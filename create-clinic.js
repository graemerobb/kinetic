(function () {
  const form = document.getElementById("clinicForm");
  const statusEl = document.getElementById("status");
  const debugEl = document.getElementById("debugOutput");
  const resetBtn = document.getElementById("resetBtn");

  // Auto-fill created_at with "now" (local time) for datetime-local
  const createdAtInput = document.getElementById("createdAt");
  if (createdAtInput && !createdAtInput.value) {
    createdAtInput.value = toDatetimeLocalValue(new Date());
  }

  // Load last saved clinic (if any)
  const existing = safeParse(localStorage.getItem("kinetic_clinic"));
  if (existing) {
    debugEl.textContent = JSON.stringify(existing, null, 2);
  }

  resetBtn.addEventListener("click", () => {
    form.reset();
    clearErrors();
    setStatus("");
    // re-set created_at after reset
    createdAtInput.value = toDatetimeLocalValue(new Date());
  });

  form.addEventListener("submit", (e) => {
    e.preventDefault();
    clearErrors();

    const clinic = getClinicFromForm();

    const errors = validateClinic(clinic);
    if (errors.length) {
      errors.forEach(({ field, message }) => showError(field, message));
      setStatus("Please fix the highlighted fields.", "bad");
      return;
    }

    // Save locally for now (placeholder for DB/API integration later)
    localStorage.setItem("kinetic_clinic", JSON.stringify(clinic));
    debugEl.textContent = JSON.stringify(clinic, null, 2);

    setStatus("Clinic saved locally ✔ (DB integration later).", "ok");
  });

  function getClinicFromForm() {
    const id = form.elements["id"].value.trim();
    const email = form.elements["email"].value.trim();
    const speciality = form.elements["speciality"].value.trim();
    const address = form.elements["address"].value.trim();

    const tokensRaw = form.elements["data_sharing_tokens"].value;
    const dataSharingRaw = form.elements["data_sharing"].value;

    const createdAtRaw = form.elements["created_at"].value; // datetime-local string

    return {
      id,
      email,
      // optional fields only included if non-empty (keeps objects tidy)
      ...(speciality ? { speciality } : {}),
      ...(address ? { address } : {}),
      ...(tokensRaw !== "" ? { data_sharing_tokens: Number(tokensRaw) } : {}),
      // required field:
      data_sharing: dataSharingRaw === "true",
      // required field:
      created_at: createdAtRaw ? new Date(createdAtRaw).toISOString() : ""
    };
  }

  function validateClinic(clinic) {
    const errs = [];

    // required: id
    if (!clinic.id) errs.push({ field: "id", message: "Clinic ID is required." });

    // required: email (and format)
    if (!clinic.email) {
      errs.push({ field: "email", message: "Email is required." });
    } else if (!isValidEmail(clinic.email)) {
      errs.push({ field: "email", message: "Please enter a valid email address." });
    }

    // required: data_sharing (must be explicitly chosen)
    // because boolean defaults can hide missing selection, we validate the select directly
    const dsSelect = form.elements["data_sharing"].value;
    if (dsSelect !== "true" && dsSelect !== "false") {
      errs.push({ field: "data_sharing", message: "Please select Yes or No." });
    }

    // required: created_at (must be set)
    if (!clinic.created_at) {
      errs.push({ field: "created_at", message: "Created at is required." });
    } else if (Number.isNaN(Date.parse(clinic.created_at))) {
      errs.push({ field: "created_at", message: "Created at must be a valid date/time." });
    }

    // optional: data_sharing_tokens integer (if present)
    if (clinic.data_sharing_tokens !== undefined) {
      if (!Number.isInteger(clinic.data_sharing_tokens)) {
        errs.push({ field: "data_sharing_tokens", message: "Tokens must be an integer." });
      } else if (clinic.data_sharing_tokens < 0) {
        errs.push({ field: "data_sharing_tokens", message: "Tokens must be 0 or greater." });
      }
    }

    return errs;
  }

  function showError(fieldName, message) {
    const el = document.querySelector(`[data-error-for="${fieldName}"]`);
    if (el) el.textContent = message;
  }

  function clearErrors() {
    document.querySelectorAll(".error").forEach((e) => (e.textContent = ""));
  }

  function setStatus(message, kind) {
    statusEl.textContent = message;
    statusEl.classList.remove("ok", "bad");
    if (kind) statusEl.classList.add(kind);
  }

  function isValidEmail(email) {
    // Simple pragmatic email check
    return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
  }

  function toDatetimeLocalValue(date) {
    const pad = (n) => String(n).padStart(2, "0");
    const yyyy = date.getFullYear();
    const mm = pad(date.getMonth() + 1);
    const dd = pad(date.getDate());
    const hh = pad(date.getHours());
    const min = pad(date.getMinutes());
    return `${yyyy}-${mm}-${dd}T${hh}:${min}`;
  }

  function safeParse(s) {
    try { return s ? JSON.parse(s) : null; } catch { return null; }
  }
})();

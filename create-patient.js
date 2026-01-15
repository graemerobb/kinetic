(function () {
  const form = document.getElementById("patientForm");
  const statusEl = document.getElementById("status");
  const debugEl = document.getElementById("debugOutput");
  const resetBtn = document.getElementById("resetBtn");
  const clinicLabel = document.getElementById("clinicLabel");

  // Read clinic_id from URL: create-patient.html?clinic_id=cln_001
  const clinicId = (new URLSearchParams(window.location.search).get("clinic_id") || "unassigned").trim();
  clinicLabel.textContent = clinicId;

  // Auto-fill created_at with "now" (local time) for datetime-local
  const createdAtInput = document.getElementById("createdAt");
  if (createdAtInput && !createdAtInput.value) {
    createdAtInput.value = toDatetimeLocalValue(new Date());
  }

  // Show last saved patient (if any)
  const last = safeParse(localStorage.getItem("kinetic_last_patient"));
  if (last) debugEl.textContent = JSON.stringify(last, null, 2);

  resetBtn.addEventListener("click", () => {
    form.reset();
    clearErrors();
    setStatus("");
    createdAtInput.value = toDatetimeLocalValue(new Date());
  });

  form.addEventListener("submit", (e) => {
    e.preventDefault();
    clearErrors();

    const patient = getPatientFromForm();

    const errors = validatePatient(patient);
    if (errors.length) {
      errors.forEach(({ field, message }) => showError(field, message));
      setStatus("Please fix the highlighted fields.", "bad");
      return;
    }

    // Save per-clinic list (placeholder until DB integration)
    const key = `kinetic_patients_${clinicId}`;
    const list = safeParse(localStorage.getItem(key)) || [];

    // Prevent accidental duplicate IDs within the same clinic
    if (list.some(p => p.id === patient.id)) {
      showError("id", "That Patient ID already exists for this clinic.");
      setStatus("Patient not saved (duplicate ID).", "bad");
      return;
    }

    list.push(patient);
    localStorage.setItem(key, JSON.stringify(list));

    // Save last patient for debugging
    localStorage.setItem("kinetic_last_patient", JSON.stringify({ clinic_id: clinicId, ...patient }));
    debugEl.textContent = JSON.stringify({ clinic_id: clinicId, ...patient }, null, 2);

    setStatus(`Patient saved locally ✔ (clinic: ${clinicId}).`, "ok");
  });

  function getPatientFromForm() {
    const id = form.elements["id"].value.trim();
    const email = form.elements["email"].value.trim();
    const address = form.elements["address"].value.trim();
    const createdAtRaw = form.elements["created_at"].value; // datetime-local string

    return {
      id,
      email,
      ...(address ? { address } : {}),
      created_at: createdAtRaw ? new Date(createdAtRaw).toISOString() : ""
    };
  }

  function validatePatient(patient) {
    const errs = [];

    if (!patient.id) errs.push({ field: "id", message: "Patient ID is required." });

    if (!patient.email) {
      errs.push({ field: "email", message: "Email is required." });
    } else if (!isValidEmail(patient.email)) {
      errs.push({ field: "email", message: "Please enter a valid email address." });
    }

    if (!patient.created_at) {
      errs.push({ field: "created_at", message: "Created at is required." });
    } else if (Number.isNaN(Date.parse(patient.created_at))) {
      errs.push({ field: "created_at", message: "Created at must be a valid date/time." });
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

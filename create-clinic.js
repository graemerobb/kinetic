(function () {
  const form = document.getElementById("clinicForm");
  const statusEl = document.getElementById("status");
  const debugEl = document.getElementById("debugOutput");
  const resetBtn = document.getElementById("resetBtn");

  const createdAtInput = document.getElementById("createdAt");
  const submitBtn = form.querySelector('button[type="submit"]');

  // Querystring: create-clinic.html?id=cln_001
  const qs = new URLSearchParams(window.location.search);
  const idFromUrl = (qs.get("id") || "").trim();

  // Default created_at to now when creating new
  if (createdAtInput && !createdAtInput.value) {
    createdAtInput.value = toDatetimeLocalValue(new Date());
  }

  // If id is provided, load clinic and populate
  if (idFromUrl) {
    loadClinic(idFromUrl);
  } else {
    setModeCreate();
  }

  resetBtn.addEventListener("click", () => {
    form.reset();
    clearErrors();
    setStatus("");
    // If we were loaded via ?id=, restore that ID; otherwise empty
    document.getElementById("clinicId").value = idFromUrl || "";
    createdAtInput.value = toDatetimeLocalValue(new Date());
    if (idFromUrl) loadClinic(idFromUrl);
  });

  form.addEventListener("submit", async (e) => {
    e.preventDefault();
    clearErrors();

    const clinic = getClinicFromForm();

    const errors = validateClinic(clinic);
    if (errors.length) {
      errors.forEach(({ field, message }) => showError(field, message));
      setStatus("Please fix the highlighted fields.", "bad");
      return;
    }

    setBusy(true);
    try {
      const resp = await fetch(`/api/create-clinic`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(clinic)
      });

      const data = await safeJson(resp);

      if (!resp.ok) {
        setStatus(`Save failed: ${data?.error || resp.statusText}`, "bad");
        // optional: show detail in debug
        debugEl.textContent = JSON.stringify(data || { status: resp.status }, null, 2);
        return;
      }

      setStatus("Clinic saved ✔", "ok");
      debugEl.textContent = JSON.stringify(data, null, 2);

      // After create, set URL param so refresh loads it
      if (!idFromUrl && clinic.id) {
        const newUrl = `${window.location.pathname}?id=${encodeURIComponent(clinic.id)}`;
        window.history.replaceState({}, "", newUrl);
      }

    } catch (err) {
      setStatus(`Save failed: ${err.message || err}`, "bad");
    } finally {
      setBusy(false);
    }
  });

  async function loadClinic(clinicId) {
    setModeLoading(clinicId);
    setBusy(true);

    try {
      const resp = await fetch(`/api/get-clinic?id=${encodeURIComponent(clinicId)}`, {
        method: "GET",
        headers: { "Accept": "application/json" }
      });

      const data = await safeJson(resp);

      if (resp.status === 404) {
        setModeCreate();
        document.getElementById("clinicId").value = clinicId; // keep what user asked for
        setStatus("Clinic not found. You can create it now.", "bad");
        debugEl.textContent = JSON.stringify(data, null, 2);
        return;
      }

      if (!resp.ok) {
        setStatus(`Load failed: ${data?.error || resp.statusText}`, "bad");
        debugEl.textContent = JSON.stringify(data || { status: resp.status }, null, 2);
        setModeCreate();
        return;
      }

      populateClinicForm(data);
      setModeEdit();
      setStatus("Clinic loaded.", "ok");
      debugEl.textContent = JSON.stringify(data, null, 2);

    } catch (err) {
      setStatus(`Load failed: ${err.message || err}`, "bad");
      setModeCreate();
    } finally {
      setBusy(false);
    }
  }

  function populateClinicForm(clinic) {
    document.getElementById("clinicId").value = clinic.id ?? "";
    document.getElementById("email").value = clinic.email ?? "";
    document.getElementById("speciality").value = clinic.speciality ?? "";
    document.getElementById("address").value = clinic.address ?? "";
    document.getElementById("dataSharingTokens").value =
      clinic.data_sharing_tokens !== null && clinic.data_sharing_tokens !== undefined
        ? String(clinic.data_sharing_tokens)
        : "";

    // boolean -> select
    document.getElementById("dataSharing").value = String(!!clinic.data_sharing);

    // ISO -> datetime-local
    if (clinic.created_at) {
      createdAtInput.value = toDatetimeLocalValue(new Date(clinic.created_at));
    }
  }

  function setModeCreate() {
    submitBtn.textContent = "Create clinic";
  }

  function setModeEdit() {
    submitBtn.textContent = "Update clinic";
  }

  function setModeLoading(clinicId) {
    submitBtn.textContent = `Loading ${clinicId}…`;
  }

  function setBusy(isBusy) {
    submitBtn.disabled = isBusy;
    resetBtn.disabled = isBusy;
  }

  function getClinicFromForm() {
    const id = form.elements["id"].value.trim();
    const email = form.elements["email"].value.trim();
    const speciality = form.elements["speciality"].value.trim();
    const address = form.elements["address"].value.trim();
    const tokensRaw = form.elements["data_sharing_tokens"].value;
    const dataSharingRaw = form.elements["data_sharing"].value;
    const createdAtRaw = form.elements["created_at"].value;

    return {
      id,
      email,
      ...(speciality ? { speciality } : {}),
      ...(address ? { address } : {}),
      ...(tokensRaw !== "" ? { data_sharing_tokens: Number(tokensRaw) } : {}),
      data_sharing: dataSharingRaw === "true",
      created_at: createdAtRaw ? new Date(createdAtRaw).toISOString() : ""
    };
  }

  function validateClinic(clinic) {
    const errs = [];

    if (!clinic.id) errs.push({ field: "id", message: "Clinic ID is required." });

    if (!clinic.email) {
      errs.push({ field: "email", message: "Email is required." });
    } else if (!isValidEmail(clinic.email)) {
      errs.push({ field: "email", message: "Please enter a valid email address." });
    }

    const dsSelect = form.elements["data_sharing"].value;
    if (dsSelect !== "true" && dsSelect !== "false") {
      errs.push({ field: "data_sharing", message: "Please select Yes or No." });
    }

    if (!clinic.created_at) {
      errs.push({ field: "created_at", message: "Created at is required." });
    } else if (Number.isNaN(Date.parse(clinic.created_at))) {
      errs.push({ field: "created_at", message: "Created at must be a valid date/time." });
    }

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

  async function safeJson(resp) {
    try {
      return await resp.json();
    } catch {
      return null;
    }
  }
})();

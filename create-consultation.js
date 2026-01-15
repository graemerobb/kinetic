(function () {
  const form = document.getElementById("consultForm");
  const statusEl = document.getElementById("status");
  const debugEl = document.getElementById("debugOutput");
  const resetBtn = document.getElementById("resetBtn");

  const clinicLabel = document.getElementById("clinicLabel");
  const patientLabel = document.getElementById("patientLabel");

  // Read from URL for bookmarkability:
  // create-consultation.html?clinic_id=cln_001&patient_id=pat_001
  const qs = new URLSearchParams(window.location.search);
  const clinicIdFromUrl = (qs.get("clinic_id") || "unassigned").trim();
  const patientIdFromUrl = (qs.get("patient_id") || "unassigned").trim();

  clinicLabel.textContent = clinicIdFromUrl;
  patientLabel.textContent = patientIdFromUrl;

  // Prefill form fields from URL
  const clinicIdInput = document.getElementById("clinicId");
  const patientIdInput = document.getElementById("patientId");
  clinicIdInput.value = clinicIdFromUrl !== "unassigned" ? clinicIdFromUrl : "";
  patientIdInput.value = patientIdFromUrl !== "unassigned" ? patientIdFromUrl : "";

  // Auto-fill consultation_date with now
  const consultDateInput = document.getElementById("consultDate");
  if (consultDateInput && !consultDateInput.value) {
    consultDateInput.value = toDatetimeLocalValue(new Date());
  }

  // Show last saved consultation (if any)
  const last = safeParse(localStorage.getItem("kinetic_last_consultation"));
  if (last) debugEl.textContent = JSON.stringify(last, null, 2);

  resetBtn.addEventListener("click", () => {
    form.reset();
    clearErrors();
    setStatus("");
    clinicIdInput.value = clinicIdFromUrl !== "unassigned" ? clinicIdFromUrl : "";
    patientIdInput.value = patientIdFromUrl !== "unassigned" ? patientIdFromUrl : "";
    consultDateInput.value = toDatetimeLocalValue(new Date());
  });

  form.addEventListener("submit", (e) => {
    e.preventDefault();
    clearErrors();

    const consultation = getConsultationFromForm();

    const errors = validateConsultation(consultation);
    if (errors.length) {
      errors.forEach(({ field, message }) => showError(field, message));
      setStatus("Please fix the highlighted fields.", "bad");
      return;
    }

    // Save per-clinic list (placeholder until DB integration)
    const key = `kinetic_consultations_${consultation.clinic_id}`;
    const list = safeParse(localStorage.getItem(key)) || [];

    // Prevent accidental duplicate IDs within the same clinic
    if (list.some(c => c.id === consultation.id)) {
      showError("id", "That Consultation ID already exists for this clinic.");
      setStatus("Consultation not saved (duplicate ID).", "bad");
      return;
    }

    list.push(consultation);
    localStorage.setItem(key, JSON.stringify(list));

    localStorage.setItem("kinetic_last_consultation", JSON.stringify(consultation));
    debugEl.textContent = JSON.stringify(consultation, null, 2);

    setStatus(`Consultation saved locally ✔ (clinic: ${consultation.clinic_id}).`, "ok");
  });

  function getConsultationFromForm() {
    const id = form.elements["id"].value.trim();
    const clinic_id = form.elements["clinic_id"].value.trim();
    const patient_id = form.elements["patient_id"].value.trim();
    const clinician_name = form.elements["clinician_name"].value.trim();
    const notes = form.elements["notes"].value.trim();

    const consultDateRaw = form.elements["consultation_date"].value; // datetime-local string

    return {
      id,
      clinic_id,
      patient_id,
      consultation_date: consultDateRaw ? new Date(consultDateRaw).toISOString() : "",
      clinician_name,
      notes
    };
  }

  function validateConsultation(c) {
    const errs = [];

    if (!c.id) errs.push({ field: "id", message: "Consultation ID is required." });

    if (!c.clinic_id) errs.push({ field: "clinic_id", message: "Clinic ID is required." });

    if (!c.patient_id) errs.push({ field: "patient_id", message: "Patient ID is required." });

    if (!c.clinician_name) errs.push({ field: "clinician_name", message: "Clinician name is required." });

    if (!c.notes) errs.push({ field: "notes", message: "Notes are required." });

    if (!c.consultation_date) {
      errs.push({ field: "consultation_date", message: "Consultation date is required." });
    } else if (Number.isNaN(Date.parse(c.consultation_date))) {
      errs.push({ field: "consultation_date", message: "Consultation date must be a valid date/time." });
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

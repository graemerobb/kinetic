CREATE TABLE dbo.Clinics (
  id                 NVARCHAR(64)  NOT NULL PRIMARY KEY,
  email              NVARCHAR(256) NOT NULL,
  speciality         NVARCHAR(256) NULL,
  address            NVARCHAR(512) NULL,
  data_sharing_tokens INT          NULL,
  data_sharing       BIT           NOT NULL,
  created_at         DATETIME2     NOT NULL
);

CREATE TABLE dbo.Patients (
  id         NVARCHAR(64)  NOT NULL PRIMARY KEY,
  clinic_id  NVARCHAR(64)  NOT NULL,
  email      NVARCHAR(256) NOT NULL,
  address    NVARCHAR(512) NULL,
  created_at DATETIME2     NOT NULL,
  CONSTRAINT FK_Patients_Clinics FOREIGN KEY (clinic_id) REFERENCES dbo.Clinics(id)
);

CREATE TABLE dbo.Consultations (
  id                NVARCHAR(64) NOT NULL PRIMARY KEY,
  clinic_id          NVARCHAR(64) NOT NULL,
  patient_id         NVARCHAR(64) NOT NULL,
  consultation_date  DATETIME2    NOT NULL,
  clinician_name     NVARCHAR(256) NOT NULL,
  notes              NVARCHAR(MAX) NOT NULL,
  CONSTRAINT FK_Consultations_Clinics FOREIGN KEY (clinic_id) REFERENCES dbo.Clinics(id),
  CONSTRAINT FK_Consultations_Patients FOREIGN KEY (patient_id) REFERENCES dbo.Patients(id)
);

-- Helpful indexes
CREATE INDEX IX_Patients_ClinicId ON dbo.Patients(clinic_id);
CREATE INDEX IX_Consultations_ClinicId ON dbo.Consultations(clinic_id);
CREATE INDEX IX_Consultations_PatientId ON dbo.Consultations(patient_id);

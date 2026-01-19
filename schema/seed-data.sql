/* === Seed data for dbo.Clinics / dbo.Patients / dbo.Consultations ===
   5 clinics, 10 patients each, 2 consultations per patient (100 consultations)
   Referential integrity: Patients.clinic_id -> Clinics.id; Consultations -> Clinics/Patients
*/

SET NOCOUNT ON;

----------------------------------------
-- Clinics (5)
----------------------------------------
INSERT INTO dbo.Clinics (id, email, speciality, address, data_sharing_tokens, data_sharing, created_at)
VALUES
('cln_001', 'admin@harbourhealth.com.au',      'General Practice',      'Level 3, 85 George St, Sydney NSW 2000',          120, 1, '2025-10-02T09:12:00'),
('cln_002', 'reception@riverstoneclinic.com.au','Dermatology',          '12 Station Rd, Footscray VIC 3011',               75,  1, '2025-10-10T10:05:00'),
('cln_003', 'info@eucalyptfamilyclinic.com.au','Paediatrics',           '220 Lygon St, Carlton VIC 3053',                  NULL,0,'2025-10-21T08:40:00'),
('cln_004', 'hello@suncoastmedical.com.au',    'Sports Medicine',       '5/18 Ocean Ave, Sunshine Beach QLD 4567',         40,  1, '2025-11-03T11:25:00'),
('cln_005', 'contact@alpinespecialists.com.au','Cardiology',            'Suite 7, 44 High St, Kew VIC 3101',               15,  0, '2025-11-18T14:10:00');

----------------------------------------
-- Patients (50)
----------------------------------------
INSERT INTO dbo.Patients (id, clinic_id, email, address, created_at)
VALUES
-- Clinic 1 (Sydney)
('pat_001_01','cln_001','amelia.nguyen@gmail.com','14/32 Harris St, Pyrmont NSW 2009','2025-11-01T09:05:00'),
('pat_001_02','cln_001','oliver.thompson@gmail.com','7 Wattle St, Surry Hills NSW 2010','2025-11-02T10:14:00'),
('pat_001_03','cln_001','sophia.wilson@gmail.com','19 Union St, Newtown NSW 2042','2025-11-03T08:22:00'),
('pat_001_04','cln_001','jackson.lee@gmail.com','3/11 Darling St, Balmain NSW 2041','2025-11-04T12:40:00'),
('pat_001_05','cln_001','mia.patel@gmail.com','88 Anzac Pde, Kensington NSW 2033','2025-11-05T15:05:00'),
('pat_001_06','cln_001','ethan.brown@gmail.com','4/2 Princes Hwy, St Peters NSW 2044','2025-11-06T09:30:00'),
('pat_001_07','cln_001','isabella.johnson@gmail.com','21 Campbell St, Bondi Junction NSW 2022','2025-11-07T11:10:00'),
('pat_001_08','cln_001','noah.clark@gmail.com','6/55 Crown St, Woolloomooloo NSW 2011','2025-11-08T13:55:00'),
('pat_001_09','cln_001','charlotte.evans@gmail.com','102/9 Railway Pde, Chatswood NSW 2067','2025-11-09T16:20:00'),
('pat_001_10','cln_001','liam.walker@gmail.com','10 Vista St, Mosman NSW 2088','2025-11-10T08:45:00'),

-- Clinic 2 (Footscray VIC)
('pat_002_01','cln_002','ava.roberts@gmail.com','1/62 Barkly St, Footscray VIC 3011','2025-11-01T09:20:00'),
('pat_002_02','cln_002','william.martin@gmail.com','13 Albert St, Yarraville VIC 3013','2025-11-02T10:35:00'),
('pat_002_03','cln_002','grace.hughes@gmail.com','9/28 Droop St, Footscray VIC 3011','2025-11-03T08:50:00'),
('pat_002_04','cln_002','henry.green@gmail.com','44 Somerville Rd, Kingsville VIC 3012','2025-11-04T12:10:00'),
('pat_002_05','cln_002','ella.turner@gmail.com','6/19 Leeds St, Footscray VIC 3011','2025-11-05T15:30:00'),
('pat_002_06','cln_002','james.baker@gmail.com','22 Francis St, Yarraville VIC 3013','2025-11-06T09:55:00'),
('pat_002_07','cln_002','chloe.carter@gmail.com','8/75 Geelong Rd, Footscray VIC 3011','2025-11-07T11:45:00'),
('pat_002_08','cln_002','benjamin.hill@gmail.com','17 Williamstown Rd, Seddon VIC 3011','2025-11-08T14:05:00'),
('pat_002_09','cln_002','lily.scott@gmail.com','3/10 Pilgrim St, Seddon VIC 3011','2025-11-09T16:35:00'),
('pat_002_10','cln_002','samuel.wright@gmail.com','50 Buckley St, Footscray VIC 3011','2025-11-10T09:05:00'),

-- Clinic 3 (Carlton VIC)
('pat_003_01','cln_003','zoe.morris@gmail.com','112 Rathdowne St, Carlton VIC 3053','2025-11-01T09:10:00'),
('pat_003_02','cln_003','lucas.king@gmail.com','7/80 Drummond St, Carlton VIC 3053','2025-11-02T10:20:00'),
('pat_003_03','cln_003','hannah.edwards@gmail.com','18/200 Elgin St, Carlton VIC 3053','2025-11-03T08:35:00'),
('pat_003_04','cln_003','oscar.collins@gmail.com','25 Canning St, Carlton VIC 3053','2025-11-04T12:25:00'),
('pat_003_05','cln_003','ruby.stewart@gmail.com','5/33 Lygon St, Carlton VIC 3053','2025-11-05T15:15:00'),
('pat_003_06','cln_003','theo.campbell@gmail.com','9 University St, Carlton VIC 3053','2025-11-06T09:35:00'),
('pat_003_07','cln_003','ivy.mitchell@gmail.com','2/41 Queensberry St, Carlton VIC 3053','2025-11-07T11:25:00'),
('pat_003_08','cln_003','maxwell.parker@gmail.com','60 Nicholson St, Carlton VIC 3053','2025-11-08T13:35:00'),
('pat_003_09','cln_003','scarlett.phillips@gmail.com','14/77 Swanston St, Carlton VIC 3053','2025-11-09T16:05:00'),
('pat_003_10','cln_003','leo.bailey@gmail.com','31/102 Grattan St, Carlton VIC 3053','2025-11-10T08:55:00'),

-- Clinic 4 (Sunshine Beach QLD)
('pat_004_01','cln_004','poppy.cooper@gmail.com','1/9 Duke St, Sunshine Beach QLD 4567','2025-11-01T09:30:00'),
('pat_004_02','cln_004','archer.ward@gmail.com','14 Elanda St, Sunshine Beach QLD 4567','2025-11-02T10:55:00'),
('pat_004_03','cln_004','matilda.howard@gmail.com','3/22 Seaview Tce, Sunshine Beach QLD 4567','2025-11-03T08:15:00'),
('pat_004_04','cln_004','hudson.brooks@gmail.com','8 Sobraon St, Sunshine Beach QLD 4567','2025-11-04T12:45:00'),
('pat_004_05','cln_004','willow.gray@gmail.com','5/18 Pacific Ave, Sunshine Beach QLD 4567','2025-11-05T15:40:00'),
('pat_004_06','cln_004','mason.reid@gmail.com','11 Ben Lexcen Dr, Sunshine Beach QLD 4567','2025-11-06T09:10:00'),
('pat_004_07','cln_004','evie.wood@gmail.com','2/6 Solway Dr, Sunshine Beach QLD 4567','2025-11-07T11:05:00'),
('pat_004_08','cln_004','finn.kelly@gmail.com','20 Cannon St, Sunshine Beach QLD 4567','2025-11-08T14:25:00'),
('pat_004_09','cln_004','elsie.hall@gmail.com','7/30 Arakoon Cres, Sunshine Beach QLD 4567','2025-11-09T16:50:00'),
('pat_004_10','cln_004','charlie.cook@gmail.com','16 Parkedge Rd, Sunshine Beach QLD 4567','2025-11-10T09:25:00'),

-- Clinic 5 (Kew VIC)
('pat_005_01','cln_005','harper.bell@gmail.com','10/55 Cotham Rd, Kew VIC 3101','2025-11-01T09:40:00'),
('pat_005_02','cln_005','sebastian.murphy@gmail.com','21 Studley Park Rd, Kew VIC 3101','2025-11-02T10:05:00'),
('pat_005_03','cln_005','aria.morgan@gmail.com','3/9 Princess St, Kew VIC 3101','2025-11-03T08:25:00'),
('pat_005_04','cln_005','levi.pierce@gmail.com','88 High St, Kew VIC 3101','2025-11-04T12:05:00'),
('pat_005_05','cln_005','freya.richardson@gmail.com','6/14 Walpole St, Kew VIC 3101','2025-11-05T15:55:00'),
('pat_005_06','cln_005','ashton.henderson@gmail.com','4/76 Barkers Rd, Kew VIC 3101','2025-11-06T09:45:00'),
('pat_005_07','cln_005','violet.fox@gmail.com','19/33 Earl St, Kew VIC 3101','2025-11-07T11:35:00'),
('pat_005_08','cln_005','cooper.jameson@gmail.com','12 Willsmere Rd, Kew VIC 3101','2025-11-08T13:20:00'),
('pat_005_09','cln_005','daisy.simons@gmail.com','2/40 Belford Rd, Kew VIC 3101','2025-11-09T16:15:00'),
('pat_005_10','cln_005','jude.anderson@gmail.com','7/102 Normanby Rd, Kew VIC 3101','2025-11-10T09:15:00');

----------------------------------------
-- Consultations (100 = 2 per patient)
----------------------------------------
INSERT INTO dbo.Consultations (id, clinic_id, patient_id, consultation_date, clinician_name, notes)
VALUES
-- Clinic 1
('con_001_01_a','cln_001','pat_001_01','2025-11-12T09:10:00','Dr Priya Menon','Annual check-up. Discussed sleep, stress, and exercise routine. BP within normal range.'),
('con_001_01_b','cln_001','pat_001_01','2025-12-03T14:20:00','Dr Priya Menon','Follow-up for mild asthma symptoms. Provided action plan and reviewed inhaler technique.'),

('con_001_02_a','cln_001','pat_001_02','2025-11-13T10:30:00','Dr Daniel Harper','URI symptoms x4 days. Advised fluids, rest, and return precautions.'),
('con_001_02_b','cln_001','pat_001_02','2025-12-05T09:00:00','Dr Daniel Harper','Persistent cough improving. Chest clear. Recommended continued supportive care.'),

('con_001_03_a','cln_001','pat_001_03','2025-11-14T08:45:00','Dr Aisha Khan','Skin rash after new detergent. Advised trigger avoidance and topical hydrocortisone.'),
('con_001_03_b','cln_001','pat_001_03','2025-12-09T16:10:00','Dr Aisha Khan','Rash resolved. Reviewed allergy history and provided prevention advice.'),

('con_001_04_a','cln_001','pat_001_04','2025-11-15T11:15:00','Dr Priya Menon','Back pain after lifting. Exam suggests muscular strain. Advised gentle mobility and NSAIDs if tolerated.'),
('con_001_04_b','cln_001','pat_001_04','2025-12-11T13:40:00','Dr Priya Menon','Back pain much improved. Provided home exercise plan and posture guidance.'),

('con_001_05_a','cln_001','pat_001_05','2025-11-18T15:00:00','Dr Daniel Harper','Discussed migraine triggers and management. Started trial of prophylactic measures.'),
('con_001_05_b','cln_001','pat_001_05','2025-12-17T10:20:00','Dr Daniel Harper','Migraine frequency reduced. Reviewed hydration, sleep, and stress plan.'),

('con_001_06_a','cln_001','pat_001_06','2025-11-19T09:40:00','Dr Aisha Khan','Elevated cholesterol on screening. Discussed diet changes and repeat labs in 3 months.'),
('con_001_06_b','cln_001','pat_001_06','2025-12-18T12:10:00','Dr Aisha Khan','Dietary changes underway. Provided referral to dietitian; discussed family history.'),

('con_001_07_a','cln_001','pat_001_07','2025-11-20T10:50:00','Dr Priya Menon','Seasonal allergies. Recommended antihistamine and nasal spray; reviewed technique.'),
('con_001_07_b','cln_001','pat_001_07','2025-12-20T09:30:00','Dr Priya Menon','Symptoms controlled. Advised taper plan and monitoring.'),

('con_001_08_a','cln_001','pat_001_08','2025-11-21T13:10:00','Dr Daniel Harper','GI upset after travel. Hydration advice; stool tests if persists >48h.'),
('con_001_08_b','cln_001','pat_001_08','2025-12-23T14:45:00','Dr Daniel Harper','Symptoms resolved. Discussed food safety while travelling.'),

('con_001_09_a','cln_001','pat_001_09','2025-11-22T16:30:00','Dr Aisha Khan','Thyroid check due to fatigue. Ordered labs; discussed sleep hygiene.'),
('con_001_09_b','cln_001','pat_001_09','2025-12-27T11:00:00','Dr Aisha Khan','Labs normal. Discussed workload management and iron-rich diet.'),

('con_001_10_a','cln_001','pat_001_10','2025-11-25T09:05:00','Dr Priya Menon','Knee pain after running. Suspected patellofemoral pain; advised strengthening exercises.'),
('con_001_10_b','cln_001','pat_001_10','2026-01-08T08:40:00','Dr Priya Menon','Knee improving. Provided progression plan and referral to physio if flare-up.'),

-- Clinic 2 (Derm)
('con_002_01_a','cln_002','pat_002_01','2025-11-12T10:05:00','Dr Mei Lin','Acne flare. Discussed skincare routine; started topical retinoid.'),
('con_002_01_b','cln_002','pat_002_01','2025-12-10T10:05:00','Dr Mei Lin','Acne improved. Reviewed adherence and side effects; continue regimen.'),

('con_002_02_a','cln_002','pat_002_02','2025-11-13T09:20:00','Dr Thomas Nguyen','Eczema on hands. Trigger review; prescribed emollient and mild steroid.'),
('con_002_02_b','cln_002','pat_002_02','2025-12-12T09:25:00','Dr Thomas Nguyen','Eczema controlled. Discussed barrier protection and flare plan.'),

('con_002_03_a','cln_002','pat_002_03','2025-11-14T12:15:00','Dr Mei Lin','Mole check. No concerning features; advised routine monitoring.'),
('con_002_03_b','cln_002','pat_002_03','2026-01-06T11:10:00','Dr Mei Lin','Follow-up skin check. No changes noted; documented photos for baseline.'),

('con_002_04_a','cln_002','pat_002_04','2025-11-15T14:00:00','Dr Thomas Nguyen','Psoriasis plaques. Discussed topical therapy; started vitamin D analogue.'),
('con_002_04_b','cln_002','pat_002_04','2025-12-16T14:05:00','Dr Thomas Nguyen','Improved scaling and itch. Continue treatment; reviewed moisturising.'),

('con_002_05_a','cln_002','pat_002_05','2025-11-18T09:10:00','Dr Mei Lin','Rosacea symptoms. Reviewed triggers; started topical metronidazole.'),
('con_002_05_b','cln_002','pat_002_05','2025-12-19T09:10:00','Dr Mei Lin','Reduced redness. Continue; discussed sun protection and gentle cleanser.'),

('con_002_06_a','cln_002','pat_002_06','2025-11-19T11:40:00','Dr Thomas Nguyen','Wart treatment. Cryotherapy performed; aftercare explained.'),
('con_002_06_b','cln_002','pat_002_06','2025-12-23T11:35:00','Dr Thomas Nguyen','Wart reduced. Second cryotherapy session; reviewed aftercare.'),

('con_002_07_a','cln_002','pat_002_07','2025-11-20T15:20:00','Dr Mei Lin','Contact dermatitis from new product. Advised cessation and topical steroid.'),
('con_002_07_b','cln_002','pat_002_07','2025-12-30T15:15:00','Dr Mei Lin','Resolved. Provided patch-testing referral if recurrence.'),

('con_002_08_a','cln_002','pat_002_08','2025-11-21T10:30:00','Dr Thomas Nguyen','Hair thinning. Discussed patterns; ordered iron/thyroid labs; advised minoxidil trial.'),
('con_002_08_b','cln_002','pat_002_08','2026-01-09T10:20:00','Dr Thomas Nguyen','Reviewed labs; discussed ongoing management and expectations.'),

('con_002_09_a','cln_002','pat_002_09','2025-11-22T13:50:00','Dr Mei Lin','Sun damage concerns. Education on SPF; discussed treatment options.'),
('con_002_09_b','cln_002','pat_002_09','2026-01-10T13:45:00','Dr Mei Lin','Follow-up. Started topical regimen; reviewed tolerance.'),

('con_002_10_a','cln_002','pat_002_10','2025-11-25T16:05:00','Dr Thomas Nguyen','Skin tag removal request. Discussed benign nature; performed simple removal.'),
('con_002_10_b','cln_002','pat_002_10','2026-01-13T16:00:00','Dr Thomas Nguyen','Site healed well. Reviewed scar care and sun protection.'),

-- Clinic 3 (Paeds)
('con_003_01_a','cln_003','pat_003_01','2025-11-12T09:00:00','Dr Sarah O''Connell','Vaccination catch-up. Reviewed schedule; administered influenza vaccine.'),
('con_003_01_b','cln_003','pat_003_01','2026-01-07T09:10:00','Dr Sarah O''Connell','Follow-up growth check. Normal development; discussed nutrition and sleep.'),

('con_003_02_a','cln_003','pat_003_02','2025-11-13T10:10:00','Dr Anil Desai','Recurrent ear pain. Exam suggests otitis media; discussed options and safety net advice.'),
('con_003_02_b','cln_003','pat_003_02','2025-12-11T10:05:00','Dr Anil Desai','Symptoms resolved. Reviewed prevention and when to return.'),

('con_003_03_a','cln_003','pat_003_03','2025-11-14T08:55:00','Dr Sarah O''Connell','School readiness consult. Discussed attention, routines, and screen time plan.'),
('con_003_03_b','cln_003','pat_003_03','2026-01-08T08:45:00','Dr Sarah O''Connell','Follow-up. Improved routines; provided resources for ongoing support.'),

('con_003_04_a','cln_003','pat_003_04','2025-11-15T12:35:00','Dr Anil Desai','Asthma review. Updated action plan; reviewed spacer use.'),
('con_003_04_b','cln_003','pat_003_04','2026-01-09T12:30:00','Dr Anil Desai','Stable control. Discussed step-down options and seasonal triggers.'),

('con_003_05_a','cln_003','pat_003_05','2025-11-18T15:05:00','Dr Sarah O''Connell','Dietary concerns (picky eating). Discussed gradual exposure and meal routines.'),
('con_003_05_b','cln_003','pat_003_05','2026-01-10T15:00:00','Dr Sarah O''Connell','Follow-up. Some improvement; provided referral to dietitian if needed.'),

('con_003_06_a','cln_003','pat_003_06','2025-11-19T09:25:00','Dr Anil Desai','Sports clearance. No red flags; provided safe training advice.'),
('con_003_06_b','cln_003','pat_003_06','2026-01-13T09:15:00','Dr Anil Desai','Follow-up after minor strain. Advised rest and gradual return.'),

('con_003_07_a','cln_003','pat_003_07','2025-11-20T11:40:00','Dr Sarah O''Connell','Sleep difficulties. Discussed bedtime routine and anxiety coping strategies.'),
('con_003_07_b','cln_003','pat_003_07','2026-01-14T11:35:00','Dr Sarah O''Connell','Improved sleep. Reinforced routine; discussed school term transition.'),

('con_003_08_a','cln_003','pat_003_08','2025-11-21T13:25:00','Dr Anil Desai','Gastro symptoms. Hydration advice; reviewed red flags and monitoring.'),
('con_003_08_b','cln_003','pat_003_08','2026-01-15T13:20:00','Dr Anil Desai','Resolved. Provided guidance on preventing dehydration during illness.'),

('con_003_09_a','cln_003','pat_003_09','2025-11-22T16:00:00','Dr Sarah O''Connell','Allergy concerns. Reviewed symptoms; suggested trial of non-sedating antihistamine.'),
('con_003_09_b','cln_003','pat_003_09','2026-01-16T16:00:00','Dr Sarah O''Connell','Follow-up. Symptoms controlled; discussed pollen season strategies.'),

('con_003_10_a','cln_003','pat_003_10','2025-11-25T09:15:00','Dr Anil Desai','Wheeze with colds. Reviewed inhaler plan; advised GP follow-up if frequent.'),
('con_003_10_b','cln_003','pat_003_10','2026-01-17T09:05:00','Dr Anil Desai','Follow-up. Fewer symptoms; reinforced action plan.'),

-- Clinic 4 (Sports)
('con_004_01_a','cln_004','pat_004_01','2025-11-12T09:50:00','Dr Michael Tran','Ankle sprain after trail run. RICE protocol and mobility plan discussed.'),
('con_004_01_b','cln_004','pat_004_01','2025-12-10T09:45:00','Dr Michael Tran','Improving stability. Added strengthening and return-to-run progression.'),

('con_004_02_a','cln_004','pat_004_02','2025-11-13T11:10:00','Dr Jenna Walsh','Shoulder pain with swimming. Suspected impingement; advised physio exercises.'),
('con_004_02_b','cln_004','pat_004_02','2026-01-06T11:05:00','Dr Jenna Walsh','Range improved. Reviewed technique and warm-up routine.'),

('con_004_03_a','cln_004','pat_004_03','2025-11-14T08:40:00','Dr Michael Tran','Runner''s knee. Strength plan for glutes/quads; discussed load management.'),
('con_004_03_b','cln_004','pat_004_03','2026-01-07T08:35:00','Dr Michael Tran','Pain reduced. Progressed training and added cadence cues.'),

('con_004_04_a','cln_004','pat_004_04','2025-11-15T12:55:00','Dr Jenna Walsh','Lower back tightness. Exam suggests strain; advised mobility and core program.'),
('con_004_04_b','cln_004','pat_004_04','2026-01-08T12:50:00','Dr Jenna Walsh','Much improved. Provided maintenance plan and ergonomics tips.'),

('con_004_05_a','cln_004','pat_004_05','2025-11-18T15:20:00','Dr Michael Tran','Tennis elbow symptoms. Discussed brace, activity modification, and exercises.'),
('con_004_05_b','cln_004','pat_004_05','2026-01-09T15:10:00','Dr Michael Tran','Symptoms improving. Increased eccentric loading and reviewed technique.'),

('con_004_06_a','cln_004','pat_004_06','2025-11-19T09:35:00','Dr Jenna Walsh','Hamstring tightness. Advised graded stretching and strengthening.'),
('con_004_06_b','cln_004','pat_004_06','2026-01-10T09:25:00','Dr Jenna Walsh','No pain on sprint. Progressed drills and warm-up routine.'),

('con_004_07_a','cln_004','pat_004_07','2025-11-20T11:30:00','Dr Michael Tran','Foot pain, possible plantar fasciitis. Discussed calf loading and footwear.'),
('con_004_07_b','cln_004','pat_004_07','2026-01-13T11:20:00','Dr Michael Tran','Improved morning pain. Continue program; consider orthotics if plateau.'),

('con_004_08_a','cln_004','pat_004_08','2025-11-21T14:10:00','Dr Jenna Walsh','Cycling-related neck pain. Reviewed bike fit and posture; exercises provided.'),
('con_004_08_b','cln_004','pat_004_08','2026-01-14T14:05:00','Dr Jenna Walsh','Better tolerance on rides. Adjusted exercise plan and stretching.'),

('con_004_09_a','cln_004','pat_004_09','2025-11-22T16:35:00','Dr Michael Tran','Calf strain. Advised rest and gradual loading; discussed warning signs.'),
('con_004_09_b','cln_004','pat_004_09','2026-01-15T16:30:00','Dr Michael Tran','Strength returning. Introduced plyometrics and return-to-sport timeline.'),

('con_004_10_a','cln_004','pat_004_10','2025-11-25T09:45:00','Dr Jenna Walsh','Sports physical. Cleared for season; reviewed injury prevention.'),
('con_004_10_b','cln_004','pat_004_10','2026-01-16T09:40:00','Dr Jenna Walsh','Minor knee soreness check. Advised deload week and mobility work.'),

-- Clinic 5 (Cardiology)
('con_005_01_a','cln_005','pat_005_01','2025-11-12T10:25:00','Dr Elena Rossi','Palpitations review. ECG planned; discussed caffeine and stress triggers.'),
('con_005_01_b','cln_005','pat_005_01','2025-12-17T10:20:00','Dr Elena Rossi','ECG normal. Reassured; recommended monitoring and lifestyle modifications.'),

('con_005_02_a','cln_005','pat_005_02','2025-11-13T09:40:00','Dr Marcus Shaw','Hypertension consult. Reviewed home BP readings; medication options discussed.'),
('con_005_02_b','cln_005','pat_005_02','2025-12-19T09:35:00','Dr Marcus Shaw','BP improving. Continue plan; reviewed salt intake and exercise.'),

('con_005_03_a','cln_005','pat_005_03','2025-11-14T08:30:00','Dr Elena Rossi','Chest discomfort on exertion. Ordered stress test; discussed return precautions.'),
('con_005_03_b','cln_005','pat_005_03','2025-12-22T08:25:00','Dr Elena Rossi','Stress test reassuring. Discussed graded exercise and symptom tracking.'),

('con_005_04_a','cln_005','pat_005_04','2025-11-15T12:20:00','Dr Marcus Shaw','Lipid management. Reviewed labs and diet; discussed statin therapy options.'),
('con_005_04_b','cln_005','pat_005_04','2025-12-23T12:15:00','Dr Marcus Shaw','Started medication. Reviewed side effects and follow-up labs plan.'),

('con_005_05_a','cln_005','pat_005_05','2025-11-18T15:35:00','Dr Elena Rossi','Shortness of breath. Exam stable; ordered echo; reviewed activity tolerance.'),
('con_005_05_b','cln_005','pat_005_05','2026-01-06T15:30:00','Dr Elena Rossi','Echo normal. Discussed breathing techniques and fitness progression.'),

('con_005_06_a','cln_005','pat_005_06','2025-11-19T09:55:00','Dr Marcus Shaw','Family history consult. Discussed screening plan and lifestyle changes.'),
('con_005_06_b','cln_005','pat_005_06','2026-01-07T09:50:00','Dr Marcus Shaw','Follow-up. Implemented exercise plan; scheduled repeat labs.'),

('con_005_07_a','cln_005','pat_005_07','2025-11-20T11:55:00','Dr Elena Rossi','Medication review. Discussed adherence and BP monitoring.'),
('con_005_07_b','cln_005','pat_005_07','2026-01-08T11:50:00','Dr Elena Rossi','Stable readings. Continue current regimen; reviewed follow-up cadence.'),

('con_005_08_a','cln_005','pat_005_08','2025-11-21T13:05:00','Dr Marcus Shaw','Intermittent dizziness. Reviewed hydration and orthostatic vitals; labs ordered.'),
('con_005_08_b','cln_005','pat_005_08','2026-01-09T13:00:00','Dr Marcus Shaw','Labs normal. Advised gradual position changes and hydration plan.'),

('con_005_09_a','cln_005','pat_005_09','2025-11-22T16:10:00','Dr Elena Rossi','Post-viral fatigue. Reviewed activity pacing and sleep; rule-out tests planned.'),
('con_005_09_b','cln_005','pat_005_09','2026-01-10T16:05:00','Dr Elena Rossi','Symptoms improving. Discussed return-to-exercise strategy.'),

('con_005_10_a','cln_005','pat_005_10','2025-11-25T09:35:00','Dr Marcus Shaw','Preventive cardiology consult. Discussed diet, steps/day, and BP targets.'),
('con_005_10_b','cln_005','pat_005_10','2026-01-13T09:30:00','Dr Marcus Shaw','Follow-up. Progress on activity goals; reviewed next lab timeline.');


/* === Update dbo.Consultations.notes ===
   - Multi-line notes (CRLF via CHAR(13)+CHAR(10))
   - Includes fictional sensitive details: places, events, family member names
   - Updates by consultation id
*/

SET NOCOUNT ON;

UPDATE dbo.Consultations
SET notes =
  CASE id
    -- Clinic 1
    WHEN 'con_001_01_a' THEN
      N'Annual check-up (routine).'+CHAR(13)+CHAR(10)+
      N'Patient attended after morning walk at Pyrmont Bay Park.'+CHAR(13)+CHAR(10)+
      N'Mentions partner "Tom Nguyen" noticed louder snoring over the past month.'+CHAR(13)+CHAR(10)+
      N'Planning travel for a work conference at ICC Sydney next week.'
    WHEN 'con_001_01_b' THEN
      N'Asthma follow-up.'+CHAR(13)+CHAR(10)+
      N'Wheeze worse after attending the Newtown Street Festival (outdoor smoke exposure).'+CHAR(13)+CHAR(10)+
      N'Child "Ellie" (age 7) reminded patient to pack inhaler for school pickup.'+CHAR(13)+CHAR(10)+
      N'Discussed action plan and spacer technique; advised avoid triggers at Enmore Park.'

    WHEN 'con_001_02_a' THEN
      N'URI symptoms x4 days.'+CHAR(13)+CHAR(10)+
      N'Onset after crowded train commute from Chatswood to Wynyard.'+CHAR(13)+CHAR(10)+
      N'Lives with housemate "Grace Miller" who also developed sore throat.'+CHAR(13)+CHAR(10)+
      N'Notes attending a birthday dinner at Mr Wong (CBD) two nights prior.'
    WHEN 'con_001_02_b' THEN
      N'Follow-up for persistent cough.'+CHAR(13)+CHAR(10)+
      N'Cough improving; no fever.'+CHAR(13)+CHAR(10)+
      N'Patient anxious due to upcoming presentation at Barangaroo office.'+CHAR(13)+CHAR(10)+
      N'Partner "Sophie" requested reassurance about contagion before weekend trip to Manly.'

    WHEN 'con_001_03_a' THEN
      N'Skin rash likely irritant/contact dermatitis.'+CHAR(13)+CHAR(10)+
      N'New detergent purchased from Woolworths Metro (King St, Newtown).'+CHAR(13)+CHAR(10)+
      N'Mentions mother "Lan Wilson" has history of eczema.'+CHAR(13)+CHAR(10)+
      N'Patient concerned about rash visible for wedding at St Mary''s Cathedral this Saturday.'
    WHEN 'con_001_03_b' THEN
      N'Rash resolved.'+CHAR(13)+CHAR(10)+
      N'Reviewed avoidance plan and patch-test options.'+CHAR(13)+CHAR(10)+
      N'Patient attended wedding reception at Circular Quay; no recurrence despite warm weather.'+CHAR(13)+CHAR(10)+
      N'Family member "Aunt Priya" suggested switching to fragrance-free products.'

    WHEN 'con_001_04_a' THEN
      N'Acute back strain after lifting moving boxes in Balmain.'+CHAR(13)+CHAR(10)+
      N'Patient reports helping brother "Jake Lee" move apartments on Darling St.'+CHAR(13)+CHAR(10)+
      N'Pain worse after driving to IKEA Tempe; improved with heat pack.'+CHAR(13)+CHAR(10)+
      N'Provided return-to-activity plan and red-flag advice.'
    WHEN 'con_001_04_b' THEN
      N'Back pain follow-up.'+CHAR(13)+CHAR(10)+
      N'Patient resumed Pilates at KX Studio Surry Hills; tolerated well.'+CHAR(13)+CHAR(10)+
      N'Mentions toddler "Mason" now sleeps through night, improving recovery.'+CHAR(13)+CHAR(10)+
      N'Reinforced core strengthening and safe lifting at home.'

    WHEN 'con_001_05_a' THEN
      N'Migraine management discussion.'+CHAR(13)+CHAR(10)+
      N'Triggers include late nights during Diwali celebrations in Harris Park.'+CHAR(13)+CHAR(10)+
      N'Patient''s sister "Riya Patel" encouraged hydration and regular meals.'+CHAR(13)+CHAR(10)+
      N'Work stress related to deadline at UNSW Kensington campus.'
    WHEN 'con_001_05_b' THEN
      N'Migraine follow-up.'+CHAR(13)+CHAR(10)+
      N'Frequency reduced; patient tracking in phone app.'+CHAR(13)+CHAR(10)+
      N'Upcoming family trip to Blue Mountains (Leura) — discussed plan for travel triggers.'+CHAR(13)+CHAR(10)+
      N'Partner "Amit" will share driving to reduce fatigue.'

    WHEN 'con_001_06_a' THEN
      N'Cholesterol review after screening.'+CHAR(13)+CHAR(10)+
      N'Patient eats frequently at food courts near St Peters station.'+CHAR(13)+CHAR(10)+
      N'Father "Graham Brown" had MI at age 58 (family history discussed).'+CHAR(13)+CHAR(10)+
      N'Provided diet/exercise counselling and repeat labs plan.'
    WHEN 'con_001_06_b' THEN
      N'Lifestyle follow-up for cholesterol.'+CHAR(13)+CHAR(10)+
      N'Patient switched to home-cooked meals; shops at Marrickville Markets.'+CHAR(13)+CHAR(10)+
      N'Mentions coworker "Ben" organising City2Surf training group.'+CHAR(13)+CHAR(10)+
      N'Discussed referral to dietitian and goal setting.'

    WHEN 'con_001_07_a' THEN
      N'Seasonal allergic rhinitis.'+CHAR(13)+CHAR(10)+
      N'Flare after gardening at Bondi Junction courtyard; high pollen week.'+CHAR(13)+CHAR(10)+
      N'Roommate "Isla Johnson" bought new cat; symptoms worsened around litter box.'+CHAR(13)+CHAR(10)+
      N'Reviewed nasal spray technique and non-sedating antihistamines.'
    WHEN 'con_001_07_b' THEN
      N'Allergy follow-up.'+CHAR(13)+CHAR(10)+
      N'Improved with daily nasal spray.'+CHAR(13)+CHAR(10)+
      N'Patient planning to attend Sydney Festival show at Walsh Bay; discussed medication timing.'+CHAR(13)+CHAR(10)+
      N'Advised continue during peak season and taper when stable.'

    WHEN 'con_001_08_a' THEN
      N'Travel-related GI upset.'+CHAR(13)+CHAR(10)+
      N'Onset after weekend trip to Kiama; ate fish and chips at the harbour.'+CHAR(13)+CHAR(10)+
      N'Partner "Noah Clark" asymptomatic; child "Chloe" had mild nausea.'+CHAR(13)+CHAR(10)+
      N'Provided hydration advice and red flag guidance.'
    WHEN 'con_001_08_b' THEN
      N'GI symptoms resolved.'+CHAR(13)+CHAR(10)+
      N'Patient returned to work at Woolloomooloo office.'+CHAR(13)+CHAR(10)+
      N'Discussed food safety for upcoming camping at Lane Cove National Park.'+CHAR(13)+CHAR(10)+
      N'Recommended hand hygiene and safe storage of leftovers.'

    WHEN 'con_001_09_a' THEN
      N'Fatigue assessment; thyroid/iron discussion.'+CHAR(13)+CHAR(10)+
      N'Patient reports late nights due to caring for grandmother "Margaret Evans" in Chatswood.'+CHAR(13)+CHAR(10)+
      N'Attended funeral service at Macquarie Park chapel last week; grief noted.'+CHAR(13)+CHAR(10)+
      N'Ordered labs; discussed supports and sleep routine.'
    WHEN 'con_001_09_b' THEN
      N'Lab review: results within normal range.'+CHAR(13)+CHAR(10)+
      N'Patient planning return to gym near Chatswood Chase.'+CHAR(13)+CHAR(10)+
      N'Mentions sister "Emily Evans" visiting from Brisbane for Australia Day weekend.'+CHAR(13)+CHAR(10)+
      N'Provided fatigue management strategies and follow-up plan.'

    WHEN 'con_001_10_a' THEN
      N'Knee pain after running.'+CHAR(13)+CHAR(10)+
      N'Pain started following 10km run along Mosman Bay trail.'+CHAR(13)+CHAR(10)+
      N'Patient training with friend "Liam Walker" for the Blackmores Half.'+CHAR(13)+CHAR(10)+
      N'Advised strengthening, activity modification, and return precautions.'
    WHEN 'con_001_10_b' THEN
      N'Knee follow-up.'+CHAR(13)+CHAR(10)+
      N'Improved with exercises; patient attended physio near Neutral Bay.'+CHAR(13)+CHAR(10)+
      N'Mentions weekend hike at Spit to Manly planned with cousin "Jake".'+CHAR(13)+CHAR(10)+
      N'Provided graded progression plan.'

    -- Clinic 2
    WHEN 'con_002_01_a' THEN
      N'Acne flare consultation.'+CHAR(13)+CHAR(10)+
      N'Worse after hot yoga at Footscray studio; increased sweating.'+CHAR(13)+CHAR(10)+
      N'Patient attending formal event at Flemington Racecourse; anxious about skin.'+CHAR(13)+CHAR(10)+
      N'Started topical regimen; reviewed side effects and routine.'
    WHEN 'con_002_01_b' THEN
      N'Acne review.'+CHAR(13)+CHAR(10)+
      N'Improved; mild dryness around nose.'+CHAR(13)+CHAR(10)+
      N'Patient''s partner "Mia Roberts" bought new sunscreen for Great Ocean Road trip.'+CHAR(13)+CHAR(10)+
      N'Adjusted regimen and reinforced moisturiser/SPF.'

    WHEN 'con_002_02_a' THEN
      N'Eczema (hands) consult.'+CHAR(13)+CHAR(10)+
      N'Flare after childcare drop-off at Yarraville and frequent handwashing.'+CHAR(13)+CHAR(10)+
      N'Parent "Janet Martin" suggested fragranced cream—stopped due to sting.'+CHAR(13)+CHAR(10)+
      N'Provided barrier care plan and medication advice.'
    WHEN 'con_002_02_b' THEN
      N'Eczema follow-up.'+CHAR(13)+CHAR(10)+
      N'Improved with gloves for dishwashing and regular emollient use.'+CHAR(13)+CHAR(10)+
      N'Patient preparing for weekend BBQ at Newport Lakes; discussed sun exposure.'+CHAR(13)+CHAR(10)+
      N'Continued maintenance plan.'

    WHEN 'con_002_03_a' THEN
      N'Mole check.'+CHAR(13)+CHAR(10)+
      N'Patient noted new mole after beach day at Altona Pier.'+CHAR(13)+CHAR(10)+
      N'Family history: uncle "Peter Hughes" had melanoma (details discussed).'+CHAR(13)+CHAR(10)+
      N'No suspicious features; provided monitoring advice.'
    WHEN 'con_002_03_b' THEN
      N'Follow-up skin review.'+CHAR(13)+CHAR(10)+
      N'No change in lesion; baseline photo taken.'+CHAR(13)+CHAR(10)+
      N'Patient attending music event at Flemington; reminded about SPF and hat.'+CHAR(13)+CHAR(10)+
      N'Advised annual checks.'

    WHEN 'con_002_04_a' THEN
      N'Psoriasis management.'+CHAR(13)+CHAR(10)+
      N'Flare after stressful shift at Sunshine Hospital.'+CHAR(13)+CHAR(10)+
      N'Patient''s spouse "Henry Green" reports itching disrupts sleep.'+CHAR(13)+CHAR(10)+
      N'Discussed topical plan and trigger management.'
    WHEN 'con_002_04_b' THEN
      N'Psoriasis follow-up.'+CHAR(13)+CHAR(10)+
      N'Improved plaques; less itch.'+CHAR(13)+CHAR(10)+
      N'Patient planning camping at Werribee Gorge with friends; discussed packing meds.'+CHAR(13)+CHAR(10)+
      N'Continued regimen and moisturising guidance.'

    WHEN 'con_002_05_a' THEN
      N'Rosacea consult.'+CHAR(13)+CHAR(10)+
      N'Flushing triggered by coffee at Seddon cafe and summer heat.'+CHAR(13)+CHAR(10)+
      N'Patient worried before engagement party at Abbotsford Convent.'+CHAR(13)+CHAR(10)+
      N'Started topical treatment; reviewed triggers.'
    WHEN 'con_002_05_b' THEN
      N'Rosacea review.'+CHAR(13)+CHAR(10)+
      N'Reduced redness.'+CHAR(13)+CHAR(10)+
      N'Partner "Ella Turner" noticed flare after spicy dinner at Victoria St, Richmond.'+CHAR(13)+CHAR(10)+
      N'Continued treatment; reinforced SPF.'

    WHEN 'con_002_06_a' THEN
      N'Wart treatment (cryotherapy).' +CHAR(13)+CHAR(10)+
      N'Patient coaches kids footy at Whitten Oval; wants quick recovery.'+CHAR(13)+CHAR(10)+
      N'Mentions daughter "Chloe Baker" has school concert next week.'+CHAR(13)+CHAR(10)+
      N'Aftercare provided; expected blistering explained.'
    WHEN 'con_002_06_b' THEN
      N'Wart follow-up (2nd cryotherapy).' +CHAR(13)+CHAR(10)+
      N'Lesion reduced; mild tenderness.'+CHAR(13)+CHAR(10)+
      N'Patient travelling to Bendigo for family reunion; discussed dressing care.'+CHAR(13)+CHAR(10)+
      N'Reviewed aftercare and return if infection signs.'

    WHEN 'con_002_07_a' THEN
      N'Contact dermatitis.'+CHAR(13)+CHAR(10)+
      N'Onset after trying new serum bought from Chemist Warehouse (Footscray).'+CHAR(13)+CHAR(10)+
      N'Housemate "Ben Hill" suggested tea tree oil—advised against.'+CHAR(13)+CHAR(10)+
      N'Stopped product; prescribed topical steroid and soothing routine.'
    WHEN 'con_002_07_b' THEN
      N'Contact dermatitis resolved.'+CHAR(13)+CHAR(10)+
      N'Patient attended Christmas party at Docklands without flare.'+CHAR(13)+CHAR(10)+
      N'Recommended patch testing if future reactions; reviewed gentle products.'+CHAR(13)+CHAR(10)+
      N'Provided prevention plan.'

    WHEN 'con_002_08_a' THEN
      N'Hair thinning consult.'+CHAR(13)+CHAR(10)+
      N'Noticed increased shedding after stressful month moving from Seddon to Yarraville.'+CHAR(13)+CHAR(10)+
      N'Mother "Lily Kelly" has history of iron deficiency.'+CHAR(13)+CHAR(10)+
      N'Ordered labs; discussed minoxidil expectations.'
    WHEN 'con_002_08_b' THEN
      N'Hair thinning follow-up.'+CHAR(13)+CHAR(10)+
      N'Reviewed labs and nutrition.'+CHAR(13)+CHAR(10)+
      N'Patient attending wedding at St Kilda Botanical Gardens; discussed styling to reduce breakage.'+CHAR(13)+CHAR(10)+
      N'Continued management plan.'

    WHEN 'con_002_09_a' THEN
      N'Sun damage consult.'+CHAR(13)+CHAR(10)+
      N'Frequent beach days at Williamstown; inconsistent SPF use.'+CHAR(13)+CHAR(10)+
      N'Patient planning Surf Coast weekend (Torquay) with sibling "Sam Scott".'+CHAR(13)+CHAR(10)+
      N'Provided sun protection education and options.'
    WHEN 'con_002_09_b' THEN
      N'Follow-up for sun damage concerns.'+CHAR(13)+CHAR(10)+
      N'Patient started daily SPF; mild irritation noted.'+CHAR(13)+CHAR(10)+
      N'Attended outdoor event at Federation Square; used wide-brim hat.'+CHAR(13)+CHAR(10)+
      N'Adjusted regimen and reinforced sun safety.'

    WHEN 'con_002_10_a' THEN
      N'Skin tag removal.'+CHAR(13)+CHAR(10)+
      N'Patient requested removal before holiday photos at Great Ocean Road.'+CHAR(13)+CHAR(10)+
      N'Spouse "Samuel Wright" present in waiting room; consent discussed.'+CHAR(13)+CHAR(10)+
      N'Procedure uncomplicated; wound care advice provided.'
    WHEN 'con_002_10_b' THEN
      N'Post-procedure check.'+CHAR(13)+CHAR(10)+
      N'Healed well; no infection signs.'+CHAR(13)+CHAR(10)+
      N'Patient attended cricket at MCG; reminded about sunscreen on scar.'+CHAR(13)+CHAR(10)+
      N'Reviewed scar care and follow-up as needed.'

    -- Clinic 3
    WHEN 'con_003_01_a' THEN
      N'Immunisation / paediatric review.'+CHAR(13)+CHAR(10)+
      N'Family arrived after school drop-off at Carlton Primary.'+CHAR(13)+CHAR(10)+
      N'Parent "Zoe Morris" reports child excited for museum visit at Melbourne Museum.'+CHAR(13)+CHAR(10)+
      N'Vaccination provided; discussed post-vaccine care and fever plan.'
    WHEN 'con_003_01_b' THEN
      N'Growth and development follow-up.'+CHAR(13)+CHAR(10)+
      N'Family holiday planned to Healesville Sanctuary; discussed sun safety.'+CHAR(13)+CHAR(10)+
      N'Grandparent "Nana Ruth" assisting with routines during school holidays.'+CHAR(13)+CHAR(10)+
      N'Provided nutrition/sleep guidance and next review timing.'

    WHEN 'con_003_02_a' THEN
      N'Otitis media assessment.'+CHAR(13)+CHAR(10)+
      N'Symptoms started after swimming lesson at Carlton Baths.'+CHAR(13)+CHAR(10)+
      N'Parent "Lucas King" concerned due to upcoming flight to Adelaide for family wedding.'+CHAR(13)+CHAR(10)+
      N'Treatment options and safety-net advice discussed.'
    WHEN 'con_003_02_b' THEN
      N'Ear pain follow-up.'+CHAR(13)+CHAR(10)+
      N'Symptoms resolved; no hearing concerns.'+CHAR(13)+CHAR(10)+
      N'Family attended wedding in Adelaide; no recurrence during travel.'+CHAR(13)+CHAR(10)+
      N'Provided prevention tips and when to return.'

    WHEN 'con_003_03_a' THEN
      N'School readiness consultation.'+CHAR(13)+CHAR(10)+
      N'Family reports increased screen time during end-of-year events at Princess Theatre.'+CHAR(13)+CHAR(10)+
      N'Parent mentions aunt "Hannah Edwards" encouraging structured routines.'+CHAR(13)+CHAR(10)+
      N'Discussed bedtime routine, attention strategies, and supports.'
    WHEN 'con_003_03_b' THEN
      N'Follow-up school readiness.'+CHAR(13)+CHAR(10)+
      N'Routines improved; fewer bedtime disputes.'+CHAR(13)+CHAR(10)+
      N'Family planning day trip to St Kilda Beach; agreed on screen-time boundaries.'+CHAR(13)+CHAR(10)+
      N'Provided resources for ongoing support.'

    WHEN 'con_003_04_a' THEN
      N'Asthma review.'+CHAR(13)+CHAR(10)+
      N'Flare during smoky air from nearby BBQ at Queensberry St party.'+CHAR(13)+CHAR(10)+
      N'Parent "Oscar Collins" reports missed school day at Melbourne High entrance exam prep.'+CHAR(13)+CHAR(10)+
      N'Updated action plan and reviewed spacer technique.'
    WHEN 'con_003_04_b' THEN
      N'Asthma follow-up.'+CHAR(13)+CHAR(10)+
      N'Stable; no night waking.'+CHAR(13)+CHAR(10)+
      N'Family attending Australia Day picnic at Edinburgh Gardens; advised carry reliever.'+CHAR(13)+CHAR(10)+
      N'Discussed seasonal triggers and step-down plan.'

    WHEN 'con_003_05_a' THEN
      N'Nutrition / picky eating consult.'+CHAR(13)+CHAR(10)+
      N'Family dinners often at Lygon St; child prefers pasta only.'+CHAR(13)+CHAR(10)+
      N'Parent "Ruby Stewart" reports pressure from grandparent "Nonna Maria" during meals.'+CHAR(13)+CHAR(10)+
      N'Discussed exposure strategy and meal routine.'
    WHEN 'con_003_05_b' THEN
      N'Nutrition follow-up.'+CHAR(13)+CHAR(10)+
      N'Slight improvement; trying new foods after cooking class at Carlton Community Centre.'+CHAR(13)+CHAR(10)+
      N'Family planning holiday to Bright; discussed maintaining routine while travelling.'+CHAR(13)+CHAR(10)+
      N'Provided referral option if plateau.'

    WHEN 'con_003_06_a' THEN
      N'Sports clearance.'+CHAR(13)+CHAR(10)+
      N'Patient preparing for school athletics carnival at Princes Park.'+CHAR(13)+CHAR(10)+
      N'Parent "Theo Campbell" notes sibling "Ivy" has similar asthma history.'+CHAR(13)+CHAR(10)+
      N'Cleared; reviewed warm-up and hydration.'
    WHEN 'con_003_06_b' THEN
      N'Follow-up after minor strain.'+CHAR(13)+CHAR(10)+
      N'Incident occurred during soccer training at Royal Park.'+CHAR(13)+CHAR(10)+
      N'Family planning weekend visit to Scienceworks; advised rest and gradual return.'+CHAR(13)+CHAR(10)+
      N'Provided return-to-sport guidance.'

    WHEN 'con_003_07_a' THEN
      N'Sleep difficulties consult.'+CHAR(13)+CHAR(10)+
      N'Anxiety worsened after news of school camp at Phillip Island.'+CHAR(13)+CHAR(10)+
      N'Parent reports sibling "Max" teases at bedtime; family conflict discussed.'+CHAR(13)+CHAR(10)+
      N'Outlined routine, calming strategies, and support options.'
    WHEN 'con_003_07_b' THEN
      N'Sleep follow-up.'+CHAR(13)+CHAR(10)+
      N'Improved with consistent bedtime routine and reduced evening screens.'+CHAR(13)+CHAR(10)+
      N'Family attended Midsumma event (Carlton Gardens); bedtime maintained.'+CHAR(13)+CHAR(10)+
      N'Reinforced strategies and school term planning.'

    WHEN 'con_003_08_a' THEN
      N'Gastro symptoms consult.'+CHAR(13)+CHAR(10)+
      N'Onset after birthday party at Melbourne Zoo; possible food exposure.'+CHAR(13)+CHAR(10)+
      N'Parent "Maxwell Parker" reports sibling "Scarlett" also unwell.'+CHAR(13)+CHAR(10)+
      N'Hydration guidance and red flags reviewed.'
    WHEN 'con_003_08_b' THEN
      N'GI follow-up.'+CHAR(13)+CHAR(10)+
      N'Resolved; returned to school.'+CHAR(13)+CHAR(10)+
      N'Family planning long drive to Albury to visit grandparents; discussed snacks and hydration.'+CHAR(13)+CHAR(10)+
      N'Provided prevention advice.'

    WHEN 'con_003_09_a' THEN
      N'Allergy symptoms consult.'+CHAR(13)+CHAR(10)+
      N'Worse after visiting friend''s house with dogs in Brunswick.'+CHAR(13)+CHAR(10)+
      N'Parent notes father "Leo Bailey" has hayfever and uses daily antihistamine.'+CHAR(13)+CHAR(10)+
      N'Advised trial medication and avoidance strategies.'
    WHEN 'con_003_09_b' THEN
      N'Allergy follow-up.'+CHAR(13)+CHAR(10)+
      N'Symptoms controlled; no sedation from medication.'+CHAR(13)+CHAR(10)+
      N'Family attending outdoor movie night at Carlton Gardens; advised carry medication.'+CHAR(13)+CHAR(10)+
      N'Reinforced pollen-season plan.'

    WHEN 'con_003_10_a' THEN
      N'Wheeze with colds consult.'+CHAR(13)+CHAR(10)+
      N'Symptoms after school swimming carnival at MSAC.'+CHAR(13)+CHAR(10)+
      N'Parent reports cousin "Anil" suggested steam inhalation—discussed safety.'+CHAR(13)+CHAR(10)+
      N'Reviewed inhaler plan and return precautions.'
    WHEN 'con_003_10_b' THEN
      N'Follow-up wheeze review.'+CHAR(13)+CHAR(10)+
      N'Fewer symptoms; no night cough.'+CHAR(13)+CHAR(10)+
      N'Family planning weekend at Daylesford; advised pack reliever and spacer.'+CHAR(13)+CHAR(10)+
      N'Provided ongoing action plan.'

    -- Clinic 4
    WHEN 'con_004_01_a' THEN
      N'Ankle sprain assessment.'+CHAR(13)+CHAR(10)+
      N'Injury during trail run near Noosa National Park headland track.'+CHAR(13)+CHAR(10)+
      N'Partner "Poppy Cooper" reports swelling increased after standing at Sunshine Beach markets.'+CHAR(13)+CHAR(10)+
      N'RICE protocol discussed; provided rehab plan.'
    WHEN 'con_004_01_b' THEN
      N'Ankle sprain follow-up.'+CHAR(13)+CHAR(10)+
      N'Improving stability; progressed strengthening.'+CHAR(13)+CHAR(10)+
      N'Patient planning to attend Australia Day swim event at Main Beach; advised graded return.'+CHAR(13)+CHAR(10)+
      N'Reviewed taping options and warning signs.'

    WHEN 'con_004_02_a' THEN
      N'Shoulder pain (swimming).' +CHAR(13)+CHAR(10)+
      N'Pain started after squad session at Noosa Aquatic Centre.'+CHAR(13)+CHAR(10)+
      N'Mentions coach "Archie Ward" pushing increased volume before regional meet.'+CHAR(13)+CHAR(10)+
      N'Advised physio exercises, load management, and technique review.'
    WHEN 'con_004_02_b' THEN
      N'Shoulder follow-up.'+CHAR(13)+CHAR(10)+
      N'ROM improved; reduced pain with modified training.'+CHAR(13)+CHAR(10)+
      N'Family event: wedding at Laguna Lookout next month; patient wants to dance comfortably.'+CHAR(13)+CHAR(10)+
      N'Progressed rehab and reinforced warm-up.'

    WHEN 'con_004_03_a' THEN
      N'Runner''s knee assessment.'+CHAR(13)+CHAR(10)+
      N'Training on soft sand at Sunrise Beach; pain after hill repeats.'+CHAR(13)+CHAR(10)+
      N'Sibling "Matilda Howard" suggested new shoes—reviewed footwear.'+CHAR(13)+CHAR(10)+
      N'Provided strengthening plan and load guidance.'
    WHEN 'con_004_03_b' THEN
      N'Runner''s knee follow-up.'+CHAR(13)+CHAR(10)+
      N'Pain reduced; training resumed with cadence focus.'+CHAR(13)+CHAR(10)+
      N'Planning event at Noosa Triathlon expo; discussed pacing and recovery.'+CHAR(13)+CHAR(10)+
      N'Progressed program.'

    WHEN 'con_004_04_a' THEN
      N'Lower back strain consult.'+CHAR(13)+CHAR(10)+
      N'Onset after long drive to Brisbane for concert at Riverstage.'+CHAR(13)+CHAR(10)+
      N'Partner "Hudson Brooks" reports pain worse after sitting through show.'+CHAR(13)+CHAR(10)+
      N'Provided mobility/core plan and ergonomics advice.'
    WHEN 'con_004_04_b' THEN
      N'Back strain follow-up.'+CHAR(13)+CHAR(10)+
      N'Much improved; resumed Pilates at Noosaville studio.'+CHAR(13)+CHAR(10)+
      N'Family trip planned to Fraser Island (K''gari); discussed lifting and camping setup.'+CHAR(13)+CHAR(10)+
      N'Reinforced maintenance plan.'

    WHEN 'con_004_05_a' THEN
      N'Tennis elbow consult.'+CHAR(13)+CHAR(10)+
      N'Worse after social comp at Noosa Tennis Club.'+CHAR(13)+CHAR(10)+
      N'Patient''s father "Willow Gray" advised rest; discussed evidence-based rehab.'+CHAR(13)+CHAR(10)+
      N'Brace and exercises recommended.'
    WHEN 'con_004_05_b' THEN
      N'Tennis elbow follow-up.'+CHAR(13)+CHAR(10)+
      N'Improving; progressed eccentric loading.'+CHAR(13)+CHAR(10)+
      N'Patient attending charity event at Sunshine Beach Surf Club; advised pacing activities.'+CHAR(13)+CHAR(10)+
      N'Continued plan and reviewed technique.'

    WHEN 'con_004_06_a' THEN
      N'Hamstring tightness consult.'+CHAR(13)+CHAR(10)+
      N'Symptoms after sprint session on Noosa Oval.'+CHAR(13)+CHAR(10)+
      N'Mentions teammate "Mason Reid" encouraged stretching challenges; discussed safe approach.'+CHAR(13)+CHAR(10)+
      N'Provided graded strengthening plan.'
    WHEN 'con_004_06_b' THEN
      N'Hamstring follow-up.'+CHAR(13)+CHAR(10)+
      N'No pain on sprint; introduced drills.'+CHAR(13)+CHAR(10)+
      N'Upcoming family barbecue at Tewantin — patient wants to play backyard cricket.'+CHAR(13)+CHAR(10)+
      N'Reviewed warm-up and progression.'

    WHEN 'con_004_07_a' THEN
      N'Plantar heel pain consult.'+CHAR(13)+CHAR(10)+
      N'Worse after standing all day at Eumundi Markets.'+CHAR(13)+CHAR(10)+
      N'Partner "Evie Wood" bought new sandals—advised supportive footwear.'+CHAR(13)+CHAR(10)+
      N'Provided calf loading plan and footwear guidance.'
    WHEN 'con_004_07_b' THEN
      N'Heel pain follow-up.'+CHAR(13)+CHAR(10)+
      N'Improved morning pain; continued loading.'+CHAR(13)+CHAR(10)+
      N'Patient planning hiking event at Glass House Mountains; discussed precautions.'+CHAR(13)+CHAR(10)+
      N'Consider orthotics if plateau.'

    WHEN 'con_004_08_a' THEN
      N'Cycling-related neck pain consult.'+CHAR(13)+CHAR(10)+
      N'Pain after long ride from Noosa to Coolum.'+CHAR(13)+CHAR(10)+
      N'Mentions friend "Finn Kelly" adjusted handlebars; discussed bike fit properly.'+CHAR(13)+CHAR(10)+
      N'Exercises provided; posture cues discussed.'
    WHEN 'con_004_08_b' THEN
      N'Neck pain follow-up.'+CHAR(13)+CHAR(10)+
      N'Better tolerance on rides.'+CHAR(13)+CHAR(10)+
      N'Preparing for charity ride finishing at Mooloolaba; advised pacing and breaks.'+CHAR(13)+CHAR(10)+
      N'Progressed strengthening and mobility.'

    WHEN 'con_004_09_a' THEN
      N'Calf strain consult.'+CHAR(13)+CHAR(10)+
      N'Injury during beach volleyball at Sunshine Beach.'+CHAR(13)+CHAR(10)+
      N'Sibling "Elsie Hall" concerned due to upcoming wedding photos at Hastings St.'+CHAR(13)+CHAR(10)+
      N'Provided rest/loading plan and red flags.'
    WHEN 'con_004_09_b' THEN
      N'Calf strain follow-up.'+CHAR(13)+CHAR(10)+
      N'Strength returning; introduced plyometrics.'+CHAR(13)+CHAR(10)+
      N'Patient attending Noosa Food & Wine event; advised avoid prolonged standing early.'+CHAR(13)+CHAR(10)+
      N'Return-to-sport timeline discussed.'

    WHEN 'con_004_10_a' THEN
      N'Sports physical.'+CHAR(13)+CHAR(10)+
      N'Cleared for season; reviewed injury prevention.'+CHAR(13)+CHAR(10)+
      N'Patient plays local netball; training at Noosaville courts.'+CHAR(13)+CHAR(10)+
      N'Mentions coach "Charlie Cook" wants extra sessions — discussed recovery.'
    WHEN 'con_004_10_b' THEN
      N'Minor knee soreness check.'+CHAR(13)+CHAR(10)+
      N'After tournament weekend at Maroochydore.'+CHAR(13)+CHAR(10)+
      N'Family member "Aunt Claire" suggested ice baths—discussed balanced recovery.'+CHAR(13)+CHAR(10)+
      N'Advised deload week and mobility work.'

    -- Clinic 5
    WHEN 'con_005_01_a' THEN
      N'Palpitations review.'+CHAR(13)+CHAR(10)+
      N'Patient noticed episodes during concert at Hamer Hall (Southbank).'+CHAR(13)+CHAR(10)+
      N'Partner "Harper Bell" reports increased caffeine intake during work crunch.'+CHAR(13)+CHAR(10)+
      N'Planned ECG; discussed red flags and lifestyle triggers.'
    WHEN 'con_005_01_b' THEN
      N'ECG review.'+CHAR(13)+CHAR(10)+
      N'Results normal; reassurance provided.'+CHAR(13)+CHAR(10)+
      N'Patient attending family reunion in Ballarat; discussed hydration and pacing.'+CHAR(13)+CHAR(10)+
      N'Advised return if symptoms worsen.'

    WHEN 'con_005_02_a' THEN
      N'Hypertension consult.'+CHAR(13)+CHAR(10)+
      N'Home BP elevated after stressful meeting in CBD (Collins St).'+CHAR(13)+CHAR(10)+
      N'Spouse "Sebastian Murphy" concerned due to family history in father "Glen".'+CHAR(13)+CHAR(10)+
      N'Discussed lifestyle, monitoring, and medication options.'
    WHEN 'con_005_02_b' THEN
      N'Hypertension follow-up.'+CHAR(13)+CHAR(10)+
      N'BP improving; adherence good.'+CHAR(13)+CHAR(10)+
      N'Patient attending wedding at Coombe Yarra Valley; discussed alcohol/salt moderation.'+CHAR(13)+CHAR(10)+
      N'Continue plan; schedule repeat readings.'

    WHEN 'con_005_03_a' THEN
      N'Chest discomfort on exertion.'+CHAR(13)+CHAR(10)+
      N'Symptoms noted during hike at 1000 Steps (Dandenongs).'+CHAR(13)+CHAR(10)+
      N'Family member "Aria Morgan" urged immediate review; discussed safety plan.'+CHAR(13)+CHAR(10)+
      N'Ordered stress test; reviewed emergency red flags.'
    WHEN 'con_005_03_b' THEN
      N'Stress test review.'+CHAR(13)+CHAR(10)+
      N'Reassuring result; discussed graded exercise.'+CHAR(13)+CHAR(10)+
      N'Patient planning trip to Phillip Island Penguin Parade with children "Levi" and "Freya".'+CHAR(13)+CHAR(10)+
      N'Advised symptom tracking and follow-up if recurrence.'

    WHEN 'con_005_04_a' THEN
      N'Lipid management consult.'+CHAR(13)+CHAR(10)+
      N'Diet high in takeaway during renovation in Kew.'+CHAR(13)+CHAR(10)+
      N'Partner "Levi Pierce" concerned after colleague''s recent heart event.'+CHAR(13)+CHAR(10)+
      N'Discussed statin options and lifestyle plan.'
    WHEN 'con_005_04_b' THEN
      N'Lipids follow-up.'+CHAR(13)+CHAR(10)+
      N'Started medication; mild muscle ache denied.'+CHAR(13)+CHAR(10)+
      N'Attended Christmas Eve service at St Patrick''s Cathedral; increased walking tolerated.'+CHAR(13)+CHAR(10)+
      N'Reviewed side effects, labs plan, and adherence.'

    WHEN 'con_005_05_a' THEN
      N'Shortness of breath assessment.'+CHAR(13)+CHAR(10)+
      N'Noted during stair climbing at Parliament Station.'+CHAR(13)+CHAR(10)+
      N'Patient stressed after caring for parent "Freya Richardson" post-surgery.'+CHAR(13)+CHAR(10)+
      N'Ordered echo; reviewed activity pacing and red flags.'
    WHEN 'con_005_05_b' THEN
      N'Echo review.'+CHAR(13)+CHAR(10)+
      N'Normal findings; reassurance given.'+CHAR(13)+CHAR(10)+
      N'Patient attending Australia Day event at Studley Park Boathouse; discussed heat precautions.'+CHAR(13)+CHAR(10)+
      N'Provided fitness progression guidance.'

    WHEN 'con_005_06_a' THEN
      N'Family history / preventive cardiology consult.'+CHAR(13)+CHAR(10)+
      N'Patient''s sibling "Ashton Henderson" had high cholesterol; discussed screening.'+CHAR(13)+CHAR(10)+
      N'Work travel to Canberra (Parliament House) planned; advised routine and exercise.'+CHAR(13)+CHAR(10)+
      N'Outlined lifestyle plan and monitoring.'
    WHEN 'con_005_06_b' THEN
      N'Preventive follow-up.'+CHAR(13)+CHAR(10)+
      N'Patient increased daily steps via walks around Yarra Bend Park.'+CHAR(13)+CHAR(10)+
      N'Family member "Violet Fox" organising charity fun run; discussed safe training.'+CHAR(13)+CHAR(10)+
      N'Planned repeat labs and ongoing follow-up.'

    WHEN 'con_005_07_a' THEN
      N'Medication review.'+CHAR(13)+CHAR(10)+
      N'BP log reviewed; adherence discussed.'+CHAR(13)+CHAR(10)+
      N'Patient attended NYE fireworks at Docklands; had late night and missed dose.'+CHAR(13)+CHAR(10)+
      N'Discussed reminders and routine strategies.'
    WHEN 'con_005_07_b' THEN
      N'Follow-up medication review.'+CHAR(13)+CHAR(10)+
      N'Stable readings; no side effects.'+CHAR(13)+CHAR(10)+
      N'Patient planning weekend brunch at Chapel St with friend "Cooper Jameson".'+CHAR(13)+CHAR(10)+
      N'Continue regimen; follow-up schedule set.'

    WHEN 'con_005_08_a' THEN
      N'Intermittent dizziness assessment.'+CHAR(13)+CHAR(10)+
      N'Occurs after standing quickly at workplace in Richmond.'+CHAR(13)+CHAR(10)+
      N'Partner "Daisy Simons" noticed reduced fluid intake during heatwave.'+CHAR(13)+CHAR(10)+
      N'Ordered labs; advised hydration and slow position changes.'
    WHEN 'con_005_08_b' THEN
      N'Dizziness follow-up.'+CHAR(13)+CHAR(10)+
      N'Labs normal; symptoms improved with hydration.'+CHAR(13)+CHAR(10)+
      N'Family trip to Mornington Peninsula planned; advised heat precautions.'+CHAR(13)+CHAR(10)+
      N'Provided ongoing management advice.'

    WHEN 'con_005_09_a' THEN
      N'Post-viral fatigue consult.'+CHAR(13)+CHAR(10)+
      N'Patient reports illness after attending AFL match at MCG.'+CHAR(13)+CHAR(10)+
      N'Parent "Jude Anderson" assisting with childcare for niece "Sophie".'+CHAR(13)+CHAR(10)+
      N'Discussed pacing, sleep hygiene, and rule-out tests.'
    WHEN 'con_005_09_b' THEN
      N'Post-viral fatigue follow-up.'+CHAR(13)+CHAR(10)+
      N'Improving; gradually resuming exercise.'+CHAR(13)+CHAR(10)+
      N'Patient planning family lunch at Lorne; discussed rest breaks and hydration.'+CHAR(13)+CHAR(10)+
      N'Reinforced pacing strategy and follow-up if relapse.'

    WHEN 'con_005_10_a' THEN
      N'Preventive cardiology consult.'+CHAR(13)+CHAR(10)+
      N'Patient starting lifestyle changes after friend''s event at Albert Park.'+CHAR(13)+CHAR(10)+
      N'Partner "Marcus" wants joint meal plan; discussed Mediterranean-style diet.'+CHAR(13)+CHAR(10)+
      N'Reviewed BP targets and activity goals.'
    WHEN 'con_005_10_b' THEN
      N'Preventive follow-up.'+CHAR(13)+CHAR(10)+
      N'Progress on steps/day; cooking more at home.'+CHAR(13)+CHAR(10)+
      N'Family attending wedding in Geelong; discussed alcohol moderation and sleep.'+CHAR(13)+CHAR(10)+
      N'Planned repeat lipids and ongoing follow-up.'

    ELSE notes
  END
WHERE id IN (
  'con_001_01_a','con_001_01_b','con_001_02_a','con_001_02_b','con_001_03_a','con_001_03_b','con_001_04_a','con_001_04_b','con_001_05_a','con_001_05_b',
  'con_001_06_a','con_001_06_b','con_001_07_a','con_001_07_b','con_001_08_a','con_001_08_b','con_001_09_a','con_001_09_b','con_001_10_a','con_001_10_b',
  'con_002_01_a','con_002_01_b','con_002_02_a','con_002_02_b','con_002_03_a','con_002_03_b','con_002_04_a','con_002_04_b','con_002_05_a','con_002_05_b',
  'con_002_06_a','con_002_06_b','con_002_07_a','con_002_07_b','con_002_08_a','con_002_08_b','con_002_09_a','con_002_09_b','con_002_10_a','con_002_10_b',
  'con_003_01_a','con_003_01_b','con_003_02_a','con_003_02_b','con_003_03_a','con_003_03_b','con_003_04_a','con_003_04_b','con_003_05_a','con_003_05_b',
  'con_003_06_a','con_003_06_b','con_003_07_a','con_003_07_b','con_003_08_a','con_003_08_b','con_003_09_a','con_003_09_b','con_003_10_a','con_003_10_b',
  'con_004_01_a','con_004_01_b','con_004_02_a','con_004_02_b','con_004_03_a','con_004_03_b','con_004_04_a','con_004_04_b','con_004_05_a','con_004_05_b',
  'con_004_06_a','con_004_06_b','con_004_07_a','con_004_07_b','con_004_08_a','con_004_08_b','con_004_09_a','con_004_09_b','con_004_10_a','con_004_10_b',
  'con_005_01_a','con_005_01_b','con_005_02_a','con_005_02_b','con_005_03_a','con_005_03_b','con_005_04_a','con_005_04_b','con_005_05_a','con_005_05_b',
  'con_005_06_a','con_005_06_b','con_005_07_a','con_005_07_b','con_005_08_a','con_005_08_b','con_005_09_a','con_005_09_b','con_005_10_a','con_005_10_b'
);

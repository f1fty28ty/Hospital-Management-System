-- ============================================================
-- COMPREHENSIVE SEED DATA FOR HOSPITAL MANAGEMENT SYSTEM
-- ============================================================
-- This script populates all tables with sample data
-- Execute in order to maintain referential integrity
-- ============================================================

-- ============================================================
-- STAGE 1: Core Entities (Departments, Rooms, Medications)
-- ============================================================

-- Insert 9 Departments
INSERT INTO Department (departmentName, location) VALUES
('Front Desk', 'Main Entrance'),
('Laboratory', 'Building A'),
('Pharmacy', 'Building B'),
('Radiology', 'Building C'),
('Surgery', 'Block D'),
('Pediatrics', 'Block E'),
('Maternity', 'Block F'),
('ICU', 'Block G'),
('General', 'Block H');

-- Insert one Room per Department (9 rooms total)
INSERT INTO Room (roomNumber, type, status, departmentID) VALUES
('001', 'General', 'Available', 1),   -- Front Desk
('LAB', 'General', 'Available', 2),   -- Laboratory
('PHR', 'General', 'Available', 3),   -- Pharmacy
('RAD', 'General', 'Available', 4),   -- Radiology
('SUR', 'Surgery', 'Available', 5),   -- Surgery
('PED', 'Pediatric', 'Available', 6), -- Pediatrics
('MAT', 'Maternity', 'Available', 7), -- Maternity
('ICU', 'ICU', 'Available', 8),       -- ICU
('GEN', 'General', 'Available', 9);   -- General

-- Insert Medications (10 common medications)
INSERT INTO Medications (medicationName, description, dosage, sideEffects) VALUES
('Paracetamol', 'Pain reliever and fever reducer', '500mg every 4-6 hours', 'Nausea, rash, liver damage with overdose'),
('Amoxicillin', 'Antibiotic for bacterial infections', '250mg every 8 hours', 'Diarrhea, allergic reactions, nausea'),
('Ibuprofen', 'Anti-inflammatory pain reliever', '400mg every 4-6 hours', 'Stomach upset, dizziness, heartburn'),
('Lisinopril', 'Blood pressure medication', '10mg once daily', 'Dizziness, dry cough, headache'),
('Metformin', 'Diabetes medication', '500mg twice daily', 'Nausea, diarrhea, stomach pain'),
('Atorvastatin', 'Cholesterol-lowering medication', '20mg once daily', 'Muscle pain, digestive problems'),
('Omeprazole', 'Acid reflux medication', '20mg once daily', 'Headache, nausea, diarrhea'),
('Levothyroxine', 'Thyroid hormone replacement', '50mcg once daily', 'Weight changes, hair loss, sweating'),
('Albuterol', 'Asthma inhaler', '2 puffs as needed', 'Nervousness, tremor, headache'),
('Aspirin', 'Blood thinner and pain reliever', '81mg once daily', 'Stomach bleeding, easy bruising');

-- ============================================================
-- STAGE 2: Employees (One employee per department)
-- ============================================================
-- Note: Assuming auto-increment will assign employeeIDs 1-9

INSERT INTO Employee (firstName, lastName, DOB, phone, homeAddress, position, departmentID, dateHired, salary) VALUES
('Alice', 'Frontdesk', '1988-05-12', '555-0001', '12 Entry St', 'Receptionist', 1, '2019-01-01', 35000.00),
('Bob', 'Labtech', '1985-08-24', '555-0002', '34 Lab Rd', 'Lab Technician', 2, '2018-02-15', 60000.00),
('Carol', 'Pharma', '1990-10-03', '555-0003', '56 Pharma Ave', 'Pharmacist', 3, '2017-06-20', 70000.00),
('Dave', 'Radios', '1979-12-11', '555-0004', '78 Rad St', 'Doctor', 4, '2016-03-30', 110000.00),
('Eve', 'Surgeon', '1983-11-22', '555-0005', '90 Sur Dr', 'Doctor', 5, '2014-09-14', 150000.00),
('Frank', 'Pedia', '1987-07-29', '555-0006', '12 Child Ln', 'Nurse', 6, '2021-05-10', 65000.00),
('Grace', 'Maternity', '1986-03-14', '555-0007', '34 Birth Way', 'Nurse', 7, '2022-04-18', 55000.00),
('Hank', 'ICUstaff', '1992-09-05', '555-0008', '56 ICU Blvd', 'Doctor', 8, '2013-12-25', 125000.00),
('Ian', 'General', '1984-06-07', '555-0009', '78 Gen Rd', 'Administrative Staff', 9, '2020-11-11', 50000.00);

-- ============================================================
-- STAGE 3: Employee Extension Tables
-- ============================================================
-- Assuming employeeIDs: Alice=1, Bob=2, Carol=3, Dave=4, Eve=5, Frank=6, Grace=7, Hank=8, Ian=9

-- Insert Receptionist (Alice, employeeID=1)
INSERT INTO Receptionist (receptionistID, departmentID) VALUES
(1, 1);

-- Insert Lab Technician (Bob, employeeID=2)
INSERT INTO LabTechnician (labTechnicianID, departmentID) VALUES
(2, 2);

-- Insert Pharmacist (Carol, employeeID=3)
INSERT INTO Pharmacist (pharmacistID, departmentID) VALUES
(3, 3);

-- Insert Doctors (Dave=4, Eve=5, Hank=8)
INSERT INTO Doctor (doctorID, roomID, payScale, specialization) VALUES
(4, 4, 110000.00, 'Radiology'),
(5, 5, 150000.00, 'Surgery'),
(8, 8, 125000.00, 'Critical Care');

-- Insert Nurses (Frank=6, Grace=7)
INSERT INTO Nurse (nurseID, departmentID) VALUES
(6, 6),
(7, 7);

-- Insert Administrative Staff (Ian=9)
INSERT INTO AdministrativeStaff (administrativeStaffID, departmentID) VALUES
(9, 9);

-- ============================================================
-- STAGE 4: Patients (Original 5)
-- ============================================================

INSERT INTO Patients (firstName, lastName, DOB, phone, homeAddress, emergencyContactName, emergencyContactPhone, primaryDoctorID) VALUES
('Michael', 'Brown', '1987-05-14', '555-1001', '987 Birch St', 'Laura Brown', '555-1002', 4),
('Sarah', 'Davis', '1993-08-07', '555-1003', '654 Spruce St', 'John Davis', '555-1004', 5),
('Robert', 'Wilson', '1975-12-20', '555-1005', '321 Oak Ave', 'Mary Wilson', '555-1006', 8),
('Jennifer', 'Martinez', '1998-03-15', '555-1007', '147 Pine Dr', 'Carlos Martinez', '555-1008', 4),
('William', 'Anderson', '1965-09-30', '555-1009', '258 Maple Ln', 'Susan Anderson', '555-1010', 5);

-- ============================================================
-- STAGE 5: Appointments (Original 5)
-- ============================================================

INSERT INTO Appointment (patientID, doctorID, appointmentDate, reason, status) VALUES
(1, 4, '2025-11-05 10:00:00', 'Annual checkup and X-ray', 'Scheduled'),
(2, 5, '2025-11-06 14:30:00', 'Pre-surgery consultation', 'Scheduled'),
(3, 8, '2025-11-07 09:00:00', 'ICU follow-up', 'Scheduled'),
(4, 4, '2025-11-08 11:00:00', 'Pediatric wellness exam', 'Completed'),
(5, 5, '2025-11-09 15:00:00', 'Post-operative follow-up', 'Completed');

-- ============================================================
-- STAGE 6: Prescriptions (Original 5)
-- ============================================================

INSERT INTO Prescriptions (patientID, doctorID, medicationID, actions) VALUES
(1, 4, 1, 'Take one tablet every 6 hours for pain relief'),
(2, 5, 2, 'Take one capsule three times daily for 10 days'),
(3, 8, 4, 'Take one tablet daily in the morning for blood pressure'),
(4, 4, 3, 'Take one tablet every 6 hours as needed for fever'),
(5, 5, 6, 'Take one tablet daily in the evening for cholesterol');

-- ============================================================
-- STAGE 7: Lab Tests
-- ============================================================

INSERT INTO LabTests (testName, description, cost, startDate, endDate) VALUES
('Complete Blood Count', 'CBC - Full blood panel analysis', 50.00, '2025-10-01', '2025-10-01'),
('Chest X-Ray', 'Radiological examination of chest', 100.00, '2025-10-01', '2025-10-01'),
('Lipid Panel', 'Cholesterol and triglycerides test', 75.00, '2025-10-01', '2025-10-01'),
('Urinalysis', 'Urine composition analysis', 30.00, '2025-10-01', '2025-10-01'),
('Blood Glucose', 'Fasting blood sugar test', 25.00, '2025-10-01', '2025-10-01');

-- ============================================================
-- STAGE 8: Lab Results (Original 5)
-- ============================================================

INSERT INTO LabResults (labTestID, patientID, resultDate, results, performedBy, status) VALUES
(1, 1, '2025-10-15 14:00:00', 'WBC: 7.5, RBC: 4.8, Hemoglobin: 14.2 - All values within normal range', 2, 'Completed'),
(2, 2, '2025-10-16 10:00:00', 'Chest clear, no abnormalities detected', 2, 'Completed'),
(3, 3, '2025-10-17 11:30:00', 'Total cholesterol: 185 mg/dL, HDL: 55, LDL: 110 - Within normal limits', 2, 'Completed'),
(4, 4, '2025-10-18 09:00:00', 'pH: 6.5, Specific gravity: 1.015, No abnormalities', 2, 'Completed'),
(5, 5, '2025-10-19 08:30:00', 'Fasting glucose: 95 mg/dL - Normal', 2, 'Completed');

-- ============================================================
-- STAGE 9: Medical History (Original 5)
-- ============================================================

INSERT INTO MedicalHistory (patientID, allergies, immunizations, diagnoses, treatments) VALUES
(1, 'Penicillin', 'Flu (2024), COVID-19 (2023), Hepatitis B', 'Hypertension, Seasonal allergies', 'Blood pressure medication, antihistamines'),
(2, 'None known', 'Flu (2024), MMR, Tdap', 'Appendicitis (resolved)', 'Appendectomy (2022)'),
(3, 'Sulfa drugs', 'Flu (2024), Pneumonia vaccine', 'Type 2 Diabetes, High cholesterol', 'Metformin, Atorvastatin'),
(4, 'None known', 'Flu (2024), COVID-19 (2023), Chickenpox', 'Asthma', 'Albuterol inhaler as needed'),
(5, 'Aspirin', 'Flu (2024), Shingles vaccine', 'Coronary artery disease', 'Stent placement (2020), ongoing medication');

-- ============================================================
-- STAGE 10: Care Plans (Original 5)
-- ============================================================

INSERT INTO CarePlan (patientID, diagnosis, treatmentPlan, startDate, endDate) VALUES
(1, 'Hypertension Stage 1', 'Lifestyle modifications: reduce sodium intake, exercise 30 min daily, monitor BP weekly. Continue Lisinopril.', '2025-10-10', '2026-04-10'),
(2, 'Post-appendectomy recovery', 'Rest for 2 weeks, avoid heavy lifting, gradual return to normal activities. Follow-up in 6 weeks.', '2025-10-15', '2025-12-15'),
(3, 'Type 2 Diabetes management', 'Diet control, regular exercise, blood glucose monitoring twice daily. Continue Metformin.', '2025-10-20', '2026-10-20'),
(4, 'Pediatric asthma', 'Avoid triggers, use rescue inhaler as needed, breathing exercises. Monthly follow-ups.', '2025-10-25', '2026-04-25'),
(5, 'Cardiac rehabilitation', 'Supervised exercise program 3x/week, dietary counseling, stress management. Continue medications.', '2025-10-30', '2026-04-30');

-- ============================================================
-- STAGE 11: Doctor Schedule
-- ============================================================

INSERT INTO DoctorSchedule (doctorID, dayOfWeek, startTime, endTime) VALUES
(4, 'Monday', '2025-11-03 08:00:00', '2025-11-03 16:00:00'),
(4, 'Wednesday', '2025-11-05 08:00:00', '2025-11-05 16:00:00'),
(4, 'Friday', '2025-11-07 08:00:00', '2025-11-07 16:00:00'),
(5, 'Monday', '2025-11-03 07:00:00', '2025-11-03 18:00:00'),
(5, 'Tuesday', '2025-11-04 07:00:00', '2025-11-04 18:00:00'),
(5, 'Thursday', '2025-11-06 07:00:00', '2025-11-06 18:00:00'),
(8, 'Monday', '2025-11-03 00:00:00', '2025-11-03 12:00:00'),
(8, 'Wednesday', '2025-11-05 12:00:00', '2025-11-06 00:00:00'),
(8, 'Friday', '2025-11-07 00:00:00', '2025-11-07 12:00:00');

-- ============================================================
-- STAGE 12: Pharmacy Stock (Original 10)
-- ============================================================

INSERT INTO PharmacyStock (medicationID, batchNumber, quantity, expirationDate) VALUES
(1, 'PAR20251001', 500, '2026-10-01'),
(2, 'AMX20251002', 300, '2026-09-15'),
(3, 'IBU20251003', 400, '2026-11-30'),
(4, 'LIS20251004', 200, '2027-01-15'),
(5, 'MET20251005', 350, '2026-12-31'),
(6, 'ATO20251006', 250, '2027-02-28'),
(7, 'OME20251007', 180, '2026-08-20'),
(8, 'LEV20251008', 220, '2027-03-10'),
(9, 'ALB20251009', 150, '2026-07-25'),
(10, 'ASP20251010', 600, '2027-05-15');

-- ============================================================
-- STAGE 13: Invoices and Invoice Items (Original 5 patients)
-- ============================================================

-- Invoice for Patient 1 (Michael Brown)
INSERT INTO Invoice (patientID, invoiceDate, totalAmount, amountPaid, status) VALUES
(1, '2025-10-15 16:00:00', 175.00, 175.00, 'Paid');

INSERT INTO InvoiceItem (invoiceID, description, quantity, unitPrice) VALUES
(1, 'Complete Blood Count (CBC)', 1, 50.00),
(1, 'Office Visit - Consultation', 1, 100.00),
(1, 'Paracetamol Prescription', 20, 1.25);

-- Invoice for Patient 2 (Sarah Davis)
INSERT INTO Invoice (patientID, invoiceDate, totalAmount, amountPaid, status) VALUES
(2, '2025-10-16 17:00:00', 250.00, 100.00, 'Pending');

INSERT INTO InvoiceItem (invoiceID, description, quantity, unitPrice) VALUES
(2, 'Chest X-Ray', 1, 100.00),
(2, 'Pre-surgery Consultation', 1, 125.00),
(2, 'Amoxicillin Prescription', 30, 0.83);

-- Invoice for Patient 3 (Robert Wilson)
INSERT INTO Invoice (patientID, invoiceDate, totalAmount, amountPaid, status) VALUES
(3, '2025-10-17 15:30:00', 325.00, 325.00, 'Paid');

INSERT INTO InvoiceItem (invoiceID, description, quantity, unitPrice) VALUES
(3, 'Lipid Panel', 1, 75.00),
(3, 'ICU Follow-up Visit', 1, 200.00),
(3, 'Lisinopril Prescription', 30, 1.67);

-- Invoice for Patient 4 (Jennifer Martinez)
INSERT INTO Invoice (patientID, invoiceDate, totalAmount, amountPaid, status) VALUES
(4, '2025-10-18 14:00:00', 155.00, 0.00, 'Unpaid');

INSERT INTO InvoiceItem (invoiceID, description, quantity, unitPrice) VALUES
(4, 'Urinalysis', 1, 30.00),
(4, 'Pediatric Wellness Exam', 1, 100.00),
(4, 'Ibuprofen Prescription', 20, 1.25);

-- Invoice for Patient 5 (William Anderson)
INSERT INTO Invoice (patientID, invoiceDate, totalAmount, amountPaid, status) VALUES
(5, '2025-10-19 13:00:00', 200.00, 100.00, 'Pending');

INSERT INTO InvoiceItem (invoiceID, description, quantity, unitPrice) VALUES
(5, 'Blood Glucose Test', 1, 25.00),
(5, 'Post-operative Follow-up', 1, 150.00),
(5, 'Atorvastatin Prescription', 30, 0.83);

-- ============================================================
-- ENHANCED DATA - Additional Patients and Records
-- ============================================================

-- ============================================================
-- STAGE 14: Additional Patients (6-15)
-- ============================================================

INSERT INTO Patients (firstName, lastName, DOB, phone, homeAddress, emergencyContactName, emergencyContactPhone, primaryDoctorID) VALUES
('Emma', 'Thompson', '1992-06-15', '555-2001', '789 Cedar St', 'James Thompson', '555-2002', 4),
('Oliver', 'Garcia', '1988-11-20', '555-2003', '456 Elm St', 'Maria Garcia', '555-2004', 5),
('Sophia', 'Rodriguez', '2010-03-08', '555-2005', '123 Willow Ave', 'Pedro Rodriguez', '555-2006', 4),
('Liam', 'Johnson', '1955-07-25', '555-2007', '890 Pine Rd', 'Elizabeth Johnson', '555-2008', 8),
('Ava', 'Williams', '1978-09-12', '555-2009', '234 Maple Dr', 'Noah Williams', '555-2010', 5),
('Ethan', 'Brown', '2015-12-30', '555-2011', '567 Oak Ln', 'Isabella Brown', '555-2012', 4),
('Mia', 'Jones', '1990-04-18', '555-2013', '678 Birch Way', 'Mason Jones', '555-2014', 8),
('Noah', 'Miller', '1968-08-03', '555-2015', '789 Spruce Ct', 'Emma Miller', '555-2016', 5),
('Isabella', 'Davis', '2008-01-22', '555-2017', '890 Cedar Blvd', 'Liam Davis', '555-2018', 4),
('Lucas', 'Martinez', '1985-05-16', '555-2019', '345 Willow St', 'Olivia Martinez', '555-2020', 8);

-- ============================================================
-- STAGE 15: Additional Appointments (with varied dates)
-- ============================================================

INSERT INTO Appointment (patientID, doctorID, appointmentDate, reason, status) VALUES
-- Today's appointments (using relative dates for demo purposes)
(6, 4, DATE_ADD(NOW(), INTERVAL 2 HOUR), 'Severe headache and dizziness', 'Scheduled'),
(7, 5, DATE_ADD(NOW(), INTERVAL 4 HOUR), 'Post-surgery follow-up', 'Scheduled'),
(8, 4, DATE_ADD(NOW(), INTERVAL 6 HOUR), 'Child wellness check - vaccines', 'Scheduled'),
(9, 8, DATE_ADD(NOW(), INTERVAL 1 HOUR), 'Chest pain and shortness of breath', 'Scheduled'),
(10, 5, DATE_ADD(NOW(), INTERVAL 8 HOUR), 'Consultation for knee replacement', 'Scheduled'),

-- This week's appointments
(11, 4, DATE_ADD(NOW(), INTERVAL 1 DAY), 'Annual physical exam', 'Scheduled'),
(12, 8, DATE_ADD(NOW(), INTERVAL 2 DAY), 'ICU recovery assessment', 'Scheduled'),
(13, 5, DATE_ADD(NOW(), INTERVAL 3 DAY), 'Pre-operative consultation', 'Scheduled'),
(14, 4, DATE_ADD(NOW(), INTERVAL 4 DAY), 'Pediatric allergy testing', 'Scheduled'),
(15, 8, DATE_ADD(NOW(), INTERVAL 5 DAY), 'Cardiac stress test', 'Scheduled'),

-- Future appointments
(6, 4, DATE_ADD(NOW(), INTERVAL 10 DAY), 'Follow-up MRI results review', 'Scheduled'),
(7, 5, DATE_ADD(NOW(), INTERVAL 15 DAY), 'Surgery scheduling', 'Scheduled'),
(8, 4, DATE_ADD(NOW(), INTERVAL 20 DAY), '6-month pediatric checkup', 'Scheduled'),

-- Completed appointments
(9, 8, DATE_SUB(NOW(), INTERVAL 2 DAY), 'Emergency admission - stabilized', 'Completed'),
(10, 5, DATE_SUB(NOW(), INTERVAL 5 DAY), 'Orthopedic consultation completed', 'Completed'),
(11, 4, DATE_SUB(NOW(), INTERVAL 7 DAY), 'Routine checkup completed', 'Completed'),

-- Cancelled appointments
(12, 8, DATE_ADD(NOW(), INTERVAL 6 DAY), 'Patient cancelled - rescheduling needed', 'Cancelled'),
(13, 5, DATE_SUB(NOW(), INTERVAL 1 DAY), 'No-show appointment', 'Cancelled');

-- ============================================================
-- STAGE 16: Additional Prescriptions
-- ============================================================

INSERT INTO Prescriptions (patientID, doctorID, medicationID, actions) VALUES
(6, 4, 3, 'Take one tablet every 8 hours for headache relief'),
(7, 5, 2, 'Post-surgical antibiotic - take one capsule three times daily for 14 days'),
(8, 4, 9, 'Use 2 puffs every 4-6 hours as needed for asthma symptoms'),
(9, 8, 10, 'Take one tablet daily for heart health - blood thinner'),
(10, 5, 3, 'Take one tablet every 6 hours for post-operative pain'),
(11, 4, 7, 'Take one capsule daily before breakfast for acid reflux'),
(12, 8, 5, 'Take one tablet twice daily with meals for blood sugar control'),
(13, 5, 6, 'Take one tablet at bedtime for cholesterol management'),
(14, 4, 1, 'Give child 1/2 tablet every 6 hours for fever (max 4 doses per day)'),
(15, 8, 4, 'Take one tablet each morning for blood pressure control');

-- ============================================================
-- STAGE 17: Additional Lab Results
-- ============================================================

INSERT INTO LabResults (labTestID, patientID, resultDate, results, performedBy, status) VALUES
-- Completed tests
(1, 6, DATE_SUB(NOW(), INTERVAL 1 DAY), 'WBC: 12.3 (elevated), RBC: 4.9, Hemoglobin: 13.8 - Slight infection indicated', 2, 'Completed'),
(2, 7, DATE_SUB(NOW(), INTERVAL 3 DAY), 'Post-surgical X-ray shows proper healing, no complications', 2, 'Completed'),
(3, 9, DATE_SUB(NOW(), INTERVAL 2 DAY), 'Total cholesterol: 245 mg/dL (high), HDL: 42 (low), LDL: 165 (high) - Needs treatment', 2, 'Completed'),
(4, 10, DATE_SUB(NOW(), INTERVAL 4 DAY), 'pH: 5.8, Specific gravity: 1.020, Trace protein detected', 2, 'Completed'),
(5, 11, DATE_SUB(NOW(), INTERVAL 6 DAY), 'Fasting glucose: 185 mg/dL - Elevated, diabetic range', 2, 'Completed'),

-- In Progress tests
(1, 12, NOW(), 'Sample collected, awaiting analysis', 2, 'In Progress'),
(2, 13, NOW(), 'Imaging in progress', 2, 'In Progress'),

-- Pending tests
(3, 14, NULL, 'Test scheduled for tomorrow', 2, 'Pending'),
(4, 15, NULL, 'Sample not yet collected', 2, 'Pending');

-- ============================================================
-- STAGE 18: Additional Medical History
-- ============================================================

INSERT INTO MedicalHistory (patientID, allergies, immunizations, diagnoses, treatments) VALUES
(6, 'Latex, Shellfish', 'Flu (2024), COVID-19 (2023)', 'Migraine disorder, Anxiety', 'Ibuprofen as needed, therapy sessions'),
(7, 'None known', 'Flu (2024), Tetanus (2023)', 'Recent appendectomy', 'Post-operative care, antibiotics'),
(8, 'Pollen, Pet dander', 'All childhood vaccines current', 'Asthma, Seasonal allergies', 'Albuterol inhaler, allergy medication'),
(9, 'Aspirin, NSAIDs', 'Flu (2024), Pneumonia vaccine', 'Coronary artery disease, Hypertension', 'Blood thinners, beta blockers'),
(10, 'None known', 'Flu (2024), Shingles vaccine', 'Osteoarthritis - knees', 'Pain management, physical therapy'),
(11, 'Penicillin family', 'Flu (2024), COVID-19 booster (2024)', 'GERD, Mild hypertension', 'Omeprazole, lifestyle modifications'),
(12, 'None known', 'Flu (2024), All routine vaccines', 'Type 1 Diabetes', 'Insulin therapy, glucose monitoring'),
(13, 'Sulfa drugs', 'Flu (2024), Hepatitis B', 'High cholesterol, Pre-diabetes', 'Statin therapy, diet control'),
(14, 'None known', 'Age-appropriate vaccines complete', 'Childhood asthma', 'Rescue inhaler as needed'),
(15, 'None known', 'Flu (2024), COVID-19 (2023)', 'Atrial fibrillation, Hypertension', 'Blood thinners, rate control medication');

-- ============================================================
-- STAGE 19: Additional Care Plans
-- ============================================================

INSERT INTO CarePlan (patientID, diagnosis, treatmentPlan, startDate, endDate) VALUES
(6, 'Chronic Migraine Disorder', 'Trigger identification, preventive medication trial, stress management techniques. Monthly follow-ups.', DATE_SUB(NOW(), INTERVAL 30 DAY), DATE_ADD(NOW(), INTERVAL 150 DAY)),
(7, 'Post-Appendectomy Care', 'Wound care, antibiotic course completion, gradual activity increase. Follow-up in 2 weeks.', DATE_SUB(NOW(), INTERVAL 10 DAY), DATE_ADD(NOW(), INTERVAL 20 DAY)),
(8, 'Pediatric Asthma Management', 'Identify triggers, proper inhaler technique training, action plan for exacerbations. Quarterly reviews.', DATE_SUB(NOW(), INTERVAL 60 DAY), DATE_ADD(NOW(), INTERVAL 300 DAY)),
(9, 'Cardiac Disease Management', 'Medication adherence, cardiac rehab program, dietary modifications, stress reduction. Weekly monitoring initially.', DATE_SUB(NOW(), INTERVAL 5 DAY), DATE_ADD(NOW(), INTERVAL 175 DAY)),
(10, 'Pre-Surgical Preparation', 'Weight optimization, physical therapy, medication review, surgical risk assessment. Surgery in 6 weeks.', NOW(), DATE_ADD(NOW(), INTERVAL 60 DAY)),
(11, 'GERD and Hypertension Management', 'Dietary changes, weight loss program, medication optimization. Bi-monthly follow-ups.', DATE_SUB(NOW(), INTERVAL 90 DAY), DATE_ADD(NOW(), INTERVAL 270 DAY)),
(12, 'Type 1 Diabetes Control', 'Insulin pump training, continuous glucose monitoring, nutritional counseling. Weekly check-ins.', DATE_SUB(NOW(), INTERVAL 180 DAY), DATE_ADD(NOW(), INTERVAL 180 DAY)),
(15, 'Atrial Fibrillation Management', 'Rate control, anticoagulation monitoring, lifestyle modifications. Monthly INR checks.', DATE_SUB(NOW(), INTERVAL 45 DAY), DATE_ADD(NOW(), INTERVAL 315 DAY));

-- ============================================================
-- STAGE 20: Additional Pharmacy Stock (Low Stock Items)
-- ============================================================

INSERT INTO PharmacyStock (medicationID, batchNumber, quantity, expirationDate) VALUES
-- Low stock items for demo
(1, 'PAR20251101', 45, '2026-11-15'),   -- Low stock
(2, 'AMX20251102', 30, '2026-10-20'),   -- Critical low stock
(3, 'IBU20251103', 85, '2026-12-10'),   -- Low stock
(9, 'ALB20251109', 25, '2026-08-05'),   -- Critical low stock

-- Expiring soon items
(4, 'LIS20251104', 150, DATE_ADD(NOW(), INTERVAL 60 DAY)),  -- Expiring in 60 days
(5, 'MET20251105', 200, DATE_ADD(NOW(), INTERVAL 75 DAY)),  -- Expiring in 75 days
(7, 'OME20251107', 90, DATE_ADD(NOW(), INTERVAL 45 DAY));   -- Expiring in 45 days

-- ============================================================
-- STAGE 21: Additional Invoices (Unpaid and Pending)
-- ============================================================

-- Unpaid invoices
INSERT INTO Invoice (patientID, invoiceDate, totalAmount, amountPaid, status) VALUES
(6, DATE_SUB(NOW(), INTERVAL 2 DAY), 425.00, 0.00, 'Unpaid'),
(9, DATE_SUB(NOW(), INTERVAL 3 DAY), 1850.00, 0.00, 'Unpaid'),
(12, DATE_SUB(NOW(), INTERVAL 5 DAY), 320.00, 0.00, 'Unpaid');

INSERT INTO InvoiceItem (invoiceID, description, quantity, unitPrice) VALUES
-- Invoice for patient 6
(6, 'Complete Blood Count (CBC)', 1, 50.00),
(6, 'MRI Scan - Head', 1, 350.00),
(6, 'Ibuprofen Prescription', 30, 0.83),

-- Invoice for patient 9 (Emergency - high cost)
(7, 'Emergency Room Visit', 1, 750.00),
(7, 'Chest X-Ray', 1, 100.00),
(7, 'ECG', 1, 200.00),
(7, 'Blood Work Panel', 1, 150.00),
(7, 'Lipid Panel', 1, 75.00),
(7, 'IV Fluids and Medications', 1, 500.00),
(7, 'Emergency Physician Consultation', 1, 75.00),

-- Invoice for patient 12
(8, 'Diabetes Management Consultation', 1, 200.00),
(8, 'Blood Glucose Test', 1, 25.00),
(8, 'HbA1C Test', 1, 75.00),
(8, 'Metformin Prescription', 90, 0.22);

-- Pending invoices (partially paid)
INSERT INTO Invoice (patientID, invoiceDate, totalAmount, amountPaid, status) VALUES
(7, DATE_SUB(NOW(), INTERVAL 4 DAY), 650.00, 300.00, 'Pending'),
(10, DATE_SUB(NOW(), INTERVAL 6 DAY), 450.00, 200.00, 'Pending'),
(11, DATE_SUB(NOW(), INTERVAL 8 DAY), 275.00, 100.00, 'Pending');

INSERT INTO InvoiceItem (invoiceID, description, quantity, unitPrice) VALUES
-- Invoice for patient 7
(9, 'Post-Surgical Follow-up', 1, 150.00),
(9, 'Wound Care Supplies', 1, 50.00),
(9, 'Chest X-Ray', 1, 100.00),
(9, 'Amoxicillin Prescription', 42, 0.83),
(9, 'Pain Medication', 60, 5.00),

-- Invoice for patient 10
(10, 'Orthopedic Consultation', 1, 250.00),
(10, 'Knee X-Ray (bilateral)', 1, 150.00),
(10, 'Ibuprofen Prescription', 60, 0.83),

-- Invoice for patient 11
(11, 'Routine Physical Exam', 1, 150.00),
(11, 'Blood Glucose Test', 1, 25.00),
(11, 'Urinalysis', 1, 30.00),
(11, 'Omeprazole Prescription', 30, 2.33);

-- Paid invoices (recent)
INSERT INTO Invoice (patientID, invoiceDate, totalAmount, amountPaid, status) VALUES
(8, DATE_SUB(NOW(), INTERVAL 7 DAY), 180.00, 180.00, 'Paid'),
(13, DATE_SUB(NOW(), INTERVAL 9 DAY), 225.00, 225.00, 'Paid'),
(14, DATE_SUB(NOW(), INTERVAL 10 DAY), 125.00, 125.00, 'Paid');

INSERT INTO InvoiceItem (invoiceID, description, quantity, unitPrice) VALUES
-- Invoice for patient 8
(12, 'Pediatric Wellness Visit', 1, 100.00),
(12, 'Immunizations (2)', 2, 40.00),

-- Invoice for patient 13
(13, 'Pre-Surgical Consultation', 1, 200.00),
(13, 'Lab Work Panel', 1, 75.00),

-- Invoice for patient 14
(14, 'Allergy Testing', 1, 100.00),
(14, 'Paracetamol Prescription', 20, 1.25);

-- ============================================================
-- END OF SEED DATA
-- ============================================================
-- Summary of data:
-- - Departments: 9
-- - Rooms: 9
-- - Medications: 10
-- - Employees: 9
-- - Employee Extensions: 9 (various roles)
-- - Patients: 15
-- - Appointments: 23 (various statuses and priorities)
-- - Prescriptions: 15
-- - Lab Tests: 5
-- - Lab Results: 14 (various statuses)
-- - Medical History: 15
-- - Care Plans: 13
-- - Doctor Schedules: 9
-- - Pharmacy Stock: 17 (including low stock items)
-- - Invoices: 14 (Paid, Unpaid, Pending)
-- - Invoice Items: 35+
-- ============================================================
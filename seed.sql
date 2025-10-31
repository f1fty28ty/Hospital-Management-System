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
-- STAGE 4: Patients
-- ============================================================
-- Insert 5 patients with different primary doctors

INSERT INTO Patients (firstName, lastName, DOB, phone, homeAddress, emergencyContactName, emergencyContactPhone, primaryDoctorID) VALUES
('Michael', 'Brown', '1987-05-14', '555-1001', '987 Birch St', 'Laura Brown', '555-1002', 4),
('Sarah', 'Davis', '1993-08-07', '555-1003', '654 Spruce St', 'John Davis', '555-1004', 5),
('Robert', 'Wilson', '1975-12-20', '555-1005', '321 Oak Ave', 'Mary Wilson', '555-1006', 8),
('Jennifer', 'Martinez', '1998-03-15', '555-1007', '147 Pine Dr', 'Carlos Martinez', '555-1008', 4),
('William', 'Anderson', '1965-09-30', '555-1009', '258 Maple Ln', 'Susan Anderson', '555-1010', 5);

-- ============================================================
-- STAGE 5: Appointments
-- ============================================================

INSERT INTO Appointment (patientID, doctorID, appointmentDate, reason, status) VALUES
(1, 4, '2025-11-05 10:00:00', 'Annual checkup and X-ray', 'Scheduled'),
(2, 5, '2025-11-06 14:30:00', 'Pre-surgery consultation', 'Scheduled'),
(3, 8, '2025-11-07 09:00:00', 'ICU follow-up', 'Scheduled'),
(4, 4, '2025-11-08 11:00:00', 'Pediatric wellness exam', 'Completed'),
(5, 5, '2025-11-09 15:00:00', 'Post-operative follow-up', 'Completed');

-- ============================================================
-- STAGE 6: Prescriptions
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
-- STAGE 8: Lab Results
-- ============================================================

INSERT INTO LabResults (labTestID, patientID, resultDate, results, performedBy, status) VALUES
(1, 1, '2025-10-15 14:00:00', 'WBC: 7.5, RBC: 4.8, Hemoglobin: 14.2 - All values within normal range', 2, 'Completed'),
(2, 2, '2025-10-16 10:00:00', 'Chest clear, no abnormalities detected', 2, 'Completed'),
(3, 3, '2025-10-17 11:30:00', 'Total cholesterol: 185 mg/dL, HDL: 55, LDL: 110 - Within normal limits', 2, 'Completed'),
(4, 4, '2025-10-18 09:00:00', 'pH: 6.5, Specific gravity: 1.015, No abnormalities', 2, 'Completed'),
(5, 5, '2025-10-19 08:30:00', 'Fasting glucose: 95 mg/dL - Normal', 2, 'Completed');

-- ============================================================
-- STAGE 9: Medical History
-- ============================================================

INSERT INTO MedicalHistory (patientID, allergies, immunizations, diagnoses, treatments) VALUES
(1, 'Penicillin', 'Flu (2024), COVID-19 (2023), Hepatitis B', 'Hypertension, Seasonal allergies', 'Blood pressure medication, antihistamines'),
(2, 'None known', 'Flu (2024), MMR, Tdap', 'Appendicitis (resolved)', 'Appendectomy (2022)'),
(3, 'Sulfa drugs', 'Flu (2024), Pneumonia vaccine', 'Type 2 Diabetes, High cholesterol', 'Metformin, Atorvastatin'),
(4, 'None known', 'Flu (2024), COVID-19 (2023), Chickenpox', 'Asthma', 'Albuterol inhaler as needed'),
(5, 'Aspirin', 'Flu (2024), Shingles vaccine', 'Coronary artery disease', 'Stent placement (2020), ongoing medication');

-- ============================================================
-- STAGE 10: Care Plans
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
-- STAGE 12: Pharmacy Stock
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
-- STAGE 13: Invoices and Invoice Items
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
-- END OF SEED DATA
-- ============================================================

-- ============================================================
-- HOSPITAL MANAGEMENT SYSTEM - COMPLETE DEMO SCRIPT
-- DDL (Data Definition Language) and DML (Data Manipulation Language)
-- ============================================================

-- ============================================================
-- PART 1: DDL OPERATIONS (Data Definition Language)
-- ============================================================
-- DDL includes: CREATE, ALTER, DROP, TRUNCATE

-- ------------------------------------------------------------
-- 1. CREATE TABLE - Creating a new Audit Log table
-- ------------------------------------------------------------
CREATE TABLE AuditLog (
    auditID INT PRIMARY KEY AUTO_INCREMENT,
    tableName VARCHAR(50) NOT NULL,
    operation ENUM('INSERT', 'UPDATE', 'DELETE') NOT NULL,
    recordID INT,
    performedBy INT,
    performedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    details TEXT,
    FOREIGN KEY (performedBy) REFERENCES Employee(employeeID)
);

-- ------------------------------------------------------------
-- 2. ALTER TABLE - Adding new columns to existing tables
-- ------------------------------------------------------------
-- Add email column to Patients table
ALTER TABLE Patients 
ADD COLUMN email VARCHAR(100);

-- Add certification column to Doctor table
ALTER TABLE Doctor 
ADD COLUMN certificationNumber VARCHAR(50) UNIQUE;

-- Add priority level to Appointment table
ALTER TABLE Appointment 
ADD COLUMN priority ENUM('Low', 'Medium', 'High', 'Emergency') DEFAULT 'Medium';

-- ------------------------------------------------------------
-- 3. CREATE INDEX - Improving query performance
-- ------------------------------------------------------------
-- Index on patient names for faster searches
CREATE INDEX idx_patient_name ON Patients(lastName, firstName);

-- Index on appointment dates for scheduling queries
CREATE INDEX idx_appointment_date ON Appointment(appointmentDate);

-- Index on invoice status for billing reports
CREATE INDEX idx_invoice_status ON Invoice(status);

-- ------------------------------------------------------------
-- 4. CREATE VIEW - Creating useful database views
-- ------------------------------------------------------------
-- View for active appointments with patient and doctor details
CREATE VIEW ActiveAppointments AS
SELECT 
    a.appointmentID,
    a.appointmentDate,
    a.reason,
    a.status,
    a.priority,
    CONCAT(p.firstName, ' ', p.lastName) AS patientName,
    p.phone AS patientPhone,
    CONCAT(e.firstName, ' ', e.lastName) AS doctorName,
    d.specialization
FROM Appointment a
JOIN Patients p ON a.patientID = p.patientID
JOIN Employee e ON a.doctorID = e.employeeID
JOIN Doctor d ON a.doctorID = d.doctorID
WHERE a.status = 'Scheduled';

-- View for patient billing summary
CREATE VIEW PatientBillingSummary AS
SELECT 
    p.patientID,
    CONCAT(p.firstName, ' ', p.lastName) AS patientName,
    COUNT(i.invoiceID) AS totalInvoices,
    SUM(i.totalAmount) AS totalBilled,
    SUM(i.amountPaid) AS totalPaid,
    SUM(i.totalAmount - i.amountPaid) AS outstandingBalance
FROM Patients p
LEFT JOIN Invoice i ON p.patientID = i.patientID
GROUP BY p.patientID, p.firstName, p.lastName;

-- View for department staff roster
CREATE VIEW DepartmentStaffRoster AS
SELECT 
    d.departmentID,
    d.departmentName,
    d.location,
    COUNT(e.employeeID) AS staffCount,
    CONCAT(e.firstName, ' ', e.lastName) AS staffMember,
    e.position,
    e.salary
FROM Department d
LEFT JOIN Employee e ON d.departmentID = e.departmentID
GROUP BY d.departmentID, d.departmentName, d.location, e.employeeID, 
         e.firstName, e.lastName, e.position, e.salary;

-- ------------------------------------------------------------
-- 5. DROP and TRUNCATE examples (commented for safety)
-- ------------------------------------------------------------
-- DROP TABLE example (removes table structure and data)
-- DROP TABLE IF EXISTS AuditLog;

-- TRUNCATE TABLE example (removes all data but keeps structure)
-- TRUNCATE TABLE AuditLog;

-- ALTER TABLE DROP COLUMN example
-- ALTER TABLE Patients DROP COLUMN email;


-- ============================================================
-- PART 2: DML OPERATIONS (Data Manipulation Language)
-- ============================================================
-- DML includes: INSERT, UPDATE, DELETE, SELECT

-- ------------------------------------------------------------
-- 1. INSERT - Adding new records
-- ------------------------------------------------------------
-- Insert a new patient
INSERT INTO Patients (firstName, lastName, DOB, phone, homeAddress, 
                      emergencyContactName, emergencyContactPhone, 
                      primaryDoctorID, email)
VALUES ('Emma', 'Thompson', '1992-06-15', '555-2001', 
        '789 Cedar St', 'James Thompson', '555-2002', 4, 
        'emma.thompson@email.com');

-- Insert a new appointment
INSERT INTO Appointment (patientID, doctorID, appointmentDate, 
                        reason, status, priority)
VALUES (6, 5, '2025-11-25 10:30:00', 
        'Surgery consultation for gallbladder removal', 
        'Scheduled', 'High');

-- Insert a new medication
INSERT INTO Medications (medicationName, description, dosage, sideEffects)
VALUES ('Ciprofloxacin', 'Antibiotic for various bacterial infections', 
        '500mg twice daily', 'Nausea, dizziness, diarrhea');

-- ------------------------------------------------------------
-- 2. UPDATE - Modifying existing records
-- ------------------------------------------------------------
-- Update patient contact information
UPDATE Patients
SET phone = '555-2010', 
    email = 'emma.t@newemail.com'
WHERE patientID = 6;

-- Update appointment status
UPDATE Appointment
SET status = 'Completed'
WHERE appointmentID = 1 AND appointmentDate < NOW();

-- Update pharmacy stock after dispensing medication
UPDATE PharmacyStock
SET quantity = quantity - 30
WHERE medicationID = 2 AND quantity >= 30;

-- Update employee salary (annual raise)
UPDATE Employee
SET salary = salary * 1.05
WHERE departmentID = 2 AND dateHired < '2020-01-01';

-- Mark invoice as paid
UPDATE Invoice
SET status = 'Paid',
    amountPaid = totalAmount
WHERE invoiceID = 4;

-- ------------------------------------------------------------
-- 3. DELETE - Removing records
-- ------------------------------------------------------------
-- Delete a cancelled appointment
DELETE FROM Appointment
WHERE appointmentID = 5 AND status = 'Cancelled';

-- Delete expired medications from pharmacy stock
DELETE FROM PharmacyStock
WHERE expirationDate < CURDATE();

-- Delete old audit log entries (older than 1 year)
-- DELETE FROM AuditLog
-- WHERE performedAt < DATE_SUB(NOW(), INTERVAL 1 YEAR);

-- ------------------------------------------------------------
-- 4. SELECT - Querying data (Basic to Advanced)
-- ------------------------------------------------------------

-- Basic SELECT: List all patients
SELECT patientID, firstName, lastName, phone, DOB
FROM Patients
ORDER BY lastName, firstName;

-- SELECT with WHERE: Find patients of a specific doctor
SELECT CONCAT(firstName, ' ', lastName) AS patientName,
       phone, homeAddress
FROM Patients
WHERE primaryDoctorID = 4;

-- SELECT with JOIN: Appointments with patient and doctor info
SELECT 
    a.appointmentID,
    a.appointmentDate,
    CONCAT(p.firstName, ' ', p.lastName) AS patient,
    CONCAT(e.firstName, ' ', e.lastName) AS doctor,
    a.reason,
    a.status
FROM Appointment a
JOIN Patients p ON a.patientID = p.patientID
JOIN Employee e ON a.doctorID = e.employeeID
WHERE a.status = 'Scheduled'
ORDER BY a.appointmentDate;

-- SELECT with AGGREGATE: Department employee count and salary totals
SELECT 
    d.departmentName,
    COUNT(e.employeeID) AS employeeCount,
    AVG(e.salary) AS avgSalary,
    SUM(e.salary) AS totalPayroll
FROM Department d
LEFT JOIN Employee e ON d.departmentID = e.departmentID
GROUP BY d.departmentID, d.departmentName
ORDER BY totalPayroll DESC;

-- SELECT with SUBQUERY: Patients with outstanding balances
SELECT 
    p.patientID,
    CONCAT(p.firstName, ' ', p.lastName) AS patientName,
    p.phone,
    (SELECT SUM(totalAmount - amountPaid)
     FROM Invoice
     WHERE patientID = p.patientID) AS outstandingBalance
FROM Patients p
WHERE EXISTS (
    SELECT 1 
    FROM Invoice i
    WHERE i.patientID = p.patientID 
    AND i.totalAmount > i.amountPaid
)
ORDER BY outstandingBalance DESC;

-- COMPLEX JOIN: Complete patient medical overview
SELECT 
    p.patientID,
    CONCAT(p.firstName, ' ', p.lastName) AS patientName,
    p.DOB,
    CONCAT(doc.firstName, ' ', doc.lastName) AS primaryDoctor,
    COUNT(DISTINCT a.appointmentID) AS totalAppointments,
    COUNT(DISTINCT pr.prescriptionID) AS totalPrescriptions,
    COUNT(DISTINCT lr.resultID) AS totalLabTests,
    SUM(i.totalAmount) AS totalBilled,
    SUM(i.amountPaid) AS totalPaid
FROM Patients p
LEFT JOIN Employee doc ON p.primaryDoctorID = doc.employeeID
LEFT JOIN Appointment a ON p.patientID = a.patientID
LEFT JOIN Prescriptions pr ON p.patientID = pr.patientID
LEFT JOIN LabResults lr ON p.patientID = lr.patientID
LEFT JOIN Invoice i ON p.patientID = i.patientID
GROUP BY p.patientID, p.firstName, p.lastName, p.DOB, 
         doc.firstName, doc.lastName;

-- SELECT with CASE: Appointment urgency report
SELECT 
    appointmentID,
    appointmentDate,
    CONCAT(p.firstName, ' ', p.lastName) AS patient,
    reason,
    priority,
    CASE 
        WHEN priority = 'Emergency' THEN 'URGENT - Immediate attention'
        WHEN priority = 'High' THEN 'High priority - Today'
        WHEN priority = 'Medium' THEN 'Normal scheduling'
        ELSE 'Low priority - Can reschedule'
    END AS urgencyLevel,
    CASE
        WHEN appointmentDate < NOW() THEN 'OVERDUE'
        WHEN appointmentDate < DATE_ADD(NOW(), INTERVAL 1 DAY) THEN 'TODAY'
        WHEN appointmentDate < DATE_ADD(NOW(), INTERVAL 7 DAY) THEN 'THIS WEEK'
        ELSE 'FUTURE'
    END AS timing
FROM Appointment a
JOIN Patients p ON a.patientID = p.patientID
WHERE status = 'Scheduled'
ORDER BY 
    CASE priority
        WHEN 'Emergency' THEN 1
        WHEN 'High' THEN 2
        WHEN 'Medium' THEN 3
        ELSE 4
    END,
    appointmentDate;

-- ------------------------------------------------------------
-- 5. TRANSACTIONS - Ensuring data consistency
-- ------------------------------------------------------------
-- Example: Complete patient discharge process
START TRANSACTION;

-- Update appointment status
UPDATE Appointment
SET status = 'Completed'
WHERE appointmentID = 2;

-- Create final invoice
INSERT INTO Invoice (patientID, invoiceDate, totalAmount, amountPaid, status)
SELECT patientID, NOW(), 500.00, 0.00, 'Unpaid'
FROM Appointment
WHERE appointmentID = 2;

-- Add invoice items
INSERT INTO InvoiceItem (invoiceID, description, quantity, unitPrice)
VALUES 
    (LAST_INSERT_ID(), 'Surgery consultation', 1, 300.00),
    (LAST_INSERT_ID(), 'Lab tests', 1, 150.00),
    (LAST_INSERT_ID(), 'Medications', 1, 50.00);

-- Log the discharge
INSERT INTO AuditLog (tableName, operation, recordID, performedBy, details)
VALUES ('Appointment', 'UPDATE', 2, 9, 'Patient discharge completed');

COMMIT;

-- ============================================================
-- DEMONSTRATION QUERIES FOR PRESENTATION
-- ============================================================

-- Query 1: Today's appointment schedule
SELECT 
    TIME(appointmentDate) AS time,
    CONCAT(p.firstName, ' ', p.lastName) AS patient,
    CONCAT(e.firstName, ' ', e.lastName) AS doctor,
    d.specialization,
    a.reason,
    a.priority
FROM Appointment a
JOIN Patients p ON a.patientID = p.patientID
JOIN Employee e ON a.doctorID = e.employeeID
JOIN Doctor d ON a.doctorID = d.doctorID
WHERE DATE(appointmentDate) = CURDATE()
  AND status = 'Scheduled'
ORDER BY appointmentDate;

-- Query 2: Pharmacy inventory low stock alert
SELECT 
    m.medicationName,
    ps.quantity,
    ps.expirationDate,
    DATEDIFF(ps.expirationDate, CURDATE()) AS daysUntilExpiry,
    CASE
        WHEN ps.quantity < 50 THEN 'CRITICAL - Reorder immediately'
        WHEN ps.quantity < 100 THEN 'LOW - Reorder soon'
        ELSE 'Adequate stock'
    END AS stockStatus
FROM PharmacyStock ps
JOIN Medications m ON ps.medicationID = m.medicationID
WHERE ps.quantity < 150
   OR ps.expirationDate < DATE_ADD(CURDATE(), INTERVAL 90 DAY)
ORDER BY ps.quantity, ps.expirationDate;

-- Query 3: Revenue report by department
SELECT 
    d.departmentName,
    COUNT(DISTINCT a.appointmentID) AS appointments,
    COUNT(DISTINCT i.invoiceID) AS invoices,
    SUM(i.totalAmount) AS revenue,
    SUM(i.amountPaid) AS collected,
    SUM(i.totalAmount - i.amountPaid) AS outstanding
FROM Department d
JOIN Employee e ON d.departmentID = e.departmentID
JOIN Appointment a ON e.employeeID = a.doctorID
JOIN Invoice i ON a.patientID = i.patientID
GROUP BY d.departmentID, d.departmentName
ORDER BY revenue DESC;

-- ============================================================
-- END OF DEMO SCRIPT
-- ============================================================
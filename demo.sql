-- ============================================================
-- HOSPITAL MANAGEMENT SYSTEM - DEMO SCRIPT
-- DDL (Data Definition Language) and DML (Data Manipulation Language)
-- ============================================================

-- ============================================================
-- PART 1: DDL OPERATIONS (Data Definition Language)
-- ============================================================

-- ------------------------------------------------------------
-- DDL 1: CREATE TABLE - AuditLog for compliance tracking
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

-- Verify table creation
DESCRIBE AuditLog;

-- ------------------------------------------------------------
-- DDL 2: ALTER TABLE - Add priority to appointments for triage
-- ------------------------------------------------------------
ALTER TABLE Appointment 
ADD COLUMN priority ENUM('Low', 'Medium', 'High', 'Emergency') DEFAULT 'Medium';

-- Verify the column was added
DESCRIBE Appointment;

-- See appointments now have priority column (currently NULL or default)
SELECT appointmentID, appointmentDate, reason, priority 
FROM Appointment 
LIMIT 5;

-- ------------------------------------------------------------
-- DDL 3: CREATE INDEX - Speed up patient name searches
-- ------------------------------------------------------------
CREATE INDEX idx_patient_name ON Patients(lastName, firstName);

-- Verify index creation
SHOW INDEX FROM Patients WHERE Key_name = 'idx_patient_name';

-- Test the index with a search query
SELECT firstName, lastName, phone 
FROM Patients 
WHERE lastName LIKE 'B%' 
ORDER BY lastName, firstName;

-- ------------------------------------------------------------
-- DDL 4: CREATE VIEW - Simplify complex appointment queries
-- ------------------------------------------------------------
CREATE VIEW ActiveAppointments AS
SELECT 
    a.appointmentID,
    DATE_FORMAT(a.appointmentDate, '%Y-%m-%d %H:%i') AS appointmentTime,
    CONCAT(p.firstName, ' ', p.lastName) AS patientName,
    p.phone AS patientPhone,
    CONCAT(e.firstName, ' ', e.lastName) AS doctorName,
    d.specialization,
    a.reason,
    a.priority
FROM Appointment a
JOIN Patients p ON a.patientID = p.patientID
JOIN Employee e ON a.doctorID = e.employeeID
JOIN Doctor d ON a.doctorID = d.doctorID
WHERE a.status = 'Scheduled';

-- Show the view in action - much simpler than writing the full query!
SELECT * FROM ActiveAppointments LIMIT 5;


-- ============================================================
-- PART 2: DML OPERATIONS (Data Manipulation Language)
-- ============================================================

-- ------------------------------------------------------------
-- DML 1: INSERT - Register new patient
-- ------------------------------------------------------------
INSERT INTO Patients (firstName, lastName, DOB, phone, homeAddress, 
                      emergencyContactName, emergencyContactPhone, 
                      primaryDoctorID, email)
VALUES ('John', 'Smith', '1985-03-20', '555-9999', 
        '100 Main St', 'Jane Smith', '555-9998', 4, 
        'john.smith@email.com');

-- View the newly inserted patient
SELECT patientID, firstName, lastName, phone, email, primaryDoctorID
FROM Patients 
WHERE patientID = LAST_INSERT_ID();

-- ------------------------------------------------------------
-- DML 2: UPDATE - Update pharmacy inventory
-- ------------------------------------------------------------
-- Check current stock before update
SELECT medicationID, m.medicationName, ps.quantity, ps.batchNumber
FROM PharmacyStock ps
JOIN Medications m ON ps.medicationID = m.medicationID
WHERE ps.medicationID = 1;

-- Dispense 10 units of medication
UPDATE PharmacyStock
SET quantity = quantity - 10
WHERE medicationID = 1 AND stockID = 1;

-- View the updated stock level
SELECT medicationID, m.medicationName, ps.quantity, ps.batchNumber
FROM PharmacyStock ps
JOIN Medications m ON ps.medicationID = m.medicationID
WHERE ps.medicationID = 1;

-- ------------------------------------------------------------
-- DML 3: DELETE - Remove expired medications
-- ------------------------------------------------------------
-- See expired items before deletion
SELECT ps.stockID, m.medicationName, ps.expirationDate, ps.quantity
FROM PharmacyStock ps
JOIN Medications m ON ps.medicationID = m.medicationID
WHERE ps.expirationDate < CURDATE();

-- Delete expired medications
DELETE FROM PharmacyStock
WHERE expirationDate < CURDATE();

-- Verify deletion (should return no rows)
SELECT COUNT(*) AS expiredItemsRemaining
FROM PharmacyStock
WHERE expirationDate < CURDATE();

-- ------------------------------------------------------------
-- DML 4: SELECT (Basic) - Patient lookup with doctor
-- ------------------------------------------------------------
SELECT 
    p.patientID,
    CONCAT(p.firstName, ' ', p.lastName) AS patientName,
    p.phone,
    p.email,
    CONCAT(e.firstName, ' ', e.lastName) AS primaryDoctor,
    d.specialization
FROM Patients p
LEFT JOIN Employee e ON p.primaryDoctorID = e.employeeID
LEFT JOIN Doctor d ON p.primaryDoctorID = d.doctorID
ORDER BY p.lastName, p.firstName
LIMIT 10;

-- ------------------------------------------------------------
-- DML 5: SELECT (Advanced) - Department payroll analysis
-- ------------------------------------------------------------
SELECT 
    d.departmentName,
    d.location,
    COUNT(e.employeeID) AS staffCount,
    ROUND(AVG(e.salary), 2) AS avgSalary,
    ROUND(SUM(e.salary), 2) AS totalPayroll
FROM Department d
LEFT JOIN Employee e ON d.departmentID = e.departmentID
GROUP BY d.departmentID, d.departmentName, d.location
ORDER BY totalPayroll DESC;

-- ------------------------------------------------------------
-- DML 6: TRANSACTION - Complete patient discharge process
-- ------------------------------------------------------------
START TRANSACTION;

-- Step 1: Update appointment status
UPDATE Appointment
SET status = 'Completed'
WHERE appointmentID = 2;

-- Check the update
SELECT appointmentID, patientID, status 
FROM Appointment 
WHERE appointmentID = 2;

-- Step 2: Create discharge invoice
INSERT INTO Invoice (patientID, invoiceDate, totalAmount, amountPaid, status)
SELECT patientID, NOW(), 500.00, 0.00, 'Unpaid'
FROM Appointment
WHERE appointmentID = 2;

SET @new_invoice = LAST_INSERT_ID();

-- Step 3: Add invoice line items
INSERT INTO InvoiceItem (invoiceID, description, quantity, unitPrice)
VALUES 
    (@new_invoice, 'Surgery consultation', 1, 300.00),
    (@new_invoice, 'Lab tests', 1, 150.00),
    (@new_invoice, 'Medications', 1, 50.00);

-- View the new invoice
SELECT * FROM Invoice WHERE invoiceID = @new_invoice;
SELECT * FROM InvoiceItem WHERE invoiceID = @new_invoice;

-- Step 4: Log the discharge in audit table
INSERT INTO AuditLog (tableName, operation, recordID, performedBy, details)
VALUES ('Appointment', 'UPDATE', 2, 9, 'Patient discharge completed with invoice');

-- View the audit log entry
SELECT * FROM AuditLog WHERE auditID = LAST_INSERT_ID();

-- Commit all changes as a single unit
COMMIT;


-- ============================================================
-- BONUS: DEMONSTRATION QUERIES (Real-World Use Cases)
-- ============================================================

-- Query 1: Today's appointments prioritized by urgency
SELECT 
    TIME(appointmentDate) AS time,
    CONCAT(p.firstName, ' ', p.lastName) AS patient,
    p.phone,
    CONCAT(e.firstName, ' ', e.lastName) AS doctor,
    a.priority,
    a.reason
FROM Appointment a
JOIN Patients p ON a.patientID = p.patientID
JOIN Employee e ON a.doctorID = e.employeeID
WHERE DATE(appointmentDate) = CURDATE()
  AND status = 'Scheduled'
ORDER BY 
    CASE a.priority
        WHEN 'Emergency' THEN 1
        WHEN 'High' THEN 2
        WHEN 'Medium' THEN 3
        ELSE 4
    END,
    appointmentDate;

-- Query 2: Low stock pharmacy alert
SELECT 
    m.medicationName,
    ps.quantity,
    ps.expirationDate,
    DATEDIFF(ps.expirationDate, CURDATE()) AS daysUntilExpiry,
    CASE
        WHEN ps.quantity < 50 THEN 'CRITICAL'
        WHEN ps.quantity < 100 THEN 'LOW'
        ELSE 'Reorder Soon'
    END AS stockStatus
FROM PharmacyStock ps
JOIN Medications m ON ps.medicationID = m.medicationID
WHERE ps.quantity < 150
   OR ps.expirationDate < DATE_ADD(CURDATE(), INTERVAL 90 DAY)
ORDER BY ps.quantity, ps.expirationDate;

-- Query 3: Patients with outstanding balances
SELECT 
    p.patientID,
    CONCAT(p.firstName, ' ', p.lastName) AS patientName,
    p.phone,
    SUM(i.totalAmount - i.amountPaid) AS outstandingBalance
FROM Patients p
JOIN Invoice i ON p.patientID = i.patientID
WHERE i.totalAmount > i.amountPaid
GROUP BY p.patientID, p.firstName, p.lastName, p.phone
ORDER BY outstandingBalance DESC;

-- ============================================================
-- END OF DEMO SCRIPT
-- ============================================================
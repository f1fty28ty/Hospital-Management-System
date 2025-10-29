-- MySQL Compatible Schema for Hospital Management System
-- link to table styling https://docs.google.com/spreadsheets/d/1RDEdzJzPHG6E3xWMCGLrQ5HLsfqTBaq5zk_CzEpqZ2w/edit?usp=sharing

USE hospital_db;

/* ============================================================
   Core Entities
   ============================================================ */
CREATE TABLE Department(
    departmentID INT PRIMARY KEY AUTO_INCREMENT,
    departmentName ENUM('Front Desk', 'Laboratory', 'Pharmacy', 'Radiology', 'Surgery', 'Pediatrics', 'Maternity', 'ICU', 'General'),
    location VARCHAR(100)
);

CREATE TABLE Room(
    roomID INT PRIMARY KEY AUTO_INCREMENT,
    roomNumber CHAR(3),
    type ENUM('General', 'ICU', 'Surgery', 'Maternity', 'Pediatric', 'Private'),
    status ENUM('Available', 'Occupied', 'Under Maintenance'),
    departmentID INT,
    FOREIGN KEY (departmentID) REFERENCES Department(departmentID)
);

CREATE TABLE Employee(
    employeeID INT PRIMARY KEY AUTO_INCREMENT,
    firstName VARCHAR(100),
    lastName VARCHAR(100),
    DOB DATE,
    phone VARCHAR(15),
    homeAddress VARCHAR(255),
    position ENUM('Doctor', 'Nurse', 'Lab Technician', 'Receptionist', 'Pharmacist', 'Administrative Staff', 'Janitorial Staff', 'Security Staff', 'Maintenance Staff', 'Human Resources Staff', 'IT Staff'),
    departmentID INT,
    dateHired DATE,
    salary DECIMAL(10, 2),
    FOREIGN KEY (departmentID) REFERENCES Department(departmentID)
);

CREATE TABLE Medications(
    medicationID INT PRIMARY KEY AUTO_INCREMENT,
    medicationName VARCHAR(100),
    description TEXT,
    dosage VARCHAR(50),
    sideEffects TEXT
);

/* ============================================================
   Facility
   ============================================================ */
-- Doctors (extension of Employee)
CREATE TABLE Doctor(
    doctorID INT PRIMARY KEY,
    roomID INT,
    payScale DECIMAL(10, 2),
    specialization VARCHAR(100),
    FOREIGN KEY (doctorID) REFERENCES Employee(employeeID),
    FOREIGN KEY (roomID) REFERENCES Room(roomID)
);

-- Nurses (extension of Employee)
CREATE TABLE Nurse(
    nurseID INT PRIMARY KEY,
    departmentID INT,
    FOREIGN KEY (nurseID) REFERENCES Employee(employeeID),
    FOREIGN KEY (departmentID) REFERENCES Department(departmentID)
);

-- Lab Technicians (extension of Employee)
CREATE TABLE LabTechnician(
    labTechnicianID INT PRIMARY KEY,
    departmentID INT,
    FOREIGN KEY (labTechnicianID) REFERENCES Employee(employeeID),
    FOREIGN KEY (departmentID) REFERENCES Department(departmentID)
);

-- Receptionists (extension of Employee)
CREATE TABLE Receptionist(
    receptionistID INT PRIMARY KEY,
    departmentID INT,
    FOREIGN KEY (receptionistID) REFERENCES Employee(employeeID),
    FOREIGN KEY (departmentID) REFERENCES Department(departmentID)
);

-- Pharmacists (extension of Employee)
CREATE TABLE Pharmacist(
    pharmacistID INT PRIMARY KEY,
    departmentID INT,
    FOREIGN KEY (pharmacistID) REFERENCES Employee(employeeID),
    FOREIGN KEY (departmentID) REFERENCES Department(departmentID)
);

-- Administrative Staff (extension of Employee)
CREATE TABLE AdministrativeStaff(
    administrativeStaffID INT PRIMARY KEY,
    departmentID INT,
    FOREIGN KEY (administrativeStaffID) REFERENCES Employee(employeeID),
    FOREIGN KEY (departmentID) REFERENCES Department(departmentID)
);

-- Janitorial Staff (extension of Employee)
CREATE TABLE JanitorialStaff(
    janitorialStaffID INT PRIMARY KEY,
    departmentID INT,
    FOREIGN KEY (janitorialStaffID) REFERENCES Employee(employeeID),
    FOREIGN KEY (departmentID) REFERENCES Department(departmentID)
);

-- Security Staff (extension of Employee)
CREATE TABLE SecurityStaff(
    securityStaffID INT PRIMARY KEY,
    departmentID INT,
    FOREIGN KEY (securityStaffID) REFERENCES Employee(employeeID),
    FOREIGN KEY (departmentID) REFERENCES Department(departmentID)
);

-- Maintenance Staff (extension of Employee)
CREATE TABLE MaintenanceStaff(
    maintenanceStaffID INT PRIMARY KEY,
    departmentID INT,
    FOREIGN KEY (maintenanceStaffID) REFERENCES Employee(employeeID),
    FOREIGN KEY (departmentID) REFERENCES Department(departmentID)
);

-- Human Resources Staff (extension of Employee)
CREATE TABLE HumanResourcesStaff(
    humanResourcesStaffID INT PRIMARY KEY,
    departmentID INT,
    FOREIGN KEY (humanResourcesStaffID) REFERENCES Employee(employeeID),
    FOREIGN KEY (departmentID) REFERENCES Department(departmentID)
);

-- IT Staff (extension of Employee)
CREATE TABLE ITStaff(
    itStaffID INT PRIMARY KEY,
    departmentID INT,
    FOREIGN KEY (itStaffID) REFERENCES Employee(employeeID),
    FOREIGN KEY (departmentID) REFERENCES Department(departmentID)
);

/* ============================================================
   Patients
   ============================================================ */
CREATE TABLE Patients(
    patientID INT PRIMARY KEY AUTO_INCREMENT,
    firstName VARCHAR(100),
    lastName VARCHAR(100),
    DOB DATE,
    phone VARCHAR(15),
    homeAddress VARCHAR(255),
    emergencyContactName VARCHAR(100),
    emergencyContactPhone VARCHAR(15),
    primaryDoctorID INT,
    dateCreated TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (primaryDoctorID) REFERENCES Doctor(doctorID)
);

CREATE TABLE Appointment(
    appointmentID INT PRIMARY KEY AUTO_INCREMENT,
    patientID INT,
    doctorID INT,
    appointmentDate TIMESTAMP,
    reason VARCHAR(255),
    status ENUM('Scheduled', 'Completed', 'Cancelled'),
    FOREIGN KEY (patientID) REFERENCES Patients(patientID),
    FOREIGN KEY (doctorID) REFERENCES Employee(employeeID)
);

CREATE TABLE Prescriptions(
    prescriptionID INT PRIMARY KEY AUTO_INCREMENT,
    patientID INT,
    doctorID INT,
    medicationID INT,
    actions TEXT,
    FOREIGN KEY (patientID) REFERENCES Patients(patientID),
    FOREIGN KEY (doctorID) REFERENCES Employee(employeeID),
    FOREIGN KEY (medicationID) REFERENCES Medications(medicationID)
);

CREATE TABLE LabTests(
    testID INT PRIMARY KEY AUTO_INCREMENT,
    testName VARCHAR(100),
    description TEXT,
    cost DECIMAL(10, 2),
    startDate DATE,
    endDate DATE
);

CREATE TABLE LabResults(
    resultID INT PRIMARY KEY AUTO_INCREMENT,
    labTestID INT,
    patientID INT,
    resultDate TIMESTAMP,
    results TEXT,
    performedBy INT,
    status ENUM('Pending', 'In Progress', 'Completed'),
    FOREIGN KEY (labTestID) REFERENCES LabTests(testID),
    FOREIGN KEY (patientID) REFERENCES Patients(patientID),
    FOREIGN KEY (performedBy) REFERENCES Employee(employeeID)
);

CREATE TABLE MedicalHistory(
    historyID INT PRIMARY KEY AUTO_INCREMENT,
    patientID INT,
    allergies TEXT,
    immunizations TEXT,
    diagnoses TEXT,
    treatments TEXT,
    FOREIGN KEY (patientID) REFERENCES Patients(patientID)
);

/* ============================================================
   Scheduling
   ============================================================ */
CREATE TABLE CarePlan(
    carePlanID INT PRIMARY KEY AUTO_INCREMENT,
    patientID INT,
    diagnosis VARCHAR(255),
    treatmentPlan TEXT,
    startDate DATE,
    endDate DATE,
    FOREIGN KEY (patientID) REFERENCES Patients(patientID)
);

CREATE TABLE DoctorSchedule(
    scheduleID INT PRIMARY KEY AUTO_INCREMENT,
    doctorID INT,
    dayOfWeek VARCHAR(10),
    startTime TIMESTAMP,
    endTime TIMESTAMP,
    FOREIGN KEY (doctorID) REFERENCES Employee(employeeID)
);

/* ============================================================
   Pharmacy
   ============================================================ */
CREATE TABLE PharmacyStock(
    stockID INT PRIMARY KEY AUTO_INCREMENT,
    medicationID INT,
    batchNumber VARCHAR(50),
    quantity INT,
    expirationDate DATE,
    FOREIGN KEY (medicationID) REFERENCES Medications(medicationID)
);

/* ============================================================
   Billing
   ============================================================ */
CREATE TABLE Invoice(
    invoiceID INT PRIMARY KEY AUTO_INCREMENT,
    patientID INT,
    invoiceDate TIMESTAMP,
    totalAmount DECIMAL(10, 2),
    amountPaid DECIMAL(10, 2),
    status ENUM('Paid', 'Unpaid', 'Pending'),
    FOREIGN KEY (patientID) REFERENCES Patients(patientID)
);

CREATE TABLE InvoiceItem(
    itemID INT PRIMARY KEY AUTO_INCREMENT,
    invoiceID INT,
    description TEXT,
    quantity DECIMAL(10, 2),
    unitPrice DECIMAL(10, 2),
    FOREIGN KEY (invoiceID) REFERENCES Invoice(invoiceID)
);

-- TODO: Insurance, Payments


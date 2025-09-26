-- link to table styling https://docs.google.com/spreadsheets/d/1RDEdzJzPHG6E3xWMCGLrQ5HLsfqTBaq5zk_CzEpqZ2w/edit?usp=sharing
/* ============================================================
   Core Entities
   ============================================================ */
CREATE TABLE Patients(
    patientID INT PRIMARY KEY,
    firstName VARCHAR(100),
    lastName VARCHAR(100),
    DOB DATE,
    phone VARCHAR(15) CHECK (phone LIKE '+%[0-9]%'),
    homeAddress VARCHAR(255),
    emergencyContactName VARCHAR(100),
    emergencyContactPhone VARCHAR(15),
    primaryDoctorID INT,
    dateCreated DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (primaryDoctorID) REFERENCES Doctor(doctorID)
);
CREATE TABLE Employee(
    employeeID INT PRIMARY KEY,
    firstName VARCHAR(100),
    lastName VARCHAR(100),
    DOB DATE,
    phone VARCHAR(15) CHECK (phone LIKE '+%[0-9]%'),
    homeAddress VARCHAR(255),
    position ENUM('Doctor', 'Nurse', 'Lab Technician', 'Receptionist', 'Pharmacist', 'Administrative Staff', 'Janitorial Staff', 'Security Staff', 'Maintenance Staff', 'Human Resources Staff', 'IT Staff'),
    departmentID INT,
    dateHired DATE,
    salary DECIMAL(10, 2),
    FOREIGN KEY (departmentID) REFERENCES Department(departmentID)
);
CREATE TABLE Department(
    departmentID INT PRIMARY KEY,
    departmentName VARCHAR(100),
    location VARCHAR(100),
);
/* ============================================================
    Facilities
   ============================================================ */
CREATE TABLE Room(
    roomID INT PRIMARY KEY,
    roomNumber char(3),
    type ENUM('General', 'ICU', 'Surgery', 'Maternity', 'Pediatric', 'Private'),
    status ENUM('Available', 'Occupied', 'Under Maintenance'),
    departmentID INT,
    FOREIGN KEY (departmentID) REFERENCES Department(departmentID)
);

/* ============================================================
   Scheduling
   ============================================================ */
CREATE TABLE Appointment(
    appointmentID INT PRIMARY KEY,
    patientID INT,
    doctorID INT,
    appointmentDate DATETIME,
    reason VARCHAR(255),
    status ENUM('Scheduled', 'Completed', 'Cancelled'),
    FOREIGN KEY (patientID) REFERENCES Patients(patientID),
    FOREIGN KEY (doctorID) REFERENCES Employee(employeeID)
);
CREATE TABLE CarePlan(
    carePlanID INT PRIMARY KEY,
    patientID INT,
    diagnosis VARCHAR(255),
    treatmentPlan TEXT,
    startDate DATE,
    endDate DATE,
    FOREIGN KEY (patientID) REFERENCES Patients(patientID)
);
CREATE TABLE DoctorSchedule(
    scheduleID INT PRIMARY KEY,
    doctorID INT,
    dayOfWeek ENUM('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'),
    startTime DATETIME,
    endTime DATETIME,
    FOREIGN KEY (doctorID) REFERENCES Employee(employeeID)
);
/* ============================================================
    Pharmacy
   ============================================================ */
CREATE TABLE Medications(
    medicationID INT PRIMARY KEY,
    medicationName VARCHAR(100),
    description TEXT,
    dosage VARCHAR(50),
    sideEffects TEXT
);
CREATE TABLE PharmacyStock(
    stockID INT PRIMARY KEY,
    medicationID INT,
    batchNumber VARCHAR(50),
    quantity INT,
    expirationDate DATE,
    FOREIGN KEY (medicationID) REFERENCES Medications(medicationID)
);
-- TODO: Prescriptions

/* ============================================================
   Billing
   ============================================================ */
CREATE TABLE Invoice(
    invoiceID INT PRIMARY KEY,
    patientID INT,
    invoiceDate DATETIME,
    totalAmount DECIMAL(10, 2),
    amountPaid DECIMAL(10, 2),
    status ENUM('Paid', 'Unpaid', 'Pending'),
    FOREIGN KEY (patientID) REFERENCES Patients(patientID)
);
CREATE TABLE InvoiceItem(
    itemID INT PRIMARY KEY,
    invoiceID INT,
    description TEXT,
    quantity DECIMAL(10, 2),
    unitPrice DECIMAL(10, 2),
    FOREIGN KEY (invoiceID) REFERENCES Invoice(invoiceID)
);
-- TODO: Insurance, Payments

/* ============================================================
   Laboratory
   ============================================================ */
CREATE TABLE LabTests(
    testID INT PRIMARY KEY,
    testName VARCHAR(100),
    description TEXT,
    cost DECIMAL(10, 2)
    startDate DATE,
    endDate DATE
);

CREATE TABLE LabResults(
    resultID INT PRIMARY KEY,
    labTestID INT,
    patientID INT,
    resultDate DATETIME,
    results TEXT,
    peformedBy INT,
    FOREIGN KEY (testID) REFERENCES LabTests(testID),
    FOREIGN KEY (patientID) REFERENCES Patients(patientID),
    FOREIGN KEY (peformedBy) REFERENCES Employee(employeeID)
);

-- TODO



-- Treatment
-- Doctors (extension of Employee)
-- Nurses (extension of Employee)
-- Lab Technicians (extension of Employee)
-- Receptionists (extension of Employee)
-- Pharmacists (extension of Employee)
-- Administrative Staff (extension of Employee)
-- Janitorial Staff (extension of Employee)
-- Security Staff (extension of Employee)
-- Maintenance Staff (extension of Employee)
-- Human Resources Staff (extension of Employee)
-- IT Staff (extension of Employee)

-- link to table styling https://docs.google.com/spreadsheets/d/1RDEdzJzPHG6E3xWMCGLrQ5HLsfqTBaq5zk_CzEpqZ2w/edit?usp=sharing

-- Patients
CREATE TABLE Patients(
    patientID INT PRIMARY KEY,
    firstName VARCHAR(100),
    lastName VARCHAR(100),
    DOB DATE,
    phone VARCHAR(15),
    homeAddress VARCHAR(255),
    emergencyContactName VARCHAR(100),
    emergencyContactPhone VARCHAR(15),
    primaryDoctorID INT,
    dateCreated DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (primaryDoctorID) REFERENCES Doctor(doctorID)
);

-- Employee
CREATE TABLE Employee(
    employeeID INT PRIMARY KEY,
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
-- Department
-- Room
-- Appointment
-- Treatment
-- Car Plan
-- DoctorSchedule
-- Medications
-- Pharmacy Stock
-- Pharmacy
-- Invoice
-- Invoice Items
-- Lab Tests
-- Lab Results
-- Billing
-- Insurance
-- Insurance Providers
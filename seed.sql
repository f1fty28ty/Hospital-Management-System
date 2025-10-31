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

INSERT INTO Room (roomNumber, type, status, departmentID) VALUES
('101', 'General', 'Available', 9),
('102', 'ICU', 'Occupied', 8),
('201', 'Surgery', 'Under Maintenance', 5),
('202', 'Maternity', 'Available', 7),
('301', 'Pediatric', 'Available', 6),
('302', 'Private', 'Available', 9);

INSERT INTO Employee (firstName, lastName, DOB, phone, homeAddress, position, departmentID, dateHired, salary) VALUES
('John', 'Doe', '1980-04-12', '555-1234', '123 Elm St', 'Doctor', 5, '2010-06-01', 120000.00),
('Jane', 'Smith', '1985-09-20', '555-5678', '456 Oak St', 'Nurse', 6, '2015-08-15', 75000.00),
('Alice', 'Johnson', '1990-02-28', '555-8765', '789 Pine St', 'Lab Technician', 2, '2018-11-11', 65000.00),
('Bob', 'Lee', '1975-10-05', '555-3456', '321 Maple St', 'Receptionist', 1, '2020-01-02', 40000.00);

INSERT INTO Doctor (doctorID, roomID, payScale, specialization) VALUES
(1, 201, 120000.00, 'Cardiology'),
(10, 202, 110000.00, 'Neurology');

INSERT INTO Patients (firstName, lastName, DOB, phone, homeAddress, emergencyContactName, emergencyContactPhone, primaryDoctorID) VALUES
('Michael', 'Brown', '1987-05-14', '555-4321', '987 Birch St', 'Laura Brown', '555-6789', 1),
('Sarah', 'Davis', '1993-08-07', '555-6543', '654 Spruce St', 'John Davis', '555-1234', 1);

INSERT INTO Medications (medicationName, description, dosage, sideEffects) VALUES
('Paracetamol', 'Pain reliever and fever reducer', '500mg every 4-6 hours', 'Nausea, rash'),
('Amoxicillin', 'Antibiotic for bacterial infections', '250mg every 8 hours', 'Diarrhea, allergic reactions');

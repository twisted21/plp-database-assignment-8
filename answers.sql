-- Drop tables if they already exist
DROP TABLE IF EXISTS Payments, Treatments, Appointments, Doctor_Specializations, Specializations, Patients, Doctors;

-- Patients Table
CREATE TABLE Patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    dob DATE NOT NULL,
    gender ENUM('Male', 'Female', 'Other') NOT NULL,
    phone VARCHAR(15) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE
);

-- Doctors Table
CREATE TABLE Doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    phone VARCHAR(15) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

-- Specializations Table
CREATE TABLE Specializations (
    specialization_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL
);

-- Doctor_Specializations (M-M)
CREATE TABLE Doctor_Specializations (
    doctor_id INT,
    specialization_id INT,
    PRIMARY KEY (doctor_id, specialization_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id),
    FOREIGN KEY (specialization_id) REFERENCES Specializations(specialization_id)
);

-- Appointments Table
CREATE TABLE Appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATETIME NOT NULL,
    status ENUM('Scheduled', 'Completed', 'Cancelled') DEFAULT 'Scheduled',
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);

-- Treatments Table
CREATE TABLE Treatments (
    treatment_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT UNIQUE,
    diagnosis TEXT NOT NULL,
    prescription TEXT,
    notes TEXT,
    FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id)
);

-- Payments Table
CREATE TABLE Payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT UNIQUE,
    amount DECIMAL(10,2) NOT NULL,
    payment_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    method ENUM('Cash', 'Credit Card', 'Insurance') NOT NULL,
    FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id)
);

-- Insert sample data into Patients table
INSERT INTO Patients (first_name, last_name, dob, gender, phone, email) VALUES
('Alice', 'Smith', '1985-02-20', 'Female', '5551234567', 'alice@example.com'),
('Bob', 'Jones', '1990-07-11', 'Male', '5559876543', 'bob@example.com');

-- Insert Doctors data
INSERT INTO Doctors (first_name, last_name, phone, email) VALUES
('Dr. John', 'Miller', '5551112222', 'john.miller@clinic.com'),
('Dr. Jane', 'Brown', '5553334444', 'jane.brown@clinic.com');

-- Insert Specializations data
INSERT INTO Specializations (name) VALUES
('Cardiology'),
('Dermatology'),
('Pediatrics');

-- Associate Doctors with Specializations (M-M)
-- Dr. John is a Cardiologist and Pediatrician
INSERT INTO Doctor_Specializations (doctor_id, specialization_id) VALUES
(1, 1),  -- Dr. John: Cardiology
(1, 3),  -- Dr. John: Pediatrics
(2, 2);  -- Dr. Jane: Dermatology

-- Insert Appointments data
INSERT INTO Appointments (patient_id, doctor_id, appointment_date, status) VALUES
(1, 1, '2025-05-10 09:00:00', 'Scheduled'),
(2, 2, '2025-05-11 14:30:00', 'Scheduled');

-- Insert Treatments data
-- Treatment for appointment 1 (Alice with Dr. John)
INSERT INTO Treatments (appointment_id, diagnosis, prescription, notes) VALUES
(1, 'High Blood Pressure', 'Lisinopril 10mg', 'Monitor blood pressure daily'),
(2, 'Skin Rash', 'Hydrocortisone cream', 'Avoid allergens');

-- Insert Payments data
-- Payment for appointment 1 (Alice with Dr. John)
INSERT INTO Payments (appointment_id, amount, method) VALUES
(1, 150.00, 'Credit Card'),
(2, 100.00, 'Insurance');
     
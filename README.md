# plp-database-assignment-8
database final assignment
# Clinic Booking System Database

This project is a full-featured relational database for managing a small medical clinic's booking, treatment, and payment system using **MySQL**.

# Use Case

The system handles:
- Patient registration
- Doctor information and specializations
- Appointment scheduling
- Treatment recording
- Payment tracking

---

# Database Structure

# Tables

- **Patients**: Stores patient demographics.
- **Doctors**: Stores doctor profiles.
- **Specializations**: List of medical specialties.
- **Doctor_Specializations**: Many-to-many relationship between doctors and specializations.
- **Appointments**: Schedules for patient-doctor visits.
- **Treatments**: Diagnoses and prescriptions associated with an appointment.
- **Payments**: Payment details linked to appointments.

---

# Setup Instructions

# Requirements

- MySQL Server (8.0 or later)
- MySQL Workbench or terminal access

# Installation

1. Clone or download this repository.
2. Open MySQL Workbench or your terminal.
3. Create a new database:
    ```sql
    CREATE DATABASE clinic;
    USE clinic;
    ```
4. Import the SQL file:
    - Workbench: File → Open SQL Script → `clinic_booking_system.sql` → Execute
    - CLI:
      ```bash
      mysql -u root -p clinic < clinic_booking_system.sql
      ```

---

# Sample Queries

```sql
-- View all patients
SELECT * FROM Patients;

-- View appointments with doctor and patient names
SELECT 
  a.appointment_id,
  CONCAT(p.first_name, ' ', p.last_name) AS patient_name,
  CONCAT(d.first_name, ' ', d.last_name) AS doctor_name,
  a.appointment_date,
  a.status
FROM Appointments a
JOIN Patients p ON a.patient_id = p.patient_id
JOIN Doctors d ON a.doctor_id = d.doctor_id;

-- Get all treatments and prescriptions
SELECT 
  t.diagnosis,
  t.prescription,
  t.notes,
  a.appointment_date
FROM Treatments t
JOIN Appointments a ON t.appointment_id = a.appointment_id;

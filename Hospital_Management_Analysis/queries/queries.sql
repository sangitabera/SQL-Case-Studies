USE hospital_management;

-- total patients
SELECT COUNT(*) AS total_patients
FROM patients;

-- Count doctors
SELECT COUNT(*) AS total_doctorss
FROM doctors;

-- List all doctor specializations
SELECT DISTINCT specialization
FROM doctors;

-- Patients registered in 2023
SELECT *
FROM patients
WHERE YEAR(registration_date) = 2023 ;

-- Scheduled appointments
SELECT *
FROM appointments
WHERE status = 'Scheduled' ;
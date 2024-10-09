DROP table "SQLExperiments".patient_info;

CREATE TABLE "SQLExperiments".patient_info (
    patient_id INT ,
    patient_name VARCHAR(100) NOT NULL,
    ailment TEXT,
    visit_date DATE
);


INSERT INTO "SQLExperiments".patient_info(patient_id, patient_name, ailment, visit_date) VALUES(1,'John Doe','Diabetes','2024-09-01');
INSERT INTO "SQLExperiments".patient_info(patient_id, patient_name, ailment, visit_date) VALUES(1,'John Doe','Diabetes','2024-09-08');
INSERT INTO "SQLExperiments".patient_info(patient_id, patient_name, ailment, visit_date) VALUES(1,'John Doe','Diabetes','2024-09-15');
INSERT INTO "SQLExperiments".patient_info(patient_id, patient_name, ailment, visit_date) VALUES(1,'John Doe','Diabetes','2024-09-23');
INSERT INTO "SQLExperiments".patient_info(patient_id, patient_name, ailment, visit_date) VALUES(5,'Lisa Rae','Hypertension','2024-09-01');
INSERT INTO "SQLExperiments".patient_info(patient_id, patient_name, ailment, visit_date) VALUES(6,'Lisa Rae','Hypertension','2024-09-08');
INSERT INTO "SQLExperiments".patient_info(patient_id, patient_name, ailment, visit_date) VALUES(7,'Lisa Rae','Hypertension','2024-09-15');

select * from "SQLExperiments".patient_info;

update "SQLExperiments".patient_info set patient_id =5 where patient_name = 'Lisa Rae' and visit_date = '2024-09-15'


SELECT patient_name, ailment, visit_date,
       CASE
           WHEN LAG(visit_date) OVER (partition by patient_id) IS NULL THEN 'First Appointment'
           WHEN visit_date - LAG(visit_date) OVER (partition by patient_id) <= 7 THEN 'Not Missed'
           WHEN visit_date - LAG(visit_date) OVER (partition by patient_id) > 7 THEN 'Missed'
       END AS appointment_status
FROM "SQLExperiments".patient_info;
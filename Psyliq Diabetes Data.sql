create database diabetes_prediction;

use diabetes_prediction;

create table diabetes_data
(Employee_Name varchar(50),
Patient_id varchar(50),
gender varchar(50),
age	int,
hypertension int,	
heart_disease int,
smoking_history	varchar(50),
bmi float,
HbA1c_level	float,
blood_glucose_level float,	
diabetes float);

select * from diabetes_data;

-- 1. Retrieve the Patient_id and ages of all patients.

select patient_id,age
from diabetes_data;

-- 2.Select all female patients who are older than 40.

select Employee_Name, gender, age
from diabetes_data
where gender = "Female" and age>40;

-- 3. Calculate the average BMI of patients.

select round(avg(bmi),2) as avg_bmi
from diabetes_data;

-- 4. List patients in descending order of blood glucose levels.

select Employee_Name, Patient_id, blood_glucose_level
from diabetes_data
order by blood_glucose_level desc;

-- 5. Find patients who have hypertension and diabetes.

select Employee_Name, Patient_id,hypertension,diabetes
from diabetes_data
where hypertension=1 and diabetes=1;

-- 6. Determine the number of patients with heart disease.

select count(heart_disease) as no_of_patients_with_heart_disease
from diabetes_data
where heart_disease=1;

-- 7. Group patients by smoking history and count how many smokers and non smokers there are.

select smoking_history, count(*) as cnt
from diabetes_data
group by smoking_history;

-- 8. Retrieve the Patient_ids of patients who have a BMI greater than the average BMI.

select Patient_id,bmi
from diabetes_data
where bmi>(select round(avg(bmi),2)
from diabetes_data);

-- 9. Find the patient with the highest HbA1c level and the patient with the lowest
-- HbA1clevel.

select employee_name,hba1c_level
from diabetes_data
order by hba1c_level desc
limit 1;

select employee_name,hba1c_level
from diabetes_data
order by hba1c_level
limit 1;

select max(HbA1c_level) as highest_level,
min(HbA1c_level) as lowest_level
from diabetes_data;

-- 10. Calculate the age of patients in years (assuming the current date as of now)

select patient_id,age,year(curdate())-age as birth_year
from diabetes_data;

-- 11. Rank patients by blood glucose level within each gender group. 

select employee_name,gender,blood_glucose_level,
rank () over (partition by gender order by blood_glucose_level desc) as Rnk
from diabetes_data;

-- 12. Update the smoking history of patients who are older than 50 to "Ex-smoker."

update diabetes_data
set smoking_history="Ex-smoker"
where age>50;

-- 13. Insert a new patient into the database with sample data.

insert into diabetes_data
values ('Rinku Singh','PT654321','Male',50,0,1,'never smoked',19,31,45,0);

select * 
from diabetes_data
where Patient_id='PT654321';

-- 14. Delete all patients with heart disease from the database.

delete
from diabetes_data
where heart_disease=1;

-- 15. Find patients who have hypertension but not diabetes using the EXCEPT operator.

select employee_name,patient_id
from diabetes_data
where hypertension=1

except

select employee_name,patient_id
from diabetes_data
where diabetes=1;

-- 16. Define a unique constraint on the "patient_id" column to ensure its values are unique.

alter table diabetes_data
add constraint unique_patient_id unique(patient_id);

-- 17. Create a view that displays the Patient_ids, ages, and BMI of patients.

create view patient_info as
select Patient_id,age,bmi from diabetes_data;




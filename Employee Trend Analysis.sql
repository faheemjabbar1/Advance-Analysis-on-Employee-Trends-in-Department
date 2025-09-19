USE AET;  

---------------------------------------------------------
-- 1. Basic Exploration
---------------------------------------------------------
-- Preview the dataset
SELECT * 
FROM AET
LIMIT 50;

-- Count employees by department
SELECT department, COUNT(*) AS employee_count
FROM AET
GROUP BY department
ORDER BY employee_count DESC;

-- Average age by department
SELECT department, ROUND(AVG(age), 1) AS average_age
FROM AET
GROUP BY department
ORDER BY average_age DESC;

---------------------------------------------------------
-- 2. Job Roles & Satisfaction
---------------------------------------------------------
-- Most common job roles in each department
SELECT department, job_role, COUNT(*) AS role_count
FROM AET
GROUP BY department, job_role
ORDER BY department, role_count DESC;

-- Average job satisfaction by education
SELECT education, ROUND(AVG(job_satisfaction), 2) AS average_satisfaction
FROM AET
GROUP BY education
ORDER BY average_satisfaction DESC;

-- Average age by job satisfaction
SELECT job_satisfaction, ROUND(AVG(age), 1) AS average_age
FROM AET
GROUP BY job_satisfaction
ORDER BY job_satisfaction;

---------------------------------------------------------
-- 3. Attrition Analysis
---------------------------------------------------------
-- Attrition rate by age band
SELECT age_band,
       ROUND(SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM AET
GROUP BY age_band
ORDER BY attrition_rate DESC;

-- Departments ranked by average job satisfaction
SELECT department, ROUND(AVG(job_satisfaction), 2) AS average_satisfaction
FROM AET
GROUP BY department
ORDER BY average_satisfaction DESC;

-- Attrition rate by education + age band
SELECT education, age_band,
       ROUND(SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM AET
GROUP BY education, age_band
ORDER BY attrition_rate DESC;

-- Satisfaction among frequent travelers by education
SELECT education, ROUND(AVG(job_satisfaction), 2) AS average_satisfaction
FROM AET
WHERE business_travel = 'Travel_Frequently'
GROUP BY education
ORDER BY average_satisfaction DESC
LIMIT 3;

-- Highest job satisfaction among married employees by age band
SELECT age_band, ROUND(AVG(job_satisfaction), 2) AS average_satisfaction
FROM AET
WHERE marital_status = 'Married'
GROUP BY age_band
ORDER BY average_satisfaction DESC
LIMIT 1;

---------------------------------------------------------
-- 4. Advanced Insights (Added Value)
---------------------------------------------------------
-- Which departments have highest attrition vs lowest?
WITH dept_attrition AS (
    SELECT department,
           COUNT(*) AS total_employees,
           SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS attrition_count,
           ROUND(SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
    FROM AET
    GROUP BY department
)
SELECT *
FROM dept_attrition
ORDER BY attrition_rate DESC;

-- Retention rate by job role (using active_employee flag)
SELECT job_role,
       COUNT(*) AS total_employees,
       SUM(CASE WHEN active_employee = 1 THEN 1 ELSE 0 END) AS retained_employees,
       ROUND(SUM(CASE WHEN active_employee = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS retention_rate
FROM AET
GROUP BY job_role
ORDER BY retention_rate DESC;

-- Attrition rate by travel frequency
SELECT business_travel,
       COUNT(*) AS total_employees,
       SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS attrition_count,
       ROUND(SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM AET
GROUP BY business_travel
ORDER BY attrition_rate DESC;


-- Manager-level retention: attrition rate by manager
SELECT manager_id,
       COUNT(*) AS team_size,
       ROUND(SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM AET
GROUP BY manager_id
HAVING team_size >= 5
ORDER BY attrition_rate DESC;

--Attrition by education field
SELECT education_field,
       ROUND(SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM AET
GROUP BY education_field
ORDER BY attrition_rate DESC;

-- Top 5 job roles with highest attrition
SELECT job_role,
       ROUND(SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM AET
GROUP BY job_role
ORDER BY attrition_rate DESC
LIMIT 5;

-- Satisfaction bands by department
SELECT department,
       SUM(CASE WHEN job_satisfaction >= 4 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS pct_high_satisfaction,
       SUM(CASE WHEN job_satisfaction <= 2 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS pct_low_satisfaction
FROM AET
GROUP BY department
ORDER BY pct_high_satisfaction DESC;

--Attrition by gender + marital_status (family factors
SELECT gender, marital_status,
       ROUND(SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM AET
GROUP BY gender, marital_status
ORDER BY attrition_rate DESC;

--Department-wise active vs inactive headcount:
SELECT department,
       COUNT(*) AS total_employees,
       SUM(CASE WHEN active_employee = 1 THEN 1 ELSE 0 END) AS active_employees,
       SUM(CASE WHEN active_employee = 0 THEN 1 ELSE 0 END) AS inactive_employees
FROM AET
GROUP BY department
ORDER BY inactive_employees DESC;

---------------------------------------------------------
-- 5. Ready for Leadership Dashboards
---------------------------------------------------------
-- Summary table combining key HR metrics by department
SELECT
    department,
    COUNT(*) AS total_employees,
    ROUND(AVG(age), 1) AS avg_age,
    ROUND(AVG(job_satisfaction), 2) AS avg_satisfaction,
    ROUND(
      (SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0) / NULLIF(COUNT(*),0),
      2
    ) AS attrition_rate,
    ROUND(
      (SUM(CASE WHEN active_employee = 1 THEN 1 ELSE 0 END) * 100.0) / NULLIF(COUNT(*),0),
      2
    ) AS retention_rate
FROM AET
GROUP BY department
ORDER BY attrition_rate DESC;
USE AET;  

---------------------------------------------------------
-- 1. Basic Exploration
---------------------------------------------------------
-- Preview the dataset
SELECT * 
FROM AET
LIMIT 10;

-- Count employees by department
SELECT department, COUNT(*) AS employee_count
FROM AET
GROUP BY department
ORDER BY employee_count DESC;

-- Average age by department
SELECT department, ROUND(AVG(age), 1) AS average_age
FROM AET
GROUP BY department
ORDER BY average_age DESC;

---------------------------------------------------------
-- 2. Job Roles & Satisfaction
---------------------------------------------------------
-- Most common job roles in each department
SELECT department, job_role, COUNT(*) AS role_count
FROM AET
GROUP BY department, job_role
ORDER BY department, role_count DESC;

-- Average job satisfaction by education
SELECT education, ROUND(AVG(job_satisfaction), 2) AS average_satisfaction
FROM AET
GROUP BY education
ORDER BY average_satisfaction DESC;

-- Average age by job satisfaction
SELECT job_satisfaction, ROUND(AVG(age), 1) AS average_age
FROM AET
GROUP BY job_satisfaction
ORDER BY job_satisfaction;

---------------------------------------------------------
-- 3. Attrition Analysis
---------------------------------------------------------
-- Attrition rate by age band
SELECT age_band,
       ROUND(SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM AET
GROUP BY age_band
ORDER BY attrition_rate DESC;

-- Departments ranked by average job satisfaction
SELECT department, ROUND(AVG(job_satisfaction), 2) AS average_satisfaction
FROM AET
GROUP BY department
ORDER BY average_satisfaction DESC;

-- Attrition rate by education + age band
SELECT education, age_band,
       ROUND(SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM AET
GROUP BY education, age_band
ORDER BY attrition_rate DESC;

-- Satisfaction among frequent travelers by education
SELECT education, ROUND(AVG(job_satisfaction), 2) AS average_satisfaction
FROM AET
WHERE business_travel = 'Travel_Frequently'
GROUP BY education
ORDER BY average_satisfaction DESC
LIMIT 3;

-- Highest job satisfaction among married employees by age band
SELECT age_band, ROUND(AVG(job_satisfaction), 2) AS average_satisfaction
FROM AET
WHERE marital_status = 'Married'
GROUP BY age_band
ORDER BY average_satisfaction DESC
LIMIT 1;

---------------------------------------------------------
-- 4. Advanced Insights (Added Value)
---------------------------------------------------------
-- Which departments have highest attrition vs lowest?
WITH dept_attrition AS (
    SELECT department,
           COUNT(*) AS total_employees,
           SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS attrition_count,
           ROUND(SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
    FROM AET
    GROUP BY department
)
SELECT *
FROM dept_attrition
ORDER BY attrition_rate DESC;

-- Retention rate by job role (using active_employee flag)
SELECT job_role,
       COUNT(*) AS total_employees,
       SUM(CASE WHEN active_employee = 1 THEN 1 ELSE 0 END) AS retained_employees,
       ROUND(SUM(CASE WHEN active_employee = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS retention_rate
FROM AET
GROUP BY job_role
ORDER BY retention_rate DESC;

-- Attrition rate by travel frequency
SELECT business_travel,
       COUNT(*) AS total_employees,
       SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS attrition_count,
       ROUND(SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM AET
GROUP BY business_travel
ORDER BY attrition_rate DESC;


-- Manager-level retention: attrition rate by manager
SELECT manager_id,
       COUNT(*) AS team_size,
       ROUND(SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM AET
GROUP BY manager_id
HAVING team_size >= 5
ORDER BY attrition_rate DESC;

--Attrition by education field
SELECT education_field,
       ROUND(SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM AET
GROUP BY education_field
ORDER BY attrition_rate DESC;

-- Top 5 job roles with highest attrition
SELECT job_role,
       ROUND(SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM AET
GROUP BY job_role
ORDER BY attrition_rate DESC
LIMIT 5;

-- Satisfaction bands by department
SELECT department,
       SUM(CASE WHEN job_satisfaction >= 4 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS pct_high_satisfaction,
       SUM(CASE WHEN job_satisfaction <= 2 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS pct_low_satisfaction
FROM AET
GROUP BY department
ORDER BY pct_high_satisfaction DESC;

--Attrition by gender + marital_status (family factors
SELECT gender, marital_status,
       ROUND(SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate
FROM AET
GROUP BY gender, marital_status
ORDER BY attrition_rate DESC;

--Department-wise active vs inactive headcount:
SELECT department,
       COUNT(*) AS total_employees,
       SUM(CASE WHEN active_employee = 1 THEN 1 ELSE 0 END) AS active_employees,
       SUM(CASE WHEN active_employee = 0 THEN 1 ELSE 0 END) AS inactive_employees
FROM AET
GROUP BY department
ORDER BY inactive_employees DESC;

---------------------------------------------------------
-- 5. Ready for Leadership Dashboards
---------------------------------------------------------
-- Summary table combining key HR metrics by department
SELECT
    department,
    COUNT(*) AS total_employees,
    ROUND(AVG(age), 1) AS avg_age,
    ROUND(AVG(job_satisfaction), 2) AS avg_satisfaction,
    ROUND(
      (SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0) / NULLIF(COUNT(*),0),
      2
    ) AS attrition_rate,
    ROUND(
      (SUM(CASE WHEN active_employee = 1 THEN 1 ELSE 0 END) * 100.0) / NULLIF(COUNT(*),0),
      2
    ) AS retention_rate
FROM AET
GROUP BY department
ORDER BY attrition_rate DESC;

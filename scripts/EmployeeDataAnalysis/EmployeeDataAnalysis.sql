--Demonstration of Windows Function

-- Employee table created
CREATE TABLE "Employee".employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    dept_name VARCHAR(50),
    salary INT
);

-- Employee table loaded

COPY "Employee".employees (emp_id,emp_name,dept_name,salary)
FROM 'C:\Projects\Databricks\Source Data\employee_data.csv'
WITH (FORMAT csv, HEADER);

-- Generic queries executed

select * 
from "Employee".employees limit 10;

-- Aggregrate functions applied

select max(salary) as max_salary 	
from "Employee".employees;

select dept_name, 
	max(salary) as max_salary 
from "Employee".employees 
	group by dept_name;

select dept_name, 
	max(salary) as max_salary, 
	avg(salary) as avg_salary 
from "Employee".employees 
	group by dept_name;

-- Windows functions application

select emp.*,
	max(emp.salary) over() as max_salary, 
	min(emp.salary) over() as min_salary, 
	cast(avg(emp.salary) over() as INT) as avg_salary 
from "Employee".employees emp
	order by max_salary;

-- Row, Rank and Dense_Rank function application

select emp.*,
	row_number() over() as row_num,
	rank() over(partition by dept_name order by salary asc) as rank_num,
	dense_rank() over(partition by dept_name order by salary asc) as dense_rank_num
from "Employee".employees emp
order by dept_name

-- Lag function

select emp.*,
	lag(salary,2,null) over(partition by dept_name) as prev_salary,
	lead(salary,2,null) over(partition by dept_name) as next_salary
from "Employee".employees emp


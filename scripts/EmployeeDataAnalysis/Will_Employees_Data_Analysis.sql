CREATE TABLE "Employee".wills_employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    designation VARCHAR(100) NOT NULL,
    is_manager BOOLEAN DEFAULT FALSE,
    salary INT NOT NULL
);

COPY "Employee".employees (emp_id,emp_name,dept_name,salary)
FROM 'C:\Projects\Databricks\employee_data.csv'
WITH (FORMAT csv, HEADER);

select * from "Employee".wills_employees;

alter table "Employee".wills_employees add column manager_id int;

INSERT INTO "Employee".wills_employees (employee_id, employee_name, designation, is_manager, salary, manager_id) VALUES(1,'Amy Simons','Sales Representative',False,80507,null);
INSERT INTO "Employee".wills_employees (employee_id, employee_name, designation, is_manager, salary, manager_id) VALUES(2,'Ronald Hopkins','Sales Representative',True,75326,1);
INSERT INTO "Employee".wills_employees (employee_id, employee_name, designation, is_manager, salary, manager_id) VALUES(3,'Joan Hodge','Software Engineer',False,91283,1);
INSERT INTO "Employee".wills_employees (employee_id, employee_name, designation, is_manager, salary, manager_id) VALUES(4,'Victor Richardson','Marketing Specialist',False,64825,2);
INSERT INTO "Employee".wills_employees (employee_id, employee_name, designation, is_manager, salary, manager_id) VALUES(5,'Gonzalo Hall','Data Analyst',False,44608,3);
INSERT INTO "Employee".wills_employees (employee_id, employee_name, designation, is_manager, salary, manager_id) VALUES(6,'Matthew Morris','Data Analyst',False,57750,2);


--Query to find out that who is whose manager?

alter table "Employee".wills_employees drop column is_manager;

select e1.employee_id, e1.employee_name,
	case when e1.manager_id is null then e1.employee_name
		when e1.manager_id is not null then e2.employee_name 
		end as manager_name
from "Employee".wills_employees e1 left join "Employee".wills_employees e2
on e1.manager_id = e2.employee_id

--Query to get max, min and average salary

select designation, count(1) as num_of_team_mem, max(salary) as max_salary, min(salary) as min_salary, cast(avg(salary)as int)  as avg_salary
from "Employee".wills_employees
group by designation;

--Query to get the salary difference from previous employee in table ordered by designation and salary

with employee_salary as (
select employee_name, designation, salary
from "Employee".wills_employees
order by designation, salary asc),

salary_com as (
select employee_name, designation, salary, lag(salary) over() as prev_emp_salary
	from employee_salary)

select employee_name, designation, salary, salary-prev_emp_salary as salary_difference
from salary_com;

--Query to get the salary difference from previous employee of same designation in table ordered by designation and salary

with employee_salary as (
    select employee_name, designation, salary
    from "Employee".wills_employees
    order by designation, salary asc
),
salary_com as (
    select employee_name, designation, salary,
           lag(salary) over (partition by designation order by salary) as prev_emp_salary,
           salary - lag(salary) over (partition by designation order by salary) as salary_difference
    from employee_salary
)
select employee_name, designation, salary, salary_difference
from salary_com;

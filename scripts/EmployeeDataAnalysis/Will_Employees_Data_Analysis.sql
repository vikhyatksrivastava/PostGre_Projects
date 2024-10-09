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

create table "Employee".individual(
	id Int,
	name varchar,
	profession varchar
);

INSERT INTO "Employee".individual(ID, Name, Profession) VALUES(1,'Sam','Doctor');
INSERT INTO "Employee".individual(ID, Name, Profession) VALUES(2,'Shyam','Actor');
INSERT INTO "Employee".individual(ID, Name, Profession) VALUES(3,'Samuel','Cricketer');
INSERT INTO "Employee".individual(ID, Name, Profession) VALUES(4,'Sammy','Singer');

select * from "Employee".individual;

select id, name, profession, concat(name,'(',substring(profession,1,1),')') as Output
	from "Employee".individual;

Alter table "Employee".individual add column Salary Int;

Update "Employee".individual Set salary = 1420 where id = 1;
Update "Employee".individual Set salary = 1988 where id = 2;
Update "Employee".individual Set salary = 7980 where id = 3;
Update "Employee".individual Set salary = 5432 where id = 4;

select cast(avg(salary) - avg(entered_salary) as Int) as diff_of_avg_salary from (
select id, name, salary, cast(replace(cast(salary as varchar),'0','') as int) as entered_salary
from "Employee".individual) temp;

-----------------------------------------------------------------

select * from "SQLExperiments".tree;

create table "SQLExperiments".binary_search_tree(
	node int,
	parent int
);

select * from "SQLExperiments".binary_search_tree;


INSERT INTO "SQLExperiments".binary_search_tree(node,parent) VALUES(1,2);
INSERT INTO "SQLExperiments".binary_search_tree(node,parent) VALUES(3,2);
INSERT INTO "SQLExperiments".binary_search_tree(node,parent) VALUES(6,8);
INSERT INTO "SQLExperiments".binary_search_tree(node,parent) VALUES(9,8);
INSERT INTO "SQLExperiments".binary_search_tree(node,parent) VALUES(2,5);
INSERT INTO "SQLExperiments".binary_search_tree(node,parent) VALUES(8,5);
INSERT INTO "SQLExperiments".binary_search_tree(node,parent) VALUES(5,null);
INSERT INTO "SQLExperiments".binary_search_tree(node,parent) VALUES(4,1);

select distinct t1.node, t1.parent,
	case when t1.parent is null and t1.node is not null then 'Root'
	when t2.parent is null then 'leaf'
	ELSE 'Inner 'end as OutPut
from "SQLExperiments".binary_search_tree t1 full JOIN "SQLExperiments".binary_search_tree t2
on t1.node = t2.parent
	where t1.node is not null
	order by t1.node;


select T1.node,T1.parent ,
	case 
		when T1.parent is null then 'ROOT' 
		when T1.node in (select parent from "SQLExperiments".binary_search_tree) then 'Inner'
		else 'LEAF'
	end as tree_element
from "SQLExperiments".binary_search_tree T1
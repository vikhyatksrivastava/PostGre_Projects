
-- Find out root, branch or leaf from a tree as in given table such that:
-- 	if child is null then node is root;
-- 	else if child is present in node then its a branch;
-- 	else the child is leaf

select * from "SQLExperiments".tree;
-- Result:
-- "node"	"branch"
-- 1	
-- 2	1
-- 3	1
-- 4	2
-- 5	2

select T1.node,T1.child ,
	case 
		when T1.child is null then 'ROOT' 
		when T1.node in (select child from "SQLExperiments".tree) then 'BRANCH'
		else 'LEAF'
	end as tree_element
from "SQLExperiments".tree T1

--Outcome:
-- "node"	"child"	"tree_element"
-- 1		"ROOT"
-- 2	1	"BRANCH"
-- 3	1	"LEAF"
-- 4	2	"LEAF"
-- 5	2	"LEAF"
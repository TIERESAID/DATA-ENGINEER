/*
Write a query that, based on data from the system view, displays all the foreign key (relationship) constraints in the 'public' schema. The query result must contain the 'public' database schema, constraint name, update rule, delete rule. From the list of system views , select the one that contains the information you need.
*/

SELECT 
    constraint_name,
    constraint_schema,
    update_rule,
    delete_rule
FROM 
    information_schema.referential_constraints
WHERE 
    constraint_schema = 'public';
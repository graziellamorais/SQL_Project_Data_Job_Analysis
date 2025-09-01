-- List all companies that have job postings mentioning no degree requirement.
-- Include company_id and company_name.
-- Use a subquery in the WHERE clause.
SELECT
    company_id,
    name AS company_name
FROM 
    company_dim
WHERE
    co
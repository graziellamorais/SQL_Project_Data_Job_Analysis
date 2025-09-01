-- Create tables for each month of the year

CREATE TABLE january_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1;

CREATE TABLE february_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 2;

CREATE TABLE march_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 3;

CREATE TABLE april_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 4;

CREATE TABLE may_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 5;

CREATE TABLE june_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 6;

CREATE TABLE july_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 7;

CREATE TABLE august_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 8;

CREATE TABLE september_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 9;

CREATE TABLE october_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 10;

CREATE TABLE november_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 11;

CREATE TABLE december_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 12;

-- verify the tables were created successfully
SELECT job_posted_date
FROM january_jobs;

-- Categorize job locations into 'Remote', 'Local', and 'Onsite'
-- 'Remote' for 'Anywhere', 'Local' for 'New York, NY', and 'Onsite' for all other locations
SELECT
    COUNT(job_id) AS number_of_jobs,
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS location_category
FROM job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
GROUP BY 
    location_category;

SELECT *
FROM job_postings_fact
WHERE job_title_short = 'Data Analyst';

-- Categorize the salaries from each job posting to see if it fits the desired salary range
-- Put salary into different buckets: '<50k', '50k-100k', '100k-150k', '150k-200k', '>200k'
-- Define what's a high, standard, and low salary for a Data Analyst role
-- Order from highest to lowest salary range
SELECT
    COUNT(job_id) AS number_of_jobs,
    CASE
        WHEN salary_year_avg < 50000 THEN '<50k'
        WHEN salary_year_avg BETWEEN 50000 AND 100000 THEN '50k-100k'
        WHEN salary_year_avg BETWEEN 100001 AND 150000 THEN '100k-150k'
        WHEN salary_year_avg BETWEEN 150001 AND 200000 THEN '150k-200k'
        ELSE '>200k'
    END AS salary_range
FROM job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
GROUP BY 
    salary_range
ORDER BY
    salary_range DESC;

-- Using a subquery to filter job postings made in January
-- This subquery selects all job postings from January and the outer query retrieves all columns from that result
-- This is useful for isolating data for specific analysis or reporting
SELECT *
FROM ( -- Subquery starts here
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1
) AS janurary_jobs; -- Subquery ends here

-- Using a Common Table Expression (CTE) to filter job postings made in January
-- This CTE selects all job postings from January and the main query retrieves all columns from that result
-- CTEs can improve readability and organization of complex queries
WITH janurary_jobs AS (
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1
)
SELECT *
FROM janurary_jobs;
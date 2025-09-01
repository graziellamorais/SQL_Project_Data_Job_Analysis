-- Get jobs and companies from January
SELECT 
    job_title_short,
    company_id,
    job_location
FROM 
    january_jobs

UNION ALL
-- Get jobs and companies from February
SELECT 
    job_title_short,
    company_id,
    job_location
FROM 
    february_jobs

UNION ALL
-- Get jobs and companies from March
SELECT 
    job_title_short,
    company_id,
    job_location
FROM 
    march_jobs;

/*
PRACTICE: 
    Find job postings from the first quarter that have a salary greater than $70k
    - Combine job posting tables from the first quarter of 2023 (Jan-Mar)
    - Get job postings with an average yearly salary greater than $70,000
*/

SELECT 
    job_title_short,
    job_location,
    job_via,
    job_posted_date::DATE,
    salary_year_avg
-- Combine job postings from January, February, and March using UNION ALL
FROM (
    SELECT *
    FROM january_jobs
    UNION ALL
    SELECT *
    FROM february_jobs
    UNION ALL
    SELECT *
    FROM march_jobs
) AS quarter1_job_postings
-- Filter for jobs with an average yearly salary greater than $70,000
WHERE 
    salary_year_avg > 70000 AND
    job_title_short = 'Data Analyst'
ORDER BY
    salary_year_avg DESC;
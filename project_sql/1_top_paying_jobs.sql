-- Find the top paying Data Analyst jobs in Berlin, Germany
-- Display job title, location, posted date, and average yearly salary
-- Order the results by average yearly salary in descending order
-- Limit the output to the top 10 highest paying jobs
SELECT 
    job_title_short,
    job_location,
    job_via,
    job_posted_date::DATE,
    salary_year_avg AS average_yearly_salary
FROM 
    job_postings_fact
WHERE 
    salary_year_avg IS NOT NULL
    AND job_title_short = 'Data Analyst'
    AND job_location = 'Berlin, Germany'
ORDER BY
    salary_year_avg DESC
LIMIT 10;
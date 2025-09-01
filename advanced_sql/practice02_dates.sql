-- This query selects job titles, locations, and posted dates from the job_postings_fact table.
-- The job_posted_date is cast to a DATE type to ensure it is in the correct format.
SELECT
    job_title_short AS title,
    job_location AS location,
    job_posted_date::DATE AS date 
FROM
    job_postings_fact;

-- This query selects job titles, locations, and posted dates from the job_postings_fact table.
-- The job_posted_date is converted to the 'EST' timezone from 'UTC'.
-- Additionally, it extracts the month and year from the job_posted_date.
-- We can use it in combination with something like GROUP BY to aggregate data by month or year for trend analysis.
-- Note: Adjust the timezone names as per your database's supported timezones.
SELECT
    job_title_short AS title, 
    job_location AS location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS date_time,
    EXTRACT(MONTH FROM job_posted_date) AS date_month,
    EXTRACT(YEAR FROM job_posted_date) AS date_year
FROM
    job_postings_fact
LIMIT 5;


-- This query counts the number of job postings per month by extracting the month from the job_posted_date.
-- It groups the results by month to provide a summary of job postings for each month.
-- Note: The LIMIT clause is used here to restrict the output for demonstration purposes.
-- In a real scenario, you might want to remove the LIMIT to see all months.
SELECT 
    COUNT(job_id) AS job_posted_count,
    EXTRACT(MONTH FROM job_posted_date) AS month
FROM
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    month
ORDER BY 
    job_posted_count DESC;
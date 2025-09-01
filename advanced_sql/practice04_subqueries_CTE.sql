-- List all companies that have job postings mentioning no degree requirement.
-- Include company_id and company_name.
-- Use a subquery in the WHERE clause.
SELECT
    company_id,
    name AS company_name
FROM 
    company_dim
WHERE
    company_id IN (
        SELECT 
            company_id
        FROM 
            job_postings_fact
        WHERE
            job_no_degree_mention = TRUE
    );


-- Count the number of job postings per company.
-- Include company_id and the count of job postings.
-- Use a Common Table Expression (CTE).
WITH company_job_count AS (
    SELECT
        company_id,
        COUNT(*) AS total_jobs
    FROM
        job_postings_fact
    GROUP BY
        company_id
)

-- Join the CTE with company_dim to get company names.
SELECT 
    company_dim.name AS company_name,
    company_job_count.total_jobs
FROM 
    company_dim
LEFT JOIN 
    company_job_count ON company_job_count.company_id = company_dim.company_id
    ORDER BY total_jobs DESC;


-- Practice subqueries and CTEs
-- Identify the top 5 skills that are most frequently mentioned in job postings.
-- Use a subquery to find the skill ids with the highest counts in the skills_job_dim table and then join this result with the skills_dim table to get the skill names.
SELECT *
FROM skills_dim;

SELECT 
    skills_dim.skills AS skill_name,
    skill_counts.job_count
FROM 
    skills_dim
JOIN (
    SELECT 
        skill_id,
        COUNT(job_id) AS job_count
    FROM 
        skills_job_dim
    GROUP BY 
        skill_id
    ORDER BY 
        job_count DESC
    LIMIT 5
) AS skill_counts ON skills_dim.skill_id = skill_counts.skill_id;
-- The top 5 skills are: SQL, Python, R, Azure, and AWS.

/*
Find the count of the number of remote job postings per skill
    - Display the top 5 skills by their demand in remote jobs
    - Include skill ID, name, and count of postings requiring the skill
*/
WITH remote_job_skills AS (
    SELECT
        skill_id,
        COUNT(*) AS skill_count
    FROM 
        skills_job_dim AS skills_to_job
    INNER JOIN 
        job_postings_fact AS job_postings ON job_postings.job_id = skills_to_job.job_id
    WHERE
        job_postings.job_work_from_home = TRUE AND
        job_postings.job_title_short = 'Data Analyst'
    GROUP BY
        skill_id
)

-- Join the CTE with skills_dim to get skill names
-- Select the top 5 skills by count
-- Order the results by skill count in descending order
-- Limit the output to 5 records
SELECT 
    skills.skill_id,
    skills AS skill_name,
    skill_count
FROM remote_job_skills
INNER JOIN skills_dim AS skills ON skills.skill_id = remote_job_skills.skill_id
ORDER BY 
    skill_count DESC
LIMIT 5;
-- The top 5 skills for remote Data Analyst jobs are: SQL, Excel, Python, Tableau, and Power BI.
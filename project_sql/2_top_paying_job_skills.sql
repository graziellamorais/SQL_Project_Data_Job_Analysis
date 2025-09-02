/*
Question: What skills are required for the top-paying data analyst jobs?
- Use the top 10 highest-paying Data Analyst jobs from first query
- Add the specific skills required for these roles
- Why? It provides a detailed look at which high-paying Data Analyst jobs in Berlin, Germany, require which skills, helping job seekers target their skill development.
*/

-- Create a CTE to get the top 10 highest-paying Data Analyst jobs in Berlin, Germany
WITH top_paying_jobs AS (
    SELECT 
        job_id,
        job_title,
        name AS company_name,
        salary_year_avg
    FROM 
        job_postings_fact
    -- I want to know the company name as well, but it's not in this table. I need to join with the dim_company table.
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    -- Filter for Data Analyst jobs in Berlin, Germany with non-null salaries
    WHERE 
        job_title_short = 'Data Analyst'
        AND job_location = 'Berlin, Germany'
        AND salary_year_avg IS NOT NULL
    ORDER BY 
        salary_year_avg DESC
    LIMIT 10
)
-- Join the top-paying jobs with the skills_job_dim table to get the skills for these jobs
SELECT 
    top_paying_jobs.*, -- Select all columns from the top-paying jobs CTE
    skills_dim.skills
FROM top_paying_jobs
-- Join with skills_job_dim to link job postings with skills
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
-- Join with skills_dim to get skill names
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    top_paying_jobs.salary_year_avg DESC;

/*
Here are the most sought-after skills for data analyst roles:
    - SQL and Tableau are tied for the most in-demand skills, each mentioned 5 times. This indicates the importance of both database querying (SQL) and data visualization (Tableau) in the field.
    - Python comes in as the next most requested skill, with 4 mentions, highlighting the need for programming and scripting abilities.
    - Other skills such as R, Power BI, and Looker were also mentioned, showing the value of a diverse technical toolkit.
This analysis suggests that a strong foundation in SQL for data manipulation, paired with proficiency in a data visualization tool like Tableau, and programming skills in Python, are key for success as a data analyst.

[
  {
    "job_id": 59701,
    "job_title": "Head of Data Analytics",
    "company_name": "Volt.io",
    "salary_year_avg": "166419.5",
    "skills": "sql"
  },
  {
    "job_id": 59701,
    "job_title": "Head of Data Analytics",
    "company_name": "Volt.io",
    "salary_year_avg": "166419.5",
    "skills": "python"
  },
  {
    "job_id": 59701,
    "job_title": "Head of Data Analytics",
    "company_name": "Volt.io",
    "salary_year_avg": "166419.5",
    "skills": "tableau"
  },
  {
    "job_id": 59701,
    "job_title": "Head of Data Analytics",
    "company_name": "Volt.io",
    "salary_year_avg": "166419.5",
    "skills": "power bi"
  },
  {
    "job_id": 537995,
    "job_title": "Data Analyst/Manager - Last Mile Planning (m/f/d)",
    "company_name": "Flink",
    "salary_year_avg": "111202.0",
    "skills": "python"
  },
  {
    "job_id": 537995,
    "job_title": "Data Analyst/Manager - Last Mile Planning (m/f/d)",
    "company_name": "Flink",
    "salary_year_avg": "111202.0",
    "skills": "r"
  },
  {
    "job_id": 573605,
    "job_title": "Principal Data Analyst - Growth",
    "company_name": "SumUp",
    "salary_year_avg": "111175.0",
    "skills": "sql"
  },
  {
    "job_id": 573605,
    "job_title": "Principal Data Analyst - Growth",
    "company_name": "SumUp",
    "salary_year_avg": "111175.0",
    "skills": "python"
  },
  {
    "job_id": 573605,
    "job_title": "Principal Data Analyst - Growth",
    "company_name": "SumUp",
    "salary_year_avg": "111175.0",
    "skills": "r"
  },
  {
    "job_id": 573605,
    "job_title": "Principal Data Analyst - Growth",
    "company_name": "SumUp",
    "salary_year_avg": "111175.0",
    "skills": "matlab"
  },
  {
    "job_id": 573605,
    "job_title": "Principal Data Analyst - Growth",
    "company_name": "SumUp",
    "salary_year_avg": "111175.0",
    "skills": "tableau"
  },
  {
    "job_id": 181752,
    "job_title": "Data Analyst:in mit Schwerpunkt Marketing",
    "company_name": "Vattenfall",
    "salary_year_avg": "111175.0",
    "skills": "looker"
  },
  {
    "job_id": 432207,
    "job_title": "Data Analyst - SME Sales",
    "company_name": "SumUp",
    "salary_year_avg": "105000.0",
    "skills": "tableau"
  },
  {
    "job_id": 432207,
    "job_title": "Data Analyst - SME Sales",
    "company_name": "SumUp",
    "salary_year_avg": "105000.0",
    "skills": "sap"
  },
  {
    "job_id": 432207,
    "job_title": "Data Analyst - SME Sales",
    "company_name": "SumUp",
    "salary_year_avg": "105000.0",
    "skills": "git"
  },
  {
    "job_id": 929216,
    "job_title": "Data Analyst",
    "company_name": "Veeva Systems",
    "salary_year_avg": "102500.0",
    "skills": "sql"
  },
  {
    "job_id": 929216,
    "job_title": "Data Analyst",
    "company_name": "Veeva Systems",
    "salary_year_avg": "102500.0",
    "skills": "tableau"
  },
  {
    "job_id": 929216,
    "job_title": "Data Analyst",
    "company_name": "Veeva Systems",
    "salary_year_avg": "102500.0",
    "skills": "atlassian"
  },
  {
    "job_id": 956581,
    "job_title": "Data Analyst (f/m/d) Berlin",
    "company_name": "SIGNA Sports United",
    "salary_year_avg": "100500.0",
    "skills": "sql"
  },
  {
    "job_id": 956581,
    "job_title": "Data Analyst (f/m/d) Berlin",
    "company_name": "SIGNA Sports United",
    "salary_year_avg": "100500.0",
    "skills": "aws"
  },
  {
    "job_id": 956581,
    "job_title": "Data Analyst (f/m/d) Berlin",
    "company_name": "SIGNA Sports United",
    "salary_year_avg": "100500.0",
    "skills": "tableau"
  },
  {
    "job_id": 1204219,
    "job_title": "SEO Data Analyst (f/m/x)",
    "company_name": "AUTO1 Group",
    "salary_year_avg": "57500.0",
    "skills": "sql"
  },
  {
    "job_id": 1204219,
    "job_title": "SEO Data Analyst (f/m/x)",
    "company_name": "AUTO1 Group",
    "salary_year_avg": "57500.0",
    "skills": "python"
  },
  {
    "job_id": 1204219,
    "job_title": "SEO Data Analyst (f/m/x)",
    "company_name": "AUTO1 Group",
    "salary_year_avg": "57500.0",
    "skills": "sheets"
  }
]
*/
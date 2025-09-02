/*
Question: What are the most in-demand skills for data analysts in Berlin, Germany?
- Join job postings to inner join table similar to query 2
- Idenfity the top 5 in-demand skills for a data analyst in Berlin, Germany
- Why? Retrieves the top 5 skills with the highest demand in the job market, providing insights into the most valuable skills for job seekers.
*/

-- Calculate the demand for each skill associated with Data Analyst jobs in Berlin, Germany
SELECT
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
-- Join with skills_job_dim to link job postings with skills
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
-- Join with skills_dim to get skill names
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
-- Filter for Data Analyst jobs in Berlin, Germany
WHERE
    job_title_short = 'Data Analyst'
    AND job_location = 'Berlin, Germany'
-- Group by skill to calculate demand count per skill
GROUP BY
    skills
-- Order by demand count in descending order and limit to top 5 skills
ORDER BY
    demand_count DESC
LIMIT 5;

/*
The top 5 most in-demand skills for data analysts in Berlin, Germany are:
[
  {
    "skills": "sql",
    "demand_count": "558"
  },
  {
    "skills": "python",
    "demand_count": "415"
  },
  {
    "skills": "tableau",
    "demand_count": "307"
  },
  {
    "skills": "r",
    "demand_count": "192"
  },
  {
    "skills": "excel",
    "demand_count": "173"
  }
]
This analysis highlights the critical skills for data analysts in Berlin, Germany. 
    - SQL tops the list, underscoring its importance in data manipulation and querying. 
    - Python follows closely, reflecting its versatility in data analysis and machine learning tasks. 
    - Tableau's presence indicates a strong demand for data visualization skills, essential for interpreting and presenting data insights effectively. 
    - R, known for statistical analysis.
    - and Excel, a fundamental tool for data handling, round out the top five skills.
Together, these skills form a robust foundation for data analysts aiming to excel in the competitive job market of Berlin.
*/
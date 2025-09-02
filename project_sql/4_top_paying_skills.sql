/*
Question: What are the top skills based on salary, in Berlin?
- Look at the average salary associated with each skill for Data Analyst jobs in Berlin, Germany.
- Focus on roles with specified salaries (remove nulls).
- Why? It reveals how different skills impact salary levels for Data Analysts and helps identify the most financially rewarding skills to acquire or improve.
*/

SELECT
    skills,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0)  AS avg_salary -- Average salary rounded to the nearest whole number
FROM job_postings_fact
-- Join with skills_job_dim to link job postings with skills
-- Use INNER JOIN to ensure only jobs with associated skills are considered
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
-- Filter for Data Analyst jobs in Berlin, Germany with non-null salaries
WHERE
    job_title_short = 'Data Analyst'
    AND job_location = 'Berlin, Germany'
    AND salary_year_avg IS NOT NULL
-- Group by skill to calculate average salary per skill
GROUP BY
    skills
-- Order by average salary in descending order and limit to top 10 skills
ORDER BY
    avg_salary DESC
LIMIT 10;

/*
The top 10 highest-paying skills for data analysts in Berlin, Germany are:
[
  {
    "skills": "power bi",
    "avg_salary": "166420"
  },
  {
    "skills": "python",
    "avg_salary": "111574"
  },
  {
    "skills": "r",
    "avg_salary": "111189"
  },
  {
    "skills": "matlab",
    "avg_salary": "111175"
  },
  {
    "skills": "git",
    "avg_salary": "105000"
  },
  {
    "skills": "atlassian",
    "avg_salary": "102500"
  },
  {
    "skills": "aws",
    "avg_salary": "100500"
  },
  {
    "skills": "tableau",
    "avg_salary": "92830"
  },
  {
    "skills": "sql",
    "avg_salary": "86892"
  },
  {
    "skills": "sap",
    "avg_salary": "78007"
  }
]

This analysis highlights the most financially rewarding skills for data analysts in Berlin, Germany. 
    - Power BI tops the list, indicating its high value in the job market for data visualization and business intelligence tasks. 
    - Programming languages like Python and R follow closely, reflecting their importance in data analysis, statistical computing, and machine learning. 
    - Other technical skills such as MATLAB, Git, Atlassian tools, and AWS also feature prominently, showcasing the diverse skill set that can lead to higher salaries in this field. 
    - SQL and Tableau, while essential for data manipulation and visualization, offer comparatively lower average salaries but remain critical skills for data analysts. 
    - SAP, a widely used enterprise software, rounds out the top ten, indicating its relevance in certain industries.
Overall, acquiring and honing these skills can significantly enhance a data analyst's earning potential in Berlin's competitive job market.
*/
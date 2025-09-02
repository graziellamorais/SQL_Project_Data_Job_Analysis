/*
Question: What are the most optimal skills to learn (aka it's in high demand and pays well) for data analysts in Berlin, Germany?
- Identify skills in high demand and associated with high average salaries for Data Analyst jobs in Berlin, Germany.
- Concentrates on positions with specified salaries (removes nulls).
- Why? Targets skills that offer job security (high demand) and financial benefits (high pay), guiding job seekers on which skills to prioritize for career advancement.
*/

-- Create a CTE to calculate the demand for each skill associated with Data Analyst jobs in Berlin, Germany
WITH skills_demand AS (
    SELECT
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS demand_count
    FROM job_postings_fact
    -- Join with skills_job_dim to link job postings with skills
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    -- Join with skills_dim to get skill names
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    -- Filter for Data Analyst jobs in Berlin, Germany with non-null salaries
    WHERE
        job_title_short = 'Data Analyst'
        AND job_location = 'Berlin, Germany'
        AND salary_year_avg IS NOT NULL
    -- Group by skill_id to calculate demand count per skill
    GROUP BY
        skills_dim.skill_id
), average_salary AS ( -- CTE to calculate the average salary for each skill associated with Data Analyst jobs in Berlin, Germany
    SELECT
        skills_dim.skill_id,
        ROUND(AVG(job_postings_fact.salary_year_avg), 0)  AS avg_salary -- Average salary rounded to the nearest whole number
    FROM job_postings_fact
    -- Join with skills_job_dim to link job postings with skills
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    -- Filter for Data Analyst jobs in Berlin, Germany with non-null salaries
    WHERE
        job_title_short = 'Data Analyst'
        AND job_location = 'Berlin, Germany'
        AND salary_year_avg IS NOT NULL
    -- Group by skill_id to calculate average salary per skill
    GROUP BY
        skills_dim.skill_id
)

-- Combine the demand and average salary CTEs to find the most optimal skills
SELECT
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    avg_salary
FROM 
    skills_demand
-- Join with average_salary CTE to get the average salary for each skill
INNER JOIN average_salary ON skills_demand.skill_id = average_salary.skill_id
WHERE demand_count > 2 -- Filter to include only skills with demand count greater than 2
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 10;

-- Rewriting this same query more concisely
SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0)  AS avg_salary -- Average salary rounded to the nearest whole number
FROM job_postings_fact
-- Join with skills_job_dim to link job postings with skills
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
-- Join with skills_dim to get skill names
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
-- Filter for Data Analyst jobs in Berlin, Germany with non-null salaries
WHERE
    job_title_short = 'Data Analyst'
    AND job_location = 'Berlin, Germany'
    AND salary_year_avg IS NOT NULL
-- Group by skill_id to calculate demand count and average salary per skill
GROUP BY
    skills_dim.skill_id
HAVING COUNT(skills_job_dim.job_id) > 2 -- Filter to include only skills with demand count greater than 2
ORDER BY
    avg_salary DESC,
    demand_count DESC;

/*
The most optimal skills for data analysts in Berlin, Germany, balancing high demand and high average salaries are:
    [
  {
    "skill_id": 1,
    "skills": "python",
    "demand_count": "4",
    "avg_salary": "111574"
  },
  {
    "skill_id": 182,
    "skills": "tableau",
    "demand_count": "8",
    "avg_salary": "92830"
  },
  {
    "skill_id": 0,
    "skills": "sql",
    "demand_count": "8",
    "avg_salary": "86892"
  },
  {
    "skill_id": 185,
    "skills": "looker",
    "demand_count": "4",
    "avg_salary": "67054"
  }
]
This analysis identifies key skills that are both in high demand and associated with higher average salaries for Data Analyst roles in Berlin, Germany. 
    - Python stands out as the most optimal skill, combining a strong demand with the highest average salary, highlighting its critical role in data analysis and machine learning.
    - Tableau and SQL also emerge as essential skills, each with significant demand and respectable average salaries, underscoring their importance in data visualization and database management, respectively.
    - Looker, while having a lower average salary compared to the top skills, still shows a notable demand, indicating its relevance in the data analytics landscape.
Overall, these skills represent valuable assets for Data Analysts aiming to enhance their employability and earning potential
*/
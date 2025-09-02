/*
Question: What are the top-paying data alayst jobs?
- Identify the top 10 highest-paying Data Analyst roles that are available in Berlin, Germany.
- Focuses on job postings with specified salaries (remove nulls).
- Why? Highlight the top-paying opportunities for Data Analysts in Berlin, Germany, offering insights into employment opportunities in this location.
*/

-- Query to find the top 10 highest-paying Data Analyst jobs in Berlin, Germany
SELECT 
    job_id,
    job_title,
    name AS company_name,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date
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
LIMIT 10;

/*
The top 10 highest-paying Data Analyst jobs in Berlin, Germany are:
[
  {
    "job_id": 59701,
    "job_title": "Head of Data Analytics",
    "company_name": "Volt.io",
    "job_location": "Berlin, Germany",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "166419.5",
    "job_posted_date": "2023-04-18 06:15:58"
  },
  {
    "job_id": 537995,
    "job_title": "Data Analyst/Manager - Last Mile Planning (m/f/d)",
    "company_name": "Flink",
    "job_location": "Berlin, Germany",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "111202.0",
    "job_posted_date": "2023-01-13 20:23:50"
  },
  {
    "job_id": 573605,
    "job_title": "Principal Data Analyst - Growth",
    "company_name": "SumUp",
    "job_location": "Berlin, Germany",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "111175.0",
    "job_posted_date": "2023-04-24 15:15:33"
  },
  {
    "job_id": 181752,
    "job_title": "Data Analyst:in mit Schwerpunkt Marketing",
    "company_name": "Vattenfall",
    "job_location": "Berlin, Germany",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "111175.0",
    "job_posted_date": "2023-08-24 19:42:01"
  },
  {
    "job_id": 432207,
    "job_title": "Data Analyst - SME Sales",
    "company_name": "SumUp",
    "job_location": "Berlin, Germany",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "105000.0",
    "job_posted_date": "2023-07-05 04:12:13"
  },
  {
    "job_id": 929216,
    "job_title": "Data Analyst",
    "company_name": "Veeva Systems",
    "job_location": "Berlin, Germany",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "102500.0",
    "job_posted_date": "2023-01-16 10:59:59"
  },
  {
    "job_id": 956581,
    "job_title": "Data Analyst (f/m/d) Berlin",
    "company_name": "SIGNA Sports United",
    "job_location": "Berlin, Germany",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "100500.0",
    "job_posted_date": "2023-08-30 09:30:44"
  },
  {
    "job_id": 98385,
    "job_title": "Data Model Manager",
    "company_name": "AVIV Group",
    "job_location": "Berlin, Germany",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "89100.0",
    "job_posted_date": "2023-02-04 17:05:13"
  },
  {
    "job_id": 188203,
    "job_title": "Data Model Manager",
    "company_name": "AVIV Group",
    "job_location": "Berlin, Germany",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "89100.0",
    "job_posted_date": "2023-04-28 07:15:11"
  },
  {
    "job_id": 1204219,
    "job_title": "SEO Data Analyst (f/m/x)",
    "company_name": "AUTO1 Group",
    "job_location": "Berlin, Germany",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "57500.0",
    "job_posted_date": "2023-07-01 11:10:02"
  }
]
*/
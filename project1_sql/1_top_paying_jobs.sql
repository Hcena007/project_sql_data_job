/*
Question: What are the top—paying data analyst jobs?
— Identify the top 10 highest—paying Data Analyst roles that are available remotely.
— Focuses on job postings with specified salaries (remove nulls).
- Why? Highlight the top-paying opportunities for Data Analysts, offering insights into
*/
SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name as company_name
from job_postings_fact
 JOIN company_dim ON job_postings_fact.company_id=company_dim.company_id
WHERE job_title_short = 'Data Analyst' AND salary_year_avg is not NULL
 AND job_location = 'Anywhere'
ORDER BY
    salary_year_avg DESC
LIMIT 10;
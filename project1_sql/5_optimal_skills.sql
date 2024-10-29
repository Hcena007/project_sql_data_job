

WITH skills_demand AS(
    SELECT 
   skills_dim.skill_id,
   skills_dim.skills,
   
    count(skills_job_dim.job_id) AS demand_count

    from job_postings_fact
    INNER JOIN skills_job_dim on skills_job_dim.job_id=job_postings_fact.job_id
    INNER JOIN skills_dim on skills_dim.skill_id=skills_job_dim.skill_id
    WHERE job_title_short='Data Analyst' AND job_work_from_home=TRUE
    AND salary_year_avg is NOT NULL
    GROUP BY
        skills_dim.skill_id
        
),average_salary AS (
    SELECT 
    skills_job_dim.skill_id,
   
    ROUND(AVG(job_postings_fact.salary_year_avg),0) AS avg_salary

    from job_postings_fact
    INNER JOIN skills_job_dim on skills_job_dim.job_id=job_postings_fact.job_id
    INNER JOIN skills_dim on skills_dim.skill_id=skills_job_dim.skill_id
    WHERE job_title_short='Data Analyst' AND salary_year_avg is NOT NULL
    AND job_work_from_home=TRUE
    GROUP BY
         skills_job_dim.skill_id  
        
    )
SELECT
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    avg_salary
FROM skills_demand INNER JOIN average_salary ON skills_demand.skill_id=average_salary.skill_id
ORDER BY
    demand_count DESC,
    avg_salary DESC

--rewriting same query more concisely


   SELECT 
   skills_dim.skill_id,
   skills_dim.skills,
   count(skills_job_dim.job_id) AS demand_count,
   ROUND(AVG(job_postings_fact.salary_year_avg),0) AS avg_salary
FROM job_postings_fact 
INNER JOIN skills_job_dim on skills_job_dim.job_id=job_postings_fact.job_id
INNER JOIN skills_dim on skills_dim.skill_id=skills_job_dim.skill_id
WHERE
    job_title_short='Data Analyst' 
    AND salary_year_avg is NOT NULL
    AND job_work_from_home=TRUE
    GROUP BY
    skills_dim.skill_id
    having 
       count(skills_job_dim.job_id) > 10
    ORDER BY
    demand_count DESC,
    avg_salary DESC
    LIMIT 25
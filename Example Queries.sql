

#//Sort employees by Assistant level employee Salary only in descending order//

SELECT 
	last_name, substring(job_title from 10) as "Title (Assistant Level Only)" , round(sum(salary),2)
FROM 
	staff
where 
	job_title LIKE 'Assistant%'
group by
	last_name, job_title
order by 
	sum(salary) desc

#//List employees with the largest deviation in salary from the department average in order from highest to lowest deviation.

SELECT 
	s1.last_name,
	s1.salary,
	s1.job_title,
	s1.department,
	(SELECT round(avg(salary)) FROM staff s2 WHERE s2.department = s1.department)  "Avg salary",
	round(((s1.salary - (SELECT round(avg(salary)) FROM staff s2 WHERE s2.department = s1.department))/s1.salary),2)  "Deviation from average salary"
	FROM 
		staff s1
	ORDER BY "Deviation from average salary"

#//List engineering employees with the largest deviation in salary from the department average in order from highest to lowest deviation.

SELECT 
	s1.last_name,
	s1.salary,
	s1.job_title,
	s1.department,
	(SELECT round(avg(salary)) FROM staff s2 WHERE s2.department = s1.department)  "Avg salary",
	round(((s1.salary - (SELECT round(avg(salary)) FROM staff s2 WHERE s2.department = s1.department))/s1.salary),2)  "Deviation from average salary"
FROM 
		staff s1
WHERE s1.job_title like '%Engineer'
ORDER BY "Deviation from average salary"



#//List employees and their deviation from the max salary of their job title in descending order

SELECT 
	job_title,
	department,
	last_name,
	salary,
	(max(salary) OVER (partition by job_title order by salary desc)-salary) "prev"
	FROM
	staff




//# Evaluate employees by their deviation from the max salary for their job title by tenure.
SELECT 
	job_title,
	department,
	last_name,
	age(current_date, start_date), 	
	salary,
	(max(salary) OVER (partition by job_title order by salary desc)-salary) "prev"
FROM
	staff
###########################
# Esther Lowe             #
# 07/18/2019              #
# Company History Queries #
###########################


-- 1. List the following details of each employee:
-- employee number, last name, first name, gender, and salary.
SELECT "Employees".emp_no, "Employees".last_name, "Employees".first_name,
	"Employees".gender, "Salaries".salary
FROM "Employees"
LEFT JOIN "Salaries"
ON "Salaries".emp_no = "Employees".emp_no;

-- 2. List employees who were hired in 1986.
SELECT "emp_no", "hire_date" FROM "Employees"
WHERE "hire_date" >= '1986-01-01'::date
AND "hire_date" <= '1986-12-31'::date;

-- 3. List the manager of each department with the following information:
-- department number, department name, the manager's employee number,
-- last name, first name, and start and end employment dates.
SELECT "Employees".emp_no, "Employees".last_name, "Employees".first_name, "Dept_Managers".from_date,
	"Dept_Managers".to_date, "Dept_Managers".dept_no, "Departments".dept_name
FROM "Employees"
INNER JOIN "Dept_Managers"
	ON "Dept_Managers".emp_no = "Employees".emp_no
INNER JOIN "Departments"
	ON "Departments".dept_no = "Dept_Managers".dept_no;

-- 4. List the department of each employee with the following information:
-- employee number, last name, first name, and department name.
SELECT emp.emp_no, emp.last_name, emp.first_name, dep.dept_name
FROM "Employees" AS emp
INNER JOIN "Dept_Employees" AS dep_emp
	ON emp.emp_no = dep_emp.emp_no
INNER JOIN "Departments" AS dep
	ON dep.dept_no = dep_emp.dept_no

UNION

SELECT emp.emp_no, emp.last_name, emp.first_name, dep.dept_name
FROM "Employees" AS emp
INNER JOIN "Dept_Managers" AS dep_man
	ON emp.emp_no = dep_man.emp_no
INNER JOIN "Departments" AS dep
	ON dep.dept_no = dep_man.dept_no;

-- 5. List all employees whose first name is "Hercules" and last names begin with "B."
SELECT * FROM "Employees"
WHERE first_name = 'Hercules' AND last_name like 'B%';

-- 6. List all employees in the Sales department, including their:
--employee number, last name, first name, and department name.

SELECT emp.emp_no, emp.first_name, emp.last_name, 'Sales' AS Department_Name
FROM "Employees" AS emp
WHERE emp.emp_no IN (
	SELECT dep_emp.emp_no
	FROM "Dept_Employees" AS dep_emp
	WHERE dep_emp.dept_no IN (
		SELECT dep.dept_no
		FROM "Departments" AS dep
		WHERE dept_name = 'Sales'));

-- 7. List all employees in the Sales and Development departments,
--including their employee number, last name, first name, and department name.
SELECT emp.emp_no, emp.first_name, emp.last_name, dep.dept_name
FROM "Employees" AS emp
INNER JOIN "Dept_Employees" AS dep_emp
	ON dep_emp.emp_no = emp.emp_no
INNER JOIN "Departments" AS dep
	ON dep.dept_no = dep_emp.dept_no
WHERE dep.dept_name = 'Sales' OR dep.dept_name = 'Development'

UNION

SELECT emp.emp_no, emp.first_name, emp.last_name, dep.dept_name
FROM "Employees" AS emp
INNER JOIN "Dept_Managers" AS dep_man
	ON dep_man.emp_no = emp.emp_no
INNER JOIN "Departments" AS dep
	ON dep.dept_no = dep_man.dept_no
WHERE dep.dept_name = 'Sales' OR dep.dept_name = 'Development';
	
-- 8. In descending order, list the frequency count of employee last names,
-- i.e., how many employees share each last name.
SELECT "Employees".last_name, COUNT("Employees".last_name) AS Shared_Name
FROM "Employees"
GROUP BY "Employees".last_name;

SELECT COUNT( *) FROM "Employees" WHERE last_name = 'Breugel';

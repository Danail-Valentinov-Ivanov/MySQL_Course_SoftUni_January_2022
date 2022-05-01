-- p1
SELECT * FROM departments
ORDER BY department_id;
-- p2
SELECT `name` FROM departments
ORDER BY department_id;
-- p3
SELECT first_name, last_name, salary FROM employees
ORDER BY employee_id;
-- p4
SELECT first_name, middle_name, last_name FROM employees
ORDER BY employee_id;
-- p5
SELECT concat(first_name, '.', last_name, '@softuni.bg') AS 'full_email_address'
FROM employees;
-- p6
SELECT DISTINCT salary FROM employees;
-- p7
SELECT * FROM employees
WHERE job_title = 'Sales Representative';
-- p8
SELECT first_name, last_name, job_title FROM employees
WHERE salary BETWEEN 20000 AND 30000
ORDER BY employee_id;
-- p9
SELECT concat(first_name, ' ', middle_name, ' ', last_name) AS 'Full Name'
FROM employees
WHERE salary IN (25000, 14000, 12500, 23600);
-- p10
SELECT first_name, last_name FROM employees
WHERE manager_id IS NULL;
-- p11
SELECT first_name, last_name, salary FROM employees
WHERE salary > 50000
ORDER BY salary DESC;
-- p12
SELECT first_name, last_name FROM employees
ORDER BY salary DESC LIMIT 5;
-- p13
SELECT first_name, last_name FROM employees
WHERE NOT department_id = 4;
-- 14
SELECT * FROM employees
ORDER BY salary DESC,
first_name,
last_name DESC,
middle_name,
employee_id;
-- p15
CREATE VIEW v_employees_salaries AS
SELECT first_name, last_name, salary FROM employees;
-- p16
CREATE VIEW v_employees_job_titles AS
SELECT concat_ws(' ', first_name, middle_name, last_name) AS 'full_name',
job_title FROM employees;
-- p17
SELECT DISTINCT job_title FROM employees ORDER BY job_title;
-- p18
SELECT * FROM projects
ORDER BY start_date,
`name`
LIMIT 10;
-- p19
SELECT first_name, last_name, hire_date FROM employees
ORDER BY hire_date DESC LIMIT 7;
-- p20
UPDATE employees 
SET salary = salary * 1.12
WHERE department_id IN (1, 2, 4, 11);
SELECT salary FROM employees;
-- p21
SELECT peak_name FROM peaks
ORDER BY peak_name;
-- p22
SELECT country_name, population FROM countries
WHERE continent_code = 'EU'
ORDER BY population DESC,
country_name
LIMIT 30;
-- p23
SELECT country_name, country_code, if(currency_code = 'EUR', 'Euro', 'Not Euro')
AS 'currency' FROM countries
ORDER BY country_name;
-- p24
SELECT `name` FROM characters
ORDER BY `name`;
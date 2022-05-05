-- p1
SELECT employee_id, job_title, e.address_id, address_text FROM employees as e 
JOIN addresses as a ON e.address_id = a.address_id
ORDER BY e.address_id
LIMIT 5;
-- p2
SELECT first_name, last_name, `name` as town, address_text FROM employees as e 
JOIN addresses as a ON e. address_id = a. address_id
JOIN towns as t ON a.town_id = t.town_id
ORDER BY first_name, last_name
LIMIT 5;
-- p3
SELECT employee_id, first_name, last_name, `name` as department_name FROM employees as e 
JOIN departments as d ON e.department_id = d.department_id
WHERE `name` = 'Sales'
ORDER BY employee_id DESC;
-- p4
SELECT employee_id, first_name, salary, `name` as department_name FROM employees as e 
JOIN departments as d
ON e.department_id = d.department_id
WHERE salary > 15000
ORDER BY d.department_id DESC
LIMIT 5;
-- p5
SELECT e. employee_id, e.first_name FROM employees as e 
LEFT JOIN employees_projects as ep ON e.employee_id = ep.employee_id
LEFT JOIN projects as p ON ep.project_id = p.project_id
WHERE ep.project_id IS NULL
ORDER BY e.employee_id DESC
LIMIT 3;
-- p6
SELECT e.first_name, e.last_name, e.hire_date, d.`name` as dept_name FROM employees as e
JOIN departments as d ON e.department_id = d.department_id
WHERE hire_date > '1999-01-01'
AND d.`name` IN ('Sales', 'Finance')
ORDER BY hire_date;
-- p7
SELECT e.employee_id, e.first_name, p.`name` as project_name FROM employees as e 
JOIN employees_projects as ep ON e.employee_id = ep.employee_id
JOIN projects as p ON p.project_id = ep.project_id
WHERE DATE(p.start_date) > '2002-08-13' 
AND p.end_date IS NULL
ORDER BY e.first_name, p.`name`
LIMIT 5;
-- p8
SELECT e.employee_id, e.first_name, if(year(p.start_date) >= '2005', null, p.`name`)  as project_name 
FROM employees as e 
JOIN employees_projects as ep ON e.employee_id = ep.employee_id
JOIN projects as p ON p.project_id = ep.project_id
WHERE e.employee_id = 24
ORDER BY p.`name`;
-- p9
SELECT e. employee_id, e.first_name, m.employee_id as manager_id, m.first_name as manager_name FROM employees as e
JOIN employees as m ON e.manager_id = m.employee_id
WHERE m.employee_id IN (3, 7)
ORDER BY e.first_name;
-- p10
SELECT e. employee_id, concat_ws(' ', e.first_name, e.last_name) as employee_name, 
concat_ws(' ', m.first_name, m.last_name) as manager_name, d.name as departmant_name 
FROM employees as e
JOIN employees as m ON e.manager_id = m.employee_id
JOIN departments as d ON e.department_id = d.department_id
ORDER BY e.employee_id
LIMIT 5;
-- p11
SELECT avg(salary) as min_average_salary FROM employees
GROUP BY department_id
ORDER BY min_average_salary
LIMIT 1;
-- p12
SELECT c.country_code, m.mountain_range, p.peak_name, p.elevation FROM countries as c
JOIN mountains_countries as mc ON c.country_code = mc.country_code
JOIN mountains as m ON mc.mountain_id = m.id
JOIN peaks as p ON m.id = p.mountain_id
WHERE c.country_code = 'BG' AND p.elevation > 2835
ORDER BY p.elevation DESC;
-- p13
SELECT c.country_code, count(mountain_id) as mountain_range FROM countries as c
JOIN mountains_countries as mc ON c.country_code = mc.country_code
JOIN mountains as m ON mc.mountain_id = m.id
GROUP BY c.country_code
HAVING c.country_code IN('US', 'RU', 'BG')
ORDER BY mountain_range DESC;
-- p14
SELECT c.country_name, r.river_name FROM countries as c
LEFT JOIN countries_rivers as cr ON c.country_code = cr.country_code
LEFT JOIN rivers as r ON cr.river_id = r.id
WHERE c.continent_code LIKE 'AF'
ORDER BY c.country_name
LIMIT 5;
-- p16
SELECT count(c.country_code) as country_count FROM countries as c
LEFT JOIN mountains_countries as mc ON c.country_code = mc.country_code
WHERE mc.mountain_id IS NULL;
-- p17
SELECT c.country_name, max(p.elevation) as highest_peak_elevation, 
max(r.length) as longest_river_length 
FROM countries as c
LEFT JOIN mountains_countries as mc ON c.country_code = mc.country_code
LEFT JOIN mountains as m ON mc.mountain_id = m.id
LEFT JOIN peaks as p ON m.id = p.mountain_id
LEFT JOIN countries_rivers as cr ON c.country_code = cr.country_code
LEFT JOIN rivers as r ON cr.river_id = r.id
GROUP BY c.country_name
ORDER BY highest_peak_elevation DESC, longest_river_length DESC, c.country_name
LIMIT 5;
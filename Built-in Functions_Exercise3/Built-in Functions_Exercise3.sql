-- p1
SELECT first_name, last_name FROM employees
WHERE lower(substring(first_name, 1, 2)) = 'sa'
ORDER BY employee_id;
-- p2
SELECT first_name, last_name FROM employees
WHERE lower(last_name) LIKE '%ei%'
ORDER BY employee_id;
-- p3
SELECT first_name FROM employees
WHERE (department_id = 3 OR department_id = 10)
AND year(hire_date) BETWEEN 1995 AND 2005
ORDER BY employee_id;
-- p4
SELECT first_name, last_name FROM employees
WHERE job_title NOT LIKE '%engineer%'
ORDER BY employee_id;
-- p5
SELECT `name` FROM towns
WHERE char_length(`name`) IN (5, 6)
ORDER BY `name`;
-- p6
SELECT * FROM towns
WHERE lower(`name`) LIKE 'm%'
OR lower(`name`) LIKE 'k%'
OR lower(`name`) LIKE 'b%'
OR lower(`name`) LIKE 'e%'
ORDER BY `name`;
-- p7
SELECT * FROM towns
WHERE lower(`name`) NOT LIKE 'r%'
AND lower(`name`) NOT LIKE 'b%'
AND lower(`name`) NOT LIKE 'd%'
ORDER BY `name`;
-- p8
CREATE VIEW v_employees_hired_after_2000 AS
SELECT first_name, last_name FROM employees
WHERE year(hire_date) > '2000';
SELECT * FROM v_employees_hired_after_2000;
-- p9
SELECT first_name, last_name FROM employees
WHERE char_length(last_name) LIKE 5;
-- p10
SELECT country_name, iso_code FROM countries
WHERE lower(country_name) LIKE '%a%a%a%'
ORDER BY iso_code;
-- p11
SELECT peak_name, river_name, lower(concat(left(peak_name, char_length(peak_name) - 1), river_name)) AS 'mix'
FROM peaks, rivers
WHERE lower(right(peak_name, 1)) LIKE lower(left(river_name, 1))
ORDER BY mix;
-- p12
SELECT `name`, date_format(`start`, '%Y-%m-%d') AS `start` FROM games
WHERE year(`start`) IN (2011, 2012)
ORDER BY `start`, `name`
LIMIT 50;
-- p13
SELECT user_name, regexp_replace(email, '.*@', '') AS `email provider` FROM users
ORDER BY `email provider`, user_name;
-- p14
SELECT user_name, ip_address FROM users
WHERE ip_address LIKE '___.1%.%.___'
ORDER BY user_name;
-- p15
SELECT `name` AS game, 
CASE 
WHEN date_format(`start`, '%H')  BETWEEN 0 AND 11 THEN 'Morning'
WHEN date_format(`start`, '%H')  BETWEEN 12 AND 17 THEN 'Afternoon'
WHEN date_format(`start`, '%H')  BETWEEN 18 AND 23 THEN 'Evening'
END AS `Part of the Day`, 
CASE
WHEN duration <= 3 THEN 'Extra Short'
WHEN duration BETWEEN 3 AND 6 THEN 'Short'
WHEN duration BETWEEN 6 AND 10 THEN 'Long'
ELSE 'Extra Long'
END AS Duration FROM games;
-- p16
SELECT product_name, order_date,
adddate(order_date, INTERVAL 3 DAY) AS pay_due,
adddate(order_date, INTERVAL 1 MONTH) AS deliver_due FROM orders;
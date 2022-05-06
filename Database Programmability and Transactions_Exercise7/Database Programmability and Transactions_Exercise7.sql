-- p1
DELIMITER $$
CREATE PROCEDURE usp_get_employees_salary_above_35000()
BEGIN
SELECT first_name, last_name FROM employees
WHERE salary > 35000
ORDER BY first_name, last_name, employee_id;
END $$
DELIMITER ;
CALL usp_get_employees_salary_above_35000();
-- p2
delimiter $
CREATE PROCEDURE usp_get_employees_salary_above(some_number DECIMAL(10, 4))
BEGIN
SELECT first_name, last_name FROM employees
WHERE salary >= some_number
ORDER BY first_name, last_name, employee_id;
END $
delimiter ;
CALL usp_get_employees_salary_above(45000);
-- p3
delimiter $
CREATE PROCEDURE usp_get_towns_starting_with(some_name VARCHAR(100))
BEGIN
SELECT name FROM towns
WHERE name LIKE concat(some_name, '%')
ORDER BY name;
END $
delimiter ;
CALL usp_get_towns_starting_with('b');
-- p4
delimiter $
CREATE PROCEDURE usp_get_employees_from_town(town_name VARCHAR(100))
BEGIN
SELECT e.first_name, e.last_name FROM employees as e
JOIN addresses as a ON e.address_id = a.address_id
JOIN towns as t ON a.town_id = t.town_id
WHERE t.name = town_name
ORDER BY e.first_name, e.last_name, e.employee_id;
END $
delimiter ;
CALL usp_get_employees_from_town('Sofia');
-- p5
delimiter $
CREATE FUNCTION ufn_get_salary_level(some_salary DECIMAL(10, 2))
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
DECLARE result VARCHAR(100);
IF some_salary < 30000 THEN SET result = 'Low';
ELSEIF some_salary <= 50000 THEN SET result = 'Average';
ELSE SET result = 'High';
END IF;
RETURN result;
END $
delimiter ;
SELECT salary, ufn_get_salary_level(salary) as salary_Level FROM employees;
-- p6
delimiter $
CREATE PROCEDURE usp_get_employees_by_salary_level(salary_level VARCHAR(100))
BEGIN
SELECT first_name, last_name FROM employees
WHERE ufn_get_salary_level(salary) LIKE salary_level
ORDER BY first_name DESC, last_name DESC;
END $
delimiter ;
CALL usp_get_employees_by_salary_level('High');
-- p7
delimiter $
CREATE FUNCTION ufn_is_word_comprised(set_of_letters VARCHAR(50), word VARCHAR(50))
RETURNS INT
DETERMINISTIC
BEGIN
RETURN (CASE
WHEN lower(word) REGEXP concat('^[', set_of_letters, ']+$') THEN 1
ELSE 0
END);
END $
delimiter ;
CREATE TABLE set_of_letters_word(
set_of_letters varchar(100),
word varchar(100)
);
INSERT INTO set_of_letters_word (set_of_letters, word)
VALUES 
('oistmiahf', 'Sofia'),
('oistmiahf', 'halves'),
('bobr', 'Rob'),
('pppp', 'Guy');
SELECT set_of_letters, word, ufn_is_word_comprised(set_of_letters, word) as result from set_of_letters_word;
-- p8
delimiter $
CREATE PROCEDURE usp_get_holders_full_name()
BEGIN
SELECT concat_ws(' ', first_name, last_name) as full_name FROM account_holders
ORDER BY full_name, id;
END $
delimiter ;
CALL usp_get_holders_full_name();
-- p10
delimiter $
CREATE FUNCTION ufn_calculate_future_value(`sum` DECIMAL(10, 4), yearly_interest_rate DOUBLE(7, 4), number_of_years INT)
RETURNS DECIMAL (10, 4)
DETERMINISTIC
BEGIN
RETURN (`sum` * (pow((1 + yearly_interest_rate), number_of_years)));
END $
delimiter ;usp_calculate_future_value_for_account
SELECT ufn_calculate_future_value(1000, 0.5, 5) as Output;
-- p11
delimiter $
CREATE PROCEDURE usp_calculate_future_value_for_account(id INT, interest_rate DOUBLE(7, 4))
BEGIN
SELECT a.id as account_id, ah.first_name, ah.last_name, a.balance as current_balance,
ufn_calculate_future_value(a.balance, interest_rate, 5) as balance_in_5_year FROM accounts as a
JOIN account_holders as ah ON a.account_holder_id = ah.id
WHERE a.id = id;
END $
delimiter ;
CALL usp_calculate_future_value_for_account(1, 0.1);
-- p12
delimiter $
CREATE PROCEDURE usp_deposit_money(account_id INT, money_amount DECIMAL(20, 4)) 
BEGIN
START TRANSACTION;
IF money_amount <= 0 THEN ROLLBACK;
ELSE UPDATE accounts
SET balance = balance + money_amount
WHERE id = account_id;
END IF;
END $
delimiter ;
CALL usp_deposit_money(1, 10);
SELECT * FROM accounts
WHERE id = 1;
-- p13
delimiter $
CREATE PROCEDURE usp_withdraw_money(account_id INT, money_amount DECIMAL(20, 4)) 
BEGIN
START TRANSACTION;
IF money_amount <= 0 OR (SELECT balance FROM accounts WHERE id = account_id) - money_amount < 0 THEN ROLLBACK;
ELSE UPDATE accounts
SET balance = balance - money_amount
WHERE id = account_id;
END IF;
END $
delimiter ;
CALL usp_withdraw_money(1, 10);
SELECT * FROM accounts
WHERE id = 1;
-- p14
delimiter $
CREATE FUNCTION ufn_result(from_account_id INT, to_account_id INT)
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
DECLARE result BOOLEAN;
IF from_account_id BETWEEN 1 AND (SELECT max(id) FROM accounts)
AND to_account_id BETWEEN 1 AND (SELECT max(id) FROM accounts)
THEN SET result := TRUE;
ELSE SET result := FALSE;
END IF;
RETURN result;
END $
delimiter ;
delimiter $
CREATE PROCEDURE usp_transfer_money(from_account_id INT, to_account_id INT, amount DECIMAL(20, 4))
BEGIN
START TRANSACTION;
IF (SELECT ufn_result(from_account_id, to_account_id)) IS FALSE
OR amount <= 0 OR (SELECT balance FROM accounts WHERE id = from_account_id) - amount < 0
OR from_account_id = to_account_id THEN ROLLBACK;
ELSE UPDATE accounts
SET balance = balance - amount
WHERE id = from_account_id;
UPDATE accounts
SET balance = balance + amount
WHERE id = to_account_id;
END IF;
END $
delimiter ;
CALL usp_transfer_money(1, 2, 10);
SELECT * FROM accounts
LIMIT 2;
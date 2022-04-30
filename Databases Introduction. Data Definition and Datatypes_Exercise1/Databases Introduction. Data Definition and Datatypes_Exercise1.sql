-- p1
CREATE TABLE `minions` (
`id` INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(30),
`age` INT
);
-- DROP TABLE minions;
-- DROP TABLE towns;
CREATE TABLE `towns` (
`town_id` INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(30)
);
-- p2
ALTER TABLE towns
CHANGE COLUMN town_id id INT;

ALTER TABLE minions
ADD COLUMN town_id INT,
ADD CONSTRAINT fk_minions_towns
FOREIGN KEY minions(town_id)
REFERENCES towns(id);
-- p3
INSERT INTO towns(id, `name`)
VALUES (1, 'Sofia'),
 (2, 'Plovdiv'),
 (3, 'Varna');
 
INSERT INTO minions(id, `name`, age, town_id)
VALUES ('1', 'Kevin', '22', '1'),
 ('2', 'Bob', '15', '3'),
 ('3', 'Steward', NULL, '2');
 -- p4
 TRUNCATE TABLE minions;
 -- p5
 DROP TABLE minions;
 DROP TABLE towns;
 -- p6
 CREATE TABLE people (
 id INT PRIMARY KEY AUTO_INCREMENT,
 `name` CHAR (200) NOT NULL,
 `picture` BLOB,
 height DOUBLE(7, 2),
 weight DOUBLE(7, 2),
 gender CHAR(1) NOT NULL,
 birthdate DATETIME NOT NULL,
 biography TEXT
 );
 INSERT INTO people(`name`, gender, birthdate)
 VALUES
 ('Dido', 'm', '1981-07-07'),
 ('Dido', 'm', '1981-07-07'),
 ('Dido', 'm', '1981-07-07'),
 ('Dido', 'm', '1981-07-07'),
 ('Dido', 'm', '1981-07-07');
-- p7
CREATE TABLE users (
id INT PRIMARY KEY AUTO_INCREMENT,
username CHAR(30) NOT NULL,
`password` CHAR(26) NOT NULL,
profile_picture BLOB,
last_login_time DATETIME,
is_deleted BOOLEAN
);
 INSERT INTO users(`username`, `password`)
 VALUES
 ('Dido', 'm'),
 ('Dido', 'm'),
 ('Dido', 'm'),
 ('Dido', 'm'),
 ('Dido', 'm');
-- p8
ALTER TABLE users
DROP PRIMARY KEY,
ADD CONSTRAINT pk_users
PRIMARY KEY users(id, username);
-- p9
ALTER TABLE users
CHANGE COLUMN last_login_time last_login_time
TIMESTAMP DEFAULT NOW();
-- p10
ALTER TABLE users
DROP PRIMARY KEY,
ADD CONSTRAINT pk_users
PRIMARY KEY users(id),
ADD CONSTRAINT unicue
UNIQUE users(username);
-- p11
DROP SCHEMA movies;
DROP TABLE directors;
DROP TABLE genres;
DROP TABLE categories;
DROP TABLE movies;
-- p12
 CREATE TABLE categories (
 id INT PRIMARY KEY AUTO_INCREMENT,
 category VARCHAR(30) NOT NULL,
 daily_rate DOUBLE,
 weekly_rate DOUBLE,
 monthly_rate DOUBLE,
 weekend_rate DOUBLE
 );
 INSERT INTO categories(category)
 VALUES 
 ('comedy'),
 ('drama'),
 ('ection');

 CREATE TABLE cars (
 id INT PRIMARY KEY AUTO_INCREMENT,
 plate_number VARCHAR (30) NOT NULL,
 make VARCHAR (30) NOT NULL,
 model VARCHAR (30) NOT NULL,
 car_year YEAR,
 category_id INT NOT NULL,
 doors INT,
 picture BLOB,
 car_condition TEXT,
available BOOLEAN
);
 INSERT INTO cars(plate_number, make, model, category_id)
 VALUES 
 ('abcd', 'Lada', 'oka', 1),
 ('abcd', 'Opel', 'korsa', 2),
 ('abcd', 'Alfa', '147', 3);
 
CREATE TABLE employees (
id INT PRIMARY KEY AUTO_INCREMENT,
 first_name VARCHAR(30) NOT NULL,
 last_name VARCHAR(30) ,
 title VARCHAR(30),
 notes TEXT
 );
  INSERT INTO employees(first_name)
 VALUES 
 ('Dido'),
 ('Petia'),
 ('Miro');
 
 CREATE TABLE customers (
 id INT PRIMARY KEY AUTO_INCREMENT,
 driver_licence_number INT,
 full_name VARCHAR(30) NOT NULL,
 address VARCHAR(30),
 city VARBINARY(30),
 zip_code INT(4),
 notes TEXT
 );
   INSERT INTO customers(full_name)
 VALUES 
 ('Dido Ivanov'),
 ('Petia Ivanova'),
 ('Miro Ivanov');

CREATE TABLE rental_orders (
id INT PRIMARY KEY AUTO_INCREMENT,
 employee_id INT NOT NULL,
 customer_id INT NOT NULL,
 car_id INT NOT NULL,
 car_condition TEXT,
 tank_level INT,
kilometrage_start INT,
 kilometrage_end INT,
 total_kilometrage INT,
 start_date DATETIME,
 end_date DATETIME,
total_days INT,
 rate_applied DOUBLE,
 tax_rate DOUBLE,
 order_status BOOLEAN,
 notes TEXT
 );
   INSERT INTO rental_orders(total_kilometrage, employee_id, customer_id, car_id)
 VALUES 
 (190, 1, 1, 1),
 (34, 2, 2, 2),
 (55, 3, 3, 3);
-- p13
INSERT INTO towns(`name`)
VALUE 
('Sofia'),
('Plovdiv'),
('Varna'),
('Burgas');

INSERT INTO departments(`name`)
VALUE 
('Engineering'),
('Sales'),
('Marketing'),
('Software Development'),
('Quality Assurance');

INSERT INTO employees(first_name, middle_name, last_name, job_title, department_id, hire_date, salary)
VALUE 
('Ivan', 'Ivanov', 'Ivanov', '.NET Developer', 4, '2013-02-01', 3500.00),
('Petar', 'Petrov', 'Petrov', 'Senior Engineer', 1, '2004-03-02', 4000.00),
('Maria', 'Petrova', 'Ivanova', 'Intern', 5, '2016-08-28', 525.25),
('Georgi', 'Terziev', 'Ivanov', 'CEO', 2, '2007-12-09', 3000.00),
('Peter', 'Pan', 'Pan', 'Intern', 3, '2016-08-28', 599.88);
-- p14
SELECT * FROM towns;
SELECT * FROM departments;
SELECT * FROM employees;
-- p15
SELECT * FROM towns
ORDER BY towns.name;
SELECT * FROM departments
ORDER BY departments.name;
SELECT * FROM employees
ORDER BY employees.salary DESC;
-- p16
SELECT name FROM towns
ORDER BY towns.name;
SELECT name FROM departments
ORDER BY departments.name;
SELECT first_name, last_name, job_title, salary FROM employees
ORDER BY employees.salary DESC;
-- p17
UPDATE employees 
SET salary = salary * 1.1;
SELECT salary FROM employees;
-- p18
TRUNCATE TABLE occupancies;
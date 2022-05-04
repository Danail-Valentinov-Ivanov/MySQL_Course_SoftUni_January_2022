-- p1
CREATE TABLE people (
person_id INT UNIQUE AUTO_INCREMENT NOT NULL,
first_name VARCHAR(100) NOT NULL,
salary DECIMAL(7, 2) NOT NULL,
passport_id INT UNIQUE NOT NULL
);
-- DROP TABLE people;
-- DROP TABLE passports;
CREATE TABLE passports (
passport_id INT UNIQUE AUTO_INCREMENT NOT NULL,
passport_number VARCHAR(100) UNIQUE NOT NULL
) AUTO_INCREMENT = 101;

INSERT INTO people(first_name, salary, passport_id)
VALUES 
('Roberto', 43300.00, 102),
('Tom', 56100.00, 103),
('Yana', 60200.00, 101);

INSERT INTO passports (passport_number)
VALUES 
('N34FG21B'),
('K65LO4R7'),
('ZE657QP2');

ALTER TABLE people
ADD CONSTRAINT pk_people
PRIMARY KEY (person_id);

ALTER TABLE people
ADD CONSTRAINT fk_people_passports
FOREIGN KEY (passport_id)
REFERENCES passports(passport_id);
-- p2
CREATE TABLE manufacturers(
manufacturer_id INT UNIQUE AUTO_INCREMENT NOT NULL,
`name` VARCHAR(100) NOT NULL,
established_on DATE NOT NULL
);
CREATE TABLE models(
model_id INT UNIQUE AUTO_INCREMENT  NOT NULL,
`name` VARCHAR(100) NOT NULL,
manufacturer_id INT NOT NULL
)AUTO_INCREMENT = 101;

INSERT INTO manufacturers (`name`, established_on)
VALUES 
('BMW', '1916-03-01'),
('Tesla', '2003-01-01'),
('Lada', '1966-05-01');

INSERT INTO models(`name`, manufacturer_id)
VALUES 
('X1', 1),
('i6', 1),
('Model S', 2),
('Model X', 2),
('Model 3', 2),
('Nova', 3);

ALTER TABLE manufacturers
ADD CONSTRAINT pk_manufacturers
PRIMARY KEY (manufacturer_id);

ALTER TABLE models
ADD CONSTRAINT pk_models
PRIMARY KEY (model_id),
ADD CONSTRAINT fk_models_manufacturers
FOREIGN KEY (manufacturer_id)
REFERENCES manufacturers(manufacturer_id);
-- p3
CREATE TABLE students(
student_id INT UNIQUE AUTO_INCREMENT NOT NULL,
`name` VARCHAR(100) NOT NULL
);
CREATE TABLE exams(
exam_id INT UNIQUE AUTO_INCREMENT NOT NULL,
`name` VARCHAR(100) NOT NULL
) AUTO_INCREMENT = 101;

CREATE TABLE students_exams(
student_id INT NOT NULL,
exam_id INT NOT NULL
);
INSERT INTO students (`name`)
VALUES 
('Mila'),
('Toni'),
('Ron');

INSERT INTO exams (`name`)
VALUES 
('Spring MVC'),
('Neo4j'),
('Oracle 11g');

INSERT INTO students_exams(student_id, exam_id)
VALUES 
(1, 101),
(1, 102),
(2, 101),
(3, 103),
(2, 102),
(2, 103);

ALTER TABLE students
ADD CONSTRAINT pk_students
PRIMARY KEY (student_id);

ALTER TABLE exams
ADD CONSTRAINT pk_exams
PRIMARY KEY (exam_id);

ALTER TABLE students_exams
ADD CONSTRAINT fk_students_exams_students
FOREIGN KEY (student_id)
REFERENCES students(student_id),
ADD CONSTRAINT fk_students_exams_exams
FOREIGN KEY (exam_id)
REFERENCES exams(exam_id),
ADD CONSTRAINT pk_students_exams
PRIMARY KEY (student_id, exam_id);
-- p4
CREATE TABLE teachers(
teacher_id INT UNIQUE AUTO_INCREMENT NOT NULL,
`name` VARCHAR(100) NOT NULL,
manager_id INT
) AUTO_INCREMENT = 101;

INSERT INTO teachers(`name`, manager_id)
VALUES 
('John', NULL),
('Maya', 106),
('Silvia', 106),
('Ted', 105),
('Mark', 101),
('Greta', 101);

ALTER TABLE teachers
ADD CONSTRAINT pk_teachers
PRIMARY KEY (teacher_id),
ADD CONSTRAINT fk_teacher_manager
FOREIGN KEY (manager_id)
REFERENCES teachers(teacher_id);

-- 5
CREATE TABLE cities(
city_id INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(50) NOT NULL
);
CREATE TABLE customers(
customer_id INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(50) NOT NULL,
birthday DATE NOT NULL,
city_id INT NOT NULL,
CONSTRAINT fk_customers_cities
FOREIGN KEY (city_id)
REFERENCES cities(city_id)
);
CREATE TABLE orders(
order_id INT PRIMARY KEY AUTO_INCREMENT,
customer_id INT NOT NULL, 
CONSTRAINT fk_orders_customers
FOREIGN KEY (customer_id)
REFERENCES customers(customer_id)
);
CREATE TABLE item_types(
item_type_id INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(50) NOT NULL
);
CREATE TABLE items(
item_id INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(50) NOT NULL,
item_type_id INT  NOT NULL,
CONSTRAINT fk_items_item_type
FOREIGN KEY (item_type_id)
REFERENCES item_types(item_type_id)
);
CREATE TABLE order_items(
order_id INT  NOT NULL,
item_id INT  NOT NULL,
CONSTRAINT pk_order_items
PRIMARY KEY (order_id, item_id),
CONSTRAINT fk_order_item
FOREIGN KEY (order_id)
REFERENCES orders(order_id),
CONSTRAINT fk_item_order
FOREIGN KEY (item_id)
REFERENCES items(item_id)
);
-- p6
CREATE TABLE majors(
major_id INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(50) NOT NULL
);
CREATE TABLE students(
student_id INT PRIMARY KEY AUTO_INCREMENT,
`student_number` VARCHAR(12) NOT NULL,
`student_name` VARCHAR(50) NOT NULL,
major_id INT NOT NULL,
CONSTRAINT fk_students_majors
FOREIGN KEY (major_id)
REFERENCES majors(major_id)
);
CREATE TABLE payments(
payment_id  INT PRIMARY KEY AUTO_INCREMENT,
payment_date DATE,
payment_amount DECIMAL (8, 2),
student_id INT NOT NULL,
CONSTRAINT fk_paymants_students
FOREIGN KEY (student_id)
REFERENCES students(student_id)
);
CREATE TABLE subjects(
subject_id INT PRIMARY KEY AUTO_INCREMENT,
`subject_name` VARCHAR(50) NOT NULL
);
CREATE TABLE agenda(
student_id INT NOT NULL,
subject_id INT NOT NULL,
CONSTRAINT pk_agenda
PRIMARY KEY (student_id, subject_id),
CONSTRAINT fk_agenda_students
FOREIGN KEY (student_id)
REFERENCES students(student_id),
CONSTRAINT fk_agenda_subjects
FOREIGN KEY (subject_id)
REFERENCES subjects(subject_id)
);
-- p9
SELECT mountain_range, peak_name, elevation as peak_elevation FROM mountains as m JOIN peaks as p
ON p.mountain_id = m.id
WHERE mountain_range = 'Rila'
ORDER BY peak_elevation DESC;
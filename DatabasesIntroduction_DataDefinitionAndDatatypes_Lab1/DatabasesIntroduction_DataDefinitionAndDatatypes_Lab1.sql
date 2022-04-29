-- p1
CREATE TABLE `employees` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `first_name` VARCHAR(50) NOT NULL,
  `last_name` VARCHAR(50) NOT NULL
  );

CREATE TABLE `categories` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL
  );

CREATE TABLE `products` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `category_id` INT NOT NULL
  );
  -- p2
INSERT INTO `employees` (`first_name`, `last_name`)
VALUES ('Danail', 'Ivanov');
INSERT INTO `employees` (`first_name`, `last_name`)
VALUES ('Danail', 'Ivanov');
INSERT INTO `employees` (`first_name`, `last_name`)
VALUES ('Danail', 'Ivanov');
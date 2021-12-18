Drop SCHEMA `app`;
CREATE SCHEMA `app` ;

CREATE TABLE `app`.`students` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(11) NOT NULL,
  `age` FLOAT NOT NULL DEFAULT 0.0,
  `phone` VARCHAR(11) NOT NULL,
  `createdAt` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `phone_UNIQUE` (`phone` ASC) );

CREATE TABLE `app`.`student_enrolls` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `phone` VARCHAR(11) NOT NULL,
  `topic_name` VARCHAR(11) NOT NULL,
  `topic_id` VARCHAR(255) NOT NULL,
  `score` FLOAT NOT NULL DEFAULT 0.0,
  `createdAt` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`));

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `Ecommerce` DEFAULT CHARACTER SET utf8 ;
USE `Ecommerce` ;

-- -----------------------------------------------------
-- Table `Ecommerce`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ecommerce`.`users` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `role` VARCHAR(45) NOT NULL,
  `email_address` VARCHAR(45) NOT NULL,
  `password` VARCHAR(32) NOT NULL,
  `mobile_number` VARCHAR(45) NOT NULL,
  `address` VARCHAR(4) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `userID_UNIQUE` (`id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Ecommerce`.`payment_modes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ecommerce`.`payment_modes` (
  `id` INT NOT NULL,
  `payment_method` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Ecommerce`.`products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ecommerce`.`products` (
  `id` INT NOT NULL,
  `product_name` VARCHAR(64) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Ecommerce`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ecommerce`.`orders` (
  `id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `order_cost` FLOAT NULL DEFAULT NULL,
  `payment_id` INT NOT NULL,
  `product_id` INT NOT NULL,
  `final_cost` FLOAT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_order_1_idx` (`payment_id` ASC),
  INDEX `product_d_idx` (`product_id` ASC),
  INDEX `user_id_idx` (`user_id` ASC),
  CONSTRAINT `payment_id`
    FOREIGN KEY (`payment_id`)
    REFERENCES `Ecommerce`.`payment_modes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `product_id`
    FOREIGN KEY (`product_id`)
    REFERENCES `Ecommerce`.`products` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `Ecommerce`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Ecommerce`.`product_details`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ecommerce`.`product_details` (
  `color_id` INT NOT NULL,
  `product_id` INT NOT NULL,
  `product_color` VARCHAR(45) NOT NULL,
  `product_price` FLOAT NOT NULL,
  `product_stock` INT NOT NULL,
  PRIMARY KEY (`color_id`),
  CONSTRAINT `product_id`
    FOREIGN KEY (`color_id`)
    REFERENCES `Ecommerce`.`products` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Ecommerce`.`credit_cards`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ecommerce`.`credit_cards` (
  `credit_card_no` INT NOT NULL,
  `credit_payment_id` INT NOT NULL,
  `expiry_date` DATE NOT NULL,
  `card_name` VARCHAR(45) NOT NULL,
  INDEX `credit_payment_id_idx` (`credit_payment_id` ASC),
  CONSTRAINT `credit_payment_id`
    FOREIGN KEY (`credit_payment_id`)
    REFERENCES `Ecommerce`.`payment_modes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Ecommerce`.`discounts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ecommerce`.`discounts` (
  `id` INT NOT NULL,
  `payment_id` INT NOT NULL,
  `amount` FLOAT NOT NULL,
  `coupon_code` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `payment_id_idx` (`payment_id` ASC),
  CONSTRAINT `payment_id`
    FOREIGN KEY (`payment_id`)
    REFERENCES `Ecommerce`.`payment_modes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `Ecommerce` DEFAULT CHARACTER SET utf8 ;
USE `Ecommerce` ;

-- -----------------------------------------------------
-- Table `Ecommerce`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ecommerce`.`user` (
  `user_id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `email_address` VARCHAR(45) NOT NULL,
  `password` VARCHAR(32) NOT NULL,
  `mobile_number` VARCHAR(45) NOT NULL,
  `address` VARCHAR(4) NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `userID_UNIQUE` (`user_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Ecommerce`.`payment_mode`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ecommerce`.`payment_mode` (
  `payment_id` INT NOT NULL,
  `payment_method` VARCHAR(45) NULL DEFAULT NULL,
  `payment_order_id` INT NULL,
  PRIMARY KEY (`payment_id`),
  INDEX `payment_order_id_idx` (`payment_order_id` ASC),
  CONSTRAINT `payment_order_id`
    FOREIGN KEY (`payment_order_id`)
    REFERENCES `Ecommerce`.`order` (`order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Ecommerce`.`product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ecommerce`.`product` (
  `product_id` INT NOT NULL,
  `product_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`product_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Ecommerce`.`order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ecommerce`.`order` (
  `order_id` INT NOT NULL,
  `user_order_id` INT NOT NULL,
  `order_cost` FLOAT NULL DEFAULT NULL,
  `payment_id` INT NOT NULL,
  `product_id` INT NOT NULL,
  PRIMARY KEY (`order_id`),
  INDEX `user_order_id_idx` (`user_order_id` ASC),
  INDEX `fk_order_1_idx` (`payment_id` ASC),
  INDEX `product_d_idx` (`product_id` ASC),
  CONSTRAINT `user_order_id`
    FOREIGN KEY (`user_order_id`)
    REFERENCES `Ecommerce`.`buyer` (`buyer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `payment_id`
    FOREIGN KEY (`payment_id`)
    REFERENCES `Ecommerce`.`payment_mode` (`payment_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `product_d`
    FOREIGN KEY (`product_id`)
    REFERENCES `Ecommerce`.`product` (`product_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Ecommerce`.`buyer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ecommerce`.`buyer` (
  `buyer_id` INT NOT NULL,
  `order_id` INT NOT NULL,
  PRIMARY KEY (`buyer_id`),
  UNIQUE INDEX `buyerID_UNIQUE` (`buyer_id` ASC),
  UNIQUE INDEX `orderID_UNIQUE` (`order_id` ASC),
  CONSTRAINT `buyer_id`
    FOREIGN KEY (`buyer_id`)
    REFERENCES `Ecommerce`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `order_id`
    FOREIGN KEY (`order_id`)
    REFERENCES `Ecommerce`.`order` (`order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Ecommerce`.`product_details`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ecommerce`.`product_details` (
  `product_details_id` INT NOT NULL,
  `product_order_id` INT NOT NULL,
  `product_color` VARCHAR(45) NULL DEFAULT NULL,
  `product_price` FLOAT NOT NULL,
  `productStock` INT NULL DEFAULT NULL,
  PRIMARY KEY (`product_details_id`),
  CONSTRAINT `product_details_id`
    FOREIGN KEY (`product_details_id`)
    REFERENCES `Ecommerce`.`product` (`product_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Ecommerce`.`credit_card`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ecommerce`.`credit_card` (
  `credit_payment_id` INT NOT NULL,
  `credit_card_no` INT NOT NULL,
  `expiry_date` DATE NOT NULL,
  `card_name` VARCHAR(45) NOT NULL,
  INDEX `credit_payment_id_idx` (`credit_payment_id` ASC),
  CONSTRAINT `credit_payment_id`
    FOREIGN KEY (`credit_payment_id`)
    REFERENCES `Ecommerce`.`payment_mode` (`payment_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Ecommerce`.`discount`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ecommerce`.`discount` (
  `discount_id` INT NOT NULL,
  `payment_id` INT NULL DEFAULT NULL,
  `amount` FLOAT NULL DEFAULT NULL,
  `discount_code` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`discount_id`),
  INDEX `payment_id_idx` (`payment_id` ASC),
  CONSTRAINT `payment_id`
    FOREIGN KEY (`payment_id`)
    REFERENCES `Ecommerce`.`payment_mode` (`payment_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Ecommerce`.`inventory_manager`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ecommerce`.`inventory_manager` (
  `inventory_manager_id` INT NOT NULL,
  `inventory_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`inventory_manager_id`),
  CONSTRAINT `inventory_manager_id`
    FOREIGN KEY (`inventory_manager_id`)
    REFERENCES `Ecommerce`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

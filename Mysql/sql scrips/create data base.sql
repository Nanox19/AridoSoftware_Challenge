-- MySQL Workbench Synchronization
-- Generated: 2022-07-04 13:31
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: JARVIS

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE TABLE IF NOT EXISTS `aridosoftware_challenge`.`user_base` (
  `id_user` INT(11) NOT NULL AUTO_INCREMENT,
  `user_name` VARCHAR(50) UNIQUE NOT NULL,
  `password` VARCHAR(60) NOT NULL,
  `creation_date` DATETIME NOT NULL,
  `account_state` INT(2) NOT NULL,
  PRIMARY KEY (`id_user`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE IF NOT EXISTS `aridosoftware_challenge`.`access_level` (
  `id_access_level` INT(11) NOT NULL AUTO_INCREMENT,
  `access_level_name` VARCHAR(40) NOT NULL,
  PRIMARY KEY (`id_access_level`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE IF NOT EXISTS `aridosoftware_challenge`.`security_group` (
  `id_security_group` INT(11) NOT NULL AUTO_INCREMENT,
  `security_group_name` VARCHAR(50) NOT NULL,
  `security_group_description` VARCHAR(500) NULL DEFAULT NULL,
  PRIMARY KEY (`id_security_group`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE IF NOT EXISTS `aridosoftware_challenge`.`user_security` (
  `id_security_group` INT(11) NOT NULL,
  `id_user` INT(11) NOT NULL,
  `id_access_level` INT(11) NOT NULL,
  PRIMARY KEY (`id_security_group`, `id_user`),
  INDEX `fk_security_group_has_user_base_user_base_idx` (`id_user` ASC),
  INDEX `fk_security_group_has_user_base_security_group_idx` (`id_security_group` ASC),
  INDEX `fk_user_security_access_level_idx` (`id_access_level` ASC),
  CONSTRAINT `fk_security_group_has_user_base_security_group`
    FOREIGN KEY (`id_security_group`)
    REFERENCES `aridosoftware_challenge`.`security_group` (`id_security_group`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_security_group_has_user_base_user_base`
    FOREIGN KEY (`id_user`)
    REFERENCES `aridosoftware_challenge`.`user_base` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_security_access_level`
    FOREIGN KEY (`id_access_level`)
    REFERENCES `aridosoftware_challenge`.`access_level` (`id_access_level`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

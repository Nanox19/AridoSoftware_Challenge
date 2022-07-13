DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `alta_security_user` (IN `_user_name` VARCHAR(50), IN `_security_group_name` VARCHAR(50), IN `_access_level` INT(11))   BEGIN
DECLARE _id_security_group  INT(11);
DECLARE _id_user  INT(11);
		SELECT id_user into @_id_user 
		FROM user_base
		WHERE user_name = _user_name;
		SELECT @_id_user ;
        
		SELECT id_security_group into @_id_security_group 
		FROM security_group
		WHERE security_group_name = _security_group_name;
		SELECT @_id_security_group;
        
		INSERT INTO user_security (`id_security_group`, `id_user`, `id_access_level`) 
			VALUES (@_id_security_group,@_id_user,_access_level);

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `alta_usuario_security_group` (IN `_user_name` VARCHAR(50), IN `_password` VARCHAR(60), IN `_creation_date` DATETIME, IN `_account_state` INT(2), IN `_security_group_name` VARCHAR(50), IN `_access_level` INT(11))   BEGIN
DECLARE _id_security_group  INT(11);
DECLARE _id_user  INT(11);
		INSERT INTO user_base (`user_name`, `password`, `creation_date`, `account_state`) 
			VALUES (_user_name,_password,_creation_date,_account_state);
	SET  @_id_user= last_insert_id();
		SELECT id_security_group into@_id_security_group 
		FROM security_group
		WHERE security_group_name = _security_group_name;
    SELECT @_id_security_group;
		INSERT INTO user_security (`id_security_group`, `id_user`, `id_access_level`) 
			VALUES (@_id_security_group,@_id_user,_access_level);

		SELECT _id_user AS id_user;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `alta_y_update_usuario` (IN `_id_user` INT(11), IN `_user_name` VARCHAR(50), IN `_password` VARCHAR(60), IN `_creation_date` DATETIME, IN `_account_state` INT(2))   BEGIN
 IF _id_user=0 THEN
		INSERT INTO user_base (`user_name`, `password`, `creation_date`, `account_state`) 
			VALUES (_user_name,_password,_creation_date,_account_state);
        SET _id_user= last_insert_id();
  ELSE
	UPDATE user_base SET
		user_name=_user_name,
        password = _password,
        creation_date = _creation_date,
        account_state = _account_state
			WHERE id_user=_id_user;
	END IF;
    SELECT _id_user AS id_user;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_security_group_by_user_name` (IN `_user_name` VARCHAR(50))   BEGIN
DECLARE _id_user  INT(11);
		SELECT id_user into @_id_user 
		FROM user_base
		WHERE user_name = _user_name;
		
        
		SELECT security_group.security_group_name
		FROM user_security,security_group
		WHERE user_security.id_user = @_id_user 
        and user_security.id_security_group=security_group.id_security_group;

END$$

DELIMITER ;
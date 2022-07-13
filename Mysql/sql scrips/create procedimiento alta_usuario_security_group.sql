CREATE DEFINER=`root`@`localhost` PROCEDURE `alta_usuario_security_group`(
  IN _user_name VARCHAR(50),
  IN _password VARCHAR(60),
  IN _creation_date DATETIME,
  IN _account_state INT(2),
  IN _security_group_name VARCHAR(50),
  IN _access_level INT(11)
  )
BEGIN
DECLARE _id_security_group  INT(11);
DECLARE _id_user  INT(11);
		INSERT INTO user_base (`user_name`, `password`, `creation_date`, `account_state`) 
			VALUES (_user_name,_password,_creation_date,_account_state);
	SET  @_id_user= last_insert_id();
		SELECT @_id_security_group:= security_group.id_security_group 
		FROM security_group 
		WHERE security_group.security_group_name = _security_group_name;
    
		INSERT INTO user_security (`id_security_group`, `id_user`, `id_access_level`) 
			VALUES (_id_security_group,_id_user,_access_level);

		SELECT _id_user AS id_user;
END
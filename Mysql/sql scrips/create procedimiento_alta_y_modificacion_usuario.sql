CREATE PROCEDURE alta_y_update_usuario (
  IN _id_user INT(11),
  IN _user_name VARCHAR(50),
  IN _password VARCHAR(60),
  IN _creation_date DATETIME,
  IN _account_state INT(2)
  )
BEGIN
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
END

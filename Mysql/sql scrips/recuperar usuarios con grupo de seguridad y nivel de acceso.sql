SELECT user_base.user_name,security_group_name,access_level_name FROM user_base,user_security,security_group,access_level
WHERE user_base.id_user = user_security.id_user 
and security_group.id_security_group = user_security.id_security_group 
and access_level.id_access_level = user_security.id_access_level;


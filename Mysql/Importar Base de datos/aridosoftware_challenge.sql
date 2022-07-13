-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 13-07-2022 a las 05:58:00
-- Versión del servidor: 10.4.24-MariaDB
-- Versión de PHP: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `aridosoftware_challenge`
--

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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `access_level`
--

CREATE TABLE `access_level` (
  `id_access_level` int(11) NOT NULL,
  `access_level_name` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `access_level`
--

INSERT INTO `access_level` (`id_access_level`, `access_level_name`) VALUES
(1, 'read'),
(2, 'write'),
(3, 'administrator'),
(4, 'owner');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `security_group`
--

CREATE TABLE `security_group` (
  `id_security_group` int(11) NOT NULL,
  `security_group_name` varchar(50) NOT NULL,
  `security_group_description` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `security_group`
--

INSERT INTO `security_group` (`id_security_group`, `security_group_name`, `security_group_description`) VALUES
(1, 'guest_user', 'Cuenta de invitado, esta restringido a solo lectura.'),
(2, 'common_user', 'Cuenta de usuario común, con derechos de lectura y escritura limitados.'),
(3, 'administrator_user', 'Usuario administrador, con permisos especiales. Tiene mas acceso al sistema con fines regulatorios.'),
(4, 'super_user', 'Usuario root con acceso total al sistema.');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `user_base`
--

CREATE TABLE `user_base` (
  `id_user` int(11) NOT NULL,
  `user_name` varchar(50) NOT NULL,
  `password` varchar(60) NOT NULL,
  `creation_date` datetime NOT NULL,
  `account_state` int(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `user_base`
--

INSERT INTO `user_base` (`id_user`, `user_name`, `password`, `creation_date`, `account_state`) VALUES
(1, 'root_admin', 'aridosoftware_admin', '2022-07-01 08:00:00', 1),
(2, 'admin_as_1', 'administrator_as_1', '2022-07-01 09:00:00', 1),
(3, 'admin_as_2', 'administrator_as_2', '2022-07-02 10:00:00', 1),
(4, 'admin_as_3', 'administrator_as_3', '2022-07-02 11:00:00', 1),
(5, 'valeria_23', 'alfajor_aguila', '2022-07-05 14:00:00', 1),
(6, 'gonzalo_olguin', 'gabriel_quevedo', '2022-07-05 14:00:00', 1),
(7, 'rocio_19', 'baigorria1999', '2022-07-05 15:00:00', 0),
(8, 'franco_garcia', 'catriel48265', '2022-07-05 15:00:00', 1),
(9, 'rio_valentina', '1357986420', '2022-07-05 16:00:00', 1),
(10, 'chanchito_feliz', 'chanchitos_felices', '2022-07-05 22:30:00', 1),
(11, 'juan_joel', 'olguin_quevedo', '2022-07-05 16:20:00', 1),
(13, 'laura_quevedo', 'milagros', '2022-07-10 21:38:33', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `user_security`
--

CREATE TABLE `user_security` (
  `id_security_group` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `id_access_level` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `user_security`
--

INSERT INTO `user_security` (`id_security_group`, `id_user`, `id_access_level`) VALUES
(1, 10, 1),
(1, 11, 1),
(2, 6, 1),
(2, 5, 2),
(2, 7, 2),
(2, 8, 2),
(2, 9, 2),
(2, 11, 2),
(2, 13, 2),
(3, 2, 3),
(3, 3, 3),
(3, 4, 3),
(3, 6, 3),
(4, 1, 4);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `access_level`
--
ALTER TABLE `access_level`
  ADD PRIMARY KEY (`id_access_level`);

--
-- Indices de la tabla `security_group`
--
ALTER TABLE `security_group`
  ADD PRIMARY KEY (`id_security_group`);

--
-- Indices de la tabla `user_base`
--
ALTER TABLE `user_base`
  ADD PRIMARY KEY (`id_user`),
  ADD UNIQUE KEY `user_name` (`user_name`);

--
-- Indices de la tabla `user_security`
--
ALTER TABLE `user_security`
  ADD PRIMARY KEY (`id_security_group`,`id_user`),
  ADD KEY `fk_security_group_has_user_base_user_base_idx` (`id_user`),
  ADD KEY `fk_security_group_has_user_base_security_group_idx` (`id_security_group`),
  ADD KEY `fk_user_security_access_level_idx` (`id_access_level`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `access_level`
--
ALTER TABLE `access_level`
  MODIFY `id_access_level` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `security_group`
--
ALTER TABLE `security_group`
  MODIFY `id_security_group` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `user_base`
--
ALTER TABLE `user_base`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `user_security`
--
ALTER TABLE `user_security`
  ADD CONSTRAINT `fk_security_group_has_user_base_security_group` FOREIGN KEY (`id_security_group`) REFERENCES `security_group` (`id_security_group`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_security_group_has_user_base_user_base` FOREIGN KEY (`id_user`) REFERENCES `user_base` (`id_user`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_user_security_access_level` FOREIGN KEY (`id_access_level`) REFERENCES `access_level` (`id_access_level`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

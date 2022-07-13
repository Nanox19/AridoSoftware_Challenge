const express = require('express');
const router = express.Router();

// La llave lo conviene 
const {getUsers,getUser,getSecurity_group,deleteUser,postUsers,postSecurity_user,post_put_User} = require("../controllers/users");

router.get("/users",getUsers);
router.get("/users/:user_name",getUser);
router.get("/obtener_grupos_de_seguridad/:user_name",getSecurity_group);
router.get("/users/delete/",deleteUser); 
router.post("/users/alta",postUsers);
router.post("/agregar_security_user",postSecurity_user);



// Exportando esto ya podemos acceder al metodo. 
module.exports = router; 


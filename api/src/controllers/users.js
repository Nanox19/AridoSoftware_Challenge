const mysqlConnection  = require('../db/database.js');

// GET all Users
exports.getUsers =async(req, res) => {
  mysqlConnection.query('SELECT user_name,creation_date,account_state FROM user_base', (err, rows, fields) => {
    if(!err) {
     //console.log(rows);
      res.json(rows);
    } else {
      alert("Ocurrio un error");
      console.log(err);
    }
  });  
};

// GET An User
exports.getUser =async(req, res) => {
  const { user_name } = req.params; 
  mysqlConnection.query('SELECT user_name,creation_date,account_state FROM user_base WHERE user_name = ?', [user_name], (err, rows, fields) => {
    if (!err) {
      //console.log(rows[0]);
      res.json(rows[0]);
    } else {
      alert("Usuario no encontrado.");
      console.log(err);
    }
  });
};

exports.getSecurity_group =async(req, res) => {
  const { user_name } = req.params; 

  mysqlConnection.query('CALL get_security_group_by_user_name (?);', [user_name], (err, rows, fields) => {
    if (!err) {
      //console.log("grupos");
      //console.log(rows);
      res.json(rows);
    } else {
      console.log(err);
    }
  });
};

// DELETE An User
exports.deleteUser =async (req, res) => {
  const { user_name } = req.body;
  mysqlConnection.query('DELETE FROM user_base WHERE user_name = ?', [user_name], (err, rows, fields) => {
    if(!err) {
      res.json({status: 'User Deleted'});
      alert("Usuario eliminado con exito");
    } else {
      console.log(err);
      alert("Usuario no encontrado.");
    }
  });
};

// INSERT An User
exports.postUsers =async(req, res) => {
  const {user_name, password,creation_date,account_state,security_group_name,access_level} = req.body;
  //console.log(user_name, password,creation_date,account_state,security_group_name,access_level);
  //console.log("datos del body:"+req.body);
  const query = `CALL alta_usuario_security_group(?,?,?,?,?,?);`;
  mysqlConnection.query(query, [user_name,password,creation_date,account_state,security_group_name,access_level], (err, rows, fields) => {
    if(!err) {
      res.json({status: 'User Saved'});
    } else {
        console.log("Aca comienza el error:");
        alert("El usuario ha sido registrado");
      console.log(err);
      alert("Este usuario ya esta registrado");
    }
  });

};

exports.postSecurity_user =async(req, res) => {
  const {user_name,security_group_name,access_level} = req.body;
  //console.log(user_name,security_group_name,access_level);
  //console.log("datos del body:");
  //console.log(req.body);
  const query = `CALL alta_security_user(?,?,?);`;
  mysqlConnection.query(query, [user_name,security_group_name,access_level], (err, rows, fields) => {
    if(!err) {
      res.json({status: 'security_user Saved'});
      alert("Grupo de seguridad asiganado con exito!");
    } else {
        console.log("Aca comienza el error:");
        alert("Este usuario ya pertenece al grupo de seguridad");
      console.log(err);
    }
  });
};


exports.post_put_User =async(req, res) => {
  const {user_name, password,creation_date,account_state} = req.body;
  const { id_user } = req.params;
  const query = `CALL alta_y_update_usuario(?,?,?,?,?);`;
  mysqlConnection.query(query, [id_user, user_name, password,creation_date,account_state], (err, rows, fields) => {
    if(!err) {
      res.json({status: 'User Updated'});
      alert("El usuario ha sido modificado");
    } else {
      alert("Ocurrio un error y no se pudo modificar el usuario");
      console.log(err);
    }
  });
};

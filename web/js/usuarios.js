let users=[];
  let user;
  function getAPIUsers() {
      axios.get('http://localhost:3000/users')
      .then(response =>{ 
       // console.log(response.data);
        users=response.data;
      })
      .catch(error => console.log(error))
  }
  function getAPIUser(datos) {
    console.log(datos);  
    axios.get(`http://localhost:3000/users/${datos.user_name}`)
    .then(response =>{ 
      let usuario=response.data;
      //console.log("respuesta");
      //console.log(response);
      //console.log(response.data);

      let tabla=document.getElementById("tabla_body_unico_usuario");
          
          let titulo=document.getElementById("usuario_seleccionado");
          titulo.textContent=`Usuario: ${datos.user_name}`;
          
          //console.log("muestro usuario");
          //console.log(usuario);
          var tableHeaderRowCount = 0;
         
          var rowCount = tabla.rows.length;
          for (var i = tableHeaderRowCount; i < rowCount; i++) {
            tabla.deleteRow(tableHeaderRowCount);
}
          let fila=tabla.insertRow(-1);

          let celda=fila.insertCell(0);
          celda.textContent=1;

          celda=fila.insertCell(1);
          celda.textContent=usuario.user_name;

          celda=fila.insertCell(2);
          let fecha=(usuario.creation_date).replaceAll("T"," ");
          fecha=fecha.replaceAll("Z","");
          celda.textContent=fecha;

          celda=fila.insertCell(3);
          let estado;
          if(usuario.account_state){
            estado="Activada";
          }else{
            estado="Desactivada"
          }
          celda.textContent=estado;

      
    })
    .catch(error => console.log(error))
}
function evento_boton(){
    let boton = document.getElementById("Guardar");
    boton.addEventListener("click", () => {
          let user_name = document.getElementById("user_name");

          let usuario = { 
              user_name:user_name.value
          }; 

          //console.log("muestro datos: "); 
          //console.log(usuario); 
              // Validar datos antes de invocar metodo 

              getAPIUser(usuario);
      });
  }

  getAPIUsers();
  
  window.onload = function() {
    let form=document.getElementById("formulario");

    form.addEventListener("submit",function(event){
            event.preventDefault();
            let transactionFormData=new FormData(form);
            });
    getAPIUsers();
    evento_boton();

      let tabla=document.getElementById("tabla_body");
      for(let i=0;i<users.length;i++){
        user=users[i];

        let fila=tabla.insertRow(-1);

        let celda=fila.insertCell(0);
        celda.textContent=i+1;

        celda=fila.insertCell(1);
        celda.textContent=user.user_name;

        celda=fila.insertCell(2);
        let fecha=(user.creation_date).replaceAll("T"," ");
        fecha=fecha.replaceAll("Z","");
        celda.textContent=fecha;

        celda=fila.insertCell(3);
        let estado;
        if(user.account_state){
          estado="Activada";
        }else{
          estado="Desactivada"
        }
        celda.textContent=estado;

      }
  }
let grupos=[];
  
function getAPISecurityGroups(datos) {
    //console.log(datos);  
    axios.get(`http://localhost:3000/obtener_grupos_de_seguridad/${datos.user_name}`)
    .then(response =>{ 
      grupos=response.data;
      //console.log("respuesta");
      //console.log(response);
      //console.log(response.data);

      let tabla=document.getElementById("tabla_body");
          
          let titulo=document.getElementById("usuario_seleccionado");
          titulo.textContent=`Usuario: ${datos.user_name}`;
          
          //console.log("muestro grupos");
          //console.log(grupos);
          var tableHeaderRowCount = 0;
         
          var rowCount = tabla.rows.length;
          for (var i = tableHeaderRowCount; i < rowCount; i++) {
            tabla.deleteRow(tableHeaderRowCount);
}
          
          for(let i=0;i<grupos[0].length;i++){

            let fila=tabla.insertRow(-1);

            let celda=fila.insertCell(0);
            celda.textContent=i+1;

            celda=fila.insertCell(1);
            console.log(grupos[0][i]);
            celda.textContent=grupos[0][i].security_group_name;
          }
      
    })
    .catch(error => console.log(error))
}
function evento_boton(){
    let boton = document.getElementById("Guardar");
    boton.addEventListener("click", () => {
          let user_name = document.getElementById("user_name");

          let user = { 
              user_name:user_name.value
          }; 

          //console.log("muestro datos: "); 
          //console.log(user); 
              // Validar datos antes de invocar metodo 

          getAPISecurityGroups(user);
        
          
      });



  }
 
window.onload = function() {
  let form=document.getElementById("formulario");

  form.addEventListener("submit",function(event){
          event.preventDefault();
          let transactionFormData=new FormData(form);
          });
  evento_boton();
    
}
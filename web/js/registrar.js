function postAPIUser(datos) {
    console.log(datos);  
    axios.post('http://localhost:3000/users/alta', datos)
    .then(response => {
        if (response.status === 200) {
            //alert("Exito");
        } else {
            //alert("Fracaso");
        }
    })
}

function postAPISecurity_group(datos) {
    console.log(datos);  
    axios.post('http://localhost:3000/agregar_security_user', datos)
    .then(response => {
        if (response.status === 200) {
      //alert("Exito");
  } else {
      //alert("Fracaso");
  }
    })
}

window.onload = function() {

    let form=document.getElementById("formulario");
    let form_GS=document.getElementById("formulario_GS");

    form.addEventListener("submit",function(event){
    event.preventDefault();
    let transactionFormData=new FormData(form);
    });
    
    form_GS.addEventListener("submit",function(event){
    event.preventDefault();
    let transactionFormData=new FormData(form_GS);
    });

    let boton = document.getElementById("Guardar"); 
    let boton_GS = document.getElementById("Guardar_GS"); 

    boton.addEventListener("click", () => {

        let user_name = document.getElementById("user_name");
        let password = document.getElementById("password");


        let security_group_name = document.getElementById("security_group_name");
        let access_level;

        let fecha=new Date().toLocaleDateString();
        let hora=new Date().toLocaleTimeString();
        fecha=fecha.split("/");
        let grupo_s=security_group_name.value;
        let nivel_acceso;
        if(grupo_s==="guest_user"){
            nivel_acceso=1;
        }else{
            if(grupo_s==="common_user"){
                nivel_acceso=2;
            }else{
                if(grupo_s==="administrator_user"){
                    nivel_acceso=3;
                }
                else{
                    nivel_acceso=4;
                }
            }
        }
        let creation_date =`${fecha[2]}-${fecha[1]}-${fecha[0]} ${hora}`;
    
        let user = { 
            user_name:user_name.value,
            password:password.value,
            creation_date:creation_date,
            account_state:1,
            security_group_name:security_group_name.value,
            access_level:nivel_acceso
        }; 
        
        //console.log("muestro datos: "); 
        //console.log(user); 
            // Validar datos antes de invocar metodo 
            postAPIUser(user)});

    /*___________________________________________________________*/

    boton_GS.addEventListener("click", () => {

    let user_name = document.getElementById("user_name_GS");
    let security_group_name = document.getElementById("security_group_name_GS");
    let grupo_s=security_group_name.value;
    let nivel_acceso;
    if(grupo_s==="guest_user"){
        nivel_acceso=1;
    }else{
        if(grupo_s==="common_user"){
            nivel_acceso=2;
        }else{
            if(grupo_s==="administrator_user"){
                nivel_acceso=3;
            }
            else{
                nivel_acceso=4;
            }
        }
    }

    let data = { 
        user_name:user_name.value,
        security_group_name:security_group_name.value,
        access_level:nivel_acceso
    }; 
    
    //console.log("muestro datos: "); 
    //console.log(data); 
        // Validar datos antes de invocar metodo 
        postAPISecurity_group(data)});
}
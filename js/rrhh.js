$(document).ready(function(){

    cargarSolicitudes();

    $("#rrhh_enviar_solicitud").on("click", function(e){
        e.preventDefault();
        if(rrhh_validarForm()){
          console.log("solcitud:"+enviarSolicitudID);
          var datos = {
            "opcion":"2",
            "solicitudID":enviarSolicitudID,
            "rrhh_salarioBruto":$("#rrhh_salarioBruto").val(),
            "rrhh_salarioConDeduccion":$("#rrhh_salarioConDeduccion").val(),
            "rrhh_derechos":$("#rrhh_derechos").val(),
            "rrhh_antiguedad":$("#rrhh_antiguedad").val(),
            "rrhh_comentario":$("#rrhh_comentario").val()
          } 
          $.post('../class/controller_rrhh.php', datos, function(response){
            console.log(response);
              var data = JSON.parse(response);
              if (data[0].bandera === '1') {
                  cargarSolicitudes();
                  show_alert(1, data[0].mensajeError);
                  $("#rrhh_modalEnviar").modal("hide");
              }
              else{
                show_alert(2, data[0].mensajeError);
              }
            });
        }
      });

});



//============================   ALERTAS   =====================================
function show_alert(option, msj){
  switch(option){
    case 1:
       jQuery.gritter.add({
        title: 'Exito!',
        text: msj,
          class_name: 'growl-success',
        sticky: false,
        time: ''
       });
      break;
    case 2:
       jQuery.gritter.add({
        title: 'Error!',
        text: msj,
          class_name: 'growl-danger',
        sticky: false,
        time: ''
       });

      break;

  }
}

//====================CARGA DE solicitudes ========================
function cargarSolicitudes(){
  $.ajax({
      type: "POST",
      url: "../class/controller_rrhh.php",
      data: {
        "opcion": "1"
      },
      beforeSend: function(){
        $("#tbody_solicitudes").html('<div class = ""><img src="../../img/load.gif" class = "img-responsive center-block" /></div>');
      },
      success: function(response){
          $("#tbody_solicitudes").html("");
          var tr = "";
          var estado = '';
          var estado = '';
          var datos = JSON.parse(response);

          if (datos[0].bandera  === 1) {
              for(var index = 1; index < datos.length ; index++){
                if (datos[index].estadoID === "2") {
                  estado = '<td><center><label href="#" class="label label-default">Sin enviar</label></center></td>';
                  enviada = '<center><button data-solicitud = "'+ datos[index].solicitudID+'"" href="#" class=" btn btn-success btn_enviar"><i class="glyphicon glyphicon-export"></i></button></center>';
                }else{
                  if (datos[index].estadoID === "5") {
                    estado = '<td><center><label href="#" class="label label-danger">Aprobada</label></center></td>';
                    enviada = '<center><button data-solicitud = "'+ datos[index].solicitudID+'"" href="#" class=" btn btn-default "><i class="glyphicon glyphicon-send"></i></button></center>';
                  }
                  else{
                    estado = '<td><center><label href="#" class="label label-success">Enviada</label></center></td>';
                    enviada = '<center><button data-solicitud = "'+ datos[index].solicitudID+'"" href="#" class=" btn btn-default "><i class="glyphicon glyphicon-export"></i></button></center>';
                  }
                }

                 tr += '<tr>'
                    +'<td><center>'+datos[index].solicitudID+'</center></td>'
                    + estado
                    +'<td><center>'+datos[index].fechaCreacion+'</center></td>'
                    +'<td><center>'+datos[index].identidad+'</center></td>'
                    +'<td><center>'+datos[index].solicitanteNombre+'</center></td>'
                    +' <td><center><label href="#" class="label label-default">'+datos[index].tipoSolicitud+'</label></center></td>'

                    
                    + '<td>'
                    +    enviada
                    +  '</td>'
                  + '</tr>';
                
              }
                $("#tbody_solicitudes").html(tr);
                eventos_solicitudes();

                // plugin dataTable
                $('#tbl_solicitudes').dataTable();
          }

      },
  });


}





//============================EVENTOS SOBRE LAS SOLICITUDES=============================
function eventos_solicitudes(){
    
  // ==== eventos para modal_confirm
  $(".btn_enviar").on("click", function(e){
      e.preventDefault();
      enviarSolicitudID = $(this).data("solicitud");
      $("#rrhh_enviar_solicitud").data("solicitud_id", enviarSolicitudID);
      $("#rrhh_modalEnviar").modal("show");

  });

}





//======================    VALIDAR FORMULARIO ========================







function  rrhh_validarForm(){
    var rrhh_salarioBruto=$("#rrhh_salarioBruto").val();
    var rrhh_salarioConDeduccion=$("#rrhh_salarioConDeduccion").val();
    var rrhh_derechos=$("#rrhh_derechos").val();
    var rrhh_antiguedad=$("#rrhh_antiguedad").val();
    var rrhh_comentario=$("#rrhh_comentario").val();


      $('.form-group').removeClass("has-warning");
      $('.form-group').removeClass("has-error");

      if (rrhh_salarioBruto === "") {
          $("#verSalarioBruto").addClass("has-error");
          $("#verSalarioBruto").find("label").text("Salario Bruto: Campo requerido.");
          $("#rrhh_salarioBruto").focus();
          return false;
      }

      if (rrhh_salarioConDeduccion === "") {
          $("#verSalaConDeduccion").addClass("has-error");
          $("#verSalaConDeduccion").find("label").text("Salario con Deduccion: Campo requerido.");
          $("#rrhh_salarioConDeduccion").focus();
          return false;
      }
      if (rrhh_derechos === "") {
          $("#verDerechos").addClass("has-error");
          $("#verDerechos").find("label").text("Derechos Acumulados: Campo requerido.");
          $("#rrhh_derechos").focus();
          return false;
      }

      if (rrhh_antiguedad === "") {
          $("#verAntiguedad").addClass("has-error");
          $("#verAntiguedad").find("label").text("Antiguedad: Campo requerido.");
          $("#rrhh_antiguedad").focus();
          return false;
      }
      if (rrhh_comentario === "") {
          $("#verComment").addClass("has-error");
          $("#verComment").find("label").text("Comentario: Campo requerido.");
          $("#rrhh_comentario").focus();
          return false;
      }

      
      return true;
  

}



$(document).ready(function(){

  cargarSolicitudes();

     // calculo automatico de edad
     $('.card2Edad').on('change', function(e) {
      e.preventDefault();
      var fecha  = $("#card2_naciAnio").val()+"-"+$("#card2_naciMes").val()+"-"+$("#card2_naciDia").val();
      $("#card2_edad").val(calcularEdad(fecha));
    })


    //eventos sobre radio botones en formularios
    $('#radioBtn a').on('click', function(e){
      e.preventDefault();
      var sel = $(this).data('title');
      var tog = $(this).data('toggle');
      $('#'+tog).prop('value', sel);
      $('a[data-toggle="'+tog+'"]').not('[data-title="'+sel+'"]').removeClass('active').removeClass('btn-primary').addClass('notActive').addClass('btn-default');
      $('a[data-toggle="'+tog+'"][data-title="'+sel+'"]').removeClass('notActive').removeClass('btn-default').addClass('btn-primary').addClass('active');
    });


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

      //configuracion inicial en el wizard
      wizard = $('#wizard_crearSolicitud').wizard({
        keyboard : true,
        contentHeight : 600,
        contentWidth : 1000,
        backdrop: 'static',
        showCancel: 'true' ,
        buttons: {
          cancelText: "Cancelar",
          nextText: "Siguiente",
          backText: "Atras",
          submitText: "Salir",
          submittingText: "enviando..."
        }
      });


      //evento abrir wizard
      $('.openWizard').click(function(e) {
        e.preventDefault();
        $("#opcion").val("0");
        var wizarTitle = "Formulario creación de nueva solicitud";
        wizard.setTitle(wizarTitle);
        wizard.show();
      });

      //evento submit del wizard
      wizard.on("submit", function(wizard) {
        wizard.submitSuccess();
      });

      //
      wizard.el.find(".wizard-success .im-done").click(function() {
        wizard.hide();
        setTimeout(function() {
          wizard.reset(); 
        }, 250);
        
      });


       //Carga los comentarios
       wizard.cards["card9"].on("loaded", function(card) {
        console.log("load comments:"+$("#solicitud_id").val());
        $.ajax({
          type: "POST",
          url: "../class/controller_solicitudes.php",
          data: {
            "opcion": "6",
            "solicitudID":$("#solicitud_id").val()
          },
          beforeSend: function(){
            $("#tbody_solicitudes").html('<div class = ""><img src="../img/load.gif" class = "img-responsive center-block" /></div>');
          },
          success: function(response){
            var datos = JSON.parse(response);
            var html = "No hay comentarios...";
            if (datos[0].bandera === 1) {
              for(var index = 1; index < datos.length ; index++){
                html += "<tr class=''>"
                +"<td>"+datos[index].modulo+"</td>"
                +"<td>"+datos[index].fecha+"</td>"
                +"<td>"+datos[index].usuarioID+"</td>"
                +"<td>"+datos[index].comentario+"</td>"
                +"</tr>";
              }
              $("#tbody_comentarios").html(html);
              cargarSolicitudes();
            }
            else{
              console.log("Error al obtener comentarios...");
            }

          }
        });
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
      $("#tbody_solicitudes").html('<div class = ""><img src="../img/load.gif" class = "img-responsive center-block" /></div>');
    },
    success: function(response){
      $("#tbody_solicitudes").html("");
      var tr = "";
      var estado = '';
      var enviada = '';
      var datos = JSON.parse(response);

      if (datos[0].bandera  === 1) {
        for(var index = 1; index < datos.length ; index++){
          switch(datos[index].estadoID) {
              case "2":
                  estado = '<td><center><label href="#" class="label label-default">Sin enviar</label></center></td>';
                  enviada = '<center><button data-solicitud = "'+ datos[index].solicitudID+'"" href="#" class=" btn btn-success btn_enviar"><i class="glyphicon glyphicon-send"></i></button></center>';
                  break;
              case "5":
                  estado = '<td><center><label href="#" class="label label-success">Aprobada</label></center></td>';
                  enviada = '<center><button data-solicitud = "'+ datos[index].solicitudID+'"" href="#" class=" btn btn-default "><i class="glyphicon glyphicon-send"></i></button></center>';
                  break;
              case "6":
                  estado = '<td><center><label href="#" class="label label-danger">Denegada</label></center></td>';
                  enviada = '<center><button data-solicitud = "'+ datos[index].solicitudID+'"" href="#" class=" btn btn-default "><i class="glyphicon glyphicon-send"></i></button></center>';
                  break;
              case "7":
                  estado = '<td><center><label href="#" class="label label-primary">Devuelta</label></center></td>';
                  enviada = '<center><button data-solicitud = "'+ datos[index].solicitudID+'"" href="#" class=" btn btn-default "><i class="glyphicon glyphicon-send"></i></button></center>';
                  break;

              default:
                estado = '<td><center><label href="#" class="label label-primary">Enviada</label></center></td>';
                enviada = '<center><button data-solicitud = "'+ datos[index].solicitudID+'"" href="#" class=" btn btn-default "><i class="glyphicon glyphicon-send"></i></button></center>';
                break;
          }
          
          tr += '<tr>'
          +'<td><center>'+datos[index].solicitudID+'</center></td>'
          + estado
          +'<td><center>'+datos[index].fechaCreacion+'</center></td>'
          +'<td><center>'+datos[index].identidad+'</center></td>'
          +'<td><center>'+datos[index].solicitanteNombre+'</center></td>'
          +' <td><center><label href="#" class="label label-default">'+datos[index].tipoSolicitud+'</label></center></td>'
          + '<td>'
          +    '<center><button  href="#" data-solicitud="'+datos[index].solicitudID+'" class="btn btn-info editarWizard"><i class="glyphicon glyphicon-file"></i></button></center>'
          + '</td>'

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

  //evento abrir wizard
  $('.editarWizard').click(function(e) {
    e.preventDefault();
    wizard.reset();
    $("#opcion").val("4");
    var solicitud = $(this).data("solicitud");
    wizarTitle = "Formulario editar solicitud #"+solicitud;
    wizard.setTitle(wizarTitle);
    llenarWizard(solicitud);
    wizard.show();
  });

}

//======================    LLENAR WIZARD ========================

function llenarWizard(solicitudID){
  $.post('../class/controller_solicitudes.php', {"opcion":"3", "solicitudID": solicitudID}, function(response){
    var data = JSON.parse(response);
    var index = 1;
    if (data[0].bandera === '1') {

      $("#solicitud_id").val(solicitudID);

      $("#card1_tipoSolicitud").val(data[index].tipoSolicitudID);
      $("#card1_tipoPrestamo").val(data[index].tipoPrestamoID);

      $("#card2_Pnombre").val(data[index].soli_Pnombre);
      $("#card2_Snombre").val(data[index].soli_Snombre);
      $("#card2_Papellido").val(data[index].soli_Papellido);
      $("#card2_Sapellido").val(data[index].soli_Sapellido);

      $("#card2_identidad").val(data[index].soli_identidad);
      $("#card2_RTN").val(data[index].soli_RTN);
      $("#card2_edad").val(calcularEdad(data[index].soli_fechaNacimiento));

      tog = "card2_sexo";
      sel = data[index].soli_sexo;
      $('a[data-toggle="'+tog+'"][data-title="'+sel+'"]').removeClass('notActive').removeClass('btn-default').addClass('btn-primary').addClass('active');
      $("#"+tog).val(sel);

      $("#card2_tipoVivienda").val(data[index].soli_tipoViviendaID);
      $("#card2_pagoVivienda").val(data[index].soli_pagoVivienda);

      var fechaNac = data[index].soli_fechaNacimiento.split('-');
      $("#card2_naciAnio").val(fechaNac[0]);
      $("#card2_naciMes").val(fechaNac[1]);
      $("#card2_naciDia").val(fechaNac[2]);

      $("#card2_lugarNaci").val(data[index].soli_lugarNaci);

      $("#card2_direccion").val(data[index].soli_direccion);
      $("#card2_residencia").val(data[index].soli_residencia);
      $("#card2_nacionalidad").val(data[index].soli_nacionalidad);
      $("#card2_ocupacion").val(data[index].soli_ocupacion);

      $("#card2_email").val(data[index].soli_email);
      $("#card2_tel").val(data[index].soli_tel);
      $("#card2_cel").val(data[index].soli_cel);

      $("#card2_dependientes").val(data[index].soli_dependientes);
      $("#card2_hijos").val(data[index].soli_hijos);

      tog = "card2_estadoCivil";
      sel = data[index].soli_estadoCivil;
      $('a[data-toggle="'+tog+'"][data-title="'+sel+'"]').removeClass('notActive').removeClass('btn-default').addClass('btn-primary').addClass('active');
      $("#"+tog).val(sel);

      $("#card3_cant").val(data[index].cantSolicitada);
      $("#card3_plazo").val(data[index].plazo);
      $("#card3_destino").val(data[index].destino);

      $("#card4_empresa").val(data[index].soli_empresa);
      $("#card4_cargo").val(data[index].soli_posicion);
      $("#card4_tiempo").val(data[index].soli_aniosTrabajo);
      $("#card4_sueldo").val(data[index].soli_sueldo);
      $("#card4_jefe").val(data[index].soli_jefe);
      $("#card4_otroIngreso").val(data[index].soli_otrosIngresos);
      $("#card4_telefono").val(data[index].soli_empresaTel);
      $("#card4_telefonoExt").val(data[index].soli_empresaExt);
      $("#card4_selectActividad").val(data[index].soli_actividadEmpresa);
      $("#card4_direccion").val(data[index].soli_empresaDireccion);

      $("#card5_Pnombre").val(data[index].conyu_Pnombre);
      $("#card5_Snombre").val(data[index].conyu_Snombre);
      $("#card5_Papellido").val(data[index].conyu_Papellido);
      $("#card5_Sapellido").val(data[index].conyu_Sapellido);
      $("#card5_identidad").val(data[index].conyu_identidad);
            // $("#card5_identidad").val(data[index].conyu_fechaNacimiento);
            var fechaNac = data[index].conyu_fechaNacimiento.split('-');
            $("#card5_naciAnio").val(fechaNac[0]);
            $("#card5_naciMes").val(fechaNac[1]);
            $("#card5_naciDia").val(fechaNac[2]);

            $("#card5_profesion").val(data[index].conyu_ocupacion);

            tog = "card5_tipoVivienda";
            $("#card5_tipoVivienda").val(data[index].conyu_tipoVivienda);
            $("#card5_pagoVivienda").val(data[index].conyu_pagoVivienda);

            $("#card5_tel").val(data[index].conyu_tel);
            $("#card5_cel").val(data[index].conyu_cel);
            
            $("#card5_lugarLabor").val(data[index].conyu_empresa);
            $("#card5_ingresoMensual").val(data[index].conyu_sueldo);
            $("#card5_cargo").val(data[index].conyu_cargo);

            $("#card6_Pnombre").val(data[index].fiador_Pnombre);
            $("#card6_Snombre").val(data[index].fiador_Snombre);
            $("#card6_Papellido").val(data[index].fiador_Papellido);
            $("#card6_Sapellido").val(data[index].fiador_Sapellido);
            $("#card6_direccion").val(data[index].fiador_direccion);
            $("#card6_identidad").val(data[index].fiador_identidad);
            $("#card6_residencia").val(data[index].fiador_residencia);

            tog = "card6_estadoCivil";
            sel = data[index].fiador_estadoCivil;
            $('a[data-toggle="'+tog+'"][data-title="'+sel+'"]').removeClass('notActive').removeClass('btn-default').addClass('btn-primary').addClass('active');
            $("#"+tog).val(sel);

            $("#card6_dependientes").val(data[index].fiador_dependientes);

            $("#card6_tel").val(data[index].fiador_telefono);
            $("#card6_cel").val(data[index].fiador_cel);
            $("#card6_email").val(data[index].fiador_email);

            
            $("#card6_empresa").val(data[index].fiador_empresa);
            $("#card6_posicion").val(data[index].fiador_posicion);
            $("#card6_tiempoServicio").val(data[index].fiador_aniosTrabajo);
            $("#card6_sueldoMensual").val(data[index].fiador_sueldo);
            $("#card6_otrosIngresos").val(data[index].fiador_otrosIngresos);
            $("#card6_empresaTel").val(data[index].fiador_empresaTel);
            $("#card6_empresaExt").val(data[index].fiador_empresaExt);
            $("#card6_jefe").val(data[index].fiador_jefe);
            $("#card6_selectActividad").val(data[index].fiador_ActividadEmpresa);
            cargar_referencias(solicitudID);
          }
          else{
            show_alert(2, data[0].mensajeError);
          }
        });

}

function cargar_referencias(solicitudID){
 $.post('../class/controller_solicitudes.php', {"opcion":"5", "solicitudID": solicitudID}, function(response){;
  var data = JSON.parse(response);
  var index = 1;
  if (data[0].bandera  === '1') {
    for(var index = 1; index < data.length ; index++){
      if (index === 1) {
        $("#card7_nombre").val(data[index].nombre_completo);
        $("#card7_tel").val(data[index].telefono_residencia);
        $("#card7_trabajo").val(data[index].trabajo);
        $("#card7_parentesco").val(data[index].parentesco);
      }
      else{
        if (index === 2) {
          $("#card7_nombre2").val(data[index].nombre_completo);
          $("#card7_tel2").val(data[index].telefono_residencia);
          $("#card7_trabajo2").val(data[index].trabajo);
          $("#card7_parentesco2").val(data[index].parentesco);
        }else{
          $("#card8_nombre").val(data[index].nombre_completo);
          $("#card8_tel").val(data[index].telefono_residencia);
          $("#card8_trabajo").val(data[index].trabajo);
          $("#card8_parentesco").val(data[index].parentesco);
        }
      }
    }
  }
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

//RETORNA EDAD SEGUN FECHA RECIBIDA(YYYY-MM-DD)
function calcularEdad(fecha)
{
    // Si la fecha es correcta, calculamos la edad
    var values=fecha.split("-");
    var dia = values[2];
    var mes = values[1];
    var ano = values[0];

    // obtenemos los valores actuales
    var fecha_hoy = new Date();
    var ahora_ano = fecha_hoy.getYear();
    var ahora_mes = fecha_hoy.getMonth()+1;
    var ahora_dia = fecha_hoy.getDate();

    // realizamos el calculo
    var edad = (ahora_ano + 1900) - ano;
    if ( ahora_mes < mes )
    {
      edad--;
    }
    if ((mes == ahora_mes) && (ahora_dia < dia))
    {
      edad--;
    }
    if (edad > 1900)
    {
      edad -= 1900;
    }

    // calculamos los meses
    return edad;
  }



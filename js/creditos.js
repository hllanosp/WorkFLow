

$(document).ready(function() {
  // Llamado a la funcion cargarUsuarios
  cargarSolicitudes();


  $('.card2Edad').on('change', function(e) {
    e.preventDefault();
    var fecha  = $("#card2_anyo").val()+"-"+$("#card2_Mes").val()+"-"+$("#card2_dia").val();
    $("#card2_edad").val(calcularEdad(fecha));
  })

  var fecha = rellenaAnyos(150);
  $("#seleccionaAnyo").html(fecha);

  // ========================================================================================================
  $('#radioBtn a').on('click', function(){
    var sel = $(this).data('title');
    var tog = $(this).data('toggle');
    $('#'+tog).prop('value', sel);
    $('a[data-toggle="'+tog+'"]').not('[data-title="'+sel+'"]').removeClass('active').removeClass('btn-primary').addClass('notActive').addClass('btn-default');
    $('a[data-toggle="'+tog+'"][data-title="'+sel+'"]').removeClass('notActive').removeClass('btn-default').addClass('btn-primary').addClass('active');
  });


  $("#btn_confirmEnviar").on("click", function(e){
    e.preventDefault();
    var comment = $("#comentario").val();
    $.post('../class/controller_creditos.php', {"opcion":"2", "comment": comment, "solicitudID": enviarSolicitudID}, function(response){
      console.log(response);
      var data = JSON.parse(response);
      if (data[0].bandera === '1') {
        cargarSolicitudes();
        show_alert(1, data[0].mensajeError);
        $("#modal_confirmEnviar").modal("hide");
        $("#comentario").val("");
      }
      else{
        show_alert(2, data[0].mensajeError);
      }
    });
  });


  //llamado a la modal wizar
  wizard = $('#wizard_EditarSolicitud').wizard({
    keyboard : true,
    contentHeight : 600,
    contentWidth : 1000,
    backdrop: 'static',
    showCancel: 'true' ,
    buttons: {
      cancelText: "Cancelar",
      nextText: "Siguiente",
      backText: "Atras",
      submitText: "Guardar",
      submittingText: "Guardando..."
    }
  });


  //evento submit del wizard
  wizard.on("submit", function(wizard) {
    console.log(wizard.serialize());
    $.ajax({
      url: "../class/controller_creditos.php",
      type: "POST",
      data: wizard.serialize()
    }).done(function(response) {
      console.log(response);
      var data = JSON.parse(response);
      if(data[0].bandera ===  '1'){
        show_alert(1, data[0].mensajeError);
          wizard.submitSuccess();         // displays the success card
          wizard.hideButtons();           // hides the next and back buttons
          wizard.updateProgressBar(0);    // sets the progress meter to 0
          // cargarSolicitudes();
        }else{
          show_alert(2, data[0].mensajeError)
          wizard.submitError();           // display the error card
          wizard.hideButtons(); 
        }
      }).fail(function(response) {
        console.log(response);
        wizard.submitError();           // display the error card
        wizard.hideButtons(); 
      });
    });

  //================  eventos en tarjeta wizard-success   ===========
  wizard.el.find(".wizard-success .im-done").click(function() {
    wizard.hide();
    setTimeout(function() {
      wizard.reset(); 
    }, 250);
  });


  //================  eventos en tarjeta wizard-error   ===========
  wizard.el.find(".wizard-error .im-done").click(function() {
    wizard.hide();
    setTimeout(function() {
      wizard.reset(); 
    }, 250);
  });

  //================  cerrar y limpiar wizard ===============
  wizard.on('closed', function(){
    wizard.reset();
  });

  wizard.on("reset", function() {
    wizard.modal.find(':input').val('');
    wizard.modal.find('.form-group').removeClass('has-error').removeClass('has-succes');
    $('#radioBtn a').removeClass('active').removeClass('btn-primary').addClass('notActive').addClass('btn-default');
    $('select').val("-1");
    $("#tbody_comentarios").html("No hay comentarios..");
  });


  // ================================================================================================== 
  // //VALIDACION DE LAS TARJETAS DEL MODAL WIZARD
  // ==================================================================================================
  $(".numeros").keypress(function(tecla){
    if( tecla.charCode >31 && (tecla.charCode < 45 || tecla.charCode > 57) ){
      return false;
    }
    else{
      return true;
    }
  });


  //-------------------------- Validacion de la primer tarjeta----------------------------------------- 
  wizard.cards["card1"].on("validate", function(card) {
    wizard.hidePopovers();
    var sel1 = card.el.find("#card1_tipoSolicitud");
    var sel2 = card.el.find("#card1_tipoPrestamo");
    var txt3 = card.el.find("#card1_prestamoID");
    var sel4 = card.el.find("#card1_destino");
    var sel5 = card.el.find("#card1_res");
    var sel6 = card.el.find("#card1_aval");

    var val1 = sel1.val();
    var val2 = sel2.val();
    var val3 = txt3.val();
    var val4 = sel4.val();
    var val5 = sel5.val();
    var val6 = sel6.val();

    if (val1 == "-1") {
      card.wizard.errorPopover(sel1, "Campo requerido");
      return false;
    }

    if (val2 == "-1") {
      card.wizard.errorPopover(sel2, "Campo requerido");
      return false;
    }

    if (val3 == ""){
      card.wizard.errorPopover(txt3,"Campo requerido");
      return false;
    }

    if (val4 == "-1"){
      card.wizard.errorPopover(sel4,"Campo requerido");
      return false;
    }

    if (val5 == ""){
      card.wizard.errorPopover(sel5,"Campo requerido");
      return false;
    }

    if (val6 == ""){
      card.wizard.errorPopover(sel6,"Campo requerido");
      return false;
    }

  });
  //--------------------------- Validaci¨®n de la segunda tarjeta--------------------------------------
  wizard.cards["card2"].on("validate", function(card){
    wizard.hidePopovers();
    var txt1 = card.el.find("#card2_Pnombre_sol");
    var txt2 = card.el.find("#card2_Snombre_sol");
    var txt3 = card.el.find("#card2_Papellido_sol");
    var txt4 = card.el.find("#card2_Sapellido_sol");
    var txt5 = card.el.find("#card2_identidad_sol");
    var txt6 = card.el.find("#card2_RTN_sol");
    var txt7 = card.el.find("#card2_Jefe");
    var txt8 = card.el.find("#card2_Tservicio");
    var rad1 = card.el.find("#card2_sexo");

    var alerta ="Campo requerido";

    var val1 = txt1.val();
    var val2 = txt2.val();
    var val3 = txt3.val();
    var val4 = txt4.val();
    var val5 = txt5.val();
    var val6 = txt6.val();
    var val7 = txt7.val();
    var val8 = txt8.val();
    var val9 = rad1.val();

    if (val1 == ""){
      card.wizard.errorPopover(txt1,alerta);
      return false;
    }

    if (val2 == ""){
      card.wizard.errorPopover(txt2,alerta);
      return false;
    }

    if (val3 == ""){
      card.wizard.errorPopover(txt3,alerta);
      return false;
    }

    if (val4 == ""){
      card.wizard.errorPopover(txt4,alerta);
      return false;
    }

    if (val5 == ""){
      card.wizard.errorPopover(txt5,alerta);
      return false;
    }

    if (val6 == ""){
      card.wizard.errorPopover(txt6,alerta);
      return false;
    }

    if (val7 == ""){
      card.wizard.errorPopover(txt7,alerta);
      return false;
    }


    if (val8 == ""){
      card.wizard.errorPopover(txt8,alerta);
      return false;
    }

    if (val9 == ""){
      card.wizard.errorPopover(rad1,alerta);
      return false;
    }

    return true;
  });


  wizard.cards["card3"].on("validate", function(card){
    wizard.hidePopovers();
    var text1 = card.el.find("#card3_Pnombre_fiador");
    var text2 = card.el.find("#card3_Snombre_fiador");
    var text3 = card.el.find("#card3_Papellido_fiador");
    var text4 = card.el.find("#card3_Sapellido_fiador");
    var text5 = card.el.find("#card3_identidad_fiador");
    var text6 = card.el.find("#card3_nombre_empresa");

    var alerta ="Campo requerido";

    var val1 = text1.val();
    var val2 = text2.val();
    var val3 = text3.val();
    var val4 = text4.val();
    var val5 = text5.val();
    var val6 = text6.val();


    if (val1 == ""){
      card.wizard.errorPopover(text1,alerta);
      return false;
    }

    if (val2 == ""){
      card.wizard.errorPopover(text2,alerta);
      return false;
    }

    if (val3 == ""){
      card.wizard.errorPopover(text3,alerta);
      return false;
    }

    if (val4 == ""){
      card.wizard.errorPopover(text4,alerta);
      return false;
    }

    if (val5 == ""){
      card.wizard.errorPopover(text5,alerta);
      return false;
    }

    if (val6 == ""){
      card.wizard.errorPopover(text6,alerta);
      return false;
    }



    return true;
  });

  wizard.cards["card4"].on("validate", function(card){
    wizard.hidePopovers();
    var text1 = card.el.find("#card4_monto");
    var text2 = card.el.find("#card4_plazoap");
    var text3 = card.el.find("#card4_cuota");
    var text4 = card.el.find("#card4_interes");
    var text5 = card.el.find("#card4_garantia");
    var text6 = card.el.find("#card4_RCI");
    var text7 = card.el.find("#card4_TDI");
    var text8 = card.el.find("#card4_confirmacion");
    var text9 = card.el.find("#card4_analista");


    var alerta ="Campo requerido";

    var val1 = text1.val();
    var val2 = text2.val();
    var val3 = text3.val();
    var val4 = text4.val();
    var val5 = text5.val();
    var val6 = text6.val();
    var val7 = text7.val();
    var val8 = text8.val();
    var val9 = text9.val();


    if (val1 == ""){
      card.wizard.errorPopover(text1,alerta);
      return false;
    }

    if (val2 == ""){
      card.wizard.errorPopover(text2,alerta);
      return false;
    }

    if (val3 == ""){
      card.wizard.errorPopover(text3,alerta);
      return false;
    }

    if (val4 == ""){
      card.wizard.errorPopover(text4,alerta);
      return false;
    }

    if (val5 == ""){
      card.wizard.errorPopover(text5,alerta);
      return false;
    }

    if (val6 == ""){
      card.wizard.errorPopover(text6,alerta);
      return false;
    }

    if (val7 == ""){
      card.wizard.errorPopover(text7,alerta);
      return false;
    }

    if (val8 == ""){
      card.wizard.errorPopover(text8,alerta);
      return false;
    }

    if (val9 == ""){
      card.wizard.errorPopover(text9,alerta);
      return false;
    }

    return true;
  });

 

});



//===============================CARGAR SOLICITUDES=========================
function cargarComentarios(solicitudID){
  $.ajax({
    type: "POST",
    url: "../class/controller_solicitudes.php",
    data: {
      "opcion": "6",
      "solicitudID":solicitudID
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
      }
      else{
        console.log("Error al obtener comentarios...");
      }

    }
  });
  
}


//=======================CARGAR INFORMACION DE RRHH=========================
function cargarInfoRRHH(solicitudID){
  $.ajax({
     type: "POST",
     url: "../class/controller_creditos.php",
     data: {
       "opcion": "6",
       "solicitudID":solicitudID
     },
     beforeSend: function(){
       $("#tbody_solicitudes").html('<div class = ""><img src="../img/load.gif" class = "img-responsive center-block" /></div>');
     },
     success: function(response){
      console.log(response);
      var datos = JSON.parse(response);
      var index = 1;
      if (datos[0].bandera === 1) {
       if (datos.length > 1) {
         $("#rrhh_salarioBruto").val(datos[index].salarioBruto);
         $("#rrhh_salarioConDeduccion").val(datos[index].salarioConDeduccion);
         $("#rrhh_derechos").val(datos[index].derechos);
         $("#rrhh_antiguedad").val(datos[index].tiempoLabor);
         $("#rrhh_comentario").val(datos[index].comentario);
       }
       else{
         $("#title_rrhh").text("No hay informacion de Recursos Hunamos para este solicitante");
       }
     }
     else{
       show_alert(2, datos[0].mensajeError);
     }

    }
  });

}


//===============================CARGAR SOLICITUDES=========================
function cargarSolicitudes(){
  $.ajax({
    type: "POST",
    url: "../class/controller_creditos.php",
    data: {
      "opcion": "1"
    },
    beforeSend: function(){
      $("#tbody_creditos").html('<div class = ""><img src="../img/load.gif" class = "img-responsive center-block" /></div>');
    },
    success: function(response){
      $("#tbody_creditos").html("");
      var tr = "";
      var estado = "";
      var enviada = "";
      var datos = JSON.parse(response);
      if (datos[0].bandera  === 1) {
        for(var index = 1; index < datos.length ; index++){
          switch(datos[index].estadoID) {
              case "3":
                  estado = '<td><center><label href="#" class="label label-default">Sin enviar</label></center></td>';
                  enviada = '<center><button data-solicitud = "'+ datos[index].solicitudID+'"" href="#" class=" btn btn-success btn_enviar"><i class="glyphicon glyphicon-send"></i></button></center>';
                  break;
              case "4":
                  estado = '<td><center><label href="#" class="label label-primary">Enviada</label></center></td>';
                enviada = '<center><button data-solicitud = "'+ datos[index].solicitudID+'"" href="#" class=" btn btn-default "><i class="glyphicon glyphicon-send"></i></button></center>';
                  break;
              case "5":
                  estado = '<td><center><label href="#" class="label label-success">Aprobada</label></center></td>';
                  enviada = '<center><button data-solicitud = "'+ datos[index].solicitudID+'"" href="#" class=" btn btn-default "><i class="glyphicon glyphicon-send"></i></button></center>';
                  break;
              case "6":
                  estado = '<td><center><label href="#" class="label label-danger">Denegada</label></center></td>';
                  enviada = '<center><button data-solicitud = "'+ datos[index].solicitudID+'"" href="#" class=" btn btn-success btn_enviar"><i class="glyphicon glyphicon-send"></i></button></center>';

                  break;
              case "7":
                  estado = '<td><center><label href="#" class="label label-primary">Devuelta</label></center></td>';
                  enviada = '<center><button data-solicitud = "'+ datos[index].solicitudID+'"" href="#" class=" btn btn-success btn_enviar"><i class="glyphicon glyphicon-send"></i></button></center>';
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
          +    '<center><button  href="#" data-solicitud="'+datos[index].solicitudID+'" class="btn_editar_credito btn btn-info"><i class="glyphicon glyphicon-edit"></i></button></center>'
          +  '</td>'
          + '<td>'
          +    enviada
          +  '</td>'
          + '</tr>';
          + '</tr>';

        }
        $("#tbody_creditos").html(tr);
        eventos_creditos();
        // estilo de tabla
        $('#tbl_creditos').dataTable();
      }
    },
  });
}


// ============================Eventos de credito===========================
function eventos_creditos(){
  $(".btn_enviar").on("click", function(e){
    e.preventDefault();
    enviarSolicitudID = $(this).data("solicitud");
    $("#enviar_solicitud").data("solicitud_id", enviarSolicitudID);
    $("#modal_confirmEnviar").modal("show");

  });
  //evento abrir wizard
  $('.btn_editar_credito').click(function(e) {
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

// ==========================================================
function llenarWizard(solicitudID){
  $.post('../class/controller_creditos.php', {"opcion":"3", "solicitudID": solicitudID}, function(response){
    var data = JSON.parse(response);
    if (data[0].bandera === '1') {
      var index = 1;
      $("#solicitud_id").val(solicitudID);

      $("#card1_tipoSolicitud").val(data[index].tipoSolicitudID);
      $("#card1_tipoPrestamo").val(data[index].tipoPrestamoID);
      $("#card1_prestamoID").val(data[index].prestamoID);
      $("#card1_cant_solicitada").val(data[index].cantSolicitada);
      $("#card1_destino").val(data[index].destino);

      $("#card1_res").val(data[index].responsabilidadID);
      tog = "card1_res";
      sel = data[index].responsabilidadID;
      $('a[data-toggle="'+tog+'"][data-title="'+sel+'"]').removeClass('notActive').removeClass('btn-default').addClass('btn-primary').addClass('active');

      $("#card1_aval").val(data[index].tipo_aprobacion);
      tog = "card1_aval";
      sel = data[index].tipo_aprobacion;
      $('a[data-toggle="'+tog+'"][data-title="'+sel+'"]').removeClass('notActive').removeClass('btn-default').addClass('btn-primary').addClass('active');


      $("#card2_Pnombre_sol").val(data[index].soli_Pnombre);
      $("#card2_Snombre_sol").val(data[index].soli_Snombre);
      $("#card2_Papellido_sol").val(data[index].soli_Papellido);
      $("#card2_Sapellido_sol").val(data[index].soli_Sapellido);
      $("#card2_identidad_sol").val(data[index].soli_identidad);
      $("#card2_RTN_sol").val(data[index].soli_RTN);

      $("#card2_sexo").val(data[index].soli_sexo);
      tog = "card2_sexo";
      sel = data[index].soli_sexo;
      $('a[data-toggle="'+tog+'"][data-title="'+sel+'"]').removeClass('notActive').removeClass('btn-default').addClass('btn-primary').addClass('active');

      $("#card2_edad").val(calcularEdad(data[index].soli_fechaNacimiento));

      var fechaNac = data[index].soli_fechaNacimiento.split('-');
      $("#card2_anyo").val(fechaNac[0]);
      $("#card2_Mes").val(fechaNac[1]);
      $("#card2_dia").val(fechaNac[2]);


      $("#card2_estadoCivil").val(data[index].soli_estadoCivil);
      tog = "card2_estadoCivil";
      sel = data[index].soli_estadoCivil;
      $('a[data-toggle="'+tog+'"][data-title="'+sel+'"]').removeClass('notActive').removeClass('btn-default').addClass('btn-primary').addClass('active');


      $("#card2_Jefe").val(data[index].soli_jefe);
      $("#card2_Tservicio").val(data[index].soli_aniosTrabajo);


      $("#card3_Pnombre_fiador").val(data[index].fiador_Pnombre);
      $("#card3_Snombre_fiador").val(data[index].fiador_Snombre);
      $("#card3_Papellido_fiador").val(data[index].fiador_Papellido);
      $("#card3_Sapellido_fiador").val(data[index].fiador_Sapellido);
      $("#card3_identidad_fiador").val(data[index].fiador_identidad);
      // $("#card3_sexo").val(data[index].fiador_sexo);
      // tog = "card3_sexo";
      // sel = data[index].fiador_sexo;
      // $('a[data-toggle="'+tog+'"][data-title="'+sel+'"]').removeClass('notActive').removeClass('btn-default').addClass('btn-primary').addClass('active');
      
      $("#card3_nombre_empresa").val(data[index].fiador_empresa);
      
      $("#card3_estadoCivil").val(data[index].fiador_estadoCivil);
      tog = "card3_estadoCivil";
      sel = data[index].fiador_estadoCivil;
      $('a[data-toggle="'+tog+'"][data-title="'+sel+'"]').removeClass('notActive').removeClass('btn-default').addClass('btn-primary').addClass('active');

      // var fechaNac = data[index].fiador_fechaNacimiento.split('-');
      // $("#card3_anyo").val(fechaNac[0]);
      // $("#card3_Mes").val(fechaNac[1]);
      // $("#card3_dia").val(fechaNac[2]);
      
      $("#card4_monto").val(data[index].monto_aprobado);
      $("#card4_plazoap").val(data[index].plazo_aprobado);
      $("#card4_cuota").val(data[index].cuota_nivelada);
      $("#card4_interes").val(data[index].tasa_interes);
      $("#card4_garantia").val(data[index].descrpicion_garantia);
      $("#card4_RCI").val(data[index].RCI);
      $("#card4_TDI").val(data[index].TDI);
      
      $("#card4_confirmacion").val(data[index].confirmacion);
      tog = "card4_confirmacion";
      sel = data[index].confirmacion;
      $('a[data-toggle="'+tog+'"][data-title="'+sel+'"]').removeClass('notActive').removeClass('btn-default').addClass('btn-primary').addClass('active');
      
      $("#card4_analista").val(data[index].comentario_analista);    
    }
    else{
      show_alert(2, data[0].mensajeError);
    }
  });


  cargarComentarios(solicitudID);
  cargarInfoRRHH(solicitudID);
}


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

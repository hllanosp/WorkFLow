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


    $("#enviar_solicitud").on("click", function(e){
        e.preventDefault();
        var comment = $("#comentario").val();
        $.post('../../class/controller_solicitudes.php', {"opcion":"2", "comment": comment, "solicitudID": enviarSolicitudID}, function(response){
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
            submitText: "Enviar",
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
        $.ajax({
            url: "../../class/controller_solicitudes.php",
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
                cargarSolicitudes();
            }else{
                show_alert(2, data[0].mensajeError)
                wizard.submitError();           // display the error card
                wizard.hideButtons(); 
            }

           
        }).fail(function(response) {
            console.log("fail"+response);
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
    
    //
    wizard.el.find(".wizard-success .crearOtraSolicitud").click(function() {
        wizard.reset();
    });

    //================  eventos en tarjeta wizard-error   ===========
    wizard.el.find(".wizard-error .im-done").click(function() {
      wizard.hide();
      setTimeout(function() {
        wizard.reset(); 
      }, 250);
    });

    //================  cerrar y limpiar wizard ===============
    wizard.on('closed', function() {
      wizard.reset();
    });


    wizard.on("reset", function() {
      wizard.modal.find(':input').val('');
      wizard.modal.find('.form-group').removeClass('has-error').removeClass('has-succes');
      $('#radioBtn a').removeClass('active').removeClass('btn-primary').addClass('notActive').addClass('btn-default');
      $('select').val("-1");
    });



    // =============================================================================================================
    // =====================================   VALIDACION DE WIZARD    =============================================
    $(".numeros").keypress(function(tecla){
       if( tecla.charCode >31 && (tecla.charCode < 45 || tecla.charCode > 57) )  return false;
       else{
        return true;
       }
    });

  
    
    // =============================================================================================================

    wizard.cards["card1"].on("validate", function(card) {
        wizard.hidePopovers();
        var name1 = card.el.find("#card1_tipoSolicitud");
        var name2 = card.el.find("#card1_tipoPrestamo");
        var val1 = name1.val();
        var val2 = name2.val();

        if (val1 == "-1") {
            card.wizard.errorPopover(name1, "Campo requerido");
            return false;
        }
        if (val2 == "-1") {
            card.wizard.errorPopover(name2, "Campo requerido");
            return false;
        }
        return true;
    });

    // ====================  VALIDACION CARD 2   ====================
    wizard.cards["card2"].on("validate", function(card) {
        wizard.hidePopovers();
        var input1 = card.el.find("#card2_Pnombre");
        // var input2 = card.el.find("#card2_Snombre");
        var input3 = card.el.find("#card2_Papellido");
        // var input4 = card.el.find("#card2_Sapellido");
        var input5 = card.el.find("#card2_identidad");
        // var input6 = card.el.find("#card2_RTN");
        var input8 = card.el.find("#card2_sexo");

        var input9 = card.el.find("#card2_tipoVivienda");

        // // var input10 = card.el.find("#card2_lugarNaci");
        var input11= card.el.find("#card2_direccion");
        // // var input12 = card.el.find("#card2_nacionalidad");
        // var input13 = card.el.find("#card2_residencia");

        // var input14 = card.el.find("#card2_ocupacion");
        var input15 = card.el.find("#card2_email");
        var input16 = card.el.find("#card2_tel");
        var input17 = card.el.find("#card2_cel");

        var input18 = card.el.find("#card2_estadoCivil");
        // var input19 = card.el.find("#card2_dependientes");
        // var input20 = card.el.find("#card2_hijos");

        var name1 = input1.val();
        // var name2 = input1.val();
        var name3 = input1.val();
        // var name4 = input3.val();
        var name5 = input5.val();
        var name8 = input8.val();
        var name9 = input9.val();
        var name11 = input11.val();
        var name15 = input15.val();
        var name16 = input16.val();
        var name17 = input17.val();
        var name18 = input18.val();
    

        if (name1 == "") {
            card.wizard.errorPopover(input1, "Campo requerido");
            return false;
        }
        if (name3 == "") {
            card.wizard.errorPopover(input3, "Campo requerido");
            return false;
        }
        if (name5 == "") {
            card.wizard.errorPopover(input5, "Campo requerido");
            return false;
        }else{
           
        }

        if (name8 == "") {
            card.wizard.errorPopover(input8, "Campo requerido");
            return false;
        }

        if (name9 == "") {
            card.wizard.errorPopover(input9, "Campo requerido");
            return false;
        }
        if (name11 == "") {
            card.wizard.errorPopover(input11, "Campo requerido");
            return false;
        }

        if (name16 == "") {
            card.wizard.errorPopover(input16, "Campo requerido");
            return false;
        }
        if (name17 == "") {
            card.wizard.errorPopover(input17, "Campo requerido");
            return false;
        }
        if (name18 == "") {
            card.wizard.errorPopover(input18, "Campo requerido");
            return false;
        }

        var mailformat = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;  
        if (name15.match(mailformat)){
            $("#xmail").addClass('hide').slideDown('slow');
        }else{
            $("#xmail").removeClass('hide').slideDown('fast');
            return false;
        }



        
        return true;
    });

    
    // ====================  VALIDACION CARD 3   ====================
    wizard.cards["card3"].on("validate", function(card) {
        wizard.hidePopovers();
        var name1 = card.el.find("#card3_cant");
        var name2 = card.el.find("#card3_plazo");
        var name3 = card.el.find("#card3_destino");
        var val1 = name1.val();
        var val2 = name2.val();
        var val3 = name3.val();

        if (val1 == "") {
            card.wizard.errorPopover(name1, "Campo requerido");
            return false;
        }
        if (val2 == "") {
            card.wizard.errorPopover(name2, "Campo requerido");
            return false;
        }
        if (val3 == "-1") {
            card.wizard.errorPopover(name3, "Campo requerido");
            return false;
        }

        return true;
    });
    
    // ====================  VALIDACION CARD 4   ====================
    wizard.cards["card4"].on("validate", function(card) {
        wizard.hidePopovers();
        var name1 = card.el.find("#card4_empresa");
        var name2 = card.el.find("#card4_sueldo");
        var name3 = card.el.find("#card4_tiempo");
        var name4 = card.el.find("#card4_cargo");
        var name5 = card.el.find("#card4_otroIngreso");
        var name6 = card.el.find("#card4_direccion");
        var name7 = card.el.find("#card4_telefono");
        var name8 = card.el.find("#card4_jefe");
        var name9 = card.el.find("#card4_selectActividad");
        var val1 = name1.val();
        var val2 = name2.val();
        var val3 = name3.val();
        var val4 = name4.val();
        var val5 = name5.val();
        var val6 = name6.val();
        var val7 = name7.val();
        var val8 = name8.val();
        var val9 = name9.val();

        if (val1 == "") {
            card.wizard.errorPopover(name1, "Campo requerido");
            return false;
        }
        // if (val2 == "0") {
        //     card.wizard.errorPopover(name2, "Campo requerido");
        //     return false;
        // }
        // if (val3 == "0") {
        //     card.wizard.errorPopover(name3, "Campo requerido");
        //     return false;
        // }
        if (val4 == "") {
            card.wizard.errorPopover(name4, "Campo requerido");
            return false;
        }
        // if (val5 == "0") {
        //     card.wizard.errorPopover(name5, "Campo requerido");
        //     return false;
        // }
        // if (val6 == "") {
        //     card.wizard.errorPopover(name6, "Campo requerido");
        //     return false;
        // }
        // if (val7 == "") {
        //     card.wizard.errorPopover(name7, "Campo requerido");
        //     return false;
        // }
        if (val8 == "") {
            card.wizard.errorPopover(name8, "Campo requerido");
            return false;
        }
        if (val9 == "-1") {
            card.wizard.errorPopover(name9, "Campo requerido");
            return false;
        }

        return true;
    });
    
    // ====================  VALIDACION CARD 5  ====================
    wizard.cards["card5"].on("validate", function(card) {
        wizard.hidePopovers();
        if ($("#card2_estadoCivil").val() !== "1") {
            var name1 = card.el.find("#card5_Pnombre");
            var name90 = card.el.find("#card5_Papellido");
            var name2 = card.el.find("#card5_identidad");
            var name3 = card.el.find("#card5_naciDia");
            var name4 = card.el.find("#card5_naciMes");
            var name5 = card.el.find("#card5_naciAnio");
            var name6 = card.el.find("#card5_profesion");
            var name7 = card.el.find("#card5_ingresoMensual");
            var name8 = card.el.find("#card5_lugarLabor");
            var name9 = card.el.find("#card5_cargo");
            var name10 = card.el.find("#card5_tel");
            var name11= card.el.find("#card5_cel");
            var name12= card.el.find("#card5_tipoVivienda");
            var val1 = name1.val();
            var val2 = name2.val();
            var val3 = name3.val();
            var val4 = name4.val();
            var val5 = name5.val();
            var val6 = name6.val();
            var val7 = name7.val();
            var val8 = name8.val();
            var val9 = name9.val();
            var val10 = name10.val();
            var val11 = name11.val();
            var val90 = name90.val();
            var val12 = name12.val();

            if (val1 == "") {
                card.wizard.errorPopover(name1, "Campo requerido");
                return false;
            }
            if (val90 == "") {
                card.wizard.errorPopover(name90, "Campo requerido");
                return false;
            }
            if (val2 == "") {
                card.wizard.errorPopover(name2, "Campo requerido");
                return false;
            }
            if (val3 == "0") {
                card.wizard.errorPopover(name3, "Campo requerido");
                return false;
            }
            if (val4 == "0") {
                card.wizard.errorPopover(name4, "Campo requerido");
                return false;
            }
            if (val5 == "0") {
                card.wizard.errorPopover(name5, "Campo requerido");
                return false;
            }
            if (val6 == "") {
                card.wizard.errorPopover(name6, "Campo requerido");
                return false;
            }
            if (val7 == "0") {
                card.wizard.errorPopover(name7, "Campo requerido");
                return false;
            }
            if (val8 == "") {
                card.wizard.errorPopover(name8, "Campo requerido");
                return false;
            }
            if (val9 == "") {
                card.wizard.errorPopover(name9, "Campo requerido");
                return false;
            }
            if (val10 == "") {
                card.wizard.errorPopover(name10, "Campo requerido");
                return false;
            }
            if (val11 == "") {
                card.wizard.errorPopover(name11, "Campo requerido");
                return false;
            }
            if (val12 == "") {
                card.wizard.errorPopover(name12, "Campo requerido");
                return false;
            }
            
        }

        return true;
    });

    // ====================  VALIDACION CARD 6  ====================
    wizard.cards["card6"].on("validate", function(card) {
        wizard.hidePopovers();
        var name1 = card.el.find("#card6_Pnombre");
        var name2 = card.el.find("#card6_Snombre");
        var name3 = card.el.find("#card6_Papellido");
        var name4 = card.el.find("#card6_Sapellido");
        var name5 = card.el.find("#card6_lugarNaci");
        var name6 = card.el.find("#card6_direccion");
        var name7 = card.el.find("#card6_tel");
        var name8 = card.el.find("#card6_cel");
        var name9 = card.el.find("#card6_email");
        var name10 = card.el.find("#card6_estadoCivil");
        var name11= card.el.find("#card6_dependientes");
        var name12= card.el.find("#card6_empresa");
        var name13= card.el.find("#card6_posicion");
        var name14= card.el.find("#card6_tiempoServicio");
        var name15= card.el.find("#card6_sueldoMensual");
        var name16= card.el.find("#card6_otrosIngresos");
        var name17= card.el.find("#card6_tel");
        var name18= card.el.find("#card6_jefe");
        var name19= card.el.find("#card6_selectActividad");
        var val1 = name1.val();
        var val2 = name2.val();
        var val3 = name3.val();
        var val4 = name4.val();
        var val5 = name5.val();
        var val6 = name6.val();
        var val7 = name7.val();
        var val8 = name8.val();
        var val9 = name9.val();
        var val10 = name10.val();
        var val11 = name11.val();
        var val12 = name12.val();
        var val13 = name13.val();
        var val14 = name14.val();
        var val15 = name15.val();
        var val16 = name16.val();
        var val17 = name17.val();
        var val18 = name18.val();
        var val19 = name19.val();

        if (val1 == "") {
            card.wizard.errorPopover(name1, "Campo requerido");
            return false;
        }
        // if (val2 == "") {
        //     card.wizard.errorPopover(name2, "Campo requerido");
        //     return false;
        // }
        if (val3 == "0") {
            card.wizard.errorPopover(name3, "Campo requerido");
            return false;
        }
        // if (val4 == "0") {
        //     card.wizard.errorPopover(name4, "Campo requerido");
        //     return false;
        // }
        // if (val5 == "0") {
        //     card.wizard.errorPopover(name5, "Campo requerido");
        //     return false;
        // }
        if (val6 == "") {
            card.wizard.errorPopover(name6, "Campo requerido");
            return false;
        }
        if (val7 == "0") {
            card.wizard.errorPopover(name7, "Campo requerido");
            return false;
        }
        if (val8 == "") {
            card.wizard.errorPopover(name8, "Campo requerido");
            return false;
        }
        // if (val9 == "") {
        //     card.wizard.errorPopover(name9, "Campo requerido");
        //     return false;
        // }

        var mailformat = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;  
        if (val9.match(mailformat)){
            $("#xmail2").addClass('hide').slideDown('slow');
        }else{
            $("#xmail2").removeClass('hide').slideDown('fast');
            return false;
        }

        if (val10 == "") {
            card.wizard.errorPopover(name10, "Campo requerido");
            return false;
        }
        // if (val11 == "0") {
        //     card.wizard.errorPopover(name11, "Campo requerido");
        //     return false;
        // }
        if (val12 == "") {
            card.wizard.errorPopover(name12, "Campo requerido");
            return false;
        }
        if (val13 == "") {
            card.wizard.errorPopover(name13, "Campo requerido");
            return false;
        }
        // if (val14 == "0") {
        //     card.wizard.errorPopover(name14, "Campo requerido");
        //     return false;
        // }
        // if (val15 == "0") {
        //     card.wizard.errorPopover(name15, "Campo requerido");
        //     return false;
        // }
        // if (val16 == "0") {
        //     card.wizard.errorPopover(name16, "Campo requerido");
        //     return false;
        // }
        // if (val17 == "") {
        //     card.wizard.errorPopover(name17, "Campo requerido");
        //     return false;
        // }
        // if (val18 == "") {
        //     card.wizard.errorPopover(name18, "Campo requerido");
        //     return false;
        // }
        if (val19 == "-1") {
            card.wizard.errorPopover(name19, "Campo requerido");
            return false;
        }


        return true;

    });

    // ====================  VALIDACION CARD 7   ====================
    wizard.cards["card7"].on("validate", function(card) {
        wizard.hidePopovers();
        var name1 = card.el.find("#card7_nombre");
        var name2 = card.el.find("#card7_tel");
        var name3 = card.el.find("#card7_trabajo");
        var name4 = card.el.find("#card7_parentesco");

        var name5 = card.el.find("#card7_nombre2");
        var name6 = card.el.find("#card7_tel2");
        var name7 = card.el.find("#card7_trabajo2");
        var name8 = card.el.find("#card7_parentesco2");

        var val1 = name1.val();
        var val2 = name2.val();
        var val3 = name3.val();
        var val4 = name4.val();
        var val5 = name5.val();
        var val6 = name6.val();
        var val7 = name7.val();
        var val8 = name8.val();

        // if (val1 == "") {
        //     card.wizard.errorPopover(name1, "Campo requerido");
        //     return false;
        // }
        // if (val2 == "") {
        //     card.wizard.errorPopover(name2, "Campo requerido");
        //     return false;
        // }
        // if (val3 == "") {
        //     card.wizard.errorPopover(name3, "Campo requerido");
        //     return false;
        // }
        // if (val4 == "") {
        //     card.wizard.errorPopover(name4, "Campo requerido");
        //     return false;
        // }
        // if (val5 == "") {
        //     card.wizard.errorPopover(name5, "Campo requerido");
        //     return false;
        // }
        // if (val6 == "") {
        //     card.wizard.errorPopover(name6, "Campo requerido");
        //     return false;
        // }
        // if (val7 == "") {
        //     card.wizard.errorPopover(name7, "Campo requerido");
        //     return false;
        // }
        // if (val8 == "") {
        //     card.wizard.errorPopover(name8, "Campo requerido");
        //     return false;
        // }

        return true;
    });

    // ====================  VALIDACION CARD 8  ====================
    wizard.cards["card8"].on("validate", function(card) {
        wizard.hidePopovers();
        var name1 = card.el.find("#card8_nombre");
        var name2 = card.el.find("#card8_tel");
        var name3 = card.el.find("#card8_trabajo");
        var name4 = card.el.find("#card8_parentesco");

        var val1 = name1.val();
        var val2 = name2.val();
        var val3 = name3.val();
        var val4 = name4.val();
        // if (val1 == "") {
        //     card.wizard.errorPopover(name1, "Campo requerido");
        //     return false;
        // }
        // if (val2 == "") {
        //     card.wizard.errorPopover(name2, "Campo requerido");
        //     return false;
        // }
        // if (val3 == "") {
        //     card.wizard.errorPopover(name3, "Campo requerido");
        //     return false;
        // }
        // if (val4 == "") {
        //     card.wizard.errorPopover(name4, "Campo requerido");
        //     return false;
        // }

        return true;
    });

    //Carga los comentarios
    wizard.cards["card9"].on("loaded", function(card) {
        console.log("card9 loaded");
        $.ajax({
            type: "POST",
            url: "../../class/controller_solicitudes.php",
            data: {
                "opcion": "6",
                "solicitudID":$("#solicitud_id").val()
            },
            beforeSend: function(){
                $("#tbody_solicitudes").html('<div class = ""><img src="../../img/load.gif" class = "img-responsive center-block" /></div>');
            },
            success: function(response){
                var datos = JSON.parse(response);
                var html2 = "No hay comentarios...";
                if (datos[0].bandera === 1) {
                    for(var index = 1; index < datos.length ; index++){
                        html2 += "<tr class=''>"
                                +"<td>"+datos[index].modulo+"</td>"
                                +"<td>"+datos[index].fecha+"</td>"
                                +"<td>"+datos[index].usuarioID+"</td>"
                                +"<td>"+datos[index].comentario+"</td>"
                                +"</tr>";
                    }
                    $("#tbody_comentarios").html(html2);
                    cargarSolicitudes();
                }
                else{
                    show_alert(2,"Error al obtener comentarios...");
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

//====================CARGA DE USUARIOS ========================
function cargarSolicitudes(){
  $.ajax({
      type: "POST",
      url: "../../class/controller_solicitudes.php",
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
          var enviada = '';
          var datos = JSON.parse(response);

          if (datos[0].bandera  === 1) {
              for(var index = 1; index < datos.length ; index++){
                switch(datos[index].estadoID) {
                    case "1":
                        estado = '<td><center><label href="#" class="label label-default">Sin enviar</label></center></td>';
                        enviada = '<center><button data-solicitud = "'+ datos[index].solicitudID+'"" href="#" class=" btn btn-success btn_enviar"><i class="glyphicon glyphicon-send"></i></button></center>';
                        break;
                    case "2":
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
                    +    '<center><button data-solicitud = "'+ datos[index].solicitudID+'" href="#" class=" btn btn-primary editarWizard" ><i class="glyphicon glyphicon-edit"></i></button></center>'
                    +  '</td>'
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
      $("#enviar_solicitud").data("solicitud_id", enviarSolicitudID);
      $("#modal_confirmEnviar").modal("show");

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
    $.post('../../class/controller_solicitudes.php', {"opcion":"3", "solicitudID": solicitudID}, function(response){
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
            $("#card5_telefono").val(data[index].conyu_empresaTel);
            $("#card5_telefonoExt").val(data[index].conyu_empresaExt);

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
            $("#card6_hijos").val(data[index].fiador_hijos);
            tog = "card6_sexo";
            sel = data[index].fiador_sexo;
            $('a[data-toggle="'+tog+'"][data-title="'+sel+'"]').removeClass('notActive').removeClass('btn-default').addClass('btn-primary').addClass('active');
            $("#"+tog).val(sel);

            $("#card6_tipoVivienda").val(data[index].fiador_tipoVivienda);

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
            $("#card6_empresaDireccion").val(data[index].fiador_empresaDireccion);
            cargar_referencias(solicitudID);
        }
        else{
          show_alert(2, data[0].mensajeError);
        }
      });

}

function cargar_referencias(solicitudID){
     $.post('../../class/controller_solicitudes.php', {"opcion":"5", "solicitudID": solicitudID}, function(response){
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


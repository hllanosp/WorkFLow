$(document).ready(function(){

    var wizard = $('#wizard_crearSolicitud').wizard({
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
              },
          submitUrl: "../../class/controller_solicitudes.php"

     });


    //evento abrir wizard
    $('#btn_openWizardCrearSolicitud').click(function(e) {
          e.preventDefault();
          wizard.show();
          wizard.setTitle("Formulario ingreso de nueva solicitud");
    });


    //evento presionar submit en wizard
    wizard.on("submit", function(wizard) {
      console.log(wizard.serialize());
      console.log(wizard.serializeArray());

      // this.log('seralize()');
      // this.log(this.serialize());
      // this.log('serializeArray()');
      // this.log(this.serializeArray());

        // $.ajax({
        //     url: "/wizard_submit_url",
        //     type: "POST",
        //     url: wizard.args.submitUrl,
        //     data: wizard.serialize(),
        //     dataType: "json"
        // }).done(function(response) {
        //     wizard.submitSuccess();         // displays the success card
        //     wizard.hideButtons();           // hides the next and back buttons
        //     wizard.updateProgressBar(0);    // sets the progress meter to 0
        // }).fail(function() {
        //     wizard.submitError();           // display the error card
        //     wizard.hideButtons(); 
        // });
    });


    wizard.el.find(".wizard-success .im-done").click(function() {
      wizard.hide();
      setTimeout(function() {
        wizard.reset(); 
      }, 250);
      
    });

    //Evento al presionar boton finalizar de la tarjeta de error
    wizard.el.find(".wizard-error .im-done").click(function() {
      wizard.hide();
      setTimeout(function() {
        wizard.reset(); 
      }, 250);
      
    });


    wizard.el.find(".wizard-success .crearOtraSolicitud").click(function() {
      wizard.reset();
    });

    //evento al cerrar el wizard
    wizard.on('closed', function() {
      wizard.reset();
    });

    //limpiar wizard
    wizard.on("reset", function() {
      wizard.modal.find(':input').val('');
      wizard.modal.find('.form-group').removeClass('has-error').removeClass('has-succes');
    });


    //eventos sobre radio botones en formularios
    $('#radioBtn a').on('click', function(){
        var sel = $(this).data('title');
        var tog = $(this).data('toggle');
        $('#'+tog).prop('value', sel);

        $('a[data-toggle="'+tog+'"]').not('[data-title="'+sel+'"]').removeClass('active').addClass('notActive');
        $('a[data-toggle="'+tog+'"][data-title="'+sel+'"]').removeClass('notActive').addClass('active');
    });

    // =============================================================================================================
    // =====================================   VALIDACION DE WIZARD    =============================================
    // =============================================================================================================

    
    wizard.cards["card1"].on("validate", function(card) {
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
        var input1 = card.el.find("#card2_Pnombre");
        var input2 = card.el.find("#card2_Snombre");
        var input3 = card.el.find("#card2_Papellido");
        var input4 = card.el.find("#card2_Sapellido");
        var input5 = card.el.find("#card2_identidad");
        var input6 = card.el.find("#card2_RTN");
        var input7 = card.el.find("#card2_edad");
        var input8 = card.el.find("#card2_sexo");
        var input9 = card.el.find("#card2_tipoVivienda");

        var input10 = card.el.find("#card2_lugarNaci");
        var input11= card.el.find("#card2_direccion");
        var input12 = card.el.find("#card2_nacionalidad");
        var input13 = card.el.find("#card2_residencia");

        var input14 = card.el.find("#card2_ocupacion");
        var input15 = card.el.find("#card2_email");
        var input16 = card.el.find("#card2_tel");
        var input17 = card.el.find("#card2_cel");

        var input18 = card.el.find("#card2_estadoCivil");
        var input19 = card.el.find("#card2_dependientes");
        var input20 = card.el.find("#card2_hijos");

        var name1 = input1.val();
        var name2 = input2.val();
        var name3 = input3.val();
        var name4 = input4.val();
        var name5 = input5.val();
        var name6 = input6.val();
        var name7 = input7.val();
        var name8 = input8.val();
        var name9 = input9.val();
        var name10 = input10.val();
        var name11 = input11.val();
        var name12 = input12.val();
        var name13 = input13.val();
        var name14 = input14.val();
        var name15 = input15.val();
        var name16 = input16.val();
        var name17 = input17.val();
        var name18 = input18.val();
        var name19 = input19.val();
        var name20 = input20.val();

        // if (name1 == "") {
        //     card.wizard.errorPopover(input1, "Campo requerido");
        //     return false;
        // }
        // if (name2 == "") {
        //     card.wizard.errorPopover(input1, "Campo requerido");
        //     return false;
        // }
        // if (name3 == "") {
        //     card.wizard.errorPopover(input1, "Campo requerido");
        //     return false;
        // }

        
        return true;
    });
    
    // ====================  VALIDACION CARD 3   ====================
    wizard.cards["card3"].on("validate", function(card) {
        var name1 = card.el.find("#card3_cant");
        var name2 = card.el.find("#card3_plazo");
        var name3 = card.el.find("#card3_destino");
        var val1 = name1.val();
        var val2 = name2.val();
        var val3 = name3.val();

        // if (val1 == "0") {
        //     card.wizard.errorPopover(name1, "Campo requerido");
        //     return false;
        // }
        // if (val2 == "0") {
        //     card.wizard.errorPopover(name2, "Campo requerido");
        //     return false;
        // }
        // if (val3 == "") {
        //     card.wizard.errorPopover(name2, "Campo requerido");
        //     return false;
        // }

        return true;
    });
    
    // ====================  VALIDACION CARD 4   ====================
    wizard.cards["card4"].on("validate", function(card) {
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

        // if (val1 == "") {
        //     card.wizard.errorPopover(name1, "Campo requerido");
        //     return false;
        // }
        // if (val2 == "0") {
        //     card.wizard.errorPopover(name2, "Campo requerido");
        //     return false;
        // }
        // if (val3 == "0") {
        //     card.wizard.errorPopover(name3, "Campo requerido");
        //     return false;
        // }
        // if (val4 == "") {
        //     card.wizard.errorPopover(name4, "Campo requerido");
        //     return false;
        // }
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
        // if (val8 == "") {
        //     card.wizard.errorPopover(name8, "Campo requerido");
        //     return false;
        // }
        // if (val9 == "-1") {
        //     card.wizard.errorPopover(name9, "Campo requerido");
        //     return false;
        // }

        return true;
    });
    
    // ====================  VALIDACION CARD 5  ====================
    wizard.cards["card5"].on("validate", function(card) {
        var name1 = card.el.find("#card5_nombreCompleto");
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

        // if (val1 == "") {
        //     card.wizard.errorPopover(name1, "Campo requerido");
        //     return false;
        // }
        // if (val2 == "") {
        //     card.wizard.errorPopover(name2, "Campo requerido");
        //     return false;
        // }
        // if (val3 == "0") {
        //     card.wizard.errorPopover(name3, "Campo requerido");
        //     return false;
        // }
        // if (val4 == "0") {
        //     card.wizard.errorPopover(name4, "Campo requerido");
        //     return false;
        // }
        // if (val5 == "0") {
        //     card.wizard.errorPopover(name5, "Campo requerido");
        //     return false;
        // }
        // if (val6 == "") {
        //     card.wizard.errorPopover(name6, "Campo requerido");
        //     return false;
        // }
        // if (val7 == "0") {
        //     card.wizard.errorPopover(name7, "Campo requerido");
        //     return false;
        // }
        // if (val8 == "") {
        //     card.wizard.errorPopover(name8, "Campo requerido");
        //     return false;
        // }
        // if (val9 == "") {
        //     card.wizard.errorPopover(name9, "Campo requerido");
        //     return false;
        // }
        // if (val10 == "") {
        //     card.wizard.errorPopover(name10, "Campo requerido");
        //     return false;
        // }
        // if (val11 == "") {
        //     card.wizard.errorPopover(name11, "Campo requerido");
        //     return false;
        // }

        return true;
    });

    // ====================  VALIDACION CARD 6  ====================
    wizard.cards["card6"].on("validate", function(card) {
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

        // if (val1 == "") {
        //     card.wizard.errorPopover(name1, "Campo requerido");
        //     return false;
        // }
        // if (val2 == "") {
        //     card.wizard.errorPopover(name2, "Campo requerido");
        //     return false;
        // }
        // if (val3 == "0") {
        //     card.wizard.errorPopover(name3, "Campo requerido");
        //     return false;
        // }
        // if (val4 == "0") {
        //     card.wizard.errorPopover(name4, "Campo requerido");
        //     return false;
        // }
        // if (val5 == "0") {
        //     card.wizard.errorPopover(name5, "Campo requerido");
        //     return false;
        // }
        // if (val6 == "") {
        //     card.wizard.errorPopover(name6, "Campo requerido");
        //     return false;
        // }
        // if (val7 == "0") {
        //     card.wizard.errorPopover(name7, "Campo requerido");
        //     return false;
        // }
        // if (val8 == "") {
        //     card.wizard.errorPopover(name8, "Campo requerido");
        //     return false;
        // }
        // if (val9 == "") {
        //     card.wizard.errorPopover(name9, "Campo requerido");
        //     return false;
        // }
        // if (val10 == "-1") {
        //     card.wizard.errorPopover(name10, "Campo requerido");
        //     return false;
        // }
        // if (val11 == "0") {
        //     card.wizard.errorPopover(name11, "Campo requerido");
        //     return false;
        // }
        // if (val12 == "") {
        //     card.wizard.errorPopover(name12, "Campo requerido");
        //     return false;
        // }
        // if (val13 == "") {
        //     card.wizard.errorPopover(name13, "Campo requerido");
        //     return false;
        // }
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
        // if (val19 == "-1") {
        //     card.wizard.errorPopover(name19, "Campo requerido");
        //     return false;
        // }

        return true;

    });

    // ====================  VALIDACION CARD 7   ====================
    wizard.cards["card7"].on("validate", function(card) {
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
        //     card.wizard.errorPopover(name2, "Campo requerido");
        //     return false;
        // }
        // if (val4 == "") {
        //     card.wizard.errorPopover(name1, "Campo requerido");
        //     return false;
        // }
        // if (val5 == "") {
        //     card.wizard.errorPopover(name2, "Campo requerido");
        //     return false;
        // }
        // if (val6 == "") {
        //     card.wizard.errorPopover(name2, "Campo requerido");
        //     return false;
        // }
        // if (val7 == "") {
        //     card.wizard.errorPopover(name2, "Campo requerido");
        //     return false;
        // }
        // if (val8 == "") {
        //     card.wizard.errorPopover(name2, "Campo requerido");
        //     return false;
        // }

        return true;
    });


});


//==================================================================================
//=============================  VALIDACION DE TARJETAS ============================
//==================================================================================

// function validarWizard(){

 
// }
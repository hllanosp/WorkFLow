
$(document).ready(function() {
  cargarUsuarios();
  llenarRoles();
  grafico_usuariosActivos();

  // ================  EVENTOS ===============
  //modal nuevo usuario 
  $("#btn_nuevoUsuario").on('click',function(e){
    e.preventDefault();
    clearForm();
    $("#myModalLabel").html('Nuevo Usuario');
    $(".modal-footer").html('<button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button> <button id = "btn_guardarUsuario" data-user = "0" type="submit" class="btn btn-primary">Guardar nuevo usuario</button>');
    $("#modal_editarUsuario").modal("show");


     //guardar usuario
    $("#btn_guardarUsuario").on('click',function(e){
      e.preventDefault();
        if (validador()) {
          var datos = {
            "opcion": 4,
            "usuario": $("#nombreUsuario").val(),
            "pass":$("#password").val(),
            "rol": $("#select_rol option:selected").val()
          };
          $.post('../class/controller_mantenimiento.php', datos , function(response){
            var data = JSON.parse(response);
            if (data[0].bandera === 1) {
              $("#modal_editarUsuario").modal("hide");
              cargarUsuarios();
              show_alert(1, data[0].mensajeError );
              
            }
            else{
              show_alert(1, data[0].mensajeError );
            }
          });
        }
    });
  });

});


//====================CARGA DE USUARIOS ========================
function cargarUsuarios(){
  $.ajax({
      type: "POST",
      url: "../class/controller_mantenimiento.php",
      data: {
        "opcion": "0"
      },
      beforeSend: function(){
        $("#tbody_usuarios").html('<div class = ""><img src="../img/load.gif" class = "img-responsive center-block" /></div>');
      },
      success: function(response){
          $("#tbody_usuarios").html("");
          var tr = "";
          var estado = "";
          var datos = JSON.parse(response);
          if (datos[0].bandera  === 1) {
              for(var index = 1; index < datos.length ; index++){

                // if (datos[index].estado === "1") {
                //   estado = '<td><center><label href="#" class="label label-success">Activo</label></center></td>';
                // }else{
                //   estado = '<td><center><label href="#" class="label label-warning">Inactivo</label></center></td>';
                // }

                if (datos[index].estado === "1") {
                  estado = "<td><center><label class='label label-primary'>Habilitado</label></center></td>";
                }else{
                  estado = "<td><center><label class='label label-danger'>Deshabilitado</label></center></td>";
                }

                 tr += '<tr>'
                    +'<td><center>'+datos[index].usuario+'</center></td>'
                    +'<td><center>'+datos[index].rol_descripcion+'</center></td>'
                    +'<td><center>'+datos[index].fechaCreacion+'</center></td>'
                    + estado
                    + '<td>'
                    +    '<center><button data-usuario_id='+datos[index].usuarioID+' href="#" class="btn_editar btn btn-info"><i class="glyphicon glyphicon-edit"></i></button></center>'
                    +  '</td>'
                  + '</tr>';
                
              }
                $("#tbody_usuarios").html(tr);
                eventos_usuarios();

                // plugin dataTable
                $('#tbl_usuarios').dataTable();

                // // stilos de los switches
                $("[name='checkbox']").bootstrapSwitch();
          }

      },
  });


}

//============================EVENTOS SOBRE LOS USUARIOS=============================
function eventos_usuarios(){
  $(".btn_editar").on("click", function(e){
    e.preventDefault();
    clearForm();
    var usuarioID = $(this).data("usuario_id");
      $.post('../class/controller_mantenimiento.php', {"opcion":1, "usuarioID": usuarioID}, function(response){
        var data = JSON.parse(response);
        if (data[0].bandera === 1) {
          $("#myModalLabel").html('Editar Información de Usuario');
          $(".modal-footer").html('<button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button> <button id = "btn_editarUsuario" data-user = "0" type="submit" class="btn btn-primary">Guardar Cambios</button>');
          $("#userInfo").html('Usuario: <strong style = "color: #337AB7;">'+data[1].usuario+'</strong>  Ingresado el <strong style = "color:#337AB7;">'+data[1].fechaCreacion+'</strong>');
          $("#nombreUsuario").val(data[1].usuario);
          $("#select_rol").val(data[1].rol);
          $("#userID").val(usuarioID);
          var estado = "";
          if (data[1].estado === "1") {
            estado = "<input class = ' bootstrap-switch-wrapper bootstrap-switch-id-switch-state bootstrap-switch-animate bootstrap-switch-on' data-id = '1' data-on-color = 'primary' data-off-color = 'danger' data-off-text = 'Inactivo' data-on-text = 'activo' type='checkbox' name='checkbox' checked>";
          }else{
            estado = "<input class = ' bootstrap-switch-wrapper bootstrap-switch-id-switch-state bootstrap-switch-animate bootstrap-switch-on' data-id = '0' data-on-color = 'primary' data-off-color  = 'danger' data-off-text = 'Inactivo' data-on-text = 'activo' type='checkbox' name='checkbox'> ";
          }
          $("#estado").html(estado);

          // // stilos de los switches
          $("[name='checkbox']").bootstrapSwitch();

          $("#modal_editarUsuario").modal("show");

          var switch_status;
          $('[name="checkbox"]').on('switchChange.bootstrapSwitch', function(event, state) {
             if (state == true) {
               switch_status = 1;
             }
             else {
               switch_status = 0;
             }
          });

          //Editar usuario
          $("#btn_editarUsuario").on('click',function(e){
            e.preventDefault();
            if (validador()) {
              var datos = {
                "opcion": 3,
                "usuarioID":$("#userID").val(),
                "usuario": $("#nombreUsuario").val(),
                "pass":$("#password").val(),
                "rol": $("#select_rol option:selected").val(),
                "estado" : switch_status
              };

              $.post('../class/controller_mantenimiento.php', datos , function(response){
                var data = JSON.parse(response);
                if (data[0].bandera === 1) {
                  $("#modal_editarUsuario").modal("hide");
                  cargarUsuarios();
                  show_alert(1, data[0].mensajeError );
                  clearForm();
                }
                else{
                  show_alert(1, data[0].mensajeError );
                }
              });


            }
          });

        }
        else{
          // alert("Error al obtener datos del usuario...");
        }
      });
  });
}

//============================Llenar selects de roles de usuario=============================
function llenarRoles(){
    $.post('../class/controller_mantenimiento.php', {"opcion":2}, function(response){
        var data = JSON.parse(response);
        if (data[0].bandera === 1) {
          for (var i = 1; i < data.length; i++) {
            $("#select_rol").append('<option value = "'+data[i].rolID+'">'+data[i].descripcion+'</option>');
          }
        }
        else{
          // alert("Error al obtener los roles...");
        }
      });
}

//==============================LIMPIAR FORMULARIO======================
function clearForm(){
  $("#userInfo").html("");
  $("#nombreUsuario").val("");
  $("#select_rol").val(-1);
  $("#userID").val(-1);
  $("#password").val("");
  $("#password2").val("");
  $('.form-group').removeClass("has-warning");
  $('.form-group').removeClass("has-error");
}

// =======================GRAFICO DE USUARIOS ACTIVOS========================
function grafico_usuariosActivos(){
  var activos ;
  var inactivos ;
  $.post('../class/controller_mantenimiento.php', {"opcion":5}, function(response){
      var data = JSON.parse(response);
      if (data[0].bandera === 1) {
        activos = parseInt(data[2].activos);
        inactivos = parseInt(data[1].inactivos);

        $('#grafic_usuariosActivos').highcharts({
            chart: {
                plotBackgroundColor: null,
                plotBorderWidth: 0,
                plotShadow: false
            },
            title: {
                text: 'Usuarios<br> ',
                align: 'center',
                verticalAlign: 'middle',
                y: 50
            },
            tooltip: {
                pointFormat: '<b>{point.y}</b>'
            },
            plotOptions: {
                pie: {
                    dataLabels: {
                        enabled: false,
                        distance: -50,
                        style: {
                            fontWeight: 'bold',
                            color: 'white',
                            textShadow: '0px 1px 2px black'
                        }
                    },
                    startAngle: -90,
                    endAngle: 90,
                    center: ['50%', '60%']
                }
            },
            series: [{
                type: 'pie',
                innerSize: '50%',
                data: [
                    ["Habilitados", activos],["deshabilitados", inactivos]            ]
            }]
        });
        
      }
      else{
        // alert("Error al obtener los datos...");
      }
    });

    
}



//======================validacion personlizada======================
function validador(){
  
    var nombreUsuario = $("#nombreUsuario").val();
    var pass1 = $("#password").val();
    var pass2 = $("#password2").val();
    var rol = $('#select_rol option:selected').val();

    $('.form-group').removeClass("has-warning");
    $('.form-group').removeClass("has-error");

    //tamano del nombre de usuario
    if (nombreUsuario.length < 5) {
        $("#verUserName").addClass("has-error");
        $("#verUserName").find("label").text("Nombre del usuario: El nombre debe ser mayor a 5 caracteres");
        $("#nombreUsuario").focus();
        return false;
    }

    //tamanio de la contrasenia
    if (pass1.length < 5) {
        $("#verPass").addClass("has-error");
        $("#verPass").find("label").text("contraseña: Tiene que ser mayor a 5 caracteres");
        $("#password").focus();
        return false;
    }

    //usuario solo lleva letras y numeros
    if (esPalabra(nombreUsuario) === false) {
        $("#verUserName").addClass("has-error");
        $("#verUserName").find("label").text("Nombre del usuario: Solo son permitidos números y letras");
        $("#nombreUsuario").focus();
        return false;
    } else {
        $("#verUserName").removeClass("has-error");
        $("#verUserName").find("label").text("Nombre del usuario");
    }

    //usuario solo lleva letras y numeros
    if (esPalabra(pass1) === false) {
        $("#verPass").addClass("has-error");
        $("#verPass").find("label").text("Nombre del usuario: Solo son permitidos números y letras");
        $("#password").focus();
        return false;
    } else {
        $("#verPass").removeClass("has-error");
        $("#verPass").find("label").text("Nombre del usuario");
    }

    // valida si el password es el mismo que se ingreso la segunda vez
    if(pass1 == pass2){
        $("#verPass2").removeClass("has-error");
        $("#verPass2").find("label").text("Repetir contraseña");

    }else{
        $("#verPass2").addClass("has-error");
        $("#verPass2").find("label").text("Repetir contraseña: Error la contraseña no coincide");
        $("#password2").focus();
        return false;
    }

    //valida si selecciona un rol valido
    if (rol == '-1' ) {
      $("#verrol").addClass("has-error");
      $("#verrol").find("label").text("Selecciona un rol de usuario valido");
      $("#select_rol").focus();
      return false;
    } else {
      $("#verrol").removeClass("has-error");
      $("#verrol").find("label").text("-- Seleccione un rol de usuario -- ");
    }
    return true;
}

    //esPalabra: incluye letras numeros y una sola palabra
    function esPalabra(text) {
        var letters = /^[0-9a-zA-Z]+$/;
        if (text.match(letters)) {
            return true;
        } else {
            return false;
        }
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
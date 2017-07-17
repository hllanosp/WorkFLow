<!---INFORMACION DE LA PAGINA- -->

<?php
require_once("../login/seguridad.php");
sec_session_start();
    //verificamos si hay una sesión iniciada
if(!(isset($_SESSION['login']) && $_SESSION['login'] == '1')) {
  header("location: ../login/login.php?error_code=2");
}
else{
 $maindir = "../";
 $content = "rrhh";
 $usuario = $_SESSION['usuario'];
}
?>


<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
  <meta name="description" content="">
  <meta name="author" content="">
  <link rel="shortcut icon" href="" type="../img/icon.png">

  <title>Workflow Solinver</title>

  <?php 
  require_once($maindir."pages/head.php");
  ?>
  <style type="text/css">
  .btn-group{margin-left: -15px;}
  </style>

  <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
    <script src="js/respond.min.js"></script>
    <![endif]-->
  </head>

  <body>
    <!-- Preloader -->
    <div id="preloader">
      <div id="status"><i class="fa fa-spinner fa-spin"></i></div>
    </div>

    <section>

      <div class="leftpanel">
        <?php 
        require_once($maindir."pages/left_panel.php");
        ?>
      </div><!-- leftpanel -->

      <div class="mainpanel">

        <div class="headerbar">
          <?php 
          require_once($maindir."pages/header.php");
          ?>

        </div><!-- headerbar -->


        <div class="contentpanel">
          <div>
            <ol class="breadcrumb">
              <li class="active">
                <span class="fa fa-cog"></span></i> Módulo Ingreso de Recursos Humanos /Principal
              </li>
            </ol>
          </div>

          <div class="panel panel-default">

            <div class="panel-body">
              <div class="box-body table-responsive">
                <table class="table table-striped table-bordered" cellspacing="0" id="tbl_solicitudes">
                  <thead>
                   <tr>
                    <th>Solicitud</th>
                    <th>Estado</th>
                    <th>Fecha creación</th>
                    <th>Identidad</th>
                    <th>Nombre</th>
                    <th>Tipo Solicitud</th>
                    <th>Detalle</th>
                    <th>Enviar</th>
                  </tr>
                </thead>
                <tbody id = "tbody_solicitudes">

                </tbody>
              </table>
            </div><!-- table-responsive -->
          </div>
        </div>

      </div>
    </div><!-- contentpanel -->

  </div><!-- mainpanel -->
</section>
<?php  
require_once($maindir."pages/footer.php");
?>
<script type='text/javascript' src = '../js/rrhh.js'></script>

</body>
</html>




<!-- ===============MODAL confirm accion============= -->
<div class="modal fade" id="rrhh_modalEnviar" >
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
        <h4 class="modal-title" id="">Enviar solicitud a revisión de Analista de Créditos.</h4>
      </div>
      <div class="modal-body">

        <form id="" class="form" name="">
          <input type = "text" id = "data_envio_solicitud"  hidden>
          <br>
          <div class="row">
            <div class="form-group" id="verSalarioBruto" >
              <label class="control-label col-sm-5" style = "text-align: right;" for="rrhh_salarioBruto" >Salario Bruto:</label>
              <div class="input-group col-sm-5">
                <input id="rrhh_salarioBruto" type="number" step="0.01" min="0" maxlength="11" class="form-control numeros" name="rrhh_salarioBruto" value="" placeholder="">                                        
                <span class="input-group-addon">LPS</span>
              </div>
            </div>
          </div>
          <br>
          <div class="row">
            <div class="form-group" id="verSalaConDeduccion">
              <label class="control-label col-sm-5 " style = "text-align: right;" for="rrhh_salarioConDeduccion">Salario con Deducciones:</label>
              <div class="input-group col-sm-5">
                <input id="rrhh_salarioConDeduccion" type="number" step="0.01" min="0" maxlength="11" class="form-control numeros" name="rrhh_salarioConDeduccion" value="" placeholder="">                                        
                <span class="input-group-addon">LPS</span>
              </div>
            </div>
          </div>

          <br>
          <div class="row">
            <div class="form-group" id = "verDerechos">
              <label class="control-label col-sm-5" style = "text-align: right;" for="rrhh_derechos">Derechos Adquiridos a la Fecha:</label>
              <div class="input-group col-sm-5">
                <input id="rrhh_derechos" type="number" step="0.01" min="0" maxlength="11" class="form-control numeros" name="rrhh_derechos" value="" placeholder="">                                        
                <span class="input-group-addon">LPS</span>
              </div>
            </div>
          </div>

          <br>
          <div class="row">
            <div class="form-group" id = "verAntiguedad">
              <label class="control-label col-sm-5" style = "text-align: right;"for="rrhh_antiguedad">Antiguedad Laboral:</label>
              <div class="input-group col-sm-5">
                <input id="rrhh_antiguedad" type="number" min = "0" class="form-control numeros" name="rrhh_antiguedad" value="" placeholder="">
                <span class="input-group-addon">Años</span>
              </div>
            </div>
          </div>
          <br>
          <div class="row">
            <div class="form-group" id = "verComment" >
              <label class="control-label col-xs-2" style = "text-align: right;">Comentario:</label>
              <div class="col-xs-10">
                <textarea type="text" class="form-control" name="rrhh_comentario" id="rrhh_comentario" placeholder = "Ingrese un comentario..." required></textarea>
              </div>
            </div>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
        <button id = "rrhh_enviar_solicitud" type = "button" class = "btn btn-primary">Guardar y enviar</button>
      </div>

    </div><!-- modal-content -->
  </div>
</div>

<div class="wizard" id="wizard_crearSolicitud" data-title="">
  <div class="wizard-card" data-cardname="card1" style="height: 525px;">
    <h3 hidden>Información de la solicitud</h3>
    <input id="opcion" type="text" class="form-control" name="opcion" data-solicitud_id = 0 value=0 style = "visibility:hidden;">                                        
    <input id="solicitud_id" type="text" class="form-control" name="solicitud_id" style = "visibility:hidden;">                                        
    <br><br>
    <h5>
      <p><strong>Solicitud Colaborador:</strong> Será validada por el oficial de Recursos Humanos</p>
      <p><strong>Solicitud Cliente externo:</strong> Será validada por el oficial Analista de Créditos</p>
      <p><strong>Solicitud Empresarial:</strong> Será validada por el oficial Analista de Créditos</p>
    </h5>
    <hr>
    <div class = "row">
      <div class = "col-xs-8 col-xs-offset-2" >
        <div class="wizard-input-section">
          <div class="form-group">
            <label class= "control-label">Tipo de Solicitud</label>
            <select disabled id = "card1_tipoSolicitud" name="card1_tipoSolicitud" data-placeholder="Seleccione el tipo de solicitud" style = "width: 350px" class="form-control">
              <option selected value= "-1">----Seleccione una opcion valida----</option>
              <option value= "1">Solicitud para colaborador</option>
              <option value= "2">Solicitud para cliente externo</option>
              <option value= "3">Solicitud cliente empresarial</option>
            </select>
          </div>
        </div>

        <div class="wizard-input-section">
          <div class="form-group">
            <label class= "control-label">Tipo de Préstamo</label>
            <select disabled id = "card1_tipoPrestamo" name="card1_tipoPrestamo" data-placeholder="Seleccione el tipo de préstamo" style = "width: 350px" class="form-control">
              <option selected value= "-1">----Seleccione una opcion valida----</option>
              <option value= "1">Préstamo Fiduciario</option>
              <option value= "2">Préstamo Prendario</option>
              <option value= "3">Préstamo Hipotecario</option>
            </select>
          </div>
        </div>
      </div>
    </div>

  </div>

  <div class="wizard-card" data-cardname="card2" style="height: 525px;">
    <h3 hidden>Datos personales</h3>
    <div class="row">
      <div class="wizard-input-section">
        <div class="form-group">
          <label class="control-label col-sm-2" for="nombres" >Nombres:</label>
          <div class="col-sm-4">
            <input disabled id="card2_Pnombre" type="text" maxlength="30" class="form-control" name="card2_Pnombre" value="" placeholder="Ingrese el primer nombre">                                        
          </div><div class="col-sm-4">
          <input disabled id="card2_Snombre" type="text" maxlength="30" class="form-control" name="card2_Snombre" value="" placeholder="Ingrese el segundo nombre">                                        
        </div>
      </div>
    </div>
    <div class="wizard-input-section">
      <div class="form-group">
        <label class="control-label col-sm-2" for="email">Apellidos:</label>
        <div class="col-sm-4">
          <input disabled id="card2_Papellido" type="text" maxlength="30" class="form-control" name="card2_Papellido" value="" placeholder="Ingrese primer apellido">                                        
        </div><div class="col-sm-4">
        <input disabled id="card2_Sapellido" type="text" maxlength="30" class="form-control" name="card2_Sapellido" value="" placeholder="Ingrese el segundo apellido">                                        
      </div> 
    </div>
  </div>
</div>
<br>
<div class="row">
  <div class="col-xs-3">
    <div class="wizard-input-section">
      <div class="form-group">
        <label class="control-label">Número Identidad</label>
        <div class="input-group">
          <input disabled id="card2_identidad" maxlength="13" type="text" class="form-control numeros" name="card2_identidad" value="" placeholder="Número de identidad válido">                                        
        </div>
      </div>
    </div>
  </div>
  <div class="col-xs-3 col-xs-offset-1">
    <div class="wizard-input-section">
      <div class="form-group">
        <label class="control-label">RTN</label>
        <div class="input-group">
          <input disabled id="card2_RTN" type="text" class="form-control numeros" maxlength="14" name="card2_RTN" value="" placeholder="Ingresar RTN válido">                                        
        </div>
      </div>
    </div>
  </div>
  <div class="col-xs-3 col-xs-offset-1 ">
    <div class="wizard-input-section">
      <div class="form-group">
        <label class="control-label">Edad</label>
        <div class="input-group">
          <span class="input-group-addon"><i class="fa fa-male"></i></span>
          <input id="card2_edad"  min="0" class="form-control" name="card2_edad"  disabled>                                        
        </div>
      </div>
    </div>
  </div>
</div>
<br>
<div class="row">
  <div class="col-xs-2 ">
    <div class="form-group">
      <label for="card2_sexo" class="control-label">Sexo:</label>
      <div class="col-xs-12">
        <div class="input-group">
          <div id="radioBtn" class="btn-group">
            <a disabled class="btn btn-default btn-sm notActive" data-toggle="card2_sexo" data-title='M'>M</a>
            <a disabled class="btn btn-default btn-sm notActive" data-toggle="card2_sexo" data-title='F'>F</a>
          </div>
          <input  style = "visibility:hidden;" name="card2_sexo" id="card2_sexo">
        </div>
      </div>
    </div>            
  </div>
  <div class="col-xs-5 col-xs-offset-0">
    <div class="form-group">
      <label for="card2_tipoVivienda" class="control-label">Tipo vivienda</label>
      <select disabled id = "card2_tipoVivienda" name="card2_tipoVivienda" data-placeholder="Seleccione el tipo de préstamo" style = "width: 200px" class="form-control">
        <option selected value= "-1">----Seleccione una opcion valida----</option>
        <option value= "1">Alquilada</option>
        <option value= "2">Propia</option>
        <option value= "3">Familiar</option>
        <option value= "4">Pagándola</option>
        <option value= "5">Otros</option>
      </select>
      <div class="input-group" style="width:200px">
        <input disabled type = "number" min = "0" value=0 step = "0.01" name="card2_pagoVivienda" class = "numeros form-control" id="card2_pagoVivienda" placeholder = "Pago Mensual">
        <span class="input-group-addon">LPS</span>
      </div>

    </div>
  </div>
        <!-- <div class="col-xs-3 col-xs-offset-1">
            
  </div> -->
  <div class="col-xs-5 col-xs-offset-0">
    <label class="control-label">
      Fecha Nacimiento
    </label>
    <div class="row">
      <div class="col-xs-3">
        <div class="form-group">

          <label class="control-label">Dia</label>
          <select disabled class = "form-control card2Edad" id = "card2_naciDia" name="card2_naciDia">
            <?php
            for ($i=1; $i<=31; $i++) {
              if (i < 10) {
                if ($i == date('j')){
                  echo '<option value="0'.$i.'" selected>'.$i.'</option>';
                }
                else{
                  echo '<option value="0'.$i.'">'.$i.'</option>';
                }
              }
              else{
                if ($i == date('j')){
                  echo '<option value="'.$i.'" selected>'.$i.'</option>';
                }
                else{
                  echo '<option value="'.$i.'">'.$i.'</option>';
                }
              }
            }
            ?>
          </select>
        </div>
      </div>
      <div class="col-xs-3">
        <div class="form-group">
          <label class="control-label">Mes</label>
          <select disabled class = "form-control card2Edad" id = "card2_naciMes" name="card2_naciMes">
            <?php
            for ($i=1; $i<=12; $i++) {
              if (i <10) {
                if ($i == date('m')){
                  echo '<option value="0'.$i.'" selected>'.$i.'</option>';
                }
                else{
                  echo '<option value="0'.$i.'">'.$i.'</option>';
                }
              }
              else{
                if ($i == date('m')){
                  echo '<option value="'.$i.'" selected>'.$i.'</option>';
                }
                else{
                  echo '<option value="'.$i.'">'.$i.'</option>';
                }
              }
            }
            ?>
          </select>
        </div>
      </div>
      <div class="col-xs-4">
        <div class="form-group">
          <label class="control-label">año</label>
          <select disabled name="card2_naciAnio" id = "card2_naciAnio" class = "form-control card2Edad" >
            <?php
            for($i=date('o'); $i>=1910; $i--){
              if ($i == date('o'))
                echo '<option value="'.$i.'" selected>'.$i.'</option>';
              else
                echo '<option value="'.$i.'">'.$i.'</option>';
            }
            ?>
          </select>
        </div>
      </div>
    </div>
  </div>
</div>
<hr>
<div class="row">
  <div class="col-xs-5">
    <div class="form-group">
      <label class="control-label">Lugar Nacimiento</label>
      <div class="input-group">
        <input disabled id="card2_lugarNaci" maxlength="50" type="text" class="form-control" name="card2_lugarNaci" value="" placeholder="">                                        
      </div>
    </div>
  </div>
  <div class="col-xs-5">
    <div class="form-group">
      <label class="control-label">Dirección</label>
      <div class="input-group">
        <span class="input-group-addon"><i class="glyphicon glyphicon-map-marker"></i></span>
        <input disabled id="card2_direccion"  maxlength="200"  type="text" class="form-control" name="card2_direccion" value="" placeholder="">                                        
      </div>
    </div>
  </div>

    </div>

    <div class="row">
      <div class="col-xs-5">
        <div class="form-group">
          <label class="control-label">Nacionalidad</label>
          <div class="input-group">
            <input disabled id="card2_nacionalidad" maxlength="50" type="text" class="form-control" name="card2_nacionalidad" value="" placeholder="">                                        
          </div>
        </div>
      </div>

      <div class="col-xs-5">
        <div class="form-group">
          <label class="control-label">Ciudad de Residencia</label>
          <div class="input-group">
            <input disabled id="card2_residencia" maxlength="50" type="text" class="form-control" name="card2_residencia" value="" placeholder="">                                        
          </div>
        </div>
      </div>

    </div>

    <div class="row">

      <div class="col-xs-5 col-xs-offset-0">
        <div class="form-group">
          <label class="control-label">Profesión, ocupación u oficio</label>
          <div class="input-group">
            <input disabled id="card2_ocupacion" type="text" maxlength="50" class="form-control" name="card2_ocupacion" value="" placeholder="">                                        
          </div>
        </div>
      </div>
      <div class="col-xs-6 col-xs-offset-0">
        <div class="form-group">
          <label class="control-label">Email</label>
          <div class="input-group">
            <span class="input-group-addon"><i class="glyphicon glyphicon-envelope"></i></span>
            <input disabled id="card2_email" type="email" maxlength="70" class="form-control" name="card2_email" value="" placeholder="Ingrese correo electrónico">                                        
          </div>
          <div id="xmail" class="hide"><h6 class="text-danger">Ingresa un email valido</h6></div>
        </div>
      </div>
    </div>
    <div class = "row">
      <div class="col-xs-4 col-xs-offset-0">
        <div class="form-group">
          <label class="control-label">Telefono Casa</label>
          <div class="input-group">
            <span class="input-group-addon"><i class="fa fa-phone"></i></span>
            <input disabled id="card2_tel" maxlength="20" type="text" class="form-control numeros" name="card2_tel" value="" placeholder="Ingrese el teléfono">                                        
          </div>
        </div>
      </div>
      <div class="col-xs-4 col-xs-offset-1">
        <div class="form-group">
          <label class="control-label">Celular</label>
          <div class="input-group">
            <span class="input-group-addon"><i class="fa fa-phone"></i></span>
            <input disabled id="card2_cel" maxlength="20" type="text" class="form-control numeros" name="card2_cel" value="" placeholder="Número de celular">                                        
          </div>
        </div>
      </div>
    </div>
    <hr>
    <div class = "row">
      <div class="col-xs-4 col-xs-offset-0">
        <div class="form-group">
          <label for="card2_estadoCivil" class="control-label">Estado Civil</label>
          <div class="col-xs-12">
            <div class="input-group">
              <div id="radioBtn" class="btn-group">
                <a disabled class="btn btn-default btn-sm notActive" data-toggle="card2_estadoCivil" data-title="1">Soltero</a>
                <a disabled class="btn btn-default btn-sm notActive" data-toggle="card2_estadoCivil" data-title="2">Casado</a>
                <a disabled class="btn btn-default btn-sm notActive" data-toggle="card2_estadoCivil" data-title="3">otros</a>
              </div>
              <input style = "visibility:hidden;" name="card2_estadoCivil" id="card2_estadoCivil" value = "">
            </div>
          </div>
        </div>
      </div>
      <div class="col-xs-3 col-xs-offset-0">
        <div class="form-group">
          <label class="control-label">Dependientes</label>
          <div class="input-group">
            <input disabled id="card2_dependientes" maxlength="8" type="number" min="0" class="form-control numeros" name="card2_dependientes" value="" placeholder="# dependientes">                                        
          </div>
        </div>
      </div>
      <div class="col-xs-3 col-xs-offset-1">
        <div class="form-group">
          <label class="control-label">Hijos</label>
          <div class="input-group">
            <input disabled id="card2_hijos" type="number" maxlength="8" min="0" class="form-control numeros" name="card2_hijos" value="" placeholder="Cantidad de hijos">                                        
          </div>
        </div>
      </div>
    </div>

  </div>

  <!-- ============================================ -->
  <div class="wizard-card" data-cardname="card3" style="height: 525px;">
    <h3 hidden>Datos del Préstamo</h3>
    <br><br>
    <div class = "row">
      <div class="col-xs-6 col-xs-offset-1">
        <div class="form-group">
          <label class="control-label">Cantidad Solicitada</label>
          <div class="input-group">
            <span class="input-group-addon">LPS</span>
            <input disabled id="card3_cant" maxlength="11" type="number" step = "0.01"  min="0" class="form-control numeros" name="card3_cant" value="" placeholder="">                                        
          </div>
        </div>
      </div>
    </div>
    <br>  
    <div class = "row">
      <div class="col-xs-6 col-xs-offset-1">
        <div class="form-group">
          <label class="control-label">Plazo</label>
          <div class="input-group">
            <span class="input-group-addon">Meses</span>
            <input disabled id="card3_plazo" maxlength="11" type="number" min="0" class="form-control numeros" name="card3_plazo" value="" placeholder="">                                        
          </div>
        </div>
      </div>
    </div> 
    <br>
    <div class = "row">
      <div class="col-xs-6 col-xs-offset-1">
        <div class="form-group">
          <label class="control-label">Destino del préstamo</label>
          <div class="input-group">
            <!-- <input id="card3_destino" type="text"  class="form-control" name="card3_destino"  placeholder="">                                         -->
            <select disabled id = "card3_destino" name="card3_destino" data-placeholder="Seleccione el tipo de préstamo" style = "width: 350px" class="form-control">
              <option selected value= "-1">----Seleccione una opcion valida----</option>
              <option value= "1">Adquisición de vivienda y/o terreno</option>
              <option value= "2">Adquisición de vehículo</option>
              <option value= "3">Consolidación de Deudas</option>
              <option value= "4">Reparaciones, mejoras y/o ampliaciones de vivienda</option>
              <option value= "5">Educación</option>
              <option value= "6">Gastos de traslado de casa</option>
              <option value= "7">Viajes/Entretenimiento</option>
              <option value= "8">Adquisición de Artículos para el hogar</option>
              <option value= "9">Salud/Tratamientos Médicos</option>
              <option value= "10">Otros</option>
            </select>
          </div>
        </div>
      </div>
    </div>    
  </div>

  <!-- ============================================ -->

  <div class="wizard-card" data-cardname="card4" style="height: 525px;">
    <h3 hidden>Datos Laborales</h3>
    <br>
    <div class="row">
      <div class="col-xs-4">
        <div class="form-group">
          <label class="control-label">Empresa donde labora:</label>
          <div class="input-group">
            <input disabled id="card4_empresa" maxlength="100" type="text" class="form-control" name="card4_empresa" value="" placeholder="">                                        
          </div>
        </div>
      </div>
      <div class="col-xs-3 col-xs-offset-1">
        <div class="form-group">
          <label class="control-label">Sueldo Mensual</label>
          <div class="input-group">
            <span class="input-group-addon">LPS</span>
            <input disabled id="card4_sueldo" type=number step=0.01 min = "0" class="form-control" name="card4_sueldo" >                                        
          </div>
        </div>
      </div>

      <div class="col-xs-3 col-xs-offset-1">
        <div class="form-group">
          <label class="control-label">Tiempo de Servicio</label>
          <div class="input-group">
            <span class="input-group-addon">años</span>
            <input disabled id="card4_tiempo" maxlength="11"  type="number" min = "0" class="form-control" name="card4_tiempo" value="" placeholder="">                                        
          </div>
        </div>
      </div>

    </div>
    <br>
    <div class="row">
      <div class="col-xs-5">
        <div class="form-group">
          <label class="control-label">Posición / Cargo </label>
          <div class="input-group">
            <input disabled id="card4_cargo" type="text" maxlength="100" class="form-control" name="card4_cargo" value="" placeholder="">                                        
          </div>
        </div>
      </div>

      <div class="col-xs-5">
        <div class="form-group">
          <label class="control-label">Otros Ingresos</label>
          <div class="input-group col-md-8">
            <input disabled id="card4_otroIngreso" type="number" min = "0" step="0.01" class="form-control" name="card4_otroIngreso" value="" placeholder="">                                        
            <span  class="input-group-addon">LPS</span>
          </div>
        </div>
      </div>
    </div>
    <br>
    <div class="row">
      <div class="col-xs-6">
        <div class="form-group">
          <label class="control-label">Dirección</label>
          <div class="input-group">
            <input disabled id="card4_direccion" maxlength="200" type="text" class="form-control" name="card4_direccion" value="" placeholder="">                                        
          </div>
        </div>
      </div>

      <div class="col-xs-5">
        <div class="form-group">
          <label class="control-label">Teléfono de Trabajo</label>
          <div class="input-group">
            <input disabled id="card4_telefono" type="text" maxlength="20" class="form-control numeros" name="card4_telefono" value="" placeholder=" ">                                        
            <span class="input-group-addon">Extensión:</i></span>
            <input disabled id="card4_telefonoExt" type="text" maxlength="5" class="form-control numeros" name="card4_telefonoExt" value="" placeholder=" ">                                        
          </div>
        </div>
      </div>
    </div>
    <br>
    <div class = "row">
      <div class="col-xs-5">
        <div class="form-group">
          <label class="control-label">Jefe directo</label>
          <div class="input-group">
            <input disabled id="card4_jefe" type="text" maxlength="100" class="form-control" name="card4_jefe" value="" placeholder="">                                        
          </div>
        </div>
      </div>

      <div class="col-xs-5">
        <div class="form-group">
          <label class= "control-label">Actividad de la empresa</label>
          <select disabled id = "card4_selectActividad" name="card4_selectActividad" data-placeholder="Seleccione el tipo de solicitud" style = "width: 350px" class="form-control">
            <option selected value= "-1">----Seleccione una opcion valida----</option>
            <option value= "1">Servicios financieros</option>
            <option value= "2">Educación</option>
            <option value= "3">Transporte</option>
            <option value= "4">Industria</option>
            <option value= "5">Gobierno</option>
            <option value= "6">Agricultura</option>
            <option value= "7">Sector Privado</option>
          </select>
        </div>
      </div>
    </div>

  </div>


  <!-- ============================================ -->
  <div class="wizard-card" data-cardname="card5" style="height: 525px;">
    <h3 hidden>Datos del cónyugue</h3>
    <div class="row">
      <div class="wizard-input-section">
        <div class="form-group">
          <label class="control-label col-sm-2" for="nombres" >Nombres:</label>
          <div class="col-sm-4">
            <input disabled id="card5_Pnombre" type="text" maxlength="30" class="form-control" name="card5_Pnombre" value="" placeholder="Ingrese el primer nombre">                                        
          </div>
          <div class="col-sm-4">
           <input disabled id="card5_Snombre" type="text" maxlength="30" class="form-control" name="card5_Snombre" value="" placeholder="Ingrese el segundo nombre">                                        
        </div>
      </div>
    </div>
    <div class="wizard-input-section">
      <div class="form-group">
        <label class="control-label col-sm-2" for="email">Apellidos:</label>
        <div class="col-sm-4">
          <input disabled id="card5_Papellido" type="text" maxlength="30" class="form-control" name="card5_Papellido" value="" placeholder="Ingrese el primer apellido">                                        
        </div><div class="col-sm-4">
        <input disabled id="card5_Sapellido" type="text" maxlength="30" class="form-control" name="card5_Sapellido" value="" placeholder="Ingrese el segundo apellido">                                        
      </div> 
    </div>
  </div>
</div>
<br>

<div class = "row">
  <div class="col-xs-5">
    <div class="form-group">
      <label class="control-label">Número Identidad</label>
      <div class="input-group">
        <input disabled id="card5_identidad" maxlength="13" type="text" class="form-control numeros" name="card5_identidad" value="" placeholder="Número de identidad válido">                                        
      </div>
    </div>
  </div>
  <div class="col-xs-5 col-xs-offset-1">
    <label class="control-label">
      Fecha Nacimiento
    </label>
    <div class="row">
      <div class="col-xs-3">
        <div class="form-group">

          <label class="control-label">Dia</label>
          <select disabled class = "form-control" id = "card5_naciDia" name="card5_naciDia">
            <?php
            for ($i=1; $i<=31; $i++) {
              if (i < 10) {
                if ($i == date('j')){
                  echo '<option value="0'.$i.'" selected>'.$i.'</option>';
                }
                else{
                  echo '<option value="0'.$i.'">'.$i.'</option>';
                }
              }
              else{
                if ($i == date('j')){
                  echo '<option value="'.$i.'" selected>'.$i.'</option>';
                }
                else{
                  echo '<option value="'.$i.'">'.$i.'</option>';
                }
              }
            }
            ?>
          </select>
        </div>
      </div>
      <div class="col-xs-3">
        <div class="form-group">
          <label class="control-label">Mes</label>
          <select disabled class = "form-control" id = "card5_naciMes" name="card5_naciMes">
            <?php
            for ($i=1; $i<=12; $i++) {

              if (i < 10) {
                if ($i == date('m'))
                  echo '<option value="0'.$i.'" >'.$i.'</option>';
                else
                  echo '<option value="0'.$i.'">'.$i.'</option>';
              }
              else{
                if ($i == date('m'))
                  echo '<option value="'.$i.'" >'.$i.'</option>';
                else
                  echo '<option value="'.$i.'">'.$i.'</option>';
              }
            }
            ?>
          </select>
        </div>
      </div>
      <div class="col-xs-4">
        <div class="form-group">
          <label class="control-label">año</label>
          <select disabled name="card5_naciAnio"  id = "card5_naciAnio" class = "form-control" >
            <?php
            for($i=date('o'); $i>=1910; $i--){
              if ($i == date('o'))
                echo '<option value="'.$i.'" selected>'.$i.'</option>';
              else
                echo '<option value="'.$i.'">'.$i.'</option>';
            }
            ?>
          </select>
        </div>
      </div>
    </div>
  </div>
</div>
<br>
<div class = "row">
  <div class="col-xs-3 col-xs-offset-0">
    <div class="form-group">
      <label class="control-label">Telefono de casa</label>
      <div class="input-group">
        <span class="input-group-addon"><i class="fa fa-phone"></i></span>
        <input disabled id="card5_tel" maxlength="20" type="text" class="form-control numeros" name="card5_tel" value="" placeholder="">                                        
      </div>
    </div>
  </div>
  <div class="col-xs-3 col-xs-offset-1">
    <div class="form-group">
      <label class="control-label">Celular</label>
      <div class="input-group">
        <span class="input-group-addon"><i class="fa fa-phone"></i></span>
        <input disabled id="card5_cel" maxlength="20" type="text" class="form-control numeros" name="card5_cel" value="" placeholder="">                                        
      </div>
    </div>
  </div>
  <div class="col-xs-4 col-xs-offset-1">
    <div class="form-group">
      <label for="card5_tipoVivienda" class="control-label">Tipo vivienda</label>
      <select disabled id = "card5_tipoVivienda" name="card5_tipoVivienda" data-placeholder="Seleccione el tipo de préstamo" style = "width: 200px" class="form-control">
        <option selected value= "-1">----Seleccione una opcion valida----</option>
        <option value= "1">Alquilada</option>
        <option value= "2">Propia</option>
        <option value= "3">Familiar</option>
        <option value= "4">Pagándola</option>
        <option value= "5">Otros</option>
      </select>
      <div class="input-group col-md-11">
        <input disabled type = "number" min = "0" value=0 step = "0.01" name="card5_pagoVivienda" class = "numeros form-control" id="card5_pagoVivienda" placeholder = "Pago Mensual">
        <span class="input-group-addon">LPS</span>
      </div>
    </div>
  </div>
</div>
<br>
<div class="row">
  <div class="col-xs-5">
    <div class="form-group">
      <label class="control-label">Profesión, Ocupación u Oficio</label>
      <div class="input-group">
        <input disabled id="card5_profesion" maxlength="50" type="text" class="form-control" name="card5_profesion" value="" placeholder="">                                        
      </div>
    </div>
  </div>

  <div class="col-xs-5">
    <div class="form-group">
      <label class="control-label">Sueldo Mensual</label>
      <div class="input-group">
        <span class="input-group-addon">LPS</span>
        <input disabled id="card5_ingresoMensual" maxlength="11" type="number" step = "0.01" class="form-control" name="card5_ingresoMensual" placeholder="">                                        
      </div>
    </div>
  </div>
</div>

<div class="row">
  <div class="col-xs-5">
    <div class="form-group">
      <label class="control-label">Nombre de la empresa para que labora: </label>
      <div class="input-group">
        <input disabled id="card5_lugarLabor" type="text" maxlength="100" class="form-control" name="card5_lugarLabor" value="" placeholder="">                                        
      </div>
    </div>
  </div>

  <div class="col-xs-5">
    <div class="form-group">
      <label class="control-label">Posición o Cargo</label>
      <div class="input-group">
        <input disabled id="card5_cargo" maxlength="100" type="text" class="form-control" name="card5_cargo" value="" placeholder="">                                        
      </div>
    </div>
  </div>
</div>
<br>


</div>

<!-- ============================================ -->
<div class="wizard-card" data-cardname="card6" style="height: 525px;">
  <h3 hidden>Datos del Fiador</h3>
  <div class="row">
    <div class="form-group">
      <label style = "margin-left: -20px;"class="control-label col-sm-2" for="nombres" >Nombres:</label>
      <div class="col-sm-5">
        <input disabled id="card6_Pnombre" type="text" maxlength="30" class="form-control" name="card6_Pnombre" value="" placeholder="Ingrese el primer nombre">                                        
      </div>
      <div class="col-sm-5">
      <input disabled id="card6_Snombre" type="text" maxlength="30" class="form-control" name="card6_Snombre" value="" placeholder="Ingrese el segundo nombre">                                        
    </div>
  </div>
  <div class="form-group">
    <label style = "margin-left: -20px;" class="control-label col-sm-2" for="email">Apellidos:</label>
    <div class="col-sm-5">
      <input disabled id="card6_Papellido" type="text" maxlength="30" class="form-control" name="card6_Papellido" value="" placeholder="Ingrese el primer apellido">                                        
    </div>
    <div class="col-sm-5">
      <input disabled id="card6_Sapellido" type="text" maxlength="30" class="form-control" name="card6_Sapellido" value="" placeholder="Ingrese el segundo apellido">                                        
    </div> 
  </div>
</div>
<div class="row">
  <div class="col-xs-3">
    <div class="form-group">
      <label class="control-label">Número Identidad</label>
      <div class="input-group">
        <input disabled id="card6_identidad" maxlength="13" type="text" class="form-control numeros" name="card6_identidad" value="" placeholder="Número de identidad válido">                                        
      </div>
    </div>
  </div>
</div>

<div class="row">
  <div class="col-xs-6">
    <div class="form-group">
      <label class="control-label">Dirección</label>
      <div class="input-group">
        <input disabled id="card6_direccion" maxlength="200" type="text" class="form-control" name="card6_direccion" value="" placeholder="">                                        
      </div>
    </div>
  </div>
  <div class="col-xs-5">
    <div class="form-group">
      <label class="control-label">Ciudad residencia</label>
      <div class="input-group">
        <span class="input-group-addon"><i class="glyphicon glyphicon-globe"></i></span>
        <input disabled id="card6_residencia" maxlength="50" type="text" class="form-control" name="card6_residencia" value="" placeholder="">                                        
      </div>
    </div>
  </div>
</div>

<div class = "row">
  <div class="col-xs-3 col-xs-offset-0">
    <div class="form-group">
      <label class="control-label">Telefono de casa</label>
      <div class="input-group">
        <span class="input-group-addon"><i class="fa fa-phone"></i></span>
        <input disabled id="card6_tel" type="text" maxlength="20" class="form-control numeros" name="card6_tel" value="" placeholder="">                                        
      </div>
    </div>
  </div>
  <div class="col-xs-3 col-xs-offset-1">
    <div class="form-group">
      <label class="control-label">Celular</label>
      <div class="input-group">
        <span class="input-group-addon"><i class="fa fa-phone"></i></span>
        <input disabled id="card6_cel" type="text" maxlength="20" class="form-control numeros" name="card6_cel" value="" placeholder="">                                        
      </div>
    </div>
  </div>
  <div class="col-xs-3 col-xs-offset-1">
    <div class="form-group">
      <label class="control-label">email</label>
      <div class="input-group">

        <input disabled id="card6_email" maxlength="100"  type="email" class="form-control" name="card6_email" value="" placeholder="">                                        
      </div>
    </div>
    <div id="xmail2" class="hide"><h6 class="text-danger">Ingresa un email valido</h6></div>
  </div>
</div>
<div class = "row">
  <div class="col-xs-4 col-xs-offset-0">
    <div class="form-group">
      <label for="card6_estadoCivil" class="control-label">Estado Civil</label>
      <div class="col-xs-12">
        <div class="input-group">
          <div id="radioBtn" class="btn-group">
            <a disabled class="btn btn-default btn-sm notActive" data-toggle="card6_estadoCivil" data-title="1">Soltero</a>
            <a disabled class="btn btn-default btn-sm notActive" data-toggle="card6_estadoCivil" data-title="2">Casado</a>
            <a disabled class="btn btn-default btn-sm notActive" data-toggle="card6_estadoCivil" data-title="3">otros</a>
          </div>
          <input style = "visibility:hidden;" name="card6_estadoCivil" id="card6_estadoCivil" value = "">
        </div>
      </div>
    </div>
  </div>
  <div class="col-xs-3 col-xs-offset-0">
    <div class="form-group">
      <label class="control-label">Dependientes</label>
      <div class="input-group">
        <input disabled id="card6_dependientes"  maxlength="11" type="number" min="0" class="form-control numeros" name="card6_dependientes" value="" placeholder="">                                        
      </div>
    </div>
  </div>
</div>
<hr>
<div class="row">
  <div class="col-xs-5">
    <div class="form-group">
      <label class="control-label">Empresa donde labora</label>
      <div class="input-group">
        <input disabled id="card6_empresa" maxlength="100" type="text" class="form-control" name="card6_empresa" value="" placeholder="">                                        
      </div>
    </div>
  </div>
  <div class="col-xs-5">
    <div class="form-group">
      <label class="control-label">Posición, ocupación u oficio</label>
      <div class="input-group">
        <span class="input-group-addon"><i class="glyphicon glyphicon-pushpin"></i></span>
        <input disabled id="card6_posicion" type="text" maxlength="100" class="form-control" name="card6_posicion" value="" placeholder="">                                        
      </div>
    </div>
  </div>

  </div>
  <div class="row">
    <div class="col-xs-3">
      <div class="form-group">
        <label class="control-label">Tiempo de servicio</label>
        <div class="input-group">
          <span class="input-group-addon">años</span>
          <input disabled id="card6_tiempoServicio" maxlength="11" type="number" min = "0" class="form-control numeros" name="card6_tiempoServicio" value="" placeholder="">                                        
        </div>
      </div>
    </div>
    <div class="col-xs-4 col-xs-offset-2">
      <div class="form-group">
        <label class="control-label">Sueldo Mensual</label>
        <div class="input-group">
          <span class="input-group-addon">LPS</span>
          <input disabled id="card6_sueldoMensual" maxlength="14" type="number" step = "0.01" min = "0" class="form-control" name="card6_sueldoMensual" >                                        
        </div>
      </div>
    </div>
  </div>

  <div class="row">
    <div class="col-xs-3">
      <div class="form-group">
        <label class="control-label">Otros ingresos</label>
        <div class="input-group">
          <span class="input-group-addon">LPS</span>
          <input disabled id="card6_otrosIngresos" maxlength="14"  type="number" step = "0.01" min = "0" class="form-control" name="card6_otrosIngresos" value="" placeholder="">                                        
        </div>
      </div>
    </div>
    <div class="col-xs-6 col-xs-offset-2">
      <div class="form-group">
        <label class="control-label">Teléfono Trabajo</label>
        <div class="input-group">
          <input disabled id="card6_empresaTel" maxlength="20" type="text"  min = "0" class="form-control numeros" name="card6_empresaTel" value="" placeholder="">                                        <span class="input-group-addon"><i class="fa fa-phone"></i></span>
          <span class="input-group-addon">Ext:</span>
          <input disabled id="card6_empresaExt" maxlength="5" type="text"  min = "0" class="form-control numeros" name="card6_empresaExt" value="" placeholder="">                                        
        </div>
      </div>
    </div>
  </div>

  <div class = "row">
    <div class="col-xs-5">
      <div class="form-group">
        <label class="control-label">Jefe Inmediato</label>
        <div class="input-group">
          <input disabled id="card6_jefe" type="text" maxlength="100" class="form-control" name="card6_jefe"  placeholder="">                                        
        </div>
      </div>
    </div>

    <div class="col-xs-5">
      <div class="form-group">
        <label class= "control-label">Actividad de la empresa</label>
        <select disabled id = "card6_selectActividad" name="card6_selectActividad" data-placeholder="" style = "width: 350px" class="form-control">
          <option selected value= "-1">----Seleccione una opcion valida----</option>
          <option value= "1">Servicios financieros</option>
          <option value= "2">Educación</option>
          <option value= "3">Transporte</option>
          <option value= "4">Industria</option>
          <option value= "5">Gobierno</option>
          <option value= "6">Agricultura</option>
          <option value= "7">Sector Privado</option>
        </select>
      </div>
    </div>
  </div>

</div>


<!-- ============================================ -->
<div class="wizard-card" data-cardname="card7" style="height: 525px;">
  <h3 hidden>Referencias Familiares</h3>
  <div class="panel panel-default">
    <div class = "panel-heading">Referencia 1</div>
    <div class="panel-body" style=" ">
      <div class="row">
        <div class="form-group">
          <label style = ""class="control-label col-sm-4" for="nombres" >Nombre Completo:</label>
          <div class="col-sm-7">
            <input disabled id="card7_nombre" maxlength="200" type="text" class="form-control" name="card7_nombre" value="" placeholder="">                                        
          </div>
        </div>
        <div class="form-group">
          <label style = "" class="control-label col-sm-4" for="email">Teléfono residencia:</label>
          <div class="col-sm-7">
            <input disabled id="card7_tel"  maxlength="20" type="text" class="form-control numeros" name="card7_tel" value="" placeholder="">                                        
          </div>
        </div>
        <div class="form-group">
          <label style = "" class="control-label col-sm-4" for="email">Telefono Trabajo:</label>
          <div class="col-sm-7">
            <input disabled id="card7_trabajo" maxlength="100" type="text" class="form-control numeros" name="card7_trabajo" value="" placeholder="">                                        
          </div>
        </div>
        <div class="form-group">
          <label style = "" class="control-label col-sm-4" for="email">Parentesco:</label>
          <div class="col-sm-7">
            <input disabled id="card7_parentesco" maxlength="50" type="text" class="form-control" name="card7_parentesco" value="" placeholder="">                                        
          </div>
        </div>
      </div>
    </div>
  </div>

  <div class="panel panel-default">
    <div class = "panel-heading">Referencia 2</div>
    <div class="panel-body" style=" ">
      <div class="row">
        <div class="form-group">
          <label style = ""class="control-label col-sm-4" for="nombres" >Nombre Completo:</label>
          <div class="col-sm-7">
            <input disabled id="card7_nombre2" maxlength="200" type="text" class="form-control" name="card7_nombre2" value="" placeholder="">                                        
          </div>
        </div>
        <div class="form-group">
          <label style = "" class="control-label col-sm-4" for="email">Teléfono residencia:</label>
          <div class="col-sm-7">
            <input disabled id="card7_tel2" type="text" maxlength="20" class="form-control numeros" name="card7_tel2" value="" placeholder="">                                        
          </div>
        </div>
        <div class="form-group">
          <label style = "" class="control-label col-sm-4" for="email">Telefono Trabajo:</label>
          <div class="col-sm-7">
            <input  disabled id="card7_trabajo2" maxlength="100" type="text" class="form-control numeros" name="card7_trabajo2" value="" placeholder="">                                        
          </div>
        </div>
        <div class="form-group">
          <label style = "" class="control-label col-sm-4" for="email">Parentesco:</label>
          <div class="col-sm-7">
            <input disabled id="card7_parentesco2" maxlength="50" type="text" class="form-control" name="card7_parentesco2" value="" placeholder="">                                        
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- ============================================ -->
<div class="wizard-card" data-cardname="card8" style="height: 525px;">
  <h3 hidden>Referencias Personales</h3>
  <div class="panel panel-default">
    <div class = "panel-heading">Referencia 1</div>
    <div class="panel-body" style=" ">
      <div class="row">
        <div class="form-group">
          <label style = ""class="control-label col-sm-4" for="nombres" >Nombre Completo:</label>
          <div class="col-sm-7">
            <input disabled id="card8_nombre" maxlength="200" type="text" class="form-control" name="card8_nombre" value="" placeholder="">                                        
          </div>
        </div>
        <div class="form-group">
          <label style = "" class="control-label col-sm-4" for="email">Teléfono residencia:</label>
          <div class="col-sm-7">
            <input disabled id="card8_tel"  maxlength="20" type="text" class="form-control numeros" name="card8_tel" value="" placeholder="">                                        
          </div>
        </div>
        <div class="form-group">
          <label style = "" class="control-label col-sm-4" for="email">Telefono Trabajo:</label>
          <div class="col-sm-7">
            <input disabled id="card8_trabajo" maxlength="100" type="text" class="form-control numeros" name="card8_trabajo" value="" placeholder="">                                        
          </div>
        </div>
        <div class="form-group">
          <label style = "" class="control-label col-sm-4" for="email">Relación con el solicitante:</label>
          <div class="col-sm-7">
            <input disabled id="card8_parentesco" maxlength="50" type="text" class="form-control" name="card8_parentesco" value="" placeholder="">                                        
          </div>
        </div>
      </div>
    </div>
  </div>

</div>


<!-- ============================================ -->
<div class="wizard-card" data-cardname="card9" style="height: 525px;">
  <h3 hidden>Comentarios</h3>
  <table id = "" class = "table table-striped">
    <thead>
      <th>Módulo</th>
      <th>Fecha</th>
      <th>Usuario</th>
      <th>Comentario</th>
    </thead>
    <tbody id = "tbody_comentarios">
    </tbody>
  </table>
</div>
<!-- tarjetas especiales -->


<div class="wizard-success">
  <div class="alert alert-success">
    <!-- <span class="crearOtraSolicitud"></span>Solicitud guardada <strong>Correctamente.</strong> -->
  </div>
  <a class="btn btn-success im-done">Salir</a>
</div>

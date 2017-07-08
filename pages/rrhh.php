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

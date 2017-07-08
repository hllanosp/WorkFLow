
  <?php
      require_once("../login/seguridad.php");
      sec_session_start();
      //verificamos si hay una sesión iniciada
      if(!(isset($_SESSION['login']) && $_SESSION['login'] == '1')) {
            header("location: ../login/login.php?error_code=2");
      }
      else{
         $maindir = "../";
         $content = "mantenimiento";
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
  <link rel="shortcut icon" href="images/favicon.png" type="image/png">

  <title>Workflow Solinver</title>

  <?php 
    require_once("../pages/head.php");
  ?>

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
      require_once("../pages/left_panel.php");
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
                <span class="fa fa-cog"></span></i> Mantenimiento del sistema
            </li>

        </ol>
      </div>

      <div class="panel panel-default">
        <div class="panel-body">
          <br />
          <div class = "col-md-3 col-md-offset-0">
            <div class="panel panel-default">
              <a>
                <div class="panel-heading">
                    <div class="row">
                        <div class="col-xs-3">
                            <i style = "color: #1caf9a;"class="fa fa-user fa-5x"></i>
                        </div>
                        <div class="col-xs-9 text-right">
                            <div>Agregar</div>
                        </div>
                    </div>
                </div>
              </a>
              <a>
                <div role="button" class="panel-footer" data-toggle="modal" id = "btn_nuevoUsuario" style="background-color: #1caf9a; color:white;">
                    <span class="pull-left">Nuevo Usuario</span>
                    <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                    <div class="clearfix"></div>
                </div>
              </a>
            </div>

            <div class = "panel panel-default" style="margin-top: 15px;">
              <div class="panel-heading">
                  <label><span class="fa fa-bar-chart-o fa-fw" aria-hidden="true"></span>Usuarios Activos</label>
              </div>
                <div id="grafic_usuariosActivos" style="width: 100%; height: 200px; margin: 0 auto">

                </div>
            </div>
          </div>
          <div class = "col-md-9">
              <div class="box-body table-responsive">
                <table class="table table-striped table-bordered" cellspacing="0" id="tbl_usuarios">
                  <thead>
                     <tr>
                        <th>Usuario</th>
                        <th>Rol</th>
                        <th>Fecha creación</th>
                        <th>Estado</th>
                        <th>Editar</th>
                     </tr>
                  </thead>
                  <tbody id = "tbody_usuarios">
                    
                  </tbody>
               </table>
              </div><!-- table-responsive -->
          </div>
          
        </div><!-- panel-body -->
      </div><!-- panel -->

                           
    <?php  
      require_once($maindir."pages/footer.php");
      echo "<script type='text/javascript' src='".$maindir."components/highchart/highcharts.js'></script>";
    ?>
    <script type="text/javascript" src = "../js/mantenimiento.js"></script>
  </body>
</html>



<!-- ===============MODAL PARA EDITAR/Crear USUARIO============= -->
<div class="modal fade" id="modal_editarUsuario" >
  <div class="modal-dialog">
    <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            <h4 class="modal-title" id="myModalLabel">Editar Información de Usuario</h4>
          </div>
          <div class="modal-body">
            <h5 id = "userInfo"></h5> 
              <form id="formEditarUsuario" class="form" name="formEditarUsuario">
                <input id= 'userID' value = "" hidden>
                  <div id="verUserName" class="form-group">
                      <label class="control-label">Nombre del usuario</label>
                      <input type="text" class="form-control" name="nombreUsuario" id="nombreUsuario" title="Solo son permitidos numeros y letras 5 caracteres minimo" minlength="5" pattern="[a-zA-Z0-9]{5,}" autocomplete="off" required>
                  </div>
                  <div id="verPass" class="form-group">
                      <label class="control-label">Contraseña </label>
                      <input type="password" class="form-control" id="password" name="password" title="Solo son permitidos numeros y letras 8 caracteres minimo" pattern="[a-zA-Z0-9]{5,}" autocomplete="off" required>
                  </div>
                  <div id="verPass2" class="form-group">
                      <label class="control-label">Repetir contraseña</label>
                      <input type="password" class="form-control" id="password2" name="password2" value="">
                  </div>
                  <div id="verrol" class="form-group">
                    <label class="control-label" >Rol del usuario</label>
                    <div class="col-sm-10">
                        <select id="select_rol" name = "select_rol" class="form-control">
                            <option selected="" value="-1"> -- Seleccione un rol de usuario -- </option>        
                        </select>
                    </div>
                  </div>
                  <br>
                  <div class="row form-group " style = "height:35px; margin-top: 50px; margin-button : 5px;" >
                    <div class="col-md-4">
                      <label>Estado del usuario:  </label>

                    </div>
                    <div class="col-md-8" id = "estado" name = "estado">
                    </div>
                  </div>
            </form>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
            <button id = "btn_editarUsuario" data-user = "0" type="submit" class="btn btn-primary">Guardar Cambios</button>
          </div>
        </div><!-- modal-content -->
      </div>
  </div>
</div>



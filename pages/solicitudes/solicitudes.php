  <!---INFORMACION DE LA PAGINA- -->

  <?php
      require_once("../../login/seguridad.php");
      sec_session_start();
      //verificamos si hay una sesión iniciada
      if(!(isset($_SESSION['login']) && $_SESSION['login'] == '1')) {
        header("location: ../../login/login.php?error_code=2");
      }
      else{
         $maindir = "../../";
         $content = "solicitudes";
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
      <link rel="shortcut icon" href="" type="../../img/icon.png">

      <title>Workflow Solinver</title>

      <?php 
        require_once($maindir."pages/head.php");
      ?>
      <link rel="stylesheet" type="text/css" href="../../components/bootstrap-datepicker-1.6.4/bootstrap-datepicker.min.css">
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
                    <span class="fa fa-cog"></span></i> Módulo Ingreso de Solicitudes/Principal
                </li>
            </ol>
          </div>

          <div class="panel panel-default">
            <div class="panel-heading">
              <button class = "btn btn-large btn-primary openWizard" data-accion = "crear" >Ingresar nueva solicitud</button>
            </div>
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
                        <th>Editar</th>
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
    <script type="text/javascript" src = "../../components/bootstrap-datepicker-1.6.4/bootstrap-datepicker.min.js"></script>
    <script type='text/javascript' src = '../../js/solicitudes.js'></script>

    </body>
  </html>

  <!-- ===============MODAL confirm accion============= -->
  <div class="modal fade" id="modal_confirmEnviar" >
      <div class="modal-dialog">
          <div class="modal-content">
            <div class="modal-header">
              <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
              <h4 class="modal-title" id="">Enviar solicitud</h4>
            </div>
            <div class="modal-body">
                <form id="" class="form" name="">
                  <input type = "text" id = "data_envio_solicitud"  hidden>
                  <h2>¿Esta seguro de realizar esta acción?</h2>
                  <h5>Esta acción no se puede revertir.</h5>
                  <hr>
                  <div class="row" >
                   <label class="control-label col-sm-4" for="">Módulo Destino:</label>
                   <div class="form-inline">
                     <div class="col-sm-5">
                       <div class="form-group verModuloDestino">
                         <select name="moduloDestino" id="moduloDestino" class="form-control" required>
                           <option value= "-1" selected>----Seleccione una opcion valida----</option>
                           <option value= "2">Módulo de Recursos Humanos</option>
                           <option value= "3">Módulo de Analista de Créditos</option>
                           <option value= "4">Módulo de Aprobaciones</option>
                         </select>
                       </div>
                     </div>
                   </div>
                 </div>

                 <br>
                    <div id="" class="form-group">
                        <label class="control-label">Comentario:</label>
                        <textarea type="text" class="form-control" name="comentario" id="comentario" placeholder = "Ingrese un comentario..." required></textarea>
                    </div>
                    
                    <br>
              </form>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
              <button id = "enviar_solicitud" type = "button" class = "btn btn-primary">Enviar Solicitud</button>
            </div>
            
          </div><!-- modal-content -->
        </div>
  </div>


  <?php require_once("wizardCards.php"); ?>



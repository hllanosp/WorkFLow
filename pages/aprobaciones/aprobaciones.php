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
         $content = "aprobaciones";
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
                    <span class="fa fa-cog"></span></i> Módulo de  Aprobaciones
                </li>
            </ol>
          </div>

          <div class="panel panel-default">
            <div class="panel-body">
              <br />
              <div class = "col-md-12">
                <div class="box-body table-responsive">
                  <table class="table table-striped table-bordered" cellspacing="0" id="tbl_creditos">
                      <thead>
                       <tr>
                        <th >Solicitud</th>
                        <th >Estado</th>
                        <th >Fecha de creación</th>
                        <th >Identidad</th>
                        <th >Nombre</th>
                        <th >Tipo solicitud</th>
                        <th >Editar</th>
                        <th>Enviar</th>
                      </tr>
                    </thead>
                    <tbody id = "tbody_creditos">
                      
                    </tbody>
                  </table>
                </div><!-- table-responsive -->
              </div>

            </div><!-- panel-body -->
          </div><!-- panel -->
        </div>
        </div><!-- contentpanel -->
        
      </div><!-- mainpanel -->
    </section>
    <?php  
      require_once($maindir."pages/footer.php");
    ?>
    <script type="text/javascript" src = "../../components/bootstrap-datepicker-1.6.4/bootstrap-datepicker.min.js"></script>
    <script type='text/javascript' src = '../../js/aprobaciones.js'></script>

    </body>
  </html>


  <!-- ===============MODAL confirm accion============= -->
  <div class="modal fade " id="modal_confirmEnviar" >
    <div class="modal-dialog">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            <h4 class="modal-title" id="">Enviar</h4>
          </div>
          <div class="modal-body">
            <div class="" style = "padding: 20px;">
              <form id="formConfirm" class="form" name="formConfirm">
                <h2>¿Esta seguro de realizar esta acción?</h2>
                <hr>
                <div class="row" >
                 <label class="control-label col-sm-4" for="">Resolución del pŕestamo:</label>
                 <div class="form-inline">
                   <div class="col-sm-5">
                     <div class="form-group verResolucion">
                       <select name="card5_resolucion" id="card5_resolucion" class="form-control" required>
                         <option value= "-1" selected>----Seleccione una opcion valida----</option>
                         <option value= "5">Aprobado</option>
                         <option value= "6">Denegado</option>
                         <option value= "7">Devuelto</option>
                       </select>
                     </div>
                   </div>
                 </div>
               </div>
               <hr>
               <div class="row">
                 <div class="form-inline">
                   <div class="form-group verComments">
                     <label for="">Comentarios del aprobador</label>
                     <textarea name="card5_coment" maxlength="200" id="card5_coment" cols="55" rows="4" class="form-control"></textarea>
                   </div>
                 </div>
               </div>
             </form>
            </div>
         </div>
         <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
          <button id = "btn_confirmEnviar" data-solicitud = "0" type="button" class="btn btn-primary"  >Enviar</button>
        </div>

      </div><!-- modal-content -->
    </div>
  </div>
</div>




  <?php require_once("wizardCards.php"); ?>



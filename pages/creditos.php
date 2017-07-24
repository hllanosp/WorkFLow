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
 $content = "creditos";
 $usuario = $_SESSION['usuario'];
}
?>


<!DOCTYPE html>
<html lang="en">
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

    <!-- <div class="pageheader">
      <h4><i class="fa fa-home"></i> Inicio <span>...</span></h4>
      <div class="breadcrumb-wrapper">
        <span class="label">You are here:</span>
        <ol class="breadcrumb">
          <li><a href="index.html">Bracket</a></li>
          <li class="active">Dashboard</li>
        </ol>
      </div>
    </div> -->
    
    <div class="contentpanel">
      <ol class="breadcrumb">
        <li class="active">
          <span class="glyphicon glyphicon-credit-card"></span></i> Módulo analista de Créditos
        </li>
      </ol>
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
    
  </div><!-- contentpanel -->

</div><!-- mainpanel -->
</section>
<?php  
require_once($maindir."pages/footer.php");
?>
<script type="text/javascript" src = "../js/creditos.js"></script>

</body>
</html>


<div class="wizard" id="wizard_EditarSolicitud" data-title="">
  <div class="wizard-card" data-cardname="card1" style="height: 525px;">
    <h3 hidden>Datos generales del prestamo</h3>
    <input style="visibility:hidden;" class="" id="opcion" type="text" class="form-control" name="opcion" value=0 >  
    <input id="solicitud_id" type="text" class="" class="form-control" name="solicitud_id" style = "visibility:hidden;">                                          
    <div class = "form-group">
      <label class= "control-label">Tipo de Solicitud</label>
      <select name="card1_tipoSolicitud" id="card1_tipoSolicitud" data-placeholder="Seleccione el tipo de solicitud" style = "width: 350px" class="form-control">
        <option selected value= "-1">----Seleccione una opcion valida----</option>
        <option value= "1">Solicitud para colaborador</option>
        <option value= "2">Solicitud para cliente externo</option>
        <option value= "3">Solicitud cliente empresarial</option>
      </select>
    </div>
    <hr>
    <div class = "form-group">
      <label class= "control-label">Tipo de Préstamo</label>
      <select id="card1_tipoPrestamo" name="card1_tipoPrestamo" data-placeholder="Seleccione el tipo de préstamo" style = "width: 350px" class="form-control">
        <option selected value= "-1">----Seleccione una opcion valida----</option>
        <option value= "1">Préstamo Fiduciario</option>
        <option value= "2">Préstamo Prendario</option>
        <option value= "3">Préstamo Hipotecario</option>
      </select>
    </div>
    <hr>
    <div class="col-md-6">
      <div class="form-group">
        <label class="control-label" for="">Número de préstamo</label>
        <input disabled type="text" placeholder="Ingrese el número de préstamos" min="0" name="card1_prestamoID" id="card1_prestamoID" style="width:250px;" class="form-control numeros">
      </div>
    </div>
    
    <div class="col-md-6">
      <div class="form-group">
        <label class="control-label" for="">Cantidad Solicitada</label>
        <div class="input-group" style="width:250px;">
          <input disabled type="text" placeholder="" min="0" name="card1_cant_solicitada" id="card1_cant_solicitada"  class="form-control numeros">
          <span class="input-group-addon">LPS</span>
        </div>
      </div>
    </div>
    <hr>
    
    <div class="col-md-5">
      <div class="form-group">
        <br>
        <label class="control-label"  for="">Destino del préstamo</label>
        <select id = "card1_destino" name="card1_destino" data-placeholder="Seleccione el tipo de préstamo" style = "width: 350px" class="form-control">
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
    <div class="col-md-12">
      <hr>
    </div>
    <div class="col-xs-5 ">
      <div class="form-group">
        <label for="card1_resp" class="control-label">Tipo de responsabilidad</label>
        <div class="col-xs-12">
          <div class="input-group">
            <div id="radioBtn" class="btn-group">
              <a class="btn btn-default btn-sm notActive" data-toggle="card1_res" data-title="1">Individual</a>
              <a class="btn btn-default btn-sm notActive" data-toggle="card1_res" data-title="2">Mancomunal</a>
            </div>
            <input type="text"  style="visibility:hidden" name="card1_res" id="card1_res">
          </div>
        </div>
      </div>
    </div>
    <div class="col-md-5 col-md-offset-1">
      <div class="form-group">
        <label for="">Tipo de aprobación</label>
        <div class="col-xs-12">
          <div class="input-group">
            <div id="radioBtn" class="btn-group">
              <a class="btn btn-default btn-sm notActive" data-toggle="card1_aval" data-title="1">Con aval</a>
              <a class="btn btn-default btn-sm notActive" data-toggle="card1_aval" data-title="0">Sin aval</a>
            </div>
            <input type="text" style="visibility:hidden" name="card1_aval" id="card1_aval">
          </div>
        </div>
      </div>
    </div>
  </div>

  <!-- ============================================ -->
  <div class="wizard-card" data-cardname="card2" style="height: 525px;">
    <h3 hidden>Datos personales del solicitante</h3>
    <div class="row">
      <label class="control-label col-sm-2" for="">Nombres:</label>
      <div class="form-inline">
        <div class="col-sm-4">
          <div class="form-group ">
            <input id="card2_Pnombre_sol" type="text" class="form-control" maxlength="30" name="card2_Pnombre_sol" value="" placeholder="Ingrese el primer nombre">                                        
          </div>
        </div>
        <div class="col-sm-4">
          <div class="form-group">
            <input id="card2_Snombre_sol" type="text" class="form-control" maxlength="30" name="card2_Snombre_sol" value="" placeholder="Ingrese el segundo nombre">                                        
          </div>
        </div>
      </div>
    </div>
    <br>
    <div class="row">
      <label class="control-label col-sm-2" for="email">Apellidos:</label>
      <div class="form-inline">
        <div class="col-sm-4">
          <div class="form-group">
            <input id="card2_Papellido_sol" type="text" class="form-control" maxlength="30" name="card2_Papellido_sol" value="" placeholder="Ingrese el primer apellido">                                        
          </div>
        </div>
        <div class="col-sm-4">
          <div class="form-group">
            <input id="card2_Sapellido_sol" type="text" class="form-control" maxlength="30" name="card2_Sapellido_sol" value="" placeholder="Ingrese el segundo apellido">                                        
          </div>
        </div>
      </div>        
    </div>
    <br>
    <div class="row">
      <div class="col-xs-3">
        <label class="control-label">Número Identidad</label>
        <div class="input-group">
          <div class="form-group">
            <input id="card2_identidad_sol" type="text" maxlength="13" class="form-control numeros" name="card2_identidad_sol" value="" placeholder="Ingrese número de identidad">                                        
          </div>
        </div>
      </div>
      <div class="col-xs-3 col-xs-offset-1">
        <label class="control-label">RTN</label>
        <div class="input-group">
          <div class="form-group">
            <input id="card2_RTN_sol" type="text" maxlength="14" class="form-control numeros" name="card2_RTN_sol" value="" placeholder="Ingresar RTN">                                        
          </div>
        </div>
      </div>
      <div class="col-xs-3 col-xs-offset-1 ">
        <div class="form-group">
          <label class="control-label">Edad</label>
          <div class="input-group">
            <span class="input-group-addon"><i class="fa fa-male"></i></span>
            <input type="text"  id = "card2_edad" name="card2_edad" class="form-control" disabled>
          </div>
        </div>
      </div>
    </div>
    <br>
    <div class="row">
     <div class="col-xs-2 ">
      <div class="form-group">
        <label for="card2_sexo" class="control-label">Sexo</label>
        <div class="col-xs-12">
          <div class="input-group">
            <div id="radioBtn" class="btn-group">
              <a class="btn btn-default btn-sm notActive" data-toggle="card2_sexo" data-title="M">M</a>
              <a class="btn btn-default btn-sm notActive" data-toggle="card2_sexo" data-title="F">F</a>
            </div>
            <input type="text" style="visibility:hidden" name="card2_sexo" id="card2_sexo">
          </div>
        </div>
      </div>
    </div>
    <div class="col-xs-5 col-xs-offset-0">
      <label class="control-label">
        Fecha Nacimiento
      </label>
      <div class="row">
        <form name="formFecha" class="fecha">
          <div class="col-xs-3">
            <div class="form-group">

              <label class="control-label">Dia</label>
              <select name="card2_dia" id="card2_dia" class="form-control card2Edad" >
                <option value="01">01
                  <option value="02">02
                    <option value="03">03
                      <option value="04">04
                        <option value="05">05
                          <option value="06">06
                            <option value="07">07
                              <option value="08">08
                                <option value="09">09
                                  <option value="10">10
                                    <option value="11">11
                                      <option value="12">12
                                        <option value="13">13
                                          <option value="14">14
                                            <option value="15">15
                                              <option value="16">16
                                                <option value="17">17
                                                  <option value="18">18
                                                    <option value="19">19
                                                      <option value="20">20
                                                        <option value="21">21
                                                          <option value="22">22
                                                            <option value="23">23
                                                              <option value="24">24
                                                                <option value="25">25
                                                                  <option value="26">26
                                                                    <option value="27">27
                                                                      <option value="28">28
                                                                        <option value="29">29
                                                                          <option value="30">30
                                                                            <option value="31">31
                                                                            </select>
                                                                          </div>
                                                                        </div>
                                                                        <div class="col-xs-3">
                                                                          <div class="form-group">
                                                                            <label class="control-label">Mes</label>
                                                                            <select name="card2_Mes" id="card2_Mes" class="form-control card2Edad" onchange="asignaDias()">
                                                                              <option value="01">Enero
                                                                                <option value="02">Febrero
                                                                                  <option value="03">Marzo
                                                                                    <option value="04">Abril
                                                                                      <option value="05">Mayo
                                                                                        <option value="06">Junio
                                                                                          <option value="07">Julio
                                                                                            <option value="08">Agosto
                                                                                              <option value="09">Septiembre
                                                                                                <option value="10">Octubre
                                                                                                  <option value="11">Noviembre
                                                                                                    <option value="12">Diciembre
                                                                                                    </select>
                                                                                                  </div>
                                                                                                </div>
                                                                                                <div class="col-xs-4">
                                                                                                  <div class="form-group">
                                                                                                    <label class="control-label">año</label>
                                                                                                    <select name="card2_anyo" id="card2_anyo" class="form-control card2Edad" onchange="asignaDias()">
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
                                                                                              </form>
                                                                                              
                                                                                            </div> 
                                                                                          </div>
                                                                                          <div class="col-xs-4 col-xs-offset-0">
                                                                                            <div class="form-group">
                                                                                              <label for="card2_estadoCivil" class="control-label">Estado Civil</label>
                                                                                              <div class="col-xs-12">
                                                                                                <div class="input-group">
                                                                                                  <div id="radioBtn" class="btn-group">
                                                                                                    <a class="btn btn-default btn-sm notActive" data-toggle="card2_estadoCivil" data-title="1">Soltero</a>
                                                                                                    <a class="btn btn-default btn-sm notActive" data-toggle="card2_estadoCivil" data-title="2">Casado</a>
                                                                                                    <a class="btn btn-default btn-sm notActive" data-toggle="card2_estadoCivil" data-title="3">otros</a>
                                                                                                  </div>
                                                                                                  <input type="text" style="visibility:hidden" name="card2_estadoCivil" id="card2_estadoCivil">
                                                                                                </div>
                                                                                              </div>
                                                                                            </div>
                                                                                          </div>
                                                                                        </div>
                                                                                        <hr>
                                                                                        <div class="row">
                                                                                          <div class="col-xs-5">
                                                                                            <div class="form-group">
                                                                                              <label class="control-label">Jefe directo</label>
                                                                                              <div class="input-group">
                                                                                                <span class="input-group-addon"><i class="glyphicon glyphicon-king"></i></span>
                                                                                                <input id="card2_Jefe" type="text" maxlength="100" class="form-control" name="card2_Jefe" value="" placeholder="Ingrese el nombre del jefe directo">                                        
                                                                                              </div>
                                                                                            </div>
                                                                                          </div>
                                                                                          <div class="col-xs-3 col-xs-offset-1">
                                                                                            <div class="form-group">
                                                                                              <label class="control-label">Tiempo de servicio</label>
                                                                                              <div class="input-group">
                                                                                                <span class="input-group-addon">Años</span>
                                                                                                <input id="card2_Tservicio" type="number" min="0" max="99999" class="form-control numeros" name="card2_Tservicio" value="" placeholder="Ingrese el tiempo del servicio">                                        
                                                                                              </div>
                                                                                            </div>
                                                                                          </div>
                                                                                        </div>
                                                                                      </div>
                                                                                      
                                                                                      <!-- ============================================ -->
                                                                                      <div class="wizard-card" data-cardname="card3" style="height: 525px;">
                                                                                        <h3 hidden>Datos personales del fiador</h3>
                                                                                        <div class="row">
                                                                                          <div class="form-group">
                                                                                            <label class="control-label col-sm-2" for="card3_Pnombre_aval">Nombres:</label>
                                                                                            <div class="col-sm-4">
                                                                                              <input id="card3_Pnombre_fiador" maxlength="30" type="text" class="form-control" name="card3_Pnombre_fiador" value="" placeholder="Ingrese el primer nombre">                                        
                                                                                            </div>
                                                                                            <div class="col-sm-4">
                                                                                              <input id="card3_Snombre_fiador" maxlength="30" type="text" class="form-control" name="card3_Snombre_fiador" value="" placeholder="Ingrese el segundo nombre">                                        
                                                                                            </div>
                                                                                          </div>
                                                                                          <div class="form-group">
                                                                                            <label class="control-label col-sm-2" for="">Apellidos:</label>
                                                                                            <div class="col-sm-4">
                                                                                              <input id="card3_Papellido_fiador"  maxlength="30" type="text" class="form-control" name="card3_Papellido_fiador" value="" placeholder="Ingrese el primer apellido">                                        
                                                                                            </div>
                                                                                            <div class="col-sm-4">
                                                                                              <input id="card3_Sapellido_fiador" maxlength="30" type="text" class="form-control" name="card3_Sapellido_fiador" value="" placeholder="Ingrese el segundo apellido">                                        
                                                                                            </div>
                                                                                          </div>
                                                                                        </div>

                                                                                        <br>
                                                                                        <div class="row">
                                                                                          <div class="col-xs-3 col-xs-offset-3">
                                                                                            <div class="form-group">
                                                                                              <label class="control-label">Número Identidad</label>
                                                                                              <div class="input-group">
                                                                                                <!-- <span class="input-group-addon"><i class="fa fa-male"></i></span> -->
                                                                                                <input id="card3_identidad_fiador" maxlength="13" type="text" class="form-control numeros" name="card3_identidad_fiador" value="" placeholder="Ingrese número de identidad">                                        
                                                                                              </div>
                                                                                            </div>
                                                                                          </div>
                                                                                          
                                                                                          <div class="col-xs-3 col-xs-offset-1 ">
        <!-- <div class="form-group">
          <label class="control-label">Edad</label>
          <div class="input-group">
            <span class="input-group-addon"><i class="fa fa-male"></i></span>
           <h4 for="" id="card3_edad_fiador"></h4>                                    
          </div>
        </div> -->
      </div>
    </div>
    <br>
    <!-- <div class="row">
      <div class="col-xs-2 ">
        <div class="form-group">
          <label for="text_sexo_aval" class="control-label">&nbsp;&nbsp;&nbsp;&nbsp;Sexo</label>
          <div class="col-xs-12">
            <div class="input-group">
              <div id="radioBtn" class="btn-group">
                <a class="btn btn-default btn-sm notActive" data-toggle="card3_sexo" data-title="M">M</a>
                <a class="btn btn-default btn-sm notActive" data-toggle="card3_sexo" data-title="F">F</a>
              </div>
              <input type="text" style="" name="card3_sexo" id="card3_sexo">
            </div>
          </div>
        </div>
      </div>
      <div class="col-xs-5 col-xs-offset-0">
        <label class="control-label">
          Fecha Nacimiento
        </label>
        <div class="row">
          <form name="formFecha2" class="fecha">
          <div class="col-xs-3">
            <div class="form-group">
              <label class="control-label">Dia</label>
              <select name="seleccionaDia" id="card3_dia" class="form-control" >
                <option value="01">01
                <option value="02">02
                <option value="03">03
                <option value="04">04
                <option value="05">05
                <option value="06">06
                <option value="07">07
                <option value="08">08
                <option value="09">09
                <option value="10">10
                <option value="11">11
                <option value="12">12
                <option value="13">13
                <option value="14">14
                <option value="15">15
                <option value="16">16
                <option value="17">17
                <option value="18">18
                <option value="19">19
                <option value="20">20
                <option value="21">21
                <option value="22">22
                <option value="23">23
                <option value="24">24
                <option value="25">25
                <option value="26">26
                <option value="27">27
                <option value="28">28
                <option value="29">29
                <option value="30">30
                <option value="31">31
              </select>
            </div>
          </div>
          <div class="col-xs-3">
            <div class="form-group">
              <label class="control-label">Mes</label>
              <select name="seleccionaMes" id="card3_Mes" class="form-control" onchange="asignaDias2()">
                <option value="01">Enero
                <option value="02">Febrero
                <option value="03">Marzo
                <option value="04">Abril
                <option value="05">Mayo
                <option value="06">Junio
                <option value="07">Julio
                <option value="08">Agosto
                <option value="09">Septiembre
                <option value="10">Octubre
                <option value="11">Noviembre
                <option value="12">Diciembre
              </select>
            </div>
          </div>
          <div class="col-xs-4">
            <div class="form-group">
              <label class="control-label">año</label>
              <select name="seleccionaAnyo" id="card3_anyo" class="form-control" onchange="asignaDias2()">
                <script language="JavaScript" type="text/javascript">
                    document.write(rellenaAnyos2(150));
                </script>
              </select>
            </div>
          </div>
          </form>
         
        </div>
      </div>
      <div class="col-xs-5 ">
        <div class="form-group">
          <label for="card2_EstaCivil" class="control-label">Estado civil</label>
           <br>
            <div class="input-group">
              <div id="radioBtn" class="btn-group">
                <a class="btn btn-default btn-sm notActive" data-toggle="card3_estadoCivil" data-title="1">Soltero</a>
                <a class="btn btn-default btn-sm notActive" data-toggle="card3_estadoCivil" data-title="2">Casado</a>
                <a class="btn btn-default btn-sm notActive" data-toggle="card3_estadoCivil" data-title="3">Otros</a>
              </div>
              <input type="text" style="visibility:hidden" name="card3_estadoCivil" id="card3_estadoCivil">
            </div>
         </div>
      </div>
    </div> -->
    <hr>
    <div class="row">
      <div class="col-xs-7">
        <div class="form-group">
          <label class="control-label">Nombre de la empresa en que labora</label>
          <div class="input-group">
            <span class="input-group-addon"><i class="glyphicon glyphicon-briefcase"></i></span>
            <input id="card3_nombre_empresa" maxlength="100" type="text" class="form-control" name="card3_nombre_empresa" value="" placeholder="Ingrese el nombre de la empresa en que labora">                                        
          </div>
        </div>
      </div>
    </div>
  </div>

  <!-- ============================================ -->
  <div class="wizard-card" data-cardname="card4" style="height: 525px;">
    <h3 hidden>Condiciones del préstamo</h3>
    <div class="row">
      <div class="col-md-6">
        <div class="form-inline">
          <div class="form-group">
            <label for="">Monto aprobado</label> 
            <div class="input-group">
              <input type="number" step="0.01" min="0" maxlength="13" style="width:135px;" id="card4_monto" name = "card4_monto" class="form-control numeros">
              <span class="input-group-addon">LPS</span>
            </div>
          </div>
        </div>
        <br>
        <div class="form-inline">
          <div class="form-group">
            <label for="">Plazo aprobado</label>&nbsp; 
            <div class="input-group">
              <input type="number" style="width:120px;" id="card4_plazoap"min="0" name = "card4_plazoap" class="form-control numeros">  
              <span class="input-group-addon">Meses</span>
            </div>
          </div>
        </div>
        <br>
        <div class="form-inline">
          <div class="form-group">
            <label for="">Cuota nivelada</label>&nbsp;&nbsp; 
            <div class="input-group">
              <input type="number" step="0.01" min="0" maxlength="13" style="width:136px;" id="card4_cuota" min="0" name="card4_cuota"class="form-control numeros">  
              <span class="input-group-addon">LPS</span>
            </div>
          </div>
        </div>
        <br>
        <div class="form-inline">
          <div class="form-group">
            <label for="">Tasa de interes</label>&nbsp;&nbsp;
            <div class="input-group">
              <input type="number" step="0.01" style="width:100px;" id="card4_interes" name = "card4_interes" min="0" max="100" class="form-control numeros">  
              <span class="input-group-addon">%</span>
            </div> 
          </div>
        </div>
      </div>
      <div class="col-md-6">
        <div class="form-group">
          <label for="">Descripción de garantia</label>
          <br>
          <textarea  id="card4_garantia" maxlength="300" name = "card4_garantia" class="form-control" cols="25" rows="5"></textarea>
        </div>
      </div>
    </div>
    <hr>
    <h4>Cuadro indicadores de credito</h4>
    <div class="row">
      <div class="col-xs-6">
        <div class="form-inline">
          <div class="form-group">
            <label for="">Relación Cuota Ingreso (RCI):</label>&nbsp;&nbsp;
            <div class="input-group">
              <input type="number" step="0.01" min="0" max="100" id="card4_RCI" name = "card4_RCI" style="width:100px;" class="form-control numeros">
              <span class="input-group-addon">%</span>
            </div>
          </div>
        </div>
      </div>
      <div class="col-xs-6">
        <div class="form-inline">
          <div class="form-inline">
            <div class="form-group">
              <label for="">Nivel De Endeudamiento (DTI):</label>&nbsp;&nbsp;
              <div class="input-group">
                <input type="number" step="0.01" id="card4_TDI" name = "card4_TDI" style="width:100px;" max="100" min="0" class="form-control numeros">
                <span class="input-group-addon">%</span>
              </div>
            </div>
          </div>
        </div>
      </div> 
    </div>
    <hr>
    <div class="row">
      <label for="">Confirmación de referencias</label>
      <div class="form-group">
        <div class="input-group">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          <div id="radioBtn" class="btn-group">
            <a class="btn btn-default btn-sm notActive"  data-toggle="card4_confirmacion" data-title="1">Si</a>
            <a class="btn btn-default btn-sm notActive"  data-toggle="card4_confirmacion" data-title="0">No</a>
          </div>

          <input type="text" style="visibility:hidden" name="card4_confirmacion" id="card4_confirmacion">
        </div>
        
      </div>
    </div>
    <hr>
    <div class="row">
      <div class="form-inline">
        <div class="form-group">
          <label for="">Comentarios del analista</label>
          <textarea name="card4_analista" maxlength="300" id="card4_analista" cols="55" rows="4" class="form-control"></textarea>
        </div>
      </div>
    </div>
  </div>
  <!-- ============================================ -->
  <div class="wizard-card" data-cardname="card5" style="height: 525px;">
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

  <!-- ==================================================== -->

  <div class="wizard-card" data-cardname="card6" style="height: 525px;">
    <h3 id = "title_rrhh">Información de RRHH</h3>
    <form id="" class="form" name="">
      <input type = "text" id = "data_envio_solicitud" hidden>
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
  <!-- tarjetas especiales -->
  
  <!-- Tarjeta a mostrar cuando existe un error al hacer submit del wizard -->
  <div class="wizard-error">
    <div class="alert alert-success">
      <span class="create-server-name"></span>Ha ocurrido un error al guardar el formulario... <strong></strong>
    </div>
    <a class="btn btn-success im-done">Salir</a>
  </div>
  

  <div class="wizard-failure">
  <!-- <div class="alert alert-error">
    <strong>There was a problem</strong> submitting the form.
    Please try again in a minute.
  </div> -->
</div>

<div class="wizard-success">
  <div class="alert alert-success">
    <span class="crearOtraSolicitud"></span>Solicitud editada <strong>Correctamente.</strong>
  </div>
  <a class="btn btn-success im-done">Finalizar y salir</a>
</div>
</div>


<!-- ===============MODAL confirm accion============= -->
<div class="modal fade" id="modal_confirmEnviar" >
  <div class="modal-dialog">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
          <h4 class="modal-title" id="">Enviar</h4>
        </div>
        <div class="modal-body">
          <form id="formConfirm" class="form" name="formConfirm">
            <h2>¿Esta seguro de realizar esta acción?</h2>
             <hr>
             <div class="row" >
              <label class="control-label col-sm-4" for="">Resolución del pŕestamo:</label>
              <div class="form-inline">
                <div class="col-sm-5">
                  <div class="form-group verResolucion">
                    <select name="card5_resolucion" id="card5_resolucion" class="form-control" required>
                      <option value= "4" selected>Enviar Solicitud al Aprobador</option>
                      <option value= "1">Devolver a Módulo Ingreso de Solicitudes</option>
                    </select>
                  </div>
                </div>
              </div>
            </div>
            <hr>
            <br>
            <h5>Esta acción no se puede revertir.</h5>
            <div id="" class="form-group verComments">
              <label class="control-label">Comentario:</label>
              <textarea type="text" class="form-control" name="card5_coment" id="card5_coment" placeholder = "Ingrese un comentario..." required></textarea>
            </div>
            
            <br>
          </form>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
          <button id = "btn_confirmEnviar" data-solicitud = "0" type="button" class="btn btn-primary"  >Enviar</button>
        </div>
        
      </div><!-- modal-content -->
    </div>
  </div>
</div>


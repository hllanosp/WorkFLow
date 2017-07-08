<!---INFORMACION DE LA PAGINA- -->


<?php
    require_once("../login/seguridad.php");
    sec_session_start();
    $maindir = "../";
    //verificamos si hay una sesión iniciada
    if(!(isset($_SESSION['login']) && $_SESSION['login'] == '1')) {
          header("location: ".$maindir."login/login.php?error_code=2");
    }
    else{
      $content = "home";
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
    
    <div class="contentpanel">
      <div>
        <ol class="breadcrumb">
            <li class="active">
                <span class="fa fa-cog"></span></i> Pagina de Inicio
            </li>

        </ol>
      </div>
      <div class="jumbotron" style = "margin:5%;">
        <h4 class="text-center">Bienvenido al WorkFlow de Sistema de Creditos SOLINVER.</h3>
        <hr>
        <div class = "container">
            <div class = "row">
              <div class = "col-xs-4">
                <img class="featurette-image img-circle pull-left" src="../img/logoInicio.png" style = "width: 65%; margin-left: 35%; ">
              </div>
              <div class = "col-xs-8 ">
                  <h5 class="">Misión: Proveer soluciones a Otorgantes de Crédito y Consumidores para administrar el riesgo crediticio, que faciliten la toma de decisiones para la generación de negocios, contribuyendo al desarrollo economico de nuestro empleados.</h5>
                  <h5 class="">Visión: Ser lider en proveer soluciones para la administracion del riesgo créditicio, creando valor para nuestros clientes, colaboradores y accionistas y facilitando el acceso al crédito a nuestros socios.</h5>
              </div>
            </div>

        </div>
        <hr>
          <a class="btn btn-default btn-lg" style = "margin-left: 70%; color: white; background-color: rgb(104, 119, 129);" href="#" role="button">Saber mas...</a>
        
      </div>
       
      </div>
    
  </div><!-- mainpanel -->
</section>
<?php  
  require_once($maindir."pages/footer.php");
?>

</body>
</html>

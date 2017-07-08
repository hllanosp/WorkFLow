<?php
  require_once("../login/seguridad.php");
  sec_session_start();
  
	function cargar_error(){
	   if(isset($_GET["error_code"]))
	   {
	       $accion = $_GET["error_code"];
	        switch ($accion) {
	            case 1:
	                error_print(1);
	                break;
	            case 2:
	                error_print(2);
	                break;
              case 3:
                  error_print(3);
                  break;

	       
	            default:
	                break;
	        }
	   }
	}

	 function error_print($error_code)
	 {
	     $mensaje = "";
	     switch ($error_code) {
	          case 1:
	              $mensaje = "Usuario o contraseña incorrecto";
	              break;
	          case 2:
                $mensaje = "Credenciales inválidas, por favor trate de ingresar con un usuario y contraseña validos";
                break;
            case 3:
	              $mensaje = "Credenciales inválidas, Usuario inhabilitado";
	              break;
	          default:
	              break;
	      }
	      echo '<div class="alert alert-danger alert-error" id = "notificaciones">
	      <a href="#" class="close" data-dismiss="alert">&times;</a>
	      <strong> Error! </strong>'.$mensaje.'</div>';
	 }
?>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
  <meta name="description" content="">
  <meta name="author" content="">
  <link rel="shortcut icon" href="images/favicon.png" type="image/png">

  <title>Autenticación de</title>

  <link href="../css/style.default.css" rel="stylesheet">

  <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
  <!--[if lt IE 9]>
  <script src="js/html5shiv.js"></script>
  <script src="js/respond.min.js"></script>
  <![endif]-->
</head>

<body class="signin">
<section>
    <div class="signinpanel">
        <div class="row">
            <div class="col-md-7">
                <div class="signin-info">
                    <div class="logopanel">
                        <h1><span>[</span> WorkFLow Financiero SOLINVER <span>]</span></h1>
                    </div>
                
                    <div class="mb20"></div>
                
                    <h5><strong>Bienvenido !</strong></h5>
                    <ul>
                        <li><i class="fa fa-arrow-circle-o-right mr5"></i> Cualidad del sistema uno</li>
                        <li><i class="fa fa-arrow-circle-o-right mr5"></i> Cualidad 2</li>
                    </ul>
                    <!-- <div class="mb20"></div>
                    <strong>Not a member? <a href="signup.html">Sign Up</a></strong> -->
                </div>
            
            </div><!-- col-sm-7 -->
            <div class="col-md-5">
                
                <form method="post" action="login_submit.php">
                	<?php
                		cargar_error();
                	?>
                	<br>

                    <h4 class="nomargin text-center">INICIO DE SESION</h4>
                
                    <input type="text" class="form-control uname" id = "usuario" name = "usuario" placeholder="Usuario" />
                    <input type="password" class="form-control pword" id = "password" name = "password" placeholder="Contraseña" />
                    <button type = "submit"  class="btn btn-success btn-block" style = "background-color: #1CAF9A; border-color: #1CAF9A;">Ingresar</button>
                
                </form>
            </div><!-- col-sm-5 -->  
        </div><!-- row -->
        <div class="signup-footer">
            <div class="pull-left">
                &copy; 2017. SOLINVER
            </div>
            <div class="pull-right">
                Created By: <a href="http://themepixels.com/" target="_blank">hllanos75@gmail.com</a>
            </div>
        </div>
    </div><!-- signin -->
</section>
<script src="../components/jquery-1.11.3.min.js"></script>
<script src="../components/bootstrap/js/bootstrap.min.js"></script>

</body>
</html>

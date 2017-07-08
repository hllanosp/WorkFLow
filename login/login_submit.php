<?php 
		require_once("../login/seguridad.php");
		sec_session_start();
		
		include("../conexion/config.inc.php");

		$usuario = $_POST['usuario'];
		$password = $_POST['password'];

		$query =  $db->prepare("SELECT usuarioID, usuario, contrasenia, rol, estado  FROM usuarios WHERE usuario = '".$usuario."' ;");
		$query->execute();
		$result = $query -> rowCount();
		
		if($result > 0){
			$row = $query->fetch();
	        $passwordenBD = $row['contrasenia'];
	        $estado = $row['estado'];
	        $usuario_ID = $row['usuarioID'];
	        
	        if(crypt($password, $passwordenBD) == $passwordenBD) {
	            	if(($estado == 1)){ // si el usuario se encuentra habilitado
			            $_SESSION['login'] = '1';
			            $_SESSION['usuario'] = $usuario;
			            $_SESSION['usuarioID'] = $usuario_ID;
			            $_SESSION['rol'] = $row['rol'];

			            header('location:../pages/home.php');

			        }else{
			        	header('location:login.php?error_code=3');	
			        }
		    }
		    else{
	        	header('location:login.php?error_code=1');	
		    }
        }
        else{
        	header('location:login.php?error_code=1');	
        }
		
	 ?>

	 <?php
	     function crypt_blowfish($password, $digito = 7) {
	      $set_salt = './1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
	      $salt = sprintf('$2a$%02d$', $digito);
	      for($i = 0; $i < 22; $i++)
	      {
	          $salt .= $set_salt[mt_rand(0, 63)];
	      }
	      return crypt($password, $salt);
	  }
	   ?>
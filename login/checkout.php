<?php
	require_once("../login/seguridad.php");
    sec_session_start();

	$_SESSION = array();
	session_unset();
	session_destroy();
	header("location:../login/login.php");
 ?>
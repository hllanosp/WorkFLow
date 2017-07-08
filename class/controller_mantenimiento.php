<?php
    require_once("../login/seguridad.php");
    sec_session_start();
    //verificamos si hay una sesión iniciada
    if(!(isset($_SESSION['login']) && $_SESSION['login'] == '1')) {
          header("location: ../login/login.php?error_code=2");
    }
    else{
       $maindir = "../";
       $usuario = $_SESSION['usuario'];
       $rol = $_SESSION['rol'];
    }
?>


<?php 

    include ($maindir.'conexion/config.inc.php');
    include ($maindir.'scripts/encrypt_functions.php');
  
    $opcion = $_POST['opcion'];
    
    switch($opcion){

        case 0: // SE OBTIENEN TODOS LOS USUARIOS
            if($rol == 0 ){//validación por rol
                $json = array();
                $msj ="";
                $bandera = 0;
                try{

                    $query = $db->prepare("SELECT usuarioID, usuario, rol, estado, fechaCreacion, descripcion as rol_descripcion FROM usuarios inner join usuario_rol on rol = rolID");
                    $query->execute();
                    $result = $query->fetchAll();

                    $contadorIteracion = 0;
                    foreach($result as $fila){ 
                        $json[$contadorIteracion] = array(
                            "usuarioID" =>$fila['usuarioID'],
                            "usuario" => $fila['usuario'],
                            "rol" => $fila['rol'],
                            "estado" => $fila['estado'],
                            "fechaCreacion" => $fila['fechaCreacion'],
                            "rol_descripcion" => $fila['rol_descripcion']
                        );
                        
                        $contadorIteracion++;
                    }

                    $a = array(
                        "mensajeError" => "Accion realizada correctamente...",
                        "bandera" => 1
                    );

                    array_unshift($json, $a ); 
                    echo json_encode($json);

                }catch(PDOExecption $e){
                    $a = array(
                        "mensajeError" => $e,
                        "bandera" => 0
                    );
                    
                    echo json_encode($a);
                }

            }
            else{
                $a = array(
                    "mensajeError" => "Error : privilegios insuficientes...",
                    "bandera" => 0
                );
                
                echo json_encode($a);
            }

            break;

        // -----------------------------------------------------------------------------------------------

        case 1: // OBTENER INFORMACION DE USUARIO EN ESPECIFICO
            if(true){ //validacion de roles
                $json = array();
                $msj ="";
                $bandera = 0;
                try{
                    $usuarioID = $_POST["usuarioID"];
                    $query = $db->prepare("SELECT usuarioID, usuario, rol, estado, fechaCreacion FROM usuarios WHERE usuarioID = ?");
                    $query->bindParam(1,$usuarioID, PDO::PARAM_INT);
                    $query->execute();
                    $result = $query->fetchAll();

                    $contadorIteracion = 0;
                    foreach($result as $fila){ 
                        $json[$contadorIteracion] = array(
                            "usuarioID" =>$fila['usuarioID'],
                            "usuario" => $fila['usuario'],
                            "rol" => $fila['rol'],
                            "estado" => $fila['estado'],
                            "fechaCreacion" => $fila['fechaCreacion']
                        );
                        
                        $contadorIteracion++;
                    }
                    $a = array(
                        "mensajeError" => "Accion realizada correctamente...",
                        "bandera" => 1
                    );
                    array_unshift($json, $a ); 
                    echo json_encode($json);
                }catch(PDOExecption $e){
                    $a = array(
                        "mensajeError" => $e,
                        "bandera" => 0
                    );
                    echo json_encode($a);
                }
            }
            else{
            }
            break;

        // -----------------------------------------------------------------------------------------------


        case 2: // OBTIENE LOS ROLES DE USUARIO
            if(true){ //validacion de roles
                $json = array();
                $msj ="";
                $bandera = 0;
                try{
                    $query = $db->prepare("SELECT rolID, descripcion FROM usuario_rol ");
                    $query->execute();
                    $result = $query->fetchAll();

                    $contadorIteracion = 0;
                    foreach($result as $fila){ 
                        $json[$contadorIteracion] = array(
                            "rolID" =>$fila['rolID'],
                            "descripcion" => $fila['descripcion'],
                        );
                        
                        $contadorIteracion++;
                    }

                    $a = array(
                        "mensajeError" => "Accion realizada correctamente...",
                        "bandera" => 1
                    );

                    array_unshift($json, $a ); 
                    echo json_encode($json);
                }catch(PDOExecption $e){
                    $a = array(
                        "mensajeError" => "Hubo un error al realizar la consulta...",
                        "bandera" => 0
                    );
                    
                    echo json_encode($a);
                }
            }
            else{
            }
            break;

        // -----------------------------------------------------------------------------------------------


        case 3: // EDITAR USUARIO
            if(true){ //validacion de roles
                $json = array();
                $msj ="";
                $bandera = 0;


                try{
                    $usuarioID = $_POST["usuarioID"];
                    $usuario = $_POST["usuario"];
                    $pass = crypt_blowfish($_POST["pass"]);
                    $rol = $_POST["rol"];
                    $estado = $_POST["estado"];

                    $query = $db->prepare("UPDATE  usuarios SET usuario = ?, rol = ?, contrasenia = ? , estado = ? WHERE usuarioID = ? ");
                    $query->bindParam(1,$usuario, PDO::PARAM_INT);
                    $query->bindParam(2,$rol, PDO::PARAM_INT);
                    $query->bindParam(3,$pass, PDO::PARAM_STR);
                    $query->bindParam(4,$estado, PDO::PARAM_INT);
                    $query->bindParam(5,$usuarioID, PDO::PARAM_STR);
                    $query->execute();

                    $json[0]= array(
                        "mensajeError" => "Accion realizada correctamente...",
                        "bandera" => 1
                    );

                    echo json_encode($json);
                }catch(PDOExecption $e){
                    $a = array(
                        "mensajeError" => "Hubo un error al realizar la consulta...",
                        "bandera" => 0
                    );
                    echo json_encode($a);
                }
            }
            else{

            }
            break;

        // -----------------------------------------------------------------------------------------------

        case 4: // GUARDAR NUEVO USUARIO
            if(true){ //validacion de roles
                $json = array();
                $msj ="";
                $bandera = 0;

                try{
                    $usuario = $_POST["usuario"];
                    $rol = $_POST["rol"];
                    $pass = crypt_blowfish($_POST["pass"]);
                    $estado = 2;

                    $query = $db->prepare("INSERT INTO  usuarios(usuario, rol, contrasenia, estado) VALUES(?,?,?,?) ;");
                    $query->bindParam(1,$usuario, PDO::PARAM_STR);
                    $query->bindParam(2,$rol, PDO::PARAM_INT);
                    $query->bindParam(3,$pass, PDO::PARAM_STR);
                    $query->bindParam(4, $estado, PDO::PARAM_INT);
                    
                    $query->execute();

                    $json[0]= array(
                        "mensajeError" => "Accion realizada correctamente...",
                        "bandera" => 1
                    );

                    echo json_encode($json);

                }catch(PDOException $e){
                    $a = array(
                        "mensajeError" => $e,
                        "bandera" => 0
                    );
                    echo json_encode($a);
                }
            }
            else{
                $msj = "No tienes privilegios suficientes para realizar esta acción...";
                $bandera = 0;
            }
            break;

        // -----------------------------------------------------------------------------------------------

        case 5: // OBTENER USUARIOS HABILITADOS O DESABILITADOS
            if(true){ //validacion de roles
                $json = array();
                $msj ="";
                $bandera = 0;
                try{
                    $query = $db->prepare("SELECT count(estado) as activos FROM usuarios WHERE estado = 1");
                    $query ->execute();

                    $query2 = $db->prepare("SELECT count(estado) as inactivos FROM usuarios WHERE estado = 0");
                    $query2->execute();    

                    $activos = $query ->fetch();
                    $inactivos = $query2->fetch();
                   
                    array_unshift($json, $activos ); 
                    array_unshift($json, $inactivos ); 

                    $a = array(
                        "mensajeError" => "Accion realizada correctamente...",
                        "bandera" => 1
                    );

                    array_unshift($json, $a ); 
                    
                    echo json_encode($json);
                }catch(PDOExecption $e){
                    $a = array(
                        "mensajeError" => $e,
                        "bandera" => 0
                    );
                    echo json_encode($a);
                }
            }
            else{
            }
            break;    


        // -----------------------------------------------------------------------------------------------

        case 6: // habilitar o deshabilitar usuarios
            if(true){ //validacion de roles
                $json = array();
                $msj ="";
                $bandera = 0;
                try{
                    $estado = $_POST["status"];
                    $usuarioID = $_POST["usuarioID"];
                    $query = $db->prepare("UPDATE usuarios SET estado = ? WHERE usuarioID = ?");
                    $query->bindParam(1,$estado, PDO::PARAM_INT);
                    $query->bindParam(2,$usuarioID, PDO::PARAM_INT);
                    
                    $query->execute();

                    $json[0]= array(
                        "mensajeError" => "Accion realizada correctamente...",
                        "bandera" => 1
                    );
                    
                    echo json_encode($json);
                }catch(PDOExecption $e){
                    $a = array(
                        "mensajeError" => $e,
                        "bandera" => 0
                    );
                    echo json_encode($a);
                }
            }
            else{
            }
            break;    

       default:
            break;


    }

?>

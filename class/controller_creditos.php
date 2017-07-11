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
 $usuarioID = $_SESSION['usuarioID'];
 $rol = $_SESSION['rol'];
}
?>


<?php 
include ($maindir.'conexion/config.inc.php');
include ($maindir.'scripts/encrypt_functions.php');

$opcion = $_POST['opcion'];


switch($opcion){
    case 1: //  obtiene todas las solicitudes.
        if(true){ //validacion de roles
            $json = array();
            $msj ="";
            $bandera = 0;
            try{
                $query = $db->prepare("CALL SP_TRAER_SOLICITUDES_CREDITOS(@mensajeError,@codigoError)");
                $query->execute();
                $result = $query->fetchAll();

                $contadorIteracion = 0;
                foreach($result as $fila){ 
                    $json[$contadorIteracion] = array(
                        "solicitudID" =>$fila['solicitudID'],
                        "estadoID" => $fila['estadoID'],
                        "fechaCreacion" => $fila['fechaCreacion'],
                        
                        "identidad" => $fila['identidad'],
                        "solicitanteNombre" => $fila['solicitanteNombre'],
                        "tipoSolicitud" => $fila['tipoSolicitud']
                        
                    );
                    
                    $contadorIteracion++;
                }

                // $output = $db->query("select @mensajeError")->fetchAll(PDO::FETCH_ASSOC);
                // $mensaje = $output['@mensajeError'];
                
                // $output = $db->query("select @codigoError")->fetchAll(PDO::FETCH_ASSOC);
                // $bandera = $output['@codigoError']; 

                 $a = array(
                    "mensajeError" =>"exito",
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
            $a = array(
                "mensajeError" => "Error : privilegios insuficientes...",
                "bandera" => 0
                );
            
            echo json_encode($a);
        }

        break;

        // -----------------------------------------------------------------------------------------------

        // -----------------------------------------------------------------------------------------------

     case 2: // envio de solicitud 
        if(true){ //validacion de roles
            $json = array();
            $msj ="";
            $bandera = 0;

            try{
                $comment = $_POST["comment"];
                $solicitudID = $_POST["solicitudID"];
                $nuevoEstado = 4;

                $query = $db->prepare("CALL SP_ENVIAR_SOLICITUD_CREDITOS(?,?,?,?, @mensajeError,@codigoError)");
                $query->bindParam(1,$solicitudID, PDO::PARAM_INT);
                $query->bindParam(2,$nuevoEstado, PDO::PARAM_INT);
                $query->bindParam(3,$usuarioID, PDO::PARAM_INT);
                $query->bindParam(4,$comment, PDO::PARAM_STR);
                $query->execute();

                $output = $db->query("select @mensajeError")->fetch(PDO::FETCH_ASSOC);
                $mensaje = $output['@mensajeError'];
                
                $output = $db->query("select @codigoError")->fetch(PDO::FETCH_ASSOC);
                $bandera = $output['@codigoError']; 

                $json[0] = array(
                    "mensajeError" => $bandera,
                    "bandera" => $mensaje
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

    case 3: //  trae una solicitud
        if(true){ //validacion de roles
            $json = array();
            $msj ="";
            $bandera = 0;
            try{
                $solicitudID = $_POST["solicitudID"];
                $query = $db->prepare("CALL SP_OBTENER_CREDITOS(@codigoError, @mensajeError,?);");
                $query->bindParam(1,$solicitudID, PDO::PARAM_INT);
                $query->execute();
                $result = $query->fetchAll();

                $contadorIteracion = 0;
                foreach($result as $fila){ 
                    $json[$contadorIteracion] = array(
                        "tipoSolicitudID" =>$fila['tipoSolicitudID'],
                        "tipoPrestamoID" => $fila['tipoPrestamoID'],
                        "prestamoID" => $fila['prestamoID'],
                        "destino" => $fila['destinoID'],
                        "responsabilidadID" => $fila['responsabilidadID'],
                        "tipo_aprobacion" => $fila['tipo_aprobacion'],

                        "soli_Pnombre" => $fila['soli_Pnombre'],
                        "soli_Snombre" => $fila['soli_Snombre'],
                        "soli_Papellido" => $fila['soli_Papellido'],
                        "soli_Sapellido" => $fila['soli_Sapellido'],
                        "soli_identidad" => $fila['soli_identidad'],
                        "soli_RTN" => $fila['soli_RTN'],
                        "soli_sexo" => $fila['soli_sexo'],
                        "soli_fechaNacimiento" => $fila['soli_fechaNacimiento'],
                        "soli_estadoCivil" => $fila['soli_estadoCivil'],
                        "soli_jefe" => $fila['soli_jefe'],
                        "soli_aniosTrabajo" => $fila['soli_aniosTrabajo'],


                        "fiador_Pnombre" => $fila['fiador_Pnombre'],
                        "fiador_Snombre" => $fila['fiador_Snombre'],
                        "fiador_Papellido" => $fila['fiador_Papellido'],
                        "fiador_Sapellido" => $fila['fiador_Sapellido'],
                        "fiador_identidad" => $fila['fiador_identidad'],
                        // "fiador_sexo" => $fila['fiador_sexo'],
                        "fiador_estadoCivil" => $fila['fiador_estadoCivil'],
                        // "fiador_fechaNacimiento" => $fila['fiador_fechaNacimiento'],
                        "fiador_empresa" => $fila['fiador_empresa'],

                        "monto_aprobado" => $fila['monto_aprobado'],
                        "plazo_aprobado" => $fila['plazo_aprobado'],
                        "cuota_nivelada" => $fila['cuota_nivelada'],
                        "tasa_interes" => $fila['tasa_interes'],
                        "descrpicion_garantia" => $fila['descrpicion_garantia'],
                        "RCI" => $fila['RCI'],
                        "TDI" => $fila['TDI'],
                        "confirmacion" => $fila['confirmacion'],
                        "comentario_analista" => $fila['comentario_analista']
                       

                    );
                    
                    $contadorIteracion++;
                }

            

             $a = array(
                "mensajeError" =>"exito",
                "bandera" => "1"
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
            $a = array(
                "mensajeError" => "Error : privilegios insuficientes...",
                "bandera" => 0
                );
            
            echo json_encode($a);
        }

        break;


        // -----------------------------------------------------------------------------------------------


        case 4: // EDITAR SOLICITUD
            if(true){ //validacion de roles
                $json = array();
                $msj ="";
                $bandera = 0;
                try{

                    $solicitudID = $_POST["solicitud_id"];
                    $card1_tipoSolicitud = $_POST["card1_tipoSolicitud"];
                    $card1_tipoPrestamo = $_POST["card1_tipoPrestamo"];
                    $card1_prestamoID = 0;
                    $card1_destino = $_POST["card1_destino"];
                    $card1_res = $_POST["card1_res"];
                    $card1_aval = $_POST["card1_aval"];
                    
                    $card2_Pnombre = $_POST["card2_Pnombre_sol"];
                    $card2_Snombre = $_POST["card2_Snombre_sol"];
                    $card2_Papellido = $_POST["card2_Papellido_sol"];
                    $card2_Sapellido = $_POST["card2_Sapellido_sol"];
                    $card2_identidad = $_POST["card2_identidad_sol"];
                    $card2_RTN_sol = $_POST["card2_RTN_sol"];
                    $card2_sexo = $_POST["card2_sexo"];
                    $card2_estadoCivil = $_POST["card2_estadoCivil"];
                    $card4_jefe = $_POST["card2_Jefe"];
                    $card4_tiempo = $_POST["card2_Tservicio"];
                    
                    $card6_Pnombre = $_POST["card3_Pnombre_fiador"];
                    $card6_Snombre = $_POST["card3_Snombre_fiador"];
                    $card6_Papellido = $_POST["card3_Papellido_fiador"];
                    $card6_Sapellido = $_POST["card3_Sapellido_fiador"];
                    $card6_identidad = $_POST["card3_identidad_fiador"];
                    $card6_empresa = $_POST["card3_nombre_empresa"];
                    
                    $card4_monto = $_POST["card4_monto"];
                    $card4_plazoap = $_POST["card4_plazoap"];
                    $card4_cuota = $_POST["card4_cuota"];
                    $card4_interes = $_POST["card4_interes"];
                    $card4_RCI = $_POST["card4_RCI"];
                    $card4_TDI = $_POST["card4_TDI"];
                    $card4_analista = $_POST["card4_analista"];
                    $card4_confirmacion = $_POST["card4_confirmacion"];
                    $card4_garantia = $_POST["card4_garantia"];
                    $card2_fechaNaci = $_POST["seleccionaAnyo"]."-".$_POST["seleccionaMes"]."-".$_POST["seleccionaDia"];
                   

                    $query = $db->prepare("CALL SP_EDITAR_CREDITOS (
                        ?,?,?,?,?,?,?,?,?,?,
                        ?,?,?,?,?,?,?,?,?,?,
                        ?,?,?,?,?,?,?,?,?,?,?,?,?, @codigoError, @mensajeError) ;");

                    $query->bindParam(1,$solicitudID, PDO::PARAM_INT);
                    $query->bindParam(2,$card1_tipoSolicitud, PDO::PARAM_INT);
                    $query->bindParam(3,$card1_tipoPrestamo, PDO::PARAM_INT);
                    $query->bindParam(4,$card1_prestamoID, PDO::PARAM_INT);
                    $query->bindParam(5,$card1_destino, PDO::PARAM_INT);
                    $query->bindParam(6,$card1_res, PDO::PARAM_INT);
                    $query->bindParam(7,$card1_aval, PDO::PARAM_INT);

                    $query->bindParam(8,$card2_Pnombre, PDO::PARAM_STR);
                    $query->bindParam(9,$card2_Snombre, PDO::PARAM_STR);
                    $query->bindParam(10,$card2_Papellido, PDO::PARAM_STR);
                    $query->bindParam(11,$card2_Sapellido, PDO::PARAM_STR);
                    $query->bindParam(12,$card2_identidad, PDO::PARAM_STR);
                    $query->bindParam(13,$card2_RTN_sol, PDO::PARAM_STR);
                    $query->bindParam(14,$card2_sexo, PDO::PARAM_STR);
                    $query->bindParam(15,$card2_estadoCivil, PDO::PARAM_INT);
                    $query->bindParam(16,$card4_jefe, PDO::PARAM_STR);
                    $query->bindParam(17,$card4_tiempo, PDO::PARAM_INT);
                    
                    $query->bindParam(18,$card6_Pnombre, PDO::PARAM_STR);
                    $query->bindParam(19,$card6_Snombre, PDO::PARAM_STR);
                    $query->bindParam(20,$card6_Papellido, PDO::PARAM_STR);
                    $query->bindParam(21,$card6_Sapellido, PDO::PARAM_STR);
                    $query->bindParam(22,$card6_identidad, PDO::PARAM_STR);
                    $query->bindParam(23,$card6_empresa, PDO::PARAM_STR);
                    
                    $query->bindParam(24,$card4_monto, PDO::PARAM_STR);
                    $query->bindParam(25,$card4_plazoap, PDO::PARAM_STR);
                    $query->bindParam(26,$card4_cuota, PDO::PARAM_STR);
                    $query->bindParam(27,$card4_interes, PDO::PARAM_STR);
                    $query->bindParam(28,$card4_RCI, PDO::PARAM_STR);
                    $query->bindParam(29,$card4_TDI, PDO::PARAM_STR);
                    $query->bindParam(30,$card4_analista, PDO::PARAM_STR);
                    $query->bindParam(31,$card4_confirmacion, PDO::PARAM_INT);
                    $query->bindParam(32,$card2_fechaNaci, PDO::PARAM_STR);
                    $query->bindParam(33,$card4_garantia, PDO::PARAM_STR);


                    $query->execute();

                    $output = $db->query("select @codigoError")->fetch(PDO::FETCH_ASSOC);
                    $bandera = $output['@codigoError']; 

                    $output = $db->query("select @mensajeError")->fetch(PDO::FETCH_ASSOC);
                    $mensaje = $output['@mensajeError'];
                    
                    
                    $json[0] = array(
                        "mensajeError" => $mensaje,
                        "bandera" => $bandera
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
                $a = array(
                    "mensajeError" => "Error : privilegios insuficientes...",
                    "bandera" => 0
                    );
                
                echo json_encode($a);
            }

            break;



        case 5: // obtiene los comentarios
                if(true){ //validacion de roles
                    $json = array();
                    $msj ="";
                    $bandera = 0;
                    try{
                        $solicitudID = $_POST["solicitudID"];
                        $query = $db->prepare("CALL SP_OBTENER_COMENTARIOS(?,@codigoError, @mensajeError);");
                        $query->bindParam(1, $solicitudID, PDO::PARAM_INT);
                        $query->execute();
                        $result = $query->fetchAll();

                        $contadorIteracion = 0;
                        foreach($result as $fila){ 
                            $json[$contadorIteracion] = array(
                                "modulo" =>$fila['modulo'],
                                "fecha" => $fila['fecha'],
                                "usuarioID" => $fila['usuarioID'],
                                "comentario" => $fila['comentario']
                                );

                            $contadorIteracion++;
                        }

                     // $output = $db->query("select @codigoError")->fetch(PDO::FETCH_ASSOC);
                     // $bandera = $output['@codigoError']; 

                     // $output = $db->query("select @mensajeError")->fetch(PDO::FETCH_ASSOC);
                     // $mensaje = $output['@mensajeError'];


                        $json[0] = array(
                           "mensajeError" => "Exito",
                           "bandera" => 1
                           );

                // array_unshift($json, $a ); 
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
                    $a = array(
                        "mensajeError" => "Error : privilegios insuficientes...",
                        "bandera" => 0
                        );

                    echo json_encode($a);
                }

                break;





    // -==============================================================================================

        default:
            break;


    }

    ?>

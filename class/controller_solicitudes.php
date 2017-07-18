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
        case 0: // inserta una nueva solicitud con todos sus datos (persona, prestamo)
            if(true){ //validacion de roles
                $json = array();
                $msj ="";
                $bandera = 0;
                try{
                    $card1_tipoSolicitud = $_POST["card1_tipoSolicitud"];
                    $card1_tipoPrestamo = $_POST["card1_tipoPrestamo"];

                    $card2_Pnombre = $_POST["card2_Pnombre"];
                    $card2_Snombre = $_POST["card2_Snombre"];
                    $card2_Papellido = $_POST["card2_Papellido"];
                    $card2_Sapellido = $_POST["card2_Sapellido"];
                    $card2_identidad = $_POST["card2_identidad"];
                    $card2_RTN = $_POST["card2_RTN"];
                    $card2_edad = 0;
                    $card2_sexo = $_POST["card2_sexo"];
                    $card2_tipoVivienda = $_POST["card2_tipoVivienda"];
                    $card2_pagoVivienda = $_POST["card2_pagoVivienda"];

                    $card2_fechaNacimiento = $_POST["card2_naciAnio"]."-".$_POST["card2_naciMes"]."-".$_POST["card2_naciDia"];
                    $card2_lugarNaci = $_POST["card2_lugarNaci"];
                    $card2_direccion = $_POST["card2_direccion"];
                    $card2_nacionalidad = $_POST["card2_nacionalidad"];
                    $card2_residencia = $_POST["card2_residencia"];
                    $card2_ocupacion = $_POST["card2_ocupacion"];
                    $card2_email = $_POST["card2_email"];
                    $card2_tel = $_POST["card2_tel"];
                    $card2_cel = $_POST["card2_cel"];
                    $card2_estadoCivil = $_POST["card2_estadoCivil"];
                    $card2_dependientes = $_POST["card2_dependientes"];
                    $card2_hijos = $_POST["card2_hijos"];
                    
                    $card3_cant = $_POST["card3_cant"];
                    $card3_plazo = $_POST["card3_plazo"];
                    $card3_destino = $_POST["card3_destino"];
                    
                    $card4_empresa = $_POST["card4_empresa"];
                    $card4_sueldo = $_POST["card4_sueldo"];
                    $card4_tiempo = $_POST["card4_tiempo"];
                    $card4_cargo = $_POST["card4_cargo"];
                    $card4_otroIngreso = $_POST["card4_otroIngreso"];
                    $card4_direccion = $_POST["card4_direccion"];
                    $card4_telefono = $_POST["card4_telefono"];
                    $card4_telefonoExt = $_POST["card4_telefonoExt"];
                    $card4_jefe = $_POST["card4_jefe"];
                    $card4_selectActividad = $_POST["card4_selectActividad"];
                   
                    $card5_Pnombre = $_POST["card5_Pnombre"];
                    $card5_Snombre = $_POST["card5_Snombre"];
                    $card5_Papellido = $_POST["card5_Papellido"];
                    $card5_Sapellido = $_POST["card5_Sapellido"];
                    $card5_identidad = $_POST["card5_identidad"];
                    $card5_fechaNacimiento = $_POST["card5_naciAnio"]."-".$_POST["card5_naciMes"]."-".$_POST["card5_naciDia"];
                    $card5_profesion = $_POST["card5_profesion"];
                    $card5_ingresoMensual = $_POST["card5_ingresoMensual"];
                    $card5_lugarLabor = $_POST["card5_lugarLabor"];
                    $card5_cargo = $_POST["card5_cargo"];
                    $card5_tel = $_POST["card5_tel"];
                    $card5_cel = $_POST["card5_cel"];
                    $card5_tipoVivienda = $_POST["card5_tipoVivienda"];
                    $card5_pagoVivienda = $_POST["card5_pagoVivienda"];

                    //nuevos campos conyugue
                    $card5_empresaTel = $_POST["card5_telefono"];
                    $card5_empresaExt = $_POST["card5_telefonoExt"];
                     
                    if($card5_tipoVivienda == "-1"){
                        $card5_tipoVivienda = null;
                    }

                    $card6_Pnombre = $_POST["card6_Pnombre"];
                    $card6_Snombre = $_POST["card6_Snombre"];
                    $card6_Papellido = $_POST["card6_Papellido"];
                    $card6_Sapellido = $_POST["card6_Sapellido"];
                    $card6_identidad = $_POST["card6_identidad"];
                    $card6_residencia = $_POST["card6_residencia"];
                    $card6_direccion = $_POST["card6_direccion"];

                    $card6_tel = $_POST["card6_tel"];
                    $card6_cel = $_POST["card6_cel"];
                    $card6_email = $_POST["card6_email"];
                    $card6_estadoCivil = $_POST["card6_estadoCivil"];
                    $card6_dependientes = $_POST["card6_dependientes"];
                    $card6_empresa = $_POST["card6_empresa"];
                    $card6_posicion = $_POST["card6_posicion"];
                    $card6_tiempoServicio = $_POST["card6_tiempoServicio"];
                    $card6_sueldoMensual = $_POST["card6_sueldoMensual"];
                    $card6_otrosIngresos = $_POST["card6_otrosIngresos"];
                    $card6_empresaTel = $_POST["card6_empresaTel"];
                    $card6_empresaExt = $_POST["card6_empresaExt"];
                    $card6_jefe = $_POST["card6_jefe"];
                    $card6_selectActividad = $_POST["card6_selectActividad"];

                     //nuevos campos en fiador
                    $card6_sexo = $_POST["card6_sexo"];
                    $card6_tipoVivienda = $_POST["card6_tipoVivienda"];
                    $card6_hijos = $_POST["card6_hijos"];
                    $card6_empresaDireccion = $_POST["card6_empresaDireccion"];

                    $card7_nombre = $_POST["card7_nombre"];
                    $card7_tel = $_POST["card7_tel"];
                    $card7_trabajo = $_POST["card7_trabajo"];
                    $card7_parentesco = $_POST["card7_parentesco"];
                    $card7_nombre2 = $_POST["card7_nombre2"];
                    $card7_tel2 = $_POST["card7_tel2"];
                    $card7_trabajo2 = $_POST["card7_trabajo2"];
                    $card7_parentesco2 = $_POST["card7_parentesco2"];

                    $card8_nombre = $_POST["card8_nombre"];
                    $card8_tel = $_POST["card8_tel"];
                    $card8_trabajo = $_POST["card8_trabajo"];
                    $card8_parentesco = $_POST["card8_parentesco"];


                    $query = $db->prepare("CALL SP_CREAR_SOLICITUD(
                         ?,?,?,?,?,?,?,?,?,?
                        ,?,?,?,?,?,?,?,?
                        ,?,?,?,?,?,?,?,?,?,?
                        ,?,?,?,?,?,?,?,?,?,?
                        ,?,?,?,?,?,?,?,?,?,?,?,?
                        ,?,?,?,?,?,?,?,?,?,?,?
                        ,?,?,?,?,?,?,?,?,?,?
                        ,?,?,?,?,?,?,?,?,?,?,?,?,?,?,
                        ?,?,?,?,?,?,
                        @mensajeError,@codigoError)");

                    $query->bindParam(1,$card1_tipoSolicitud, PDO::PARAM_INT);
                    $query->bindParam(2,$card1_tipoPrestamo, PDO::PARAM_INT);
                    $query->bindParam(3,$card2_Pnombre, PDO::PARAM_STR);
                    $query->bindParam(4,$card2_Snombre, PDO::PARAM_STR);
                    $query->bindParam(5,$card2_Papellido, PDO::PARAM_STR);
                    $query->bindParam(6,$card2_Sapellido, PDO::PARAM_STR);
                    $query->bindParam(7,$card2_identidad, PDO::PARAM_STR);
                    $query->bindParam(8,$card2_RTN, PDO::PARAM_STR);
                    $query->bindParam(9,$card2_edad, PDO::PARAM_INT);
                    $query->bindParam(10,$card2_sexo, PDO::PARAM_STR);
                    $query->bindParam(11,$card2_tipoVivienda, PDO::PARAM_INT);
                    $query->bindParam(12,$card2_pagoVivienda, PDO::PARAM_STR);
                    $query->bindParam(13,$card2_fechaNacimiento, PDO::PARAM_STR);
                    $query->bindParam(14,$card2_lugarNaci, PDO::PARAM_STR);
                    $query->bindParam(15,$card2_direccion, PDO::PARAM_STR);
                    $query->bindParam(16,$card2_nacionalidad, PDO::PARAM_STR);
                    $query->bindParam(17,$card2_residencia, PDO::PARAM_STR);
                    $query->bindParam(18,$card2_ocupacion, PDO::PARAM_STR);
                    $query->bindParam(19,$card2_email, PDO::PARAM_STR);
                    $query->bindParam(20,$card2_tel, PDO::PARAM_STR);
                    $query->bindParam(21,$card2_cel, PDO::PARAM_STR);
                    $query->bindParam(22,$card2_estadoCivil, PDO::PARAM_INT);
                    $query->bindParam(23,$card2_dependientes, PDO::PARAM_INT);
                    $query->bindParam(24,$card2_hijos, PDO::PARAM_INT);

                    $query->bindParam(25,$card3_cant, PDO::PARAM_STR);
                    $query->bindParam(26,$card3_plazo, PDO::PARAM_STR);
                    $query->bindParam(27,$card3_destino, PDO::PARAM_INT);
                    $query->bindParam(28,$card4_empresa, PDO::PARAM_STR);
                    $query->bindParam(29,$card4_sueldo, PDO::PARAM_STR);
                    $query->bindParam(30,$card4_tiempo, PDO::PARAM_INT);
                    $query->bindParam(31,$card4_cargo, PDO::PARAM_STR);
                    $query->bindParam(32,$card4_otroIngreso, PDO::PARAM_STR);
                    $query->bindParam(33,$card4_direccion, PDO::PARAM_STR);
                    $query->bindParam(34,$card4_telefono, PDO::PARAM_STR);
                    $query->bindParam(35,$card4_telefonoExt, PDO::PARAM_STR);
                    $query->bindParam(36,$card4_jefe, PDO::PARAM_STR);
                    $query->bindParam(37,$card4_selectActividad, PDO::PARAM_INT);

                    $query->bindParam(38,$card5_Pnombre, PDO::PARAM_STR);
                    $query->bindParam(39,$card5_Snombre, PDO::PARAM_STR);
                    $query->bindParam(40,$card5_Papellido, PDO::PARAM_STR);
                    $query->bindParam(41,$card5_Sapellido, PDO::PARAM_STR);
                    $query->bindParam(42,$card5_identidad, PDO::PARAM_STR);
                    $query->bindParam(43,$card5_fechaNacimiento, PDO::PARAM_STR);
                    $query->bindParam(44,$card5_profesion, PDO::PARAM_STR);
                    $query->bindParam(45,$card5_ingresoMensual, PDO::PARAM_STR);
                    $query->bindParam(46,$card5_lugarLabor, PDO::PARAM_STR);
                    $query->bindParam(47,$card5_cargo, PDO::PARAM_STR);
                    $query->bindParam(48,$card5_tel, PDO::PARAM_STR);
                    $query->bindParam(49,$card5_cel, PDO::PARAM_STR);
                    $query->bindParam(50,$card5_tipoVivienda, PDO::PARAM_INT);
                    $query->bindParam(51,$card5_pagoVivienda, PDO::PARAM_STR);

                    $query->bindParam(52,$card6_Pnombre, PDO::PARAM_STR);
                    $query->bindParam(53,$card6_Snombre, PDO::PARAM_STR);
                    $query->bindParam(54,$card6_Papellido, PDO::PARAM_STR);
                    $query->bindParam(55,$card6_Sapellido, PDO::PARAM_STR);
                    $query->bindParam(56,$card6_identidad, PDO::PARAM_STR);
                    $query->bindParam(57,$card6_residencia, PDO::PARAM_STR);
                    $query->bindParam(58,$card6_direccion, PDO::PARAM_STR);
                    $query->bindParam(59,$card6_tel, PDO::PARAM_STR);
                    $query->bindParam(60,$card6_cel, PDO::PARAM_STR);
                    $query->bindParam(61,$card6_email, PDO::PARAM_STR);
                    $query->bindParam(62,$card6_estadoCivil, PDO::PARAM_INT);
                    $query->bindParam(63,$card6_dependientes, PDO::PARAM_INT);
                    $query->bindParam(64,$card6_empresa, PDO::PARAM_STR);
                    $query->bindParam(65,$card6_posicion, PDO::PARAM_STR);
                    $query->bindParam(66,$card6_tiempoServicio, PDO::PARAM_INT);
                    $query->bindParam(67,$card6_sueldoMensual, PDO::PARAM_STR);
                    $query->bindParam(68,$card6_otrosIngresos, PDO::PARAM_STR);
                    $query->bindParam(69,$card6_empresaTel, PDO::PARAM_STR);
                    $query->bindParam(70,$card6_empresaExt, PDO::PARAM_STR);
                    $query->bindParam(71,$card6_jefe, PDO::PARAM_STR);
                    $query->bindParam(72,$card6_selectActividad, PDO::PARAM_INT);

                    $query->bindParam(73,$card7_nombre, PDO::PARAM_STR);
                    $query->bindParam(74,$card7_tel, PDO::PARAM_STR);
                    $query->bindParam(75,$card7_trabajo, PDO::PARAM_STR);
                    $query->bindParam(76,$card7_parentesco, PDO::PARAM_STR);
                    $query->bindParam(77,$card7_nombre2, PDO::PARAM_STR);
                    $query->bindParam(78,$card7_tel2, PDO::PARAM_STR);
                    $query->bindParam(79,$card7_trabajo2, PDO::PARAM_STR);
                    $query->bindParam(80,$card7_parentesco2, PDO::PARAM_STR);
                    $query->bindParam(81,$card8_nombre, PDO::PARAM_STR);
                    $query->bindParam(82,$card8_tel, PDO::PARAM_STR);
                    $query->bindParam(83,$card8_trabajo, PDO::PARAM_STR);
                    $query->bindParam(84,$card8_parentesco, PDO::PARAM_STR);

                    $query->bindParam(85,$card5_empresaTel, PDO::PARAM_STR);
                    $query->bindParam(86,$card5_empresaExt, PDO::PARAM_STR);
                    $query->bindParam(87,$card6_sexo, PDO::PARAM_STR);
                    $query->bindParam(88,$card6_tipoVivienda, PDO::PARAM_INT);
                    $query->bindParam(89,$card6_hijos, PDO::PARAM_INT);
                    $query->bindParam(90,$card6_empresaDireccion, PDO::PARAM_STR);

                    $query->bindParam(91,$usuarioID, PDO::PARAM_INT);

                    $query->execute();

                    $output = $db->query("select @mensajeError")->fetch(PDO::FETCH_ASSOC);
                    $mensaje = $output['@mensajeError'];
                    
                    $output = $db->query("select @codigoError")->fetch(PDO::FETCH_ASSOC);
                    $bandera = $output['@codigoError']; 

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

        case 1: //  obtiene todas las solicitudes.
            if(true){ //validacion de roles
                $json = array();
                $msj ="";
                $bandera = 0;
                try{
                    $query = $db->prepare("CALL SP_TRAER_SOLICITUDES(@mensajeError,@codigoError)");
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
                    $nuevoEstado = 2;

                    $query = $db->prepare("CALL SP_ENVIAR_SOLICITUD(?,?,?,?, @mensajeError,@codigoError)");
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
                        $query = $db->prepare("CALL SP_OBTENER_SOLICITUD(@codigoError, @mensajeError,?);");
                        $query->bindParam(1, $solicitudID, PDO::PARAM_INT);
                        $query->execute();
                        $result = $query->fetchAll();

                        $contadorIteracion = 0;
                        foreach($result as $fila){ 
                            $json[$contadorIteracion] = array(
                                "tipoSolicitudID" =>$fila['tipoSolicitudID'],
                                "tipoPrestamoID" => $fila['tipoPrestamoID'],

                                "soli_identidad" => $fila['soli_identidad'],
                                "soli_Pnombre" => $fila['soli_Pnombre'],
                                "soli_Snombre" => $fila['soli_Snombre'],
                                "soli_Papellido" => $fila['soli_Papellido'],
                                "soli_Sapellido" => $fila['soli_Sapellido'],
                                "soli_RTN" => $fila['soli_RTN'],
                                "soli_sexo" => $fila['soli_sexo'],
                                "soli_tipoViviendaID" => $fila['soli_tipoViviendaID'],
                                "soli_pagoVivienda" => $fila['soli_pagoVivienda'],

                                "soli_fechaNacimiento" => $fila['soli_fechaNacimiento'],
                                "soli_lugarNaci" => $fila['soli_lugarNaci'],
                                "soli_direccion" => $fila['soli_direccion'],
                                "soli_nacionalidad" => $fila['soli_nacionalidad'],
                                "soli_residencia" => $fila['soli_residencia'],
                                "soli_ocupacion" => $fila['soli_ocupacion'],

                                "soli_email" => $fila['soli_email'],
                                "soli_tel" => $fila['soli_tel'],
                                "soli_cel" => $fila['soli_cel'],
                                

                                "soli_dependientes" => $fila['soli_dependientes'],
                                "soli_hijos" => $fila['soli_hijos'],
                                "soli_estadoCivil" => $fila['soli_estadoCivil'],
                  
                                "cantSolicitada" => $fila['cantSolicitada'],
                                "plazo" => $fila['plazo'],
                                "destino" => $fila['destinoID'],

                                "soli_empresa" => $fila['soli_empresa'],
                                "soli_posicion" => $fila['soli_posicion'],
                                "soli_aniosTrabajo" => $fila['soli_aniosTrabajo'],
                                "soli_sueldo" => $fila['soli_sueldo'],
                                "soli_jefe" => $fila['soli_jefe'],
                                "soli_otrosIngresos" => $fila['soli_otrosIngresos'],
                                "soli_empresaTel" => $fila['soli_empresaTel'],
                                "soli_empresaExt" => $fila['soli_empresaExt'],
                                "soli_actividadEmpresa" => $fila['soli_actividadEmpresa'],
                                "soli_empresaDireccion" => $fila['soli_empresaDireccion'],
                                
                               
                                "conyu_Pnombre" => $fila['conyu_Pnombre'],
                                "conyu_Snombre" => $fila['conyu_Snombre'],
                                "conyu_Papellido" => $fila['conyu_Papellido'],
                                "conyu_Sapellido" => $fila['conyu_Sapellido'],
                                "conyu_identidad" => $fila['conyu_identidad'],
                                "conyu_fechaNacimiento" => $fila['conyu_fechaNacimiento'],
                                "conyu_ocupacion" => $fila['conyu_ocupacion'],
                                "conyu_tipoVivienda" => $fila['conyu_tipoVivienda'],
                                "conyu_pagoVivienda" => $fila['conyu_pagoVivienda'],
                                
                                "conyu_tel" => $fila['conyu_tel'],
                                "conyu_cel" => $fila['conyu_cel'],
                               
                                "conyu_empresa" => $fila['conyu_empresa'],
                                "conyu_sueldo" => $fila['conyu_sueldo'],
                                "conyu_cargo" => $fila['conyu_cargo'],
                                "conyu_empresaTel" => $fila['conyu_empresaTel'],
                                "conyu_empresaExt" => $fila['conyu_empresaExt'],
                                
                                "fiador_Pnombre" => $fila['fiador_Pnombre'],
                                "fiador_Snombre" => $fila['fiador_Snombre'],
                                "fiador_Papellido" => $fila['fiador_Papellido'],
                                "fiador_Sapellido" => $fila['fiador_Sapellido'],
                                "fiador_identidad" => $fila['fiador_identidad'],
                                "fiador_direccion" => $fila['fiador_direccion'],
                                "fiador_residencia" => $fila['fiador_residencia'],
                                "fiador_estadoCivil" => $fila['fiador_estadoCivil'],
                                "fiador_dependientes" => $fila['fiador_dependientes'],
                                "fiador_sexo" => $fila['fiador_sexo'],
                                "fiador_hijos" => $fila['fiador_hijos'],
                                "fiador_tipoVivienda" => $fila['fiador_tipoVivienda'],

                               
                                "fiador_telefono" => $fila['fiador_telefono'],
                                "fiador_cel" => $fila['fiador_cel'],
                                "fiador_email" => $fila['fiador_email'],

                                "fiador_empresa" => $fila['fiador_empresa'],
                                "fiador_posicion" => $fila['fiador_posicion'],
                                "fiador_aniosTrabajo" => $fila['fiador_aniosTrabajo'],
                                "fiador_sueldo" => $fila['fiador_sueldo'],
                                "fiador_otrosIngresos" => $fila['fiador_otrosIngresos'],
                                "fiador_empresaTel" => $fila['fiador_empresaTel'],
                                "fiador_empresaExt" => $fila['fiador_empresaExt'],
                                "fiador_jefe" => $fila['fiador_jefe'],
                                "fiador_ActividadEmpresa" => $fila['fiador_ActividadEmpresa'],
                                "fiador_empresaDireccion" => $fila['fiador_empresaDireccion']
                             
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
                        $card2_Pnombre = $_POST["card2_Pnombre"];
                        $card2_Snombre = $_POST["card2_Snombre"];
                        $card2_Papellido = $_POST["card2_Papellido"];
                        $card2_Sapellido = $_POST["card2_Sapellido"];
                        $card2_identidad = $_POST["card2_identidad"];
                        $card2_RTN = $_POST["card2_RTN"];
                        $card2_sexo = $_POST["card2_sexo"];
                        $card2_estadoCivil = $_POST["card2_estadoCivil"];
                        $card2_tipoVivienda = $_POST["card2_tipoVivienda"];
                        $card2_pagoVivienda = $_POST["card2_pagoVivienda"];
                        
                        $card2_fechaNacimiento = $_POST["card2_naciAnio"]."-".$_POST["card2_naciMes"]."-".$_POST["card2_naciDia"];
                        $card2_lugarNaci = $_POST["card2_lugarNaci"];
                        $card2_direccion = $_POST["card2_direccion"];
                        $card2_nacionalidad = $_POST["card2_nacionalidad"];
                        $card2_residencia = $_POST["card2_residencia"];
                        $card2_ocupacion = $_POST["card2_ocupacion"];
                        $card2_email = $_POST["card2_email"];
                        $card2_tel = $_POST["card2_tel"];
                        $card2_cel = $_POST["card2_cel"];
                        $card2_dependientes = $_POST["card2_dependientes"];
                        $card2_hijos = $_POST["card2_hijos"];
                       
                        $card3_cant = $_POST["card3_cant"];
                        $card3_plazo = $_POST["card3_plazo"];
                        $card3_destino = $_POST["card3_destino"];

                        $card4_empresa = $_POST["card4_empresa"];
                        $card4_sueldo = $_POST["card4_sueldo"];
                        $card4_tiempo = $_POST["card4_tiempo"];
                        $card4_cargo = $_POST["card4_cargo"];
                        $card4_otroIngreso = $_POST["card4_otroIngreso"];
                        $card4_direccion = $_POST["card4_direccion"];
                        $card4_telefono = $_POST["card4_telefono"];
                        $card4_telefonoExt = $_POST["card4_telefonoExt"];
                        $card4_jefe = $_POST["card4_jefe"];
                        $card4_selectActividad = $_POST["card4_selectActividad"];

                        $card5_Pnombre = $_POST["card5_Pnombre"];
                        $card5_Snombre = $_POST["card5_Snombre"];
                        $card5_Papellido = $_POST["card5_Papellido"];
                        $card5_Sapellido = $_POST["card5_Sapellido"];
                        $card5_identidad = $_POST["card5_identidad"];
                        $card5_fechaNacimiento = $_POST["card5_naciAnio"]."-".$_POST["card5_naciMes"]."-".$_POST["card5_naciDia"];
                        $card5_profesion = $_POST["card5_profesion"];
                        $card5_ingresoMensual = $_POST["card5_ingresoMensual"];
                        $card5_lugarLabor = $_POST["card5_lugarLabor"];
                        $card5_cargo = $_POST["card5_cargo"];
                        $card5_tel = $_POST["card5_tel"];
                        $card5_cel = $_POST["card5_cel"];

                        //nuevas mejoras
                        $card5_empresaTel = $_POST["card5_telefono"];
                        $card5_empresaExt = $_POST["card5_telefonoExt"];


                        $card5_tipoVivienda = $_POST["card5_tipoVivienda"];
                        $card5_pagoVivienda = $_POST["card5_pagoVivienda"];
                        $card6_Pnombre = $_POST["card6_Pnombre"];
                        $card6_Snombre = $_POST["card6_Snombre"];
                        $card6_Papellido = $_POST["card6_Papellido"];
                        $card6_Sapellido = $_POST["card6_Sapellido"];
                        $card6_identidad = $_POST["card6_identidad"];
                        $card6_residencia = $_POST["card6_residencia"];
                        $card6_direccion = $_POST["card6_direccion"];
                        $card6_tel = $_POST["card6_tel"];
                        $card6_cel = $_POST["card6_cel"];
                        $card6_email = $_POST["card6_email"];
                        $card6_estadoCivil = $_POST["card6_estadoCivil"];
                        
                        //nuevos campos en fiador
                        $card6_sexo = $_POST["card6_sexo"];
                        $card6_tipoVivienda = $_POST["card6_tipoVivienda"];
                        $card6_hijos = $_POST["card6_hijos"];
                        $card6_empresaDireccion = $_POST["card6_empresaDireccion"];


                        
                        $card6_dependientes = $_POST["card6_dependientes"];
                        $card6_empresa = $_POST["card6_empresa"];
                        $card6_posicion = $_POST["card6_posicion"];
                        $card6_tiempoServicio = $_POST["card6_tiempoServicio"];
                        $card6_sueldoMensual = $_POST["card6_sueldoMensual"];
                        $card6_otrosIngresos = $_POST["card6_otrosIngresos"];
                        $card6_empresaTel = $_POST["card6_empresaTel"];
                        $card6_empresaExt = $_POST["card6_empresaExt"];
                        
                        $card6_jefe = $_POST["card6_jefe"];
                        $card6_selectActividad = $_POST["card6_selectActividad"];

                        $card7_nombre = $_POST["card7_nombre"];
                        $card7_tel = $_POST["card7_tel"];
                        $card7_trabajo = $_POST["card7_trabajo"];
                        $card7_parentesco = $_POST["card7_parentesco"];
                        $card7_nombre2 = $_POST["card7_nombre2"];
                        $card7_tel2 = $_POST["card7_tel2"];
                        $card7_trabajo2 = $_POST["card7_trabajo2"];
                        $card7_parentesco2 = $_POST["card7_parentesco2"];

                        $card8_nombre = $_POST["card8_nombre"];
                        $card8_tel = $_POST["card8_tel"];
                        $card8_trabajo = $_POST["card8_trabajo"];
                        $card8_parentesco = $_POST["card8_parentesco"];

                        $query = $db->prepare("CALL SP_EDITAR_SOLICITUD (
                            ?,?,?,?,?,?,?,?,?,?,
                            ?,?,?,?,?,?,?,?,?,?,
                            ?,?,?,?,?,?,?,?,?,?,
                            ?,?,?,?,?,?,?,?,?,?,
                            ?,?,?,?,?,?,?,?,?,?,
                            ?,?,?,?,?,?,?,?,?,?,
                            ?,?,?,?,?,?,?,?,?,?,
                            ?,?,?,?,?,?,?,?,?,?,
                            ?,?,?,?,?, ?,?,?,?,?,?,
                             @codigoError, @mensajeError) ;");
                        $query->bindParam(1,$solicitudID, PDO::PARAM_INT);
                        $query->bindParam(2,$card1_tipoSolicitud, PDO::PARAM_INT);
                        $query->bindParam(3,$card1_tipoPrestamo, PDO::PARAM_INT);
                        $query->bindParam(4,$card2_Pnombre, PDO::PARAM_STR);
                        $query->bindParam(5,$card2_Snombre, PDO::PARAM_STR);
                        $query->bindParam(6,$card2_Papellido, PDO::PARAM_STR);
                        $query->bindParam(7,$card2_Sapellido, PDO::PARAM_STR);
                        $query->bindParam(8,$card2_identidad, PDO::PARAM_STR);
                        $query->bindParam(9,$card2_RTN, PDO::PARAM_STR);
                        $query->bindParam(10,$card2_sexo, PDO::PARAM_STR);
                        $query->bindParam(11,$card2_tipoVivienda, PDO::PARAM_INT);
                        $query->bindParam(12,$card2_pagoVivienda, PDO::PARAM_STR);
                        $query->bindParam(13,$card2_fechaNacimiento, PDO::PARAM_STR);
                        $query->bindParam(14,$card2_lugarNaci, PDO::PARAM_STR);
                        $query->bindParam(15,$card2_direccion, PDO::PARAM_STR);
                        $query->bindParam(16,$card2_nacionalidad, PDO::PARAM_STR);
                        $query->bindParam(17,$card2_residencia, PDO::PARAM_STR);
                        $query->bindParam(18,$card2_ocupacion, PDO::PARAM_STR);
                        $query->bindParam(19,$card2_email, PDO::PARAM_STR);
                        $query->bindParam(20,$card2_tel, PDO::PARAM_STR);
                        $query->bindParam(21,$card2_cel, PDO::PARAM_STR);
                        $query->bindParam(22,$card2_estadoCivil, PDO::PARAM_INT);
                        $query->bindParam(23,$card2_dependientes, PDO::PARAM_INT);
                        $query->bindParam(24,$card2_hijos, PDO::PARAM_INT);

                        $query->bindParam(25,$card3_cant, PDO::PARAM_STR);
                        $query->bindParam(26,$card3_plazo, PDO::PARAM_INT);
                        $query->bindParam(27,$card3_destino, PDO::PARAM_INT);
                        $query->bindParam(28,$card4_empresa, PDO::PARAM_STR);
                        $query->bindParam(29,$card4_sueldo, PDO::PARAM_STR);
                        $query->bindParam(30,$card4_tiempo, PDO::PARAM_INT);
                        $query->bindParam(31,$card4_cargo, PDO::PARAM_STR);
                        $query->bindParam(32,$card4_otroIngreso, PDO::PARAM_STR);
                        $query->bindParam(33,$card4_direccion, PDO::PARAM_STR);
                        $query->bindParam(34,$card4_telefono, PDO::PARAM_STR);
                        $query->bindParam(35,$card4_telefonoExt, PDO::PARAM_STR);
                        $query->bindParam(36,$card4_jefe, PDO::PARAM_STR);
                        $query->bindParam(37,$card4_selectActividad, PDO::PARAM_INT);
                        $query->bindParam(38,$card5_Pnombre, PDO::PARAM_STR);
                        $query->bindParam(39,$card5_Snombre, PDO::PARAM_STR);
                        $query->bindParam(40,$card5_Papellido, PDO::PARAM_STR);
                        $query->bindParam(41,$card5_Sapellido, PDO::PARAM_STR);
                        $query->bindParam(42,$card5_identidad, PDO::PARAM_STR);
                        $query->bindParam(43,$card5_fechaNacimiento, PDO::PARAM_STR);
                        $query->bindParam(44,$card5_profesion, PDO::PARAM_STR);
                        $query->bindParam(45,$card5_ingresoMensual, PDO::PARAM_STR);
                        $query->bindParam(46,$card5_lugarLabor, PDO::PARAM_STR);
                        $query->bindParam(47,$card5_cargo, PDO::PARAM_STR);
                        $query->bindParam(48,$card5_tel, PDO::PARAM_STR);
                        $query->bindParam(49,$card5_cel, PDO::PARAM_STR);
                        $query->bindParam(50,$card5_tipoVivienda, PDO::PARAM_INT);
                        $query->bindParam(51,$card5_pagoVivienda, PDO::PARAM_STR);

                        $query->bindParam(52,$card6_Pnombre, PDO::PARAM_STR);
                        $query->bindParam(53,$card6_Snombre, PDO::PARAM_STR);
                        $query->bindParam(54,$card6_Papellido, PDO::PARAM_STR);
                        $query->bindParam(55,$card6_Sapellido, PDO::PARAM_STR);
                        $query->bindParam(56,$card6_identidad, PDO::PARAM_STR);
                        $query->bindParam(57,$card6_residencia, PDO::PARAM_STR);
                        $query->bindParam(58,$card6_direccion, PDO::PARAM_STR);
                        $query->bindParam(59,$card6_tel, PDO::PARAM_STR);
                        $query->bindParam(60,$card6_cel, PDO::PARAM_STR);
                        $query->bindParam(61,$card6_email, PDO::PARAM_STR);
                        $query->bindParam(62,$card6_estadoCivil, PDO::PARAM_INT);
                        $query->bindParam(63,$card6_dependientes, PDO::PARAM_INT);
                        $query->bindParam(64,$card6_empresa, PDO::PARAM_STR);
                        $query->bindParam(65,$card6_posicion, PDO::PARAM_STR);
                        $query->bindParam(66,$card6_tiempoServicio, PDO::PARAM_INT);
                        $query->bindParam(67,$card6_sueldoMensual, PDO::PARAM_STR);
                        $query->bindParam(68,$card6_otrosIngresos, PDO::PARAM_STR);
                        $query->bindParam(69,$card6_empresaTel, PDO::PARAM_STR);
                        $query->bindParam(70,$card6_empresaExt, PDO::PARAM_STR);
                        $query->bindParam(71,$card6_jefe, PDO::PARAM_STR);
                        $query->bindParam(72,$card6_selectActividad, PDO::PARAM_INT);
                        $query->bindParam(73,$card7_nombre, PDO::PARAM_STR);
                        $query->bindParam(74,$card7_tel, PDO::PARAM_STR);
                        $query->bindParam(75,$card7_trabajo, PDO::PARAM_STR);
                        $query->bindParam(76,$card7_parentesco, PDO::PARAM_STR);
                        $query->bindParam(77,$card7_nombre2, PDO::PARAM_STR);
                        $query->bindParam(78,$card7_tel2, PDO::PARAM_STR);
                        $query->bindParam(79,$card7_trabajo2, PDO::PARAM_STR);
                        $query->bindParam(80,$card7_parentesco2, PDO::PARAM_STR);
                        $query->bindParam(81,$card8_nombre, PDO::PARAM_STR);
                        $query->bindParam(82,$card8_tel, PDO::PARAM_STR);
                        $query->bindParam(83,$card8_trabajo, PDO::PARAM_STR);
                        $query->bindParam(84,$card8_parentesco, PDO::PARAM_STR);


                        $query->bindParam(85,$card5_empresaTel, PDO::PARAM_STR);
                        $query->bindParam(86,$card5_empresaExt, PDO::PARAM_STR);
                        $query->bindParam(87,$card6_sexo, PDO::PARAM_STR);
                        $query->bindParam(88,$card6_tipoVivienda, PDO::PARAM_INT);
                        $query->bindParam(89,$card6_hijos, PDO::PARAM_INT);
                        $query->bindParam(90,$card6_empresaDireccion, PDO::PARAM_STR);
                        
                        $query->bindParam(91,$usuarioID, PDO::PARAM_INT);
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

            case 5: //  trae las referencias para una solicitud especifica.
                if(true){ //validacion de roles
                    $json = array();
                    $msj ="";
                    $bandera = 0;
                    try{
                        $solicitudID = $_POST["solicitudID"];
                        $query = $db->prepare("CALL SP_OBTENER_REFERENCIAS(@codigoError, @mensajeError,?);");
                        $query->bindParam(1, $solicitudID, PDO::PARAM_INT);
                        $query->execute();
                        $result = $query->fetchAll();

                        $contadorIteracion = 0;
                        foreach($result as $fila){ 
                            $json[$contadorIteracion] = array(
                                "nombre_completo" =>$fila['nombre_completo'],
                                "telefono_residencia" => $fila['telefono_residencia'],
                                "trabajo" => $fila['trabajo'],
                                "parentesco" => $fila['parentesco']
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


            case 6: // obtiene los comentarios
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

            // -----------------------------------------------------------------------------------------------

            default:
                break;


        }

        ?>

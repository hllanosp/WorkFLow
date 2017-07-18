-- phpMyAdmin SQL Dump
-- version 4.6.5.2
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 18-07-2017 a las 08:10:23
-- Versión del servidor: 10.1.21-MariaDB
-- Versión de PHP: 5.6.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `workflow`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`cpses_hid8rg6wxh`@`localhost`  PROCEDURE `SP_CREAR_SOLICITUD` (IN `card1_tipoSolicitud` INT, IN `card1_tipoPrestamo` INT, IN `card2_Pnombre` VARCHAR(30), IN `card2_Snombre` VARCHAR(30), IN `card2_Papellido` VARCHAR(30), IN `card2_Sapellido` VARCHAR(30), IN `card2_identidad` VARCHAR(13), IN `card2_RTN` VARCHAR(14), IN `card2_edad` INT, IN `card2_sexo` CHAR(1), IN `card2_tipoVivienda` INT, IN `card2_pagoVivienda` DOUBLE, IN `card2_fechaNacimiento` VARCHAR(10), IN `card2_lugarNaci` VARCHAR(100), IN `card2_direccion` VARCHAR(100), IN `card2_nacionalidad` VARCHAR(50), IN `card2_residencia` VARCHAR(100), IN `card2_ocupacion` VARCHAR(100), IN `card2_email` VARCHAR(100), IN `card2_tel` VARCHAR(15), IN `card2_cel` VARCHAR(15), IN `card2_estadoCivil` INT, IN `card2_dependientes` INT, IN `card2_hijos` INT, IN `card3_cant` DOUBLE, IN `card3_plazo` INT, IN `card3_destino` INT(11), IN `card4_empresa` VARCHAR(50), IN `card4_sueldo` DOUBLE, IN `card4_tiempo` INT, IN `card4_cargo` VARCHAR(100), IN `card4_otroIngreso` VARCHAR(100), IN `card4_direccion` VARCHAR(100), IN `card4_telefono` VARCHAR(36), IN `card4_telefonoExt` VARCHAR(5), IN `card4_jefe` VARCHAR(100), IN `card4_selectActividad` INT, IN `card5_Pnombre` VARCHAR(30), IN `card5_Snombre` VARCHAR(30), IN `card5_Papellido` VARCHAR(30), IN `card5_Sapellido` VARCHAR(30), IN `card5_identidad` VARCHAR(14), IN `card5_fechaNacimiento` VARCHAR(10), IN `card5_profesion` VARCHAR(100), IN `card5_ingresoMensual` DOUBLE, IN `card5_lugarLabor` VARCHAR(100), IN `card5_cargo` VARCHAR(100), IN `card5_tel` VARCHAR(30), IN `card5_cel` VARCHAR(30), IN `card5_tipoVivienda` INT(11), IN `card5_pagoVivienda` DOUBLE, IN `card6_Pnombre` VARCHAR(30), IN `card6_Snombre` VARCHAR(30), IN `card6_Papellido` VARCHAR(30), IN `card6_Sapellido` VARCHAR(30), IN `card6_identidad` VARCHAR(13), IN `card6_residencia` VARCHAR(100), IN `card6_direccion` VARCHAR(100), IN `card6_tel` VARCHAR(30), IN `card6_cel` VARCHAR(30), IN `card6_email` VARCHAR(100), IN `card6_estadoCivil` INT, IN `card6_dependientes` INT, IN `card6_empresa` VARCHAR(100), IN `card6_posicion` VARCHAR(100), IN `card6_tiempoServicio` INT, IN `card6_sueldoMensual` DOUBLE, IN `card6_otrosIngresos` DOUBLE, IN `card6_empresaTel` VARCHAR(30), IN `card6_empresaExt` VARCHAR(5), IN `card6_jefe` VARCHAR(100), IN `card6_selectActividad` INT, IN `card7_nombre` VARCHAR(30), IN `card7_tel` VARCHAR(30), IN `card7_trabajo` VARCHAR(30), IN `card7_parentesco` VARCHAR(30), IN `card7_nombre2` VARCHAR(30), IN `card7_tel2` VARCHAR(30), IN `card7_trabajo2` VARCHAR(30), IN `card7_parentesco2` VARCHAR(30), IN `card8_nombre` VARCHAR(30), IN `card8_tel` VARCHAR(30), IN `card8_trabajo` VARCHAR(30), IN `card8_parentesco` VARCHAR(30), IN `card5_empresaTel` VARCHAR(30), IN `card5_empresaExt` VARCHAR(30), IN `card6_sexo` VARCHAR(1), IN `card6_tipoVivienda` INT, IN `card6_hijos` INT, IN `card6_empresaDireccion` VARCHAR(200), IN `usuarioID` INT(11), OUT `mensajeError` VARCHAR(100), OUT `codigoError` INT(11))  BEGIN

	DECLARE CONYUGUE_ID INT;
	DECLARE FIADOR_ID INT;
	DECLARE SOLICITANTE_ID INT;
	DECLARE PRESTAMO_ID INT;
	DECLARE SOLICITUD_ID INT;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
		SET mensajeError = 'Hubo un error en la transaccion.';
        SET codigoError = 0;
        SHOW ERRORS;
    END;
    
	SET mensajeError = 'Transaccion exitosa.';
	SET codigoError = 1;
   
    START TRANSACTION;
	
	INSERT INTO personas(
		identidad, 

		Pnombre, 
		Snombre, 
		Papellido, 
		Sapellido, 
        fechaNacimiento,
		ocupacion,
		tipoViviendaID,
        pago_mensualVivienda
		) 
	VALUES(
		card5_identidad,
		card5_Pnombre,
		card5_Snombre, 
		card5_Papellido, 
		card5_Sapellido,
        card5_fechaNacimiento,
		card5_profesion,
		card5_tipoVivienda,
        card5_pagoVivienda
		 );

	SELECT LAST_INSERT_ID() INTO CONYUGUE_ID;
    
	INSERT INTO datosLaborales(
		personaID, 
		empresa, 
		posicion, 
		sueldo,
        telefono,
        extension
		) 
	VALUES(
		CONYUGUE_ID,
		card5_lugarLabor, 
		card5_cargo,
		card5_ingresoMensual,
        card5_empresaTel,
        card5_empresaExt
	);

	INSERT INTO personas_contacto(
			personaID, 
			telefono, 
			celular
		)
		VALUES(
			CONYUGUE_ID,
			card5_tel,
			card5_cel
		);



	INSERT INTO personas(
		identidad, 
		Pnombre, 
		Snombre, 
		Papellido, 
		Sapellido, 
		direccion,
		residencia,
		dependientes,
		estadoCivilID,
        sexo,
        tipoViviendaID,
        hijos
		) 

	VALUES(
		card6_identidad,
		card6_Pnombre,
		card6_Snombre, 
		card6_Papellido, 
		card6_Sapellido,
		card6_direccion,
		card6_residencia,
		card6_dependientes,
		card6_estadoCivil,
        card6_sexo,
        card6_tipoVivienda,
        card6_hijos
		);

		SELECT LAST_INSERT_ID() INTO FIADOR_ID;
    
	INSERT INTO datosLaborales(
		personaID, 
		empresa, 
		posicion, 
		aniosTrabajo,
		sueldo,
		jefeDirecto,
		otrosIngresos,
		telefono,
        datosLaborales.extension,
		actividadEmpresaID,
        direccion
		) 

	VALUES(
		FIADOR_ID,
		card6_empresa,
		card6_posicion,
		card6_tiempoServicio,
		card6_sueldoMensual,
		card6_jefe,
		card6_otrosIngresos,
		card6_empresaTel,
        card6_empresaExt,
		card6_selectActividad,
        card6_empresaDireccion
	);

	INSERT INTO personas_contacto(
			personaID, 
			telefono, 
			celular,
			email
		)
		VALUES(
			FIADOR_ID,
			card6_tel,
			card6_cel,
			card6_email
		);



	INSERT INTO personas(
		identidad, 
		Pnombre, 
		Snombre, 
		Papellido, 
		Sapellido, 
		RTN, 
		sexo, 
        fechaNacimiento,
		lugarNacimiento,
		direccion,
		nacionalidad,
		residencia,
		ocupacion,
		dependientes,
		hijos,
		estadoCivilID,
		tipoViviendaID,
        pago_mensualVivienda,
		conyugueID
		) 
	VALUES(
		card2_identidad,
		card2_Pnombre,
		card2_Snombre, 
		card2_Papellido, 
		card2_Sapellido,
		card2_RTN,
		card2_sexo,
        card2_fechaNacimiento,
		card2_lugarNaci,
		card2_direccion,
		card2_nacionalidad,
		card2_residencia,
		card2_ocupacion,
		card2_dependientes,
		card2_hijos,
		card2_estadoCivil,
		card2_tipoVivienda,
        card2_pagoVivienda,
		CONYUGUE_ID
		 );

		SELECT LAST_INSERT_ID() INTO SOLICITANTE_ID;


		INSERT INTO datosLaborales(
			personaID, 
			empresa, 
			posicion, 
			aniosTrabajo,
			sueldo,
			jefeDirecto,
			otrosIngresos,
			telefono,
            datosLaborales.extension,
			actividadEmpresaID,
			direccion
			) 

		VALUES(
			SOLICITANTE_ID,
			card4_empresa,
			card4_cargo,
			card4_tiempo,
			card4_sueldo,
			card4_jefe,
			card4_otroIngreso,
			card4_telefono,
            card4_telefonoExt,
			card4_selectActividad,
			card4_direccion
		);

		INSERT INTO personas_contacto(
			personaID, 
			telefono, 
			celular, 
			email
		)
		VALUES(
			SOLICITANTE_ID,
			card2_tel,
			card2_cel,
			card2_email
		);



		INSERT INTO prestamos(
			cantSolicitada,
			plazo,
			destinoID,
			tipoPrestamoID,
			fiadorID
		)
		VALUES(
			card3_cant,
			card3_plazo,
			card3_destino,
			card1_tipoPrestamo,
			FIADOR_ID
		);

		SELECT LAST_INSERT_ID() INTO PRESTAMO_ID;


		INSERT INTO solicitudes(
			solicitanteID,
			tipoSolicitudID,
			prestamoID,
			estadoID
		)
		VALUES(
			SOLICITANTE_ID,
			card1_tipoSolicitud,
			PRESTAMO_ID,
			1
		);

		SELECT LAST_INSERT_ID() INTO SOLICITUD_ID;

	

		INSERT INTO solicitudesBitacora(
			solicitudID,
			estadoID,
			usuarioID,
			comentario
		)
		VALUES(
			SOLICITUD_ID,
			1,
			usuarioID,
			'Creación de Solicitud'
		);
        

        
        INSERT INTO solicitudes_referencia(
	     solicitudes_referencia.solicitudID,
	     solicitudes_referencia.nombre_completo,
	     solicitudes_referencia.telefono_residencia,
	     solicitudes_referencia.trabajo,
	     solicitudes_referencia.parentesco,
         solicitudes_referencia.numeroReferencia)
     VALUES(
        SOLICITUD_ID,
     	card7_nombre,
     	card7_tel,
     	card7_trabajo,
     	card7_parentesco,1
     	),
     	(
        SOLICITUD_ID,
     	card7_nombre2,
     	card7_tel2,
     	card7_trabajo2,
     	card7_parentesco2,2
     	),
     	(
        SOLICITUD_ID,
     	card8_nombre,
     	card8_tel,
     	card8_trabajo,
     	card8_parentesco,3
     	)
     	;
        
        INSERT INTO condicion_prestamo(condicion_prestamo.prestamoID) values(PRESTAMO_ID);

	COMMIT;
END$$

CREATE DEFINER=`cpses_hid8rg6wxh`@`localhost`  PROCEDURE `SP_EDITAR_APRO` (IN `solicitudID` INT(11), IN `card1_tipoSolicitud` INT, IN `card1_tipoPrestamo` INT, IN `card1_prestamoID` INT, IN `card3_destino` INT(11), IN `card1_responsabilidad` INT, IN `card1_tipoAprobacion` BOOLEAN, IN `card2_Pnombre` VARCHAR(30), IN `card2_Snombre` VARCHAR(30), IN `card2_Papellido` VARCHAR(30), IN `card2_Sapellido` VARCHAR(30), IN `card2_identidad` VARCHAR(30), IN `card2_RTN` VARCHAR(14), IN `card2_sexo` CHAR(1), IN `card2_estadoCivil` INT, IN `card4_jefe` VARCHAR(100), IN `card4_tiempo` INT, IN `card6_Pnombre` VARCHAR(30), IN `card6_Snombre` VARCHAR(30), IN `card6_Papellido` VARCHAR(30), IN `card6_Sapellido` VARCHAR(30), IN `card6_identidad` VARCHAR(13), IN `card6_empresa` VARCHAR(100), IN `card4_monto` DOUBLE, IN `card4_plazoap` INT, IN `card4_cuota` DOUBLE, IN `card4_interes` DOUBLE, IN `card4_RCI` DOUBLE, IN `card4_TDI` DOUBLE, IN `card4_analista` VARCHAR(200), IN `card4_confirmacion` BOOLEAN, IN `card2_fechaNaci` VARCHAR(10), IN `card4_garantia` VARCHAR(200), IN `card2_jefe` VARCHAR(100), OUT `codigoError` INT, OUT `mensajeError` VARCHAR(100))  BEGIN
    DECLARE SOLICITANTE_ID INT;
    DECLARE PRESTAMO_ID INT;
    DECLARE FIADOR_ID INT;
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SET mensajeError = 'Hubo un error en la transaccion.';
        SET codigoError = 0;
        SHOW ERRORS limit 1;
    END;
    
   
    START TRANSACTION;
    SELECT solicitudes.solicitanteID into SOLICITANTE_ID from solicitudes where solicitudes.solicitudID = solicitudID;

    
    SELECT prestamoID INTO PRESTAMO_ID 
    FROM solicitudes
    WHERE solicitudes.solicitudID = solicitudID;

    SELECT fiadorID INTO FIADOR_ID
    FROM prestamos
    WHERE prestamos.prestamoID = PRESTAMO_ID;
    
    
        
        UPDATE personas SET
           Pnombre = card6_Pnombre, 
           Snombre = card6_Snombre, 
           Papellido = card6_Papellido, 
           Sapellido = card6_Sapellido,
           identidad = card6_identidad 
        WHERE personas.personaID = FIADOR_ID;

        
        UPDATE datosLaborales SET
            datosLaborales.empresa = card6_empresa
        WHERE datosLaborales.personaID = FIADOR_ID;


    UPDATE personas set 
        personas.Pnombre = card2_Pnombre, 
        personas.Snombre = card2_Snombre,
        personas.Papellido = card2_Papellido, 
        personas.Sapellido = card2_Sapellido,
        personas.RTN = card2_RTN,
        personas.sexo = card2_sexo,
        personas.identidad = card2_identidad,
        personas.fechaNacimiento = card2_fechaNaci,
        personas.estadoCivilID = card2_estadoCivil
    WHERE  personas.personaID = SOLICITANTE_ID;

    
    UPDATE datosLaborales SET 
    datosLaborales.jefeDirecto = card2_jefe,
    datosLaborales.aniosTrabajo = card4_tiempo WHERE datosLaborales.personaID = SOLICITANTE_ID;
   

        UPDATE  prestamos SET
            prestamos.destinoID =  card3_destino,
            prestamos.tipoPrestamoID = card1_tipoPrestamo,
            prestamos.responsabilidadID = card1_responsabilidad,
            prestamos.tipo_aprobacion = card1_tipoAprobacion
        WHERE prestamos.prestamoID = PRESTAMO_ID;
    
    UPDATE condicion_prestamo SET
    condicion_prestamo.monto_aprobado = card4_monto,
    condicion_prestamo.plazo_aprobado = card4_plazoap,
    condicion_prestamo.cuota_nivelada = card4_cuota,
    condicion_prestamo.tasa_interes = card4_interes,
    condicion_prestamo.RCI = card4_RCI,
    condicion_prestamo.TDI = card4_TDI,
    condicion_prestamo.comentario_analista = card4_analista,
    condicion_prestamo.confirmacion = card4_confirmacion,
    condicion_prestamo.descrpicion_garantia = card4_garantia
    WHERE condicion_prestamo.prestamoID = PRESTAMO_ID;
    
        
    SET mensajeError = 'Transaccion exitosa...';
    SET codigoError = 1;
        
    COMMIT;
END$$

CREATE DEFINER=`cpses_hid8rg6wxh`@`localhost`  PROCEDURE `SP_EDITAR_CREDITOS` (IN `solicitudID` INT(11), IN `card1_tipoSolicitud` INT, IN `card1_tipoPrestamo` INT, IN `card1_prestamoID` INT, IN `card3_destino` INT(11), IN `card1_responsabilidad` INT, IN `card1_tipoAprobacion` BOOLEAN, IN `card2_Pnombre` VARCHAR(30), IN `card2_Snombre` VARCHAR(30), IN `card2_Papellido` VARCHAR(30), IN `card2_Sapellido` VARCHAR(30), IN `card2_identidad` VARCHAR(30), IN `card2_RTN` VARCHAR(14), IN `card2_sexo` CHAR(1), IN `card2_estadoCivil` INT, IN `card4_jefe` VARCHAR(100), IN `card4_tiempo` INT, IN `card6_Pnombre` VARCHAR(30), IN `card6_Snombre` VARCHAR(30), IN `card6_Papellido` VARCHAR(30), IN `card6_Sapellido` VARCHAR(30), IN `card6_identidad` VARCHAR(13), IN `card6_empresa` VARCHAR(100), IN `card4_monto` DOUBLE, IN `card4_plazoap` INT, IN `card4_cuota` DOUBLE, IN `card4_interes` DOUBLE, IN `card4_RCI` DOUBLE, IN `card4_TDI` DOUBLE, IN `card4_analista` VARCHAR(200), IN `card4_confirmacion` BOOLEAN, IN `card2_fechaNaci` VARCHAR(10), IN `card4_garantia` VARCHAR(200), IN `card2_jefe` VARCHAR(100), OUT `codigoError` INT, OUT `mensajeError` VARCHAR(100))  BEGIN
    DECLARE SOLICITANTE_ID INT;
    DECLARE PRESTAMO_ID INT;
    DECLARE FIADOR_ID INT;
    

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SET mensajeError = 'Hubo un error en la transaccion.';
        SET codigoError = 0;
        SHOW ERRORS limit 1;
    END;
    
   
    START TRANSACTION;
    SELECT solicitudes.solicitanteID into SOLICITANTE_ID from solicitudes where solicitudes.solicitudID = solicitudID;

    
    SELECT prestamoID INTO PRESTAMO_ID 
    FROM solicitudes
    WHERE solicitudes.solicitudID = solicitudID;

    SELECT fiadorID INTO FIADOR_ID
    FROM prestamos
    WHERE prestamos.prestamoID = PRESTAMO_ID;
    
    
        
        UPDATE personas SET
           Pnombre = card6_Pnombre, 
           Snombre = card6_Snombre, 
           Papellido = card6_Papellido, 
           Sapellido = card6_Sapellido,
           identidad = card6_identidad 
        WHERE personas.personaID = FIADOR_ID;

        
        UPDATE datosLaborales SET
            empresa = card6_empresa,   
            aniosTrabajo = card4_tiempo,
            jefeDirecto = card4_jefe
        WHERE datosLaborales.personaID = FIADOR_ID;


    UPDATE personas set 
        personas.Pnombre = card2_Pnombre, 
        personas.Snombre = card2_Snombre,
        personas.Papellido = card2_Papellido, 
        personas.Sapellido = card2_Sapellido,
        personas.RTN = card2_RTN,
        personas.sexo = card2_sexo,
        personas.identidad = card2_identidad,
        personas.fechaNacimiento = card2_fechaNaci,
        personas.estadoCivilID = card2_estadoCivil
    WHERE  personas.personaID = SOLICITANTE_ID;
    
    UPDATE datosLaborales SET 
    datosLaborales.jefeDirecto = card2_jefe,
    datosLaborales.aniosTrabajo = card4_tiempo where datosLaborales.personaID = SOLICITANTE_ID;
   

        UPDATE  prestamos SET
            prestamos.destinoID =  card3_destino,
            prestamos.tipoPrestamoID = card1_tipoPrestamo,
            prestamos.responsabilidadID = card1_responsabilidad,
            prestamos.tipo_aprobacion = card1_tipoAprobacion
        WHERE prestamos.prestamoID = PRESTAMO_ID;
    
    UPDATE condicion_prestamo SET
    condicion_prestamo.monto_aprobado = card4_monto,
    condicion_prestamo.plazo_aprobado = card4_plazoap,
    condicion_prestamo.cuota_nivelada = card4_cuota,
    condicion_prestamo.tasa_interes = card4_interes,
    condicion_prestamo.RCI = card4_RCI,
    condicion_prestamo.TDI = card4_TDI,
    condicion_prestamo.comentario_analista = card4_analista,
    condicion_prestamo.confirmacion = card4_confirmacion,
    condicion_prestamo.descrpicion_garantia = card4_garantia
    WHERE condicion_prestamo.prestamoID = PRESTAMO_ID;

        
    SET mensajeError = 'Transaccion exitosa...';
    SET codigoError = 1;
        
    COMMIT;
END$$

CREATE DEFINER=`cpses_hid8rg6wxh`@`localhost`  PROCEDURE `SP_EDITAR_SOLICITUD` (IN `solicitudID` INT(11), IN `card1_tipoSolicitud` INT, IN `card1_tipoPrestamo` INT, IN `card2_Pnombre` VARCHAR(30), IN `card2_Snombre` VARCHAR(30), IN `card2_Papellido` VARCHAR(30), IN `card2_Sapellido` VARCHAR(30), IN `card2_identidad` VARCHAR(14), IN `card2_RTN` VARCHAR(14), IN `card2_sexo` CHAR(1), IN `card2_tipoVivienda` INT, IN `card2_pagoVivienda` DOUBLE, IN `card2_fechaNacimiento` VARCHAR(10), IN `card2_lugarNaci` VARCHAR(100), IN `card2_direccion` VARCHAR(100), IN `card2_nacionalidad` VARCHAR(50), IN `card2_residencia` VARCHAR(100), IN `card2_ocupacion` VARCHAR(100), IN `card2_email` VARCHAR(100), IN `card2_tel` VARCHAR(15), IN `card2_cel` VARCHAR(15), IN `card2_estadoCivil` INT, IN `card2_dependientes` INT, IN `card2_hijos` INT, IN `card3_cant` DOUBLE, IN `card3_plazo` INT, IN `card3_destino` INT(11), IN `card4_empresa` VARCHAR(50), IN `card4_sueldo` DOUBLE, IN `card4_tiempo` INT, IN `card4_cargo` VARCHAR(100), IN `card4_otroIngreso` VARCHAR(100), IN `card4_direccion` VARCHAR(100), IN `card4_telefono` VARCHAR(36), IN `card4_telefonoExt` VARCHAR(5), IN `card4_jefe` VARCHAR(100), IN `card4_selectActividad` INT, IN `card5_Pnombre` VARCHAR(30), IN `card5_Snombre` VARCHAR(30), IN `card5_Papellido` VARCHAR(30), IN `card5_Sapellido` VARCHAR(30), IN `card5_identidad` VARCHAR(14), IN `card5_fechaNacimiento` VARCHAR(10), IN `card5_profesion` VARCHAR(100), IN `card5_ingresoMensual` DOUBLE, IN `card5_lugarLabor` VARCHAR(100), IN `card5_cargo` VARCHAR(100), IN `card5_tel` VARCHAR(30), IN `card5_cel` VARCHAR(30), IN `card5_tipoVivienda` INT(11), IN `card5_pagoVivienda` DOUBLE, IN `card6_Pnombre` VARCHAR(30), IN `card6_Snombre` VARCHAR(30), IN `card6_Papellido` VARCHAR(30), IN `card6_Sapellido` VARCHAR(30), IN `card6_identidad` VARCHAR(13), IN `card6_residencia` VARCHAR(100), IN `card6_direccion` VARCHAR(100), IN `card6_tel` VARCHAR(30), IN `card6_cel` VARCHAR(30), IN `card6_email` VARCHAR(100), IN `card6_estadoCivil` INT, IN `card6_dependientes` INT, IN `card6_empresa` VARCHAR(100), IN `card6_posicion` VARCHAR(100), IN `card6_tiempoServicio` INT, IN `card6_sueldoMensual` DOUBLE, IN `card6_otrosIngresos` DOUBLE, IN `card6_empresaTel` VARCHAR(30), IN `card6_empresaExt` VARCHAR(5), IN `card6_jefe` VARCHAR(100), IN `card6_selectActividad` INT, IN `card7_nombre` VARCHAR(30), IN `card7_tel` VARCHAR(30), IN `card7_trabajo` VARCHAR(30), IN `card7_parentesco` VARCHAR(30), IN `card7_nombre2` VARCHAR(30), IN `card7_tel2` VARCHAR(30), IN `card7_trabajo2` VARCHAR(30), IN `card7_parentesco2` VARCHAR(30), IN `card8_nombre` VARCHAR(30), IN `card8_tel` VARCHAR(30), IN `card8_trabajo` VARCHAR(30), IN `card8_parentesco` VARCHAR(30), IN `card5_empresaTel` VARCHAR(30), IN `card5_empresaExt` VARCHAR(30), IN `card6_sexo` VARCHAR(1), IN `card6_tipoVivienda` INT, IN `card6_hijos` INT, IN `card6_empresaDireccion` VARCHAR(200), IN `usuarioID` INT(11), OUT `codigoError` INT, OUT `mensajeError` VARCHAR(100))  BEGIN
    DECLARE CONYUGUE_ID INT;
    DECLARE SOLICITANTE_ID INT;
    DECLARE PRESTAMO_ID INT;
    DECLARE FIADOR_ID INT;
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SET mensajeError = 'Hubo un error en la transaccion.';
        SET codigoError = 0;
        SHOW ERRORS limit 1;
    END;
    
   
    START TRANSACTION;
    SELECT solicitudes.solicitanteID into SOLICITANTE_ID from solicitudes where solicitudes.solicitudID = solicitudID;

    SELECT conyugueID INTO CONYUGUE_ID 
    FROM personas
    WHERE personas.personaID = SOLICITANTE_ID;
    
    SELECT prestamoID INTO PRESTAMO_ID 
    FROM solicitudes
    WHERE solicitudes.solicitudID = solicitudID;

    SELECT fiadorID INTO FIADOR_ID
    FROM prestamos
    WHERE prestamos.prestamoID = PRESTAMO_ID;

        UPDATE personas SET 
        Pnombre = card5_Pnombre,
        Snombre = card5_Snombre,
        Papellido = card5_Papellido, 
        Sapellido = card5_Sapellido,
        identidad = card5_identidad, 
        fechaNacimiento = card5_fechaNacimiento,
        ocupacion = card5_profesion,
        tipoViviendaID = card5_tipoVivienda,
        personas.pago_mensualVivienda = card5_pagoVivienda
        WHERE personas.personaID = CONYUGUE_ID;

        UPDATE  datosLaborales SET
            empresa =  card5_lugarLabor, 
            posicion = card5_cargo, 
            sueldo = card5_ingresoMensual,
            datosLaborales.telefono = card5_empresaTel,
            datosLaborales.extension = card5_empresaExt
        WHERE datosLaborales.personaID = CONYUGUE_ID;


        UPDATE personas_contacto SET
            telefono = card5_tel ,
            celular = card5_cel
        WHERE personas_contacto.personaID = CONYUGUE_ID;

        
        
        UPDATE personas SET

           Pnombre = card6_Pnombre, 
           Snombre = card6_Snombre, 

           Papellido = card6_Papellido, 
           Sapellido = card6_Sapellido, 
           identidad = card6_identidad,
           direccion = card6_direccion,
           residencia = card6_residencia,
           dependientes = card6_dependientes,
           estadoCivilID = card6_estadoCivil,
           personas.sexo = card6_sexo,
           personas.tipoViviendaID = card6_tipoVivienda,
           personas.hijos = card6_hijos
        WHERE personas.personaID = FIADOR_ID;

        
        UPDATE datosLaborales SET
            empresa = card6_empresa,   
            posicion = card6_posicion, 
            aniosTrabajo = card6_tiempoServicio,
            sueldo = card6_sueldoMensual,
            jefeDirecto = card6_jefe,
            otrosIngresos = card6_otrosIngresos,
            telefono = card6_empresaTel,
            datosLaborales.extension = card6_empresaExt,
            actividadEmpresaID = card6_selectActividad,
            datosLaborales.direccion = card6_empresaDireccion
        WHERE datosLaborales.personaID = FIADOR_ID;

        UPDATE personas_contacto SET
                telefono = card6_tel, 
                celular = card6_cel,
                email = card6_email 
        WHERE personas_contacto.personaID = FIADOR_ID;


    
    UPDATE personas set 
        personas.Pnombre = card2_Pnombre, 
        personas.Snombre = card2_Snombre,
        personas.Papellido = card2_Papellido, 
        personas.Sapellido = card2_Sapellido,
        personas.identidad = card2_identidad,
        personas.RTN = card2_RTN,
        personas.sexo = card2_sexo,
        personas.fechaNacimiento = card2_fechaNacimiento,
        personas.direccion = card2_direccion,
        personas.residencia = card2_residencia,
        personas.lugarNacimiento = card2_lugarNaci,
        personas.nacionalidad = card2_nacionalidad,
        personas.ocupacion = card2_ocupacion,
        personas.dependientes = card2_dependientes,
        personas.hijos = card2_hijos,
        personas.estadoCivilID = card2_estadoCivil,
        personas.tipoViviendaID = card2_tipoVivienda,
        personas.pago_mensualVivienda = card2_pagoVivienda
    WHERE  personas.personaID = SOLICITANTE_ID;
    
    UPDATE datosLaborales SET
            datosLaborales.empresa = card4_empresa, 
            datosLaborales.posicion = card4_cargo, 
            datosLaborales.aniosTrabajo = card4_tiempo,
            datosLaborales.sueldo = card4_sueldo,
            datosLaborales.jefeDirecto = card4_jefe,
            datosLaborales.otrosIngresos =              card4_otroIngreso,
            datosLaborales.telefono = card4_telefono,
            datosLaborales.extension = card4_telefonoExt,
            datosLaborales.actividadEmpresaID = card4_selectActividad,
            datosLaborales.direccion = card4_direccion
        WHERE datosLaborales.personaID = SOLICITANTE_ID;

         UPDATE personas_contacto SET
            telefono  = card2_tel, 
            celular = card2_cel,
            email = card2_email
        WHERE personas_contacto.personaID = SOLICITANTE_ID;



        UPDATE  prestamos SET
            prestamos.cantSolicitada  = card3_cant,
            prestamos.plazo = card3_plazo,
            prestamos.destinoID =  card3_destino,
            prestamos.tipoPrestamoID = card1_tipoPrestamo
        WHERE prestamos.prestamoID = PRESTAMO_ID;

        UPDATE solicitudes_referencia SET
        solicitudes_referencia.nombre_completo = card7_nombre,
        solicitudes_referencia.telefono_residencia = card7_tel,
        solicitudes_referencia.trabajo = card7_trabajo,
        solicitudes_referencia.parentesco = card7_parentesco
        WHERE solicitudes_referencia.numeroReferencia = 1 and solicitudes_referencia.solicitudID = solicitudID;
        
        
        
        UPDATE solicitudes_referencia SET
        solicitudes_referencia.nombre_completo = card7_nombre2,
        solicitudes_referencia.telefono_residencia = card7_tel2,
        solicitudes_referencia.trabajo = card7_trabajo2,
        solicitudes_referencia.parentesco = card7_parentesco2
        WHERE solicitudes_referencia.numeroReferencia = 2 and solicitudes_referencia.solicitudID = solicitudID;
        
        UPDATE solicitudes_referencia SET
        solicitudes_referencia.nombre_completo = card8_nombre,
        solicitudes_referencia.telefono_residencia = card8_tel,
        solicitudes_referencia.trabajo = card8_trabajo,
        solicitudes_referencia.parentesco = card8_parentesco
        WHERE solicitudes_referencia.numeroReferencia = 3 and solicitudes_referencia.solicitudID = solicitudID;
        
        
        
        
    
    SET mensajeError = 'Transaccion exitosa.';
    SET codigoError = 1;
        
    COMMIT;
END$$

CREATE DEFINER=`cpses_hid8rg6wxh`@`localhost`  PROCEDURE `SP_ENVIAR_SOLICITUD` (IN `solicitud_ID` INT(11), IN `nuevoEstado` INT, IN `usuarioID` INT, IN `comentario` VARCHAR(200), OUT `codigoError` INT, OUT `mensajeError` VARCHAR(100))  BEGIN
	DECLARE TIPO_SOLICITUD INT;
    DECLARE NUEVO_ESTADO INT;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
		SET mensajeError = 'Hubo un error en la transaccion.';
        SET codigoError = 0;
        SHOW ERRORS;
    END;
    
	SET mensajeError = 'Transaccion exitosa.';
	SET codigoError = 1;
   
    START TRANSACTION;
    
    SELECT solicitudes.tipoSolicitudID INTO TIPO_SOLICITUD FROM solicitudes WHERE solicitudes.solicitudID = solicitud_ID;
    
    IF TIPO_SOLICITUD = 1 THEN
    	SET NUEVO_ESTADO = 2;
    ELSE
    	SET NUEVO_ESTADO = 3;
    END IF;
    
    INSERT INTO solicitudesBitacora(
    	solicitudesBitacora.solicitudID,

    	solicitudesBitacora.estadoID,
    	solicitudesBitacora.usuarioID,
    	solicitudesBitacora.comentario
    )
    VALUES(
    	solicitud_ID,
    	NUEVO_ESTADO,
    	usuarioID,

    	comentario);
        
    UPDATE solicitudes SET solicitudes.estadoID = NUEVO_ESTADO  WHERE solicitudes.solicitudID = solicitud_ID;
        
	COMMIT;
END$$

CREATE DEFINER=`cpses_hid8rg6wxh`@`localhost`  PROCEDURE `SP_ENVIAR_SOLICITUD_APRO` (IN `solicitud_ID` INT(11), IN `nuevoEstado` INT, IN `usuarioID` INT, IN `comentario` VARCHAR(200), OUT `codigoError` INT, OUT `mensajeError` VARCHAR(100))  BEGIN
	DECLARE TIPO_SOLICITUD INT;
    DECLARE NUEVO_ESTADO INT;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
		SET mensajeError = 'Hubo un error en la transaccion.';
        SET codigoError = 0;
        SHOW ERRORS;
    END;
    
	SET mensajeError = 'Transaccion exitosa.';
	SET codigoError = 1;
   
    START TRANSACTION;
    
    SELECT solicitudes.tipoSolicitudID INTO TIPO_SOLICITUD FROM solicitudes WHERE solicitudes.solicitudID = solicitud_ID;
    
 
    
    INSERT INTO solicitudesBitacora(
    	solicitudesBitacora.solicitudID,

    	solicitudesBitacora.estadoID,
    	solicitudesBitacora.usuarioID,
    	solicitudesBitacora.comentario
    )
    VALUES(
    	solicitud_ID,
    	nuevoEstado,
    	usuarioID,
    	comentario);
        
    UPDATE solicitudes SET solicitudes.estadoID = nuevoEstado  WHERE solicitudes.solicitudID = solicitud_ID;
        
	COMMIT;
END$$

CREATE DEFINER=`cpses_hid8rg6wxh`@`localhost`  PROCEDURE `SP_ENVIAR_SOLICITUD_CREDITOS` (IN `solicitud_ID` INT(11), IN `nuevoEstado` INT, IN `usuarioID` INT, IN `comentario` VARCHAR(200), OUT `codigoError` INT, OUT `mensajeError` VARCHAR(100))  BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
		SET mensajeError = 'Hubo un error en la transaccion.';
        SET codigoError = 0;
        SHOW ERRORS;
    END;
    
    DECLARE EXIT HANDLER FOR SQLWARNING
    BEGIN
		SET mensajeError = 'Hubo un error en la transaccion.';
        SET codigoError = 0;
        SHOW ERRORS;
    END;
    
	SET mensajeError = 'Transaccion exitosa.';
	SET codigoError = 1;
   
    START TRANSACTION;
    
    INSERT INTO solicitudesBitacora(
    	solicitudesBitacora.solicitudID,

    	solicitudesBitacora.estadoID,
    	solicitudesBitacora.usuarioID,
    	solicitudesBitacora.comentario
    )
    VALUES(
    	solicitud_ID,
    	nuevoEstado,
    	usuarioID,
    	comentario);
        
    UPDATE solicitudes SET solicitudes.estadoID = nuevoEstado  WHERE solicitudes.solicitudID = solicitud_ID;
        
	COMMIT;
END$$

CREATE DEFINER=`cpses_hid8rg6wxh`@`localhost`  PROCEDURE `SP_ENVIAR_SOLICITUD_RRHH` (IN `solicitudID` INT, IN `rrhh_salarioBruto` DOUBLE, IN `rrhh_salarioConDeduccion` DOUBLE, IN `rrhh_derechos` DOUBLE, IN `rrhh_antiguedad` DOUBLE, IN `rrhh_comentario` VARCHAR(200), IN `nuevoEstado` INT, IN `usuarioID` INT, OUT `mensajeError` VARCHAR(100), OUT `codigoError` INT(11))  BEGIN
	
	DECLARE SOLICITANTE_ID INT;
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
		SET mensajeError = 'Hubo un error en la transaccion.';
        SET codigoError = 0;
        SHOW ERRORS;
    END;
    
    SET mensajeError = 'La transacción se realizó correctamente.';
    SET codigoError = 1;
    
    START TRANSACTION;
    
    SELECT solicitudes.solicitanteID INTO SOLICITANTE_ID FROM solicitudes WHERE    	  solicitudes.solicitudID = solicitudID;
    
    INSERT INTO solicitudesBitacora(
    	solicitudesBitacora.solicitudID,
    	solicitudesBitacora.estadoID,
    	solicitudesBitacora.usuarioID,
    	solicitudesBitacora.comentario
    )
    VALUES(
    	solicitudID,
    	nuevoEstado,
    	usuarioID,
    	rrhh_comentario);
        
    UPDATE solicitudes SET solicitudes.estadoID = nuevoEstado  WHERE 		    solicitudes.solicitudID = solicitudID;
    
    INSERT INTO empleadoDatos(empleadoDatos.personaID, empleadoDatos.salarioBruto, empleadoDatos.salarioConDeduccion, empleadoDatos.derechos,empleadoDatos.tiempoLabor,empleadoDatos.comentario) VALUES(SOLICITANTE_ID, rrhh_salarioBruto, rrhh_salarioConDeduccion,rrhh_derechos,rrhh_antiguedad,rrhh_comentario);
    
    

	COMMIT;
END$$

CREATE DEFINER=`cpses_hid8rg6wxh`@`localhost`  PROCEDURE `SP_OBTENER_APRO` (OUT `codigoError` INT, OUT `mensajeError` VARCHAR(200), IN `solicitudID` INT)  NO SQL
BEGIN
    DECLARE PRESTAMO_ID int;
  DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    SET mensajeError = 'Hubo un error en la transaccion.';
        SET codigoError = 0;
        SHOW ERRORS;
    END;
    
  SET mensajeError = 'Transaccion exitosa.';
  SET codigoError = 1;
   
  START TRANSACTION;
  
    SELECT solicitudes.prestamoID INTO PRESTAMO_ID FROM solicitudes  WHERE solicitudes.solicitudID = solicitudID;
  
    SELECT 
    solicitudes.tipoSolicitudID,
    prestamos.tipoPrestamoID,
    prestamos.prestamoID,
    prestamo_destino.destinoID,
    prestamos.responsabilidadID,
    prestamos.tipo_aprobacion,
    prestamos.cantSolicitada,

    solicitante.Pnombre as soli_Pnombre,
    solicitante.Snombre as soli_Snombre,
    solicitante.Papellido as soli_Papellido,
    solicitante.Sapellido as soli_Sapellido,
    solicitante.identidad as soli_identidad,
    solicitante.RTN as soli_RTN,
    solicitante.sexo as soli_sexo,
    solicitante.fechaNacimiento as soli_fechaNacimiento,
    solicitante.estadoCivilID as soli_estadoCivil,
    
    soli_datosLaborales.jefeDirecto as soli_jefe,

    soli_datosLaborales.aniosTrabajo as soli_aniosTrabajo,
    
  
    fiador.Pnombre as fiador_Pnombre,
    fiador.Snombre as fiador_Snombre,
    fiador.Papellido as fiador_Papellido,
    fiador.Sapellido as fiador_Sapellido,
    fiador.identidad as fiador_identidad,
    fiador.sexo as fiador_sexo,
    fiador.fechaNacimiento as fiador_fechaNacimiento,
    fiador.estadoCivilID fiador_estadoCivil,
       
    fiador_datosLaborales.empresa as fiador_empresa,
    
    condicion_prestamo.prestamoID,
    condicion_prestamo.monto_aprobado,
    condicion_prestamo.plazo_aprobado,
    condicion_prestamo.cuota_nivelada,
    condicion_prestamo.tasa_interes,
    condicion_prestamo.descrpicion_garantia,
    condicion_prestamo.RCI,
    condicion_prestamo.TDI,
    condicion_prestamo.confirmacion,
    condicion_prestamo.comentario_analista
    
       

    FROM solicitudes
    
    INNER JOIN personas as solicitante ON solicitudes.solicitanteID = solicitante.personaID
    
       
    INNER JOIN datosLaborales as soli_datosLaborales ON soli_datosLaborales.personaID = solicitudes.solicitanteID
    
   
    INNER JOIN prestamos ON solicitudes.prestamoID = prestamos.prestamoID

INNER JOIN prestamo_destino on prestamos.destinoID = prestamo_destino.destinoID
       
    INNER JOIN personas as fiador ON fiador.personaID = prestamos.fiadorID

    INNER JOIN datosLaborales as fiador_datosLaborales ON fiador_datosLaborales.personaID = prestamos.fiadorID
    
    INNER JOIN condicion_prestamo ON prestamos.prestamoID = condicion_prestamo.prestamoID
    
   
    

    
    WHERE solicitudes.solicitudID = solicitudID;
   
        
  COMMIT;
END$$

CREATE DEFINER=`cpses_hid8rg6wxh`@`localhost`  PROCEDURE `SP_OBTENER_COMENTARIOS` (IN `solicitudID` INT, OUT `codigoError` INT, OUT `mensajeError` VARCHAR(200))  NO SQL
BEGIN
DECLARE CONYUGUE_ID INT;
DECLARE SOLICITANTE_ID INT;
DECLARE PRESTAMO_ID INT;
DECLARE FIADOR_ID INT;

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
    SET mensajeError = 'Hubo un error en la transaccion.';
    SET codigoError = 0;
    SHOW ERRORS limit 1;
END;


START TRANSACTION;

SELECT 
    CASE solicitudesBitacora.estadoID  
     WHEN 1 THEN 'Módulo ingreso de Solicitudes'
     WHEN 2 THEN 'Módulo Ingreso de solicitudes'
     WHEN 3 THEN 'Oficial de RRHH'
     WHEN 4 THEN 'Oficial Analista de Créditos' 
     WHEN 5 THEN 'Oficial Aprobador'
     WHEN 6 THEN 'Oficial Aprobador'
     WHEN 7 THEN 'Oficial Aprobador'
    ELSE '' END as modulo,      
solicitudesBitacora.fecha, 
(SELECT usuarios.usuario FROM usuarios WHERE usuarios.usuarioID = solicitudesBitacora.usuarioID) as usuarioID, solicitudesBitacora.comentario from solicitudesBitacora INNER JOIN usuarios ON usuarios.usuarioID = solicitudesBitacora.usuarioID WHERE solicitudesBitacora.solicitudID = solicitudID;



SET mensajeError = 'Transaccion exitosa.';
SET codigoError = 1;


COMMIT;
END$$

CREATE DEFINER=`cpses_hid8rg6wxh`@`localhost`  PROCEDURE `SP_OBTENER_CREDITOS` (OUT `codigoError` INT, OUT `mensajeError` VARCHAR(200), IN `solicitudID` INT)  NO SQL
BEGIN
  DECLARE EXIT HANDLER FOR SQLEXCEPTION

    BEGIN
    SET mensajeError = 'Hubo un error en la transaccion.';
        SET codigoError = 0;
        SHOW ERRORS;
    END;
    
  SET mensajeError = 'Transaccion exitosa.';
  SET codigoError = 1;
   
  START TRANSACTION;
    SELECT 
    solicitudes.tipoSolicitudID,
    prestamos.tipoPrestamoID,
    prestamos.prestamoID,

    prestamo_destino.destinoID,
    prestamos.responsabilidadID,
    prestamos.tipo_aprobacion,
    prestamos.cantSolicitada,

    solicitante.Pnombre as soli_Pnombre,
    solicitante.Snombre as soli_Snombre,
    solicitante.Papellido as soli_Papellido,
    solicitante.Sapellido as soli_Sapellido,
    solicitante.identidad as soli_identidad,
    solicitante.RTN as soli_RTN,
    solicitante.sexo as soli_sexo,
   	solicitante.fechaNacimiento as soli_fechaNacimiento,
    solicitante.estadoCivilID as soli_estadoCivil,
    
    soli_datosLaborales.jefeDirecto as soli_jefe,
    soli_datosLaborales.aniosTrabajo as soli_aniosTrabajo,
    
  
    fiador.Pnombre as fiador_Pnombre,
    fiador.Snombre as fiador_Snombre,
    fiador.Papellido as fiador_Papellido,
    fiador.Sapellido as fiador_Sapellido,
    fiador.identidad as fiador_identidad,
    fiador.sexo as fiador_sexo,
    fiador.fechaNacimiento as fiador_fechaNacimiento,
    fiador.estadoCivilID fiador_estadoCivil,
       
    fiador_datosLaborales.empresa as fiador_empresa,
    
    condicion_prestamo.prestamoID,
    condicion_prestamo.monto_aprobado,
    condicion_prestamo.plazo_aprobado,
    condicion_prestamo.cuota_nivelada,
    condicion_prestamo.tasa_interes,
    condicion_prestamo.descrpicion_garantia,
    condicion_prestamo.RCI,
    condicion_prestamo.TDI,
    condicion_prestamo.confirmacion,
    condicion_prestamo.comentario_analista
    
       

    FROM solicitudes
    
    INNER JOIN personas as solicitante ON solicitudes.solicitanteID = solicitante.personaID
    
       
    INNER JOIN datosLaborales as soli_datosLaborales ON soli_datosLaborales.personaID = solicitudes.solicitanteID
    
   
    INNER JOIN prestamos ON solicitudes.prestamoID = prestamos.prestamoID

INNER JOIN prestamo_destino on prestamos.destinoID = prestamo_destino.destinoID
       
    INNER JOIN personas as fiador ON fiador.personaID = prestamos.fiadorID

	INNER JOIN datosLaborales as fiador_datosLaborales ON fiador_datosLaborales.personaID = prestamos.fiadorID
    
    INNER JOIN condicion_prestamo ON prestamos.prestamoID = condicion_prestamo.prestamoID
    
    

    
    WHERE solicitudes.solicitudID = solicitudID;
   
        
  COMMIT;
END$$

CREATE DEFINER=`cpses_hid8rg6wxh`@`localhost`  PROCEDURE `SP_OBTENER_REFERENCIAS` (OUT `codigoError` INT, OUT `mensajeError` VARCHAR(200), IN `solicitud_id` INT)  NO SQL
BEGIN
  DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    SET mensajeError = 'Hubo un error en la transaccion.';
        SET codigoError = 0;
        SHOW ERRORS;
    END;
    
  SET mensajeError = 'Transaccion exitosa.';
  SET codigoError = 1;
   
  START TRANSACTION;
    
   SELECT solicitudes_referencia.nombre_completo, solicitudes_referencia.telefono_residencia, solicitudes_referencia.trabajo,solicitudes_referencia.parentesco FROM solicitudes_referencia WHERE solicitudes_referencia.solicitudID = solicitud_id ORDER by solicitudes_referencia.numeroReferencia ASC;
    
        
  COMMIT;
END$$

CREATE DEFINER=`cpses_hid8rg6wxh`@`localhost`  PROCEDURE `SP_OBTENER_RRHH` (IN `solicitudID` INT(11), OUT `codigoError` INT(11), OUT `mensajeError` VARCHAR(200))  NO SQL
BEGIN
DECLARE SOLICITANTE_ID INT;
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
SET mensajeError = 'Hubo un error en la transaccion.';
SET codigoError = 0;
SHOW ERRORS limit 1;
END;

START TRANSACTION;

SELECT solicitudes.solicitanteID INTO SOLICITANTE_ID FROM solicitudes WHERE solicitudes.solicitudID = solicitudID;

SELECT empleadoDatos.salarioBruto, empleadoDatos.salarioConDeduccion, empleadoDatos.derechos, empleadoDatos.tiempoLabor, empleadoDatos.comentario FROM empleadoDatos WHERE empleadoDatos.personaID = SOLICITANTE_ID;

SET mensajeError = 'Transaccion exitosa.';
SET codigoError = 1;

COMMIT;
END$$

CREATE DEFINER=`cpses_hid8rg6wxh`@`localhost`  PROCEDURE `SP_OBTENER_SOLICITUD` (OUT `codigoError` INT, OUT `mensajeError` VARCHAR(200), IN `solicitudID` INT)  NO SQL
BEGIN
  DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    SET mensajeError = 'Hubo un error en la transaccion.';
        SET codigoError = 0;
        SHOW ERRORS;
    END;
    
  SET mensajeError = 'Transaccion exitosa.';
  SET codigoError = 1;
   
  START TRANSACTION;
    
   SELECT 
    solicitudes.tipoSolicitudID,
    prestamos.tipoPrestamoID,

    solicitante.Pnombre as soli_Pnombre,
    solicitante.Snombre as soli_Snombre,
    solicitante.Papellido as soli_Papellido,
    solicitante.Sapellido as soli_Sapellido,
    solicitante.identidad as soli_identidad,
    solicitante.RTN as soli_RTN,
    solicitante.sexo as soli_sexo,
    solicitante.tipoViviendaID as soli_tipoViviendaID,
    solicitante.pago_mensualVivienda as soli_pagoVivienda,
    solicitante.fechaNacimiento as soli_fechaNacimiento,
    solicitante.lugarNacimiento as soli_lugarNaci,
    solicitante.direccion as soli_direccion,
    solicitante.nacionalidad as soli_nacionalidad,
    solicitante.residencia as soli_residencia,
    solicitante.ocupacion as soli_ocupacion,
    solicitanteContact.email as soli_email,
    solicitanteContact.telefono as soli_tel,
    solicitanteContact.celular as soli_cel,
    solicitante.estadoCivilID as soli_estadoCivil,
    solicitante.dependientes as soli_dependientes,
    solicitante.hijos as soli_hijos,

    prestamos.cantSolicitada,
    prestamos.plazo,
    prestamo_destino.destinoID,

    soli_datosLaborales.empresa as soli_empresa,
    soli_datosLaborales.posicion as soli_posicion,
    soli_datosLaborales.aniosTrabajo as soli_aniosTrabajo,
    soli_datosLaborales.sueldo as soli_sueldo,
    soli_datosLaborales.jefeDirecto as soli_jefe ,
    soli_datosLaborales.otrosIngresos as soli_otrosIngresos,
    soli_datosLaborales.telefono as soli_empresaTel,
    soli_datosLaborales.extension as soli_empresaExt,
    soli_datosLaborales.actividadEmpresaID as soli_actividadEmpresa,
    soli_datosLaborales.direccion as soli_empresaDireccion,
    

    conyugue.Pnombre as conyu_Pnombre,
    conyugue.Snombre as conyu_Snombre,
    conyugue.Papellido as conyu_Papellido,
    conyugue.Sapellido as conyu_Sapellido,
    conyugue.identidad as conyu_identidad,
    conyugue.fechaNacimiento as conyu_fechaNacimiento,
    conyugue.ocupacion as conyu_ocupacion,
    conyugue.tipoViviendaID as conyu_tipoVivienda,

    conyugue.pago_mensualVivienda as conyu_pagoVivienda,

    conyugueContact.telefono as conyu_tel,
    conyugueContact.celular as conyu_cel,

    datosLaboralesConyugue.empresa as conyu_empresa,
    datosLaboralesConyugue.sueldo as conyu_sueldo,
    datosLaboralesConyugue.posicion as conyu_cargo,
    datosLaboralesConyugue.telefono as conyu_empresaTel,
    datosLaboralesConyugue.extension as conyu_empresaExt,

  
    fiador.Pnombre as fiador_Pnombre,
    fiador.Snombre as fiador_Snombre,
    fiador.Papellido as fiador_Papellido,
    fiador.Sapellido as fiador_Sapellido,
    fiador.identidad as fiador_identidad,
    fiador.identidad as fiador_identidad,
    fiador.direccion as fiador_direccion,
    fiador.residencia as fiador_residencia,
    fiador.estadoCivilID fiador_estadoCivil,
    fiador.dependientes as fiador_dependientes,
    fiador.sexo as fiador_sexo,
    fiador.tipoViviendaID as fiador_tipoVivienda,
    fiador.hijos as fiador_hijos,
    
    
    
    fiadorContact.telefono as fiador_telefono,
    fiadorContact.celular as fiador_cel,
    fiadorContact.email as fiador_email,
    
    fiador_datosLaborales.empresa as fiador_empresa,
    fiador_datosLaborales.posicion as fiador_posicion,

    fiador_datosLaborales.aniosTrabajo as fiador_aniosTrabajo,
    fiador_datosLaborales.sueldo as fiador_sueldo,
    fiador_datosLaborales.otrosIngresos as fiador_otrosIngresos,
    fiador_datosLaborales.telefono as fiador_empresaTel,
    fiador_datosLaborales.extension as fiador_empresaExt,
    fiador_datosLaborales.jefeDirecto as fiador_jefe,
    fiador_datosLaborales.actividadEmpresaID as fiador_ActividadEmpresa,
    fiador_datosLaborales.direccion as fiador_empresaDireccion 
    
    
    

    FROM solicitudes
    
    INNER JOIN personas as solicitante ON solicitudes.solicitanteID = solicitante.personaID
    
    INNER JOIN personas as conyugue ON conyugue.personaID = solicitante.conyugueID
    
    
    INNER JOIN datosLaborales as soli_datosLaborales ON soli_datosLaborales.personaID = solicitudes.solicitanteID
    
    INNER JOIN personas_contacto as solicitanteContact ON solicitanteContact.personaID = solicitante.personaID

    INNER JOIN personas_contacto as conyugueContact ON conyugueContact.personaID = conyugue.personaID

    INNER JOIN prestamos ON solicitudes.prestamoID = prestamos.prestamoID
    
    
    INNER JOIN datosLaborales as datosLaboralesConyugue ON datosLaboralesConyugue.personaID = conyugue.personaID
    
    INNER JOIN personas as fiador ON fiador.personaID = prestamos.fiadorID

	 INNER JOIN datosLaborales as fiador_datosLaborales ON fiador_datosLaborales.personaID = prestamos.fiadorID

    INNER JOIN personas_contacto as fiadorContact ON fiadorContact.personaID = prestamos.fiadorID
    INNER JOIN prestamo_destino on prestamos.destinoID = prestamo_destino.destinoID
    
    
    WHERE solicitudes.solicitudID = solicitudID ;
        
  COMMIT;
END$$

CREATE DEFINER=`cpses_hid8rg6wxh`@`localhost`  PROCEDURE `SP_PRUEBA` (IN `solicitudID` INT(11), IN `card1_tipoSolicitud` INT, IN `card1_tipoPrestamo` INT, IN `card2_Pnombre` VARCHAR(30), IN `card2_Snombre` VARCHAR(30), IN `card2_Papellido` VARCHAR(30), IN `card2_Sapellido` VARCHAR(30), IN `card2_RTN` VARCHAR(14), IN `card2_sexo` CHAR(1), IN `card2_tipoVivienda` INT, IN `card2_fechaNacimiento` VARCHAR(10), IN `card2_lugarNaci` VARCHAR(100), IN `card2_direccion` VARCHAR(100), IN `card2_nacionalidad` VARCHAR(50), IN `card2_residencia` VARCHAR(100), IN `card2_ocupacion` VARCHAR(100), IN `card2_email` VARCHAR(100), IN `card2_tel` VARCHAR(15), IN `card2_cel` VARCHAR(15), IN `card2_estadoCivil` INT, IN `card2_dependientes` INT, IN `card2_hijos` INT, IN `usuarioID` INT(11), OUT `codigoError` INT, OUT `mensajeError` VARCHAR(100))  BEGIN
    DECLARE _SOLICITANTE int;
    DECLARE PRESTAMO_ID int;
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SET mensajeError = 'Hubo un error en la transaccion.';
        SET codigoError = 0;
        SHOW ERRORS limit 1;
    END;
    
   
    START TRANSACTION;
    SELECT solicitudes.solicitanteID into _SOLICITANTE from solicitudes where solicitudes.solicitudID = solicitudID;
    
    SELECT prestamoID INTO PRESTAMO_ID 
    FROM solicitudes
    WHERE solicitudes.solicitudID = solicitudID;

    
    UPDATE personas set 
    	personas.Pnombre = card2_Pnombre, 
        personas.Snombre = card2_Snombre,

        personas.Papellido = card2_Papellido, 
       	personas.Sapellido = card2_Sapellido,
        personas.RTN = card2_RTN,
        personas.sexo = card2_sexo,
        personas.fechaNacimiento = card2_fechaNacimiento,
        personas.direccion = card2_direccion,
        personas.residencia = card2_residencia,
        personas.lugarNacimiento = card2_lugarNaci,
        personas.nacionalidad = card2_nacionalidad,
        personas.ocupacion = card2_ocupacion,
        personas.dependientes = card2_dependientes,
        personas.hijos = card2_hijos,
        personas.estadoCivilID = card2_estadoCivil,
        personas.tipoViviendaID = card2_tipoVivienda
    WHERE  personas.personaID = _SOLICITANTE;
    
    UPDATE datosLaborales SET
            datosLaborales.empresa = card4_empresa, 
            datosLaborales.posicion = card4_cargo, 
            datosLaborales.aniosTrabajo = card4_tiempo,
            datosLaborales.sueldo = card4_sueldo,
            datosLaborales.jefeDirecto = card4_jefe,
            datosLaborales.otrosIngresos =       		card4_otroIngreso,
            datosLaborales.telefono = card4_telefono,
            datosLaborales.actividadEmpresaID = card4_selectActividad,
            datosLaborales.direccion = card4_direccion
        WHERE datosLaborales.personaID = _SOLICITANTE;

         UPDATE personas_contacto SET
            telefono  = card2_tel, 
            celular = card2_cel,
            email = card2_email
        WHERE personas_contacto.personaID = _SOLICITANTE;


        UPDATE  prestamos SET
            prestamos.cantSolicitada  = card3_cant,
            prestamos.plazo = card3_plazo,
            prestamos.destino =  card3_destino,
            prestamos.tipoPrestamoID = card1_tipoPrestamo
        WHERE prestamos.prestamoID = PRESTAMO_ID;


    
    SET mensajeError = 'Transaccion exitosa.';
    SET codigoError = _SOLICITANTE;
        
    COMMIT;
END$$

CREATE DEFINER=`cpses_hid8rg6wxh`@`localhost`  PROCEDURE `SP_TRAER_SOLICITUDES` (OUT `codigoError` INT, OUT `mensajeError` VARCHAR(100))  BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
		SET mensajeError = 'Hubo un error en la transaccion.';
        SET codigoError = 0;
        SHOW ERRORS;
    END;
    
	SET mensajeError = 'Transaccion exitosa.';
	SET codigoError = 1;
   
    START TRANSACTION;
    
		SELECT solicitudes.solicitudID,
		solicitudes.estadoID, 
		(SELECT solicitudesBitacora.fecha FROM solicitudesBitacora WHERE solicitudesBitacora.solicitudID = solicitudes.solicitudID AND solicitudesBitacora.estadoID = 1 ) fechaCreacion, 
		solicitante.identidad,
		CONCAT(solicitante.Pnombre , ' ' , solicitante.Papellido) AS solicitanteNombre,
		tipoSolicitudes.descripcion AS tipoSolicitud
		FROM solicitudes
		INNER JOIN personas as solicitante ON solicitudes.solicitanteID = solicitante.personaID
		INNER JOIN tipoSolicitudes ON solicitudes.tipoSolicitudID = tipoSolicitudes.tipoSolicitudID ;
	COMMIT;
END$$

CREATE DEFINER=`cpses_hid8rg6wxh`@`localhost`  PROCEDURE `SP_TRAER_SOLICITUDES_APRO` (OUT `codigoError` INT, OUT `mensajeError` VARCHAR(100))  BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
		SET mensajeError = 'Hubo un error en la transaccion.';

        SET codigoError = 0;
        SHOW ERRORS;
    END;
    
	SET mensajeError = 'Transaccion exitosa.';
	SET codigoError = 1;
   
    START TRANSACTION;
    
		SELECT solicitudes.solicitudID,
		solicitudes.estadoID, 
		(SELECT solicitudesBitacora.fecha FROM solicitudesBitacora WHERE solicitudesBitacora.solicitudID = solicitudes.solicitudID AND solicitudesBitacora.estadoID = 4 ) fechaCreacion, 
		solicitante.identidad,
		CONCAT(solicitante.Pnombre , ' ' , solicitante.Papellido) AS solicitanteNombre,

		tipoSolicitudes.descripcion AS tipoSolicitud
		FROM solicitudes
		INNER JOIN personas as solicitante ON solicitudes.solicitanteID = solicitante.personaID
		INNER JOIN tipoSolicitudes ON solicitudes.tipoSolicitudID = tipoSolicitudes.tipoSolicitudID 
        WHERE solicitudes.estadoID in (4,5,6,7);
        
	COMMIT;
END$$

CREATE DEFINER=`cpses_hid8rg6wxh`@`localhost`  PROCEDURE `SP_TRAER_SOLICITUDES_CREDITOS` (OUT `codigoError` INT, OUT `mensajeError` VARCHAR(100))  BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
		SET mensajeError = 'Hubo un error en la transaccion.';
        SET codigoError = 0;
        SHOW ERRORS;
    END;
    
	SET mensajeError = 'Transaccion exitosa.';
	SET codigoError = 1;
   
    START TRANSACTION;
    
		SELECT solicitudes.solicitudID,
		solicitudes.estadoID, 
		(SELECT solicitudesBitacora.fecha FROM solicitudesBitacora WHERE solicitudesBitacora.solicitudID = solicitudes.solicitudID AND solicitudesBitacora.estadoID = 1 ) fechaCreacion, 
		solicitante.identidad,
		CONCAT(solicitante.Pnombre , ' ' , solicitante.Papellido) AS solicitanteNombre,
		tipoSolicitudes.descripcion AS tipoSolicitud
		FROM solicitudes
		INNER JOIN personas as solicitante ON solicitudes.solicitanteID = solicitante.personaID
		INNER JOIN tipoSolicitudes ON solicitudes.tipoSolicitudID = tipoSolicitudes.tipoSolicitudID 
        WHERE solicitudes.estadoID in (3,4, 5, 6, 7);
        
	COMMIT;
END$$

CREATE DEFINER=`cpses_hid8rg6wxh`@`localhost`  PROCEDURE `SP_TRAER_SOLICITUDES_RRHH` (OUT `codigoError` INT, OUT `mensajeError` VARCHAR(100))  BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
		SET mensajeError = 'Hubo un error en la transaccion.';
        SET codigoError = 0;
        SHOW ERRORS;
    END;
    
	SET mensajeError = 'Transaccion exitosa.';
	SET codigoError = 1;

   
    START TRANSACTION;
    
		SELECT solicitudes.solicitudID,
		solicitudes.estadoID, 
		(SELECT solicitudesBitacora.fecha FROM solicitudesBitacora WHERE solicitudesBitacora.solicitudID = solicitudes.solicitudID AND solicitudesBitacora.estadoID = 1 ) fechaCreacion, 
		solicitante.identidad,
		CONCAT(solicitante.Pnombre , ' ' , solicitante.Papellido) AS solicitanteNombre,
		tipoSolicitudes.descripcion AS tipoSolicitud
		FROM solicitudes
		INNER JOIN personas as solicitante ON solicitudes.solicitanteID = solicitante.personaID
		INNER JOIN tipoSolicitudes ON solicitudes.tipoSolicitudID = tipoSolicitudes.tipoSolicitudID 
        WHERE solicitudes.tipoSolicitudID = 1 and solicitudes.estadoID in (2,3,4,5,6,7);
        
	COMMIT;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `condicion_prestamo`
--

CREATE TABLE `condicion_prestamo` (
  `prestamoID` int(11) NOT NULL,
  `monto_aprobado` double(13,2) DEFAULT '0.00',
  `plazo_aprobado` int(11) DEFAULT '0',
  `cuota_nivelada` double(13,2) DEFAULT '0.00',
  `tasa_interes` double(5,2) DEFAULT '0.00',
  `descrpicion_garantia` varchar(300) DEFAULT '0',
  `RCI` double(5,2) DEFAULT '0.00',
  `TDI` double(5,2) DEFAULT '0.00',
  `confirmacion` tinyint(1) DEFAULT '0',
  `comentario_analista` varchar(300) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `datosLaborales`
--

CREATE TABLE `datosLaborales` (
  `personaID` int(11) NOT NULL DEFAULT '0',
  `empresa` varchar(100) COLLATE latin1_spanish_ci DEFAULT NULL,
  `posicion` varchar(100) COLLATE latin1_spanish_ci DEFAULT NULL,
  `aniosTrabajo` int(11) DEFAULT NULL,
  `sueldo` double DEFAULT NULL,
  `jefeDirecto` varchar(100) COLLATE latin1_spanish_ci DEFAULT NULL,
  `otrosIngresos` double DEFAULT NULL,
  `telefono` varchar(30) COLLATE latin1_spanish_ci DEFAULT NULL,
  `extension` varchar(10) COLLATE latin1_spanish_ci DEFAULT NULL,
  `actividadEmpresaID` int(11) DEFAULT NULL,
  `direccion` varchar(200) COLLATE latin1_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleadoDatos`
--

CREATE TABLE `empleadoDatos` (
  `personaID` int(11) NOT NULL,
  `salarioBruto` double NOT NULL,
  `salarioConDeduccion` double NOT NULL,
  `derechos` double NOT NULL,
  `tiempoLabor` int(11) NOT NULL,
  `comentario` varchar(200) COLLATE latin1_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empresaActividades`
--

CREATE TABLE `empresaActividades` (
  `empresaActividadID` int(11) NOT NULL,
  `descripcion` varchar(200) COLLATE latin1_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

--
-- Volcado de datos para la tabla `empresaActividades`
--

INSERT INTO `empresaActividades` (`empresaActividadID`, `descripcion`) VALUES
(1, 'Servicios financieros'),
(2, 'Educación'),
(3, 'Transporte'),
(4, 'Industria'),
(5, 'Gobierno'),
(6, 'Agricultura'),
(7, 'Sector Privado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estadosCivil`
--

CREATE TABLE `estadosCivil` (
  `estadoCivilID` int(11) NOT NULL,
  `descripcion` varchar(200) COLLATE latin1_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

--
-- Volcado de datos para la tabla `estadosCivil`
--

INSERT INTO `estadosCivil` (`estadoCivilID`, `descripcion`) VALUES
(1, 'Soltero'),
(2, 'Casado'),
(3, 'Otros');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personas`
--

CREATE TABLE `personas` (
  `personaID` int(11) NOT NULL,
  `identidad` varchar(13) COLLATE latin1_spanish_ci DEFAULT NULL,
  `Pnombre` varchar(30) COLLATE latin1_spanish_ci DEFAULT NULL,
  `Snombre` varchar(30) COLLATE latin1_spanish_ci DEFAULT NULL,
  `Papellido` varchar(30) COLLATE latin1_spanish_ci DEFAULT NULL,
  `Sapellido` varchar(30) COLLATE latin1_spanish_ci DEFAULT NULL,
  `RTN` varchar(14) COLLATE latin1_spanish_ci DEFAULT NULL,
  `sexo` char(1) COLLATE latin1_spanish_ci DEFAULT NULL,
  `fechaNacimiento` date DEFAULT NULL,
  `direccion` varchar(200) COLLATE latin1_spanish_ci DEFAULT NULL,
  `residencia` varchar(50) COLLATE latin1_spanish_ci DEFAULT NULL,
  `lugarNacimiento` varchar(50) COLLATE latin1_spanish_ci DEFAULT NULL,
  `nacionalidad` varchar(50) COLLATE latin1_spanish_ci DEFAULT NULL,
  `ocupacion` varchar(50) COLLATE latin1_spanish_ci DEFAULT NULL,
  `dependientes` int(11) DEFAULT NULL,
  `hijos` int(11) DEFAULT NULL,
  `estadoCivilID` int(11) DEFAULT NULL,
  `tipoViviendaID` int(11) DEFAULT NULL,
  `pago_mensualVivienda` double DEFAULT '0',
  `conyugueID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personas_contacto`
--

CREATE TABLE `personas_contacto` (
  `personaID` int(11) NOT NULL,
  `telefono` varchar(30) COLLATE latin1_spanish_ci NOT NULL DEFAULT '',
  `celular` varchar(30) COLLATE latin1_spanish_ci NOT NULL DEFAULT '',
  `email` varchar(200) COLLATE latin1_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `prestamos`
--

CREATE TABLE `prestamos` (
  `prestamoID` int(11) NOT NULL,
  `cantSolicitada` decimal(14,2) NOT NULL,
  `plazo` int(11) NOT NULL,
  `destinoID` int(11) NOT NULL,
  `tipoPrestamoID` int(11) NOT NULL,
  `fiadorID` int(11) NOT NULL,
  `responsabilidadID` int(11) DEFAULT NULL,
  `tipo_aprobacion` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `prestamo_destino`
--

CREATE TABLE `prestamo_destino` (
  `destinoID` int(11) NOT NULL,
  `descripcion` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `prestamo_destino`
--

INSERT INTO `prestamo_destino` (`destinoID`, `descripcion`) VALUES
(1, 'Adquisición de Vivienda y/o Terreno'),
(2, 'Adquisición de Vehiculo'),
(3, 'Consolidación de Deudas'),
(4, ' Reparaciones o mejoras de vivienda'),
(5, 'Educación'),
(6, 'Gastos de traslado de casa'),
(7, 'Viajes/Entretenimiento'),
(8, 'Adquisición de Artículos'),
(9, 'Salud/Tratamientos Médicos'),
(10, 'Otros');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `solicitudes`
--

CREATE TABLE `solicitudes` (
  `solicitudID` int(11) NOT NULL,
  `solicitanteID` int(11) NOT NULL,
  `tipoSolicitudID` int(11) NOT NULL,
  `prestamoID` int(11) NOT NULL,
  `estadoID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `solicitudesBitacora`
--

CREATE TABLE `solicitudesBitacora` (
  `solicitudID` int(11) NOT NULL,
  `estadoID` int(11) NOT NULL,
  `fecha` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `usuarioID` int(11) NOT NULL,
  `comentario` varchar(200) COLLATE latin1_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `solicitudEstados`
--

CREATE TABLE `solicitudEstados` (
  `estadoID` int(11) NOT NULL,
  `descripcion` varchar(100) COLLATE latin1_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

--
-- Volcado de datos para la tabla `solicitudEstados`
--

INSERT INTO `solicitudEstados` (`estadoID`, `descripcion`) VALUES
(1, 'Creación de solicitud'),
(2, 'Envio desde ingreso solicitudes'),
(3, 'Envio desde RRHH'),
(4, 'Envio desde Creditos'),
(5, 'Aprobado'),
(6, 'Denegado'),
(7, 'Devuelto');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `solicitudes_referencia`
--

CREATE TABLE `solicitudes_referencia` (
  `solicitudID` int(11) NOT NULL,
  `nombre_completo` varchar(200) COLLATE latin1_spanish_ci DEFAULT NULL,
  `telefono_residencia` varchar(20) COLLATE latin1_spanish_ci DEFAULT NULL,
  `trabajo` varchar(200) COLLATE latin1_spanish_ci DEFAULT NULL,
  `parentesco` varchar(200) COLLATE latin1_spanish_ci DEFAULT NULL,
  `numeroReferencia` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipoPrestamos`
--

CREATE TABLE `tipoPrestamos` (
  `tipoPrestamosID` int(11) NOT NULL,
  `descripcion` varchar(200) COLLATE latin1_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

--
-- Volcado de datos para la tabla `tipoPrestamos`
--

INSERT INTO `tipoPrestamos` (`tipoPrestamosID`, `descripcion`) VALUES
(1, 'fiduciario'),
(2, 'prendario'),
(3, 'hipotecario');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipoSolicitudes`
--

CREATE TABLE `tipoSolicitudes` (
  `tipoSolicitudID` int(11) NOT NULL,
  `descripcion` varchar(200) COLLATE latin1_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

--
-- Volcado de datos para la tabla `tipoSolicitudes`
--

INSERT INTO `tipoSolicitudes` (`tipoSolicitudID`, `descripcion`) VALUES
(1, 'Colaborador'),
(2, 'Cliente externo'),
(3, 'Empresarial');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipoViviendas`
--

CREATE TABLE `tipoViviendas` (
  `tipoViviendaID` int(11) NOT NULL,
  `descripcion` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tipoViviendas`
--

INSERT INTO `tipoViviendas` (`tipoViviendaID`, `descripcion`) VALUES
(1, 'Alquilada'),
(2, 'Propia'),
(3, 'Familiar'),
(4, 'Pagándola'),
(5, 'Otros');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_responsabilidad`
--

CREATE TABLE `tipo_responsabilidad` (
  `responsabilidadID` int(11) NOT NULL,
  `descripcion` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tipo_responsabilidad`
--

INSERT INTO `tipo_responsabilidad` (`responsabilidadID`, `descripcion`) VALUES
(1, 'Individual'),
(2, 'Mancomunal');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `usuarioID` int(11) NOT NULL,
  `usuario` varchar(30) NOT NULL,
  `contrasenia` text NOT NULL,
  `rol` int(11) NOT NULL,
  `estado` tinyint(1) NOT NULL,
  `fechaCreacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`usuarioID`, `usuario`, `contrasenia`, `rol`, `estado`, `fechaCreacion`) VALUES
(1, 'remoteTest', '$2a$07$g5LY0JL5ydxNO44KHGL9UOALr8sbblkLLHONZUX5F9y2ZVAYzc8Le', 0, 1, '2017-04-14 11:53:20'),
(2, 'modulorhh', '$2a$07$hiSg8F.3YJf6PGfEB0diVOtr9DaRYnJr1X5XunTBrLR19ugjD7E06', 1, 1, '2017-07-10 17:23:19');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario_rol`
--

CREATE TABLE `usuario_rol` (
  `rolID` int(11) NOT NULL,
  `descripcion` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `usuario_rol`
--

INSERT INTO `usuario_rol` (`rolID`, `descripcion`) VALUES
(0, 'Administrador'),
(1, 'Analista de Recursos Humanos'),
(2, 'Analista de créditos'),
(3, 'Aprobador');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `condicion_prestamo`
--
ALTER TABLE `condicion_prestamo`
  ADD PRIMARY KEY (`prestamoID`);

--
-- Indices de la tabla `datosLaborales`
--
ALTER TABLE `datosLaborales`
  ADD PRIMARY KEY (`personaID`),
  ADD KEY `actividad_Empresa_FK` (`actividadEmpresaID`);

--
-- Indices de la tabla `empleadoDatos`
--
ALTER TABLE `empleadoDatos`
  ADD PRIMARY KEY (`personaID`);

--
-- Indices de la tabla `empresaActividades`
--
ALTER TABLE `empresaActividades`
  ADD PRIMARY KEY (`empresaActividadID`);

--
-- Indices de la tabla `estadosCivil`
--
ALTER TABLE `estadosCivil`
  ADD PRIMARY KEY (`estadoCivilID`);

--
-- Indices de la tabla `personas`
--
ALTER TABLE `personas`
  ADD PRIMARY KEY (`personaID`),
  ADD KEY `conyugue_FK` (`conyugueID`),
  ADD KEY `estado_civil_FK` (`estadoCivilID`),
  ADD KEY `tipoVivienda_FK` (`tipoViviendaID`);

--
-- Indices de la tabla `personas_contacto`
--
ALTER TABLE `personas_contacto`
  ADD PRIMARY KEY (`personaID`,`telefono`,`celular`);

--
-- Indices de la tabla `prestamos`
--
ALTER TABLE `prestamos`
  ADD PRIMARY KEY (`prestamoID`),
  ADD KEY `fiadorID_FK` (`fiadorID`),
  ADD KEY `tipo_prestamo_FK` (`tipoPrestamoID`),
  ADD KEY `responsabilidad_FK` (`responsabilidadID`),
  ADD KEY `prestamo_destino_FK` (`destinoID`);

--
-- Indices de la tabla `prestamo_destino`
--
ALTER TABLE `prestamo_destino`
  ADD PRIMARY KEY (`destinoID`);

--
-- Indices de la tabla `solicitudes`
--
ALTER TABLE `solicitudes`
  ADD PRIMARY KEY (`solicitudID`,`prestamoID`),
  ADD KEY `estadoID_FK` (`estadoID`),
  ADD KEY `prestamoID_FK` (`prestamoID`),
  ADD KEY `solicitante_FK` (`solicitanteID`),
  ADD KEY `tipo_solicitudes_FK` (`tipoSolicitudID`);

--
-- Indices de la tabla `solicitudesBitacora`
--
ALTER TABLE `solicitudesBitacora`
  ADD PRIMARY KEY (`solicitudID`,`estadoID`,`fecha`),
  ADD KEY `estadoIDBitacora_FK` (`estadoID`),
  ADD KEY `usuarioIDBitacora_FK` (`usuarioID`);

--
-- Indices de la tabla `solicitudEstados`
--
ALTER TABLE `solicitudEstados`
  ADD PRIMARY KEY (`estadoID`);

--
-- Indices de la tabla `solicitudes_referencia`
--
ALTER TABLE `solicitudes_referencia`
  ADD KEY `referencia_FK` (`solicitudID`);

--
-- Indices de la tabla `tipoPrestamos`
--
ALTER TABLE `tipoPrestamos`
  ADD PRIMARY KEY (`tipoPrestamosID`);

--
-- Indices de la tabla `tipoSolicitudes`
--
ALTER TABLE `tipoSolicitudes`
  ADD PRIMARY KEY (`tipoSolicitudID`);

--
-- Indices de la tabla `tipoViviendas`
--
ALTER TABLE `tipoViviendas`
  ADD PRIMARY KEY (`tipoViviendaID`);

--
-- Indices de la tabla `tipo_responsabilidad`
--
ALTER TABLE `tipo_responsabilidad`
  ADD PRIMARY KEY (`responsabilidadID`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`usuarioID`),
  ADD KEY `usuario_rol_FK` (`rol`);

--
-- Indices de la tabla `usuario_rol`
--
ALTER TABLE `usuario_rol`
  ADD PRIMARY KEY (`rolID`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `empresaActividades`
--
ALTER TABLE `empresaActividades`
  MODIFY `empresaActividadID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT de la tabla `estadosCivil`
--
ALTER TABLE `estadosCivil`
  MODIFY `estadoCivilID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT de la tabla `personas`
--
ALTER TABLE `personas`
  MODIFY `personaID` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `prestamos`
--
ALTER TABLE `prestamos`
  MODIFY `prestamoID` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `prestamo_destino`
--
ALTER TABLE `prestamo_destino`
  MODIFY `destinoID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT de la tabla `solicitudes`
--
ALTER TABLE `solicitudes`
  MODIFY `solicitudID` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `solicitudEstados`
--
ALTER TABLE `solicitudEstados`
  MODIFY `estadoID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT de la tabla `tipoPrestamos`
--
ALTER TABLE `tipoPrestamos`
  MODIFY `tipoPrestamosID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT de la tabla `tipoSolicitudes`
--
ALTER TABLE `tipoSolicitudes`
  MODIFY `tipoSolicitudID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT de la tabla `tipoViviendas`
--
ALTER TABLE `tipoViviendas`
  MODIFY `tipoViviendaID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT de la tabla `tipo_responsabilidad`
--
ALTER TABLE `tipo_responsabilidad`
  MODIFY `responsabilidadID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `usuarioID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT de la tabla `usuario_rol`
--
ALTER TABLE `usuario_rol`
  MODIFY `rolID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `condicion_prestamo`
--
ALTER TABLE `condicion_prestamo`
  ADD CONSTRAINT `condicion_FK` FOREIGN KEY (`prestamoID`) REFERENCES `prestamos` (`prestamoID`);

--
-- Filtros para la tabla `datosLaborales`
--
ALTER TABLE `datosLaborales`
  ADD CONSTRAINT `actividad_Empresa_FK` FOREIGN KEY (`actividadEmpresaID`) REFERENCES `empresaActividades` (`empresaActividadID`),
  ADD CONSTRAINT `personaID_FK` FOREIGN KEY (`personaID`) REFERENCES `personas` (`personaID`);

--
-- Filtros para la tabla `personas`
--
ALTER TABLE `personas`
  ADD CONSTRAINT `conyugue_FK` FOREIGN KEY (`conyugueID`) REFERENCES `personas` (`personaID`),
  ADD CONSTRAINT `estado_civil_FK` FOREIGN KEY (`estadoCivilID`) REFERENCES `estadosCivil` (`estadoCivilID`),
  ADD CONSTRAINT `tipoVivienda_FK` FOREIGN KEY (`tipoViviendaID`) REFERENCES `tipoViviendas` (`tipoViviendaID`);

--
-- Filtros para la tabla `prestamos`
--
ALTER TABLE `prestamos`
  ADD CONSTRAINT `fiadorID_FK` FOREIGN KEY (`fiadorID`) REFERENCES `personas` (`personaID`),
  ADD CONSTRAINT `prestamo_destino_FK` FOREIGN KEY (`destinoID`) REFERENCES `prestamo_destino` (`destinoID`),
  ADD CONSTRAINT `responsabilidad_FK` FOREIGN KEY (`responsabilidadID`) REFERENCES `tipo_responsabilidad` (`responsabilidadID`),
  ADD CONSTRAINT `tipo_prestamo_FK` FOREIGN KEY (`tipoPrestamoID`) REFERENCES `tipoPrestamos` (`tipoPrestamosID`);

--
-- Filtros para la tabla `solicitudes`
--
ALTER TABLE `solicitudes`
  ADD CONSTRAINT `estadoID_FK` FOREIGN KEY (`estadoID`) REFERENCES `solicitudEstados` (`estadoID`),
  ADD CONSTRAINT `prestamoID_FK` FOREIGN KEY (`prestamoID`) REFERENCES `prestamos` (`prestamoID`),
  ADD CONSTRAINT `solicitante_FK` FOREIGN KEY (`solicitanteID`) REFERENCES `personas` (`personaID`),
  ADD CONSTRAINT `tipo_solicitudes_FK` FOREIGN KEY (`tipoSolicitudID`) REFERENCES `tipoSolicitudes` (`tipoSolicitudID`);

--
-- Filtros para la tabla `solicitudes_referencia`
--
ALTER TABLE `solicitudes_referencia`
  ADD CONSTRAINT `referencia_FK` FOREIGN KEY (`solicitudID`) REFERENCES `solicitudes` (`solicitudID`);

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuario_rol_FK` FOREIGN KEY (`rol`) REFERENCES `usuario_rol` (`rolID`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

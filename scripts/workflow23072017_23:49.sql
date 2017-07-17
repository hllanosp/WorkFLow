-- phpMyAdmin SQL Dump
-- version 4.4.3
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jul 14, 2017 at 07:49 
-- Server version: 5.6.24
-- PHP Version: 5.6.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `workflow`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_CREAR_SOLICITUD`(IN `card1_tipoSolicitud` INT, IN `card1_tipoPrestamo` INT, IN `card2_Pnombre` VARCHAR(30), IN `card2_Snombre` VARCHAR(30), IN `card2_Papellido` VARCHAR(30), IN `card2_Sapellido` VARCHAR(30), IN `card2_identidad` VARCHAR(13), IN `card2_RTN` VARCHAR(14), IN `card2_edad` INT, IN `card2_sexo` CHAR(1), IN `card2_tipoVivienda` INT, IN `card2_pagoVivienda` DOUBLE, IN `card2_fechaNacimiento` VARCHAR(10), IN `card2_lugarNaci` VARCHAR(100), IN `card2_direccion` VARCHAR(100), IN `card2_nacionalidad` VARCHAR(50), IN `card2_residencia` VARCHAR(100), IN `card2_ocupacion` VARCHAR(100), IN `card2_email` VARCHAR(100), IN `card2_tel` VARCHAR(15), IN `card2_cel` VARCHAR(15), IN `card2_estadoCivil` INT, IN `card2_dependientes` INT, IN `card2_hijos` INT, IN `card3_cant` DOUBLE, IN `card3_plazo` INT, IN `card3_destino` INT(11), IN `card4_empresa` VARCHAR(50), IN `card4_sueldo` DOUBLE, IN `card4_tiempo` INT, IN `card4_cargo` VARCHAR(100), IN `card4_otroIngreso` VARCHAR(100), IN `card4_direccion` VARCHAR(100), IN `card4_telefono` VARCHAR(36), IN `card4_telefonoExt` VARCHAR(5), IN `card4_jefe` VARCHAR(100), IN `card4_selectActividad` INT, IN `card5_Pnombre` VARCHAR(30), IN `card5_Snombre` VARCHAR(30), IN `card5_Papellido` VARCHAR(30), IN `card5_Sapellido` VARCHAR(30), IN `card5_identidad` VARCHAR(14), IN `card5_fechaNacimiento` VARCHAR(10), IN `card5_profesion` VARCHAR(100), IN `card5_ingresoMensual` DOUBLE, IN `card5_lugarLabor` VARCHAR(100), IN `card5_cargo` VARCHAR(100), IN `card5_tel` VARCHAR(30), IN `card5_cel` VARCHAR(30), IN `card5_tipoVivienda` INT(11), IN `card5_pagoVivienda` DOUBLE, IN `card6_Pnombre` VARCHAR(30), IN `card6_Snombre` VARCHAR(30), IN `card6_Papellido` VARCHAR(30), IN `card6_Sapellido` VARCHAR(30), IN `card6_identidad` VARCHAR(13), IN `card6_residencia` VARCHAR(100), IN `card6_direccion` VARCHAR(100), IN `card6_tel` VARCHAR(30), IN `card6_cel` VARCHAR(30), IN `card6_email` VARCHAR(100), IN `card6_estadoCivil` INT, IN `card6_dependientes` INT, IN `card6_empresa` VARCHAR(100), IN `card6_posicion` VARCHAR(100), IN `card6_tiempoServicio` INT, IN `card6_sueldoMensual` DOUBLE, IN `card6_otrosIngresos` DOUBLE, IN `card6_empresaTel` VARCHAR(30), IN `card6_empresaExt` VARCHAR(5), IN `card6_jefe` VARCHAR(100), IN `card6_selectActividad` INT, IN `card7_nombre` VARCHAR(30), IN `card7_tel` VARCHAR(30), IN `card7_trabajo` VARCHAR(30), IN `card7_parentesco` VARCHAR(30), IN `card7_nombre2` VARCHAR(30), IN `card7_tel2` VARCHAR(30), IN `card7_trabajo2` VARCHAR(30), IN `card7_parentesco2` VARCHAR(30), IN `card8_nombre` VARCHAR(30), IN `card8_tel` VARCHAR(30), IN `card8_trabajo` VARCHAR(30), IN `card8_parentesco` VARCHAR(30), IN `usuarioID` INT(11), OUT `mensajeError` VARCHAR(100), OUT `codigoError` INT(11))
BEGIN
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
		sueldo
		) 
	VALUES(
		CONYUGUE_ID,
		card5_lugarLabor, 
		card5_cargo,
		card5_ingresoMensual
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
		estadoCivilID
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
		card6_estadoCivil
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
		actividadEmpresaID
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
		card6_selectActividad
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_EDITAR_APRO`(IN `solicitudID` INT(11), IN `card1_tipoSolicitud` INT, IN `card1_tipoPrestamo` INT, IN `card1_prestamoID` INT, IN `card3_destino` INT(11), IN `card1_responsabilidad` INT, IN `card1_tipoAprobacion` BOOLEAN, IN `card2_Pnombre` VARCHAR(30), IN `card2_Snombre` VARCHAR(30), IN `card2_Papellido` VARCHAR(30), IN `card2_Sapellido` VARCHAR(30), IN `card2_identidad` VARCHAR(30), IN `card2_RTN` VARCHAR(14), IN `card2_sexo` CHAR(1), IN `card2_estadoCivil` INT, IN `card4_jefe` VARCHAR(100), IN `card4_tiempo` INT, IN `card6_Pnombre` VARCHAR(30), IN `card6_Snombre` VARCHAR(30), IN `card6_Papellido` VARCHAR(30), IN `card6_Sapellido` VARCHAR(30), IN `card6_identidad` VARCHAR(13), IN `card6_empresa` VARCHAR(100), IN `card4_monto` DOUBLE, IN `card4_plazoap` INT, IN `card4_cuota` DOUBLE, IN `card4_interes` DOUBLE, IN `card4_RCI` DOUBLE, IN `card4_TDI` DOUBLE, IN `card4_analista` VARCHAR(200), IN `card4_confirmacion` BOOLEAN, IN `card2_fechaNaci` VARCHAR(10), IN `card4_garantia` VARCHAR(200), IN `card2_jefe` VARCHAR(100), OUT `codigoError` INT, OUT `mensajeError` VARCHAR(100))
BEGIN
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_EDITAR_CREDITOS`(IN `solicitudID` INT(11), IN `card1_tipoSolicitud` INT, IN `card1_tipoPrestamo` INT, IN `card1_prestamoID` INT, IN `card3_destino` INT(11), IN `card1_responsabilidad` INT, IN `card1_tipoAprobacion` BOOLEAN, IN `card2_Pnombre` VARCHAR(30), IN `card2_Snombre` VARCHAR(30), IN `card2_Papellido` VARCHAR(30), IN `card2_Sapellido` VARCHAR(30), IN `card2_identidad` VARCHAR(30), IN `card2_RTN` VARCHAR(14), IN `card2_sexo` CHAR(1), IN `card2_estadoCivil` INT, IN `card4_jefe` VARCHAR(100), IN `card4_tiempo` INT, IN `card6_Pnombre` VARCHAR(30), IN `card6_Snombre` VARCHAR(30), IN `card6_Papellido` VARCHAR(30), IN `card6_Sapellido` VARCHAR(30), IN `card6_identidad` VARCHAR(13), IN `card6_empresa` VARCHAR(100), IN `card4_monto` DOUBLE, IN `card4_plazoap` INT, IN `card4_cuota` DOUBLE, IN `card4_interes` DOUBLE, IN `card4_RCI` DOUBLE, IN `card4_TDI` DOUBLE, IN `card4_analista` VARCHAR(200), IN `card4_confirmacion` BOOLEAN, IN `card2_fechaNaci` VARCHAR(10), IN `card4_garantia` VARCHAR(200), IN `card2_jefe` VARCHAR(100), OUT `codigoError` INT, OUT `mensajeError` VARCHAR(100))
BEGIN
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_EDITAR_SOLICITUD`(IN `solicitudID` INT(11), IN `card1_tipoSolicitud` INT, IN `card1_tipoPrestamo` INT, IN `card2_Pnombre` VARCHAR(30), IN `card2_Snombre` VARCHAR(30), IN `card2_Papellido` VARCHAR(30), IN `card2_Sapellido` VARCHAR(30), IN `card2_identidad` VARCHAR(14), IN `card2_RTN` VARCHAR(14), IN `card2_sexo` CHAR(1), IN `card2_tipoVivienda` INT, IN `card2_pagoVivienda` DOUBLE, IN `card2_fechaNacimiento` VARCHAR(10), IN `card2_lugarNaci` VARCHAR(100), IN `card2_direccion` VARCHAR(100), IN `card2_nacionalidad` VARCHAR(50), IN `card2_residencia` VARCHAR(100), IN `card2_ocupacion` VARCHAR(100), IN `card2_email` VARCHAR(100), IN `card2_tel` VARCHAR(15), IN `card2_cel` VARCHAR(15), IN `card2_estadoCivil` INT, IN `card2_dependientes` INT, IN `card2_hijos` INT, IN `card3_cant` DOUBLE, IN `card3_plazo` INT, IN `card3_destino` INT(11), IN `card4_empresa` VARCHAR(50), IN `card4_sueldo` DOUBLE, IN `card4_tiempo` INT, IN `card4_cargo` VARCHAR(100), IN `card4_otroIngreso` VARCHAR(100), IN `card4_direccion` VARCHAR(100), IN `card4_telefono` VARCHAR(36), IN `card4_telefonoExt` VARCHAR(5), IN `card4_jefe` VARCHAR(100), IN `card4_selectActividad` INT, IN `card5_Pnombre` VARCHAR(30), IN `card5_Snombre` VARCHAR(30), IN `card5_Papellido` VARCHAR(30), IN `card5_Sapellido` VARCHAR(30), IN `card5_identidad` VARCHAR(14), IN `card5_fechaNacimiento` VARCHAR(10), IN `card5_profesion` VARCHAR(100), IN `card5_ingresoMensual` DOUBLE, IN `card5_lugarLabor` VARCHAR(100), IN `card5_cargo` VARCHAR(100), IN `card5_tel` VARCHAR(30), IN `card5_cel` VARCHAR(30), IN `card5_tipoVivienda` INT(11), IN `card5_pagoVivienda` DOUBLE, IN `card6_Pnombre` VARCHAR(30), IN `card6_Snombre` VARCHAR(30), IN `card6_Papellido` VARCHAR(30), IN `card6_Sapellido` VARCHAR(30), IN `card6_identidad` VARCHAR(13), IN `card6_residencia` VARCHAR(100), IN `card6_direccion` VARCHAR(100), IN `card6_tel` VARCHAR(30), IN `card6_cel` VARCHAR(30), IN `card6_email` VARCHAR(100), IN `card6_estadoCivil` INT, IN `card6_dependientes` INT, IN `card6_empresa` VARCHAR(100), IN `card6_posicion` VARCHAR(100), IN `card6_tiempoServicio` INT, IN `card6_sueldoMensual` DOUBLE, IN `card6_otrosIngresos` DOUBLE, IN `card6_empresaTel` VARCHAR(30), IN `card6_empresaExt` VARCHAR(5), IN `card6_jefe` VARCHAR(100), IN `card6_selectActividad` INT, IN `card7_nombre` VARCHAR(30), IN `card7_tel` VARCHAR(30), IN `card7_trabajo` VARCHAR(30), IN `card7_parentesco` VARCHAR(30), IN `card7_nombre2` VARCHAR(30), IN `card7_tel2` VARCHAR(30), IN `card7_trabajo2` VARCHAR(30), IN `card7_parentesco2` VARCHAR(30), IN `card8_nombre` VARCHAR(30), IN `card8_tel` VARCHAR(30), IN `card8_trabajo` VARCHAR(30), IN `card8_parentesco` VARCHAR(30), IN `usuarioID` INT(11), OUT `codigoError` INT, OUT `mensajeError` VARCHAR(100))
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
            posicion = card5_cargo , 
            sueldo = card5_ingresoMensual
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
           estadoCivilID = card6_estadoCivil
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
            actividadEmpresaID = card6_selectActividad
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ENVIAR_SOLICITUD`(IN `solicitud_ID` INT(11), IN `nuevoEstado` INT, IN `usuarioID` INT, IN `comentario` VARCHAR(200), OUT `codigoError` INT, OUT `mensajeError` VARCHAR(100))
BEGIN
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ENVIAR_SOLICITUD_APRO`(IN `solicitud_ID` INT(11), IN `nuevoEstado` INT, IN `usuarioID` INT, IN `comentario` VARCHAR(200), OUT `codigoError` INT, OUT `mensajeError` VARCHAR(100))
BEGIN
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ENVIAR_SOLICITUD_CREDITOS`(IN `solicitud_ID` INT(11), IN `nuevoEstado` INT, IN `usuarioID` INT, IN `comentario` VARCHAR(200), OUT `codigoError` INT, OUT `mensajeError` VARCHAR(100))
BEGIN
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ENVIAR_SOLICITUD_RRHH`(IN `solicitudID` INT, IN `rrhh_salarioBruto` DOUBLE, IN `rrhh_salarioConDeduccion` DOUBLE, IN `rrhh_derechos` DOUBLE, IN `rrhh_antiguedad` DOUBLE, IN `rrhh_comentario` VARCHAR(200), IN `nuevoEstado` INT, IN `usuarioID` INT, OUT `mensajeError` VARCHAR(100), OUT `codigoError` INT(11))
BEGIN
	
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_OBTENER_APRO`(OUT `codigoError` INT, OUT `mensajeError` VARCHAR(200), IN `solicitudID` INT)
    NO SQL
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_OBTENER_COMENTARIOS`(IN `solicitudID` INT, OUT `codigoError` INT, OUT `mensajeError` VARCHAR(200))
    NO SQL
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_OBTENER_CREDITOS`(OUT `codigoError` INT, OUT `mensajeError` VARCHAR(200), IN `solicitudID` INT)
    NO SQL
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_OBTENER_REFERENCIAS`(OUT `codigoError` INT, OUT `mensajeError` VARCHAR(200), IN `solicitud_id` INT)
    NO SQL
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_OBTENER_RRHH`(IN solicitudID INT(11), OUT codigoError INT(11), OUT mensajeError VARCHAR(200))
    NO SQL
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_OBTENER_SOLICITUD`(OUT `codigoError` INT, OUT `mensajeError` VARCHAR(200), IN `solicitudID` INT)
    NO SQL
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
    fiador_datosLaborales.actividadEmpresaID as fiador_ActividadEmpresa
    
    
    

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

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_PRUEBA`(IN `solicitudID` INT(11), IN `card1_tipoSolicitud` INT, IN `card1_tipoPrestamo` INT, IN `card2_Pnombre` VARCHAR(30), IN `card2_Snombre` VARCHAR(30), IN `card2_Papellido` VARCHAR(30), IN `card2_Sapellido` VARCHAR(30), IN `card2_RTN` VARCHAR(14), IN `card2_sexo` CHAR(1), IN `card2_tipoVivienda` INT, IN `card2_fechaNacimiento` VARCHAR(10), IN `card2_lugarNaci` VARCHAR(100), IN `card2_direccion` VARCHAR(100), IN `card2_nacionalidad` VARCHAR(50), IN `card2_residencia` VARCHAR(100), IN `card2_ocupacion` VARCHAR(100), IN `card2_email` VARCHAR(100), IN `card2_tel` VARCHAR(15), IN `card2_cel` VARCHAR(15), IN `card2_estadoCivil` INT, IN `card2_dependientes` INT, IN `card2_hijos` INT, IN `usuarioID` INT(11), OUT `codigoError` INT, OUT `mensajeError` VARCHAR(100))
BEGIN
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_TRAER_SOLICITUDES`(OUT `codigoError` INT, OUT `mensajeError` VARCHAR(100))
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_TRAER_SOLICITUDES_APRO`(OUT `codigoError` INT, OUT `mensajeError` VARCHAR(100))
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_TRAER_SOLICITUDES_CREDITOS`(OUT `codigoError` INT, OUT `mensajeError` VARCHAR(100))
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_TRAER_SOLICITUDES_RRHH`(OUT `codigoError` INT, OUT `mensajeError` VARCHAR(100))
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
    
		SELECT solicitudes.solicitudID,
		solicitudes.estadoID, 
		(SELECT solicitudesBitacora.fecha FROM solicitudesBitacora WHERE solicitudesBitacora.solicitudID = solicitudes.solicitudID AND solicitudesBitacora.estadoID = 1 ) fechaCreacion, 
		solicitante.identidad,
		CONCAT(solicitante.Pnombre , ' ' , solicitante.Papellido) AS solicitanteNombre,
		tipoSolicitudes.descripcion AS tipoSolicitud
		FROM solicitudes
		INNER JOIN personas as solicitante ON solicitudes.solicitanteID = solicitante.personaID
		INNER JOIN tipoSolicitudes ON solicitudes.tipoSolicitudID = tipoSolicitudes.tipoSolicitudID 
        WHERE solicitudes.tipoSolicitudID = 1 and solicitudes.estadoID in (2,3,5,6,7);
        
	COMMIT;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `condicion_prestamo`
--

CREATE TABLE IF NOT EXISTS `condicion_prestamo` (
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

--
-- Dumping data for table `condicion_prestamo`
--

INSERT INTO `condicion_prestamo` (`prestamoID`, `monto_aprobado`, `plazo_aprobado`, `cuota_nivelada`, `tasa_interes`, `descrpicion_garantia`, `RCI`, `TDI`, `confirmacion`, `comentario_analista`) VALUES
(38, 23.05, 10, 6.86, 6.94, 'asasdssss', 7.11, 6.92, 1, '34h'),
(39, 0.00, 0, 0.00, 0.00, '0', 0.00, 0.00, 0, '0'),
(40, 0.00, 0, 0.00, 0.00, '0', 0.00, 0.00, 0, '0'),
(42, 3.00, 3, 3.00, 3.00, 'zzzz', 3.00, 3.00, 1, '999'),
(43, 234243.00, 234, 234.00, 234.00, 'aqweqwe', 3.00, 3.00, 1, 'sdfsdf'),
(44, 0.00, 0, 0.00, 0.00, NULL, 0.00, 0.00, 0, '0'),
(45, 0.00, 0, 0.00, 0.00, '0', 0.00, 0.00, 0, '0'),
(46, 0.00, 0, 0.00, 0.00, '0', 0.00, 0.00, 0, '0'),
(47, 843276400.00, 64, 88989.00, 999.99, 'POrr', 32.00, 23.00, 0, 'Rancoc'),
(48, 0.00, 0, 0.00, 0.00, '0', 0.00, 0.00, 0, '0'),
(49, 0.00, 0, 0.00, 0.00, '0', 0.00, 0.00, 0, '0'),
(50, 0.00, 0, 0.00, 0.00, '0', 0.00, 0.00, 0, '0'),
(51, 0.00, 0, 0.00, 0.00, '0', 0.00, 0.00, 0, '0'),
(52, 0.00, 0, 0.00, 0.00, '0', 0.00, 0.00, 0, '0'),
(53, 0.00, 0, 0.00, 0.00, '0', 0.00, 0.00, 0, '0'),
(54, 0.00, 0, 0.00, 0.00, '0', 0.00, 0.00, 0, '0'),
(55, 0.00, 0, 0.00, 0.00, '0', 0.00, 0.00, 0, '0'),
(56, 0.00, 0, 0.00, 0.00, '0', 0.00, 0.00, 0, '0'),
(57, 0.00, 0, 0.00, 0.00, '0', 0.00, 0.00, 0, '0'),
(58, 0.00, 0, 0.00, 0.00, '0', 0.00, 0.00, 0, '0'),
(59, 0.00, 0, 0.00, 0.00, '0', 0.00, 0.00, 0, '0'),
(60, 0.00, 0, 0.00, 0.00, '0', 0.00, 0.00, 0, '0'),
(61, 0.00, 0, 0.00, 0.00, '0', 0.00, 0.00, 0, '0');

-- --------------------------------------------------------

--
-- Table structure for table `datosLaborales`
--

CREATE TABLE IF NOT EXISTS `datosLaborales` (
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

--
-- Dumping data for table `datosLaborales`
--

INSERT INTO `datosLaborales` (`personaID`, `empresa`, `posicion`, `aniosTrabajo`, `sueldo`, `jefeDirecto`, `otrosIngresos`, `telefono`, `extension`, `actividadEmpresaID`, `direccion`) VALUES
(117, 'INDAFddd', 'Maestra de quimicaddd', NULL, 15000.24, NULL, NULL, NULL, NULL, NULL, NULL),
(118, 'Santos y compania ', 'Supervisor de obrasd', 4, 38887.94, 'Martin Carrillos', 13123, '', '77', 3, NULL),
(119, 'DDsd', 'Jefe de recursos Humanossd', 4, 3423.16, 'Martin Carrillos', 3423434.17, '2321334', '77', 5, 'Saucesdfssdf'),
(120, 'asdsda', 'asdasd', NULL, 234234, NULL, NULL, NULL, NULL, NULL, NULL),
(121, 'QWEQWE', 'EQWEQE', 23, 343434, 'asdasd', 324234, '324234', NULL, 6, NULL),
(122, 'asdasd', 'dasd', 23, 2323, 'asdasd', 2332, '23423', NULL, 5, 'sadasd'),
(123, 'werwer', 'werwer', NULL, 242323, NULL, NULL, NULL, NULL, NULL, NULL),
(124, 'sadasd', 'ewrewr', 23, 3434434, 'ewrwer', 324234, '', '434', 5, NULL),
(125, 'werwer', 'ewrwer', 23, 23423, 'ewrwer', 234234, '234234', '', 2, 'werwer'),
(126, 'gfdgdfg', 'ertert', NULL, 345345, NULL, NULL, NULL, NULL, NULL, NULL),
(127, 'ertert', 'ertert', 445, 45455, 'treretert', 54545, NULL, '32423', 6, NULL),
(128, 'sadasdad', 'sdfsdf', 23, 2323, 'erwerwr', 234234, '34234', '', 4, 'sdfsdf'),
(129, 'ASDFASDF', 'ASDFASDF', NULL, 234, NULL, NULL, NULL, NULL, NULL, NULL),
(130, 'ASDF', 'ASDF', 1, 1234, 'SDFASDF', 123, NULL, '', 4, NULL),
(131, 'qwaeASD', 'ASDEF', 2, 1231, 'SDFASDF', 123, '12341234', '', 2, 'ASDF'),
(132, 'SJH', 'Cias', NULL, 234234, NULL, NULL, NULL, NULL, NULL, NULL),
(133, 'LIS', 'posicion', 18, 23332, 'Camilo Duron', 3232, '232323', NULL, 5, NULL),
(134, 'LIUA', 'Cargo', 18, 2332, 'Camilo Duron', 32232, '232232323', NULL, 4, 'Col, '),
(137, 'sfdsdfsdf', 'sdfsdfsdf', NULL, 2434234, NULL, NULL, NULL, NULL, NULL, NULL),
(138, 'sdfsdfsdf', 'sdfsdfsdf', 34234, 234, 'sdfsdfsdf', 234234, NULL, '', 4, NULL),
(139, 'dasdasd', 'fsdfsdf', 34234, 234234, 'sdfsdfsdf', 34234, '4234234', '', 3, 'sdfsdfsdf'),
(142, 'sdfsdfsdf', 'sdfsdfsdf', NULL, 234234, NULL, NULL, NULL, NULL, NULL, NULL),
(143, 'sdfsdf', 'sdfsdfsd', 2, 234234, 'sdfsdfsdf', 324234, '234234', NULL, 3, NULL),
(144, 'sdfsdfsdf', 'sdfsdfsdf', 234, 234, 'sdfsdfsdfsdf', 23423, '234234', NULL, 2, 'sdfsdfsdf'),
(145, '1', '1', NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL),
(146, 'sefin', 'jefe', 5, 25000, 'JORGE', 4000, NULL, '343', 1, NULL),
(147, 'Sefin', 'Jefe de Logistica', 5, 25000, 'Jorge Zuniga', 5000, '225576832', '', 1, 'Col Hato'),
(148, 'edsjdhsjd xxxx', 'sfsfsdf xxxx', NULL, 788888777, NULL, NULL, NULL, NULL, NULL, NULL),
(149, 'asdasd xxxxx hghghg', 'dsaasd xx', 4443, 88888, 'ella xxxx', 888, NULL, '343', 3, NULL),
(150, 'POZO xxx', 'seven days xxxx', 4443, 88888, 'ella xxxx', 999999, '888888', '', 3, 'pozo xxxx'),
(151, 'asdad', 'asasdasd', NULL, 234234, NULL, NULL, NULL, NULL, NULL, NULL),
(152, 'asdasd', 'asdasd', 234234, 234234, 'asdasdasd', 24234, NULL, '', 3, NULL),
(153, 'asdads', 'asdasd', 234234, 34243, 'asdsadasd', 324234, '234234', '', 3, 'asdasd'),
(154, 'asd', 'sadf', NULL, 324342, NULL, NULL, NULL, NULL, NULL, NULL),
(155, 'fff', 'ggg', 0, 0, '', 0, NULL, '', 3, NULL),
(156, 'asdf', 'asdf', 0, 0, 'asdf', 0, '', '', 3, ''),
(160, '444', '444', NULL, 444, NULL, NULL, NULL, NULL, NULL, NULL),
(161, 'rrr', 'rrr', 33, 4, 'fff', 4, '4', NULL, 3, NULL),
(162, 'ff', 'fff', 33, 33, 'fff', 333, '333', NULL, 1, 'fff'),
(163, '444', '444', NULL, 444, NULL, NULL, NULL, NULL, NULL, NULL),
(164, 'rrr', 'rrr', 4, 4, 'ggg', 4, NULL, '', 3, NULL),
(165, 'ff', 'fff', 33, 33, 'fff', 333, '333', '', 1, 'fff'),
(166, 'INDAFddd', 'Maestra de quimicaddd', NULL, 15000, NULL, NULL, NULL, NULL, NULL, NULL),
(167, 'Santos y compania', 'Supervisor de obrasd', 342, 38888, 'Martin Carrillosdf', 13123, NULL, '77', 3, NULL),
(168, 'DDsd', 'Jefe de recursos Humanossd', 342, 3423, 'Martin Carrillosdf', 3423434, '2321334', '77', 5, 'Saucesdfssdf'),
(169, 'INDAFddd', 'Maestra de quimicaddd', NULL, 15000, NULL, NULL, NULL, NULL, NULL, NULL),
(170, 'Santos y compania', 'Supervisor de obrasd', 342, 38888, 'Martin Carrillosdf', 13123, '', '77', 3, NULL),
(171, 'DDsd', 'Jefe de recursos Humanossd', 342, 3423, 'Martin Carrillosdf', 3423434, '2321334', '77', 5, 'Saucesdfssdf'),
(172, 'INDAFddd', 'Maestra de quimicaddd', NULL, 15000, NULL, NULL, NULL, NULL, NULL, NULL),
(173, 'Santos y compania', 'Supervisor de obrasd', 342, 38888, 'Martin Carrillosdf', 13123, NULL, '77', 3, NULL),
(174, 'DDsd', 'Jefe de recursos Humanossd', 342, 3423, 'Martin Carrillosdf', 3423434, '2321334', '77', 5, 'Saucesdfssdf'),
(175, 'INDAFddd', 'Maestra de quimicaddd', NULL, 15000, NULL, NULL, NULL, NULL, NULL, NULL),
(176, 'Santos y compania', 'Supervisor de obrasd', 342, 38888, 'Martin Carrillosdf', 13123, '', '77', 3, NULL),
(177, 'DDsd', 'Jefe de recursos Humanossd', 342, 3423, 'Martin Carrillosdf', 3423434, '2321334', '77', 5, 'Saucesdfssdf'),
(178, 'asdad', 'asasdasd', NULL, 234234, NULL, NULL, NULL, NULL, NULL, NULL),
(179, 'asdasd', 'asdasd', 234234, 234234, 'asdasdasd', 24234, NULL, '', 3, NULL),
(180, 'asdads', 'asdasd', 234234, 34243, 'asdsadasd', 324234, '234234', '', 3, 'asdasd'),
(181, 'INDAFddd', 'Maestra de quimicaddd', NULL, 15000, NULL, NULL, NULL, NULL, NULL, NULL),
(182, 'Santos y compania', 'Supervisor de obrasd', 342, 38888, 'Martin Carrillosdf', 13123, '', '77', 3, NULL),
(183, 'DDsd', 'Jefe de recursos Humanossd', 342, 3423, 'Martin Carrillosdf', 3423434, '2321334', '77', 5, 'Saucesdfssdf'),
(184, 'INDAFddd', 'Maestra de quimicaddd', NULL, 15000, NULL, NULL, NULL, NULL, NULL, NULL),
(185, 'Santos y compania', 'Supervisor de obrasd', 342, 38888, 'Martin Carrillosdf', 13123, '', '77', 3, NULL),
(186, 'DDsd', 'Jefe de recursos Humanossd', 342, 3423, 'Martin Carrillosdf', 3423434, '2321334', '77', 5, 'Saucesdfssdf'),
(187, 'INDAFddd', 'Maestra de quimicaddd', NULL, 15000, NULL, NULL, NULL, NULL, NULL, NULL),
(188, 'Santos y compania', 'Supervisor de obrasd', 342, 38888, 'Martin Carrillosdf', 13123, '', '77', 3, NULL),
(189, 'DDsd', 'Jefe de recursos Humanossd', 342, 3423, 'Martin Carrillosdf', 3423434, '2321334', '77', 5, 'Saucesdfssdf'),
(190, 'INDAFddd', 'Maestra de quimicaddd', NULL, 15000.24, NULL, NULL, NULL, NULL, NULL, NULL),
(191, 'Santos y compania ', 'Supervisor de obrasd', 3, 38887.94, 'Martin Carrillosdf', 13123, '23232323', '77', 3, NULL),
(192, 'DDsd', 'Jefe de recursos Humanossd', 3, 3423.16, 'Martin Carrillosdf', 3423434.17, '2321334', '77', 5, 'Saucesdfssdf'),
(193, 'asdsda', 'asdasd', NULL, 234234, NULL, NULL, NULL, NULL, NULL, NULL),
(194, 'QWEQWE', 'EQWEQE', 23, 343434, 'asdasd', 324234, '324234', '', 6, NULL),
(195, 'asdasd', 'dasd', 23, 2323, 'asdasd', 2332, '23423', '', 5, 'sadasd');

-- --------------------------------------------------------

--
-- Table structure for table `empleadoDatos`
--

CREATE TABLE IF NOT EXISTS `empleadoDatos` (
  `personaID` int(11) NOT NULL,
  `salarioBruto` double NOT NULL,
  `salarioConDeduccion` double NOT NULL,
  `derechos` double NOT NULL,
  `tiempoLabor` int(11) NOT NULL,
  `comentario` varchar(200) COLLATE latin1_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

--
-- Dumping data for table `empleadoDatos`
--

INSERT INTO `empleadoDatos` (`personaID`, `salarioBruto`, `salarioConDeduccion`, `derechos`, `tiempoLabor`, `comentario`) VALUES
(119, 234234, 34234, 234, 234234, 'dsa'),
(122, 3432, 234234, 324, 234, 'sdfsd'),
(125, 423423, 234, 234, 234, 'paselo a credito'),
(128, 345345, 5345, 34534, 345345, 'pasalo'),
(131, 123, 123, 123, 123, 'ASDFASDF'),
(134, 232, 2323, 2323, 2323, 'as'),
(139, 34234, 234, 342, 324, 'paselo'),
(144, 23423.02, 23424.01, 233.99, 2, '34'),
(147, 0, 0, 0, 0, '0'),
(150, 34834563, 236726372, 237632, 2323, 'Vamos para analista de créditos '),
(192, 2, 2, 2, 2, 'comentario de RRHH');

-- --------------------------------------------------------

--
-- Table structure for table `empresaActividades`
--

CREATE TABLE IF NOT EXISTS `empresaActividades` (
  `empresaActividadID` int(11) NOT NULL,
  `descripcion` varchar(200) COLLATE latin1_spanish_ci NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

--
-- Dumping data for table `empresaActividades`
--

INSERT INTO `empresaActividades` (`empresaActividadID`, `descripcion`) VALUES
(1, 'Servicios financieros'),
(2, 'Educación'),
(3, 'Transporte'),
(4, 'Industria'),
(5, 'Gobierno'),
(6, 'Agricultura');

-- --------------------------------------------------------

--
-- Table structure for table `estadosCivil`
--

CREATE TABLE IF NOT EXISTS `estadosCivil` (
  `estadoCivilID` int(11) NOT NULL,
  `descripcion` varchar(200) COLLATE latin1_spanish_ci NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

--
-- Dumping data for table `estadosCivil`
--

INSERT INTO `estadosCivil` (`estadoCivilID`, `descripcion`) VALUES
(1, 'Soltero'),
(2, 'Casado'),
(3, 'Otros');

-- --------------------------------------------------------

--
-- Table structure for table `personas`
--

CREATE TABLE IF NOT EXISTS `personas` (
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
) ENGINE=InnoDB AUTO_INCREMENT=196 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

--
-- Dumping data for table `personas`
--

INSERT INTO `personas` (`personaID`, `identidad`, `Pnombre`, `Snombre`, `Papellido`, `Sapellido`, `RTN`, `sexo`, `fechaNacimiento`, `direccion`, `residencia`, `lugarNacimiento`, `nacionalidad`, `ocupacion`, `dependientes`, `hijos`, `estadoCivilID`, `tipoViviendaID`, `pago_mensualVivienda`, `conyugueID`) VALUES
(117, '23', 'Mariasd', 'Teresa', 'De Calcutaeeee', 'Sapobledor', NULL, NULL, '2017-03-08', NULL, NULL, NULL, NULL, 'Docentedsd', NULL, NULL, NULL, 4, 888.45, NULL),
(118, '0273337', 'Carlos', 'Enrrique', 'Aguilar', 'Palma', NULL, NULL, NULL, 'Col. La orquidea', 'TGU', NULL, NULL, NULL, 4, NULL, 2, 4, 666, NULL),
(119, '22', 'Norberto ', 'Casimiroa', 'Paguada', 'Tavora', '823878', 'M', '1973-07-02', 'Col. Alameda', 'Col. Pasqual', 'T', 'hondurenio ', 'Lic. Relaciones Publicasss', 2, 2, 1, 2, 777.15, 117),
(120, '324234', 'asdasd', 'asda', 'asd', 'asdasd', NULL, NULL, '2013-05-02', NULL, NULL, NULL, NULL, 'dadasd', NULL, NULL, NULL, 1, NULL, NULL),
(121, '234234', 'asdasd', 'asd', 'sda', 'sd', NULL, NULL, NULL, 'eqweqwe', 'deqweqwe', NULL, NULL, NULL, 2, NULL, 2, NULL, NULL, NULL),
(122, '23213', 'Mario', 'Hector', 'Figueroa', 'Moncada', '123213', 'F', '2003-03-01', 'dfsdfsd', 'sadasd', 'weqwe', 'asdd', 'asdsad', 1, 1, 1, 2, NULL, 120),
(123, '234234', 'werwer', 'wer', 'ewrwer', 'werwer', NULL, NULL, '2013-03-04', NULL, NULL, NULL, NULL, 'werwer', NULL, NULL, NULL, 2, 0, NULL),
(124, '234234', 'asdasd', 'asd', 'asdasd', 'asd', NULL, NULL, NULL, 'werwer', 'werewr', NULL, NULL, NULL, 2, NULL, 2, NULL, NULL, NULL),
(125, '213123', 'asdasd', 'asdasd', 'asdasd', 'asdasd', '2323', 'M', '1965-05-01', 'asdasd', 'asdasd', 'asdasd', 'asdasd', 'asdasd', 1, 1, 2, 1, 0, 123),
(126, '23423424', 'sdfsdf', 'sdfsdf', 'sdfsdf', 'sdfsdf', NULL, NULL, '2013-04-03', NULL, NULL, NULL, NULL, 'sdfsdfsdf', NULL, NULL, NULL, 1, 0, NULL),
(127, '345345', 'ertert', 'ertert', 'tretert', 'ertert', NULL, NULL, NULL, 'erretert', 'ertert', NULL, NULL, NULL, 4, NULL, 2, NULL, NULL, NULL),
(128, '2312312', 'asdasd', 'asdasd', 'asdasd', 'asdasd', '23123', 'M', '1999-02-02', 'asdasd', 'asdasd', 'asdasd', 'asdasd', 'asdasdasd', 1, 1, 3, 1, 0, 126),
(129, '12341234', 'FFFF', '', 'HHHH', '', NULL, NULL, '2017-01-01', NULL, NULL, NULL, NULL, '1ASDFEWSRT', NULL, NULL, NULL, 2, 0, NULL),
(130, '984878489', 'BBBB', 'FF', 'CCCC', 'FF', NULL, NULL, NULL, 'KJLASDFUI', 'ASDFFF', NULL, NULL, NULL, 3, NULL, 2, NULL, NULL, NULL),
(131, '12341234', 'jjas', 'dsadf', 'Estrada', 'C', '7777777', 'M', '2017-05-02', 'asdf', 'asdf', 'asdf', 'asdf', 'lkjgh', 0, 0, 2, 1, 0, 129),
(132, '3212323', 'Carlos', 'Patricio ', 'Estrella', 'Fondo del mar', NULL, NULL, '1982-03-02', NULL, NULL, NULL, NULL, 'ocupacion', NULL, NULL, NULL, 1, NULL, NULL),
(133, '3213123', 'Roberto', 'Paaa', 'Palacios ', 'Gacuculta', NULL, NULL, NULL, 'Col', 'resi', NULL, NULL, NULL, 2, NULL, 2, NULL, NULL, NULL),
(134, '213123123', 'Juanquin', 'Martin', 'Flores ', 'Portillo', '234234234', 'M', '1991-04-02', 'Caol', 'col, la esquina', 'Casa', 'hn', 'ocupador', 1, 1, 1, 2, NULL, 132),
(137, '4234234', 'sdfsdfsdf', 'sdfsdfs', 'dfsdfs', 'dfsdfsdf', NULL, NULL, '2012-03-04', NULL, NULL, NULL, NULL, 'sdfsdf', NULL, NULL, NULL, 2, 0, NULL),
(138, '234234', 'sdfsdf', 'sdfsdf', 'sdfsdf', 'sdfsdf', NULL, NULL, NULL, 'sdfsdf', 'sdfsdfsdf', NULL, NULL, NULL, 2, NULL, 2, NULL, NULL, NULL),
(139, '1231231', 'werwerw', 'werwer', 'werwerwer', 'werwerwer', '78362612387123', 'M', '1999-03-02', 'sdfsdfsdf', 'sfsdfsdfsdf', 'dsfsdfsdfsdfsdf', 'fsdfsdfsf', 'sdfsdfsdf', 1, 1, 2, 2, 0, 137),
(142, '234234', 'sdfsdfsdf', 'sdfsdf', 'sdfsdfsdfsd', 'sdfsdfsdf', NULL, NULL, '1994-03-06', NULL, NULL, NULL, NULL, 'sdfsdfsdfsdfsf', NULL, NULL, NULL, 1, NULL, NULL),
(143, '234234', 'sdfsdfsdf', 'sdfsdf', 'sdfsdf', 'sdfsdfsdf', NULL, NULL, NULL, 'sdfsdfsdsdf', 'sdfsdfsdfsdf', NULL, NULL, NULL, 3, NULL, 2, NULL, NULL, NULL),
(144, '23123', 'sdfsdf', 'fsdfsdf', 'sdfsdfs', 'dfsdfsdf', '32423', 'F', '2001-05-01', 'sdfsdf', 'sdfsdf', 'sdfsdf', 'sdfsdf', 'sdfsdf', 2, 2, 2, 1, NULL, 142),
(145, '7', 'na', 'nan', 'na', 'na', NULL, NULL, '2017-01-02', NULL, NULL, NULL, NULL, '1', NULL, NULL, NULL, 2, 0, NULL),
(146, '908634479', 'Jenn', 'sUY', 'lOPE', 'Ma', NULL, NULL, NULL, 'Col', 'col', NULL, NULL, NULL, 1, NULL, 2, NULL, NULL, NULL),
(147, '08082198674', 'Eder', 'Jose', 'Ramirez', 'Guillen', '080821986748', 'M', '1984-05-01', 'Col. Hato de Enmedio', '', 'Tegucigalp', 'Hondure;a', 'Ingeniero', 0, 0, 1, 2, 0, 145),
(148, '2323232', 'aaaaaa xxx', 'aaaaaa xxx', 'aaaaaaaaa xxx', 'aaaaaaaaaa xxx', NULL, NULL, '1957-05-01', NULL, NULL, NULL, NULL, 'dsdsddsdsd xxxx', NULL, NULL, NULL, 2, 0, NULL),
(149, '347425632', 'dsudyusdyu xxx', 'mydsydusyu xxx', 'dsyusyduydu xxxx', 'sydusyduysu xxx', NULL, NULL, NULL, 'yustdystdytsd xxx', 'ystdystydtsydt xxxx', NULL, NULL, NULL, 66, NULL, 3, NULL, NULL, NULL),
(150, '2323232', 'Tamara yyy', 'Cacimira yyy', 'Sapobledor yyyy', 'Ring yyyy', '433434', 'F', '1978-01-02', 'faro xxx', 'pozo xxx', 'faro xxx', 'usa xxx', 'joder a la mara en 7 xxx', 1, 1, 3, 1, 0, 148),
(151, '34233234', 'asdasda', 'asdasd', 'asdasd', 'asdasd', NULL, NULL, '2011-06-06', NULL, NULL, NULL, NULL, 'asdasdasd', NULL, NULL, NULL, 2, 0, NULL),
(152, '4234234', 'adsadsad', 'asdasd', 'asdasd', 'asdasdasd', NULL, NULL, NULL, 'asdasdasd', 'adasda', NULL, NULL, NULL, 23, NULL, 2, NULL, NULL, NULL),
(153, '2343413222342', 'wwdwe', 'sdfsdf', 'sdfsdf', 'sdfsdf', '1', 'M', '1998-06-01', 'sfsdf', 'sdfsdf', 'sdfsdfsd', 'sdfsdfs', 'sdfsdf', 2, 2, 2, 2, 0, 151),
(154, '2134', 'asdf', '', 'asdf', '', NULL, NULL, '0000-00-00', NULL, NULL, NULL, NULL, 'asdf', NULL, NULL, NULL, 3, 0, NULL),
(155, '', '234', '', '', '', NULL, NULL, NULL, 'asdfasdf', '', NULL, NULL, NULL, 0, NULL, 3, NULL, 0, NULL),
(156, '333', 'dd', '', '', '', '', 'M', '2004-05-01', 'asdf', 'adf', 'sdfa', 'adsf', 'adfg', 123, 123, 2, 4, 0, 154),
(160, '44', 'fff', 'fff', 'ff', 'f', NULL, NULL, '2017-01-04', NULL, NULL, NULL, NULL, '444', NULL, NULL, NULL, 4, 66, NULL),
(161, '33', 'ff', 'fff', 'fff', 'fff', NULL, NULL, NULL, 'ffff', 'fff', NULL, NULL, NULL, 44, NULL, 1, NULL, 0, NULL),
(162, '233', 'asd', 'sd', 'sdsd', 'sdd', '333', 'M', '2001-04-01', 'fff', 'fff', 'fff', 'fff', 'fff', 3, 3, 1, 4, 666666, 160),
(163, '44', 'fff', 'fff', 'ff', 'f', NULL, NULL, '2017-01-04', NULL, NULL, NULL, NULL, '444', NULL, NULL, NULL, 4, 111, NULL),
(164, '33', 'ff', 'fff', 'fff', 'fff', NULL, NULL, NULL, 'ffff', 'fff', NULL, NULL, NULL, 44, NULL, 1, NULL, 0, NULL),
(165, '233', 'asd', 'sd', 'sdsd', 'sdd', '44443', 'M', '2001-04-01', 'fff', 'fff', 'fff', 'fff', 'fff', 3, 3, 1, 4, 1111, 163),
(166, '234234', 'Mariasd', 'Teresa', 'De Calcutaeeee', 'Sapobledor', NULL, NULL, '2017-03-08', NULL, NULL, NULL, NULL, 'Docentedsd', NULL, NULL, NULL, 4, 888, NULL),
(167, '4234234', 'Carlos', 'Enrrique', 'Aguilar', 'Palma', NULL, NULL, NULL, 'Col. La orquidea', 'TGU', NULL, NULL, NULL, 1, NULL, 2, NULL, 0, NULL),
(168, '8745784098587', 'Norberto ', 'Casimiroa', 'Paguada', 'Tavora', '777777777', 'F', '1999-05-02', 'Col. Alameda', 'Col. Pasqual', 'T', 'hondurenio ', 'Lic. Relaciones Publicasss', 2, 2, 1, 5, 777, 166),
(169, '234234', 'Mariasd', 'Teresa', 'De Calcutaeeee', 'Sapobledor', NULL, NULL, '2017-03-08', NULL, NULL, NULL, NULL, 'Docentedsd', NULL, NULL, NULL, 4, 888, NULL),
(170, '4234234', 'Carlos', 'Enrrique', 'Aguilar', 'Palma', NULL, NULL, NULL, 'Col. La orquidea', 'TGU', NULL, NULL, NULL, 1, NULL, 2, NULL, 0, NULL),
(171, '765546', 'Norberto ', 'Casimiroa', 'Paguada', 'Tavora', '45664532234444', 'F', '1999-05-02', 'Col. Alameda', 'Col. Pasqual', 'T', 'hondurenio ', 'Lic. Relaciones Publicasss', 2, 2, 1, 5, 777, 169),
(172, '234234', 'Mariasd', 'Teresa', 'De Calcutaeeee', 'Sapobledor', NULL, NULL, '2017-03-08', NULL, NULL, NULL, NULL, 'Docentedsd', NULL, NULL, NULL, 4, 888, NULL),
(173, '4234234', 'Carlos', 'Enrrique', 'Aguilar', 'Palma', NULL, NULL, NULL, 'Col. La orquidea', 'TGU', NULL, NULL, NULL, 1, NULL, 2, NULL, 0, NULL),
(174, '123723621', 'Pachamama', 'Augusta', 'Hernandez', 'Tavora', '234534534', 'F', '1999-05-02', 'Col. Alameda', 'Col. Pasqual', 'T', 'hondurenio ', 'Lic. Relaciones Publicasss', 2, 2, 1, 5, 777, 172),
(175, '234234', 'Mariasd', 'Teresa', 'De Calcutaeeee', 'Sapobledor', NULL, NULL, '2017-03-08', NULL, NULL, NULL, NULL, 'Docentedsd', NULL, NULL, NULL, 4, 888, NULL),
(176, '4234234', 'Carlos', 'Enrrique', 'Aguilar', 'Palma', NULL, NULL, NULL, 'Col. La orquidea', 'TGU', NULL, NULL, NULL, 1, NULL, 2, NULL, 0, NULL),
(177, '87346573', 'Norberto ', 'Casimiroa', 'Paguada', 'Tavora', '734634', 'F', '1999-05-02', 'Col. Alameda', 'Col. Pasqual', 'T', 'hondurenio ', 'Lic. Relaciones Publicasss', 2, 2, 1, 5, 777, 175),
(178, '34233234', 'asdasda', 'asdasd', 'asdasd', 'asdasd', NULL, NULL, '2011-06-06', NULL, NULL, NULL, NULL, 'asdasdasd', NULL, NULL, NULL, 2, 0, NULL),
(179, '4234234', 'adsadsad', 'asdasd', 'asdasd', 'asdasdasd', NULL, NULL, NULL, 'asdasdasd', 'adasda', NULL, NULL, NULL, 23, NULL, 2, NULL, 0, NULL),
(180, '3', 'wwdwe', 'sdfsdf', 'sdfsdf', 'sdfsdf', '9', 'M', '1998-06-01', 'sfsdf', 'sdfsdf', 'sdfsdfsd', 'sdfsdfs', 'sdfsdf', 2, 2, 2, 2, 0, 178),
(181, '234234', 'Mariasd', 'Teresa', 'De Calcutaeeee', 'Sapobledor', NULL, NULL, '2017-03-08', NULL, NULL, NULL, NULL, 'Docentedsd', NULL, NULL, NULL, 4, 888, NULL),
(182, '4234234', 'Carlos', 'Enrrique', 'Aguilar', 'Palma', NULL, NULL, NULL, 'Col. La orquidea', 'TGU', NULL, NULL, NULL, 1, NULL, 2, NULL, 0, NULL),
(183, '24234', 'Norberto ffff', 'Casimiroa fff', 'Paguadafff', 'fffTavora', '45664532234444', 'F', '1999-05-02', 'Col. Alameda', 'Col. Pasqual', 'T', 'hondurenio ', 'Lic. Relaciones Publicasss', 2, 2, 1, 5, 777, 181),
(184, '234234', 'Mariasd', 'Teresa', 'De Calcutaeeee', 'Sapobledor', NULL, NULL, '2017-03-08', NULL, NULL, NULL, NULL, 'Docentedsd', NULL, NULL, NULL, 4, 888, NULL),
(185, '4234234', 'Carlos', 'Enrrique', 'Aguilar', 'Palma', NULL, NULL, NULL, 'Col. La orquidea', 'TGU', NULL, NULL, NULL, 1, NULL, 2, NULL, 0, NULL),
(186, '24234', 'Norberto ffff xxxx', 'Casimiroa fffxxx', 'Paguadafffxxx', 'fffTavoraxxx', '45664532234444', 'F', '1999-05-02', 'Col. Alameda', 'Col. Pasqual', 'T', 'hondurenio ', 'Lic. Relaciones Publicasss', 2, 2, 1, 5, 777, 184),
(187, '234234', 'Mariasd', 'Teresa', 'De Calcutaeeee', 'Sapobledor', NULL, NULL, '2017-03-08', NULL, NULL, NULL, NULL, 'Docentedsd', NULL, NULL, NULL, 4, 888, NULL),
(188, '4234234', 'Carlos', 'Enrrique', 'Aguilar', 'Palma', NULL, NULL, NULL, 'Col. La orquidea', 'TGU', NULL, NULL, NULL, 1, NULL, 2, NULL, 0, NULL),
(189, '432434', 'Norberto ', 'Casimiroa', 'Paguada', 'Tavora', '12123', 'F', '1999-05-02', 'Col. Alameda', 'Col. Pasqual', 'T', 'hondurenio ', 'Lic. Relaciones Publicasss', 2, 2, 1, 5, 777, 187),
(190, '234234', 'Mariasd', 'Teresa', 'De Calcutaeeee', 'Sapobledor', NULL, NULL, '2017-03-08', NULL, NULL, NULL, NULL, 'Docentedsd', NULL, NULL, NULL, 4, 888.45, NULL),
(191, '4234234', 'Carlos', 'Enrrique', 'Aguilar', 'Palma', NULL, NULL, NULL, 'Col. La orquidea', 'TGU', NULL, NULL, NULL, 4, NULL, 2, NULL, 0, NULL),
(192, '3232323', 'Norberto ', 'Casimiroa', 'Paguada', 'Tavora', '343434', 'M', '1999-05-02', 'Col. Alameda', 'Col. Pasqual', 'T', 'hondurenio ', 'Lic. Relaciones Publicasss', 2, 2, 1, 2, 777.15, 190),
(193, '324234', 'asdasd', 'asda', 'asd', 'asdasd', NULL, NULL, '2013-05-02', NULL, NULL, NULL, NULL, 'dadasd', NULL, NULL, NULL, 1, 0, NULL),
(194, '234234', 'asdasd', 'asd', 'sda', 'sd', NULL, NULL, NULL, 'eqweqwe', 'deqweqwe', NULL, NULL, NULL, 2, NULL, 2, NULL, 0, NULL),
(195, '76562323', 'Mario', 'Hector', 'Figueroa', 'Moncada', '123213', 'F', '2003-03-01', 'dfsdfsd', 'sadasd', 'weqwe', 'asdd', 'asdsad', 1, 1, 1, 2, 0, 193);

-- --------------------------------------------------------

--
-- Table structure for table `personas_contacto`
--

CREATE TABLE IF NOT EXISTS `personas_contacto` (
  `personaID` int(11) NOT NULL,
  `telefono` varchar(30) COLLATE latin1_spanish_ci NOT NULL,
  `celular` varchar(30) COLLATE latin1_spanish_ci NOT NULL,
  `email` varchar(200) COLLATE latin1_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

--
-- Dumping data for table `personas_contacto`
--

INSERT INTO `personas_contacto` (`personaID`, `telefono`, `celular`, `email`) VALUES
(117, '234234', '234', ''),
(118, '234243', '3424', 'asdas@das.com'),
(119, '123123', '8934834234', 'norberto_tavora@gmail.com'),
(120, '234234', '234234', ''),
(121, '234234', '234234', 'dasda@ASD.COM'),
(122, '232132', '345435', 'asdas@das.com'),
(123, '324234', '24234', ''),
(124, '324234', '324234', 'werwer@dasd.com'),
(125, '123123', '234234', 'sdasdasd@df.com'),
(126, '2423434', '8984745', ''),
(127, '345345', '345345', 'tertert@dsad.com'),
(128, '234234234', '98763344', 'asdasd@dsa.com'),
(129, '1234', '1234', ''),
(130, '5546456', '45645656', 'ASDF@ASDF.COM'),
(131, '1234', '123412341', 'asdf@asdf.com'),
(132, '234234', '972346656', ''),
(133, '213123', '8712375', 'aas@sad.com'),
(134, '2343467', '882366', 'ad@gmail.com'),
(137, '3424234', '234234', ''),
(138, '342423', '234234', 'sdfsdf@ASDAS.COM'),
(139, '32423', '324234', 'fsdfsdfsd@asda.com'),
(142, '234234', '234234', ''),
(143, '234234', '234234', 'sdfsdf@dasd.com'),
(144, '32213', '3123', 'sdfsdf@asd.com'),
(145, '1', '1', ''),
(146, '334567898', '689809371', 'jenfer1983@hotmail.com'),
(147, '22553595', '99945789', 'redeesoj15@gmail.com'),
(148, '222222', '8888888', ''),
(149, '8888888', '8888888', 'ASAS@dssxxx.com'),
(150, '999999', '888888', 'sevenday@ringxxxx.com'),
(151, '34234234', '234234', ''),
(152, '234234', '234234', 'adsda@asd.com'),
(153, '2343232', '234234', 'ssdfsf@dasda.com'),
(154, '324', '345', ''),
(155, '', '3245', 'asdf@asdf.com'),
(156, '1234', '1234', 'sdfg@asdf.com'),
(160, '44', '44', ''),
(161, '444', '444', '444@asdf.com'),
(162, '3', '333', 'fff@gmail.com'),
(163, '44', '44', ''),
(164, '444', '444', '444@asdf.com'),
(165, '3', '333', 'fff@gmail.com'),
(166, '234234', '234', ''),
(167, '234243', '3424', 'asdas@das.com'),
(168, '123123', '8934834234', 'norberto_tavora@gmail.com'),
(169, '234234', '234', ''),
(170, '234243', '3424', 'asdas@das.com'),
(171, '123123', '8934834234', 'norberto_tavora@gmail.com'),
(172, '234234', '234', ''),
(173, '234243', '3424', 'asdas@das.com'),
(174, '123123', '8934834234', 'norberto_tavora@gmail.com'),
(175, '234234', '234', ''),
(176, '234243', '3424', 'asdas@das.com'),
(177, '123123', '8934834234', 'norberto_tavora@gmail.com'),
(178, '34234234', '234234', ''),
(179, '234234', '234234', 'adsda@asd.com'),
(180, '2343232', '234234', 'ssdfsf@dasda.com'),
(181, '234234', '234', ''),
(182, '234243', '3424', 'asdas@das.com'),
(183, '123123', '8934834234', 'norberto_tavora@gmail.com'),
(184, '234234', '234', ''),
(185, '234243', '3424', 'asdas@das.com'),
(186, '123123', '8934834234', 'norberto_tavora@gmail.com'),
(187, '234234', '234', ''),
(188, '234243', '3424', 'asdas@das.com'),
(189, '123123', '8934834234', 'norberto_tavora@gmail.com'),
(190, '234234', '234', ''),
(191, '234243', '3424', 'asdas@das.com'),
(192, '123123', '8934834234', 'norberto_tavora@gmail.com'),
(193, '234234', '234234', ''),
(194, '234234', '234234', 'dasda@ASD.COM'),
(195, '232132', '345435', 'asdas@das.com');

-- --------------------------------------------------------

--
-- Table structure for table `prestamos`
--

CREATE TABLE IF NOT EXISTS `prestamos` (
  `prestamoID` int(11) NOT NULL,
  `cantSolicitada` decimal(14,2) NOT NULL,
  `plazo` int(11) NOT NULL,
  `destinoID` int(11) NOT NULL,
  `tipoPrestamoID` int(11) NOT NULL,
  `fiadorID` int(11) NOT NULL,
  `responsabilidadID` int(11) DEFAULT NULL,
  `tipo_aprobacion` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `prestamos`
--

INSERT INTO `prestamos` (`prestamoID`, `cantSolicitada`, `plazo`, `destinoID`, `tipoPrestamoID`, `fiadorID`, `responsabilidadID`, `tipo_aprobacion`) VALUES
(38, '100001.98', 35, 2, 1, 118, 2, 1),
(39, '423423.00', 53, 1, 2, 121, 2, 0),
(40, '234234.00', 234, 2, 2, 124, 1, 1),
(41, '234234.05', 243, 1, 1, 127, NULL, NULL),
(42, '123.00', 123, 4, 3, 130, 1, 1),
(43, '23232.00', 2323, 1, 2, 133, 2, 1),
(44, '324234.00', 234234, 3, 3, 138, 2, 1),
(45, '234213.00', 334, 3, 2, 143, 2, 0),
(46, '500000.00', 22, 1, 3, 146, NULL, NULL),
(47, '888888888.00', 99999999, 1, 1, 149, 2, 1),
(48, '3242342.00', 234234, 7, 1, 152, NULL, NULL),
(49, '1234.00', 1, 3, 2, 155, NULL, NULL),
(50, '3.00', 3, 3, 1, 161, 1, 1),
(51, '3.00', 3, 3, 1, 164, NULL, NULL),
(52, '9999999999.00', 34, 2, 1, 167, NULL, NULL),
(53, '9999999999.00', 34, 2, 1, 170, NULL, NULL),
(54, '9999999999.00', 34, 2, 1, 173, NULL, NULL),
(55, '9999999999.00', 34, 2, 1, 176, NULL, NULL),
(56, '3242342.00', 234234, 7, 1, 179, NULL, NULL),
(57, '9999999999.00', 34, 2, 1, 182, NULL, NULL),
(58, '9999999999.00', 34, 2, 1, 185, NULL, NULL),
(59, '9999999999.00', 34, 2, 1, 188, NULL, NULL),
(60, '100001.98', 35, 3, 1, 191, 2, 1),
(61, '423423.00', 53, 1, 2, 194, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `prestamo_destino`
--

CREATE TABLE IF NOT EXISTS `prestamo_destino` (
  `destinoID` int(11) NOT NULL,
  `descripcion` varchar(200) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `prestamo_destino`
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
-- Table structure for table `solicitudes`
--

CREATE TABLE IF NOT EXISTS `solicitudes` (
  `solicitudID` int(11) NOT NULL,
  `solicitanteID` int(11) NOT NULL,
  `tipoSolicitudID` int(11) NOT NULL,
  `prestamoID` int(11) NOT NULL,
  `estadoID` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `solicitudes`
--

INSERT INTO `solicitudes` (`solicitudID`, `solicitanteID`, `tipoSolicitudID`, `prestamoID`, `estadoID`) VALUES
(38, 119, 1, 38, 5),
(39, 122, 1, 39, 5),
(40, 125, 1, 40, 5),
(41, 128, 1, 41, 5),
(42, 131, 1, 42, 5),
(43, 134, 1, 43, 5),
(44, 139, 1, 44, 5),
(45, 144, 1, 45, 2),
(46, 147, 1, 46, 7),
(47, 150, 1, 47, 5),
(48, 153, 1, 48, 2),
(49, 156, 1, 49, 2),
(50, 162, 2, 50, 5),
(51, 165, 2, 51, 3),
(52, 168, 1, 52, 1),
(53, 171, 1, 53, 1),
(54, 174, 1, 54, 2),
(55, 177, 1, 55, 1),
(56, 180, 1, 56, 1),
(57, 183, 1, 57, 1),
(58, 186, 1, 58, 1),
(59, 189, 1, 59, 1),
(60, 192, 1, 60, 4),
(61, 195, 1, 61, 1);

-- --------------------------------------------------------

--
-- Table structure for table `solicitudesBitacora`
--

CREATE TABLE IF NOT EXISTS `solicitudesBitacora` (
  `solicitudID` int(11) NOT NULL,
  `estadoID` int(11) NOT NULL,
  `fecha` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `usuarioID` int(11) NOT NULL,
  `comentario` varchar(200) COLLATE latin1_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

--
-- Dumping data for table `solicitudesBitacora`
--

INSERT INTO `solicitudesBitacora` (`solicitudID`, `estadoID`, `fecha`, `usuarioID`, `comentario`) VALUES
(38, 1, '2017-05-22 11:36:52', 1, 'Creación de Solicitud'),
(38, 2, '2017-05-22 11:42:58', 1, 'a'),
(38, 3, '2017-05-22 11:43:15', 1, 'dsa'),
(38, 4, '2017-05-22 12:52:45', 1, 'jj'),
(38, 5, '2017-05-23 22:39:26', 1, 'qq'),
(39, 1, '2017-05-22 11:40:22', 1, 'Creación de Solicitud'),
(39, 2, '2017-05-22 12:48:52', 1, 'k'),
(39, 3, '2017-05-22 12:49:04', 1, 'sdfsd'),
(39, 4, '2017-05-23 21:59:35', 1, 'a'),
(39, 5, '2017-05-23 22:49:31', 1, 'apruebela'),
(40, 1, '2017-05-23 21:00:15', 1, 'Creación de Solicitud'),
(40, 2, '2017-05-23 21:04:17', 1, 'paselo'),
(40, 3, '2017-05-23 21:04:31', 1, 'paselo a credito'),
(40, 4, '2017-05-23 21:04:45', 1, 'apruebelo'),
(40, 5, '2017-05-26 01:37:23', 1, 'aprobado'),
(41, 1, '2017-05-23 21:41:04', 1, 'Creación de Solicitud'),
(41, 2, '2017-05-23 21:41:16', 1, 'pasalo'),
(41, 3, '2017-05-23 21:41:53', 1, 'pasalo'),
(41, 4, '2017-05-23 21:57:12', 1, 'aa'),
(41, 5, '2017-05-26 05:51:06', 1, 'a'),
(42, 1, '2017-05-23 23:02:28', 1, 'Creación de Solicitud'),
(42, 2, '2017-05-23 23:02:45', 1, 'ENVIANDO'),
(42, 3, '2017-05-23 23:03:05', 1, 'ASDFASDF'),
(42, 4, '2017-05-23 23:05:13', 1, 'XXXX'),
(42, 5, '2017-05-26 06:02:00', 1, 'dale'),
(43, 1, '2017-05-25 00:04:56', 1, 'Creación de Solicitud'),
(43, 2, '2017-05-26 01:08:23', 1, 'a'),
(43, 3, '2017-05-26 01:08:36', 1, 'as'),
(43, 4, '2017-05-26 23:56:34', 1, 'p'),
(43, 5, '2017-06-22 18:42:19', 1, 'aprobar'),
(44, 1, '2017-05-25 23:38:47', 1, 'Creación de Solicitud'),
(44, 2, '2017-05-26 00:25:46', 1, 'Paselo'),
(44, 3, '2017-05-26 00:46:32', 1, 'paselo'),
(44, 4, '2017-05-26 01:07:24', 1, 'a'),
(44, 5, '2017-05-26 23:56:14', 1, 'p'),
(45, 1, '2017-05-26 00:25:14', 1, 'Creación de Solicitud'),
(45, 2, '2017-06-29 21:07:54', 1, 'xcc'),
(45, 2, '2017-07-13 23:11:43', 1, 'enviada desde 1er modulo'),
(45, 3, '2017-07-11 09:33:01', 1, '34'),
(45, 4, '2017-07-13 20:35:09', 1, 'kkkk'),
(45, 6, '2017-07-13 20:37:45', 1, ''),
(45, 6, '2017-07-13 20:41:35', 1, 'denegado'),
(45, 7, '2017-07-13 20:41:22', 1, 'devuelto'),
(45, 7, '2017-07-13 20:44:22', 1, 'devolver por 2da ves'),
(46, 1, '2017-05-26 16:20:01', 1, 'Creación de Solicitud'),
(46, 2, '2017-05-26 16:23:14', 1, 'enviar a RRHH'),
(46, 3, '2017-07-13 23:02:04', 1, '0'),
(46, 4, '2017-07-13 23:02:25', 1, 'jjj'),
(46, 7, '2017-07-13 23:38:59', 1, 'devuelto desde aprobador'),
(47, 1, '2017-06-29 22:36:23', 1, 'Creación de Solicitud'),
(47, 2, '2017-06-29 22:37:44', 1, 'Vamos'),
(47, 3, '2017-06-29 22:38:32', 1, 'Vamos para analista de créditos '),
(47, 4, '2017-06-29 23:29:35', 1, 'Vamos a ver si se aprueba'),
(47, 5, '2017-06-29 23:37:16', 1, 'Aprobado'),
(48, 1, '2017-06-29 23:03:35', 1, 'Creación de Solicitud'),
(48, 2, '2017-07-06 20:27:50', 1, 'a'),
(49, 1, '2017-07-02 22:54:25', 1, 'Creación de Solicitud'),
(49, 2, '2017-07-06 20:52:39', 1, 'sffsdfsdf'),
(50, 1, '2017-07-03 22:46:32', 1, 'Creación de Solicitud'),
(50, 3, '2017-07-06 21:03:56', 1, 'vvv'),
(50, 4, '2017-07-13 11:05:16', 1, 'vvvv'),
(50, 6, '2017-07-13 19:42:55', 1, ''),
(50, 7, '2017-07-13 19:56:44', 1, ''),
(51, 1, '2017-07-03 23:08:16', 1, 'Creación de Solicitud'),
(51, 3, '2017-07-13 23:20:39', 1, 'envio desde RRHH'),
(52, 1, '2017-07-05 23:55:48', 1, 'Creación de Solicitud'),
(53, 1, '2017-07-05 23:58:07', 1, 'Creación de Solicitud'),
(54, 1, '2017-07-06 08:44:15', 1, 'Creación de Solicitud'),
(54, 2, '2017-07-06 21:01:49', 1, 'hhh'),
(55, 1, '2017-07-06 22:14:09', 1, 'Creación de Solicitud'),
(56, 1, '2017-07-07 22:07:11', 1, 'Creación de Solicitud'),
(57, 1, '2017-07-07 22:08:35', 1, 'Creación de Solicitud'),
(58, 1, '2017-07-07 22:09:11', 1, 'Creación de Solicitud'),
(59, 1, '2017-07-10 01:59:33', 1, 'Creación de Solicitud'),
(60, 1, '2017-07-11 08:43:08', 1, 'Creación de Solicitud'),
(60, 2, '2017-07-13 23:21:00', 1, 'dddd'),
(60, 3, '2017-07-13 23:21:47', 1, 'comentario de RRHH'),
(60, 4, '2017-07-13 23:22:45', 1, 'comentario desde Cr[editos'),
(61, 1, '2017-07-12 16:27:16', 1, 'Creación de Solicitud');

-- --------------------------------------------------------

--
-- Table structure for table `solicitudEstados`
--

CREATE TABLE IF NOT EXISTS `solicitudEstados` (
  `estadoID` int(11) NOT NULL,
  `descripcion` varchar(100) COLLATE latin1_spanish_ci NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

--
-- Dumping data for table `solicitudEstados`
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
-- Table structure for table `solicitudes_referencia`
--

CREATE TABLE IF NOT EXISTS `solicitudes_referencia` (
  `solicitudID` int(11) NOT NULL,
  `nombre_completo` varchar(200) COLLATE latin1_spanish_ci DEFAULT NULL,
  `telefono_residencia` varchar(20) COLLATE latin1_spanish_ci DEFAULT NULL,
  `trabajo` varchar(200) COLLATE latin1_spanish_ci DEFAULT NULL,
  `parentesco` varchar(200) COLLATE latin1_spanish_ci DEFAULT NULL,
  `numeroReferencia` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

--
-- Dumping data for table `solicitudes_referencia`
--

INSERT INTO `solicitudes_referencia` (`solicitudID`, `nombre_completo`, `telefono_residencia`, `trabajo`, `parentesco`, `numeroReferencia`) VALUES
(38, 'referencia', '23452345', '234234', 'asdf', 3),
(38, 'referencia', '23452345', '234234', 'asdf', 3),
(39, 'dsdsdsd xxxx', '6767676', 'sdsdsd', 'sdsdsd', 1),
(39, 'sdsdsd', '232323', 'sdsdds', 'sdsdds', 2),
(40, 'dsdsdsaaa', '222', '234234', 'aa', 1),
(40, 'bb', '999999', '3224', 'bb', 2),
(41, 'dsdsdsd xxxx', '6767676', 'sdsdsd', 'sdsdsd', 1),
(41, 'sdsdsd', '232323', 'sdsdds', 'sdsdds', 2),
(42, 'dsdsdsd xxxx', '6767676', 'sdsdsd', 'sdsdsd', 1),
(42, 'sdsdsd', '232323', 'sdsdds', 'sdsdds', 2),
(43, 'dsdsdsd xxxx', '6767676', 'sdsdsd', 'sdsdsd', 1),
(43, 'sdsdsd', '232323', 'sdsdds', 'sdsdds', 2),
(44, 'dsdsdsd xxxx', '6767676', 'sdsdsd', 'sdsdsd', 1),
(44, 'sdsdsd', '232323', 'sdsdds', 'sdsdds', 2),
(45, 'dsdsdsd xxxx', '6767676', 'sdsdsd', 'sdsdsd', 1),
(45, 'sdsdsd', '232323', 'sdsdds', 'sdsdds', 2),
(46, 'dsdsdsd xxxx', '6767676', 'sdsdsd', 'sdsdsd', 1),
(46, 'sdsdsd', '232323', 'sdsdds', 'sdsdds', 2),
(47, 'dsdsdsd xxxx', '6767676', 'sdsdsd', 'sdsdsd', 1),
(47, 'sdsdsd', '232323', 'sdsdds', 'sdsdds', 2),
(48, 'dsdsdsd xxxx', '6767676', 'sdsdsd', 'sdsdsd', 1),
(48, 'sdsdsd', '232323', 'sdsdds', 'sdsdds', 2),
(38, 'referencia', '23452345', '234234', 'asdf', 3),
(40, 'zz', '111', '2234', 'zz', 3),
(49, '', '', '', '', 1),
(49, '', '', '', '', 2),
(49, '', '', '', '', 3),
(50, '', '', '', '', 1),
(50, '', '', '', '', 2),
(50, '', '', '', '', 3),
(51, '', '', '', '', 1),
(51, '', '', '', '', 2),
(51, '', '', '', '', 3),
(52, 'referencia', '23452345', 'asdgfadfg', 'asdf', 1),
(52, 'referencia', '23452345', 'asdgfadfg', 'asdf', 2),
(52, 'referencia', '23452345', 'asdgfadfg', 'asdf', 3),
(53, 'referencia', '23452345', 'asdgfadfg', 'asdf', 1),
(53, 'referencia', '23452345', 'asdgfadfg', 'asdf', 2),
(53, 'referencia', '23452345', 'asdgfadfg', 'asdf', 3),
(54, 'referencia', '23452345', 'asdgfadfg', 'asdf', 1),
(54, 'referencia', '23452345', 'asdgfadfg', 'asdf', 2),
(54, 'referencia', '23452345', 'asdgfadfg', 'asdf', 3),
(55, 'referencia', '23452345', 'asdgfadfg', 'asdf', 1),
(55, 'referencia', '23452345', 'asdgfadfg', 'asdf', 2),
(55, 'referencia', '23452345', 'asdgfadfg', 'asdf', 3),
(56, 'dsdsdsd xxxx', '6767676', 'sdsdsd', 'sdsdsd', 1),
(56, 'sdsdsd', '232323', 'sdsdds', 'sdsdds', 2),
(56, '', '', '', '', 3),
(57, 'referencia', '23452345', 'asdgfadfg', 'asdf', 1),
(57, 'referencia', '23452345', 'asdgfadfg', 'asdf', 2),
(57, 'referencia', '23452345', 'asdgfadfg', 'asdf', 3),
(58, 'referencia', '23452345', 'asdgfadfg', 'asdf', 1),
(58, 'referencia', '23452345', 'asdgfadfg', 'asdf', 2),
(58, 'referencia', '23452345', 'asdgfadfg', 'asdf', 3),
(59, 'referencia', '23452345', 'asdgfadfg', 'asdf', 1),
(59, 'referencia', '23452345', 'asdgfadfg', 'asdf', 2),
(59, 'referencia', '23452345', 'asdgfadfg', 'asdf', 3),
(60, 'referencia', '23452345', '234234', 'asdf', 1),
(60, 'referencia', '23452345', '234234', 'asdf', 2),
(60, 'referencia', '23452345', '234234', 'asdf', 3),
(61, 'dsdsdsd xxxx', '6767676', 'sdsdsd', 'sdsdsd', 1),
(61, 'sdsdsd', '232323', 'sdsdds', 'sdsdds', 2),
(61, '', '', '', '', 3);

-- --------------------------------------------------------

--
-- Table structure for table `tipoPrestamos`
--

CREATE TABLE IF NOT EXISTS `tipoPrestamos` (
  `tipoPrestamosID` int(11) NOT NULL,
  `descripcion` varchar(200) COLLATE latin1_spanish_ci NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

--
-- Dumping data for table `tipoPrestamos`
--

INSERT INTO `tipoPrestamos` (`tipoPrestamosID`, `descripcion`) VALUES
(1, 'fiduciario'),
(2, 'prendario'),
(3, 'hipotecario');

-- --------------------------------------------------------

--
-- Table structure for table `tipoSolicitudes`
--

CREATE TABLE IF NOT EXISTS `tipoSolicitudes` (
  `tipoSolicitudID` int(11) NOT NULL,
  `descripcion` varchar(200) COLLATE latin1_spanish_ci NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

--
-- Dumping data for table `tipoSolicitudes`
--

INSERT INTO `tipoSolicitudes` (`tipoSolicitudID`, `descripcion`) VALUES
(1, 'Colaborador'),
(2, 'Cliente externo'),
(3, 'Empresarial');

-- --------------------------------------------------------

--
-- Table structure for table `tipoViviendas`
--

CREATE TABLE IF NOT EXISTS `tipoViviendas` (
  `tipoViviendaID` int(11) NOT NULL,
  `descripcion` varchar(50) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tipoViviendas`
--

INSERT INTO `tipoViviendas` (`tipoViviendaID`, `descripcion`) VALUES
(1, 'Alquilada'),
(2, 'Propia'),
(3, 'Familiar'),
(4, 'Pagándola'),
(5, 'Otros');

-- --------------------------------------------------------

--
-- Table structure for table `tipo_responsabilidad`
--

CREATE TABLE IF NOT EXISTS `tipo_responsabilidad` (
  `responsabilidadID` int(11) NOT NULL,
  `descripcion` varchar(50) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tipo_responsabilidad`
--

INSERT INTO `tipo_responsabilidad` (`responsabilidadID`, `descripcion`) VALUES
(1, 'Individual'),
(2, 'Mancomunal');

-- --------------------------------------------------------

--
-- Table structure for table `usuarios`
--

CREATE TABLE IF NOT EXISTS `usuarios` (
  `usuarioID` int(11) NOT NULL,
  `usuario` varchar(30) NOT NULL,
  `contrasenia` text NOT NULL,
  `rol` int(11) NOT NULL,
  `estado` tinyint(1) NOT NULL,
  `fechaCreacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `usuarios`
--

INSERT INTO `usuarios` (`usuarioID`, `usuario`, `contrasenia`, `rol`, `estado`, `fechaCreacion`) VALUES
(1, 'remoteTest', '$2a$07$g5LY0JL5ydxNO44KHGL9UOALr8sbblkLLHONZUX5F9y2ZVAYzc8Le', 0, 1, '2017-04-14 11:53:20'),
(2, 'modulorhh', '$2a$07$hiSg8F.3YJf6PGfEB0diVOtr9DaRYnJr1X5XunTBrLR19ugjD7E06', 1, 1, '2017-07-10 17:23:19');

-- --------------------------------------------------------

--
-- Table structure for table `usuario_rol`
--

CREATE TABLE IF NOT EXISTS `usuario_rol` (
  `rolID` int(11) NOT NULL,
  `descripcion` varchar(50) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `usuario_rol`
--

INSERT INTO `usuario_rol` (`rolID`, `descripcion`) VALUES
(0, 'Administrador'),
(1, 'Analista de Recursos Humanos'),
(2, 'Analista de créditos'),
(3, 'Aprobador');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `condicion_prestamo`
--
ALTER TABLE `condicion_prestamo`
  ADD PRIMARY KEY (`prestamoID`);

--
-- Indexes for table `datosLaborales`
--
ALTER TABLE `datosLaborales`
  ADD PRIMARY KEY (`personaID`),
  ADD KEY `actividad_Empresa_FK` (`actividadEmpresaID`);

--
-- Indexes for table `empleadoDatos`
--
ALTER TABLE `empleadoDatos`
  ADD PRIMARY KEY (`personaID`);

--
-- Indexes for table `empresaActividades`
--
ALTER TABLE `empresaActividades`
  ADD PRIMARY KEY (`empresaActividadID`);

--
-- Indexes for table `estadosCivil`
--
ALTER TABLE `estadosCivil`
  ADD PRIMARY KEY (`estadoCivilID`);

--
-- Indexes for table `personas`
--
ALTER TABLE `personas`
  ADD PRIMARY KEY (`personaID`),
  ADD KEY `conyugue_FK` (`conyugueID`),
  ADD KEY `estado_civil_FK` (`estadoCivilID`),
  ADD KEY `tipoVivienda_FK` (`tipoViviendaID`);

--
-- Indexes for table `personas_contacto`
--
ALTER TABLE `personas_contacto`
  ADD PRIMARY KEY (`personaID`,`telefono`,`celular`);

--
-- Indexes for table `prestamos`
--
ALTER TABLE `prestamos`
  ADD PRIMARY KEY (`prestamoID`),
  ADD KEY `fiadorID_FK` (`fiadorID`),
  ADD KEY `tipo_prestamo_FK` (`tipoPrestamoID`),
  ADD KEY `responsabilidad_FK` (`responsabilidadID`),
  ADD KEY `prestamo_destino_FK` (`destinoID`);

--
-- Indexes for table `prestamo_destino`
--
ALTER TABLE `prestamo_destino`
  ADD PRIMARY KEY (`destinoID`);

--
-- Indexes for table `solicitudes`
--
ALTER TABLE `solicitudes`
  ADD PRIMARY KEY (`solicitudID`,`prestamoID`),
  ADD KEY `estadoID_FK` (`estadoID`),
  ADD KEY `prestamoID_FK` (`prestamoID`),
  ADD KEY `solicitante_FK` (`solicitanteID`),
  ADD KEY `tipo_solicitudes_FK` (`tipoSolicitudID`);

--
-- Indexes for table `solicitudesBitacora`
--
ALTER TABLE `solicitudesBitacora`
  ADD PRIMARY KEY (`solicitudID`,`estadoID`,`fecha`),
  ADD KEY `estadoIDBitacora_FK` (`estadoID`),
  ADD KEY `usuarioIDBitacora_FK` (`usuarioID`);

--
-- Indexes for table `solicitudEstados`
--
ALTER TABLE `solicitudEstados`
  ADD PRIMARY KEY (`estadoID`);

--
-- Indexes for table `solicitudes_referencia`
--
ALTER TABLE `solicitudes_referencia`
  ADD KEY `referencia_FK` (`solicitudID`);

--
-- Indexes for table `tipoPrestamos`
--
ALTER TABLE `tipoPrestamos`
  ADD PRIMARY KEY (`tipoPrestamosID`);

--
-- Indexes for table `tipoSolicitudes`
--
ALTER TABLE `tipoSolicitudes`
  ADD PRIMARY KEY (`tipoSolicitudID`);

--
-- Indexes for table `tipoViviendas`
--
ALTER TABLE `tipoViviendas`
  ADD PRIMARY KEY (`tipoViviendaID`);

--
-- Indexes for table `tipo_responsabilidad`
--
ALTER TABLE `tipo_responsabilidad`
  ADD PRIMARY KEY (`responsabilidadID`);

--
-- Indexes for table `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`usuarioID`),
  ADD KEY `usuario_rol_FK` (`rol`);

--
-- Indexes for table `usuario_rol`
--
ALTER TABLE `usuario_rol`
  ADD PRIMARY KEY (`rolID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `empresaActividades`
--
ALTER TABLE `empresaActividades`
  MODIFY `empresaActividadID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `estadosCivil`
--
ALTER TABLE `estadosCivil`
  MODIFY `estadoCivilID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `personas`
--
ALTER TABLE `personas`
  MODIFY `personaID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=196;
--
-- AUTO_INCREMENT for table `prestamos`
--
ALTER TABLE `prestamos`
  MODIFY `prestamoID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=62;
--
-- AUTO_INCREMENT for table `prestamo_destino`
--
ALTER TABLE `prestamo_destino`
  MODIFY `destinoID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT for table `solicitudes`
--
ALTER TABLE `solicitudes`
  MODIFY `solicitudID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=62;
--
-- AUTO_INCREMENT for table `solicitudEstados`
--
ALTER TABLE `solicitudEstados`
  MODIFY `estadoID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `tipoPrestamos`
--
ALTER TABLE `tipoPrestamos`
  MODIFY `tipoPrestamosID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `tipoSolicitudes`
--
ALTER TABLE `tipoSolicitudes`
  MODIFY `tipoSolicitudID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `tipoViviendas`
--
ALTER TABLE `tipoViviendas`
  MODIFY `tipoViviendaID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `tipo_responsabilidad`
--
ALTER TABLE `tipo_responsabilidad`
  MODIFY `responsabilidadID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `usuarioID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `usuario_rol`
--
ALTER TABLE `usuario_rol`
  MODIFY `rolID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `condicion_prestamo`
--
ALTER TABLE `condicion_prestamo`
  ADD CONSTRAINT `condicion_FK` FOREIGN KEY (`prestamoID`) REFERENCES `prestamos` (`prestamoID`);

--
-- Constraints for table `datosLaborales`
--
ALTER TABLE `datosLaborales`
  ADD CONSTRAINT `actividad_Empresa_FK` FOREIGN KEY (`actividadEmpresaID`) REFERENCES `empresaActividades` (`empresaActividadID`),
  ADD CONSTRAINT `personaID_FK` FOREIGN KEY (`personaID`) REFERENCES `personas` (`personaID`);

--
-- Constraints for table `personas`
--
ALTER TABLE `personas`
  ADD CONSTRAINT `conyugue_FK` FOREIGN KEY (`conyugueID`) REFERENCES `personas` (`personaID`),
  ADD CONSTRAINT `estado_civil_FK` FOREIGN KEY (`estadoCivilID`) REFERENCES `estadosCivil` (`estadoCivilID`),
  ADD CONSTRAINT `tipoVivienda_FK` FOREIGN KEY (`tipoViviendaID`) REFERENCES `tipoViviendas` (`tipoViviendaID`);

--
-- Constraints for table `prestamos`
--
ALTER TABLE `prestamos`
  ADD CONSTRAINT `fiadorID_FK` FOREIGN KEY (`fiadorID`) REFERENCES `personas` (`personaID`),
  ADD CONSTRAINT `prestamo_destino_FK` FOREIGN KEY (`destinoID`) REFERENCES `prestamo_destino` (`destinoID`),
  ADD CONSTRAINT `responsabilidad_FK` FOREIGN KEY (`responsabilidadID`) REFERENCES `tipo_responsabilidad` (`responsabilidadID`),
  ADD CONSTRAINT `tipo_prestamo_FK` FOREIGN KEY (`tipoPrestamoID`) REFERENCES `tipoPrestamos` (`tipoPrestamosID`);

--
-- Constraints for table `solicitudes`
--
ALTER TABLE `solicitudes`
  ADD CONSTRAINT `estadoID_FK` FOREIGN KEY (`estadoID`) REFERENCES `solicitudEstados` (`estadoID`),
  ADD CONSTRAINT `prestamoID_FK` FOREIGN KEY (`prestamoID`) REFERENCES `prestamos` (`prestamoID`),
  ADD CONSTRAINT `solicitante_FK` FOREIGN KEY (`solicitanteID`) REFERENCES `personas` (`personaID`),
  ADD CONSTRAINT `tipo_solicitudes_FK` FOREIGN KEY (`tipoSolicitudID`) REFERENCES `tipoSolicitudes` (`tipoSolicitudID`);

--
-- Constraints for table `solicitudes_referencia`
--
ALTER TABLE `solicitudes_referencia`
  ADD CONSTRAINT `referencia_FK` FOREIGN KEY (`solicitudID`) REFERENCES `solicitudes` (`solicitudID`);

--
-- Constraints for table `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuario_rol_FK` FOREIGN KEY (`rol`) REFERENCES `usuario_rol` (`rolID`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

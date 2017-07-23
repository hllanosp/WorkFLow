-- phpMyAdmin SQL Dump
-- version 4.6.6
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jul 23, 2017 at 12:27 AM
-- Server version: 5.6.35
-- PHP Version: 5.6.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hiwypani_workflow3`
--

DELIMITER $$
--
-- Procedures
--
$$

$$

$$

$$

$$

$$

$$

$$

$$

$$

$$

$$

$$

$$

$$

$$

$$

$$

$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `condicion_prestamo`
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

--
-- Dumping data for table `condicion_prestamo`
--

INSERT INTO `condicion_prestamo` (`prestamoID`, `monto_aprobado`, `plazo_aprobado`, `cuota_nivelada`, `tasa_interes`, `descrpicion_garantia`, `RCI`, `TDI`, `confirmacion`, `comentario_analista`) VALUES
(1, 0.00, 0, 0.00, 0.00, '0', 0.00, 0.00, 0, '0');

-- --------------------------------------------------------

--
-- Table structure for table `datosLaborales`
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

--
-- Dumping data for table `datosLaborales`
--

INSERT INTO `datosLaborales` (`personaID`, `empresa`, `posicion`, `aniosTrabajo`, `sueldo`, `jefeDirecto`, `otrosIngresos`, `telefono`, `extension`, `actividadEmpresaID`, `direccion`) VALUES
(1, '', '', NULL, 0, NULL, NULL, '', '', NULL, NULL),
(2, 'TTC', 'Adminitradora', 8, 42434.03, 'Camilo Ortega', 32323.02, '22332434', '234', 4, 'Col. Hh'),
(3, 'Hospital San Jose', 'Pediatra', 8, 223123.02, 'Camilo Ortega', 10000.04, '2223324', '323', 7, 'Col. Soto');

-- --------------------------------------------------------

--
-- Table structure for table `empleadoDatos`
--

CREATE TABLE `empleadoDatos` (
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
(3, 234234.03, 34234.02, 32434.03, 7, 'Solicitud enviada al Analista de Créditos ');

-- --------------------------------------------------------

--
-- Table structure for table `empresaActividades`
--

CREATE TABLE `empresaActividades` (
  `empresaActividadID` int(11) NOT NULL,
  `descripcion` varchar(200) COLLATE latin1_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

--
-- Dumping data for table `empresaActividades`
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
-- Table structure for table `estadosCivil`
--

CREATE TABLE `estadosCivil` (
  `estadoCivilID` int(11) NOT NULL,
  `descripcion` varchar(200) COLLATE latin1_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

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

--
-- Dumping data for table `personas`
--

INSERT INTO `personas` (`personaID`, `identidad`, `Pnombre`, `Snombre`, `Papellido`, `Sapellido`, `RTN`, `sexo`, `fechaNacimiento`, `direccion`, `residencia`, `lugarNacimiento`, `nacionalidad`, `ocupacion`, `dependientes`, `hijos`, `estadoCivilID`, `tipoViviendaID`, `pago_mensualVivienda`, `conyugueID`) VALUES
(1, '', '', '', '', '', NULL, NULL, '2017-01-01', NULL, NULL, NULL, NULL, '', NULL, NULL, NULL, 1, 0, NULL),
(2, '089882137', 'Sandra', 'Carminda', 'Salinas', 'Corrales', NULL, 'F', NULL, 'Col. Soto', 'Tegucigalpa', NULL, NULL, NULL, 0, 0, 1, 3, 0, NULL),
(3, '0872837123', 'Fausto', 'Emilio ', 'Tavora', 'Nagera', '72361763', 'M', '1989-05-01', 'Col. Palmira', 'Teguciglapa ', 'Tegucigalpa, Honduras ', 'hondureñio', 'Doctor', 0, 0, 1, 2, 3243234.03, 1);

-- --------------------------------------------------------

--
-- Table structure for table `personas_contacto`
--

CREATE TABLE `personas_contacto` (
  `personaID` int(11) NOT NULL,
  `telefono` varchar(30) COLLATE latin1_spanish_ci NOT NULL DEFAULT '',
  `celular` varchar(30) COLLATE latin1_spanish_ci NOT NULL DEFAULT '',
  `email` varchar(200) COLLATE latin1_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

--
-- Dumping data for table `personas_contacto`
--

INSERT INTO `personas_contacto` (`personaID`, `telefono`, `celular`, `email`) VALUES
(1, '', '', NULL),
(2, '223233', '9872137', 'ssalinas@sdad.com'),
(3, '22323123', '97834623', 'ftavora@asda.com');

-- --------------------------------------------------------

--
-- Table structure for table `prestamos`
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

--
-- Dumping data for table `prestamos`
--

INSERT INTO `prestamos` (`prestamoID`, `cantSolicitada`, `plazo`, `destinoID`, `tipoPrestamoID`, `fiadorID`, `responsabilidadID`, `tipo_aprobacion`) VALUES
(1, '234234.03', 34, 6, 2, 2, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `prestamo_destino`
--

CREATE TABLE `prestamo_destino` (
  `destinoID` int(11) NOT NULL,
  `descripcion` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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

CREATE TABLE `solicitudes` (
  `solicitudID` int(11) NOT NULL,
  `solicitanteID` int(11) NOT NULL,
  `tipoSolicitudID` int(11) NOT NULL,
  `prestamoID` int(11) NOT NULL,
  `estadoID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `solicitudes`
--

INSERT INTO `solicitudes` (`solicitudID`, `solicitanteID`, `tipoSolicitudID`, `prestamoID`, `estadoID`) VALUES
(1, 3, 1, 1, 6);

-- --------------------------------------------------------

--
-- Table structure for table `solicitudesBitacora`
--

CREATE TABLE `solicitudesBitacora` (
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
(1, 1, '2017-07-18 01:41:45', 1, 'Creación de Solicitud'),
(1, 2, '2017-07-18 01:42:53', 1, 'Solicitud Enviada a RRHH'),
(1, 3, '2017-07-18 01:45:49', 1, 'Solicitud enviada al Analista de Créditos '),
(1, 4, '2017-07-18 01:52:57', 1, 'a'),
(1, 6, '2017-07-18 23:55:32', 1, 'solicitud denegada falta confirmar informacion');

-- --------------------------------------------------------

--
-- Table structure for table `solicitudEstados`
--

CREATE TABLE `solicitudEstados` (
  `estadoID` int(11) NOT NULL,
  `descripcion` varchar(100) COLLATE latin1_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

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

CREATE TABLE `solicitudes_referencia` (
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
(1, 'Catalina Soto', '23234234', '234234', 'Prima', 1),
(1, 'Carlos Soto', '232423', '123423', 'Primo ', 2),
(1, 'Fabricia Opeth', '23424234', '23423423', 'Amigo ', 3);

-- --------------------------------------------------------

--
-- Table structure for table `tipoPrestamos`
--

CREATE TABLE `tipoPrestamos` (
  `tipoPrestamosID` int(11) NOT NULL,
  `descripcion` varchar(200) COLLATE latin1_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

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

CREATE TABLE `tipoSolicitudes` (
  `tipoSolicitudID` int(11) NOT NULL,
  `descripcion` varchar(200) COLLATE latin1_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

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

CREATE TABLE `tipoViviendas` (
  `tipoViviendaID` int(11) NOT NULL,
  `descripcion` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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

CREATE TABLE `tipo_responsabilidad` (
  `responsabilidadID` int(11) NOT NULL,
  `descripcion` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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

CREATE TABLE `usuarios` (
  `usuarioID` int(11) NOT NULL,
  `usuario` varchar(30) NOT NULL,
  `contrasenia` text NOT NULL,
  `rol` int(11) NOT NULL,
  `estado` tinyint(1) NOT NULL,
  `fechaCreacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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

CREATE TABLE `usuario_rol` (
  `rolID` int(11) NOT NULL,
  `descripcion` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
  MODIFY `empresaActividadID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `estadosCivil`
--
ALTER TABLE `estadosCivil`
  MODIFY `estadoCivilID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `personas`
--
ALTER TABLE `personas`
  MODIFY `personaID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `prestamos`
--
ALTER TABLE `prestamos`
  MODIFY `prestamoID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `prestamo_destino`
--
ALTER TABLE `prestamo_destino`
  MODIFY `destinoID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT for table `solicitudes`
--
ALTER TABLE `solicitudes`
  MODIFY `solicitudID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `solicitudEstados`
--
ALTER TABLE `solicitudEstados`
  MODIFY `estadoID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `tipoPrestamos`
--
ALTER TABLE `tipoPrestamos`
  MODIFY `tipoPrestamosID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `tipoSolicitudes`
--
ALTER TABLE `tipoSolicitudes`
  MODIFY `tipoSolicitudID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `tipoViviendas`
--
ALTER TABLE `tipoViviendas`
  MODIFY `tipoViviendaID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `tipo_responsabilidad`
--
ALTER TABLE `tipo_responsabilidad`
  MODIFY `responsabilidadID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `usuarioID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `usuario_rol`
--
ALTER TABLE `usuario_rol`
  MODIFY `rolID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
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

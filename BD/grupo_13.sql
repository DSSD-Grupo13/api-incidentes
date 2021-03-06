SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";

DROP DATABASE IF EXISTS grupo13;

CREATE DATABASE grupo13;

DROP USER IF EXISTS 'grupo13'@'localhost';

CREATE USER 'grupo13'@'localhost' IDENTIFIED BY 'bpm';

GRANT ALL ON *.* TO 'grupo13'@'localhost';

USE grupo13;

CREATE TABLE `estado` (
  `idEstado` int(2) NOT NULL,
  `nombre` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `estado` (`idEstado`, `nombre`) VALUES
(1, 'pendiente'),
(2, 'en inspeccion'),
(3, 'revision presupuestos'),
(4, 'aprobado'),
(5, 'rechazado');

CREATE TABLE `incidente` (
  `idIncidente` int(10) NOT NULL,
  `descripcion` text NOT NULL,
  `idTipoIncidente` int(11) NOT NULL,
  `idUsuario` int(11) NOT NULL,
  `fechaInicio` date NOT NULL,
  `fechaFin` date NOT NULL,
  `idEstado` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `objetoIncidente` (
  `idObjeto`int(10) NOT NULL,
  `idIncidente` int(10) NOT NULL,
  `nombre` text NOT NULL,
  `descripcion` text NOT NULL,
  `cantidad` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `tipoincidente` (
  `nombre` varchar(15) NOT NULL,
  `idTipoIncidente` int(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `tipoincidente` (`nombre`, `idTipoIncidente`) VALUES
('no determinado', 1),
('casa', 2),
('vehiculo', 3),
('objeto-mueble', 4);

CREATE TABLE `usuario` (
  `idUsuario` int(5) NOT NULL,
  `nombreUsuario` varchar(20) NOT NULL,
  `contrasena` varchar(20) NOT NULL,
  `nombre` varchar(20) NOT NULL,
  `apellido` varchar(20) NOT NULL,
  `dni` int(8) NOT NULL,
  `mail` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `presupuesto` (
  `idPresupuesto` int(10) NOT NULL,
  `total` decimal(15, 2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `objetos_presupuesto` (
  `idObjeto` int(10) NOT NULL,
  `idPresupuesto` int(10) NOT NULL,
  `nombre` varchar(20) NOT NULL,
  `cantidad` int(5) NOT NULL,
  `descripcion` varchar(100) NOT NULL,
  `precio` decimal(15, 2) NOT NULL,
  `total` decimal(15, 2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `presupuestos_incidente` (
  `idIncidente` int(10) NOT NULL,
  `idPresupuesto` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `usuario` (`idUsuario`, `nombreUsuario`, `contrasena`, `nombre`, `apellido`, `dni`, `mail`) VALUES
(1, 'mlopez', 'bpm', 'maria', 'lopez', 38951674, 'ortu.agustin@gmail.com'),
(2, 'mgomez', 'bpm', 'mateo', 'gomez', 37694301, 'corbatta.emiliana@gmail.com'),
(3, 'jrodriguez', 'bpm', 'juan', 'rodriguez', 36950167, 'mastronardi.gonzalo@gmail.com'),
(4, 'wgarcia', 'bpm', 'walter', 'garcia', 33694178, 'ortu.agustin@gmail.com');

ALTER TABLE `estado`
  ADD PRIMARY KEY (`idEstado`);

ALTER TABLE `incidente`
  ADD PRIMARY KEY (`idIncidente`),
  ADD KEY `idTipoIncidente` (`idTipoIncidente`),
  ADD KEY `idUsuario` (`idUsuario`),
  ADD KEY `id_estado` (`idEstado`);

ALTER TABLE `tipoincidente`
  ADD PRIMARY KEY (`idTipoIncidente`);

ALTER TABLE `usuario`
  ADD PRIMARY KEY (`idUsuario`);

ALTER TABLE `presupuesto`
  ADD PRIMARY KEY (`idPresupuesto`);

ALTER TABLE `objetos_presupuesto`
  ADD PRIMARY KEY (`idObjeto`),
  ADD KEY `idPresupuesto` (`idPresupuesto`);

ALTER TABLE `presupuestos_incidente`
  ADD PRIMARY KEY (`idIncidente`, `idPresupuesto`),
  ADD KEY `idIncidente` (`idIncidente`),
  ADD KEY `idPresupuesto` (`idPresupuesto`);

ALTER TABLE `estado`
  MODIFY `idEstado` int(2) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

ALTER TABLE `incidente`
  MODIFY `idIncidente` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

ALTER TABLE `tipoincidente`
  MODIFY `idTipoIncidente` int(2) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

ALTER TABLE `usuario`
  MODIFY `idUsuario` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

ALTER TABLE `presupuesto`
  MODIFY `idPresupuesto` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

ALTER TABLE `objetos_presupuesto`
  MODIFY `idObjeto` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

ALTER TABLE `incidente`
  ADD CONSTRAINT `incidente_ibfk_1` FOREIGN KEY (`idTipoIncidente`) REFERENCES `tipoincidente` (`idTipoIncidente`),
  ADD CONSTRAINT `incidente_ibfk_2` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`),
  ADD CONSTRAINT `incidente_ibfk_3` FOREIGN KEY (`idEstado`) REFERENCES `estado` (`idEstado`);

ALTER TABLE `objetos_presupuesto`
  ADD CONSTRAINT `objetos_presupuesto_ibfk_1` FOREIGN KEY (`idPresupuesto`) REFERENCES `presupuesto` (`idPresupuesto`);

ALTER TABLE `presupuestos_incidente`
  ADD CONSTRAINT `presupuestos_incidente_ibfk_1` FOREIGN KEY (`idIncidente`) REFERENCES `incidente` (`idIncidente`),
  ADD CONSTRAINT `presupuestos_incidente_ibfk_2` FOREIGN KEY (`idPresupuesto`) REFERENCES `presupuesto` (`idPresupuesto`);
COMMIT;

-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: localhost    Database: uniia
-- ------------------------------------------------------
-- Server version	8.0.43

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `asistencias`
--

DROP TABLE IF EXISTS `asistencias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `asistencias` (
  `id_asistencia` int NOT NULL AUTO_INCREMENT,
  `estudiante_id` int NOT NULL,
  `curso_id` int NOT NULL,
  `periodo_id` int NOT NULL,
  `fecha` date DEFAULT (curdate()),
  `estado` enum('P','A','T') DEFAULT 'P',
  PRIMARY KEY (`id_asistencia`),
  KEY `estudiante_id` (`estudiante_id`),
  KEY `curso_id` (`curso_id`),
  KEY `periodo_id` (`periodo_id`),
  CONSTRAINT `asistencias_ibfk_1` FOREIGN KEY (`estudiante_id`) REFERENCES `estudiantes` (`id_estudiante`),
  CONSTRAINT `asistencias_ibfk_2` FOREIGN KEY (`curso_id`) REFERENCES `cursos` (`id_curso`),
  CONSTRAINT `asistencias_ibfk_3` FOREIGN KEY (`periodo_id`) REFERENCES `periodos` (`id_periodo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asistencias`
--

LOCK TABLES `asistencias` WRITE;
/*!40000 ALTER TABLE `asistencias` DISABLE KEYS */;
/*!40000 ALTER TABLE `asistencias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `carreras`
--

DROP TABLE IF EXISTS `carreras`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `carreras` (
  `id_carrera` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  PRIMARY KEY (`id_carrera`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carreras`
--

LOCK TABLES `carreras` WRITE;
/*!40000 ALTER TABLE `carreras` DISABLE KEYS */;
/*!40000 ALTER TABLE `carreras` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `curso_unidades`
--

DROP TABLE IF EXISTS `curso_unidades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `curso_unidades` (
  `id_unidad` int NOT NULL AUTO_INCREMENT,
  `id_curso` int NOT NULL,
  `numero_unidad` int NOT NULL,
  PRIMARY KEY (`id_unidad`),
  UNIQUE KEY `id_curso` (`id_curso`,`numero_unidad`),
  CONSTRAINT `curso_unidades_ibfk_1` FOREIGN KEY (`id_curso`) REFERENCES `cursos` (`id_curso`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `curso_unidades`
--

LOCK TABLES `curso_unidades` WRITE;
/*!40000 ALTER TABLE `curso_unidades` DISABLE KEYS */;
/*!40000 ALTER TABLE `curso_unidades` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cursos`
--

DROP TABLE IF EXISTS `cursos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cursos` (
  `id_curso` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `creditos` int NOT NULL,
  `silabo` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id_curso`),
  CONSTRAINT `cursos_chk_1` CHECK ((`creditos` in (2,3,4)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cursos`
--

LOCK TABLES `cursos` WRITE;
/*!40000 ALTER TABLE `cursos` DISABLE KEYS */;
/*!40000 ALTER TABLE `cursos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `docentes`
--

DROP TABLE IF EXISTS `docentes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `docentes` (
  `id_docente` int NOT NULL AUTO_INCREMENT,
  `dni` varchar(8) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `apellidop` varchar(100) NOT NULL,
  `apellidom` varchar(100) DEFAULT NULL,
  `celular` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`id_docente`),
  UNIQUE KEY `dni` (`dni`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `docentes`
--

LOCK TABLES `docentes` WRITE;
/*!40000 ALTER TABLE `docentes` DISABLE KEYS */;
/*!40000 ALTER TABLE `docentes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estudiantes`
--

DROP TABLE IF EXISTS `estudiantes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estudiantes` (
  `id_estudiante` int NOT NULL AUTO_INCREMENT,
  `codigo_universitario` varchar(20) NOT NULL,
  `dni` varchar(8) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `apellidop` varchar(100) NOT NULL,
  `apellidom` varchar(100) NOT NULL,
  `id_carrera` int NOT NULL,
  PRIMARY KEY (`id_estudiante`),
  UNIQUE KEY `codigo_universitario` (`codigo_universitario`),
  UNIQUE KEY `dni` (`dni`),
  KEY `id_carrera` (`id_carrera`),
  CONSTRAINT `estudiantes_ibfk_1` FOREIGN KEY (`id_carrera`) REFERENCES `carreras` (`id_carrera`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estudiantes`
--

LOCK TABLES `estudiantes` WRITE;
/*!40000 ALTER TABLE `estudiantes` DISABLE KEYS */;
/*!40000 ALTER TABLE `estudiantes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `matriculas`
--

DROP TABLE IF EXISTS `matriculas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `matriculas` (
  `id_matricula` int NOT NULL AUTO_INCREMENT,
  `id_estudiante` int NOT NULL,
  `id_curso` int NOT NULL,
  `id_periodo` int NOT NULL,
  PRIMARY KEY (`id_matricula`),
  UNIQUE KEY `id_estudiante` (`id_estudiante`,`id_curso`,`id_periodo`),
  KEY `id_curso` (`id_curso`),
  KEY `id_periodo` (`id_periodo`),
  CONSTRAINT `matriculas_ibfk_1` FOREIGN KEY (`id_estudiante`) REFERENCES `estudiantes` (`id_estudiante`),
  CONSTRAINT `matriculas_ibfk_2` FOREIGN KEY (`id_curso`) REFERENCES `cursos` (`id_curso`),
  CONSTRAINT `matriculas_ibfk_3` FOREIGN KEY (`id_periodo`) REFERENCES `periodos` (`id_periodo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `matriculas`
--

LOCK TABLES `matriculas` WRITE;
/*!40000 ALTER TABLE `matriculas` DISABLE KEYS */;
/*!40000 ALTER TABLE `matriculas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notas_unidad`
--

DROP TABLE IF EXISTS `notas_unidad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notas_unidad` (
  `id_nota_unidad` int NOT NULL AUTO_INCREMENT,
  `id_matricula` int NOT NULL,
  `id_unidad` int NOT NULL,
  `nota_actitudinal` decimal(5,2) DEFAULT '0.00',
  `nota_procedimental` decimal(5,2) DEFAULT '0.00',
  `nota_conceptual` decimal(5,2) DEFAULT '0.00',
  `promedio_unidad` decimal(5,2) GENERATED ALWAYS AS ((((`nota_actitudinal` * 0.20) + (`nota_procedimental` * 0.30)) + (`nota_conceptual` * 0.50))) STORED,
  PRIMARY KEY (`id_nota_unidad`),
  UNIQUE KEY `id_matricula` (`id_matricula`,`id_unidad`),
  KEY `id_unidad` (`id_unidad`),
  CONSTRAINT `notas_unidad_ibfk_1` FOREIGN KEY (`id_matricula`) REFERENCES `matriculas` (`id_matricula`),
  CONSTRAINT `notas_unidad_ibfk_2` FOREIGN KEY (`id_unidad`) REFERENCES `curso_unidades` (`id_unidad`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notas_unidad`
--

LOCK TABLES `notas_unidad` WRITE;
/*!40000 ALTER TABLE `notas_unidad` DISABLE KEYS */;
/*!40000 ALTER TABLE `notas_unidad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `periodos`
--

DROP TABLE IF EXISTS `periodos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `periodos` (
  `id_periodo` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(20) NOT NULL,
  `fecha_inicio` date DEFAULT NULL,
  `fecha_fin` date DEFAULT NULL,
  `activo` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id_periodo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `periodos`
--

LOCK TABLES `periodos` WRITE;
/*!40000 ALTER TABLE `periodos` DISABLE KEYS */;
/*!40000 ALTER TABLE `periodos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plan_estudios`
--

DROP TABLE IF EXISTS `plan_estudios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `plan_estudios` (
  `id_plan` int NOT NULL AUTO_INCREMENT,
  `id_carrera` int NOT NULL,
  `id_curso` int NOT NULL,
  `id_semestre` int NOT NULL,
  PRIMARY KEY (`id_plan`),
  UNIQUE KEY `id_carrera` (`id_carrera`,`id_curso`,`id_semestre`),
  KEY `id_curso` (`id_curso`),
  KEY `id_semestre` (`id_semestre`),
  CONSTRAINT `plan_estudios_ibfk_1` FOREIGN KEY (`id_carrera`) REFERENCES `carreras` (`id_carrera`),
  CONSTRAINT `plan_estudios_ibfk_2` FOREIGN KEY (`id_curso`) REFERENCES `cursos` (`id_curso`),
  CONSTRAINT `plan_estudios_ibfk_3` FOREIGN KEY (`id_semestre`) REFERENCES `semestres` (`id_semestre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plan_estudios`
--

LOCK TABLES `plan_estudios` WRITE;
/*!40000 ALTER TABLE `plan_estudios` DISABLE KEYS */;
/*!40000 ALTER TABLE `plan_estudios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `promedio_curso`
--

DROP TABLE IF EXISTS `promedio_curso`;
/*!50001 DROP VIEW IF EXISTS `promedio_curso`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `promedio_curso` AS SELECT 
 1 AS `id_matricula`,
 1 AS `estudiante`,
 1 AS `curso`,
 1 AS `periodo`,
 1 AS `promedio_final`,
 1 AS `estado`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `semestres`
--

DROP TABLE IF EXISTS `semestres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `semestres` (
  `id_semestre` int NOT NULL AUTO_INCREMENT,
  `numero` int NOT NULL,
  `descripcion` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id_semestre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `semestres`
--

LOCK TABLES `semestres` WRITE;
/*!40000 ALTER TABLE `semestres` DISABLE KEYS */;
/*!40000 ALTER TABLE `semestres` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `promedio_curso`
--

/*!50001 DROP VIEW IF EXISTS `promedio_curso`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `promedio_curso` AS select `m`.`id_matricula` AS `id_matricula`,`e`.`nombre` AS `estudiante`,`c`.`nombre` AS `curso`,`p`.`nombre` AS `periodo`,avg(`nu`.`promedio_unidad`) AS `promedio_final`,(case when (avg(`nu`.`promedio_unidad`) >= 10.5) then 'APROBADO' else 'DESAPROBADO' end) AS `estado` from ((((`matriculas` `m` join `estudiantes` `e` on((`e`.`id_estudiante` = `m`.`id_estudiante`))) join `cursos` `c` on((`c`.`id_curso` = `m`.`id_curso`))) join `periodos` `p` on((`p`.`id_periodo` = `m`.`id_periodo`))) join `notas_unidad` `nu` on((`nu`.`id_matricula` = `m`.`id_matricula`))) group by `m`.`id_matricula` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-11-25 19:29:26

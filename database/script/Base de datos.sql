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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carreras`
--

LOCK TABLES `carreras` WRITE;
/*!40000 ALTER TABLE `carreras` DISABLE KEYS */;
INSERT INTO `carreras` VALUES (1,'Ingeniería Agroindustrial'),(2,'Ingeniería Forestal'),(3,'Ingeniería de Sistemas e Informática'),(4,'Medicina Veterinaria'),(5,'Educación Matemática'),(6,'Derecho'),(7,'Enfermería'),(8,'Ecoturismo'),(9,'Administración'),(10,'Contabilidad');
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
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `curso_unidades`
--

LOCK TABLES `curso_unidades` WRITE;
/*!40000 ALTER TABLE `curso_unidades` DISABLE KEYS */;
INSERT INTO `curso_unidades` VALUES (1,1,1),(2,1,2),(3,2,1),(4,2,2),(5,3,1),(6,3,2),(7,4,1),(8,4,2),(9,4,3),(10,5,1),(11,5,2),(12,6,1),(13,6,2),(14,7,1),(15,7,2),(16,8,1),(17,8,2),(18,9,1),(19,9,2),(20,10,1),(21,10,2),(22,10,3),(23,11,1),(24,11,2),(25,12,1),(26,12,2),(27,13,1),(28,13,2),(29,13,3),(30,14,1),(31,14,2),(32,14,3),(33,15,1),(34,15,2),(35,15,3);
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
  `id_docente` int NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `creditos` int NOT NULL,
  `silabo` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id_curso`),
  KEY `id_docente` (`id_docente`),
  CONSTRAINT `cursos_ibfk_1` FOREIGN KEY (`id_docente`) REFERENCES `docentes` (`id_docente`),
  CONSTRAINT `cursos_chk_1` CHECK ((`creditos` in (2,3,4)))
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cursos`
--

LOCK TABLES `cursos` WRITE;
/*!40000 ALTER TABLE `cursos` DISABLE KEYS */;
INSERT INTO `cursos` VALUES (1,2,'ALGORITMOS INTRODUCTORIOS',3,'Silabo por definir'),(2,4,'CULTURA DE PAZ Y DEFENSA NACIONAL',2,'Silabo por definir'),(3,8,'REDACCION TECNICA Y CIENTIFICA',2,'Silabo por definir'),(4,3,'COMPLEMENTO DE MATEMATICA',4,'Silabo por definir'),(5,7,'LENGUAJE Y COMUNICACION',3,'Silabo por definir'),(6,6,'INTRODUCCION A INGENIERIA DE SISTEMAS',3,'Silabo por definir'),(7,5,'ECOLOGIA GENERAL Y RECURSOS NATURALES',3,'Silabo por definir'),(8,1,'ACTIVIDADES CULTURALES Y/O DEPORTIVAS',2,'Silabo por definir'),(9,12,'DISEÑO PARA INGENIERIA',2,'D:\\database\\S2022-2\\DISEÑO.pdf'),(10,14,'QUIMICA GENERAL',4,'D:\\database\\S2022-2\\QUIMICA_GENERAL.pdf'),(11,15,'SOCIOLOGIA RURAL Y AMAZONICA',2,'D:\\database\\S2022-2\\SOCIOLOGIA.pdf'),(12,10,'ALGORITMOS Y PROGRAMACIÓN',3,'D:\\database\\S2022-2\\ALGORITMOS.pdf'),(13,11,'CALCULO I',4,'D:\\database\\S2022-2\\CALCULI.pdf'),(14,9,'ALGEBRA LINEAL',4,'D:\\database\\S2022-2\\ALGEBRA_LINEAL.pdf'),(15,13,'FISICA I',4,'D:\\database\\S2022-2\\FISICAI.pdf');
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
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `docentes`
--

LOCK TABLES `docentes` WRITE;
/*!40000 ALTER TABLE `docentes` DISABLE KEYS */;
INSERT INTO `docentes` VALUES (1,'70000001','Ricardo','Vargas','Torres','91000001'),(2,'70000002','Luisa','Mendoza','Rojas','91000002'),(3,'70000003','Carlos','Flores','Silva','91000003'),(4,'70000004','Elena','Espinoza','Herrera','91000004'),(5,'70000005','Javier','Acuña','López','91000005'),(6,'70000006','Ana','Sánchez','Díaz','91000006'),(7,'70000007','Miguel','Pérez','Gómez','91000007'),(8,'70000008','Teresa','Martínez','Castro','91000008'),(9,'70000009','Héctor','Fernández','García','91000009'),(10,'70000010','Sofía','Rodríguez','González','91000010'),(11,'70000011','Jorge','Gómez','Vargas','91000011'),(12,'70000012','Marta','Díaz','Torres','91000012'),(13,'70000013','Andrés','Castro','Mendoza','91000013'),(14,'70000014','Laura','Rojas','Flores','91000014'),(15,'70000015','Pedro','Silva','Espinoza','91000015');
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
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estudiantes`
--

LOCK TABLES `estudiantes` WRITE;
/*!40000 ALTER TABLE `estudiantes` DISABLE KEYS */;
INSERT INTO `estudiantes` VALUES (1,'20250001','40000000','Daniel','Rojas','Martínez',3),(2,'20250002','40000001','Isabella','Martínez','Espinoza',3),(3,'20250003','40000002','Alejandro','Flores','Herrera',3),(4,'20250004','40000003','Sofía','Espinoza','Castro',3),(5,'20250005','40000004','Mateo','Acuña','Fernández',3),(6,'20250006','40000005','Mateo','González','Sánchez',3),(7,'20250007','40000006','Andrea','Silva','Rojas',3),(8,'20250008','40000007','Mateo','Martínez','Vargas',3),(9,'20250009','40000008','Javier','Gómez','Mendoza',3),(10,'20250010','40000009','Adrián','Vargas','Rojas',3),(11,'20250011','40000010','Elena','Silva','García',3),(12,'20250012','40000011','Javier','Pérez','Gómez',3),(13,'20250013','40000012','Luciana','Rodríguez','Silva',3),(14,'20250014','40000013','Luciana','Silva','Sánchez',3),(15,'20250015','40000014','Sofía','Fernández','Herrera',3),(16,'20250016','40000015','María','Flores','Herrera',3),(17,'20250017','40000016','Sofía','Rodríguez','Sánchez',3),(18,'20250018','40000017','Andrea','Castro','Espinoza',3),(19,'20250019','40000018','Mateo','Silva','Martínez',3),(20,'20250020','40000019','Camila','Silva','Sánchez',3),(21,'20250021','40000020','Emilio','Sánchez','Espinoza',3),(22,'20250022','40000021','Daniel','Pérez','Silva',3),(23,'20250023','40000022','Sofía','Vargas','Silva',3),(24,'20250024','40000023','Isabella','Herrera','Gómez',3),(25,'20250025','40000024','Isabella','Espinoza','Fernández',3),(26,'20250026','40000025','Nicolás','Herrera','López',3),(27,'20250027','40000026','Elena','Torres','Flores',3),(28,'20250028','40000027','Camila','Acuña','Silva',3),(29,'20250029','40000028','Nicolás','González','Pérez',3),(30,'20250030','40000029','Emilio','Mendoza','García',3);
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
) ENGINE=InnoDB AUTO_INCREMENT=211 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `matriculas`
--

LOCK TABLES `matriculas` WRITE;
/*!40000 ALTER TABLE `matriculas` DISABLE KEYS */;
INSERT INTO `matriculas` VALUES (4,1,9,2),(6,1,10,2),(7,1,11,2),(2,1,12,2),(3,1,13,2),(1,1,14,2),(5,1,15,2),(11,2,9,2),(13,2,10,2),(14,2,11,2),(9,2,12,2),(10,2,13,2),(8,2,14,2),(12,2,15,2),(18,3,9,2),(20,3,10,2),(21,3,11,2),(16,3,12,2),(17,3,13,2),(15,3,14,2),(19,3,15,2),(25,4,9,2),(27,4,10,2),(28,4,11,2),(23,4,12,2),(24,4,13,2),(22,4,14,2),(26,4,15,2),(32,5,9,2),(34,5,10,2),(35,5,11,2),(30,5,12,2),(31,5,13,2),(29,5,14,2),(33,5,15,2),(39,6,9,2),(41,6,10,2),(42,6,11,2),(37,6,12,2),(38,6,13,2),(36,6,14,2),(40,6,15,2),(46,7,9,2),(48,7,10,2),(49,7,11,2),(44,7,12,2),(45,7,13,2),(43,7,14,2),(47,7,15,2),(53,8,9,2),(55,8,10,2),(56,8,11,2),(51,8,12,2),(52,8,13,2),(50,8,14,2),(54,8,15,2),(60,9,9,2),(62,9,10,2),(63,9,11,2),(58,9,12,2),(59,9,13,2),(57,9,14,2),(61,9,15,2),(67,10,9,2),(69,10,10,2),(70,10,11,2),(65,10,12,2),(66,10,13,2),(64,10,14,2),(68,10,15,2),(74,11,9,2),(76,11,10,2),(77,11,11,2),(72,11,12,2),(73,11,13,2),(71,11,14,2),(75,11,15,2),(81,12,9,2),(83,12,10,2),(84,12,11,2),(79,12,12,2),(80,12,13,2),(78,12,14,2),(82,12,15,2),(88,13,9,2),(90,13,10,2),(91,13,11,2),(86,13,12,2),(87,13,13,2),(85,13,14,2),(89,13,15,2),(95,14,9,2),(97,14,10,2),(98,14,11,2),(93,14,12,2),(94,14,13,2),(92,14,14,2),(96,14,15,2),(102,15,9,2),(104,15,10,2),(105,15,11,2),(100,15,12,2),(101,15,13,2),(99,15,14,2),(103,15,15,2),(109,16,9,2),(111,16,10,2),(112,16,11,2),(107,16,12,2),(108,16,13,2),(106,16,14,2),(110,16,15,2),(116,17,9,2),(118,17,10,2),(119,17,11,2),(114,17,12,2),(115,17,13,2),(113,17,14,2),(117,17,15,2),(123,18,9,2),(125,18,10,2),(126,18,11,2),(121,18,12,2),(122,18,13,2),(120,18,14,2),(124,18,15,2),(130,19,9,2),(132,19,10,2),(133,19,11,2),(128,19,12,2),(129,19,13,2),(127,19,14,2),(131,19,15,2),(137,20,9,2),(139,20,10,2),(140,20,11,2),(135,20,12,2),(136,20,13,2),(134,20,14,2),(138,20,15,2),(144,21,9,2),(146,21,10,2),(147,21,11,2),(142,21,12,2),(143,21,13,2),(141,21,14,2),(145,21,15,2),(151,22,9,2),(153,22,10,2),(154,22,11,2),(149,22,12,2),(150,22,13,2),(148,22,14,2),(152,22,15,2),(158,23,9,2),(160,23,10,2),(161,23,11,2),(156,23,12,2),(157,23,13,2),(155,23,14,2),(159,23,15,2),(165,24,9,2),(167,24,10,2),(168,24,11,2),(163,24,12,2),(164,24,13,2),(162,24,14,2),(166,24,15,2),(172,25,9,2),(174,25,10,2),(175,25,11,2),(170,25,12,2),(171,25,13,2),(169,25,14,2),(173,25,15,2),(179,26,9,2),(181,26,10,2),(182,26,11,2),(177,26,12,2),(178,26,13,2),(176,26,14,2),(180,26,15,2),(186,27,9,2),(188,27,10,2),(189,27,11,2),(184,27,12,2),(185,27,13,2),(183,27,14,2),(187,27,15,2),(193,28,9,2),(195,28,10,2),(196,28,11,2),(191,28,12,2),(192,28,13,2),(190,28,14,2),(194,28,15,2),(200,29,9,2),(202,29,10,2),(203,29,11,2),(198,29,12,2),(199,29,13,2),(197,29,14,2),(201,29,15,2),(207,30,9,2),(209,30,10,2),(210,30,11,2),(205,30,12,2),(206,30,13,2),(204,30,14,2),(208,30,15,2);
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
) ENGINE=InnoDB AUTO_INCREMENT=541 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notas_unidad`
--

LOCK TABLES `notas_unidad` WRITE;
/*!40000 ALTER TABLE `notas_unidad` DISABLE KEYS */;
INSERT INTO `notas_unidad` (`id_nota_unidad`, `id_matricula`, `id_unidad`, `nota_actitudinal`, `nota_procedimental`, `nota_conceptual`) VALUES (1,1,30,10.57,6.44,10.47),(2,1,31,19.32,11.37,17.54),(3,1,32,10.23,5.61,5.06),(4,2,25,11.04,16.68,16.53),(5,2,26,4.68,9.94,8.35),(6,3,27,14.41,1.31,13.68),(7,3,28,14.59,3.86,13.47),(8,3,29,7.23,8.16,9.46),(9,4,18,2.11,1.24,4.58),(10,4,19,18.81,11.27,9.91),(11,5,33,3.49,9.92,9.07),(12,5,34,5.36,11.09,6.27),(13,5,35,6.65,6.18,14.57),(14,6,20,5.27,14.34,19.10),(15,6,21,12.97,18.80,1.38),(16,6,22,13.70,18.63,10.17),(17,7,23,14.43,3.73,10.83),(18,7,24,5.56,10.64,19.06),(19,8,30,12.91,5.02,2.11),(20,8,31,14.15,14.80,0.77),(21,8,32,13.78,2.60,18.87),(22,9,25,6.37,9.89,11.83),(23,9,26,7.82,14.09,2.76),(24,10,27,16.18,15.48,0.98),(25,10,28,14.96,17.40,9.45),(26,10,29,0.12,7.46,10.59),(27,11,18,19.49,1.99,2.60),(28,11,19,4.51,3.73,17.79),(29,12,33,9.86,4.06,14.08),(30,12,34,15.62,18.28,10.25),(31,12,35,13.44,7.29,1.70),(32,13,20,2.39,9.10,19.94),(33,13,21,0.96,8.33,13.99),(34,13,22,3.52,2.10,15.37),(35,14,23,8.90,0.67,15.53),(36,14,24,2.97,13.73,17.53),(37,15,30,9.97,8.88,0.16),(38,15,31,7.47,13.04,0.54),(39,15,32,11.05,19.54,19.16),(40,16,25,11.94,14.15,10.87),(41,16,26,5.14,9.01,14.62),(42,17,27,3.22,11.63,18.26),(43,17,28,11.31,15.51,19.17),(44,17,29,5.92,15.06,1.91),(45,18,18,1.76,10.78,8.35),(46,18,19,7.42,5.00,5.26),(47,19,33,14.61,11.70,17.74),(48,19,34,1.62,2.92,13.01),(49,19,35,11.91,7.14,4.63),(50,20,20,13.57,16.05,2.30),(51,20,21,4.30,9.32,1.84),(52,20,22,18.84,9.03,9.38),(53,21,23,13.91,1.64,10.20),(54,21,24,4.72,9.49,1.68),(55,22,30,12.90,7.12,12.37),(56,22,31,18.01,1.20,18.73),(57,22,32,15.00,8.77,16.80),(58,23,25,18.61,0.83,13.54),(59,23,26,16.78,16.16,8.57),(60,24,27,0.27,0.97,8.43),(61,24,28,9.81,15.07,2.21),(62,24,29,4.95,11.77,15.43),(63,25,18,19.00,19.94,15.17),(64,25,19,7.98,16.09,0.96),(65,26,33,18.76,7.26,13.53),(66,26,34,7.69,9.91,11.48),(67,26,35,0.06,16.71,14.17),(68,27,20,6.92,13.28,1.62),(69,27,21,18.48,14.99,3.71),(70,27,22,12.12,3.05,9.29),(71,28,23,11.98,0.76,18.73),(72,28,24,9.06,14.83,14.22),(73,29,30,17.18,10.96,6.17),(74,29,31,2.97,4.92,13.84),(75,29,32,11.82,19.09,17.77),(76,30,25,7.80,9.08,2.13),(77,30,26,4.17,4.39,5.97),(78,31,27,9.12,6.37,14.86),(79,31,28,1.14,9.20,19.33),(80,31,29,19.02,19.13,3.33),(81,32,18,0.32,12.63,3.90),(82,32,19,19.00,8.25,6.38),(83,33,33,18.91,7.15,4.02),(84,33,34,17.44,9.92,7.31),(85,33,35,11.74,9.64,7.99),(86,34,20,15.59,1.24,4.20),(87,34,21,7.36,15.28,3.93),(88,34,22,13.63,18.97,2.97),(89,35,23,18.57,18.96,17.43),(90,35,24,9.76,2.28,5.54),(91,36,30,4.33,3.98,0.50),(92,36,31,4.57,5.89,7.27),(93,36,32,6.40,14.91,15.09),(94,37,25,1.26,19.72,8.69),(95,37,26,5.87,7.03,15.01),(96,38,27,14.90,11.92,12.44),(97,38,28,14.30,1.72,2.73),(98,38,29,5.21,5.27,14.97),(99,39,18,17.61,8.27,2.92),(100,39,19,5.36,11.58,18.47),(101,40,33,17.84,7.86,12.60),(102,40,34,14.68,19.31,10.53),(103,40,35,0.07,6.44,8.66),(104,41,20,17.23,1.32,11.30),(105,41,21,0.68,18.06,16.44),(106,41,22,10.36,7.70,11.35),(107,42,23,17.00,3.86,4.10),(108,42,24,18.29,12.45,4.56),(109,43,30,11.67,11.76,9.45),(110,43,31,9.09,12.33,7.74),(111,43,32,15.55,16.04,0.77),(112,44,25,16.69,1.81,16.27),(113,44,26,14.40,13.12,6.20),(114,45,27,11.14,3.22,11.59),(115,45,28,19.72,11.60,1.31),(116,45,29,7.33,13.48,9.12),(117,46,18,3.33,19.63,10.60),(118,46,19,18.24,14.02,0.72),(119,47,33,13.05,15.46,2.26),(120,47,34,13.86,18.61,16.52),(121,47,35,11.44,6.24,8.88),(122,48,20,4.95,12.98,14.51),(123,48,21,17.58,5.92,5.25),(124,48,22,18.92,8.74,16.84),(125,49,23,7.31,1.76,5.62),(126,49,24,13.37,17.55,14.75),(127,50,30,4.52,9.84,18.83),(128,50,31,2.79,4.61,5.01),(129,50,32,6.93,14.72,19.23),(130,51,25,14.39,14.99,19.20),(131,51,26,4.68,7.64,5.04),(132,52,27,9.39,3.01,18.49),(133,52,28,14.41,7.14,6.98),(134,52,29,1.01,11.86,19.04),(135,53,18,19.47,2.68,2.63),(136,53,19,13.21,4.56,19.44),(137,54,33,14.64,8.25,10.99),(138,54,34,12.48,4.09,11.67),(139,54,35,13.16,11.69,0.94),(140,55,20,13.77,13.18,8.72),(141,55,21,2.62,10.00,5.09),(142,55,22,12.07,13.98,5.00),(143,56,23,17.05,14.27,0.32),(144,56,24,4.19,9.23,11.64),(145,57,30,0.90,9.29,6.35),(146,57,31,12.35,15.34,12.40),(147,57,32,0.45,13.00,11.80),(148,58,25,1.79,18.37,17.94),(149,58,26,17.82,14.10,1.01),(150,59,27,13.28,19.95,3.62),(151,59,28,14.67,4.90,19.26),(152,59,29,5.82,9.15,8.41),(153,60,18,19.60,0.82,2.49),(154,60,19,10.12,12.61,10.96),(155,61,33,15.70,14.37,2.52),(156,61,34,9.05,7.65,15.32),(157,61,35,8.36,12.16,15.39),(158,62,20,10.65,15.08,6.88),(159,62,21,2.16,16.59,4.61),(160,62,22,14.36,8.62,5.06),(161,63,23,19.31,7.20,16.83),(162,63,24,8.07,14.62,1.35),(163,64,30,10.16,12.25,7.68),(164,64,31,2.35,10.55,0.47),(165,64,32,6.88,9.29,8.02),(166,65,25,16.31,8.61,2.29),(167,65,26,5.23,16.28,16.11),(168,66,27,2.36,19.65,0.59),(169,66,28,16.22,19.44,10.59),(170,66,29,6.87,3.48,15.23),(171,67,18,15.00,7.56,18.90),(172,67,19,14.18,3.45,13.72),(173,68,33,15.41,2.18,7.93),(174,68,34,19.53,16.13,14.53),(175,68,35,6.57,15.50,14.54),(176,69,20,8.60,2.21,11.20),(177,69,21,14.81,18.37,19.85),(178,69,22,14.68,7.36,12.97),(179,70,23,16.67,17.46,17.71),(180,70,24,19.16,5.52,17.42),(181,71,30,7.39,13.37,8.57),(182,71,31,18.19,8.38,5.05),(183,71,32,15.96,15.79,5.14),(184,72,25,17.30,15.82,4.03),(185,72,26,4.64,15.16,8.33),(186,73,27,12.93,17.50,19.73),(187,73,28,8.53,3.29,1.52),(188,73,29,10.81,0.41,12.04),(189,74,18,11.10,5.57,9.24),(190,74,19,8.92,0.99,16.55),(191,75,33,9.17,14.89,12.40),(192,75,34,10.34,5.97,1.03),(193,75,35,14.68,17.67,7.18),(194,76,20,6.43,8.20,17.26),(195,76,21,19.31,2.84,3.82),(196,76,22,1.84,18.00,6.64),(197,77,23,2.84,16.96,8.03),(198,77,24,17.50,10.87,14.55),(199,78,30,1.63,10.92,7.85),(200,78,31,17.09,8.97,11.20),(201,78,32,1.87,16.64,14.39),(202,79,25,19.66,6.13,16.36),(203,79,26,14.37,18.82,16.13),(204,80,27,2.31,8.46,0.52),(205,80,28,14.32,2.89,17.08),(206,80,29,2.36,19.56,18.49),(207,81,18,16.29,15.15,2.38),(208,81,19,12.99,16.74,8.13),(209,82,33,7.82,1.19,5.90),(210,82,34,0.61,7.64,18.81),(211,82,35,18.78,17.51,5.58),(212,83,20,17.17,7.18,11.84),(213,83,21,13.90,5.01,5.79),(214,83,22,13.71,1.83,4.23),(215,84,23,3.93,20.00,8.65),(216,84,24,11.84,19.74,4.68),(217,85,30,0.10,5.28,9.58),(218,85,31,2.26,3.95,6.79),(219,85,32,18.47,6.37,7.99),(220,86,25,1.88,4.57,3.30),(221,86,26,7.44,12.27,5.91),(222,87,27,12.83,6.86,16.56),(223,87,28,14.36,8.97,9.14),(224,87,29,12.75,15.70,16.95),(225,88,18,3.66,14.26,5.19),(226,88,19,0.64,18.54,8.31),(227,89,33,7.85,6.59,10.64),(228,89,34,11.20,19.04,16.74),(229,89,35,0.65,1.89,6.30),(230,90,20,9.64,4.50,5.35),(231,90,21,16.23,6.56,3.79),(232,90,22,5.93,19.56,13.04),(233,91,23,15.59,15.12,0.14),(234,91,24,2.90,13.97,10.08),(235,92,30,7.92,0.64,14.94),(236,92,31,18.06,2.93,14.71),(237,92,32,0.26,10.11,15.89),(238,93,25,13.46,14.28,4.14),(239,93,26,14.73,6.29,9.22),(240,94,27,0.52,9.36,17.29),(241,94,28,17.61,1.18,2.04),(242,94,29,2.93,11.58,10.75),(243,95,18,17.77,9.48,7.15),(244,95,19,12.91,19.45,12.07),(245,96,33,4.10,19.51,8.60),(246,96,34,0.02,15.78,15.76),(247,96,35,17.02,10.64,11.74),(248,97,20,0.22,19.15,19.81),(249,97,21,3.92,9.70,7.27),(250,97,22,3.75,8.15,13.95),(251,98,23,9.92,11.68,16.00),(252,98,24,13.76,9.49,19.79),(253,99,30,15.55,12.89,13.94),(254,99,31,3.67,4.14,16.52),(255,99,32,11.31,10.39,7.72),(256,100,25,18.15,16.87,1.54),(257,100,26,14.62,8.92,2.83),(258,101,27,1.90,3.54,3.17),(259,101,28,16.97,0.98,9.10),(260,101,29,7.81,2.38,3.56),(261,102,18,16.18,11.49,18.31),(262,102,19,13.17,15.63,17.41),(263,103,33,4.85,16.20,9.28),(264,103,34,13.92,11.02,6.97),(265,103,35,19.32,13.96,18.40),(266,104,20,18.43,3.10,7.99),(267,104,21,4.77,6.08,3.41),(268,104,22,0.60,12.38,0.33),(269,105,23,15.48,7.42,19.13),(270,105,24,4.82,10.13,15.75),(271,106,30,14.99,18.03,19.91),(272,106,31,18.39,3.32,1.29),(273,106,32,3.10,0.49,18.61),(274,107,25,5.76,11.07,4.13),(275,107,26,1.10,15.68,5.97),(276,108,27,19.06,9.86,19.61),(277,108,28,4.31,17.62,2.31),(278,108,29,3.29,14.73,10.13),(279,109,18,7.88,7.24,19.40),(280,109,19,16.37,10.45,13.99),(281,110,33,5.56,2.93,15.32),(282,110,34,19.01,2.37,5.52),(283,110,35,12.89,2.23,2.14),(284,111,20,9.54,9.38,11.30),(285,111,21,1.80,17.80,1.47),(286,111,22,8.69,2.03,2.86),(287,112,23,8.72,8.54,6.13),(288,112,24,1.14,9.60,16.59),(289,113,30,10.93,19.55,8.87),(290,113,31,12.78,15.83,19.15),(291,113,32,9.74,16.01,13.51),(292,114,25,14.72,1.77,16.50),(293,114,26,19.26,9.08,2.51),(294,115,27,4.85,14.89,17.23),(295,115,28,9.85,11.65,1.51),(296,115,29,1.85,5.87,12.54),(297,116,18,10.19,17.71,1.52),(298,116,19,13.02,14.54,12.80),(299,117,33,0.23,4.32,5.08),(300,117,34,0.20,7.71,12.35),(301,117,35,12.75,5.67,11.96),(302,118,20,3.43,9.65,5.76),(303,118,21,18.26,8.31,19.18),(304,118,22,13.98,12.02,1.19),(305,119,23,12.36,2.35,14.42),(306,119,24,3.34,0.38,0.92),(307,120,30,9.86,14.75,13.50),(308,120,31,4.59,15.80,15.10),(309,120,32,0.56,13.69,13.36),(310,121,25,13.13,4.45,2.45),(311,121,26,3.09,13.69,14.54),(312,122,27,14.66,16.14,19.10),(313,122,28,1.28,15.94,5.22),(314,122,29,0.96,1.91,4.72),(315,123,18,1.23,3.34,17.03),(316,123,19,4.08,12.19,19.45),(317,124,33,6.62,7.26,9.71),(318,124,34,2.94,2.39,10.24),(319,124,35,17.02,3.43,18.80),(320,125,20,2.57,13.36,1.79),(321,125,21,4.36,4.91,18.52),(322,125,22,15.88,8.44,7.13),(323,126,23,3.71,14.03,15.39),(324,126,24,5.94,15.65,10.12),(325,127,30,11.04,11.00,4.93),(326,127,31,8.03,13.47,16.06),(327,127,32,19.27,12.03,2.02),(328,128,25,12.98,4.28,4.34),(329,128,26,12.64,13.87,10.67),(330,129,27,3.31,14.26,7.96),(331,129,28,0.77,0.44,16.01),(332,129,29,2.23,19.46,3.78),(333,130,18,2.24,8.89,1.24),(334,130,19,19.60,2.63,0.10),(335,131,33,16.79,1.36,10.06),(336,131,34,10.38,4.27,8.23),(337,131,35,16.68,1.48,11.24),(338,132,20,15.80,19.75,15.61),(339,132,21,11.04,7.58,9.65),(340,132,22,18.00,19.07,4.11),(341,133,23,18.20,8.24,10.64),(342,133,24,9.90,0.77,9.04),(343,134,30,17.92,0.63,7.53),(344,134,31,12.00,1.15,14.75),(345,134,32,8.39,16.52,14.99),(346,135,25,0.45,6.93,0.66),(347,135,26,17.49,19.34,19.56),(348,136,27,6.23,19.25,18.13),(349,136,28,1.82,18.34,8.33),(350,136,29,17.49,5.44,17.30),(351,137,18,0.90,7.23,12.18),(352,137,19,10.36,13.09,10.60),(353,138,33,5.90,4.00,17.56),(354,138,34,16.26,4.74,4.33),(355,138,35,4.05,7.39,7.95),(356,139,20,0.31,9.38,13.99),(357,139,21,14.80,0.19,14.05),(358,139,22,18.92,4.56,4.45),(359,140,23,12.18,19.12,0.47),(360,140,24,17.77,11.36,3.36),(361,141,30,0.33,1.78,11.77),(362,141,31,19.95,1.63,1.63),(363,141,32,17.59,18.01,9.00),(364,142,25,12.94,19.41,15.96),(365,142,26,17.82,2.46,18.71),(366,143,27,3.84,11.34,14.11),(367,143,28,11.04,0.66,8.52),(368,143,29,4.08,8.44,16.54),(369,144,18,4.90,19.15,9.78),(370,144,19,12.54,7.38,8.80),(371,145,33,9.69,5.75,18.33),(372,145,34,17.54,8.11,0.00),(373,145,35,17.65,5.96,15.17),(374,146,20,10.81,12.42,14.67),(375,146,21,15.22,4.25,13.77),(376,146,22,7.54,16.41,16.82),(377,147,23,5.52,12.99,5.38),(378,147,24,13.60,12.52,0.59),(379,148,30,11.81,7.63,11.99),(380,148,31,12.90,7.74,19.33),(381,148,32,14.42,12.93,11.76),(382,149,25,14.87,19.45,12.01),(383,149,26,11.13,4.88,8.73),(384,150,27,18.29,10.40,7.18),(385,150,28,3.34,6.15,16.39),(386,150,29,7.24,3.87,13.41),(387,151,18,8.52,13.69,15.40),(388,151,19,15.56,17.25,2.67),(389,152,33,4.31,11.53,10.00),(390,152,34,1.66,6.31,10.39),(391,152,35,12.91,15.21,0.05),(392,153,20,18.79,15.48,12.91),(393,153,21,19.02,16.26,8.75),(394,153,22,1.91,5.94,1.58),(395,154,23,11.65,1.56,14.85),(396,154,24,3.12,5.20,6.02),(397,155,30,5.84,1.70,5.19),(398,155,31,1.25,2.28,9.23),(399,155,32,4.36,15.31,14.14),(400,156,25,14.33,16.92,13.94),(401,156,26,6.66,18.94,13.73),(402,157,27,6.69,9.29,6.65),(403,157,28,4.94,15.06,17.86),(404,157,29,10.28,14.05,10.33),(405,158,18,19.30,0.36,10.68),(406,158,19,8.82,11.42,13.97),(407,159,33,10.76,16.78,11.36),(408,159,34,9.90,14.36,0.62),(409,159,35,6.49,8.42,18.19),(410,160,20,9.06,4.51,4.20),(411,160,21,16.22,2.11,9.03),(412,160,22,12.27,1.96,5.71),(413,161,23,14.67,3.19,18.23),(414,161,24,11.77,15.95,4.21),(415,162,30,1.87,3.22,15.54),(416,162,31,11.52,0.24,19.68),(417,162,32,12.02,1.19,12.42),(418,163,25,19.96,17.20,6.69),(419,163,26,6.95,5.02,16.84),(420,164,27,6.29,9.22,4.19),(421,164,28,8.33,17.56,19.77),(422,164,29,17.43,9.26,2.14),(423,165,18,18.92,13.96,8.66),(424,165,19,18.16,7.64,5.19),(425,166,33,7.05,9.38,4.37),(426,166,34,11.15,15.69,3.67),(427,166,35,12.57,3.59,11.16),(428,167,20,2.47,5.58,4.00),(429,167,21,6.27,14.64,0.20),(430,167,22,13.68,8.88,6.32),(431,168,23,10.95,8.98,6.42),(432,168,24,1.34,1.38,3.69),(433,169,30,16.50,4.12,12.35),(434,169,31,12.18,17.07,1.53),(435,169,32,3.05,10.00,11.22),(436,170,25,19.06,12.64,5.54),(437,170,26,10.17,11.85,1.75),(438,171,27,10.68,3.45,7.26),(439,171,28,0.86,12.83,10.50),(440,171,29,11.93,16.72,16.55),(441,172,18,8.76,14.43,10.76),(442,172,19,0.16,17.24,3.93),(443,173,33,12.03,12.35,15.23),(444,173,34,2.29,4.58,8.77),(445,173,35,15.71,5.15,0.19),(446,174,20,2.65,14.86,10.02),(447,174,21,11.37,16.10,5.86),(448,174,22,4.76,10.88,2.02),(449,175,23,14.31,1.41,1.74),(450,175,24,10.89,16.76,11.12),(451,176,30,6.58,12.98,13.33),(452,176,31,12.59,15.99,8.33),(453,176,32,5.87,4.71,6.15),(454,177,25,19.94,2.89,0.22),(455,177,26,5.95,18.76,8.59),(456,178,27,0.38,8.07,1.19),(457,178,28,5.26,4.98,16.50),(458,178,29,14.94,15.48,0.56),(459,179,18,15.03,14.11,18.96),(460,179,19,18.42,10.47,7.43),(461,180,33,3.02,18.80,14.94),(462,180,34,5.16,0.69,3.42),(463,180,35,19.66,6.03,12.32),(464,181,20,7.84,8.61,4.26),(465,181,21,18.39,13.86,15.05),(466,181,22,18.24,5.69,12.27),(467,182,23,15.18,4.94,16.62),(468,182,24,9.50,5.49,10.65),(469,183,30,10.74,1.99,14.56),(470,183,31,12.30,5.22,19.25),(471,183,32,0.56,16.41,3.29),(472,184,25,16.59,8.17,6.46),(473,184,26,5.44,9.40,1.37),(474,185,27,5.85,18.70,0.16),(475,185,28,1.36,14.87,15.04),(476,185,29,13.23,13.81,3.61),(477,186,18,9.87,12.47,12.06),(478,186,19,9.94,16.66,2.13),(479,187,33,0.11,8.32,4.42),(480,187,34,14.11,4.96,10.65),(481,187,35,5.59,7.20,15.25),(482,188,20,10.97,3.01,4.74),(483,188,21,11.97,9.70,6.44),(484,188,22,3.98,9.65,16.53),(485,189,23,3.35,13.81,7.37),(486,189,24,8.69,6.06,9.90),(487,190,30,3.14,7.74,19.15),(488,190,31,13.11,8.63,8.48),(489,190,32,19.44,0.48,6.33),(490,191,25,18.08,17.39,8.72),(491,191,26,3.34,15.49,16.42),(492,192,27,16.29,14.42,19.67),(493,192,28,1.76,19.23,9.33),(494,192,29,10.55,1.33,5.95),(495,193,18,4.29,1.66,19.85),(496,193,19,15.55,10.01,0.80),(497,194,33,3.75,14.73,9.08),(498,194,34,7.88,14.52,5.56),(499,194,35,6.50,12.47,10.59),(500,195,20,7.74,11.37,3.02),(501,195,21,6.06,15.05,9.98),(502,195,22,1.91,2.71,14.91),(503,196,23,15.57,6.12,2.13),(504,196,24,18.55,1.31,7.02),(505,197,30,19.04,10.28,5.55),(506,197,31,11.30,15.84,10.75),(507,197,32,3.74,5.78,16.96),(508,198,25,6.99,1.96,10.58),(509,198,26,12.58,16.29,10.63),(510,199,27,17.25,13.22,18.51),(511,199,28,5.02,10.45,4.30),(512,199,29,7.66,11.61,0.42),(513,200,18,16.10,5.17,14.76),(514,200,19,16.66,14.69,6.62),(515,201,33,13.73,19.21,11.44),(516,201,34,17.19,2.53,4.09),(517,201,35,8.46,3.99,7.62),(518,202,20,6.44,10.34,14.48),(519,202,21,6.22,19.25,15.73),(520,202,22,15.67,3.19,8.75),(521,203,23,14.27,3.50,12.67),(522,203,24,1.92,10.66,2.99),(523,204,30,4.53,14.96,18.11),(524,204,31,10.52,13.91,5.47),(525,204,32,6.83,14.01,20.00),(526,205,25,11.24,9.48,8.01),(527,205,26,1.09,4.83,17.39),(528,206,27,1.93,13.59,0.60),(529,206,28,16.52,6.56,10.88),(530,206,29,1.27,19.81,1.09),(531,207,18,3.73,14.22,1.16),(532,207,19,12.69,16.94,16.60),(533,208,33,19.47,18.04,18.05),(534,208,34,11.90,14.75,8.73),(535,208,35,2.74,3.72,2.93),(536,209,20,2.35,16.03,7.67),(537,209,21,0.58,1.81,18.28),(538,209,22,12.42,8.08,3.15),(539,210,23,19.76,9.21,19.33),(540,210,24,14.08,4.14,0.54);
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `periodos`
--

LOCK TABLES `periodos` WRITE;
/*!40000 ALTER TABLE `periodos` DISABLE KEYS */;
INSERT INTO `periodos` VALUES (1,'2025-1','2025-03-01','2025-07-31',1),(2,'2025-2','2025-08-01','2025-12-20',1);
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
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plan_estudios`
--

LOCK TABLES `plan_estudios` WRITE;
/*!40000 ALTER TABLE `plan_estudios` DISABLE KEYS */;
INSERT INTO `plan_estudios` VALUES (2,3,1,1),(4,3,2,1),(8,3,3,1),(3,3,4,1),(7,3,5,1),(6,3,6,1),(5,3,7,1),(1,3,8,1),(12,3,9,2),(14,3,10,2),(15,3,11,2),(10,3,12,2),(11,3,13,2),(9,3,14,2),(13,3,15,2);
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `semestres`
--

LOCK TABLES `semestres` WRITE;
/*!40000 ALTER TABLE `semestres` DISABLE KEYS */;
INSERT INTO `semestres` VALUES (1,1,'Primer Semestre'),(2,2,'Segundo Semestre');
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

-- Dump completed on 2025-12-01 23:46:38

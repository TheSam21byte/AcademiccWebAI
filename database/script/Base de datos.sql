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
  `id_docente` int DEFAULT NULL,
  `nombre` varchar(100) NOT NULL,
  `creditos` int NOT NULL,
  `silabo` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id_curso`),
  KEY `fk_curso_docente` (`id_docente`),
  CONSTRAINT `fk_curso_docente` FOREIGN KEY (`id_docente`) REFERENCES `docentes` (`id_docente`),
  CONSTRAINT `cursos_chk_1` CHECK ((`creditos` in (2,3,4)))
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cursos`
--

LOCK TABLES `cursos` WRITE;
/*!40000 ALTER TABLE `cursos` DISABLE KEYS */;
INSERT INTO `cursos` VALUES (1,1,'ALGORITMOS INTRODUCTORIOS',3,'Silabo por definir'),(2,2,'CULTURA DE PAZ Y DEFENSA NACIONAL',2,'Silabo por definir'),(3,3,'REDACCION TECNICA Y CIENTIFICA',2,'Silabo por definir'),(4,4,'COMPLEMENTO DE MATEMATICA',4,'Silabo por definir'),(5,5,'LENGUAJE Y COMUNICACION',3,'Silabo por definir'),(6,6,'INTRODUCCION A INGENIERIA DE SISTEMAS',3,'Silabo por definir'),(7,7,'ECOLOGIA GENERAL Y RECURSOS NATURALES',3,'Silabo por definir'),(8,8,'ACTIVIDADES CULTURALES Y/O DEPORTIVAS',2,'Silabo por definir'),(9,9,'DISEÑO PARA INGENIERIA',2,'D:\\8VO SEMESTRE\\IA\\DB Prueba Insertación de Datos\\database\\S2022-2\\DISEÑO.pdf'),(10,10,'QUIMICA GENERAL',4,'D:\\8VO SEMESTRE\\IA\\DB Prueba Insertación de Datos\\database\\S2022-2\\QUIMICA_GENERAL.pdf'),(11,11,'SOCIOLOGIA RURAL Y AMAZONICA',2,'D:\\8VO SEMESTRE\\IA\\DB Prueba Insertación de Datos\\database\\S2022-2\\SOCIOLOGIA.pdf'),(12,12,'ALGORITMOS Y PROGRAMACIÓN',3,'D:\\8VO SEMESTRE\\IA\\DB Prueba Insertación de Datos\\database\\S2022-2\\ALGORITMOS.pdf'),(13,13,'CALCULO I',4,'D:\\8VO SEMESTRE\\IA\\DB Prueba Insertación de Datos\\database\\S2022-2\\CALCULI.pdf'),(14,14,'ALGEBRA LINEAL',4,'D:\\8VO SEMESTRE\\IA\\DB Prueba Insertación de Datos\\database\\S2022-2\\ALGEBRA_LINEAL.pdf'),(15,15,'FISICA I',4,'D:\\8VO SEMESTRE\\IA\\DB Prueba Insertación de Datos\\database\\S2022-2\\FISICAI.pdf');
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
INSERT INTO `estudiantes` VALUES (1,'20250001','40000000','Luciana','Torres','Díaz',3),(2,'20250002','40000001','Sebastián','Díaz','Rojas',3),(3,'20250003','40000002','Emilio','Rojas','Rodríguez',3),(4,'20250004','40000003','Andrea','Rojas','Castro',3),(5,'20250005','40000004','Elena','Vargas','González',3),(6,'20250006','40000005','Sofía','Pérez','Mendoza',3),(7,'20250007','40000006','Paula','Fernández','Acuña',3),(8,'20250008','40000007','Elena','González','Mendoza',3),(9,'20250009','40000008','Andrea','Sánchez','Gómez',3),(10,'20250010','40000009','Emilio','Díaz','González',3),(11,'20250011','40000010','Mateo','Pérez','Silva',3),(12,'20250012','40000011','Paula','Pérez','Díaz',3),(13,'20250013','40000012','Isabella','Flores','Díaz',3),(14,'20250014','40000013','Mateo','Castro','Flores',3),(15,'20250015','40000014','Valeria','López','Espinoza',3),(16,'20250016','40000015','Camila','Rojas','González',3),(17,'20250017','40000016','Emilio','Vargas','López',3),(18,'20250018','40000017','Nicolás','Sánchez','Rodríguez',3),(19,'20250019','40000018','Valeria','Martínez','García',3),(20,'20250020','40000019','Gabriel','Espinoza','González',3),(21,'20250021','40000020','Paula','Castro','Silva',3),(22,'20250022','40000021','Andrea','Castro','Díaz',3),(23,'20250023','40000022','María','Castro','Mendoza',3),(24,'20250024','40000023','Paula','Fernández','Mendoza',3),(25,'20250025','40000024','Mateo','Silva','Herrera',3),(26,'20250026','40000025','Camila','Gómez','Sánchez',3),(27,'20250027','40000026','Camila','López','Rojas',3),(28,'20250028','40000027','Paula','Rodríguez','Pérez',3),(29,'20250029','40000028','Sebastián','Silva','Espinoza',3),(30,'20250030','40000029','María','Martínez','Espinoza',3);
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
INSERT INTO `matriculas` VALUES (1,1,9,2),(2,1,10,2),(3,1,11,2),(4,1,12,2),(5,1,13,2),(6,1,14,2),(7,1,15,2),(8,2,9,2),(9,2,10,2),(10,2,11,2),(11,2,12,2),(12,2,13,2),(13,2,14,2),(14,2,15,2),(15,3,9,2),(16,3,10,2),(17,3,11,2),(18,3,12,2),(19,3,13,2),(20,3,14,2),(21,3,15,2),(22,4,9,2),(23,4,10,2),(24,4,11,2),(25,4,12,2),(26,4,13,2),(27,4,14,2),(28,4,15,2),(29,5,9,2),(30,5,10,2),(31,5,11,2),(32,5,12,2),(33,5,13,2),(34,5,14,2),(35,5,15,2),(36,6,9,2),(37,6,10,2),(38,6,11,2),(39,6,12,2),(40,6,13,2),(41,6,14,2),(42,6,15,2),(43,7,9,2),(44,7,10,2),(45,7,11,2),(46,7,12,2),(47,7,13,2),(48,7,14,2),(49,7,15,2),(50,8,9,2),(51,8,10,2),(52,8,11,2),(53,8,12,2),(54,8,13,2),(55,8,14,2),(56,8,15,2),(57,9,9,2),(58,9,10,2),(59,9,11,2),(60,9,12,2),(61,9,13,2),(62,9,14,2),(63,9,15,2),(64,10,9,2),(65,10,10,2),(66,10,11,2),(67,10,12,2),(68,10,13,2),(69,10,14,2),(70,10,15,2),(71,11,9,2),(72,11,10,2),(73,11,11,2),(74,11,12,2),(75,11,13,2),(76,11,14,2),(77,11,15,2),(78,12,9,2),(79,12,10,2),(80,12,11,2),(81,12,12,2),(82,12,13,2),(83,12,14,2),(84,12,15,2),(85,13,9,2),(86,13,10,2),(87,13,11,2),(88,13,12,2),(89,13,13,2),(90,13,14,2),(91,13,15,2),(92,14,9,2),(93,14,10,2),(94,14,11,2),(95,14,12,2),(96,14,13,2),(97,14,14,2),(98,14,15,2),(99,15,9,2),(100,15,10,2),(101,15,11,2),(102,15,12,2),(103,15,13,2),(104,15,14,2),(105,15,15,2),(106,16,9,2),(107,16,10,2),(108,16,11,2),(109,16,12,2),(110,16,13,2),(111,16,14,2),(112,16,15,2),(113,17,9,2),(114,17,10,2),(115,17,11,2),(116,17,12,2),(117,17,13,2),(118,17,14,2),(119,17,15,2),(120,18,9,2),(121,18,10,2),(122,18,11,2),(123,18,12,2),(124,18,13,2),(125,18,14,2),(126,18,15,2),(127,19,9,2),(128,19,10,2),(129,19,11,2),(130,19,12,2),(131,19,13,2),(132,19,14,2),(133,19,15,2),(134,20,9,2),(135,20,10,2),(136,20,11,2),(137,20,12,2),(138,20,13,2),(139,20,14,2),(140,20,15,2),(141,21,9,2),(142,21,10,2),(143,21,11,2),(144,21,12,2),(145,21,13,2),(146,21,14,2),(147,21,15,2),(148,22,9,2),(149,22,10,2),(150,22,11,2),(151,22,12,2),(152,22,13,2),(153,22,14,2),(154,22,15,2),(155,23,9,2),(156,23,10,2),(157,23,11,2),(158,23,12,2),(159,23,13,2),(160,23,14,2),(161,23,15,2),(162,24,9,2),(163,24,10,2),(164,24,11,2),(165,24,12,2),(166,24,13,2),(167,24,14,2),(168,24,15,2),(169,25,9,2),(170,25,10,2),(171,25,11,2),(172,25,12,2),(173,25,13,2),(174,25,14,2),(175,25,15,2),(176,26,9,2),(177,26,10,2),(178,26,11,2),(179,26,12,2),(180,26,13,2),(181,26,14,2),(182,26,15,2),(183,27,9,2),(184,27,10,2),(185,27,11,2),(186,27,12,2),(187,27,13,2),(188,27,14,2),(189,27,15,2),(190,28,9,2),(191,28,10,2),(192,28,11,2),(193,28,12,2),(194,28,13,2),(195,28,14,2),(196,28,15,2),(197,29,9,2),(198,29,10,2),(199,29,11,2),(200,29,12,2),(201,29,13,2),(202,29,14,2),(203,29,15,2),(204,30,9,2),(205,30,10,2),(206,30,11,2),(207,30,12,2),(208,30,13,2),(209,30,14,2),(210,30,15,2);
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
INSERT INTO `notas_unidad` (`id_nota_unidad`, `id_matricula`, `id_unidad`, `nota_actitudinal`, `nota_procedimental`, `nota_conceptual`) VALUES (1,1,18,16.20,12.26,6.12),(2,1,19,18.79,15.35,0.44),(3,2,20,13.36,7.29,15.36),(4,2,21,13.59,19.62,1.59),(5,2,22,0.85,11.81,0.91),(6,3,23,16.34,16.82,13.46),(7,3,24,6.91,17.86,7.96),(8,4,25,2.45,9.34,5.38),(9,4,26,18.84,3.28,0.21),(10,5,27,2.26,5.69,0.02),(11,5,28,13.99,14.48,3.99),(12,5,29,6.07,10.17,6.43),(13,6,30,13.87,1.95,7.28),(14,6,31,10.28,5.89,14.29),(15,6,32,16.78,12.21,6.10),(16,7,33,18.02,5.34,12.85),(17,7,34,16.05,8.23,2.50),(18,7,35,16.05,15.40,18.31),(19,8,18,14.19,1.22,7.94),(20,8,19,13.09,11.82,5.84),(21,9,20,19.82,16.26,16.87),(22,9,21,19.47,18.11,10.22),(23,9,22,8.78,15.03,0.26),(24,10,23,10.78,10.88,10.87),(25,10,24,1.21,4.38,11.65),(26,11,25,6.82,11.16,17.98),(27,11,26,7.69,11.44,15.38),(28,12,27,1.50,14.29,8.05),(29,12,28,1.74,1.55,2.20),(30,12,29,1.13,13.50,0.65),(31,13,30,17.21,4.12,9.18),(32,13,31,17.55,4.47,10.30),(33,13,32,12.22,6.32,8.76),(34,14,33,16.06,17.27,4.60),(35,14,34,0.19,19.98,12.51),(36,14,35,2.96,15.83,10.63),(37,15,18,10.96,1.63,19.17),(38,15,19,17.32,1.29,15.37),(39,16,20,0.79,18.01,2.64),(40,16,21,6.34,14.76,4.06),(41,16,22,8.62,13.59,12.77),(42,17,23,12.10,3.27,2.15),(43,17,24,9.33,4.06,1.60),(44,18,25,9.15,1.03,14.75),(45,18,26,2.62,15.75,16.13),(46,19,27,7.67,18.15,14.47),(47,19,28,15.03,10.71,2.12),(48,19,29,1.57,5.42,0.09),(49,20,30,8.68,14.24,6.26),(50,20,31,7.41,5.87,13.34),(51,20,32,2.26,17.32,0.48),(52,21,33,1.62,5.53,13.54),(53,21,34,11.50,19.23,15.50),(54,21,35,9.24,8.99,8.42),(55,22,18,15.00,7.98,18.58),(56,22,19,13.34,18.14,2.88),(57,23,20,0.32,8.24,5.98),(58,23,21,4.39,11.18,10.03),(59,23,22,18.23,0.13,11.88),(60,24,23,17.97,16.67,2.07),(61,24,24,14.38,13.48,18.80),(62,25,25,19.39,15.19,10.16),(63,25,26,3.17,10.95,10.25),(64,26,27,5.65,4.09,19.53),(65,26,28,19.22,4.77,11.75),(66,26,29,14.72,14.19,19.49),(67,27,30,16.97,4.90,10.85),(68,27,31,10.89,0.72,14.74),(69,27,32,4.58,5.56,19.65),(70,28,33,18.68,12.47,10.31),(71,28,34,3.60,7.08,15.11),(72,28,35,4.74,15.49,8.22),(73,29,18,7.97,13.76,19.35),(74,29,19,6.40,17.01,16.74),(75,30,20,16.37,4.47,10.02),(76,30,21,0.37,0.05,7.82),(77,30,22,17.77,14.60,12.65),(78,31,23,13.02,2.25,13.35),(79,31,24,16.12,2.04,10.76),(80,32,25,4.33,7.18,13.01),(81,32,26,7.03,13.92,4.78),(82,33,27,6.71,3.26,9.93),(83,33,28,6.53,6.12,9.41),(84,33,29,10.88,17.73,7.92),(85,34,30,0.65,4.63,11.67),(86,34,31,7.95,0.93,10.47),(87,34,32,1.87,7.19,9.69),(88,35,33,18.17,13.95,4.39),(89,35,34,12.00,19.92,12.82),(90,35,35,17.76,0.22,2.46),(91,36,18,4.14,13.64,17.54),(92,36,19,10.95,18.26,18.73),(93,37,20,2.30,8.96,5.64),(94,37,21,12.45,4.39,12.55),(95,37,22,5.41,1.88,10.86),(96,38,23,6.32,5.76,19.73),(97,38,24,12.26,7.46,14.12),(98,39,25,9.70,1.88,14.53),(99,39,26,8.97,4.02,16.65),(100,40,27,11.71,2.70,18.93),(101,40,28,7.97,19.09,1.42),(102,40,29,12.19,19.63,12.97),(103,41,30,2.16,5.03,0.39),(104,41,31,5.86,8.53,18.87),(105,41,32,2.02,2.33,16.03),(106,42,33,7.99,4.59,17.76),(107,42,34,9.12,13.34,14.18),(108,42,35,0.11,10.89,16.77),(109,43,18,4.84,9.45,14.27),(110,43,19,8.09,18.55,10.13),(111,44,20,9.52,1.32,1.14),(112,44,21,10.72,14.28,7.30),(113,44,22,3.67,18.42,13.62),(114,45,23,1.23,7.81,13.45),(115,45,24,15.65,12.21,15.55),(116,46,25,10.28,6.94,7.51),(117,46,26,15.19,6.64,2.50),(118,47,27,3.12,13.46,16.95),(119,47,28,3.74,12.87,9.99),(120,47,29,0.19,16.91,16.17),(121,48,30,14.26,2.36,5.26),(122,48,31,11.21,17.52,19.72),(123,48,32,13.17,3.44,4.16),(124,49,33,14.02,16.32,9.41),(125,49,34,12.20,0.08,14.64),(126,49,35,5.18,13.98,9.17),(127,50,18,0.69,16.13,13.70),(128,50,19,13.08,14.80,10.10),(129,51,20,11.61,11.28,16.18),(130,51,21,7.69,17.21,0.06),(131,51,22,5.20,11.44,11.41),(132,52,23,14.73,14.33,17.92),(133,52,24,8.29,6.24,18.84),(134,53,25,11.48,1.78,13.22),(135,53,26,3.92,11.88,12.68),(136,54,27,16.15,11.69,19.22),(137,54,28,4.80,19.04,4.40),(138,54,29,2.28,10.77,1.44),(139,55,30,15.55,15.94,0.48),(140,55,31,0.58,0.03,4.61),(141,55,32,16.98,4.98,7.06),(142,56,33,9.74,18.89,12.16),(143,56,34,12.01,7.02,7.19),(144,56,35,18.45,6.14,11.21),(145,57,18,2.77,5.05,10.48),(146,57,19,1.94,16.29,1.14),(147,58,20,5.54,10.21,12.48),(148,58,21,16.02,6.35,9.55),(149,58,22,10.82,18.41,3.21),(150,59,23,8.84,13.12,12.78),(151,59,24,13.83,1.16,1.29),(152,60,25,13.56,13.12,15.98),(153,60,26,1.33,10.75,10.37),(154,61,27,7.43,12.65,14.56),(155,61,28,8.63,9.20,7.33),(156,61,29,10.43,15.27,2.24),(157,62,30,9.02,4.85,10.99),(158,62,31,11.97,17.00,19.19),(159,62,32,18.71,19.04,11.32),(160,63,33,2.64,10.98,15.52),(161,63,34,14.81,5.21,17.67),(162,63,35,15.03,2.88,19.09),(163,64,18,4.58,11.07,8.17),(164,64,19,14.34,6.32,18.10),(165,65,20,5.59,2.15,16.03),(166,65,21,8.43,11.84,9.23),(167,65,22,14.17,0.77,10.04),(168,66,23,6.54,16.09,5.46),(169,66,24,7.49,16.82,15.11),(170,67,25,0.91,6.02,15.59),(171,67,26,7.39,3.23,3.49),(172,68,27,1.64,15.40,15.26),(173,68,28,10.02,13.21,5.88),(174,68,29,0.50,3.88,19.14),(175,69,30,4.56,13.66,16.51),(176,69,31,3.82,14.80,9.50),(177,69,32,15.22,16.17,19.98),(178,70,33,4.66,0.40,16.29),(179,70,34,6.12,4.44,0.83),(180,70,35,14.36,7.80,12.91),(181,71,18,3.28,2.87,12.86),(182,71,19,2.74,5.72,10.05),(183,72,20,1.03,1.29,16.58),(184,72,21,1.77,18.41,4.13),(185,72,22,9.20,8.39,6.97),(186,73,23,18.28,2.90,1.58),(187,73,24,12.60,14.63,17.95),(188,74,25,3.48,15.21,8.49),(189,74,26,16.37,19.48,18.95),(190,75,27,3.49,1.39,16.64),(191,75,28,0.34,6.26,7.61),(192,75,29,11.62,0.23,18.16),(193,76,30,19.42,4.50,5.08),(194,76,31,19.77,3.60,8.45),(195,76,32,15.76,14.42,9.61),(196,77,33,5.45,8.38,10.34),(197,77,34,2.52,2.41,5.83),(198,77,35,17.67,19.74,16.10),(199,78,18,7.09,5.85,3.20),(200,78,19,15.79,12.21,8.54),(201,79,20,7.07,13.11,0.39),(202,79,21,4.08,16.02,2.62),(203,79,22,2.23,8.26,17.60),(204,80,23,17.81,19.64,12.43),(205,80,24,10.37,8.82,14.57),(206,81,25,14.47,9.86,12.07),(207,81,26,0.39,13.12,17.60),(208,82,27,11.54,2.37,2.24),(209,82,28,13.79,15.90,12.60),(210,82,29,15.55,4.00,12.36),(211,83,30,17.73,0.27,12.86),(212,83,31,3.76,17.93,16.56),(213,83,32,13.72,13.29,16.47),(214,84,33,13.73,11.05,12.48),(215,84,34,0.05,2.39,0.40),(216,84,35,12.38,13.18,4.13),(217,85,18,0.52,6.32,11.47),(218,85,19,6.98,4.38,0.04),(219,86,20,4.68,8.94,10.63),(220,86,21,13.01,8.96,12.81),(221,86,22,15.12,17.35,3.02),(222,87,23,8.26,7.56,7.24),(223,87,24,1.01,3.47,2.10),(224,88,25,10.25,16.66,14.43),(225,88,26,18.91,13.23,2.74),(226,89,27,12.02,16.48,13.91),(227,89,28,9.83,7.18,4.25),(228,89,29,12.82,9.17,17.67),(229,90,30,17.16,11.07,3.49),(230,90,31,6.43,13.83,4.71),(231,90,32,10.32,8.83,8.65),(232,91,33,0.30,18.73,14.81),(233,91,34,18.91,5.63,7.86),(234,91,35,16.70,1.56,13.49),(235,92,18,15.32,3.09,18.80),(236,92,19,11.06,0.71,16.77),(237,93,20,9.50,1.47,3.93),(238,93,21,13.54,2.44,4.74),(239,93,22,0.02,17.18,2.94),(240,94,23,19.62,19.37,13.66),(241,94,24,8.30,6.97,5.97),(242,95,25,5.06,10.42,9.34),(243,95,26,4.23,15.31,8.35),(244,96,27,19.08,18.46,9.49),(245,96,28,9.64,14.65,9.88),(246,96,29,11.23,14.71,0.57),(247,97,30,15.45,1.89,18.76),(248,97,31,9.18,4.24,1.75),(249,97,32,8.01,14.84,15.74),(250,98,33,2.75,18.28,15.27),(251,98,34,0.68,5.12,6.67),(252,98,35,4.91,17.22,13.66),(253,99,18,16.78,15.72,14.66),(254,99,19,11.70,11.78,9.29),(255,100,20,1.34,14.54,19.44),(256,100,21,9.09,1.74,14.33),(257,100,22,7.08,3.62,6.09),(258,101,23,0.17,12.46,19.98),(259,101,24,9.13,19.48,2.97),(260,102,25,18.33,9.97,10.03),(261,102,26,17.57,9.48,0.88),(262,103,27,16.57,9.15,0.10),(263,103,28,2.52,2.34,12.45),(264,103,29,11.89,9.29,19.78),(265,104,30,10.58,7.26,9.31),(266,104,31,9.87,15.26,4.27),(267,104,32,5.92,17.82,16.39),(268,105,33,3.94,15.88,18.72),(269,105,34,2.85,16.69,3.11),(270,105,35,17.07,3.19,5.52),(271,106,18,0.85,12.21,0.27),(272,106,19,19.46,17.88,17.57),(273,107,20,2.59,17.77,12.97),(274,107,21,11.25,11.56,4.27),(275,107,22,11.99,18.12,19.03),(276,108,23,8.34,14.89,8.85),(277,108,24,17.20,3.37,11.82),(278,109,25,18.19,8.51,2.71),(279,109,26,14.53,17.91,5.82),(280,110,27,12.78,9.09,19.78),(281,110,28,17.99,6.42,19.39),(282,110,29,6.63,18.69,17.53),(283,111,30,6.04,16.96,9.70),(284,111,31,9.24,12.82,2.73),(285,111,32,1.14,16.58,12.62),(286,112,33,15.95,3.92,16.31),(287,112,34,1.94,3.69,0.66),(288,112,35,1.88,3.17,5.75),(289,113,18,7.87,19.46,18.43),(290,113,19,14.06,4.90,0.18),(291,114,20,2.84,7.92,9.00),(292,114,21,14.19,17.41,6.91),(293,114,22,7.56,8.89,16.51),(294,115,23,2.21,5.46,15.90),(295,115,24,20.00,8.42,7.51),(296,116,25,6.94,9.53,4.73),(297,116,26,3.41,11.35,4.07),(298,117,27,18.35,5.71,2.65),(299,117,28,15.64,15.95,9.21),(300,117,29,9.91,6.02,5.53),(301,118,30,3.68,2.99,5.87),(302,118,31,16.74,4.25,11.89),(303,118,32,4.92,17.29,17.47),(304,119,33,13.54,9.42,7.21),(305,119,34,18.67,13.99,5.10),(306,119,35,0.26,19.14,11.74),(307,120,18,9.16,11.59,3.19),(308,120,19,4.66,13.05,17.00),(309,121,20,9.49,18.88,15.14),(310,121,21,16.02,10.79,8.17),(311,121,22,19.26,14.94,1.54),(312,122,23,4.70,2.61,3.71),(313,122,24,7.97,11.28,7.56),(314,123,25,5.62,17.86,17.23),(315,123,26,15.82,10.86,7.95),(316,124,27,2.05,14.66,10.00),(317,124,28,19.39,16.56,4.40),(318,124,29,10.30,19.09,14.76),(319,125,30,9.44,13.30,0.38),(320,125,31,8.82,14.27,12.85),(321,125,32,18.89,8.08,12.73),(322,126,33,9.50,17.28,18.40),(323,126,34,1.96,2.78,13.06),(324,126,35,15.78,9.18,3.61),(325,127,18,9.07,9.79,8.03),(326,127,19,4.57,7.95,11.48),(327,128,20,3.10,10.87,2.20),(328,128,21,15.08,13.77,17.70),(329,128,22,9.83,6.93,15.41),(330,129,23,17.48,19.19,14.71),(331,129,24,8.76,12.27,13.77),(332,130,25,5.41,5.30,15.60),(333,130,26,9.17,7.53,15.33),(334,131,27,7.12,2.88,1.42),(335,131,28,1.86,0.85,1.73),(336,131,29,14.28,15.59,16.27),(337,132,30,2.77,10.27,16.32),(338,132,31,16.81,15.76,7.75),(339,132,32,10.63,19.39,2.68),(340,133,33,5.65,2.63,9.61),(341,133,34,13.86,2.76,19.03),(342,133,35,15.52,6.29,6.69),(343,134,18,18.14,12.50,11.58),(344,134,19,3.97,13.89,17.67),(345,135,20,19.19,9.06,4.24),(346,135,21,5.85,15.03,17.46),(347,135,22,18.29,7.98,11.54),(348,136,23,18.50,5.96,14.86),(349,136,24,17.71,18.44,16.57),(350,137,25,3.45,4.72,16.16),(351,137,26,16.07,16.25,14.87),(352,138,27,16.54,5.38,8.73),(353,138,28,16.25,19.86,3.27),(354,138,29,5.90,1.60,7.42),(355,139,30,10.92,7.69,17.32),(356,139,31,13.14,17.42,10.70),(357,139,32,11.78,5.42,19.56),(358,140,33,1.01,5.02,15.40),(359,140,34,17.56,3.95,4.86),(360,140,35,9.33,19.49,6.30),(361,141,18,12.60,5.37,14.54),(362,141,19,4.38,1.19,13.53),(363,142,20,17.70,11.40,0.48),(364,142,21,12.48,18.63,2.05),(365,142,22,0.53,11.84,17.12),(366,143,23,5.35,3.34,15.52),(367,143,24,15.41,2.63,14.74),(368,144,25,6.00,12.48,7.94),(369,144,26,18.77,10.13,11.91),(370,145,27,18.52,5.15,5.12),(371,145,28,4.94,13.01,4.88),(372,145,29,9.82,12.22,6.62),(373,146,30,0.56,8.17,6.66),(374,146,31,1.67,4.39,3.93),(375,146,32,8.66,3.59,17.60),(376,147,33,17.99,14.04,8.82),(377,147,34,9.80,5.55,19.29),(378,147,35,6.77,4.04,7.96),(379,148,18,6.47,4.63,12.07),(380,148,19,9.43,4.92,18.85),(381,149,20,7.80,16.95,7.20),(382,149,21,2.66,19.89,2.29),(383,149,22,5.28,11.20,13.53),(384,150,23,9.16,2.85,14.38),(385,150,24,3.85,13.90,14.40),(386,151,25,3.30,6.92,11.35),(387,151,26,14.22,6.74,0.97),(388,152,27,15.35,13.44,8.63),(389,152,28,16.35,7.60,10.15),(390,152,29,7.76,3.70,2.11),(391,153,30,11.11,0.35,9.72),(392,153,31,12.42,0.28,0.76),(393,153,32,12.70,6.50,3.47),(394,154,33,17.24,11.14,19.00),(395,154,34,6.68,8.85,3.50),(396,154,35,12.88,19.91,4.43),(397,155,18,7.14,5.07,8.77),(398,155,19,18.22,0.35,16.73),(399,156,20,19.33,0.48,3.86),(400,156,21,3.00,17.32,8.84),(401,156,22,3.85,14.64,5.76),(402,157,23,16.19,11.24,19.90),(403,157,24,10.37,17.52,2.15),(404,158,25,2.66,9.86,6.09),(405,158,26,4.63,7.58,8.76),(406,159,27,3.51,4.27,6.66),(407,159,28,9.24,17.91,16.00),(408,159,29,7.52,6.65,2.76),(409,160,30,14.08,17.52,6.81),(410,160,31,12.33,10.69,17.79),(411,160,32,18.59,13.79,0.38),(412,161,33,4.71,13.25,4.62),(413,161,34,4.45,14.91,11.65),(414,161,35,6.37,15.76,13.63),(415,162,18,8.67,0.52,19.34),(416,162,19,9.61,2.12,0.41),(417,163,20,1.38,2.51,14.97),(418,163,21,18.01,15.55,16.13),(419,163,22,4.16,2.19,15.88),(420,164,23,1.23,9.04,10.40),(421,164,24,0.19,17.28,8.72),(422,165,25,13.86,3.42,2.94),(423,165,26,11.56,16.58,4.36),(424,166,27,6.39,4.68,17.62),(425,166,28,17.44,18.52,5.15),(426,166,29,5.61,0.28,12.69),(427,167,30,7.74,4.21,17.41),(428,167,31,6.96,7.78,14.83),(429,167,32,4.51,14.19,5.10),(430,168,33,7.93,19.87,2.07),(431,168,34,6.81,9.65,9.61),(432,168,35,16.98,4.22,0.22),(433,169,18,15.74,10.03,19.06),(434,169,19,11.63,8.61,16.41),(435,170,20,19.33,1.49,19.61),(436,170,21,18.50,14.54,12.18),(437,170,22,11.37,2.37,15.18),(438,171,23,3.80,10.97,1.56),(439,171,24,3.34,2.97,1.11),(440,172,25,6.74,14.13,11.63),(441,172,26,19.09,5.52,15.24),(442,173,27,7.30,17.60,10.52),(443,173,28,16.24,13.88,4.43),(444,173,29,7.26,14.57,9.64),(445,174,30,19.15,19.91,14.88),(446,174,31,14.14,17.14,18.18),(447,174,32,2.44,3.23,2.14),(448,175,33,12.86,11.47,2.55),(449,175,34,16.73,6.08,18.00),(450,175,35,17.93,4.03,1.90),(451,176,18,16.35,13.03,19.95),(452,176,19,5.13,16.48,6.44),(453,177,20,9.57,1.77,10.47),(454,177,21,4.63,15.20,1.30),(455,177,22,14.35,14.07,14.31),(456,178,23,9.11,3.68,10.47),(457,178,24,0.70,7.44,0.04),(458,179,25,11.16,0.42,1.06),(459,179,26,14.24,7.15,1.27),(460,180,27,4.61,2.71,9.71),(461,180,28,7.75,13.65,6.61),(462,180,29,13.83,18.41,1.67),(463,181,30,15.54,10.45,2.26),(464,181,31,18.12,6.22,17.57),(465,181,32,14.76,12.71,2.96),(466,182,33,5.57,6.43,12.52),(467,182,34,17.63,3.44,14.07),(468,182,35,13.06,10.48,9.02),(469,183,18,8.94,10.44,10.50),(470,183,19,9.14,9.29,2.72),(471,184,20,17.99,8.39,1.24),(472,184,21,11.42,7.07,5.01),(473,184,22,4.23,5.45,2.90),(474,185,23,6.07,13.79,14.65),(475,185,24,2.57,10.00,7.06),(476,186,25,16.11,8.55,14.92),(477,186,26,11.56,2.35,17.84),(478,187,27,15.58,5.23,8.64),(479,187,28,14.74,0.11,12.83),(480,187,29,9.25,18.79,16.78),(481,188,30,2.96,16.88,2.73),(482,188,31,19.56,0.58,8.35),(483,188,32,2.75,0.59,3.01),(484,189,33,8.98,6.10,5.23),(485,189,34,20.00,13.05,4.89),(486,189,35,3.97,4.22,14.18),(487,190,18,11.39,2.18,0.66),(488,190,19,14.74,11.77,0.12),(489,191,20,6.56,14.50,9.70),(490,191,21,3.86,6.51,13.04),(491,191,22,7.14,0.89,9.69),(492,192,23,11.38,4.89,7.71),(493,192,24,19.42,5.41,6.41),(494,193,25,6.09,19.58,4.87),(495,193,26,6.53,0.54,11.33),(496,194,27,17.33,4.12,4.75),(497,194,28,9.38,0.64,6.68),(498,194,29,17.74,3.18,1.82),(499,195,30,14.65,19.02,0.76),(500,195,31,8.06,6.98,18.29),(501,195,32,11.96,18.99,13.25),(502,196,33,5.14,10.34,15.31),(503,196,34,7.84,4.26,12.16),(504,196,35,0.73,2.72,2.85),(505,197,18,11.80,18.38,14.12),(506,197,19,8.26,7.76,13.73),(507,198,20,12.75,5.16,19.74),(508,198,21,16.42,8.10,9.37),(509,198,22,12.30,0.15,0.55),(510,199,23,10.12,9.12,4.25),(511,199,24,10.01,0.33,15.24),(512,200,25,4.67,13.39,15.62),(513,200,26,9.04,17.60,11.99),(514,201,27,10.58,10.03,0.13),(515,201,28,4.97,17.63,13.29),(516,201,29,7.57,5.40,8.01),(517,202,30,3.28,11.35,19.17),(518,202,31,18.66,1.69,5.06),(519,202,32,8.03,8.57,8.32),(520,203,33,15.25,9.97,11.84),(521,203,34,3.66,6.36,13.17),(522,203,35,17.51,17.83,12.32),(523,204,18,16.54,18.14,4.21),(524,204,19,6.45,6.61,0.89),(525,205,20,15.09,15.30,4.43),(526,205,21,18.32,15.42,18.61),(527,205,22,15.59,6.16,16.04),(528,206,23,4.74,13.45,13.85),(529,206,24,12.42,16.95,12.90),(530,207,25,0.93,4.48,13.39),(531,207,26,1.27,3.30,19.99),(532,208,27,15.07,2.62,13.78),(533,208,28,0.22,16.95,10.47),(534,208,29,5.09,13.07,13.69),(535,209,30,10.85,15.86,15.52),(536,209,31,5.14,11.03,2.29),(537,209,32,19.06,2.98,2.45),(538,210,33,10.55,18.58,19.75),(539,210,34,15.27,6.92,18.39),(540,210,35,12.28,11.28,12.74);
/*!40000 ALTER TABLE `notas_unidad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `perfil_estudiante_completo`
--

DROP TABLE IF EXISTS `perfil_estudiante_completo`;
/*!50001 DROP VIEW IF EXISTS `perfil_estudiante_completo`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `perfil_estudiante_completo` AS SELECT 
 1 AS `id_estudiante`,
 1 AS `codigo_universitario`,
 1 AS `dni`,
 1 AS `nombre_completo`,
 1 AS `nombre_carrera`,
 1 AS `id_matricula`,
 1 AS `periodo_academico`,
 1 AS `nombre_curso`,
 1 AS `creditos`,
 1 AS `semestre_malla`,
 1 AS `docente_curso`,
 1 AS `numero_unidad`,
 1 AS `nota_actitudinal`,
 1 AS `nota_procedimental`,
 1 AS `nota_conceptual`,
 1 AS `promedio_unidad`,
 1 AS `promedio_final`,
 1 AS `estado_final_curso`*/;
SET character_set_client = @saved_cs_client;

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
INSERT INTO `plan_estudios` VALUES (1,3,1,1),(2,3,2,1),(3,3,3,1),(4,3,4,1),(5,3,5,1),(6,3,6,1),(7,3,7,1),(8,3,8,1),(9,3,9,2),(10,3,10,2),(11,3,11,2),(12,3,12,2),(13,3,13,2),(14,3,14,2),(15,3,15,2);
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
-- Final view structure for view `perfil_estudiante_completo`
--

/*!50001 DROP VIEW IF EXISTS `perfil_estudiante_completo`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `perfil_estudiante_completo` AS select `e`.`id_estudiante` AS `id_estudiante`,`e`.`codigo_universitario` AS `codigo_universitario`,`e`.`dni` AS `dni`,concat(`e`.`nombre`,' ',`e`.`apellidop`,' ',`e`.`apellidom`) AS `nombre_completo`,`carr`.`nombre` AS `nombre_carrera`,`m`.`id_matricula` AS `id_matricula`,`p`.`nombre` AS `periodo_academico`,`cur`.`nombre` AS `nombre_curso`,`cur`.`creditos` AS `creditos`,`sem`.`numero` AS `semestre_malla`,`doc`.`nombre` AS `docente_curso`,`cu`.`numero_unidad` AS `numero_unidad`,`nu`.`nota_actitudinal` AS `nota_actitudinal`,`nu`.`nota_procedimental` AS `nota_procedimental`,`nu`.`nota_conceptual` AS `nota_conceptual`,`nu`.`promedio_unidad` AS `promedio_unidad`,`pc`.`promedio_final` AS `promedio_final`,`pc`.`estado` AS `estado_final_curso` from ((((((((((`estudiantes` `e` join `carreras` `carr` on((`e`.`id_carrera` = `carr`.`id_carrera`))) left join `matriculas` `m` on((`e`.`id_estudiante` = `m`.`id_estudiante`))) left join `periodos` `p` on((`m`.`id_periodo` = `p`.`id_periodo`))) left join `cursos` `cur` on((`m`.`id_curso` = `cur`.`id_curso`))) left join `docentes` `doc` on((`cur`.`id_docente` = `doc`.`id_docente`))) left join `plan_estudios` `pe` on(((`e`.`id_carrera` = `pe`.`id_carrera`) and (`cur`.`id_curso` = `pe`.`id_curso`)))) left join `semestres` `sem` on((`pe`.`id_semestre` = `sem`.`id_semestre`))) left join `notas_unidad` `nu` on((`m`.`id_matricula` = `nu`.`id_matricula`))) left join `curso_unidades` `cu` on(((`nu`.`id_unidad` = `cu`.`id_unidad`) and (`cur`.`id_curso` = `cu`.`id_curso`)))) left join `promedio_curso` `pc` on((`m`.`id_matricula` = `pc`.`id_matricula`))) order by `e`.`id_estudiante`,`p`.`nombre`,`cur`.`nombre`,`cu`.`numero_unidad` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

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

-- Dump completed on 2025-12-13 13:05:10

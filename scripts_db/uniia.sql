DROP DATABASE uniia;
CREATE DATABASE uniia;
use uniia;

-- 1. TABLAS BASE
CREATE TABLE Carreras (
    id_carrera INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE Semestres (
    id_semestre INT AUTO_INCREMENT PRIMARY KEY,
    numero INT NOT NULL, 
    descripcion VARCHAR(20)
);

CREATE TABLE Periodos (
    id_periodo INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(20) NOT NULL, -- Ej: "2024-I"
    fecha_inicio DATE,
    fecha_fin DATE,
    activo BOOLEAN DEFAULT TRUE
);

CREATE TABLE Docentes (
    id_docente INT AUTO_INCREMENT PRIMARY KEY,
    dni VARCHAR(8) UNIQUE NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    apellidop VARCHAR(100) NOT NULL,
    apellidom VARCHAR(100),
    celular VARCHAR(15)
);

CREATE TABLE Cursos (
    id_curso INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    creditos INT NOT NULL CHECK (creditos IN (2,3,4)),
    silabo VARCHAR(200)
);

-- 2. MALLA CURRICULAR
CREATE TABLE Plan_Estudios (
    id_plan INT AUTO_INCREMENT PRIMARY KEY,
    id_carrera INT NOT NULL,
    id_curso INT NOT NULL,
    id_semestre INT NOT NULL,
    FOREIGN KEY (id_carrera) REFERENCES Carreras(id_carrera),
    FOREIGN KEY (id_curso) REFERENCES Cursos(id_curso),
    FOREIGN KEY (id_semestre) REFERENCES Semestres(id_semestre),
    UNIQUE(id_carrera, id_curso, id_semestre) 
);

-- 3. USUARIOS
CREATE TABLE Estudiantes (
    id_estudiante INT AUTO_INCREMENT PRIMARY KEY,
    codigo_universitario VARCHAR(20) UNIQUE NOT NULL, -- Usaremos esto para el login
    dni VARCHAR(8) UNIQUE NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    apellidop VARCHAR(100) NOT NULL,
    apellidom VARCHAR(100) NOT NULL,
    id_carrera INT NOT NULL,
    FOREIGN KEY (id_carrera) REFERENCES Carreras(id_carrera)
);

-- 4. OPERACIONES (Aquí agregamos el vínculo con Periodos)

CREATE TABLE Asistencias (
    id_asistencia INT AUTO_INCREMENT PRIMARY KEY,
    estudiante_id INT NOT NULL,
    curso_id INT NOT NULL,
    periodo_id INT NOT NULL, -- [NUEVO] Vinculamos al periodo
    fecha DATE DEFAULT (CURRENT_DATE),
    estado ENUM('P', 'A', 'T') DEFAULT 'P', 
    FOREIGN KEY (estudiante_id) REFERENCES Estudiantes(id_estudiante),
    FOREIGN KEY (curso_id) REFERENCES Cursos(id_curso),
    FOREIGN KEY (periodo_id) REFERENCES Periodos(id_periodo) -- Relación creada
);

CREATE TABLE Curso_Unidades (
    id_unidad INT AUTO_INCREMENT PRIMARY KEY,
    id_curso INT NOT NULL,
    numero_unidad INT NOT NULL,  -- 1, 2 o 3

    FOREIGN KEY (id_curso) REFERENCES Cursos(id_curso),
    UNIQUE(id_curso, numero_unidad)
);

CREATE TABLE Matriculas (
    id_matricula INT AUTO_INCREMENT PRIMARY KEY,
    id_estudiante INT NOT NULL,
    id_curso INT NOT NULL,
    id_periodo INT NOT NULL,

    FOREIGN KEY (id_estudiante) REFERENCES Estudiantes(id_estudiante),
    FOREIGN KEY (id_curso) REFERENCES Cursos(id_curso),
    FOREIGN KEY (id_periodo) REFERENCES Periodos(id_periodo),
    UNIQUE(id_estudiante, id_curso, id_periodo)
);


CREATE TABLE Notas_Unidad (
    id_nota_unidad INT AUTO_INCREMENT PRIMARY KEY,
    id_matricula INT NOT NULL,
    id_unidad INT NOT NULL,

    nota_actitudinal DECIMAL(5,2) DEFAULT 0,
    nota_procedimental DECIMAL(5,2) DEFAULT 0,
    nota_conceptual DECIMAL(5,2) DEFAULT 0,

    promedio_unidad DECIMAL(5,2)
        GENERATED ALWAYS AS (
            (nota_actitudinal * 0.20) +
            (nota_procedimental * 0.30) +
            (nota_conceptual * 0.50)
        ) STORED,

    FOREIGN KEY (id_matricula) REFERENCES Matriculas(id_matricula),
    FOREIGN KEY (id_unidad) REFERENCES Curso_Unidades(id_unidad),

    UNIQUE(id_matricula, id_unidad)
);

CREATE VIEW Promedio_Curso AS
SELECT 
    m.id_matricula,
    e.nombre AS estudiante,
    c.nombre AS curso,
    p.nombre AS periodo,
    
    AVG(nu.promedio_unidad) AS promedio_final,
    
    CASE 
        WHEN AVG(nu.promedio_unidad) >= 10.5 THEN 'APROBADO'
        ELSE 'DESAPROBADO'
    END AS estado

FROM Matriculas m
JOIN Estudiantes e ON e.id_estudiante = m.id_estudiante
JOIN Cursos c ON c.id_curso = m.id_curso
JOIN Periodos p ON p.id_periodo = m.id_periodo
JOIN Notas_Unidad nu ON nu.id_matricula = m.id_matricula

GROUP BY m.id_matricula;


-- TRIGGER PARA GENERAR UNIDADES AUTOMATICAMENTE A LOS CURSOS DEPENDIENDO DE SUS CREDITOS
DELIMITER $$

CREATE TRIGGER trg_crear_unidades_curso
AFTER INSERT ON Cursos
FOR EACH ROW
BEGIN
    DECLARE num_unidades INT;
    DECLARE unidad_actual INT DEFAULT 1;

    -- Calcular unidades según créditos
    IF NEW.creditos = 2 THEN
        SET num_unidades = 2;
    ELSEIF NEW.creditos = 3 THEN
        SET num_unidades = 2;
    ELSEIF NEW.creditos = 4 THEN
        SET num_unidades = 3;
    ELSE
        SET num_unidades = 1;
    END IF;

    -- Insertar unidades automáticamente
    WHILE unidad_actual <= num_unidades DO
        INSERT INTO Curso_Unidades (id_curso, numero_unidad)
        VALUES (NEW.id_curso, unidad_actual);

        SET unidad_actual = unidad_actual + 1;
    END WHILE;

END$$

DELIMITER ;

SELECT * FROM Periodos;
SELECT * FROM notas_unidad;

SELECT * FROM Matriculas;
SHOW CREATE VIEW Promedio_Curso;
SELECT * FROM Promedio_Curso;

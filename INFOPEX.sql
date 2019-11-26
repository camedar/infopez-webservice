CREATE TABLE tipo_documento (
id INT(3) NOT NULL AUTO_INCREMENT,
nombre VARCHAR(50) NOT NULL,
PRIMARY KEY (id)
);

CREATE TABLE pais (
id INT(3) NOT NULL AUTO_INCREMENT,
nombre VARCHAR (30) NOT NULL,
PRIMARY KEY (id)
);

CREATE TABLE coordenadas(
id INT(8) NOT NULL AUTO_INCREMENT,
longitud DECIMAL (11,8) DEFAULT NULL,
latitud DECIMAL (11,8) DEFAULT NULL,
PRIMARY KEY (id)
);

CREATE TABLE especie (
id INT NOT NULL AUTO_INCREMENT,
nombre_especie VARCHAR (30) NOT NULL,
nombre_comun VARCHAR (30) NOT NULL,
nombre_ingles VARCHAR (30) NULL,
PRIMARY KEY (id)
);

CREATE TABLE metal (
id INT NOT NULL AUTO_INCREMENT,
nombre VARCHAR(50) NOT NULL,
PRIMARY KEY (id)
);

CREATE TABLE documento (
id INT(8) NOT NULL AUTO_INCREMENT,
tipo_documento_id INT UNSIGNED FOREIGN KEY tipo_documento (id) NOT NULL,
pais_id INT NOT NULL,
revista VARCHAR(50) NULL,
titulo VARCHAR(50) NOT NULL,
autores VARCHAR(100) NULL,
resumen VARCHAR(500) NULL,
ano_publicacion INT(4) NOT NULL,
ano INT(4) NULL,
lugar VARCHAR(100) NULL,
matriz VARCHAR(50) NULL,
termino_general VARCHAR (30) NULL,
descriptor VARCHAR (50) NULL,
termino_especifico VARCHAR (50) NULL,
palabra_clave VARCHAR (100) NULL,
link VARCHAR (1024) NULL,
fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON INSERT CURRENT_TIMESTAMP,
PRIMARY KEY (id),
FOREIGN KEY (tipo_documento_id) REFERENCES tipo_documento (id),
FOREIGN KEY (pais_id) REFERENCES pais (id)
);

CREATE TABLE documento_coordenadas(
id INT(8) NOT NULL AUTO_INCREMENT,
documento_id INT (8) NOT NULL,
coordenadas_id INT (8) NOT NULL,
FOREIGN KEY (documento_id) REFERENCES documento (id),
FOREIGN KEY (coordenadas_id) REFERENCES coordenadas (id)
);

CREATE TABLE document_especies (
id INT (8) NOT NULL AUTO_INCREMENT,
documento_id INT (8) NOT NULL,
especie_id INT(8) NOT NULL,
FOREIGN KEY (documento_id) REFERENCES documento (id),
FOREIGN KEY (especie_id) REFERENCES especie (id)
);

CREATE TABLE documento_concentracion_metal(
id INT(8) NOT NULL AUTO_INCREMENT,
documento_id INT(8) NOT NULL,
metal_id INT (8) NOT NULL,
minimo VARCHAR (15) DEFAULT NULL,
maximo VARCHAR (15) DEFAULT NULL,
unidad VARCHAR (15) DEFAULT NULL,
PRIMARY KEY (id),
FOREIGN KEY (document_id) REFERENCES documento (id),
FOREIGN KEY (metal_id) REFERENCES metal (id)
);


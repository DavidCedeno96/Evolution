use Evolution_db

create table Constants(	
	nombre varchar(20) unique not null,
	descripcion varchar(250),
	estado int default 1,
	fechaCreacion datetime default getdate(),
	fechaModificacion datetime default getdate()
);

create table Licencia(	
	idLicencia uniqueidentifier primary key default newid(),
	tabla varchar(60) unique not null,
	nombre varchar(60) unique not null,
	cantidadMaxima int not null,	
	estado int default 1,
	fechaCreacion datetime default getdate(),
	fechaModificacion datetime default getdate()
);

create table Notificacion(	
	idNotificacion uniqueidentifier primary key default newid(),	
	nombre varchar(160) unique not null,
	estado int default 0 not null,
	msgPersonalizado varchar(350),
	descripcion varchar(60),
	numDesc int default 0 not null,	
	enviarCorreo int default 0 not null,
	fechaCreacion datetime default getdate(),
	fechaModificacion datetime default getdate()
);

create table CorreoEnvio(	
	idCorreo uniqueidentifier primary key default newid(),	
	nombre varchar(60),
	correo varchar(60) unique not null,
	clave varbinary(MAX) not null,
	puerto int default 587 not null,
	host varchar(60) unique not null,
	fechaCreacion datetime default getdate(),
	fechaModificacion datetime default getdate()
);

create table Rol(
	idRol varchar(9) primary key,
	nombre varchar(20) unique not null,
	descripcion varchar(250),
	estado int default 1,
	fechaCreacion datetime default getdate(),
	fechaModificacion datetime default getdate()
);

create table Inicio(
	idInicio uniqueidentifier primary key default newid(),
	nombre varchar(60) not null,
	indice int not null default 0,
	estado int not null default 1,
	color varchar(10),
	idRol varchar(9) references Rol(idRol) not null,
	fechaCreacion datetime default getdate(),
	fechaModificacion datetime default getdate()
)

create table Empresa(
	idEmpresa uniqueidentifier primary key default newid(),
	nombre varchar(100) unique not null,
	descripcion varchar(250),
	estado int default 1,
	fechaCreacion datetime default getdate(),
	fechaModificacion datetime default getdate()
);

create table Area(
	idArea uniqueidentifier primary key default newid(),
	nombre varchar(65) unique not null,
	descripcion varchar(250),
	estado int default 1,
	fechaCreacion datetime default getdate(),
	fechaModificacion datetime default getdate(),
	idEmpresa uniqueidentifier references Empresa(idEmpresa) not null
);

create table Pais(
	idPais uniqueidentifier primary key default newid(),
	nombre varchar(65) unique not null,
	descripcion varchar(250),
	estado int default 1,
	fechaCreacion datetime default getdate(),
	fechaModificacion datetime default getdate(),	
);

create table Ciudad(
	idCiudad uniqueidentifier primary key default newid(),
	nombre varchar(65) unique not null,
	descripcion varchar(250),
	idPais uniqueidentifier references Pais(idPais) not null,
	estado int default 1,
	fechaCreacion datetime default getdate(),
	fechaModificacion datetime default getdate(),		
);

create table Usuario(
	idUsuario uniqueidentifier primary key default newid(),
	nombre varchar(23) not null,
	apellido varchar(23) not null,
	correo varchar(60) unique not null,
	celular varchar(15),
	foto varchar(50),
	estado int default 1,
	idRol varchar(9) references Rol(idRol) not null,
	pais varchar(30),
	ciudad varchar(30),
	empresa varchar(40),
	idArea uniqueidentifier references Area(idArea) null,
	clave varbinary(MAX) not null,
	idCiudad uniqueidentifier references Ciudad(idCiudad) null,
	fechaLogin datetime,
	puntos int not null default 0,
	creditos int not null default 0,
	id varchar(20) unique not null,
	paisIso2 varchar(4),
	paisCode varchar(5),
	fechaCreacion datetime default getdate(),
	fechaModificacion datetime default getdate(),
);

create table Novedad(
	idNovedad uniqueidentifier primary key default newid(),
	mensaje varchar(250) not null,
	auxMsg varchar(100),
	idUsuario uniqueidentifier references Usuario(idUsuario) not null,
	idTabla uniqueidentifier,
	tabla varchar(30),	
	ruta varchar(60),
	fechaCreacion datetime default getdate(),
	fechaModificacion datetime default getdate(),
);

create table Nivel(
	idNivel uniqueidentifier primary key default newid(),
	nombre varchar(20) not null,
	descripcion varchar(250),
	puntosNecesarios int unique not null,
	imagen varchar(50),
	estado int default 1,
	fechaCreacion datetime default getdate(),
	fechaModificacion datetime default getdate(),	
);

create table Usuario_Nivel(
	idUsuario uniqueidentifier references Usuario(idUsuario) not null,
	idNivel uniqueidentifier references Nivel(idNivel) not null,
	fechaCreacion datetime default getdate(),
	fechaModificacion datetime default getdate()
);

create table RedSocial(
	idRed uniqueidentifier primary key default newid(),
	descripcion varchar(250) not null,
	imagen varchar(50),
	estado int default 1,
	fechaPublicacion datetime,
	fechaCreacion datetime default getdate(),
	fechaModificacion datetime default getdate()
);

create table Usuario_RedSocial(
	idRed uniqueidentifier references RedSocial(idRed) not null,
	idUsuario uniqueidentifier references Usuario(idUsuario) not null,
	likes int default 0,
	comentario varchar(255),	
	fechaCreacion datetime default getdate(),
	fechaModificacion datetime default getdate()
);

create table CategoriaNoticia (
	idCategoria uniqueidentifier primary key default newid(),
	nombre varchar(50) unique not null,
	descripcion varchar(250),
	estado int default 1,
	fechaCreacion datetime default getdate(),
	fechaModificacion datetime default getdate()
);

create table Noticia(
	idNoticia uniqueidentifier primary key default newid(),
	titular varchar(100) not null,
	descripcion varchar(500),
	url varchar(250),
	imagen varchar(50),
	estado int default 1,
	idCategoria uniqueidentifier references CategoriaNoticia(idCategoria) not null,
	fechaPublicacion datetime,
	fechaCreacion datetime default getdate(),
	fechaModificacion datetime default getdate()
);

create table Usuario_Noticia(
	idNoticia uniqueidentifier references Noticia(idNoticia) not null,
	idUsuario uniqueidentifier references Usuario(idUsuario) not null,
	likes int default 0,
	comentario varchar(250),	
	fechaCreacion datetime default getdate(),
	fechaModificacion datetime default getdate()
);

create table CategoriaRecompensa (
	idCategoria uniqueidentifier primary key default newid(),
	nombre varchar(50) unique not null,
	descripcion varchar(250),
	estado int default 1,
	fechaCreacion datetime default getdate(),
	fechaModificacion datetime default getdate()
);

create table Recompensa(
	idRecompensa uniqueidentifier primary key default newid(),
	nombre varchar(60) not null,
	descripcion varchar(250),	
	imagen varchar(50),
	cantDisponible int default 0,
	cantCanje int default 0,
	estado int default 1,	
	idCategoria uniqueidentifier references CategoriaRecompensa(idCategoria) not null,
	fechaCreacion datetime default getdate(),
	fechaModificacion datetime default getdate()
);

create table Usuario_Recompensa(
	idRecompensa uniqueidentifier references Recompensa(idRecompensa) not null,
	idUsuario uniqueidentifier references Usuario(idUsuario) not null,
	fechaCreacion datetime default getdate(),
	fechaModificacion datetime default getdate()
);

create table Condicion(
	idCondicion uniqueidentifier primary key default newid(),
	nombre varchar(30) unique not null,
	descripcion varchar(250),
	estado int default 1,	
	fechaCreacion datetime default getdate(),
	fechaModificacion datetime default getdate()
);

create table Medalla(
	idMedalla uniqueidentifier primary key default newid(),
	nombre varchar(30) unique not null,
	descripcion varchar(250),
	imagen varchar(50),
	estado int default 1,	
	idCondicion uniqueidentifier references Condicion(idCondicion) not null,
	fechaCreacion datetime default getdate(),
	fechaModificacion datetime default getdate(),
	numCondicion int default 1 not null
);

create table Usuario_Medalla(
	idMedalla uniqueidentifier references Medalla(idMedalla) not null,
	idUsuario uniqueidentifier references Usuario(idUsuario) not null,
	fechaCreacion datetime default getdate(),
	fechaModificacion datetime default getdate()
);

create table Configuracion(
	idConfig uniqueidentifier primary key default newid(),
	tipo varchar(10) not null,
	propiedad varchar(40),
	nombre varchar(30) unique not null,
	valor varchar(50),
	descripcion varchar(250),
	idUsuario uniqueidentifier references Usuario(idUsuario),	
	fechaCreacion datetime default getdate(),
	fechaModificacion datetime default getdate()
);

create table TipoValidador(
	idTipoValidador uniqueidentifier primary key default newid(),
	nombre varchar(40) unique not null,
	descripcion varchar(250),
	estado int default 1,
	fechaCreacion datetime default getdate(),
	fechaModificacion datetime default getdate()
);

create table TipoReto(
	idTipoReto uniqueidentifier primary key default newid(),
	nombre varchar(30) unique not null,
	descripcion varchar(250),
	estado int default 1,
	fechaCreacion datetime default getdate(),
	fechaModificacion datetime default getdate()
);

create table TipoArchivo(
	idTipoArchivo uniqueidentifier primary key default newid(),
	nombre varchar(20) unique not null,
	descripcion varchar(250),
	extension varchar(20) not null,
	estado int default 1,
	fechaCreacion datetime default getdate(),
	fechaModificacion datetime default getdate()
);

create table ComportamientoPregunta(
	idComportamiento uniqueidentifier primary key default newid(),
	nombre varchar(30) unique not null,
	descripcion varchar(250),
	estado int default 1,
	fechaCreacion datetime default getdate(),
	fechaModificacion datetime default getdate()
);

create table TipoEncuesta(
	idTipoEncuesta uniqueidentifier primary key default newid(),
	nombre varchar(20) unique not null,
	descripcion varchar(250),
	estado int default 1,
	fechaCreacion datetime default getdate(),
	fechaModificacion datetime default getdate()
);

create table Reto(
	idReto uniqueidentifier primary key default newid(),
	nombre varchar(40) unique not null,
	fechaApetura datetime,
	fechaCierre datetime,
	estado int default 1,
	vidas int default 1,
	tiempo_ms int default 60000,
	puntosRecompensa int default 1,
	creditosObtenidos int default 1,
	instrucciones varchar(300),
	imagen varchar(50),
	idTipoReto uniqueidentifier references TipoReto(idTipoReto) not null,
	idComportamiento uniqueidentifier references ComportamientoPregunta(idComportamiento) not null,
	criterioMinimo int default 100 NOT NULL,
	enEquipo int default 0 not null,
	idTipoEncuesta uniqueidentifier references TipoEncuesta(idTipoEncuesta) not null,
	idTipoArchivo uniqueidentifier references TipoArchivo(idTipoArchivo) not null,
	opsRequeridas int not null default 0, 
	items int not null default 0,	
	fechaCreacion datetime default getdate(),
	fechaModificacion datetime default getdate(),
);

create table Equipo(
	idEquipo uniqueidentifier primary key default newid(),
	nombre varchar(60) unique not null,
	imagen varchar(50),
	descripcion varchar(250),
	estado int default 1,
	fechaCreacion datetime default getdate(),
	fechaModificacion datetime default getdate(),
)

create table Usuario_Equipo(
	idEquipo uniqueidentifier references Equipo(idEquipo) not null,
	idUsuario uniqueidentifier references Usuario(idUsuario) unique not null,
	fechaCreacion datetime default getdate(),
	fechaModificacion datetime default getdate(),
)

create table Pregunta(
	idPregunta uniqueidentifier primary key default newid(),
	nombre varchar(200) not null,
	estado int default 1,
	idReto uniqueidentifier references Reto(idReto) not null,
	fechaCreacion datetime default getdate(),
	fechaModificacion datetime default getdate()
);

create table TipoEntrada(
	idTipoEntrada uniqueidentifier primary key default newid(),
	nombre varchar(20) unique not null,
	descripcion varchar(250),
	estado int default 1,	
	fechaCreacion datetime default getdate(),
	fechaModificacion datetime default getdate()
);

create table Opcion(
	idOpcion uniqueidentifier primary key default newid(),
	nombre varchar(200) not null,
	correcta int default 0,
	estado int default 1,
	valor int default 0 not null,
	idPregunta uniqueidentifier references Pregunta(idPregunta) not null,
	idTipoEntrada uniqueidentifier references TipoEntrada(idTipoEntrada) not null,
	fechaCreacion datetime default getdate(),
	fechaModificacion datetime default getdate()
);

create table UsuarioxOpcion(
	idOpcion uniqueidentifier not null,
	idUsuario uniqueidentifier not null,
	respuesta varchar(350),
	idUserValidador uniqueidentifier,
	fechaCreacion datetime default getdate(),
	fechaModificacion datetime default getdate()
)

create table UsuarioxArchivo(
	idReto uniqueidentifier not null,
	idUsuario uniqueidentifier not null,
	archivo varchar(100) not null,
	url varchar(150),
	fechaCreacion datetime default getdate(),
	fechaModificacion datetime default getdate()
)

create table Usuario_Reto(
	idReto uniqueidentifier references Reto(idReto) not null,
	idUsuario uniqueidentifier references Usuario(idUsuario) not null,
	puntos int default 0 not null,
	tiempo int default 0 not null,
	vidas int default 0 not null,
	completado int default 0 not null,
	fechaAsignacion datetime default getdate(),
	tieneEquipo int default 0 not null,
	validador int not null default 0,
	incorrectas int not null default 0,
	correctas int not null default 0,
	fechaCreacion datetime default getdate(),
	fechaModificacion datetime default getdate(),
);

--create table Puzzle(
--	idPuzzle uniqueidentifier primary key default newid(),
--	imagen varchar(50) not null,
--	descripcion varchar(250),
--	idReto uniqueidentifier references Reto(idReto) not null,
--	fechaCreacion datetime default getdate(),
--	fechaModificacion datetime default getdate()
--);

--create table Laberinto(
--	idLaberinto uniqueidentifier primary key default newid(),

--	-- Aqui falta los campos

--	fechaCreacion datetime default getdate(),
--	fechaModificacion datetime default getdate()
--);

-- ----------------------------------------------------------------------------------------------------
select * from Rol
select * from Area
select * from Usuario

-- ----------------------------------------------------------------------------------------------------
insert into Rol (idRol, nombre, descripcion) values 
('jug','Jugador', 'Este rol es para los jugadores')

insert into Usuario (nombre, apellido, correo, idRol) values
('Byron David', 'Cede�o Lucero', 'david@gmail.com','adm')
-- ----------------------------------------------------------------------------------------------------

---
SELECT ROUTINE_NAME FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE ROUTINE_TYPE = 'PROCEDURE'
   ORDER BY ROUTINE_NAME 

---
SELECT 
	tc.CONSTRAINT_TYPE,
    tc.CONSTRAINT_NAME,
	tc.TABLE_NAME,
    kcu.COLUMN_NAME	
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS tc
JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE kcu
    ON tc.CONSTRAINT_NAME = kcu.CONSTRAINT_NAME
WHERE 
    tc.TABLE_NAME = 'Usuario' AND 
    tc.CONSTRAINT_TYPE = 'UNIQUE'    

----
SELECT *
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE TABLE_NAME = 'Usuario' AND CONSTRAINT_TYPE = 'CHECK';

---
SELECT tc.COLUMN_NAME, tc.DATA_TYPE, tc.CHARACTER_MAXIMUM_LENGTH, tc.IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS tc
WHERE tc.TABLE_NAME = 'Usuario';

---
SELECT @@VERSION;

-----------------------------------------------------------------------------------


ALTER TABLE Usuario
ALTER COLUMN clave nvarchar(max) not null
CONSTRAINT DF_Usuario_Clave DEFAULT (CONVERT(VARBINARY(MAX), '0'));


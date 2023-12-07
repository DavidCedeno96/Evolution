use Evolution_db

EXEC sp_spaceused

EXEC sp_helpdb 'Evolution_db';

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

--- INFO DE LA TABLA
SELECT tc.COLUMN_NAME, tc.DATA_TYPE, tc.CHARACTER_MAXIMUM_LENGTH, tc.IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS tc
WHERE tc.TABLE_NAME = 'Usuario';

---
SELECT @@VERSION;

-- INSERTS IMPORTANTES ---------------------------------------------------------
--Insert into Constants (nombre,descripcion) values
--('encontrar','encontrado'),
--('no_encontrar','no encontrado'),
--('exito_eliminar','Registro eliminado satisfactoriamente'),
--('exito_update','Registro editado satisfactoriamente'),
--('exito_insert','Registro creado satisfactoriamente')

--Insert Into Rol (idRol, nombre, descripcion, estado) values
--('adm', 'Administrador', 'Este rol es para el administrador',1),
--('jug', 'Jugador', 'Este rol es para los jugadores',1),
--('sadm', 'Super Administrador', 'Este es para el super administrador',0)

-- OTROS INSERTS ---------------------------------------------------------
--Insert into Usuario (nombre, apellido, correo, celular, idRol, pais, ciudad, clave) values
--('Benito','Camelas','benito@gmail.com','0954712456','jug','Puerto Rico', 'Santo Domingo','12345')

-- ------------------------------------------------------------
select * from Constants
select * from Rol
select * from Usuario
select * from Area
select * from Nivel
-- ------------------------------------------------------------

-- SPs
-- ROL --------------------------------------------------------
exec sp_B_Rol
@estado = -1,
@error = '',
@info = '',
@id = ''

-- USUARIO --------------------------------------------------------
--delete from Usuario

exec sp_B_Usuario		
@estado = -1,
@error = '',
@info = '',
@id = ''

exec sp_B_UsuarioById	
@idUsuario = '939C9C6D-9DCF-4B7E-BEA6-5C26169FA066',	
@estado = -1,
@error = '',
@info = '',
@id = ''

exec sp_B_UsuarioByCorreo
@correo = 'dav@gmail.com',
@error = '',
@info = '',
@id = ''

declare @auxClave varbinary(max) = CAST('aqui el texo encriptado' AS VARBINARY(MAX))
exec sp_C_Usuario
@nombre = 'Daniela',
@apellido = 'Dias',
@correo = 'dani@gmail.com',
@clave = @auxClave,
@celular = '0998467221',
@foto = '',
@idRol = 'jug',
@pais = 'Mexico',
@ciudad = 'cdmx',
@empresa = '',
@idArea = '',
@error = '',
@info = '',
@id = ''

declare @auxClave varbinary(max) = 0x
exec sp_U_Usuario
@idUsuario = '7C8613DA-DD4B-4883-BA12-15636828FA3A',
@nombre = 'Daniela edit',
@apellido = 'Dias',
@correo = 'dani@gmail.com',
@clave = @auxClave,
@celular = '0998467221',
@foto = 'foto2.png',
@idRol = 'jug',
@pais = 'Mexico',
@ciudad = 'cdmx',
@empresa = '',
@idArea = '',
@error = '',
@info = '',
@id = ''

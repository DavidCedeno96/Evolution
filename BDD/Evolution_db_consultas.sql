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

---
SELECT tc.COLUMN_NAME, tc.DATA_TYPE, tc.CHARACTER_MAXIMUM_LENGTH, tc.IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS tc
WHERE tc.TABLE_NAME = 'Usuario';

---
SELECT @@VERSION;

select * from Rol
select * from Usuario
select * from Area
select * from Nivel

-- ---------------------------------------------------------
Insert into Usuario (nombre, apellido, correo, celular, idRol, pais, ciudad, clave) values
('Benito','Camelas','benito@gmail.com','0954712456','jug','Puerto Rico', 'Santo Domingo','12345')

Insert Into Rol (idRol, nombre, descripcion) values
('sadm', 'Super Administrador', 'Este es para el super administrador')

-- ------------------------------------------------------------
-- SPs
-- ROL --------------------------------------------------------
exec sp_B_Rol
@estado = -1,
@error = '',
@info = '',
@id = ''

-- USUARIO --------------------------------------------------------
exec sp_B_Usuario		
@estado = -1,
@error = '',
@info = '',
@id = ''

exec sp_B_UsuarioById	
@idUsuario = 'DFD02F9A-4617-4713-9A9B-19FBC2817258',	
@estado = -1,
@error = '',
@info = '',
@id = ''

exec sp_B_UsuarioByCorreo
@correo = 'mia@gmail.com',
@error = '',
@info = '',
@id = ''

exec sp_B_UsuarioLogin
@correo = 'david@gmail.com',
@clave = 'admin',
@error = '',
@info = '',
@id = ''

exec sp_C_Usuario
@nombre = 'Mia',
@apellido = 'Lomeli',
@correo = 'mia@gmail.com',
@clave = '',
@celular = '0998467220',
@foto = '',
@idRol = 'jug',
@pais = 'Mexico',
@ciudad = 'cdmx',
@empresa = '',
@idArea = '',
@error = '',
@info = '',
@id = ''

--delete from Usuario
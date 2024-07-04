use Evolution_db

EXEC sp_spaceused

EXEC sp_helpdb 'Evolution_db';

--- Fecha y hora actual
SELECT SYSDATETIME() AS [Fecha y Hora Actual], CURRENT_TIMEZONE() AS [Zona Horaria Actual];

--- SPs
SELECT ROUTINE_NAME FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE ROUTINE_TYPE = 'PROCEDURE'
   ORDER BY ROUTINE_NAME 

--- TRIGGERS
SELECT
    tr.name AS TriggerName,
    tr.object_id AS TriggerObjectId,
	te.type,
	te.type_desc,
    tr.parent_id AS TableObjectId,
    OBJECT_NAME(tr.parent_id) AS 'TableName'
FROM sys.triggers tr 
INNER JOIN sys.trigger_events te ON tr.object_id = te.object_id
INNER JOIN sys.objects o ON tr.parent_id = o.object_id
--WHERE te.type = 2;

--- RESTRICCIONES: FK, PK, Unique
SELECT 
    tc.CONSTRAINT_NAME,
	tc.CONSTRAINT_TYPE,
	tc.TABLE_NAME,
    kcu.COLUMN_NAME	
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS tc
JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE kcu
    ON tc.CONSTRAINT_NAME = kcu.CONSTRAINT_NAME
WHERE 
    tc.TABLE_NAME = 'area' AND 
    tc.CONSTRAINT_TYPE = 'UNIQUE' OR   
	tc.CONSTRAINT_TYPE = 'CHECK';

---- RESTRICCIONES: Predeterminadas
SELECT 
    dc.name AS constraint_name, 
    o.name AS table_name, 
	dc.create_date,
    c.name AS column_name, 
    c.is_nullable, 
	dc.type_desc,
    dc.definition AS default_value
FROM 
    sys.default_constraints dc
    INNER JOIN sys.columns c ON dc.parent_object_id = c.object_id AND dc.parent_column_id = c.column_id
    INNER JOIN sys.objects o ON dc.parent_object_id = o.object_id
WHERE 
    o.name = 'Novedad';


--- INFO DE LA TABLA
SELECT tc.COLUMN_NAME, tc.DATA_TYPE, tc.CHARACTER_MAXIMUM_LENGTH, tc.IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS tc
WHERE tc.TABLE_NAME = 'area';

---
SELECT @@VERSION;

-- INSERTS IMPORTANTES ---------------------------------------------------------
--Insert into Constants (nombre,descripcion) values
--('sin_licencias','El número de licencias están agotadas'),
--('no_delete','Registro no eliminado'),
--('encontrar','encontrado'),
--('no_encontrar','no encontrado'),
--('exito_delete','Registro eliminado satisfactoriamente'),
--('exito_update','Registro editado satisfactoriamente'),
--('exito_insert','Registro creado satisfactoriamente'),
--('cero_filas','No se encontró ningun resultado')

--Insert Into Rol (idRol, nombre, descripcion, estado) values
--('adm', 'Administrador', 'Este rol es para el administrador',1),
--('jug', 'Jugador', 'Este rol es para los jugadores',1),
--('sadm', 'Super Administrador', 'Este es para el super administrador',0)

-- Insert Into CategoriaNoticia (nombre, descripcion) values 
-- ('General','Es para las noticias en general')

--Notificacion
--Configuracion
--Inicio
--CorreoEnvio
--TipoReto
--TipoEncuesta
--TipoEntrada
--TipoValidador
--TipoArchivo

-- OTROS INSERTS ---------------------------------------------------------
--Insert into Usuario (nombre, apellido, correo, celular, idRol, pais, ciudad, clave) values
--('Benito','Camelas','benito@gmail.com','0954712456','jug','Puerto Rico', 'Santo Domingo','12345')


-- ------------------------------------------------------------
select * from Constants
select * from Rol
select * from Usuario
-- ------------------------------------------------------------

-- SPs
-- ROL --------------------------------------------------------
exec sp_B_Rol
@estado = -1,
@error = '',
@info = '',
@id = ''

-- INICIO --------------------------------------------------------
exec sp_B_Inicio
@error = '',
@info = '',
@id = ''

select * from Inicio where nombre = 'Verificar retos'
-- update Inicio set nombre = 'Retos por calificar' where nombre = 'Verificar retos'

exec sp_B_InicioByIdRol	
@idRol = 'adm',
@error = '',
@info = '',
@id = ''

exec sp_U_Inicio		
@idInicio = '7c8c2672-2233-486a-a184-f0b51eb4a331',
@nombre = 'Mis Medallas',
@indice = 1,
@idRol = 'jug',
@color = '',
@error = '',
@info = '',
@id = ''

exec sp_D_InicioByNoIds
@ids = '',
@idRol = '',
@error = '',
@info = '',
@id = ''

-- USUARIO --------------------------------------------------------
-- delete from Usuario where idUsuario = 'D33AEE6A-F632-4476-9C9D-7A1D6DB5093B'
-- delete from Usuario where fechaCreacion > '2024-02-20'
-- update Usuario set correo = 'user@correo.com' where idUsuario = 'AB37197C-BF33-44B8-BA5D-E246FA250B41'
-- update Usuario set estado = 1

select * from Usuario where idUsuario = '6d81e350-a4f4-4042-a3e9-ef97d985bc2a'
--AB37197C-BF33-44B8-BA5D-E246FA250B41
exec sp_B_Usuario
@estado = -1,
@error = '',
@info = '',
@id = ''

exec sp_B_UsuarioById	
@idUsuario = '6d81e350-a4f4-4042-a3e9-ef97d985bc2a',	
@estado = 1,
@error = '',
@info = '',
@id = ''

exec sp_B_UsuarioByCorreo
@correo = 'elver.galarga@gmail.com',
@error = '',
@info = '',
@id = ''

exec sp_B_UsuarioByRegister
@idU = '',
@correo = '',
@codRegistro = '',
@error = '',
@info = '',
@id = ''

exec sp_B_UsuarioByAll
@buscar = 'admin',
@incluirAdmins = 1,
@error = '',
@info = '',
@id = ''

exec sp_B_UsuarioPuntosCreditos		
@idUsuario = '015E40DD-58CE-401E-A0A9-075874BC0B68',
@error = '',
@info = '',
@id = ''

select * from Usuario
exec sp_B_Usuario_fechaLogin	
@idUsuario = '91DB7BAE-7D2F-423D-B595-D227C63CA0A6',
@error = '',
@info = '',
@id = ''

declare @auxClave varbinary(max) = CAST('aqui el texo encriptado' AS VARBINARY(MAX))
exec sp_C_Usuario
@nombre = 'Daniela',
@apellido = 'Dias',
@correo = 'dani@gmail.com',
@idU  = '',
@clave = @auxClave,
@paisIso2 = 'ec',
@paisCode = '593',
@celular = '0998467221',
@foto = '',
@idRol = 'jug',
@idCiudad = '',
@idArea = '',
@error = '',
@info = '',
@id = ''

declare @auxClave varbinary(max) = 0x
exec sp_U_Usuario
@idUsuario = '91331754-1E83-417F-90E7-0E596E996510',
@nombre = 'Elver',
@apellido = 'Galarraga',
@correo = 'elver.ga.larga@gmail.com',
@idU = '',
@clave = @auxClave,
@paisIso2 = 'ec',
@paisCode = '593',
@celular = '1234567891',
@foto = 'models.png',
@idRol = 'jug',
@idCiudad = '',
@idArea = '',
@error = '',
@info = '',
@id = ''

exec sp_U_UsuarioByEstado
@idUsuario = '939C9C6D-9DCF-4B7E-BEA6-5C26169FA066',
@estado = 0,
@error = '',
@info = '',
@id = ''


exec sp_U_UsuarioEstadoByCorreoIds
@correo_id = '1020304056',
@estado = 0,
@error = '',
@info = '',
@id = ''


exec sp_U_UsuarioByFoto
@idUsuario = 'F42329D1-EDAA-4F2C-9AE1-8F026C92C842',
@foto = '',
@error = '',
@info = '',
@id = ''

-- Area --------------------------------------------------------
select * from Empresa

exec sp_B_Area		
@estado = -1,
@error = '',
@info = '',
@id = ''

exec sp_B_AreaById		
@idArea = 'C1DF8D3C-0069-468E-8811-A0F404F12819',
@estado = -1,
@error = '',
@info = '',
@id = ''

exec sp_B_AreaByNombre		
@nombre = 'Call Center',
@empresa = 'Dinamica Mercados',
@error = '',
@info = '',
@id = ''

--exec sp_B_AreaByIdEmpresa		
--@estado = -1,
--@idEmpresa = '4E87C6CD-992A-4F14-90C8-CB7BFD4B2DBA',
--@error = '',
--@info = '',
--@id = ''

exec sp_C_Area		
@nombre = 'Call Center',
@descripcion = '',
@idEmpresa = '1CB1DB77-B372-43D8-9FA1-EB64FA7B9CDD',
@error = '',
@info = '',
@id = ''

exec sp_U_Area		
@idArea = '1B837374-0533-4885-AF06-A3AF2D6E3B50',
@nombre = 'preubn edit',
@descripcion = 'Este es solo para la prueba',
@idEmpresa = '4E87C6CD-992A-4F14-90C8-CB7BFD4B2DBA',
@error = '',
@info = '',
@id = ''

-- Empresa --------------------------------------------------------
exec sp_B_Empresa		
@estado = -1,
@error = '',
@info = '',
@id = ''

exec sp_B_EmpresaById		
@idEmpresa = '4E87C6CD-992A-4F14-90C8-CB7BFD4B2DBA',
@estado = -1,
@error = '',
@info = '',
@id = ''

exec sp_C_Empresa		
@nombre = 'Prueba',
@descripcion = '',
@error = '',
@info = '',
@id = ''

exec sp_U_Empresa		
@idEmpresa = 'C99EC2BD-7C18-499C-878A-5EE9AB6FE8C7',
@nombre = 'Prueba ediado',
@descripcion = 'editado desc',
@error = '',
@info = '',
@id = ''

-- Pais --------------------------------------------------------
exec sp_B_Pais
@estado = -1,
@error = '',
@info = '',
@id = ''

exec sp_B_PaisById		
@idPais = '4A89B8A4-418D-47E1-BD16-80AAB501D4C0',
@estado = -1,
@error = '',
@info = '',
@id = ''

exec sp_C_Pais		
@nombre = 'México',
@descripcion = '',
@error = '',
@info = '',
@id = ''

exec sp_U_Pais
@idPais = 'D0A947C1-149A-4747-9A58-272F3EED7480',
@nombre = 'pais prueba edit',
@descripcion = 'este es para la prueba',
@error = '',
@info = '',
@id = ''

-- Ciudad -------------------------------------------------------- 
select * from Pais
--DELETE from Pais where idPais = 'B9CB4FD1-FF4F-4606-981C-AC7A6EAE3649'

exec sp_B_Ciudad
@estado = -1,
@error = '',
@info = '',
@id = ''

exec sp_B_CiudadByNombre		
@nombre = 'quito',
@error = '',
@info = '',
@id = ''

exec sp_B_CiudadById		
@idCiudad = 'F25E73BA-3D82-4D9B-86B4-D4AA94745649',	
@estado = -1,
@error = '',
@info = '',
@id = ''

--exec sp_B_CiudadByIdPais		
--@estado = -1,
--@idPais = '1E539FEF-7E19-4248-BD2C-D19B79726B0A',
--@error = '',
--@info = '',
--@id = ''

exec sp_C_Ciudad		
@nombre = 'Cancún',
@descripcion = '',
@idPais = '4A89B8A4-418D-47E1-BD16-80AAB501D4C0',
@error = '',
@info = '',
@id = ''

exec sp_U_Ciudad	
@idCiudad = '679FDC16-B347-4A5B-B7B6-F00E92786C7F',
@nombre = 'ciudad edit',
@descripcion = 'edit',
@idPais = 'D0A947C1-149A-4747-9A58-272F3EED7480',
@error = '',
@info = '',
@id = ''

-- Nivel --------------------------------------------------------
exec sp_B_Nivel		
@estado = -1,
@error = '',
@info = '',
@id = ''

exec sp_B_NivelById		
@idNivel = '1E7E4DD1-22B4-49B6-AAA9-705D0E49A7E5',
@estado = -1,
@error = '',
@info = '',
@id = ''

exec sp_B_NivelByAll		
@buscar = '3',
@error = '',
@info = '',
@id = ''

exec sp_B_NivelByNextPuntos
@puntos = 20,
@error = '',
@info = '',
@id = ''


exec sp_C_Nivel
@nombre = 'nivel con pos',
@descripcion = 'este es para el nivel con pos',
@puntosNecesarios = 3,
@imagen = '',
@error = '',
@info = '',
@id = ''

exec sp_U_Nivel
@idNivel = 'A3AE5C3C-1D90-4306-882D-A092EDBD82EF',
@nombre = 'nivel con pos edit',
@descripcion = 'este es para el nivel con pos edit',
@puntosNecesarios = 23,
@imagen = '',
@error = '',
@info = '',
@id = ''

exec sp_D_Nivel
@idNivel = '34FA60B2-4FCD-49A8-BEBB-198E7A343CFA',
@error = '',
@info = '',
@id = ''

exec sp_B_Usuario_NivelByIdUsuario		
@idUsuario = 'AB37197C-BF33-44B8-BA5D-E246FA250B41',
@top = -1,
@error = '',
@info = '',
@id = ''

exec sp_C_Usuario_Nivel
@idUsuario = '015E40DD-58CE-401E-A0A9-075874BC0B68',
@idNivel = '62629073-7CC1-4AD3-82F1-B57A823E0092',
@error = '',
@info = '',
@id = ''

select * from Usuario_Nivel
select * from Usuario
-- Condicion --------------------------------------------------------
select * from Condicion

exec sp_B_Condicion		
@estado = -1,
@error = '',
@info = '',
@id = ''

-- Medallas --------------------------------------------------------
select * from Medalla

exec sp_B_Medalla
@estado = -1,
@error = '',
@info = '',
@id = ''

exec sp_B_MedallaById		
@idMedalla = '2EB8768C-F1AE-49BE-83E0-B04C39EB64C2',
@estado = -1,
@error = '',
@info = '',
@id = ''

exec sp_B_MedallaByAll		
@buscar = 'medalla',
@error = '',
@info = '',
@id = ''

exec sp_C_Medalla
@nombre = 'medalla 3',
@descripcion = 'desc 1',
@imagen = '',
@idCondicion = '2439150E-8525-4582-8203-9D1D2AC93739',
@numCondicion = 0,
@error = '',
@info = '',
@id = ''

exec sp_U_Medalla
@idMedalla = '',
@nombre = 'medalla 3',
@descripcion = 'desc 1',
@imagen = '',
@idCondicion = '2439150E-8525-4582-8203-9D1D2AC93739',
@numCondicion = 0,
@error = '',
@info = '',
@id = ''

exec sp_D_Medalla	
@idMedalla = '6D3A6B25-C6C7-4ED4-A5E9-D992B1CC98A7',
@error = '',
@info = '',
@id = ''

exec sp_B_Usuario_MedallaByIdUsuario		
@idUsuario = 'F42329D1-EDAA-4F2C-9AE1-8F026C92C842',
@top = 2,
@error = '',
@info = '',
@id = ''

exec sp_C_Usuario_Medalla
@idUsuario = 'F42329D1-EDAA-4F2C-9AE1-8F026C92C842',
@idMedalla = '2EB8768C-F1AE-49BE-83E0-B04C39EB64C2',
@error = '',
@info = '',
@id = ''

-- Recompensas y sus Categorias --------------------------------------------------------
-- Categorias ----------
exec sp_B_CategoriaRecompensa		
@estado = -1,
@error = '',
@info = '',
@id = ''

exec sp_B_CategoriaRecompensaByAll		
@buscar = 'g',
@error = '',
@info = '',
@id = ''

exec sp_B_CategoriaRecompensaById		
@idCategoria = '11283D21-EA6E-4945-9C59-A8868416016f',
@estado = -1,
@error = '',
@info = '',
@id = ''

exec sp_C_CategoriaRecompensa
@nombre = 'Nueva1',
@descripcion = '',
@error = '',
@info = '',
@id = ''

exec sp_U_CategoriaRecompensa
@idCategoria = '11283D21-EA6E-4945-9C59-A8868416016F',
@nombre = 'edit',
@descripcion = 'desc edit',
@error = '',
@info = '',
@id = ''

-- Recompensas ----------
exec sp_B_Recompensa
@estado = -1,
@error = '',
@info = '',
@id = ''

exec sp_B_RecompensaById		
@idRecompensa = '4D6DA0F1-01A5-4EFC-9CA3-4FD6A5130A11',
@estado = -1,
@error = '',
@info = '',
@id = ''

exec sp_B_RecompensaByAll		
@buscar = '',
@idCategoria = 'EE6CA0ED-F5E2-4640-AAF4-76D11C9762B2',
@error = '',
@info = '',
@id = ''

exec sp_C_Recompensa
@nombre = '10 entradas al cine',
@idCategoria = '',
@descripcion = '',
@imagen = '',
@cantDisp = 0,	
@cantCanje = 5,
@error = '',
@info = '',
@id = ''

exec sp_U_Recompensa
@idRecompensa = '',
@idCategoria = '',
@nombre = '10 entradas al cine',
@descripcion = '',
@imagen = '',
@cantDisp = 0,	
@cantCanje = 5,
@error = '',
@info = '',
@id = ''

exec sp_U_RecompensaByEstado
@idRecompensa = '3C18891D-48F7-44B1-9DE9-E9EB833CEE23',
@estado = '',
@error = '',
@info = '',
@id = ''

exec sp_D_Recompensa
@idRecompensa = '015E40DD-58CE-401E-A0A9-075874BC0B68',
@error = '',
@info = '',
@id = ''

Select * from Usuario_Recompensa
exec sp_B_Usuario_RecompensaTotalUsuarios
@error = '',
@info = '',
@id = ''

exec sp_B_Usuario_RecompensaByIdUsuario
@idUsuario = '939C9C6D-9DCF-4B7E-BEA6-5C26169FA066',
@error = '',
@info = '',
@id = ''

-- HAY TRIGGER
exec sp_C_Usuario_Recompensa
@idUsuario = '939C9C6D-9DCF-4B7E-BEA6-5C26169FA066',
@idRecompensa = '91F482C6-59A5-450F-A09A-9C745B861339',
@error = '',
@info = '',
@id = ''

select * from Usuario

-- Noticias y sus Categorias --------------------------------------------------------
-- Categorias
exec sp_B_CategoriaNoticia
@estado = -1,
@error = '',
@info = '',
@id = ''

exec sp_B_CategoriaNoticiaById		
@idCategoria = '65E3EC0D-24D9-4F06-9B9C-DE5F21C925AE',
@estado = -1,
@error = '',
@info = '',
@id = ''

exec sp_B_CategoriaNoticiaByAll		
@buscar = 'cien',
@error = '',
@info = '',
@id = ''

exec sp_C_CategoriaNoticia
@nombre = 'Culturales',
@descripcion = 'Cuando se refieren a sucesos de la vida artística, literaria y cultural del país.',
@error = '',
@info = '',
@id = ''

exec sp_U_CategoriaNoticia
@idCategoria = '',
@nombre = 'Culturales',
@descripcion = 'Cuando se refieren a sucesos de la vida artística, literaria y cultural del país.',
@error = '',
@info = '',
@id = ''

-- Noticias
exec sp_B_Noticia
@estado = -1,
@idUsuario = '015E40DD-58CE-401E-A0A9-075874BC0B68',
--@idNoticia = '7CF3F854-ABE0-4033-BD63-4A94DC7DAF11', -- este es opcional
@error = '',
@info = '',
@id = ''

exec sp_B_NoticiaById		
@idNoticia = '',
@estado = -1,
@error = '',
@info = '',
@id = ''

exec sp_B_NoticiaByAll		
@buscar = 'cient',
@error = '',
@info = '',
@id = ''

exec sp_B_Noticia_enTendencia
@estado = -1,
@error = '',
@info = '',
@id = ''

exec sp_C_Noticia
@titular = 'titular 3  de prueba',
@descripcion = 'descripcion 3  de prueba',
@url = '',
@imagen = 'img1.jpg',
@idCategoria = '622FF0AC-4EC0-461F-8EDA-F8A487F80EB3',
@fechaPublicacion = '2023-12-23',
@error = '',
@info = '',
@id = ''

exec sp_U_Noticia
@idNoticia = '',
@titular = 'titular 3  de prueba',
@descripcion = 'descripcion 3  de prueba',
@url = '',
@imagen = '',
@idCategoria = '622FF0AC-4EC0-461F-8EDA-F8A487F80EB3',
@fechaPublicacion = '2023-12-23',
@error = '',
@info = '',
@id = ''

exec sp_D_Noticia
@idNoticia = '03DC6270-512F-4B45-8B35-A4C818C2A6C2',
@error = '',
@info = '',
@id = ''

select * from Usuario_Noticia

exec sp_B_Usuario_NoticiaByIdNoticia	
@idNoticia = '7CF3F854-ABE0-4033-BD63-4A94DC7DAF1A',	
@error = '',
@info = '',
@id = ''

exec sp_C_Usuario_Noticia
@idUsuario = 'F42329D1-EDAA-4F2C-9AE1-8F026C92C842',
@idNoticia = 'E1F0D39F-A8F3-4297-9429-9A89DD88EE7D',
@likes = 0,
@comentario = 'Buenas tardes',
@error = '',
@info = '',
@id = ''

-- Red Social --------------------------------------------------------
select * from RedSocial

exec sp_B_RedSocial		
@idUsuario = 'DAD5FFE9-A8CE-4D00-BF12-9FAF4F30204f',
@error = '',
@info = '',
@id = ''

exec sp_B_RedSocialByIdRedUser		
@idRed = 'DAD5FFE9-A8CE-4D00-BF12-9FAF4F30204f',
@error = '',
@info = '',
@id = ''

exec sp_C_RedSocial	
@descripcion = 'elver.png|Elver Galarraga|ha alcanzado el nivel 6',
@imagen = 'nivel6.png',
@fechaPublicacion = '2024-03-11',
@error = '',
@info = '',
@id = ''

exec sp_B_Usuario_RedSocialByIdRed	
@idRed = 'E50664AD-160B-4E08-B9C1-11D8B7D6DF00',
@error = '',
@info = '',
@id = ''

exec sp_C_Usuario_RedSocial
@idUsuario = '91DB7BAE-7D2F-423D-B595-D227C63CA0A6',
@idRed = 'E50664AD-160B-4E08-B9C1-11D8B7D6DF00',
@likes = 0,
@comentario = 'felicidades por el hola mundo',
@error = '',
@info = '',
@id = ''

select * from Usuario
select * from Usuario_RedSocial

-- Configuracion --------------------------------------------------------
select * from Configuracion where tipo = 'imagen'

--update Configuracion set valor = '#f58220' where idConfig = '8FDC49E5-2C82-423F-B3A9-85AF544339C9'
--update Configuracion set valor = '#5EFF33' where idConfig = '8FDC49E5-2C82-423F-B3A9-85AF544339C9'

exec sp_B_Configuracion
@error = '',
@info = '',
@id = ''

exec sp_B_ConfiguracionByValor
@valor = 'abc-123-xyz-23',
@error = '',
@info = '',
@id = ''

exec sp_B_ConfiguracionByNombre
@nombre = 'registro',
@error = '',
@info = '',
@id = ''

exec sp_C_Configuracion
@tipo = 'view',
@propiedad = '',
@nombre = 'registro',
@valor = '0',
@descripcion = 'Esta es para permitir la vista de Registrarse',
--@idUsuario = '939C9C6D-9DCF-4B7E-BEA6-5C26169FA066',
@error = '',
@info = '',
@id = ''

exec sp_U_Configuracion
@idConfig = '71B8C9AE-1509-4886-80B7-679368903BD7',
@valor = '1',
@idUsuario = '939C9C6D-9DCF-4B7E-BEA6-5C26169FA066',
@error = '',
@info = '',
@id = ''

------------------------------------------------------------------------------------
-- En esta parte es para los juegos que va a tener la aplicacion -------------------
------------------------------------------------------------------------------------
-- Comportamiento de Pregunta ------------------------------------------------------
exec sp_B_ComporPregu
@estado = -1,
@error = '',
@info = '',
@id = ''

-- Opcion ------------------------------------------------------------------------
select * from Opcion
select * from Pregunta

exec sp_B_OpcionByIdPregunta		
@idPregunta = 'F0B0AC75-B7BB-472F-B612-20A394E71343',
@estado = -1,
@error = '',
@info = '',
@id = ''

exec sp_B_OpcionByIdPreguntaIdUsuario		
@idPregunta = 'F0B0AC75-B7BB-472F-B612-20A394E71343',
@idUsuario = '015E40DD-58CE-401E-A0A9-075874BC0B68',
@estado = -1,
@error = '',
@info = '',
@id = ''


exec sp_C_Opcion		
@nombre = 'Ambato',
@correcta = 0,
@valor = 0, 
@idPregunta = 'EFE6E2F4-091C-4B53-958C-CC1EDC252445',
@idTipoEntrada = 'EFE6E2F4-091C-4B53-958C-CC1EDC252445',
@error = '',
@info = '',
@id = ''

exec sp_U_Opcion	
@idOpcion = '8EE73190-C353-420B-9453-92C1E9F075E6',
@nombre = 'Ambato',
@correcta = '',
@valor = 0,
@idPregunta = 'EFE6E2F4-091C-4B53-958C-CC1EDC252445',
@idTipoEntrada = 'EFE6E2F4-091C-4B53-958C-CC1EDC252445',
@error = '',
@info = '',
@id = ''

exec sp_D_Opcion
@idOpcion = 'EFE6E2F4-091C-4B53-958C-CC1EDC252445',
@error = '',
@info = '',
@id = ''

exec sp_D_OpcionByNoIds
@ids = '',
@idPregunta = '',
@error = '',
@info = '',
@id = ''

-- UsuarioxOpcion ------------------------------------------------------------------------
select * from UsuarioxOpcion
select Count(*) as 'cantVotos' from UsuarioxOpcion where idOpcion = '8C05CBC7-C867-497D-800F-777B52422FC8'

exec sp_C_UsuarioxOpcion
@idOpcion = '',
@idUsuario = '',
@respuesta = '',
@idUserValidador = '',
@error = '',
@info = '',
@id = ''

-- UsuarioxArchivo ------------------------------------------------------------------------
select * from UsuarioxArchivo

select * from Usuario
select * from Reto

exec sp_C_UsuarioxArchivo			
@idReto = '1895C363-0443-4E24-B55D-3F410C435D23',
@idUsuario = 'AB37197C-BF33-44B8-BA5D-E246FA250B41',
@archivo = 'mi archivo1.png',
@url = '',
@error = '',
@info = '',
@id = ''

exec sp_B_UsuarioxArchivoByIdRetoYIdUser	
@idUsuario = 'AB37197C-BF33-44B8-BA5D-E246FA250B41',
@idReto = 'DDF75D8B-E869-4C4B-8A47-547E77E7F632',
@error = '',
@info = '',
@id = ''



-- Pregunta ------------------------------------------------------------------------
select * from Pregunta where nombre = 'primera prueba'

select * from Pregunta  where nombre like '%Que te perecio Femsa en producción audiovisual?%'
select * from Opcion where idPregunta = '5E89EFAE-A8E6-4AAD-9347-A117E6DF00CA'
select * from Opcion where idPregunta = '00046450-01F9-4F73-B3F3-C5A00D11446C'


exec sp_B_PreguntaByIdReto		
@estado = -1,
@idReto = '354e8be8-3d2d-4e42-90b6-8935f7e56ef4',
@error = '',
@info = '',
@id = ''

exec sp_B_PreguntaById		
@idPregunta = '7178DEA1-9A99-475F-9F42-32A77FF81DD0',
@estado = -1,
@error = '',
@info = '',
@id = ''

exec sp_B_PreguntaByAll		
@buscar = '27',
@idReto = '21A9D4C2-0EAD-4CC5-B4C7-1C264676DD30',
@error = '',
@info = '',
@id = ''

exec sp_C_Pregunta		
@nombre = '¿Esta es una pregunta de prueba?',
@idReto = '21A9D4C2-0EAD-4CC5-B4C7-1C264676DD30',
@error = '',
@info = '',
@id = ''

exec sp_U_Pregunta		
@idPregunta = '4D060801-0692-4BE7-8559-52756B101CAA',
@nombre = '¿Esta es una pregunta de prueba editada?',
@idReto = '21A9D4C2-0EAD-4CC5-B4C7-1C264676DD30',
@error = '',
@info = '',
@id = ''

exec sp_D_Pregunta
@idPregunta = '21A9D4C2-0EAD-4CC5-B4C7-1C264676DD30',
@error = '',
@info = '',
@id = ''

-- Reto ------------------------------------------------------------------------
-- select * from reto
-- select * from usuario

-- mi encuesta 1
select * from TipoArchivo where estado = 1
update Reto set idTipoArchivo = '7E6182BB-635F-40BC-9602-27E368C6C905' where idReto = '1895C363-0443-4E24-B55D-3F410C435D23'

insert into TipoArchivo (nombre, descripcion, estado) values
('Video','Es para los retos que se tengan que subir un video pero hay que guardar la url del video ya sea de Vimeo o de Youtube',1)

exec sp_B_Reto
@estado = -1,
@idUsuario = 'AB37197C-BF33-44B8-BA5D-E246FA250B41',
@error = '',
@info = '',
@id = ''

exec sp_B_RetoById
@idReto = 'C214AB54-5ED2-4F61-A075-2196497BAB4B',
@estado = -1,
@error = '',
@info = '',
@id = ''

exec sp_B_RetoByAll
@buscar = '%',
@idUsuario = 'AB37197C-BF33-44B8-BA5D-E246FA250B41',
@error = '',
@info = '',
@id = ''

exec sp_D_Reto	
@idReto = 'F95CAB4F-A810-402D-A9C8-557F0E3A89E8',
@error = '',
@info = '',
@id = ''

exec sp_C_Reto		
@nombre = 'mi segundo reto 25',
@fechaApertura = '',
@fechaCierre = '2023-12-24',
@vidas = 3,
@tiempo = 40000,
@puntosRecompensa = 11,
@creditosObtenidos = 16,
@criterioMin = 0,
@instrucciones = '',
@imagen = '',
@idTipoReto = '63AA060B-CDE4-49C0-9D60-AAF069DF1533',
@idTipoEncuesta = '63AA060B-CDE4-49C0-9D60-AAF069DF1533',
@idComportamiento = '1DD28D88-34C7-4394-AB3D-525726001730',
@idTipoValidador = '1DD28D88-34C7-4394-AB3D-525726001730',
@idTipoArchivo = '1DD28D88-34C7-4394-AB3D-525726001730',
@items = 0,
@opsRequeridas = 0,
@enEquipo = 0,
@error = '',
@info = '',
@id = ''

exec sp_U_Reto		
@idReto = '81642C08-9711-469B-B831-18C682B5122A',
@nombre = 'mi segundo reto editado',
@fechaApertura = '2023-12-29',
@fechaCierre = '2023-12-31',
@vidas = 4,
@tiempo = 50000,
@puntosRecompensa = 12,
@creditosObtenidos = 17,
@criterioMin = 60,
@instrucciones = '',
@imagen = '',
@idTipoReto = '63AA060B-CDE4-49C0-9D60-AAF069DF1533',
@idComportamiento = '1DD28D88-34C7-4394-AB3D-525726001730',
@opsRequeridas = 0,
@error = '',
@info = '',
@id = ''

exec sp_U_RetoByEstado
@idReto = '63AA060B-CDE4-49C0-9D60-AAF069DF1533',
@estado = '',
@error = '',
@info = '',
@id = ''

select * from Usuario_Reto where CAST(fechaCreacion AS DATE) = '2024-05-28';
--delete from Reto where fechaCreacion = '2024-03-07 09:35:53.787'
exec sp_B_Usuario_RetoByIdUsuario		
@idUsuario = 'AB37197C-BF33-44B8-BA5D-E246FA250B41',
@top = -1,
@completado = -1,
@error = '',
@info = '',
@id = ''

exec sp_B_Usuario_RetoByIdUsuarioByAll		
@buscar = '',
@idUsuario = 'AB37197C-BF33-44B8-BA5D-E246FA250B41',			
@completado = -1,
@error = '',
@info = '',
@id = ''


exec sp_B_Usuario_RetoByIdReto
@idReto = '27C5527F-3EA3-431B-BEDF-65841EAF5663',
@validador = 0,
@error = '',
@info = '',
@id = ''

exec sp_B_Usuario_RetoByIdUsuarioYIdReto		
@idUsuario = '91DB7BAE-7D2F-423D-B595-D227C63CA0A6',
@idReto = '0b3439f9-f94d-4e28-b758-89668b4d020f',			
@completado = -1,
@error = '',
@info = '',
@id = ''


select * from Usuario
exec sp_B_Usuario_RetoSumaPuntos
@idUsuario = 'AB37197C-BF33-44B8-BA5D-E246FA250B41',
@top = 10,
@error = '',
@info = '',
@id = ''

exec sp_B_Usuario_RetoPtosMesesAños
@idUsuario = 'AB37197C-BF33-44B8-BA5D-E246FA250B41',
@error = '',
@info = '',
@id = ''

exec sp_B_Usuario_RetoValidador
@idReto = '81642C08-9711-469B-B831-18C682B5122A',
@idUsuario = 'AB37197C-BF33-44B8-BA5D-E246FA250B41',
@error = '',
@info = '',
@id = ''

exec sp_B_Usuario_RetoxValidarByValidador
@idUserValidador = 'AB37197C-BF33-44B8-BA5D-E246FA250B41',
@top = -1,
@error = '',
@info = '',
@id = ''

exec sp_B_Usuario_RetoxValidarByReto
@idReto = '0b3439f9-f94d-4e28-b758-89668b4d020f',
@idUserValidador = 'AB37197C-BF33-44B8-BA5D-E246FA250B41',
@error = '',
@info = '',
@id = ''

exec sp_C_Usuario_Reto
@correo = 'admin@hotmail.com',
@idReto = '1895C363-0443-4E24-B55D-3F410C435D23',
@puntos = -1,
@tiempo = -1,
@vidas = -1,
@tieneEquipo = 0,
@validador = 1,
@error = '',
@info = '',
@id = ''

exec sp_C_Usuario_RetoByCorreoIds
@correo_id = '',
@idReto = '',
@error = '',
@info = '',
@id = ''

exec sp_U_Usuario_Reto
@idUsuario = 'F42329D1-EDAA-4F2C-9AE1-8F026C92C842',
@idReto = '27C5527F-3EA3-431B-BEDF-65841EAF5663',
@puntos = 10,
@tiempo = 100,
@vidas = -1,
@completado = 1,
@correctas = -1,
@incorrectas = -1,
@error = '',
@info = '',
@id = ''

exec sp_D_Usuario_Reto	
@idUsuario = '939C9C6D-9DCF-4B7E-BEA6-5C26169FA066',
@idReto = '81642C08-9711-469B-B831-18C682B5122A',
@error = '',
@info = '',
@id = ''

select * from Usuario_Reto
select * from Usuario where idUsuario = '015e40dd-58ce-401e-a0a9-075874bc0b68'

-- Equipos ------------------------------------------------------------------------
select * from Equipo
select * from Usuario
select * from Usuario_Equipo

exec sp_B_Equipo
@estado = -1,
@error = '',
@info = '',
@id = ''

exec sp_B_EquipoById		
@idEquipo = '114EC699-77C3-4E52-999B-0E59861F46B9',
@estado = -1,
@error = '',
@info = '',
@id = ''

exec sp_B_EquipoByAll		
@buscar = 'desc 2',
@error = '',
@info = '',
@id = ''

exec sp_C_Equipo		
@nombre = '',
@imagen = '',
@descripcion = '',
@error = '',
@info = '',
@id = ''

exec sp_U_Equipo		
@idEquipo = '',
@nombre = '',
@imagen = '',
@descripcion = '',
@error = '',
@info = '',
@id = ''

exec sp_U_EquipoByEstado
@idEquipo = 'FAAE4C5D-9140-40FE-8FB1-F88C5090D8A2',
@estado = '',
@error = '',
@info = '',
@id = ''

exec sp_D_Equipo	
@idEquipo = 'FAAE4C5D-9140-40FE-8FB1-F88C5090D8A1',
@error = '',
@info = '',
@id = ''


select * from Usuario_Equipo
exec sp_B_Usuario_EquipoByIdEquipo
@idEquipo = '53F42543-4841-4482-B4CA-B6C1EABA4EF8',
@error = '',
@info = '',
@id = ''

exec sp_B_Usuario_EquipoByPuntos
@idUsuario  = '91DB7BAE-7D2F-423D-B595-D227C63CA0A6',
@top  = 10,
@error = '',
@info = '',
@id = ''

exec sp_C_Usuario_Equipo
@correo = 'elver.galarga@gmail.com',
@idEquipo = '4638E1DF-928A-442A-BCD8-388AD33A8829',
@error = '',
@info = '',
@id = ''

exec sp_C_Usuario_EquipoByCorreoIds
@correo_id = '',
@idEquipo = '',
@error = '',
@info = '',
@id = ''

exec sp_D_Usuario_Equipo	
@idUsuario = '',
@idEquipo = '',
@error = '',
@info = '',
@id = ''


exec sp_B_Equipo_RetoByIdReto
@idReto = 'd9ca3dcb-ee6a-4f35-ae4c-719843510a1a',
@estado = -1,
@error = '',
@info = '',
@id = ''

exec sp_C_Equipo_Reto
@idEquipo = '53F42543-4841-4482-B4CA-B6C1EABA4EF8',
@idReto = 'D9CA3DCB-EE6A-4F35-AE4C-719843510A1A',
@error = '',
@info = '',
@id = ''

exec sp_D_Equipo_Reto	
@idEquipo = '29F12B60-F1D4-4CA8-948C-90BAF876A4F2',
@idReto = '27C5527F-3EA3-431B-BEDF-65841EAF5663',
@error = '',
@info = '',
@id = ''

-- EQUIPOS AGREGADOS A LOS RETOS
Select 	
ur.idReto,
e.idEquipo,
count(ue.idEquipo) as 'totalUsuarios',
e.nombre,
ISNULL(e.imagen, 'N/A') as 'imagen'	,
e.estado
From Usuario_Reto ur 
inner join Usuario_Equipo ue on ue.idUsuario = ur.idUsuario
inner join Equipo e on e.idEquipo = ue.idEquipo 
Where ur.tieneEquipo = 1
Group by ue.idEquipo, ur.idReto, e.idEquipo, e.nombre, e.imagen, e.estado

-- Tipo de Reto ------------------------------------------------------------------------
exec sp_B_TipoReto		
@estado = -1,
@error = '',
@info = '',
@id = ''


-- Tipo de Encuesta ------------------------------------------------------------------------
exec sp_B_TipoEncuesta		
@estado = 1,
@error = '',
@info = '',
@id = ''

-- Tipo de Entrada ------------------------------------------------------------------------
exec sp_B_TipoEntrada
@estado = -1,
@error = '',
@info = '',
@id = ''

-- Tipo de Validador ------------------------------------------------------------------------
exec sp_B_TipoValidador
@estado = -1,
@error = '',
@info = '',
@id = ''

-- Tipo de Archivo ------------------------------------------------------------------------
exec sp_B_TipoArchivo
@estado = -1,
@error = '',
@info = '',
@id = ''

exec sp_B_TipoValidadorById		
@idTipoValidador = 'ED15D366-E0EA-4D90-A5DF-A4AED453D1FE',
@estado = -1,
@error = '',
@info = '',
@id = ''

-- Comportamiento Pregunta ------------------------------------------------------------------------
exec sp_B_ComporPregu		
@estado = -1,
@error = '',
@info = '',
@id = ''

-- Resumen General ------------------------------------------------------------------------
select * from Usuario
exec sp_B_resumenGeneral
@idUsuario = '939C9C6D-9DCF-4B7E-BEA6-5C26169FA066',
@error = '',
@info = '',
@id = ''

-- Estadisticas del Campus (Licencias)------------------------------------------------------------------------
select * from Licencia
exec sp_B_Licencia
@estado = -1,
@error = '',
@info = '',
@id = ''

exec sp_C_Licencia
@tabla = 'Batalla',
@nombre = 'Batallas',
@cantMax = 10,
@error = '',
@info = '',
@id = ''

-- delete from Licencia where idLicencia = '88A01598-B763-4A27-B13F-9A477D93F61E' 
-- Novedad ------------------------------------------------------------------------
select * from Novedad
select * from Reto
select * from Usuario
select * from Notificacion

-- update Novedad set fechaCreacion = '2024-01-20 16:08:24.113' where idNovedad = '48B47339-53B9-40E2-8A04-33732B9C2814'

exec sp_B_NovedadByIdUsuario		
@idUsuario = '6D81E350-A4F4-4042-A3E9-EF97D985BC2A',
@error = '',
@info = '',
@id = ''

exec sp_U_NovedadByEstado
@idNovedad = '48B47339-53B9-40E2-8A04-33732B9C2814',
@idUsuario = '48B47339-53B9-40E2-8A04-33732B9C2814',
@estado = 1,
@error = '',
@info = '',
@id = ''

exec sp_D_Novedad	
@idNovedad = 'AB37197C-BF33-44B8-BA5D-E246FA250B41',
@idUsuario = '48B47339-53B9-40E2-8A04-33732B9C2814',
@error = '',
@info = '',
@id = ''

exec sp_D_NovedadByIdUsuario	
@idUsuario = '42C77DB8-7FD5-45CB-AB1A-EB331C7DFB61',
@error = '',
@info = '',
@id = ''



-- Notificación ------------------------------------------------------------------------
exec sp_B_Notificacion
@estado = -1,
@error = '',
@info = '',
@id = ''

exec sp_B_NotificacionById		
@idNotificacion = '69614AED-FC82-4EB0-91BD-1463CF6D75FC',
@error = '',
@info = '',
@id = ''

exec sp_B_NotificacionByNombre		
@nombre = 'Notificar a los usuarios cuando canjean una recompensa',
@error = '',
@info = '',
@id = ''

exec sp_U_Notificacion
@idNotificacion = '',
@estado = '',
@msgPers = '',
@numDesc = '',
@error = '',
@info = '',
@id = ''

exec sp_U_NotificacionByEstado		
@idNotificacion = 'F8F1F0CD-7338-473D-B75A-2256A0924D84',
@estado = '',
@error = '',
@info = '',
@id = ''

-- Correo ------------------------------------------------------------------------
select * from CorreoEnvio

exec sp_B_CorreoEnvio
@error = '',
@info = '',
@id = ''

declare @auxClaveCorreo varbinary(max) = CAST('Aqui poner el texto encripado' AS VARBINARY(MAX))

exec sp_U_CorreoEnvio
@idCorreo = '45333B41-0022-42E3-8F26-164F5D157EB1',
@nombre = 'prueba Nombre',
@correo = '06f1835853c3bb',
@clave = @auxClaveCorreo,
@puerto = 2525,
@host = 'sandbox.smtp.mailtrap.io',
@error = '',
@info = '',
@id = ''


--insert into CorreoEnvio (correo, clave, puerto, host) values
--('bcedeno@digimentore.com.ec', @auxClaveCorreo, 587, 'smtp.office365.com')

------------------------------------------------------------------------------------------------------------------------------------
--Insert Into Notificacion (nombre) values
--('Notificar a los usuarios cuando el administrador crea un nuevo usuario'),
--('Notificar a los usuarios cuando se les agregaron a un reto'),
--('Notificar a los usuarios cuando ganan una medalla'),
--('Notificar a los usuarios cuando este entre 10 primeros puestos del ranking'),
--('Notificar a los usuarios cuando el reto esta por cerrarse'),
--('Notificar a los usuarios cuando canjean una recompensa'),
--('Notificar a los usuarios cuando suben de nivel'),
--('Notificar a los usuarios cuando reciben una reacción en la red social'),
------------------------------------------------------------------------------------------------------------------------------------
--insert into Reto (nombre, fechaApetura, fechaCierre, vidas, tiempo_ms, puntosRecompensa, creditosObtenidos, idTipoReto, idComportamiento) values
--('Mi primer reto', '2023-12-16', '2023-12-17', 3, 300000, 10, 5, '63AA060B-CDE4-49C0-9D60-AAF069DF1533', '1DD28D88-34C7-4394-AB3D-525726001730')

--insert into Pregunta (nombre, idReto) values
--('¿Cuantos años tengo?', '21A9D4C2-0EAD-4CC5-B4C7-1C264676DD30')
--('¿Cual es la capital del Ecuador?', '21A9D4C2-0EAD-4CC5-B4C7-1C264676DD30')

--insert into Opcion (nombre, correcta, idPregunta) values
--('Quito', 1, 'EFE6E2F4-091C-4B53-958C-CC1EDC252445'),
--('Tulcan', 0, 'EFE6E2F4-091C-4B53-958C-CC1EDC252445'),
--('Cuenca', 0, 'EFE6E2F4-091C-4B53-958C-CC1EDC252445'),
--('23', 0, '7178DEA1-9A99-475F-9F42-32A77FF81DD0'),
--('25', 0, '7178DEA1-9A99-475F-9F42-32A77FF81DD0'),
--('27', 1, '7178DEA1-9A99-475F-9F42-32A77FF81DD0')


SELECT CONVERT(uniqueidentifier,'DF215E10-8BD4-4401-B2DC-99BB03135F2E')

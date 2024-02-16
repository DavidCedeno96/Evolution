use Evolution_db

EXEC sp_spaceused

EXEC sp_helpdb 'Evolution_db';

---
SELECT SYSDATETIME() AS [Fecha y Hora Actual], CURRENT_TIMEZONE() AS [Zona Horaria Actual];

---
SELECT ROUTINE_NAME FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE ROUTINE_TYPE = 'PROCEDURE'
   ORDER BY ROUTINE_NAME 

---
SELECT
    tr.name AS TriggerName,
    tr.object_id AS TriggerObjectId,
	te.type_desc,
    tr.parent_id AS TableObjectId,
    OBJECT_NAME(tr.parent_id) AS 'TableName'
FROM sys.triggers tr 
INNER JOIN sys.trigger_events te ON tr.object_id = te.object_id
INNER JOIN sys.objects o ON tr.parent_id = o.object_id
--WHERE te.type = 1;

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
    tc.TABLE_NAME = 'Opcion' AND 
    tc.CONSTRAINT_TYPE = 'UNIQUE'    

----
SELECT *
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE TABLE_NAME = 'Noticia' AND CONSTRAINT_TYPE = 'CHECK';

--- INFO DE LA TABLA
SELECT tc.COLUMN_NAME, tc.DATA_TYPE, tc.CHARACTER_MAXIMUM_LENGTH, tc.IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS tc
WHERE tc.TABLE_NAME = 'Inicio';

---
SELECT @@VERSION;

-- INSERTS IMPORTANTES ---------------------------------------------------------
--Insert into Constants (nombre,descripcion) values
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

exec sp_B_InicioByIdRol	
@idRol = 'jug',
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
--delete from Usuario

exec sp_B_Usuario		
@estado = -1,
@error = '',
@info = '',
@id = ''

exec sp_B_UsuarioById	
@idUsuario = '015E40DD-58CE-401E-A0A9-075874BC0B68',	
@estado = -1,
@error = '',
@info = '',
@id = ''

exec sp_B_UsuarioByCorreo
@correo = 'mia@gmail.com',
@error = '',
@info = '',
@id = ''

exec sp_B_UsuarioByAll		
@buscar = 'd/a',
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
@clave = @auxClave,
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
@clave = @auxClave,
@celular = '1234567891',
@foto = 'models.png',
@idRol = 'jug',
@idCiudad = '',
@idArea = '',
@error = '',
@info = '',
@id = ''

exec sp_U_UsuarioByEstado
@idUsuario = 'F42329D1-EDAA-4F2C-9AE1-8F026C92C842',
@estado = 1,
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
DELETE from Pais where idPais = 'B9CB4FD1-FF4F-4606-981C-AC7A6EAE3649'

exec sp_B_Ciudad
@estado = -1,
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
@idNivel = 'D18F415A-CD36-4E84-98FD-04DC30FC1EE1',
@estado = -1,
@error = '',
@info = '',
@id = ''

exec sp_B_NivelByAll		
@buscar = '3',
@error = '',
@info = '',
@id = ''

exec sp_C_Nivel
@nombre = 'nivel 5',
@descripcion = 'este es para el nivel 5',
@puntosNecesarios = 3,
@imagen = '',
@error = '',
@info = '',
@id = ''

exec sp_U_Nivel
@idNivel = '',
@nombre = 'nivel 5',
@descripcion = 'este es para el nivel 5',
@puntosNecesarios = 3,
@imagen = '',
@error = '',
@info = '',
@id = ''

exec sp_D_Nivel
@idNivel = '34FA60B2-4FCD-49A8-BEBB-198E7A343CFA',
@error = '',
@info = '',
@id = ''

select * from Usuario_Nivel

exec sp_B_Usuario_NivelByIdUsuario		
@idUsuario = '91331754-1E83-417F-90E7-0E596E996510',
@top = -1,
@error = '',
@info = '',
@id = ''

exec sp_C_Usuario_Nivel
@idUsuario = 'AB37197C-BF33-44B8-BA5D-E246FA250B41',
@idNivel = '62629073-7CC1-4AD3-82F1-B57A823E0092',
@error = '',
@info = '',
@id = ''

-- Condicion --------------------------------------------------------
exec sp_B_Condicion		
@estado = -1,
@error = '',
@info = '',
@id = ''

-- Medallas --------------------------------------------------------
select * from Condicion

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
@buscar = 'medalla 2',
@error = '',
@info = '',
@id = ''

exec sp_C_Medalla
@nombre = 'medalla 3',
@descripcion = 'desc 1',
@imagen = '',
@idCondicion = '2439150E-8525-4582-8203-9D1D2AC93739',
@error = '',
@info = '',
@id = ''

exec sp_U_Medalla
@idMedalla = '',
@nombre = 'medalla 3',
@descripcion = 'desc 1',
@imagen = '',
@idCondicion = '2439150E-8525-4582-8203-9D1D2AC93739',
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
@idUsuario = '6D3A6B25-C6C7-4ED4-A5E9-D992B1CC98A7',
@idMedalla = '26763EAA-657D-4E10-BD82-78D29934C607',
@error = '',
@info = '',
@id = ''

-- Recompensas --------------------------------------------------------
exec sp_B_Recompensa
@estado = -1,
@error = '',
@info = '',
@id = ''

exec sp_B_RecompensaById		
@idRecompensa = 'CC0B9551-17E1-453A-9FFA-D0EF55F02F70',
@estado = -1,
@error = '',
@info = '',
@id = ''

exec sp_B_RecompensaByAll		
@buscar = 'entradas',
@error = '',
@info = '',
@id = ''

exec sp_C_Recompensa
@nombre = '10 entradas al cine',
@descripcion = '',
@imagen = '',
@cantDisp = 0,	
@cantCanje = 5,
@error = '',
@info = '',
@id = ''

exec sp_U_Recompensa
@idRecompensa = '',
@nombre = '10 entradas al cine',
@descripcion = '',
@imagen = '',
@cantDisp = 0,	
@cantCanje = 5,
@error = '',
@info = '',
@id = ''

exec sp_D_Recompensa
@idRecompensa = '015E40DD-58CE-401E-A0A9-075874BC0B68',
@error = '',
@info = '',
@id = ''

-- HAY TRIGGER
exec sp_C_Usuario_Recompensa
@idUsuario = '015E40DD-58CE-401E-A0A9-075874BC0B68',
@idRecompensa = '56D57B18-2AFE-46A9-822B-9540EB4F8E6A',
@error = '',
@info = '',
@id = ''

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
exec sp_B_RedSocial		
@estado = -1,
@error = '',
@info = '',
@id = ''

exec sp_C_RedSocial	
@descripcion = 'Hola mundo',
@imagen = '',
@fechaPublicacion = '',
@error = '',
@info = '',
@id = ''

exec sp_B_Usuario_RedSocialByIdRed	
@idRed = 'E7D76E78-CE50-4712-AABF-FBC79EA3CB46',
@error = '',
@info = '',
@id = ''

exec sp_C_Usuario_RedSocial
@idUsuario = '6D3A6B25-C6C7-4ED4-A5E9-D992B1CC98A7',
@idRed = 'E7D76E78-CE50-4712-AABF-FBC79EA3CB46',
@likes = 1,
@comentario = '',
@error = '',
@info = '',
@id = ''

-- Configuracion --------------------------------------------------------
exec sp_B_Configuracion
@error = '',
@info = '',
@id = ''

--update Configuracion set valor = '#f58220' where idConfig = 'F7A0D011-57B5-4417-A8C4-F38C8DCE0A20'
--update Configuracion set valor = null where idConfig = 'E21410F4-491B-4E5D-A639-FE5C0E70278D'

exec sp_C_Configuracion
@tipo = 'imagen',
@propiedad = '',
@nombre = 'footer',
@valor = '',
@descripcion = 'Esta es la imagen que esta en el footer',
@idUsuario = '939C9C6D-9DCF-4B7E-BEA6-5C26169FA066',
@error = '',
@info = '',
@id = ''

exec sp_U_Configuracion
@idConfig = '5DFF0459-133F-4EAF-889A-8B2E5557184B',
@tipo = 'color',
@propiedad = '--TxtMenuItem-active',
@nombre = 'texto menu item active',
@valor = '#FFFFFF',
@descripcion = 'Es para el texto del item del menu cuando esta en active y hover',
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

-- Tipo de Reto ------------------------------------------------------------------
exec sp_B_tipoReto
@estado = -1,
@error = '',
@info = '',
@id = ''

-- Opcion ------------------------------------------------------------------------
select * from Opcion

exec sp_B_OpcionByIdPregunta		
@estado = -1,
@idPregunta = 'EFE6E2F4-091C-4B53-958C-CC1EDC252445',
@error = '',
@info = '',
@id = ''

exec sp_C_Opcion		
@nombre = 'Ambato',
@correcta = 0,
@idPregunta = 'EFE6E2F4-091C-4B53-958C-CC1EDC252445',
@error = '',
@info = '',
@id = ''

exec sp_U_Opcion	
@idOpcion = '8EE73190-C353-420B-9453-92C1E9F075E6',
@nombre = 'Ambato',
@correcta = '',
@idPregunta = 'EFE6E2F4-091C-4B53-958C-CC1EDC252445',
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

-- Pregunta ------------------------------------------------------------------------
select * from Pregunta

exec sp_B_PreguntaByIdReto		
@estado = -1,
@idReto = '21A9D4C2-0EAD-4CC5-B4C7-1C264676DD30',
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
exec sp_B_Reto
@estado = -1,
@error = '',
@info = '',
@id = ''

exec sp_D_Reto	
@idReto = '',
@error = '',
@info = '',
@id = ''

exec sp_B_RetoById	
@idReto = '21A9D4C2-0EAD-4CC5-B4C7-1C264676DD30',
@estado = -1,
@error = '',
@info = '',
@id = ''

exec sp_B_RetoByAll
@buscar = 'hola',
@error = '',
@info = '',
@id = ''

exec sp_C_Reto		
@nombre = 'mi segundo reto',
@fechaApertura = '2023-12-23',
@fechaCierre = '2023-12-24',
@vidas = 3,
@tiempo = 40000,
@puntosRecompensa = 11,
@creditosObtenidos = 16,
@instrucciones = '',
@imagen = '',
@idTipoReto = '63AA060B-CDE4-49C0-9D60-AAF069DF1533',
@idComportamiento = '1DD28D88-34C7-4394-AB3D-525726001730',
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
@instrucciones = '',
@imagen = '',
@idTipoReto = '63AA060B-CDE4-49C0-9D60-AAF069DF1533',
@idComportamiento = '1DD28D88-34C7-4394-AB3D-525726001730',
@error = '',
@info = '',
@id = ''


exec sp_B_Usuario_RetoByIdUsuario		
@idUsuario = 'ab37197c-bf33-44b8-ba5d-e246fa250b41',
@top = -1,
@error = '',
@info = '',
@id = ''

exec sp_C_Usuario_Reto
@idUsuario = 'F42329D1-EDAA-4F2C-9AE1-8F026C92C842',
@idReto = '21A9D4C2-0EAD-4CC5-B4C7-1C264676DD30',
@puntos = 23,
@tiempo = 50000,
@vidas = '',
@error = '',
@info = '',
@id = ''

-- Tipo de Reto ------------------------------------------------------------------------
exec sp_B_tipoReto		
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


-- Chart puntos ------------------------------------------------------------------------
exec sp_B_chartPuntos
@error = '',
@info = '',
@id = ''

-- Resumen General ------------------------------------------------------------------------
select * from Usuario
exec sp_B_resumenGeneral
@idUsuario = '939C9C6D-9DCF-4B7E-BEA6-5C26169FA069',
@error = '',
@info = '',
@id = ''

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
select top 1 * from Usuario_Nivel order by fechaCreacion desc

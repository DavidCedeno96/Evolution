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
    tc.TABLE_NAME = 'Noticia' AND 
    tc.CONSTRAINT_TYPE = 'UNIQUE'    

----
SELECT *
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE TABLE_NAME = 'Noticia' AND CONSTRAINT_TYPE = 'CHECK';

--- INFO DE LA TABLA
SELECT tc.COLUMN_NAME, tc.DATA_TYPE, tc.CHARACTER_MAXIMUM_LENGTH, tc.IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS tc
WHERE tc.TABLE_NAME = 'Noticia';

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
@correo = 'mia@gmail.com',
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

-- Area --------------------------------------------------------
exec sp_B_Area		
@estado = -1,
@error = '',
@info = '',
@id = ''

exec sp_C_Area		
@nombre = 'Preuab1',
@descripcion = 'Este es solo para la prueba1',
@idEmpresa = '4E87C6CD-992A-4F14-90C8-CB7BFD4B2DBA',
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

exec sp_C_Pais		
@nombre = 'Prueba',
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
exec sp_B_Ciudad
@estado = -1,
@error = '',
@info = '',
@id = ''

exec sp_C_Ciudad		
@nombre = 'prueba',
@descripcion = '',
@idPais = '1E539FEF-7E19-4248-BD2C-D19B79726B0A',
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

exec sp_C_Usuario_Nivel
@idUsuario = '939C9C6D-9DCF-4B7E-BEA6-5C26169FA066',
@idNivel = 'D18F415A-CD36-4E84-98FD-04DC30FC1EE1',
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
exec sp_B_Medalla
@estado = -1,
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

exec sp_C_Configuracion
@tipo = 'color',
@propiedad = '--ColorBotonSecundario',
@nombre = 'boton secundario',
@valor = '#58CD2C',
@descripcion = '',
@idUsuario = '939C9C6D-9DCF-4B7E-BEA6-5C26169FA066',
@error = '',
@info = '',
@id = ''

exec sp_U_Configuracion
@idConfig = '453657DA-CC12-403D-888F-96D72035A4C0',
@tipo = 'color',
@propiedad = '--ColorBotonSecundario',
@nombre = 'boton secundario',
@valor = '#4CBB23',
@descripcion = '',
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


-- Pregunta ------------------------------------------------------------------------
select * from Pregunta

exec sp_B_PreguntaByIdReto		
@estado = -1,
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

exec sp_B_RetoById	
@idReto = '21A9D4C2-0EAD-4CC5-B4C7-1C264676DD30',
@estado = -1,
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

exec sp_C_Usuario_Reto
@idUsuario = 'F42329D1-EDAA-4F2C-9AE1-8F026C92C842',
@idReto = '21A9D4C2-0EAD-4CC5-B4C7-1C264676DD30',
@puntos = 23,
@tiempo = 50000,
@vidas = '',
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
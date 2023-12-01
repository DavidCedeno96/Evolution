use Evolution_db

select * from Rol
select * from Usuario
select * from Area
select * from Nivel

-- ---------------------------------------------------------
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
exec sp_B_UsuarioById	
@idUsuario = 'DFD02F9A-4617-4713-9A9B-19FBC2817258',	
@estado = -1,
@error = '',
@info = '',
@id = ''

exec sp_B_UsuarioLogin
@correo = 'david@gmail.com',
@clave = 'admin',
@error = '',
@info = '',
@id = ''

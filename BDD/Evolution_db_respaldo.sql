USE [Evolution_db]
GO
/****** Object:  UserDefinedFunction [dbo].[sf_totalEquiposAsignadosByReto]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[sf_totalEquiposAsignadosByReto] (@idReto uniqueidentifier)
RETURNS INT
AS
BEGIN

	DECLARE @retoNombre varchar(30), @total int = 0

	DECLARE EquiposByReto CURSOR FOR 
	
	Select 	
	e.nombre
	From Usuario_Reto ur 
	inner join Usuario_Equipo ue on ue.idUsuario = ur.idUsuario
	inner join Equipo e on e.idEquipo = ue.idEquipo 
	Where ur.tieneEquipo = 1 and idReto = @idReto
	Group by ue.idEquipo, ur.idReto, e.idEquipo, e.nombre, e.imagen, e.estado


	OPEN EquiposByReto
	FETCH NEXT FROM EquiposByReto INTO @retoNombre
	WHILE @@fetch_status = 0
	BEGIN

		set @total += 1		

		FETCH NEXT FROM EquiposByReto INTO @retoNombre
	END
	CLOSE EquiposByReto
	DEALLOCATE EquiposByReto
   

    RETURN @total;
END;
GO
/****** Object:  Table [dbo].[Area]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Area](
	[idArea] [uniqueidentifier] NOT NULL,
	[nombre] [varchar](65) NOT NULL,
	[descripcion] [varchar](250) NULL,
	[estado] [int] NULL,
	[fechaCreacion] [datetime] NULL,
	[fechaModificacion] [datetime] NULL,
	[idEmpresa] [uniqueidentifier] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[idArea] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CategoriaNoticia]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CategoriaNoticia](
	[idCategoria] [uniqueidentifier] NOT NULL,
	[nombre] [varchar](50) NOT NULL,
	[descripcion] [varchar](250) NULL,
	[estado] [int] NULL,
	[fechaCreacion] [datetime] NULL,
	[fechaModificacion] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[idCategoria] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CategoriaRecompensa]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CategoriaRecompensa](
	[idCategoria] [uniqueidentifier] NOT NULL,
	[nombre] [varchar](50) NOT NULL,
	[descripcion] [varchar](250) NULL,
	[estado] [int] NULL,
	[fechaCreacion] [datetime] NULL,
	[fechaModificacion] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[idCategoria] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ciudad]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ciudad](
	[idCiudad] [uniqueidentifier] NOT NULL,
	[nombre] [varchar](65) NOT NULL,
	[descripcion] [varchar](250) NULL,
	[idPais] [uniqueidentifier] NOT NULL,
	[estado] [int] NULL,
	[fechaCreacion] [datetime] NULL,
	[fechaModificacion] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[idCiudad] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ComportamientoPregunta]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ComportamientoPregunta](
	[idComportamiento] [uniqueidentifier] NOT NULL,
	[nombre] [varchar](30) NOT NULL,
	[descripcion] [varchar](250) NULL,
	[estado] [int] NULL,
	[fechaCreacion] [datetime] NULL,
	[fechaModificacion] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[idComportamiento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Condicion]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Condicion](
	[idCondicion] [uniqueidentifier] NOT NULL,
	[nombre] [varchar](30) NOT NULL,
	[descripcion] [varchar](250) NULL,
	[estado] [int] NULL,
	[fechaCreacion] [datetime] NULL,
	[fechaModificacion] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[idCondicion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Configuracion]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Configuracion](
	[idConfig] [uniqueidentifier] NOT NULL,
	[tipo] [varchar](10) NOT NULL,
	[propiedad] [varchar](40) NULL,
	[nombre] [varchar](30) NOT NULL,
	[valor] [varchar](50) NULL,
	[descripcion] [varchar](250) NULL,
	[idUsuario] [uniqueidentifier] NULL,
	[fechaCreacion] [datetime] NULL,
	[fechaModificacion] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[idConfig] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Constants]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Constants](
	[nombre] [varchar](20) NOT NULL,
	[descripcion] [varchar](250) NULL,
	[estado] [int] NULL,
	[fechaCreacion] [datetime] NULL,
	[fechaModificacion] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CorreoEnvio]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CorreoEnvio](
	[idCorreo] [uniqueidentifier] NOT NULL,
	[correo] [varchar](60) NOT NULL,
	[clave] [varbinary](max) NOT NULL,
	[puerto] [int] NOT NULL,
	[host] [varchar](60) NOT NULL,
	[fechaCreacion] [datetime] NULL,
	[fechaModificacion] [datetime] NULL,
	[nombre] [varchar](60) NULL,
PRIMARY KEY CLUSTERED 
(
	[idCorreo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Empresa]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Empresa](
	[idEmpresa] [uniqueidentifier] NOT NULL,
	[nombre] [varchar](100) NOT NULL,
	[descripcion] [varchar](250) NULL,
	[estado] [int] NULL,
	[fechaCreacion] [datetime] NULL,
	[fechaModificacion] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[idEmpresa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Equipo]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Equipo](
	[idEquipo] [uniqueidentifier] NOT NULL,
	[nombre] [varchar](60) NOT NULL,
	[imagen] [varchar](50) NULL,
	[descripcion] [varchar](250) NULL,
	[estado] [int] NULL,
	[fechaCreacion] [datetime] NULL,
	[fechaModificacion] [datetime] NULL,
	[tiempo] [int] NOT NULL,
	[puntos] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[idEquipo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Inicio]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Inicio](
	[idInicio] [uniqueidentifier] NOT NULL,
	[nombre] [varchar](60) NOT NULL,
	[indice] [int] NOT NULL,
	[estado] [int] NOT NULL,
	[color] [varchar](10) NULL,
	[idRol] [varchar](9) NOT NULL,
	[fechaCreacion] [datetime] NULL,
	[fechaModificacion] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[idInicio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Licencia]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Licencia](
	[idLicencia] [uniqueidentifier] NOT NULL,
	[tabla] [varchar](60) NOT NULL,
	[nombre] [varchar](60) NOT NULL,
	[cantidadMaxima] [int] NOT NULL,
	[estado] [int] NULL,
	[fechaCreacion] [datetime] NULL,
	[fechaModificacion] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[idLicencia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Medalla]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Medalla](
	[idMedalla] [uniqueidentifier] NOT NULL,
	[nombre] [varchar](30) NOT NULL,
	[descripcion] [varchar](250) NULL,
	[imagen] [varchar](50) NULL,
	[estado] [int] NULL,
	[idCondicion] [uniqueidentifier] NOT NULL,
	[fechaCreacion] [datetime] NULL,
	[fechaModificacion] [datetime] NULL,
	[numCondicion] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[idMedalla] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Nivel]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Nivel](
	[idNivel] [uniqueidentifier] NOT NULL,
	[nombre] [varchar](20) NOT NULL,
	[descripcion] [varchar](250) NULL,
	[puntosNecesarios] [int] NOT NULL,
	[imagen] [varchar](50) NULL,
	[estado] [int] NULL,
	[fechaCreacion] [datetime] NULL,
	[fechaModificacion] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[idNivel] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Noticia]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Noticia](
	[idNoticia] [uniqueidentifier] NOT NULL,
	[titular] [varchar](100) NULL,
	[descripcion] [varchar](500) NULL,
	[url] [varchar](250) NULL,
	[imagen] [varchar](50) NULL,
	[estado] [int] NULL,
	[idCategoria] [uniqueidentifier] NOT NULL,
	[fechaPublicacion] [datetime] NULL,
	[fechaCreacion] [datetime] NULL,
	[fechaModificacion] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[idNoticia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Notificacion]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Notificacion](
	[idNotificacion] [uniqueidentifier] NOT NULL,
	[nombre] [varchar](160) NOT NULL,
	[estado] [int] NOT NULL,
	[msgPersonalizado] [varchar](350) NULL,
	[descripcion] [varchar](60) NULL,
	[numDesc] [int] NOT NULL,
	[enviarCorreo] [int] NOT NULL,
	[fechaCreacion] [datetime] NULL,
	[fechaModificacion] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[idNotificacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Novedad]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Novedad](
	[idNovedad] [uniqueidentifier] NOT NULL,
	[mensaje] [varchar](250) NOT NULL,
	[auxMsg] [varchar](100) NULL,
	[idUsuario] [uniqueidentifier] NOT NULL,
	[idTabla] [uniqueidentifier] NULL,
	[tabla] [varchar](30) NULL,
	[estado] [int] NOT NULL,
	[fechaCreacion] [datetime] NULL,
	[fechaModificacion] [datetime] NULL,
	[ruta] [varchar](60) NULL,
PRIMARY KEY CLUSTERED 
(
	[idNovedad] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Opcion]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Opcion](
	[idOpcion] [uniqueidentifier] NOT NULL,
	[nombre] [varchar](200) NOT NULL,
	[correcta] [int] NULL,
	[estado] [int] NULL,
	[idPregunta] [uniqueidentifier] NOT NULL,
	[fechaCreacion] [datetime] NULL,
	[fechaModificacion] [datetime] NULL,
	[valor] [int] NOT NULL,
	[idTipoEntrada] [uniqueidentifier] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[idOpcion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pais]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pais](
	[idPais] [uniqueidentifier] NOT NULL,
	[nombre] [varchar](65) NOT NULL,
	[descripcion] [varchar](250) NULL,
	[estado] [int] NULL,
	[fechaCreacion] [datetime] NULL,
	[fechaModificacion] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[idPais] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pregunta]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pregunta](
	[idPregunta] [uniqueidentifier] NOT NULL,
	[nombre] [varchar](200) NOT NULL,
	[estado] [int] NULL,
	[idReto] [uniqueidentifier] NOT NULL,
	[fechaCreacion] [datetime] NULL,
	[fechaModificacion] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[idPregunta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Recompensa]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Recompensa](
	[idRecompensa] [uniqueidentifier] NOT NULL,
	[nombre] [varchar](60) NOT NULL,
	[descripcion] [varchar](250) NULL,
	[imagen] [varchar](50) NULL,
	[cantDisponible] [int] NULL,
	[cantCanje] [int] NULL,
	[estado] [int] NULL,
	[fechaCreacion] [datetime] NULL,
	[fechaModificacion] [datetime] NULL,
	[idCategoria] [uniqueidentifier] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[idRecompensa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RedSocial]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RedSocial](
	[idRed] [uniqueidentifier] NOT NULL,
	[descripcion] [varchar](250) NOT NULL,
	[imagen] [varchar](50) NULL,
	[estado] [int] NULL,
	[fechaPublicacion] [datetime] NULL,
	[fechaCreacion] [datetime] NULL,
	[fechaModificacion] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[idRed] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Reto]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reto](
	[idReto] [uniqueidentifier] NOT NULL,
	[nombre] [varchar](40) NOT NULL,
	[fechaApetura] [datetime] NULL,
	[fechaCierre] [datetime] NULL,
	[estado] [int] NULL,
	[vidas] [int] NULL,
	[tiempo_ms] [int] NULL,
	[puntosRecompensa] [int] NULL,
	[creditosObtenidos] [int] NULL,
	[instrucciones] [varchar](300) NULL,
	[imagen] [varchar](50) NULL,
	[idTipoReto] [uniqueidentifier] NOT NULL,
	[idComportamiento] [uniqueidentifier] NOT NULL,
	[fechaCreacion] [datetime] NULL,
	[fechaModificacion] [datetime] NULL,
	[criterioMinimo] [int] NOT NULL,
	[enEquipo] [int] NOT NULL,
	[idTipoEncuesta] [uniqueidentifier] NOT NULL,
	[opsRequeridas] [int] NOT NULL,
	[items] [int] NOT NULL,
	[idTipoValidador] [uniqueidentifier] NOT NULL,
	[idTipoArchivo] [uniqueidentifier] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[idReto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Rol]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rol](
	[idRol] [varchar](9) NOT NULL,
	[nombre] [varchar](20) NOT NULL,
	[descripcion] [varchar](250) NULL,
	[estado] [int] NULL,
	[fechaCreacion] [datetime] NULL,
	[fechaModificacion] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[idRol] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TipoArchivo]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoArchivo](
	[idTipoArchivo] [uniqueidentifier] NOT NULL,
	[nombre] [varchar](20) NOT NULL,
	[descripcion] [varchar](250) NULL,
	[estado] [int] NULL,
	[fechaCreacion] [datetime] NULL,
	[fechaModificacion] [datetime] NULL,
	[extension] [varchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[idTipoArchivo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TipoEncuesta]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoEncuesta](
	[idTipoEncuesta] [uniqueidentifier] NOT NULL,
	[nombre] [varchar](20) NOT NULL,
	[descripcion] [varchar](250) NULL,
	[estado] [int] NULL,
	[fechaCreacion] [datetime] NULL,
	[fechaModificacion] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[idTipoEncuesta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TipoEntrada]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoEntrada](
	[idTipoEntrada] [uniqueidentifier] NOT NULL,
	[nombre] [varchar](20) NOT NULL,
	[descripcion] [varchar](250) NULL,
	[estado] [int] NULL,
	[fechaCreacion] [datetime] NULL,
	[fechaModificacion] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[idTipoEntrada] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TipoReto]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoReto](
	[idTipoReto] [uniqueidentifier] NOT NULL,
	[nombre] [varchar](30) NOT NULL,
	[descripcion] [varchar](250) NULL,
	[estado] [int] NULL,
	[fechaCreacion] [datetime] NULL,
	[fechaModificacion] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[idTipoReto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TipoValidador]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoValidador](
	[idTipoValidador] [uniqueidentifier] NOT NULL,
	[nombre] [varchar](40) NOT NULL,
	[descripcion] [varchar](250) NULL,
	[estado] [int] NULL,
	[fechaCreacion] [datetime] NULL,
	[fechaModificacion] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[idTipoValidador] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuario]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuario](
	[idUsuario] [uniqueidentifier] NOT NULL,
	[nombre] [varchar](23) NOT NULL,
	[apellido] [varchar](23) NOT NULL,
	[correo] [varchar](60) NOT NULL,
	[celular] [varchar](15) NULL,
	[foto] [varchar](50) NULL,
	[estado] [int] NULL,
	[idRol] [varchar](9) NOT NULL,
	[idArea] [uniqueidentifier] NULL,
	[fechaCreacion] [datetime] NULL,
	[fechaModificacion] [datetime] NULL,
	[clave] [varbinary](max) NOT NULL,
	[idCiudad] [uniqueidentifier] NULL,
	[fechaLogin] [datetime] NULL,
	[puntos] [int] NOT NULL,
	[creditos] [int] NOT NULL,
	[id] [varchar](20) NOT NULL,
	[paisIso2] [varchar](4) NULL,
	[paisCode] [varchar](5) NULL,
PRIMARY KEY CLUSTERED 
(
	[idUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuario_Equipo]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuario_Equipo](
	[idEquipo] [uniqueidentifier] NOT NULL,
	[idUsuario] [uniqueidentifier] NOT NULL,
	[fechaCreacion] [datetime] NULL,
	[fechaModificacion] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuario_Medalla]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuario_Medalla](
	[idMedalla] [uniqueidentifier] NOT NULL,
	[idUsuario] [uniqueidentifier] NOT NULL,
	[fechaCreacion] [datetime] NULL,
	[fechaModificacion] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuario_Nivel]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuario_Nivel](
	[idUsuario] [uniqueidentifier] NOT NULL,
	[idNivel] [uniqueidentifier] NOT NULL,
	[fechaCreacion] [datetime] NULL,
	[fechaModificacion] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuario_Noticia]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuario_Noticia](
	[idNoticia] [uniqueidentifier] NOT NULL,
	[idUsuario] [uniqueidentifier] NOT NULL,
	[likes] [int] NULL,
	[comentario] [varchar](250) NULL,
	[fechaCreacion] [datetime] NULL,
	[fechaModificacion] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuario_Recompensa]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuario_Recompensa](
	[idRecompensa] [uniqueidentifier] NOT NULL,
	[idUsuario] [uniqueidentifier] NOT NULL,
	[fechaCreacion] [datetime] NULL,
	[fechaModificacion] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuario_RedSocial]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuario_RedSocial](
	[idRed] [uniqueidentifier] NOT NULL,
	[idUsuario] [uniqueidentifier] NOT NULL,
	[likes] [int] NULL,
	[comentario] [varchar](255) NULL,
	[fechaCreacion] [datetime] NULL,
	[fechaModificacion] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuario_Reto]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuario_Reto](
	[idReto] [uniqueidentifier] NOT NULL,
	[idUsuario] [uniqueidentifier] NOT NULL,
	[puntos] [int] NOT NULL,
	[tiempo] [int] NOT NULL,
	[vidas] [int] NOT NULL,
	[fechaCreacion] [datetime] NULL,
	[fechaModificacion] [datetime] NULL,
	[completado] [int] NOT NULL,
	[fechaAsignacion] [datetime] NULL,
	[tieneEquipo] [int] NOT NULL,
	[validador] [int] NOT NULL,
	[correctas] [int] NOT NULL,
	[incorrectas] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UsuarioxArchivo]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UsuarioxArchivo](
	[idReto] [uniqueidentifier] NOT NULL,
	[idUsuario] [uniqueidentifier] NOT NULL,
	[archivo] [varchar](100) NOT NULL,
	[fechaCreacion] [datetime] NULL,
	[fechaModificacion] [datetime] NULL,
	[url] [varchar](150) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UsuarioxOpcion]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UsuarioxOpcion](
	[idOpcion] [uniqueidentifier] NOT NULL,
	[idUsuario] [uniqueidentifier] NOT NULL,
	[fechaCreacion] [datetime] NULL,
	[fechaModificacion] [datetime] NULL,
	[respuesta] [varchar](350) NULL,
	[idUserValidador] [uniqueidentifier] NULL
) ON [PRIMARY]
GO
INSERT [dbo].[Area] ([idArea], [nombre], [descripcion], [estado], [fechaCreacion], [fechaModificacion], [idEmpresa]) VALUES (N'914784e1-b67c-4e57-b53a-209f99944985', N'Desarrollo Multimedia', NULL, 1, CAST(N'2023-12-13T17:40:15.660' AS DateTime), CAST(N'2023-12-13T17:40:15.660' AS DateTime), N'4e87c6cd-992a-4f14-90c8-cb7bfd4b2dba')
GO
INSERT [dbo].[Area] ([idArea], [nombre], [descripcion], [estado], [fechaCreacion], [fechaModificacion], [idEmpresa]) VALUES (N'e592fcd1-94c6-469d-a646-3106e3f043b0', N'Call Center', NULL, 1, CAST(N'2024-01-30T12:16:43.673' AS DateTime), CAST(N'2024-01-30T12:16:43.673' AS DateTime), N'1cb1db77-b372-43d8-9fa1-eb64fa7b9cdd')
GO
INSERT [dbo].[Area] ([idArea], [nombre], [descripcion], [estado], [fechaCreacion], [fechaModificacion], [idEmpresa]) VALUES (N'c1df8d3c-0069-468e-8811-a0f404f12819', N'Recursos Humanos', NULL, 1, CAST(N'2024-01-30T12:16:29.893' AS DateTime), CAST(N'2024-01-30T12:16:29.893' AS DateTime), N'1cb1db77-b372-43d8-9fa1-eb64fa7b9cdd')
GO
INSERT [dbo].[Area] ([idArea], [nombre], [descripcion], [estado], [fechaCreacion], [fechaModificacion], [idEmpresa]) VALUES (N'1b837374-0533-4885-af06-a3af2d6e3b50', N'preubn edit', N'Este es solo para la prueba', 1, CAST(N'2023-12-13T17:50:36.960' AS DateTime), CAST(N'2023-12-13T17:50:36.960' AS DateTime), N'4e87c6cd-992a-4f14-90c8-cb7bfd4b2dba')
GO
INSERT [dbo].[Area] ([idArea], [nombre], [descripcion], [estado], [fechaCreacion], [fechaModificacion], [idEmpresa]) VALUES (N'9452289a-57ca-4d8b-8618-cbd785690951', N'Preuab1', N'Este es solo para la prueba1', 1, CAST(N'2023-12-19T16:13:20.073' AS DateTime), CAST(N'2023-12-19T16:13:20.073' AS DateTime), N'4e87c6cd-992a-4f14-90c8-cb7bfd4b2dba')
GO
INSERT [dbo].[Area] ([idArea], [nombre], [descripcion], [estado], [fechaCreacion], [fechaModificacion], [idEmpresa]) VALUES (N'b7fc947e-8db6-415d-b361-e0c41fcc8344', N'Asistente de Tics', NULL, 1, CAST(N'2023-12-13T17:21:13.180' AS DateTime), CAST(N'2023-12-13T17:21:13.180' AS DateTime), N'4e87c6cd-992a-4f14-90c8-cb7bfd4b2dba')
GO
INSERT [dbo].[CategoriaNoticia] ([idCategoria], [nombre], [descripcion], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'e399ab72-bd42-40a6-b48d-860e328d2fbd', N'Deportes', NULL, 1, CAST(N'2024-02-02T10:03:30.077' AS DateTime), CAST(N'2024-03-01T14:35:38.277' AS DateTime))
GO
INSERT [dbo].[CategoriaNoticia] ([idCategoria], [nombre], [descripcion], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'e8c4e141-d3da-4d06-9e8e-ad69ed9143bc', N'General', N'Es para las noticias en general', 1, CAST(N'2023-01-02T00:00:00.000' AS DateTime), CAST(N'2024-03-01T12:10:27.767' AS DateTime))
GO
INSERT [dbo].[CategoriaNoticia] ([idCategoria], [nombre], [descripcion], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'5728b518-8f16-4649-b682-c20c4e7a7f21', N'nueva categoria', NULL, 1, CAST(N'2024-03-20T11:24:40.200' AS DateTime), CAST(N'2024-03-20T11:25:14.217' AS DateTime))
GO
INSERT [dbo].[CategoriaNoticia] ([idCategoria], [nombre], [descripcion], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'65e3ec0d-24d9-4f06-9b9c-de5f21c925ae', N'Culturales', N'Cuando se refieren a sucesos de la vida artística, literaria y cultural del país.', 1, CAST(N'2023-12-13T14:49:22.407' AS DateTime), CAST(N'2023-12-13T14:49:22.407' AS DateTime))
GO
INSERT [dbo].[CategoriaNoticia] ([idCategoria], [nombre], [descripcion], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'884568d0-5390-4216-a6d1-f52fa220b202', N'Ejemplo', NULL, 1, CAST(N'2024-03-12T16:57:03.897' AS DateTime), CAST(N'2024-03-12T16:57:03.897' AS DateTime))
GO
INSERT [dbo].[CategoriaNoticia] ([idCategoria], [nombre], [descripcion], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'622ff0ac-4ec0-461f-8eda-f8a487f80eb3', N'Científicas', N'Las cuatro categorías científicas básicas son: Aspirante a Investigador (transitoria), Investigador Agregado, Investigador Auxiliar e Investigador Titular.', 1, CAST(N'2023-12-12T15:45:48.870' AS DateTime), CAST(N'2024-02-02T09:59:52.250' AS DateTime))
GO
INSERT [dbo].[CategoriaRecompensa] ([idCategoria], [nombre], [descripcion], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'ee6ca0ed-f5e2-4640-aaf4-76d11c9762b2', N'Prueba', NULL, 1, CAST(N'2024-04-16T13:02:37.217' AS DateTime), CAST(N'2024-04-16T13:03:04.807' AS DateTime))
GO
INSERT [dbo].[CategoriaRecompensa] ([idCategoria], [nombre], [descripcion], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'11283d21-ea6e-4945-9c59-a8868416016f', N'General', N'Es para las recompensas en general', 1, CAST(N'2024-04-16T11:36:12.410' AS DateTime), CAST(N'2024-04-16T14:53:54.280' AS DateTime))
GO
INSERT [dbo].[Ciudad] ([idCiudad], [nombre], [descripcion], [idPais], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'ca6c9451-3ea9-465f-88ce-07e078314731', N'Guayaquil', NULL, N'1e539fef-7e19-4248-bd2c-d19b79726b0a', 1, CAST(N'2024-01-30T11:56:18.220' AS DateTime), CAST(N'2024-01-30T11:56:18.220' AS DateTime))
GO
INSERT [dbo].[Ciudad] ([idCiudad], [nombre], [descripcion], [idPais], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'81b630d1-d9ad-4590-a992-24bd85bafff2', N'Cancún', NULL, N'4a89b8a4-418d-47e1-bd16-80aab501d4c0', 1, CAST(N'2024-01-30T11:58:26.253' AS DateTime), CAST(N'2024-01-30T11:58:26.253' AS DateTime))
GO
INSERT [dbo].[Ciudad] ([idCiudad], [nombre], [descripcion], [idPais], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'c8a7ed9a-8a62-4a3b-9114-9a204938f25d', N'Guadalajara', NULL, N'4a89b8a4-418d-47e1-bd16-80aab501d4c0', 1, CAST(N'2024-01-30T11:57:44.430' AS DateTime), CAST(N'2024-01-30T11:57:44.430' AS DateTime))
GO
INSERT [dbo].[Ciudad] ([idCiudad], [nombre], [descripcion], [idPais], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'ba814fdb-8b2c-4e82-8a61-af2d4ae7387a', N'CDMX', NULL, N'4a89b8a4-418d-47e1-bd16-80aab501d4c0', 1, CAST(N'2024-01-30T11:57:22.253' AS DateTime), CAST(N'2024-01-30T11:57:22.253' AS DateTime))
GO
INSERT [dbo].[Ciudad] ([idCiudad], [nombre], [descripcion], [idPais], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'48632ff5-b6f9-45f0-a514-c0a5ec544226', N'Quito', NULL, N'1e539fef-7e19-4248-bd2c-d19b79726b0a', 1, CAST(N'2023-12-15T12:21:51.743' AS DateTime), CAST(N'2023-12-15T12:21:51.743' AS DateTime))
GO
INSERT [dbo].[Ciudad] ([idCiudad], [nombre], [descripcion], [idPais], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'529cdd9d-4f17-41e4-abc3-c6d57ae19322', N'Tijuana', NULL, N'4a89b8a4-418d-47e1-bd16-80aab501d4c0', 1, CAST(N'2024-01-30T11:57:30.640' AS DateTime), CAST(N'2024-01-30T11:57:30.640' AS DateTime))
GO
INSERT [dbo].[Ciudad] ([idCiudad], [nombre], [descripcion], [idPais], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'f25e73ba-3d82-4d9b-86b4-d4aa94745649', N'Mexicali', NULL, N'4a89b8a4-418d-47e1-bd16-80aab501d4c0', 1, CAST(N'2024-01-30T11:58:00.587' AS DateTime), CAST(N'2024-01-30T11:58:00.587' AS DateTime))
GO
INSERT [dbo].[Ciudad] ([idCiudad], [nombre], [descripcion], [idPais], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'679fdc16-b347-4a5b-b7b6-f00e92786c7f', N'ciudad edit', N'edit', N'd0a947c1-149a-4747-9a58-272f3eed7480', 1, CAST(N'2023-12-15T12:30:44.057' AS DateTime), CAST(N'2023-12-15T12:32:26.393' AS DateTime))
GO
INSERT [dbo].[Ciudad] ([idCiudad], [nombre], [descripcion], [idPais], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'ca53fa42-c034-454a-a64b-fa2122500858', N'Ambato', NULL, N'1e539fef-7e19-4248-bd2c-d19b79726b0a', 1, CAST(N'2024-02-06T16:17:58.257' AS DateTime), CAST(N'2024-02-06T16:18:55.797' AS DateTime))
GO
INSERT [dbo].[Ciudad] ([idCiudad], [nombre], [descripcion], [idPais], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'78a452cc-98e6-414d-a882-fe9c6bd5a70c', N'Cuenca', NULL, N'1e539fef-7e19-4248-bd2c-d19b79726b0a', 1, CAST(N'2024-01-30T11:56:35.787' AS DateTime), CAST(N'2024-01-30T11:56:35.787' AS DateTime))
GO
INSERT [dbo].[ComportamientoPregunta] ([idComportamiento], [nombre], [descripcion], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'1dd28d88-34c7-4394-ab3d-525726001730', N'Aleatorio', N'Es para que se muestren de forma aleatoria las preguntas', 1, CAST(N'2023-12-16T10:23:46.323' AS DateTime), CAST(N'2023-12-16T10:23:46.323' AS DateTime))
GO
INSERT [dbo].[ComportamientoPregunta] ([idComportamiento], [nombre], [descripcion], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'cce31bb2-f39c-4328-823b-ef32e5bd8ca1', N'Normal', N'las preguntas se van a mostrar normalmente', 1, CAST(N'2023-12-16T10:23:46.323' AS DateTime), CAST(N'2023-12-16T10:23:46.323' AS DateTime))
GO
INSERT [dbo].[Condicion] ([idCondicion], [nombre], [descripcion], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'5f908fdb-6b0d-4903-ad1f-76826511c8a5', N'Completar retos', N'retos', 1, CAST(N'2023-12-12T11:23:49.307' AS DateTime), CAST(N'2023-12-12T11:23:49.307' AS DateTime))
GO
INSERT [dbo].[Condicion] ([idCondicion], [nombre], [descripcion], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'2439150e-8525-4582-8203-9d1d2ac93739', N'Obtener puntos', N'puntos', 1, CAST(N'2023-12-12T11:23:49.307' AS DateTime), CAST(N'2023-12-12T11:23:49.307' AS DateTime))
GO
INSERT [dbo].[Configuracion] ([idConfig], [tipo], [propiedad], [nombre], [valor], [descripcion], [idUsuario], [fechaCreacion], [fechaModificacion]) VALUES (N'c0c99c24-fcc3-4c9b-a380-16b1cab52c90', N'color', N'--Loading1', N'carga superior', N'#f58220', N'Es para la franja superior del loading', N'939c9c6d-9dcf-4b7e-bea6-5c26169fa066', CAST(N'2024-02-10T07:00:00.000' AS DateTime), CAST(N'2024-03-19T15:20:59.170' AS DateTime))
GO
INSERT [dbo].[Configuracion] ([idConfig], [tipo], [propiedad], [nombre], [valor], [descripcion], [idUsuario], [fechaCreacion], [fechaModificacion]) VALUES (N'6c44b768-7844-4e27-9371-1819803cc20f', N'color', N'--BgMenuItem', N'menu item', N'#f58220', N'Es para el item del menu', N'939c9c6d-9dcf-4b7e-bea6-5c26169fa066', CAST(N'2024-02-20T07:00:00.000' AS DateTime), CAST(N'2024-03-19T15:20:59.173' AS DateTime))
GO
INSERT [dbo].[Configuracion] ([idConfig], [tipo], [propiedad], [nombre], [valor], [descripcion], [idUsuario], [fechaCreacion], [fechaModificacion]) VALUES (N'1e4b42b0-dabe-48ee-8a5e-29e71621bfea', N'url', NULL, N'url servicio', N'http://192.168.100.91:8087', N'Esta es la url del servicio REST', N'939c9c6d-9dcf-4b7e-bea6-5c26169fa066', CAST(N'2024-04-02T11:25:02.020' AS DateTime), CAST(N'2024-04-02T11:25:02.020' AS DateTime))
GO
INSERT [dbo].[Configuracion] ([idConfig], [tipo], [propiedad], [nombre], [valor], [descripcion], [idUsuario], [fechaCreacion], [fechaModificacion]) VALUES (N'9c28f7e8-eddd-4b12-b96d-3eed36a13376', N'color', N'--Terciario', N'terciario', N'#898a8d', N'Es para los colores terciarios', N'939c9c6d-9dcf-4b7e-bea6-5c26169fa066', CAST(N'2024-01-03T07:00:00.000' AS DateTime), CAST(N'2024-03-19T15:20:59.170' AS DateTime))
GO
INSERT [dbo].[Configuracion] ([idConfig], [tipo], [propiedad], [nombre], [valor], [descripcion], [idUsuario], [fechaCreacion], [fechaModificacion]) VALUES (N'56aee2ad-ff1e-47a0-897d-3ef3f5d80aa6', N'color', N'--TxtMenuItem', N'texto menu item', N'#0b2b34', N'Es para el texto del item del menu', N'939c9c6d-9dcf-4b7e-bea6-5c26169fa066', CAST(N'2024-02-22T07:00:00.000' AS DateTime), CAST(N'2024-03-19T15:20:59.173' AS DateTime))
GO
INSERT [dbo].[Configuracion] ([idConfig], [tipo], [propiedad], [nombre], [valor], [descripcion], [idUsuario], [fechaCreacion], [fechaModificacion]) VALUES (N'6e38ccd3-1f86-4050-b140-42c1753fb286', N'color', N'--Header', N'encabezado', N'#f1f5f8', N'Es para el encabezado (header)', N'939c9c6d-9dcf-4b7e-bea6-5c26169fa066', CAST(N'2024-02-02T07:00:00.000' AS DateTime), CAST(N'2024-03-19T15:20:59.170' AS DateTime))
GO
INSERT [dbo].[Configuracion] ([idConfig], [tipo], [propiedad], [nombre], [valor], [descripcion], [idUsuario], [fechaCreacion], [fechaModificacion]) VALUES (N'7949216f-4be1-4a7d-8531-57a2e8995ac2', N'color', N'--BotonTerciario', N'boton terciario', N'#898a8d', N'Es para el boton terciario', N'939c9c6d-9dcf-4b7e-bea6-5c26169fa066', CAST(N'2024-01-12T07:00:00.000' AS DateTime), CAST(N'2024-03-19T15:20:59.170' AS DateTime))
GO
INSERT [dbo].[Configuracion] ([idConfig], [tipo], [propiedad], [nombre], [valor], [descripcion], [idUsuario], [fechaCreacion], [fechaModificacion]) VALUES (N'8addb26a-1149-46cb-b5ae-5b93f14d7f1d', N'imagen', NULL, N'header', NULL, N'Esta es la imagen que esta en le header', N'939c9c6d-9dcf-4b7e-bea6-5c26169fa066', CAST(N'2024-03-02T07:00:00.000' AS DateTime), CAST(N'2024-03-20T10:20:48.650' AS DateTime))
GO
INSERT [dbo].[Configuracion] ([idConfig], [tipo], [propiedad], [nombre], [valor], [descripcion], [idUsuario], [fechaCreacion], [fechaModificacion]) VALUES (N'71b8c9ae-1509-4886-80b7-679368903bd7', N'view', NULL, N'registro', N'1', N'Esta es para permitir la vista de Registrarse', N'939c9c6d-9dcf-4b7e-bea6-5c26169fa066', CAST(N'2024-04-03T10:07:31.280' AS DateTime), CAST(N'2024-04-04T12:08:18.037' AS DateTime))
GO
INSERT [dbo].[Configuracion] ([idConfig], [tipo], [propiedad], [nombre], [valor], [descripcion], [idUsuario], [fechaCreacion], [fechaModificacion]) VALUES (N'0cf1e848-5bc0-42cb-8f40-6daa58c27a10', N'color', N'--TextoSecundario', N'texto secundario', N'#0b2b34', N'Es para el texto secundario', N'939c9c6d-9dcf-4b7e-bea6-5c26169fa066', CAST(N'2024-01-21T07:00:00.000' AS DateTime), CAST(N'2024-03-19T15:20:59.170' AS DateTime))
GO
INSERT [dbo].[Configuracion] ([idConfig], [tipo], [propiedad], [nombre], [valor], [descripcion], [idUsuario], [fechaCreacion], [fechaModificacion]) VALUES (N'8fdc49e5-2c82-423f-b3a9-85af544339c9', N'color', N'--Primario', N'primario', N'#f58220', N'Es para los colores primarios', N'939c9c6d-9dcf-4b7e-bea6-5c26169fa066', CAST(N'2024-01-01T07:00:00.000' AS DateTime), CAST(N'2024-03-19T15:20:59.163' AS DateTime))
GO
INSERT [dbo].[Configuracion] ([idConfig], [tipo], [propiedad], [nombre], [valor], [descripcion], [idUsuario], [fechaCreacion], [fechaModificacion]) VALUES (N'feb39de3-2a26-42f3-89d4-8a98b93586f3', N'color', N'--BotonSecundario', N'boton secundario', N'#0b2b34', N'Es para el color de los botones secundarios', N'939c9c6d-9dcf-4b7e-bea6-5c26169fa066', CAST(N'2024-01-11T07:00:00.000' AS DateTime), CAST(N'2024-03-19T15:20:59.170' AS DateTime))
GO
INSERT [dbo].[Configuracion] ([idConfig], [tipo], [propiedad], [nombre], [valor], [descripcion], [idUsuario], [fechaCreacion], [fechaModificacion]) VALUES (N'5dff0459-133f-4eaf-889a-8b2e5557184b', N'color', N'--TxtMenuItem-active', N'texto menu item active', N'#ffffff', N'Es para el texto del item del menu cuando esta en active y hover', N'939c9c6d-9dcf-4b7e-bea6-5c26169fa066', CAST(N'2024-02-23T07:00:00.000' AS DateTime), CAST(N'2024-03-19T15:20:59.173' AS DateTime))
GO
INSERT [dbo].[Configuracion] ([idConfig], [tipo], [propiedad], [nombre], [valor], [descripcion], [idUsuario], [fechaCreacion], [fechaModificacion]) VALUES (N'978e4324-f9a6-400a-989b-9930fa7b7de5', N'color', N'--TextoPrimario', N'texto primario', N'#f58220', N'Es para el texto primario', N'939c9c6d-9dcf-4b7e-bea6-5c26169fa066', CAST(N'2024-01-20T07:00:00.000' AS DateTime), CAST(N'2024-03-19T15:20:59.170' AS DateTime))
GO
INSERT [dbo].[Configuracion] ([idConfig], [tipo], [propiedad], [nombre], [valor], [descripcion], [idUsuario], [fechaCreacion], [fechaModificacion]) VALUES (N'34db8b1f-4d75-44a5-ae72-9cfe97586cf7', N'color', N'--BotonPrimario', N'boton primario', N'#f58220', N'Es para el color de los botones primarios', N'939c9c6d-9dcf-4b7e-bea6-5c26169fa066', CAST(N'2024-01-10T07:00:00.000' AS DateTime), CAST(N'2024-03-19T15:20:59.170' AS DateTime))
GO
INSERT [dbo].[Configuracion] ([idConfig], [tipo], [propiedad], [nombre], [valor], [descripcion], [idUsuario], [fechaCreacion], [fechaModificacion]) VALUES (N'5774d321-18f4-4ac6-80cc-ac092115adf9', N'color', N'--BgMenuItem-hover', N'menu item hover', N'#898a8d', N'Es para el item del menu cuando pasa el mouse por encima', N'939c9c6d-9dcf-4b7e-bea6-5c26169fa066', CAST(N'2024-02-21T07:00:00.000' AS DateTime), CAST(N'2024-03-19T15:20:59.173' AS DateTime))
GO
INSERT [dbo].[Configuracion] ([idConfig], [tipo], [propiedad], [nombre], [valor], [descripcion], [idUsuario], [fechaCreacion], [fechaModificacion]) VALUES (N'5e9f9f61-53fc-4d66-ba4f-acc638e16a89', N'color', N'--Loading2', N'carga inferior', N'#0b2b34', N'Es para la franja inferior del loading', N'939c9c6d-9dcf-4b7e-bea6-5c26169fa066', CAST(N'2024-02-11T07:00:00.000' AS DateTime), CAST(N'2024-03-19T15:20:59.173' AS DateTime))
GO
INSERT [dbo].[Configuracion] ([idConfig], [tipo], [propiedad], [nombre], [valor], [descripcion], [idUsuario], [fechaCreacion], [fechaModificacion]) VALUES (N'99971a3d-d926-4842-a59f-d7712f72b822', N'color', N'--TextoTerciario', N'texto terciario', N'#898a8d', N'Es para el texto terciario', N'939c9c6d-9dcf-4b7e-bea6-5c26169fa066', CAST(N'2024-01-22T07:00:00.000' AS DateTime), CAST(N'2024-03-19T15:20:59.170' AS DateTime))
GO
INSERT [dbo].[Configuracion] ([idConfig], [tipo], [propiedad], [nombre], [valor], [descripcion], [idUsuario], [fechaCreacion], [fechaModificacion]) VALUES (N'8d0176a4-6480-4c48-894c-d9794ee4e740', N'color', N'--Footer', N'pie de pagina', N'#898a8d', N'Es para el pie de pagina (footer)', N'939c9c6d-9dcf-4b7e-bea6-5c26169fa066', CAST(N'2024-02-03T07:00:00.000' AS DateTime), CAST(N'2024-03-19T15:20:59.170' AS DateTime))
GO
INSERT [dbo].[Configuracion] ([idConfig], [tipo], [propiedad], [nombre], [valor], [descripcion], [idUsuario], [fechaCreacion], [fechaModificacion]) VALUES (N'549a2b9e-7ec9-4dc5-902a-f2168e2bbdc8', N'llave', NULL, N'codigo de registro', N'abc-123-xyz-23', N'Este es el código para que el usuario pueda registrarse en el sitio web', N'939c9c6d-9dcf-4b7e-bea6-5c26169fa066', CAST(N'2024-03-04T07:00:00.000' AS DateTime), CAST(N'2024-04-04T12:08:18.037' AS DateTime))
GO
INSERT [dbo].[Configuracion] ([idConfig], [tipo], [propiedad], [nombre], [valor], [descripcion], [idUsuario], [fechaCreacion], [fechaModificacion]) VALUES (N'f7a0d011-57b5-4417-a8c4-f38c8dce0a20', N'color', N'--BandaSuperior', N'banda superior', N'#f58220', N'Es para la franja que esta en la parte de arriba del header', N'939c9c6d-9dcf-4b7e-bea6-5c26169fa066', CAST(N'2024-02-01T07:00:00.000' AS DateTime), CAST(N'2024-03-19T15:20:59.170' AS DateTime))
GO
INSERT [dbo].[Configuracion] ([idConfig], [tipo], [propiedad], [nombre], [valor], [descripcion], [idUsuario], [fechaCreacion], [fechaModificacion]) VALUES (N'a5eadd45-3f48-4ea9-afa5-f5fe3569f16d', N'imagen', NULL, N'iniciar sesión', NULL, N'Esta es la imagen de fondo del login', N'939c9c6d-9dcf-4b7e-bea6-5c26169fa066', CAST(N'2024-03-01T07:00:00.000' AS DateTime), CAST(N'2024-03-20T10:20:48.650' AS DateTime))
GO
INSERT [dbo].[Configuracion] ([idConfig], [tipo], [propiedad], [nombre], [valor], [descripcion], [idUsuario], [fechaCreacion], [fechaModificacion]) VALUES (N'17f228df-0bd1-4310-b35f-fdc9866c6308', N'color', N'--Secundario', N'secundario', N'#0b2b34', N'Es para los colores secundarios', N'939c9c6d-9dcf-4b7e-bea6-5c26169fa066', CAST(N'2024-01-02T07:00:00.000' AS DateTime), CAST(N'2024-03-19T15:20:59.167' AS DateTime))
GO
INSERT [dbo].[Configuracion] ([idConfig], [tipo], [propiedad], [nombre], [valor], [descripcion], [idUsuario], [fechaCreacion], [fechaModificacion]) VALUES (N'e21410f4-491b-4e5d-a639-fe5c0e70278d', N'imagen', NULL, N'footer', NULL, N'Esta es la imagen que esta en el footer', N'939c9c6d-9dcf-4b7e-bea6-5c26169fa066', CAST(N'2024-03-03T07:00:00.000' AS DateTime), CAST(N'2024-03-20T10:20:48.650' AS DateTime))
GO
INSERT [dbo].[Constants] ([nombre], [descripcion], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'exito_insert', N'Registro creado satisfactoriamente', 1, CAST(N'2023-12-05T10:49:38.620' AS DateTime), CAST(N'2023-12-05T10:49:38.620' AS DateTime))
GO
INSERT [dbo].[Constants] ([nombre], [descripcion], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'exito_delete', N'Registro eliminado satisfactoriamente', 1, CAST(N'2023-12-05T10:51:05.230' AS DateTime), CAST(N'2023-12-05T10:51:05.230' AS DateTime))
GO
INSERT [dbo].[Constants] ([nombre], [descripcion], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'exito_update', N'Registro editado satisfactoriamente', 1, CAST(N'2023-12-05T10:51:05.230' AS DateTime), CAST(N'2023-12-05T10:51:05.230' AS DateTime))
GO
INSERT [dbo].[Constants] ([nombre], [descripcion], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'encontrar', N'encontrado', 1, CAST(N'2023-12-05T12:42:01.540' AS DateTime), CAST(N'2023-12-05T12:42:01.540' AS DateTime))
GO
INSERT [dbo].[Constants] ([nombre], [descripcion], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'no_encontrar', N'no encontrado', 1, CAST(N'2023-12-05T12:42:01.540' AS DateTime), CAST(N'2023-12-05T12:42:01.540' AS DateTime))
GO
INSERT [dbo].[Constants] ([nombre], [descripcion], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'cero_filas', N'No se encontró ningun resultado', 1, CAST(N'2024-01-29T16:58:25.777' AS DateTime), CAST(N'2024-01-29T16:58:25.777' AS DateTime))
GO
INSERT [dbo].[Constants] ([nombre], [descripcion], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'no_delete', N'Registro no eliminado', 1, CAST(N'2024-02-04T13:59:52.153' AS DateTime), CAST(N'2024-02-04T13:59:52.153' AS DateTime))
GO
INSERT [dbo].[Constants] ([nombre], [descripcion], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'sin_licencias', N'El número de licencias están agotadas', 1, CAST(N'2024-04-03T15:31:39.347' AS DateTime), CAST(N'2024-04-03T15:31:39.347' AS DateTime))
GO
INSERT [dbo].[CorreoEnvio] ([idCorreo], [correo], [clave], [puerto], [host], [fechaCreacion], [fechaModificacion], [nombre]) VALUES (N'45333b41-0022-42e3-8f26-164f5d157eb1', N'06f1835853c3bb', 0x7B2243697068657254657874223A225733575636636946593544694B573131387074384A513D3D222C224956223A225974443672376434316F52644E6A556A316A633656673D3D227D, 587, N'sandbox.smtp.mailtrap.io', CAST(N'2024-04-01T15:10:41.227' AS DateTime), CAST(N'2024-07-03T09:21:22.577' AS DateTime), N'Digimentore')
GO
INSERT [dbo].[Empresa] ([idEmpresa], [nombre], [descripcion], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'8b0b70cc-9893-496c-aed9-2f5117553240', N'Agua Splendor', NULL, 1, CAST(N'2024-02-06T17:51:06.660' AS DateTime), CAST(N'2024-02-06T18:00:51.747' AS DateTime))
GO
INSERT [dbo].[Empresa] ([idEmpresa], [nombre], [descripcion], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'c99ec2bd-7c18-499c-878a-5ee9ab6fe8c7', N'Prueba ediado', N'editado desc', 1, CAST(N'2023-12-15T10:51:14.030' AS DateTime), CAST(N'2023-12-15T10:52:24.913' AS DateTime))
GO
INSERT [dbo].[Empresa] ([idEmpresa], [nombre], [descripcion], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'4e87c6cd-992a-4f14-90c8-cb7bfd4b2dba', N'Digimentore', NULL, 1, CAST(N'2023-12-14T10:14:01.260' AS DateTime), CAST(N'2023-12-14T10:14:01.260' AS DateTime))
GO
INSERT [dbo].[Empresa] ([idEmpresa], [nombre], [descripcion], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'1cb1db77-b372-43d8-9fa1-eb64fa7b9cdd', N'Dinamica Mercados', NULL, 1, CAST(N'2023-12-15T10:44:49.083' AS DateTime), CAST(N'2023-12-15T10:44:49.083' AS DateTime))
GO
INSERT [dbo].[Equipo] ([idEquipo], [nombre], [imagen], [descripcion], [estado], [fechaCreacion], [fechaModificacion], [tiempo], [puntos]) VALUES (N'114ec699-77c3-4e52-999b-0e59861f46b9', N'Equipo 1', N'ventajas-trabajo-en-equipo.jpg', NULL, 1, CAST(N'2024-04-25T10:58:06.663' AS DateTime), CAST(N'2024-04-25T10:59:18.940' AS DateTime), 0, 0)
GO
INSERT [dbo].[Equipo] ([idEquipo], [nombre], [imagen], [descripcion], [estado], [fechaCreacion], [fechaModificacion], [tiempo], [puntos]) VALUES (N'4638e1df-928a-442a-bcd8-388ad33a8829', N'Equipo 23', NULL, NULL, 1, CAST(N'2024-04-11T12:59:09.077' AS DateTime), CAST(N'2024-04-11T17:28:06.833' AS DateTime), 0, 0)
GO
INSERT [dbo].[Equipo] ([idEquipo], [nombre], [imagen], [descripcion], [estado], [fechaCreacion], [fechaModificacion], [tiempo], [puntos]) VALUES (N'281bba2c-1e7b-4d4e-a384-9e372faf895c', N'Super Campeones', NULL, N'Equipo dedicado a obtener cada medalla', 1, CAST(N'2024-06-18T15:38:58.630' AS DateTime), CAST(N'2024-06-18T17:11:23.887' AS DateTime), -13, 380)
GO
INSERT [dbo].[Inicio] ([idInicio], [nombre], [indice], [estado], [color], [idRol], [fechaCreacion], [fechaModificacion]) VALUES (N'568740a5-6764-4e15-8cbf-1618245445c1', N'Ranking por puntos', 5, 1, NULL, N'adm', CAST(N'2024-03-14T09:55:44.817' AS DateTime), CAST(N'2024-06-19T12:37:12.683' AS DateTime))
GO
INSERT [dbo].[Inicio] ([idInicio], [nombre], [indice], [estado], [color], [idRol], [fechaCreacion], [fechaModificacion]) VALUES (N'd419d4fa-eef6-4d4d-b1e8-16f7f0e76cdd', N'Puntos de experiencia', 6, 1, NULL, N'adm', CAST(N'2024-03-14T15:14:11.513' AS DateTime), CAST(N'2024-06-19T12:37:12.683' AS DateTime))
GO
INSERT [dbo].[Inicio] ([idInicio], [nombre], [indice], [estado], [color], [idRol], [fechaCreacion], [fechaModificacion]) VALUES (N'727a9ae6-b5f6-4a08-af68-1876aff92e0c', N'Usuarios más activos', 4, 1, NULL, N'adm', CAST(N'2024-04-03T17:48:45.890' AS DateTime), CAST(N'2024-06-19T12:37:12.683' AS DateTime))
GO
INSERT [dbo].[Inicio] ([idInicio], [nombre], [indice], [estado], [color], [idRol], [fechaCreacion], [fechaModificacion]) VALUES (N'65058300-b83d-4028-8732-24a978706e43', N'Retos completados', 10, 1, NULL, N'jug', CAST(N'2024-04-09T17:53:22.017' AS DateTime), CAST(N'2024-05-31T12:16:58.240' AS DateTime))
GO
INSERT [dbo].[Inicio] ([idInicio], [nombre], [indice], [estado], [color], [idRol], [fechaCreacion], [fechaModificacion]) VALUES (N'c23647f1-0975-43c7-9635-27c96899a288', N'Mis retos pendientes', 2, 1, NULL, N'jug', CAST(N'2024-04-09T17:53:22.013' AS DateTime), CAST(N'2024-05-31T12:16:58.240' AS DateTime))
GO
INSERT [dbo].[Inicio] ([idInicio], [nombre], [indice], [estado], [color], [idRol], [fechaCreacion], [fechaModificacion]) VALUES (N'03dff04a-5eec-4fbe-9432-3f4bc400cbef', N'Ranking por equipos', 8, 1, NULL, N'adm', CAST(N'2024-04-25T15:47:20.630' AS DateTime), CAST(N'2024-06-19T12:37:12.687' AS DateTime))
GO
INSERT [dbo].[Inicio] ([idInicio], [nombre], [indice], [estado], [color], [idRol], [fechaCreacion], [fechaModificacion]) VALUES (N'622bbb0e-5e21-4f80-a64c-41dff7a7ca47', N'Mis medallas', 3, 1, NULL, N'jug', CAST(N'2024-03-13T15:52:11.040' AS DateTime), CAST(N'2024-05-31T12:16:58.240' AS DateTime))
GO
INSERT [dbo].[Inicio] ([idInicio], [nombre], [indice], [estado], [color], [idRol], [fechaCreacion], [fechaModificacion]) VALUES (N'ed8f54e1-c1e6-4192-993b-48b57653d3fa', N'Usuarios más activos', 6, 1, NULL, N'jug', CAST(N'2024-04-09T17:53:22.017' AS DateTime), CAST(N'2024-05-31T12:16:58.240' AS DateTime))
GO
INSERT [dbo].[Inicio] ([idInicio], [nombre], [indice], [estado], [color], [idRol], [fechaCreacion], [fechaModificacion]) VALUES (N'3fb69c62-d3d2-46ed-bb10-54342a55bfe1', N'Noticias', 2, 1, NULL, N'adm', CAST(N'2024-03-13T16:41:09.810' AS DateTime), CAST(N'2024-06-19T12:37:12.683' AS DateTime))
GO
INSERT [dbo].[Inicio] ([idInicio], [nombre], [indice], [estado], [color], [idRol], [fechaCreacion], [fechaModificacion]) VALUES (N'ff17bf8f-837b-4247-9439-6907c11023b5', N'Resumen general', 1, 1, NULL, N'adm', CAST(N'2024-03-13T15:51:50.023' AS DateTime), CAST(N'2024-06-19T12:37:12.680' AS DateTime))
GO
INSERT [dbo].[Inicio] ([idInicio], [nombre], [indice], [estado], [color], [idRol], [fechaCreacion], [fechaModificacion]) VALUES (N'e1364975-2ef7-410d-abdc-6e991b407e18', N'Recompensas más reclamadas', 3, 1, NULL, N'adm', CAST(N'2024-03-14T09:23:21.610' AS DateTime), CAST(N'2024-06-19T12:37:12.683' AS DateTime))
GO
INSERT [dbo].[Inicio] ([idInicio], [nombre], [indice], [estado], [color], [idRol], [fechaCreacion], [fechaModificacion]) VALUES (N'e08dabb8-788a-439e-8075-75ab690d3255', N'Ranking por puntos', 5, 1, NULL, N'jug', CAST(N'2024-03-14T10:34:55.687' AS DateTime), CAST(N'2024-05-31T12:16:58.240' AS DateTime))
GO
INSERT [dbo].[Inicio] ([idInicio], [nombre], [indice], [estado], [color], [idRol], [fechaCreacion], [fechaModificacion]) VALUES (N'6d38188b-5c5b-4c6d-8cb8-806d93f5f5ab', N'Noticias', 8, 1, NULL, N'jug', CAST(N'2024-03-13T17:06:32.073' AS DateTime), CAST(N'2024-05-31T12:16:58.240' AS DateTime))
GO
INSERT [dbo].[Inicio] ([idInicio], [nombre], [indice], [estado], [color], [idRol], [fechaCreacion], [fechaModificacion]) VALUES (N'3e346378-31f6-4758-9c9a-8ab25fc61aba', N'Mi evolución', 4, 1, NULL, N'jug', CAST(N'2024-03-14T16:07:19.493' AS DateTime), CAST(N'2024-05-31T12:16:58.240' AS DateTime))
GO
INSERT [dbo].[Inicio] ([idInicio], [nombre], [indice], [estado], [color], [idRol], [fechaCreacion], [fechaModificacion]) VALUES (N'72751bda-5e5c-488e-8fd9-9f9b7a409607', N'Nivel de Experiencia', 1, 1, NULL, N'jug', CAST(N'2024-03-28T16:13:50.657' AS DateTime), CAST(N'2024-05-31T12:16:58.233' AS DateTime))
GO
INSERT [dbo].[Inicio] ([idInicio], [nombre], [indice], [estado], [color], [idRol], [fechaCreacion], [fechaModificacion]) VALUES (N'4807188d-02ce-4a4f-8a49-ca851f698b6b', N'Resumen general', 9, 1, NULL, N'jug', CAST(N'2024-03-14T17:14:37.477' AS DateTime), CAST(N'2024-05-31T12:16:58.240' AS DateTime))
GO
INSERT [dbo].[Inicio] ([idInicio], [nombre], [indice], [estado], [color], [idRol], [fechaCreacion], [fechaModificacion]) VALUES (N'10508aa0-1770-4f45-a664-d112d41d2aad', N'Retos por calificar', 11, 1, NULL, N'jug', CAST(N'2024-05-31T12:16:58.243' AS DateTime), CAST(N'2024-05-31T12:16:58.243' AS DateTime))
GO
INSERT [dbo].[Inicio] ([idInicio], [nombre], [indice], [estado], [color], [idRol], [fechaCreacion], [fechaModificacion]) VALUES (N'be6d44ba-fdea-42b9-8d83-ed03eb81742c', N'Uso del plan', 7, 1, NULL, N'adm', CAST(N'2024-04-03T17:50:45.917' AS DateTime), CAST(N'2024-06-19T12:37:12.687' AS DateTime))
GO
INSERT [dbo].[Inicio] ([idInicio], [nombre], [indice], [estado], [color], [idRol], [fechaCreacion], [fechaModificacion]) VALUES (N'5fcb6814-6f71-4e8d-b0ee-f22a08c71632', N'Ranking por equipos', 7, 1, NULL, N'jug', CAST(N'2024-04-25T15:47:14.403' AS DateTime), CAST(N'2024-05-31T12:16:58.240' AS DateTime))
GO
INSERT [dbo].[Licencia] ([idLicencia], [tabla], [nombre], [cantidadMaxima], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'f3adc302-6ab6-4657-82de-235fa5f9f891', N'Recompensa', N'Recompensas', 23, 1, CAST(N'2024-03-20T17:55:04.470' AS DateTime), CAST(N'2024-03-20T17:55:04.470' AS DateTime))
GO
INSERT [dbo].[Licencia] ([idLicencia], [tabla], [nombre], [cantidadMaxima], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'2ddf4d4d-9a87-48e8-a226-5f626e1cabfe', N'Usuario', N'Usuarios', -1, 1, CAST(N'2024-03-20T17:55:04.470' AS DateTime), CAST(N'2024-03-20T17:55:04.470' AS DateTime))
GO
INSERT [dbo].[Licencia] ([idLicencia], [tabla], [nombre], [cantidadMaxima], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'3c691921-fc60-430d-a238-bfbb0ba053a5', N'Reto', N'Retos', 50, 1, CAST(N'2024-03-20T17:55:04.470' AS DateTime), CAST(N'2024-03-20T17:55:04.470' AS DateTime))
GO
INSERT [dbo].[Medalla] ([idMedalla], [nombre], [descripcion], [imagen], [estado], [idCondicion], [fechaCreacion], [fechaModificacion], [numCondicion]) VALUES (N'2eb8768c-f1ae-49be-83e0-b04c39eb64c2', N'medalla 1', N'desc 1', NULL, 1, N'2439150e-8525-4582-8203-9d1d2ac93739', CAST(N'2023-12-12T11:58:46.920' AS DateTime), CAST(N'2024-03-20T11:40:45.200' AS DateTime), 20)
GO
INSERT [dbo].[Medalla] ([idMedalla], [nombre], [descripcion], [imagen], [estado], [idCondicion], [fechaCreacion], [fechaModificacion], [numCondicion]) VALUES (N'54c00fb9-e9d1-491c-b3bb-d9fd6307d508', N'medalla 2', N'desc 1', NULL, 1, N'5f908fdb-6b0d-4903-ad1f-76826511c8a5', CAST(N'2024-03-12T10:39:24.067' AS DateTime), CAST(N'2024-04-16T15:00:36.047' AS DateTime), 5)
GO
INSERT [dbo].[Nivel] ([idNivel], [nombre], [descripcion], [puntosNecesarios], [imagen], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'537f0f44-9d61-4c40-8aaa-0f8b88471c91', N'nivel de prueba', NULL, 33, N'level-up1.gif', 1, CAST(N'2024-04-22T15:43:10.603' AS DateTime), CAST(N'2024-04-22T15:43:10.603' AS DateTime))
GO
INSERT [dbo].[Nivel] ([idNivel], [nombre], [descripcion], [puntosNecesarios], [imagen], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'4544d5a7-2e3b-49d5-8df6-145cee2a7698', N'new level', NULL, 25, N'nivel1.png', 1, CAST(N'2024-02-01T15:48:37.110' AS DateTime), CAST(N'2024-02-01T15:48:37.110' AS DateTime))
GO
INSERT [dbo].[Nivel] ([idNivel], [nombre], [descripcion], [puntosNecesarios], [imagen], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'5690c0ba-70e1-4f3d-a0e2-2ab787446f37', N'nivel 23', NULL, 32, NULL, 1, CAST(N'2024-03-18T15:52:53.480' AS DateTime), CAST(N'2024-03-20T11:36:36.927' AS DateTime))
GO
INSERT [dbo].[Nivel] ([idNivel], [nombre], [descripcion], [puntosNecesarios], [imagen], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'cf68ecd4-fe5c-4e11-9aab-69514424fd1b', N'nivel 4', N'este es para el nivel 4', 10, NULL, 1, CAST(N'2023-12-11T16:50:33.887' AS DateTime), CAST(N'2023-12-11T16:50:33.887' AS DateTime))
GO
INSERT [dbo].[Nivel] ([idNivel], [nombre], [descripcion], [puntosNecesarios], [imagen], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'1e7e4dd1-22b4-49b6-aaa9-705d0e49a7e5', N'mi nuevo nivel', N'desc de mi nivel', 23, N'nivel4.png', 1, CAST(N'2024-02-01T15:38:43.597' AS DateTime), CAST(N'2024-02-01T15:42:12.967' AS DateTime))
GO
INSERT [dbo].[Nivel] ([idNivel], [nombre], [descripcion], [puntosNecesarios], [imagen], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'a3ae5c3c-1d90-4306-882d-a092edbd82ef', N'nivel con pos edit', N'este es para el nivel con pos edit', 22, NULL, 1, CAST(N'2024-03-10T21:15:19.780' AS DateTime), CAST(N'2024-03-10T21:54:41.543' AS DateTime))
GO
INSERT [dbo].[Nivel] ([idNivel], [nombre], [descripcion], [puntosNecesarios], [imagen], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'62629073-7cc1-4ad3-82f1-b57a823e0092', N'nivel 1', NULL, 21, NULL, 1, CAST(N'2023-12-11T16:13:01.443' AS DateTime), CAST(N'2023-12-11T16:13:01.443' AS DateTime))
GO
INSERT [dbo].[Nivel] ([idNivel], [nombre], [descripcion], [puntosNecesarios], [imagen], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'ffd99848-9d07-4cbd-93b1-b7ca5cc18452', N'next level', N'next level', 24, N'level-up.gif', 1, CAST(N'2024-02-01T15:42:37.177' AS DateTime), CAST(N'2024-04-22T15:43:29.510' AS DateTime))
GO
INSERT [dbo].[Noticia] ([idNoticia], [titular], [descripcion], [url], [imagen], [estado], [idCategoria], [fechaPublicacion], [fechaCreacion], [fechaModificacion]) VALUES (N'70114d2e-1ba0-4251-a626-1cfdfdce6a40', N'titular de prueba', N'descripcion de prueba', N'https://stackoverflow.com/questions/35359358/angular-2-change-event-on-every-keypress', NULL, 1, N'622ff0ac-4ec0-461f-8eda-f8a487f80eb3', CAST(N'2024-03-23T00:00:00.000' AS DateTime), CAST(N'2023-12-12T16:37:49.343' AS DateTime), CAST(N'2024-02-01T10:02:10.100' AS DateTime))
GO
INSERT [dbo].[Noticia] ([idNoticia], [titular], [descripcion], [url], [imagen], [estado], [idCategoria], [fechaPublicacion], [fechaCreacion], [fechaModificacion]) VALUES (N'6c8c7b7c-c3be-4dbf-9e3a-3f8b8640d0e2', N'nuevo titular', N'descripcion de prueba', NULL, NULL, 1, N'e8c4e141-d3da-4d06-9e8e-ad69ed9143bc', CAST(N'2024-03-12T00:00:00.000' AS DateTime), CAST(N'2024-03-12T16:59:50.333' AS DateTime), CAST(N'2024-03-12T16:59:50.333' AS DateTime))
GO
INSERT [dbo].[Noticia] ([idNoticia], [titular], [descripcion], [url], [imagen], [estado], [idCategoria], [fechaPublicacion], [fechaCreacion], [fechaModificacion]) VALUES (N'7cf3f854-abe0-4033-bd63-4a94dc7daf1a', N'A los enfermos de cáncer lo que nos cura es la investigación', N'Pacientes e investigadores se han encontrado hoy en un evento de la Asociación contra el Cáncer de Bizkaia. Subrayan que la lucha contra el cáncer avanza, aunque la "tarea pendiente" sigue siendo la metástasis. Es fundamental, añaden, una "financiación correcta" para poder avanzar a mejor ritmo.', N'https://www.larazon.es/salud/descubren-cura-generica-cancer-ataca-cualquier-tipo-tumor-aunque-sepa-donde-esta_20230627649ab2579d4a8300016efe1c.html', N'SPEOD72LCNEEJHXLUFH3XHGMWM.jpg', 1, N'622ff0ac-4ec0-461f-8eda-f8a487f80eb3', CAST(N'2024-03-24T00:00:00.000' AS DateTime), CAST(N'2023-12-12T15:59:53.020' AS DateTime), CAST(N'2024-04-15T16:43:48.603' AS DateTime))
GO
INSERT [dbo].[Noticia] ([idNoticia], [titular], [descripcion], [url], [imagen], [estado], [idCategoria], [fechaPublicacion], [fechaCreacion], [fechaModificacion]) VALUES (N'ff601fed-b6f1-4d8a-8c0f-a153bd7053bb', N'Elearning con IA', N'"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."', NULL, N'PlugCourseLogo.png', 1, N'622ff0ac-4ec0-461f-8eda-f8a487f80eb3', CAST(N'2024-06-19T00:00:00.000' AS DateTime), CAST(N'2024-06-19T10:14:48.760' AS DateTime), CAST(N'2024-06-19T10:36:54.387' AS DateTime))
GO
INSERT [dbo].[Notificacion] ([idNotificacion], [nombre], [estado], [msgPersonalizado], [descripcion], [numDesc], [enviarCorreo], [fechaCreacion], [fechaModificacion]) VALUES (N'69614aed-fc82-4eb0-91bd-1463cf6d75fc', N'Notificar a los usuarios cuando el reto esta por cerrarse', 0, N'prueba', N'Días restantes', 23, 1, CAST(N'2024-03-22T11:19:08.290' AS DateTime), CAST(N'2024-04-02T13:16:31.050' AS DateTime))
GO
INSERT [dbo].[Notificacion] ([idNotificacion], [nombre], [estado], [msgPersonalizado], [descripcion], [numDesc], [enviarCorreo], [fechaCreacion], [fechaModificacion]) VALUES (N'f8f1f0cd-7338-473d-b75a-2256a0924d84', N'Notificar a los usuarios cuando suben de nivel', 1, NULL, NULL, 0, 1, CAST(N'2024-03-22T11:19:08.290' AS DateTime), CAST(N'2024-06-26T10:30:36.827' AS DateTime))
GO
INSERT [dbo].[Notificacion] ([idNotificacion], [nombre], [estado], [msgPersonalizado], [descripcion], [numDesc], [enviarCorreo], [fechaCreacion], [fechaModificacion]) VALUES (N'531a630d-b453-4bd4-8fdd-35bee0a14a55', N'Notificar a los usuarios cuando se les agregaron a un reto', 1, NULL, NULL, 0, 1, CAST(N'2024-03-22T11:19:08.290' AS DateTime), CAST(N'2024-03-22T16:00:21.480' AS DateTime))
GO
INSERT [dbo].[Notificacion] ([idNotificacion], [nombre], [estado], [msgPersonalizado], [descripcion], [numDesc], [enviarCorreo], [fechaCreacion], [fechaModificacion]) VALUES (N'dd651785-32f9-431d-9883-3f475ace85aa', N'Notificar a los usuarios cuando este entre 10 primeros puestos del ranking', 0, NULL, NULL, 0, 1, CAST(N'2024-03-22T11:19:08.290' AS DateTime), CAST(N'2024-03-22T11:19:08.290' AS DateTime))
GO
INSERT [dbo].[Notificacion] ([idNotificacion], [nombre], [estado], [msgPersonalizado], [descripcion], [numDesc], [enviarCorreo], [fechaCreacion], [fechaModificacion]) VALUES (N'ce927ad8-342f-4d2b-b863-456c7756976c', N'Notificar a los usuarios cuando reciben una reacción en la red social', 1, NULL, NULL, 0, 0, CAST(N'2024-03-22T11:19:08.290' AS DateTime), CAST(N'2024-06-26T10:30:39.270' AS DateTime))
GO
INSERT [dbo].[Notificacion] ([idNotificacion], [nombre], [estado], [msgPersonalizado], [descripcion], [numDesc], [enviarCorreo], [fechaCreacion], [fechaModificacion]) VALUES (N'd31eba8e-985d-47c6-b6e0-4ea9739adc49', N'Notificar a los usuarios cuando ganan una medalla', 1, NULL, NULL, 0, 1, CAST(N'2024-03-22T11:19:08.290' AS DateTime), CAST(N'2024-06-26T10:30:41.260' AS DateTime))
GO
INSERT [dbo].[Notificacion] ([idNotificacion], [nombre], [estado], [msgPersonalizado], [descripcion], [numDesc], [enviarCorreo], [fechaCreacion], [fechaModificacion]) VALUES (N'00321384-1c44-4a73-8202-9f3cfba40582', N'Notificar a los usuarios cuando el administrador crea un nuevo usuario', 1, NULL, NULL, 0, 1, CAST(N'2024-03-22T11:19:08.290' AS DateTime), CAST(N'2024-06-26T10:30:44.457' AS DateTime))
GO
INSERT [dbo].[Notificacion] ([idNotificacion], [nombre], [estado], [msgPersonalizado], [descripcion], [numDesc], [enviarCorreo], [fechaCreacion], [fechaModificacion]) VALUES (N'1115961e-3ba2-482e-b664-a6547a4ed198', N'Notificar a los usuarios cuando canjean una recompensa', 1, N'Este es el mensaje del administrador', NULL, 0, 1, CAST(N'2024-03-22T11:19:08.290' AS DateTime), CAST(N'2024-04-23T12:35:42.497' AS DateTime))
GO
INSERT [dbo].[Novedad] ([idNovedad], [mensaje], [auxMsg], [idUsuario], [idTabla], [tabla], [estado], [fechaCreacion], [fechaModificacion], [ruta]) VALUES (N'3ad091f4-5af7-4935-80a9-0af11ca8c1f0', N'Recibiste una nueva reacción en la red social', NULL, N'ab37197c-bf33-44b8-ba5d-e246fa250b41', N'c2f763c8-19c4-4b12-9e4c-e72a3244c454', NULL, 1, CAST(N'2024-06-27T18:06:00.777' AS DateTime), CAST(N'2024-06-27T18:06:00.777' AS DateTime), N'red-social#')
GO
INSERT [dbo].[Novedad] ([idNovedad], [mensaje], [auxMsg], [idUsuario], [idTabla], [tabla], [estado], [fechaCreacion], [fechaModificacion], [ruta]) VALUES (N'fcaf5d00-e2e1-4d11-a396-0b60af83b12f', N'Te han asignado a un NUEVO RETO:', NULL, N'6d81e350-a4f4-4042-a3e9-ef97d985bc2a', N'354e8be8-3d2d-4e42-90b6-8935f7e56ef4', N'Reto', 0, CAST(N'2024-06-25T11:22:43.833' AS DateTime), CAST(N'2024-06-28T09:07:25.477' AS DateTime), N'entrada-reto?reto=')
GO
INSERT [dbo].[Novedad] ([idNovedad], [mensaje], [auxMsg], [idUsuario], [idTabla], [tabla], [estado], [fechaCreacion], [fechaModificacion], [ruta]) VALUES (N'd12f8927-a038-4798-8dd4-0dfcab6f33cd', N'Te han asignado a un NUEVO RETO:', NULL, N'42c77db8-7fd5-45cb-ab1a-eb331c7dfb61', N'0039af84-1d83-47cf-94f4-ac5b7268aa97', N'Reto', 1, CAST(N'2024-07-03T14:49:50.037' AS DateTime), CAST(N'2024-07-03T14:49:50.037' AS DateTime), N'entrada-reto?reto=')
GO
INSERT [dbo].[Novedad] ([idNovedad], [mensaje], [auxMsg], [idUsuario], [idTabla], [tabla], [estado], [fechaCreacion], [fechaModificacion], [ruta]) VALUES (N'31ef1e3a-f6dc-4de8-97ba-183583fac080', N'Subiste a un NUEVO NIVEL:', NULL, N'96a49ac1-c9c4-4bc1-8d3c-548f37f34828', N'cf68ecd4-fe5c-4e11-9aab-69514424fd1b', N'Nivel', 0, CAST(N'2024-07-03T12:01:07.730' AS DateTime), CAST(N'2024-07-03T12:03:01.887' AS DateTime), N'user-nivel#')
GO
INSERT [dbo].[Novedad] ([idNovedad], [mensaje], [auxMsg], [idUsuario], [idTabla], [tabla], [estado], [fechaCreacion], [fechaModificacion], [ruta]) VALUES (N'2fff37c4-aa57-44c7-a0b9-1cd600b7c9a2', N'Te han asignado a un NUEVO RETO:', NULL, N'6d81e350-a4f4-4042-a3e9-ef97d985bc2a', N'60713ad9-036a-4f46-8b18-30b37fa1a1c2', N'Reto', 1, CAST(N'2024-06-25T11:22:43.830' AS DateTime), CAST(N'2024-06-25T11:47:29.257' AS DateTime), N'entrada-reto?reto=')
GO
INSERT [dbo].[Novedad] ([idNovedad], [mensaje], [auxMsg], [idUsuario], [idTabla], [tabla], [estado], [fechaCreacion], [fechaModificacion], [ruta]) VALUES (N'46f3cbba-bff3-478c-b942-1ffc83b575a7', N'Te han asignado a un NUEVO RETO:', NULL, N'42c77db8-7fd5-45cb-ab1a-eb331c7dfb61', N'9f339f9d-c782-475d-9ce6-5f70058f4ab3', N'Reto', 1, CAST(N'2024-07-03T14:47:27.353' AS DateTime), CAST(N'2024-07-03T14:47:27.353' AS DateTime), N'entrada-reto?reto=')
GO
INSERT [dbo].[Novedad] ([idNovedad], [mensaje], [auxMsg], [idUsuario], [idTabla], [tabla], [estado], [fechaCreacion], [fechaModificacion], [ruta]) VALUES (N'c5299e72-913f-4489-b909-22330c52f876', N'Te han asignado a un NUEVO RETO:', NULL, N'6d81e350-a4f4-4042-a3e9-ef97d985bc2a', N'0039af84-1d83-47cf-94f4-ac5b7268aa97', N'Reto', 0, CAST(N'2024-07-03T14:49:50.040' AS DateTime), CAST(N'2024-07-03T14:56:30.717' AS DateTime), N'entrada-reto?reto=')
GO
INSERT [dbo].[Novedad] ([idNovedad], [mensaje], [auxMsg], [idUsuario], [idTabla], [tabla], [estado], [fechaCreacion], [fechaModificacion], [ruta]) VALUES (N'8bcdda4d-35e3-4a8e-a9a0-2d1c131c33c3', N'Te han asignado a un NUEVO RETO:', NULL, N'96a49ac1-c9c4-4bc1-8d3c-548f37f34828', N'39d09ca3-ddbc-4ea2-a21e-7b982d3b7628', N'Reto', 1, CAST(N'2024-07-03T13:33:20.430' AS DateTime), CAST(N'2024-07-03T13:33:20.430' AS DateTime), N'entrada-reto?reto=')
GO
INSERT [dbo].[Novedad] ([idNovedad], [mensaje], [auxMsg], [idUsuario], [idTabla], [tabla], [estado], [fechaCreacion], [fechaModificacion], [ruta]) VALUES (N'a3aa787c-0e47-4945-9b4a-2d79df4c4097', N'Te han asignado a un NUEVO RETO:', N'como validador', N'96a49ac1-c9c4-4bc1-8d3c-548f37f34828', N'1f05f1db-2c24-435e-a1eb-81fbef77e87b', N'Reto', 1, CAST(N'2024-07-03T13:21:24.933' AS DateTime), CAST(N'2024-07-03T13:21:24.933' AS DateTime), N'validaciones/users?reto=')
GO
INSERT [dbo].[Novedad] ([idNovedad], [mensaje], [auxMsg], [idUsuario], [idTabla], [tabla], [estado], [fechaCreacion], [fechaModificacion], [ruta]) VALUES (N'bbc6d452-fc22-48db-8fbb-2e1621b14d00', N'Has canjeado una NUEVA RECOMPENSA:', NULL, N'96a49ac1-c9c4-4bc1-8d3c-548f37f34828', N'91f482c6-59a5-450f-a09a-9c745b861339', N'Recompensa', 1, CAST(N'2024-07-03T13:27:03.767' AS DateTime), CAST(N'2024-07-03T13:27:03.767' AS DateTime), N'user-recompensa#')
GO
INSERT [dbo].[Novedad] ([idNovedad], [mensaje], [auxMsg], [idUsuario], [idTabla], [tabla], [estado], [fechaCreacion], [fechaModificacion], [ruta]) VALUES (N'c38edb82-3b61-48e3-a81b-3206ada05ed9', N'Recibiste una nueva reacción en la red social', NULL, N'96a49ac1-c9c4-4bc1-8d3c-548f37f34828', N'c2f763c8-19c4-4b12-9e4c-e72a3244c454', NULL, 1, CAST(N'2024-07-03T13:28:24.560' AS DateTime), CAST(N'2024-07-03T13:28:24.560' AS DateTime), N'red-social#')
GO
INSERT [dbo].[Novedad] ([idNovedad], [mensaje], [auxMsg], [idUsuario], [idTabla], [tabla], [estado], [fechaCreacion], [fechaModificacion], [ruta]) VALUES (N'884577bf-554e-4ea9-8cca-368e91d573b9', N'Te han asignado a un NUEVO RETO:', NULL, N'96a49ac1-c9c4-4bc1-8d3c-548f37f34828', N'0039af84-1d83-47cf-94f4-ac5b7268aa97', N'Reto', 1, CAST(N'2024-07-03T14:49:50.037' AS DateTime), CAST(N'2024-07-03T14:49:50.037' AS DateTime), N'entrada-reto?reto=')
GO
INSERT [dbo].[Novedad] ([idNovedad], [mensaje], [auxMsg], [idUsuario], [idTabla], [tabla], [estado], [fechaCreacion], [fechaModificacion], [ruta]) VALUES (N'c4981458-70c8-449f-a0b9-39fea464ef65', N'Te han asignado a un NUEVO RETO:', NULL, N'6d81e350-a4f4-4042-a3e9-ef97d985bc2a', N'f66e11b2-6d7e-413b-a7ce-3a1dc068cb67', N'Reto', 1, CAST(N'2024-07-03T14:43:50.067' AS DateTime), CAST(N'2024-07-03T14:43:50.067' AS DateTime), N'entrada-reto?reto=')
GO
INSERT [dbo].[Novedad] ([idNovedad], [mensaje], [auxMsg], [idUsuario], [idTabla], [tabla], [estado], [fechaCreacion], [fechaModificacion], [ruta]) VALUES (N'e9ee06c4-d02d-4c0a-b356-3aa4ed5fffce', N'Te han asignado a un NUEVO RETO:', NULL, N'6d81e350-a4f4-4042-a3e9-ef97d985bc2a', N'ad3048ea-9b72-40b3-8c56-7eb618d833d4', N'Reto', 1, CAST(N'2024-06-25T11:22:43.830' AS DateTime), CAST(N'2024-06-25T11:47:30.490' AS DateTime), N'entrada-reto?reto=')
GO
INSERT [dbo].[Novedad] ([idNovedad], [mensaje], [auxMsg], [idUsuario], [idTabla], [tabla], [estado], [fechaCreacion], [fechaModificacion], [ruta]) VALUES (N'f3b7bd4e-dbfd-4982-ad2d-4ae48a8d26cc', N'Te han asignado a un NUEVO RETO:', NULL, N'96a49ac1-c9c4-4bc1-8d3c-548f37f34828', N'354e8be8-3d2d-4e42-90b6-8935f7e56ef4', N'Reto', 1, CAST(N'2024-07-03T13:33:20.430' AS DateTime), CAST(N'2024-07-03T13:33:20.430' AS DateTime), N'entrada-reto?reto=')
GO
INSERT [dbo].[Novedad] ([idNovedad], [mensaje], [auxMsg], [idUsuario], [idTabla], [tabla], [estado], [fechaCreacion], [fechaModificacion], [ruta]) VALUES (N'4226eed8-c54e-4811-8228-4ca537298c9b', N'Te han asignado a un NUEVO RETO:', NULL, N'96a49ac1-c9c4-4bc1-8d3c-548f37f34828', N'ad3048ea-9b72-40b3-8c56-7eb618d833d4', N'Reto', 1, CAST(N'2024-07-03T13:33:20.430' AS DateTime), CAST(N'2024-07-03T13:33:20.430' AS DateTime), N'entrada-reto?reto=')
GO
INSERT [dbo].[Novedad] ([idNovedad], [mensaje], [auxMsg], [idUsuario], [idTabla], [tabla], [estado], [fechaCreacion], [fechaModificacion], [ruta]) VALUES (N'96f33199-3d20-4722-b5cf-4d64b8f2d310', N'has conseguido una NUEVA MEDALLA:', NULL, N'96a49ac1-c9c4-4bc1-8d3c-548f37f34828', N'2eb8768c-f1ae-49be-83e0-b04c39eb64c2', N'Medalla', 0, CAST(N'2024-07-03T12:00:20.577' AS DateTime), CAST(N'2024-07-03T12:02:25.623' AS DateTime), N'user-medalla#')
GO
INSERT [dbo].[Novedad] ([idNovedad], [mensaje], [auxMsg], [idUsuario], [idTabla], [tabla], [estado], [fechaCreacion], [fechaModificacion], [ruta]) VALUES (N'6c5f59ac-cd69-4cb9-b6b7-50009dd338c9', N'Te han asignado a un NUEVO RETO:', NULL, N'6d81e350-a4f4-4042-a3e9-ef97d985bc2a', N'2252397c-b7d9-42b4-b171-3a6eda0afaec', N'Reto', 0, CAST(N'2024-06-25T11:22:43.830' AS DateTime), CAST(N'2024-06-25T11:47:45.147' AS DateTime), N'entrada-reto?reto=')
GO
INSERT [dbo].[Novedad] ([idNovedad], [mensaje], [auxMsg], [idUsuario], [idTabla], [tabla], [estado], [fechaCreacion], [fechaModificacion], [ruta]) VALUES (N'f6046d07-7f72-4b0c-ae85-508b593be2d6', N'Te han asignado a un NUEVO RETO:', NULL, N'de632913-94cf-4ab1-8350-aa4c9c0b0b52', N'f66e11b2-6d7e-413b-a7ce-3a1dc068cb67', N'Reto', 1, CAST(N'2024-07-03T14:43:50.063' AS DateTime), CAST(N'2024-07-03T14:43:50.063' AS DateTime), N'entrada-reto?reto=')
GO
INSERT [dbo].[Novedad] ([idNovedad], [mensaje], [auxMsg], [idUsuario], [idTabla], [tabla], [estado], [fechaCreacion], [fechaModificacion], [ruta]) VALUES (N'30c96849-a4bc-41bf-bda1-53da5ec0f410', N'Recibiste una nueva reacción en la red social', NULL, N'ab37197c-bf33-44b8-ba5d-e246fa250b41', N'c2f763c8-19c4-4b12-9e4c-e72a3244c454', NULL, 1, CAST(N'2024-06-27T18:06:48.843' AS DateTime), CAST(N'2024-06-27T18:06:48.843' AS DateTime), N'red-social#')
GO
INSERT [dbo].[Novedad] ([idNovedad], [mensaje], [auxMsg], [idUsuario], [idTabla], [tabla], [estado], [fechaCreacion], [fechaModificacion], [ruta]) VALUES (N'b1be05fa-5e76-43f2-a01c-5f0fe0d3082e', N'Te han asignado a un NUEVO RETO:', NULL, N'6d81e350-a4f4-4042-a3e9-ef97d985bc2a', N'37cf8fee-91e0-4886-9aea-b1dcf97cbb28', N'Reto', 1, CAST(N'2024-07-03T13:32:58.633' AS DateTime), CAST(N'2024-07-03T13:32:58.633' AS DateTime), N'entrada-reto?reto=')
GO
INSERT [dbo].[Novedad] ([idNovedad], [mensaje], [auxMsg], [idUsuario], [idTabla], [tabla], [estado], [fechaCreacion], [fechaModificacion], [ruta]) VALUES (N'3ba627e4-fbaa-4c39-ad42-5ff1a49acbcc', N'Te han asignado a un NUEVO RETO:', N'como validador', N'96a49ac1-c9c4-4bc1-8d3c-548f37f34828', N'0039af84-1d83-47cf-94f4-ac5b7268aa97', N'Reto', 1, CAST(N'2024-07-03T14:49:41.240' AS DateTime), CAST(N'2024-07-03T14:49:41.240' AS DateTime), N'validaciones/users?reto=')
GO
INSERT [dbo].[Novedad] ([idNovedad], [mensaje], [auxMsg], [idUsuario], [idTabla], [tabla], [estado], [fechaCreacion], [fechaModificacion], [ruta]) VALUES (N'a1a136e4-9a3d-4099-b67a-60eeaa36b82e', N'Recibiste una nueva reacción en la red social', NULL, N'96a49ac1-c9c4-4bc1-8d3c-548f37f34828', N'0e93b64e-60c6-4485-b989-825c33becf52', NULL, 1, CAST(N'2024-07-03T13:28:19.820' AS DateTime), CAST(N'2024-07-03T13:28:19.820' AS DateTime), N'red-social#')
GO
INSERT [dbo].[Novedad] ([idNovedad], [mensaje], [auxMsg], [idUsuario], [idTabla], [tabla], [estado], [fechaCreacion], [fechaModificacion], [ruta]) VALUES (N'a6ceb308-24b9-47be-a285-6485cf901e6a', N'Te han asignado a un NUEVO RETO:', NULL, N'96a49ac1-c9c4-4bc1-8d3c-548f37f34828', N'46a95c2a-36ca-472c-8645-a8fb96bf2812', N'Reto', 0, CAST(N'2024-07-03T11:55:34.090' AS DateTime), CAST(N'2024-07-03T11:59:32.987' AS DateTime), N'entrada-reto?reto=')
GO
INSERT [dbo].[Novedad] ([idNovedad], [mensaje], [auxMsg], [idUsuario], [idTabla], [tabla], [estado], [fechaCreacion], [fechaModificacion], [ruta]) VALUES (N'f7df4b57-d3c9-4337-8f97-6bf36f7d7cb0', N'Recibiste una nueva reacción en la red social', NULL, N'ab37197c-bf33-44b8-ba5d-e246fa250b41', N'c2f763c8-19c4-4b12-9e4c-e72a3244c454', NULL, 1, CAST(N'2024-06-27T18:04:52.190' AS DateTime), CAST(N'2024-06-27T18:04:52.190' AS DateTime), N'red-social#')
GO
INSERT [dbo].[Novedad] ([idNovedad], [mensaje], [auxMsg], [idUsuario], [idTabla], [tabla], [estado], [fechaCreacion], [fechaModificacion], [ruta]) VALUES (N'2b9a9911-ff26-496c-b445-726354980062', N'Has canjeado una NUEVA RECOMPENSA:', NULL, N'96a49ac1-c9c4-4bc1-8d3c-548f37f34828', N'2517e519-acf6-42d4-90a7-df589bff4987', N'Recompensa', 0, CAST(N'2024-07-03T12:18:20.923' AS DateTime), CAST(N'2024-07-03T12:18:56.623' AS DateTime), N'user-recompensa#')
GO
INSERT [dbo].[Novedad] ([idNovedad], [mensaje], [auxMsg], [idUsuario], [idTabla], [tabla], [estado], [fechaCreacion], [fechaModificacion], [ruta]) VALUES (N'98573397-bdbf-4dfc-a38e-7420c58f33ef', N'Te han asignado a un NUEVO RETO:', NULL, N'de632913-94cf-4ab1-8350-aa4c9c0b0b52', N'0039af84-1d83-47cf-94f4-ac5b7268aa97', N'Reto', 1, CAST(N'2024-07-03T14:49:50.037' AS DateTime), CAST(N'2024-07-03T14:49:50.037' AS DateTime), N'entrada-reto?reto=')
GO
INSERT [dbo].[Novedad] ([idNovedad], [mensaje], [auxMsg], [idUsuario], [idTabla], [tabla], [estado], [fechaCreacion], [fechaModificacion], [ruta]) VALUES (N'fac59968-3bcd-44b4-9e83-74f58336ac42', N'Te han asignado a un NUEVO RETO:', NULL, N'96a49ac1-c9c4-4bc1-8d3c-548f37f34828', N'9f339f9d-c782-475d-9ce6-5f70058f4ab3', N'Reto', 0, CAST(N'2024-07-03T14:47:27.353' AS DateTime), CAST(N'2024-07-03T14:48:04.927' AS DateTime), N'entrada-reto?reto=')
GO
INSERT [dbo].[Novedad] ([idNovedad], [mensaje], [auxMsg], [idUsuario], [idTabla], [tabla], [estado], [fechaCreacion], [fechaModificacion], [ruta]) VALUES (N'abec4506-0937-48bc-8e89-757cc8249c68', N'Te han asignado a un NUEVO RETO:', NULL, N'de632913-94cf-4ab1-8350-aa4c9c0b0b52', N'37cf8fee-91e0-4886-9aea-b1dcf97cbb28', N'Reto', 1, CAST(N'2024-07-03T13:32:58.630' AS DateTime), CAST(N'2024-07-03T13:32:58.630' AS DateTime), N'entrada-reto?reto=')
GO
INSERT [dbo].[Novedad] ([idNovedad], [mensaje], [auxMsg], [idUsuario], [idTabla], [tabla], [estado], [fechaCreacion], [fechaModificacion], [ruta]) VALUES (N'1a7e8f89-8d32-4e9d-9d94-763266ff5f41', N'Te han asignado a un NUEVO RETO:', NULL, N'de632913-94cf-4ab1-8350-aa4c9c0b0b52', N'9f339f9d-c782-475d-9ce6-5f70058f4ab3', N'Reto', 1, CAST(N'2024-07-03T14:47:27.350' AS DateTime), CAST(N'2024-07-03T14:47:27.350' AS DateTime), N'entrada-reto?reto=')
GO
INSERT [dbo].[Novedad] ([idNovedad], [mensaje], [auxMsg], [idUsuario], [idTabla], [tabla], [estado], [fechaCreacion], [fechaModificacion], [ruta]) VALUES (N'c6a87a07-c5e9-4bcd-8753-7ac09a08b1ef', N'Te han asignado a un NUEVO RETO:', N'como validador', N'96a49ac1-c9c4-4bc1-8d3c-548f37f34828', N'9f339f9d-c782-475d-9ce6-5f70058f4ab3', N'Reto', 1, CAST(N'2024-07-03T14:47:02.693' AS DateTime), CAST(N'2024-07-03T14:47:02.693' AS DateTime), N'validaciones/users?reto=')
GO
INSERT [dbo].[Novedad] ([idNovedad], [mensaje], [auxMsg], [idUsuario], [idTabla], [tabla], [estado], [fechaCreacion], [fechaModificacion], [ruta]) VALUES (N'f745554a-192b-4102-a83d-7b7f139a7258', N'has conseguido una NUEVA MEDALLA:', NULL, N'96a49ac1-c9c4-4bc1-8d3c-548f37f34828', N'54c00fb9-e9d1-491c-b3bb-d9fd6307d508', N'Medalla', 0, CAST(N'2024-07-03T13:36:16.033' AS DateTime), CAST(N'2024-07-03T13:40:37.853' AS DateTime), N'user-medalla#')
GO
INSERT [dbo].[Novedad] ([idNovedad], [mensaje], [auxMsg], [idUsuario], [idTabla], [tabla], [estado], [fechaCreacion], [fechaModificacion], [ruta]) VALUES (N'e9dfd66e-484f-4dfe-8d1c-80fa3dd7e2d1', N'Bienvenido a Play Move', NULL, N'de95894e-8253-410e-90a7-79458bea72a7', N'de95894e-8253-410e-90a7-79458bea72a7', N'Usuario', 0, CAST(N'2024-07-02T18:10:48.897' AS DateTime), CAST(N'2024-07-02T18:14:11.660' AS DateTime), NULL)
GO
INSERT [dbo].[Novedad] ([idNovedad], [mensaje], [auxMsg], [idUsuario], [idTabla], [tabla], [estado], [fechaCreacion], [fechaModificacion], [ruta]) VALUES (N'ad0bf6ce-05a8-4708-ab4d-8240af6df11e', N'Bienvenido a Play Move', N'completa retos para conseguir puntos y recompensas', N'97403188-7343-4fed-a873-9a041a4d9e01', N'97403188-7343-4fed-a873-9a041a4d9e01', N'Usuario', 1, CAST(N'2024-07-03T11:01:36.473' AS DateTime), CAST(N'2024-07-03T11:01:36.473' AS DateTime), NULL)
GO
INSERT [dbo].[Novedad] ([idNovedad], [mensaje], [auxMsg], [idUsuario], [idTabla], [tabla], [estado], [fechaCreacion], [fechaModificacion], [ruta]) VALUES (N'1f705382-c8ea-4310-b262-849612963909', N'Te han asignado a un NUEVO RETO:', NULL, N'6d81e350-a4f4-4042-a3e9-ef97d985bc2a', N'9f339f9d-c782-475d-9ce6-5f70058f4ab3', N'Reto', 1, CAST(N'2024-07-03T14:47:27.353' AS DateTime), CAST(N'2024-07-03T14:47:27.353' AS DateTime), N'entrada-reto?reto=')
GO
INSERT [dbo].[Novedad] ([idNovedad], [mensaje], [auxMsg], [idUsuario], [idTabla], [tabla], [estado], [fechaCreacion], [fechaModificacion], [ruta]) VALUES (N'9bd8da93-c2e3-4387-a9ef-8f01f00a5069', N'Te han asignado a un NUEVO RETO:', NULL, N'96a49ac1-c9c4-4bc1-8d3c-548f37f34828', N'60713ad9-036a-4f46-8b18-30b37fa1a1c2', N'Reto', 1, CAST(N'2024-07-03T13:33:20.427' AS DateTime), CAST(N'2024-07-03T13:33:20.427' AS DateTime), N'entrada-reto?reto=')
GO
INSERT [dbo].[Novedad] ([idNovedad], [mensaje], [auxMsg], [idUsuario], [idTabla], [tabla], [estado], [fechaCreacion], [fechaModificacion], [ruta]) VALUES (N'9c4b0f96-62cd-4b41-80ad-931bf51660c7', N'Recibiste una nueva reacción en la red social', NULL, N'ab37197c-bf33-44b8-ba5d-e246fa250b41', N'c2f763c8-19c4-4b12-9e4c-e72a3244c454', NULL, 1, CAST(N'2024-06-27T18:06:43.310' AS DateTime), CAST(N'2024-06-27T18:06:43.310' AS DateTime), N'red-social#')
GO
INSERT [dbo].[Novedad] ([idNovedad], [mensaje], [auxMsg], [idUsuario], [idTabla], [tabla], [estado], [fechaCreacion], [fechaModificacion], [ruta]) VALUES (N'fbc8c260-94cf-42fd-8654-93bad7c8b853', N'Recibiste una nueva reacción en la red social', NULL, N'ab37197c-bf33-44b8-ba5d-e246fa250b41', N'c2f763c8-19c4-4b12-9e4c-e72a3244c454', NULL, 1, CAST(N'2024-06-27T18:05:04.837' AS DateTime), CAST(N'2024-06-27T18:05:04.837' AS DateTime), N'red-social#')
GO
INSERT [dbo].[Novedad] ([idNovedad], [mensaje], [auxMsg], [idUsuario], [idTabla], [tabla], [estado], [fechaCreacion], [fechaModificacion], [ruta]) VALUES (N'24723d19-c6af-45c2-a0f4-956abe563001', N'Bienvenido a Play Move', N'completa retos para conseguir puntos y recompensas', N'763ece31-66cd-4203-ae52-938efdd4408f', N'763ece31-66cd-4203-ae52-938efdd4408f', N'Usuario', 1, CAST(N'2024-07-03T11:01:36.473' AS DateTime), CAST(N'2024-07-03T11:01:36.473' AS DateTime), NULL)
GO
INSERT [dbo].[Novedad] ([idNovedad], [mensaje], [auxMsg], [idUsuario], [idTabla], [tabla], [estado], [fechaCreacion], [fechaModificacion], [ruta]) VALUES (N'1f4c1b4c-e5ac-4644-879b-9dedd6d47e58', N'Te han asignado a un NUEVO RETO:', NULL, N'42c77db8-7fd5-45cb-ab1a-eb331c7dfb61', N'f66e11b2-6d7e-413b-a7ce-3a1dc068cb67', N'Reto', 1, CAST(N'2024-07-03T14:43:50.067' AS DateTime), CAST(N'2024-07-03T14:43:50.067' AS DateTime), N'entrada-reto?reto=')
GO
INSERT [dbo].[Novedad] ([idNovedad], [mensaje], [auxMsg], [idUsuario], [idTabla], [tabla], [estado], [fechaCreacion], [fechaModificacion], [ruta]) VALUES (N'20be654c-6019-4ed3-b415-a3908d10faa2', N'Te han asignado a un NUEVO RETO:', NULL, N'96a49ac1-c9c4-4bc1-8d3c-548f37f34828', N'37cf8fee-91e0-4886-9aea-b1dcf97cbb28', N'Reto', 0, CAST(N'2024-07-03T13:33:20.430' AS DateTime), CAST(N'2024-07-03T13:35:39.530' AS DateTime), N'entrada-reto?reto=')
GO
INSERT [dbo].[Novedad] ([idNovedad], [mensaje], [auxMsg], [idUsuario], [idTabla], [tabla], [estado], [fechaCreacion], [fechaModificacion], [ruta]) VALUES (N'3785fd10-01cb-47d4-a64c-b075ffcf79e5', N'Recibiste una nueva reacción en la red social', NULL, N'939c9c6d-9dcf-4b7e-bea6-5c26169fa066', N'c2f763c8-19c4-4b12-9e4c-e72a3244c454', NULL, 1, CAST(N'2024-06-28T14:19:38.577' AS DateTime), CAST(N'2024-06-28T14:19:38.577' AS DateTime), N'red-social#')
GO
INSERT [dbo].[Novedad] ([idNovedad], [mensaje], [auxMsg], [idUsuario], [idTabla], [tabla], [estado], [fechaCreacion], [fechaModificacion], [ruta]) VALUES (N'791d886e-ce26-4085-8000-c5a00579c28e', N'Recibiste una nueva reacción en la red social', NULL, N'96a49ac1-c9c4-4bc1-8d3c-548f37f34828', N'0e93b64e-60c6-4485-b989-825c33becf52', NULL, 1, CAST(N'2024-07-03T13:28:00.203' AS DateTime), CAST(N'2024-07-03T13:28:00.203' AS DateTime), N'red-social#')
GO
INSERT [dbo].[Novedad] ([idNovedad], [mensaje], [auxMsg], [idUsuario], [idTabla], [tabla], [estado], [fechaCreacion], [fechaModificacion], [ruta]) VALUES (N'363a4436-fe23-4e34-a750-c7115a38f7b7', N'Recibiste una nueva reacción en la red social', NULL, N'96a49ac1-c9c4-4bc1-8d3c-548f37f34828', N'0e93b64e-60c6-4485-b989-825c33becf52', NULL, 1, CAST(N'2024-07-03T13:28:05.933' AS DateTime), CAST(N'2024-07-03T13:28:05.933' AS DateTime), N'red-social#')
GO
INSERT [dbo].[Novedad] ([idNovedad], [mensaje], [auxMsg], [idUsuario], [idTabla], [tabla], [estado], [fechaCreacion], [fechaModificacion], [ruta]) VALUES (N'92b8f9e6-d7e8-4269-875a-cccf02daf8ae', N'Te han asignado a un NUEVO RETO:', NULL, N'42c77db8-7fd5-45cb-ab1a-eb331c7dfb61', N'37cf8fee-91e0-4886-9aea-b1dcf97cbb28', N'Reto', 1, CAST(N'2024-07-03T13:32:58.633' AS DateTime), CAST(N'2024-07-03T13:32:58.633' AS DateTime), N'entrada-reto?reto=')
GO
INSERT [dbo].[Novedad] ([idNovedad], [mensaje], [auxMsg], [idUsuario], [idTabla], [tabla], [estado], [fechaCreacion], [fechaModificacion], [ruta]) VALUES (N'bbac4875-ae2e-4bc7-96ea-d06eda7a0ade', N'Te han asignado a un NUEVO RETO:', NULL, N'96a49ac1-c9c4-4bc1-8d3c-548f37f34828', N'ef9c1644-f977-43e0-b47c-06699fc22d5d', N'Reto', 0, CAST(N'2024-07-03T12:23:50.533' AS DateTime), CAST(N'2024-07-03T12:24:10.603' AS DateTime), N'entrada-reto?reto=')
GO
INSERT [dbo].[Novedad] ([idNovedad], [mensaje], [auxMsg], [idUsuario], [idTabla], [tabla], [estado], [fechaCreacion], [fechaModificacion], [ruta]) VALUES (N'198dc089-3131-4735-b1e3-d2c2db17ecbe', N'Te han asignado a un NUEVO RETO:', NULL, N'96a49ac1-c9c4-4bc1-8d3c-548f37f34828', N'1f05f1db-2c24-435e-a1eb-81fbef77e87b', N'Reto', 0, CAST(N'2024-07-03T13:22:44.860' AS DateTime), CAST(N'2024-07-03T13:23:22.967' AS DateTime), N'entrada-reto?reto=')
GO
INSERT [dbo].[Novedad] ([idNovedad], [mensaje], [auxMsg], [idUsuario], [idTabla], [tabla], [estado], [fechaCreacion], [fechaModificacion], [ruta]) VALUES (N'a8b3d719-c0dc-49dc-9969-d80a9903c14e', N'Te han asignado a un NUEVO RETO:', NULL, N'015e40dd-58ce-401e-a0a9-075874bc0b68', N'701e4b94-1e54-4de4-9128-239ded5eaa06', N'Reto', 1, CAST(N'2024-06-20T16:09:17.263' AS DateTime), CAST(N'2024-06-20T16:09:17.263' AS DateTime), N'entrada-reto?reto=')
GO
INSERT [dbo].[Novedad] ([idNovedad], [mensaje], [auxMsg], [idUsuario], [idTabla], [tabla], [estado], [fechaCreacion], [fechaModificacion], [ruta]) VALUES (N'59e39d64-7f66-4cbc-8b07-df7566334038', N'Te han asignado a un NUEVO RETO:', NULL, N'96a49ac1-c9c4-4bc1-8d3c-548f37f34828', N'f66e11b2-6d7e-413b-a7ce-3a1dc068cb67', N'Reto', 1, CAST(N'2024-07-03T14:43:50.067' AS DateTime), CAST(N'2024-07-03T14:43:50.067' AS DateTime), N'entrada-reto?reto=')
GO
INSERT [dbo].[Novedad] ([idNovedad], [mensaje], [auxMsg], [idUsuario], [idTabla], [tabla], [estado], [fechaCreacion], [fechaModificacion], [ruta]) VALUES (N'a81d44a2-d63e-4b0b-9f63-e390ce1aac58', N'Bienvenido a Play Move', N'completa retos para conseguir puntos y recompensas', N'ff546529-1904-425d-be28-7204eac38013', N'ff546529-1904-425d-be28-7204eac38013', N'Usuario', 1, CAST(N'2024-07-03T11:01:36.470' AS DateTime), CAST(N'2024-07-03T11:01:36.470' AS DateTime), NULL)
GO
INSERT [dbo].[Novedad] ([idNovedad], [mensaje], [auxMsg], [idUsuario], [idTabla], [tabla], [estado], [fechaCreacion], [fechaModificacion], [ruta]) VALUES (N'5e16e0b4-99b3-4750-afcc-e7bcd0ee7ed1', N'Te han asignado a un NUEVO RETO:', NULL, N'6d81e350-a4f4-4042-a3e9-ef97d985bc2a', N'39d09ca3-ddbc-4ea2-a21e-7b982d3b7628', N'Reto', 0, CAST(N'2024-06-25T11:22:43.830' AS DateTime), CAST(N'2024-06-25T11:46:17.020' AS DateTime), N'entrada-reto?reto=')
GO
INSERT [dbo].[Novedad] ([idNovedad], [mensaje], [auxMsg], [idUsuario], [idTabla], [tabla], [estado], [fechaCreacion], [fechaModificacion], [ruta]) VALUES (N'539e55c3-d403-40bb-9384-f58a36373b2f', N'Recibiste una nueva reacción en la red social', NULL, N'96a49ac1-c9c4-4bc1-8d3c-548f37f34828', N'0e93b64e-60c6-4485-b989-825c33becf52', NULL, 1, CAST(N'2024-07-03T13:28:15.790' AS DateTime), CAST(N'2024-07-03T13:28:15.790' AS DateTime), N'red-social#')
GO
INSERT [dbo].[Novedad] ([idNovedad], [mensaje], [auxMsg], [idUsuario], [idTabla], [tabla], [estado], [fechaCreacion], [fechaModificacion], [ruta]) VALUES (N'6d9f2ecf-e86a-4fea-b6ab-f69222f6317d', N'Te han asignado a un NUEVO RETO:', NULL, N'96a49ac1-c9c4-4bc1-8d3c-548f37f34828', N'6e504c05-c240-4a9a-931e-b3ad7e452333', N'Reto', 0, CAST(N'2024-07-03T11:35:23.280' AS DateTime), CAST(N'2024-07-03T13:16:58.720' AS DateTime), N'entrada-reto?reto=')
GO
INSERT [dbo].[Novedad] ([idNovedad], [mensaje], [auxMsg], [idUsuario], [idTabla], [tabla], [estado], [fechaCreacion], [fechaModificacion], [ruta]) VALUES (N'c92390db-d4eb-4bb9-af0c-fb3e64d876ff', N'Te han asignado a un NUEVO RETO:', NULL, N'96a49ac1-c9c4-4bc1-8d3c-548f37f34828', N'2252397c-b7d9-42b4-b171-3a6eda0afaec', N'Reto', 0, CAST(N'2024-07-03T13:33:20.427' AS DateTime), CAST(N'2024-07-03T13:35:04.770' AS DateTime), N'entrada-reto?reto=')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'4042172a-efff-419f-a638-001cf66d69ce', N'Espacios públicos', 0, 1, N'af15ba63-8426-43d9-ba74-e855cde8b47d', CAST(N'2024-05-17T11:36:59.167' AS DateTime), CAST(N'2024-05-17T11:36:59.167' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'd1b4eb57-fd7e-4723-b930-0093bd08e5ba', N'Neutral', 0, 1, N'0df5898c-37bb-49e9-b288-3888bafd62f4', CAST(N'2024-07-03T14:43:33.877' AS DateTime), CAST(N'2024-07-03T14:43:33.877' AS DateTime), 3, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'b67e23f5-0820-4943-9459-00adfba9d0cd', N'Rara Vez', 0, 1, N'c3d05caf-4623-4fdd-9097-e4a289cd87b8', CAST(N'2024-06-19T12:11:10.673' AS DateTime), CAST(N'2024-06-19T12:11:10.673' AS DateTime), 2, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'8c483688-a95a-4e0a-abd4-014103f6fad8', N'Húmero', 0, 1, N'cb0edcd3-1843-49d0-b98f-d1894a876054', CAST(N'2024-05-14T17:15:37.357' AS DateTime), CAST(N'2024-05-14T17:15:37.357' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'b47d57af-9556-4304-8cbf-016c39b5bdda', N'Ciencia ficción', 0, 1, N'6122e532-6296-4b7f-b2cf-a91b1e1ce8a2', CAST(N'2024-05-17T11:36:59.207' AS DateTime), CAST(N'2024-05-17T11:36:59.207' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'694ce796-49a3-4e20-9417-01731151ca64', N'Rara Vez', 0, 1, N'5bfc42e7-4c0e-43af-83e8-8721e3a6d8df', CAST(N'2024-06-12T17:32:03.223' AS DateTime), CAST(N'2024-06-12T17:32:03.223' AS DateTime), 2, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'cb265b05-dbf3-4ac1-b4eb-019b95fa78f4', N'George Washington', 1, 1, N'd0e024f3-e436-4f39-aa16-9ec0d638b825', CAST(N'2024-05-18T20:06:22.273' AS DateTime), CAST(N'2024-05-18T20:06:22.273' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'099014ec-ff21-42c2-b29f-02b0a9143c8a', N'Aluminio', 1, 1, N'f8499c7e-6912-4b18-8819-ccbdbe4bfb94', CAST(N'2024-05-14T17:15:37.353' AS DateTime), CAST(N'2024-05-14T17:15:37.353' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'618427b4-d067-474e-a138-035a255df862', N'Frecuentemente', 0, 1, N'a924c254-6554-4b24-8fae-47163f0ebb93', CAST(N'2024-06-18T15:58:50.340' AS DateTime), CAST(N'2024-06-18T15:58:50.340' AS DateTime), 4, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'3fd6d859-99db-408e-93df-036e0c71679a', N'Victor Hugo', 0, 1, N'a418389d-a1a4-49d5-94e2-b8f4dc813982', CAST(N'2024-05-14T17:15:37.343' AS DateTime), CAST(N'2024-05-14T17:15:37.343' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'8bdc6ee8-3fd4-4934-be80-03980087545c', N'Urano', 0, 1, N'697a8471-4b6a-4422-b4e7-a1c8de4d72c7', CAST(N'2024-05-18T20:06:22.287' AS DateTime), CAST(N'2024-05-18T20:06:22.287' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'e192c6cb-b354-40aa-bbed-044c8422bba3', N'Jules Verne', 0, 1, N'44f97be2-194e-40cc-9d42-9ebfd8a3aaad', CAST(N'2024-05-06T15:19:40.160' AS DateTime), CAST(N'2024-05-06T15:19:40.160' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'26e962a2-acf7-47b4-ad52-04a469a57248', N'De acuerdo', 0, 1, N'943e4c32-92d1-484c-840f-27f1f22a00d7', CAST(N'2024-07-03T14:43:33.890' AS DateTime), CAST(N'2024-07-03T14:43:33.890' AS DateTime), 4, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'25bfd343-1a78-4769-beb4-05398c09e591', N'Montaña K2', 0, 1, N'f48a82eb-8845-4172-b53d-b3cd42ffa07e', CAST(N'2024-05-06T15:19:40.157' AS DateTime), CAST(N'2024-05-06T15:19:40.157' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'8127506a-fce3-4b61-a107-056f0cf557f6', N'Ejemplo Opcion 1', 0, 1, N'2f722edf-8c3b-4682-8abf-c8305c2d18ca', CAST(N'2024-06-18T17:48:28.853' AS DateTime), CAST(N'2024-06-18T17:48:28.853' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'e1f11bcd-781c-4e07-8e12-05deea47c074', N'1939', 0, 1, N'52efe634-e59c-463c-9599-e88f9955094c', CAST(N'2024-05-06T15:19:40.167' AS DateTime), CAST(N'2024-05-06T15:19:40.167' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'8e7741f0-815f-492a-929e-06ebc9421c1a', N'Frecuentemente', 0, 1, N'4b64542b-5941-4b53-935f-8269262a93d4', CAST(N'2024-07-03T13:22:31.030' AS DateTime), CAST(N'2024-07-03T13:22:31.030' AS DateTime), 4, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'8aec6f36-1257-42ed-baa5-070ef93f3c50', N'Yuri Gagarin', 1, 1, N'c29f1d5d-90db-41ff-ba8b-8c2cd25354e0', CAST(N'2024-05-14T17:15:37.350' AS DateTime), CAST(N'2024-05-14T17:15:37.350' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'2d591a61-9601-4a30-8abb-077a09a75c49', N'Blues', 0, 1, N'253efaf1-4751-416d-aebd-3f82ca9ecc86', CAST(N'2024-05-17T11:36:59.193' AS DateTime), CAST(N'2024-05-17T11:36:59.193' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'e697fbcd-c822-4ec0-9d75-083b2231e47f', N'Siempre', 0, 1, N'b8e7022f-cecd-458f-b5b2-352e7ad04b32', CAST(N'2024-07-03T13:22:31.027' AS DateTime), CAST(N'2024-07-03T13:22:31.027' AS DateTime), 5, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'58f8ddc3-4d63-4fbd-836c-0878dc833ff0', N'Tibia', 0, 1, N'70cc4b45-c763-4e54-9728-98738a0e57ca', CAST(N'2024-05-18T20:06:22.283' AS DateTime), CAST(N'2024-05-18T20:06:22.283' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'43dff10c-d746-49da-b9f3-088fafb26683', N'a', 1, 1, N'8b8c5642-1e5a-4cd9-a6c0-899eb7c30192', CAST(N'2024-06-18T16:41:06.653' AS DateTime), CAST(N'2024-06-18T16:41:06.653' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'2da26739-1acc-43d9-8f28-097586e41764', N'Ejemplo Opcion 1', 0, 1, N'f5535438-f8f2-441d-b3ce-266d618d8301', CAST(N'2024-07-03T13:32:40.003' AS DateTime), CAST(N'2024-07-03T13:32:40.003' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'dc16199c-b1ab-457d-890d-098337fb9415', N'Ejemplo Opcion 3', 0, 1, N'e20687bd-bdd9-4edf-8bf4-8caa5cb8d616', CAST(N'2024-07-03T13:32:39.997' AS DateTime), CAST(N'2024-07-03T13:32:39.997' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'06153a37-ac3f-4fe9-b6a9-09daf0f8599f', N'Ejemplo Opcion 3', 0, 1, N'9d6aa9f8-e6a9-4dd9-ade8-d0e2d0e53309', CAST(N'2024-06-18T17:48:28.873' AS DateTime), CAST(N'2024-06-18T17:48:28.873' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'327bb237-a749-441d-bbce-0a61003e063d', N'Ejemplo Opcion 3', 0, 1, N'812b0e64-0b5e-4742-a260-a5eb8b09d89f', CAST(N'2024-07-03T12:23:31.020' AS DateTime), CAST(N'2024-07-03T12:23:31.020' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'824f27c0-71a6-41df-9ae3-0be1c27a9db5', N'prueba op 3', 0, 1, N'828020ba-8f8c-4650-9fe0-7e44cd9f8088', CAST(N'2024-05-17T14:55:06.967' AS DateTime), CAST(N'2024-05-17T14:55:06.967' AS DateTime), 0, N'1e2e9f6c-4c7f-4142-8317-c398db956764')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'f0cd7bd8-4baa-4d95-a824-0bfdf9a1f359', N'Vino', 0, 1, N'331bea1d-cf31-4085-bda8-fc1544356c4d', CAST(N'2024-05-17T11:36:59.223' AS DateTime), CAST(N'2024-05-17T11:36:59.223' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'ed527bee-0647-4a93-90b8-0c0aa2e1135a', N'Ejemplo Opcion 6', 0, 1, N'f5535438-f8f2-441d-b3ce-266d618d8301', CAST(N'2024-07-03T13:32:40.007' AS DateTime), CAST(N'2024-07-03T13:32:40.007' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'aa4c77f5-24c3-493c-80f5-0c205822aa0b', N'Cuando terminó la segunda guerra mundial', 0, 1, N'ee2e1db9-86c6-4da4-b2ed-4ed9626b4ea4', CAST(N'2024-05-21T12:25:25.553' AS DateTime), CAST(N'2024-05-21T12:25:25.553' AS DateTime), 0, N'1e2e9f6c-4c7f-4142-8317-c398db956764')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'02eb1c2a-04c1-4b7b-a8ef-0c2b2c67556e', N'Vladivostok', 0, 1, N'588e2705-8a7d-417d-977d-61fcd1e38863', CAST(N'2024-05-14T17:15:37.370' AS DateTime), CAST(N'2024-05-14T17:15:37.370' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'31f4184e-ab45-4f35-b79b-0c9553aec254', N'mi opcion 3', 0, 1, N'b7a37232-4eb1-4ac4-bc7b-d9396a96000f', CAST(N'2024-05-13T12:56:22.243' AS DateTime), CAST(N'2024-05-13T12:56:22.243' AS DateTime), 4, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'70f43f40-7e60-4780-bb27-0ccb74723b75', N'H2O', 1, 1, N'34922354-8289-4138-ba76-f014216ab8fa', CAST(N'2024-05-14T17:15:37.377' AS DateTime), CAST(N'2024-05-14T17:15:37.377' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'84cc3c51-4f2f-46a2-bcb6-0ceaa294709f', N'Ejemplo Opcion 3', 0, 1, N'9a431a9c-1aaa-4616-8b4b-bbf6c34082de', CAST(N'2024-06-18T17:48:28.860' AS DateTime), CAST(N'2024-06-18T17:48:28.860' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'fb03306d-778d-45ec-99ff-0cf21f7f8dab', N'Fútbol', 0, 1, N'd34fb3e9-1be1-41bd-b542-957a78db78b7', CAST(N'2024-05-17T11:36:59.193' AS DateTime), CAST(N'2024-05-17T11:36:59.193' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'c4840360-6d1e-409d-ba27-0cf8f2bf95b3', N'En desacuerdo', 0, 1, N'74dbbef1-3d7b-4c36-aaf5-f459715311b0', CAST(N'2024-06-19T11:51:12.150' AS DateTime), CAST(N'2024-06-19T11:51:12.150' AS DateTime), 2, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'312aa1e3-045d-48b3-9ca6-0cfa5c5907c3', N'Ingrese sus nombres o apodos completos', 0, 1, N'ee2e1db9-86c6-4da4-b2ed-4ed9626b4ea4', CAST(N'2024-05-21T12:25:25.557' AS DateTime), CAST(N'2024-05-21T12:25:25.557' AS DateTime), 0, N'bfef5abf-cff4-460b-a3af-55630d81066a')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'5755013d-cd03-41e6-ad83-0dcb83583e77', N'Magnesio', 0, 1, N'10ccc4aa-9bef-4015-89bf-106ac005fb2b', CAST(N'2024-05-18T20:06:22.297' AS DateTime), CAST(N'2024-05-18T20:06:22.297' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'8f422900-4874-4e70-a2db-0ddc1bfd9d8b', N'Interfaz de programación de aplicaciones', 0, 1, N'43c4c9c4-b885-4bc4-83cb-1e3a257c3530', CAST(N'2024-02-27T16:55:53.443' AS DateTime), CAST(N'2024-02-27T16:55:53.443' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'416150b5-ad1d-42cd-a3ea-0df21438c447', N'Leonardo da Vinci', 1, 1, N'17f78458-362d-4b64-b1ef-1c2a868733f9', CAST(N'2024-05-14T17:15:37.333' AS DateTime), CAST(N'2024-05-14T17:15:37.333' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'37a1d339-b3d5-4ac4-95b6-0e2702fed4c8', N'Ejemplo Opcion 2', 0, 1, N'e20687bd-bdd9-4edf-8bf4-8caa5cb8d616', CAST(N'2024-07-03T13:32:39.997' AS DateTime), CAST(N'2024-07-03T13:32:39.997' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'2e3e4037-919a-4859-990e-0e78445845a0', N'Animación', 0, 1, N'6122e532-6296-4b7f-b2cf-a91b1e1ce8a2', CAST(N'2024-05-17T11:36:59.210' AS DateTime), CAST(N'2024-05-17T11:36:59.210' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'bcece1db-dbde-4fc1-a5ee-0edb74ab924d', N'opcionC', 0, 1, N'176464f5-9c08-422e-8fa2-eeba91ad54b7', CAST(N'2024-06-19T09:57:32.910' AS DateTime), CAST(N'2024-06-19T09:57:32.910' AS DateTime), 0, N'1e2e9f6c-4c7f-4142-8317-c398db956764')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'6d21ea6e-4baf-44bd-8e83-0eefade4603f', N'Neptuno', 0, 1, N'36e791c5-4812-4cca-888c-7ba831f26df5', CAST(N'2024-05-14T17:15:37.360' AS DateTime), CAST(N'2024-05-14T17:15:37.360' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'992692e3-3c02-4aa5-8d0b-0f2611f01ea1', N'Siempre', 0, 1, N'ef9c4a21-331f-43d6-8b16-85867035a4c2', CAST(N'2024-06-18T16:19:46.777' AS DateTime), CAST(N'2024-06-18T16:19:46.777' AS DateTime), 5, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'978fb481-1747-4f4c-b45c-0fcbe5503263', N'bueno', 0, 1, N'2f4a9a17-f878-4788-8a84-0ace26143d43', CAST(N'2024-05-13T15:25:20.927' AS DateTime), CAST(N'2024-05-13T15:25:20.927' AS DateTime), 3, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'989d45b6-571a-4087-981f-10dba4a08d15', N'Monte Everest', 1, 1, N'8af5bd89-7624-495b-81e1-d642dc9cdcb3', CAST(N'2024-05-18T20:06:22.267' AS DateTime), CAST(N'2024-05-18T20:06:22.267' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'0cbc2189-1b3b-465f-98cb-10f8ae74e5bb', N'Siempre', 0, 1, N'a66925cc-5701-4460-91d0-fe6af4676618', CAST(N'2024-06-18T16:00:22.873' AS DateTime), CAST(N'2024-06-18T16:00:22.873' AS DateTime), 5, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'075c62c0-6316-4f13-a826-115fc857d442', N'Miguel Hidalgo', 0, 1, N'fcd4f005-2ea6-491b-bdf4-d07beb7cdb0d', CAST(N'2024-05-06T15:19:40.187' AS DateTime), CAST(N'2024-05-06T15:19:40.187' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'848dfb3c-c8f8-4322-a5e2-11f6cf0089b2', N'Interfaz de programación de aplicaciones', 1, 1, N'5089e889-89ff-4ca9-a614-9fe5d0567487', CAST(N'2024-02-27T16:56:20.283' AS DateTime), CAST(N'2024-02-27T16:56:20.283' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'65bbda02-11c9-438d-81d7-120b2b34b369', N'Transferencia de estado representacional', 0, 1, N'5089e889-89ff-4ca9-a614-9fe5d0567487', CAST(N'2024-02-27T16:56:20.283' AS DateTime), CAST(N'2024-02-27T16:56:20.283' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'03d3d403-3924-4c96-8779-12591b8e58e4', N'Ejemplo Opcion 2', 0, 1, N'dda0bb6e-5579-4971-a05a-a1a20c4482ac', CAST(N'2024-06-18T17:48:28.880' AS DateTime), CAST(N'2024-06-18T17:48:28.880' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'f3d8f61f-ff94-4cce-891b-12aab9b79fd4', N'Nunca', 0, 1, N'a66925cc-5701-4460-91d0-fe6af4676618', CAST(N'2024-06-18T16:00:22.870' AS DateTime), CAST(N'2024-06-18T16:00:22.870' AS DateTime), 1, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'e208e072-8244-4bff-ba21-12b86e0dc9e6', N'Río Misisipi', 0, 1, N'9d3385e6-863e-4e5c-b5ab-d4cc9be20991', CAST(N'2024-05-18T20:06:22.273' AS DateTime), CAST(N'2024-05-18T20:06:22.273' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'6aca0a21-2e23-42c4-bb45-12e9a7a86e23', N'Nunca', 0, 1, N'4b9c5102-2cf1-48bf-8983-162fef069f5d', CAST(N'2024-07-03T13:16:16.583' AS DateTime), CAST(N'2024-07-03T13:16:16.583' AS DateTime), 1, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'058b8a16-f139-4600-8b82-1366ecc21a69', N'¿Cuándo va a llegar Kylian Mbappé al Real Madrid?', 0, 1, N'9d8082c3-f809-41ef-ab1d-d24162bfcf72', CAST(N'2024-06-03T16:18:15.333' AS DateTime), CAST(N'2024-06-03T16:18:15.333' AS DateTime), 0, N'1e2e9f6c-4c7f-4142-8317-c398db956764')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'886ee30e-7ef4-49a9-8bdb-13f44a8f6590', N'Ejemplo Opcion 3', 0, 1, N'dda0bb6e-5579-4971-a05a-a1a20c4482ac', CAST(N'2024-06-18T17:48:28.880' AS DateTime), CAST(N'2024-06-18T17:48:28.880' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'3573c701-acc8-4c3f-a5b5-14273307ed60', N'Fémur', 1, 1, N'70cc4b45-c763-4e54-9728-98738a0e57ca', CAST(N'2024-05-18T20:06:22.283' AS DateTime), CAST(N'2024-05-18T20:06:22.283' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'14888157-e307-43bb-b244-148ffe24b44a', N'Ejemplo Opcion 10', 0, 1, N'aed89eab-a165-406f-926d-689ef0fa2ccb', CAST(N'2024-07-03T13:32:39.993' AS DateTime), CAST(N'2024-07-03T13:32:39.993' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'26c3ae21-7e2a-4e16-bf0b-14a295de7100', N'Antoine de Saint-Exupéry', 1, 1, N'a418389d-a1a4-49d5-94e2-b8f4dc813982', CAST(N'2024-05-14T17:15:37.340' AS DateTime), CAST(N'2024-05-14T17:15:37.340' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'e5d457cf-b207-47c2-b06b-14cc8d623b8e', N'Domicilio de familiares o amigos', 0, 1, N'af15ba63-8426-43d9-ba74-e855cde8b47d', CAST(N'2024-05-17T11:36:59.170' AS DateTime), CAST(N'2024-05-17T11:36:59.170' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'e462a1e4-9e92-4258-80fa-151f6580be71', N'Menos de 5 horas', 0, 1, N'bae6adba-4464-48fb-b80c-71ef136b44a1', CAST(N'2024-05-17T11:36:59.230' AS DateTime), CAST(N'2024-05-17T11:36:59.230' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'ab2bb820-ba0f-4ea5-aff4-15431ba8c207', N'Baloncesto', 0, 1, N'd34fb3e9-1be1-41bd-b542-957a78db78b7', CAST(N'2024-05-17T11:36:59.193' AS DateTime), CAST(N'2024-05-17T11:36:59.193' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'72221ff8-def9-4192-8ec0-155815843db4', N'Thomas Jefferson', 0, 1, N'463e14a7-3123-4038-b87f-3370b24ef98c', CAST(N'2024-05-06T15:19:40.163' AS DateTime), CAST(N'2024-05-06T15:19:40.163' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'f663f959-7d66-48f5-ba6f-15d61c2bb426', N'Ejemplo Opcion 3', 0, 1, N'06fb7cfc-9e4f-4c35-b6ab-1cd0d31e187a', CAST(N'2024-07-03T12:23:31.023' AS DateTime), CAST(N'2024-07-03T12:23:31.023' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'35039309-d4b1-44a0-aea9-15e07d70eded', N'A Veces', 0, 1, N'19850dc1-0247-44c6-9774-aa733a61ce45', CAST(N'2024-07-03T13:16:16.600' AS DateTime), CAST(N'2024-07-03T13:16:16.600' AS DateTime), 3, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'810b4f29-4d0a-4daf-9f89-1617154b7cdc', N'Rara Vez', 0, 1, N'cb7f759a-4f64-4c49-8d4e-d7716784ec88', CAST(N'2024-06-12T14:51:55.910' AS DateTime), CAST(N'2024-06-12T14:51:55.910' AS DateTime), 2, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'9abcdf54-c0f6-4f97-a833-165699ad5ddd', N'Ejemplo Opcion 9', 0, 1, N'f5535438-f8f2-441d-b3ce-266d618d8301', CAST(N'2024-07-03T13:32:40.007' AS DateTime), CAST(N'2024-07-03T13:32:40.007' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'75d815d2-7d3e-41d4-8da7-165835943402', N'Otra', 0, 1, N'fbdb896d-999e-4123-9d57-804508ddd7c1', CAST(N'2024-05-17T11:36:59.187' AS DateTime), CAST(N'2024-05-17T11:36:59.187' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'621b094f-0e5f-4f0d-ada4-1661b4fdbb53', N'Pop', 0, 1, N'253efaf1-4751-416d-aebd-3f82ca9ecc86', CAST(N'2024-05-17T11:36:59.190' AS DateTime), CAST(N'2024-05-17T11:36:59.190' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'ddc4aba5-c903-4c5f-8fef-16e2833bdb64', N'Más de 9 horas', 0, 1, N'bae6adba-4464-48fb-b80c-71ef136b44a1', CAST(N'2024-05-17T11:36:59.233' AS DateTime), CAST(N'2024-05-17T11:36:59.233' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'aa3b9860-fc8e-49ee-9416-1740b1b687ac', N'Nunca', 0, 1, N'ef9c4a21-331f-43d6-8b16-85867035a4c2', CAST(N'2024-06-18T16:19:46.773' AS DateTime), CAST(N'2024-06-18T16:19:46.773' AS DateTime), 1, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'39d788f4-209f-4e8e-bc5e-1758af2d4654', N'1939', 0, 1, N'7d1ddcfd-9c98-43e8-b5bb-38a216617fbe', CAST(N'2024-05-18T20:06:22.277' AS DateTime), CAST(N'2024-05-18T20:06:22.277' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'fd4a0f75-3d95-46cd-9dbe-17efdfa4b23a', N'Ejemplo Opcion 6', 0, 1, N'e20687bd-bdd9-4edf-8bf4-8caa5cb8d616', CAST(N'2024-07-03T13:32:39.997' AS DateTime), CAST(N'2024-07-03T13:32:39.997' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'37dc4975-d2d7-45c8-b799-182728d94fc9', N'Victor Hugo', 0, 1, N'2e3c17ca-b700-48e1-be55-636ddbf6995d', CAST(N'2024-05-18T20:06:22.270' AS DateTime), CAST(N'2024-05-18T20:06:22.270' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'6e399079-0093-4e81-8f2a-18b19965b991', N'En desacuerdo', 0, 1, N'd8585a71-6633-403a-857d-5e042524c98f', CAST(N'2024-07-03T14:43:33.890' AS DateTime), CAST(N'2024-07-03T14:43:33.890' AS DateTime), 2, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'c4a7ee08-06a4-45b6-b251-18f582ee56b4', N'Neutral', 0, 1, N'0d893612-4eb6-4049-a0d7-3b9ce643b426', CAST(N'2024-06-19T11:51:12.147' AS DateTime), CAST(N'2024-06-19T11:51:12.147' AS DateTime), 3, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'383aea1e-032a-427b-957e-194ada13100b', N'Ejemplo Opcion 5', 0, 1, N'c4273e68-8869-4369-9eac-259ba870b163', CAST(N'2024-07-03T13:32:39.983' AS DateTime), CAST(N'2024-07-03T13:32:39.983' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'2cc2b76e-3bb1-418c-baab-19e562dfa82a', N'Automóvil', 0, 1, N'768ae381-8735-43ad-8c33-77b4836a070f', CAST(N'2024-05-17T11:36:59.210' AS DateTime), CAST(N'2024-05-17T11:36:59.210' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'6807e28e-8e8a-4152-8461-1a206a32799d', N'Ejemploa', 0, 1, N'd02c70c9-b921-446c-ad76-45f9650712cb', CAST(N'2024-07-03T11:55:14.123' AS DateTime), CAST(N'2024-07-03T11:55:14.123' AS DateTime), 0, N'357dbf15-2a3e-4424-9005-9325bba3462c')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'159d4689-a5e0-43d0-b14e-1a4137e47ce2', N'Plata', 0, 1, N'2a24fe22-f17e-4dd5-974a-171dfe3c6f9c', CAST(N'2024-05-06T15:19:40.170' AS DateTime), CAST(N'2024-05-06T15:19:40.170' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'ab56dfac-78db-48f9-a366-1b0514d619d0', N'Totalmente en desacuerdo', 0, 1, N'74dbbef1-3d7b-4c36-aaf5-f459715311b0', CAST(N'2024-06-19T11:51:12.150' AS DateTime), CAST(N'2024-06-19T11:51:12.150' AS DateTime), 1, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'629197de-d989-4ed7-9c60-1bca9e5fb547', N'fsfd', 0, 1, N'4d6449d8-69a2-4062-a77d-f3f9e3a3777f', CAST(N'2024-06-19T11:46:31.547' AS DateTime), CAST(N'2024-06-19T11:46:31.547' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'e2ebed19-31e1-4acf-ae1a-1bf4f4bcb10c', N'De acuerdo', 0, 1, N'74dbbef1-3d7b-4c36-aaf5-f459715311b0', CAST(N'2024-06-19T11:51:12.150' AS DateTime), CAST(N'2024-06-19T11:51:12.150' AS DateTime), 4, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'73b4d5c2-a9df-4e7f-af98-1c257790e990', N'Siempre', 0, 1, N'f0b0ac75-b7bb-472f-b612-20a394e71343', CAST(N'2024-06-12T14:23:58.080' AS DateTime), CAST(N'2024-06-12T14:23:58.080' AS DateTime), 5, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'9b6a521b-ac1d-4e78-a801-1da46d5a338b', N'Charles Dickens', 0, 1, N'5eba467e-fcd2-4b64-8da4-aa167d1c2539', CAST(N'2024-05-14T17:15:37.367' AS DateTime), CAST(N'2024-05-14T17:15:37.367' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'd5221b81-678b-42b3-b0aa-1eaac66e2160', N'EjemploE', 0, 1, N'4d30043b-9bbf-4dac-8e4c-c3663eb83655', CAST(N'2024-06-19T12:00:32.250' AS DateTime), CAST(N'2024-06-19T12:00:32.250' AS DateTime), 0, N'357dbf15-2a3e-4424-9005-9325bba3462c')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'6c3244cf-48b0-4ffd-937f-1ed8c8a88286', N'1918', 0, 1, N'8d107d91-0768-4810-bced-29dfc6815825', CAST(N'2024-05-14T17:15:37.350' AS DateTime), CAST(N'2024-05-14T17:15:37.350' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'9d594a86-3a73-4965-b79b-1f1ae7fb6e20', N'A Veces', 0, 1, N'0efc1f0a-ac87-466e-bb5e-5f3ae9c0f814', CAST(N'2024-06-18T16:11:02.860' AS DateTime), CAST(N'2024-06-18T16:11:02.860' AS DateTime), 3, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'6562ac41-e17c-42a7-8e32-1f53d5826ec6', N'Ejemplo Opcion 6', 0, 1, N'dda0bb6e-5579-4971-a05a-a1a20c4482ac', CAST(N'2024-06-18T17:48:28.880' AS DateTime), CAST(N'2024-06-18T17:48:28.880' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'a407990d-cb6b-4721-84a2-1fd3d2446106', N'Thomas Jefferson', 0, 1, N'd0e024f3-e436-4f39-aa16-9ec0d638b825', CAST(N'2024-05-18T20:06:22.273' AS DateTime), CAST(N'2024-05-18T20:06:22.273' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'572696bf-50f7-4bd3-b4e8-212451a49490', N'Saturno', 0, 1, N'ae85ef32-0e82-487f-a2c1-6d1b5b6477ff', CAST(N'2024-05-06T15:19:40.173' AS DateTime), CAST(N'2024-05-06T15:19:40.173' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'37999793-0ace-4131-854e-220915dc88b0', N'Neutral', 0, 1, N'741d8042-94e7-4865-8b44-7ab832561eba', CAST(N'2024-07-03T14:43:33.880' AS DateTime), CAST(N'2024-07-03T14:43:33.880' AS DateTime), 3, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'1db821b1-f1e0-4b4d-ac99-227b42d4eb9a', N'Ejemplo Opcion 2', 0, 1, N'2f722edf-8c3b-4682-8abf-c8305c2d18ca', CAST(N'2024-06-18T17:48:28.853' AS DateTime), CAST(N'2024-06-18T17:48:28.853' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'f9985b4b-62e8-47fc-9eec-22988c85102f', N'Ejemplo Opcion 4', 0, 1, N'e20687bd-bdd9-4edf-8bf4-8caa5cb8d616', CAST(N'2024-07-03T13:32:39.997' AS DateTime), CAST(N'2024-07-03T13:32:39.997' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'dcd25220-ad78-489d-b999-234940255864', N'De acuerdo', 0, 1, N'9f118e9f-8fd8-42f7-bced-3dd76988cdb2', CAST(N'2024-07-03T14:43:33.883' AS DateTime), CAST(N'2024-07-03T14:43:33.883' AS DateTime), 4, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'4c7471f6-355a-408b-8778-23dbe488cefc', N'Ejemplo Opcion 1', 0, 1, N'7fa649e1-4ca7-43e6-9211-1cbacceccc50', CAST(N'2024-07-03T13:32:40.017' AS DateTime), CAST(N'2024-07-03T13:32:40.017' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'6e5c0249-24a5-46f4-b6b1-2446b29cfa51', N'Charles Dickens', 0, 1, N'546b1a00-fa38-4ceb-be54-83ca7dd923c9', CAST(N'2024-05-06T15:19:40.180' AS DateTime), CAST(N'2024-05-06T15:19:40.180' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'adf9981b-a82a-4240-88eb-24572609d358', N'Ejemplo Opcion 8', 0, 1, N'e20687bd-bdd9-4edf-8bf4-8caa5cb8d616', CAST(N'2024-07-03T13:32:40.000' AS DateTime), CAST(N'2024-07-03T13:32:40.000' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'11549d04-c6ec-47f2-a90d-246d1de83912', N'Ejemplo Opcion 2', 0, 1, N'812b0e64-0b5e-4742-a260-a5eb8b09d89f', CAST(N'2024-07-03T12:23:31.020' AS DateTime), CAST(N'2024-07-03T12:23:31.020' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'371a13fa-ac73-4353-9bbe-26b7a9744693', N'Ejemplo Opcion 4', 0, 1, N'aed89eab-a165-406f-926d-689ef0fa2ccb', CAST(N'2024-07-03T13:32:39.990' AS DateTime), CAST(N'2024-07-03T13:32:39.990' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'762065ca-7e0b-4a7d-969c-26daa94acf48', N'En desacuerdo', 0, 1, N'741d8042-94e7-4865-8b44-7ab832561eba', CAST(N'2024-07-03T14:43:33.880' AS DateTime), CAST(N'2024-07-03T14:43:33.880' AS DateTime), 2, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'c8ba7f20-0271-43b1-9ad7-272fa39a626d', N'Ejemplo Opcion 1', 0, 1, N'e20687bd-bdd9-4edf-8bf4-8caa5cb8d616', CAST(N'2024-07-03T13:32:39.993' AS DateTime), CAST(N'2024-07-03T13:32:39.993' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'3228fabd-dd33-443f-8a5a-274d5bccb2d1', N'1953', 0, 1, N'7d1ddcfd-9c98-43e8-b5bb-38a216617fbe', CAST(N'2024-05-18T20:06:22.277' AS DateTime), CAST(N'2024-05-18T20:06:22.277' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'f57a911a-8400-434f-ba74-2805f9406866', N'Radio', 0, 1, N'70cc4b45-c763-4e54-9728-98738a0e57ca', CAST(N'2024-05-18T20:06:22.287' AS DateTime), CAST(N'2024-05-18T20:06:22.287' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'5a40254d-cc20-46f0-b4a6-2915a9c9f558', N'Ejemplo Opcion 4', 0, 1, N'f5535438-f8f2-441d-b3ce-266d618d8301', CAST(N'2024-07-03T13:32:40.003' AS DateTime), CAST(N'2024-07-03T13:32:40.003' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'3429114c-2eb8-4cd2-8e6a-2968bc00781e', N'EjemploD', 0, 1, N'55973eec-9d86-4a83-aa90-33cbc394dd02', CAST(N'2024-06-19T12:00:32.240' AS DateTime), CAST(N'2024-06-19T12:00:32.240' AS DateTime), 0, N'bfef5abf-cff4-460b-a3af-55630d81066a')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'590db667-2021-49fd-92bc-29f41bfe405f', N'¿Cuándo se celebró la inauguración del Canal de Panamá?', 0, 1, N'98c931ee-8300-4484-9497-30b80e74062f', CAST(N'2024-06-03T16:18:15.327' AS DateTime), CAST(N'2024-06-03T16:18:15.327' AS DateTime), 0, N'1e2e9f6c-4c7f-4142-8317-c398db956764')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'f8a0885e-32a8-4080-9fad-2a6ef0e2a52e', N'1953', 0, 1, N'52efe634-e59c-463c-9599-e88f9955094c', CAST(N'2024-05-06T15:19:40.163' AS DateTime), CAST(N'2024-05-06T15:19:40.163' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'bc46be60-1b07-4ae4-ac6b-2aa94f9749d2', N'Dólar', 0, 1, N'63afe949-1674-421a-8cce-463e7e6ba267', CAST(N'2024-05-18T20:06:22.293' AS DateTime), CAST(N'2024-05-18T20:06:22.293' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'8b1bc8ab-01c8-4baf-8711-2b295caf5cf0', N'Ejemplo Opcion 3', 0, 1, N'7fa649e1-4ca7-43e6-9211-1cbacceccc50', CAST(N'2024-07-03T13:32:40.020' AS DateTime), CAST(N'2024-07-03T13:32:40.020' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'288e3584-3658-4c31-95b5-2b69f0475720', N'Nunca', 0, 1, N'19850dc1-0247-44c6-9774-aa733a61ce45', CAST(N'2024-07-03T13:16:16.600' AS DateTime), CAST(N'2024-07-03T13:16:16.600' AS DateTime), 1, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'279cc3c8-9589-46cf-a6e2-2bda014523f1', N'Siempre', 0, 1, N'4561f5f6-1c0d-496d-9ddb-adb0157b4a92', CAST(N'2024-07-03T13:16:16.593' AS DateTime), CAST(N'2024-07-03T13:16:16.593' AS DateTime), 5, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'c85a58e8-f5c8-41d0-846a-2c03e1d7250d', N'Rara Vez', 0, 1, N'ef9c4a21-331f-43d6-8b16-85867035a4c2', CAST(N'2024-06-18T16:19:46.777' AS DateTime), CAST(N'2024-06-18T16:19:46.777' AS DateTime), 2, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'4b90efd0-a728-4c9a-8f42-2c40ad01ad2b', N'Primaria', 0, 1, N'5cb81db3-01ac-49b5-9855-e8f9b686a99f', CAST(N'2024-05-17T11:36:59.170' AS DateTime), CAST(N'2024-05-17T11:36:59.170' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'be1ba4d6-c7f1-4722-b566-2d1edeccb77c', N'1918', 0, 1, N'7d1ddcfd-9c98-43e8-b5bb-38a216617fbe', CAST(N'2024-05-18T20:06:22.277' AS DateTime), CAST(N'2024-05-18T20:06:22.277' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'18d2a5b4-5e1b-415e-bf35-2db4303ec8ce', N'Júpiter', 1, 1, N'36e791c5-4812-4cca-888c-7ba831f26df5', CAST(N'2024-05-14T17:15:37.357' AS DateTime), CAST(N'2024-05-14T17:15:37.357' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'1db5129d-e63d-4dda-b658-2e79b0bbf574', N'¿A que hora fue firmado el Tratado de Versalles que puso fin a la Primera Guerra Mundial?', 0, 1, N'98c931ee-8300-4484-9497-30b80e74062f', CAST(N'2024-06-03T16:18:15.327' AS DateTime), CAST(N'2024-06-03T16:18:15.327' AS DateTime), 0, N'357dbf15-2a3e-4424-9005-9325bba3462c')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'8187f0d1-065b-4c52-9bd3-2e7b4170db23', N'Montaña McKinley', 0, 1, N'494aec55-c94c-4e71-94cf-dd101e545458', CAST(N'2024-05-14T17:15:37.340' AS DateTime), CAST(N'2024-05-14T17:15:37.340' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'32d84a79-abfe-46d0-8e56-2f49bb539897', N'Alan Shepard', 0, 1, N'c29f1d5d-90db-41ff-ba8b-8c2cd25354e0', CAST(N'2024-05-14T17:15:37.353' AS DateTime), CAST(N'2024-05-14T17:15:37.353' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'ccea37e3-b9c2-4925-bc82-2ff4c8c37a1d', N'Fotosintesis', 1, 1, N'3144a4a4-2d01-4bc1-9d2e-b0365f6b125c', CAST(N'2024-05-18T20:06:22.290' AS DateTime), CAST(N'2024-05-18T20:06:22.290' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'd918c88b-f036-44e4-adbd-301edc408292', N'Miguel de Cervantes', 0, 1, N'a418389d-a1a4-49d5-94e2-b8f4dc813982', CAST(N'2024-05-14T17:15:37.343' AS DateTime), CAST(N'2024-05-14T17:15:37.343' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'6a61249b-899c-4921-9009-309c31846850', N'Totalmente de acuerdo', 0, 1, N'd8585a71-6633-403a-857d-5e042524c98f', CAST(N'2024-07-03T14:43:33.893' AS DateTime), CAST(N'2024-07-03T14:43:33.893' AS DateTime), 5, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'28fad534-b084-49df-8e66-30ee960761db', N'6-7 horas', 0, 1, N'bae6adba-4464-48fb-b80c-71ef136b44a1', CAST(N'2024-05-17T11:36:59.233' AS DateTime), CAST(N'2024-05-17T11:36:59.233' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'f300fae7-a003-49e7-b19d-30f52a3c856b', N'Rara Vez', 0, 1, N'99821866-9268-4e60-95b6-8d932ecaded3', CAST(N'2024-07-03T13:22:31.033' AS DateTime), CAST(N'2024-07-03T13:22:31.033' AS DateTime), 2, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'64991094-8935-4976-a2e2-311200ca8040', N'opcionA', 0, 1, N'176464f5-9c08-422e-8fa2-eeba91ad54b7', CAST(N'2024-06-19T09:57:32.910' AS DateTime), CAST(N'2024-06-19T09:57:32.910' AS DateTime), 0, N'bfef5abf-cff4-460b-a3af-55630d81066a')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'5cd85b49-71fa-40cf-867c-313a67f2d83b', N'Ejemplo Opcion 2', 0, 1, N'2e3772af-86f7-4b10-ab23-3c7fd119df3f', CAST(N'2024-07-03T12:23:31.030' AS DateTime), CAST(N'2024-07-03T12:23:31.030' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'abbab6a8-6633-4f73-a6e1-3164e72b456c', N'¿En que pais esta la Torre Eiffel?', 0, 1, N'9d8082c3-f809-41ef-ab1d-d24162bfcf72', CAST(N'2024-06-03T16:18:15.333' AS DateTime), CAST(N'2024-06-03T16:18:15.333' AS DateTime), 0, N'bfef5abf-cff4-460b-a3af-55630d81066a')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'3111e49d-d1ae-4f63-8195-316cb0227f04', N'Vincent van Gogh', 0, 1, N'825d1a65-2bbc-4120-bade-7a304a8d44bd', CAST(N'2024-05-18T20:06:22.260' AS DateTime), CAST(N'2024-05-18T20:06:22.260' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'f49e425a-3f80-4942-afec-31990722bd08', N'Nunca', 0, 1, N'99821866-9268-4e60-95b6-8d932ecaded3', CAST(N'2024-07-03T13:22:31.030' AS DateTime), CAST(N'2024-07-03T13:22:31.030' AS DateTime), 1, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'3cfd0982-e6b7-4a94-a38b-31a80b2c990f', N'Nunca', 0, 1, N'4b64542b-5941-4b53-935f-8269262a93d4', CAST(N'2024-07-03T13:22:31.027' AS DateTime), CAST(N'2024-07-03T13:22:31.027' AS DateTime), 1, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'b0be2b49-90ea-4b7b-bee6-31d591857373', N'Kiev', 0, 1, N'e0c81067-b353-4659-b29c-d909d1209830', CAST(N'2024-05-18T20:06:22.300' AS DateTime), CAST(N'2024-05-18T20:06:22.300' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'eb9d6ac6-993f-41b3-8d1b-320cdbcf3a97', N'Discapacidad', 0, 1, N'ab319e07-97f2-4ae0-8862-527e4ed6f972', CAST(N'2024-05-17T11:36:59.180' AS DateTime), CAST(N'2024-05-17T11:36:59.180' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'6a0f3237-57d2-41da-84b8-327256a07cc0', N'Hierro', 0, 1, N'9fc8b8e0-4832-437c-88ba-0e5f4cb6585c', CAST(N'2024-05-18T20:06:22.280' AS DateTime), CAST(N'2024-05-18T20:06:22.280' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'bf4b92be-68d4-420c-b73d-332f02b6f736', N'16', 0, 1, N'415aa7b1-846e-430e-8687-96789fcdac9b', CAST(N'2024-06-18T16:40:29.753' AS DateTime), CAST(N'2024-06-18T16:40:35.740' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'62ae4779-ac48-4d92-9471-3371a9d8217e', N'Pablo Picasso', 0, 1, N'749cb8ac-109f-476e-8f3c-6396c6ebb8fd', CAST(N'2024-05-06T15:19:40.153' AS DateTime), CAST(N'2024-05-06T15:19:40.153' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'bb240980-fe0d-4d16-9f27-33a9cc9320e9', N'Café', 0, 1, N'331bea1d-cf31-4085-bda8-fc1544356c4d', CAST(N'2024-05-17T11:36:59.223' AS DateTime), CAST(N'2024-05-17T11:36:59.223' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'1b49799c-8da5-4461-bf29-33aa34320a0b', N'¿Cuál es la direccion exacta de su domicilio?', 0, 1, N'ee2e1db9-86c6-4da4-b2ed-4ed9626b4ea4', CAST(N'2024-05-21T12:25:25.557' AS DateTime), CAST(N'2024-05-21T12:25:25.557' AS DateTime), 0, N'bfef5abf-cff4-460b-a3af-55630d81066a')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'44440381-08b5-4f17-9f57-33d62187ed1a', N'Ejemplo Opcion 4', 0, 1, N'9845c3de-be89-4405-8cc6-5422f6928eb9', CAST(N'2024-06-18T17:48:28.870' AS DateTime), CAST(N'2024-06-18T17:48:28.870' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'c474b093-9704-4335-bb53-3502d9c18def', N'William Shakespeare', 1, 1, N'5eba467e-fcd2-4b64-8da4-aa167d1c2539', CAST(N'2024-05-14T17:15:37.367' AS DateTime), CAST(N'2024-05-14T17:15:37.367' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'85fba285-db05-4fb6-b4a6-350622ce8221', N'Nunca', 0, 1, N'1c8f5d74-122b-4c41-8c88-7815d790d9ec', CAST(N'2024-06-18T16:10:51.040' AS DateTime), CAST(N'2024-06-18T16:10:51.040' AS DateTime), 1, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'65ef417e-1583-4640-994b-354e67e41e16', N'Respiración', 0, 1, N'3144a4a4-2d01-4bc1-9d2e-b0365f6b125c', CAST(N'2024-05-18T20:06:22.290' AS DateTime), CAST(N'2024-05-18T20:06:22.290' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'7de64401-f76f-4aad-8401-35966042ce65', N'Ejemplo Opcion 5', 0, 1, N'dda0bb6e-5579-4971-a05a-a1a20c4482ac', CAST(N'2024-06-18T17:48:28.880' AS DateTime), CAST(N'2024-06-18T17:48:28.880' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'8cb3a1c9-3acb-40ac-89fb-359addeda64c', N'Ejemplo Opcion 9', 0, 1, N'dda0bb6e-5579-4971-a05a-a1a20c4482ac', CAST(N'2024-06-18T17:48:28.883' AS DateTime), CAST(N'2024-06-18T17:48:28.883' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'4cac4ca1-764c-4add-b8f0-35dc46d66c53', N'EjemploC', 0, 1, N'07761dfa-7ce5-42b3-9b40-29375321322e', CAST(N'2024-06-19T12:00:32.250' AS DateTime), CAST(N'2024-06-19T12:00:32.250' AS DateTime), 0, N'1e2e9f6c-4c7f-4142-8317-c398db956764')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'd3e92ffd-ec95-4573-91e2-363f45eca273', N'Otoño', 0, 1, N'24376bf1-0aa7-4b93-9e49-d1d3b983d036', CAST(N'2024-05-17T11:36:59.240' AS DateTime), CAST(N'2024-05-17T11:36:59.240' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'f5b326fb-9835-4fe4-9cd4-36a927063ded', N'1953', 0, 1, N'8d107d91-0768-4810-bced-29dfc6815825', CAST(N'2024-05-14T17:15:37.350' AS DateTime), CAST(N'2024-05-14T17:15:37.350' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'79719d04-9bef-41d3-a0b0-36de90ced6cf', N'Producción Audiovisual', 0, 1, N'e00ae793-e6c1-4a2a-8ece-142bf6b7a2ee', CAST(N'2024-05-17T11:36:59.227' AS DateTime), CAST(N'2024-05-17T11:36:59.227' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'26204531-5b1f-4a9e-86f4-36ed1a8860bb', N'dadada', 0, 1, N'8397da47-99cc-45a8-afdd-e2105d2eb748', CAST(N'2024-06-19T10:01:21.183' AS DateTime), CAST(N'2024-06-19T10:01:21.183' AS DateTime), 0, N'1e2e9f6c-4c7f-4142-8317-c398db956764')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'd9d0f4f1-24e7-4a96-bfa2-370694eafa98', N'Cobre', 0, 1, N'f8499c7e-6912-4b18-8819-ccbdbe4bfb94', CAST(N'2024-05-14T17:15:37.353' AS DateTime), CAST(N'2024-05-14T17:15:37.353' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'0d8e5927-35bf-4dcf-92db-37f782854ce1', N'Ejemplo Opcion 1', 0, 1, N'dda0bb6e-5579-4971-a05a-a1a20c4482ac', CAST(N'2024-06-18T17:48:28.880' AS DateTime), CAST(N'2024-06-18T17:48:28.880' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'c1b1c78f-4ee8-44de-838c-380299030314', N'prueba op 1', 0, 1, N'828020ba-8f8c-4650-9fe0-7e44cd9f8088', CAST(N'2024-05-17T14:55:06.963' AS DateTime), CAST(N'2024-05-17T14:55:06.963' AS DateTime), 0, N'bfef5abf-cff4-460b-a3af-55630d81066a')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'819043d8-f904-4677-8cab-38341b3ee3ff', N'John Adams', 0, 1, N'd0e024f3-e436-4f39-aa16-9ec0d638b825', CAST(N'2024-05-18T20:06:22.277' AS DateTime), CAST(N'2024-05-18T20:06:22.277' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'535532c9-7f9b-48f0-8050-3835f0f3c3dc', N'Geoffrey Chaucer', 0, 1, N'88cdf9fd-996b-4a03-b3d2-1ab46293aa9d', CAST(N'2024-05-18T20:06:22.293' AS DateTime), CAST(N'2024-05-18T20:06:22.293' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'37f717ff-51bd-4d58-8018-3876f84e5332', N'Italia', 0, 1, N'ccc3d027-def0-424d-94c2-f03a48a91ae0', CAST(N'2024-05-06T15:19:40.187' AS DateTime), CAST(N'2024-05-06T15:19:40.187' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'6b5ac7d4-e2f9-4556-a41e-38f23a4558f8', N'A Veces', 0, 1, N'1c8f5d74-122b-4c41-8c88-7815d790d9ec', CAST(N'2024-06-18T16:10:51.043' AS DateTime), CAST(N'2024-06-18T16:10:51.043' AS DateTime), 3, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'41229acc-3f55-4122-ae68-3912bbb74b0a', N'EjemploE', 0, 1, N'55973eec-9d86-4a83-aa90-33cbc394dd02', CAST(N'2024-06-19T12:00:32.240' AS DateTime), CAST(N'2024-06-19T12:00:32.240' AS DateTime), 0, N'357dbf15-2a3e-4424-9005-9325bba3462c')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'3de18fff-b649-4339-932b-3920750f9a15', N'En desacuerdo', 0, 1, N'eace26ab-f364-44cc-a179-cca4952a5cc4', CAST(N'2024-06-19T11:51:12.143' AS DateTime), CAST(N'2024-06-19T11:51:12.143' AS DateTime), 2, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'ad95bed8-5191-4943-b617-3938f02ddbda', N'24', 0, 1, N'170d9f8d-3df7-433e-9c2a-3758c9ac57cf', CAST(N'2024-05-09T18:04:09.280' AS DateTime), CAST(N'2024-05-09T18:04:09.280' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'eca1ad75-f752-40ee-95b6-3997096ffd2d', N'a', 0, 1, N'18412367-e942-4df0-9a2a-99cfe7e002a1', CAST(N'2024-06-19T09:53:17.070' AS DateTime), CAST(N'2024-06-19T09:53:17.070' AS DateTime), 0, N'1e2e9f6c-4c7f-4142-8317-c398db956764')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'a7933728-6540-45dd-89c3-3a2a2ec5b674', N'mi opcion 1', 0, 1, N'b7a37232-4eb1-4ac4-bc7b-d9396a96000f', CAST(N'2024-05-13T12:56:22.240' AS DateTime), CAST(N'2024-05-13T12:56:22.240' AS DateTime), 2, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'be814cd2-23f6-41ed-8b3e-3a3d7cbe6222', N'George Washington', 1, 1, N'463e14a7-3123-4038-b87f-3370b24ef98c', CAST(N'2024-05-06T15:19:40.163' AS DateTime), CAST(N'2024-05-06T15:19:40.163' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'9b630d70-f6a5-4d34-8b1f-3a7de13a5052', N'Terror', 0, 1, N'6122e532-6296-4b7f-b2cf-a91b1e1ce8a2', CAST(N'2024-05-17T11:36:59.207' AS DateTime), CAST(N'2024-05-17T11:36:59.207' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'7b6a1c49-72c7-46cf-8d7c-3a823d211f4d', N'Fotosintesis', 1, 1, N'94de16dd-f15a-49df-b82a-55143405dd9e', CAST(N'2024-05-14T17:15:37.360' AS DateTime), CAST(N'2024-05-14T17:15:37.360' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'52fcc49f-d1e1-412b-bd6c-3ab96fb5d3c3', N'Ejemplo Opcion 3', 0, 1, N'450e7cda-1c03-4a33-abe9-720fd4a2fe7d', CAST(N'2024-07-03T12:23:31.027' AS DateTime), CAST(N'2024-07-03T12:23:31.027' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'd89fdf70-f882-4c99-8053-3aefc2c7aaf1', N'Frecuentemente', 0, 1, N'b0426a57-6d19-4453-9640-4839197e8859', CAST(N'2024-06-19T12:11:07.057' AS DateTime), CAST(N'2024-06-19T12:11:07.057' AS DateTime), 4, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'fe65562a-b62c-4703-91ca-3b29c79cb6df', N'Ejemplo Opcion 6', 0, 1, N'aed89eab-a165-406f-926d-689ef0fa2ccb', CAST(N'2024-07-03T13:32:39.990' AS DateTime), CAST(N'2024-07-03T13:32:39.990' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'bc17adca-5ada-41cb-bf65-3b5dd6165247', N'Antoine de Saint-Exupéry', 1, 1, N'2e3c17ca-b700-48e1-be55-636ddbf6995d', CAST(N'2024-05-18T20:06:22.270' AS DateTime), CAST(N'2024-05-18T20:06:22.270' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'4a2ec164-1726-42b8-9bfd-3ba8dde5b7ad', N'Antoine de Saint-Exupéry', 1, 1, N'44f97be2-194e-40cc-9d42-9ebfd8a3aaad', CAST(N'2024-05-06T15:19:40.160' AS DateTime), CAST(N'2024-05-06T15:19:40.160' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'b8c3306a-8772-4eea-a163-3cc646277de4', N'Ejemplo Opcion 1', 1, 1, N'3a113ec5-79f5-40e6-93af-6971eccea36a', CAST(N'2024-07-03T12:23:31.027' AS DateTime), CAST(N'2024-07-03T12:23:31.027' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'38c54297-841c-4299-a00c-3d7d04bb911f', N'Ejemplob', 0, 1, N'20548ecc-bf50-4caf-8b89-557e148467cc', CAST(N'2024-06-19T11:59:34.723' AS DateTime), CAST(N'2024-06-19T11:59:34.723' AS DateTime), 0, N'357dbf15-2a3e-4424-9005-9325bba3462c')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'0e2e4059-fb48-4464-83dd-3dadf4341487', N'Ejemplo Opcion 3', 0, 1, N'93a7cd55-8c95-4ace-9468-e3a78528fa74', CAST(N'2024-07-03T13:32:40.010' AS DateTime), CAST(N'2024-07-03T13:32:40.010' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'f1074509-a8ba-4dc2-8d12-3dcc016791e3', N'Ejemplo Opcion 1', 0, 1, N'93a7cd55-8c95-4ace-9468-e3a78528fa74', CAST(N'2024-07-03T13:32:40.010' AS DateTime), CAST(N'2024-07-03T13:32:40.010' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'62b7622b-3cdf-4d90-9c47-3e0f380bfb5c', N'Italia', 0, 1, N'8d5e4ba5-2632-4ca4-817a-de1300b99a0e', CAST(N'2024-05-18T20:06:22.303' AS DateTime), CAST(N'2024-05-18T20:06:22.303' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'817295ad-5bf2-416b-bb39-3e6be2d66649', N'23', 1, 1, N'170d9f8d-3df7-433e-9c2a-3758c9ac57cf', CAST(N'2024-05-09T18:04:09.277' AS DateTime), CAST(N'2024-05-09T18:04:09.277' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'4393fbd6-1712-4d00-a4e9-3ef539bfe694', N'Vladivostok', 0, 1, N'36e6a35d-0678-4725-95a1-fb1ec32103fd', CAST(N'2024-05-06T15:19:40.183' AS DateTime), CAST(N'2024-05-06T15:19:40.183' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'6a0c73ff-2d3a-4213-aca4-3f0dc65bceb5', N'Litio', 1, 1, N'a521fe33-f349-4279-9ee9-fb9b4dec34bc', CAST(N'2024-05-06T15:19:40.180' AS DateTime), CAST(N'2024-05-06T15:19:40.180' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'7e4c004a-4b01-426a-8428-3fd786c20ad2', N'París', 1, 1, N'3418513a-2424-4676-9cc1-a071fbcc32e5', CAST(N'2024-05-18T20:06:22.263' AS DateTime), CAST(N'2024-05-18T20:06:22.263' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'e4d00805-621d-4bfd-b484-3ffa61cbc14a', N'Siempre', 0, 1, N'1c8f5d74-122b-4c41-8c88-7815d790d9ec', CAST(N'2024-06-18T16:10:51.043' AS DateTime), CAST(N'2024-06-18T16:10:51.043' AS DateTime), 5, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'1db919dd-bd6e-4c2a-bde7-4086cfa45c0c', N'Neutral', 0, 1, N'eace26ab-f364-44cc-a179-cca4952a5cc4', CAST(N'2024-06-19T11:51:12.143' AS DateTime), CAST(N'2024-06-19T11:51:12.143' AS DateTime), 3, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'd6d13f17-2005-43e3-9ea6-40ef593d0fcb', N'8-9 horas', 0, 1, N'bae6adba-4464-48fb-b80c-71ef136b44a1', CAST(N'2024-05-17T11:36:59.233' AS DateTime), CAST(N'2024-05-17T11:36:59.233' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'c0cb6eff-d290-4ba5-a4be-410badcdb360', N'Verano', 0, 1, N'24376bf1-0aa7-4b93-9e49-d1d3b983d036', CAST(N'2024-05-17T11:36:59.237' AS DateTime), CAST(N'2024-05-17T11:36:59.237' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'e0249eef-c1a1-474c-ad7d-4111d52ebabb', N'A pie', 0, 1, N'768ae381-8735-43ad-8c33-77b4836a070f', CAST(N'2024-05-17T11:36:59.210' AS DateTime), CAST(N'2024-05-17T11:36:59.210' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'd28ea7f6-3f68-4299-8aeb-41ca3655a560', N'Aluminio', 0, 1, N'10ccc4aa-9bef-4015-89bf-106ac005fb2b', CAST(N'2024-05-18T20:06:22.297' AS DateTime), CAST(N'2024-05-18T20:06:22.297' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'855dac42-74ac-407d-b7f0-41e98c4d3af5', N'Ejemplo Opcion 10', 0, 1, N'c4273e68-8869-4369-9eac-259ba870b163', CAST(N'2024-07-03T13:32:39.987' AS DateTime), CAST(N'2024-07-03T13:32:39.987' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'2ead78f4-aa25-421b-bc33-426505070b32', N'b', 0, 1, N'8b8c5642-1e5a-4cd9-a6c0-899eb7c30192', CAST(N'2024-06-18T16:41:06.653' AS DateTime), CAST(N'2024-06-18T16:41:06.653' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'1a7237de-0d6c-4fc4-a045-427e4df29941', N'Océano Ártico', 0, 1, N'c3a2166e-de24-46d3-a918-11d6b286cc1a', CAST(N'2024-05-06T15:19:40.153' AS DateTime), CAST(N'2024-05-06T15:19:40.153' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'cde0a066-55e8-4f28-b3ba-4297ebdf0cc2', N'normal', 0, 1, N'a4e255f2-3c31-4174-baa7-d1e1bf356b4a', CAST(N'2024-05-19T18:26:24.477' AS DateTime), CAST(N'2024-05-19T18:26:24.477' AS DateTime), 0, N'bfef5abf-cff4-460b-a3af-55630d81066a')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'e08c6032-29b3-4a96-8e78-429a7ec75082', N'Montaña K2', 0, 1, N'494aec55-c94c-4e71-94cf-dd101e545458', CAST(N'2024-05-14T17:15:37.340' AS DateTime), CAST(N'2024-05-14T17:15:37.340' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'4067e6dd-a7b4-4b2c-89d5-42d14d2a615d', N'De acuerdo', 0, 1, N'd8585a71-6633-403a-857d-5e042524c98f', CAST(N'2024-07-03T14:43:33.893' AS DateTime), CAST(N'2024-07-03T14:43:33.893' AS DateTime), 4, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'13386593-e55e-4d6d-a027-4311d6cee08d', N'Océano Índico', 0, 1, N'c3a2166e-de24-46d3-a918-11d6b286cc1a', CAST(N'2024-05-06T15:19:40.150' AS DateTime), CAST(N'2024-05-06T15:19:40.150' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'96c0cb9f-5048-48d7-a454-4389d42efa0a', N'Ejemplo Opcion 4', 0, 1, N'812b0e64-0b5e-4742-a260-a5eb8b09d89f', CAST(N'2024-07-03T12:23:31.020' AS DateTime), CAST(N'2024-07-03T12:23:31.020' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'7aa72135-aafa-43f9-92b1-4470d1c34670', N'París', 1, 1, N'e21a8ca2-e2a6-4d4e-a739-d44f132aa2aa', CAST(N'2024-05-14T17:15:37.337' AS DateTime), CAST(N'2024-05-14T17:15:37.337' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'0511e931-e940-438a-901f-44f9cc2fc488', N'Ejemplo Opcion 4', 0, 1, N'450e7cda-1c03-4a33-abe9-720fd4a2fe7d', CAST(N'2024-07-03T12:23:31.027' AS DateTime), CAST(N'2024-07-03T12:23:31.027' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'5d7caa06-7a69-4268-b467-45810a048e3c', N'Jane Austen', 0, 1, N'546b1a00-fa38-4ceb-be54-83ca7dd923c9', CAST(N'2024-05-06T15:19:40.180' AS DateTime), CAST(N'2024-05-06T15:19:40.180' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'8c236bc3-b386-425f-aefa-4599f56cb427', N'¿Cuál es el evento histórico que ocurrió el 15 de agosto de 1914?', 0, 1, N'768d597b-102e-4a6a-ac31-a43d22726e47', CAST(N'2024-06-03T16:18:15.330' AS DateTime), CAST(N'2024-06-03T16:18:15.330' AS DateTime), 0, N'bfef5abf-cff4-460b-a3af-55630d81066a')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'39868208-b07c-462b-9ca5-45b7057ebd13', N'Ejemploc', 0, 1, N'd02c70c9-b921-446c-ad76-45f9650712cb', CAST(N'2024-07-03T11:55:14.123' AS DateTime), CAST(N'2024-07-03T11:55:14.123' AS DateTime), 0, N'1e2e9f6c-4c7f-4142-8317-c398db956764')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'e56985f6-4017-424b-a402-4603e464a88c', N'Neptuno', 0, 1, N'ae85ef32-0e82-487f-a2c1-6d1b5b6477ff', CAST(N'2024-05-06T15:19:40.173' AS DateTime), CAST(N'2024-05-06T15:19:40.173' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'e2628f33-2e72-45ee-93c2-4629172a5743', N'Ejemplo Opcion 7', 0, 1, N'c4273e68-8869-4369-9eac-259ba870b163', CAST(N'2024-07-03T13:32:39.983' AS DateTime), CAST(N'2024-07-03T13:32:39.983' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'7932e152-1393-4f71-95c8-469ff468cd3c', N'Moscú', 1, 1, N'588e2705-8a7d-417d-977d-61fcd1e38863', CAST(N'2024-05-14T17:15:37.370' AS DateTime), CAST(N'2024-05-14T17:15:37.370' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'cc8334da-a245-4292-8359-470dd1a5e4b7', N'Clásica', 0, 1, N'253efaf1-4751-416d-aebd-3f82ca9ecc86', CAST(N'2024-05-17T11:36:59.190' AS DateTime), CAST(N'2024-05-17T11:36:59.190' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'bbd44559-7705-45b5-a2b8-474824a9bf2f', N'Neil Armstrong', 0, 1, N'c29f1d5d-90db-41ff-ba8b-8c2cd25354e0', CAST(N'2024-05-14T17:15:37.350' AS DateTime), CAST(N'2024-05-14T17:15:37.350' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'9477d871-3e6e-4e9e-8598-4887d7723ba3', N'12', 1, 1, N'415aa7b1-846e-430e-8687-96789fcdac9b', CAST(N'2024-06-18T16:40:29.753' AS DateTime), CAST(N'2024-06-18T16:40:35.743' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'e06fc25f-080f-46dd-8dea-48b80fbb77a3', N'Ejemplo Opcion 9', 0, 1, N'9d6aa9f8-e6a9-4dd9-ade8-d0e2d0e53309', CAST(N'2024-06-18T17:48:28.877' AS DateTime), CAST(N'2024-06-18T17:48:28.877' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'edb1aad2-9103-4598-9351-48d0b36e5cc3', N'Jules Verne', 0, 1, N'2e3c17ca-b700-48e1-be55-636ddbf6995d', CAST(N'2024-05-18T20:06:22.270' AS DateTime), CAST(N'2024-05-18T20:06:22.270' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'b3dac952-4751-4f95-babd-48f9771dd6a4', N'Acción', 0, 1, N'6122e532-6296-4b7f-b2cf-a91b1e1ce8a2', CAST(N'2024-05-17T11:36:59.203' AS DateTime), CAST(N'2024-05-17T11:36:59.203' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'a58cefa5-208f-491f-a545-49008de3b4b8', N'b', 0, 1, N'25a40b35-3438-4acd-a267-3edd3dcb550b', CAST(N'2024-06-18T16:41:33.317' AS DateTime), CAST(N'2024-06-18T16:41:33.317' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'cd2b374a-1c41-4fbc-8a24-4929416a2ca8', N'EjemploD', 0, 1, N'4d30043b-9bbf-4dac-8e4c-c3663eb83655', CAST(N'2024-06-19T12:00:32.247' AS DateTime), CAST(N'2024-06-19T12:00:32.247' AS DateTime), 0, N'bfef5abf-cff4-460b-a3af-55630d81066a')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'139bdd79-08c1-45b5-aaf8-495bea39fab5', N'dos', 0, 1, N'afc45722-88ba-410f-affc-88f0f17ed624', CAST(N'2024-05-13T15:24:55.300' AS DateTime), CAST(N'2024-05-13T15:24:55.300' AS DateTime), 2, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'a98580df-5549-4807-9aae-49f6573ffafe', N'Aluminio', 0, 1, N'eb983094-689e-4469-9700-09ab87c6da04', CAST(N'2024-05-14T17:15:37.367' AS DateTime), CAST(N'2024-05-14T17:15:37.367' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'0261c894-a734-4387-95da-49fae3781e14', N'de op 1', 0, 1, N'642f2953-674c-429c-a6f6-66f87770a362', CAST(N'2024-05-13T15:22:07.753' AS DateTime), CAST(N'2024-05-13T15:22:07.753' AS DateTime), 4, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'987a48bb-aecd-47dd-8e80-4a369fb31f49', N'Siempre', 0, 1, N'4b64542b-5941-4b53-935f-8269262a93d4', CAST(N'2024-07-03T13:22:31.030' AS DateTime), CAST(N'2024-07-03T13:22:31.030' AS DateTime), 5, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'd16dce49-ae5c-4a67-8daa-4a5915470e4c', N'Bicicleta', 0, 1, N'768ae381-8735-43ad-8c33-77b4836a070f', CAST(N'2024-05-17T11:36:59.210' AS DateTime), CAST(N'2024-05-17T11:36:59.210' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'af29200f-a727-493d-b8a9-4a6846674aa4', N'Ejemplo Opcion 10', 0, 1, N'9845c3de-be89-4405-8cc6-5422f6928eb9', CAST(N'2024-06-18T17:48:28.870' AS DateTime), CAST(N'2024-06-18T17:48:28.870' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'1b3e9892-823f-484b-9d59-4a7d13309404', N'Rara Vez', 0, 1, N'b0426a57-6d19-4453-9640-4839197e8859', CAST(N'2024-06-19T12:11:07.057' AS DateTime), CAST(N'2024-06-19T12:11:07.057' AS DateTime), 2, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'ddb652e0-b144-431a-9885-4a831a907659', N'Rara Vez', 0, 1, N'a0ac946e-46c8-4121-8498-40e3a2617213', CAST(N'2024-06-19T12:10:52.713' AS DateTime), CAST(N'2024-06-19T12:10:52.713' AS DateTime), 2, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'00313b1b-fb87-4e56-ab5d-4bd37b6698df', N'1945', 1, 1, N'8d107d91-0768-4810-bced-29dfc6815825', CAST(N'2024-05-14T17:15:37.350' AS DateTime), CAST(N'2024-05-14T17:15:37.350' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'9b05ebf7-f024-4d44-b8dc-4be02553d30d', N'Rara Vez', 0, 1, N'e02c5ef7-11bf-4f62-ba9a-34b280af069a', CAST(N'2024-06-18T16:10:46.520' AS DateTime), CAST(N'2024-06-18T16:10:46.520' AS DateTime), 2, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'e60c85aa-5107-4516-95a6-4d077ca25651', N'Buzz Aldrin', 0, 1, N'0f480871-91b1-4cb3-b489-acca5c45edd1', CAST(N'2024-05-18T20:06:22.280' AS DateTime), CAST(N'2024-05-18T20:06:22.280' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'867933ed-14e4-4327-acb6-4d1741444341', N'Doctorado', 0, 1, N'5cb81db3-01ac-49b5-9855-e8f9b686a99f', CAST(N'2024-05-17T11:36:59.173' AS DateTime), CAST(N'2024-05-17T11:36:59.173' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'77d71b2a-346d-4170-a368-4d7ab859a3fc', N'De acuerdo', 0, 1, N'0df5898c-37bb-49e9-b288-3888bafd62f4', CAST(N'2024-07-03T14:43:33.877' AS DateTime), CAST(N'2024-07-03T14:43:33.877' AS DateTime), 4, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'e6f4c024-787d-4d4c-a3b3-4dcbd4103106', N'Siempre', 0, 1, N'fa5519d0-d84c-45d7-aa53-2234c77fff60', CAST(N'2024-06-19T12:11:14.570' AS DateTime), CAST(N'2024-06-19T12:11:14.570' AS DateTime), 5, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'7c8088ee-3933-4d4e-a873-4e7baea81272', N'Ejemplo Opcion 5', 0, 1, N'aed89eab-a165-406f-926d-689ef0fa2ccb', CAST(N'2024-07-03T13:32:39.990' AS DateTime), CAST(N'2024-07-03T13:32:39.990' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'8c3538f9-036e-4e8d-a3ee-4f367066adab', N'Rock', 0, 1, N'253efaf1-4751-416d-aebd-3f82ca9ecc86', CAST(N'2024-05-17T11:36:59.187' AS DateTime), CAST(N'2024-05-17T11:36:59.187' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'40345ff8-7b59-4671-9155-4fffc91b79cb', N'Nunca', 0, 1, N'e02c5ef7-11bf-4f62-ba9a-34b280af069a', CAST(N'2024-06-18T16:10:46.517' AS DateTime), CAST(N'2024-06-18T16:10:46.517' AS DateTime), 1, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'68c9c4fd-cef3-4b61-b95b-50db896cc643', N'2', 0, 1, N'8b8c5642-1e5a-4cd9-a6c0-899eb7c30192', CAST(N'2024-06-18T16:40:48.627' AS DateTime), CAST(N'2024-06-18T16:40:48.627' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'c625fc61-e57d-4898-85af-51081e589661', N'Neil Armstrong', 0, 1, N'e2b3cbeb-3e97-4e0b-993a-4123bec5538c', CAST(N'2024-05-06T15:19:40.167' AS DateTime), CAST(N'2024-05-06T15:19:40.167' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'fcf7e6f3-94c3-49ae-9d42-511c204daa82', N'Ejemplo Opcion 10', 0, 1, N'f5535438-f8f2-441d-b3ce-266d618d8301', CAST(N'2024-07-03T13:32:40.010' AS DateTime), CAST(N'2024-07-03T13:32:40.010' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'9f293b79-cccc-4212-8bc9-511d079fb522', N'Berlín', 0, 1, N'baa87899-d51f-4893-a1fa-882556a8d2a4', CAST(N'2024-05-06T15:19:40.157' AS DateTime), CAST(N'2024-05-06T15:19:40.157' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'f9d26e4d-15cc-49b0-9f8d-512849478ef8', N'Neutral', 0, 1, N'd8585a71-6633-403a-857d-5e042524c98f', CAST(N'2024-07-03T14:43:33.893' AS DateTime), CAST(N'2024-07-03T14:43:33.893' AS DateTime), 3, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'882b8c48-82ba-4b92-b288-5170f8e7882c', N'Océano Índico', 0, 1, N'17944192-2c92-4b92-af87-94ce8928651e', CAST(N'2024-05-18T20:06:22.260' AS DateTime), CAST(N'2024-05-18T20:06:22.260' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'95ba8e34-1b04-4114-ab87-525d53859119', N'Metal', 0, 1, N'253efaf1-4751-416d-aebd-3f82ca9ecc86', CAST(N'2024-05-17T11:36:59.193' AS DateTime), CAST(N'2024-05-17T11:36:59.193' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'deddd511-ebd6-4e7b-b644-52cf712618e5', N'Saturno', 0, 1, N'697a8471-4b6a-4422-b4e7-a1c8de4d72c7', CAST(N'2024-05-18T20:06:22.287' AS DateTime), CAST(N'2024-05-18T20:06:22.287' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'7c3baa8f-07c4-4789-b01f-52fc8bd25d42', N'Ejemplo Opcion 9', 0, 1, N'93a7cd55-8c95-4ace-9468-e3a78528fa74', CAST(N'2024-07-03T13:32:40.017' AS DateTime), CAST(N'2024-07-03T13:32:40.017' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'db30d481-224c-4faa-a54c-530d1190b6d0', N'esta es la op 2', 0, 1, N'2f4a9a17-f878-4788-8a84-0ace26143d43', CAST(N'2024-05-13T15:25:20.927' AS DateTime), CAST(N'2024-05-13T15:25:20.927' AS DateTime), 2, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'06a228b8-46ea-4324-81ea-5316ca15354a', N'Ejemplo Opcion 9', 0, 1, N'2f722edf-8c3b-4682-8abf-c8305c2d18ca', CAST(N'2024-06-18T17:48:28.860' AS DateTime), CAST(N'2024-06-18T17:48:28.860' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'829d6b4e-a4f7-41d2-bb3a-531f476d3c93', N'Yuan', 0, 1, N'63afe949-1674-421a-8cce-463e7e6ba267', CAST(N'2024-05-18T20:06:22.290' AS DateTime), CAST(N'2024-05-18T20:06:22.290' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'bdf274ef-39af-4f3c-8af6-53b4155d3fcb', N'Primavera', 0, 1, N'24376bf1-0aa7-4b93-9e49-d1d3b983d036', CAST(N'2024-05-17T11:36:59.237' AS DateTime), CAST(N'2024-05-17T11:36:59.237' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'22687fa2-601c-4b27-ba04-53b56b3ee43b', N'A Veces', 0, 1, N'4b64542b-5941-4b53-935f-8269262a93d4', CAST(N'2024-07-03T13:22:31.030' AS DateTime), CAST(N'2024-07-03T13:22:31.030' AS DateTime), 3, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'fbd06608-e33e-4dc8-89ad-540348cc682c', N'Neptuno', 0, 1, N'697a8471-4b6a-4422-b4e7-a1c8de4d72c7', CAST(N'2024-05-18T20:06:22.287' AS DateTime), CAST(N'2024-05-18T20:06:22.287' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'589e09b4-1900-4791-852b-54a0786162ef', N'Ejemplo Opcion 6', 0, 1, N'9a431a9c-1aaa-4616-8b4b-bbf6c34082de', CAST(N'2024-06-18T17:48:28.863' AS DateTime), CAST(N'2024-06-18T17:48:28.863' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'3085ce75-e292-4efc-9b11-54a40dfba15c', N'ddad', 1, 1, N'4d6449d8-69a2-4062-a77d-f3f9e3a3777f', CAST(N'2024-06-19T11:46:31.547' AS DateTime), CAST(N'2024-06-19T11:46:31.547' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'26eb1536-1a2f-4981-8223-54def049c9de', N'Agua', 0, 1, N'331bea1d-cf31-4085-bda8-fc1544356c4d', CAST(N'2024-05-17T11:36:59.220' AS DateTime), CAST(N'2024-05-17T11:36:59.220' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'ee5da439-31fd-4ca7-8ecb-5515e3763c18', N'Nunca', 0, 1, N'5bfc42e7-4c0e-43af-83e8-8721e3a6d8df', CAST(N'2024-06-12T17:32:03.220' AS DateTime), CAST(N'2024-06-12T17:32:03.220' AS DateTime), 1, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'eb6d3dea-8a91-485e-b09d-55aa6d3bc7d4', N'A Veces', 0, 1, N'a924c254-6554-4b24-8fae-47163f0ebb93', CAST(N'2024-06-18T15:58:50.337' AS DateTime), CAST(N'2024-06-18T15:58:50.337' AS DateTime), 3, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'43025975-9f74-4e74-9cbe-5660f9ca8a55', N'George Washington', 1, 1, N'bd26060a-0a5f-4dca-9ce3-14bd3bda2ae7', CAST(N'2024-05-14T17:15:37.347' AS DateTime), CAST(N'2024-05-14T17:15:37.347' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'0d1f8553-9f1e-4002-a795-56b0fac2506c', N'Ejemplo Opcion 3', 0, 1, N'f5535438-f8f2-441d-b3ce-266d618d8301', CAST(N'2024-07-03T13:32:40.003' AS DateTime), CAST(N'2024-07-03T13:32:40.003' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'a5a2954e-ed85-4c63-b221-56eb65bb41fc', N'Frecuentemente', 0, 1, N'f0b0ac75-b7bb-472f-b612-20a394e71343', CAST(N'2024-06-12T14:23:58.077' AS DateTime), CAST(N'2024-06-12T14:23:58.077' AS DateTime), 4, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'a37c16d4-a169-4cd5-8ac5-57765564b36f', N'Madrid', 0, 1, N'baa87899-d51f-4893-a1fa-882556a8d2a4', CAST(N'2024-05-06T15:19:40.157' AS DateTime), CAST(N'2024-05-06T15:19:40.157' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'aeb73aa4-e7e4-4c86-846b-577925cd9f8a', N'Ron', 0, 1, N'331bea1d-cf31-4085-bda8-fc1544356c4d', CAST(N'2024-05-17T11:36:59.223' AS DateTime), CAST(N'2024-05-17T11:36:59.223' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'0b80366a-3e39-4b27-a0dc-5822434b6ceb', N'Frecuentemente', 0, 1, N'e02c5ef7-11bf-4f62-ba9a-34b280af069a', CAST(N'2024-06-18T16:10:46.520' AS DateTime), CAST(N'2024-06-18T16:10:46.520' AS DateTime), 4, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'5eddc9af-c46e-4244-ab2d-5864dba38f79', N'Ejemplo', 0, 1, N'7beb9206-245a-4fc2-a631-c8a6e38106b6', CAST(N'2024-07-03T11:55:14.130' AS DateTime), CAST(N'2024-07-03T11:55:14.130' AS DateTime), 0, N'bfef5abf-cff4-460b-a3af-55630d81066a')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'5e593b5c-96b1-4e31-8e45-591d6703bafe', N'Francia', 1, 1, N'2e72a58f-12e4-4d00-8857-50d25671d4a1', CAST(N'2024-05-14T17:15:37.377' AS DateTime), CAST(N'2024-05-14T17:15:37.377' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'b7d6d749-7d9d-4294-8ed5-594685709173', N'Ejemploc', 0, 1, N'912583c5-89cf-46d6-9366-e512187830a1', CAST(N'2024-07-03T11:55:14.120' AS DateTime), CAST(N'2024-07-03T11:55:14.123' AS DateTime), 0, N'1e2e9f6c-4c7f-4142-8317-c398db956764')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'e8487d42-ea95-4cb1-a4de-5964fe27e94f', N'Plata', 0, 1, N'f8499c7e-6912-4b18-8819-ccbdbe4bfb94', CAST(N'2024-05-14T17:15:37.353' AS DateTime), CAST(N'2024-05-14T17:15:37.353' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'2dbb75d8-dc74-44b6-807a-597c2f7e5931', N'¿Cuánto tiempo tardó en transmitirse el primer mensaje a través del telégrafo transatlántico?', 0, 1, N'c23d1534-c010-4e7a-b2e7-38f4ab6eff33', CAST(N'2024-06-03T16:18:15.333' AS DateTime), CAST(N'2024-06-12T12:15:32.907' AS DateTime), 0, N'357dbf15-2a3e-4424-9005-9325bba3462c')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'2e73741b-2bc0-49de-8760-59a71fd36be0', N'Montaña Kilimanjaro', 0, 1, N'8af5bd89-7624-495b-81e1-d642dc9cdcb3', CAST(N'2024-05-18T20:06:22.267' AS DateTime), CAST(N'2024-05-18T20:06:22.267' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'2acd946c-3a08-49c3-87eb-59df52a8ad35', N'Océano Pacífico', 0, 1, N'c3a2166e-de24-46d3-a918-11d6b286cc1a', CAST(N'2024-05-06T15:19:40.150' AS DateTime), CAST(N'2024-05-06T15:19:40.150' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'88cbc3d2-3a56-4a2d-9246-5a3d259a4669', N'Ejemplo Opcion 5', 0, 1, N'9d6aa9f8-e6a9-4dd9-ade8-d0e2d0e53309', CAST(N'2024-06-18T17:48:28.877' AS DateTime), CAST(N'2024-06-18T17:48:28.877' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'cd40b4f0-fe09-4ec6-bb7f-5b9cfa272fd0', N'Rara Vez', 0, 1, N'4b64542b-5941-4b53-935f-8269262a93d4', CAST(N'2024-07-03T13:22:31.030' AS DateTime), CAST(N'2024-07-03T13:22:31.030' AS DateTime), 2, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'3d8ce7be-8f81-457f-9c7b-5c078506d818', N'Rara Vez', 0, 1, N'4561f5f6-1c0d-496d-9ddb-adb0157b4a92', CAST(N'2024-07-03T13:16:16.593' AS DateTime), CAST(N'2024-07-03T13:16:16.593' AS DateTime), 2, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'76e6531f-3453-4a28-9b99-5c57bd5adace', N'Golf', 0, 1, N'd34fb3e9-1be1-41bd-b542-957a78db78b7', CAST(N'2024-05-17T11:36:59.197' AS DateTime), CAST(N'2024-05-17T11:36:59.197' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'10436311-e4b0-4009-899b-5c9676ab02a4', N'Nunca', 0, 1, N'a0ac946e-46c8-4121-8498-40e3a2617213', CAST(N'2024-06-19T12:10:52.710' AS DateTime), CAST(N'2024-06-19T12:10:52.710' AS DateTime), 1, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'9c5f8b17-0a39-4929-a949-5cf06000cebb', N'Nunca', 0, 1, N'f0b0ac75-b7bb-472f-b612-20a394e71343', CAST(N'2024-06-12T14:23:58.077' AS DateTime), CAST(N'2024-06-12T14:23:58.077' AS DateTime), 1, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'f39c3644-1606-48a3-9327-5d1345b3eced', N'Neutral', 0, 1, N'9f118e9f-8fd8-42f7-bced-3dd76988cdb2', CAST(N'2024-07-03T14:43:33.883' AS DateTime), CAST(N'2024-07-03T14:43:33.883' AS DateTime), 3, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'648318a9-647a-4deb-9156-5d18b019ace0', N'Río Nilo', 1, 1, N'9d3385e6-863e-4e5c-b5ab-d4cc9be20991', CAST(N'2024-05-18T20:06:22.270' AS DateTime), CAST(N'2024-05-18T20:06:22.270' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'75fd3efb-ef17-43da-8c43-5deefd66624d', N'prueba op 2', 0, 1, N'828020ba-8f8c-4650-9fe0-7e44cd9f8088', CAST(N'2024-05-17T14:55:06.967' AS DateTime), CAST(N'2024-05-17T14:55:06.967' AS DateTime), 0, N'357dbf15-2a3e-4424-9005-9325bba3462c')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'b2e3fb31-b3b2-4554-86f7-5df92eb294de', N'Charles Dickens', 0, 1, N'88cdf9fd-996b-4a03-b3d2-1ab46293aa9d', CAST(N'2024-05-18T20:06:22.293' AS DateTime), CAST(N'2024-05-18T20:06:22.293' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'fdc063de-d264-425b-9b58-5e424e608e39', N'Ejemplo', 0, 1, N'bb1e7ac7-c516-4341-bbda-73dbc86dd1fc', CAST(N'2024-06-19T09:54:32.800' AS DateTime), CAST(N'2024-06-19T09:55:04.430' AS DateTime), 0, N'bfef5abf-cff4-460b-a3af-55630d81066a')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'188a2a14-cc4a-4cc8-a9c3-5e678a91099e', N'Río Yangtsé', 0, 1, N'9d3385e6-863e-4e5c-b5ab-d4cc9be20991', CAST(N'2024-05-18T20:06:22.270' AS DateTime), CAST(N'2024-05-18T20:06:22.270' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'99947f84-5e72-4933-a195-5e836e3f10ba', N'esta es la op 1', 0, 1, N'695f6412-574f-4c5b-9de1-172db0e97d6f', CAST(N'2024-05-10T17:09:38.913' AS DateTime), CAST(N'2024-05-13T11:49:11.780' AS DateTime), 5, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'1039782e-48e0-4c2b-b34f-5e9ce1c965c0', N'Ejemplo Opcion 8', 0, 1, N'93a7cd55-8c95-4ace-9468-e3a78528fa74', CAST(N'2024-07-03T13:32:40.013' AS DateTime), CAST(N'2024-07-03T13:32:40.013' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'dc84608d-b178-496f-9396-5f2d15bd45a3', N'Ejemploa', 0, 1, N'73868e25-9aec-482d-b4ac-629b97a2dffe', CAST(N'2024-07-03T11:55:14.130' AS DateTime), CAST(N'2024-07-03T11:55:14.130' AS DateTime), 0, N'357dbf15-2a3e-4424-9005-9325bba3462c')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'295b5f29-b801-46c0-86a3-5f31744a2b06', N'Frecuentemente', 0, 1, N'19850dc1-0247-44c6-9774-aa733a61ce45', CAST(N'2024-07-03T13:16:16.600' AS DateTime), CAST(N'2024-07-03T13:16:16.600' AS DateTime), 4, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'216cdd75-37d6-49f8-aece-5f363102dc18', N'Rara Vez', 0, 1, N'1c8f5d74-122b-4c41-8c88-7815d790d9ec', CAST(N'2024-06-18T16:10:51.040' AS DateTime), CAST(N'2024-06-18T16:10:51.040' AS DateTime), 2, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'9d09a9a6-9ad8-4bfc-8422-5f8ed4697dd3', N'Ejemplo Opcion 2', 0, 1, N'3a113ec5-79f5-40e6-93af-6971eccea36a', CAST(N'2024-07-03T12:23:31.030' AS DateTime), CAST(N'2024-07-03T12:23:31.030' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'4ffa61db-a71f-40ec-a5a5-5ff21a3e23c7', N'Urano', 0, 1, N'36e791c5-4812-4cca-888c-7ba831f26df5', CAST(N'2024-05-14T17:15:37.360' AS DateTime), CAST(N'2024-05-14T17:15:37.360' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'4131c4eb-fa37-4f94-97e4-604d817e98d9', N'Ejemplo Opcion 8', 0, 1, N'aed89eab-a165-406f-926d-689ef0fa2ccb', CAST(N'2024-07-03T13:32:39.993' AS DateTime), CAST(N'2024-07-03T13:32:39.993' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'a1bafde4-841a-45d2-bae5-608b329abdd0', N'Montaña Kilimanjaro', 0, 1, N'494aec55-c94c-4e71-94cf-dd101e545458', CAST(N'2024-05-14T17:15:37.340' AS DateTime), CAST(N'2024-05-14T17:15:37.340' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'28f41f04-d8b4-42cf-bc41-618d98685095', N'Totalmente en desacuerdo', 0, 1, N'60e85430-d266-481d-ab99-90b825ba4ed7', CAST(N'2024-06-19T11:51:12.140' AS DateTime), CAST(N'2024-06-19T11:51:12.140' AS DateTime), 1, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'730ceb61-4998-4379-aaf1-61d573f9ae3f', N'7-8 horas', 0, 1, N'bae6adba-4464-48fb-b80c-71ef136b44a1', CAST(N'2024-05-17T11:36:59.233' AS DateTime), CAST(N'2024-05-17T11:36:59.233' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'd3b39c7c-f183-46b3-a0e3-6255464bf467', N'Magnesio', 0, 1, N'a521fe33-f349-4279-9ee9-fb9b4dec34bc', CAST(N'2024-05-06T15:19:40.180' AS DateTime), CAST(N'2024-05-06T15:19:40.180' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'17ba4837-be75-4b0e-8b6e-62e486adfa06', N'Transpiración', 0, 1, N'a832fc7d-fc43-42e1-ab7c-6d6144832af8', CAST(N'2024-05-06T15:19:40.177' AS DateTime), CAST(N'2024-05-06T15:19:40.177' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'a4c76f05-9ab8-4f37-b024-63083dde8312', N'¿Cuál es el numero dorsal que va a tener en la camiseta Kylian Mbappé en el Real Madrid?', 0, 1, N'c23d1534-c010-4e7a-b2e7-38f4ab6eff33', CAST(N'2024-06-03T16:18:15.333' AS DateTime), CAST(N'2024-06-12T12:15:32.910' AS DateTime), 0, N'bfef5abf-cff4-460b-a3af-55630d81066a')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'c44b145f-9521-4554-9a15-63b73b03f620', N'Pablo Picasso', 0, 1, N'17f78458-362d-4b64-b1ef-1c2a868733f9', CAST(N'2024-05-14T17:15:37.337' AS DateTime), CAST(N'2024-05-14T17:15:37.337' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'a4a81754-156d-47e6-b33a-63e75b6856d6', N'No', 0, 1, N'6ff61c7b-7c24-41f2-b637-882d0a96f4b4', CAST(N'2024-05-17T11:36:59.160' AS DateTime), CAST(N'2024-05-17T11:36:59.160' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'3021b580-f27f-4c46-a811-63ebd76c8107', N'Ejemplo Opcion 1', 1, 1, N'812b0e64-0b5e-4742-a260-a5eb8b09d89f', CAST(N'2024-07-03T12:23:31.020' AS DateTime), CAST(N'2024-07-03T12:23:31.020' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'2e9a20d6-23f6-447b-bd91-6500e3736a31', N'mi opcion 1', 0, 1, N'cf780862-6965-4ccf-a3ec-7c881fefc436', CAST(N'2024-05-19T18:25:59.697' AS DateTime), CAST(N'2024-05-19T18:25:59.697' AS DateTime), 0, N'357dbf15-2a3e-4424-9005-9325bba3462c')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'9b6ad78d-9f75-4721-8da8-655006c8796b', N'Totalmente de acuerdo', 0, 1, N'413ba92b-3c48-496e-9edd-0c45029a9f5c', CAST(N'2024-06-19T11:51:12.137' AS DateTime), CAST(N'2024-06-19T11:51:12.137' AS DateTime), 5, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'0019ad18-16be-407e-b16d-655fc92033f4', N'Carne de cerdo', 0, 1, N'fbdb896d-999e-4123-9d57-804508ddd7c1', CAST(N'2024-05-17T11:36:59.183' AS DateTime), CAST(N'2024-05-17T11:36:59.183' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'54343dba-875f-4675-bcb2-656b868544f3', N'Ejemplo Opcion 7', 0, 1, N'93a7cd55-8c95-4ace-9468-e3a78528fa74', CAST(N'2024-07-03T13:32:40.013' AS DateTime), CAST(N'2024-07-03T13:32:40.013' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'b6f296d8-273d-4e9d-9808-65a3c1173e4a', N'Facilidad de uso', 0, 1, N'73d8da63-da2d-4147-beb4-4abe18986e2b', CAST(N'2024-05-17T11:36:59.243' AS DateTime), CAST(N'2024-05-17T11:36:59.243' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'74d22526-8314-44ed-b647-6651b0e4bf24', N'Rara Vez', 0, 1, N'19850dc1-0247-44c6-9774-aa733a61ce45', CAST(N'2024-07-03T13:16:16.600' AS DateTime), CAST(N'2024-07-03T13:16:16.600' AS DateTime), 2, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'8c7101be-ba9a-4ba1-987a-66c0b695fda5', N'A Veces', 0, 1, N'17f90498-53f6-48ba-858b-980b529aaf4e', CAST(N'2024-06-19T12:11:03.470' AS DateTime), CAST(N'2024-06-19T12:11:03.470' AS DateTime), 3, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'497ddff6-a320-4c6b-bd21-66dd4915af6b', N'Hierro', 0, 1, N'2a24fe22-f17e-4dd5-974a-171dfe3c6f9c', CAST(N'2024-05-06T15:19:40.170' AS DateTime), CAST(N'2024-05-06T15:19:40.170' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'50c8b97c-0238-42c4-b6bd-670de282be03', N'Totalmente de acuerdo', 0, 1, N'9f118e9f-8fd8-42f7-bced-3dd76988cdb2', CAST(N'2024-07-03T14:43:33.887' AS DateTime), CAST(N'2024-07-03T14:43:33.887' AS DateTime), 5, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'c0abf286-fbf7-40be-b26b-68002fddca37', N'opcionb', 0, 1, N'176464f5-9c08-422e-8fa2-eeba91ad54b7', CAST(N'2024-06-19T09:57:32.910' AS DateTime), CAST(N'2024-06-19T09:57:32.910' AS DateTime), 0, N'357dbf15-2a3e-4424-9005-9325bba3462c')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'90f5948e-3b6e-4cbf-82bf-68282204b009', N'EjemploB', 0, 1, N'bb1e7ac7-c516-4341-bbda-73dbc86dd1fc', CAST(N'2024-06-19T09:55:04.430' AS DateTime), CAST(N'2024-06-19T09:55:04.430' AS DateTime), 0, N'357dbf15-2a3e-4424-9005-9325bba3462c')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'd4ff9aac-0d0f-4257-9361-684f623ecf6a', N'Ejemplo Opcion 4', 0, 1, N'c4273e68-8869-4369-9eac-259ba870b163', CAST(N'2024-07-03T13:32:39.983' AS DateTime), CAST(N'2024-07-03T13:32:39.983' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'b063770d-8cba-43fc-9df8-696fbe6c7599', N'Recursos Humanos', 0, 1, N'e00ae793-e6c1-4a2a-8ece-142bf6b7a2ee', CAST(N'2024-05-17T11:36:59.230' AS DateTime), CAST(N'2024-05-17T11:36:59.230' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'c3bf21d3-8a4a-4ee4-a94b-69734b46ca56', N'Siempre', 0, 1, N'a924c254-6554-4b24-8fae-47163f0ebb93', CAST(N'2024-06-18T15:58:50.340' AS DateTime), CAST(N'2024-06-18T15:58:50.340' AS DateTime), 5, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'856d787d-caef-4739-8774-6a1d43545385', N'Nunca', 0, 1, N'8b05542f-0c09-435f-b3f3-56cb286a72ff', CAST(N'2024-07-03T13:22:31.017' AS DateTime), CAST(N'2024-07-03T13:22:31.017' AS DateTime), 1, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'8bf98ce6-e7b8-4bf8-b2c1-6a1fffc57247', N'Ejemplo Opcion 7', 0, 1, N'9845c3de-be89-4405-8cc6-5422f6928eb9', CAST(N'2024-06-18T17:48:28.870' AS DateTime), CAST(N'2024-06-18T17:48:28.870' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'033bb49e-97cf-4bf6-b8bb-6a739a984b2f', N'Nunca', 0, 1, N'4561f5f6-1c0d-496d-9ddb-adb0157b4a92', CAST(N'2024-07-03T13:16:16.590' AS DateTime), CAST(N'2024-07-03T13:16:16.590' AS DateTime), 1, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'f663b4c5-0216-4118-b9bd-6ab768e6ef79', N'Ejemplo Opcion 6', 0, 1, N'c4273e68-8869-4369-9eac-259ba870b163', CAST(N'2024-07-03T13:32:39.983' AS DateTime), CAST(N'2024-07-03T13:32:39.983' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'0d267995-9b0c-4e04-aaa0-6b1a91c8bb28', N'Berlín', 0, 1, N'3418513a-2424-4676-9cc1-a071fbcc32e5', CAST(N'2024-05-18T20:06:22.263' AS DateTime), CAST(N'2024-05-18T20:06:22.263' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'a5f0dc1c-d73c-49aa-b19a-6c6a3de4f112', N'Ejemplo Opcion 2', 0, 1, N'9d6aa9f8-e6a9-4dd9-ade8-d0e2d0e53309', CAST(N'2024-06-18T17:48:28.873' AS DateTime), CAST(N'2024-06-18T17:48:28.873' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'142fd1d0-2f20-46f3-bd7d-6c6e0b722260', N'Radio', 0, 1, N'8aae72a1-8f0e-4bcc-a4c4-86d7cc5bced9', CAST(N'2024-05-06T15:19:40.170' AS DateTime), CAST(N'2024-05-06T15:19:40.170' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'6cde5c1e-b0c7-4f91-9c34-6ccc4bb67306', N'Nunca', 0, 1, N'57cb8739-ba65-4027-932f-ffbfebe6eadd', CAST(N'2024-07-03T13:22:31.020' AS DateTime), CAST(N'2024-07-03T13:22:31.020' AS DateTime), 1, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'a22f5f39-9c74-4435-b98b-6d13c1106987', N'Frecuentemente', 0, 1, N'a66925cc-5701-4460-91d0-fe6af4676618', CAST(N'2024-06-18T16:00:22.873' AS DateTime), CAST(N'2024-06-18T16:00:22.873' AS DateTime), 4, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'499bbe7e-b0f8-4326-9bf1-6d6821a421ff', N'Jazz', 0, 1, N'253efaf1-4751-416d-aebd-3f82ca9ecc86', CAST(N'2024-05-17T11:36:59.190' AS DateTime), CAST(N'2024-05-17T11:36:59.190' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'24f85be7-e464-4ffa-a08e-6de126a524c5', N'Río Amazonas', 0, 1, N'9d3385e6-863e-4e5c-b5ab-d4cc9be20991', CAST(N'2024-05-18T20:06:22.270' AS DateTime), CAST(N'2024-05-18T20:06:22.270' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'6591f2e9-da8c-4c61-b6ce-6e8931112645', N'Ejemplo Opcion 2', 0, 1, N'9a431a9c-1aaa-4616-8b4b-bbf6c34082de', CAST(N'2024-06-18T17:48:28.860' AS DateTime), CAST(N'2024-06-18T17:48:28.860' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'9b529966-c380-490f-be4c-6ea9ecc37817', N'¿Qué evento significativo ocurrió el día de la caída del Muro de Berlín?', 0, 1, N'6bc1d81e-3cba-4c9c-a06e-5671ad6be6f2', CAST(N'2024-06-03T16:18:15.330' AS DateTime), CAST(N'2024-06-03T16:18:15.330' AS DateTime), 0, N'bfef5abf-cff4-460b-a3af-55630d81066a')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'1b8e8931-4e6d-4640-b535-6f0e7a06c2ae', N'Neil Armstrong', 0, 1, N'0f480871-91b1-4cb3-b489-acca5c45edd1', CAST(N'2024-05-18T20:06:22.280' AS DateTime), CAST(N'2024-05-18T20:06:22.280' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'42fec65c-e241-4f83-af49-6f683c849ee2', N'1918', 0, 1, N'52efe634-e59c-463c-9599-e88f9955094c', CAST(N'2024-05-06T15:19:40.163' AS DateTime), CAST(N'2024-05-06T15:19:40.163' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'3476c2b3-d5be-4a2d-b1a0-6fc7647aa6f7', N'Transpiración', 0, 1, N'94de16dd-f15a-49df-b82a-55143405dd9e', CAST(N'2024-05-14T17:15:37.360' AS DateTime), CAST(N'2024-05-14T17:15:37.360' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'3b1f3b58-c895-4f8e-84f7-6fd2b0707a3e', N'Porfirio Díaz', 0, 1, N'f29610cb-4dfb-4e89-9c70-bd56031bf137', CAST(N'2024-05-14T17:15:37.373' AS DateTime), CAST(N'2024-05-14T17:15:37.373' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'c7616bda-c972-478b-bb3d-6fd2f04e4227', N'De acuerdo', 0, 1, N'70b4c4fb-d8ed-49f1-bc61-65ad9489eff8', CAST(N'2024-05-14T16:59:43.417' AS DateTime), CAST(N'2024-05-15T16:25:50.970' AS DateTime), 4, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'1406904b-a816-434b-b8b7-6ff14147504f', N'b', 0, 1, N'5e89efae-a8e6-4aad-9347-a117e6df00ca', CAST(N'2024-05-14T15:49:43.743' AS DateTime), CAST(N'2024-05-14T15:49:43.743' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'c9bab1c2-aeed-4e77-a153-7009ba3036c8', N'Océano Índico', 0, 1, N'bc51aa83-4654-4be0-878f-087bde6893ec', CAST(N'2024-05-14T17:15:37.333' AS DateTime), CAST(N'2024-05-14T17:15:37.333' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'd5241910-335e-403b-bde6-70474f51fff0', N'Francia', 1, 1, N'ccc3d027-def0-424d-94c2-f03a48a91ae0', CAST(N'2024-05-06T15:19:40.187' AS DateTime), CAST(N'2024-05-06T15:19:40.187' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'6c55b1d4-57e2-4c1c-96dc-70e18d56535b', N'Thomas Jefferson', 0, 1, N'bd26060a-0a5f-4dca-9ce3-14bd3bda2ae7', CAST(N'2024-05-14T17:15:37.347' AS DateTime), CAST(N'2024-05-14T17:15:37.347' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'099bb318-3ea5-415b-99c4-7164f32f6526', N'Ejemplo Opcion 2', 0, 1, N'9845c3de-be89-4405-8cc6-5422f6928eb9', CAST(N'2024-06-18T17:48:28.867' AS DateTime), CAST(N'2024-06-18T17:48:28.867' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'36dfa12c-f173-44db-8a4e-71ad21170938', N'Romance', 0, 1, N'6122e532-6296-4b7f-b2cf-a91b1e1ce8a2', CAST(N'2024-05-17T11:36:59.210' AS DateTime), CAST(N'2024-05-17T11:36:59.210' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'45c364bb-e191-475f-8f2b-71ccad8989a0', N'a', 1, 1, N'de3ebcdd-9365-4c51-be79-e7d2ab07e3b7', CAST(N'2024-06-18T16:41:46.897' AS DateTime), CAST(N'2024-06-18T16:41:46.897' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'2d90ea1a-f477-41ce-9f72-726573982c9e', N'Yen', 1, 1, N'e033dd49-efc7-4cc3-8553-44134c409196', CAST(N'2024-05-14T17:15:37.363' AS DateTime), CAST(N'2024-05-14T17:15:37.363' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'3038aa4b-3821-43a6-8ec7-729404b782e6', N'Gerencia', 0, 1, N'e00ae793-e6c1-4a2a-8ece-142bf6b7a2ee', CAST(N'2024-05-17T11:36:59.230' AS DateTime), CAST(N'2024-05-17T11:36:59.230' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'91fc2415-9090-46c9-a5dc-730156f0766f', N'Montaña Kilimanjaro', 0, 1, N'f48a82eb-8845-4172-b53d-b3cd42ffa07e', CAST(N'2024-05-06T15:19:40.157' AS DateTime), CAST(N'2024-05-06T15:19:40.157' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'ac28830f-acf5-420e-94d7-73071b652962', N'Neutral', 0, 1, N'943e4c32-92d1-484c-840f-27f1f22a00d7', CAST(N'2024-07-03T14:43:33.887' AS DateTime), CAST(N'2024-07-03T14:43:33.887' AS DateTime), 3, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'a230ab4d-671f-4441-9764-7310c0badde4', N'Monte Everest', 1, 1, N'494aec55-c94c-4e71-94cf-dd101e545458', CAST(N'2024-05-14T17:15:37.340' AS DateTime), CAST(N'2024-05-14T17:15:37.340' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'4d01822b-8a21-46d1-9635-7323e64a6aaf', N'1939', 0, 1, N'8d107d91-0768-4810-bced-29dfc6815825', CAST(N'2024-05-14T17:15:37.350' AS DateTime), CAST(N'2024-05-14T17:15:37.350' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'32a76ba2-ea57-4d24-a686-733a785fcb81', N'Nunca', 0, 1, N'98cc12a2-988e-4884-8d8e-b33999cb7e38', CAST(N'2024-07-03T13:16:16.587' AS DateTime), CAST(N'2024-07-03T13:16:16.587' AS DateTime), 1, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'26d234d0-4f1d-4c4e-b693-737fa1aba425', N'Ejemplo Opcion 7', 0, 1, N'9a431a9c-1aaa-4616-8b4b-bbf6c34082de', CAST(N'2024-06-18T17:48:28.863' AS DateTime), CAST(N'2024-06-18T17:48:28.863' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'8fe33bfd-2c0b-47fc-9bb7-7380edb77512', N'Rara Vez', 0, 1, N'f0b0ac75-b7bb-472f-b612-20a394e71343', CAST(N'2024-06-12T14:23:58.077' AS DateTime), CAST(N'2024-06-12T14:23:58.077' AS DateTime), 2, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'ad26f1d4-17da-4638-bd61-73f31e0a167d', N'En desacuerdo', 0, 1, N'dff06a15-ed76-4999-8518-574bbb7998c3', CAST(N'2024-07-03T14:43:33.870' AS DateTime), CAST(N'2024-07-03T14:43:33.870' AS DateTime), 2, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'85922124-bbac-4a93-bc54-73f77a05288d', N'Hierro', 0, 1, N'f8499c7e-6912-4b18-8819-ccbdbe4bfb94', CAST(N'2024-05-14T17:15:37.353' AS DateTime), CAST(N'2024-05-14T17:15:37.353' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'c838c12d-b9f1-4ab8-a17d-749b7a8fa7ee', N'Totalmente en desacuerdo', 0, 1, N'eace26ab-f364-44cc-a179-cca4952a5cc4', CAST(N'2024-06-19T11:51:12.140' AS DateTime), CAST(N'2024-06-19T11:51:12.140' AS DateTime), 1, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'be471a82-3a96-42b5-b25b-74b0a3ae8d19', N'Tibia', 0, 1, N'cb0edcd3-1843-49d0-b98f-d1894a876054', CAST(N'2024-05-14T17:15:37.357' AS DateTime), CAST(N'2024-05-14T17:15:37.357' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'3d0f832d-628f-409e-9c82-7511e8c44bed', N'sfsfs', 1, 1, N'a4b0ad13-26a9-4278-b701-8ec9bf6031c3', CAST(N'2024-06-19T11:46:55.580' AS DateTime), CAST(N'2024-06-19T11:46:55.580' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'3b6c5a15-971f-44aa-a350-75b0ea0baf4e', N'Ejemplo Opcion 9', 0, 1, N'c4273e68-8869-4369-9eac-259ba870b163', CAST(N'2024-07-03T13:32:39.987' AS DateTime), CAST(N'2024-07-03T13:32:39.987' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'3bdde801-45c7-4f3d-b51a-75c88547a35a', N'Lugar de residencia', 0, 1, N'af15ba63-8426-43d9-ba74-e855cde8b47d', CAST(N'2024-05-17T11:36:59.167' AS DateTime), CAST(N'2024-05-17T11:36:59.167' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'86c24a20-7dd0-4090-82b7-76103037f5f3', N'Titanio', 0, 1, N'a521fe33-f349-4279-9ee9-fb9b4dec34bc', CAST(N'2024-05-06T15:19:40.180' AS DateTime), CAST(N'2024-05-06T15:19:40.180' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'dfebbd23-a069-4465-9f1e-765abd591821', N'Ejemplo Opcion 7', 0, 1, N'dda0bb6e-5579-4971-a05a-a1a20c4482ac', CAST(N'2024-06-18T17:48:28.883' AS DateTime), CAST(N'2024-06-18T17:48:28.883' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'1063915b-d9f7-413b-a415-76acd336b1e6', N'Saturno', 0, 1, N'36e791c5-4812-4cca-888c-7ba831f26df5', CAST(N'2024-05-14T17:15:37.360' AS DateTime), CAST(N'2024-05-14T17:15:37.360' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'e86b3980-42b8-4dc5-a264-76faeb62ea4f', N'b', 0, 1, N'18412367-e942-4df0-9a2a-99cfe7e002a1', CAST(N'2024-06-19T09:53:17.073' AS DateTime), CAST(N'2024-06-19T09:53:17.073' AS DateTime), 0, N'1e2e9f6c-4c7f-4142-8317-c398db956764')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'440377bc-18eb-4cac-8c78-7703387138fc', N'De acuerdo', 0, 1, N'60e85430-d266-481d-ab99-90b825ba4ed7', CAST(N'2024-06-19T11:51:12.140' AS DateTime), CAST(N'2024-06-19T11:51:12.140' AS DateTime), 4, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'905939ba-2d43-4e01-8b4c-770f7ffeade3', N'H2O', 1, 1, N'04ae039c-09c6-4785-923a-98279c5fd49d', CAST(N'2024-05-18T20:06:22.307' AS DateTime), CAST(N'2024-05-18T20:06:22.307' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'8c05cbc7-c867-497d-800f-777b52422fc8', N'H2O', 1, 1, N'add6b6e1-3744-4d54-a985-8e2e9427c406', CAST(N'2024-05-06T15:19:40.190' AS DateTime), CAST(N'2024-05-09T18:03:36.963' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'cbecd095-4c93-4ebe-8f33-779a8ce3b7fc', N'Miguel de Cervantes', 0, 1, N'44f97be2-194e-40cc-9d42-9ebfd8a3aaad', CAST(N'2024-05-06T15:19:40.160' AS DateTime), CAST(N'2024-05-06T15:19:40.160' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'cf1ee12f-2c4d-4299-a2ae-77e77a259afe', N'muy bueno', 0, 1, N'2f4a9a17-f878-4788-8a84-0ace26143d43', CAST(N'2024-05-13T15:25:20.927' AS DateTime), CAST(N'2024-05-13T15:25:20.927' AS DateTime), 4, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'4ef88d0b-2ca5-45fb-953d-77ec9ee9a8a8', N'Frecuentemente', 0, 1, N'cb7f759a-4f64-4c49-8d4e-d7716784ec88', CAST(N'2024-06-12T14:51:55.910' AS DateTime), CAST(N'2024-06-12T14:51:55.910' AS DateTime), 4, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'5e2dc4c1-d678-4ad3-a0d6-77fd954edc4b', N'Ejemplo Opcion 9', 0, 1, N'aed89eab-a165-406f-926d-689ef0fa2ccb', CAST(N'2024-07-03T13:32:39.993' AS DateTime), CAST(N'2024-07-03T13:32:39.993' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'2234c1fd-def8-4f4e-9e19-783052d1f06b', N'Río Yangtsé', 0, 1, N'373a2694-c2d7-4d04-a5c6-a4b25b6bc2ce', CAST(N'2024-05-14T17:15:37.347' AS DateTime), CAST(N'2024-05-14T17:15:37.347' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'8f6a0658-fe5d-4828-9ed9-7838130f75cb', N'Totalmente de acuerdo', 0, 1, N'0d893612-4eb6-4049-a0d7-3b9ce643b426', CAST(N'2024-06-19T11:51:12.147' AS DateTime), CAST(N'2024-06-19T11:51:12.147' AS DateTime), 5, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'eb2ff3c1-e340-4f10-99c8-78562a3d7a27', N'Benito Juárez', 0, 1, N'c0362a07-5bb1-40b4-bef6-61da48da4878', CAST(N'2024-05-18T20:06:22.300' AS DateTime), CAST(N'2024-05-18T20:06:22.300' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'06cf0e2d-68d1-4ce0-a38e-787321d9dae4', N'Germinación', 0, 1, N'a832fc7d-fc43-42e1-ab7c-6d6144832af8', CAST(N'2024-05-06T15:19:40.173' AS DateTime), CAST(N'2024-05-06T15:19:40.173' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'd25002d1-f94b-4e2f-aac5-788fe3ac34a3', N'Ejemplo Opcion 1', 1, 1, N'06fb7cfc-9e4f-4c35-b6ab-1cd0d31e187a', CAST(N'2024-07-03T12:23:31.020' AS DateTime), CAST(N'2024-07-03T12:23:31.020' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'93148a66-2c82-471d-aa71-7890a21eac90', N'Siempre', 0, 1, N'98cc12a2-988e-4884-8d8e-b33999cb7e38', CAST(N'2024-07-03T13:16:16.590' AS DateTime), CAST(N'2024-07-03T13:16:16.590' AS DateTime), 5, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'c54ec09d-a6d1-438b-98ae-78b12446bd43', N'Montaña K2', 0, 1, N'8af5bd89-7624-495b-81e1-d642dc9cdcb3', CAST(N'2024-05-18T20:06:22.267' AS DateTime), CAST(N'2024-05-18T20:06:22.267' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'8aec576a-b4ff-42c9-872c-78cea7d57a72', N'Ejemplo Opcion 3', 0, 1, N'2f722edf-8c3b-4682-8abf-c8305c2d18ca', CAST(N'2024-06-18T17:48:28.857' AS DateTime), CAST(N'2024-06-18T17:48:28.857' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'fcaab136-5b77-4f32-9598-79156ae151db', N'A Veces', 0, 1, N'98cc12a2-988e-4884-8d8e-b33999cb7e38', CAST(N'2024-07-03T13:16:16.590' AS DateTime), CAST(N'2024-07-03T13:16:16.590' AS DateTime), 3, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'47b1398a-0764-422f-8d0e-7966be75e046', N'Ejemplo Opcion 4', 0, 1, N'93a7cd55-8c95-4ace-9468-e3a78528fa74', CAST(N'2024-07-03T13:32:40.010' AS DateTime), CAST(N'2024-07-03T13:32:40.010' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'1aacd171-f168-421b-bece-7b6a9bd8e133', N'Ejemplo Opcion 1', 1, 1, N'2e3772af-86f7-4b10-ab23-3c7fd119df3f', CAST(N'2024-07-03T12:23:31.030' AS DateTime), CAST(N'2024-07-03T12:23:31.030' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'6367df8c-e79b-462f-afd3-7ba138657d67', N'Totalmente en desacuerdo', 0, 1, N'dff06a15-ed76-4999-8518-574bbb7998c3', CAST(N'2024-07-03T14:43:33.870' AS DateTime), CAST(N'2024-07-03T14:43:33.870' AS DateTime), 1, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'4fd284d7-3a6a-4836-b43f-7ba79c931440', N'París', 1, 1, N'baa87899-d51f-4893-a1fa-882556a8d2a4', CAST(N'2024-05-06T15:19:40.157' AS DateTime), CAST(N'2024-05-06T15:19:40.157' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'683afd58-a88b-45aa-bb20-7bbc6132c358', N'EjemploE', 0, 1, N'20548ecc-bf50-4caf-8b89-557e148467cc', CAST(N'2024-06-19T11:59:34.727' AS DateTime), CAST(N'2024-06-19T11:59:34.727' AS DateTime), 0, N'357dbf15-2a3e-4424-9005-9325bba3462c')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'd06b65c1-959b-45eb-98c5-7c80947b841a', N'5-6 horas', 0, 1, N'bae6adba-4464-48fb-b80c-71ef136b44a1', CAST(N'2024-05-17T11:36:59.233' AS DateTime), CAST(N'2024-05-17T11:36:59.233' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'd0102646-6bbb-45f5-8799-7d48e35d51ac', N'Ejemplo Opcion 10', 0, 1, N'e20687bd-bdd9-4edf-8bf4-8caa5cb8d616', CAST(N'2024-07-03T13:32:40.000' AS DateTime), CAST(N'2024-07-03T13:32:40.000' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'130f448a-ee27-497b-bcb6-7dddc3e92070', N'Neutral', 0, 1, N'413ba92b-3c48-496e-9edd-0c45029a9f5c', CAST(N'2024-06-19T11:51:12.137' AS DateTime), CAST(N'2024-06-19T11:51:12.137' AS DateTime), 3, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'2eca5f32-6cbb-4797-89d6-7e2ab61a2cd9', N'Totalmente de acuerdo', 0, 1, N'741d8042-94e7-4865-8b44-7ab832561eba', CAST(N'2024-07-03T14:43:33.880' AS DateTime), CAST(N'2024-07-03T14:43:33.880' AS DateTime), 5, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'4d4bb9cb-7d2c-4c6e-8743-7f1915355f11', N'Ejemplo Opcion 6', 0, 1, N'2f722edf-8c3b-4682-8abf-c8305c2d18ca', CAST(N'2024-06-18T17:48:28.857' AS DateTime), CAST(N'2024-06-18T17:48:28.857' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'7edd4ed1-80df-4d0a-b43b-7fe76a7a7f4c', N'Totalmente de acuerdo', 0, 1, N'942152b7-25fc-47f6-a41d-9b420ab8231a', CAST(N'2024-06-12T14:19:17.327' AS DateTime), CAST(N'2024-06-12T14:19:17.327' AS DateTime), 5, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'e3b49431-e923-4a28-9096-805e699c5bc1', N'Té', 0, 1, N'331bea1d-cf31-4085-bda8-fc1544356c4d', CAST(N'2024-05-17T11:36:59.223' AS DateTime), CAST(N'2024-05-17T11:36:59.223' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'9d12aa92-6ae1-4cb9-99b1-80cd818e8391', N'Júpiter', 1, 1, N'697a8471-4b6a-4422-b4e7-a1c8de4d72c7', CAST(N'2024-05-18T20:06:22.287' AS DateTime), CAST(N'2024-05-18T20:06:22.287' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'16c61359-aa6c-4213-b501-80f9479bcbf6', N'Cobre', 0, 1, N'2a24fe22-f17e-4dd5-974a-171dfe3c6f9c', CAST(N'2024-05-06T15:19:40.170' AS DateTime), CAST(N'2024-05-06T15:19:40.170' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'0ffdd080-9572-4c73-87e1-8152984937fd', N'Ejemplo Opcion 7', 0, 1, N'f5535438-f8f2-441d-b3ce-266d618d8301', CAST(N'2024-07-03T13:32:40.007' AS DateTime), CAST(N'2024-07-03T13:32:40.007' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'f552a0ff-01e0-4868-956a-817149de2a69', N'Neutral', 0, 1, N'70b4c4fb-d8ed-49f1-bc61-65ad9489eff8', CAST(N'2024-05-14T16:59:43.417' AS DateTime), CAST(N'2024-05-15T16:25:50.973' AS DateTime), 3, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'a63ef88a-18cd-4715-930c-8244a85fd1e4', N'Cuando es la final de la champions', 0, 1, N'ee2e1db9-86c6-4da4-b2ed-4ed9626b4ea4', CAST(N'2024-05-21T12:25:25.560' AS DateTime), CAST(N'2024-05-21T12:25:25.560' AS DateTime), 0, N'1e2e9f6c-4c7f-4142-8317-c398db956764')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'8047989b-3ca5-49cc-9096-8294c5d3f2d5', N'Ejemplo Opcion 9', 0, 1, N'9845c3de-be89-4405-8cc6-5422f6928eb9', CAST(N'2024-06-18T17:48:28.870' AS DateTime), CAST(N'2024-06-18T17:48:28.870' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'f004d672-5d20-4644-b345-831fe7df388e', N'Titanio', 0, 1, N'10ccc4aa-9bef-4015-89bf-106ac005fb2b', CAST(N'2024-05-18T20:06:22.297' AS DateTime), CAST(N'2024-05-18T20:06:22.297' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'4bcfea33-243a-4fb9-b064-832e7833cf3b', N'Litio', 1, 1, N'eb983094-689e-4469-9700-09ab87c6da04', CAST(N'2024-05-14T17:15:37.370' AS DateTime), CAST(N'2024-05-14T17:15:37.370' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'9aa71f86-7f79-4ede-8724-83777dbd9b82', N'Totalmente en desacuerdo', 0, 1, N'70b4c4fb-d8ed-49f1-bc61-65ad9489eff8', CAST(N'2024-05-14T16:59:43.417' AS DateTime), CAST(N'2024-05-15T16:25:50.973' AS DateTime), 1, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'6ca4f326-8c16-47dd-9ac9-83b5c4af8527', N'Totalmente en desacuerdo', 0, 1, N'413ba92b-3c48-496e-9edd-0c45029a9f5c', CAST(N'2024-06-19T11:51:12.133' AS DateTime), CAST(N'2024-06-19T11:51:12.133' AS DateTime), 1, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'e4f0e938-1ab9-4d28-a06c-840707c5c2be', N'A Veces', 0, 1, N'b8e7022f-cecd-458f-b5b2-352e7ad04b32', CAST(N'2024-07-03T13:22:31.027' AS DateTime), CAST(N'2024-07-03T13:22:31.027' AS DateTime), 3, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'e1219c59-0be2-41c9-9d01-842b5d85c130', N'Totalmente en desacuerdo', 0, 1, N'9f118e9f-8fd8-42f7-bced-3dd76988cdb2', CAST(N'2024-07-03T14:43:33.883' AS DateTime), CAST(N'2024-07-03T14:43:33.883' AS DateTime), 1, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'a819d9ee-fe3f-4cc4-83e6-844a070e695c', N'Benito Juárez', 0, 1, N'f29610cb-4dfb-4e89-9c70-bd56031bf137', CAST(N'2024-05-14T17:15:37.373' AS DateTime), CAST(N'2024-05-14T17:15:37.373' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'd72cf109-f7cc-4245-b71f-844b3c10e375', N'Ejemplo Opcion 8', 0, 1, N'dda0bb6e-5579-4971-a05a-a1a20c4482ac', CAST(N'2024-06-18T17:48:28.883' AS DateTime), CAST(N'2024-06-18T17:48:28.883' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'8a7fd0f4-b66b-4c8e-9004-845f0d798a6b', N'Vladivostok', 0, 1, N'e0c81067-b353-4659-b29c-d909d1209830', CAST(N'2024-05-18T20:06:22.300' AS DateTime), CAST(N'2024-05-18T20:06:22.300' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'1015d97e-8356-404e-93c4-847107f3662d', N'Roma', 0, 1, N'e21a8ca2-e2a6-4d4e-a739-d44f132aa2aa', CAST(N'2024-05-14T17:15:37.340' AS DateTime), CAST(N'2024-05-14T17:15:37.340' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'f5638db6-ed08-4f5a-984f-850648e4fc91', N'Nunca', 0, 1, N'0dcec066-50db-4981-93fb-0dbc3b528d07', CAST(N'2024-06-12T14:52:32.303' AS DateTime), CAST(N'2024-06-12T14:52:32.303' AS DateTime), 1, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'8884b346-61d2-4bd6-88bf-8578cddb64c3', N'Varias veces a la semana', 0, 1, N'f569a206-15cb-4fb8-9bc1-d76405aa7bc9', CAST(N'2024-05-17T11:36:59.200' AS DateTime), CAST(N'2024-05-17T11:36:59.200' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'4c849a8b-3ae9-4565-a544-8593020f1d1b', N'Ejemploa', 0, 1, N'82c82b89-5159-4ed0-ba74-0e7ca1b157cd', CAST(N'2024-07-03T11:55:14.127' AS DateTime), CAST(N'2024-07-03T11:55:14.127' AS DateTime), 0, N'357dbf15-2a3e-4424-9005-9325bba3462c')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'82415cd3-789a-4afe-97b2-861cc4824a83', N'adad', 0, 1, N'8160596f-0937-4f1e-9bca-415a56db719e', CAST(N'2024-06-19T11:46:45.600' AS DateTime), CAST(N'2024-06-19T11:46:45.600' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'2a61af8c-aebb-4682-99ae-864ecd6b3fd3', N'Rasgos faciales', 0, 1, N'ab319e07-97f2-4ae0-8862-527e4ed6f972', CAST(N'2024-05-17T11:36:59.177' AS DateTime), CAST(N'2024-05-17T11:36:59.177' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'4fbf5f2a-783a-413f-abbb-864eceee67d7', N'Ejemploc', 0, 1, N'7beb9206-245a-4fc2-a631-c8a6e38106b6', CAST(N'2024-07-03T11:55:14.133' AS DateTime), CAST(N'2024-07-03T11:55:14.133' AS DateTime), 0, N'1e2e9f6c-4c7f-4142-8317-c398db956764')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'182b1e87-4caf-43ad-88ae-8652fea36d11', N'Germinación', 0, 1, N'94de16dd-f15a-49df-b82a-55143405dd9e', CAST(N'2024-05-14T17:15:37.360' AS DateTime), CAST(N'2024-05-14T17:15:37.360' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'3cca51e5-2017-428a-9104-86771163992a', N'Atención al cliente', 0, 1, N'73d8da63-da2d-4147-beb4-4abe18986e2b', CAST(N'2024-05-17T11:36:59.243' AS DateTime), CAST(N'2024-05-17T11:36:59.243' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'8ef147f8-7f57-425f-84dd-868ff6e7d49c', N'Río Misisipi', 0, 1, N'c9ebbafe-9ec1-4ef1-ad4b-61e363d386d2', CAST(N'2024-05-06T15:19:40.160' AS DateTime), CAST(N'2024-05-06T15:19:40.160' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'687f5e17-32d1-4f15-987c-87346d116c61', N'En desacuerdo', 0, 1, N'60e85430-d266-481d-ab99-90b825ba4ed7', CAST(N'2024-06-19T11:51:12.140' AS DateTime), CAST(N'2024-06-19T11:51:12.140' AS DateTime), 2, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'd32a485e-ac88-48d1-8208-87560b6da796', N'Ejemploc', 0, 1, N'82c82b89-5159-4ed0-ba74-0e7ca1b157cd', CAST(N'2024-07-03T11:55:14.127' AS DateTime), CAST(N'2024-07-03T11:55:14.127' AS DateTime), 0, N'1e2e9f6c-4c7f-4142-8317-c398db956764')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'6866ab51-02a3-4ae0-b664-87ace581dbdc', N'Frecuentemente', 0, 1, N'98cc12a2-988e-4884-8d8e-b33999cb7e38', CAST(N'2024-07-03T13:16:16.590' AS DateTime), CAST(N'2024-07-03T13:16:16.590' AS DateTime), 4, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'd6b2f0a8-caec-4707-8378-88b983e5110d', N'Totalmente en desacuerdo', 0, 1, N'd8585a71-6633-403a-857d-5e042524c98f', CAST(N'2024-07-03T14:43:33.890' AS DateTime), CAST(N'2024-07-03T14:43:33.890' AS DateTime), 1, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'65f31a5c-c8c5-4ab5-bffa-89547020f857', N'William Shakespeare', 1, 1, N'546b1a00-fa38-4ceb-be54-83ca7dd923c9', CAST(N'2024-05-06T15:19:40.180' AS DateTime), CAST(N'2024-05-06T15:19:40.180' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'efd55c9e-55af-4022-a215-897023ac18f3', N'Ejemplo Opcion 3', 0, 1, N'c4273e68-8869-4369-9eac-259ba870b163', CAST(N'2024-07-03T13:32:39.980' AS DateTime), CAST(N'2024-07-03T13:32:39.980' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'72ff5688-fec8-4e33-b65a-8970b37254f6', N'Jules Verne', 0, 1, N'a418389d-a1a4-49d5-94e2-b8f4dc813982', CAST(N'2024-05-14T17:15:37.343' AS DateTime), CAST(N'2024-05-14T17:15:37.343' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'988c0f0b-9f2c-436e-8979-89e3b4a09c59', N'Aluminio', 0, 1, N'a521fe33-f349-4279-9ee9-fb9b4dec34bc', CAST(N'2024-05-06T15:19:40.180' AS DateTime), CAST(N'2024-05-06T15:19:40.180' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'645595e5-fbe0-4612-b397-89ec06cf7ae9', N'Totalmente en desacuerdo', 0, 1, N'0df5898c-37bb-49e9-b288-3888bafd62f4', CAST(N'2024-07-03T14:43:33.877' AS DateTime), CAST(N'2024-07-03T14:43:33.877' AS DateTime), 1, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'6a2e2af8-4a69-409d-8a38-8a268a5a847f', N'Siempre', 0, 1, N'17f90498-53f6-48ba-858b-980b529aaf4e', CAST(N'2024-06-19T12:11:03.470' AS DateTime), CAST(N'2024-06-19T12:11:03.470' AS DateTime), 5, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'c6fd9ed4-4a24-49c3-94df-8a3f5a6c56bd', N'Ejemplo Opcion 3', 0, 1, N'2e3772af-86f7-4b10-ab23-3c7fd119df3f', CAST(N'2024-07-03T12:23:31.033' AS DateTime), CAST(N'2024-07-03T12:23:31.033' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'a609891d-8056-49c9-b372-8ae3b7021934', N'Yuan', 0, 1, N'32dbc843-a741-4474-9106-2001753aa21d', CAST(N'2024-05-06T15:19:40.177' AS DateTime), CAST(N'2024-05-06T15:19:40.177' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'513fd33f-6456-4133-bc65-8b1f8f38659f', N'Diseño', 0, 1, N'73d8da63-da2d-4147-beb4-4abe18986e2b', CAST(N'2024-05-17T11:36:59.243' AS DateTime), CAST(N'2024-05-17T11:36:59.243' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'd898c575-65a6-4e30-994d-8b2fb49ab826', N'Geoffrey Chaucer', 0, 1, N'5eba467e-fcd2-4b64-8da4-aa167d1c2539', CAST(N'2024-05-14T17:15:37.367' AS DateTime), CAST(N'2024-05-14T17:15:37.367' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'367ebefa-9e36-4779-a53f-8bae49badc88', N'Yuri Gagarin', 1, 1, N'0f480871-91b1-4cb3-b489-acca5c45edd1', CAST(N'2024-05-18T20:06:22.280' AS DateTime), CAST(N'2024-05-18T20:06:22.280' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'360b82e4-bdaa-407c-b44c-8bb86a20941a', N'H2O2', 0, 1, N'34922354-8289-4138-ba76-f014216ab8fa', CAST(N'2024-05-14T17:15:37.377' AS DateTime), CAST(N'2024-05-14T17:15:37.377' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'0eb77b1d-741c-488a-9f4c-8be7548087f9', N'uno', 0, 1, N'afc45722-88ba-410f-affc-88f0f17ed624', CAST(N'2024-05-13T15:24:55.300' AS DateTime), CAST(N'2024-05-13T15:24:55.300' AS DateTime), 3, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'8d766f4c-0fa9-4859-a0df-8c97c1cb3320', N'Rara Vez', 0, 1, N'b8e7022f-cecd-458f-b5b2-352e7ad04b32', CAST(N'2024-07-03T13:22:31.023' AS DateTime), CAST(N'2024-07-03T13:22:31.023' AS DateTime), 2, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'c294705c-6717-492f-a887-8cba6be2dd28', N'Nunca', 0, 1, N'cb7f759a-4f64-4c49-8d4e-d7716784ec88', CAST(N'2024-06-12T14:51:55.910' AS DateTime), CAST(N'2024-06-12T14:51:55.910' AS DateTime), 1, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'9a7b1eb1-8560-45f3-8e15-8ce66495376b', N'Euro', 0, 1, N'32dbc843-a741-4474-9106-2001753aa21d', CAST(N'2024-05-06T15:19:40.177' AS DateTime), CAST(N'2024-05-06T15:19:40.177' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'23bef39c-ff3a-4ed8-a9ec-8d25201171f9', N'Siempre', 0, 1, N'5bfc42e7-4c0e-43af-83e8-8721e3a6d8df', CAST(N'2024-06-12T17:32:03.223' AS DateTime), CAST(N'2024-06-12T17:32:03.223' AS DateTime), 5, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'4f975a2e-1e40-4941-a880-8d31c2039877', N'EjemploA', 0, 1, N'4d30043b-9bbf-4dac-8e4c-c3663eb83655', CAST(N'2024-06-19T12:00:32.247' AS DateTime), CAST(N'2024-06-19T12:00:32.247' AS DateTime), 0, N'bfef5abf-cff4-460b-a3af-55630d81066a')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'b3eaed9a-d055-48a7-b580-8d659299188d', N'Euro', 0, 1, N'63afe949-1674-421a-8cce-463e7e6ba267', CAST(N'2024-05-18T20:06:22.290' AS DateTime), CAST(N'2024-05-18T20:06:22.290' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'6536776f-d000-4246-8433-8e574b3454cf', N'De acuerdo', 0, 1, N'eace26ab-f364-44cc-a179-cca4952a5cc4', CAST(N'2024-06-19T11:51:12.143' AS DateTime), CAST(N'2024-06-19T11:51:12.143' AS DateTime), 4, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'b466d7a0-97a4-4b73-959a-8ee21e127ea3', N'Ejemplo Opcion 2', 0, 1, N'f5535438-f8f2-441d-b3ce-266d618d8301', CAST(N'2024-07-03T13:32:40.003' AS DateTime), CAST(N'2024-07-03T13:32:40.003' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'bcb13de4-a375-4498-95e6-8f24ed5eb7be', N'Ejemplo Opcion 10', 0, 1, N'2f722edf-8c3b-4682-8abf-c8305c2d18ca', CAST(N'2024-06-18T17:48:28.860' AS DateTime), CAST(N'2024-06-18T17:48:28.860' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'5de0177b-b329-4eee-b529-90206e3997e7', N'¿A que hora es el almuerzo?', 0, 1, N'768d597b-102e-4a6a-ac31-a43d22726e47', CAST(N'2024-06-03T16:18:15.330' AS DateTime), CAST(N'2024-06-03T16:18:15.330' AS DateTime), 0, N'357dbf15-2a3e-4424-9005-9325bba3462c')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'62c1ec52-d69d-4703-a88b-905f124a8a95', N'Euro', 0, 1, N'e033dd49-efc7-4cc3-8553-44134c409196', CAST(N'2024-05-14T17:15:37.363' AS DateTime), CAST(N'2024-05-14T17:15:37.363' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'47e0f2a9-8c5b-4dd2-ae2d-911161afd400', N'Júpiter', 1, 1, N'ae85ef32-0e82-487f-a2c1-6d1b5b6477ff', CAST(N'2024-05-06T15:19:40.173' AS DateTime), CAST(N'2024-05-06T15:19:40.173' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'af1110a8-5127-4e70-a616-911cea04aaea', N'Ejemploa', 0, 1, N'912583c5-89cf-46d6-9366-e512187830a1', CAST(N'2024-07-03T11:55:14.120' AS DateTime), CAST(N'2024-07-03T11:55:14.120' AS DateTime), 0, N'357dbf15-2a3e-4424-9005-9325bba3462c')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'bb7633c8-8a9e-483b-ba63-91271d3fa248', N'Ejemplo Opcion 8', 0, 1, N'2f722edf-8c3b-4682-8abf-c8305c2d18ca', CAST(N'2024-06-18T17:48:28.860' AS DateTime), CAST(N'2024-06-18T17:48:28.860' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'430a1332-e6e5-4bde-89be-9138d7d6dc77', N'regular', 0, 1, N'a4e255f2-3c31-4174-baa7-d1e1bf356b4a', CAST(N'2024-05-19T18:26:24.477' AS DateTime), CAST(N'2024-05-19T18:26:24.477' AS DateTime), 0, N'bfef5abf-cff4-460b-a3af-55630d81066a')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'2e4a21e5-7052-4a4b-bbdc-915aaa9a2b38', N'Siempre', 0, 1, N'6340dd21-34ab-40a9-8103-116a1ebce518', CAST(N'2024-07-03T13:16:16.597' AS DateTime), CAST(N'2024-07-03T13:16:16.597' AS DateTime), 5, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'eab393c4-4d3d-4519-99eb-916d1243b252', N'Moscú', 1, 1, N'36e6a35d-0678-4725-95a1-fb1ec32103fd', CAST(N'2024-05-06T15:19:40.183' AS DateTime), CAST(N'2024-05-06T15:19:40.183' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'65e7a760-cfb8-4479-b766-916e3e590b7f', N'Sí', 0, 1, N'6ff61c7b-7c24-41f2-b637-882d0a96f4b4', CAST(N'2024-05-17T11:36:59.160' AS DateTime), CAST(N'2024-05-17T11:36:59.160' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'0918a3ba-6acb-477c-81e7-91d23c83c82f', N'muy malo', 0, 1, N'93cb4f0a-7486-40a9-b755-4c95d1b6d96f', CAST(N'2024-05-19T18:25:28.843' AS DateTime), CAST(N'2024-05-19T18:25:28.843' AS DateTime), 0, N'1e2e9f6c-4c7f-4142-8317-c398db956764')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'd630ad14-9fdc-47e2-b327-9224b69b9ed6', N'Tenis', 0, 1, N'd34fb3e9-1be1-41bd-b542-957a78db78b7', CAST(N'2024-05-17T11:36:59.193' AS DateTime), CAST(N'2024-05-17T11:36:59.193' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'325cab66-cdf4-4c9b-bf13-93d30495ecfb', N'Río Amazonas', 0, 1, N'c9ebbafe-9ec1-4ef1-ad4b-61e363d386d2', CAST(N'2024-05-06T15:19:40.160' AS DateTime), CAST(N'2024-05-06T15:19:40.160' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'62a45211-a332-487d-b4b0-940341453a74', N'España', 0, 1, N'ccc3d027-def0-424d-94c2-f03a48a91ae0', CAST(N'2024-05-06T15:19:40.187' AS DateTime), CAST(N'2024-05-06T15:19:40.187' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'02212e0a-0fbb-407a-90b1-945ce62f3c91', N'Aluminio', 1, 1, N'9fc8b8e0-4832-437c-88ba-0e5f4cb6585c', CAST(N'2024-05-18T20:06:22.280' AS DateTime), CAST(N'2024-05-18T20:06:22.280' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'd5450c04-e21b-4368-a8de-946d61e7ae97', N'Avión', 0, 1, N'768ae381-8735-43ad-8c33-77b4836a070f', CAST(N'2024-05-17T11:36:59.210' AS DateTime), CAST(N'2024-05-17T11:36:59.210' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'eb67dbc4-8124-44c3-8611-955d3bc2199a', N'a', 0, 1, N'5e89efae-a8e6-4aad-9347-a117e6df00ca', CAST(N'2024-05-14T15:49:43.740' AS DateTime), CAST(N'2024-05-14T15:49:43.740' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'a670275b-3781-47c8-b547-95f5e07b6e47', N'Fémur', 1, 1, N'8aae72a1-8f0e-4bcc-a4c4-86d7cc5bced9', CAST(N'2024-05-06T15:19:40.170' AS DateTime), CAST(N'2024-05-06T15:19:40.170' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'94d52e37-2f90-480a-bf5b-95f72a357edf', N'Ejemplo Opcion 8', 0, 1, N'9a431a9c-1aaa-4616-8b4b-bbf6c34082de', CAST(N'2024-06-18T17:48:28.863' AS DateTime), CAST(N'2024-06-18T17:48:28.863' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'caccf54d-6d16-451b-b806-96692849c9e1', N'Ejemploa', 0, 1, N'7beb9206-245a-4fc2-a631-c8a6e38106b6', CAST(N'2024-07-03T11:55:14.130' AS DateTime), CAST(N'2024-07-03T11:55:14.130' AS DateTime), 0, N'357dbf15-2a3e-4424-9005-9325bba3462c')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'6c3a59a5-7e8a-4590-a4e6-968aa0ec09f8', N'Taxi', 0, 1, N'768ae381-8735-43ad-8c33-77b4836a070f', CAST(N'2024-05-17T11:36:59.213' AS DateTime), CAST(N'2024-05-17T11:36:59.213' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'6e74427a-88f3-4b4d-9e21-96992cedaf52', N'Ejemplo Opcion 6', 0, 1, N'9845c3de-be89-4405-8cc6-5422f6928eb9', CAST(N'2024-06-18T17:48:28.870' AS DateTime), CAST(N'2024-06-18T17:48:28.870' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'b149ceeb-8676-4087-a6ca-96e23afd5fff', N'A Veces', 0, 1, N'a66925cc-5701-4460-91d0-fe6af4676618', CAST(N'2024-06-18T16:00:22.870' AS DateTime), CAST(N'2024-06-18T16:00:22.870' AS DateTime), 3, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'0409ba71-a8b3-4683-be7b-96eab7595fb9', N'Guadalupe Victoria', 1, 1, N'fcd4f005-2ea6-491b-bdf4-d07beb7cdb0d', CAST(N'2024-05-06T15:19:40.187' AS DateTime), CAST(N'2024-05-06T15:19:40.187' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'073d92a5-3687-48bd-9b36-96f63f15e271', N'Benito Juárez', 0, 1, N'fcd4f005-2ea6-491b-bdf4-d07beb7cdb0d', CAST(N'2024-05-06T15:19:40.183' AS DateTime), CAST(N'2024-05-06T15:19:40.183' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'245b41b6-f6af-4b98-8572-97d8bef6d376', N'14', 0, 1, N'415aa7b1-846e-430e-8687-96789fcdac9b', CAST(N'2024-06-18T16:40:29.753' AS DateTime), CAST(N'2024-06-18T16:40:35.743' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'3b8d66f3-aa11-495f-b089-9818ccb8ddef', N'Frecuentemente', 0, 1, N'b8e7022f-cecd-458f-b5b2-352e7ad04b32', CAST(N'2024-07-03T13:22:31.027' AS DateTime), CAST(N'2024-07-03T13:22:31.027' AS DateTime), 4, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'a1dfbda1-f1dd-488f-9ce7-982de03cd1e2', N'Ejemplo Opcion 4', 0, 1, N'9a431a9c-1aaa-4616-8b4b-bbf6c34082de', CAST(N'2024-06-18T17:48:28.860' AS DateTime), CAST(N'2024-06-18T17:48:28.860' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'b895be50-6c45-44e8-9952-984828003384', N'Secundaria', 0, 1, N'5cb81db3-01ac-49b5-9855-e8f9b686a99f', CAST(N'2024-05-17T11:36:59.173' AS DateTime), CAST(N'2024-05-17T11:36:59.173' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'c4fed440-762c-485b-a341-989825ff44fd', N'De acuerdo', 0, 1, N'741d8042-94e7-4865-8b44-7ab832561eba', CAST(N'2024-07-03T14:43:33.880' AS DateTime), CAST(N'2024-07-03T14:43:33.880' AS DateTime), 4, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'5a1652ab-162b-4fa2-af91-996db2f5cbea', N'Restaurantes o Bares', 0, 1, N'af15ba63-8426-43d9-ba74-e855cde8b47d', CAST(N'2024-05-17T11:36:59.167' AS DateTime), CAST(N'2024-05-17T11:36:59.167' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'e11e1bc7-cd93-432d-93ab-9a00f4659cbc', N'bueno', 0, 1, N'93cb4f0a-7486-40a9-b755-4c95d1b6d96f', CAST(N'2024-05-19T18:25:28.843' AS DateTime), CAST(N'2024-05-19T18:25:28.843' AS DateTime), 0, N'bfef5abf-cff4-460b-a3af-55630d81066a')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'16f48380-f602-43b4-9bfb-9aa34aed3b52', N'Buzz Aldrin', 0, 1, N'e2b3cbeb-3e97-4e0b-993a-4123bec5538c', CAST(N'2024-05-06T15:19:40.167' AS DateTime), CAST(N'2024-05-06T15:19:40.167' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'067e38d0-42f7-4b3d-8e3e-9b21a84b9a75', N'Francia', 1, 1, N'8d5e4ba5-2632-4ca4-817a-de1300b99a0e', CAST(N'2024-05-18T20:06:22.307' AS DateTime), CAST(N'2024-05-18T20:06:22.307' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'cd7db268-9bd6-4a14-9b97-9b497f643401', N'adad', 1, 1, N'53f22e8e-3d32-4b7f-9d0c-8ddb90c3d9c9', CAST(N'2024-06-19T11:47:03.777' AS DateTime), CAST(N'2024-06-19T11:47:03.780' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'5079ad4f-4f99-4417-9574-9bb81bfe65c4', N'Respiración', 0, 1, N'94de16dd-f15a-49df-b82a-55143405dd9e', CAST(N'2024-05-14T17:15:37.360' AS DateTime), CAST(N'2024-05-14T17:15:37.360' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'90b9a157-480f-47c6-8d1a-9c3796e73e4c', N'En desacuerdo', 0, 1, N'942152b7-25fc-47f6-a41d-9b420ab8231a', CAST(N'2024-06-12T14:19:17.327' AS DateTime), CAST(N'2024-06-12T14:19:17.327' AS DateTime), 2, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'aacd2a3d-0430-406d-b315-9c3968e0ac63', N'Madrid', 0, 1, N'e21a8ca2-e2a6-4d4e-a739-d44f132aa2aa', CAST(N'2024-05-14T17:15:37.337' AS DateTime), CAST(N'2024-05-14T17:15:37.337' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'3c85a536-c9c5-4ec8-b502-9d454499c259', N'Ejemplo Opcion 2', 0, 1, N'450e7cda-1c03-4a33-abe9-720fd4a2fe7d', CAST(N'2024-07-03T12:23:31.027' AS DateTime), CAST(N'2024-07-03T12:23:31.027' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'060d3b05-5936-4813-ab7f-9db590178d89', N'Nunca', 0, 1, N'17f90498-53f6-48ba-858b-980b529aaf4e', CAST(N'2024-06-19T12:11:03.467' AS DateTime), CAST(N'2024-06-19T12:11:03.467' AS DateTime), 1, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'9054ea44-7f9c-4970-b3a4-9dbeae1e53f1', N'Río Nilo', 1, 1, N'c9ebbafe-9ec1-4ef1-ad4b-61e363d386d2', CAST(N'2024-05-06T15:19:40.160' AS DateTime), CAST(N'2024-05-06T15:19:40.160' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'108fd5d1-b40c-4c8e-a890-9dda05e1b80d', N'Frecuentemente', 0, 1, N'5bfc42e7-4c0e-43af-83e8-8721e3a6d8df', CAST(N'2024-06-12T17:32:03.223' AS DateTime), CAST(N'2024-06-12T17:32:03.223' AS DateTime), 4, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'c03938d9-2cea-4632-bb2e-9dfb71a59c2a', N'Ejemplo Opcion 1', 0, 1, N'9d6aa9f8-e6a9-4dd9-ade8-d0e2d0e53309', CAST(N'2024-06-18T17:48:28.873' AS DateTime), CAST(N'2024-06-18T17:48:28.873' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'171d3987-70ca-45fb-a3a1-9e27e473a950', N'Totalmente en desacuerdo', 0, 1, N'942152b7-25fc-47f6-a41d-9b420ab8231a', CAST(N'2024-06-12T14:19:17.323' AS DateTime), CAST(N'2024-06-12T14:19:17.323' AS DateTime), 1, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'4067a58a-9292-4b53-8a0c-9e4e0a30f5fe', N'De acuerdo', 0, 1, N'942152b7-25fc-47f6-a41d-9b420ab8231a', CAST(N'2024-06-12T14:19:17.327' AS DateTime), CAST(N'2024-06-12T14:19:17.327' AS DateTime), 4, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'd505d87f-db50-4547-a9bf-9eb82b8cae89', N'Fantasía', 0, 1, N'6122e532-6296-4b7f-b2cf-a91b1e1ce8a2', CAST(N'2024-05-17T11:36:59.207' AS DateTime), CAST(N'2024-05-17T11:36:59.207' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'de0a0317-e25c-4384-b568-9f53b0b8e67d', N'Ejemplo Opcion 4', 0, 1, N'3a113ec5-79f5-40e6-93af-6971eccea36a', CAST(N'2024-07-03T12:23:31.030' AS DateTime), CAST(N'2024-07-03T12:23:31.030' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'9440d0db-612c-4e14-a710-9f6fcdcc30db', N'1945', 1, 1, N'7d1ddcfd-9c98-43e8-b5bb-38a216617fbe', CAST(N'2024-05-18T20:06:22.277' AS DateTime), CAST(N'2024-05-18T20:06:22.277' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'9bf4d45d-288c-41f1-a4f8-9f8403a92e21', N'Magnesio', 0, 1, N'eb983094-689e-4469-9700-09ab87c6da04', CAST(N'2024-05-14T17:15:37.370' AS DateTime), CAST(N'2024-05-14T17:15:37.370' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'2c3894bb-71d0-4763-ba70-9fcfe0d83e48', N'Electrónica', 0, 1, N'253efaf1-4751-416d-aebd-3f82ca9ecc86', CAST(N'2024-05-17T11:36:59.190' AS DateTime), CAST(N'2024-05-17T11:36:59.190' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'5845b483-2eec-4055-ba2c-a00400ca3c0f', N'Geoffrey Chaucer', 0, 1, N'546b1a00-fa38-4ceb-be54-83ca7dd923c9', CAST(N'2024-05-06T15:19:40.180' AS DateTime), CAST(N'2024-05-06T15:19:40.180' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'40955156-07fe-437a-bb85-a14156b31094', N'Frecuentemente', 0, 1, N'4b9c5102-2cf1-48bf-8983-162fef069f5d', CAST(N'2024-07-03T13:16:16.587' AS DateTime), CAST(N'2024-07-03T13:16:16.587' AS DateTime), 4, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'e9fdf9bd-9f10-4d45-a911-a2114d5bcda6', N'Impreso', 0, 1, N'89af27c7-a4c1-4f07-a439-bce379652542', CAST(N'2024-05-17T11:36:59.217' AS DateTime), CAST(N'2024-05-17T11:36:59.217' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'c66e04eb-a261-402e-868d-a36173042f23', N'Hip-Hop/Rap', 0, 1, N'253efaf1-4751-416d-aebd-3f82ca9ecc86', CAST(N'2024-05-17T11:36:59.190' AS DateTime), CAST(N'2024-05-17T11:36:59.190' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'e8d0713c-eb5f-4f59-b58e-a366cff36a1c', N'Frecuentemente', 0, 1, N'a0ac946e-46c8-4121-8498-40e3a2617213', CAST(N'2024-06-19T12:10:52.713' AS DateTime), CAST(N'2024-06-19T12:10:52.713' AS DateTime), 4, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'1a2ecbbc-12ef-4a46-8f8b-a3a087560eee', N'De acuerdo', 0, 1, N'dff06a15-ed76-4999-8518-574bbb7998c3', CAST(N'2024-07-03T14:43:33.873' AS DateTime), CAST(N'2024-07-03T14:43:33.873' AS DateTime), 4, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'4e8d7d56-2292-421d-b3c2-a4110787b4bd', N'1', 1, 1, N'8b8c5642-1e5a-4cd9-a6c0-899eb7c30192', CAST(N'2024-06-18T16:40:48.623' AS DateTime), CAST(N'2024-06-18T16:40:48.623' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'bd0cad51-e274-4002-8efe-a4242896f83c', N'Vincent van Gogh', 0, 1, N'749cb8ac-109f-476e-8f3c-6396c6ebb8fd', CAST(N'2024-05-06T15:19:40.153' AS DateTime), CAST(N'2024-05-06T15:19:40.153' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'f181a6c5-49e4-4f53-b138-a46f3da972af', N'Kiev', 0, 1, N'588e2705-8a7d-417d-977d-61fcd1e38863', CAST(N'2024-05-14T17:15:37.370' AS DateTime), CAST(N'2024-05-14T17:15:37.370' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'81f53aff-cad9-443b-b58c-a4c0cd992991', N'Rara Vez', 0, 1, N'a924c254-6554-4b24-8fae-47163f0ebb93', CAST(N'2024-06-18T15:58:50.337' AS DateTime), CAST(N'2024-06-18T15:58:50.337' AS DateTime), 2, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'e362f29d-9c54-4285-acc8-a4c95586c5b1', N'Rara Vez', 0, 1, N'8b05542f-0c09-435f-b3f3-56cb286a72ff', CAST(N'2024-07-03T13:22:31.017' AS DateTime), CAST(N'2024-07-03T13:22:31.017' AS DateTime), 2, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'10125bb9-2a01-4944-bcd3-a4e7f70ac3e7', N'Siempre', 0, 1, N'19850dc1-0247-44c6-9774-aa733a61ce45', CAST(N'2024-07-03T13:16:16.600' AS DateTime), CAST(N'2024-07-03T13:16:16.600' AS DateTime), 5, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'65e30c84-bf33-4423-a44f-a5091de8c59f', N'Ejemplo Opcion 7', 0, 1, N'aed89eab-a165-406f-926d-689ef0fa2ccb', CAST(N'2024-07-03T13:32:39.990' AS DateTime), CAST(N'2024-07-03T13:32:39.990' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'363c1805-b241-4f6d-a7e4-a515a1a68bb2', N'Ejemplo', 0, 1, N'5ed265a7-14dc-43e7-ab4b-3ba3d95f8a5a', CAST(N'2024-06-19T09:56:26.833' AS DateTime), CAST(N'2024-06-19T09:56:55.910' AS DateTime), 0, N'bfef5abf-cff4-460b-a3af-55630d81066a')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'8abe7efb-6425-4993-877d-a52cd2c59c84', N'Respiración', 0, 1, N'a832fc7d-fc43-42e1-ab7c-6d6144832af8', CAST(N'2024-05-06T15:19:40.173' AS DateTime), CAST(N'2024-05-06T15:19:40.173' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'3db3feb7-183f-43fc-a19e-a5bc280e9e95', N'William Shakespeare', 1, 1, N'88cdf9fd-996b-4a03-b3d2-1ab46293aa9d', CAST(N'2024-05-18T20:06:22.293' AS DateTime), CAST(N'2024-05-18T20:06:22.293' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'29b81c8c-02b4-46cd-a562-a6003f2d6b16', N'Ejemplo Opcion 5', 0, 1, N'9a431a9c-1aaa-4616-8b4b-bbf6c34082de', CAST(N'2024-06-18T17:48:28.863' AS DateTime), CAST(N'2024-06-18T17:48:28.863' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'8add5188-8f08-49db-a252-a61632a3756f', N'CO2', 0, 1, N'add6b6e1-3744-4d54-a985-8e2e9427c406', CAST(N'2024-05-06T15:19:40.190' AS DateTime), CAST(N'2024-05-09T18:03:36.963' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'9bb1a8f9-751c-46d1-943b-a64b39d08b68', N'Reggae', 0, 1, N'253efaf1-4751-416d-aebd-3f82ca9ecc86', CAST(N'2024-05-17T11:36:59.190' AS DateTime), CAST(N'2024-05-17T11:36:59.190' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'76577e9d-15b2-4a6f-9af6-a6c7433ec7d6', N'adada', 0, 1, N'8397da47-99cc-45a8-afdd-e2105d2eb748', CAST(N'2024-06-19T10:01:21.180' AS DateTime), CAST(N'2024-06-19T10:01:21.180' AS DateTime), 0, N'1e2e9f6c-4c7f-4142-8317-c398db956764')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'b04fd19f-f559-4f71-ab20-a6d85d503b56', N'Porfirio Díaz', 0, 1, N'c0362a07-5bb1-40b4-bef6-61da48da4878', CAST(N'2024-05-18T20:06:22.303' AS DateTime), CAST(N'2024-05-18T20:06:22.303' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'1c4f9033-2987-4346-9a0d-a742458605f6', N'op a', 0, 1, N'5c5fe21d-35a5-4e83-88be-c5004d5027bf', CAST(N'2024-05-19T18:25:12.537' AS DateTime), CAST(N'2024-05-19T18:25:12.537' AS DateTime), 0, N'bfef5abf-cff4-460b-a3af-55630d81066a')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'46937df3-cc89-4233-9d7a-a7512c7e6533', N'Jane Austen', 0, 1, N'88cdf9fd-996b-4a03-b3d2-1ab46293aa9d', CAST(N'2024-05-18T20:06:22.297' AS DateTime), CAST(N'2024-05-18T20:06:22.297' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'10322db0-792d-40ef-8a10-a79281d6a6b9', N'Ejemplob', 0, 1, N'55973eec-9d86-4a83-aa90-33cbc394dd02', CAST(N'2024-06-19T12:00:32.240' AS DateTime), CAST(N'2024-06-19T12:00:32.240' AS DateTime), 0, N'357dbf15-2a3e-4424-9005-9325bba3462c')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'd29f1360-ffdb-4839-8ebb-a795027dd450', N'Ejemplo Opcion 8', 0, 1, N'9d6aa9f8-e6a9-4dd9-ade8-d0e2d0e53309', CAST(N'2024-06-18T17:48:28.877' AS DateTime), CAST(N'2024-06-18T17:48:28.877' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'fff4ad7c-c66f-4f54-800b-a79b5a5cfae0', N'San Petersburgo', 0, 1, N'36e6a35d-0678-4725-95a1-fb1ec32103fd', CAST(N'2024-05-06T15:19:40.183' AS DateTime), CAST(N'2024-05-06T15:19:40.183' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'f6081680-737f-46bb-8268-a8595380b741', N'Ejemplo Opcion 4', 0, 1, N'dda0bb6e-5579-4971-a05a-a1a20c4482ac', CAST(N'2024-06-18T17:48:28.880' AS DateTime), CAST(N'2024-06-18T17:48:28.880' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'aa8019d5-8816-4cb0-a708-a8c76405d678', N'Ejemplo Opcion 3', 0, 1, N'aed89eab-a165-406f-926d-689ef0fa2ccb', CAST(N'2024-07-03T13:32:39.990' AS DateTime), CAST(N'2024-07-03T13:32:39.990' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'0916617e-b29e-4cb2-8ea5-a8d858fff216', N'Frecuentemente', 0, 1, N'1c8f5d74-122b-4c41-8c88-7815d790d9ec', CAST(N'2024-06-18T16:10:51.043' AS DateTime), CAST(N'2024-06-18T16:10:51.043' AS DateTime), 4, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'e6ecb766-ef60-473a-98db-a9685048f21c', N'Ejemplo Opcion 10', 0, 1, N'7fa649e1-4ca7-43e6-9211-1cbacceccc50', CAST(N'2024-07-03T13:32:40.023' AS DateTime), CAST(N'2024-07-03T13:32:40.023' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'a04a8e9b-06fc-48e8-b09a-a969dad762e9', N'Alan Shepard', 0, 1, N'e2b3cbeb-3e97-4e0b-993a-4123bec5538c', CAST(N'2024-05-06T15:19:40.167' AS DateTime), CAST(N'2024-05-06T15:19:40.167' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'cbe632fd-94b2-4b8f-850b-a9bdccb90896', N'Radio', 0, 1, N'cb0edcd3-1843-49d0-b98f-d1894a876054', CAST(N'2024-05-14T17:15:37.357' AS DateTime), CAST(N'2024-05-14T17:15:37.357' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'81b2a012-c238-4d67-8011-a9d92fb84896', N'de op 2', 0, 1, N'642f2953-674c-429c-a6f6-66f87770a362', CAST(N'2024-05-13T15:22:07.753' AS DateTime), CAST(N'2024-05-13T15:22:07.753' AS DateTime), 1, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'a1959306-827e-4eb6-8db2-aa4d3c2f4270', N'Ejemplo Opcion 4', 0, 1, N'2e3772af-86f7-4b10-ab23-3c7fd119df3f', CAST(N'2024-07-03T12:23:31.033' AS DateTime), CAST(N'2024-07-03T12:23:31.033' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'80341966-e961-4851-8685-aa631a890d4b', N'Michelangelo', 0, 1, N'825d1a65-2bbc-4120-bade-7a304a8d44bd', CAST(N'2024-05-18T20:06:22.263' AS DateTime), CAST(N'2024-05-18T20:06:22.263' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'612a49fc-2e2c-45e8-9451-aaa05d5f1d74', N'Ejemplo Opcion 7', 0, 1, N'7fa649e1-4ca7-43e6-9211-1cbacceccc50', CAST(N'2024-07-03T13:32:40.020' AS DateTime), CAST(N'2024-07-03T13:32:40.020' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'a8b74eb5-19ad-42d2-a5ed-aab815ad658b', N'EjemploE', 0, 1, N'07761dfa-7ce5-42b3-9b40-29375321322e', CAST(N'2024-06-19T12:00:32.250' AS DateTime), CAST(N'2024-06-19T12:00:32.250' AS DateTime), 0, N'357dbf15-2a3e-4424-9005-9325bba3462c')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'bb618028-4cd7-495f-96c3-ab8b1902df75', N'Ejemplo Opcion 4', 0, 1, N'7fa649e1-4ca7-43e6-9211-1cbacceccc50', CAST(N'2024-07-03T13:32:40.020' AS DateTime), CAST(N'2024-07-03T13:32:40.020' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'f051191b-2969-404f-860c-abe56185ccd4', N'Rara Vez', 0, 1, N'a66925cc-5701-4460-91d0-fe6af4676618', CAST(N'2024-06-18T16:00:22.870' AS DateTime), CAST(N'2024-06-18T16:00:22.870' AS DateTime), 2, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'6435111c-a309-45e0-9f0e-ac4f032b65fd', N'Totalmente de acuerdo', 0, 1, N'943e4c32-92d1-484c-840f-27f1f22a00d7', CAST(N'2024-07-03T14:43:33.890' AS DateTime), CAST(N'2024-07-03T14:43:33.890' AS DateTime), 5, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'd90dce4d-a28a-43be-879b-acb5301a1a41', N'Ejemplo', 0, 1, N'73868e25-9aec-482d-b4ac-629b97a2dffe', CAST(N'2024-07-03T11:55:14.130' AS DateTime), CAST(N'2024-07-03T11:55:14.130' AS DateTime), 0, N'bfef5abf-cff4-460b-a3af-55630d81066a')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'0d9166ad-0393-473e-8658-ad6a725443ba', N'A Veces', 0, 1, N'cb7f759a-4f64-4c49-8d4e-d7716784ec88', CAST(N'2024-06-12T14:51:55.910' AS DateTime), CAST(N'2024-06-12T14:51:55.910' AS DateTime), 3, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'1b8639f0-94f9-4113-bc7e-ad733f80351c', N'Nunca', 0, 1, N'b0426a57-6d19-4453-9640-4839197e8859', CAST(N'2024-06-19T12:11:07.053' AS DateTime), CAST(N'2024-06-19T12:11:07.053' AS DateTime), 1, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'd8c5ce64-35f4-4bb6-ba55-addd1d90f252', N'Ejemplo Opcion 9', 0, 1, N'7fa649e1-4ca7-43e6-9211-1cbacceccc50', CAST(N'2024-07-03T13:32:40.023' AS DateTime), CAST(N'2024-07-03T13:32:40.023' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'37a509fb-ef7f-4844-86a7-ae5034d447d1', N'Ejemplo Opcion 2', 0, 1, N'06fb7cfc-9e4f-4c35-b6ab-1cd0d31e187a', CAST(N'2024-07-03T12:23:31.023' AS DateTime), CAST(N'2024-07-03T12:23:31.023' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'f74060f5-1913-44ef-9b83-ae8d8cf37b67', N'Ejemplo Opcion 1', 0, 1, N'9a431a9c-1aaa-4616-8b4b-bbf6c34082de', CAST(N'2024-06-18T17:48:28.860' AS DateTime), CAST(N'2024-06-18T17:48:28.860' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'79fb273d-2961-4460-903f-aeb4b4d702bb', N'Titanio', 0, 1, N'eb983094-689e-4469-9700-09ab87c6da04', CAST(N'2024-05-14T17:15:37.367' AS DateTime), CAST(N'2024-05-14T17:15:37.367' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'ef750e26-bfc4-423a-98dc-aee079237926', N'A Veces', 0, 1, N'57cb8739-ba65-4027-932f-ffbfebe6eadd', CAST(N'2024-07-03T13:22:31.023' AS DateTime), CAST(N'2024-07-03T13:22:31.023' AS DateTime), 3, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'd3e46f15-8f2f-4607-965c-af749a542ec1', N'Siempre', 0, 1, N'99821866-9268-4e60-95b6-8d932ecaded3', CAST(N'2024-07-03T13:22:31.033' AS DateTime), CAST(N'2024-07-03T13:22:31.033' AS DateTime), 5, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'950f01d0-5b29-4b30-b401-af93836c91ca', N'Ejemplo Opcion 10', 0, 1, N'9a431a9c-1aaa-4616-8b4b-bbf6c34082de', CAST(N'2024-06-18T17:48:28.867' AS DateTime), CAST(N'2024-06-18T17:48:28.867' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'f864e8d3-f39d-4175-98b0-af95559ca910', N'Siempre', 0, 1, N'a0ac946e-46c8-4121-8498-40e3a2617213', CAST(N'2024-06-19T12:10:52.717' AS DateTime), CAST(N'2024-06-19T12:10:52.717' AS DateTime), 5, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'6f63be41-8a3a-47ca-8e97-afbe1d7ca1ac', N'Michelangelo', 0, 1, N'749cb8ac-109f-476e-8f3c-6396c6ebb8fd', CAST(N'2024-05-06T15:19:40.153' AS DateTime), CAST(N'2024-05-06T15:19:40.153' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'2b26ebec-29ca-4242-af88-b00423b536e7', N'Siempre', 0, 1, N'0dcec066-50db-4981-93fb-0dbc3b528d07', CAST(N'2024-06-12T14:52:32.307' AS DateTime), CAST(N'2024-06-12T14:52:32.307' AS DateTime), 5, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'bb0981cb-e6d4-4691-b7d7-b041060e4ffa', N'Totalmente en desacuerdo', 0, 1, N'943e4c32-92d1-484c-840f-27f1f22a00d7', CAST(N'2024-07-03T14:43:33.887' AS DateTime), CAST(N'2024-07-03T14:43:33.887' AS DateTime), 1, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'b49b7abf-4075-4666-aed1-b0960f9d76f4', N'Ejemplob', 0, 1, N'4d30043b-9bbf-4dac-8e4c-c3663eb83655', CAST(N'2024-06-19T12:00:32.247' AS DateTime), CAST(N'2024-06-19T12:00:32.247' AS DateTime), 0, N'357dbf15-2a3e-4424-9005-9325bba3462c')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'480ae232-6d05-4c01-908d-b17f5706ddcf', N'Comedia', 0, 1, N'6122e532-6296-4b7f-b2cf-a91b1e1ce8a2', CAST(N'2024-05-17T11:36:59.203' AS DateTime), CAST(N'2024-05-17T11:36:59.203' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'e72dd944-07fa-461f-9f3c-b18cc9a06532', N'Rara Vez', 0, 1, N'4b9c5102-2cf1-48bf-8983-162fef069f5d', CAST(N'2024-07-03T13:16:16.583' AS DateTime), CAST(N'2024-07-03T13:16:16.583' AS DateTime), 2, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'362ea52e-bbe8-4575-a23a-b1a42ae11c11', N'EjemploA', 0, 1, N'07761dfa-7ce5-42b3-9b40-29375321322e', CAST(N'2024-06-19T12:00:32.250' AS DateTime), CAST(N'2024-06-19T12:00:32.250' AS DateTime), 0, N'bfef5abf-cff4-460b-a3af-55630d81066a')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'77263018-6d80-4e52-b1c0-b1ed72a0c08f', N'Siempre', 0, 1, N'b0426a57-6d19-4453-9640-4839197e8859', CAST(N'2024-06-19T12:11:07.057' AS DateTime), CAST(N'2024-06-19T12:11:07.057' AS DateTime), 5, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'ae3a97b8-8a0d-41d9-8574-b214237dc60b', N'Ejemplo Opcion 1', 0, 1, N'c4273e68-8869-4369-9eac-259ba870b163', CAST(N'2024-07-03T13:32:39.980' AS DateTime), CAST(N'2024-07-03T13:32:39.980' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'5dc197d9-314d-4f5e-9d18-b216a0243d23', N'En desacuerdo', 0, 1, N'943e4c32-92d1-484c-840f-27f1f22a00d7', CAST(N'2024-07-03T14:43:33.887' AS DateTime), CAST(N'2024-07-03T14:43:33.887' AS DateTime), 2, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'c34d945e-e6f8-42cc-8116-b219d6ded079', N'EjemploA', 0, 1, N'55973eec-9d86-4a83-aa90-33cbc394dd02', CAST(N'2024-06-19T12:00:32.237' AS DateTime), CAST(N'2024-06-19T12:00:32.237' AS DateTime), 0, N'bfef5abf-cff4-460b-a3af-55630d81066a')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'4b4ac625-b705-4e81-890b-b23e027a3206', N'mi opcion 2', 0, 1, N'b7a37232-4eb1-4ac4-bc7b-d9396a96000f', CAST(N'2024-05-13T12:56:22.243' AS DateTime), CAST(N'2024-05-13T12:56:22.243' AS DateTime), 3, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'38b19de7-c236-4b5b-9884-b2548c600856', N'Río Misisipi', 0, 1, N'373a2694-c2d7-4d04-a5c6-a4b25b6bc2ce', CAST(N'2024-05-14T17:15:37.347' AS DateTime), CAST(N'2024-05-14T17:15:37.347' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'39930b3d-35ef-4a8c-9d25-b260092d479e', N'Rugby', 0, 1, N'd34fb3e9-1be1-41bd-b542-957a78db78b7', CAST(N'2024-05-17T11:36:59.197' AS DateTime), CAST(N'2024-05-17T11:36:59.197' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'fddd8617-1d7b-44e8-9a99-b2b55c55c119', N'En desacuerdo', 0, 1, N'0df5898c-37bb-49e9-b288-3888bafd62f4', CAST(N'2024-07-03T14:43:33.877' AS DateTime), CAST(N'2024-07-03T14:43:33.877' AS DateTime), 2, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'd7f2bb32-bea6-498a-aacd-b2e0972a6bf2', N'Rara Vez', 0, 1, N'17f90498-53f6-48ba-858b-980b529aaf4e', CAST(N'2024-06-19T12:11:03.467' AS DateTime), CAST(N'2024-06-19T12:11:03.467' AS DateTime), 2, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'e56f9d90-b1ef-45e9-a2f6-b34081bb0ef4', N'A Veces', 0, 1, N'99821866-9268-4e60-95b6-8d932ecaded3', CAST(N'2024-07-03T13:22:31.033' AS DateTime), CAST(N'2024-07-03T13:22:31.033' AS DateTime), 3, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'9ab79a5d-b4e0-4499-92df-b3a0a595b088', N'Ejemplo Opcion 1', 1, 1, N'450e7cda-1c03-4a33-abe9-720fd4a2fe7d', CAST(N'2024-07-03T12:23:31.023' AS DateTime), CAST(N'2024-07-03T12:23:31.023' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'3f237267-d4c6-417a-9a5b-b47d3808cb9f', N'dadada', 0, 1, N'24e68314-38ec-4f1d-b5b6-ba6ef91edbf7', CAST(N'2024-06-19T11:46:13.610' AS DateTime), CAST(N'2024-06-19T11:46:13.610' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'2579e526-0a85-4218-acb1-b49d7c0b680a', N'Desarrollador Web', 0, 1, N'e00ae793-e6c1-4a2a-8ece-142bf6b7a2ee', CAST(N'2024-05-17T11:36:59.230' AS DateTime), CAST(N'2024-05-17T11:36:59.230' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'9017f221-15b2-4b04-b437-b5622a6f26c9', N'Siempre', 0, 1, N'cb7f759a-4f64-4c49-8d4e-d7716784ec88', CAST(N'2024-06-12T14:51:55.910' AS DateTime), CAST(N'2024-06-12T14:51:55.910' AS DateTime), 5, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'451cd7fc-07f5-48c4-adb5-b5714f31cb09', N'Siempre', 0, 1, N'c3d05caf-4623-4fdd-9097-e4a289cd87b8', CAST(N'2024-06-19T12:11:10.677' AS DateTime), CAST(N'2024-06-19T12:11:10.677' AS DateTime), 5, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'92a09d52-71d9-431a-8fd6-b57e2c329dbd', N'Siempre', 0, 1, N'e02c5ef7-11bf-4f62-ba9a-34b280af069a', CAST(N'2024-06-18T16:10:46.520' AS DateTime), CAST(N'2024-06-18T16:10:46.520' AS DateTime), 5, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'66eb107f-0393-43bb-8e12-b5f280570e36', N'H2O2', 0, 1, N'04ae039c-09c6-4785-923a-98279c5fd49d', CAST(N'2024-05-18T20:06:22.307' AS DateTime), CAST(N'2024-05-18T20:06:22.307' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'2454e618-3a7f-4acc-86ce-b61a288229c9', N'Ejemplo Opcion 5', 0, 1, N'2f722edf-8c3b-4682-8abf-c8305c2d18ca', CAST(N'2024-06-18T17:48:28.857' AS DateTime), CAST(N'2024-06-18T17:48:28.857' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'fe3a1ea4-9350-4e70-be6e-b63e8e67983d', N'Diseño Gráfico', 0, 1, N'e00ae793-e6c1-4a2a-8ece-142bf6b7a2ee', CAST(N'2024-05-17T11:36:59.230' AS DateTime), CAST(N'2024-05-17T11:36:59.230' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'c34d2d2f-a14e-471a-9a5d-b6672e139083', N'Siempre', 0, 1, N'57cb8739-ba65-4027-932f-ffbfebe6eadd', CAST(N'2024-07-03T13:22:31.023' AS DateTime), CAST(N'2024-07-03T13:22:31.023' AS DateTime), 5, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'e47e66d6-242c-487a-9ada-b6f680004a55', N'Abraham Lincoln', 0, 1, N'463e14a7-3123-4038-b87f-3370b24ef98c', CAST(N'2024-05-06T15:19:40.163' AS DateTime), CAST(N'2024-05-06T15:19:40.163' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'c0f8f780-3181-421b-92c6-b6fd5bd762ea', N'Invierno', 0, 1, N'24376bf1-0aa7-4b93-9e49-d1d3b983d036', CAST(N'2024-05-17T11:36:59.240' AS DateTime), CAST(N'2024-05-17T11:36:59.240' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'35edbfc4-27df-42a6-a222-b704bf7af061', N'Frecuentemente', 0, 1, N'ef9c4a21-331f-43d6-8b16-85867035a4c2', CAST(N'2024-06-18T16:19:46.777' AS DateTime), CAST(N'2024-06-18T16:19:46.777' AS DateTime), 4, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'7f7fe7cd-ccc0-4ecd-8c10-b763b20e4d31', N'Totalmente de acuerdo', 0, 1, N'0df5898c-37bb-49e9-b288-3888bafd62f4', CAST(N'2024-07-03T14:43:33.877' AS DateTime), CAST(N'2024-07-03T14:43:33.877' AS DateTime), 5, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'daa45abe-c1cd-4461-91ee-b7b9b3799abf', N'Alan Shepard', 0, 1, N'0f480871-91b1-4cb3-b489-acca5c45edd1', CAST(N'2024-05-18T20:06:22.280' AS DateTime), CAST(N'2024-05-18T20:06:22.280' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'e7b61d92-009a-4130-9b01-b7d6395eb2af', N'Todos los días', 0, 1, N'f569a206-15cb-4fb8-9bc1-d76405aa7bc9', CAST(N'2024-05-17T11:36:59.200' AS DateTime), CAST(N'2024-05-17T11:36:59.200' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'4edb2cf2-dbc4-40e8-8ba7-b7ebd84ce01c', N'¿Cuándo fue el descubrimiento de América por Cristóbal Colón?', 0, 1, N'6bc1d81e-3cba-4c9c-a06e-5671ad6be6f2', CAST(N'2024-06-03T16:18:15.330' AS DateTime), CAST(N'2024-06-03T16:18:15.330' AS DateTime), 0, N'1e2e9f6c-4c7f-4142-8317-c398db956764')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'7c27bc49-4340-49ba-bbe2-b83d3b068a5d', N'Urano', 0, 1, N'ae85ef32-0e82-487f-a2c1-6d1b5b6477ff', CAST(N'2024-05-06T15:19:40.173' AS DateTime), CAST(N'2024-05-06T15:19:40.173' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'14cd7548-71d0-4305-a313-b8476bff9d67', N'Ejemplo Opcion 4', 0, 1, N'9d6aa9f8-e6a9-4dd9-ade8-d0e2d0e53309', CAST(N'2024-06-18T17:48:28.873' AS DateTime), CAST(N'2024-06-18T17:48:28.873' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'cc7b0066-6878-4f16-9478-b89b7c4636c8', N'A Veces', 0, 1, N'4b9c5102-2cf1-48bf-8983-162fef069f5d', CAST(N'2024-07-03T13:16:16.587' AS DateTime), CAST(N'2024-07-03T13:16:16.587' AS DateTime), 3, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'15434116-7d41-41c6-84fe-b93591da1e0f', N'En desacuerdo', 0, 1, N'413ba92b-3c48-496e-9edd-0c45029a9f5c', CAST(N'2024-06-19T11:51:12.137' AS DateTime), CAST(N'2024-06-19T11:51:12.137' AS DateTime), 2, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'71acc2bb-4539-4f8c-b24c-b98954cb3168', N'Ejemplo Opcion 2', 0, 1, N'aed89eab-a165-406f-926d-689ef0fa2ccb', CAST(N'2024-07-03T13:32:39.990' AS DateTime), CAST(N'2024-07-03T13:32:39.990' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'9078db67-1c81-46cf-a67a-b9bdd03f12b1', N'Ejemplo Opcion 5', 0, 1, N'e20687bd-bdd9-4edf-8bf4-8caa5cb8d616', CAST(N'2024-07-03T13:32:39.997' AS DateTime), CAST(N'2024-07-03T13:32:39.997' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'e2c48b03-7076-4454-8bbe-bae079d5ed6b', N'Océano Atlántico', 1, 1, N'bc51aa83-4654-4be0-878f-087bde6893ec', CAST(N'2024-05-14T17:15:37.330' AS DateTime), CAST(N'2024-05-14T17:15:37.330' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'd9b0003d-b081-4990-8fb3-bb516c4f5905', N'¿A que hora es el almuerzo?', 0, 1, N'ee2e1db9-86c6-4da4-b2ed-4ed9626b4ea4', CAST(N'2024-05-21T12:25:25.557' AS DateTime), CAST(N'2024-05-21T12:25:25.557' AS DateTime), 0, N'357dbf15-2a3e-4424-9005-9325bba3462c')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'328edd7a-f447-4085-86a1-bb6cc6d7229a', N'EjemploC', 0, 1, N'20548ecc-bf50-4caf-8b89-557e148467cc', CAST(N'2024-06-19T11:59:34.723' AS DateTime), CAST(N'2024-06-19T11:59:34.723' AS DateTime), 0, N'1e2e9f6c-4c7f-4142-8317-c398db956764')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'9d036432-f660-4b68-bcfd-bbb23d6bfdbc', N'Leonardo da Vinci', 1, 1, N'749cb8ac-109f-476e-8f3c-6396c6ebb8fd', CAST(N'2024-05-06T15:19:40.153' AS DateTime), CAST(N'2024-05-06T15:19:40.153' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'bfd8757e-4dd0-4fcf-b9c5-bbd01c9a9e66', N'sgsgs', 0, 1, N'4d6449d8-69a2-4062-a77d-f3f9e3a3777f', CAST(N'2024-06-19T11:46:31.547' AS DateTime), CAST(N'2024-06-19T11:46:31.547' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'c95255b0-376b-4d10-9f7b-bc331da28b03', N'Ejemploc', 0, 1, N'bb1e7ac7-c516-4341-bbda-73dbc86dd1fc', CAST(N'2024-06-19T09:55:04.433' AS DateTime), CAST(N'2024-06-19T09:55:04.433' AS DateTime), 0, N'1e2e9f6c-4c7f-4142-8317-c398db956764')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'5a5e7416-331f-4fa9-8b5f-bc34707a6d00', N'EjemploE', 0, 1, N'cfb97942-1699-472b-9ab0-43c3a159ec62', CAST(N'2024-06-19T12:00:32.243' AS DateTime), CAST(N'2024-06-19T12:00:32.243' AS DateTime), 0, N'357dbf15-2a3e-4424-9005-9325bba3462c')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'4d0f9259-3b6e-45c9-9e3f-bc8605437110', N'Rara Vez', 0, 1, N'0efc1f0a-ac87-466e-bb5e-5f3ae9c0f814', CAST(N'2024-06-18T16:11:02.860' AS DateTime), CAST(N'2024-06-18T16:11:02.860' AS DateTime), 2, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'51cd534a-7261-468e-840c-bcd2d3c65e1c', N'Pollo', 0, 1, N'fbdb896d-999e-4123-9d57-804508ddd7c1', CAST(N'2024-05-17T11:36:59.183' AS DateTime), CAST(N'2024-05-17T11:36:59.183' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'baeed5f8-246e-4c2d-8a05-bd68e59dc6f6', N'Natación', 0, 1, N'd34fb3e9-1be1-41bd-b542-957a78db78b7', CAST(N'2024-05-17T11:36:59.197' AS DateTime), CAST(N'2024-05-17T11:36:59.197' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'5102808f-8a68-4ad9-9fb9-beade895b672', N'Océano Ártico', 0, 1, N'17944192-2c92-4b92-af87-94ce8928651e', CAST(N'2024-05-18T20:06:22.260' AS DateTime), CAST(N'2024-05-18T20:06:22.260' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'288ff812-eab3-4494-b88e-bf5141210867', N'Victor Hugo', 0, 1, N'44f97be2-194e-40cc-9d42-9ebfd8a3aaad', CAST(N'2024-05-06T15:19:40.160' AS DateTime), CAST(N'2024-05-06T15:19:40.160' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'45a949a0-d3cd-431c-823b-bf53b05b27f0', N'Ejemplo Opcion 5', 0, 1, N'f5535438-f8f2-441d-b3ce-266d618d8301', CAST(N'2024-07-03T13:32:40.003' AS DateTime), CAST(N'2024-07-03T13:32:40.003' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'afcf572c-05f0-4660-9672-bf823a8c2362', N'De acuerdo', 0, 1, N'413ba92b-3c48-496e-9edd-0c45029a9f5c', CAST(N'2024-06-19T11:51:12.137' AS DateTime), CAST(N'2024-06-19T11:51:12.137' AS DateTime), 4, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'088e0763-0d64-4875-94f3-bfe357f2e358', N'Roma', 0, 1, N'baa87899-d51f-4893-a1fa-882556a8d2a4', CAST(N'2024-05-06T15:19:40.157' AS DateTime), CAST(N'2024-05-06T15:19:40.157' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'5a3014f0-3545-4d81-8138-c08d2b2fcec3', N'Totalmente en desacuerdo', 0, 1, N'741d8042-94e7-4865-8b44-7ab832561eba', CAST(N'2024-07-03T14:43:33.880' AS DateTime), CAST(N'2024-07-03T14:43:33.880' AS DateTime), 1, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'69b82684-d51c-4fbc-9033-c12bccfc2446', N'Ejemplo Opcion 7', 0, 1, N'e20687bd-bdd9-4edf-8bf4-8caa5cb8d616', CAST(N'2024-07-03T13:32:40.000' AS DateTime), CAST(N'2024-07-03T13:32:40.000' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'c37b78cc-15e4-4ee4-8030-c130589c31c0', N'esta es la op 2', 0, 1, N'695f6412-574f-4c5b-9de1-172db0e97d6f', CAST(N'2024-05-10T17:09:38.917' AS DateTime), CAST(N'2024-05-13T11:49:11.780' AS DateTime), 4, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'fe2db1b9-de8b-4830-9942-c13356c50aca', N'Jane Austen', 0, 1, N'5eba467e-fcd2-4b64-8da4-aa167d1c2539', CAST(N'2024-05-14T17:15:37.367' AS DateTime), CAST(N'2024-05-14T17:15:37.367' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'b8952831-03ea-45d2-af90-c17584181745', N'En desacuerdo', 0, 1, N'0d893612-4eb6-4049-a0d7-3b9ce643b426', CAST(N'2024-06-19T11:51:12.147' AS DateTime), CAST(N'2024-06-19T11:51:12.147' AS DateTime), 2, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'82de273b-f1b5-4c36-847d-c237c9b745b5', N'd', 1, 1, N'24e68314-38ec-4f1d-b5b6-ba6ef91edbf7', CAST(N'2024-06-19T11:46:13.610' AS DateTime), CAST(N'2024-06-19T11:46:13.610' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'1c932230-6de6-4f31-8776-c23debacac32', N'Berlín', 0, 1, N'e21a8ca2-e2a6-4d4e-a739-d44f132aa2aa', CAST(N'2024-05-14T17:15:37.337' AS DateTime), CAST(N'2024-05-14T17:15:37.337' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'6dab28ea-8171-4648-bb20-c2a54c96dc0b', N'EjemploC', 0, 1, N'55973eec-9d86-4a83-aa90-33cbc394dd02', CAST(N'2024-06-19T12:00:32.240' AS DateTime), CAST(N'2024-06-19T12:00:32.240' AS DateTime), 0, N'1e2e9f6c-4c7f-4142-8317-c398db956764')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'ee686074-1ceb-404f-8962-c389c537d221', N'En desacuerdo', 0, 1, N'70b4c4fb-d8ed-49f1-bc61-65ad9489eff8', CAST(N'2024-05-14T16:59:43.417' AS DateTime), CAST(N'2024-05-15T16:25:50.973' AS DateTime), 2, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'77cfffc4-0aff-472a-aff8-c40f27ac3bfd', N'Neutral', 0, 1, N'dff06a15-ed76-4999-8518-574bbb7998c3', CAST(N'2024-07-03T14:43:33.873' AS DateTime), CAST(N'2024-07-03T14:43:33.873' AS DateTime), 3, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'f974ddc3-49a8-4524-bfeb-c4316c44991a', N'España', 0, 1, N'2e72a58f-12e4-4d00-8857-50d25671d4a1', CAST(N'2024-05-14T17:15:37.377' AS DateTime), CAST(N'2024-05-14T17:15:37.377' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'50e1ee98-2597-4003-90b7-c43f9ca8509f', N'a', 1, 1, N'25a40b35-3438-4acd-a267-3edd3dcb550b', CAST(N'2024-06-18T16:41:33.313' AS DateTime), CAST(N'2024-06-18T16:41:33.313' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'd77a9218-8737-4d09-ae38-c4495b1a12b8', N'Ejemplo Opcion 8', 0, 1, N'7fa649e1-4ca7-43e6-9211-1cbacceccc50', CAST(N'2024-07-03T13:32:40.020' AS DateTime), CAST(N'2024-07-03T13:32:40.020' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'242821e6-1217-419f-a3fa-c4fe9111ec65', N'Abraham Lincoln', 0, 1, N'bd26060a-0a5f-4dca-9ce3-14bd3bda2ae7', CAST(N'2024-05-14T17:15:37.347' AS DateTime), CAST(N'2024-05-14T17:15:37.347' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'364a9b41-a8ad-45ca-8f30-c5e3d2149b6b', N'Kiev', 0, 1, N'36e6a35d-0678-4725-95a1-fb1ec32103fd', CAST(N'2024-05-06T15:19:40.183' AS DateTime), CAST(N'2024-05-06T15:19:40.183' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'42de051c-ded1-4190-881c-c5f85f1a8f76', N'Totalmente de acuerdo', 0, 1, N'70b4c4fb-d8ed-49f1-bc61-65ad9489eff8', CAST(N'2024-05-14T16:59:43.413' AS DateTime), CAST(N'2024-05-15T16:25:50.970' AS DateTime), 5, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'72b132ef-0794-468c-848b-c651646802cb', N'Frecuentemente', 0, 1, N'c3d05caf-4623-4fdd-9097-e4a289cd87b8', CAST(N'2024-06-19T12:11:10.677' AS DateTime), CAST(N'2024-06-19T12:11:10.677' AS DateTime), 4, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'c72f0d96-719f-4e82-8733-c6ee891813b1', N'Ejemplo Opcion 7', 0, 1, N'9d6aa9f8-e6a9-4dd9-ade8-d0e2d0e53309', CAST(N'2024-06-18T17:48:28.877' AS DateTime), CAST(N'2024-06-18T17:48:28.877' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'f9ad8ace-2c72-46d4-9b05-c761c00bd342', N'Fotosintesis', 1, 1, N'a832fc7d-fc43-42e1-ab7c-6d6144832af8', CAST(N'2024-05-06T15:19:40.177' AS DateTime), CAST(N'2024-05-06T15:19:40.177' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'8a9d5669-0b8e-4aed-83c9-c76a4092b966', N'Ejemplo Opcion 5', 0, 1, N'9845c3de-be89-4405-8cc6-5422f6928eb9', CAST(N'2024-06-18T17:48:28.870' AS DateTime), CAST(N'2024-06-18T17:48:28.870' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'4b86fe37-a4b9-45c5-9556-c788e40914d0', N'Ejemplo Opcion 3', 0, 1, N'9845c3de-be89-4405-8cc6-5422f6928eb9', CAST(N'2024-06-18T17:48:28.867' AS DateTime), CAST(N'2024-06-18T17:48:28.867' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'bef4d88a-1bc7-4bf6-92de-c7f079c7161e', N'Miguel Hidalgo', 0, 1, N'c0362a07-5bb1-40b4-bef6-61da48da4878', CAST(N'2024-05-18T20:06:22.303' AS DateTime), CAST(N'2024-05-18T20:06:22.303' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'c167599a-8244-433b-a21e-c7f1c5c7f683', N'Nunca', 0, 1, N'a924c254-6554-4b24-8fae-47163f0ebb93', CAST(N'2024-06-18T15:58:50.337' AS DateTime), CAST(N'2024-06-18T15:58:50.337' AS DateTime), 1, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'828ab1dc-1950-4e02-a547-c8550a3d5b21', N'Océano Pacífico', 0, 1, N'bc51aa83-4654-4be0-878f-087bde6893ec', CAST(N'2024-05-14T17:15:37.333' AS DateTime), CAST(N'2024-05-14T17:15:37.333' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'dbdcfc9c-bf6d-4dea-a877-c886af91f676', N'Ciclismo', 0, 1, N'd34fb3e9-1be1-41bd-b542-957a78db78b7', CAST(N'2024-05-17T11:36:59.197' AS DateTime), CAST(N'2024-05-17T11:36:59.197' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'b4f1ae7c-c9cb-467b-b057-c88a6545281a', N'EjemploC', 0, 1, N'cfb97942-1699-472b-9ab0-43c3a159ec62', CAST(N'2024-06-19T12:00:32.243' AS DateTime), CAST(N'2024-06-19T12:00:32.243' AS DateTime), 0, N'1e2e9f6c-4c7f-4142-8317-c398db956764')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'b8d901a3-bdba-441d-b7dc-c890a70bb660', N'Ejemplo Opcion 2', 0, 1, N'93a7cd55-8c95-4ace-9468-e3a78528fa74', CAST(N'2024-07-03T13:32:40.010' AS DateTime), CAST(N'2024-07-03T13:32:40.010' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'5f67c9d5-5131-408f-a1d3-c8c5ad706331', N'Totalmente de acuerdo', 0, 1, N'dff06a15-ed76-4999-8518-574bbb7998c3', CAST(N'2024-07-03T14:43:33.873' AS DateTime), CAST(N'2024-07-03T14:43:33.873' AS DateTime), 5, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'793515bb-c814-428c-830e-c8d9b1677657', N'Aluminio', 1, 1, N'2a24fe22-f17e-4dd5-974a-171dfe3c6f9c', CAST(N'2024-05-06T15:19:40.170' AS DateTime), CAST(N'2024-05-06T15:19:40.170' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'0cf00652-2f8d-4662-91d5-c8ff9750c21b', N'Música Latina', 0, 1, N'253efaf1-4751-416d-aebd-3f82ca9ecc86', CAST(N'2024-05-17T11:36:59.190' AS DateTime), CAST(N'2024-05-17T11:36:59.190' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'42b1c5ba-12a7-4d17-95ae-c990f466fb22', N'Nunca', 0, 1, N'fa5519d0-d84c-45d7-aa53-2234c77fff60', CAST(N'2024-06-19T12:11:14.567' AS DateTime), CAST(N'2024-06-19T12:11:14.567' AS DateTime), 1, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'20e0037d-4e20-4893-9288-c9f9e0e5911b', N'EjemploA', 0, 1, N'20548ecc-bf50-4caf-8b89-557e148467cc', CAST(N'2024-06-19T11:59:34.723' AS DateTime), CAST(N'2024-06-19T11:59:34.723' AS DateTime), 0, N'bfef5abf-cff4-460b-a3af-55630d81066a')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'ac5ed6f7-73b6-45ee-ab49-ca0e1d2657b0', N'Ejemplo Opcion 10', 0, 1, N'93a7cd55-8c95-4ace-9468-e3a78528fa74', CAST(N'2024-07-03T13:32:40.017' AS DateTime), CAST(N'2024-07-03T13:32:40.017' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'4f7e2d83-8abd-44b2-841d-ca6a614ae376', N'Bus', 0, 1, N'768ae381-8735-43ad-8c33-77b4836a070f', CAST(N'2024-05-17T11:36:59.213' AS DateTime), CAST(N'2024-05-17T11:36:59.213' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'8429d797-5628-4b08-9da7-cab301964a7b', N'Fémur', 1, 1, N'cb0edcd3-1843-49d0-b98f-d1894a876054', CAST(N'2024-05-14T17:15:37.357' AS DateTime), CAST(N'2024-05-14T17:15:37.357' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'd29c967a-638f-42b0-9882-cae03eed4b67', N'Rara Vez', 0, 1, N'0dcec066-50db-4981-93fb-0dbc3b528d07', CAST(N'2024-06-12T14:52:32.303' AS DateTime), CAST(N'2024-06-12T14:52:32.303' AS DateTime), 2, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'646ef339-8c1f-4edd-b275-cb2147ca1402', N'Monte Everest', 1, 1, N'f48a82eb-8845-4172-b53d-b3cd42ffa07e', CAST(N'2024-05-06T15:19:40.157' AS DateTime), CAST(N'2024-05-06T15:19:40.157' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'58f0cbb3-5652-443d-9e13-cb3e4bf7e4a6', N'Plata', 0, 1, N'9fc8b8e0-4832-437c-88ba-0e5f4cb6585c', CAST(N'2024-05-18T20:06:22.283' AS DateTime), CAST(N'2024-05-18T20:06:22.283' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'cb97c4ee-9239-406f-9f2a-cb5c6995327b', N'Ejemplo Opcion 6', 0, 1, N'9d6aa9f8-e6a9-4dd9-ade8-d0e2d0e53309', CAST(N'2024-06-18T17:48:28.877' AS DateTime), CAST(N'2024-06-18T17:48:28.877' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'3134e9da-6c72-441f-b030-cb615290ff96', N'Madrid', 0, 1, N'3418513a-2424-4676-9cc1-a071fbcc32e5', CAST(N'2024-05-18T20:06:22.263' AS DateTime), CAST(N'2024-05-18T20:06:22.263' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'83da4a79-4769-40c7-bbee-cbd3b40db817', N'Atletismo', 0, 1, N'd34fb3e9-1be1-41bd-b542-957a78db78b7', CAST(N'2024-05-17T11:36:59.197' AS DateTime), CAST(N'2024-05-17T11:36:59.197' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'9cfa7bfc-66d8-49ea-8169-cc42d2ada777', N'Siempre', 0, 1, N'4b9c5102-2cf1-48bf-8983-162fef069f5d', CAST(N'2024-07-03T13:16:16.587' AS DateTime), CAST(N'2024-07-03T13:16:16.587' AS DateTime), 5, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'5210b3ab-a255-4c21-b594-cc58d3773e62', N'Raramente', 0, 1, N'f569a206-15cb-4fb8-9bc1-d76405aa7bc9', CAST(N'2024-05-17T11:36:59.200' AS DateTime), CAST(N'2024-05-17T11:36:59.200' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'87452ef0-3dfe-461b-a186-ccd1bb4a8476', N'Océano Ártico', 0, 1, N'bc51aa83-4654-4be0-878f-087bde6893ec', CAST(N'2024-05-14T17:15:37.333' AS DateTime), CAST(N'2024-05-14T17:15:37.333' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'6821bc2b-5f67-4617-9dd0-cd050d60230c', N'Ejemplo Opcion 10', 0, 1, N'dda0bb6e-5579-4971-a05a-a1a20c4482ac', CAST(N'2024-06-18T17:48:28.883' AS DateTime), CAST(N'2024-06-18T17:48:28.883' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'6660dbf1-5d86-419a-92cf-cdfd6c891aef', N'Ejemplo Opcion 5', 0, 1, N'93a7cd55-8c95-4ace-9468-e3a78528fa74', CAST(N'2024-07-03T13:32:40.013' AS DateTime), CAST(N'2024-07-03T13:32:40.013' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'6f5cc486-dc1c-4844-afcf-ce80af6a266d', N'Color de piel', 0, 1, N'ab319e07-97f2-4ae0-8862-527e4ed6f972', CAST(N'2024-05-17T11:36:59.180' AS DateTime), CAST(N'2024-05-17T11:36:59.180' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'e625ccba-87f8-4437-986e-ce84c1a42837', N'Neutral', 0, 1, N'60e85430-d266-481d-ab99-90b825ba4ed7', CAST(N'2024-06-19T11:51:12.140' AS DateTime), CAST(N'2024-06-19T11:51:12.140' AS DateTime), 3, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'd665d6d2-9420-48bc-bbf9-cf9069f4c87f', N'Miguel de Cervantes', 0, 1, N'2e3c17ca-b700-48e1-be55-636ddbf6995d', CAST(N'2024-05-18T20:06:22.270' AS DateTime), CAST(N'2024-05-18T20:06:22.270' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'968eed1d-9f6c-484d-ad89-cf9fa17d1890', N'Ejemplo Opcion 4', 0, 1, N'06fb7cfc-9e4f-4c35-b6ab-1cd0d31e187a', CAST(N'2024-07-03T12:23:31.023' AS DateTime), CAST(N'2024-07-03T12:23:31.023' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'cf1b3685-f74d-4f28-bd80-d046c9184275', N'Ejemplob', 0, 1, N'07761dfa-7ce5-42b3-9b40-29375321322e', CAST(N'2024-06-19T12:00:32.250' AS DateTime), CAST(N'2024-06-19T12:00:32.250' AS DateTime), 0, N'357dbf15-2a3e-4424-9005-9325bba3462c')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'23b3bd74-1738-405d-99cd-d0a4a1a18e10', N'Posgrado', 0, 1, N'5cb81db3-01ac-49b5-9855-e8f9b686a99f', CAST(N'2024-05-17T11:36:59.173' AS DateTime), CAST(N'2024-05-17T11:36:59.173' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'b8ab4376-19d9-4900-a816-d0bf352228a2', N'EjemploC', 0, 1, N'4d30043b-9bbf-4dac-8e4c-c3663eb83655', CAST(N'2024-06-19T12:00:32.247' AS DateTime), CAST(N'2024-06-19T12:00:32.247' AS DateTime), 0, N'1e2e9f6c-4c7f-4142-8317-c398db956764')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'125c4034-c031-4e81-ab3e-d13201115396', N'Ejemplo Opcion 2', 0, 1, N'7fa649e1-4ca7-43e6-9211-1cbacceccc50', CAST(N'2024-07-03T13:32:40.017' AS DateTime), CAST(N'2024-07-03T13:32:40.017' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'a0885dd9-bdb4-4926-9af3-d235bd646177', N'Ejemplo Opcion 3', 0, 1, N'3a113ec5-79f5-40e6-93af-6971eccea36a', CAST(N'2024-07-03T12:23:31.030' AS DateTime), CAST(N'2024-07-03T12:23:31.030' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'8cb075af-fa9d-4401-a867-d2bed5a3d3ce', N'Sopa de fideos', 0, 1, N'fbdb896d-999e-4123-9d57-804508ddd7c1', CAST(N'2024-05-17T11:36:59.183' AS DateTime), CAST(N'2024-05-17T11:36:59.183' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'015534e1-30da-4012-829c-d2d0add8f896', N'Rara Vez', 0, 1, N'6340dd21-34ab-40a9-8103-116a1ebce518', CAST(N'2024-07-03T13:16:16.597' AS DateTime), CAST(N'2024-07-03T13:16:16.597' AS DateTime), 2, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'5cfa3d62-9dab-4878-b7d6-d30926dfb36e', N'A Veces', 0, 1, N'5bfc42e7-4c0e-43af-83e8-8721e3a6d8df', CAST(N'2024-06-12T17:32:03.223' AS DateTime), CAST(N'2024-06-12T17:32:03.223' AS DateTime), 3, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'8b6ed7df-c82a-4f2e-bde3-d33052689e78', N'Yuan', 0, 1, N'e033dd49-efc7-4cc3-8553-44134c409196', CAST(N'2024-05-14T17:15:37.363' AS DateTime), CAST(N'2024-05-14T17:15:37.363' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'4da16591-94a5-4d68-a330-d34cf9f6ec21', N'sfsf', 0, 1, N'a4b0ad13-26a9-4278-b701-8ec9bf6031c3', CAST(N'2024-06-19T11:46:55.580' AS DateTime), CAST(N'2024-06-19T11:46:55.580' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'1f7c8d9d-afe0-43f4-951a-d352b6727fa1', N'Transferencia de estado representacional', 1, 1, N'43c4c9c4-b885-4bc4-83cb-1e3a257c3530', CAST(N'2024-02-27T16:55:53.440' AS DateTime), CAST(N'2024-02-27T16:55:53.440' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'd549017b-2e81-4c48-b4d5-d352dbcfb5ea', N'Guadalupe Victoria', 1, 1, N'f29610cb-4dfb-4e89-9c70-bd56031bf137', CAST(N'2024-05-14T17:15:37.373' AS DateTime), CAST(N'2024-05-14T17:15:37.373' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'f582fc74-2bd9-463e-be4f-d3731d67be25', N'Ejemplo Opcion 1', 0, 1, N'9845c3de-be89-4405-8cc6-5422f6928eb9', CAST(N'2024-06-18T17:48:28.867' AS DateTime), CAST(N'2024-06-18T17:48:28.867' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'991f6e65-9cef-4596-a31d-d3be3144911f', N'Musical', 0, 1, N'6122e532-6296-4b7f-b2cf-a91b1e1ce8a2', CAST(N'2024-05-17T11:36:59.210' AS DateTime), CAST(N'2024-05-17T11:36:59.210' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'1d69776b-67fd-475b-a656-d4277fa345be', N'Diseño Instruccional', 0, 1, N'e00ae793-e6c1-4a2a-8ece-142bf6b7a2ee', CAST(N'2024-05-17T11:36:59.227' AS DateTime), CAST(N'2024-05-17T11:36:59.227' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'e152e0c4-b652-4983-a5d5-d5b563272369', N'op b', 0, 1, N'5c5fe21d-35a5-4e83-88be-c5004d5027bf', CAST(N'2024-05-19T18:25:12.537' AS DateTime), CAST(N'2024-05-19T18:25:12.537' AS DateTime), 0, N'357dbf15-2a3e-4424-9005-9325bba3462c')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'7cf6bbdf-cc98-4ae0-b9db-d6333ad91f3c', N'Totalmente de acuerdo', 0, 1, N'74dbbef1-3d7b-4c36-aaf5-f459715311b0', CAST(N'2024-06-19T11:51:12.150' AS DateTime), CAST(N'2024-06-19T11:51:12.150' AS DateTime), 5, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'07480e79-96de-4c63-8cf3-d64efb0281da', N'Moscú', 1, 1, N'e0c81067-b353-4659-b29c-d909d1209830', CAST(N'2024-05-18T20:06:22.300' AS DateTime), CAST(N'2024-05-18T20:06:22.300' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'0ff238b4-fd7b-4e71-b520-d65ad2ee543e', N'Ejemplo', 0, 1, N'82c82b89-5159-4ed0-ba74-0e7ca1b157cd', CAST(N'2024-07-03T11:55:14.127' AS DateTime), CAST(N'2024-07-03T11:55:14.127' AS DateTime), 0, N'bfef5abf-cff4-460b-a3af-55630d81066a')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'713b316f-dcda-4948-8b0c-d6c98eb78e39', N'EjemploA', 0, 1, N'cfb97942-1699-472b-9ab0-43c3a159ec62', CAST(N'2024-06-19T12:00:32.243' AS DateTime), CAST(N'2024-06-19T12:00:32.243' AS DateTime), 0, N'bfef5abf-cff4-460b-a3af-55630d81066a')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'34487073-a2dd-4a03-be7b-d7059a07aa18', N'Húmero', 0, 1, N'8aae72a1-8f0e-4bcc-a4c4-86d7cc5bced9', CAST(N'2024-05-06T15:19:40.170' AS DateTime), CAST(N'2024-05-06T15:19:40.170' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'c77833b1-3305-46bb-a84f-d85cb184a20a', N'Italia', 0, 1, N'2e72a58f-12e4-4d00-8857-50d25671d4a1', CAST(N'2024-05-14T17:15:37.373' AS DateTime), CAST(N'2024-05-14T17:15:37.373' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'c3a39077-5b21-4919-aa94-d95fec05c238', N'Frecuentemente', 0, 1, N'57cb8739-ba65-4027-932f-ffbfebe6eadd', CAST(N'2024-07-03T13:22:31.023' AS DateTime), CAST(N'2024-07-03T13:22:31.023' AS DateTime), 4, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'f604eb9c-d55f-40ae-ba7b-d9ed9f53b928', N'dadad', 1, 1, N'8160596f-0937-4f1e-9bca-415a56db719e', CAST(N'2024-06-19T11:46:45.600' AS DateTime), CAST(N'2024-06-19T11:46:45.600' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'a3f88cc3-e998-4803-9a54-da02efb8ddd5', N'Refresco', 0, 1, N'331bea1d-cf31-4085-bda8-fc1544356c4d', CAST(N'2024-05-17T11:36:59.220' AS DateTime), CAST(N'2024-05-17T11:36:59.220' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'45f7b911-7397-4f2c-8ed7-da7ccb6acdda', N'Ejemplo Opcion 1', 0, 1, N'aed89eab-a165-406f-926d-689ef0fa2ccb', CAST(N'2024-07-03T13:32:39.987' AS DateTime), CAST(N'2024-07-03T13:32:39.987' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'c2a8e504-ebec-4255-bc03-da8a8c7d6f32', N'Boxeo', 0, 1, N'd34fb3e9-1be1-41bd-b542-957a78db78b7', CAST(N'2024-05-17T11:36:59.197' AS DateTime), CAST(N'2024-05-17T11:36:59.197' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'78c9c69b-79c8-4d62-bddb-dac0fb6711e2', N'A Veces', 0, 1, N'b0426a57-6d19-4453-9640-4839197e8859', CAST(N'2024-06-19T12:11:07.057' AS DateTime), CAST(N'2024-06-19T12:11:07.057' AS DateTime), 3, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'38a40f9e-cfbc-42fd-bf58-db30fb0d036f', N'Frecuentemente', 0, 1, N'6340dd21-34ab-40a9-8103-116a1ebce518', CAST(N'2024-07-03T13:16:16.597' AS DateTime), CAST(N'2024-07-03T13:16:16.597' AS DateTime), 4, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'e1d111e3-56fc-4c18-8313-dbb51bc288e9', N'25', 0, 1, N'170d9f8d-3df7-433e-9c2a-3758c9ac57cf', CAST(N'2024-05-09T18:04:09.280' AS DateTime), CAST(N'2024-05-09T18:04:09.280' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'66d8b024-8f6c-4406-9e5f-dbc02d9fc351', N'sfs', 0, 1, N'a4b0ad13-26a9-4278-b701-8ec9bf6031c3', CAST(N'2024-06-19T11:46:55.580' AS DateTime), CAST(N'2024-06-19T11:46:55.580' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'a8672458-45c2-4903-97d2-dbf4c2867e80', N'Asistente de Gerencia', 0, 1, N'e00ae793-e6c1-4a2a-8ece-142bf6b7a2ee', CAST(N'2024-05-17T11:36:59.230' AS DateTime), CAST(N'2024-05-17T11:36:59.230' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'34f92c54-4b75-4f1b-a685-dc54ebff410d', N'Ejemplo Opcion 6', 0, 1, N'93a7cd55-8c95-4ace-9468-e3a78528fa74', CAST(N'2024-07-03T13:32:40.013' AS DateTime), CAST(N'2024-07-03T13:32:40.013' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'e02e838c-0fc7-4052-8cbd-dca29a300f5f', N'En desacuerdo', 0, 1, N'9f118e9f-8fd8-42f7-bced-3dd76988cdb2', CAST(N'2024-07-03T14:43:33.883' AS DateTime), CAST(N'2024-07-03T14:43:33.883' AS DateTime), 2, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'b09c27f4-95e7-49b1-a8ff-dcbd2dccacf4', N'Yuri Gagarin', 1, 1, N'e2b3cbeb-3e97-4e0b-993a-4123bec5538c', CAST(N'2024-05-06T15:19:40.167' AS DateTime), CAST(N'2024-05-06T15:19:40.167' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'eef8d894-2464-4023-b994-dcca89e6d522', N'A Veces', 0, 1, N'f0b0ac75-b7bb-472f-b612-20a394e71343', CAST(N'2024-06-12T14:23:58.077' AS DateTime), CAST(N'2024-06-12T14:23:58.077' AS DateTime), 3, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'196bd757-63bd-4479-bf2b-dd40754ddb76', N'Yen', 1, 1, N'32dbc843-a741-4474-9106-2001753aa21d', CAST(N'2024-05-06T15:19:40.177' AS DateTime), CAST(N'2024-05-06T15:19:40.177' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'376b51f9-66e3-478a-a8f3-dd8b1019fabc', N'Universidad', 0, 1, N'5cb81db3-01ac-49b5-9855-e8f9b686a99f', CAST(N'2024-05-17T11:36:59.173' AS DateTime), CAST(N'2024-05-17T11:36:59.173' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'e145c6f4-f8c3-457f-97ce-ddcc774d1fd4', N'Leonardo da Vinci', 1, 1, N'825d1a65-2bbc-4120-bade-7a304a8d44bd', CAST(N'2024-05-18T20:06:22.260' AS DateTime), CAST(N'2024-05-18T20:06:22.260' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'72e15a23-7d5a-4570-a93a-de0612e7803e', N'Transpiración', 0, 1, N'3144a4a4-2d01-4bc1-9d2e-b0365f6b125c', CAST(N'2024-05-18T20:06:22.290' AS DateTime), CAST(N'2024-05-18T20:06:22.290' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'eee81b3c-c4c1-4814-85a4-de8ab4cd1c8e', N'A Veces', 0, 1, N'8b05542f-0c09-435f-b3f3-56cb286a72ff', CAST(N'2024-07-03T13:22:31.020' AS DateTime), CAST(N'2024-07-03T13:22:31.020' AS DateTime), 3, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'de9b8550-6464-4de5-8a9b-df243b016e43', N'Totalmente de acuerdo', 0, 1, N'60e85430-d266-481d-ab99-90b825ba4ed7', CAST(N'2024-06-19T11:51:12.140' AS DateTime), CAST(N'2024-06-19T11:51:12.140' AS DateTime), 5, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'b751b06b-243d-4e7a-bb5a-df3c11bbd257', N'Abraham Lincoln', 0, 1, N'd0e024f3-e436-4f39-aa16-9ec0d638b825', CAST(N'2024-05-18T20:06:22.273' AS DateTime), CAST(N'2024-05-18T20:06:22.273' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'47fa88ca-0ffc-4f9d-9534-df5559d2c175', N'Ejemplo Opcion 7', 0, 1, N'2f722edf-8c3b-4682-8abf-c8305c2d18ca', CAST(N'2024-06-18T17:48:28.857' AS DateTime), CAST(N'2024-06-18T17:48:28.857' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'fc1a3c3e-7305-4dd9-ab31-e02392ab49e0', N'Neutral', 0, 1, N'942152b7-25fc-47f6-a41d-9b420ab8231a', CAST(N'2024-06-12T14:19:17.327' AS DateTime), CAST(N'2024-06-12T14:19:17.327' AS DateTime), 3, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'5682154a-3859-4340-ae8a-e0cb501c486e', N'Húmero', 0, 1, N'70cc4b45-c763-4e54-9728-98738a0e57ca', CAST(N'2024-05-18T20:06:22.283' AS DateTime), CAST(N'2024-05-18T20:06:22.283' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'd9fba8d0-d5b0-4481-b730-e16e2c70a442', N'muy malo', 0, 1, N'2f4a9a17-f878-4788-8a84-0ace26143d43', CAST(N'2024-05-13T15:25:20.927' AS DateTime), CAST(N'2024-05-13T15:25:20.927' AS DateTime), 1, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'ea031861-d297-40a3-9430-e1b513d43dd5', N'Vincent van Gogh', 0, 1, N'17f78458-362d-4b64-b1ef-1c2a868733f9', CAST(N'2024-05-14T17:15:37.333' AS DateTime), CAST(N'2024-05-14T17:15:37.333' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'7b7ce5c3-19cf-49f1-a8eb-e200e321e420', N'Yen', 1, 1, N'63afe949-1674-421a-8cce-463e7e6ba267', CAST(N'2024-05-18T20:06:22.293' AS DateTime), CAST(N'2024-05-18T20:06:22.293' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'52c8def0-ca03-49b8-9b15-e208458caf1f', N'Ejemplo Opcion 9', 0, 1, N'9a431a9c-1aaa-4616-8b4b-bbf6c34082de', CAST(N'2024-06-18T17:48:28.863' AS DateTime), CAST(N'2024-06-18T17:48:28.863' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'06e77df1-707d-4616-8cde-e20ed5397c76', N'Frecuentemente', 0, 1, N'fa5519d0-d84c-45d7-aa53-2234c77fff60', CAST(N'2024-06-19T12:11:14.567' AS DateTime), CAST(N'2024-06-19T12:11:14.567' AS DateTime), 4, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'8cbec05e-b46b-411f-815d-e2b4b20fdd68', N'Frecuentemente', 0, 1, N'0dcec066-50db-4981-93fb-0dbc3b528d07', CAST(N'2024-06-12T14:52:32.307' AS DateTime), CAST(N'2024-06-12T14:52:32.307' AS DateTime), 4, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'bf3f5793-b935-4677-b074-e31e4a0d8874', N'Océano Atlántico', 1, 1, N'c3a2166e-de24-46d3-a918-11d6b286cc1a', CAST(N'2024-05-06T15:19:40.150' AS DateTime), CAST(N'2024-05-06T15:19:40.150' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'3a1daf72-5d99-44d4-9848-e32c81b4cef1', N'Guadalupe Victoria', 1, 1, N'c0362a07-5bb1-40b4-bef6-61da48da4878', CAST(N'2024-05-18T20:06:22.303' AS DateTime), CAST(N'2024-05-18T20:06:22.303' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'f2005ffd-dd40-48db-b975-e331fc28b7cf', N'EjemploD', 0, 1, N'20548ecc-bf50-4caf-8b89-557e148467cc', CAST(N'2024-06-19T11:59:34.723' AS DateTime), CAST(N'2024-06-19T11:59:34.723' AS DateTime), 0, N'bfef5abf-cff4-460b-a3af-55630d81066a')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'fb84ae96-7939-43bf-a909-e344a32aedf7', N'Frecuentemente', 0, 1, N'99821866-9268-4e60-95b6-8d932ecaded3', CAST(N'2024-07-03T13:22:31.033' AS DateTime), CAST(N'2024-07-03T13:22:31.033' AS DateTime), 4, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'afb28dd9-b741-4cc7-ab21-e4173e93bb0c', N'A Veces', 0, 1, N'e02c5ef7-11bf-4f62-ba9a-34b280af069a', CAST(N'2024-06-18T16:10:46.520' AS DateTime), CAST(N'2024-06-18T16:10:46.520' AS DateTime), 3, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'2b71b883-510c-4737-ba71-e446a0282ac0', N'b', 0, 1, N'20460eaf-c2d1-44d6-ab0d-2eabac627dcc', CAST(N'2024-06-18T16:41:21.497' AS DateTime), CAST(N'2024-06-18T16:41:21.497' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'd9a5e4c0-dbe6-45fa-a53f-e45e273e58bf', N'Digital', 0, 1, N'89af27c7-a4c1-4f07-a439-bce379652542', CAST(N'2024-05-17T11:36:59.217' AS DateTime), CAST(N'2024-05-17T11:36:59.217' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'0f527663-0cde-4271-a46a-e47d9bd9e029', N'Nunca', 0, 1, N'0efc1f0a-ac87-466e-bb5e-5f3ae9c0f814', CAST(N'2024-06-18T16:11:02.860' AS DateTime), CAST(N'2024-06-18T16:11:02.860' AS DateTime), 1, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'd23852ad-7e9f-4d79-ba64-e482f443b304', N'Ejemplo Opcion 5', 0, 1, N'7fa649e1-4ca7-43e6-9211-1cbacceccc50', CAST(N'2024-07-03T13:32:40.020' AS DateTime), CAST(N'2024-07-03T13:32:40.020' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'fffb6714-709a-4c99-8e75-e489b64f6b42', N'A Veces', 0, 1, N'6340dd21-34ab-40a9-8103-116a1ebce518', CAST(N'2024-07-03T13:16:16.597' AS DateTime), CAST(N'2024-07-03T13:16:16.597' AS DateTime), 3, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'a33683b3-d947-4fae-af49-e4be15d8e941', N'A Veces', 0, 1, N'a0ac946e-46c8-4121-8498-40e3a2617213', CAST(N'2024-06-19T12:10:52.713' AS DateTime), CAST(N'2024-06-19T12:10:52.713' AS DateTime), 3, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'f3960572-6e92-4246-b396-e564fcd2e28b', N'Ejemplo Opcion 8', 0, 1, N'c4273e68-8869-4369-9eac-259ba870b163', CAST(N'2024-07-03T13:32:39.987' AS DateTime), CAST(N'2024-07-03T13:32:39.987' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'68313da5-9fbd-409d-8e90-e5907a359ef8', N'Buzz Aldrin', 0, 1, N'c29f1d5d-90db-41ff-ba8b-8c2cd25354e0', CAST(N'2024-05-14T17:15:37.350' AS DateTime), CAST(N'2024-05-14T17:15:37.350' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'75ce8029-ec43-4834-b7b3-e5a678bc2e1b', N'Nunca', 0, 1, N'c3d05caf-4623-4fdd-9097-e4a289cd87b8', CAST(N'2024-06-19T12:11:10.673' AS DateTime), CAST(N'2024-06-19T12:11:10.673' AS DateTime), 1, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'475f1b80-530c-48b8-a93a-e61ca63f0de8', N'Litio', 1, 1, N'10ccc4aa-9bef-4015-89bf-106ac005fb2b', CAST(N'2024-05-18T20:06:22.297' AS DateTime), CAST(N'2024-05-18T20:06:22.297' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'e3330812-529e-461a-ab0b-e7e843a03a66', N'Falso', 1, 1, N'024fc029-063b-4179-ad7d-82fb599ac9ef', CAST(N'2024-02-28T09:35:18.063' AS DateTime), CAST(N'2024-05-13T11:47:08.630' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'6028d07f-2411-40ba-b1a1-e85d438ca8d5', N'Michelangelo', 0, 1, N'17f78458-362d-4b64-b1ef-1c2a868733f9', CAST(N'2024-05-14T17:15:37.337' AS DateTime), CAST(N'2024-05-14T17:15:37.337' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'd4064c72-c761-425d-b9e7-e895aedd0269', N'Océano Pacífico', 0, 1, N'17944192-2c92-4b92-af87-94ce8928651e', CAST(N'2024-05-18T20:06:22.260' AS DateTime), CAST(N'2024-05-18T20:06:22.260' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'9701504a-12b4-48f5-b3b7-e9956b01c273', N'Germinación', 0, 1, N'3144a4a4-2d01-4bc1-9d2e-b0365f6b125c', CAST(N'2024-05-18T20:06:22.290' AS DateTime), CAST(N'2024-05-18T20:06:22.290' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'94dfc234-311b-4f60-9396-e997c7eb5e4c', N'Nunca', 0, 1, N'b8e7022f-cecd-458f-b5b2-352e7ad04b32', CAST(N'2024-07-03T13:22:31.023' AS DateTime), CAST(N'2024-07-03T13:22:31.023' AS DateTime), 1, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'4814cafa-5c54-4176-b516-e9a70479335b', N'Río Nilo', 1, 1, N'373a2694-c2d7-4d04-a5c6-a4b25b6bc2ce', CAST(N'2024-05-14T17:15:37.343' AS DateTime), CAST(N'2024-05-14T17:15:37.343' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'b9ea37e0-5b06-4432-9306-ea112da830b9', N'Ejemplo Opcion 8', 0, 1, N'f5535438-f8f2-441d-b3ce-266d618d8301', CAST(N'2024-07-03T13:32:40.007' AS DateTime), CAST(N'2024-07-03T13:32:40.007' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'5cf8d00b-c45d-4787-b2ca-eb016979d7da', N'Drama', 0, 1, N'6122e532-6296-4b7f-b2cf-a91b1e1ce8a2', CAST(N'2024-05-17T11:36:59.207' AS DateTime), CAST(N'2024-05-17T11:36:59.207' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'6f99d33f-105d-4868-8e4b-eb409d96fb2d', N'Jugo', 0, 1, N'331bea1d-cf31-4085-bda8-fc1544356c4d', CAST(N'2024-05-17T11:36:59.220' AS DateTime), CAST(N'2024-05-17T11:36:59.220' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'107575f2-f350-4ece-8965-eb5188cff623', N'Dólar', 0, 1, N'32dbc843-a741-4474-9106-2001753aa21d', CAST(N'2024-05-06T15:19:40.177' AS DateTime), CAST(N'2024-05-06T15:19:40.177' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'3f936b57-0a79-4e70-b909-eb6fae061793', N'Río Yangtsé', 0, 1, N'c9ebbafe-9ec1-4ef1-ad4b-61e363d386d2', CAST(N'2024-05-06T15:19:40.160' AS DateTime), CAST(N'2024-05-06T15:19:40.160' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'9190e027-ded3-4924-ac03-ebdc53acb2f7', N'A Veces', 0, 1, N'ef9c4a21-331f-43d6-8b16-85867035a4c2', CAST(N'2024-06-18T16:19:46.777' AS DateTime), CAST(N'2024-06-18T16:19:46.777' AS DateTime), 3, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'84d5fe8c-8bd8-4e72-b24f-ebe4e373a48b', N'Ejemplo Opcion 2', 0, 1, N'c4273e68-8869-4369-9eac-259ba870b163', CAST(N'2024-07-03T13:32:39.980' AS DateTime), CAST(N'2024-07-03T13:32:39.980' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'b14cf777-0398-4b6c-8a34-ebe514ceccd6', N'EjemploD', 0, 1, N'cfb97942-1699-472b-9ab0-43c3a159ec62', CAST(N'2024-06-19T12:00:32.243' AS DateTime), CAST(N'2024-06-19T12:00:32.243' AS DateTime), 0, N'bfef5abf-cff4-460b-a3af-55630d81066a')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'e9779884-1e4b-49ca-a52a-ec07eed280c5', N'a', 1, 1, N'20460eaf-c2d1-44d6-ab0d-2eabac627dcc', CAST(N'2024-06-18T16:41:21.493' AS DateTime), CAST(N'2024-06-18T16:41:21.493' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'd8a3dbb5-3914-411b-9a40-eceefbd268ae', N'Siempre', 0, 1, N'8b05542f-0c09-435f-b3f3-56cb286a72ff', CAST(N'2024-07-03T13:22:31.020' AS DateTime), CAST(N'2024-07-03T13:22:31.020' AS DateTime), 5, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'e16476a2-f248-4f9b-bb66-ed0bfbabeaf1', N'Una vez a la semana', 0, 1, N'f569a206-15cb-4fb8-9bc1-d76405aa7bc9', CAST(N'2024-05-17T11:36:59.200' AS DateTime), CAST(N'2024-05-17T11:36:59.200' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'ca63867d-c234-4dc5-aa31-ed48e6c57e19', N'A Veces', 0, 1, N'4561f5f6-1c0d-496d-9ddb-adb0157b4a92', CAST(N'2024-07-03T13:16:16.593' AS DateTime), CAST(N'2024-07-03T13:16:16.593' AS DateTime), 3, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'922d97dd-e9b8-4cb1-8726-ee6489aeaa83', N'Pablo Picasso', 0, 1, N'825d1a65-2bbc-4120-bade-7a304a8d44bd', CAST(N'2024-05-18T20:06:22.260' AS DateTime), CAST(N'2024-05-18T20:06:22.260' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'cb8ed0d8-bd23-49f9-b435-eed72af141ab', N'San Petersburgo', 0, 1, N'588e2705-8a7d-417d-977d-61fcd1e38863', CAST(N'2024-05-14T17:15:37.370' AS DateTime), CAST(N'2024-05-14T17:15:37.370' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'7d600c9a-5a92-4e51-aae3-ef51e986a4e2', N'Roma', 0, 1, N'3418513a-2424-4676-9cc1-a071fbcc32e5', CAST(N'2024-05-18T20:06:22.263' AS DateTime), CAST(N'2024-05-18T20:06:22.263' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'7bce8a1e-7e43-448c-9096-ef7a7aa7cf04', N'Ejemploc', 0, 1, N'73868e25-9aec-482d-b4ac-629b97a2dffe', CAST(N'2024-07-03T11:55:14.130' AS DateTime), CAST(N'2024-07-03T11:55:14.130' AS DateTime), 0, N'1e2e9f6c-4c7f-4142-8317-c398db956764')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'f4940f21-63c9-4913-a83f-ef8b469502a3', N'Siempre', 0, 1, N'0efc1f0a-ac87-466e-bb5e-5f3ae9c0f814', CAST(N'2024-06-18T16:11:02.863' AS DateTime), CAST(N'2024-06-18T16:11:02.863' AS DateTime), 5, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'409450a1-1c87-4766-a456-f012fe5a8d28', N'Ejemplo', 0, 1, N'912583c5-89cf-46d6-9366-e512187830a1', CAST(N'2024-07-03T11:55:14.120' AS DateTime), CAST(N'2024-07-03T11:55:14.120' AS DateTime), 0, N'bfef5abf-cff4-460b-a3af-55630d81066a')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'04048c35-4236-4eee-8ec6-f04ad0fb1f7a', N'Montaña McKinley', 0, 1, N'f48a82eb-8845-4172-b53d-b3cd42ffa07e', CAST(N'2024-05-06T15:19:40.160' AS DateTime), CAST(N'2024-05-06T15:19:40.160' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'7674def2-65cf-455d-91e3-f0e8b35eebdd', N'Pizza', 0, 1, N'fbdb896d-999e-4123-9d57-804508ddd7c1', CAST(N'2024-05-17T11:36:59.183' AS DateTime), CAST(N'2024-05-17T11:36:59.183' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'517eaa2b-2abf-4e64-84d4-f1231b8eb7ae', N'España', 0, 1, N'8d5e4ba5-2632-4ca4-817a-de1300b99a0e', CAST(N'2024-05-18T20:06:22.303' AS DateTime), CAST(N'2024-05-18T20:06:22.303' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'f4532212-01db-4e5f-a2d8-f1440e2b76a6', N'Documental', 0, 1, N'6122e532-6296-4b7f-b2cf-a91b1e1ce8a2', CAST(N'2024-05-17T11:36:59.207' AS DateTime), CAST(N'2024-05-17T11:36:59.207' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'5addc5aa-3783-4ddf-ad3d-f14979a109ed', N'b', 0, 1, N'de3ebcdd-9365-4c51-be79-e7d2ab07e3b7', CAST(N'2024-06-18T16:41:46.900' AS DateTime), CAST(N'2024-06-18T16:41:46.900' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'b8159596-f252-40b5-985a-f1b90827933b', N'Ejemplo Opcion 8', 0, 1, N'9845c3de-be89-4405-8cc6-5422f6928eb9', CAST(N'2024-06-18T17:48:28.870' AS DateTime), CAST(N'2024-06-18T17:48:28.870' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'8a5cace5-19ac-441e-bfbc-f1e4933ecf47', N'Rara Vez', 0, 1, N'57cb8739-ba65-4027-932f-ffbfebe6eadd', CAST(N'2024-07-03T13:22:31.020' AS DateTime), CAST(N'2024-07-03T13:22:31.020' AS DateTime), 2, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'0578cc04-483f-4cad-864d-f2178a0b7511', N'Frecuentemente', 0, 1, N'0efc1f0a-ac87-466e-bb5e-5f3ae9c0f814', CAST(N'2024-06-18T16:11:02.860' AS DateTime), CAST(N'2024-06-18T16:11:02.860' AS DateTime), 4, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'8ab8b688-6bd9-4bf4-8e71-f235a35ee590', N'A Veces', 0, 1, N'c3d05caf-4623-4fdd-9097-e4a289cd87b8', CAST(N'2024-06-19T12:11:10.673' AS DateTime), CAST(N'2024-06-19T12:11:10.673' AS DateTime), 3, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'044585ed-b6a0-4399-8e6e-f2cadbbabb27', N'San Petersburgo', 0, 1, N'e0c81067-b353-4659-b29c-d909d1209830', CAST(N'2024-05-18T20:06:22.300' AS DateTime), CAST(N'2024-05-18T20:06:22.300' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'e0461ea6-2a33-48ec-8f38-f2cba9e3d58c', N'1945', 1, 1, N'52efe634-e59c-463c-9599-e88f9955094c', CAST(N'2024-05-06T15:19:40.167' AS DateTime), CAST(N'2024-05-06T15:19:40.167' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'afa64e82-25ce-4282-9d7c-f2f2dca488ca', N'Nunca', 0, 1, N'f569a206-15cb-4fb8-9bc1-d76405aa7bc9', CAST(N'2024-05-17T11:36:59.200' AS DateTime), CAST(N'2024-05-17T11:36:59.200' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'33ed2186-ebe1-48b9-bc5c-f30c8beea924', N'Ejemplob', 0, 1, N'cfb97942-1699-472b-9ab0-43c3a159ec62', CAST(N'2024-06-19T12:00:32.243' AS DateTime), CAST(N'2024-06-19T12:00:32.243' AS DateTime), 0, N'357dbf15-2a3e-4424-9005-9325bba3462c')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'16536ee8-23ce-4f31-a49a-f32e058a9fc8', N'Miguel Hidalgo', 0, 1, N'f29610cb-4dfb-4e89-9c70-bd56031bf137', CAST(N'2024-05-14T17:15:37.373' AS DateTime), CAST(N'2024-05-14T17:15:37.373' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'3fa6d7a1-200b-4dcf-a7be-f394b29d0a7b', N'Océano Atlántico', 1, 1, N'17944192-2c92-4b92-af87-94ce8928651e', CAST(N'2024-05-18T20:06:22.257' AS DateTime), CAST(N'2024-05-18T20:06:22.257' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'a1bbe3f7-bd59-44fd-9255-f3b1ad39fe3c', N'Ejemplo Opcion 9', 0, 1, N'e20687bd-bdd9-4edf-8bf4-8caa5cb8d616', CAST(N'2024-07-03T13:32:40.000' AS DateTime), CAST(N'2024-07-03T13:32:40.000' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'1a3cd740-99e4-47d5-9d49-f3c64fc35a3c', N'Río Amazonas', 0, 1, N'373a2694-c2d7-4d04-a5c6-a4b25b6bc2ce', CAST(N'2024-05-14T17:15:37.343' AS DateTime), CAST(N'2024-05-14T17:15:37.343' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'77e6a69b-5cd1-43f1-b68e-f4385df5805c', N'Ejemplo', 0, 1, N'd02c70c9-b921-446c-ad76-45f9650712cb', CAST(N'2024-07-03T11:55:14.123' AS DateTime), CAST(N'2024-07-03T11:55:14.123' AS DateTime), 0, N'bfef5abf-cff4-460b-a3af-55630d81066a')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'e8bf435e-1b96-4813-808d-f44db0741aae', N'Nunca', 0, 1, N'6340dd21-34ab-40a9-8103-116a1ebce518', CAST(N'2024-07-03T13:16:16.593' AS DateTime), CAST(N'2024-07-03T13:16:16.593' AS DateTime), 1, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'401908bc-5a9b-4df7-81db-f4a33701c804', N'A Veces', 0, 1, N'0dcec066-50db-4981-93fb-0dbc3b528d07', CAST(N'2024-06-12T14:52:32.307' AS DateTime), CAST(N'2024-06-12T14:52:32.307' AS DateTime), 3, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'7e41ef45-caf8-4dca-b836-f4e235fbe269', N'Hamburguesa', 0, 1, N'fbdb896d-999e-4123-9d57-804508ddd7c1', CAST(N'2024-05-17T11:36:59.183' AS DateTime), CAST(N'2024-05-17T11:36:59.183' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'50879bcd-3aa4-443b-be35-f4f7196d5a05', N'Cobre', 0, 1, N'9fc8b8e0-4832-437c-88ba-0e5f4cb6585c', CAST(N'2024-05-18T20:06:22.280' AS DateTime), CAST(N'2024-05-18T20:06:22.280' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'99ee9066-1125-412a-827c-f6420d9e8f2c', N'Desarrollador Multimedia', 0, 1, N'e00ae793-e6c1-4a2a-8ece-142bf6b7a2ee', CAST(N'2024-05-17T11:36:59.227' AS DateTime), CAST(N'2024-05-17T11:36:59.227' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'f29f5831-8e2f-46a3-8387-f77654ef06cd', N'De acuerdo', 0, 1, N'0d893612-4eb6-4049-a0d7-3b9ce643b426', CAST(N'2024-06-19T11:51:12.147' AS DateTime), CAST(N'2024-06-19T11:51:12.147' AS DateTime), 4, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'30156b1b-c9f4-4a1e-be0a-f7c8867b96f7', N'Tibia', 0, 1, N'8aae72a1-8f0e-4bcc-a4c4-86d7cc5bced9', CAST(N'2024-05-06T15:19:40.170' AS DateTime), CAST(N'2024-05-06T15:19:40.170' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'34768314-024a-4c34-ad26-f84ccdfc534e', N'Verdadero', 0, 1, N'024fc029-063b-4179-ad7d-82fb599ac9ef', CAST(N'2024-02-28T09:35:18.063' AS DateTime), CAST(N'2024-05-13T11:47:08.630' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'eb0fb8f3-8b85-4f00-ad15-f8534dcf7851', N'A Veces', 0, 1, N'fa5519d0-d84c-45d7-aa53-2234c77fff60', CAST(N'2024-06-19T12:11:14.567' AS DateTime), CAST(N'2024-06-19T12:11:14.567' AS DateTime), 3, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'dad359d8-ff56-4dd8-ae36-f85732b2521f', N'Frecuentemente', 0, 1, N'4561f5f6-1c0d-496d-9ddb-adb0157b4a92', CAST(N'2024-07-03T13:16:16.593' AS DateTime), CAST(N'2024-07-03T13:16:16.593' AS DateTime), 4, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'abb503c5-8823-4e12-afdb-f8894da301fd', N'Totalmente en desacuerdo', 0, 1, N'0d893612-4eb6-4049-a0d7-3b9ce643b426', CAST(N'2024-06-19T11:51:12.147' AS DateTime), CAST(N'2024-06-19T11:51:12.147' AS DateTime), 1, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'41d8a878-98a5-4388-883e-f97275e0b394', N'Rara Vez', 0, 1, N'fa5519d0-d84c-45d7-aa53-2234c77fff60', CAST(N'2024-06-19T12:11:14.567' AS DateTime), CAST(N'2024-06-19T12:11:14.567' AS DateTime), 2, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'ef7572dc-4ac0-4ff5-b3d9-f9fe000c1e65', N'Ejemplo Opcion 6', 0, 1, N'7fa649e1-4ca7-43e6-9211-1cbacceccc50', CAST(N'2024-07-03T13:32:40.020' AS DateTime), CAST(N'2024-07-03T13:32:40.020' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'b311ead9-8132-4379-8552-fa6275561087', N'Dólar', 0, 1, N'e033dd49-efc7-4cc3-8553-44134c409196', CAST(N'2024-05-14T17:15:37.363' AS DateTime), CAST(N'2024-05-14T17:15:37.363' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'a7dc9baf-94a6-4a6e-8ac9-fabe37b28054', N'EjemploD', 0, 1, N'07761dfa-7ce5-42b3-9b40-29375321322e', CAST(N'2024-06-19T12:00:32.250' AS DateTime), CAST(N'2024-06-19T12:00:32.250' AS DateTime), 0, N'bfef5abf-cff4-460b-a3af-55630d81066a')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'8b570f0a-c7ad-4a08-abcc-fadf20bc9ab1', N'Ejemplo Opcion 4', 0, 1, N'2f722edf-8c3b-4682-8abf-c8305c2d18ca', CAST(N'2024-06-18T17:48:28.857' AS DateTime), CAST(N'2024-06-18T17:48:28.857' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'43d4088d-9acd-43b3-b920-fb577c2a3cc5', N'Neutral', 0, 1, N'74dbbef1-3d7b-4c36-aaf5-f459715311b0', CAST(N'2024-06-19T11:51:12.150' AS DateTime), CAST(N'2024-06-19T11:51:12.150' AS DateTime), 3, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'968d129e-dcba-4573-96b0-fbf27e34e1d2', N'Porfirio Díaz', 0, 1, N'fcd4f005-2ea6-491b-bdf4-d07beb7cdb0d', CAST(N'2024-05-06T15:19:40.183' AS DateTime), CAST(N'2024-05-06T15:19:40.183' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'cba923d8-975c-4ca4-88de-fc89e0f838b9', N'John Adams', 0, 1, N'463e14a7-3123-4038-b87f-3370b24ef98c', CAST(N'2024-05-06T15:19:40.163' AS DateTime), CAST(N'2024-05-06T15:19:40.163' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'f9f0ebf3-7c1a-4d58-a863-fcbd45d43fbf', N'Patineta', 0, 1, N'768ae381-8735-43ad-8c33-77b4836a070f', CAST(N'2024-05-17T11:36:59.210' AS DateTime), CAST(N'2024-05-17T11:36:59.210' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'5edd7bd8-ee38-4483-ab6d-fcd100e3a3aa', N'Frecuentemente', 0, 1, N'17f90498-53f6-48ba-858b-980b529aaf4e', CAST(N'2024-06-19T12:11:03.470' AS DateTime), CAST(N'2024-06-19T12:11:03.470' AS DateTime), 4, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'2e2e6981-893f-4407-a14b-fcffb5bd262c', N'esta es la op 2', 0, 1, N'cf780862-6965-4ccf-a3ec-7c881fefc436', CAST(N'2024-05-19T18:25:59.697' AS DateTime), CAST(N'2024-05-19T18:25:59.697' AS DateTime), 0, N'1e2e9f6c-4c7f-4142-8317-c398db956764')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'2eb5525f-df4b-4996-a802-fdb1cca4df92', N'John Adams', 0, 1, N'bd26060a-0a5f-4dca-9ce3-14bd3bda2ae7', CAST(N'2024-05-14T17:15:37.350' AS DateTime), CAST(N'2024-05-14T17:15:37.350' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'fb31483d-589c-44e2-9c70-fe0fdabe4d92', N'Totalmente de acuerdo', 0, 1, N'eace26ab-f364-44cc-a179-cca4952a5cc4', CAST(N'2024-06-19T11:51:12.143' AS DateTime), CAST(N'2024-06-19T11:51:12.143' AS DateTime), 5, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'5a35e470-7598-473d-96d4-fe657ab10888', N'Frecuentemente', 0, 1, N'8b05542f-0c09-435f-b3f3-56cb286a72ff', CAST(N'2024-07-03T13:22:31.020' AS DateTime), CAST(N'2024-07-03T13:22:31.020' AS DateTime), 4, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'b1751c07-d6a9-4789-98dd-fee74de5607a', N'Montaña McKinley', 0, 1, N'8af5bd89-7624-495b-81e1-d642dc9cdcb3', CAST(N'2024-05-18T20:06:22.267' AS DateTime), CAST(N'2024-05-18T20:06:22.267' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'd56b62e0-b61a-4692-81ea-ff931d0de82a', N'Rara Vez', 0, 1, N'98cc12a2-988e-4884-8d8e-b33999cb7e38', CAST(N'2024-07-03T13:16:16.590' AS DateTime), CAST(N'2024-07-03T13:16:16.590' AS DateTime), 2, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion], [valor], [idTipoEntrada]) VALUES (N'ff305d9a-bec3-4b60-b207-ffc0758d2d86', N'Ejemplo Opcion 10', 0, 1, N'9d6aa9f8-e6a9-4dd9-ade8-d0e2d0e53309', CAST(N'2024-06-18T17:48:28.880' AS DateTime), CAST(N'2024-06-18T17:48:28.880' AS DateTime), 0, N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9')
GO
INSERT [dbo].[Pais] ([idPais], [nombre], [descripcion], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'd0a947c1-149a-4747-9a58-272f3eed7480', N'pais prueba', NULL, 1, CAST(N'2023-12-15T11:40:45.600' AS DateTime), CAST(N'2024-02-06T16:20:05.187' AS DateTime))
GO
INSERT [dbo].[Pais] ([idPais], [nombre], [descripcion], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'af81e949-1e19-449b-94af-7e9a3b2de9ec', N'Perú', NULL, 1, CAST(N'2024-02-06T14:00:50.123' AS DateTime), CAST(N'2024-02-06T14:58:36.170' AS DateTime))
GO
INSERT [dbo].[Pais] ([idPais], [nombre], [descripcion], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'4a89b8a4-418d-47e1-bd16-80aab501d4c0', N'México', NULL, 1, CAST(N'2024-01-30T11:55:12.817' AS DateTime), CAST(N'2024-01-30T11:55:12.817' AS DateTime))
GO
INSERT [dbo].[Pais] ([idPais], [nombre], [descripcion], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'1e539fef-7e19-4248-bd2c-d19b79726b0a', N'Ecuador', NULL, 1, CAST(N'2023-12-15T11:31:31.193' AS DateTime), CAST(N'2023-12-15T11:31:31.193' AS DateTime))
GO
INSERT [dbo].[Pais] ([idPais], [nombre], [descripcion], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'001cff55-773d-4389-a04a-d5625a252239', N'Colombia', NULL, 1, CAST(N'2024-02-06T13:05:16.670' AS DateTime), CAST(N'2024-02-06T14:59:11.993' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'bc51aa83-4654-4be0-878f-087bde6893ec', N'¿Cuál es el océano más grande del mundo', 1, N'd9ca3dcb-ee6a-4f35-ae4c-719843510a1a', CAST(N'2024-05-14T17:15:37.323' AS DateTime), CAST(N'2024-05-14T17:15:37.323' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'eb983094-689e-4469-9700-09ab87c6da04', N'¿Cuál es el metal más ligero', 1, N'd9ca3dcb-ee6a-4f35-ae4c-719843510a1a', CAST(N'2024-05-14T17:15:37.367' AS DateTime), CAST(N'2024-05-14T17:15:37.367' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'2f4a9a17-f878-4788-8a84-0ace26143d43', N'ultima pregunta', 1, N'428164a1-24f7-4c0c-8a6c-6278c23bffb5', CAST(N'2024-05-13T15:25:20.917' AS DateTime), CAST(N'2024-05-13T15:25:20.917' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'413ba92b-3c48-496e-9edd-0c45029a9f5c', N'Estas de acuerdo en 1', 1, N'354e8be8-3d2d-4e42-90b6-8935f7e56ef4', CAST(N'2024-06-19T11:51:12.123' AS DateTime), CAST(N'2024-06-19T11:51:12.123' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'0dcec066-50db-4981-93fb-0dbc3b528d07', N'¿Cumple con el horario de trabajo?', 1, N'0b3439f9-f94d-4e28-b758-89668b4d020f', CAST(N'2024-06-12T14:52:32.293' AS DateTime), CAST(N'2024-06-12T14:52:32.293' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'9fc8b8e0-4832-437c-88ba-0e5f4cb6585c', N'¿Cuál es el metal más abundante en la corteza terrestre', 1, N'fac2338b-35d6-4cba-9cfb-d02bf4c33e60', CAST(N'2024-05-18T20:06:22.280' AS DateTime), CAST(N'2024-05-18T20:06:22.280' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'82c82b89-5159-4ed0-ba74-0e7ca1b157cd', N'¿Ejemplod?', 1, N'46a95c2a-36ca-472c-8645-a8fb96bf2812', CAST(N'2024-07-03T11:55:14.127' AS DateTime), CAST(N'2024-07-03T11:55:14.127' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'10ccc4aa-9bef-4015-89bf-106ac005fb2b', N'¿Cuál es el metal más ligero', 1, N'fac2338b-35d6-4cba-9cfb-d02bf4c33e60', CAST(N'2024-05-18T20:06:22.297' AS DateTime), CAST(N'2024-05-18T20:06:22.297' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'6340dd21-34ab-40a9-8103-116a1ebce518', N'¿Ejemplo3?', 1, N'6e504c05-c240-4a9a-931e-b3ad7e452333', CAST(N'2024-07-03T13:16:16.593' AS DateTime), CAST(N'2024-07-03T13:16:16.593' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'c3a2166e-de24-46d3-a918-11d6b286cc1a', N'¿Cuál es el océano más grande del mundo', 1, N'63d7661c-366b-4134-9e94-6f72e3076c73', CAST(N'2024-05-06T15:19:40.143' AS DateTime), CAST(N'2024-05-06T15:19:40.143' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'e00ae793-e6c1-4a2a-8ece-142bf6b7a2ee', N'¿Cuál es el área que ocupas en tu trabajo actual?', 1, N'701e4b94-1e54-4de4-9128-239ded5eaa06', CAST(N'2024-05-17T11:36:59.227' AS DateTime), CAST(N'2024-05-17T11:36:59.227' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'bd26060a-0a5f-4dca-9ce3-14bd3bda2ae7', N'¿Quién fue el primer presidente de Estados Unidos', 1, N'd9ca3dcb-ee6a-4f35-ae4c-719843510a1a', CAST(N'2024-05-14T17:15:37.347' AS DateTime), CAST(N'2024-05-14T17:15:37.347' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'4b9c5102-2cf1-48bf-8983-162fef069f5d', N'¿Ejemplo?', 1, N'6e504c05-c240-4a9a-931e-b3ad7e452333', CAST(N'2024-07-03T13:16:16.573' AS DateTime), CAST(N'2024-07-03T13:16:16.573' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'2a24fe22-f17e-4dd5-974a-171dfe3c6f9c', N'¿Cuál es el metal más abundante en la corteza terrestre', 1, N'63d7661c-366b-4134-9e94-6f72e3076c73', CAST(N'2024-05-06T15:19:40.170' AS DateTime), CAST(N'2024-05-06T15:19:40.170' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'695f6412-574f-4c5b-9de1-172db0e97d6f', N'prueba', 1, N'428164a1-24f7-4c0c-8a6c-6278c23bffb5', CAST(N'2024-05-10T17:09:38.907' AS DateTime), CAST(N'2024-05-13T11:49:11.777' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'88cdf9fd-996b-4a03-b3d2-1ab46293aa9d', N'¿Quién escribió la obra "Romeo y Julieta"', 1, N'fac2338b-35d6-4cba-9cfb-d02bf4c33e60', CAST(N'2024-05-18T20:06:22.293' AS DateTime), CAST(N'2024-05-18T20:06:22.293' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'17f78458-362d-4b64-b1ef-1c2a868733f9', N'¿Quién pintó la Mona Lisa', 1, N'd9ca3dcb-ee6a-4f35-ae4c-719843510a1a', CAST(N'2024-05-14T17:15:37.333' AS DateTime), CAST(N'2024-05-14T17:15:37.333' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'7fa649e1-4ca7-43e6-9211-1cbacceccc50', N'¿Ejemplo5?', 1, N'37cf8fee-91e0-4886-9aea-b1dcf97cbb28', CAST(N'2024-07-03T13:32:40.017' AS DateTime), CAST(N'2024-07-03T13:32:40.017' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'06fb7cfc-9e4f-4c35-b6ab-1cd0d31e187a', N'¿Ejemplo1?', 1, N'ef9c1644-f977-43e0-b47c-06699fc22d5d', CAST(N'2024-07-03T12:23:31.020' AS DateTime), CAST(N'2024-07-03T12:23:31.020' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'43c4c9c4-b885-4bc4-83cb-1e3a257c3530', N'¿Que significa REST?', 1, N'27c5527f-3ea3-431b-bedf-65841eaf5663', CAST(N'2024-02-27T16:55:53.433' AS DateTime), CAST(N'2024-02-27T16:55:53.433' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'32dbc843-a741-4474-9106-2001753aa21d', N'¿Cuál es la moneda oficial de Japón', 1, N'63d7661c-366b-4134-9e94-6f72e3076c73', CAST(N'2024-05-06T15:19:40.177' AS DateTime), CAST(N'2024-05-06T15:19:40.177' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'f0b0ac75-b7bb-472f-b612-20a394e71343', N'¿Llega puntual todos los días?', 1, N'0b3439f9-f94d-4e28-b758-89668b4d020f', CAST(N'2024-06-12T14:23:58.067' AS DateTime), CAST(N'2024-06-12T14:23:58.067' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'fa5519d0-d84c-45d7-aa53-2234c77fff60', N'kkkkkkkkkkkkkkkkkk', 1, N'39d09ca3-ddbc-4ea2-a21e-7b982d3b7628', CAST(N'2024-06-19T12:11:14.563' AS DateTime), CAST(N'2024-06-19T12:11:14.563' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'c4273e68-8869-4369-9eac-259ba870b163', N'¿Ejemplo?', 1, N'37cf8fee-91e0-4886-9aea-b1dcf97cbb28', CAST(N'2024-07-03T13:32:39.970' AS DateTime), CAST(N'2024-07-03T13:32:39.970' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'f5535438-f8f2-441d-b3ce-266d618d8301', N'¿Ejemplo3?', 1, N'37cf8fee-91e0-4886-9aea-b1dcf97cbb28', CAST(N'2024-07-03T13:32:40.000' AS DateTime), CAST(N'2024-07-03T13:32:40.000' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'943e4c32-92d1-484c-840f-27f1f22a00d7', N'¿Ejemplo5?', 1, N'f66e11b2-6d7e-413b-a7ce-3a1dc068cb67', CAST(N'2024-07-03T14:43:33.887' AS DateTime), CAST(N'2024-07-03T14:43:33.887' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'07761dfa-7ce5-42b3-9b40-29375321322e', N'¿Ejemploc?', 1, N'60713ad9-036a-4f46-8b18-30b37fa1a1c2', CAST(N'2024-06-19T12:00:32.250' AS DateTime), CAST(N'2024-06-19T12:00:32.250' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'8d107d91-0768-4810-bced-29dfc6815825', N'¿En qué año terminó la Segunda Guerra Mundial', 1, N'd9ca3dcb-ee6a-4f35-ae4c-719843510a1a', CAST(N'2024-05-14T17:15:37.350' AS DateTime), CAST(N'2024-05-14T17:15:37.350' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'20460eaf-c2d1-44d6-ab0d-2eabac627dcc', N'Pregunta 1', 1, N'7eae11eb-d3b7-4b4f-90c1-287373c64e57', CAST(N'2024-06-18T16:41:21.487' AS DateTime), CAST(N'2024-06-18T16:41:21.487' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'98c931ee-8300-4484-9497-30b80e74062f', N'¿Pregunta a?', 1, N'1e42d6e2-6323-4ac6-917c-dc1727f5e49d', CAST(N'2024-06-03T16:18:15.317' AS DateTime), CAST(N'2024-06-03T16:18:15.317' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'463e14a7-3123-4038-b87f-3370b24ef98c', N'¿Quién fue el primer presidente de Estados Unidos', 1, N'63d7661c-366b-4134-9e94-6f72e3076c73', CAST(N'2024-05-06T15:19:40.163' AS DateTime), CAST(N'2024-05-06T15:19:40.163' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'55973eec-9d86-4a83-aa90-33cbc394dd02', N'¿Ejemploj?', 1, N'60713ad9-036a-4f46-8b18-30b37fa1a1c2', CAST(N'2024-06-19T12:00:32.227' AS DateTime), CAST(N'2024-06-19T12:00:32.227' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'e02c5ef7-11bf-4f62-ba9a-34b280af069a', N'Pregunta 3', 1, N'e11bb04d-bd02-4401-b6d9-f86d528199b4', CAST(N'2024-06-18T16:10:46.507' AS DateTime), CAST(N'2024-06-18T16:10:46.507' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'b8e7022f-cecd-458f-b5b2-352e7ad04b32', N'¿EjemploB?', 1, N'1f05f1db-2c24-435e-a1eb-81fbef77e87b', CAST(N'2024-07-03T13:22:31.023' AS DateTime), CAST(N'2024-07-03T13:22:31.023' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'170d9f8d-3df7-433e-9c2a-3758c9ac57cf', N'Cuantos años tengo', 1, N'63d7661c-366b-4134-9e94-6f72e3076c73', CAST(N'2024-05-09T18:04:09.270' AS DateTime), CAST(N'2024-05-09T18:04:09.270' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'0df5898c-37bb-49e9-b288-3888bafd62f4', N'¿Ejemplo1?', 1, N'f66e11b2-6d7e-413b-a7ce-3a1dc068cb67', CAST(N'2024-07-03T14:43:33.873' AS DateTime), CAST(N'2024-07-03T14:43:33.873' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'7d1ddcfd-9c98-43e8-b5bb-38a216617fbe', N'¿En qué año terminó la Segunda Guerra Mundial', 1, N'fac2338b-35d6-4cba-9cfb-d02bf4c33e60', CAST(N'2024-05-18T20:06:22.277' AS DateTime), CAST(N'2024-05-18T20:06:22.277' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'c23d1534-c010-4e7a-b2e7-38f4ab6eff33', N'¿Pregunta e?', 1, N'1e42d6e2-6323-4ac6-917c-dc1727f5e49d', CAST(N'2024-06-03T16:18:15.333' AS DateTime), CAST(N'2024-06-12T12:15:32.900' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'0d893612-4eb6-4049-a0d7-3b9ce643b426', N'Estas de acuerdo en 4', 1, N'354e8be8-3d2d-4e42-90b6-8935f7e56ef4', CAST(N'2024-06-19T11:51:12.143' AS DateTime), CAST(N'2024-06-19T11:51:12.143' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'5ed265a7-14dc-43e7-ab4b-3ba3d95f8a5a', N'¿Ejemplo?', 1, N'a10273c0-eb49-43b8-8adf-b8b5c90a87a1', CAST(N'2024-06-19T09:56:26.830' AS DateTime), CAST(N'2024-06-19T09:56:55.903' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'2e3772af-86f7-4b10-ab23-3c7fd119df3f', N'¿Ejemplo4?', 1, N'ef9c1644-f977-43e0-b47c-06699fc22d5d', CAST(N'2024-07-03T12:23:31.030' AS DateTime), CAST(N'2024-07-03T12:23:31.030' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'9f118e9f-8fd8-42f7-bced-3dd76988cdb2', N'¿Ejemplo3?', 1, N'f66e11b2-6d7e-413b-a7ce-3a1dc068cb67', CAST(N'2024-07-03T14:43:33.883' AS DateTime), CAST(N'2024-07-03T14:43:33.883' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'25a40b35-3438-4acd-a267-3edd3dcb550b', N'Pregunta 2', 1, N'7eae11eb-d3b7-4b4f-90c1-287373c64e57', CAST(N'2024-06-18T16:41:33.313' AS DateTime), CAST(N'2024-06-18T16:41:33.313' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'253efaf1-4751-416d-aebd-3f82ca9ecc86', N'¿Qué tipo de música prefieres?', 1, N'701e4b94-1e54-4de4-9128-239ded5eaa06', CAST(N'2024-05-17T11:36:59.187' AS DateTime), CAST(N'2024-05-17T11:36:59.187' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'a0ac946e-46c8-4121-8498-40e3a2617213', N'dadadad', 1, N'39d09ca3-ddbc-4ea2-a21e-7b982d3b7628', CAST(N'2024-06-19T12:10:52.703' AS DateTime), CAST(N'2024-06-19T12:10:52.703' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'e2b3cbeb-3e97-4e0b-993a-4123bec5538c', N'¿Quién fue el primer ser humano en viajar al espacio', 1, N'63d7661c-366b-4134-9e94-6f72e3076c73', CAST(N'2024-05-06T15:19:40.167' AS DateTime), CAST(N'2024-05-06T15:19:40.167' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'8160596f-0937-4f1e-9bca-415a56db719e', N'asdfgh', 1, N'2252397c-b7d9-42b4-b171-3a6eda0afaec', CAST(N'2024-06-19T11:46:45.590' AS DateTime), CAST(N'2024-06-19T11:46:45.590' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'cfb97942-1699-472b-9ab0-43c3a159ec62', N'¿Ejemploa?', 1, N'60713ad9-036a-4f46-8b18-30b37fa1a1c2', CAST(N'2024-06-19T12:00:32.240' AS DateTime), CAST(N'2024-06-19T12:00:32.240' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'e033dd49-efc7-4cc3-8553-44134c409196', N'¿Cuál es la moneda oficial de Japón', 1, N'd9ca3dcb-ee6a-4f35-ae4c-719843510a1a', CAST(N'2024-05-14T17:15:37.363' AS DateTime), CAST(N'2024-05-14T17:15:37.363' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'd02c70c9-b921-446c-ad76-45f9650712cb', N'¿Ejemploc?', 1, N'46a95c2a-36ca-472c-8645-a8fb96bf2812', CAST(N'2024-07-03T11:55:14.123' AS DateTime), CAST(N'2024-07-03T11:55:14.123' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'63afe949-1674-421a-8cce-463e7e6ba267', N'¿Cuál es la moneda oficial de Japón', 1, N'fac2338b-35d6-4cba-9cfb-d02bf4c33e60', CAST(N'2024-05-18T20:06:22.290' AS DateTime), CAST(N'2024-05-18T20:06:22.290' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'a924c254-6554-4b24-8fae-47163f0ebb93', N'¿Q tan frecuente tomas agua al día?', 1, N'e11bb04d-bd02-4401-b6d9-f86d528199b4', CAST(N'2024-06-18T15:58:50.323' AS DateTime), CAST(N'2024-06-18T15:58:50.323' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'b0426a57-6d19-4453-9640-4839197e8859', N'hhhhhhhhhh', 1, N'39d09ca3-ddbc-4ea2-a21e-7b982d3b7628', CAST(N'2024-06-19T12:11:07.053' AS DateTime), CAST(N'2024-06-19T12:11:07.053' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'73d8da63-da2d-4147-beb4-4abe18986e2b', N'¿Qué característica crees que el cliente valora más sobre un producto de alguna empresa en particular?', 1, N'701e4b94-1e54-4de4-9128-239ded5eaa06', CAST(N'2024-05-17T11:36:59.243' AS DateTime), CAST(N'2024-05-17T11:36:59.243' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'93cb4f0a-7486-40a9-b755-4c95d1b6d96f', N'preueba 3', 1, N'13590568-b03d-45a8-8a13-cf2ebae6f9b4', CAST(N'2024-05-19T18:25:28.840' AS DateTime), CAST(N'2024-05-19T18:25:28.840' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'ee2e1db9-86c6-4da4-b2ed-4ed9626b4ea4', N'¿Esta es una pregunta de prueba?', 1, N'13590568-b03d-45a8-8a13-cf2ebae6f9b4', CAST(N'2024-05-21T12:25:25.543' AS DateTime), CAST(N'2024-05-21T12:25:25.543' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'2e72a58f-12e4-4d00-8857-50d25671d4a1', N'¿En qué país se encuentra la famosa Torre Eiffel', 1, N'd9ca3dcb-ee6a-4f35-ae4c-719843510a1a', CAST(N'2024-05-14T17:15:37.373' AS DateTime), CAST(N'2024-05-14T17:15:37.373' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'ab319e07-97f2-4ae0-8862-527e4ed6f972', N'¿Cuál fue el motivo de tu discriminación?', 1, N'701e4b94-1e54-4de4-9128-239ded5eaa06', CAST(N'2024-05-17T11:36:59.177' AS DateTime), CAST(N'2024-05-17T11:36:59.177' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'9845c3de-be89-4405-8cc6-5422f6928eb9', N'¿Ejemplo3?', 1, N'0280943a-9140-4e17-a722-dcb3fc4dd725', CAST(N'2024-06-18T17:48:28.867' AS DateTime), CAST(N'2024-06-18T17:48:28.867' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'94de16dd-f15a-49df-b82a-55143405dd9e', N'¿Cuál es el proceso mediante el cual las plantas fabrican su propio alimento', 1, N'd9ca3dcb-ee6a-4f35-ae4c-719843510a1a', CAST(N'2024-05-14T17:15:37.360' AS DateTime), CAST(N'2024-05-14T17:15:37.360' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'20548ecc-bf50-4caf-8b89-557e148467cc', N'¿Ejemplo?', 1, N'60713ad9-036a-4f46-8b18-30b37fa1a1c2', CAST(N'2024-06-19T11:59:34.713' AS DateTime), CAST(N'2024-06-19T11:59:34.713' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'6bc1d81e-3cba-4c9c-a06e-5671ad6be6f2', N'¿Pregunta c?', 1, N'1e42d6e2-6323-4ac6-917c-dc1727f5e49d', CAST(N'2024-06-03T16:18:15.330' AS DateTime), CAST(N'2024-06-03T16:18:15.330' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'8b05542f-0c09-435f-b3f3-56cb286a72ff', N'¿Ejemplo?', 1, N'1f05f1db-2c24-435e-a1eb-81fbef77e87b', CAST(N'2024-07-03T13:22:31.007' AS DateTime), CAST(N'2024-07-03T13:22:31.007' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'dff06a15-ed76-4999-8518-574bbb7998c3', N'¿Ejemplo?', 1, N'f66e11b2-6d7e-413b-a7ce-3a1dc068cb67', CAST(N'2024-07-03T14:43:33.860' AS DateTime), CAST(N'2024-07-03T14:43:33.860' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'd8585a71-6633-403a-857d-5e042524c98f', N'¿Ejemplo4?', 1, N'f66e11b2-6d7e-413b-a7ce-3a1dc068cb67', CAST(N'2024-07-03T14:43:33.890' AS DateTime), CAST(N'2024-07-03T14:43:33.890' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'0efc1f0a-ac87-466e-bb5e-5f3ae9c0f814', N'Pregunta 5', 1, N'e11bb04d-bd02-4401-b6d9-f86d528199b4', CAST(N'2024-06-18T16:11:02.860' AS DateTime), CAST(N'2024-06-18T16:11:02.860' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'c0362a07-5bb1-40b4-bef6-61da48da4878', N'¿Quién fue el primer presidente de México', 1, N'fac2338b-35d6-4cba-9cfb-d02bf4c33e60', CAST(N'2024-05-18T20:06:22.300' AS DateTime), CAST(N'2024-05-18T20:06:22.300' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'c9ebbafe-9ec1-4ef1-ad4b-61e363d386d2', N'¿Cuál es el río más largo del mundo', 1, N'63d7661c-366b-4134-9e94-6f72e3076c73', CAST(N'2024-05-06T15:19:40.160' AS DateTime), CAST(N'2024-05-06T15:19:40.160' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'588e2705-8a7d-417d-977d-61fcd1e38863', N'¿Cuál es la capital de Rusia', 1, N'd9ca3dcb-ee6a-4f35-ae4c-719843510a1a', CAST(N'2024-05-14T17:15:37.370' AS DateTime), CAST(N'2024-05-14T17:15:37.370' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'73868e25-9aec-482d-b4ac-629b97a2dffe', N'¿Ejemploe?', 1, N'46a95c2a-36ca-472c-8645-a8fb96bf2812', CAST(N'2024-07-03T11:55:14.127' AS DateTime), CAST(N'2024-07-03T11:55:14.127' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'2e3c17ca-b700-48e1-be55-636ddbf6995d', N'¿Quién escribió "El Principito"', 1, N'fac2338b-35d6-4cba-9cfb-d02bf4c33e60', CAST(N'2024-05-18T20:06:22.270' AS DateTime), CAST(N'2024-05-18T20:06:22.270' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'749cb8ac-109f-476e-8f3c-6396c6ebb8fd', N'¿Quién pintó la Mona Lisa', 1, N'63d7661c-366b-4134-9e94-6f72e3076c73', CAST(N'2024-05-06T15:19:40.153' AS DateTime), CAST(N'2024-05-06T15:19:40.153' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'70b4c4fb-d8ed-49f1-bc61-65ad9489eff8', N'Le parece el clima de Quito es agradable', 1, N'bb4d3e7d-379f-489b-b9c4-dd28ce56dc81', CAST(N'2024-05-14T16:59:43.407' AS DateTime), CAST(N'2024-05-15T16:25:50.967' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'642f2953-674c-429c-a6f6-66f87770a362', N'preueba 3', 1, N'428164a1-24f7-4c0c-8a6c-6278c23bffb5', CAST(N'2024-05-13T15:22:07.743' AS DateTime), CAST(N'2024-05-13T15:22:07.743' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'aed89eab-a165-406f-926d-689ef0fa2ccb', N'¿Ejemplo1?', 1, N'37cf8fee-91e0-4886-9aea-b1dcf97cbb28', CAST(N'2024-07-03T13:32:39.987' AS DateTime), CAST(N'2024-07-03T13:32:39.987' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'3a113ec5-79f5-40e6-93af-6971eccea36a', N'¿Ejemplo3?', 1, N'ef9c1644-f977-43e0-b47c-06699fc22d5d', CAST(N'2024-07-03T12:23:31.027' AS DateTime), CAST(N'2024-07-03T12:23:31.027' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'ae85ef32-0e82-487f-a2c1-6d1b5b6477ff', N'¿Cuál es el planeta más grande del sistema solar', 1, N'63d7661c-366b-4134-9e94-6f72e3076c73', CAST(N'2024-05-06T15:19:40.170' AS DateTime), CAST(N'2024-05-06T15:19:40.170' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'a832fc7d-fc43-42e1-ab7c-6d6144832af8', N'¿Cuál es el proceso mediante el cual las plantas fabrican su propio alimento', 1, N'63d7661c-366b-4134-9e94-6f72e3076c73', CAST(N'2024-05-06T15:19:40.173' AS DateTime), CAST(N'2024-05-06T15:19:40.173' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'bae6adba-4464-48fb-b80c-71ef136b44a1', N'¿Cuántas horas duermes en promedio por noche?', 1, N'701e4b94-1e54-4de4-9128-239ded5eaa06', CAST(N'2024-05-17T11:36:59.230' AS DateTime), CAST(N'2024-05-17T11:36:59.230' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'450e7cda-1c03-4a33-abe9-720fd4a2fe7d', N'¿Ejemplo2?', 1, N'ef9c1644-f977-43e0-b47c-06699fc22d5d', CAST(N'2024-07-03T12:23:31.023' AS DateTime), CAST(N'2024-07-03T12:23:31.023' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'bb1e7ac7-c516-4341-bbda-73dbc86dd1fc', N'Pregunta 4', 1, N'a10273c0-eb49-43b8-8adf-b8b5c90a87a1', CAST(N'2024-06-19T09:54:32.800' AS DateTime), CAST(N'2024-06-19T09:55:04.423' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'768ae381-8735-43ad-8c33-77b4836a070f', N'¿Qué medio de transporte usas con más frecuencia?', 1, N'701e4b94-1e54-4de4-9128-239ded5eaa06', CAST(N'2024-05-17T11:36:59.210' AS DateTime), CAST(N'2024-05-17T11:36:59.210' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'1c8f5d74-122b-4c41-8c88-7815d790d9ec', N'Pregunta 4', 1, N'e11bb04d-bd02-4401-b6d9-f86d528199b4', CAST(N'2024-06-18T16:10:51.040' AS DateTime), CAST(N'2024-06-18T16:10:51.040' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'825d1a65-2bbc-4120-bade-7a304a8d44bd', N'¿Quién pintó la Mona Lisa', 1, N'fac2338b-35d6-4cba-9cfb-d02bf4c33e60', CAST(N'2024-05-18T20:06:22.260' AS DateTime), CAST(N'2024-05-18T20:06:22.260' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'741d8042-94e7-4865-8b44-7ab832561eba', N'¿Ejemplo2?', 1, N'f66e11b2-6d7e-413b-a7ce-3a1dc068cb67', CAST(N'2024-07-03T14:43:33.880' AS DateTime), CAST(N'2024-07-03T14:43:33.880' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'36e791c5-4812-4cca-888c-7ba831f26df5', N'¿Cuál es el planeta más grande del sistema solar', 1, N'd9ca3dcb-ee6a-4f35-ae4c-719843510a1a', CAST(N'2024-05-14T17:15:37.357' AS DateTime), CAST(N'2024-05-14T17:15:37.357' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'cf780862-6965-4ccf-a3ec-7c881fefc436', N'preueba 4', 1, N'13590568-b03d-45a8-8a13-cf2ebae6f9b4', CAST(N'2024-05-19T18:25:59.693' AS DateTime), CAST(N'2024-05-19T18:25:59.693' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'828020ba-8f8c-4650-9fe0-7e44cd9f8088', N'prueba de pregunta', 1, N'13590568-b03d-45a8-8a13-cf2ebae6f9b4', CAST(N'2024-05-17T14:55:06.953' AS DateTime), CAST(N'2024-05-17T14:55:06.953' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'fbdb896d-999e-4123-9d57-804508ddd7c1', N'¿Cuál es tu comida favorita?', 1, N'701e4b94-1e54-4de4-9128-239ded5eaa06', CAST(N'2024-05-17T11:36:59.183' AS DateTime), CAST(N'2024-05-17T11:36:59.183' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'4b64542b-5941-4b53-935f-8269262a93d4', N'¿EjemploC?', 1, N'1f05f1db-2c24-435e-a1eb-81fbef77e87b', CAST(N'2024-07-03T13:22:31.027' AS DateTime), CAST(N'2024-07-03T13:22:31.027' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'024fc029-063b-4179-ad7d-82fb599ac9ef', N'¿React js es un framework?', 1, N'27c5527f-3ea3-431b-bedf-65841eaf5663', CAST(N'2024-02-28T09:35:18.057' AS DateTime), CAST(N'2024-05-13T11:47:08.630' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'546b1a00-fa38-4ceb-be54-83ca7dd923c9', N'¿Quién escribió la obra "Romeo y Julieta"', 1, N'63d7661c-366b-4134-9e94-6f72e3076c73', CAST(N'2024-05-06T15:19:40.177' AS DateTime), CAST(N'2024-05-06T15:19:40.177' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'ef9c4a21-331f-43d6-8b16-85867035a4c2', N'Pregunta 6', 1, N'e11bb04d-bd02-4401-b6d9-f86d528199b4', CAST(N'2024-06-18T16:19:46.767' AS DateTime), CAST(N'2024-06-18T16:19:46.767' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'8aae72a1-8f0e-4bcc-a4c4-86d7cc5bced9', N'¿Cuál es el hueso más largo del cuerpo humano', 1, N'63d7661c-366b-4134-9e94-6f72e3076c73', CAST(N'2024-05-06T15:19:40.170' AS DateTime), CAST(N'2024-05-06T15:19:40.170' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'5bfc42e7-4c0e-43af-83e8-8721e3a6d8df', N'prueba', 1, N'e83ae36c-fe6d-416c-bd0f-64581fe00881', CAST(N'2024-06-12T17:32:03.210' AS DateTime), CAST(N'2024-06-12T17:32:03.210' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'baa87899-d51f-4893-a1fa-882556a8d2a4', N'¿Cuál es la capital de Francia', 1, N'63d7661c-366b-4134-9e94-6f72e3076c73', CAST(N'2024-05-06T15:19:40.153' AS DateTime), CAST(N'2024-05-06T15:19:40.153' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'6ff61c7b-7c24-41f2-b637-882d0a96f4b4', N'¿Alguna vez te has sentido discriminado?', 1, N'701e4b94-1e54-4de4-9128-239ded5eaa06', CAST(N'2024-05-17T11:36:59.150' AS DateTime), CAST(N'2024-05-17T11:36:59.150' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'afc45722-88ba-410f-affc-88f0f17ed624', N'cuarta pregurna', 1, N'428164a1-24f7-4c0c-8a6c-6278c23bffb5', CAST(N'2024-05-13T15:24:55.290' AS DateTime), CAST(N'2024-05-13T15:24:55.290' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'8b8c5642-1e5a-4cd9-a6c0-899eb7c30192', N'Pregunta 4', 1, N'7eae11eb-d3b7-4b4f-90c1-287373c64e57', CAST(N'2024-06-18T16:40:48.623' AS DateTime), CAST(N'2024-06-18T16:41:06.647' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'c29f1d5d-90db-41ff-ba8b-8c2cd25354e0', N'¿Quién fue el primer ser humano en viajar al espacio', 1, N'd9ca3dcb-ee6a-4f35-ae4c-719843510a1a', CAST(N'2024-05-14T17:15:37.350' AS DateTime), CAST(N'2024-05-14T17:15:37.350' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'e20687bd-bdd9-4edf-8bf4-8caa5cb8d616', N'¿Ejemplo2?', 1, N'37cf8fee-91e0-4886-9aea-b1dcf97cbb28', CAST(N'2024-07-03T13:32:39.993' AS DateTime), CAST(N'2024-07-03T13:32:39.993' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'99821866-9268-4e60-95b6-8d932ecaded3', N'¿EjemploD?', 1, N'1f05f1db-2c24-435e-a1eb-81fbef77e87b', CAST(N'2024-07-03T13:22:31.030' AS DateTime), CAST(N'2024-07-03T13:22:31.030' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'53f22e8e-3d32-4b7f-9d0c-8ddb90c3d9c9', N'adad', 1, N'2252397c-b7d9-42b4-b171-3a6eda0afaec', CAST(N'2024-06-19T11:47:03.777' AS DateTime), CAST(N'2024-06-19T11:47:03.777' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'add6b6e1-3744-4d54-a985-8e2e9427c406', N'¿Cuál es la fórmula química del agua', 1, N'63d7661c-366b-4134-9e94-6f72e3076c73', CAST(N'2024-05-06T15:19:40.187' AS DateTime), CAST(N'2024-05-09T18:03:36.960' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'a4b0ad13-26a9-4278-b701-8ec9bf6031c3', N'ghdgfsfsfs', 1, N'2252397c-b7d9-42b4-b171-3a6eda0afaec', CAST(N'2024-06-19T11:46:55.577' AS DateTime), CAST(N'2024-06-19T11:46:55.577' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'60e85430-d266-481d-ab99-90b825ba4ed7', N'Estas de acuerdo en 2', 1, N'354e8be8-3d2d-4e42-90b6-8935f7e56ef4', CAST(N'2024-06-19T11:51:12.137' AS DateTime), CAST(N'2024-06-19T11:51:12.137' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'17944192-2c92-4b92-af87-94ce8928651e', N'¿Cuál es el océano más grande del mundo', 1, N'fac2338b-35d6-4cba-9cfb-d02bf4c33e60', CAST(N'2024-05-18T20:06:22.247' AS DateTime), CAST(N'2024-05-18T20:06:22.247' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'd34fb3e9-1be1-41bd-b542-957a78db78b7', N'¿Cuál es tu deporte favorito?', 1, N'701e4b94-1e54-4de4-9128-239ded5eaa06', CAST(N'2024-05-17T11:36:59.193' AS DateTime), CAST(N'2024-05-17T11:36:59.193' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'415aa7b1-846e-430e-8687-96789fcdac9b', N'Pregunta 3', 1, N'7eae11eb-d3b7-4b4f-90c1-287373c64e57', CAST(N'2024-06-18T16:40:29.743' AS DateTime), CAST(N'2024-06-18T16:40:35.737' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'17f90498-53f6-48ba-858b-980b529aaf4e', N'gggggg', 1, N'39d09ca3-ddbc-4ea2-a21e-7b982d3b7628', CAST(N'2024-06-19T12:11:03.463' AS DateTime), CAST(N'2024-06-19T12:11:03.463' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'04ae039c-09c6-4785-923a-98279c5fd49d', N'¿Cuál es la fórmula química del agua', 1, N'fac2338b-35d6-4cba-9cfb-d02bf4c33e60', CAST(N'2024-05-18T20:06:22.307' AS DateTime), CAST(N'2024-05-18T20:06:22.307' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'70cc4b45-c763-4e54-9728-98738a0e57ca', N'¿Cuál es el hueso más largo del cuerpo humano', 1, N'fac2338b-35d6-4cba-9cfb-d02bf4c33e60', CAST(N'2024-05-18T20:06:22.283' AS DateTime), CAST(N'2024-05-18T20:06:22.283' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'18412367-e942-4df0-9a2a-99cfe7e002a1', N'Pregunta 4', 1, N'a10273c0-eb49-43b8-8adf-b8b5c90a87a1', CAST(N'2024-06-19T09:53:17.060' AS DateTime), CAST(N'2024-06-19T09:53:17.060' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'942152b7-25fc-47f6-a41d-9b420ab8231a', N'¿Estas de acuerdo con el servicio de internet?', 1, N'428164a1-24f7-4c0c-8a6c-6278c23bffb5', CAST(N'2024-06-12T14:19:17.313' AS DateTime), CAST(N'2024-06-12T14:19:17.313' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'44f97be2-194e-40cc-9d42-9ebfd8a3aaad', N'¿Quién escribió "El Principito"', 1, N'63d7661c-366b-4134-9e94-6f72e3076c73', CAST(N'2024-05-06T15:19:40.160' AS DateTime), CAST(N'2024-05-06T15:19:40.160' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'd0e024f3-e436-4f39-aa16-9ec0d638b825', N'¿Quién fue el primer presidente de Estados Unidos', 1, N'fac2338b-35d6-4cba-9cfb-d02bf4c33e60', CAST(N'2024-05-18T20:06:22.273' AS DateTime), CAST(N'2024-05-18T20:06:22.273' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'5089e889-89ff-4ca9-a614-9fe5d0567487', N'¿Que significa API?', 1, N'27c5527f-3ea3-431b-bedf-65841eaf5663', CAST(N'2024-02-27T16:56:20.277' AS DateTime), CAST(N'2024-02-27T16:56:20.277' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'3418513a-2424-4676-9cc1-a071fbcc32e5', N'¿Cuál es la capital de Francia', 1, N'fac2338b-35d6-4cba-9cfb-d02bf4c33e60', CAST(N'2024-05-18T20:06:22.263' AS DateTime), CAST(N'2024-05-18T20:06:22.263' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'5e89efae-a8e6-4aad-9347-a117e6df00ca', N'primera prueba', 1, N'c40e87a3-b241-403b-84db-f8d27c50261b', CAST(N'2024-05-14T15:49:43.730' AS DateTime), CAST(N'2024-05-14T15:49:43.730' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'dda0bb6e-5579-4971-a05a-a1a20c4482ac', N'¿Ejemplo5?', 1, N'0280943a-9140-4e17-a722-dcb3fc4dd725', CAST(N'2024-06-18T17:48:28.880' AS DateTime), CAST(N'2024-06-18T17:48:28.880' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'697a8471-4b6a-4422-b4e7-a1c8de4d72c7', N'¿Cuál es el planeta más grande del sistema solar', 1, N'fac2338b-35d6-4cba-9cfb-d02bf4c33e60', CAST(N'2024-05-18T20:06:22.287' AS DateTime), CAST(N'2024-05-18T20:06:22.287' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'768d597b-102e-4a6a-ac31-a43d22726e47', N'¿Pregunta b?', 1, N'1e42d6e2-6323-4ac6-917c-dc1727f5e49d', CAST(N'2024-06-03T16:18:15.330' AS DateTime), CAST(N'2024-06-03T16:18:15.330' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'373a2694-c2d7-4d04-a5c6-a4b25b6bc2ce', N'¿Cuál es el río más largo del mundo', 1, N'd9ca3dcb-ee6a-4f35-ae4c-719843510a1a', CAST(N'2024-05-14T17:15:37.343' AS DateTime), CAST(N'2024-05-14T17:15:37.343' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'812b0e64-0b5e-4742-a260-a5eb8b09d89f', N'¿Ejemplo?', 1, N'ef9c1644-f977-43e0-b47c-06699fc22d5d', CAST(N'2024-07-03T12:23:31.010' AS DateTime), CAST(N'2024-07-03T12:23:31.010' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'6122e532-6296-4b7f-b2cf-a91b1e1ce8a2', N'¿Cuál es tu género de película favorito?', 1, N'701e4b94-1e54-4de4-9128-239ded5eaa06', CAST(N'2024-05-17T11:36:59.203' AS DateTime), CAST(N'2024-05-17T11:36:59.203' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'5eba467e-fcd2-4b64-8da4-aa167d1c2539', N'¿Quién escribió la obra "Romeo y Julieta"', 1, N'd9ca3dcb-ee6a-4f35-ae4c-719843510a1a', CAST(N'2024-05-14T17:15:37.363' AS DateTime), CAST(N'2024-05-14T17:15:37.363' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'19850dc1-0247-44c6-9774-aa733a61ce45', N'¿Ejemplo4?', 1, N'6e504c05-c240-4a9a-931e-b3ad7e452333', CAST(N'2024-07-03T13:16:16.600' AS DateTime), CAST(N'2024-07-03T13:16:16.600' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'0f480871-91b1-4cb3-b489-acca5c45edd1', N'¿Quién fue el primer ser humano en viajar al espacio', 1, N'fac2338b-35d6-4cba-9cfb-d02bf4c33e60', CAST(N'2024-05-18T20:06:22.277' AS DateTime), CAST(N'2024-05-18T20:06:22.277' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'4561f5f6-1c0d-496d-9ddb-adb0157b4a92', N'¿Ejemplo2?', 1, N'6e504c05-c240-4a9a-931e-b3ad7e452333', CAST(N'2024-07-03T13:16:16.590' AS DateTime), CAST(N'2024-07-03T13:16:16.590' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'3144a4a4-2d01-4bc1-9d2e-b0365f6b125c', N'¿Cuál es el proceso mediante el cual las plantas fabrican su propio alimento', 1, N'fac2338b-35d6-4cba-9cfb-d02bf4c33e60', CAST(N'2024-05-18T20:06:22.287' AS DateTime), CAST(N'2024-05-18T20:06:22.287' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'98cc12a2-988e-4884-8d8e-b33999cb7e38', N'¿Ejemplo1?', 1, N'6e504c05-c240-4a9a-931e-b3ad7e452333', CAST(N'2024-07-03T13:16:16.587' AS DateTime), CAST(N'2024-07-03T13:16:16.587' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'f48a82eb-8845-4172-b53d-b3cd42ffa07e', N'¿Cuál es la montaña más alta del mundo', 1, N'63d7661c-366b-4134-9e94-6f72e3076c73', CAST(N'2024-05-06T15:19:40.157' AS DateTime), CAST(N'2024-05-06T15:19:40.157' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'a418389d-a1a4-49d5-94e2-b8f4dc813982', N'¿Quién escribió "El Principito"', 1, N'd9ca3dcb-ee6a-4f35-ae4c-719843510a1a', CAST(N'2024-05-14T17:15:37.340' AS DateTime), CAST(N'2024-05-14T17:15:37.340' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'24e68314-38ec-4f1d-b5b6-ba6ef91edbf7', N'¿Q tan frecuente tomas agua al día?', 1, N'2252397c-b7d9-42b4-b171-3a6eda0afaec', CAST(N'2024-06-19T11:46:13.600' AS DateTime), CAST(N'2024-06-19T11:46:13.600' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'9a431a9c-1aaa-4616-8b4b-bbf6c34082de', N'¿Ejemplo2?', 1, N'0280943a-9140-4e17-a722-dcb3fc4dd725', CAST(N'2024-06-18T17:48:28.860' AS DateTime), CAST(N'2024-06-18T17:48:28.860' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'89af27c7-a4c1-4f07-a439-bce379652542', N'¿Prefieres leer libros en formato digital o impreso?', 1, N'701e4b94-1e54-4de4-9128-239ded5eaa06', CAST(N'2024-05-17T11:36:59.213' AS DateTime), CAST(N'2024-05-17T11:36:59.213' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'f29610cb-4dfb-4e89-9c70-bd56031bf137', N'¿Quién fue el primer presidente de México', 1, N'd9ca3dcb-ee6a-4f35-ae4c-719843510a1a', CAST(N'2024-05-14T17:15:37.370' AS DateTime), CAST(N'2024-05-14T17:15:37.370' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'4d30043b-9bbf-4dac-8e4c-c3663eb83655', N'¿Ejemplob?', 1, N'60713ad9-036a-4f46-8b18-30b37fa1a1c2', CAST(N'2024-06-19T12:00:32.247' AS DateTime), CAST(N'2024-06-19T12:00:32.247' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'5c5fe21d-35a5-4e83-88be-c5004d5027bf', N'prueba 2', 1, N'13590568-b03d-45a8-8a13-cf2ebae6f9b4', CAST(N'2024-05-19T18:25:12.527' AS DateTime), CAST(N'2024-05-19T18:25:12.527' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'2f722edf-8c3b-4682-8abf-c8305c2d18ca', N'¿Ejemplo1?', 1, N'0280943a-9140-4e17-a722-dcb3fc4dd725', CAST(N'2024-06-18T17:48:28.843' AS DateTime), CAST(N'2024-06-18T17:48:28.843' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'7beb9206-245a-4fc2-a631-c8a6e38106b6', N'¿Ejemplof?', 1, N'46a95c2a-36ca-472c-8645-a8fb96bf2812', CAST(N'2024-07-03T11:55:14.130' AS DateTime), CAST(N'2024-07-03T11:55:14.130' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'eace26ab-f364-44cc-a179-cca4952a5cc4', N'Estas de acuerdo en 3', 1, N'354e8be8-3d2d-4e42-90b6-8935f7e56ef4', CAST(N'2024-06-19T11:51:12.140' AS DateTime), CAST(N'2024-06-19T11:51:12.140' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'f8499c7e-6912-4b18-8819-ccbdbe4bfb94', N'¿Cuál es el metal más abundante en la corteza terrestre', 1, N'd9ca3dcb-ee6a-4f35-ae4c-719843510a1a', CAST(N'2024-05-14T17:15:37.353' AS DateTime), CAST(N'2024-05-14T17:15:37.353' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'fcd4f005-2ea6-491b-bdf4-d07beb7cdb0d', N'¿Quién fue el primer presidente de México', 1, N'63d7661c-366b-4134-9e94-6f72e3076c73', CAST(N'2024-05-06T15:19:40.183' AS DateTime), CAST(N'2024-05-06T15:19:40.183' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'9d6aa9f8-e6a9-4dd9-ade8-d0e2d0e53309', N'¿Ejemplo4?', 1, N'0280943a-9140-4e17-a722-dcb3fc4dd725', CAST(N'2024-06-18T17:48:28.873' AS DateTime), CAST(N'2024-06-18T17:48:28.873' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'cb0edcd3-1843-49d0-b98f-d1894a876054', N'¿Cuál es el hueso más largo del cuerpo humano', 1, N'd9ca3dcb-ee6a-4f35-ae4c-719843510a1a', CAST(N'2024-05-14T17:15:37.357' AS DateTime), CAST(N'2024-05-14T17:15:37.357' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'24376bf1-0aa7-4b93-9e49-d1d3b983d036', N'¿Cuál es tu estación del año favorita?', 1, N'701e4b94-1e54-4de4-9128-239ded5eaa06', CAST(N'2024-05-17T11:36:59.237' AS DateTime), CAST(N'2024-05-17T11:36:59.237' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'a4e255f2-3c31-4174-baa7-d1e1bf356b4a', N'preueba 5', 1, N'13590568-b03d-45a8-8a13-cf2ebae6f9b4', CAST(N'2024-05-19T18:26:24.477' AS DateTime), CAST(N'2024-05-19T18:26:24.477' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'9d8082c3-f809-41ef-ab1d-d24162bfcf72', N'¿Pregunta d?', 1, N'1e42d6e2-6323-4ac6-917c-dc1727f5e49d', CAST(N'2024-06-03T16:18:15.330' AS DateTime), CAST(N'2024-06-03T16:18:15.330' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'e21a8ca2-e2a6-4d4e-a739-d44f132aa2aa', N'¿Cuál es la capital de Francia', 1, N'd9ca3dcb-ee6a-4f35-ae4c-719843510a1a', CAST(N'2024-05-14T17:15:37.337' AS DateTime), CAST(N'2024-05-14T17:15:37.337' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'9d3385e6-863e-4e5c-b5ab-d4cc9be20991', N'¿Cuál es el río más largo del mundo', 1, N'fac2338b-35d6-4cba-9cfb-d02bf4c33e60', CAST(N'2024-05-18T20:06:22.270' AS DateTime), CAST(N'2024-05-18T20:06:22.270' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'8af5bd89-7624-495b-81e1-d642dc9cdcb3', N'¿Cuál es la montaña más alta del mundo', 1, N'fac2338b-35d6-4cba-9cfb-d02bf4c33e60', CAST(N'2024-05-18T20:06:22.267' AS DateTime), CAST(N'2024-05-18T20:06:22.267' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'f569a206-15cb-4fb8-9bc1-d76405aa7bc9', N'¿Con qué frecuencia usas redes sociales?', 1, N'701e4b94-1e54-4de4-9128-239ded5eaa06', CAST(N'2024-05-17T11:36:59.200' AS DateTime), CAST(N'2024-05-17T11:36:59.200' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'cb7f759a-4f64-4c49-8d4e-d7716784ec88', N'¿Lleva un cuadernito para tomar apuntes en las reuniones?', 1, N'0b3439f9-f94d-4e28-b758-89668b4d020f', CAST(N'2024-06-12T14:51:55.900' AS DateTime), CAST(N'2024-06-12T14:51:55.900' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'e0c81067-b353-4659-b29c-d909d1209830', N'¿Cuál es la capital de Rusia', 1, N'fac2338b-35d6-4cba-9cfb-d02bf4c33e60', CAST(N'2024-05-18T20:06:22.300' AS DateTime), CAST(N'2024-05-18T20:06:22.300' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'b7a37232-4eb1-4ac4-bc7b-d9396a96000f', N'prueba 2', 1, N'428164a1-24f7-4c0c-8a6c-6278c23bffb5', CAST(N'2024-05-13T12:56:22.233' AS DateTime), CAST(N'2024-05-13T12:56:22.233' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'494aec55-c94c-4e71-94cf-dd101e545458', N'¿Cuál es la montaña más alta del mundo', 1, N'd9ca3dcb-ee6a-4f35-ae4c-719843510a1a', CAST(N'2024-05-14T17:15:37.340' AS DateTime), CAST(N'2024-05-14T17:15:37.340' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'8d5e4ba5-2632-4ca4-817a-de1300b99a0e', N'¿En qué país se encuentra la famosa Torre Eiffel', 1, N'fac2338b-35d6-4cba-9cfb-d02bf4c33e60', CAST(N'2024-05-18T20:06:22.303' AS DateTime), CAST(N'2024-05-18T20:06:22.303' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'8397da47-99cc-45a8-afdd-e2105d2eb748', N'dadadasd', 1, N'a10273c0-eb49-43b8-8adf-b8b5c90a87a1', CAST(N'2024-06-19T10:01:21.170' AS DateTime), CAST(N'2024-06-19T10:01:21.170' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'93a7cd55-8c95-4ace-9468-e3a78528fa74', N'¿Ejemplo4?', 1, N'37cf8fee-91e0-4886-9aea-b1dcf97cbb28', CAST(N'2024-07-03T13:32:40.010' AS DateTime), CAST(N'2024-07-03T13:32:40.010' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'c3d05caf-4623-4fdd-9097-e4a289cd87b8', N'jjjjjjjjjjjjjjjj', 1, N'39d09ca3-ddbc-4ea2-a21e-7b982d3b7628', CAST(N'2024-06-19T12:11:10.670' AS DateTime), CAST(N'2024-06-19T12:11:10.670' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'912583c5-89cf-46d6-9366-e512187830a1', N'¿Ejemplob?', 1, N'46a95c2a-36ca-472c-8645-a8fb96bf2812', CAST(N'2024-07-03T11:55:14.117' AS DateTime), CAST(N'2024-07-03T11:55:14.117' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'de3ebcdd-9365-4c51-be79-e7d2ab07e3b7', N'Pregunta 0', 1, N'7eae11eb-d3b7-4b4f-90c1-287373c64e57', CAST(N'2024-06-18T16:41:46.897' AS DateTime), CAST(N'2024-06-18T16:41:46.897' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'af15ba63-8426-43d9-ba74-e855cde8b47d', N'¿Cuál fue el lugar que consumiste drogas o alcohol por primera vez?', 1, N'701e4b94-1e54-4de4-9128-239ded5eaa06', CAST(N'2024-05-17T11:36:59.167' AS DateTime), CAST(N'2024-05-17T11:36:59.167' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'52efe634-e59c-463c-9599-e88f9955094c', N'¿En qué año terminó la Segunda Guerra Mundial', 1, N'63d7661c-366b-4134-9e94-6f72e3076c73', CAST(N'2024-05-06T15:19:40.163' AS DateTime), CAST(N'2024-05-06T15:19:40.163' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'5cb81db3-01ac-49b5-9855-e8f9b686a99f', N'¿Cuál es tu nivel de estudios?', 1, N'701e4b94-1e54-4de4-9128-239ded5eaa06', CAST(N'2024-05-17T11:36:59.170' AS DateTime), CAST(N'2024-05-17T11:36:59.170' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'176464f5-9c08-422e-8fa2-eeba91ad54b7', N'¿Ejemploaaaa?', 1, N'a10273c0-eb49-43b8-8adf-b8b5c90a87a1', CAST(N'2024-06-19T09:57:32.910' AS DateTime), CAST(N'2024-06-19T09:57:32.910' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'34922354-8289-4138-ba76-f014216ab8fa', N'¿Cuál es la fórmula química del agua', 1, N'd9ca3dcb-ee6a-4f35-ae4c-719843510a1a', CAST(N'2024-05-14T17:15:37.377' AS DateTime), CAST(N'2024-05-14T17:15:37.377' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'ccc3d027-def0-424d-94c2-f03a48a91ae0', N'¿En qué país se encuentra la famosa Torre Eiffel', 1, N'63d7661c-366b-4134-9e94-6f72e3076c73', CAST(N'2024-05-06T15:19:40.187' AS DateTime), CAST(N'2024-05-06T15:19:40.187' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'4d6449d8-69a2-4062-a77d-f3f9e3a3777f', N'Pregunta 5', 1, N'2252397c-b7d9-42b4-b171-3a6eda0afaec', CAST(N'2024-06-19T11:46:31.537' AS DateTime), CAST(N'2024-06-19T11:46:31.537' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'74dbbef1-3d7b-4c36-aaf5-f459715311b0', N'Estas de acuerdo en 5', 1, N'354e8be8-3d2d-4e42-90b6-8935f7e56ef4', CAST(N'2024-06-19T11:51:12.150' AS DateTime), CAST(N'2024-06-19T11:51:12.150' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'36e6a35d-0678-4725-95a1-fb1ec32103fd', N'¿Cuál es la capital de Rusia', 1, N'63d7661c-366b-4134-9e94-6f72e3076c73', CAST(N'2024-05-06T15:19:40.180' AS DateTime), CAST(N'2024-05-06T15:19:40.180' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'a521fe33-f349-4279-9ee9-fb9b4dec34bc', N'¿Cuál es el metal más ligero', 1, N'63d7661c-366b-4134-9e94-6f72e3076c73', CAST(N'2024-05-06T15:19:40.180' AS DateTime), CAST(N'2024-05-06T15:19:40.180' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'331bea1d-cf31-4085-bda8-fc1544356c4d', N'¿Cuál es tu bebida favorita?', 1, N'701e4b94-1e54-4de4-9128-239ded5eaa06', CAST(N'2024-05-17T11:36:59.220' AS DateTime), CAST(N'2024-05-17T11:36:59.220' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'a66925cc-5701-4460-91d0-fe6af4676618', N'¿Q tan frecuente haces pausas activas?', 1, N'e11bb04d-bd02-4401-b6d9-f86d528199b4', CAST(N'2024-06-18T16:00:22.860' AS DateTime), CAST(N'2024-06-18T16:00:22.860' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'57cb8739-ba65-4027-932f-ffbfebe6eadd', N'¿EjemploA?', 1, N'1f05f1db-2c24-435e-a1eb-81fbef77e87b', CAST(N'2024-07-03T13:22:31.020' AS DateTime), CAST(N'2024-07-03T13:22:31.020' AS DateTime))
GO
INSERT [dbo].[Recompensa] ([idRecompensa], [nombre], [descripcion], [imagen], [cantDisponible], [cantCanje], [estado], [fechaCreacion], [fechaModificacion], [idCategoria]) VALUES (N'40853d25-1a7a-416a-a9ca-32c3f2c53814', N'mi recompensa', N'desc 1', NULL, 15, 10, 1, CAST(N'2024-04-16T14:49:23.880' AS DateTime), CAST(N'2024-04-16T14:51:49.697' AS DateTime), N'ee6ca0ed-f5e2-4640-aaf4-76d11c9762b2')
GO
INSERT [dbo].[Recompensa] ([idRecompensa], [nombre], [descripcion], [imagen], [cantDisponible], [cantCanje], [estado], [fechaCreacion], [fechaModificacion], [idCategoria]) VALUES (N'4d6da0f1-01a5-4efc-9ca3-4fd6a5130a11', N'Tarjeta supermaxi', N'Descripcion 1', NULL, 10, 40, 0, CAST(N'2024-03-12T17:04:26.230' AS DateTime), CAST(N'2024-04-16T14:52:05.287' AS DateTime), N'11283d21-ea6e-4945-9c59-a8868416016f')
GO
INSERT [dbo].[Recompensa] ([idRecompensa], [nombre], [descripcion], [imagen], [cantDisponible], [cantCanje], [estado], [fechaCreacion], [fechaModificacion], [idCategoria]) VALUES (N'56d57b18-2afe-46a9-822b-9540eb4f8e6a', N'Tomatodo personalizado', NULL, NULL, 46, 10, 1, CAST(N'2023-12-12T12:34:34.027' AS DateTime), CAST(N'2023-12-12T12:34:34.027' AS DateTime), N'11283d21-ea6e-4945-9c59-a8868416016f')
GO
INSERT [dbo].[Recompensa] ([idRecompensa], [nombre], [descripcion], [imagen], [cantDisponible], [cantCanje], [estado], [fechaCreacion], [fechaModificacion], [idCategoria]) VALUES (N'91f482c6-59a5-450f-a09a-9c745b861339', N'10 entradas al cine', NULL, N'entradas-cine.jpg', 5, 5, 1, CAST(N'2023-12-12T12:58:13.280' AS DateTime), CAST(N'2024-02-01T12:55:24.320' AS DateTime), N'11283d21-ea6e-4945-9c59-a8868416016f')
GO
INSERT [dbo].[Recompensa] ([idRecompensa], [nombre], [descripcion], [imagen], [cantDisponible], [cantCanje], [estado], [fechaCreacion], [fechaModificacion], [idCategoria]) VALUES (N'2517e519-acf6-42d4-90a7-df589bff4987', N'Reloj Apple Watch series 9', N'Color Midnight', N'apple watch series 9.PNG', 8, 100, 1, CAST(N'2024-02-01T12:57:47.847' AS DateTime), CAST(N'2024-02-01T12:57:47.847' AS DateTime), N'11283d21-ea6e-4945-9c59-a8868416016f')
GO
INSERT [dbo].[Recompensa] ([idRecompensa], [nombre], [descripcion], [imagen], [cantDisponible], [cantCanje], [estado], [fechaCreacion], [fechaModificacion], [idCategoria]) VALUES (N'3c18891d-48f7-44b1-9de9-e9eb833cee23', N'Bicicleta', N'Descripcion2', NULL, 2, 1000, 1, CAST(N'2024-03-12T17:04:26.230' AS DateTime), CAST(N'2024-04-16T14:52:16.870' AS DateTime), N'11283d21-ea6e-4945-9c59-a8868416016f')
GO
INSERT [dbo].[RedSocial] ([idRed], [descripcion], [imagen], [estado], [fechaPublicacion], [fechaCreacion], [fechaModificacion]) VALUES (N'9c76ea2c-549e-4bda-890c-1b26a4175200', N'AB37197C-BF33-44B8-BA5D-E246FA250B41|ha conseguido una recompensa,|91F482C6-59A5-450F-A09A-9C745B861339|Recompensa', N'entradas-cine.jpg', 1, CAST(N'2024-04-17T12:49:36.603' AS DateTime), CAST(N'2024-04-17T12:49:36.603' AS DateTime), CAST(N'2024-04-17T12:49:36.603' AS DateTime))
GO
INSERT [dbo].[RedSocial] ([idRed], [descripcion], [imagen], [estado], [fechaPublicacion], [fechaCreacion], [fechaModificacion]) VALUES (N'7e9ba644-ad66-4eb5-83bd-1cf06d922928', N'AB37197C-BF33-44B8-BA5D-E246FA250B41|ha conseguido una recompensa,|91F482C6-59A5-450F-A09A-9C745B861339|Recompensa', N'entradas-cine.jpg', 1, CAST(N'2024-04-17T12:43:02.697' AS DateTime), CAST(N'2024-04-17T12:43:02.697' AS DateTime), CAST(N'2024-04-17T12:43:02.697' AS DateTime))
GO
INSERT [dbo].[RedSocial] ([idRed], [descripcion], [imagen], [estado], [fechaPublicacion], [fechaCreacion], [fechaModificacion]) VALUES (N'a8c40b1b-69e1-47e2-9535-1dca08b468c2', N'AB37197C-BF33-44B8-BA5D-E246FA250B41|ha conseguido una recompensa,|91F482C6-59A5-450F-A09A-9C745B861339|Recompensa', N'entradas-cine.jpg', 1, CAST(N'2024-04-09T18:22:47.587' AS DateTime), CAST(N'2024-04-09T18:22:47.590' AS DateTime), CAST(N'2024-04-09T18:22:47.590' AS DateTime))
GO
INSERT [dbo].[RedSocial] ([idRed], [descripcion], [imagen], [estado], [fechaPublicacion], [fechaCreacion], [fechaModificacion]) VALUES (N'faed931d-8e56-4264-a97c-1f0ba115fed8', N'DE632913-94CF-4AB1-8350-AA4C9C0B0B52|ha canjeado la recompensa:|56D57B18-2AFE-46A9-822B-9540EB4F8E6A|Recompensa', NULL, 1, CAST(N'2024-06-19T10:46:19.240' AS DateTime), CAST(N'2024-06-19T10:46:19.240' AS DateTime), CAST(N'2024-06-19T10:46:19.240' AS DateTime))
GO
INSERT [dbo].[RedSocial] ([idRed], [descripcion], [imagen], [estado], [fechaPublicacion], [fechaCreacion], [fechaModificacion]) VALUES (N'ce77c446-0fb5-4bae-ab40-2fdc754f8119', N'AB37197C-BF33-44B8-BA5D-E246FA250B41|ha conseguido una recompensa,|40853D25-1A7A-416A-A9CA-32C3F2C53814|Recompensa', NULL, 1, CAST(N'2024-04-17T12:42:48.427' AS DateTime), CAST(N'2024-04-17T12:42:48.427' AS DateTime), CAST(N'2024-04-17T12:42:48.427' AS DateTime))
GO
INSERT [dbo].[RedSocial] ([idRed], [descripcion], [imagen], [estado], [fechaPublicacion], [fechaCreacion], [fechaModificacion]) VALUES (N'0bf60bf5-09dc-4059-a3d8-34d15eb6e40f', N'96A49AC1-C9C4-4BC1-8D3C-548F37F34828|ha canjeado la recompensa:|91F482C6-59A5-450F-A09A-9C745B861339|Recompensa', N'entradas-cine.jpg', 1, CAST(N'2024-07-03T13:27:03.760' AS DateTime), CAST(N'2024-07-03T13:27:03.763' AS DateTime), CAST(N'2024-07-03T13:27:03.763' AS DateTime))
GO
INSERT [dbo].[RedSocial] ([idRed], [descripcion], [imagen], [estado], [fechaPublicacion], [fechaCreacion], [fechaModificacion]) VALUES (N'9f1663de-4038-40ad-bd86-399a94cae631', N'DE632913-94CF-4AB1-8350-AA4C9C0B0B52|ha canjeado la recompensa:|40853D25-1A7A-416A-A9CA-32C3F2C53814|Recompensa', NULL, 1, CAST(N'2024-06-19T10:44:09.893' AS DateTime), CAST(N'2024-06-19T10:44:09.897' AS DateTime), CAST(N'2024-06-19T10:44:09.897' AS DateTime))
GO
INSERT [dbo].[RedSocial] ([idRed], [descripcion], [imagen], [estado], [fechaPublicacion], [fechaCreacion], [fechaModificacion]) VALUES (N'18bb6c17-1fa4-49b0-8be0-3a8b22e3381a', N'AB37197C-BF33-44B8-BA5D-E246FA250B41|ha conseguido una recompensa,|91F482C6-59A5-450F-A09A-9C745B861339|Recompensa', N'entradas-cine.jpg', 1, CAST(N'2024-04-17T17:45:15.840' AS DateTime), CAST(N'2024-04-17T17:45:15.840' AS DateTime), CAST(N'2024-04-17T17:45:15.840' AS DateTime))
GO
INSERT [dbo].[RedSocial] ([idRed], [descripcion], [imagen], [estado], [fechaPublicacion], [fechaCreacion], [fechaModificacion]) VALUES (N'753e11df-2798-4efe-9f06-413862707a97', N'939C9C6D-9DCF-4B7E-BEA6-5C26169FA066|ha alcanzado el|CF68ECD4-FE5C-4E11-9AAB-69514424FD1B|Nivel', NULL, 1, CAST(N'2024-03-18T15:44:52.617' AS DateTime), CAST(N'2024-03-18T15:44:52.620' AS DateTime), CAST(N'2024-03-18T15:44:52.620' AS DateTime))
GO
INSERT [dbo].[RedSocial] ([idRed], [descripcion], [imagen], [estado], [fechaPublicacion], [fechaCreacion], [fechaModificacion]) VALUES (N'797bbcf4-26cd-433f-95c9-43baa3fca620', N'DE632913-94CF-4AB1-8350-AA4C9C0B0B52|ha alcanzado el nivel:|CF68ECD4-FE5C-4E11-9AAB-69514424FD1B|Nivel', NULL, 1, CAST(N'2024-06-19T09:37:52.040' AS DateTime), CAST(N'2024-06-19T09:37:52.040' AS DateTime), CAST(N'2024-06-19T09:37:52.040' AS DateTime))
GO
INSERT [dbo].[RedSocial] ([idRed], [descripcion], [imagen], [estado], [fechaPublicacion], [fechaCreacion], [fechaModificacion]) VALUES (N'6a4e28e6-0c80-474b-b424-4414e78a23a4', N'DE632913-94CF-4AB1-8350-AA4C9C0B0B52|ha canjeado la recompensa:|91F482C6-59A5-450F-A09A-9C745B861339|Recompensa', N'entradas-cine.jpg', 1, CAST(N'2024-06-19T10:44:36.223' AS DateTime), CAST(N'2024-06-19T10:44:36.223' AS DateTime), CAST(N'2024-06-19T10:44:36.223' AS DateTime))
GO
INSERT [dbo].[RedSocial] ([idRed], [descripcion], [imagen], [estado], [fechaPublicacion], [fechaCreacion], [fechaModificacion]) VALUES (N'ceec0e73-0057-4121-b177-47b5c1b0cc70', N'AB37197C-BF33-44B8-BA5D-E246FA250B41|ha alcanzado el|A3AE5C3C-1D90-4306-882D-A092EDBD82EF|Nivel', NULL, 1, CAST(N'2024-03-14T16:49:12.327' AS DateTime), CAST(N'2024-03-14T16:49:12.327' AS DateTime), CAST(N'2024-03-14T16:49:12.327' AS DateTime))
GO
INSERT [dbo].[RedSocial] ([idRed], [descripcion], [imagen], [estado], [fechaPublicacion], [fechaCreacion], [fechaModificacion]) VALUES (N'8a4314f1-7757-4b38-a375-4a15e7b71632', N'42C77DB8-7FD5-45CB-AB1A-EB331C7DFB61|ha obtenido la medalla:|2EB8768C-F1AE-49BE-83E0-B04C39EB64C2|Medalla', NULL, 1, CAST(N'2024-06-19T11:53:40.800' AS DateTime), CAST(N'2024-06-19T11:53:40.803' AS DateTime), CAST(N'2024-06-19T11:53:40.803' AS DateTime))
GO
INSERT [dbo].[RedSocial] ([idRed], [descripcion], [imagen], [estado], [fechaPublicacion], [fechaCreacion], [fechaModificacion]) VALUES (N'd1a31210-f20f-481a-a842-4a21a7823b69', N'AB37197C-BF33-44B8-BA5D-E246FA250B41|ha conseguido una recompensa,|91F482C6-59A5-450F-A09A-9C745B861339|Recompensa', N'entradas-cine.jpg', 1, CAST(N'2024-04-17T12:50:02.083' AS DateTime), CAST(N'2024-04-17T12:50:02.083' AS DateTime), CAST(N'2024-04-17T12:50:02.083' AS DateTime))
GO
INSERT [dbo].[RedSocial] ([idRed], [descripcion], [imagen], [estado], [fechaPublicacion], [fechaCreacion], [fechaModificacion]) VALUES (N'871e559d-ce0f-4578-b159-4c7756b8e624', N'AB37197C-BF33-44B8-BA5D-E246FA250B41|ha conseguido una recompensa,|40853D25-1A7A-416A-A9CA-32C3F2C53814|Recompensa', NULL, 1, CAST(N'2024-04-17T10:42:28.640' AS DateTime), CAST(N'2024-04-17T10:42:28.643' AS DateTime), CAST(N'2024-04-17T10:42:28.643' AS DateTime))
GO
INSERT [dbo].[RedSocial] ([idRed], [descripcion], [imagen], [estado], [fechaPublicacion], [fechaCreacion], [fechaModificacion]) VALUES (N'583bb7a8-c93f-427d-96a9-4e7beb0b9bcc', N'96A49AC1-C9C4-4BC1-8D3C-548F37F34828|ha obtenido la medalla:|54C00FB9-E9D1-491C-B3BB-D9FD6307D508|Medalla', NULL, 1, CAST(N'2024-07-03T13:36:16.030' AS DateTime), CAST(N'2024-07-03T13:36:16.030' AS DateTime), CAST(N'2024-07-03T13:36:16.030' AS DateTime))
GO
INSERT [dbo].[RedSocial] ([idRed], [descripcion], [imagen], [estado], [fechaPublicacion], [fechaCreacion], [fechaModificacion]) VALUES (N'c9810c23-75e2-4e66-8f97-50c9143aa716', N'AB37197C-BF33-44B8-BA5D-E246FA250B41|ha alcanzado el nivel:|5690C0BA-70E1-4F3D-A0E2-2AB787446F37|Nivel', NULL, 1, CAST(N'2024-05-30T15:21:07.193' AS DateTime), CAST(N'2024-05-30T15:21:07.193' AS DateTime), CAST(N'2024-05-30T15:21:07.193' AS DateTime))
GO
INSERT [dbo].[RedSocial] ([idRed], [descripcion], [imagen], [estado], [fechaPublicacion], [fechaCreacion], [fechaModificacion]) VALUES (N'992ac96b-a248-4757-9300-55733531b1fb', N'AB37197C-BF33-44B8-BA5D-E246FA250B41|ha alcanzado el|FFD99848-9D07-4CBD-93B1-B7CA5CC18452|Nivel', N'nivel3.png', 1, CAST(N'2024-03-12T15:16:40.480' AS DateTime), CAST(N'2024-03-12T15:16:40.480' AS DateTime), CAST(N'2024-03-12T15:16:40.480' AS DateTime))
GO
INSERT [dbo].[RedSocial] ([idRed], [descripcion], [imagen], [estado], [fechaPublicacion], [fechaCreacion], [fechaModificacion]) VALUES (N'f40d6f71-478e-47b4-b1f8-5ddab2be8268', N'015E40DD-58CE-401E-A0A9-075874BC0B68|ha alcanzado el|62629073-7CC1-4AD3-82F1-B57A823E0092|Nivel', NULL, 1, CAST(N'2024-03-12T15:37:27.070' AS DateTime), CAST(N'2024-03-12T15:37:27.070' AS DateTime), CAST(N'2024-03-12T15:37:27.070' AS DateTime))
GO
INSERT [dbo].[RedSocial] ([idRed], [descripcion], [imagen], [estado], [fechaPublicacion], [fechaCreacion], [fechaModificacion]) VALUES (N'e5f77228-8572-493d-922f-647a3c500522', N'AB37197C-BF33-44B8-BA5D-E246FA250B41|ha obtenido la medalla:|2EB8768C-F1AE-49BE-83E0-B04C39EB64C2|Medalla', NULL, 1, CAST(N'2024-05-30T15:04:43.573' AS DateTime), CAST(N'2024-05-30T15:04:43.573' AS DateTime), CAST(N'2024-05-30T15:04:43.573' AS DateTime))
GO
INSERT [dbo].[RedSocial] ([idRed], [descripcion], [imagen], [estado], [fechaPublicacion], [fechaCreacion], [fechaModificacion]) VALUES (N'9c19031f-42f7-47a8-bdb4-742654a569ef', N'96A49AC1-C9C4-4BC1-8D3C-548F37F34828|ha obtenido la medalla:|2EB8768C-F1AE-49BE-83E0-B04C39EB64C2|Medalla', NULL, 1, CAST(N'2024-07-03T12:00:20.570' AS DateTime), CAST(N'2024-07-03T12:00:20.573' AS DateTime), CAST(N'2024-07-03T12:00:20.573' AS DateTime))
GO
INSERT [dbo].[RedSocial] ([idRed], [descripcion], [imagen], [estado], [fechaPublicacion], [fechaCreacion], [fechaModificacion]) VALUES (N'27550f53-035b-4d16-a85d-749bc7810d76', N'AB37197C-BF33-44B8-BA5D-E246FA250B41|ha conseguido una recompensa,|91F482C6-59A5-450F-A09A-9C745B861339|Recompensa', N'entradas-cine.jpg', 1, CAST(N'2024-04-17T12:49:24.170' AS DateTime), CAST(N'2024-04-17T12:49:24.170' AS DateTime), CAST(N'2024-04-17T12:49:24.170' AS DateTime))
GO
INSERT [dbo].[RedSocial] ([idRed], [descripcion], [imagen], [estado], [fechaPublicacion], [fechaCreacion], [fechaModificacion]) VALUES (N'0e93b64e-60c6-4485-b989-825c33becf52', N'96A49AC1-C9C4-4BC1-8D3C-548F37F34828|ha alcanzado el nivel:|CF68ECD4-FE5C-4E11-9AAB-69514424FD1B|Nivel', NULL, 1, CAST(N'2024-07-03T12:01:07.730' AS DateTime), CAST(N'2024-07-03T12:01:07.730' AS DateTime), CAST(N'2024-07-03T12:01:07.730' AS DateTime))
GO
INSERT [dbo].[RedSocial] ([idRed], [descripcion], [imagen], [estado], [fechaPublicacion], [fechaCreacion], [fechaModificacion]) VALUES (N'e43b6f9f-bd81-40cc-8219-87139b1821e5', N'AB37197C-BF33-44B8-BA5D-E246FA250B41|ha conseguido una recompensa,|91F482C6-59A5-450F-A09A-9C745B861339|Recompensa', N'entradas-cine.jpg', 1, CAST(N'2024-04-17T12:49:50.857' AS DateTime), CAST(N'2024-04-17T12:49:50.857' AS DateTime), CAST(N'2024-04-17T12:49:50.857' AS DateTime))
GO
INSERT [dbo].[RedSocial] ([idRed], [descripcion], [imagen], [estado], [fechaPublicacion], [fechaCreacion], [fechaModificacion]) VALUES (N'd762a064-09f2-42db-b888-891caa062732', N'AB37197C-BF33-44B8-BA5D-E246FA250B41|ha obtenido la medalla:|54C00FB9-E9D1-491C-B3BB-D9FD6307D508|Medalla', NULL, 1, CAST(N'2024-05-30T15:04:43.570' AS DateTime), CAST(N'2024-05-30T15:04:43.570' AS DateTime), CAST(N'2024-05-30T15:04:43.570' AS DateTime))
GO
INSERT [dbo].[RedSocial] ([idRed], [descripcion], [imagen], [estado], [fechaPublicacion], [fechaCreacion], [fechaModificacion]) VALUES (N'3b577482-ce3d-4c04-b6d3-8cd4288258b2', N'AB37197C-BF33-44B8-BA5D-E246FA250B41|ha conseguido una recompensa,|91F482C6-59A5-450F-A09A-9C745B861339|Recompensa', N'entradas-cine.jpg', 1, CAST(N'2024-04-17T12:52:20.450' AS DateTime), CAST(N'2024-04-17T12:52:20.450' AS DateTime), CAST(N'2024-04-17T12:52:20.450' AS DateTime))
GO
INSERT [dbo].[RedSocial] ([idRed], [descripcion], [imagen], [estado], [fechaPublicacion], [fechaCreacion], [fechaModificacion]) VALUES (N'043a8d5f-a69e-4137-ac1f-96dab255f33d', N'F42329D1-EDAA-4F2C-9AE1-8F026C92C842|ha alcanzado el|4544D5A7-2E3B-49D5-8DF6-145CEE2A7698|Nivel', N'nivel1.png', 1, CAST(N'2024-03-14T09:10:39.090' AS DateTime), CAST(N'2024-03-14T09:10:39.090' AS DateTime), CAST(N'2024-03-14T09:10:39.090' AS DateTime))
GO
INSERT [dbo].[RedSocial] ([idRed], [descripcion], [imagen], [estado], [fechaPublicacion], [fechaCreacion], [fechaModificacion]) VALUES (N'd9fcd613-0507-449d-827f-97b70cfebf85', N'AB37197C-BF33-44B8-BA5D-E246FA250B41|ha conseguido una recompensa,|91F482C6-59A5-450F-A09A-9C745B861339|Recompensa', N'entradas-cine.jpg', 1, CAST(N'2024-04-17T13:05:57.350' AS DateTime), CAST(N'2024-04-17T13:05:57.350' AS DateTime), CAST(N'2024-04-17T13:05:57.350' AS DateTime))
GO
INSERT [dbo].[RedSocial] ([idRed], [descripcion], [imagen], [estado], [fechaPublicacion], [fechaCreacion], [fechaModificacion]) VALUES (N'343f8650-7e30-4d94-a729-9986a2c4cdc5', N'AB37197C-BF33-44B8-BA5D-E246FA250B41|ha conseguido una recompensa,|91F482C6-59A5-450F-A09A-9C745B861339|Recompensa', N'entradas-cine.jpg', 1, CAST(N'2024-04-17T16:08:33.530' AS DateTime), CAST(N'2024-04-17T16:08:33.530' AS DateTime), CAST(N'2024-04-17T16:08:33.530' AS DateTime))
GO
INSERT [dbo].[RedSocial] ([idRed], [descripcion], [imagen], [estado], [fechaPublicacion], [fechaCreacion], [fechaModificacion]) VALUES (N'dad5ffe9-a8ce-4d00-bf12-9faf4f30204f', N'F42329D1-EDAA-4F2C-9AE1-8F026C92C842|ha conseguido la medalla, |2EB8768C-F1AE-49BE-83E0-B04C39EB64C2|Medalla', NULL, 1, CAST(N'2024-03-14T09:21:25.757' AS DateTime), CAST(N'2024-03-14T09:21:25.760' AS DateTime), CAST(N'2024-03-14T09:21:25.760' AS DateTime))
GO
INSERT [dbo].[RedSocial] ([idRed], [descripcion], [imagen], [estado], [fechaPublicacion], [fechaCreacion], [fechaModificacion]) VALUES (N'd44d6c45-9000-4820-ae93-aba37554ecbf', N'6D3A6B25-C6C7-4ED4-A5E9-D992B1CC98A7|ha alcanzado el nivel:|CF68ECD4-FE5C-4E11-9AAB-69514424FD1B|Nivel', NULL, 1, CAST(N'2024-05-13T16:33:34.573' AS DateTime), CAST(N'2024-05-13T16:33:34.573' AS DateTime), CAST(N'2024-05-13T16:33:34.573' AS DateTime))
GO
INSERT [dbo].[RedSocial] ([idRed], [descripcion], [imagen], [estado], [fechaPublicacion], [fechaCreacion], [fechaModificacion]) VALUES (N'a1c36622-c5c9-4acc-9a01-afda3187db82', N'91DB7BAE-7D2F-423D-B595-D227C63CA0A6|ha alcanzado el|1E7E4DD1-22B4-49B6-AAA9-705D0E49A7E5|Nivel', N'nivel4.png', 1, CAST(N'2024-03-12T15:13:27.803' AS DateTime), CAST(N'2024-03-12T15:13:27.803' AS DateTime), CAST(N'2024-03-12T15:13:27.803' AS DateTime))
GO
INSERT [dbo].[RedSocial] ([idRed], [descripcion], [imagen], [estado], [fechaPublicacion], [fechaCreacion], [fechaModificacion]) VALUES (N'92887343-0e10-494d-89b0-b1b363c7e20a', N'AB37197C-BF33-44B8-BA5D-E246FA250B41|ha conseguido una recompensa,|91F482C6-59A5-450F-A09A-9C745B861339|Recompensa', N'entradas-cine.jpg', 1, CAST(N'2024-04-17T12:48:51.900' AS DateTime), CAST(N'2024-04-17T12:48:51.900' AS DateTime), CAST(N'2024-04-17T12:48:51.900' AS DateTime))
GO
INSERT [dbo].[RedSocial] ([idRed], [descripcion], [imagen], [estado], [fechaPublicacion], [fechaCreacion], [fechaModificacion]) VALUES (N'46f01d50-f16a-4e50-9da8-b386f6828a89', N'91331754-1E83-417F-90E7-0E596E996510|ha alcanzado el|5690C0BA-70E1-4F3D-A0E2-2AB787446F37|Nivel', N'nivel1.png', 1, CAST(N'2024-03-11T00:00:00.000' AS DateTime), CAST(N'2024-03-11T15:48:42.310' AS DateTime), CAST(N'2024-03-11T15:48:42.310' AS DateTime))
GO
INSERT [dbo].[RedSocial] ([idRed], [descripcion], [imagen], [estado], [fechaPublicacion], [fechaCreacion], [fechaModificacion]) VALUES (N'cc7e1f0e-71bb-4847-b520-bbf74f6edde7', N'015E40DD-58CE-401E-A0A9-075874BC0B68|ha alcanzado el nivel:|A3AE5C3C-1D90-4306-882D-A092EDBD82EF|Nivel', NULL, 1, CAST(N'2024-06-11T09:33:23.210' AS DateTime), CAST(N'2024-06-11T09:33:23.210' AS DateTime), CAST(N'2024-06-11T09:33:23.210' AS DateTime))
GO
INSERT [dbo].[RedSocial] ([idRed], [descripcion], [imagen], [estado], [fechaPublicacion], [fechaCreacion], [fechaModificacion]) VALUES (N'66cba61d-de2f-4957-be99-c07a403d349d', N'DE632913-94CF-4AB1-8350-AA4C9C0B0B52|ha canjeado la recompensa:|91F482C6-59A5-450F-A09A-9C745B861339|Recompensa', N'entradas-cine.jpg', 1, CAST(N'2024-06-19T10:48:07.997' AS DateTime), CAST(N'2024-06-19T10:48:08.000' AS DateTime), CAST(N'2024-06-19T10:48:08.000' AS DateTime))
GO
INSERT [dbo].[RedSocial] ([idRed], [descripcion], [imagen], [estado], [fechaPublicacion], [fechaCreacion], [fechaModificacion]) VALUES (N'a09f894b-e580-42cf-b25e-c85bf8b0b002', N'015E40DD-58CE-401E-A0A9-075874BC0B68|ha obtenido la medalla:|2EB8768C-F1AE-49BE-83E0-B04C39EB64C2|Medalla', NULL, 1, CAST(N'2024-05-31T15:33:00.457' AS DateTime), CAST(N'2024-05-31T15:33:00.457' AS DateTime), CAST(N'2024-05-31T15:33:00.457' AS DateTime))
GO
INSERT [dbo].[RedSocial] ([idRed], [descripcion], [imagen], [estado], [fechaPublicacion], [fechaCreacion], [fechaModificacion]) VALUES (N'7a3a2037-49ec-43cc-ae03-c913f92c50e4', N'AB37197C-BF33-44B8-BA5D-E246FA250B41|ha canjeado la recompensa:|40853D25-1A7A-416A-A9CA-32C3F2C53814|Recompensa', NULL, 1, CAST(N'2024-04-23T12:36:45.357' AS DateTime), CAST(N'2024-04-23T12:36:45.357' AS DateTime), CAST(N'2024-04-23T12:36:45.357' AS DateTime))
GO
INSERT [dbo].[RedSocial] ([idRed], [descripcion], [imagen], [estado], [fechaPublicacion], [fechaCreacion], [fechaModificacion]) VALUES (N'e00700b5-fa04-46fc-be0b-d32801b1ef51', N'015E40DD-58CE-401E-A0A9-075874BC0B68|ha obtenido la medalla:|54C00FB9-E9D1-491C-B3BB-D9FD6307D508|Medalla', NULL, 1, CAST(N'2024-06-14T16:13:39.310' AS DateTime), CAST(N'2024-06-14T16:13:39.310' AS DateTime), CAST(N'2024-06-14T16:13:39.310' AS DateTime))
GO
INSERT [dbo].[RedSocial] ([idRed], [descripcion], [imagen], [estado], [fechaPublicacion], [fechaCreacion], [fechaModificacion]) VALUES (N'd42358c4-9253-4fcf-8190-dba1ec8b7ca4', N'AB37197C-BF33-44B8-BA5D-E246FA250B41|ha canjeado la recompensa:|40853D25-1A7A-416A-A9CA-32C3F2C53814|Recompensa', NULL, 1, CAST(N'2024-04-23T14:58:35.780' AS DateTime), CAST(N'2024-04-23T14:58:35.780' AS DateTime), CAST(N'2024-04-23T14:58:35.780' AS DateTime))
GO
INSERT [dbo].[RedSocial] ([idRed], [descripcion], [imagen], [estado], [fechaPublicacion], [fechaCreacion], [fechaModificacion]) VALUES (N'fbea73a2-f19e-4e58-96e9-e07e0903ed6c', N'96A49AC1-C9C4-4BC1-8D3C-548F37F34828|ha canjeado la recompensa:|2517E519-ACF6-42D4-90A7-DF589BFF4987|Recompensa', N'apple watch series 9.PNG', 1, CAST(N'2024-07-03T12:18:20.917' AS DateTime), CAST(N'2024-07-03T12:18:20.920' AS DateTime), CAST(N'2024-07-03T12:18:20.920' AS DateTime))
GO
INSERT [dbo].[RedSocial] ([idRed], [descripcion], [imagen], [estado], [fechaPublicacion], [fechaCreacion], [fechaModificacion]) VALUES (N'47bf5792-021c-4ba1-b51a-e115f3ff516d', N'AB37197C-BF33-44B8-BA5D-E246FA250B41|ha conseguido una recompensa,|91F482C6-59A5-450F-A09A-9C745B861339|Recompensa', N'entradas-cine.jpg', 1, CAST(N'2024-04-17T12:28:45.223' AS DateTime), CAST(N'2024-04-17T12:28:45.227' AS DateTime), CAST(N'2024-04-17T12:28:45.227' AS DateTime))
GO
INSERT [dbo].[RedSocial] ([idRed], [descripcion], [imagen], [estado], [fechaPublicacion], [fechaCreacion], [fechaModificacion]) VALUES (N'9f8ea6aa-1f62-499f-a260-e19c34f5476c', N'AB37197C-BF33-44B8-BA5D-E246FA250B41|ha conseguido una recompensa,|91F482C6-59A5-450F-A09A-9C745B861339|Recompensa', N'entradas-cine.jpg', 1, CAST(N'2024-04-17T17:44:05.903' AS DateTime), CAST(N'2024-04-17T17:44:05.903' AS DateTime), CAST(N'2024-04-17T17:44:05.903' AS DateTime))
GO
INSERT [dbo].[RedSocial] ([idRed], [descripcion], [imagen], [estado], [fechaPublicacion], [fechaCreacion], [fechaModificacion]) VALUES (N'e5cbf23b-d3c8-4d14-a8b5-e40e9744de7c', N'DE632913-94CF-4AB1-8350-AA4C9C0B0B52|ha obtenido la medalla:|2EB8768C-F1AE-49BE-83E0-B04C39EB64C2|Medalla', NULL, 1, CAST(N'2024-06-19T09:37:26.833' AS DateTime), CAST(N'2024-06-19T09:37:26.833' AS DateTime), CAST(N'2024-06-19T09:37:26.833' AS DateTime))
GO
INSERT [dbo].[RedSocial] ([idRed], [descripcion], [imagen], [estado], [fechaPublicacion], [fechaCreacion], [fechaModificacion]) VALUES (N'c2f763c8-19c4-4b12-9e4c-e72a3244c454', N'6D81E350-A4F4-4042-A3E9-EF97D985BC2A|ha obtenido la medalla:|2EB8768C-F1AE-49BE-83E0-B04C39EB64C2|Medalla', NULL, 1, CAST(N'2024-06-25T10:17:39.903' AS DateTime), CAST(N'2024-06-25T10:17:39.903' AS DateTime), CAST(N'2024-06-25T10:17:39.903' AS DateTime))
GO
INSERT [dbo].[RedSocial] ([idRed], [descripcion], [imagen], [estado], [fechaPublicacion], [fechaCreacion], [fechaModificacion]) VALUES (N'0c18c23b-6f9e-47f4-bbb0-ea7be6a9fc6b', N'AB37197C-BF33-44B8-BA5D-E246FA250B41|ha alcanzado el nivel:|4544D5A7-2E3B-49D5-8DF6-145CEE2A7698|Nivel', N'nivel1.png', 1, CAST(N'2024-05-30T15:05:29.683' AS DateTime), CAST(N'2024-05-30T15:05:29.683' AS DateTime), CAST(N'2024-05-30T15:05:29.683' AS DateTime))
GO
INSERT [dbo].[RedSocial] ([idRed], [descripcion], [imagen], [estado], [fechaPublicacion], [fechaCreacion], [fechaModificacion]) VALUES (N'01563bd9-3cbe-4c21-8ce9-f4e504191f1d', N'DE632913-94CF-4AB1-8350-AA4C9C0B0B52|ha obtenido la medalla:|54C00FB9-E9D1-491C-B3BB-D9FD6307D508|Medalla', NULL, 1, CAST(N'2024-06-19T11:26:23.267' AS DateTime), CAST(N'2024-06-19T11:26:23.270' AS DateTime), CAST(N'2024-06-19T11:26:23.270' AS DateTime))
GO
INSERT [dbo].[Reto] ([idReto], [nombre], [fechaApetura], [fechaCierre], [estado], [vidas], [tiempo_ms], [puntosRecompensa], [creditosObtenidos], [instrucciones], [imagen], [idTipoReto], [idComportamiento], [fechaCreacion], [fechaModificacion], [criterioMinimo], [enEquipo], [idTipoEncuesta], [opsRequeridas], [items], [idTipoValidador], [idTipoArchivo]) VALUES (N'ef9c1644-f977-43e0-b47c-06699fc22d5d', N'Trivia individual', CAST(N'2024-07-02T00:00:00.000' AS DateTime), CAST(N'2024-07-05T00:00:00.000' AS DateTime), 1, 3, 300000, 4, 4, NULL, NULL, N'63aa060b-cde4-49c0-9d60-aaf069df1533', N'1dd28d88-34c7-4394-ab3d-525726001730', CAST(N'2024-07-03T12:22:08.880' AS DateTime), CAST(N'2024-07-03T12:24:00.567' AS DateTime), 50, 0, N'07bc09c6-34b8-4493-8026-a5c818f7bec4', 0, -1, N'706ac44f-fa65-459d-9f50-0ebcd59426e3', N'f831b56f-c313-407d-8b88-ff3c8bbceb5c')
GO
INSERT [dbo].[Reto] ([idReto], [nombre], [fechaApetura], [fechaCierre], [estado], [vidas], [tiempo_ms], [puntosRecompensa], [creditosObtenidos], [instrucciones], [imagen], [idTipoReto], [idComportamiento], [fechaCreacion], [fechaModificacion], [criterioMinimo], [enEquipo], [idTipoEncuesta], [opsRequeridas], [items], [idTipoValidador], [idTipoArchivo]) VALUES (N'a2c5de8f-b48a-49d3-ad4d-06a664b321d3', N'Mi última prueba de recoleccio', CAST(N'1800-01-01T00:00:00.000' AS DateTime), CAST(N'1800-01-01T00:00:00.000' AS DateTime), 1, 0, 0, 3, 2, NULL, NULL, N'bb0bdda2-05d0-42c6-b3bc-b32b99de18ef', N'cce31bb2-f39c-4328-823b-ef32e5bd8ca1', CAST(N'2024-05-28T14:42:00.323' AS DateTime), CAST(N'2024-05-28T14:43:45.550' AS DateTime), 0, 0, N'07bc09c6-34b8-4493-8026-a5c818f7bec4', 1, 2, N'ed15d366-e0ea-4d90-a5df-a4aed453d1fe', N'7e6182bb-635f-40bc-9602-27e368c6c905')
GO
INSERT [dbo].[Reto] ([idReto], [nombre], [fechaApetura], [fechaCierre], [estado], [vidas], [tiempo_ms], [puntosRecompensa], [creditosObtenidos], [instrucciones], [imagen], [idTipoReto], [idComportamiento], [fechaCreacion], [fechaModificacion], [criterioMinimo], [enEquipo], [idTipoEncuesta], [opsRequeridas], [items], [idTipoValidador], [idTipoArchivo]) VALUES (N'c214ab54-5ed2-4f61-a075-2196497bab4b', N'Videos de bunny', CAST(N'1800-01-01T00:00:00.000' AS DateTime), CAST(N'1800-01-01T00:00:00.000' AS DateTime), 1, 0, 0, 2, 3, NULL, NULL, N'bb0bdda2-05d0-42c6-b3bc-b32b99de18ef', N'cce31bb2-f39c-4328-823b-ef32e5bd8ca1', CAST(N'2024-06-17T10:44:56.940' AS DateTime), CAST(N'2024-06-17T10:45:16.413' AS DateTime), 0, 0, N'07bc09c6-34b8-4493-8026-a5c818f7bec4', 1, 2, N'ed15d366-e0ea-4d90-a5df-a4aed453d1fe', N'92f39ef6-109b-40a8-b46c-c388ff97acff')
GO
INSERT [dbo].[Reto] ([idReto], [nombre], [fechaApetura], [fechaCierre], [estado], [vidas], [tiempo_ms], [puntosRecompensa], [creditosObtenidos], [instrucciones], [imagen], [idTipoReto], [idComportamiento], [fechaCreacion], [fechaModificacion], [criterioMinimo], [enEquipo], [idTipoEncuesta], [opsRequeridas], [items], [idTipoValidador], [idTipoArchivo]) VALUES (N'701e4b94-1e54-4de4-9128-239ded5eaa06', N'encuesta voto', CAST(N'1800-01-01T00:00:00.000' AS DateTime), CAST(N'1800-01-01T00:00:00.000' AS DateTime), 1, 0, 0, 3, 0, NULL, NULL, N'58ad5fb5-7259-47f1-b10b-2258107eb263', N'cce31bb2-f39c-4328-823b-ef32e5bd8ca1', CAST(N'2024-05-14T17:01:51.927' AS DateTime), CAST(N'2024-05-17T12:06:29.127' AS DateTime), 0, 0, N'f0809fc0-1ef7-4a03-b621-821468c39159', 1, -1, N'706ac44f-fa65-459d-9f50-0ebcd59426e3', N'f831b56f-c313-407d-8b88-ff3c8bbceb5c')
GO
INSERT [dbo].[Reto] ([idReto], [nombre], [fechaApetura], [fechaCierre], [estado], [vidas], [tiempo_ms], [puntosRecompensa], [creditosObtenidos], [instrucciones], [imagen], [idTipoReto], [idComportamiento], [fechaCreacion], [fechaModificacion], [criterioMinimo], [enEquipo], [idTipoEncuesta], [opsRequeridas], [items], [idTipoValidador], [idTipoArchivo]) VALUES (N'7eae11eb-d3b7-4b4f-90c1-287373c64e57', N'Reto trivia indv', CAST(N'2024-06-17T00:00:00.000' AS DateTime), CAST(N'2024-06-20T00:00:00.000' AS DateTime), 1, 3, 600000, 5, 1, N'Instrucciones: contesta preguntas', NULL, N'63aa060b-cde4-49c0-9d60-aaf069df1533', N'1dd28d88-34c7-4394-ab3d-525726001730', CAST(N'2024-06-18T16:29:49.420' AS DateTime), CAST(N'2024-06-18T16:42:11.460' AS DateTime), 50, 0, N'07bc09c6-34b8-4493-8026-a5c818f7bec4', 0, -1, N'706ac44f-fa65-459d-9f50-0ebcd59426e3', N'f831b56f-c313-407d-8b88-ff3c8bbceb5c')
GO
INSERT [dbo].[Reto] ([idReto], [nombre], [fechaApetura], [fechaCierre], [estado], [vidas], [tiempo_ms], [puntosRecompensa], [creditosObtenidos], [instrucciones], [imagen], [idTipoReto], [idComportamiento], [fechaCreacion], [fechaModificacion], [criterioMinimo], [enEquipo], [idTipoEncuesta], [opsRequeridas], [items], [idTipoValidador], [idTipoArchivo]) VALUES (N'60713ad9-036a-4f46-8b18-30b37fa1a1c2', N'Seguimiento o evaluacion grupal', CAST(N'1800-01-01T00:00:00.000' AS DateTime), CAST(N'1800-01-01T00:00:00.000' AS DateTime), 1, 0, 0, 30, 30, NULL, NULL, N'a79c76bf-4240-4b3b-83b9-5689055a8b85', N'cce31bb2-f39c-4328-823b-ef32e5bd8ca1', CAST(N'2024-06-19T11:58:33.117' AS DateTime), CAST(N'2024-06-19T12:02:48.040' AS DateTime), 0, 1, N'07bc09c6-34b8-4493-8026-a5c818f7bec4', 1, -1, N'706ac44f-fa65-459d-9f50-0ebcd59426e3', N'f831b56f-c313-407d-8b88-ff3c8bbceb5c')
GO
INSERT [dbo].[Reto] ([idReto], [nombre], [fechaApetura], [fechaCierre], [estado], [vidas], [tiempo_ms], [puntosRecompensa], [creditosObtenidos], [instrucciones], [imagen], [idTipoReto], [idComportamiento], [fechaCreacion], [fechaModificacion], [criterioMinimo], [enEquipo], [idTipoEncuesta], [opsRequeridas], [items], [idTipoValidador], [idTipoArchivo]) VALUES (N'f66e11b2-6d7e-413b-a7ce-3a1dc068cb67', N'Encuesta grupal 3', CAST(N'2024-07-02T00:00:00.000' AS DateTime), CAST(N'2024-07-05T00:00:00.000' AS DateTime), 1, 0, 0, 25, 25, NULL, NULL, N'58ad5fb5-7259-47f1-b10b-2258107eb263', N'cce31bb2-f39c-4328-823b-ef32e5bd8ca1', CAST(N'2024-07-03T14:42:26.173' AS DateTime), CAST(N'2024-07-03T14:44:15.590' AS DateTime), 0, 1, N'b0c024b5-d503-44c4-802e-2a36580f13fc', 1, -1, N'706ac44f-fa65-459d-9f50-0ebcd59426e3', N'f831b56f-c313-407d-8b88-ff3c8bbceb5c')
GO
INSERT [dbo].[Reto] ([idReto], [nombre], [fechaApetura], [fechaCierre], [estado], [vidas], [tiempo_ms], [puntosRecompensa], [creditosObtenidos], [instrucciones], [imagen], [idTipoReto], [idComportamiento], [fechaCreacion], [fechaModificacion], [criterioMinimo], [enEquipo], [idTipoEncuesta], [opsRequeridas], [items], [idTipoValidador], [idTipoArchivo]) VALUES (N'2252397c-b7d9-42b4-b171-3a6eda0afaec', N'Trivia grupal', CAST(N'1800-01-01T00:00:00.000' AS DateTime), CAST(N'1800-01-01T00:00:00.000' AS DateTime), 1, 3, 300000, 25, 25, NULL, NULL, N'63aa060b-cde4-49c0-9d60-aaf069df1533', N'1dd28d88-34c7-4394-ab3d-525726001730', CAST(N'2024-06-19T11:41:05.183' AS DateTime), CAST(N'2024-06-19T11:47:09.747' AS DateTime), 50, 1, N'07bc09c6-34b8-4493-8026-a5c818f7bec4', 0, -1, N'706ac44f-fa65-459d-9f50-0ebcd59426e3', N'f831b56f-c313-407d-8b88-ff3c8bbceb5c')
GO
INSERT [dbo].[Reto] ([idReto], [nombre], [fechaApetura], [fechaCierre], [estado], [vidas], [tiempo_ms], [puntosRecompensa], [creditosObtenidos], [instrucciones], [imagen], [idTipoReto], [idComportamiento], [fechaCreacion], [fechaModificacion], [criterioMinimo], [enEquipo], [idTipoEncuesta], [opsRequeridas], [items], [idTipoValidador], [idTipoArchivo]) VALUES (N'66db6640-2b72-43cc-971e-3d0822429acb', N'Recoleccion de imagenes', CAST(N'1800-01-01T00:00:00.000' AS DateTime), CAST(N'1800-01-01T00:00:00.000' AS DateTime), 1, 0, 0, 2, 3, NULL, NULL, N'bb0bdda2-05d0-42c6-b3bc-b32b99de18ef', N'cce31bb2-f39c-4328-823b-ef32e5bd8ca1', CAST(N'2024-05-30T15:53:34.177' AS DateTime), CAST(N'2024-05-30T15:55:20.317' AS DateTime), 0, 0, N'07bc09c6-34b8-4493-8026-a5c818f7bec4', 1, 3, N'ed15d366-e0ea-4d90-a5df-a4aed453d1fe', N'eade463d-e49c-4b6a-bb40-239e9ae7b072')
GO
INSERT [dbo].[Reto] ([idReto], [nombre], [fechaApetura], [fechaCierre], [estado], [vidas], [tiempo_ms], [puntosRecompensa], [creditosObtenidos], [instrucciones], [imagen], [idTipoReto], [idComportamiento], [fechaCreacion], [fechaModificacion], [criterioMinimo], [enEquipo], [idTipoEncuesta], [opsRequeridas], [items], [idTipoValidador], [idTipoArchivo]) VALUES (N'1895c363-0443-4e24-b55d-3f410c435d23', N'Mi reto de recolección', CAST(N'1800-01-01T00:00:00.000' AS DateTime), CAST(N'1800-01-01T00:00:00.000' AS DateTime), 1, 0, 0, 23, 3, NULL, NULL, N'bb0bdda2-05d0-42c6-b3bc-b32b99de18ef', N'cce31bb2-f39c-4328-823b-ef32e5bd8ca1', CAST(N'2024-05-24T11:26:29.970' AS DateTime), CAST(N'2024-05-25T12:46:00.567' AS DateTime), 0, 0, N'07bc09c6-34b8-4493-8026-a5c818f7bec4', 1, 3, N'ed15d366-e0ea-4d90-a5df-a4aed453d1fe', N'7e6182bb-635f-40bc-9602-27e368c6c905')
GO
INSERT [dbo].[Reto] ([idReto], [nombre], [fechaApetura], [fechaCierre], [estado], [vidas], [tiempo_ms], [puntosRecompensa], [creditosObtenidos], [instrucciones], [imagen], [idTipoReto], [idComportamiento], [fechaCreacion], [fechaModificacion], [criterioMinimo], [enEquipo], [idTipoEncuesta], [opsRequeridas], [items], [idTipoValidador], [idTipoArchivo]) VALUES (N'ddf75d8b-e869-4c4b-8a47-547e77e7f632', N'Recolección de archivos de prueba', CAST(N'1800-01-01T00:00:00.000' AS DateTime), CAST(N'1800-01-01T00:00:00.000' AS DateTime), 1, 0, 0, 3, 2, NULL, NULL, N'bb0bdda2-05d0-42c6-b3bc-b32b99de18ef', N'cce31bb2-f39c-4328-823b-ef32e5bd8ca1', CAST(N'2024-06-10T09:16:43.857' AS DateTime), CAST(N'2024-06-10T09:20:28.587' AS DateTime), 0, 0, N'07bc09c6-34b8-4493-8026-a5c818f7bec4', 1, 5, N'ed15d366-e0ea-4d90-a5df-a4aed453d1fe', N'7e6182bb-635f-40bc-9602-27e368c6c905')
GO
INSERT [dbo].[Reto] ([idReto], [nombre], [fechaApetura], [fechaCierre], [estado], [vidas], [tiempo_ms], [puntosRecompensa], [creditosObtenidos], [instrucciones], [imagen], [idTipoReto], [idComportamiento], [fechaCreacion], [fechaModificacion], [criterioMinimo], [enEquipo], [idTipoEncuesta], [opsRequeridas], [items], [idTipoValidador], [idTipoArchivo]) VALUES (N'd1debca6-ec0a-446a-abd9-5d5b4b2d6a79', N'Mi segmantacion', CAST(N'1800-01-01T00:00:00.000' AS DateTime), CAST(N'1800-01-01T00:00:00.000' AS DateTime), 0, 0, 0, 3, 0, NULL, NULL, N'a79c76bf-4240-4b3b-83b9-5689055a8b85', N'cce31bb2-f39c-4328-823b-ef32e5bd8ca1', CAST(N'2024-05-14T12:24:27.203' AS DateTime), CAST(N'2024-05-14T12:25:40.970' AS DateTime), 0, 0, N'07bc09c6-34b8-4493-8026-a5c818f7bec4', 1, -1, N'706ac44f-fa65-459d-9f50-0ebcd59426e3', N'f831b56f-c313-407d-8b88-ff3c8bbceb5c')
GO
INSERT [dbo].[Reto] ([idReto], [nombre], [fechaApetura], [fechaCierre], [estado], [vidas], [tiempo_ms], [puntosRecompensa], [creditosObtenidos], [instrucciones], [imagen], [idTipoReto], [idComportamiento], [fechaCreacion], [fechaModificacion], [criterioMinimo], [enEquipo], [idTipoEncuesta], [opsRequeridas], [items], [idTipoValidador], [idTipoArchivo]) VALUES (N'cd41e229-0277-47e5-ac61-5e4399db5183', N'Recolección individual', CAST(N'1800-01-01T00:00:00.000' AS DateTime), CAST(N'1800-01-01T00:00:00.000' AS DateTime), 1, 0, 0, 20, 20, NULL, NULL, N'bb0bdda2-05d0-42c6-b3bc-b32b99de18ef', N'cce31bb2-f39c-4328-823b-ef32e5bd8ca1', CAST(N'2024-06-19T09:26:13.770' AS DateTime), CAST(N'2024-06-19T09:29:06.177' AS DateTime), 0, 0, N'07bc09c6-34b8-4493-8026-a5c818f7bec4', 1, 5, N'ed15d366-e0ea-4d90-a5df-a4aed453d1fe', N'0208d97e-eda7-4dce-baef-629e22549a54')
GO
INSERT [dbo].[Reto] ([idReto], [nombre], [fechaApetura], [fechaCierre], [estado], [vidas], [tiempo_ms], [puntosRecompensa], [creditosObtenidos], [instrucciones], [imagen], [idTipoReto], [idComportamiento], [fechaCreacion], [fechaModificacion], [criterioMinimo], [enEquipo], [idTipoEncuesta], [opsRequeridas], [items], [idTipoValidador], [idTipoArchivo]) VALUES (N'9f339f9d-c782-475d-9ce6-5f70058f4ab3', N'recolectar grupal 3', CAST(N'2024-07-01T00:00:00.000' AS DateTime), CAST(N'2024-07-05T00:00:00.000' AS DateTime), 1, 0, 0, 25, 25, NULL, NULL, N'bb0bdda2-05d0-42c6-b3bc-b32b99de18ef', N'cce31bb2-f39c-4328-823b-ef32e5bd8ca1', CAST(N'2024-07-03T14:47:02.687' AS DateTime), CAST(N'2024-07-03T14:47:31.967' AS DateTime), 0, 1, N'07bc09c6-34b8-4493-8026-a5c818f7bec4', 1, 25, N'ed15d366-e0ea-4d90-a5df-a4aed453d1fe', N'0208d97e-eda7-4dce-baef-629e22549a54')
GO
INSERT [dbo].[Reto] ([idReto], [nombre], [fechaApetura], [fechaCierre], [estado], [vidas], [tiempo_ms], [puntosRecompensa], [creditosObtenidos], [instrucciones], [imagen], [idTipoReto], [idComportamiento], [fechaCreacion], [fechaModificacion], [criterioMinimo], [enEquipo], [idTipoEncuesta], [opsRequeridas], [items], [idTipoValidador], [idTipoArchivo]) VALUES (N'428164a1-24f7-4c0c-8a6c-6278c23bffb5', N'mi Encuesta 2', CAST(N'1800-01-01T00:00:00.000' AS DateTime), CAST(N'1800-01-01T00:00:00.000' AS DateTime), 1, 0, 0, 3, 0, NULL, NULL, N'58ad5fb5-7259-47f1-b10b-2258107eb263', N'1dd28d88-34c7-4394-ab3d-525726001730', CAST(N'2024-05-08T15:57:23.250' AS DateTime), CAST(N'2024-05-13T15:25:47.650' AS DateTime), 0, 0, N'b0c024b5-d503-44c4-802e-2a36580f13fc', 1, -1, N'706ac44f-fa65-459d-9f50-0ebcd59426e3', N'f831b56f-c313-407d-8b88-ff3c8bbceb5c')
GO
INSERT [dbo].[Reto] ([idReto], [nombre], [fechaApetura], [fechaCierre], [estado], [vidas], [tiempo_ms], [puntosRecompensa], [creditosObtenidos], [instrucciones], [imagen], [idTipoReto], [idComportamiento], [fechaCreacion], [fechaModificacion], [criterioMinimo], [enEquipo], [idTipoEncuesta], [opsRequeridas], [items], [idTipoValidador], [idTipoArchivo]) VALUES (N'e83ae36c-fe6d-416c-bd0f-64581fe00881', N'nuevo comportamiento', CAST(N'1800-01-01T00:00:00.000' AS DateTime), CAST(N'1800-01-01T00:00:00.000' AS DateTime), 0, 0, 0, 5, 5, NULL, NULL, N'98d755b4-1160-4e17-9dc8-860587a4179a', N'cce31bb2-f39c-4328-823b-ef32e5bd8ca1', CAST(N'2024-05-31T15:46:40.347' AS DateTime), CAST(N'2024-05-31T15:46:40.347' AS DateTime), 0, 0, N'07bc09c6-34b8-4493-8026-a5c818f7bec4', 1, -1, N'ed15d366-e0ea-4d90-a5df-a4aed453d1fe', N'f831b56f-c313-407d-8b88-ff3c8bbceb5c')
GO
INSERT [dbo].[Reto] ([idReto], [nombre], [fechaApetura], [fechaCierre], [estado], [vidas], [tiempo_ms], [puntosRecompensa], [creditosObtenidos], [instrucciones], [imagen], [idTipoReto], [idComportamiento], [fechaCreacion], [fechaModificacion], [criterioMinimo], [enEquipo], [idTipoEncuesta], [opsRequeridas], [items], [idTipoValidador], [idTipoArchivo]) VALUES (N'27c5527f-3ea3-431b-bedf-65841eaf5663', N'mi segundo reto 25', CAST(N'1800-01-01T00:00:00.000' AS DateTime), CAST(N'1800-01-01T00:00:00.000' AS DateTime), 1, 0, 3600000, 11, 16, NULL, NULL, N'63aa060b-cde4-49c0-9d60-aaf069df1533', N'1dd28d88-34c7-4394-ab3d-525726001730', CAST(N'2024-02-27T12:45:15.930' AS DateTime), CAST(N'2024-04-12T09:20:45.530' AS DateTime), 40, 0, N'07bc09c6-34b8-4493-8026-a5c818f7bec4', 0, -1, N'706ac44f-fa65-459d-9f50-0ebcd59426e3', N'f831b56f-c313-407d-8b88-ff3c8bbceb5c')
GO
INSERT [dbo].[Reto] ([idReto], [nombre], [fechaApetura], [fechaCierre], [estado], [vidas], [tiempo_ms], [puntosRecompensa], [creditosObtenidos], [instrucciones], [imagen], [idTipoReto], [idComportamiento], [fechaCreacion], [fechaModificacion], [criterioMinimo], [enEquipo], [idTipoEncuesta], [opsRequeridas], [items], [idTipoValidador], [idTipoArchivo]) VALUES (N'63d7661c-366b-4134-9e94-6f72e3076c73', N'Mi nueva trivia de prueba', CAST(N'1800-01-01T00:00:00.000' AS DateTime), CAST(N'1800-01-01T00:00:00.000' AS DateTime), 0, 0, 300000, 3, 0, N'esta es para mi encuesta 1', NULL, N'63aa060b-cde4-49c0-9d60-aaf069df1533', N'cce31bb2-f39c-4328-823b-ef32e5bd8ca1', CAST(N'2024-05-02T11:27:40.953' AS DateTime), CAST(N'2024-05-17T10:10:32.303' AS DateTime), 50, 0, N'07bc09c6-34b8-4493-8026-a5c818f7bec4', 0, -1, N'706ac44f-fa65-459d-9f50-0ebcd59426e3', N'f831b56f-c313-407d-8b88-ff3c8bbceb5c')
GO
INSERT [dbo].[Reto] ([idReto], [nombre], [fechaApetura], [fechaCierre], [estado], [vidas], [tiempo_ms], [puntosRecompensa], [creditosObtenidos], [instrucciones], [imagen], [idTipoReto], [idComportamiento], [fechaCreacion], [fechaModificacion], [criterioMinimo], [enEquipo], [idTipoEncuesta], [opsRequeridas], [items], [idTipoValidador], [idTipoArchivo]) VALUES (N'd9ca3dcb-ee6a-4f35-ae4c-719843510a1a', N'mi segundo reto 24', CAST(N'2024-05-01T00:00:00.000' AS DateTime), CAST(N'2024-06-01T00:00:00.000' AS DateTime), 1, 3, 400002, 11, 16, NULL, NULL, N'63aa060b-cde4-49c0-9d60-aaf069df1533', N'1dd28d88-34c7-4394-ab3d-525726001730', CAST(N'2024-02-27T12:44:48.647' AS DateTime), CAST(N'2024-04-12T09:20:08.207' AS DateTime), 30, 1, N'07bc09c6-34b8-4493-8026-a5c818f7bec4', 0, -1, N'706ac44f-fa65-459d-9f50-0ebcd59426e3', N'f831b56f-c313-407d-8b88-ff3c8bbceb5c')
GO
INSERT [dbo].[Reto] ([idReto], [nombre], [fechaApetura], [fechaCierre], [estado], [vidas], [tiempo_ms], [puntosRecompensa], [creditosObtenidos], [instrucciones], [imagen], [idTipoReto], [idComportamiento], [fechaCreacion], [fechaModificacion], [criterioMinimo], [enEquipo], [idTipoEncuesta], [opsRequeridas], [items], [idTipoValidador], [idTipoArchivo]) VALUES (N'39d09ca3-ddbc-4ea2-a21e-7b982d3b7628', N'Comportamiento grupal', CAST(N'1800-01-01T00:00:00.000' AS DateTime), CAST(N'1800-01-01T00:00:00.000' AS DateTime), 1, 0, 0, 30, 30, NULL, NULL, N'98d755b4-1160-4e17-9dc8-860587a4179a', N'cce31bb2-f39c-4328-823b-ef32e5bd8ca1', CAST(N'2024-06-19T12:08:30.993' AS DateTime), CAST(N'2024-06-19T12:12:08.077' AS DateTime), 0, 1, N'07bc09c6-34b8-4493-8026-a5c818f7bec4', 1, -1, N'ed15d366-e0ea-4d90-a5df-a4aed453d1fe', N'f831b56f-c313-407d-8b88-ff3c8bbceb5c')
GO
INSERT [dbo].[Reto] ([idReto], [nombre], [fechaApetura], [fechaCierre], [estado], [vidas], [tiempo_ms], [puntosRecompensa], [creditosObtenidos], [instrucciones], [imagen], [idTipoReto], [idComportamiento], [fechaCreacion], [fechaModificacion], [criterioMinimo], [enEquipo], [idTipoEncuesta], [opsRequeridas], [items], [idTipoValidador], [idTipoArchivo]) VALUES (N'ad3048ea-9b72-40b3-8c56-7eb618d833d4', N'Recolección grupal', CAST(N'1800-01-01T00:00:00.000' AS DateTime), CAST(N'1800-01-01T00:00:00.000' AS DateTime), 1, 0, 0, 5, 100, NULL, NULL, N'bb0bdda2-05d0-42c6-b3bc-b32b99de18ef', N'cce31bb2-f39c-4328-823b-ef32e5bd8ca1', CAST(N'2024-06-19T11:23:43.960' AS DateTime), CAST(N'2024-06-19T11:33:09.427' AS DateTime), 0, 1, N'07bc09c6-34b8-4493-8026-a5c818f7bec4', 1, 2, N'81418e8e-787e-41f1-a4c4-d098406d782d', N'0208d97e-eda7-4dce-baef-629e22549a54')
GO
INSERT [dbo].[Reto] ([idReto], [nombre], [fechaApetura], [fechaCierre], [estado], [vidas], [tiempo_ms], [puntosRecompensa], [creditosObtenidos], [instrucciones], [imagen], [idTipoReto], [idComportamiento], [fechaCreacion], [fechaModificacion], [criterioMinimo], [enEquipo], [idTipoEncuesta], [opsRequeridas], [items], [idTipoValidador], [idTipoArchivo]) VALUES (N'1f05f1db-2c24-435e-a1eb-81fbef77e87b', N'Reto comportamiento individual manual', CAST(N'2024-07-02T00:00:00.000' AS DateTime), CAST(N'2024-07-05T00:00:00.000' AS DateTime), 1, 0, 0, 5, 5, NULL, NULL, N'98d755b4-1160-4e17-9dc8-860587a4179a', N'cce31bb2-f39c-4328-823b-ef32e5bd8ca1', CAST(N'2024-07-03T13:21:24.927' AS DateTime), CAST(N'2024-07-03T13:22:52.893' AS DateTime), 0, 0, N'07bc09c6-34b8-4493-8026-a5c818f7bec4', 1, -1, N'ed15d366-e0ea-4d90-a5df-a4aed453d1fe', N'f831b56f-c313-407d-8b88-ff3c8bbceb5c')
GO
INSERT [dbo].[Reto] ([idReto], [nombre], [fechaApetura], [fechaCierre], [estado], [vidas], [tiempo_ms], [puntosRecompensa], [creditosObtenidos], [instrucciones], [imagen], [idTipoReto], [idComportamiento], [fechaCreacion], [fechaModificacion], [criterioMinimo], [enEquipo], [idTipoEncuesta], [opsRequeridas], [items], [idTipoValidador], [idTipoArchivo]) VALUES (N'b4bb05a2-dc77-4202-a030-86a09dea7039', N'Videos', CAST(N'1800-01-01T00:00:00.000' AS DateTime), CAST(N'1800-01-01T00:00:00.000' AS DateTime), 1, 0, 0, 10, 5, NULL, NULL, N'bb0bdda2-05d0-42c6-b3bc-b32b99de18ef', N'cce31bb2-f39c-4328-823b-ef32e5bd8ca1', CAST(N'2024-06-06T17:17:01.347' AS DateTime), CAST(N'2024-06-06T17:17:51.693' AS DateTime), 0, 0, N'07bc09c6-34b8-4493-8026-a5c818f7bec4', 1, 2, N'81418e8e-787e-41f1-a4c4-d098406d782d', N'92f39ef6-109b-40a8-b46c-c388ff97acff')
GO
INSERT [dbo].[Reto] ([idReto], [nombre], [fechaApetura], [fechaCierre], [estado], [vidas], [tiempo_ms], [puntosRecompensa], [creditosObtenidos], [instrucciones], [imagen], [idTipoReto], [idComportamiento], [fechaCreacion], [fechaModificacion], [criterioMinimo], [enEquipo], [idTipoEncuesta], [opsRequeridas], [items], [idTipoValidador], [idTipoArchivo]) VALUES (N'354e8be8-3d2d-4e42-90b6-8935f7e56ef4', N'Encuesta grupal', CAST(N'1800-01-01T00:00:00.000' AS DateTime), CAST(N'1800-01-01T00:00:00.000' AS DateTime), 1, 0, 0, 40, 40, NULL, NULL, N'58ad5fb5-7259-47f1-b10b-2258107eb263', N'cce31bb2-f39c-4328-823b-ef32e5bd8ca1', CAST(N'2024-06-19T11:48:21.177' AS DateTime), CAST(N'2024-06-19T11:51:45.430' AS DateTime), 0, 1, N'b0c024b5-d503-44c4-802e-2a36580f13fc', 1, -1, N'706ac44f-fa65-459d-9f50-0ebcd59426e3', N'f831b56f-c313-407d-8b88-ff3c8bbceb5c')
GO
INSERT [dbo].[Reto] ([idReto], [nombre], [fechaApetura], [fechaCierre], [estado], [vidas], [tiempo_ms], [puntosRecompensa], [creditosObtenidos], [instrucciones], [imagen], [idTipoReto], [idComportamiento], [fechaCreacion], [fechaModificacion], [criterioMinimo], [enEquipo], [idTipoEncuesta], [opsRequeridas], [items], [idTipoValidador], [idTipoArchivo]) VALUES (N'0b3439f9-f94d-4e28-b758-89668b4d020f', N'prueba comprotamiento', CAST(N'1800-01-01T00:00:00.000' AS DateTime), CAST(N'1800-01-01T00:00:00.000' AS DateTime), 0, 0, 0, 20, 0, NULL, NULL, N'98d755b4-1160-4e17-9dc8-860587a4179a', N'cce31bb2-f39c-4328-823b-ef32e5bd8ca1', CAST(N'2024-05-29T18:14:53.723' AS DateTime), CAST(N'2024-05-29T18:14:53.723' AS DateTime), 0, 0, N'07bc09c6-34b8-4493-8026-a5c818f7bec4', 1, -1, N'ed15d366-e0ea-4d90-a5df-a4aed453d1fe', N'f831b56f-c313-407d-8b88-ff3c8bbceb5c')
GO
INSERT [dbo].[Reto] ([idReto], [nombre], [fechaApetura], [fechaCierre], [estado], [vidas], [tiempo_ms], [puntosRecompensa], [creditosObtenidos], [instrucciones], [imagen], [idTipoReto], [idComportamiento], [fechaCreacion], [fechaModificacion], [criterioMinimo], [enEquipo], [idTipoEncuesta], [opsRequeridas], [items], [idTipoValidador], [idTipoArchivo]) VALUES (N'46a95c2a-36ca-472c-8645-a8fb96bf2812', N'Reto de seguimiento Individual 2', CAST(N'2024-07-02T00:00:00.000' AS DateTime), CAST(N'2024-07-04T00:00:00.000' AS DateTime), 1, 0, 0, 100, 100, NULL, NULL, N'a79c76bf-4240-4b3b-83b9-5689055a8b85', N'cce31bb2-f39c-4328-823b-ef32e5bd8ca1', CAST(N'2024-07-03T11:51:33.200' AS DateTime), CAST(N'2024-07-03T11:58:58.900' AS DateTime), 0, 0, N'07bc09c6-34b8-4493-8026-a5c818f7bec4', 1, -1, N'706ac44f-fa65-459d-9f50-0ebcd59426e3', N'f831b56f-c313-407d-8b88-ff3c8bbceb5c')
GO
INSERT [dbo].[Reto] ([idReto], [nombre], [fechaApetura], [fechaCierre], [estado], [vidas], [tiempo_ms], [puntosRecompensa], [creditosObtenidos], [instrucciones], [imagen], [idTipoReto], [idComportamiento], [fechaCreacion], [fechaModificacion], [criterioMinimo], [enEquipo], [idTipoEncuesta], [opsRequeridas], [items], [idTipoValidador], [idTipoArchivo]) VALUES (N'0039af84-1d83-47cf-94f4-ac5b7268aa97', N'recolectar 4', CAST(N'2024-07-02T00:00:00.000' AS DateTime), CAST(N'2024-07-05T00:00:00.000' AS DateTime), 1, 0, 0, 25, 25, NULL, NULL, N'bb0bdda2-05d0-42c6-b3bc-b32b99de18ef', N'cce31bb2-f39c-4328-823b-ef32e5bd8ca1', CAST(N'2024-07-03T14:49:41.233' AS DateTime), CAST(N'2024-07-03T14:49:55.957' AS DateTime), 0, 1, N'07bc09c6-34b8-4493-8026-a5c818f7bec4', 1, 1, N'ed15d366-e0ea-4d90-a5df-a4aed453d1fe', N'0208d97e-eda7-4dce-baef-629e22549a54')
GO
INSERT [dbo].[Reto] ([idReto], [nombre], [fechaApetura], [fechaCierre], [estado], [vidas], [tiempo_ms], [puntosRecompensa], [creditosObtenidos], [instrucciones], [imagen], [idTipoReto], [idComportamiento], [fechaCreacion], [fechaModificacion], [criterioMinimo], [enEquipo], [idTipoEncuesta], [opsRequeridas], [items], [idTipoValidador], [idTipoArchivo]) VALUES (N'37cf8fee-91e0-4886-9aea-b1dcf97cbb28', N'Encuesta grupal 2', CAST(N'2024-07-02T00:00:00.000' AS DateTime), CAST(N'2024-07-05T00:00:00.000' AS DateTime), 1, 0, 0, 50, 50, NULL, NULL, N'58ad5fb5-7259-47f1-b10b-2258107eb263', N'cce31bb2-f39c-4328-823b-ef32e5bd8ca1', CAST(N'2024-07-03T13:31:26.540' AS DateTime), CAST(N'2024-07-03T13:37:14.390' AS DateTime), 0, 1, N'f0809fc0-1ef7-4a03-b621-821468c39159', 1, -1, N'706ac44f-fa65-459d-9f50-0ebcd59426e3', N'f831b56f-c313-407d-8b88-ff3c8bbceb5c')
GO
INSERT [dbo].[Reto] ([idReto], [nombre], [fechaApetura], [fechaCierre], [estado], [vidas], [tiempo_ms], [puntosRecompensa], [creditosObtenidos], [instrucciones], [imagen], [idTipoReto], [idComportamiento], [fechaCreacion], [fechaModificacion], [criterioMinimo], [enEquipo], [idTipoEncuesta], [opsRequeridas], [items], [idTipoValidador], [idTipoArchivo]) VALUES (N'6e504c05-c240-4a9a-931e-b3ad7e452333', N'Reto Individual Comportamiento 2', CAST(N'2024-07-02T00:00:00.000' AS DateTime), CAST(N'2024-07-05T00:00:00.000' AS DateTime), 1, 0, 0, 2, 2, NULL, NULL, N'98d755b4-1160-4e17-9dc8-860587a4179a', N'cce31bb2-f39c-4328-823b-ef32e5bd8ca1', CAST(N'2024-07-03T11:35:05.250' AS DateTime), CAST(N'2024-07-03T13:20:02.397' AS DateTime), 0, 0, N'07bc09c6-34b8-4493-8026-a5c818f7bec4', 1, -1, N'706ac44f-fa65-459d-9f50-0ebcd59426e3', N'f831b56f-c313-407d-8b88-ff3c8bbceb5c')
GO
INSERT [dbo].[Reto] ([idReto], [nombre], [fechaApetura], [fechaCierre], [estado], [vidas], [tiempo_ms], [puntosRecompensa], [creditosObtenidos], [instrucciones], [imagen], [idTipoReto], [idComportamiento], [fechaCreacion], [fechaModificacion], [criterioMinimo], [enEquipo], [idTipoEncuesta], [opsRequeridas], [items], [idTipoValidador], [idTipoArchivo]) VALUES (N'a10273c0-eb49-43b8-8adf-b8b5c90a87a1', N'Seguimiento individual', CAST(N'1800-01-01T00:00:00.000' AS DateTime), CAST(N'1800-01-01T00:00:00.000' AS DateTime), 1, 0, 0, 20, 20, NULL, NULL, N'a79c76bf-4240-4b3b-83b9-5689055a8b85', N'cce31bb2-f39c-4328-823b-ef32e5bd8ca1', CAST(N'2024-06-19T09:51:34.793' AS DateTime), CAST(N'2024-06-19T10:01:34.867' AS DateTime), 0, 0, N'07bc09c6-34b8-4493-8026-a5c818f7bec4', 1, -1, N'706ac44f-fa65-459d-9f50-0ebcd59426e3', N'f831b56f-c313-407d-8b88-ff3c8bbceb5c')
GO
INSERT [dbo].[Reto] ([idReto], [nombre], [fechaApetura], [fechaCierre], [estado], [vidas], [tiempo_ms], [puntosRecompensa], [creditosObtenidos], [instrucciones], [imagen], [idTipoReto], [idComportamiento], [fechaCreacion], [fechaModificacion], [criterioMinimo], [enEquipo], [idTipoEncuesta], [opsRequeridas], [items], [idTipoValidador], [idTipoArchivo]) VALUES (N'ceb756c4-8e8a-46f1-a94f-bbf3b165cc01', N'Prueba trivia vista previa', CAST(N'1800-01-01T00:00:00.000' AS DateTime), CAST(N'1800-01-01T00:00:00.000' AS DateTime), 0, 3, 6749000, 10, 3, NULL, NULL, N'63aa060b-cde4-49c0-9d60-aaf069df1533', N'1dd28d88-34c7-4394-ab3d-525726001730', CAST(N'2024-07-01T12:53:16.070' AS DateTime), CAST(N'2024-07-01T12:53:16.070' AS DateTime), 40, 0, N'07bc09c6-34b8-4493-8026-a5c818f7bec4', 0, -1, N'706ac44f-fa65-459d-9f50-0ebcd59426e3', N'f831b56f-c313-407d-8b88-ff3c8bbceb5c')
GO
INSERT [dbo].[Reto] ([idReto], [nombre], [fechaApetura], [fechaCierre], [estado], [vidas], [tiempo_ms], [puntosRecompensa], [creditosObtenidos], [instrucciones], [imagen], [idTipoReto], [idComportamiento], [fechaCreacion], [fechaModificacion], [criterioMinimo], [enEquipo], [idTipoEncuesta], [opsRequeridas], [items], [idTipoValidador], [idTipoArchivo]) VALUES (N'13590568-b03d-45a8-8a13-cf2ebae6f9b4', N'reto seguimiento', CAST(N'1800-01-01T00:00:00.000' AS DateTime), CAST(N'1800-01-01T00:00:00.000' AS DateTime), 1, 0, 0, 3, 0, NULL, NULL, N'a79c76bf-4240-4b3b-83b9-5689055a8b85', N'cce31bb2-f39c-4328-823b-ef32e5bd8ca1', CAST(N'2024-05-14T17:09:46.357' AS DateTime), CAST(N'2024-05-19T18:26:34.980' AS DateTime), 0, 0, N'07bc09c6-34b8-4493-8026-a5c818f7bec4', 1, -1, N'706ac44f-fa65-459d-9f50-0ebcd59426e3', N'f831b56f-c313-407d-8b88-ff3c8bbceb5c')
GO
INSERT [dbo].[Reto] ([idReto], [nombre], [fechaApetura], [fechaCierre], [estado], [vidas], [tiempo_ms], [puntosRecompensa], [creditosObtenidos], [instrucciones], [imagen], [idTipoReto], [idComportamiento], [fechaCreacion], [fechaModificacion], [criterioMinimo], [enEquipo], [idTipoEncuesta], [opsRequeridas], [items], [idTipoValidador], [idTipoArchivo]) VALUES (N'fac2338b-35d6-4cba-9cfb-d02bf4c33e60', N'Cultura General', CAST(N'1800-01-01T00:00:00.000' AS DateTime), CAST(N'1800-01-01T00:00:00.000' AS DateTime), 1, 5, 3600000, 5, 3, NULL, NULL, N'63aa060b-cde4-49c0-9d60-aaf069df1533', N'cce31bb2-f39c-4328-823b-ef32e5bd8ca1', CAST(N'2024-05-18T20:05:53.977' AS DateTime), CAST(N'2024-05-18T20:08:50.450' AS DateTime), 30, 0, N'07bc09c6-34b8-4493-8026-a5c818f7bec4', 0, -1, N'706ac44f-fa65-459d-9f50-0ebcd59426e3', N'f831b56f-c313-407d-8b88-ff3c8bbceb5c')
GO
INSERT [dbo].[Reto] ([idReto], [nombre], [fechaApetura], [fechaCierre], [estado], [vidas], [tiempo_ms], [puntosRecompensa], [creditosObtenidos], [instrucciones], [imagen], [idTipoReto], [idComportamiento], [fechaCreacion], [fechaModificacion], [criterioMinimo], [enEquipo], [idTipoEncuesta], [opsRequeridas], [items], [idTipoValidador], [idTipoArchivo]) VALUES (N'1e42d6e2-6323-4ac6-917c-dc1727f5e49d', N'Nuevo seguimiento', CAST(N'1800-01-01T00:00:00.000' AS DateTime), CAST(N'1800-01-01T00:00:00.000' AS DateTime), 1, 0, 0, 5, 0, NULL, NULL, N'a79c76bf-4240-4b3b-83b9-5689055a8b85', N'cce31bb2-f39c-4328-823b-ef32e5bd8ca1', CAST(N'2024-05-31T14:50:54.197' AS DateTime), CAST(N'2024-06-03T16:18:30.087' AS DateTime), 0, 0, N'07bc09c6-34b8-4493-8026-a5c818f7bec4', 1, -1, N'706ac44f-fa65-459d-9f50-0ebcd59426e3', N'f831b56f-c313-407d-8b88-ff3c8bbceb5c')
GO
INSERT [dbo].[Reto] ([idReto], [nombre], [fechaApetura], [fechaCierre], [estado], [vidas], [tiempo_ms], [puntosRecompensa], [creditosObtenidos], [instrucciones], [imagen], [idTipoReto], [idComportamiento], [fechaCreacion], [fechaModificacion], [criterioMinimo], [enEquipo], [idTipoEncuesta], [opsRequeridas], [items], [idTipoValidador], [idTipoArchivo]) VALUES (N'0280943a-9140-4e17-a722-dcb3fc4dd725', N'Encuesta individual', CAST(N'2024-06-17T00:00:00.000' AS DateTime), CAST(N'2024-06-20T00:00:00.000' AS DateTime), 1, 0, 0, 2, 2, NULL, NULL, N'58ad5fb5-7259-47f1-b10b-2258107eb263', N'cce31bb2-f39c-4328-823b-ef32e5bd8ca1', CAST(N'2024-06-18T17:46:11.930' AS DateTime), CAST(N'2024-06-18T17:49:43.477' AS DateTime), 0, 0, N'f0809fc0-1ef7-4a03-b621-821468c39159', 1, -1, N'706ac44f-fa65-459d-9f50-0ebcd59426e3', N'f831b56f-c313-407d-8b88-ff3c8bbceb5c')
GO
INSERT [dbo].[Reto] ([idReto], [nombre], [fechaApetura], [fechaCierre], [estado], [vidas], [tiempo_ms], [puntosRecompensa], [creditosObtenidos], [instrucciones], [imagen], [idTipoReto], [idComportamiento], [fechaCreacion], [fechaModificacion], [criterioMinimo], [enEquipo], [idTipoEncuesta], [opsRequeridas], [items], [idTipoValidador], [idTipoArchivo]) VALUES (N'bb4d3e7d-379f-489b-b9c4-dd28ce56dc81', N'reto encuesta', CAST(N'1800-01-01T00:00:00.000' AS DateTime), CAST(N'1800-01-01T00:00:00.000' AS DateTime), 0, 0, 0, 3, 0, NULL, NULL, N'58ad5fb5-7259-47f1-b10b-2258107eb263', N'cce31bb2-f39c-4328-823b-ef32e5bd8ca1', CAST(N'2024-05-14T16:52:36.817' AS DateTime), CAST(N'2024-05-14T16:52:36.817' AS DateTime), 0, 0, N'b0c024b5-d503-44c4-802e-2a36580f13fc', 1, -1, N'706ac44f-fa65-459d-9f50-0ebcd59426e3', N'f831b56f-c313-407d-8b88-ff3c8bbceb5c')
GO
INSERT [dbo].[Reto] ([idReto], [nombre], [fechaApetura], [fechaCierre], [estado], [vidas], [tiempo_ms], [puntosRecompensa], [creditosObtenidos], [instrucciones], [imagen], [idTipoReto], [idComportamiento], [fechaCreacion], [fechaModificacion], [criterioMinimo], [enEquipo], [idTipoEncuesta], [opsRequeridas], [items], [idTipoValidador], [idTipoArchivo]) VALUES (N'355785e0-e045-437a-891a-e20d0b9ff1a6', N'Recoleccion de videos', CAST(N'1800-01-01T00:00:00.000' AS DateTime), CAST(N'1800-01-01T00:00:00.000' AS DateTime), 1, 0, 0, 10, 4, NULL, NULL, N'bb0bdda2-05d0-42c6-b3bc-b32b99de18ef', N'cce31bb2-f39c-4328-823b-ef32e5bd8ca1', CAST(N'2024-06-06T10:56:31.277' AS DateTime), CAST(N'2024-06-06T10:57:10.590' AS DateTime), 0, 0, N'07bc09c6-34b8-4493-8026-a5c818f7bec4', 1, 4, N'ed15d366-e0ea-4d90-a5df-a4aed453d1fe', N'92f39ef6-109b-40a8-b46c-c388ff97acff')
GO
INSERT [dbo].[Reto] ([idReto], [nombre], [fechaApetura], [fechaCierre], [estado], [vidas], [tiempo_ms], [puntosRecompensa], [creditosObtenidos], [instrucciones], [imagen], [idTipoReto], [idComportamiento], [fechaCreacion], [fechaModificacion], [criterioMinimo], [enEquipo], [idTipoEncuesta], [opsRequeridas], [items], [idTipoValidador], [idTipoArchivo]) VALUES (N'755c0488-101c-4b21-a866-e637e3e3e778', N'nueva recoleccion', CAST(N'1800-01-01T00:00:00.000' AS DateTime), CAST(N'1800-01-01T00:00:00.000' AS DateTime), 1, 0, 0, 10, 3, NULL, NULL, N'bb0bdda2-05d0-42c6-b3bc-b32b99de18ef', N'cce31bb2-f39c-4328-823b-ef32e5bd8ca1', CAST(N'2024-05-31T15:24:52.637' AS DateTime), CAST(N'2024-05-31T15:26:52.613' AS DateTime), 0, 0, N'07bc09c6-34b8-4493-8026-a5c818f7bec4', 1, 3, N'ed15d366-e0ea-4d90-a5df-a4aed453d1fe', N'eade463d-e49c-4b6a-bb40-239e9ae7b072')
GO
INSERT [dbo].[Reto] ([idReto], [nombre], [fechaApetura], [fechaCierre], [estado], [vidas], [tiempo_ms], [puntosRecompensa], [creditosObtenidos], [instrucciones], [imagen], [idTipoReto], [idComportamiento], [fechaCreacion], [fechaModificacion], [criterioMinimo], [enEquipo], [idTipoEncuesta], [opsRequeridas], [items], [idTipoValidador], [idTipoArchivo]) VALUES (N'e11bb04d-bd02-4401-b6d9-f86d528199b4', N'Reto comportamiento indv', CAST(N'2024-06-17T00:00:00.000' AS DateTime), CAST(N'2024-06-21T00:00:00.000' AS DateTime), 1, 0, 0, 10, 5, N'Instrucciones para el reto de comportamiento', NULL, N'98d755b4-1160-4e17-9dc8-860587a4179a', N'cce31bb2-f39c-4328-823b-ef32e5bd8ca1', CAST(N'2024-06-18T15:50:09.393' AS DateTime), CAST(N'2024-06-18T16:20:06.357' AS DateTime), 0, 0, N'07bc09c6-34b8-4493-8026-a5c818f7bec4', 1, -1, N'706ac44f-fa65-459d-9f50-0ebcd59426e3', N'f831b56f-c313-407d-8b88-ff3c8bbceb5c')
GO
INSERT [dbo].[Reto] ([idReto], [nombre], [fechaApetura], [fechaCierre], [estado], [vidas], [tiempo_ms], [puntosRecompensa], [creditosObtenidos], [instrucciones], [imagen], [idTipoReto], [idComportamiento], [fechaCreacion], [fechaModificacion], [criterioMinimo], [enEquipo], [idTipoEncuesta], [opsRequeridas], [items], [idTipoValidador], [idTipoArchivo]) VALUES (N'c40e87a3-b241-403b-84db-f8d27c50261b', N'prueba encuesta', CAST(N'1800-01-01T00:00:00.000' AS DateTime), CAST(N'1800-01-01T00:00:00.000' AS DateTime), 0, 0, 0, 3, 0, NULL, NULL, N'58ad5fb5-7259-47f1-b10b-2258107eb263', N'cce31bb2-f39c-4328-823b-ef32e5bd8ca1', CAST(N'2024-05-09T16:28:48.440' AS DateTime), CAST(N'2024-05-09T16:28:48.440' AS DateTime), 0, 1, N'f0809fc0-1ef7-4a03-b621-821468c39159', 1, -1, N'706ac44f-fa65-459d-9f50-0ebcd59426e3', N'f831b56f-c313-407d-8b88-ff3c8bbceb5c')
GO
INSERT [dbo].[Rol] ([idRol], [nombre], [descripcion], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'adm', N'Administrador', N'Este rol es para el administrador', 1, CAST(N'2023-11-30T10:24:19.633' AS DateTime), CAST(N'2023-11-30T10:24:19.633' AS DateTime))
GO
INSERT [dbo].[Rol] ([idRol], [nombre], [descripcion], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'jug', N'Jugador', N'Este rol es para los jugadores', 1, CAST(N'2023-11-30T10:29:18.137' AS DateTime), CAST(N'2023-11-30T10:29:18.137' AS DateTime))
GO
INSERT [dbo].[Rol] ([idRol], [nombre], [descripcion], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'sadm', N'Super Administrador', N'Este es para el super administrador', 0, CAST(N'2023-12-01T10:06:46.973' AS DateTime), CAST(N'2023-12-01T10:06:46.973' AS DateTime))
GO
INSERT [dbo].[TipoArchivo] ([idTipoArchivo], [nombre], [descripcion], [estado], [fechaCreacion], [fechaModificacion], [extension]) VALUES (N'e16af62b-4425-44aa-bcb8-204672b5db1d', N'Cualquiera', N'Es para los retos que tengan que subir cualquier archivo', 0, CAST(N'2024-05-25T13:09:41.120' AS DateTime), CAST(N'2024-05-25T13:09:41.120' AS DateTime), N'N/A')
GO
INSERT [dbo].[TipoArchivo] ([idTipoArchivo], [nombre], [descripcion], [estado], [fechaCreacion], [fechaModificacion], [extension]) VALUES (N'eade463d-e49c-4b6a-bb40-239e9ae7b072', N'Imagen/png jpg jpeg', N'Es para los retos que se tengan que subir imagenes', 1, CAST(N'2024-05-25T13:09:41.120' AS DateTime), CAST(N'2024-05-25T13:09:41.120' AS DateTime), N'jpg/jpeg/png')
GO
INSERT [dbo].[TipoArchivo] ([idTipoArchivo], [nombre], [descripcion], [estado], [fechaCreacion], [fechaModificacion], [extension]) VALUES (N'7e6182bb-635f-40bc-9602-27e368c6c905', N'Excel', N'Es para los retos que se tengan que subir archivos de Microsoft Excel', 1, CAST(N'2024-05-25T13:09:41.120' AS DateTime), CAST(N'2024-05-25T13:09:41.120' AS DateTime), N'xls/xlsx')
GO
INSERT [dbo].[TipoArchivo] ([idTipoArchivo], [nombre], [descripcion], [estado], [fechaCreacion], [fechaModificacion], [extension]) VALUES (N'0208d97e-eda7-4dce-baef-629e22549a54', N'Word', N'Es para los retos que se tengan que subir archivos de Microsoft Word', 1, CAST(N'2024-05-25T13:09:41.120' AS DateTime), CAST(N'2024-05-25T13:09:41.120' AS DateTime), N'doc/docx')
GO
INSERT [dbo].[TipoArchivo] ([idTipoArchivo], [nombre], [descripcion], [estado], [fechaCreacion], [fechaModificacion], [extension]) VALUES (N'ad25b985-18d5-447d-b6ff-6559ce8bc098', N'Texto', N'Es para los retos que se tengan que subir archivos de Texto', 1, CAST(N'2024-05-27T11:42:55.913' AS DateTime), CAST(N'2024-05-27T11:42:55.913' AS DateTime), N'txt')
GO
INSERT [dbo].[TipoArchivo] ([idTipoArchivo], [nombre], [descripcion], [estado], [fechaCreacion], [fechaModificacion], [extension]) VALUES (N'92f39ef6-109b-40a8-b46c-c388ff97acff', N'Video', N'Es para los retos que se tengan que subir un video pero hay que guardar la url del video ya sea de Vimeo o de Youtube', 1, CAST(N'2024-06-06T10:07:54.040' AS DateTime), CAST(N'2024-06-06T10:07:54.040' AS DateTime), N'mp4')
GO
INSERT [dbo].[TipoArchivo] ([idTipoArchivo], [nombre], [descripcion], [estado], [fechaCreacion], [fechaModificacion], [extension]) VALUES (N'1ed2c1a1-42f7-42f2-aa43-c49edc54eecd', N'Pdf', N'Es para los retos que se tengan que subir archivos de PDF', 1, CAST(N'2024-05-25T13:09:41.120' AS DateTime), CAST(N'2024-05-25T13:09:41.120' AS DateTime), N'pdf')
GO
INSERT [dbo].[TipoArchivo] ([idTipoArchivo], [nombre], [descripcion], [estado], [fechaCreacion], [fechaModificacion], [extension]) VALUES (N'f831b56f-c313-407d-8b88-ff3c8bbceb5c', N'Ninguno', N'Es para los retos que no se tengan que agregar archivos', 0, CAST(N'2024-05-25T13:09:41.120' AS DateTime), CAST(N'2024-05-25T13:09:41.120' AS DateTime), N'N/A')
GO
INSERT [dbo].[TipoEncuesta] ([idTipoEncuesta], [nombre], [descripcion], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'b0c024b5-d503-44c4-802e-2a36580f13fc', N'Satisfacción', N'Son para los tipos de reto Encuesta cuando es satisfacción', 1, CAST(N'2024-05-07T14:55:23.777' AS DateTime), CAST(N'2024-05-07T14:55:23.777' AS DateTime))
GO
INSERT [dbo].[TipoEncuesta] ([idTipoEncuesta], [nombre], [descripcion], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'f0809fc0-1ef7-4a03-b621-821468c39159', N'Voto', N'Son para los tipos de reto Encuesta cuando es de voto', 1, CAST(N'2024-05-07T14:55:23.777' AS DateTime), CAST(N'2024-05-07T14:55:23.777' AS DateTime))
GO
INSERT [dbo].[TipoEncuesta] ([idTipoEncuesta], [nombre], [descripcion], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'07bc09c6-34b8-4493-8026-a5c818f7bec4', N'Otro', N'Son para los retos que no sean de tipo Encuesta', 0, CAST(N'2024-05-07T15:05:22.227' AS DateTime), CAST(N'2024-05-07T15:05:22.227' AS DateTime))
GO
INSERT [dbo].[TipoEntrada] ([idTipoEntrada], [nombre], [descripcion], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'bfef5abf-cff4-460b-a3af-55630d81066a', N'Texto', N'Son los inputs de las opciones de tipo text', 1, CAST(N'2024-05-14T14:39:44.510' AS DateTime), CAST(N'2024-05-14T14:39:44.510' AS DateTime))
GO
INSERT [dbo].[TipoEntrada] ([idTipoEntrada], [nombre], [descripcion], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'357dbf15-2a3e-4424-9005-9325bba3462c', N'Tiempo', N'Son los inputs de las opciones de tipo time', 1, CAST(N'2024-05-14T14:39:44.510' AS DateTime), CAST(N'2024-05-14T14:39:44.510' AS DateTime))
GO
INSERT [dbo].[TipoEntrada] ([idTipoEntrada], [nombre], [descripcion], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'ca0474da-229b-4e5e-9cdb-b30d94ec0fd9', N'Otro', N'Son los inputs de las opciones de cualquier otro tipo', 0, CAST(N'2024-05-14T14:40:11.163' AS DateTime), CAST(N'2024-05-14T14:40:11.163' AS DateTime))
GO
INSERT [dbo].[TipoEntrada] ([idTipoEntrada], [nombre], [descripcion], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'1e2e9f6c-4c7f-4142-8317-c398db956764', N'Fecha', N'Son los inputs de las opciones de tipo date', 1, CAST(N'2024-05-14T14:39:44.510' AS DateTime), CAST(N'2024-05-14T14:39:44.510' AS DateTime))
GO
INSERT [dbo].[TipoReto] ([idTipoReto], [nombre], [descripcion], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'58ad5fb5-7259-47f1-b10b-2258107eb263', N'Encuesta', N'Es para todas las encuestas', 1, CAST(N'2024-04-30T17:52:54.243' AS DateTime), CAST(N'2024-04-30T17:52:54.243' AS DateTime))
GO
INSERT [dbo].[TipoReto] ([idTipoReto], [nombre], [descripcion], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'a79c76bf-4240-4b3b-83b9-5689055a8b85', N'Seguimiento o Evaluación', N'Es para los seguimientos y las evaluaciones', 1, CAST(N'2024-05-13T15:05:54.133' AS DateTime), CAST(N'2024-05-13T15:05:54.133' AS DateTime))
GO
INSERT [dbo].[TipoReto] ([idTipoReto], [nombre], [descripcion], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'98d755b4-1160-4e17-9dc8-860587a4179a', N'Comportamiento', N'Es para los retos que hay que verificar el comportamiento del usuario', 1, CAST(N'2024-05-19T17:54:54.720' AS DateTime), CAST(N'2024-05-19T17:54:54.720' AS DateTime))
GO
INSERT [dbo].[TipoReto] ([idTipoReto], [nombre], [descripcion], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'63aa060b-cde4-49c0-9d60-aaf069df1533', N'Trivia', N'Es para los retos de preguntas', 1, CAST(N'2023-12-16T11:33:15.430' AS DateTime), CAST(N'2023-12-16T11:33:15.430' AS DateTime))
GO
INSERT [dbo].[TipoReto] ([idTipoReto], [nombre], [descripcion], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'bb0bdda2-05d0-42c6-b3bc-b32b99de18ef', N'Recolección', N'Es para los retos que se tengan que recolectar algunas cosas', 1, CAST(N'2023-12-16T11:33:15.430' AS DateTime), CAST(N'2023-12-16T11:33:15.430' AS DateTime))
GO
INSERT [dbo].[TipoValidador] ([idTipoValidador], [nombre], [descripcion], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'706ac44f-fa65-459d-9f50-0ebcd59426e3', N'Automático', N'Es para validar automaticamente el reto está superado', 1, CAST(N'2024-05-22T10:26:43.897' AS DateTime), CAST(N'2024-05-22T10:26:43.897' AS DateTime))
GO
INSERT [dbo].[TipoValidador] ([idTipoValidador], [nombre], [descripcion], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'ed15d366-e0ea-4d90-a5df-a4aed453d1fe', N'Usuario', N'Es para seleccionar un usuario que va a validar si el reto está superado o no superado', 1, CAST(N'2024-05-22T10:26:43.897' AS DateTime), CAST(N'2024-05-22T10:26:43.897' AS DateTime))
GO
INSERT [dbo].[TipoValidador] ([idTipoValidador], [nombre], [descripcion], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'81418e8e-787e-41f1-a4c4-d098406d782d', N'Todos los usuarios asociados al reto', N'Es para que todos los usuarios puedan validar si el reto está superado o no superado', 1, CAST(N'2024-05-22T10:26:43.897' AS DateTime), CAST(N'2024-05-22T10:26:43.897' AS DateTime))
GO
INSERT [dbo].[Usuario] ([idUsuario], [nombre], [apellido], [correo], [celular], [foto], [estado], [idRol], [idArea], [fechaCreacion], [fechaModificacion], [clave], [idCiudad], [fechaLogin], [puntos], [creditos], [id], [paisIso2], [paisCode]) VALUES (N'015e40dd-58ce-401e-a0a9-075874bc0b68', N'Diana', N'Gomez', N'diana@gmail.com', NULL, N'user13.PNG', 1, N'jug', NULL, CAST(N'2023-12-05T16:47:54.067' AS DateTime), CAST(N'2024-06-11T09:33:23.207' AS DateTime), 0x7B2243697068657254657874223A224D6654546A71526963776D384C7353796E31446B39673D3D222C224956223A22745674762F4F61724A74665A55772B487A6542676B673D3D227D, NULL, CAST(N'2024-06-18T10:23:55.627' AS DateTime), 20, 3, N'1020304050', NULL, NULL)
GO
INSERT [dbo].[Usuario] ([idUsuario], [nombre], [apellido], [correo], [celular], [foto], [estado], [idRol], [idArea], [fechaCreacion], [fechaModificacion], [clave], [idCiudad], [fechaLogin], [puntos], [creditos], [id], [paisIso2], [paisCode]) VALUES (N'91331754-1e83-417f-90e7-0e596e996510', N'Elver pablo', N'Galarraga', N'elver.galarga@gmail.com', N'1234567891', N'elver.PNG', 0, N'jug', N'c1df8d3c-0069-468e-8811-a0f404f12819', CAST(N'2023-12-07T10:27:03.510' AS DateTime), CAST(N'2024-04-04T11:51:09.593' AS DateTime), 0x7B2243697068657254657874223A2254576B68637955364E697A71764D354C7346306A39673D3D222C224956223A22776A4C5A46474B42775265316C6C64564470564F54413D3D227D, N'ca6c9451-3ea9-465f-88ce-07e078314731', CAST(N'2024-03-04T17:13:07.187' AS DateTime), 0, 0, N'1020304023', N'ec', N'593')
GO
INSERT [dbo].[Usuario] ([idUsuario], [nombre], [apellido], [correo], [celular], [foto], [estado], [idRol], [idArea], [fechaCreacion], [fechaModificacion], [clave], [idCiudad], [fechaLogin], [puntos], [creditos], [id], [paisIso2], [paisCode]) VALUES (N'96a49ac1-c9c4-4bc1-8d3c-548f37f34828', N'Carlos', N'Icaza', N'cicaza@digimentore.com.ec', N'999999996', NULL, 1, N'jug', N'914784e1-b67c-4e57-b53a-209f99944985', CAST(N'2024-07-03T11:22:13.250' AS DateTime), CAST(N'2024-07-03T13:29:26.037' AS DateTime), 0x7B2243697068657254657874223A227831586839427779675558365072384D313455525466647062587672695A6278546D63783576575A7273733D222C224956223A226A6D4D314E73484C4B394A493271645749766A4D65513D3D227D, N'48632ff5-b6f9-45f0-a514-c0a5ec544226', CAST(N'2024-07-03T14:40:31.133' AS DateTime), 5, 0, N'1722222222', N'ec', N'593')
GO
INSERT [dbo].[Usuario] ([idUsuario], [nombre], [apellido], [correo], [celular], [foto], [estado], [idRol], [idArea], [fechaCreacion], [fechaModificacion], [clave], [idCiudad], [fechaLogin], [puntos], [creditos], [id], [paisIso2], [paisCode]) VALUES (N'939c9c6d-9dcf-4b7e-bea6-5c26169fa066', N'AdminCaicaza', N'Admin', N'admin@hotmail.com', N'485214657', N'UserDefault.png', 1, N'adm', N'914784e1-b67c-4e57-b53a-209f99944985', CAST(N'2023-12-05T16:50:12.913' AS DateTime), CAST(N'2024-06-27T14:23:48.570' AS DateTime), 0x7B2243697068657254657874223A22692F444C66616A30636E7A7A74776D327572325249773D3D222C224956223A2230674A567079537A56674B31414741596D626A594F773D3D227D, N'48632ff5-b6f9-45f0-a514-c0a5ec544226', CAST(N'2024-07-03T14:41:08.053' AS DateTime), 0, 17, N'1020304059', N'bj', N'229')
GO
INSERT [dbo].[Usuario] ([idUsuario], [nombre], [apellido], [correo], [celular], [foto], [estado], [idRol], [idArea], [fechaCreacion], [fechaModificacion], [clave], [idCiudad], [fechaLogin], [puntos], [creditos], [id], [paisIso2], [paisCode]) VALUES (N'ff546529-1904-425d-be28-7204eac38013', N'Jhon', N'Doe', N'usr1@gmail.com', N'995741254', NULL, 1, N'jug', NULL, CAST(N'2024-07-03T11:01:36.470' AS DateTime), CAST(N'2024-07-03T11:01:36.470' AS DateTime), 0x7B2243697068657254657874223A2232497932687053516459424E415553484537664D5245776773574A73727452334448463139344D42506C6B3D222C224956223A224672564A485A7853794B355074334973566666366D413D3D227D, N'48632ff5-b6f9-45f0-a514-c0a5ec544226', NULL, 0, 0, N'1758462554', NULL, NULL)
GO
INSERT [dbo].[Usuario] ([idUsuario], [nombre], [apellido], [correo], [celular], [foto], [estado], [idRol], [idArea], [fechaCreacion], [fechaModificacion], [clave], [idCiudad], [fechaLogin], [puntos], [creditos], [id], [paisIso2], [paisCode]) VALUES (N'de95894e-8253-410e-90a7-79458bea72a7', N'David', N'Cedeno Lucero', N'david@gmail.com', NULL, NULL, 1, N'jug', NULL, CAST(N'2024-07-02T18:10:48.893' AS DateTime), CAST(N'2024-07-02T18:10:48.893' AS DateTime), 0x7B2243697068657254657874223A224F71315A6A6E3178504C456D32376D6E45416A354E513D3D222C224956223A2268614A552F59575574706A68573972487552774A62773D3D227D, NULL, CAST(N'2024-07-02T18:11:46.563' AS DateTime), 0, 0, N'1726960550', NULL, NULL)
GO
INSERT [dbo].[Usuario] ([idUsuario], [nombre], [apellido], [correo], [celular], [foto], [estado], [idRol], [idArea], [fechaCreacion], [fechaModificacion], [clave], [idCiudad], [fechaLogin], [puntos], [creditos], [id], [paisIso2], [paisCode]) VALUES (N'f42329d1-edaa-4f2c-9ae1-8f026c92c842', N'Pedro', N'Romero', N'pedro@gmail.com', NULL, N'user3.PNG', 1, N'jug', NULL, CAST(N'2023-12-05T17:41:38.327' AS DateTime), CAST(N'2024-04-25T18:11:23.193' AS DateTime), 0x7B2243697068657254657874223A22652F54724D7849773741505264516C526E42737A65773D3D222C224956223A2237365330735A734F7A662B31353959796D37503246413D3D227D, NULL, CAST(N'2024-06-13T16:06:27.267' AS DateTime), 13, 40, N'1020304054', NULL, NULL)
GO
INSERT [dbo].[Usuario] ([idUsuario], [nombre], [apellido], [correo], [celular], [foto], [estado], [idRol], [idArea], [fechaCreacion], [fechaModificacion], [clave], [idCiudad], [fechaLogin], [puntos], [creditos], [id], [paisIso2], [paisCode]) VALUES (N'763ece31-66cd-4203-ae52-938efdd4408f', N'Ivan', N'Salas', N'usr2@gmail.com', N'998564234', NULL, 1, N'jug', NULL, CAST(N'2024-07-03T11:01:36.473' AS DateTime), CAST(N'2024-07-03T11:01:36.473' AS DateTime), 0x7B2243697068657254657874223A2239597448586A4A6B53414B466B5966336E67352F4741664E57576165416839652B2B6B61786D41472B746B3D222C224956223A224D64414C64517330454674634A414750416B544D4A673D3D227D, N'48632ff5-b6f9-45f0-a514-c0a5ec544226', CAST(N'2024-07-03T11:19:59.167' AS DateTime), 0, 0, N'1785463221', NULL, NULL)
GO
INSERT [dbo].[Usuario] ([idUsuario], [nombre], [apellido], [correo], [celular], [foto], [estado], [idRol], [idArea], [fechaCreacion], [fechaModificacion], [clave], [idCiudad], [fechaLogin], [puntos], [creditos], [id], [paisIso2], [paisCode]) VALUES (N'97403188-7343-4fed-a873-9a041a4d9e01', N'Noe', N'Ramos', N'usr3@gmail.com', N'984521541', NULL, 1, N'jug', N'914784e1-b67c-4e57-b53a-209f99944985', CAST(N'2024-07-03T11:01:36.473' AS DateTime), CAST(N'2024-07-03T11:01:36.473' AS DateTime), 0x7B2243697068657254657874223A2256644149676645737958356334786E766A48587038673D3D222C224956223A22674358786474332F36542B75467545484D6F4D7648673D3D227D, N'48632ff5-b6f9-45f0-a514-c0a5ec544226', NULL, 0, 0, N'1789545221', NULL, NULL)
GO
INSERT [dbo].[Usuario] ([idUsuario], [nombre], [apellido], [correo], [celular], [foto], [estado], [idRol], [idArea], [fechaCreacion], [fechaModificacion], [clave], [idCiudad], [fechaLogin], [puntos], [creditos], [id], [paisIso2], [paisCode]) VALUES (N'de632913-94cf-4ab1-8350-aa4c9c0b0b52', N'caicazaOI', N'Individual', N'cicaza01@digimentore.com.ec', N'995357576', N'UserDefault - copia.png', 1, N'jug', N'914784e1-b67c-4e57-b53a-209f99944985', CAST(N'2024-06-18T15:26:34.130' AS DateTime), CAST(N'2024-06-27T13:07:11.557' AS DateTime), 0x7B2243697068657254657874223A224D3866733248582F4B364F4430567572734A47515A513D3D222C224956223A225A554C6D384D417A73545757415772356C74454552513D3D227D, N'48632ff5-b6f9-45f0-a514-c0a5ec544226', CAST(N'2024-06-19T11:25:04.373' AS DateTime), 20, 12, N'17000000000', N'ec', N'593')
GO
INSERT [dbo].[Usuario] ([idUsuario], [nombre], [apellido], [correo], [celular], [foto], [estado], [idRol], [idArea], [fechaCreacion], [fechaModificacion], [clave], [idCiudad], [fechaLogin], [puntos], [creditos], [id], [paisIso2], [paisCode]) VALUES (N'91db7bae-7d2f-423d-b595-d227c63ca0a6', N'Marie', N'Guerrero', N'marie@gmail.com', N'1223456', NULL, 1, N'jug', NULL, CAST(N'2023-12-05T17:28:22.697' AS DateTime), CAST(N'2024-05-29T16:31:35.487' AS DateTime), 0x7B2243697068657254657874223A22392F37666B717362614A4B4C586233724764534547413D3D222C224956223A225078384C70486C3351454864614E347443656D6B73513D3D227D, NULL, CAST(N'2024-06-14T11:58:40.230' AS DateTime), 10, 80, N'1020304056', N'ec', N'593')
GO
INSERT [dbo].[Usuario] ([idUsuario], [nombre], [apellido], [correo], [celular], [foto], [estado], [idRol], [idArea], [fechaCreacion], [fechaModificacion], [clave], [idCiudad], [fechaLogin], [puntos], [creditos], [id], [paisIso2], [paisCode]) VALUES (N'aa7283e3-6589-4a55-b4aa-d885315b1e5d', N'Ejemplo', N'Ejemplo', N'usuario@correo.com', N'999999999', NULL, 1, N'jug', NULL, CAST(N'2024-06-18T15:31:29.263' AS DateTime), CAST(N'2024-06-27T13:07:25.897' AS DateTime), 0x7B2243697068657254657874223A22344C62385A663848487431506A59346B7938356C42673D3D222C224956223A225147523277493662635848373351306E6E4A7A6351773D3D227D, N'48632ff5-b6f9-45f0-a514-c0a5ec544226', NULL, 0, 0, N'172584772001', N'ec', N'593')
GO
INSERT [dbo].[Usuario] ([idUsuario], [nombre], [apellido], [correo], [celular], [foto], [estado], [idRol], [idArea], [fechaCreacion], [fechaModificacion], [clave], [idCiudad], [fechaLogin], [puntos], [creditos], [id], [paisIso2], [paisCode]) VALUES (N'6d3a6b25-c6c7-4ed4-a5e9-d992b1cc98a7', N'Benito', N'Camelas', N'benito@gmail.com', N'12234', NULL, 1, N'jug', NULL, CAST(N'2023-12-05T16:52:23.680' AS DateTime), CAST(N'2024-05-13T16:33:34.570' AS DateTime), 0x7B2243697068657254657874223A2276456B7A6C785776754A3865554373466B41776231673D3D222C224956223A224F66432B4E4F3874687A7A57655A5047333874514D513D3D227D, NULL, CAST(N'2024-06-18T09:23:14.960' AS DateTime), 3, 4, N'1020304057', N'ec', N'593')
GO
INSERT [dbo].[Usuario] ([idUsuario], [nombre], [apellido], [correo], [celular], [foto], [estado], [idRol], [idArea], [fechaCreacion], [fechaModificacion], [clave], [idCiudad], [fechaLogin], [puntos], [creditos], [id], [paisIso2], [paisCode]) VALUES (N'ab37197c-bf33-44b8-ba5d-e246fa250b41', N'prueba uno', N'prueba', N'user@correo.com', N'1234567811', NULL, 1, N'jug', N'b7fc947e-8db6-415d-b361-e0c41fcc8344', CAST(N'2024-01-31T16:38:57.650' AS DateTime), CAST(N'2024-05-30T15:21:07.193' AS DateTime), 0x7B2243697068657254657874223A2242796E476A34666933472B4B4B5145435835483172513D3D222C224956223A2238652B4A687244622B626442635972515A566A3051773D3D227D, N'48632ff5-b6f9-45f0-a514-c0a5ec544226', CAST(N'2024-07-02T11:03:42.007' AS DateTime), 3, 29, N'1020304058', N'ec', N'593')
GO
INSERT [dbo].[Usuario] ([idUsuario], [nombre], [apellido], [correo], [celular], [foto], [estado], [idRol], [idArea], [fechaCreacion], [fechaModificacion], [clave], [idCiudad], [fechaLogin], [puntos], [creditos], [id], [paisIso2], [paisCode]) VALUES (N'3c0265f2-e809-4439-acb0-e6efb04918e4', N'EjemploB', N'EjemploB', N'usuario3@correo.com', N'1000000001', NULL, 0, N'jug', N'914784e1-b67c-4e57-b53a-209f99944985', CAST(N'2024-06-18T15:32:14.197' AS DateTime), CAST(N'2024-06-27T12:59:20.217' AS DateTime), 0x7B2243697068657254657874223A2235416D6355694D4A7156795A5A4E7377304B627A44513D3D222C224956223A2245325139464A675238536A59616A42545A6E63684C673D3D227D, N'48632ff5-b6f9-45f0-a514-c0a5ec544226', NULL, 0, 0, N'172584772003', N'al', N'355')
GO
INSERT [dbo].[Usuario] ([idUsuario], [nombre], [apellido], [correo], [celular], [foto], [estado], [idRol], [idArea], [fechaCreacion], [fechaModificacion], [clave], [idCiudad], [fechaLogin], [puntos], [creditos], [id], [paisIso2], [paisCode]) VALUES (N'42c77db8-7fd5-45cb-ab1a-eb331c7dfb61', N'EjemploA', N'EjemploA', N'usuario2@correo.com', N'1000000000', NULL, 1, N'jug', NULL, CAST(N'2024-06-18T15:32:14.193' AS DateTime), CAST(N'2024-06-27T13:00:38.450' AS DateTime), 0x7B2243697068657254657874223A22494C2F2F68733563653431567779656F2F3335546C513D3D222C224956223A2268777A51687174776361622B773166706465667570413D3D227D, N'48632ff5-b6f9-45f0-a514-c0a5ec544226', CAST(N'2024-06-19T11:31:23.180' AS DateTime), 0, 0, N'172584772002', N'ad', N'376')
GO
INSERT [dbo].[Usuario] ([idUsuario], [nombre], [apellido], [correo], [celular], [foto], [estado], [idRol], [idArea], [fechaCreacion], [fechaModificacion], [clave], [idCiudad], [fechaLogin], [puntos], [creditos], [id], [paisIso2], [paisCode]) VALUES (N'6d81e350-a4f4-4042-a3e9-ef97d985bc2a', N'Maria Bélen', N'Hernandez', N'mbelen@gmail.com', N'995412478', N'usr_7c8d8787-6d84-4b98-98d6-a1196a3ac0f8.png', 1, N'jug', NULL, CAST(N'2024-06-19T17:31:23.960' AS DateTime), CAST(N'2024-07-03T14:55:56.620' AS DateTime), 0x7B2243697068657254657874223A226B6551515841594F654D67547A5753384349576955773D3D222C224956223A2272436A646F6D43506E7A647369346F482B6D566F53673D3D227D, N'48632ff5-b6f9-45f0-a514-c0a5ec544226', CAST(N'2024-07-03T14:56:20.937' AS DateTime), 0, 0, N'1726584775', N'es', N'34')
GO
INSERT [dbo].[Usuario_Equipo] ([idEquipo], [idUsuario], [fechaCreacion], [fechaModificacion]) VALUES (N'4638e1df-928a-442a-bcd8-388ad33a8829', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', CAST(N'2024-04-12T16:27:13.070' AS DateTime), CAST(N'2024-04-12T16:27:13.070' AS DateTime))
GO
INSERT [dbo].[Usuario_Equipo] ([idEquipo], [idUsuario], [fechaCreacion], [fechaModificacion]) VALUES (N'281bba2c-1e7b-4d4e-a384-9e372faf895c', N'de632913-94cf-4ab1-8350-aa4c9c0b0b52', CAST(N'2024-06-18T15:42:38.303' AS DateTime), CAST(N'2024-06-18T15:42:38.303' AS DateTime))
GO
INSERT [dbo].[Usuario_Equipo] ([idEquipo], [idUsuario], [fechaCreacion], [fechaModificacion]) VALUES (N'114ec699-77c3-4e52-999b-0e59861f46b9', N'6d3a6b25-c6c7-4ed4-a5e9-d992b1cc98a7', CAST(N'2024-04-25T10:58:54.060' AS DateTime), CAST(N'2024-04-25T10:58:54.060' AS DateTime))
GO
INSERT [dbo].[Usuario_Equipo] ([idEquipo], [idUsuario], [fechaCreacion], [fechaModificacion]) VALUES (N'281bba2c-1e7b-4d4e-a384-9e372faf895c', N'42c77db8-7fd5-45cb-ab1a-eb331c7dfb61', CAST(N'2024-06-18T15:43:19.163' AS DateTime), CAST(N'2024-06-18T15:43:19.163' AS DateTime))
GO
INSERT [dbo].[Usuario_Equipo] ([idEquipo], [idUsuario], [fechaCreacion], [fechaModificacion]) VALUES (N'114ec699-77c3-4e52-999b-0e59861f46b9', N'91331754-1e83-417f-90e7-0e596e996510', CAST(N'2024-04-25T10:59:13.430' AS DateTime), CAST(N'2024-04-25T10:59:13.430' AS DateTime))
GO
INSERT [dbo].[Usuario_Equipo] ([idEquipo], [idUsuario], [fechaCreacion], [fechaModificacion]) VALUES (N'4638e1df-928a-442a-bcd8-388ad33a8829', N'015e40dd-58ce-401e-a0a9-075874bc0b68', CAST(N'2024-04-11T13:07:04.267' AS DateTime), CAST(N'2024-04-11T13:07:04.267' AS DateTime))
GO
INSERT [dbo].[Usuario_Equipo] ([idEquipo], [idUsuario], [fechaCreacion], [fechaModificacion]) VALUES (N'281bba2c-1e7b-4d4e-a384-9e372faf895c', N'96a49ac1-c9c4-4bc1-8d3c-548f37f34828', CAST(N'2024-07-03T13:33:20.413' AS DateTime), CAST(N'2024-07-03T13:33:20.413' AS DateTime))
GO
INSERT [dbo].[Usuario_Equipo] ([idEquipo], [idUsuario], [fechaCreacion], [fechaModificacion]) VALUES (N'281bba2c-1e7b-4d4e-a384-9e372faf895c', N'6d81e350-a4f4-4042-a3e9-ef97d985bc2a', CAST(N'2024-06-25T11:22:43.823' AS DateTime), CAST(N'2024-06-25T11:22:43.823' AS DateTime))
GO
INSERT [dbo].[Usuario_Medalla] ([idMedalla], [idUsuario], [fechaCreacion], [fechaModificacion]) VALUES (N'2eb8768c-f1ae-49be-83e0-b04c39eb64c2', N'f42329d1-edaa-4f2c-9ae1-8f026c92c842', CAST(N'2024-03-14T09:21:25.757' AS DateTime), CAST(N'2024-03-14T09:21:25.757' AS DateTime))
GO
INSERT [dbo].[Usuario_Medalla] ([idMedalla], [idUsuario], [fechaCreacion], [fechaModificacion]) VALUES (N'54c00fb9-e9d1-491c-b3bb-d9fd6307d508', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', CAST(N'2024-05-30T15:04:43.567' AS DateTime), CAST(N'2024-05-30T15:04:43.567' AS DateTime))
GO
INSERT [dbo].[Usuario_Medalla] ([idMedalla], [idUsuario], [fechaCreacion], [fechaModificacion]) VALUES (N'2eb8768c-f1ae-49be-83e0-b04c39eb64c2', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', CAST(N'2024-05-30T15:04:43.573' AS DateTime), CAST(N'2024-05-30T15:04:43.573' AS DateTime))
GO
INSERT [dbo].[Usuario_Medalla] ([idMedalla], [idUsuario], [fechaCreacion], [fechaModificacion]) VALUES (N'2eb8768c-f1ae-49be-83e0-b04c39eb64c2', N'015e40dd-58ce-401e-a0a9-075874bc0b68', CAST(N'2024-05-31T15:33:00.453' AS DateTime), CAST(N'2024-05-31T15:33:00.453' AS DateTime))
GO
INSERT [dbo].[Usuario_Medalla] ([idMedalla], [idUsuario], [fechaCreacion], [fechaModificacion]) VALUES (N'54c00fb9-e9d1-491c-b3bb-d9fd6307d508', N'015e40dd-58ce-401e-a0a9-075874bc0b68', CAST(N'2024-06-14T16:13:39.310' AS DateTime), CAST(N'2024-06-14T16:13:39.310' AS DateTime))
GO
INSERT [dbo].[Usuario_Medalla] ([idMedalla], [idUsuario], [fechaCreacion], [fechaModificacion]) VALUES (N'2eb8768c-f1ae-49be-83e0-b04c39eb64c2', N'de632913-94cf-4ab1-8350-aa4c9c0b0b52', CAST(N'2024-06-19T09:37:26.830' AS DateTime), CAST(N'2024-06-19T09:37:26.830' AS DateTime))
GO
INSERT [dbo].[Usuario_Medalla] ([idMedalla], [idUsuario], [fechaCreacion], [fechaModificacion]) VALUES (N'54c00fb9-e9d1-491c-b3bb-d9fd6307d508', N'de632913-94cf-4ab1-8350-aa4c9c0b0b52', CAST(N'2024-06-19T11:26:23.267' AS DateTime), CAST(N'2024-06-19T11:26:23.267' AS DateTime))
GO
INSERT [dbo].[Usuario_Medalla] ([idMedalla], [idUsuario], [fechaCreacion], [fechaModificacion]) VALUES (N'2eb8768c-f1ae-49be-83e0-b04c39eb64c2', N'42c77db8-7fd5-45cb-ab1a-eb331c7dfb61', CAST(N'2024-06-19T11:53:40.800' AS DateTime), CAST(N'2024-06-19T11:53:40.800' AS DateTime))
GO
INSERT [dbo].[Usuario_Medalla] ([idMedalla], [idUsuario], [fechaCreacion], [fechaModificacion]) VALUES (N'2eb8768c-f1ae-49be-83e0-b04c39eb64c2', N'6d81e350-a4f4-4042-a3e9-ef97d985bc2a', CAST(N'2024-06-25T10:17:39.900' AS DateTime), CAST(N'2024-06-25T10:17:39.900' AS DateTime))
GO
INSERT [dbo].[Usuario_Medalla] ([idMedalla], [idUsuario], [fechaCreacion], [fechaModificacion]) VALUES (N'2eb8768c-f1ae-49be-83e0-b04c39eb64c2', N'96a49ac1-c9c4-4bc1-8d3c-548f37f34828', CAST(N'2024-07-03T12:00:20.570' AS DateTime), CAST(N'2024-07-03T12:00:20.570' AS DateTime))
GO
INSERT [dbo].[Usuario_Medalla] ([idMedalla], [idUsuario], [fechaCreacion], [fechaModificacion]) VALUES (N'54c00fb9-e9d1-491c-b3bb-d9fd6307d508', N'96a49ac1-c9c4-4bc1-8d3c-548f37f34828', CAST(N'2024-07-03T13:36:16.027' AS DateTime), CAST(N'2024-07-03T13:36:16.027' AS DateTime))
GO
INSERT [dbo].[Usuario_Nivel] ([idUsuario], [idNivel], [fechaCreacion], [fechaModificacion]) VALUES (N'91331754-1e83-417f-90e7-0e596e996510', N'62629073-7cc1-4ad3-82f1-b57a823e0092', CAST(N'2023-12-11T16:29:52.420' AS DateTime), CAST(N'2023-12-11T16:29:52.420' AS DateTime))
GO
INSERT [dbo].[Usuario_Nivel] ([idUsuario], [idNivel], [fechaCreacion], [fechaModificacion]) VALUES (N'91db7bae-7d2f-423d-b595-d227c63ca0a6', N'62629073-7cc1-4ad3-82f1-b57a823e0092', CAST(N'2023-12-11T16:59:52.420' AS DateTime), CAST(N'2023-12-11T16:29:52.420' AS DateTime))
GO
INSERT [dbo].[Usuario_Nivel] ([idUsuario], [idNivel], [fechaCreacion], [fechaModificacion]) VALUES (N'ab37197c-bf33-44b8-ba5d-e246fa250b41', N'62629073-7cc1-4ad3-82f1-b57a823e0092', CAST(N'2024-02-14T09:58:50.980' AS DateTime), CAST(N'2024-02-14T09:58:50.980' AS DateTime))
GO
INSERT [dbo].[Usuario_Nivel] ([idUsuario], [idNivel], [fechaCreacion], [fechaModificacion]) VALUES (N'91331754-1e83-417f-90e7-0e596e996510', N'cf68ecd4-fe5c-4e11-9aab-69514424fd1b', CAST(N'2024-03-11T09:02:32.153' AS DateTime), CAST(N'2024-03-11T09:02:32.153' AS DateTime))
GO
INSERT [dbo].[Usuario_Nivel] ([idUsuario], [idNivel], [fechaCreacion], [fechaModificacion]) VALUES (N'91db7bae-7d2f-423d-b595-d227c63ca0a6', N'1e7e4dd1-22b4-49b6-aaa9-705d0e49a7e5', CAST(N'2024-03-12T15:13:27.800' AS DateTime), CAST(N'2024-03-12T15:13:27.800' AS DateTime))
GO
INSERT [dbo].[Usuario_Nivel] ([idUsuario], [idNivel], [fechaCreacion], [fechaModificacion]) VALUES (N'015e40dd-58ce-401e-a0a9-075874bc0b68', N'62629073-7cc1-4ad3-82f1-b57a823e0092', CAST(N'2024-03-12T15:37:27.067' AS DateTime), CAST(N'2024-03-12T15:37:27.067' AS DateTime))
GO
INSERT [dbo].[Usuario_Nivel] ([idUsuario], [idNivel], [fechaCreacion], [fechaModificacion]) VALUES (N'f42329d1-edaa-4f2c-9ae1-8f026c92c842', N'4544d5a7-2e3b-49d5-8df6-145cee2a7698', CAST(N'2024-03-14T09:10:39.087' AS DateTime), CAST(N'2024-03-14T09:10:39.087' AS DateTime))
GO
INSERT [dbo].[Usuario_Nivel] ([idUsuario], [idNivel], [fechaCreacion], [fechaModificacion]) VALUES (N'ab37197c-bf33-44b8-ba5d-e246fa250b41', N'a3ae5c3c-1d90-4306-882d-a092edbd82ef', CAST(N'2024-03-14T16:49:12.323' AS DateTime), CAST(N'2024-03-14T16:49:12.323' AS DateTime))
GO
INSERT [dbo].[Usuario_Nivel] ([idUsuario], [idNivel], [fechaCreacion], [fechaModificacion]) VALUES (N'939c9c6d-9dcf-4b7e-bea6-5c26169fa066', N'cf68ecd4-fe5c-4e11-9aab-69514424fd1b', CAST(N'2024-03-18T15:44:52.617' AS DateTime), CAST(N'2024-03-18T15:44:52.617' AS DateTime))
GO
INSERT [dbo].[Usuario_Nivel] ([idUsuario], [idNivel], [fechaCreacion], [fechaModificacion]) VALUES (N'6d3a6b25-c6c7-4ed4-a5e9-d992b1cc98a7', N'cf68ecd4-fe5c-4e11-9aab-69514424fd1b', CAST(N'2024-05-13T16:33:34.570' AS DateTime), CAST(N'2024-05-13T16:33:34.570' AS DateTime))
GO
INSERT [dbo].[Usuario_Nivel] ([idUsuario], [idNivel], [fechaCreacion], [fechaModificacion]) VALUES (N'ab37197c-bf33-44b8-ba5d-e246fa250b41', N'4544d5a7-2e3b-49d5-8df6-145cee2a7698', CAST(N'2024-05-30T15:05:29.680' AS DateTime), CAST(N'2024-05-30T15:05:29.680' AS DateTime))
GO
INSERT [dbo].[Usuario_Nivel] ([idUsuario], [idNivel], [fechaCreacion], [fechaModificacion]) VALUES (N'ab37197c-bf33-44b8-ba5d-e246fa250b41', N'5690c0ba-70e1-4f3d-a0e2-2ab787446f37', CAST(N'2024-05-30T15:21:07.190' AS DateTime), CAST(N'2024-05-30T15:21:07.190' AS DateTime))
GO
INSERT [dbo].[Usuario_Nivel] ([idUsuario], [idNivel], [fechaCreacion], [fechaModificacion]) VALUES (N'015e40dd-58ce-401e-a0a9-075874bc0b68', N'a3ae5c3c-1d90-4306-882d-a092edbd82ef', CAST(N'2024-06-11T09:33:23.207' AS DateTime), CAST(N'2024-06-11T09:33:23.207' AS DateTime))
GO
INSERT [dbo].[Usuario_Nivel] ([idUsuario], [idNivel], [fechaCreacion], [fechaModificacion]) VALUES (N'de632913-94cf-4ab1-8350-aa4c9c0b0b52', N'cf68ecd4-fe5c-4e11-9aab-69514424fd1b', CAST(N'2024-06-19T09:37:52.037' AS DateTime), CAST(N'2024-06-19T09:37:52.037' AS DateTime))
GO
INSERT [dbo].[Usuario_Nivel] ([idUsuario], [idNivel], [fechaCreacion], [fechaModificacion]) VALUES (N'96a49ac1-c9c4-4bc1-8d3c-548f37f34828', N'cf68ecd4-fe5c-4e11-9aab-69514424fd1b', CAST(N'2024-07-03T12:01:07.727' AS DateTime), CAST(N'2024-07-03T12:01:07.727' AS DateTime))
GO
INSERT [dbo].[Usuario_Nivel] ([idUsuario], [idNivel], [fechaCreacion], [fechaModificacion]) VALUES (N'ab37197c-bf33-44b8-ba5d-e246fa250b41', N'ffd99848-9d07-4cbd-93b1-b7ca5cc18452', CAST(N'2024-03-12T15:16:40.473' AS DateTime), CAST(N'2024-03-12T15:16:40.473' AS DateTime))
GO
INSERT [dbo].[Usuario_Noticia] ([idNoticia], [idUsuario], [likes], [comentario], [fechaCreacion], [fechaModificacion]) VALUES (N'7cf3f854-abe0-4033-bd63-4a94dc7daf1a', N'015e40dd-58ce-401e-a0a9-075874bc0b68', 0, N'hola', CAST(N'2023-12-12T17:57:18.940' AS DateTime), CAST(N'2023-12-12T17:57:18.940' AS DateTime))
GO
INSERT [dbo].[Usuario_Noticia] ([idNoticia], [idUsuario], [likes], [comentario], [fechaCreacion], [fechaModificacion]) VALUES (N'7cf3f854-abe0-4033-bd63-4a94dc7daf1a', N'015e40dd-58ce-401e-a0a9-075874bc0b68', 1, NULL, CAST(N'2023-12-12T17:57:38.647' AS DateTime), CAST(N'2023-12-12T17:57:38.647' AS DateTime))
GO
INSERT [dbo].[Usuario_Noticia] ([idNoticia], [idUsuario], [likes], [comentario], [fechaCreacion], [fechaModificacion]) VALUES (N'7cf3f854-abe0-4033-bd63-4a94dc7daf1a', N'91331754-1e83-417f-90e7-0e596e996510', 0, N'saludos', CAST(N'2023-12-13T12:32:49.910' AS DateTime), CAST(N'2023-12-13T12:32:49.910' AS DateTime))
GO
INSERT [dbo].[Usuario_Noticia] ([idNoticia], [idUsuario], [likes], [comentario], [fechaCreacion], [fechaModificacion]) VALUES (N'7cf3f854-abe0-4033-bd63-4a94dc7daf1a', N'91331754-1e83-417f-90e7-0e596e996510', 0, N'buena noticia', CAST(N'2023-12-13T12:33:29.260' AS DateTime), CAST(N'2023-12-13T12:33:29.260' AS DateTime))
GO
INSERT [dbo].[Usuario_Noticia] ([idNoticia], [idUsuario], [likes], [comentario], [fechaCreacion], [fechaModificacion]) VALUES (N'7cf3f854-abe0-4033-bd63-4a94dc7daf1a', N'91331754-1e83-417f-90e7-0e596e996510', 0, NULL, CAST(N'2023-12-13T12:34:03.657' AS DateTime), CAST(N'2023-12-13T12:34:03.657' AS DateTime))
GO
INSERT [dbo].[Usuario_Noticia] ([idNoticia], [idUsuario], [likes], [comentario], [fechaCreacion], [fechaModificacion]) VALUES (N'7cf3f854-abe0-4033-bd63-4a94dc7daf1a', N'91331754-1e83-417f-90e7-0e596e996510', 1, NULL, CAST(N'2023-12-13T12:36:15.930' AS DateTime), CAST(N'2023-12-13T12:36:15.930' AS DateTime))
GO
INSERT [dbo].[Usuario_Noticia] ([idNoticia], [idUsuario], [likes], [comentario], [fechaCreacion], [fechaModificacion]) VALUES (N'6c8c7b7c-c3be-4dbf-9e3a-3f8b8640d0e2', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', 1, NULL, CAST(N'2024-06-27T15:09:43.783' AS DateTime), CAST(N'2024-06-27T15:09:43.783' AS DateTime))
GO
INSERT [dbo].[Usuario_Noticia] ([idNoticia], [idUsuario], [likes], [comentario], [fechaCreacion], [fechaModificacion]) VALUES (N'70114d2e-1ba0-4251-a626-1cfdfdce6a40', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', 0, N'hola', CAST(N'2024-04-09T18:18:31.600' AS DateTime), CAST(N'2024-04-09T18:18:31.600' AS DateTime))
GO
INSERT [dbo].[Usuario_Noticia] ([idNoticia], [idUsuario], [likes], [comentario], [fechaCreacion], [fechaModificacion]) VALUES (N'70114d2e-1ba0-4251-a626-1cfdfdce6a40', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', 1, NULL, CAST(N'2024-04-15T16:16:14.243' AS DateTime), CAST(N'2024-04-15T16:16:14.243' AS DateTime))
GO
INSERT [dbo].[Usuario_Noticia] ([idNoticia], [idUsuario], [likes], [comentario], [fechaCreacion], [fechaModificacion]) VALUES (N'ff601fed-b6f1-4d8a-8c0f-a153bd7053bb', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', 0, N'wow', CAST(N'2024-06-27T17:58:55.520' AS DateTime), CAST(N'2024-06-27T17:58:55.520' AS DateTime))
GO
INSERT [dbo].[Usuario_Noticia] ([idNoticia], [idUsuario], [likes], [comentario], [fechaCreacion], [fechaModificacion]) VALUES (N'ff601fed-b6f1-4d8a-8c0f-a153bd7053bb', N'de632913-94cf-4ab1-8350-aa4c9c0b0b52', 0, N'eSTE ES UN COMENTARIO DE USUARIO DE CAICAZA INDIVIDUAL', CAST(N'2024-06-19T10:16:41.107' AS DateTime), CAST(N'2024-06-19T10:16:41.107' AS DateTime))
GO
INSERT [dbo].[Usuario_Noticia] ([idNoticia], [idUsuario], [likes], [comentario], [fechaCreacion], [fechaModificacion]) VALUES (N'ff601fed-b6f1-4d8a-8c0f-a153bd7053bb', N'de632913-94cf-4ab1-8350-aa4c9c0b0b52', 0, N'eSTE ES UN COMENTARIO DE USUARIO DE CAICAZA INDIVIDUAL', CAST(N'2024-06-19T10:16:43.657' AS DateTime), CAST(N'2024-06-19T10:16:43.657' AS DateTime))
GO
INSERT [dbo].[Usuario_Noticia] ([idNoticia], [idUsuario], [likes], [comentario], [fechaCreacion], [fechaModificacion]) VALUES (N'7cf3f854-abe0-4033-bd63-4a94dc7daf1a', N'6d81e350-a4f4-4042-a3e9-ef97d985bc2a', 1, NULL, CAST(N'2024-06-28T09:04:45.670' AS DateTime), CAST(N'2024-06-28T09:04:45.670' AS DateTime))
GO
INSERT [dbo].[Usuario_Noticia] ([idNoticia], [idUsuario], [likes], [comentario], [fechaCreacion], [fechaModificacion]) VALUES (N'ff601fed-b6f1-4d8a-8c0f-a153bd7053bb', N'96a49ac1-c9c4-4bc1-8d3c-548f37f34828', 1, NULL, CAST(N'2024-07-03T12:16:56.890' AS DateTime), CAST(N'2024-07-03T12:16:56.890' AS DateTime))
GO
INSERT [dbo].[Usuario_Noticia] ([idNoticia], [idUsuario], [likes], [comentario], [fechaCreacion], [fechaModificacion]) VALUES (N'ff601fed-b6f1-4d8a-8c0f-a153bd7053bb', N'6d81e350-a4f4-4042-a3e9-ef97d985bc2a', 1, NULL, CAST(N'2024-07-03T15:00:24.730' AS DateTime), CAST(N'2024-07-03T15:00:24.730' AS DateTime))
GO
INSERT [dbo].[Usuario_Noticia] ([idNoticia], [idUsuario], [likes], [comentario], [fechaCreacion], [fechaModificacion]) VALUES (N'ff601fed-b6f1-4d8a-8c0f-a153bd7053bb', N'de632913-94cf-4ab1-8350-aa4c9c0b0b52', 0, N'eSTE ES UN COMENTARIO DE USUARIO DE CAICAZA INDIVIDUAL', CAST(N'2024-06-19T10:16:44.183' AS DateTime), CAST(N'2024-06-19T10:16:44.183' AS DateTime))
GO
INSERT [dbo].[Usuario_Noticia] ([idNoticia], [idUsuario], [likes], [comentario], [fechaCreacion], [fechaModificacion]) VALUES (N'ff601fed-b6f1-4d8a-8c0f-a153bd7053bb', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', 0, N'prueba', CAST(N'2024-06-27T17:25:56.970' AS DateTime), CAST(N'2024-06-27T17:25:56.970' AS DateTime))
GO
INSERT [dbo].[Usuario_Noticia] ([idNoticia], [idUsuario], [likes], [comentario], [fechaCreacion], [fechaModificacion]) VALUES (N'ff601fed-b6f1-4d8a-8c0f-a153bd7053bb', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', 1, NULL, CAST(N'2024-06-27T18:04:12.680' AS DateTime), CAST(N'2024-06-27T18:04:12.680' AS DateTime))
GO
INSERT [dbo].[Usuario_Noticia] ([idNoticia], [idUsuario], [likes], [comentario], [fechaCreacion], [fechaModificacion]) VALUES (N'ff601fed-b6f1-4d8a-8c0f-a153bd7053bb', N'de632913-94cf-4ab1-8350-aa4c9c0b0b52', 0, N'eSTE ES UN COMENTARIO DE USUARIO DE CAICAZA INDIVIDUAL', CAST(N'2024-06-19T10:16:44.383' AS DateTime), CAST(N'2024-06-19T10:16:44.383' AS DateTime))
GO
INSERT [dbo].[Usuario_Noticia] ([idNoticia], [idUsuario], [likes], [comentario], [fechaCreacion], [fechaModificacion]) VALUES (N'ff601fed-b6f1-4d8a-8c0f-a153bd7053bb', N'de632913-94cf-4ab1-8350-aa4c9c0b0b52', 0, N'eSTE ES UN COMENTARIO DE USUARIO DE CAICAZA INDIVIDUAL', CAST(N'2024-06-19T10:16:44.803' AS DateTime), CAST(N'2024-06-19T10:16:44.803' AS DateTime))
GO
INSERT [dbo].[Usuario_Noticia] ([idNoticia], [idUsuario], [likes], [comentario], [fechaCreacion], [fechaModificacion]) VALUES (N'ff601fed-b6f1-4d8a-8c0f-a153bd7053bb', N'de632913-94cf-4ab1-8350-aa4c9c0b0b52', 1, NULL, CAST(N'2024-06-19T10:17:54.390' AS DateTime), CAST(N'2024-06-19T10:17:54.390' AS DateTime))
GO
INSERT [dbo].[Usuario_Noticia] ([idNoticia], [idUsuario], [likes], [comentario], [fechaCreacion], [fechaModificacion]) VALUES (N'7cf3f854-abe0-4033-bd63-4a94dc7daf1a', N'de632913-94cf-4ab1-8350-aa4c9c0b0b52', 1, NULL, CAST(N'2024-06-19T10:40:01.747' AS DateTime), CAST(N'2024-06-19T10:40:01.747' AS DateTime))
GO
INSERT [dbo].[Usuario_Recompensa] ([idRecompensa], [idUsuario], [fechaCreacion], [fechaModificacion]) VALUES (N'56d57b18-2afe-46a9-822b-9540eb4f8e6a', N'6d3a6b25-c6c7-4ed4-a5e9-d992b1cc98a7', CAST(N'2023-12-12T14:36:50.007' AS DateTime), CAST(N'2023-12-12T14:36:50.007' AS DateTime))
GO
INSERT [dbo].[Usuario_Recompensa] ([idRecompensa], [idUsuario], [fechaCreacion], [fechaModificacion]) VALUES (N'56d57b18-2afe-46a9-822b-9540eb4f8e6a', N'939c9c6d-9dcf-4b7e-bea6-5c26169fa066', CAST(N'2023-12-12T14:46:59.343' AS DateTime), CAST(N'2023-12-12T14:46:59.343' AS DateTime))
GO
INSERT [dbo].[Usuario_Recompensa] ([idRecompensa], [idUsuario], [fechaCreacion], [fechaModificacion]) VALUES (N'56d57b18-2afe-46a9-822b-9540eb4f8e6a', N'939c9c6d-9dcf-4b7e-bea6-5c26169fa066', CAST(N'2023-12-12T15:15:55.640' AS DateTime), CAST(N'2023-12-12T15:15:55.640' AS DateTime))
GO
INSERT [dbo].[Usuario_Recompensa] ([idRecompensa], [idUsuario], [fechaCreacion], [fechaModificacion]) VALUES (N'56d57b18-2afe-46a9-822b-9540eb4f8e6a', N'939c9c6d-9dcf-4b7e-bea6-5c26169fa066', CAST(N'2023-12-12T15:16:46.710' AS DateTime), CAST(N'2023-12-12T15:16:46.710' AS DateTime))
GO
INSERT [dbo].[Usuario_Recompensa] ([idRecompensa], [idUsuario], [fechaCreacion], [fechaModificacion]) VALUES (N'56d57b18-2afe-46a9-822b-9540eb4f8e6a', N'015e40dd-58ce-401e-a0a9-075874bc0b68', CAST(N'2023-12-12T15:29:28.763' AS DateTime), CAST(N'2023-12-12T15:29:28.763' AS DateTime))
GO
INSERT [dbo].[Usuario_Recompensa] ([idRecompensa], [idUsuario], [fechaCreacion], [fechaModificacion]) VALUES (N'2517e519-acf6-42d4-90a7-df589bff4987', N'015e40dd-58ce-401e-a0a9-075874bc0b68', CAST(N'2024-03-05T14:43:27.007' AS DateTime), CAST(N'2024-03-05T14:43:27.007' AS DateTime))
GO
INSERT [dbo].[Usuario_Recompensa] ([idRecompensa], [idUsuario], [fechaCreacion], [fechaModificacion]) VALUES (N'91f482c6-59a5-450f-a09a-9c745b861339', N'015e40dd-58ce-401e-a0a9-075874bc0b68', CAST(N'2024-03-05T14:44:42.990' AS DateTime), CAST(N'2024-03-05T14:44:42.990' AS DateTime))
GO
INSERT [dbo].[Usuario_Recompensa] ([idRecompensa], [idUsuario], [fechaCreacion], [fechaModificacion]) VALUES (N'91f482c6-59a5-450f-a09a-9c745b861339', N'939c9c6d-9dcf-4b7e-bea6-5c26169fa066', CAST(N'2024-03-05T14:45:25.583' AS DateTime), CAST(N'2024-03-05T14:45:25.583' AS DateTime))
GO
INSERT [dbo].[Usuario_Recompensa] ([idRecompensa], [idUsuario], [fechaCreacion], [fechaModificacion]) VALUES (N'91f482c6-59a5-450f-a09a-9c745b861339', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', CAST(N'2024-04-09T18:22:47.583' AS DateTime), CAST(N'2024-04-09T18:22:47.583' AS DateTime))
GO
INSERT [dbo].[Usuario_Recompensa] ([idRecompensa], [idUsuario], [fechaCreacion], [fechaModificacion]) VALUES (N'40853d25-1a7a-416a-a9ca-32c3f2c53814', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', CAST(N'2024-04-17T10:42:28.640' AS DateTime), CAST(N'2024-04-17T10:42:28.640' AS DateTime))
GO
INSERT [dbo].[Usuario_Recompensa] ([idRecompensa], [idUsuario], [fechaCreacion], [fechaModificacion]) VALUES (N'91f482c6-59a5-450f-a09a-9c745b861339', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', CAST(N'2024-04-17T12:28:45.223' AS DateTime), CAST(N'2024-04-17T12:28:45.223' AS DateTime))
GO
INSERT [dbo].[Usuario_Recompensa] ([idRecompensa], [idUsuario], [fechaCreacion], [fechaModificacion]) VALUES (N'40853d25-1a7a-416a-a9ca-32c3f2c53814', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', CAST(N'2024-04-17T12:42:48.427' AS DateTime), CAST(N'2024-04-17T12:42:48.427' AS DateTime))
GO
INSERT [dbo].[Usuario_Recompensa] ([idRecompensa], [idUsuario], [fechaCreacion], [fechaModificacion]) VALUES (N'91f482c6-59a5-450f-a09a-9c745b861339', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', CAST(N'2024-04-17T12:43:02.697' AS DateTime), CAST(N'2024-04-17T12:43:02.697' AS DateTime))
GO
INSERT [dbo].[Usuario_Recompensa] ([idRecompensa], [idUsuario], [fechaCreacion], [fechaModificacion]) VALUES (N'91f482c6-59a5-450f-a09a-9c745b861339', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', CAST(N'2024-04-17T16:08:33.527' AS DateTime), CAST(N'2024-04-17T16:08:33.527' AS DateTime))
GO
INSERT [dbo].[Usuario_Recompensa] ([idRecompensa], [idUsuario], [fechaCreacion], [fechaModificacion]) VALUES (N'91f482c6-59a5-450f-a09a-9c745b861339', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', CAST(N'2024-04-17T17:44:05.900' AS DateTime), CAST(N'2024-04-17T17:44:05.900' AS DateTime))
GO
INSERT [dbo].[Usuario_Recompensa] ([idRecompensa], [idUsuario], [fechaCreacion], [fechaModificacion]) VALUES (N'91f482c6-59a5-450f-a09a-9c745b861339', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', CAST(N'2024-04-17T17:45:15.837' AS DateTime), CAST(N'2024-04-17T17:45:15.837' AS DateTime))
GO
INSERT [dbo].[Usuario_Recompensa] ([idRecompensa], [idUsuario], [fechaCreacion], [fechaModificacion]) VALUES (N'40853d25-1a7a-416a-a9ca-32c3f2c53814', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', CAST(N'2024-04-23T12:36:45.357' AS DateTime), CAST(N'2024-04-23T12:36:45.357' AS DateTime))
GO
INSERT [dbo].[Usuario_Recompensa] ([idRecompensa], [idUsuario], [fechaCreacion], [fechaModificacion]) VALUES (N'40853d25-1a7a-416a-a9ca-32c3f2c53814', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', CAST(N'2024-04-23T14:58:35.780' AS DateTime), CAST(N'2024-04-23T14:58:35.780' AS DateTime))
GO
INSERT [dbo].[Usuario_Recompensa] ([idRecompensa], [idUsuario], [fechaCreacion], [fechaModificacion]) VALUES (N'40853d25-1a7a-416a-a9ca-32c3f2c53814', N'de632913-94cf-4ab1-8350-aa4c9c0b0b52', CAST(N'2024-06-19T10:44:09.893' AS DateTime), CAST(N'2024-06-19T10:44:09.893' AS DateTime))
GO
INSERT [dbo].[Usuario_Recompensa] ([idRecompensa], [idUsuario], [fechaCreacion], [fechaModificacion]) VALUES (N'91f482c6-59a5-450f-a09a-9c745b861339', N'de632913-94cf-4ab1-8350-aa4c9c0b0b52', CAST(N'2024-06-19T10:44:36.223' AS DateTime), CAST(N'2024-06-19T10:44:36.223' AS DateTime))
GO
INSERT [dbo].[Usuario_Recompensa] ([idRecompensa], [idUsuario], [fechaCreacion], [fechaModificacion]) VALUES (N'56d57b18-2afe-46a9-822b-9540eb4f8e6a', N'de632913-94cf-4ab1-8350-aa4c9c0b0b52', CAST(N'2024-06-19T10:46:19.240' AS DateTime), CAST(N'2024-06-19T10:46:19.240' AS DateTime))
GO
INSERT [dbo].[Usuario_Recompensa] ([idRecompensa], [idUsuario], [fechaCreacion], [fechaModificacion]) VALUES (N'91f482c6-59a5-450f-a09a-9c745b861339', N'de632913-94cf-4ab1-8350-aa4c9c0b0b52', CAST(N'2024-06-19T10:48:07.997' AS DateTime), CAST(N'2024-06-19T10:48:07.997' AS DateTime))
GO
INSERT [dbo].[Usuario_Recompensa] ([idRecompensa], [idUsuario], [fechaCreacion], [fechaModificacion]) VALUES (N'2517e519-acf6-42d4-90a7-df589bff4987', N'96a49ac1-c9c4-4bc1-8d3c-548f37f34828', CAST(N'2024-07-03T12:18:20.917' AS DateTime), CAST(N'2024-07-03T12:18:20.917' AS DateTime))
GO
INSERT [dbo].[Usuario_Recompensa] ([idRecompensa], [idUsuario], [fechaCreacion], [fechaModificacion]) VALUES (N'91f482c6-59a5-450f-a09a-9c745b861339', N'96a49ac1-c9c4-4bc1-8d3c-548f37f34828', CAST(N'2024-07-03T13:27:03.760' AS DateTime), CAST(N'2024-07-03T13:27:03.760' AS DateTime))
GO
INSERT [dbo].[Usuario_Recompensa] ([idRecompensa], [idUsuario], [fechaCreacion], [fechaModificacion]) VALUES (N'91f482c6-59a5-450f-a09a-9c745b861339', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', CAST(N'2024-04-17T12:48:51.900' AS DateTime), CAST(N'2024-04-17T12:48:51.900' AS DateTime))
GO
INSERT [dbo].[Usuario_Recompensa] ([idRecompensa], [idUsuario], [fechaCreacion], [fechaModificacion]) VALUES (N'91f482c6-59a5-450f-a09a-9c745b861339', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', CAST(N'2024-04-17T12:49:24.170' AS DateTime), CAST(N'2024-04-17T12:49:24.170' AS DateTime))
GO
INSERT [dbo].[Usuario_Recompensa] ([idRecompensa], [idUsuario], [fechaCreacion], [fechaModificacion]) VALUES (N'91f482c6-59a5-450f-a09a-9c745b861339', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', CAST(N'2024-04-17T12:49:36.600' AS DateTime), CAST(N'2024-04-17T12:49:36.600' AS DateTime))
GO
INSERT [dbo].[Usuario_Recompensa] ([idRecompensa], [idUsuario], [fechaCreacion], [fechaModificacion]) VALUES (N'91f482c6-59a5-450f-a09a-9c745b861339', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', CAST(N'2024-04-17T12:49:50.857' AS DateTime), CAST(N'2024-04-17T12:49:50.857' AS DateTime))
GO
INSERT [dbo].[Usuario_Recompensa] ([idRecompensa], [idUsuario], [fechaCreacion], [fechaModificacion]) VALUES (N'91f482c6-59a5-450f-a09a-9c745b861339', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', CAST(N'2024-04-17T12:50:02.083' AS DateTime), CAST(N'2024-04-17T12:50:02.083' AS DateTime))
GO
INSERT [dbo].[Usuario_Recompensa] ([idRecompensa], [idUsuario], [fechaCreacion], [fechaModificacion]) VALUES (N'91f482c6-59a5-450f-a09a-9c745b861339', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', CAST(N'2024-04-17T12:52:20.450' AS DateTime), CAST(N'2024-04-17T12:52:20.450' AS DateTime))
GO
INSERT [dbo].[Usuario_Recompensa] ([idRecompensa], [idUsuario], [fechaCreacion], [fechaModificacion]) VALUES (N'91f482c6-59a5-450f-a09a-9c745b861339', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', CAST(N'2024-04-17T13:05:57.350' AS DateTime), CAST(N'2024-04-17T13:05:57.350' AS DateTime))
GO
INSERT [dbo].[Usuario_RedSocial] ([idRed], [idUsuario], [likes], [comentario], [fechaCreacion], [fechaModificacion]) VALUES (N'753e11df-2798-4efe-9f06-413862707a97', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', 0, N'hola', CAST(N'2024-04-09T18:19:00.280' AS DateTime), CAST(N'2024-04-09T18:19:00.280' AS DateTime))
GO
INSERT [dbo].[Usuario_RedSocial] ([idRed], [idUsuario], [likes], [comentario], [fechaCreacion], [fechaModificacion]) VALUES (N'a8c40b1b-69e1-47e2-9535-1dca08b468c2', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', 1, NULL, CAST(N'2024-04-09T18:39:52.933' AS DateTime), CAST(N'2024-04-09T18:39:52.933' AS DateTime))
GO
INSERT [dbo].[Usuario_RedSocial] ([idRed], [idUsuario], [likes], [comentario], [fechaCreacion], [fechaModificacion]) VALUES (N'46f01d50-f16a-4e50-9da8-b386f6828a89', N'939c9c6d-9dcf-4b7e-bea6-5c26169fa066', 1, NULL, CAST(N'2024-03-12T08:43:49.863' AS DateTime), CAST(N'2024-03-12T08:43:49.863' AS DateTime))
GO
INSERT [dbo].[Usuario_RedSocial] ([idRed], [idUsuario], [likes], [comentario], [fechaCreacion], [fechaModificacion]) VALUES (N'18bb6c17-1fa4-49b0-8be0-3a8b22e3381a', N'939c9c6d-9dcf-4b7e-bea6-5c26169fa066', 1, NULL, CAST(N'2024-04-22T10:14:24.167' AS DateTime), CAST(N'2024-04-22T10:14:24.167' AS DateTime))
GO
INSERT [dbo].[Usuario_RedSocial] ([idRed], [idUsuario], [likes], [comentario], [fechaCreacion], [fechaModificacion]) VALUES (N'c2f763c8-19c4-4b12-9e4c-e72a3244c454', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', 0, N'wow', CAST(N'2024-06-27T18:05:04.837' AS DateTime), CAST(N'2024-06-27T18:05:04.837' AS DateTime))
GO
INSERT [dbo].[Usuario_RedSocial] ([idRed], [idUsuario], [likes], [comentario], [fechaCreacion], [fechaModificacion]) VALUES (N'c2f763c8-19c4-4b12-9e4c-e72a3244c454', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', 0, N'ok', CAST(N'2024-06-27T18:06:00.777' AS DateTime), CAST(N'2024-06-27T18:06:00.777' AS DateTime))
GO
INSERT [dbo].[Usuario_RedSocial] ([idRed], [idUsuario], [likes], [comentario], [fechaCreacion], [fechaModificacion]) VALUES (N'c2f763c8-19c4-4b12-9e4c-e72a3244c454', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', 1, NULL, CAST(N'2024-06-27T18:06:43.310' AS DateTime), CAST(N'2024-06-27T18:06:43.310' AS DateTime))
GO
INSERT [dbo].[Usuario_RedSocial] ([idRed], [idUsuario], [likes], [comentario], [fechaCreacion], [fechaModificacion]) VALUES (N'c2f763c8-19c4-4b12-9e4c-e72a3244c454', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', 0, N'ok', CAST(N'2024-06-27T18:06:48.843' AS DateTime), CAST(N'2024-06-27T18:06:48.843' AS DateTime))
GO
INSERT [dbo].[Usuario_RedSocial] ([idRed], [idUsuario], [likes], [comentario], [fechaCreacion], [fechaModificacion]) VALUES (N'c2f763c8-19c4-4b12-9e4c-e72a3244c454', N'939c9c6d-9dcf-4b7e-bea6-5c26169fa066', 1, NULL, CAST(N'2024-06-28T14:19:38.573' AS DateTime), CAST(N'2024-06-28T14:19:38.573' AS DateTime))
GO
INSERT [dbo].[Usuario_RedSocial] ([idRed], [idUsuario], [likes], [comentario], [fechaCreacion], [fechaModificacion]) VALUES (N'0e93b64e-60c6-4485-b989-825c33becf52', N'96a49ac1-c9c4-4bc1-8d3c-548f37f34828', 0, N'buuuu', CAST(N'2024-07-03T13:28:00.200' AS DateTime), CAST(N'2024-07-03T13:28:00.200' AS DateTime))
GO
INSERT [dbo].[Usuario_RedSocial] ([idRed], [idUsuario], [likes], [comentario], [fechaCreacion], [fechaModificacion]) VALUES (N'0e93b64e-60c6-4485-b989-825c33becf52', N'96a49ac1-c9c4-4bc1-8d3c-548f37f34828', 0, N'sdadsadasd', CAST(N'2024-07-03T13:28:05.933' AS DateTime), CAST(N'2024-07-03T13:28:05.933' AS DateTime))
GO
INSERT [dbo].[Usuario_RedSocial] ([idRed], [idUsuario], [likes], [comentario], [fechaCreacion], [fechaModificacion]) VALUES (N'0e93b64e-60c6-4485-b989-825c33becf52', N'96a49ac1-c9c4-4bc1-8d3c-548f37f34828', 0, N'Digiementore', CAST(N'2024-07-03T13:28:15.790' AS DateTime), CAST(N'2024-07-03T13:28:15.790' AS DateTime))
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'701e4b94-1e54-4de4-9128-239ded5eaa06', N'f42329d1-edaa-4f2c-9ae1-8f026c92c842', -1, -1, -1, CAST(N'2024-05-17T12:01:03.487' AS DateTime), CAST(N'2024-05-17T12:09:44.280' AS DateTime), 1, CAST(N'2024-05-17T12:01:03.487' AS DateTime), 0, 0, -1, -1)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'27c5527f-3ea3-431b-bedf-65841eaf5663', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', 11, 65000, -1, CAST(N'2024-03-28T18:32:02.993' AS DateTime), CAST(N'2024-04-23T08:59:53.437' AS DateTime), 1, CAST(N'2024-03-28T18:32:02.993' AS DateTime), 0, 0, 0, 0)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'27c5527f-3ea3-431b-bedf-65841eaf5663', N'91331754-1e83-417f-90e7-0e596e996510', 0, 0, 0, CAST(N'2024-03-07T16:07:10.130' AS DateTime), CAST(N'2024-03-07T16:07:10.130' AS DateTime), 0, CAST(N'2024-03-07T16:39:54.333' AS DateTime), 0, 0, 0, 0)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'27c5527f-3ea3-431b-bedf-65841eaf5663', N'939c9c6d-9dcf-4b7e-bea6-5c26169fa066', 0, 0, 0, CAST(N'2024-03-07T16:07:10.130' AS DateTime), CAST(N'2024-03-07T16:07:10.130' AS DateTime), 0, CAST(N'2024-03-07T16:39:54.333' AS DateTime), 0, 0, 0, 0)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'0b3439f9-f94d-4e28-b758-89668b4d020f', N'91db7bae-7d2f-423d-b595-d227c63ca0a6', 0, 0, 0, CAST(N'2024-05-30T18:05:23.590' AS DateTime), CAST(N'2024-05-30T18:05:23.590' AS DateTime), 2, CAST(N'2024-05-30T18:05:23.590' AS DateTime), 0, 0, -1, -1)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'27c5527f-3ea3-431b-bedf-65841eaf5663', N'f42329d1-edaa-4f2c-9ae1-8f026c92c842', 10, 100, -1, CAST(N'2024-03-07T16:07:10.130' AS DateTime), CAST(N'2024-03-29T16:43:08.860' AS DateTime), 1, CAST(N'2024-03-07T16:39:54.333' AS DateTime), 0, 0, 0, 0)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'd9ca3dcb-ee6a-4f35-ae4c-719843510a1a', N'015e40dd-58ce-401e-a0a9-075874bc0b68', 0, 0, 0, CAST(N'2024-04-12T10:25:43.477' AS DateTime), CAST(N'2024-04-12T10:25:43.477' AS DateTime), 0, CAST(N'2024-04-12T10:25:43.477' AS DateTime), 1, 0, 0, 0)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'27c5527f-3ea3-431b-bedf-65841eaf5663', N'015e40dd-58ce-401e-a0a9-075874bc0b68', 0, 0, 0, CAST(N'2024-04-09T13:00:16.287' AS DateTime), CAST(N'2024-04-09T13:00:16.287' AS DateTime), 0, CAST(N'2024-04-09T13:00:16.287' AS DateTime), 0, 0, 0, 0)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'428164a1-24f7-4c0c-8a6c-6278c23bffb5', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', 0, 0, 0, CAST(N'2024-05-13T15:22:54.850' AS DateTime), CAST(N'2024-05-13T15:22:54.850' AS DateTime), 0, CAST(N'2024-05-13T15:22:54.850' AS DateTime), 0, 0, -1, -1)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'701e4b94-1e54-4de4-9128-239ded5eaa06', N'6d3a6b25-c6c7-4ed4-a5e9-d992b1cc98a7', -1, -1, -1, CAST(N'2024-05-17T12:01:13.993' AS DateTime), CAST(N'2024-05-17T12:08:45.630' AS DateTime), 1, CAST(N'2024-05-17T12:01:13.993' AS DateTime), 0, 0, -1, -1)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'701e4b94-1e54-4de4-9128-239ded5eaa06', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', -1, -1, -1, CAST(N'2024-05-14T17:11:05.480' AS DateTime), CAST(N'2024-05-17T12:10:36.363' AS DateTime), 1, CAST(N'2024-05-14T17:11:05.480' AS DateTime), 0, 0, -1, -1)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'701e4b94-1e54-4de4-9128-239ded5eaa06', N'015e40dd-58ce-401e-a0a9-075874bc0b68', -1, -1, -1, CAST(N'2024-05-17T12:01:28.993' AS DateTime), CAST(N'2024-05-17T12:07:41.987' AS DateTime), 1, CAST(N'2024-05-17T12:01:28.993' AS DateTime), 0, 0, -1, -1)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'fac2338b-35d6-4cba-9cfb-d02bf4c33e60', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', 0, 0, 0, CAST(N'2024-05-18T20:08:41.377' AS DateTime), CAST(N'2024-05-18T20:08:41.377' AS DateTime), 0, CAST(N'2024-05-18T20:08:41.377' AS DateTime), 0, 0, 0, 0)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'13590568-b03d-45a8-8a13-cf2ebae6f9b4', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', 3, -1, -1, CAST(N'2024-05-19T18:08:25.113' AS DateTime), CAST(N'2024-05-31T15:10:15.570' AS DateTime), 1, CAST(N'2024-05-19T18:08:25.113' AS DateTime), 0, 0, -1, -1)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'1895c363-0443-4e24-b55d-3f410c435d23', N'91db7bae-7d2f-423d-b595-d227c63ca0a6', -1, -1, -1, CAST(N'2024-05-24T11:26:29.977' AS DateTime), CAST(N'2024-05-24T11:26:29.977' AS DateTime), 0, CAST(N'2024-05-24T11:26:29.977' AS DateTime), 0, 1, -1, -1)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'1895c363-0443-4e24-b55d-3f410c435d23', N'6d3a6b25-c6c7-4ed4-a5e9-d992b1cc98a7', -1, -1, -1, CAST(N'2024-05-24T11:26:29.977' AS DateTime), CAST(N'2024-05-24T11:26:29.977' AS DateTime), 0, CAST(N'2024-05-24T11:26:29.977' AS DateTime), 0, 1, -1, -1)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'1895c363-0443-4e24-b55d-3f410c435d23', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', -1, -1, -1, CAST(N'2024-05-24T11:26:29.977' AS DateTime), CAST(N'2024-05-24T11:26:29.977' AS DateTime), 0, CAST(N'2024-05-24T11:26:29.977' AS DateTime), 0, 1, -1, -1)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'1895c363-0443-4e24-b55d-3f410c435d23', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', 23, -1, -1, CAST(N'2024-05-25T12:45:49.137' AS DateTime), CAST(N'2024-05-30T15:15:11.027' AS DateTime), 1, CAST(N'2024-05-25T12:45:49.137' AS DateTime), 0, 0, -1, -1)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'a2c5de8f-b48a-49d3-ad4d-06a664b321d3', N'939c9c6d-9dcf-4b7e-bea6-5c26169fa066', -1, -1, -1, CAST(N'2024-05-28T14:42:00.330' AS DateTime), CAST(N'2024-05-28T14:42:00.330' AS DateTime), 0, CAST(N'2024-05-28T14:42:00.330' AS DateTime), 0, 1, -1, -1)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'a2c5de8f-b48a-49d3-ad4d-06a664b321d3', N'6d3a6b25-c6c7-4ed4-a5e9-d992b1cc98a7', -1, -1, -1, CAST(N'2024-05-28T14:42:00.330' AS DateTime), CAST(N'2024-05-29T09:40:37.780' AS DateTime), 0, CAST(N'2024-05-28T14:42:00.330' AS DateTime), 0, 1, -1, -1)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'a2c5de8f-b48a-49d3-ad4d-06a664b321d3', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', 0, 1, 1, CAST(N'2024-05-28T14:42:27.050' AS DateTime), CAST(N'2024-05-28T14:47:01.210' AS DateTime), 2, CAST(N'2024-05-28T14:42:27.050' AS DateTime), 0, 0, -1, -1)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'a2c5de8f-b48a-49d3-ad4d-06a664b321d3', N'6d3a6b25-c6c7-4ed4-a5e9-d992b1cc98a7', 0, 1, 1, CAST(N'2024-05-29T09:33:05.013' AS DateTime), CAST(N'2024-05-29T09:40:37.780' AS DateTime), 2, CAST(N'2024-05-29T09:33:05.013' AS DateTime), 0, 0, -1, -1)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'1895c363-0443-4e24-b55d-3f410c435d23', N'939c9c6d-9dcf-4b7e-bea6-5c26169fa066', -1, -1, -1, CAST(N'2024-05-29T10:09:09.580' AS DateTime), CAST(N'2024-05-29T10:09:09.580' AS DateTime), 0, CAST(N'2024-05-29T10:09:09.580' AS DateTime), 0, 1, -1, -1)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'66db6640-2b72-43cc-971e-3d0822429acb', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', -1, -1, -1, CAST(N'2024-05-30T15:53:34.180' AS DateTime), CAST(N'2024-05-30T15:53:34.180' AS DateTime), 0, CAST(N'2024-05-30T15:53:34.180' AS DateTime), 0, 1, -1, -1)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'66db6640-2b72-43cc-971e-3d0822429acb', N'6d3a6b25-c6c7-4ed4-a5e9-d992b1cc98a7', 0, 0, 0, CAST(N'2024-05-30T15:53:58.437' AS DateTime), CAST(N'2024-05-30T15:53:58.437' AS DateTime), 0, CAST(N'2024-05-30T15:53:58.437' AS DateTime), 0, 0, -1, -1)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'66db6640-2b72-43cc-971e-3d0822429acb', N'015e40dd-58ce-401e-a0a9-075874bc0b68', 0, -1, -1, CAST(N'2024-05-30T15:54:12.280' AS DateTime), CAST(N'2024-05-30T16:28:19.203' AS DateTime), 2, CAST(N'2024-05-30T15:54:12.280' AS DateTime), 0, 0, -1, -1)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'1e42d6e2-6323-4ac6-917c-dc1727f5e49d', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', 0, 0, 0, CAST(N'2024-05-31T15:03:02.820' AS DateTime), CAST(N'2024-05-31T15:03:02.820' AS DateTime), 0, CAST(N'2024-05-31T15:03:02.820' AS DateTime), 0, 0, 0, 0)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'1e42d6e2-6323-4ac6-917c-dc1727f5e49d', N'015e40dd-58ce-401e-a0a9-075874bc0b68', 0, 0, 0, CAST(N'2024-05-31T15:03:20.630' AS DateTime), CAST(N'2024-05-31T15:03:20.630' AS DateTime), 0, CAST(N'2024-05-31T15:03:20.630' AS DateTime), 0, 0, 0, 0)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'1e42d6e2-6323-4ac6-917c-dc1727f5e49d', N'91331754-1e83-417f-90e7-0e596e996510', 0, 0, 0, CAST(N'2024-05-31T15:03:44.373' AS DateTime), CAST(N'2024-05-31T15:03:44.373' AS DateTime), 0, CAST(N'2024-05-31T15:03:44.373' AS DateTime), 0, 0, 0, 0)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'755c0488-101c-4b21-a866-e637e3e3e778', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', -1, -1, -1, CAST(N'2024-05-31T15:24:52.640' AS DateTime), CAST(N'2024-05-31T15:24:52.640' AS DateTime), 0, CAST(N'2024-05-31T15:24:52.640' AS DateTime), 0, 1, 0, 0)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'755c0488-101c-4b21-a866-e637e3e3e778', N'91331754-1e83-417f-90e7-0e596e996510', -1, -1, -1, CAST(N'2024-05-31T15:24:52.643' AS DateTime), CAST(N'2024-05-31T15:24:52.643' AS DateTime), 0, CAST(N'2024-05-31T15:24:52.643' AS DateTime), 0, 1, 0, 0)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'e83ae36c-fe6d-416c-bd0f-64581fe00881', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', -1, -1, -1, CAST(N'2024-05-31T15:46:40.350' AS DateTime), CAST(N'2024-05-31T15:46:40.350' AS DateTime), 2, CAST(N'2024-05-31T15:46:40.350' AS DateTime), 0, 1, 0, 0)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'e83ae36c-fe6d-416c-bd0f-64581fe00881', N'91331754-1e83-417f-90e7-0e596e996510', -1, -1, -1, CAST(N'2024-05-31T15:46:40.350' AS DateTime), CAST(N'2024-05-31T15:46:40.350' AS DateTime), 2, CAST(N'2024-05-31T15:46:40.350' AS DateTime), 0, 1, 0, 0)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'e83ae36c-fe6d-416c-bd0f-64581fe00881', N'f42329d1-edaa-4f2c-9ae1-8f026c92c842', -1, -1, -1, CAST(N'2024-05-31T15:46:40.350' AS DateTime), CAST(N'2024-05-31T15:46:40.350' AS DateTime), 2, CAST(N'2024-05-31T15:46:40.350' AS DateTime), 0, 1, 0, 0)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'e83ae36c-fe6d-416c-bd0f-64581fe00881', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', 0, 0, 0, CAST(N'2024-05-31T15:47:00.167' AS DateTime), CAST(N'2024-05-31T15:47:00.167' AS DateTime), 2, CAST(N'2024-05-31T15:47:00.167' AS DateTime), 0, 0, 0, 0)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'66db6640-2b72-43cc-971e-3d0822429acb', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', 0, 0, 0, CAST(N'2024-06-03T12:50:00.613' AS DateTime), CAST(N'2024-06-03T12:50:00.613' AS DateTime), 0, CAST(N'2024-06-03T12:50:00.613' AS DateTime), 0, 0, 0, 0)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'355785e0-e045-437a-891a-e20d0b9ff1a6', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', -1, -1, -1, CAST(N'2024-06-06T10:56:31.283' AS DateTime), CAST(N'2024-06-06T10:56:31.283' AS DateTime), 0, CAST(N'2024-06-06T10:56:31.283' AS DateTime), 0, 1, -1, -1)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'355785e0-e045-437a-891a-e20d0b9ff1a6', N'91331754-1e83-417f-90e7-0e596e996510', -1, -1, -1, CAST(N'2024-06-06T10:56:31.287' AS DateTime), CAST(N'2024-06-06T10:56:31.287' AS DateTime), 0, CAST(N'2024-06-06T10:56:31.287' AS DateTime), 0, 1, -1, -1)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'355785e0-e045-437a-891a-e20d0b9ff1a6', N'f42329d1-edaa-4f2c-9ae1-8f026c92c842', -1, -1, -1, CAST(N'2024-06-06T10:56:31.287' AS DateTime), CAST(N'2024-06-06T10:56:31.287' AS DateTime), 0, CAST(N'2024-06-06T10:56:31.287' AS DateTime), 0, 1, -1, -1)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'355785e0-e045-437a-891a-e20d0b9ff1a6', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', 0, -1, -1, CAST(N'2024-06-06T10:56:45.843' AS DateTime), CAST(N'2024-06-06T15:55:21.623' AS DateTime), 2, CAST(N'2024-06-06T10:56:45.843' AS DateTime), 0, 0, -1, -1)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'355785e0-e045-437a-891a-e20d0b9ff1a6', N'91db7bae-7d2f-423d-b595-d227c63ca0a6', 0, 0, 0, CAST(N'2024-06-06T10:57:01.207' AS DateTime), CAST(N'2024-06-06T10:57:01.207' AS DateTime), 0, CAST(N'2024-06-06T10:57:01.207' AS DateTime), 0, 0, 0, 0)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'b4bb05a2-dc77-4202-a030-86a09dea7039', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', 0, 0, 0, CAST(N'2024-06-06T17:17:16.707' AS DateTime), CAST(N'2024-06-06T17:17:16.707' AS DateTime), 0, CAST(N'2024-06-06T17:17:16.707' AS DateTime), 0, 0, 0, 0)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'ddf75d8b-e869-4c4b-8a47-547e77e7f632', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', -1, -1, -1, CAST(N'2024-06-10T09:16:43.863' AS DateTime), CAST(N'2024-06-10T09:16:43.863' AS DateTime), 0, CAST(N'2024-06-10T09:16:43.863' AS DateTime), 0, 1, -1, -1)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'ddf75d8b-e869-4c4b-8a47-547e77e7f632', N'f42329d1-edaa-4f2c-9ae1-8f026c92c842', -1, -1, -1, CAST(N'2024-06-10T09:16:43.863' AS DateTime), CAST(N'2024-06-10T09:16:43.863' AS DateTime), 0, CAST(N'2024-06-10T09:16:43.863' AS DateTime), 0, 1, -1, -1)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'ddf75d8b-e869-4c4b-8a47-547e77e7f632', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', 0, -1, -1, CAST(N'2024-06-10T09:20:19.010' AS DateTime), CAST(N'2024-06-10T09:28:06.663' AS DateTime), 2, CAST(N'2024-06-10T09:20:19.010' AS DateTime), 0, 0, -1, -1)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'ddf75d8b-e869-4c4b-8a47-547e77e7f632', N'015e40dd-58ce-401e-a0a9-075874bc0b68', 0, -1, -1, CAST(N'2024-06-11T09:30:38.830' AS DateTime), CAST(N'2024-06-12T17:28:45.627' AS DateTime), 1, CAST(N'2024-06-11T09:30:38.830' AS DateTime), 0, 0, -1, -1)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'ddf75d8b-e869-4c4b-8a47-547e77e7f632', N'f42329d1-edaa-4f2c-9ae1-8f026c92c842', 3, -1, -1, CAST(N'2024-06-11T10:03:30.873' AS DateTime), CAST(N'2024-06-11T10:59:19.810' AS DateTime), 1, CAST(N'2024-06-11T10:03:30.873' AS DateTime), 0, 0, -1, -1)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'0b3439f9-f94d-4e28-b758-89668b4d020f', N'015e40dd-58ce-401e-a0a9-075874bc0b68', 20, -1, -1, CAST(N'2024-06-14T16:09:09.153' AS DateTime), CAST(N'2024-06-14T16:13:39.303' AS DateTime), 1, CAST(N'2024-06-14T16:09:09.153' AS DateTime), 0, 0, -1, -1)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'c214ab54-5ed2-4f61-a075-2196497bab4b', N'f42329d1-edaa-4f2c-9ae1-8f026c92c842', -1, -1, -1, CAST(N'2024-06-17T10:44:56.947' AS DateTime), CAST(N'2024-06-17T10:44:56.947' AS DateTime), 0, CAST(N'2024-06-17T10:44:56.947' AS DateTime), 0, 1, -1, -1)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'c214ab54-5ed2-4f61-a075-2196497bab4b', N'91db7bae-7d2f-423d-b595-d227c63ca0a6', -1, -1, -1, CAST(N'2024-06-17T10:44:56.947' AS DateTime), CAST(N'2024-06-17T10:44:56.947' AS DateTime), 0, CAST(N'2024-06-17T10:44:56.947' AS DateTime), 0, 1, -1, -1)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'c214ab54-5ed2-4f61-a075-2196497bab4b', N'6d3a6b25-c6c7-4ed4-a5e9-d992b1cc98a7', -1, -1, -1, CAST(N'2024-06-17T10:44:56.947' AS DateTime), CAST(N'2024-06-17T10:44:56.947' AS DateTime), 0, CAST(N'2024-06-17T10:44:56.947' AS DateTime), 0, 1, -1, -1)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'c214ab54-5ed2-4f61-a075-2196497bab4b', N'015e40dd-58ce-401e-a0a9-075874bc0b68', -1, -1, -1, CAST(N'2024-06-17T10:44:56.947' AS DateTime), CAST(N'2024-06-17T10:44:56.947' AS DateTime), 0, CAST(N'2024-06-17T10:44:56.947' AS DateTime), 0, 1, -1, -1)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'c214ab54-5ed2-4f61-a075-2196497bab4b', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', 0, -1, -1, CAST(N'2024-06-17T10:45:10.410' AS DateTime), CAST(N'2024-06-18T09:17:53.247' AS DateTime), 2, CAST(N'2024-06-17T10:45:10.410' AS DateTime), 0, 0, -1, -1)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'c214ab54-5ed2-4f61-a075-2196497bab4b', N'f42329d1-edaa-4f2c-9ae1-8f026c92c842', 0, 0, 0, CAST(N'2024-06-18T10:14:09.937' AS DateTime), CAST(N'2024-06-18T10:14:09.937' AS DateTime), 0, CAST(N'2024-06-18T10:14:09.937' AS DateTime), 0, 0, 0, 0)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'c214ab54-5ed2-4f61-a075-2196497bab4b', N'91db7bae-7d2f-423d-b595-d227c63ca0a6', 0, 0, 0, CAST(N'2024-06-18T10:14:20.067' AS DateTime), CAST(N'2024-06-18T10:14:20.067' AS DateTime), 0, CAST(N'2024-06-18T10:14:20.067' AS DateTime), 0, 0, 0, 0)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'c214ab54-5ed2-4f61-a075-2196497bab4b', N'015e40dd-58ce-401e-a0a9-075874bc0b68', 0, 0, 0, CAST(N'2024-06-18T10:14:39.563' AS DateTime), CAST(N'2024-06-18T10:14:39.563' AS DateTime), 0, CAST(N'2024-06-18T10:14:39.563' AS DateTime), 0, 0, 0, 0)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'e11bb04d-bd02-4401-b6d9-f86d528199b4', N'3c0265f2-e809-4439-acb0-e6efb04918e4', 0, 0, 0, CAST(N'2024-06-18T15:56:22.970' AS DateTime), CAST(N'2024-06-18T15:56:22.970' AS DateTime), 2, CAST(N'2024-06-18T15:56:22.970' AS DateTime), 0, 0, 0, 0)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'e11bb04d-bd02-4401-b6d9-f86d528199b4', N'de632913-94cf-4ab1-8350-aa4c9c0b0b52', 0, 0, 0, CAST(N'2024-06-18T15:56:38.117' AS DateTime), CAST(N'2024-06-18T15:56:38.117' AS DateTime), 2, CAST(N'2024-06-18T15:56:38.117' AS DateTime), 0, 0, 0, 0)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'cd41e229-0277-47e5-ac61-5e4399db5183', N'939c9c6d-9dcf-4b7e-bea6-5c26169fa066', -1, -1, -1, CAST(N'2024-06-19T09:26:13.777' AS DateTime), CAST(N'2024-06-19T09:26:13.777' AS DateTime), 0, CAST(N'2024-06-19T09:26:13.777' AS DateTime), 0, 1, -1, -1)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'cd41e229-0277-47e5-ac61-5e4399db5183', N'de632913-94cf-4ab1-8350-aa4c9c0b0b52', 20, -1, -1, CAST(N'2024-06-19T09:28:17.097' AS DateTime), CAST(N'2024-06-19T09:37:26.830' AS DateTime), 1, CAST(N'2024-06-19T09:28:17.097' AS DateTime), 0, 0, -1, -1)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'a10273c0-eb49-43b8-8adf-b8b5c90a87a1', N'939c9c6d-9dcf-4b7e-bea6-5c26169fa066', 0, 0, 0, CAST(N'2024-06-19T09:52:01.420' AS DateTime), CAST(N'2024-06-19T09:52:01.420' AS DateTime), 0, CAST(N'2024-06-19T09:52:01.420' AS DateTime), 0, 0, 0, 0)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'a10273c0-eb49-43b8-8adf-b8b5c90a87a1', N'42c77db8-7fd5-45cb-ab1a-eb331c7dfb61', 0, 0, 0, CAST(N'2024-06-19T09:52:16.573' AS DateTime), CAST(N'2024-06-19T09:52:16.573' AS DateTime), 0, CAST(N'2024-06-19T09:52:16.573' AS DateTime), 0, 0, 0, 0)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'a10273c0-eb49-43b8-8adf-b8b5c90a87a1', N'de632913-94cf-4ab1-8350-aa4c9c0b0b52', 20, -1, -1, CAST(N'2024-06-19T10:02:30.783' AS DateTime), CAST(N'2024-06-19T10:11:28.673' AS DateTime), 1, CAST(N'2024-06-19T10:02:30.783' AS DateTime), 0, 0, -1, -1)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'354e8be8-3d2d-4e42-90b6-8935f7e56ef4', N'de632913-94cf-4ab1-8350-aa4c9c0b0b52', 40, -1, -1, CAST(N'2024-06-19T11:49:05.103' AS DateTime), CAST(N'2024-06-19T11:52:29.380' AS DateTime), 1, CAST(N'2024-06-19T11:49:05.103' AS DateTime), 1, 0, -1, -1)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'354e8be8-3d2d-4e42-90b6-8935f7e56ef4', N'42c77db8-7fd5-45cb-ab1a-eb331c7dfb61', 40, -1, -1, CAST(N'2024-06-19T11:49:05.103' AS DateTime), CAST(N'2024-06-19T11:53:40.793' AS DateTime), 1, CAST(N'2024-06-19T11:49:05.103' AS DateTime), 1, 0, -1, -1)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'39d09ca3-ddbc-4ea2-a21e-7b982d3b7628', N'de632913-94cf-4ab1-8350-aa4c9c0b0b52', -1, -1, -1, CAST(N'2024-06-19T12:08:31.003' AS DateTime), CAST(N'2024-06-19T12:08:31.003' AS DateTime), 2, CAST(N'2024-06-19T12:08:31.003' AS DateTime), 0, 1, -1, -1)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'39d09ca3-ddbc-4ea2-a21e-7b982d3b7628', N'de632913-94cf-4ab1-8350-aa4c9c0b0b52', 30, -1, -1, CAST(N'2024-06-19T12:11:30.487' AS DateTime), CAST(N'2024-06-19T12:12:41.557' AS DateTime), 1, CAST(N'2024-06-19T12:11:30.487' AS DateTime), 1, 0, -1, -1)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'39d09ca3-ddbc-4ea2-a21e-7b982d3b7628', N'42c77db8-7fd5-45cb-ab1a-eb331c7dfb61', 30, -1, -1, CAST(N'2024-06-19T12:11:30.487' AS DateTime), CAST(N'2024-06-19T12:12:52.140' AS DateTime), 1, CAST(N'2024-06-19T12:11:30.487' AS DateTime), 1, 0, -1, -1)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'6e504c05-c240-4a9a-931e-b3ad7e452333', N'96a49ac1-c9c4-4bc1-8d3c-548f37f34828', 0, 0, 0, CAST(N'2024-07-03T11:35:23.280' AS DateTime), CAST(N'2024-07-03T11:35:23.280' AS DateTime), 2, CAST(N'2024-07-03T11:35:23.280' AS DateTime), 0, 0, 0, 0)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'46a95c2a-36ca-472c-8645-a8fb96bf2812', N'96a49ac1-c9c4-4bc1-8d3c-548f37f34828', 100, -1, -1, CAST(N'2024-07-03T11:55:34.090' AS DateTime), CAST(N'2024-07-03T12:00:20.563' AS DateTime), 1, CAST(N'2024-07-03T11:55:34.090' AS DateTime), 0, 0, -1, -1)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'1f05f1db-2c24-435e-a1eb-81fbef77e87b', N'96a49ac1-c9c4-4bc1-8d3c-548f37f34828', 5, -1, -1, CAST(N'2024-07-03T13:22:44.857' AS DateTime), CAST(N'2024-07-03T13:26:24.460' AS DateTime), 1, CAST(N'2024-07-03T13:22:44.857' AS DateTime), 0, 0, -1, -1)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'37cf8fee-91e0-4886-9aea-b1dcf97cbb28', N'de632913-94cf-4ab1-8350-aa4c9c0b0b52', 0, 0, 0, CAST(N'2024-07-03T13:32:58.630' AS DateTime), CAST(N'2024-07-03T13:32:58.630' AS DateTime), 0, CAST(N'2024-07-03T13:32:58.630' AS DateTime), 1, 0, 0, 0)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'37cf8fee-91e0-4886-9aea-b1dcf97cbb28', N'42c77db8-7fd5-45cb-ab1a-eb331c7dfb61', 0, 0, 0, CAST(N'2024-07-03T13:32:58.633' AS DateTime), CAST(N'2024-07-03T13:32:58.633' AS DateTime), 0, CAST(N'2024-07-03T13:32:58.633' AS DateTime), 1, 0, 0, 0)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'37cf8fee-91e0-4886-9aea-b1dcf97cbb28', N'6d81e350-a4f4-4042-a3e9-ef97d985bc2a', 0, 0, 0, CAST(N'2024-07-03T13:32:58.633' AS DateTime), CAST(N'2024-07-03T13:32:58.633' AS DateTime), 0, CAST(N'2024-07-03T13:32:58.633' AS DateTime), 1, 0, 0, 0)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'60713ad9-036a-4f46-8b18-30b37fa1a1c2', N'96a49ac1-c9c4-4bc1-8d3c-548f37f34828', 0, 0, 0, CAST(N'2024-07-03T13:33:20.423' AS DateTime), CAST(N'2024-07-03T13:33:20.423' AS DateTime), 0, CAST(N'2024-07-03T13:33:20.423' AS DateTime), 1, 0, 0, 0)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'2252397c-b7d9-42b4-b171-3a6eda0afaec', N'96a49ac1-c9c4-4bc1-8d3c-548f37f34828', 0, 0, 0, CAST(N'2024-07-03T13:33:20.427' AS DateTime), CAST(N'2024-07-03T13:33:20.427' AS DateTime), 0, CAST(N'2024-07-03T13:33:20.427' AS DateTime), 1, 0, 0, 0)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'39d09ca3-ddbc-4ea2-a21e-7b982d3b7628', N'96a49ac1-c9c4-4bc1-8d3c-548f37f34828', 0, 0, 0, CAST(N'2024-07-03T13:33:20.430' AS DateTime), CAST(N'2024-07-03T13:33:20.430' AS DateTime), 2, CAST(N'2024-07-03T13:33:20.430' AS DateTime), 1, 0, 0, 0)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'ad3048ea-9b72-40b3-8c56-7eb618d833d4', N'96a49ac1-c9c4-4bc1-8d3c-548f37f34828', 0, -1, -1, CAST(N'2024-07-03T13:33:20.430' AS DateTime), CAST(N'2024-07-03T13:36:16.023' AS DateTime), 2, CAST(N'2024-07-03T13:33:20.430' AS DateTime), 1, 0, -1, -1)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'354e8be8-3d2d-4e42-90b6-8935f7e56ef4', N'96a49ac1-c9c4-4bc1-8d3c-548f37f34828', 40, -1, -1, CAST(N'2024-07-03T13:33:20.430' AS DateTime), CAST(N'2024-07-03T13:40:03.140' AS DateTime), 1, CAST(N'2024-07-03T13:33:20.430' AS DateTime), 1, 0, -1, -1)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'1895c363-0443-4e24-b55d-3f410c435d23', N'015e40dd-58ce-401e-a0a9-075874bc0b68', 23, -1, -1, CAST(N'2024-05-29T09:54:49.577' AS DateTime), CAST(N'2024-05-31T15:33:00.447' AS DateTime), 1, CAST(N'2024-05-29T09:54:49.577' AS DateTime), 0, 0, -1, -1)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'a10273c0-eb49-43b8-8adf-b8b5c90a87a1', N'3c0265f2-e809-4439-acb0-e6efb04918e4', 0, 0, 0, CAST(N'2024-06-19T09:52:16.573' AS DateTime), CAST(N'2024-06-19T09:52:16.573' AS DateTime), 0, CAST(N'2024-06-19T09:52:16.573' AS DateTime), 0, 0, 0, 0)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'60713ad9-036a-4f46-8b18-30b37fa1a1c2', N'6d81e350-a4f4-4042-a3e9-ef97d985bc2a', 0, 0, 0, CAST(N'2024-06-25T11:22:43.830' AS DateTime), CAST(N'2024-06-25T11:22:43.830' AS DateTime), 0, CAST(N'2024-06-25T11:22:43.830' AS DateTime), 1, 0, 0, 0)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'2252397c-b7d9-42b4-b171-3a6eda0afaec', N'6d81e350-a4f4-4042-a3e9-ef97d985bc2a', 0, 0, 0, CAST(N'2024-06-25T11:22:43.830' AS DateTime), CAST(N'2024-06-25T11:22:43.830' AS DateTime), 0, CAST(N'2024-06-25T11:22:43.830' AS DateTime), 1, 0, 0, 0)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'39d09ca3-ddbc-4ea2-a21e-7b982d3b7628', N'6d81e350-a4f4-4042-a3e9-ef97d985bc2a', 0, 0, 0, CAST(N'2024-06-25T11:22:43.830' AS DateTime), CAST(N'2024-06-25T11:22:43.830' AS DateTime), 2, CAST(N'2024-06-25T11:22:43.830' AS DateTime), 1, 0, 0, 0)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'ad3048ea-9b72-40b3-8c56-7eb618d833d4', N'6d81e350-a4f4-4042-a3e9-ef97d985bc2a', 0, 0, 0, CAST(N'2024-06-25T11:22:43.830' AS DateTime), CAST(N'2024-06-25T11:22:43.830' AS DateTime), 0, CAST(N'2024-06-25T11:22:43.830' AS DateTime), 1, 0, 0, 0)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'354e8be8-3d2d-4e42-90b6-8935f7e56ef4', N'6d81e350-a4f4-4042-a3e9-ef97d985bc2a', 40, -1, -1, CAST(N'2024-06-25T11:22:43.833' AS DateTime), CAST(N'2024-06-25T11:25:17.600' AS DateTime), 1, CAST(N'2024-06-25T11:22:43.833' AS DateTime), 1, 0, -1, -1)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'ef9c1644-f977-43e0-b47c-06699fc22d5d', N'96a49ac1-c9c4-4bc1-8d3c-548f37f34828', 0, 0, 0, CAST(N'2024-07-03T12:23:50.530' AS DateTime), CAST(N'2024-07-03T12:23:50.530' AS DateTime), 0, CAST(N'2024-07-03T12:23:50.530' AS DateTime), 0, 0, 0, 0)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'1f05f1db-2c24-435e-a1eb-81fbef77e87b', N'96a49ac1-c9c4-4bc1-8d3c-548f37f34828', -1, -1, -1, CAST(N'2024-07-03T13:21:24.933' AS DateTime), CAST(N'2024-07-03T13:21:24.933' AS DateTime), 2, CAST(N'2024-07-03T13:21:24.933' AS DateTime), 0, 1, -1, -1)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'f66e11b2-6d7e-413b-a7ce-3a1dc068cb67', N'de632913-94cf-4ab1-8350-aa4c9c0b0b52', 0, 0, 0, CAST(N'2024-07-03T14:43:50.060' AS DateTime), CAST(N'2024-07-03T14:43:50.060' AS DateTime), 0, CAST(N'2024-07-03T14:43:50.060' AS DateTime), 1, 0, 0, 0)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'f66e11b2-6d7e-413b-a7ce-3a1dc068cb67', N'42c77db8-7fd5-45cb-ab1a-eb331c7dfb61', 0, 0, 0, CAST(N'2024-07-03T14:43:50.067' AS DateTime), CAST(N'2024-07-03T14:43:50.067' AS DateTime), 0, CAST(N'2024-07-03T14:43:50.067' AS DateTime), 1, 0, 0, 0)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'f66e11b2-6d7e-413b-a7ce-3a1dc068cb67', N'96a49ac1-c9c4-4bc1-8d3c-548f37f34828', 0, 0, 0, CAST(N'2024-07-03T14:43:50.067' AS DateTime), CAST(N'2024-07-03T14:43:50.067' AS DateTime), 0, CAST(N'2024-07-03T14:43:50.067' AS DateTime), 1, 0, 0, 0)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'f66e11b2-6d7e-413b-a7ce-3a1dc068cb67', N'6d81e350-a4f4-4042-a3e9-ef97d985bc2a', 0, 0, 0, CAST(N'2024-07-03T14:43:50.067' AS DateTime), CAST(N'2024-07-03T14:43:50.067' AS DateTime), 0, CAST(N'2024-07-03T14:43:50.067' AS DateTime), 1, 0, 0, 0)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'9f339f9d-c782-475d-9ce6-5f70058f4ab3', N'96a49ac1-c9c4-4bc1-8d3c-548f37f34828', -1, -1, -1, CAST(N'2024-07-03T14:47:02.693' AS DateTime), CAST(N'2024-07-03T14:47:02.693' AS DateTime), 0, CAST(N'2024-07-03T14:47:02.693' AS DateTime), 0, 1, -1, -1)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'9f339f9d-c782-475d-9ce6-5f70058f4ab3', N'de632913-94cf-4ab1-8350-aa4c9c0b0b52', 0, 0, 0, CAST(N'2024-07-03T14:47:27.350' AS DateTime), CAST(N'2024-07-03T14:47:27.350' AS DateTime), 0, CAST(N'2024-07-03T14:47:27.350' AS DateTime), 1, 0, 0, 0)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'9f339f9d-c782-475d-9ce6-5f70058f4ab3', N'42c77db8-7fd5-45cb-ab1a-eb331c7dfb61', 0, 0, 0, CAST(N'2024-07-03T14:47:27.353' AS DateTime), CAST(N'2024-07-03T14:47:27.353' AS DateTime), 0, CAST(N'2024-07-03T14:47:27.353' AS DateTime), 1, 0, 0, 0)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'9f339f9d-c782-475d-9ce6-5f70058f4ab3', N'96a49ac1-c9c4-4bc1-8d3c-548f37f34828', 0, 0, 0, CAST(N'2024-07-03T14:47:27.353' AS DateTime), CAST(N'2024-07-03T14:47:27.353' AS DateTime), 0, CAST(N'2024-07-03T14:47:27.353' AS DateTime), 1, 0, 0, 0)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'9f339f9d-c782-475d-9ce6-5f70058f4ab3', N'6d81e350-a4f4-4042-a3e9-ef97d985bc2a', 0, 0, 0, CAST(N'2024-07-03T14:47:27.353' AS DateTime), CAST(N'2024-07-03T14:47:27.353' AS DateTime), 0, CAST(N'2024-07-03T14:47:27.353' AS DateTime), 1, 0, 0, 0)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'0039af84-1d83-47cf-94f4-ac5b7268aa97', N'96a49ac1-c9c4-4bc1-8d3c-548f37f34828', -1, -1, -1, CAST(N'2024-07-03T14:49:41.240' AS DateTime), CAST(N'2024-07-03T14:49:41.240' AS DateTime), 0, CAST(N'2024-07-03T14:49:41.240' AS DateTime), 0, 1, -1, -1)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'0039af84-1d83-47cf-94f4-ac5b7268aa97', N'de632913-94cf-4ab1-8350-aa4c9c0b0b52', 0, 0, 0, CAST(N'2024-07-03T14:49:50.033' AS DateTime), CAST(N'2024-07-03T14:49:50.033' AS DateTime), 0, CAST(N'2024-07-03T14:49:50.033' AS DateTime), 1, 0, 0, 0)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'0039af84-1d83-47cf-94f4-ac5b7268aa97', N'42c77db8-7fd5-45cb-ab1a-eb331c7dfb61', 0, 0, 0, CAST(N'2024-07-03T14:49:50.037' AS DateTime), CAST(N'2024-07-03T14:49:50.037' AS DateTime), 0, CAST(N'2024-07-03T14:49:50.037' AS DateTime), 1, 0, 0, 0)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'0039af84-1d83-47cf-94f4-ac5b7268aa97', N'96a49ac1-c9c4-4bc1-8d3c-548f37f34828', 25, -1, -1, CAST(N'2024-07-03T14:49:50.037' AS DateTime), CAST(N'2024-07-03T14:50:40.397' AS DateTime), 1, CAST(N'2024-07-03T14:49:50.037' AS DateTime), 1, 0, -1, -1)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'0039af84-1d83-47cf-94f4-ac5b7268aa97', N'6d81e350-a4f4-4042-a3e9-ef97d985bc2a', 25, -1, -1, CAST(N'2024-07-03T14:49:50.040' AS DateTime), CAST(N'2024-07-03T14:57:55.423' AS DateTime), 1, CAST(N'2024-07-03T14:49:50.040' AS DateTime), 1, 0, -1, -1)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'66db6640-2b72-43cc-971e-3d0822429acb', N'91db7bae-7d2f-423d-b595-d227c63ca0a6', 0, 0, 0, CAST(N'2024-05-30T15:54:05.537' AS DateTime), CAST(N'2024-05-30T15:54:05.537' AS DateTime), 0, CAST(N'2024-05-30T15:54:05.537' AS DateTime), 0, 0, -1, -1)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'0b3439f9-f94d-4e28-b758-89668b4d020f', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', -1, -1, -1, CAST(N'2024-05-29T18:14:53.730' AS DateTime), CAST(N'2024-05-29T18:14:53.730' AS DateTime), 0, CAST(N'2024-05-29T18:14:53.730' AS DateTime), 0, 1, -1, -1)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'0b3439f9-f94d-4e28-b758-89668b4d020f', N'f42329d1-edaa-4f2c-9ae1-8f026c92c842', -1, -1, -1, CAST(N'2024-05-29T18:14:53.730' AS DateTime), CAST(N'2024-05-29T18:14:53.730' AS DateTime), 0, CAST(N'2024-05-29T18:14:53.730' AS DateTime), 0, 1, -1, -1)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'0b3439f9-f94d-4e28-b758-89668b4d020f', N'6d3a6b25-c6c7-4ed4-a5e9-d992b1cc98a7', -1, -1, -1, CAST(N'2024-05-29T18:14:53.730' AS DateTime), CAST(N'2024-05-29T18:14:53.730' AS DateTime), 0, CAST(N'2024-05-29T18:14:53.730' AS DateTime), 0, 1, -1, -1)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'd9ca3dcb-ee6a-4f35-ae4c-719843510a1a', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', 0, 80000, 0, CAST(N'2024-04-12T16:27:13.073' AS DateTime), CAST(N'2024-05-14T17:17:26.690' AS DateTime), 1, CAST(N'2024-04-12T16:27:13.073' AS DateTime), 1, 0, 0, 0)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'ddf75d8b-e869-4c4b-8a47-547e77e7f632', N'6d3a6b25-c6c7-4ed4-a5e9-d992b1cc98a7', 3, -1, -1, CAST(N'2024-06-11T10:08:13.817' AS DateTime), CAST(N'2024-06-12T17:28:17.860' AS DateTime), 1, CAST(N'2024-06-11T10:08:13.817' AS DateTime), 0, 0, -1, -1)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'755c0488-101c-4b21-a866-e637e3e3e778', N'f42329d1-edaa-4f2c-9ae1-8f026c92c842', -1, -1, -1, CAST(N'2024-05-31T15:24:52.643' AS DateTime), CAST(N'2024-05-31T15:24:52.643' AS DateTime), 0, CAST(N'2024-05-31T15:24:52.643' AS DateTime), 0, 1, 0, 0)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'755c0488-101c-4b21-a866-e637e3e3e778', N'91db7bae-7d2f-423d-b595-d227c63ca0a6', 0, 0, 0, CAST(N'2024-05-31T17:41:32.423' AS DateTime), CAST(N'2024-05-31T17:41:32.423' AS DateTime), 0, CAST(N'2024-05-31T17:41:32.423' AS DateTime), 0, 0, 0, 0)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'7eae11eb-d3b7-4b4f-90c1-287373c64e57', N'de632913-94cf-4ab1-8350-aa4c9c0b0b52', 0, 0, 0, CAST(N'2024-06-18T16:30:03.303' AS DateTime), CAST(N'2024-06-18T16:30:03.303' AS DateTime), 0, CAST(N'2024-06-18T16:30:03.303' AS DateTime), 0, 0, 0, 0)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'755c0488-101c-4b21-a866-e637e3e3e778', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', 0, -1, -1, CAST(N'2024-05-31T15:26:47.170' AS DateTime), CAST(N'2024-05-31T15:31:09.820' AS DateTime), 2, CAST(N'2024-05-31T15:26:47.170' AS DateTime), 0, 0, -1, -1)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'0280943a-9140-4e17-a722-dcb3fc4dd725', N'de632913-94cf-4ab1-8350-aa4c9c0b0b52', 2, -1, -1, CAST(N'2024-06-18T17:49:35.870' AS DateTime), CAST(N'2024-06-18T17:50:28.107' AS DateTime), 1, CAST(N'2024-06-18T17:49:35.870' AS DateTime), 0, 0, -1, -1)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'2252397c-b7d9-42b4-b171-3a6eda0afaec', N'de632913-94cf-4ab1-8350-aa4c9c0b0b52', 0, 0, 0, CAST(N'2024-06-19T11:41:11.520' AS DateTime), CAST(N'2024-06-19T11:41:11.520' AS DateTime), 0, CAST(N'2024-06-19T11:41:11.520' AS DateTime), 1, 0, 0, 0)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'2252397c-b7d9-42b4-b171-3a6eda0afaec', N'42c77db8-7fd5-45cb-ab1a-eb331c7dfb61', 0, 0, 0, CAST(N'2024-06-19T11:41:11.523' AS DateTime), CAST(N'2024-06-19T11:41:11.523' AS DateTime), 0, CAST(N'2024-06-19T11:41:11.523' AS DateTime), 1, 0, 0, 0)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'ad3048ea-9b72-40b3-8c56-7eb618d833d4', N'de632913-94cf-4ab1-8350-aa4c9c0b0b52', 5, -1, -1, CAST(N'2024-06-19T11:24:03.980' AS DateTime), CAST(N'2024-06-19T11:27:06.900' AS DateTime), 1, CAST(N'2024-06-19T11:24:03.980' AS DateTime), 1, 0, -1, -1)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'ad3048ea-9b72-40b3-8c56-7eb618d833d4', N'42c77db8-7fd5-45cb-ab1a-eb331c7dfb61', 5, -1, -1, CAST(N'2024-06-19T11:24:03.983' AS DateTime), CAST(N'2024-06-19T11:32:11.247' AS DateTime), 1, CAST(N'2024-06-19T11:24:03.983' AS DateTime), 1, 0, -1, -1)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'60713ad9-036a-4f46-8b18-30b37fa1a1c2', N'de632913-94cf-4ab1-8350-aa4c9c0b0b52', 30, -1, -1, CAST(N'2024-06-19T12:00:42.543' AS DateTime), CAST(N'2024-06-19T12:04:20.107' AS DateTime), 1, CAST(N'2024-06-19T12:00:42.543' AS DateTime), 1, 0, -1, -1)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'60713ad9-036a-4f46-8b18-30b37fa1a1c2', N'42c77db8-7fd5-45cb-ab1a-eb331c7dfb61', 30, -1, -1, CAST(N'2024-06-19T12:00:42.547' AS DateTime), CAST(N'2024-06-19T12:05:25.690' AS DateTime), 1, CAST(N'2024-06-19T12:00:42.547' AS DateTime), 1, 0, -1, -1)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo], [validador], [correctas], [incorrectas]) VALUES (N'37cf8fee-91e0-4886-9aea-b1dcf97cbb28', N'96a49ac1-c9c4-4bc1-8d3c-548f37f34828', 0, 0, 0, CAST(N'2024-07-03T13:33:20.430' AS DateTime), CAST(N'2024-07-03T13:33:20.430' AS DateTime), 0, CAST(N'2024-07-03T13:33:20.430' AS DateTime), 1, 0, 0, 0)
GO
INSERT [dbo].[UsuarioxArchivo] ([idReto], [idUsuario], [archivo], [fechaCreacion], [fechaModificacion], [url]) VALUES (N'a2c5de8f-b48a-49d3-ad4d-06a664b321d3', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', N'Mi última prueba de recoleccio_9b7fb2f0-5ac5-495c-a99c-936bad4f9ed1.xlsx', CAST(N'2024-05-28T14:47:01.223' AS DateTime), CAST(N'2024-05-28T14:47:01.223' AS DateTime), NULL)
GO
INSERT [dbo].[UsuarioxArchivo] ([idReto], [idUsuario], [archivo], [fechaCreacion], [fechaModificacion], [url]) VALUES (N'a2c5de8f-b48a-49d3-ad4d-06a664b321d3', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', N'Mi última prueba de recoleccio_428142dc-6222-42ac-bf96-9a01dabd7d65.xlsx', CAST(N'2024-05-28T14:47:01.227' AS DateTime), CAST(N'2024-05-28T14:47:01.227' AS DateTime), NULL)
GO
INSERT [dbo].[UsuarioxArchivo] ([idReto], [idUsuario], [archivo], [fechaCreacion], [fechaModificacion], [url]) VALUES (N'a2c5de8f-b48a-49d3-ad4d-06a664b321d3', N'6d3a6b25-c6c7-4ed4-a5e9-d992b1cc98a7', N'Mi última prueba de recoleccio_c5ec15cc-1118-4e1d-a9fc-5389756e9994.xlsx', CAST(N'2024-05-29T09:40:37.800' AS DateTime), CAST(N'2024-05-29T09:40:37.800' AS DateTime), NULL)
GO
INSERT [dbo].[UsuarioxArchivo] ([idReto], [idUsuario], [archivo], [fechaCreacion], [fechaModificacion], [url]) VALUES (N'a2c5de8f-b48a-49d3-ad4d-06a664b321d3', N'6d3a6b25-c6c7-4ed4-a5e9-d992b1cc98a7', N'Mi última prueba de recoleccio_009c42e2-f97b-452a-82cd-11f0df1a4737.xlsx', CAST(N'2024-05-29T09:40:37.800' AS DateTime), CAST(N'2024-05-29T09:40:37.800' AS DateTime), NULL)
GO
INSERT [dbo].[UsuarioxArchivo] ([idReto], [idUsuario], [archivo], [fechaCreacion], [fechaModificacion], [url]) VALUES (N'1895c363-0443-4e24-b55d-3f410c435d23', N'015e40dd-58ce-401e-a0a9-075874bc0b68', N'Mi reto de recolección_61abc9ca-83ee-4c88-a369-ee7fd4f8a042.xlsx', CAST(N'2024-05-29T09:58:07.247' AS DateTime), CAST(N'2024-05-29T09:58:07.247' AS DateTime), NULL)
GO
INSERT [dbo].[UsuarioxArchivo] ([idReto], [idUsuario], [archivo], [fechaCreacion], [fechaModificacion], [url]) VALUES (N'1895c363-0443-4e24-b55d-3f410c435d23', N'015e40dd-58ce-401e-a0a9-075874bc0b68', N'Mi reto de recolección_1d0468e2-c100-41f1-abed-7b6b6e1eff86.xlsx', CAST(N'2024-05-29T09:58:07.250' AS DateTime), CAST(N'2024-05-29T09:58:07.250' AS DateTime), NULL)
GO
INSERT [dbo].[UsuarioxArchivo] ([idReto], [idUsuario], [archivo], [fechaCreacion], [fechaModificacion], [url]) VALUES (N'66db6640-2b72-43cc-971e-3d0822429acb', N'015e40dd-58ce-401e-a0a9-075874bc0b68', N'66db6640-2b72-43cc-971e-3d0822429acb_c8c33156-bcb2-479d-88f7-5ff5d73c58c0.png', CAST(N'2024-05-30T16:28:19.220' AS DateTime), CAST(N'2024-05-30T16:28:19.220' AS DateTime), NULL)
GO
INSERT [dbo].[UsuarioxArchivo] ([idReto], [idUsuario], [archivo], [fechaCreacion], [fechaModificacion], [url]) VALUES (N'66db6640-2b72-43cc-971e-3d0822429acb', N'015e40dd-58ce-401e-a0a9-075874bc0b68', N'66db6640-2b72-43cc-971e-3d0822429acb_7368d11b-a993-4f43-9c10-833b0f7178bc.jpg', CAST(N'2024-05-30T16:28:19.223' AS DateTime), CAST(N'2024-05-30T16:28:19.223' AS DateTime), NULL)
GO
INSERT [dbo].[UsuarioxArchivo] ([idReto], [idUsuario], [archivo], [fechaCreacion], [fechaModificacion], [url]) VALUES (N'66db6640-2b72-43cc-971e-3d0822429acb', N'015e40dd-58ce-401e-a0a9-075874bc0b68', N'66db6640-2b72-43cc-971e-3d0822429acb_2ec9b9bc-0b33-4e06-b5e3-e08321d62ba2.png', CAST(N'2024-05-30T16:28:19.223' AS DateTime), CAST(N'2024-05-30T16:28:19.223' AS DateTime), NULL)
GO
INSERT [dbo].[UsuarioxArchivo] ([idReto], [idUsuario], [archivo], [fechaCreacion], [fechaModificacion], [url]) VALUES (N'755c0488-101c-4b21-a866-e637e3e3e778', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', N'755c0488-101c-4b21-a866-e637e3e3e778_9d03ab06-a0cb-47d4-9248-996c0eef6e6b.jpg', CAST(N'2024-05-31T15:31:09.837' AS DateTime), CAST(N'2024-05-31T15:31:09.837' AS DateTime), NULL)
GO
INSERT [dbo].[UsuarioxArchivo] ([idReto], [idUsuario], [archivo], [fechaCreacion], [fechaModificacion], [url]) VALUES (N'755c0488-101c-4b21-a866-e637e3e3e778', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', N'755c0488-101c-4b21-a866-e637e3e3e778_40c0c070-4fe8-475a-ba83-9cab1ddb9c2e.png', CAST(N'2024-05-31T15:31:09.840' AS DateTime), CAST(N'2024-05-31T15:31:09.840' AS DateTime), NULL)
GO
INSERT [dbo].[UsuarioxArchivo] ([idReto], [idUsuario], [archivo], [fechaCreacion], [fechaModificacion], [url]) VALUES (N'755c0488-101c-4b21-a866-e637e3e3e778', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', N'755c0488-101c-4b21-a866-e637e3e3e778_311dca70-c350-4c1e-a54d-4ee00d25cf28.png', CAST(N'2024-05-31T15:31:09.840' AS DateTime), CAST(N'2024-05-31T15:31:09.840' AS DateTime), NULL)
GO
INSERT [dbo].[UsuarioxArchivo] ([idReto], [idUsuario], [archivo], [fechaCreacion], [fechaModificacion], [url]) VALUES (N'355785e0-e045-437a-891a-e20d0b9ff1a6', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', N'url_3d5a028e-5ef0-4269-9c5f-0aedb4b55a61', CAST(N'2024-06-06T15:55:21.660' AS DateTime), CAST(N'2024-06-06T15:55:21.660' AS DateTime), N'https://www.youtube.com/watch?v=hXDMWeD0ERM&t=51s')
GO
INSERT [dbo].[UsuarioxArchivo] ([idReto], [idUsuario], [archivo], [fechaCreacion], [fechaModificacion], [url]) VALUES (N'355785e0-e045-437a-891a-e20d0b9ff1a6', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', N'url_ebb17b01-3fca-4f64-b8ed-0489cba70cc0', CAST(N'2024-06-06T15:55:21.660' AS DateTime), CAST(N'2024-06-06T15:55:21.660' AS DateTime), N'https://www.youtube.com/watch?v=KojoBGleqH8')
GO
INSERT [dbo].[UsuarioxArchivo] ([idReto], [idUsuario], [archivo], [fechaCreacion], [fechaModificacion], [url]) VALUES (N'355785e0-e045-437a-891a-e20d0b9ff1a6', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', N'url_e451f3c0-4b92-4720-ac13-ac9e8e4bbaee', CAST(N'2024-06-06T15:55:21.660' AS DateTime), CAST(N'2024-06-06T15:55:21.660' AS DateTime), N'https://vimeo.com/944603525?share=copy')
GO
INSERT [dbo].[UsuarioxArchivo] ([idReto], [idUsuario], [archivo], [fechaCreacion], [fechaModificacion], [url]) VALUES (N'355785e0-e045-437a-891a-e20d0b9ff1a6', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', N'url_71dfd470-ad7f-4453-8005-3e1462f3a40e', CAST(N'2024-06-06T15:55:21.660' AS DateTime), CAST(N'2024-06-06T15:55:21.660' AS DateTime), N'https://vimeo.com/848451790?share=copy')
GO
INSERT [dbo].[UsuarioxArchivo] ([idReto], [idUsuario], [archivo], [fechaCreacion], [fechaModificacion], [url]) VALUES (N'ddf75d8b-e869-4c4b-8a47-547e77e7f632', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', N'ddf75d8b-e869-4c4b-8a47-547e77e7f632_e7def6ff-f6bf-4f3b-9316-e7d1e047c2ff.xlsx', CAST(N'2024-06-10T09:28:06.683' AS DateTime), CAST(N'2024-06-10T09:28:06.683' AS DateTime), NULL)
GO
INSERT [dbo].[UsuarioxArchivo] ([idReto], [idUsuario], [archivo], [fechaCreacion], [fechaModificacion], [url]) VALUES (N'ddf75d8b-e869-4c4b-8a47-547e77e7f632', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', N'ddf75d8b-e869-4c4b-8a47-547e77e7f632_f7212d34-b384-4684-a1f7-a8c24bd5cbeb.xlsx', CAST(N'2024-06-10T09:28:06.683' AS DateTime), CAST(N'2024-06-10T09:28:06.683' AS DateTime), NULL)
GO
INSERT [dbo].[UsuarioxArchivo] ([idReto], [idUsuario], [archivo], [fechaCreacion], [fechaModificacion], [url]) VALUES (N'ddf75d8b-e869-4c4b-8a47-547e77e7f632', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', N'ddf75d8b-e869-4c4b-8a47-547e77e7f632_d3dab125-06d4-4ab6-a54e-d503ab3b6a68.xlsx', CAST(N'2024-06-10T09:28:06.687' AS DateTime), CAST(N'2024-06-10T09:28:06.687' AS DateTime), NULL)
GO
INSERT [dbo].[UsuarioxArchivo] ([idReto], [idUsuario], [archivo], [fechaCreacion], [fechaModificacion], [url]) VALUES (N'ddf75d8b-e869-4c4b-8a47-547e77e7f632', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', N'ddf75d8b-e869-4c4b-8a47-547e77e7f632_a41074f6-b79f-4958-9743-5027ebfda18a.xlsx', CAST(N'2024-06-10T09:28:06.687' AS DateTime), CAST(N'2024-06-10T09:28:06.687' AS DateTime), NULL)
GO
INSERT [dbo].[UsuarioxArchivo] ([idReto], [idUsuario], [archivo], [fechaCreacion], [fechaModificacion], [url]) VALUES (N'ddf75d8b-e869-4c4b-8a47-547e77e7f632', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', N'ddf75d8b-e869-4c4b-8a47-547e77e7f632_44379290-7057-4824-bc4a-0514048c740e.xlsx', CAST(N'2024-06-10T09:28:06.687' AS DateTime), CAST(N'2024-06-10T09:28:06.687' AS DateTime), NULL)
GO
INSERT [dbo].[UsuarioxArchivo] ([idReto], [idUsuario], [archivo], [fechaCreacion], [fechaModificacion], [url]) VALUES (N'ddf75d8b-e869-4c4b-8a47-547e77e7f632', N'015e40dd-58ce-401e-a0a9-075874bc0b68', N'ddf75d8b-e869-4c4b-8a47-547e77e7f632_4f886bfa-9385-4fa4-a860-dd8ba0761054.xlsx', CAST(N'2024-06-11T09:34:33.213' AS DateTime), CAST(N'2024-06-11T09:34:33.213' AS DateTime), NULL)
GO
INSERT [dbo].[UsuarioxArchivo] ([idReto], [idUsuario], [archivo], [fechaCreacion], [fechaModificacion], [url]) VALUES (N'ddf75d8b-e869-4c4b-8a47-547e77e7f632', N'015e40dd-58ce-401e-a0a9-075874bc0b68', N'ddf75d8b-e869-4c4b-8a47-547e77e7f632_4660c931-ddb1-474e-a93f-4be053951696.xlsx', CAST(N'2024-06-11T09:34:33.213' AS DateTime), CAST(N'2024-06-11T09:34:33.213' AS DateTime), NULL)
GO
INSERT [dbo].[UsuarioxArchivo] ([idReto], [idUsuario], [archivo], [fechaCreacion], [fechaModificacion], [url]) VALUES (N'ddf75d8b-e869-4c4b-8a47-547e77e7f632', N'015e40dd-58ce-401e-a0a9-075874bc0b68', N'ddf75d8b-e869-4c4b-8a47-547e77e7f632_47230797-d1ec-4158-bf21-dd4081c362ba.xlsx', CAST(N'2024-06-11T09:34:33.217' AS DateTime), CAST(N'2024-06-11T09:34:33.217' AS DateTime), NULL)
GO
INSERT [dbo].[UsuarioxArchivo] ([idReto], [idUsuario], [archivo], [fechaCreacion], [fechaModificacion], [url]) VALUES (N'ddf75d8b-e869-4c4b-8a47-547e77e7f632', N'015e40dd-58ce-401e-a0a9-075874bc0b68', N'ddf75d8b-e869-4c4b-8a47-547e77e7f632_81fc9855-65c5-4dc9-942c-d3c14f355117.xlsx', CAST(N'2024-06-11T09:34:33.217' AS DateTime), CAST(N'2024-06-11T09:34:33.217' AS DateTime), NULL)
GO
INSERT [dbo].[UsuarioxArchivo] ([idReto], [idUsuario], [archivo], [fechaCreacion], [fechaModificacion], [url]) VALUES (N'ddf75d8b-e869-4c4b-8a47-547e77e7f632', N'015e40dd-58ce-401e-a0a9-075874bc0b68', N'ddf75d8b-e869-4c4b-8a47-547e77e7f632_4c06f72b-b0da-4aec-8312-0d8ed502af88.xlsx', CAST(N'2024-06-11T09:34:33.217' AS DateTime), CAST(N'2024-06-11T09:34:33.217' AS DateTime), NULL)
GO
INSERT [dbo].[UsuarioxArchivo] ([idReto], [idUsuario], [archivo], [fechaCreacion], [fechaModificacion], [url]) VALUES (N'ddf75d8b-e869-4c4b-8a47-547e77e7f632', N'f42329d1-edaa-4f2c-9ae1-8f026c92c842', N'ddf75d8b-e869-4c4b-8a47-547e77e7f632_9a7e1cb2-6da0-4057-9c3d-a4683ab7e345.xlsx', CAST(N'2024-06-11T10:06:07.460' AS DateTime), CAST(N'2024-06-11T10:06:07.460' AS DateTime), NULL)
GO
INSERT [dbo].[UsuarioxArchivo] ([idReto], [idUsuario], [archivo], [fechaCreacion], [fechaModificacion], [url]) VALUES (N'ddf75d8b-e869-4c4b-8a47-547e77e7f632', N'f42329d1-edaa-4f2c-9ae1-8f026c92c842', N'ddf75d8b-e869-4c4b-8a47-547e77e7f632_ec4c9acd-40a7-4ff3-9d67-ca863e8ee00f.xlsx', CAST(N'2024-06-11T10:06:07.460' AS DateTime), CAST(N'2024-06-11T10:06:07.460' AS DateTime), NULL)
GO
INSERT [dbo].[UsuarioxArchivo] ([idReto], [idUsuario], [archivo], [fechaCreacion], [fechaModificacion], [url]) VALUES (N'ddf75d8b-e869-4c4b-8a47-547e77e7f632', N'6d3a6b25-c6c7-4ed4-a5e9-d992b1cc98a7', N'ddf75d8b-e869-4c4b-8a47-547e77e7f632_db752ec1-d397-4a8f-9368-f7d76375c3e8.xlsx', CAST(N'2024-06-11T10:09:13.967' AS DateTime), CAST(N'2024-06-11T10:09:13.967' AS DateTime), NULL)
GO
INSERT [dbo].[UsuarioxArchivo] ([idReto], [idUsuario], [archivo], [fechaCreacion], [fechaModificacion], [url]) VALUES (N'ddf75d8b-e869-4c4b-8a47-547e77e7f632', N'6d3a6b25-c6c7-4ed4-a5e9-d992b1cc98a7', N'ddf75d8b-e869-4c4b-8a47-547e77e7f632_b1a6a372-4c83-4021-8170-d31699ca3db6.xlsx', CAST(N'2024-06-11T10:09:13.970' AS DateTime), CAST(N'2024-06-11T10:09:13.970' AS DateTime), NULL)
GO
INSERT [dbo].[UsuarioxArchivo] ([idReto], [idUsuario], [archivo], [fechaCreacion], [fechaModificacion], [url]) VALUES (N'ddf75d8b-e869-4c4b-8a47-547e77e7f632', N'6d3a6b25-c6c7-4ed4-a5e9-d992b1cc98a7', N'ddf75d8b-e869-4c4b-8a47-547e77e7f632_14b72006-2c7d-48e0-96f8-ca0bcbd716c6.xlsx', CAST(N'2024-06-11T10:09:13.970' AS DateTime), CAST(N'2024-06-11T10:09:13.970' AS DateTime), NULL)
GO
INSERT [dbo].[UsuarioxArchivo] ([idReto], [idUsuario], [archivo], [fechaCreacion], [fechaModificacion], [url]) VALUES (N'ddf75d8b-e869-4c4b-8a47-547e77e7f632', N'6d3a6b25-c6c7-4ed4-a5e9-d992b1cc98a7', N'ddf75d8b-e869-4c4b-8a47-547e77e7f632_1240fc20-d9d0-4ad4-ac8c-72e534ed53dc.xlsx', CAST(N'2024-06-11T10:09:13.970' AS DateTime), CAST(N'2024-06-11T10:09:13.970' AS DateTime), NULL)
GO
INSERT [dbo].[UsuarioxArchivo] ([idReto], [idUsuario], [archivo], [fechaCreacion], [fechaModificacion], [url]) VALUES (N'ddf75d8b-e869-4c4b-8a47-547e77e7f632', N'6d3a6b25-c6c7-4ed4-a5e9-d992b1cc98a7', N'ddf75d8b-e869-4c4b-8a47-547e77e7f632_7a405da8-72e6-4590-957a-897f905f3cb6.xlsx', CAST(N'2024-06-11T10:09:13.970' AS DateTime), CAST(N'2024-06-11T10:09:13.970' AS DateTime), NULL)
GO
INSERT [dbo].[UsuarioxArchivo] ([idReto], [idUsuario], [archivo], [fechaCreacion], [fechaModificacion], [url]) VALUES (N'c214ab54-5ed2-4f61-a075-2196497bab4b', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', N'url_999ec53d-f86a-4e8d-a07c-6d94aced6c83', CAST(N'2024-06-18T09:17:53.260' AS DateTime), CAST(N'2024-06-18T09:17:53.260' AS DateTime), N'1718720044003-2276-Video-0.mp4')
GO
INSERT [dbo].[UsuarioxArchivo] ([idReto], [idUsuario], [archivo], [fechaCreacion], [fechaModificacion], [url]) VALUES (N'c214ab54-5ed2-4f61-a075-2196497bab4b', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', N'url_9e993181-9bf1-42f6-a15d-85a9de885028', CAST(N'2024-06-18T09:17:53.263' AS DateTime), CAST(N'2024-06-18T09:17:53.263' AS DateTime), N'1718720084839-476-Video-1.mp4')
GO
INSERT [dbo].[UsuarioxArchivo] ([idReto], [idUsuario], [archivo], [fechaCreacion], [fechaModificacion], [url]) VALUES (N'cd41e229-0277-47e5-ac61-5e4399db5183', N'de632913-94cf-4ab1-8350-aa4c9c0b0b52', N'cd41e229-0277-47e5-ac61-5e4399db5183_90afdbc3-aa91-4f49-bc3e-e85ee45000af.docx', CAST(N'2024-06-19T09:36:11.930' AS DateTime), CAST(N'2024-06-19T09:36:11.930' AS DateTime), NULL)
GO
INSERT [dbo].[UsuarioxArchivo] ([idReto], [idUsuario], [archivo], [fechaCreacion], [fechaModificacion], [url]) VALUES (N'cd41e229-0277-47e5-ac61-5e4399db5183', N'de632913-94cf-4ab1-8350-aa4c9c0b0b52', N'cd41e229-0277-47e5-ac61-5e4399db5183_8c09aee9-a12a-4d3b-81a3-c785b5dd33cc.docx', CAST(N'2024-06-19T09:36:11.930' AS DateTime), CAST(N'2024-06-19T09:36:11.930' AS DateTime), NULL)
GO
INSERT [dbo].[UsuarioxArchivo] ([idReto], [idUsuario], [archivo], [fechaCreacion], [fechaModificacion], [url]) VALUES (N'cd41e229-0277-47e5-ac61-5e4399db5183', N'de632913-94cf-4ab1-8350-aa4c9c0b0b52', N'cd41e229-0277-47e5-ac61-5e4399db5183_17565dc8-2c2d-4c35-a3ec-c2aad559c093.docx', CAST(N'2024-06-19T09:36:11.930' AS DateTime), CAST(N'2024-06-19T09:36:11.930' AS DateTime), NULL)
GO
INSERT [dbo].[UsuarioxArchivo] ([idReto], [idUsuario], [archivo], [fechaCreacion], [fechaModificacion], [url]) VALUES (N'cd41e229-0277-47e5-ac61-5e4399db5183', N'de632913-94cf-4ab1-8350-aa4c9c0b0b52', N'cd41e229-0277-47e5-ac61-5e4399db5183_ec74f1cd-813e-4388-8b89-afc599f2c924.docx', CAST(N'2024-06-19T09:36:11.933' AS DateTime), CAST(N'2024-06-19T09:36:11.933' AS DateTime), NULL)
GO
INSERT [dbo].[UsuarioxArchivo] ([idReto], [idUsuario], [archivo], [fechaCreacion], [fechaModificacion], [url]) VALUES (N'cd41e229-0277-47e5-ac61-5e4399db5183', N'de632913-94cf-4ab1-8350-aa4c9c0b0b52', N'cd41e229-0277-47e5-ac61-5e4399db5183_c0d6ae70-6bc5-4559-af7e-290dbc5f224a.docx', CAST(N'2024-06-19T09:36:11.933' AS DateTime), CAST(N'2024-06-19T09:36:11.933' AS DateTime), NULL)
GO
INSERT [dbo].[UsuarioxArchivo] ([idReto], [idUsuario], [archivo], [fechaCreacion], [fechaModificacion], [url]) VALUES (N'ad3048ea-9b72-40b3-8c56-7eb618d833d4', N'42c77db8-7fd5-45cb-ab1a-eb331c7dfb61', N'ad3048ea-9b72-40b3-8c56-7eb618d833d4_170944e7-a1a9-4c4d-a931-2fb01b9bdd5f.docx', CAST(N'2024-06-19T11:31:56.700' AS DateTime), CAST(N'2024-06-19T11:31:56.700' AS DateTime), NULL)
GO
INSERT [dbo].[UsuarioxArchivo] ([idReto], [idUsuario], [archivo], [fechaCreacion], [fechaModificacion], [url]) VALUES (N'ad3048ea-9b72-40b3-8c56-7eb618d833d4', N'42c77db8-7fd5-45cb-ab1a-eb331c7dfb61', N'ad3048ea-9b72-40b3-8c56-7eb618d833d4_6ce66adf-f9aa-4526-a5b4-0a835ef3c867.docx', CAST(N'2024-06-19T11:31:56.700' AS DateTime), CAST(N'2024-06-19T11:31:56.700' AS DateTime), NULL)
GO
INSERT [dbo].[UsuarioxArchivo] ([idReto], [idUsuario], [archivo], [fechaCreacion], [fechaModificacion], [url]) VALUES (N'ad3048ea-9b72-40b3-8c56-7eb618d833d4', N'96a49ac1-c9c4-4bc1-8d3c-548f37f34828', N'ad3048ea-9b72-40b3-8c56-7eb618d833d4_13722c07-79b7-4b5d-b5fa-09d633769957.docx', CAST(N'2024-07-03T13:36:16.043' AS DateTime), CAST(N'2024-07-03T13:36:16.043' AS DateTime), NULL)
GO
INSERT [dbo].[UsuarioxArchivo] ([idReto], [idUsuario], [archivo], [fechaCreacion], [fechaModificacion], [url]) VALUES (N'ad3048ea-9b72-40b3-8c56-7eb618d833d4', N'96a49ac1-c9c4-4bc1-8d3c-548f37f34828', N'ad3048ea-9b72-40b3-8c56-7eb618d833d4_db12c788-4aca-450c-9166-1ecc20b28bec.docx', CAST(N'2024-07-03T13:36:16.047' AS DateTime), CAST(N'2024-07-03T13:36:16.047' AS DateTime), NULL)
GO
INSERT [dbo].[UsuarioxArchivo] ([idReto], [idUsuario], [archivo], [fechaCreacion], [fechaModificacion], [url]) VALUES (N'0039af84-1d83-47cf-94f4-ac5b7268aa97', N'6d81e350-a4f4-4042-a3e9-ef97d985bc2a', N'0039af84-1d83-47cf-94f4-ac5b7268aa97_24b6c873-10a7-48ca-a072-c663ec951940.docx', CAST(N'2024-07-03T14:57:02.797' AS DateTime), CAST(N'2024-07-03T14:57:02.797' AS DateTime), NULL)
GO
INSERT [dbo].[UsuarioxArchivo] ([idReto], [idUsuario], [archivo], [fechaCreacion], [fechaModificacion], [url]) VALUES (N'1895c363-0443-4e24-b55d-3f410c435d23', N'015e40dd-58ce-401e-a0a9-075874bc0b68', N'Mi reto de recolección_311449c8-35c4-4ddf-aee7-2bf33adb6af9.xlsx', CAST(N'2024-05-29T09:58:07.250' AS DateTime), CAST(N'2024-05-29T09:58:07.250' AS DateTime), NULL)
GO
INSERT [dbo].[UsuarioxArchivo] ([idReto], [idUsuario], [archivo], [fechaCreacion], [fechaModificacion], [url]) VALUES (N'ad3048ea-9b72-40b3-8c56-7eb618d833d4', N'de632913-94cf-4ab1-8350-aa4c9c0b0b52', N'ad3048ea-9b72-40b3-8c56-7eb618d833d4_e162d517-9870-412e-bd21-242110c54e9d.docx', CAST(N'2024-06-19T11:26:23.277' AS DateTime), CAST(N'2024-06-19T11:26:23.277' AS DateTime), NULL)
GO
INSERT [dbo].[UsuarioxArchivo] ([idReto], [idUsuario], [archivo], [fechaCreacion], [fechaModificacion], [url]) VALUES (N'ad3048ea-9b72-40b3-8c56-7eb618d833d4', N'de632913-94cf-4ab1-8350-aa4c9c0b0b52', N'ad3048ea-9b72-40b3-8c56-7eb618d833d4_f670c15e-9d98-497a-821a-91e86175e8d1.docx', CAST(N'2024-06-19T11:26:23.280' AS DateTime), CAST(N'2024-06-19T11:26:23.280' AS DateTime), NULL)
GO
INSERT [dbo].[UsuarioxArchivo] ([idReto], [idUsuario], [archivo], [fechaCreacion], [fechaModificacion], [url]) VALUES (N'0039af84-1d83-47cf-94f4-ac5b7268aa97', N'96a49ac1-c9c4-4bc1-8d3c-548f37f34828', N'0039af84-1d83-47cf-94f4-ac5b7268aa97_393ca01d-2f24-4474-8eec-71dc34e69237.docx', CAST(N'2024-07-03T14:50:21.117' AS DateTime), CAST(N'2024-07-03T14:50:21.117' AS DateTime), NULL)
GO
INSERT [dbo].[UsuarioxArchivo] ([idReto], [idUsuario], [archivo], [fechaCreacion], [fechaModificacion], [url]) VALUES (N'ddf75d8b-e869-4c4b-8a47-547e77e7f632', N'f42329d1-edaa-4f2c-9ae1-8f026c92c842', N'ddf75d8b-e869-4c4b-8a47-547e77e7f632_cb88ba2a-93d7-4cac-af90-081d8a920cfb.xlsx', CAST(N'2024-06-11T10:06:07.463' AS DateTime), CAST(N'2024-06-11T10:06:07.463' AS DateTime), NULL)
GO
INSERT [dbo].[UsuarioxArchivo] ([idReto], [idUsuario], [archivo], [fechaCreacion], [fechaModificacion], [url]) VALUES (N'ddf75d8b-e869-4c4b-8a47-547e77e7f632', N'f42329d1-edaa-4f2c-9ae1-8f026c92c842', N'ddf75d8b-e869-4c4b-8a47-547e77e7f632_c1c8d933-d2d6-4a7d-8257-2a4e1f26a500.xlsx', CAST(N'2024-06-11T10:06:07.463' AS DateTime), CAST(N'2024-06-11T10:06:07.463' AS DateTime), NULL)
GO
INSERT [dbo].[UsuarioxArchivo] ([idReto], [idUsuario], [archivo], [fechaCreacion], [fechaModificacion], [url]) VALUES (N'ddf75d8b-e869-4c4b-8a47-547e77e7f632', N'f42329d1-edaa-4f2c-9ae1-8f026c92c842', N'ddf75d8b-e869-4c4b-8a47-547e77e7f632_59b18319-c52d-439c-853e-6418ce1bc893.xlsx', CAST(N'2024-06-11T10:06:07.463' AS DateTime), CAST(N'2024-06-11T10:06:07.463' AS DateTime), NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'8c05cbc7-c867-497d-800f-777b52422fc8', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', CAST(N'2024-05-07T12:04:08.507' AS DateTime), CAST(N'2024-05-07T12:04:08.507' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'37f717ff-51bd-4d58-8018-3876f84e5332', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', CAST(N'2024-05-07T12:04:08.510' AS DateTime), CAST(N'2024-05-07T12:04:08.510' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'075c62c0-6316-4f13-a826-115fc857d442', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', CAST(N'2024-05-07T12:04:08.510' AS DateTime), CAST(N'2024-05-07T12:04:08.510' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'4393fbd6-1712-4d00-a4e9-3ef539bfe694', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', CAST(N'2024-05-07T12:04:08.510' AS DateTime), CAST(N'2024-05-07T12:04:08.510' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'6a0c73ff-2d3a-4213-aca4-3f0dc65bceb5', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', CAST(N'2024-05-07T12:04:08.510' AS DateTime), CAST(N'2024-05-07T12:04:08.510' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'6e5c0249-24a5-46f4-b6b1-2446b29cfa51', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', CAST(N'2024-05-07T12:04:08.510' AS DateTime), CAST(N'2024-05-07T12:04:08.510' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'a609891d-8056-49c9-b372-8ae3b7021934', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', CAST(N'2024-05-07T12:04:08.510' AS DateTime), CAST(N'2024-05-07T12:04:08.510' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'17ba4837-be75-4b0e-8b6e-62e486adfa06', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', CAST(N'2024-05-07T12:04:08.510' AS DateTime), CAST(N'2024-05-07T12:04:08.510' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'572696bf-50f7-4bd3-b4e8-212451a49490', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', CAST(N'2024-05-07T12:04:08.510' AS DateTime), CAST(N'2024-05-07T12:04:08.510' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'159d4689-a5e0-43d0-b14e-1a4137e47ce2', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', CAST(N'2024-05-07T12:04:08.510' AS DateTime), CAST(N'2024-05-07T12:04:08.510' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'142fd1d0-2f20-46f3-bd7d-6c6e0b722260', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', CAST(N'2024-05-07T12:04:08.510' AS DateTime), CAST(N'2024-05-07T12:04:08.510' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'c625fc61-e57d-4898-85af-51081e589661', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', CAST(N'2024-05-07T12:04:08.510' AS DateTime), CAST(N'2024-05-07T12:04:08.510' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'72221ff8-def9-4192-8ec0-155815843db4', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', CAST(N'2024-05-07T12:04:08.510' AS DateTime), CAST(N'2024-05-07T12:04:08.510' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'e1f11bcd-781c-4e07-8e12-05deea47c074', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', CAST(N'2024-05-07T12:04:08.510' AS DateTime), CAST(N'2024-05-07T12:04:08.510' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'e192c6cb-b354-40aa-bbed-044c8422bba3', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', CAST(N'2024-05-07T12:04:08.510' AS DateTime), CAST(N'2024-05-07T12:04:08.510' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'8ef147f8-7f57-425f-84dd-868ff6e7d49c', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', CAST(N'2024-05-07T12:04:08.510' AS DateTime), CAST(N'2024-05-07T12:04:08.510' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'04048c35-4236-4eee-8ec6-f04ad0fb1f7a', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', CAST(N'2024-05-07T12:04:08.510' AS DateTime), CAST(N'2024-05-07T12:04:08.510' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'9f293b79-cccc-4212-8bc9-511d079fb522', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', CAST(N'2024-05-07T12:04:08.513' AS DateTime), CAST(N'2024-05-07T12:04:08.513' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'62ae4779-ac48-4d92-9471-3371a9d8217e', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', CAST(N'2024-05-07T12:04:08.513' AS DateTime), CAST(N'2024-05-07T12:04:08.513' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'1a7237de-0d6c-4fc4-a045-427e4df29941', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', CAST(N'2024-05-07T12:04:08.513' AS DateTime), CAST(N'2024-05-07T12:04:08.513' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'ad95bed8-5191-4943-b617-3938f02ddbda', N'f42329d1-edaa-4f2c-9ae1-8f026c92c842', CAST(N'2024-05-13T16:30:40.687' AS DateTime), CAST(N'2024-05-13T16:30:40.687' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'8c05cbc7-c867-497d-800f-777b52422fc8', N'f42329d1-edaa-4f2c-9ae1-8f026c92c842', CAST(N'2024-05-13T16:30:40.690' AS DateTime), CAST(N'2024-05-13T16:30:40.690' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'd5241910-335e-403b-bde6-70474f51fff0', N'f42329d1-edaa-4f2c-9ae1-8f026c92c842', CAST(N'2024-05-13T16:30:40.690' AS DateTime), CAST(N'2024-05-13T16:30:40.690' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'0409ba71-a8b3-4683-be7b-96eab7595fb9', N'f42329d1-edaa-4f2c-9ae1-8f026c92c842', CAST(N'2024-05-13T16:30:40.690' AS DateTime), CAST(N'2024-05-13T16:30:40.690' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'eab393c4-4d3d-4519-99eb-916d1243b252', N'f42329d1-edaa-4f2c-9ae1-8f026c92c842', CAST(N'2024-05-13T16:30:40.690' AS DateTime), CAST(N'2024-05-13T16:30:40.690' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'988c0f0b-9f2c-436e-8979-89e3b4a09c59', N'f42329d1-edaa-4f2c-9ae1-8f026c92c842', CAST(N'2024-05-13T16:30:40.690' AS DateTime), CAST(N'2024-05-13T16:30:40.690' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'65f31a5c-c8c5-4ab5-bffa-89547020f857', N'f42329d1-edaa-4f2c-9ae1-8f026c92c842', CAST(N'2024-05-13T16:30:40.690' AS DateTime), CAST(N'2024-05-13T16:30:40.690' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'196bd757-63bd-4479-bf2b-dd40754ddb76', N'f42329d1-edaa-4f2c-9ae1-8f026c92c842', CAST(N'2024-05-13T16:30:40.690' AS DateTime), CAST(N'2024-05-13T16:30:40.690' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'06cf0e2d-68d1-4ce0-a38e-787321d9dae4', N'f42329d1-edaa-4f2c-9ae1-8f026c92c842', CAST(N'2024-05-13T16:30:40.690' AS DateTime), CAST(N'2024-05-13T16:30:40.690' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'47e0f2a9-8c5b-4dd2-ae2d-911161afd400', N'f42329d1-edaa-4f2c-9ae1-8f026c92c842', CAST(N'2024-05-13T16:30:40.690' AS DateTime), CAST(N'2024-05-13T16:30:40.690' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'34487073-a2dd-4a03-be7b-d7059a07aa18', N'f42329d1-edaa-4f2c-9ae1-8f026c92c842', CAST(N'2024-05-13T16:30:40.690' AS DateTime), CAST(N'2024-05-13T16:30:40.690' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'497ddff6-a320-4c6b-bd21-66dd4915af6b', N'f42329d1-edaa-4f2c-9ae1-8f026c92c842', CAST(N'2024-05-13T16:30:40.690' AS DateTime), CAST(N'2024-05-13T16:30:40.690' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'b09c27f4-95e7-49b1-a8ff-dcbd2dccacf4', N'f42329d1-edaa-4f2c-9ae1-8f026c92c842', CAST(N'2024-05-13T16:30:40.693' AS DateTime), CAST(N'2024-05-13T16:30:40.693' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'72221ff8-def9-4192-8ec0-155815843db4', N'f42329d1-edaa-4f2c-9ae1-8f026c92c842', CAST(N'2024-05-13T16:30:40.693' AS DateTime), CAST(N'2024-05-13T16:30:40.693' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'e0461ea6-2a33-48ec-8f38-f2cba9e3d58c', N'f42329d1-edaa-4f2c-9ae1-8f026c92c842', CAST(N'2024-05-13T16:30:40.693' AS DateTime), CAST(N'2024-05-13T16:30:40.693' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'cbecd095-4c93-4ebe-8f33-779a8ce3b7fc', N'f42329d1-edaa-4f2c-9ae1-8f026c92c842', CAST(N'2024-05-13T16:30:40.693' AS DateTime), CAST(N'2024-05-13T16:30:40.693' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'325cab66-cdf4-4c9b-bf13-93d30495ecfb', N'f42329d1-edaa-4f2c-9ae1-8f026c92c842', CAST(N'2024-05-13T16:30:40.693' AS DateTime), CAST(N'2024-05-13T16:30:40.693' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'04048c35-4236-4eee-8ec6-f04ad0fb1f7a', N'f42329d1-edaa-4f2c-9ae1-8f026c92c842', CAST(N'2024-05-13T16:30:40.693' AS DateTime), CAST(N'2024-05-13T16:30:40.693' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'a37c16d4-a169-4cd5-8ac5-57765564b36f', N'f42329d1-edaa-4f2c-9ae1-8f026c92c842', CAST(N'2024-05-13T16:30:40.693' AS DateTime), CAST(N'2024-05-13T16:30:40.693' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'bd0cad51-e274-4002-8efe-a4242896f83c', N'f42329d1-edaa-4f2c-9ae1-8f026c92c842', CAST(N'2024-05-13T16:30:40.693' AS DateTime), CAST(N'2024-05-13T16:30:40.693' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'2acd946c-3a08-49c3-87eb-59df52a8ad35', N'f42329d1-edaa-4f2c-9ae1-8f026c92c842', CAST(N'2024-05-13T16:30:40.693' AS DateTime), CAST(N'2024-05-13T16:30:40.693' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'ad95bed8-5191-4943-b617-3938f02ddbda', N'6d3a6b25-c6c7-4ed4-a5e9-d992b1cc98a7', CAST(N'2024-05-13T16:34:19.163' AS DateTime), CAST(N'2024-05-13T16:34:19.163' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'8c05cbc7-c867-497d-800f-777b52422fc8', N'6d3a6b25-c6c7-4ed4-a5e9-d992b1cc98a7', CAST(N'2024-05-13T16:34:19.163' AS DateTime), CAST(N'2024-05-13T16:34:19.163' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'd5241910-335e-403b-bde6-70474f51fff0', N'6d3a6b25-c6c7-4ed4-a5e9-d992b1cc98a7', CAST(N'2024-05-13T16:34:19.163' AS DateTime), CAST(N'2024-05-13T16:34:19.163' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'0409ba71-a8b3-4683-be7b-96eab7595fb9', N'6d3a6b25-c6c7-4ed4-a5e9-d992b1cc98a7', CAST(N'2024-05-13T16:34:19.167' AS DateTime), CAST(N'2024-05-13T16:34:19.167' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'eab393c4-4d3d-4519-99eb-916d1243b252', N'6d3a6b25-c6c7-4ed4-a5e9-d992b1cc98a7', CAST(N'2024-05-13T16:34:19.167' AS DateTime), CAST(N'2024-05-13T16:34:19.167' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'86c24a20-7dd0-4090-82b7-76103037f5f3', N'6d3a6b25-c6c7-4ed4-a5e9-d992b1cc98a7', CAST(N'2024-05-13T16:34:19.167' AS DateTime), CAST(N'2024-05-13T16:34:19.167' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'65f31a5c-c8c5-4ab5-bffa-89547020f857', N'6d3a6b25-c6c7-4ed4-a5e9-d992b1cc98a7', CAST(N'2024-05-13T16:34:19.167' AS DateTime), CAST(N'2024-05-13T16:34:19.167' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'196bd757-63bd-4479-bf2b-dd40754ddb76', N'6d3a6b25-c6c7-4ed4-a5e9-d992b1cc98a7', CAST(N'2024-05-13T16:34:19.167' AS DateTime), CAST(N'2024-05-13T16:34:19.167' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'8abe7efb-6425-4993-877d-a52cd2c59c84', N'6d3a6b25-c6c7-4ed4-a5e9-d992b1cc98a7', CAST(N'2024-05-13T16:34:19.167' AS DateTime), CAST(N'2024-05-13T16:34:19.167' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'e56985f6-4017-424b-a402-4603e464a88c', N'6d3a6b25-c6c7-4ed4-a5e9-d992b1cc98a7', CAST(N'2024-05-13T16:34:19.167' AS DateTime), CAST(N'2024-05-13T16:34:19.167' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'34487073-a2dd-4a03-be7b-d7059a07aa18', N'6d3a6b25-c6c7-4ed4-a5e9-d992b1cc98a7', CAST(N'2024-05-13T16:34:19.167' AS DateTime), CAST(N'2024-05-13T16:34:19.167' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'793515bb-c814-428c-830e-c8d9b1677657', N'6d3a6b25-c6c7-4ed4-a5e9-d992b1cc98a7', CAST(N'2024-05-13T16:34:19.167' AS DateTime), CAST(N'2024-05-13T16:34:19.167' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'16f48380-f602-43b4-9bfb-9aa34aed3b52', N'6d3a6b25-c6c7-4ed4-a5e9-d992b1cc98a7', CAST(N'2024-05-13T16:34:19.167' AS DateTime), CAST(N'2024-05-13T16:34:19.167' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'be814cd2-23f6-41ed-8b3e-3a3d7cbe6222', N'6d3a6b25-c6c7-4ed4-a5e9-d992b1cc98a7', CAST(N'2024-05-13T16:34:19.167' AS DateTime), CAST(N'2024-05-13T16:34:19.167' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'e0461ea6-2a33-48ec-8f38-f2cba9e3d58c', N'6d3a6b25-c6c7-4ed4-a5e9-d992b1cc98a7', CAST(N'2024-05-13T16:34:19.170' AS DateTime), CAST(N'2024-05-13T16:34:19.170' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'cbecd095-4c93-4ebe-8f33-779a8ce3b7fc', N'6d3a6b25-c6c7-4ed4-a5e9-d992b1cc98a7', CAST(N'2024-05-13T16:34:19.170' AS DateTime), CAST(N'2024-05-13T16:34:19.170' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'325cab66-cdf4-4c9b-bf13-93d30495ecfb', N'6d3a6b25-c6c7-4ed4-a5e9-d992b1cc98a7', CAST(N'2024-05-13T16:34:19.170' AS DateTime), CAST(N'2024-05-13T16:34:19.170' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'91fc2415-9090-46c9-a5dc-730156f0766f', N'6d3a6b25-c6c7-4ed4-a5e9-d992b1cc98a7', CAST(N'2024-05-13T16:34:19.170' AS DateTime), CAST(N'2024-05-13T16:34:19.170' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'4fd284d7-3a6a-4836-b43f-7ba79c931440', N'6d3a6b25-c6c7-4ed4-a5e9-d992b1cc98a7', CAST(N'2024-05-13T16:34:19.170' AS DateTime), CAST(N'2024-05-13T16:34:19.170' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'bd0cad51-e274-4002-8efe-a4242896f83c', N'6d3a6b25-c6c7-4ed4-a5e9-d992b1cc98a7', CAST(N'2024-05-13T16:34:19.170' AS DateTime), CAST(N'2024-05-13T16:34:19.170' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'2acd946c-3a08-49c3-87eb-59df52a8ad35', N'6d3a6b25-c6c7-4ed4-a5e9-d992b1cc98a7', CAST(N'2024-05-13T16:34:19.170' AS DateTime), CAST(N'2024-05-13T16:34:19.170' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'3cca51e5-2017-428a-9104-86771163992a', N'015e40dd-58ce-401e-a0a9-075874bc0b68', CAST(N'2024-05-17T12:07:42.003' AS DateTime), CAST(N'2024-05-17T12:07:42.003' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'c0f8f780-3181-421b-92c6-b6fd5bd762ea', N'015e40dd-58ce-401e-a0a9-075874bc0b68', CAST(N'2024-05-17T12:07:42.007' AS DateTime), CAST(N'2024-05-17T12:07:42.007' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'28fad534-b084-49df-8e66-30ee960761db', N'015e40dd-58ce-401e-a0a9-075874bc0b68', CAST(N'2024-05-17T12:07:42.007' AS DateTime), CAST(N'2024-05-17T12:07:42.007' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'b063770d-8cba-43fc-9df8-696fbe6c7599', N'015e40dd-58ce-401e-a0a9-075874bc0b68', CAST(N'2024-05-17T12:07:42.007' AS DateTime), CAST(N'2024-05-17T12:07:42.007' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'6f99d33f-105d-4868-8e4b-eb409d96fb2d', N'015e40dd-58ce-401e-a0a9-075874bc0b68', CAST(N'2024-05-17T12:07:42.007' AS DateTime), CAST(N'2024-05-17T12:07:42.007' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'e9fdf9bd-9f10-4d45-a911-a2114d5bcda6', N'015e40dd-58ce-401e-a0a9-075874bc0b68', CAST(N'2024-05-17T12:07:42.007' AS DateTime), CAST(N'2024-05-17T12:07:42.007' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'd5450c04-e21b-4368-a8de-946d61e7ae97', N'015e40dd-58ce-401e-a0a9-075874bc0b68', CAST(N'2024-05-17T12:07:42.007' AS DateTime), CAST(N'2024-05-17T12:07:42.007' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'd505d87f-db50-4547-a9bf-9eb82b8cae89', N'015e40dd-58ce-401e-a0a9-075874bc0b68', CAST(N'2024-05-17T12:07:42.007' AS DateTime), CAST(N'2024-05-17T12:07:42.007' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'5210b3ab-a255-4c21-b594-cc58d3773e62', N'015e40dd-58ce-401e-a0a9-075874bc0b68', CAST(N'2024-05-17T12:07:42.010' AS DateTime), CAST(N'2024-05-17T12:07:42.010' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'39930b3d-35ef-4a8c-9d25-b260092d479e', N'015e40dd-58ce-401e-a0a9-075874bc0b68', CAST(N'2024-05-17T12:07:42.010' AS DateTime), CAST(N'2024-05-17T12:07:42.010' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'621b094f-0e5f-4f0d-ada4-1661b4fdbb53', N'015e40dd-58ce-401e-a0a9-075874bc0b68', CAST(N'2024-05-17T12:07:42.010' AS DateTime), CAST(N'2024-05-17T12:07:42.010' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'8cb075af-fa9d-4401-a867-d2bed5a3d3ce', N'015e40dd-58ce-401e-a0a9-075874bc0b68', CAST(N'2024-05-17T12:07:42.010' AS DateTime), CAST(N'2024-05-17T12:07:42.010' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'6f5cc486-dc1c-4844-afcf-ce80af6a266d', N'015e40dd-58ce-401e-a0a9-075874bc0b68', CAST(N'2024-05-17T12:07:42.010' AS DateTime), CAST(N'2024-05-17T12:07:42.010' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'23b3bd74-1738-405d-99cd-d0a4a1a18e10', N'015e40dd-58ce-401e-a0a9-075874bc0b68', CAST(N'2024-05-17T12:07:42.010' AS DateTime), CAST(N'2024-05-17T12:07:42.010' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'e5d457cf-b207-47c2-b06b-14cc8d623b8e', N'015e40dd-58ce-401e-a0a9-075874bc0b68', CAST(N'2024-05-17T12:07:42.010' AS DateTime), CAST(N'2024-05-17T12:07:42.010' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'65e7a760-cfb8-4479-b766-916e3e590b7f', N'015e40dd-58ce-401e-a0a9-075874bc0b68', CAST(N'2024-05-17T12:07:42.010' AS DateTime), CAST(N'2024-05-17T12:07:42.010' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'513fd33f-6456-4133-bc65-8b1f8f38659f', N'6d3a6b25-c6c7-4ed4-a5e9-d992b1cc98a7', CAST(N'2024-05-17T12:08:45.640' AS DateTime), CAST(N'2024-05-17T12:08:45.640' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'b6f296d8-273d-4e9d-9808-65a3c1173e4a', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', CAST(N'2024-05-17T12:10:36.380' AS DateTime), CAST(N'2024-05-17T12:10:36.380' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'c0cb6eff-d290-4ba5-a4be-410badcdb360', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', CAST(N'2024-05-17T12:10:36.380' AS DateTime), CAST(N'2024-05-17T12:10:36.380' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'e462a1e4-9e92-4258-80fa-151f6580be71', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', CAST(N'2024-05-17T12:10:36.380' AS DateTime), CAST(N'2024-05-17T12:10:36.380' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'b063770d-8cba-43fc-9df8-696fbe6c7599', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', CAST(N'2024-05-17T12:10:36.380' AS DateTime), CAST(N'2024-05-17T12:10:36.380' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'bb240980-fe0d-4d16-9f27-33a9cc9320e9', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', CAST(N'2024-05-17T12:10:36.380' AS DateTime), CAST(N'2024-05-17T12:10:36.380' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'e9fdf9bd-9f10-4d45-a911-a2114d5bcda6', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', CAST(N'2024-05-17T12:10:36.380' AS DateTime), CAST(N'2024-05-17T12:10:36.380' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'e0249eef-c1a1-474c-ad7d-4111d52ebabb', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', CAST(N'2024-05-17T12:10:36.380' AS DateTime), CAST(N'2024-05-17T12:10:36.380' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'd505d87f-db50-4547-a9bf-9eb82b8cae89', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', CAST(N'2024-05-17T12:10:36.383' AS DateTime), CAST(N'2024-05-17T12:10:36.383' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'5210b3ab-a255-4c21-b594-cc58d3773e62', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', CAST(N'2024-05-17T12:10:36.383' AS DateTime), CAST(N'2024-05-17T12:10:36.383' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'39930b3d-35ef-4a8c-9d25-b260092d479e', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', CAST(N'2024-05-17T12:10:36.383' AS DateTime), CAST(N'2024-05-17T12:10:36.383' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'c66e04eb-a261-402e-868d-a36173042f23', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', CAST(N'2024-05-17T12:10:36.383' AS DateTime), CAST(N'2024-05-17T12:10:36.383' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'7674def2-65cf-455d-91e3-f0e8b35eebdd', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', CAST(N'2024-05-17T12:10:36.383' AS DateTime), CAST(N'2024-05-17T12:10:36.383' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'eb9d6ac6-993f-41b3-8d1b-320cdbcf3a97', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', CAST(N'2024-05-17T12:10:36.383' AS DateTime), CAST(N'2024-05-17T12:10:36.383' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'867933ed-14e4-4327-acb6-4d1741444341', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', CAST(N'2024-05-17T12:10:36.383' AS DateTime), CAST(N'2024-05-17T12:10:36.383' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'4042172a-efff-419f-a638-001cf66d69ce', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', CAST(N'2024-05-17T12:10:36.383' AS DateTime), CAST(N'2024-05-17T12:10:36.383' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'a4a81754-156d-47e6-b33a-63e75b6856d6', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', CAST(N'2024-05-17T12:10:36.383' AS DateTime), CAST(N'2024-05-17T12:10:36.383' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'aa4c77f5-24c3-493c-80f5-0c205822aa0b', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', CAST(N'2024-05-31T15:10:15.587' AS DateTime), CAST(N'2024-05-31T15:10:15.587' AS DateTime), N'30/05/2024', NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'312aa1e3-045d-48b3-9ca6-0cfa5c5907c3', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', CAST(N'2024-05-31T15:10:15.590' AS DateTime), CAST(N'2024-05-31T15:10:15.590' AS DateTime), N'prueba', NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'1b49799c-8da5-4461-bf29-33aa34320a0b', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', CAST(N'2024-05-31T15:10:15.590' AS DateTime), CAST(N'2024-05-31T15:10:15.590' AS DateTime), N'prueba 2', NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'd9b0003d-b081-4990-8fb3-bb516c4f5905', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', CAST(N'2024-05-31T15:10:15.590' AS DateTime), CAST(N'2024-05-31T15:10:15.590' AS DateTime), N'15:09', NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'a63ef88a-18cd-4715-930c-8244a85fd1e4', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', CAST(N'2024-05-31T15:10:15.590' AS DateTime), CAST(N'2024-05-31T15:10:15.590' AS DateTime), N'30/05/2024', NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'cde0a066-55e8-4f28-b3ba-4297ebdf0cc2', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', CAST(N'2024-05-31T15:10:15.590' AS DateTime), CAST(N'2024-05-31T15:10:15.590' AS DateTime), N'pruebs 3', NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'430a1332-e6e5-4bde-89be-9138d7d6dc77', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', CAST(N'2024-05-31T15:10:15.590' AS DateTime), CAST(N'2024-05-31T15:10:15.590' AS DateTime), N'prueba 4', NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'2e9a20d6-23f6-447b-bd91-6500e3736a31', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', CAST(N'2024-05-31T15:10:15.590' AS DateTime), CAST(N'2024-05-31T15:10:15.590' AS DateTime), N'16:09', NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'2e2e6981-893f-4407-a14b-fcffb5bd262c', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', CAST(N'2024-05-31T15:10:15.590' AS DateTime), CAST(N'2024-05-31T15:10:15.590' AS DateTime), N'29/05/2024', NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'0918a3ba-6acb-477c-81e7-91d23c83c82f', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', CAST(N'2024-05-31T15:10:15.590' AS DateTime), CAST(N'2024-05-31T15:10:15.590' AS DateTime), N'15/05/2024', NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'e11e1bc7-cd93-432d-93ab-9a00f4659cbc', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', CAST(N'2024-05-31T15:10:15.590' AS DateTime), CAST(N'2024-05-31T15:10:15.590' AS DateTime), N'preubs 4', NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'1c4f9033-2987-4346-9a0d-a742458605f6', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', CAST(N'2024-05-31T15:10:15.590' AS DateTime), CAST(N'2024-05-31T15:10:15.590' AS DateTime), N'preubs 5', NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'e152e0c4-b652-4983-a5d5-d5b563272369', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', CAST(N'2024-05-31T15:10:15.593' AS DateTime), CAST(N'2024-05-31T15:10:15.593' AS DateTime), N'17:09', NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'c1b1c78f-4ee8-44de-838c-380299030314', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', CAST(N'2024-05-31T15:10:15.593' AS DateTime), CAST(N'2024-05-31T15:10:15.593' AS DateTime), N'prubs 6', NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'75fd3efb-ef17-43da-8c43-5deefd66624d', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', CAST(N'2024-05-31T15:10:15.593' AS DateTime), CAST(N'2024-05-31T15:10:15.593' AS DateTime), N'18:10', NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'824f27c0-71a6-41df-9ae3-0be1c27a9db5', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', CAST(N'2024-05-31T15:10:15.593' AS DateTime), CAST(N'2024-05-31T15:10:15.593' AS DateTime), N'01/05/2024', NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'd29c967a-638f-42b0-9882-cae03eed4b67', N'91db7bae-7d2f-423d-b595-d227c63ca0a6', CAST(N'2024-06-13T09:10:46.637' AS DateTime), CAST(N'2024-06-13T09:10:46.637' AS DateTime), NULL, N'ab37197c-bf33-44b8-ba5d-e246fa250b41')
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'0d9166ad-0393-473e-8658-ad6a725443ba', N'91db7bae-7d2f-423d-b595-d227c63ca0a6', CAST(N'2024-06-13T09:10:46.637' AS DateTime), CAST(N'2024-06-13T09:10:46.637' AS DateTime), NULL, N'ab37197c-bf33-44b8-ba5d-e246fa250b41')
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'a5a2954e-ed85-4c63-b221-56eb65bb41fc', N'91db7bae-7d2f-423d-b595-d227c63ca0a6', CAST(N'2024-06-13T09:10:46.640' AS DateTime), CAST(N'2024-06-13T09:10:46.640' AS DateTime), NULL, N'ab37197c-bf33-44b8-ba5d-e246fa250b41')
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'8fe33bfd-2c0b-47fc-9bb7-7380edb77512', N'91db7bae-7d2f-423d-b595-d227c63ca0a6', CAST(N'2024-06-13T16:07:11.773' AS DateTime), CAST(N'2024-06-13T16:07:11.773' AS DateTime), NULL, N'f42329d1-edaa-4f2c-9ae1-8f026c92c842')
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'401908bc-5a9b-4df7-81db-f4a33701c804', N'91db7bae-7d2f-423d-b595-d227c63ca0a6', CAST(N'2024-06-14T10:09:34.383' AS DateTime), CAST(N'2024-06-14T10:09:34.383' AS DateTime), NULL, N'6d3a6b25-c6c7-4ed4-a5e9-d992b1cc98a7')
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'0d9166ad-0393-473e-8658-ad6a725443ba', N'91db7bae-7d2f-423d-b595-d227c63ca0a6', CAST(N'2024-06-14T10:09:34.383' AS DateTime), CAST(N'2024-06-14T10:09:34.383' AS DateTime), NULL, N'6d3a6b25-c6c7-4ed4-a5e9-d992b1cc98a7')
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'73b4d5c2-a9df-4e7f-af98-1c257790e990', N'91db7bae-7d2f-423d-b595-d227c63ca0a6', CAST(N'2024-06-14T10:09:34.383' AS DateTime), CAST(N'2024-06-14T10:09:34.383' AS DateTime), NULL, N'6d3a6b25-c6c7-4ed4-a5e9-d992b1cc98a7')
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'401908bc-5a9b-4df7-81db-f4a33701c804', N'015e40dd-58ce-401e-a0a9-075874bc0b68', CAST(N'2024-06-14T16:13:39.297' AS DateTime), CAST(N'2024-06-14T16:13:39.297' AS DateTime), NULL, N'ab37197c-bf33-44b8-ba5d-e246fa250b41')
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'0d9166ad-0393-473e-8658-ad6a725443ba', N'015e40dd-58ce-401e-a0a9-075874bc0b68', CAST(N'2024-06-14T16:13:39.300' AS DateTime), CAST(N'2024-06-14T16:13:39.300' AS DateTime), NULL, N'ab37197c-bf33-44b8-ba5d-e246fa250b41')
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'eef8d894-2464-4023-b994-dcca89e6d522', N'015e40dd-58ce-401e-a0a9-075874bc0b68', CAST(N'2024-06-14T16:13:39.300' AS DateTime), CAST(N'2024-06-14T16:13:39.300' AS DateTime), NULL, N'ab37197c-bf33-44b8-ba5d-e246fa250b41')
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'42b1c5ba-12a7-4d17-95ae-c990f466fb22', N'de632913-94cf-4ab1-8350-aa4c9c0b0b52', CAST(N'2024-06-19T12:12:41.550' AS DateTime), CAST(N'2024-06-19T12:12:41.550' AS DateTime), NULL, N'de632913-94cf-4ab1-8350-aa4c9c0b0b52')
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'72b132ef-0794-468c-848b-c651646802cb', N'de632913-94cf-4ab1-8350-aa4c9c0b0b52', CAST(N'2024-06-19T12:12:41.550' AS DateTime), CAST(N'2024-06-19T12:12:41.550' AS DateTime), NULL, N'de632913-94cf-4ab1-8350-aa4c9c0b0b52')
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'77263018-6d80-4e52-b1c0-b1ed72a0c08f', N'de632913-94cf-4ab1-8350-aa4c9c0b0b52', CAST(N'2024-06-19T12:12:41.550' AS DateTime), CAST(N'2024-06-19T12:12:41.550' AS DateTime), NULL, N'de632913-94cf-4ab1-8350-aa4c9c0b0b52')
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'6a2e2af8-4a69-409d-8a38-8a268a5a847f', N'de632913-94cf-4ab1-8350-aa4c9c0b0b52', CAST(N'2024-06-19T12:12:41.550' AS DateTime), CAST(N'2024-06-19T12:12:41.550' AS DateTime), NULL, N'de632913-94cf-4ab1-8350-aa4c9c0b0b52')
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'f864e8d3-f39d-4175-98b0-af95559ca910', N'de632913-94cf-4ab1-8350-aa4c9c0b0b52', CAST(N'2024-06-19T12:12:41.550' AS DateTime), CAST(N'2024-06-19T12:12:41.550' AS DateTime), NULL, N'de632913-94cf-4ab1-8350-aa4c9c0b0b52')
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'06e77df1-707d-4616-8cde-e20ed5397c76', N'42c77db8-7fd5-45cb-ab1a-eb331c7dfb61', CAST(N'2024-06-19T12:12:52.133' AS DateTime), CAST(N'2024-06-19T12:12:52.133' AS DateTime), NULL, N'de632913-94cf-4ab1-8350-aa4c9c0b0b52')
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'8ab8b688-6bd9-4bf4-8e71-f235a35ee590', N'42c77db8-7fd5-45cb-ab1a-eb331c7dfb61', CAST(N'2024-06-19T12:12:52.137' AS DateTime), CAST(N'2024-06-19T12:12:52.137' AS DateTime), NULL, N'de632913-94cf-4ab1-8350-aa4c9c0b0b52')
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'd3e92ffd-ec95-4573-91e2-363f45eca273', N'6d3a6b25-c6c7-4ed4-a5e9-d992b1cc98a7', CAST(N'2024-05-17T12:08:45.640' AS DateTime), CAST(N'2024-05-17T12:08:45.640' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'd06b65c1-959b-45eb-98c5-7c80947b841a', N'6d3a6b25-c6c7-4ed4-a5e9-d992b1cc98a7', CAST(N'2024-05-17T12:08:45.640' AS DateTime), CAST(N'2024-05-17T12:08:45.640' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'2579e526-0a85-4218-acb1-b49d7c0b680a', N'6d3a6b25-c6c7-4ed4-a5e9-d992b1cc98a7', CAST(N'2024-05-17T12:08:45.640' AS DateTime), CAST(N'2024-05-17T12:08:45.640' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'26eb1536-1a2f-4981-8223-54def049c9de', N'6d3a6b25-c6c7-4ed4-a5e9-d992b1cc98a7', CAST(N'2024-05-17T12:08:45.643' AS DateTime), CAST(N'2024-05-17T12:08:45.643' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'e9fdf9bd-9f10-4d45-a911-a2114d5bcda6', N'6d3a6b25-c6c7-4ed4-a5e9-d992b1cc98a7', CAST(N'2024-05-17T12:08:45.643' AS DateTime), CAST(N'2024-05-17T12:08:45.643' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'2cc2b76e-3bb1-418c-baab-19e562dfa82a', N'6d3a6b25-c6c7-4ed4-a5e9-d992b1cc98a7', CAST(N'2024-05-17T12:08:45.643' AS DateTime), CAST(N'2024-05-17T12:08:45.643' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'b3dac952-4751-4f95-babd-48f9771dd6a4', N'6d3a6b25-c6c7-4ed4-a5e9-d992b1cc98a7', CAST(N'2024-05-17T12:08:45.643' AS DateTime), CAST(N'2024-05-17T12:08:45.643' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'e7b61d92-009a-4130-9b01-b7d6395eb2af', N'6d3a6b25-c6c7-4ed4-a5e9-d992b1cc98a7', CAST(N'2024-05-17T12:08:45.643' AS DateTime), CAST(N'2024-05-17T12:08:45.643' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'ab2bb820-ba0f-4ea5-aff4-15431ba8c207', N'6d3a6b25-c6c7-4ed4-a5e9-d992b1cc98a7', CAST(N'2024-05-17T12:08:45.643' AS DateTime), CAST(N'2024-05-17T12:08:45.643' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'c66e04eb-a261-402e-868d-a36173042f23', N'6d3a6b25-c6c7-4ed4-a5e9-d992b1cc98a7', CAST(N'2024-05-17T12:08:45.643' AS DateTime), CAST(N'2024-05-17T12:08:45.643' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'7e41ef45-caf8-4dca-b836-f4e235fbe269', N'6d3a6b25-c6c7-4ed4-a5e9-d992b1cc98a7', CAST(N'2024-05-17T12:08:45.643' AS DateTime), CAST(N'2024-05-17T12:08:45.643' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'eb9d6ac6-993f-41b3-8d1b-320cdbcf3a97', N'6d3a6b25-c6c7-4ed4-a5e9-d992b1cc98a7', CAST(N'2024-05-17T12:08:45.643' AS DateTime), CAST(N'2024-05-17T12:08:45.643' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'23b3bd74-1738-405d-99cd-d0a4a1a18e10', N'6d3a6b25-c6c7-4ed4-a5e9-d992b1cc98a7', CAST(N'2024-05-17T12:08:45.647' AS DateTime), CAST(N'2024-05-17T12:08:45.647' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'4042172a-efff-419f-a638-001cf66d69ce', N'6d3a6b25-c6c7-4ed4-a5e9-d992b1cc98a7', CAST(N'2024-05-17T12:08:45.647' AS DateTime), CAST(N'2024-05-17T12:08:45.647' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'65e7a760-cfb8-4479-b766-916e3e590b7f', N'6d3a6b25-c6c7-4ed4-a5e9-d992b1cc98a7', CAST(N'2024-05-17T12:08:45.647' AS DateTime), CAST(N'2024-05-17T12:08:45.647' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'513fd33f-6456-4133-bc65-8b1f8f38659f', N'f42329d1-edaa-4f2c-9ae1-8f026c92c842', CAST(N'2024-05-17T12:09:44.290' AS DateTime), CAST(N'2024-05-17T12:09:44.290' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'c0f8f780-3181-421b-92c6-b6fd5bd762ea', N'f42329d1-edaa-4f2c-9ae1-8f026c92c842', CAST(N'2024-05-17T12:09:44.293' AS DateTime), CAST(N'2024-05-17T12:09:44.293' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'ddc4aba5-c903-4c5f-8fef-16e2833bdb64', N'f42329d1-edaa-4f2c-9ae1-8f026c92c842', CAST(N'2024-05-17T12:09:44.293' AS DateTime), CAST(N'2024-05-17T12:09:44.293' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'2579e526-0a85-4218-acb1-b49d7c0b680a', N'f42329d1-edaa-4f2c-9ae1-8f026c92c842', CAST(N'2024-05-17T12:09:44.293' AS DateTime), CAST(N'2024-05-17T12:09:44.293' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'a3f88cc3-e998-4803-9a54-da02efb8ddd5', N'f42329d1-edaa-4f2c-9ae1-8f026c92c842', CAST(N'2024-05-17T12:09:44.293' AS DateTime), CAST(N'2024-05-17T12:09:44.293' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'e9fdf9bd-9f10-4d45-a911-a2114d5bcda6', N'f42329d1-edaa-4f2c-9ae1-8f026c92c842', CAST(N'2024-05-17T12:09:44.293' AS DateTime), CAST(N'2024-05-17T12:09:44.293' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'4f7e2d83-8abd-44b2-841d-ca6a614ae376', N'f42329d1-edaa-4f2c-9ae1-8f026c92c842', CAST(N'2024-05-17T12:09:44.293' AS DateTime), CAST(N'2024-05-17T12:09:44.293' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'9b630d70-f6a5-4d34-8b1f-3a7de13a5052', N'f42329d1-edaa-4f2c-9ae1-8f026c92c842', CAST(N'2024-05-17T12:09:44.293' AS DateTime), CAST(N'2024-05-17T12:09:44.293' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'e16476a2-f248-4f9b-bb66-ed0bfbabeaf1', N'f42329d1-edaa-4f2c-9ae1-8f026c92c842', CAST(N'2024-05-17T12:09:44.293' AS DateTime), CAST(N'2024-05-17T12:09:44.293' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'39930b3d-35ef-4a8c-9d25-b260092d479e', N'f42329d1-edaa-4f2c-9ae1-8f026c92c842', CAST(N'2024-05-17T12:09:44.293' AS DateTime), CAST(N'2024-05-17T12:09:44.293' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'8c3538f9-036e-4e8d-a3ee-4f367066adab', N'f42329d1-edaa-4f2c-9ae1-8f026c92c842', CAST(N'2024-05-17T12:09:44.297' AS DateTime), CAST(N'2024-05-17T12:09:44.297' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'0019ad18-16be-407e-b16d-655fc92033f4', N'f42329d1-edaa-4f2c-9ae1-8f026c92c842', CAST(N'2024-05-17T12:09:44.297' AS DateTime), CAST(N'2024-05-17T12:09:44.297' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'eb9d6ac6-993f-41b3-8d1b-320cdbcf3a97', N'f42329d1-edaa-4f2c-9ae1-8f026c92c842', CAST(N'2024-05-17T12:09:44.297' AS DateTime), CAST(N'2024-05-17T12:09:44.297' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'376b51f9-66e3-478a-a8f3-dd8b1019fabc', N'f42329d1-edaa-4f2c-9ae1-8f026c92c842', CAST(N'2024-05-17T12:09:44.297' AS DateTime), CAST(N'2024-05-17T12:09:44.297' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'5a1652ab-162b-4fa2-af91-996db2f5cbea', N'f42329d1-edaa-4f2c-9ae1-8f026c92c842', CAST(N'2024-05-17T12:09:44.297' AS DateTime), CAST(N'2024-05-17T12:09:44.297' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'65e7a760-cfb8-4479-b766-916e3e590b7f', N'f42329d1-edaa-4f2c-9ae1-8f026c92c842', CAST(N'2024-05-17T12:09:44.297' AS DateTime), CAST(N'2024-05-17T12:09:44.297' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'401908bc-5a9b-4df7-81db-f4a33701c804', N'91db7bae-7d2f-423d-b595-d227c63ca0a6', CAST(N'2024-06-13T16:07:11.770' AS DateTime), CAST(N'2024-06-13T16:07:11.770' AS DateTime), NULL, N'f42329d1-edaa-4f2c-9ae1-8f026c92c842')
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'c294705c-6717-492f-a887-8cba6be2dd28', N'91db7bae-7d2f-423d-b595-d227c63ca0a6', CAST(N'2024-06-13T16:07:11.770' AS DateTime), CAST(N'2024-06-13T16:07:11.770' AS DateTime), NULL, N'f42329d1-edaa-4f2c-9ae1-8f026c92c842')
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'd89fdf70-f882-4c99-8053-3aefc2c7aaf1', N'42c77db8-7fd5-45cb-ab1a-eb331c7dfb61', CAST(N'2024-06-19T12:12:52.137' AS DateTime), CAST(N'2024-06-19T12:12:52.137' AS DateTime), NULL, N'de632913-94cf-4ab1-8350-aa4c9c0b0b52')
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'd7f2bb32-bea6-498a-aacd-b2e0972a6bf2', N'42c77db8-7fd5-45cb-ab1a-eb331c7dfb61', CAST(N'2024-06-19T12:12:52.140' AS DateTime), CAST(N'2024-06-19T12:12:52.140' AS DateTime), NULL, N'de632913-94cf-4ab1-8350-aa4c9c0b0b52')
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'43d4088d-9acd-43b3-b920-fb577c2a3cc5', N'6d81e350-a4f4-4042-a3e9-ef97d985bc2a', CAST(N'2024-06-25T11:25:17.617' AS DateTime), CAST(N'2024-06-25T11:25:17.617' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'abb503c5-8823-4e12-afdb-f8894da301fd', N'6d81e350-a4f4-4042-a3e9-ef97d985bc2a', CAST(N'2024-06-25T11:25:17.617' AS DateTime), CAST(N'2024-06-25T11:25:17.617' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'c838c12d-b9f1-4ab8-a17d-749b7a8fa7ee', N'6d81e350-a4f4-4042-a3e9-ef97d985bc2a', CAST(N'2024-06-25T11:25:17.617' AS DateTime), CAST(N'2024-06-25T11:25:17.617' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'687f5e17-32d1-4f15-987c-87346d116c61', N'6d81e350-a4f4-4042-a3e9-ef97d985bc2a', CAST(N'2024-06-25T11:25:17.620' AS DateTime), CAST(N'2024-06-25T11:25:17.620' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'15434116-7d41-41c6-84fe-b93591da1e0f', N'6d81e350-a4f4-4042-a3e9-ef97d985bc2a', CAST(N'2024-06-25T11:25:17.620' AS DateTime), CAST(N'2024-06-25T11:25:17.620' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'5eddc9af-c46e-4244-ab2d-5864dba38f79', N'96a49ac1-c9c4-4bc1-8d3c-548f37f34828', CAST(N'2024-07-03T12:00:20.583' AS DateTime), CAST(N'2024-07-03T12:00:20.583' AS DateTime), N'fhfhf', NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'caccf54d-6d16-451b-b806-96692849c9e1', N'96a49ac1-c9c4-4bc1-8d3c-548f37f34828', CAST(N'2024-07-03T12:00:20.587' AS DateTime), CAST(N'2024-07-03T12:00:20.587' AS DateTime), N'11:56', NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'4fbf5f2a-783a-413f-abbb-864eceee67d7', N'96a49ac1-c9c4-4bc1-8d3c-548f37f34828', CAST(N'2024-07-03T12:00:20.587' AS DateTime), CAST(N'2024-07-03T12:00:20.587' AS DateTime), N'11/07/2024', NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'4c849a8b-3ae9-4565-a544-8593020f1d1b', N'96a49ac1-c9c4-4bc1-8d3c-548f37f34828', CAST(N'2024-07-03T12:00:20.587' AS DateTime), CAST(N'2024-07-03T12:00:20.587' AS DateTime), N'12:00', NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'd32a485e-ac88-48d1-8208-87560b6da796', N'96a49ac1-c9c4-4bc1-8d3c-548f37f34828', CAST(N'2024-07-03T12:00:20.587' AS DateTime), CAST(N'2024-07-03T12:00:20.587' AS DateTime), N'24/07/2024', NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'0ff238b4-fd7b-4e71-b520-d65ad2ee543e', N'96a49ac1-c9c4-4bc1-8d3c-548f37f34828', CAST(N'2024-07-03T12:00:20.587' AS DateTime), CAST(N'2024-07-03T12:00:20.587' AS DateTime), N'hfh', NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'dc84608d-b178-496f-9396-5f2d15bd45a3', N'96a49ac1-c9c4-4bc1-8d3c-548f37f34828', CAST(N'2024-07-03T12:00:20.590' AS DateTime), CAST(N'2024-07-03T12:00:20.590' AS DateTime), N'12:00', NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'd90dce4d-a28a-43be-879b-acb5301a1a41', N'96a49ac1-c9c4-4bc1-8d3c-548f37f34828', CAST(N'2024-07-03T12:00:20.590' AS DateTime), CAST(N'2024-07-03T12:00:20.590' AS DateTime), N'fhf', NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'7bce8a1e-7e43-448c-9096-ef7a7aa7cf04', N'96a49ac1-c9c4-4bc1-8d3c-548f37f34828', CAST(N'2024-07-03T12:00:20.590' AS DateTime), CAST(N'2024-07-03T12:00:20.590' AS DateTime), N'30/07/2024', NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'6807e28e-8e8a-4152-8461-1a206a32799d', N'96a49ac1-c9c4-4bc1-8d3c-548f37f34828', CAST(N'2024-07-03T12:00:20.590' AS DateTime), CAST(N'2024-07-03T12:00:20.590' AS DateTime), N'12:00', NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'39868208-b07c-462b-9ca5-45b7057ebd13', N'96a49ac1-c9c4-4bc1-8d3c-548f37f34828', CAST(N'2024-07-03T12:00:20.590' AS DateTime), CAST(N'2024-07-03T12:00:20.590' AS DateTime), N'23/07/2024', NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'77e6a69b-5cd1-43f1-b68e-f4385df5805c', N'96a49ac1-c9c4-4bc1-8d3c-548f37f34828', CAST(N'2024-07-03T12:00:20.590' AS DateTime), CAST(N'2024-07-03T12:00:20.590' AS DateTime), N'fhf', NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'b7d6d749-7d9d-4294-8ed5-594685709173', N'96a49ac1-c9c4-4bc1-8d3c-548f37f34828', CAST(N'2024-07-03T12:00:20.590' AS DateTime), CAST(N'2024-07-03T12:00:20.590' AS DateTime), N'15/07/2024', NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'af1110a8-5127-4e70-a616-911cea04aaea', N'96a49ac1-c9c4-4bc1-8d3c-548f37f34828', CAST(N'2024-07-03T12:00:20.590' AS DateTime), CAST(N'2024-07-03T12:00:20.590' AS DateTime), N'12:00', NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'409450a1-1c87-4766-a456-f012fe5a8d28', N'96a49ac1-c9c4-4bc1-8d3c-548f37f34828', CAST(N'2024-07-03T12:00:20.590' AS DateTime), CAST(N'2024-07-03T12:00:20.590' AS DateTime), N'fhfh', NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'd3e46f15-8f2f-4607-965c-af749a542ec1', N'96a49ac1-c9c4-4bc1-8d3c-548f37f34828', CAST(N'2024-07-03T13:26:24.453' AS DateTime), CAST(N'2024-07-03T13:26:24.453' AS DateTime), NULL, N'96a49ac1-c9c4-4bc1-8d3c-548f37f34828')
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'987a48bb-aecd-47dd-8e80-4a369fb31f49', N'96a49ac1-c9c4-4bc1-8d3c-548f37f34828', CAST(N'2024-07-03T13:26:24.453' AS DateTime), CAST(N'2024-07-03T13:26:24.453' AS DateTime), NULL, N'96a49ac1-c9c4-4bc1-8d3c-548f37f34828')
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'c4840360-6d1e-409d-ba27-0cf8f2bf95b3', N'96a49ac1-c9c4-4bc1-8d3c-548f37f34828', CAST(N'2024-07-03T13:40:03.157' AS DateTime), CAST(N'2024-07-03T13:40:03.157' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'abb503c5-8823-4e12-afdb-f8894da301fd', N'96a49ac1-c9c4-4bc1-8d3c-548f37f34828', CAST(N'2024-07-03T13:40:03.157' AS DateTime), CAST(N'2024-07-03T13:40:03.157' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'1db919dd-bd6e-4c2a-bde7-4086cfa45c0c', N'96a49ac1-c9c4-4bc1-8d3c-548f37f34828', CAST(N'2024-07-03T13:40:03.157' AS DateTime), CAST(N'2024-07-03T13:40:03.157' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'440377bc-18eb-4cac-8c78-7703387138fc', N'96a49ac1-c9c4-4bc1-8d3c-548f37f34828', CAST(N'2024-07-03T13:40:03.160' AS DateTime), CAST(N'2024-07-03T13:40:03.160' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'afcf572c-05f0-4660-9672-bf823a8c2362', N'96a49ac1-c9c4-4bc1-8d3c-548f37f34828', CAST(N'2024-07-03T13:40:03.160' AS DateTime), CAST(N'2024-07-03T13:40:03.160' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'a33683b3-d947-4fae-af49-e4be15d8e941', N'42c77db8-7fd5-45cb-ab1a-eb331c7dfb61', CAST(N'2024-06-19T12:12:52.140' AS DateTime), CAST(N'2024-06-19T12:12:52.140' AS DateTime), NULL, N'de632913-94cf-4ab1-8350-aa4c9c0b0b52')
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'e697fbcd-c822-4ec0-9d75-083b2231e47f', N'96a49ac1-c9c4-4bc1-8d3c-548f37f34828', CAST(N'2024-07-03T13:26:24.453' AS DateTime), CAST(N'2024-07-03T13:26:24.453' AS DateTime), NULL, N'96a49ac1-c9c4-4bc1-8d3c-548f37f34828')
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'c34d2d2f-a14e-471a-9a5d-b6672e139083', N'96a49ac1-c9c4-4bc1-8d3c-548f37f34828', CAST(N'2024-07-03T13:26:24.457' AS DateTime), CAST(N'2024-07-03T13:26:24.457' AS DateTime), NULL, N'96a49ac1-c9c4-4bc1-8d3c-548f37f34828')
GO
INSERT [dbo].[UsuarioxOpcion] ([idOpcion], [idUsuario], [fechaCreacion], [fechaModificacion], [respuesta], [idUserValidador]) VALUES (N'd8a3dbb5-3914-411b-9a40-eceefbd268ae', N'96a49ac1-c9c4-4bc1-8d3c-548f37f34828', CAST(N'2024-07-03T13:26:24.457' AS DateTime), CAST(N'2024-07-03T13:26:24.457' AS DateTime), NULL, N'96a49ac1-c9c4-4bc1-8d3c-548f37f34828')
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Area__72AFBCC6C2500A79]    Script Date: 04/07/2024 9:43:54 ******/
ALTER TABLE [dbo].[Area] ADD UNIQUE NONCLUSTERED 
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Categori__72AFBCC6B3607509]    Script Date: 04/07/2024 9:43:54 ******/
ALTER TABLE [dbo].[CategoriaNoticia] ADD UNIQUE NONCLUSTERED 
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Categori__72AFBCC6945FD353]    Script Date: 04/07/2024 9:43:54 ******/
ALTER TABLE [dbo].[CategoriaRecompensa] ADD UNIQUE NONCLUSTERED 
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Ciudad__72AFBCC60987AF52]    Script Date: 04/07/2024 9:43:54 ******/
ALTER TABLE [dbo].[Ciudad] ADD UNIQUE NONCLUSTERED 
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Comporta__72AFBCC6D24EDAA1]    Script Date: 04/07/2024 9:43:54 ******/
ALTER TABLE [dbo].[ComportamientoPregunta] ADD UNIQUE NONCLUSTERED 
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Condicio__72AFBCC66FA3235E]    Script Date: 04/07/2024 9:43:54 ******/
ALTER TABLE [dbo].[Condicion] ADD UNIQUE NONCLUSTERED 
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ_Configuracion_nom]    Script Date: 04/07/2024 9:43:54 ******/
ALTER TABLE [dbo].[Configuracion] ADD  CONSTRAINT [UQ_Configuracion_nom] UNIQUE NONCLUSTERED 
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Constant__72AFBCC6D3153B93]    Script Date: 04/07/2024 9:43:54 ******/
ALTER TABLE [dbo].[Constants] ADD UNIQUE NONCLUSTERED 
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__CorreoEn__2A586E0BB0F69B96]    Script Date: 04/07/2024 9:43:54 ******/
ALTER TABLE [dbo].[CorreoEnvio] ADD UNIQUE NONCLUSTERED 
(
	[correo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__CorreoEn__7F309E8F39900DF2]    Script Date: 04/07/2024 9:43:54 ******/
ALTER TABLE [dbo].[CorreoEnvio] ADD UNIQUE NONCLUSTERED 
(
	[host] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Empresa__72AFBCC630736C09]    Script Date: 04/07/2024 9:43:54 ******/
ALTER TABLE [dbo].[Empresa] ADD UNIQUE NONCLUSTERED 
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Equipo__72AFBCC63B05F2DF]    Script Date: 04/07/2024 9:43:54 ******/
ALTER TABLE [dbo].[Equipo] ADD UNIQUE NONCLUSTERED 
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Licencia__506462E02EF68D3A]    Script Date: 04/07/2024 9:43:54 ******/
ALTER TABLE [dbo].[Licencia] ADD UNIQUE NONCLUSTERED 
(
	[tabla] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Licencia__72AFBCC6AA2279C2]    Script Date: 04/07/2024 9:43:54 ******/
ALTER TABLE [dbo].[Licencia] ADD UNIQUE NONCLUSTERED 
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Medalla__72AFBCC6A797F12C]    Script Date: 04/07/2024 9:43:54 ******/
ALTER TABLE [dbo].[Medalla] ADD UNIQUE NONCLUSTERED 
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ_puntosNecesarios]    Script Date: 04/07/2024 9:43:54 ******/
ALTER TABLE [dbo].[Nivel] ADD  CONSTRAINT [UQ_puntosNecesarios] UNIQUE NONCLUSTERED 
(
	[puntosNecesarios] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Notifica__72AFBCC6F41559DF]    Script Date: 04/07/2024 9:43:54 ******/
ALTER TABLE [dbo].[Notificacion] ADD UNIQUE NONCLUSTERED 
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Pais__72AFBCC68522AA86]    Script Date: 04/07/2024 9:43:54 ******/
ALTER TABLE [dbo].[Pais] ADD UNIQUE NONCLUSTERED 
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Reto__72AFBCC683289CD8]    Script Date: 04/07/2024 9:43:54 ******/
ALTER TABLE [dbo].[Reto] ADD UNIQUE NONCLUSTERED 
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Rol__72AFBCC65215A463]    Script Date: 04/07/2024 9:43:54 ******/
ALTER TABLE [dbo].[Rol] ADD UNIQUE NONCLUSTERED 
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__TipoArch__72AFBCC642B389D6]    Script Date: 04/07/2024 9:43:54 ******/
ALTER TABLE [dbo].[TipoArchivo] ADD UNIQUE NONCLUSTERED 
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__TipoEncu__72AFBCC609332EA1]    Script Date: 04/07/2024 9:43:54 ******/
ALTER TABLE [dbo].[TipoEncuesta] ADD UNIQUE NONCLUSTERED 
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__TipoEntr__72AFBCC635BA26AF]    Script Date: 04/07/2024 9:43:54 ******/
ALTER TABLE [dbo].[TipoEntrada] ADD UNIQUE NONCLUSTERED 
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__tipoReto__72AFBCC679DDB36C]    Script Date: 04/07/2024 9:43:54 ******/
ALTER TABLE [dbo].[TipoReto] ADD UNIQUE NONCLUSTERED 
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__tipoVali__72AFBCC65E2787EB]    Script Date: 04/07/2024 9:43:54 ******/
ALTER TABLE [dbo].[TipoValidador] ADD UNIQUE NONCLUSTERED 
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Usuario__2A586E0BBB3CDCB2]    Script Date: 04/07/2024 9:43:54 ******/
ALTER TABLE [dbo].[Usuario] ADD  CONSTRAINT [UQ__Usuario__2A586E0BBB3CDCB2] UNIQUE NONCLUSTERED 
(
	[correo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ_Usuario_id]    Script Date: 04/07/2024 9:43:54 ******/
ALTER TABLE [dbo].[Usuario] ADD  CONSTRAINT [UQ_Usuario_id] UNIQUE NONCLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ__Usuario___645723A71F7E3A8D]    Script Date: 04/07/2024 9:43:54 ******/
ALTER TABLE [dbo].[Usuario_Equipo] ADD UNIQUE NONCLUSTERED 
(
	[idUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Area] ADD  DEFAULT (newid()) FOR [idArea]
GO
ALTER TABLE [dbo].[Area] ADD  DEFAULT ((1)) FOR [estado]
GO
ALTER TABLE [dbo].[Area] ADD  DEFAULT (getdate()) FOR [fechaCreacion]
GO
ALTER TABLE [dbo].[Area] ADD  DEFAULT (getdate()) FOR [fechaModificacion]
GO
ALTER TABLE [dbo].[CategoriaNoticia] ADD  DEFAULT (newid()) FOR [idCategoria]
GO
ALTER TABLE [dbo].[CategoriaNoticia] ADD  DEFAULT ((1)) FOR [estado]
GO
ALTER TABLE [dbo].[CategoriaNoticia] ADD  DEFAULT (getdate()) FOR [fechaCreacion]
GO
ALTER TABLE [dbo].[CategoriaNoticia] ADD  DEFAULT (getdate()) FOR [fechaModificacion]
GO
ALTER TABLE [dbo].[CategoriaRecompensa] ADD  DEFAULT (newid()) FOR [idCategoria]
GO
ALTER TABLE [dbo].[CategoriaRecompensa] ADD  DEFAULT ((1)) FOR [estado]
GO
ALTER TABLE [dbo].[CategoriaRecompensa] ADD  DEFAULT (getdate()) FOR [fechaCreacion]
GO
ALTER TABLE [dbo].[CategoriaRecompensa] ADD  DEFAULT (getdate()) FOR [fechaModificacion]
GO
ALTER TABLE [dbo].[Ciudad] ADD  DEFAULT (newid()) FOR [idCiudad]
GO
ALTER TABLE [dbo].[Ciudad] ADD  DEFAULT ((1)) FOR [estado]
GO
ALTER TABLE [dbo].[Ciudad] ADD  DEFAULT (getdate()) FOR [fechaCreacion]
GO
ALTER TABLE [dbo].[Ciudad] ADD  DEFAULT (getdate()) FOR [fechaModificacion]
GO
ALTER TABLE [dbo].[ComportamientoPregunta] ADD  DEFAULT (newid()) FOR [idComportamiento]
GO
ALTER TABLE [dbo].[ComportamientoPregunta] ADD  DEFAULT ((1)) FOR [estado]
GO
ALTER TABLE [dbo].[ComportamientoPregunta] ADD  DEFAULT (getdate()) FOR [fechaCreacion]
GO
ALTER TABLE [dbo].[ComportamientoPregunta] ADD  DEFAULT (getdate()) FOR [fechaModificacion]
GO
ALTER TABLE [dbo].[Condicion] ADD  DEFAULT (newid()) FOR [idCondicion]
GO
ALTER TABLE [dbo].[Condicion] ADD  DEFAULT ((1)) FOR [estado]
GO
ALTER TABLE [dbo].[Condicion] ADD  DEFAULT (getdate()) FOR [fechaCreacion]
GO
ALTER TABLE [dbo].[Condicion] ADD  DEFAULT (getdate()) FOR [fechaModificacion]
GO
ALTER TABLE [dbo].[Configuracion] ADD  DEFAULT (newid()) FOR [idConfig]
GO
ALTER TABLE [dbo].[Configuracion] ADD  DEFAULT (getdate()) FOR [fechaCreacion]
GO
ALTER TABLE [dbo].[Configuracion] ADD  DEFAULT (getdate()) FOR [fechaModificacion]
GO
ALTER TABLE [dbo].[Constants] ADD  DEFAULT ((1)) FOR [estado]
GO
ALTER TABLE [dbo].[Constants] ADD  DEFAULT (getdate()) FOR [fechaCreacion]
GO
ALTER TABLE [dbo].[Constants] ADD  DEFAULT (getdate()) FOR [fechaModificacion]
GO
ALTER TABLE [dbo].[CorreoEnvio] ADD  DEFAULT (newid()) FOR [idCorreo]
GO
ALTER TABLE [dbo].[CorreoEnvio] ADD  DEFAULT ((587)) FOR [puerto]
GO
ALTER TABLE [dbo].[CorreoEnvio] ADD  DEFAULT (getdate()) FOR [fechaCreacion]
GO
ALTER TABLE [dbo].[CorreoEnvio] ADD  DEFAULT (getdate()) FOR [fechaModificacion]
GO
ALTER TABLE [dbo].[Empresa] ADD  DEFAULT (newid()) FOR [idEmpresa]
GO
ALTER TABLE [dbo].[Empresa] ADD  DEFAULT ((1)) FOR [estado]
GO
ALTER TABLE [dbo].[Empresa] ADD  DEFAULT (getdate()) FOR [fechaCreacion]
GO
ALTER TABLE [dbo].[Empresa] ADD  DEFAULT (getdate()) FOR [fechaModificacion]
GO
ALTER TABLE [dbo].[Equipo] ADD  DEFAULT (newid()) FOR [idEquipo]
GO
ALTER TABLE [dbo].[Equipo] ADD  DEFAULT ((1)) FOR [estado]
GO
ALTER TABLE [dbo].[Equipo] ADD  DEFAULT (getdate()) FOR [fechaCreacion]
GO
ALTER TABLE [dbo].[Equipo] ADD  DEFAULT (getdate()) FOR [fechaModificacion]
GO
ALTER TABLE [dbo].[Equipo] ADD  DEFAULT ((0)) FOR [tiempo]
GO
ALTER TABLE [dbo].[Equipo] ADD  DEFAULT ((0)) FOR [puntos]
GO
ALTER TABLE [dbo].[Inicio] ADD  DEFAULT (newid()) FOR [idInicio]
GO
ALTER TABLE [dbo].[Inicio] ADD  DEFAULT ((0)) FOR [indice]
GO
ALTER TABLE [dbo].[Inicio] ADD  DEFAULT ((1)) FOR [estado]
GO
ALTER TABLE [dbo].[Inicio] ADD  DEFAULT (getdate()) FOR [fechaCreacion]
GO
ALTER TABLE [dbo].[Inicio] ADD  DEFAULT (getdate()) FOR [fechaModificacion]
GO
ALTER TABLE [dbo].[Licencia] ADD  DEFAULT (newid()) FOR [idLicencia]
GO
ALTER TABLE [dbo].[Licencia] ADD  DEFAULT ((1)) FOR [estado]
GO
ALTER TABLE [dbo].[Licencia] ADD  DEFAULT (getdate()) FOR [fechaCreacion]
GO
ALTER TABLE [dbo].[Licencia] ADD  DEFAULT (getdate()) FOR [fechaModificacion]
GO
ALTER TABLE [dbo].[Medalla] ADD  DEFAULT (newid()) FOR [idMedalla]
GO
ALTER TABLE [dbo].[Medalla] ADD  DEFAULT ((1)) FOR [estado]
GO
ALTER TABLE [dbo].[Medalla] ADD  DEFAULT (getdate()) FOR [fechaCreacion]
GO
ALTER TABLE [dbo].[Medalla] ADD  DEFAULT (getdate()) FOR [fechaModificacion]
GO
ALTER TABLE [dbo].[Medalla] ADD  DEFAULT ((1)) FOR [numCondicion]
GO
ALTER TABLE [dbo].[Nivel] ADD  DEFAULT (newid()) FOR [idNivel]
GO
ALTER TABLE [dbo].[Nivel] ADD  DEFAULT ((1)) FOR [estado]
GO
ALTER TABLE [dbo].[Nivel] ADD  DEFAULT (getdate()) FOR [fechaCreacion]
GO
ALTER TABLE [dbo].[Nivel] ADD  DEFAULT (getdate()) FOR [fechaModificacion]
GO
ALTER TABLE [dbo].[Noticia] ADD  DEFAULT (newid()) FOR [idNoticia]
GO
ALTER TABLE [dbo].[Noticia] ADD  DEFAULT ((1)) FOR [estado]
GO
ALTER TABLE [dbo].[Noticia] ADD  DEFAULT (getdate()) FOR [fechaCreacion]
GO
ALTER TABLE [dbo].[Noticia] ADD  DEFAULT (getdate()) FOR [fechaModificacion]
GO
ALTER TABLE [dbo].[Notificacion] ADD  DEFAULT (newid()) FOR [idNotificacion]
GO
ALTER TABLE [dbo].[Notificacion] ADD  DEFAULT ((0)) FOR [estado]
GO
ALTER TABLE [dbo].[Notificacion] ADD  DEFAULT ((0)) FOR [numDesc]
GO
ALTER TABLE [dbo].[Notificacion] ADD  DEFAULT ((0)) FOR [enviarCorreo]
GO
ALTER TABLE [dbo].[Notificacion] ADD  DEFAULT (getdate()) FOR [fechaCreacion]
GO
ALTER TABLE [dbo].[Notificacion] ADD  DEFAULT (getdate()) FOR [fechaModificacion]
GO
ALTER TABLE [dbo].[Novedad] ADD  DEFAULT (newid()) FOR [idNovedad]
GO
ALTER TABLE [dbo].[Novedad] ADD  DEFAULT ((1)) FOR [estado]
GO
ALTER TABLE [dbo].[Novedad] ADD  DEFAULT (getdate()) FOR [fechaCreacion]
GO
ALTER TABLE [dbo].[Novedad] ADD  DEFAULT (getdate()) FOR [fechaModificacion]
GO
ALTER TABLE [dbo].[Opcion] ADD  DEFAULT (newid()) FOR [idOpcion]
GO
ALTER TABLE [dbo].[Opcion] ADD  DEFAULT ((0)) FOR [correcta]
GO
ALTER TABLE [dbo].[Opcion] ADD  DEFAULT ((1)) FOR [estado]
GO
ALTER TABLE [dbo].[Opcion] ADD  DEFAULT (getdate()) FOR [fechaCreacion]
GO
ALTER TABLE [dbo].[Opcion] ADD  DEFAULT (getdate()) FOR [fechaModificacion]
GO
ALTER TABLE [dbo].[Opcion] ADD  DEFAULT ((0)) FOR [valor]
GO
ALTER TABLE [dbo].[Pais] ADD  DEFAULT (newid()) FOR [idPais]
GO
ALTER TABLE [dbo].[Pais] ADD  DEFAULT ((1)) FOR [estado]
GO
ALTER TABLE [dbo].[Pais] ADD  DEFAULT (getdate()) FOR [fechaCreacion]
GO
ALTER TABLE [dbo].[Pais] ADD  DEFAULT (getdate()) FOR [fechaModificacion]
GO
ALTER TABLE [dbo].[Pregunta] ADD  DEFAULT (newid()) FOR [idPregunta]
GO
ALTER TABLE [dbo].[Pregunta] ADD  DEFAULT ((1)) FOR [estado]
GO
ALTER TABLE [dbo].[Pregunta] ADD  DEFAULT (getdate()) FOR [fechaCreacion]
GO
ALTER TABLE [dbo].[Pregunta] ADD  DEFAULT (getdate()) FOR [fechaModificacion]
GO
ALTER TABLE [dbo].[Recompensa] ADD  DEFAULT (newid()) FOR [idRecompensa]
GO
ALTER TABLE [dbo].[Recompensa] ADD  DEFAULT ((0)) FOR [cantDisponible]
GO
ALTER TABLE [dbo].[Recompensa] ADD  DEFAULT ((0)) FOR [cantCanje]
GO
ALTER TABLE [dbo].[Recompensa] ADD  DEFAULT ((1)) FOR [estado]
GO
ALTER TABLE [dbo].[Recompensa] ADD  DEFAULT (getdate()) FOR [fechaCreacion]
GO
ALTER TABLE [dbo].[Recompensa] ADD  DEFAULT (getdate()) FOR [fechaModificacion]
GO
ALTER TABLE [dbo].[RedSocial] ADD  DEFAULT (newid()) FOR [idRed]
GO
ALTER TABLE [dbo].[RedSocial] ADD  DEFAULT ((1)) FOR [estado]
GO
ALTER TABLE [dbo].[RedSocial] ADD  DEFAULT (getdate()) FOR [fechaCreacion]
GO
ALTER TABLE [dbo].[RedSocial] ADD  DEFAULT (getdate()) FOR [fechaModificacion]
GO
ALTER TABLE [dbo].[Reto] ADD  DEFAULT (newid()) FOR [idReto]
GO
ALTER TABLE [dbo].[Reto] ADD  DEFAULT ((1)) FOR [estado]
GO
ALTER TABLE [dbo].[Reto] ADD  DEFAULT ((1)) FOR [vidas]
GO
ALTER TABLE [dbo].[Reto] ADD  DEFAULT ((60000)) FOR [tiempo_ms]
GO
ALTER TABLE [dbo].[Reto] ADD  DEFAULT ((1)) FOR [puntosRecompensa]
GO
ALTER TABLE [dbo].[Reto] ADD  DEFAULT ((1)) FOR [creditosObtenidos]
GO
ALTER TABLE [dbo].[Reto] ADD  DEFAULT (getdate()) FOR [fechaCreacion]
GO
ALTER TABLE [dbo].[Reto] ADD  DEFAULT (getdate()) FOR [fechaModificacion]
GO
ALTER TABLE [dbo].[Reto] ADD  DEFAULT ((100)) FOR [criterioMinimo]
GO
ALTER TABLE [dbo].[Reto] ADD  DEFAULT ((0)) FOR [enEquipo]
GO
ALTER TABLE [dbo].[Reto] ADD  DEFAULT ((0)) FOR [opsRequeridas]
GO
ALTER TABLE [dbo].[Reto] ADD  DEFAULT ((0)) FOR [items]
GO
ALTER TABLE [dbo].[Rol] ADD  DEFAULT ((1)) FOR [estado]
GO
ALTER TABLE [dbo].[Rol] ADD  DEFAULT (getdate()) FOR [fechaCreacion]
GO
ALTER TABLE [dbo].[Rol] ADD  DEFAULT (getdate()) FOR [fechaModificacion]
GO
ALTER TABLE [dbo].[TipoArchivo] ADD  DEFAULT (newid()) FOR [idTipoArchivo]
GO
ALTER TABLE [dbo].[TipoArchivo] ADD  DEFAULT ((1)) FOR [estado]
GO
ALTER TABLE [dbo].[TipoArchivo] ADD  DEFAULT (getdate()) FOR [fechaCreacion]
GO
ALTER TABLE [dbo].[TipoArchivo] ADD  DEFAULT (getdate()) FOR [fechaModificacion]
GO
ALTER TABLE [dbo].[TipoEncuesta] ADD  DEFAULT (newid()) FOR [idTipoEncuesta]
GO
ALTER TABLE [dbo].[TipoEncuesta] ADD  DEFAULT ((1)) FOR [estado]
GO
ALTER TABLE [dbo].[TipoEncuesta] ADD  DEFAULT (getdate()) FOR [fechaCreacion]
GO
ALTER TABLE [dbo].[TipoEncuesta] ADD  DEFAULT (getdate()) FOR [fechaModificacion]
GO
ALTER TABLE [dbo].[TipoEntrada] ADD  DEFAULT (newid()) FOR [idTipoEntrada]
GO
ALTER TABLE [dbo].[TipoEntrada] ADD  DEFAULT ((1)) FOR [estado]
GO
ALTER TABLE [dbo].[TipoEntrada] ADD  DEFAULT (getdate()) FOR [fechaCreacion]
GO
ALTER TABLE [dbo].[TipoEntrada] ADD  DEFAULT (getdate()) FOR [fechaModificacion]
GO
ALTER TABLE [dbo].[TipoReto] ADD  DEFAULT (newid()) FOR [idTipoReto]
GO
ALTER TABLE [dbo].[TipoReto] ADD  DEFAULT ((1)) FOR [estado]
GO
ALTER TABLE [dbo].[TipoReto] ADD  DEFAULT (getdate()) FOR [fechaCreacion]
GO
ALTER TABLE [dbo].[TipoReto] ADD  DEFAULT (getdate()) FOR [fechaModificacion]
GO
ALTER TABLE [dbo].[TipoValidador] ADD  DEFAULT (newid()) FOR [idTipoValidador]
GO
ALTER TABLE [dbo].[TipoValidador] ADD  DEFAULT ((1)) FOR [estado]
GO
ALTER TABLE [dbo].[TipoValidador] ADD  DEFAULT (getdate()) FOR [fechaCreacion]
GO
ALTER TABLE [dbo].[TipoValidador] ADD  DEFAULT (getdate()) FOR [fechaModificacion]
GO
ALTER TABLE [dbo].[Usuario] ADD  DEFAULT (newid()) FOR [idUsuario]
GO
ALTER TABLE [dbo].[Usuario] ADD  DEFAULT ((1)) FOR [estado]
GO
ALTER TABLE [dbo].[Usuario] ADD  DEFAULT (getdate()) FOR [fechaCreacion]
GO
ALTER TABLE [dbo].[Usuario] ADD  DEFAULT (getdate()) FOR [fechaModificacion]
GO
ALTER TABLE [dbo].[Usuario] ADD  DEFAULT (0x00) FOR [clave]
GO
ALTER TABLE [dbo].[Usuario] ADD  DEFAULT ((0)) FOR [creditos]
GO
ALTER TABLE [dbo].[Usuario_Equipo] ADD  DEFAULT (getdate()) FOR [fechaCreacion]
GO
ALTER TABLE [dbo].[Usuario_Equipo] ADD  DEFAULT (getdate()) FOR [fechaModificacion]
GO
ALTER TABLE [dbo].[Usuario_Medalla] ADD  DEFAULT (getdate()) FOR [fechaCreacion]
GO
ALTER TABLE [dbo].[Usuario_Medalla] ADD  DEFAULT (getdate()) FOR [fechaModificacion]
GO
ALTER TABLE [dbo].[Usuario_Nivel] ADD  DEFAULT (getdate()) FOR [fechaCreacion]
GO
ALTER TABLE [dbo].[Usuario_Nivel] ADD  DEFAULT (getdate()) FOR [fechaModificacion]
GO
ALTER TABLE [dbo].[Usuario_Noticia] ADD  DEFAULT ((0)) FOR [likes]
GO
ALTER TABLE [dbo].[Usuario_Noticia] ADD  DEFAULT (getdate()) FOR [fechaCreacion]
GO
ALTER TABLE [dbo].[Usuario_Noticia] ADD  DEFAULT (getdate()) FOR [fechaModificacion]
GO
ALTER TABLE [dbo].[Usuario_Recompensa] ADD  DEFAULT (getdate()) FOR [fechaCreacion]
GO
ALTER TABLE [dbo].[Usuario_Recompensa] ADD  DEFAULT (getdate()) FOR [fechaModificacion]
GO
ALTER TABLE [dbo].[Usuario_RedSocial] ADD  DEFAULT ((0)) FOR [likes]
GO
ALTER TABLE [dbo].[Usuario_RedSocial] ADD  DEFAULT (getdate()) FOR [fechaCreacion]
GO
ALTER TABLE [dbo].[Usuario_RedSocial] ADD  DEFAULT (getdate()) FOR [fechaModificacion]
GO
ALTER TABLE [dbo].[Usuario_Reto] ADD  DEFAULT ((0)) FOR [puntos]
GO
ALTER TABLE [dbo].[Usuario_Reto] ADD  DEFAULT ((0)) FOR [tiempo]
GO
ALTER TABLE [dbo].[Usuario_Reto] ADD  DEFAULT ((0)) FOR [vidas]
GO
ALTER TABLE [dbo].[Usuario_Reto] ADD  DEFAULT (getdate()) FOR [fechaCreacion]
GO
ALTER TABLE [dbo].[Usuario_Reto] ADD  DEFAULT (getdate()) FOR [fechaModificacion]
GO
ALTER TABLE [dbo].[Usuario_Reto] ADD  DEFAULT ((0)) FOR [completado]
GO
ALTER TABLE [dbo].[Usuario_Reto] ADD  DEFAULT (getdate()) FOR [fechaAsignacion]
GO
ALTER TABLE [dbo].[Usuario_Reto] ADD  DEFAULT ((0)) FOR [tieneEquipo]
GO
ALTER TABLE [dbo].[Usuario_Reto] ADD  DEFAULT ((0)) FOR [validador]
GO
ALTER TABLE [dbo].[Usuario_Reto] ADD  DEFAULT ((0)) FOR [correctas]
GO
ALTER TABLE [dbo].[Usuario_Reto] ADD  DEFAULT ((0)) FOR [incorrectas]
GO
ALTER TABLE [dbo].[UsuarioxArchivo] ADD  DEFAULT (getdate()) FOR [fechaCreacion]
GO
ALTER TABLE [dbo].[UsuarioxArchivo] ADD  DEFAULT (getdate()) FOR [fechaModificacion]
GO
ALTER TABLE [dbo].[UsuarioxOpcion] ADD  DEFAULT (getdate()) FOR [fechaCreacion]
GO
ALTER TABLE [dbo].[UsuarioxOpcion] ADD  DEFAULT (getdate()) FOR [fechaModificacion]
GO
ALTER TABLE [dbo].[Area]  WITH CHECK ADD FOREIGN KEY([idEmpresa])
REFERENCES [dbo].[Empresa] ([idEmpresa])
GO
ALTER TABLE [dbo].[Ciudad]  WITH CHECK ADD FOREIGN KEY([idPais])
REFERENCES [dbo].[Pais] ([idPais])
GO
ALTER TABLE [dbo].[Configuracion]  WITH CHECK ADD FOREIGN KEY([idUsuario])
REFERENCES [dbo].[Usuario] ([idUsuario])
GO
ALTER TABLE [dbo].[Inicio]  WITH CHECK ADD FOREIGN KEY([idRol])
REFERENCES [dbo].[Rol] ([idRol])
GO
ALTER TABLE [dbo].[Medalla]  WITH CHECK ADD FOREIGN KEY([idCondicion])
REFERENCES [dbo].[Condicion] ([idCondicion])
GO
ALTER TABLE [dbo].[Noticia]  WITH CHECK ADD FOREIGN KEY([idCategoria])
REFERENCES [dbo].[CategoriaNoticia] ([idCategoria])
GO
ALTER TABLE [dbo].[Novedad]  WITH CHECK ADD FOREIGN KEY([idUsuario])
REFERENCES [dbo].[Usuario] ([idUsuario])
GO
ALTER TABLE [dbo].[Opcion]  WITH CHECK ADD FOREIGN KEY([idPregunta])
REFERENCES [dbo].[Pregunta] ([idPregunta])
GO
ALTER TABLE [dbo].[Opcion]  WITH CHECK ADD FOREIGN KEY([idTipoEntrada])
REFERENCES [dbo].[TipoEntrada] ([idTipoEntrada])
GO
ALTER TABLE [dbo].[Pregunta]  WITH CHECK ADD FOREIGN KEY([idReto])
REFERENCES [dbo].[Reto] ([idReto])
GO
ALTER TABLE [dbo].[Recompensa]  WITH CHECK ADD FOREIGN KEY([idCategoria])
REFERENCES [dbo].[CategoriaRecompensa] ([idCategoria])
GO
ALTER TABLE [dbo].[Reto]  WITH CHECK ADD FOREIGN KEY([idComportamiento])
REFERENCES [dbo].[ComportamientoPregunta] ([idComportamiento])
GO
ALTER TABLE [dbo].[Reto]  WITH CHECK ADD FOREIGN KEY([idTipoArchivo])
REFERENCES [dbo].[TipoArchivo] ([idTipoArchivo])
GO
ALTER TABLE [dbo].[Reto]  WITH CHECK ADD FOREIGN KEY([idTipoEncuesta])
REFERENCES [dbo].[TipoEncuesta] ([idTipoEncuesta])
GO
ALTER TABLE [dbo].[Reto]  WITH CHECK ADD FOREIGN KEY([idTipoReto])
REFERENCES [dbo].[TipoReto] ([idTipoReto])
GO
ALTER TABLE [dbo].[Reto]  WITH CHECK ADD FOREIGN KEY([idTipoValidador])
REFERENCES [dbo].[TipoValidador] ([idTipoValidador])
GO
ALTER TABLE [dbo].[Usuario]  WITH CHECK ADD FOREIGN KEY([idArea])
REFERENCES [dbo].[Area] ([idArea])
GO
ALTER TABLE [dbo].[Usuario]  WITH CHECK ADD FOREIGN KEY([idCiudad])
REFERENCES [dbo].[Ciudad] ([idCiudad])
GO
ALTER TABLE [dbo].[Usuario]  WITH CHECK ADD FOREIGN KEY([idRol])
REFERENCES [dbo].[Rol] ([idRol])
GO
ALTER TABLE [dbo].[Usuario_Equipo]  WITH CHECK ADD FOREIGN KEY([idEquipo])
REFERENCES [dbo].[Equipo] ([idEquipo])
GO
ALTER TABLE [dbo].[Usuario_Equipo]  WITH CHECK ADD FOREIGN KEY([idUsuario])
REFERENCES [dbo].[Usuario] ([idUsuario])
GO
ALTER TABLE [dbo].[Usuario_Medalla]  WITH CHECK ADD FOREIGN KEY([idMedalla])
REFERENCES [dbo].[Medalla] ([idMedalla])
GO
ALTER TABLE [dbo].[Usuario_Medalla]  WITH CHECK ADD FOREIGN KEY([idUsuario])
REFERENCES [dbo].[Usuario] ([idUsuario])
GO
ALTER TABLE [dbo].[Usuario_Nivel]  WITH CHECK ADD FOREIGN KEY([idNivel])
REFERENCES [dbo].[Nivel] ([idNivel])
GO
ALTER TABLE [dbo].[Usuario_Nivel]  WITH CHECK ADD FOREIGN KEY([idUsuario])
REFERENCES [dbo].[Usuario] ([idUsuario])
GO
ALTER TABLE [dbo].[Usuario_Noticia]  WITH CHECK ADD FOREIGN KEY([idNoticia])
REFERENCES [dbo].[Noticia] ([idNoticia])
GO
ALTER TABLE [dbo].[Usuario_Noticia]  WITH CHECK ADD FOREIGN KEY([idUsuario])
REFERENCES [dbo].[Usuario] ([idUsuario])
GO
ALTER TABLE [dbo].[Usuario_Recompensa]  WITH CHECK ADD FOREIGN KEY([idRecompensa])
REFERENCES [dbo].[Recompensa] ([idRecompensa])
GO
ALTER TABLE [dbo].[Usuario_Recompensa]  WITH CHECK ADD FOREIGN KEY([idUsuario])
REFERENCES [dbo].[Usuario] ([idUsuario])
GO
ALTER TABLE [dbo].[Usuario_RedSocial]  WITH CHECK ADD FOREIGN KEY([idRed])
REFERENCES [dbo].[RedSocial] ([idRed])
GO
ALTER TABLE [dbo].[Usuario_RedSocial]  WITH CHECK ADD FOREIGN KEY([idUsuario])
REFERENCES [dbo].[Usuario] ([idUsuario])
GO
ALTER TABLE [dbo].[Usuario_Reto]  WITH CHECK ADD FOREIGN KEY([idReto])
REFERENCES [dbo].[Reto] ([idReto])
GO
ALTER TABLE [dbo].[Usuario_Reto]  WITH CHECK ADD FOREIGN KEY([idUsuario])
REFERENCES [dbo].[Usuario] ([idUsuario])
GO
/****** Object:  StoredProcedure [dbo].[sp_B_Area]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_B_Area] 
		
	@estado int,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;				
	
	Select a.idArea,
	a.nombre,
	a.descripcion,
	a.idEmpresa,
	e.nombre as 'empresa',
	a.estado,
	a.fechaCreacion,
	a.fechaModificacion
	From Area a
	Inner Join Empresa e on e.idEmpresa = a.idEmpresa
	Where (a.estado = @estado or @estado = -1)
	Order By a.fechaCreacion desc	

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_AreaById]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_B_AreaById] 
		
	@idArea uniqueidentifier,	
	@estado int,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;			
	
	declare @existeId int = 0
	Select @existeId = COUNT(*) From Area
	where idArea = @idArea

	if(@existeId > 0)
	begin

		Select a.idArea,
		a.nombre,
		a.descripcion,
		a.idEmpresa,
		e.nombre as 'empresa',
		a.estado,
		a.fechaCreacion,
		a.fechaModificacion
		From Area a
		Inner Join Empresa e on e.idEmpresa = a.idEmpresa
		Where (a.estado = @estado or @estado = -1) and a.idArea = @idArea
		Order By a.fechaCreacion desc		

		select @info = CONCAT('Empresa ', descripcion) from Constants where nombre = 'encontrar'		
		set @error = 0
	end
	else
	begin

		select @info = CONCAT('Empresa ', descripcion) from Constants where nombre = 'no_encontrar'
		set @error = 1

	end

	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_AreaByNombre]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_B_AreaByNombre] 
		
	@nombre varchar(65),
	@empresa varchar(100),

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;		
	
	Declare @totalFilas int = 0
	
	Select
	a.idArea,
	a.nombre,
	a.descripcion,
	a.idEmpresa,
	e.nombre as 'empresa',
	a.estado,
	a.fechaCreacion,
	a.fechaModificacion
	From Area a
	Inner Join Empresa e on e.idEmpresa = a.idEmpresa
	Where a.nombre = @nombre and e.nombre = @empresa
	Order By a.fechaCreacion desc

	set @totalFilas = @@ROWCOUNT

	if(@totalFilas > 0)
	begin

		select @info = descripcion from Constants where nombre = 'encontrar'
		set @error = 0
	end
	else
	begin
		
		select @info = descripcion from Constants where nombre = 'cero_filas'
		set @error = 1

	end

	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_CategoriaNoticia]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_B_CategoriaNoticia] 
		
	@estado int,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;				
	
	Select 
	c.idCategoria,
	c.nombre,
	ISNULL(c.descripcion, 'N/A') as 'descripcion',
	c.estado,
	c.fechaCreacion,
	c.fechaModificacion
	From CategoriaNoticia c
	where (c.estado = @estado or @estado = -1)
	Order By c.fechaCreacion desc			

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_CategoriaNoticiaByAll]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_B_CategoriaNoticiaByAll] 
		
	@buscar varchar(max),

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;			
	
	Declare @totalFilas int  = 0
	
	Select * From CategoriaNoticia c
	Where
	c.nombre like '%'+@buscar+'%' or
	c.descripcion like '%'+@buscar+'%'
	Order By c.fechaCreacion desc	


	select @totalFilas = @@ROWCOUNT

	if(@totalFilas > 0)
	begin

		select @info = descripcion from Constants where nombre = 'encontrar'
		set @error = 0

	end
	else
	begin

		select @info = descripcion from Constants where nombre = 'cero_filas'
		set @error = 1

	end

	print @info	

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_CategoriaNoticiaById]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_B_CategoriaNoticiaById] 
		
	@idCategoria uniqueidentifier,	
	@estado int,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;	
	
	declare @existeId int = 0
	Select @existeId = COUNT(*) From CategoriaNoticia
	where idCategoria = @idCategoria
	
	if(@existeId > 0)
	begin

		Select * From CategoriaNoticia c
		where (c.estado = @estado or @estado = -1) and c.idCategoria = @idCategoria
		Order By c.fechaCreacion desc			

		select @info = CONCAT('Categoría ', descripcion) from Constants where nombre = 'encontrar'		
		set @error = 0

	end
	else
	begin

		select @info = CONCAT('Categoría ', descripcion) from Constants where nombre = 'no_encontrar'
		set @error = 1

	end

	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_CategoriaRecompensa]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_B_CategoriaRecompensa] 
		
	@estado int,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;				
	
	Select 
	c.idCategoria,
	c.nombre,
	ISNULL(c.descripcion, 'N/A') as 'descripcion',
	c.estado,
	c.fechaCreacion,
	c.fechaModificacion
	From CategoriaRecompensa c
	where (c.estado = @estado or @estado = -1)
	Order By c.fechaCreacion desc	

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_CategoriaRecompensaByAll]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_B_CategoriaRecompensaByAll] 
		
	@buscar varchar(max),

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;			
	
	Declare @totalFilas int  = 0
	
	Select * From CategoriaRecompensa c
	Where
	c.nombre like '%'+@buscar+'%' or
	c.descripcion like '%'+@buscar+'%'
	Order By c.fechaCreacion desc	


	select @totalFilas = @@ROWCOUNT

	if(@totalFilas > 0)
	begin

		select @info = descripcion from Constants where nombre = 'encontrar'
		set @error = 0

	end
	else
	begin

		select @info = descripcion from Constants where nombre = 'cero_filas'
		set @error = 1

	end

	print @info	

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_CategoriaRecompensaById]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_B_CategoriaRecompensaById] 
		
	@idCategoria uniqueidentifier,	
	@estado int,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;	
	
	declare @existeId int = 0
	Select @existeId = COUNT(*) From CategoriaRecompensa
	where idCategoria = @idCategoria
	
	if(@existeId > 0)
	begin

		Select * From CategoriaRecompensa c
		where (c.estado = @estado or @estado = -1) and c.idCategoria = @idCategoria
		Order By c.fechaCreacion desc				

		select @info = CONCAT('Categoría ', descripcion) from Constants where nombre = 'encontrar'		
		set @error = 0

	end
	else
	begin

		select @info = CONCAT('Categoría ', descripcion) from Constants where nombre = 'no_encontrar'
		set @error = 1

	end

	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_Ciudad]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_B_Ciudad] 
		
	@estado int,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;			
	
	Select c.idCiudad,
	c.nombre,
	c.descripcion,
	c.idPais,
	p.nombre as 'pais',
	c.estado,
	c.fechaCreacion,
	c.fechaModificacion
	From Ciudad c
	Inner join Pais p on p.idPais = c.idPais
	Where (c.estado = @estado or @estado = -1)
	Order By c.fechaCreacion desc			

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_CiudadById]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_B_CiudadById] 
		
	@idCiudad uniqueidentifier,	
	@estado int,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;			

	declare @existeId int = 0
	Select @existeId = COUNT(*) From Ciudad
	where idCiudad = @idCiudad
	
	if(@existeId > 0)
	begin

		Select c.idCiudad,
		c.nombre,
		c.descripcion,
		c.idPais,
		p.nombre as 'pais',
		c.estado,
		c.fechaCreacion,
		c.fechaModificacion
		From Ciudad c
		Inner join Pais p on p.idPais = c.idPais
		Where (c.estado = @estado or @estado = -1) and c.idCiudad = @idCiudad
		Order By c.fechaCreacion desc

		select @info = CONCAT('Ciudad ', descripcion) from Constants where nombre = 'encontrar'		
		set @error = 0

	end
	else
	begin

		select @info = CONCAT('Ciudad ', descripcion) from Constants where nombre = 'no_encontrar'
		set @error = 1

	end

	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_CiudadByNombre]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_B_CiudadByNombre] 
		
	@nombre varchar(65),		

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;			

	Declare @totalFilas int = 0
	
	Select
	c.idCiudad,
	c.nombre,
	c.descripcion,
	c.idPais,
	p.nombre as 'pais',
	c.estado,
	c.fechaCreacion,
	c.fechaModificacion
	From Ciudad c
	Inner join Pais p on p.idPais = c.idPais
	Where c.nombre = @nombre
	Order By c.fechaCreacion desc

	set @totalFilas = @@ROWCOUNT

	if(@totalFilas > 0)
	begin

		select @info = descripcion from Constants where nombre = 'encontrar'
		set @error = 0
	end
	else
	begin
		
		select @info = descripcion from Constants where nombre = 'cero_filas'
		set @error = 1

	end

	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_ComporPregu]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_B_ComporPregu] 
		
	@estado int,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;				
		
	Select * 
	From ComportamientoPregunta cp
	Where (cp.estado = @estado or @estado = -1)
	Order By cp.fechaCreacion desc		

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_Condicion]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_B_Condicion] 
		
	@estado int,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;			
	
	Select * 
	From Condicion c
	Where (c.estado = @estado or @estado = -1)
	Order By c.fechaCreacion Desc				

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_Configuracion]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_B_Configuracion]  		

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;		
	
	Select c.idConfig,
	c.tipo,
	c.propiedad,
	c.nombre,
	ISNULL(c.valor, 'N/A') as 'valor',
	c.descripcion,
	c.idUsuario,
	CONCAT(u.nombre,' ',u.apellido) as 'usuario',
	c.fechaCreacion,
	c.fechaModificacion
	From Configuracion c
	Inner Join Usuario u on u.idUsuario = c.idUsuario
	Order By c.fechaCreacion asc

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_ConfiguracionByNombre]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_B_ConfiguracionByNombre]  		

	@nombre varchar(30),

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;		

	Declare @totalFilas int = 0
	
	Select c.idConfig,
	c.tipo,
	c.propiedad,
	c.nombre,
	ISNULL(c.valor, 'N/A') as 'valor',
	c.descripcion,
	c.idUsuario,
	CONCAT(u.nombre,' ',u.apellido) as 'usuario',
	c.fechaCreacion,
	c.fechaModificacion
	From Configuracion c
	Inner Join Usuario u on u.idUsuario = c.idUsuario
	Where c.nombre = @nombre
	Order By c.fechaCreacion asc

	set @totalFilas = @@ROWCOUNT

	if(@totalFilas > 0)
	begin

		select @info = descripcion from Constants where nombre = 'encontrar'
		set @error = 0
	end
	else
	begin
		
		select @info = descripcion from Constants where nombre = 'cero_filas'
		set @error = 1

	end

	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_ConfiguracionByValor]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_B_ConfiguracionByValor]  		

	@valor varchar(50),

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;		

	Declare @totalFilas int = 0
	
	Select c.idConfig,
	c.tipo,
	c.propiedad,
	c.nombre,
	ISNULL(c.valor, 'N/A') as 'valor',
	c.descripcion,
	c.idUsuario,
	CONCAT(u.nombre,' ',u.apellido) as 'usuario',
	c.fechaCreacion,
	c.fechaModificacion
	From Configuracion c
	Inner Join Usuario u on u.idUsuario = c.idUsuario
	Where c.valor = @valor
	Order By c.fechaCreacion asc

	set @totalFilas = @@ROWCOUNT

	if(@totalFilas > 0)
	begin

		select @info = descripcion from Constants where nombre = 'encontrar'
		set @error = 0
	end
	else
	begin
		
		select @info = descripcion from Constants where nombre = 'cero_filas'
		set @error = 1

	end

	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_CorreoEnvio]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_B_CorreoEnvio] 			

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;				
	
	Select 
	ce.idCorreo,
	ce.nombre,
	ce.correo,
	ce.clave,
	ce.puerto,
	ce.host,
	(Select ISNULL(c.valor, 'N/A') from Configuracion c where c.nombre = 'header' and c.tipo = 'imagen') as 'imagen',
	(Select ISNULL(c.valor, 'N/A') from Configuracion c where c.nombre = 'primario' and c.tipo = 'color') as 'colorPrimario',
	(Select ISNULL(c.valor, 'N/A') from Configuracion c where c.nombre = 'secundario' and c.tipo = 'color') as 'colorSecundario',
	(Select ISNULL(c.valor, 'N/A') from Configuracion c where c.nombre = 'terciario' and c.tipo = 'color') as 'colorTerciario',
	(Select ISNULL(c.valor, 'N/A') from Configuracion c where c.nombre = 'url servicio' and c.tipo = 'url') as 'url',
	ce.fechaCreacion,
	ce.fechaModificacion
	From CorreoEnvio ce
	
	if(@@ROWCOUNT > 0)
	begin

		select @info = CONCAT('Correo de envio ', descripcion) from Constants where nombre = 'encontrar'		
		set @error = 0

	end
	else
	begin

		select @info = CONCAT('Correo de envio ', descripcion) from Constants where nombre = 'no_encontrar'
		set @error = 1

	end

	print @info
END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_Empresa]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_B_Empresa] 
		
	@estado int,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;			
		
	Select * From Empresa e
	where (e.estado = @estado or @estado = -1)
	Order By e.fechaCreacion desc

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_EmpresaById]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_B_EmpresaById] 
		
	@idEmpresa uniqueidentifier,
	@estado int,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;			

	declare @existeId int = 0
	Select @existeId = COUNT(*) From Empresa
	where idEmpresa = @idEmpresa

	if(@existeId > 0)
	begin
	
		Select * From Empresa e
		where (e.estado = @estado or @estado = -1) and e.idEmpresa = @idEmpresa
		Order By e.fechaCreacion desc

		select @info = CONCAT('Empresa ', descripcion) from Constants where nombre = 'encontrar'		
		set @error = 0

	end
	else
	begin

		select @info = CONCAT('Empresa ', descripcion) from Constants where nombre = 'no_encontrar'
		set @error = 1

	end
	
	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_Equipo]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_B_Equipo] 
		
	@estado int,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;				
		
	Select e.idEquipo,
	e.nombre,
	ISNULL(e.imagen, 'N/A') as 'imagen',
	ISNULL(e.descripcion, 'N/A') as 'descripcion',
	(select COUNT(*) from Usuario_Equipo ue where ue.idEquipo = e.idEquipo) as 'totalUsuarios',
	e.estado,
	e.fechaCreacion,
	e.fechaModificacion
	From Equipo e
	Where (e.estado = @estado or @estado = -1)
	Order By e.fechaCreacion desc

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_Equipo_RetoByIdReto]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_B_Equipo_RetoByIdReto] 	

	@idReto uniqueidentifier,
	@estado int,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;		
	
	declare @existeId int = 0
	Select @existeId = COUNT(*) From Reto
	where idReto = @idReto

	if(@existeId > 0)
	begin
		
		Select 	
		ur.idReto,
		e.idEquipo,
		count(ue.idEquipo) as 'totalUsuarios',
		e.nombre,
		ISNULL(e.imagen, 'N/A') as 'imagen',
		e.estado
		From Usuario_Reto ur 
		inner join Usuario_Equipo ue on ue.idUsuario = ur.idUsuario
		inner join Equipo e on e.idEquipo = ue.idEquipo 
		Where ur.tieneEquipo = 1 and ur.idReto  = @idReto and (e.estado = @estado or @estado = -1)
		Group by ue.idEquipo, ur.idReto, e.idEquipo, e.nombre, e.imagen, e.estado

		select @info = CONCAT('Equipo ', descripcion) from Constants where nombre = 'encontrar'		
		set @error = 0

	end
	else
	begin

		select @info = CONCAT('Equipo ', descripcion) from Constants where nombre = 'no_encontrar'
		set @error = 1

	end

	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_EquipoByAll]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_B_EquipoByAll] 
		
	@buscar varchar(max),

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;			
	--select * from Equipo

	Declare @totalFilas int  = 0
	
	Select e.idEquipo,
	e.nombre,
	ISNULL(e.imagen, 'N/A') as 'imagen',
	ISNULL(e.descripcion, 'N/A') as 'descripcion',
	(select COUNT(*) from Usuario_Equipo ue where ue.idEquipo = e.idEquipo) as 'totalUsuarios',
	e.estado,
	e.fechaCreacion,
	e.fechaModificacion
	From Equipo e
	Where e.nombre like '%'+@buscar+'%' or
	e.descripcion like '%'+@buscar+'%'
	Order By e.fechaCreacion desc	

	select @totalFilas = @@ROWCOUNT

	if(@totalFilas > 0)
	begin

		select @info = descripcion from Constants where nombre = 'encontrar'
		set @error = 0

	end
	else
	begin

		select @info = descripcion from Constants where nombre = 'cero_filas'
		set @error = 1

	end

	print @info	

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_EquipoById]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_B_EquipoById] 
		
	@idEquipo uniqueidentifier,
	@estado int,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;		

	declare @existeId int = 0
	Select @existeId = COUNT(*) From Equipo
	where idEquipo = @idEquipo
	
	if(@existeId > 0)
	begin
	
		Select e.idEquipo,
		e.nombre,
		ISNULL(e.imagen, 'N/A') as 'imagen',
		e.descripcion,
		(select COUNT(*) from Usuario_Equipo ue where ue.idEquipo = e.idEquipo) as 'totalUsuarios',
		e.estado,
		e.fechaCreacion,
		e.fechaModificacion
		From Equipo e
		Where (e.estado = @estado or @estado = -1) and e.idEquipo = @idEquipo
		Order By e.fechaCreacion desc

		select @info = CONCAT('Equipo ', descripcion) from Constants where nombre = 'encontrar'		
		set @error = 0

	end
	else
	begin

		select @info = CONCAT('Equipo ', descripcion) from Constants where nombre = 'no_encontrar'
		set @error = 1

	end	

	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_Inicio]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_B_Inicio] 		

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;
	
	Select * 
	From Inicio i	
	Order By i.indice asc
	

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_InicioByIdRol]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_B_InicioByIdRol] 
		
	@idRol varchar(9),

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;
	
	Declare @existeId int = 0
	Select @existeId = COUNT(*) From Rol where idRol = @idRol

	if(@existeId > 0)
	begin
		
		Select * 
		From Inicio i
		Where i.idRol = @idRol
		Order By i.indice asc

		Select @info = descripcion  from Constants where nombre = 'encontrar'		
		set @error = 0

	end
	else
	begin

		set @info = 'No existe el Rol'
		set @error = 1

	end

	print @info	

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_Licencia]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_B_Licencia] 
		
	@estado int,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;			

	Declare @auxTable table (idLicencia uniqueidentifier, tabla varchar(60), nombre varchar(60), cantidadUsada int, cantidadMaxima int, porcentajeUso int, estado int, fechaCreacion datetime, fechaModificacion datetime)			
	Declare @idLicencia uniqueidentifier, @tabla varchar(60), @nombre varchar(60), @cantMax int, @auxEstado int, @fechaCreacion datetime, @fechaModificacion datetime

	DECLARE LicenciasInfo CURSOR FOR 

	Select idLicencia, tabla, nombre, cantidadMaxima, estado, fechaCreacion, fechaModificacion From Licencia		

	OPEN LicenciasInfo
	FETCH NEXT FROM LicenciasInfo INTO @idLicencia, @tabla, @nombre, @cantMax, @auxEstado, @fechaCreacion, @fechaModificacion
	WHILE @@fetch_status = 0
	BEGIN
			
		DECLARE @sql nvarchar(100), @cantUsada int = 0, @porcentajeUso int = 0

		set @sql = CONCAT('Select @cantUsada = COUNT(*) From ', QUOTENAME(@tabla));
		exec sp_executesql @sql, N'@cantUsada int output', @cantUsada output;

		if(@cantMax > 0)
		begin
			set @porcentajeUso = (@cantUsada * 100) / @cantMax
		end

		if(@porcentajeUso >= 100)
		begin
			set @porcentajeUso = 100
		end		

		Insert into @auxTable (idLicencia, tabla, nombre, cantidadUsada, cantidadMaxima, porcentajeUso, estado, fechaCreacion, fechaModificacion) values
		(@idLicencia, @tabla, @nombre, @cantUsada, @cantMax, @porcentajeUso, @auxEstado, @fechaCreacion, @fechaModificacion)			

		FETCH NEXT FROM LicenciasInfo INTO @idLicencia, @tabla, @nombre, @cantMax, @auxEstado, @fechaCreacion, @fechaModificacion
	END
	CLOSE LicenciasInfo
	DEALLOCATE LicenciasInfo

	
	Select * 
	From @auxTable 
	Where (estado = @estado or @estado = -1)
	Order by fechaCreacion desc

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_Medalla]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_B_Medalla] 
		
	@estado int,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;			
		
	Select m.idMedalla,
	m.nombre,
	m.descripcion,		
	ISNULL(m.imagen, 'N/A') as 'imagen',
	m.estado,
	(select COUNT(*) from Usuario_Medalla um where um.idMedalla = m.idMedalla) as 'totalUsuarios',
	m.idCondicion,		
	c.nombre as 'condicion',
	m.numCondicion,
	m.fechaCreacion,
	m.fechaModificacion
	From Medalla m
	Inner Join Condicion c on c.idCondicion = m.idCondicion
	where (m.estado = @estado or @estado = -1)
	Order by m.fechaCreacion desc	

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_MedallaByAll]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_B_MedallaByAll] 
		
	@buscar varchar(max),

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;		
	
	Declare @totalFilas int  = 0
	
	Select m.idMedalla,
	m.nombre,
	m.descripcion,		
	ISNULL(m.imagen, 'N/A') as 'imagen',
	m.estado,
	(select COUNT(*) from Usuario_Medalla um where um.idMedalla = m.idMedalla) as 'totalUsuarios',
	m.idCondicion,		
	c.nombre as 'condicion',
	m.numCondicion,
	m.fechaCreacion,
	m.fechaModificacion
	From Medalla m
	Inner Join Condicion c on c.idCondicion = m.idCondicion
	Where
	m.nombre like '%'+@buscar+'%' or
	m.descripcion like '%'+@buscar+'%' or
	c.nombre like '%'+@buscar+'%'
	Order by m.fechaCreacion desc	
	
	select @totalFilas = @@ROWCOUNT

	if(@totalFilas > 0)
	begin

		select @info = descripcion from Constants where nombre = 'encontrar'
		set @error = 0

	end
	else
	begin

		select @info = descripcion from Constants where nombre = 'cero_filas'
		set @error = 1

	end

	print @info			

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_MedallaById]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_B_MedallaById] 
		
	@idMedalla uniqueidentifier,	
	@estado int,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;		
	
	declare @existeId int = 0
	Select @existeId = COUNT(*) From Medalla
	where idMedalla = @idMedalla
	
	if(@existeId > 0)
	begin
		
		Select m.idMedalla,
		m.nombre,
		m.descripcion,		
		ISNULL(m.imagen, 'N/A') as 'imagen',
		m.estado,
		(select COUNT(*) from Usuario_Medalla um where um.idMedalla = m.idMedalla) as 'totalUsuarios',
		m.idCondicion,		
		c.nombre as 'condicion',
		m.numCondicion,
		m.fechaCreacion,
		m.fechaModificacion
		From Medalla m
		Inner Join Condicion c on c.idCondicion = m.idCondicion
		Where (m.estado = @estado or @estado = -1) and m.idMedalla = @idMedalla
		Order by m.fechaCreacion desc	

		select @info = CONCAT('Medalla ', descripcion) from Constants where nombre = 'encontrar'		
		set @error = 0

	end
	else
	begin

		select @info = CONCAT('Medalla ', descripcion) from Constants where nombre = 'no_encontrar'
		set @error = 1

	end

	print @info
	

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_Nivel]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_B_Nivel] 
		
	@estado int,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;			
			
	Select n.idNivel,
	n.nombre,
	n.descripcion,
	n.puntosNecesarios,
	ISNULL(n.imagen, 'N/A') as 'imagen',
	n.estado,
	(select COUNT(*) from Usuario_Nivel un where un.idNivel = n.idNivel) as 'totalUsuarios',
	n.fechaCreacion,
	n.fechaModificacion
	From Nivel n		
	where (n.estado = @estado or @estado = -1)
	Order by n.fechaCreacion desc		

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_NivelByAll]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_B_NivelByAll] 
		
	@buscar varchar(max),

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;		

	Declare @totalFilas int  = 0
	
	Select n.idNivel,
	n.nombre,	
	n.descripcion,
	n.puntosNecesarios,
	ISNULL(n.imagen, 'N/A') as 'imagen',
	n.estado,
	(select COUNT(*) from Usuario_Nivel un where un.idNivel = n.idNivel) as 'totalUsuarios',
	n.fechaCreacion,
	n.fechaModificacion
	From Nivel n
	Where
	n.nombre like '%'+@buscar+'%' or
	n.descripcion like '%'+@buscar+'%' or
	n.puntosNecesarios like '%'+@buscar+'%'
	Order by n.fechaCreacion desc	

	select @totalFilas = @@ROWCOUNT

	if(@totalFilas > 0)
	begin

		select @info = descripcion from Constants where nombre = 'encontrar'
		set @error = 0

	end
	else
	begin

		select @info = descripcion from Constants where nombre = 'cero_filas'
		set @error = 1

	end

	print @info		

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_NivelById]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_B_NivelById] 
		
	@idNivel uniqueidentifier,	
	@estado int,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;		

	declare @existeId int = 0
	Select @existeId = COUNT(*) From Nivel
	where idNivel = @idNivel

	if(@existeId > 0)
	begin
				
		Select n.idNivel,
		n.nombre,
		n.descripcion,
		n.puntosNecesarios,
		ISNULL(n.imagen, 'N/A') as 'imagen',
		n.estado,
		(select COUNT(*) from Usuario_Nivel un where un.idNivel = n.idNivel) as 'totalUsuarios',
		n.fechaCreacion,
		n.fechaModificacion
		From Nivel n		
		where (n.estado = @estado or @estado = -1) and n.idNivel = @idNivel
		Order by n.fechaCreacion desc		

		select @info = CONCAT('Nivel ', descripcion) from Constants where nombre = 'encontrar'		
		set @error = 0

	end
	else
	begin

		select @info = CONCAT('Nivel ', descripcion) from Constants where nombre = 'no_encontrar'
		set @error = 1

	end	

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_NivelByNextPuntos]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_B_NivelByNextPuntos] 			

	@puntos int,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;				

	Select top 1
	n.idNivel,
	n.nombre,	
	n.descripcion,
	n.puntosNecesarios,
	ISNULL(n.imagen, 'N/A') as 'imagen',
	n.estado,
	(select COUNT(*) from Usuario_Nivel un where un.idNivel = n.idNivel) as 'totalUsuarios',
	n.fechaCreacion,
	n.fechaModificacion
	From Nivel n 
	Where n.puntosNecesarios > @puntos
	Order by n.puntosNecesarios

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_Noticia]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_B_Noticia] 
		
	@estado int,
	@idUsuario uniqueidentifier,
	@idNoticia uniqueidentifier = null,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;			
		
	Select 
	n.idNoticia,
	n.titular,
	n.descripcion,
	n.url,
	ISNULL(n.imagen,'N/A') as 'imagen',
	n.estado,
	n.idCategoria,
	c.nombre as 'categoria',
	ISNULL(n.fechaPublicacion, '1800-01-01 00:00:00') as 'fechaPublicacion',
	(select COUNT(*) from Usuario_Noticia un where un.idNoticia = n.idNoticia and un.likes > 0) as 'totalLikes',
	(select COUNT(*) from Usuario_Noticia un where un.idNoticia = n.idNoticia and un.comentario is not null) as 'totalComents',
	(select COUNT(*) from Usuario_Noticia un where un.idNoticia = n.idNoticia and un.idUsuario = @idUsuario and likes = 1) as 'userLiked',
	n.fechaCreacion,
	n.fechaModificacion
	From Noticia n
	inner join CategoriaNoticia c on c.idCategoria = n.idCategoria
	where (n.estado = @estado or @estado = -1)
	Order by case when n.idNoticia = @idNoticia then 0 else 1 end, n.fechaCreacion desc			

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_Noticia_enTendencia]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_B_Noticia_enTendencia] 
		
	@estado int,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;			
	
	Select top 5
	n.idNoticia,
	n.titular,
	n.descripcion,
	n.url,
	ISNULL(n.imagen,'N/A') as 'imagen',
	n.estado,
	n.idCategoria,
	c.nombre as 'categoria',
	ISNULL(n.fechaPublicacion, '1800-01-01 00:00:00') as 'fechaPublicacion',
	(select COUNT(*) from Usuario_Noticia un where un.idNoticia = n.idNoticia and un.likes > 0) as 'totalLikes',
	(select COUNT(*) from Usuario_Noticia un where un.idNoticia = n.idNoticia and un.comentario is not null) as 'totalComents',
	n.fechaCreacion,
	n.fechaModificacion
	From Noticia n
	inner join CategoriaNoticia c on c.idCategoria = n.idCategoria
	where (n.estado = @estado or @estado = -1)
	Order by n.fechaCreacion desc		

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_NoticiaByAll]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_B_NoticiaByAll] 
		
	@buscar varchar(max),

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;		
	
	Declare @totalFilas int  = 0
	
	Select n.idNoticia,
	n.titular,
	n.descripcion,
	n.url,
	ISNULL(n.imagen,'N/A') as 'imagen',
	n.estado,
	n.idCategoria,
	c.nombre as 'categoria',
	ISNULL(n.fechaPublicacion, '1800-01-01 00:00:00') as 'fechaPublicacion',
	(select COUNT(*) from Usuario_Noticia un where un.idNoticia = n.idNoticia and un.likes > 0) as 'totalLikes',
	(select COUNT(*) from Usuario_Noticia un where un.idNoticia = n.idNoticia and un.comentario is not null) as 'totalComents',
	n.fechaCreacion,
	n.fechaModificacion
	From Noticia n
	inner join CategoriaNoticia c on c.idCategoria = n.idCategoria
	Where 
	n.titular like '%'+@buscar+'%' or
	n.descripcion like '%'+@buscar+'%' or
	n.url like '%'+@buscar+'%' or
	c.nombre like '%'+@buscar+'%'	
	Order by n.fechaCreacion desc				
	

	select @totalFilas = @@ROWCOUNT

	if(@totalFilas > 0)
	begin

		select @info = descripcion from Constants where nombre = 'encontrar'
		set @error = 0

	end
	else
	begin

		select @info = descripcion from Constants where nombre = 'cero_filas'
		set @error = 1

	end

	print @info		

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_NoticiaById]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_B_NoticiaById] 
		
	@idNoticia uniqueidentifier,
	@estado int,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;		
	
	declare @existeId int = 0
	Select @existeId = COUNT(*) From Noticia
	where idNoticia = @idNoticia
	
	if(@existeId > 0)
	begin
		
		Select n.idNoticia,
		n.titular,
		n.descripcion,
		n.url,
		ISNULL(n.imagen,'N/A') as 'imagen',
		n.estado,
		LOWER(n.idCategoria) as 'idCategoria',
		c.nombre as 'categoria',
		ISNULL(n.fechaPublicacion, '1800-01-01 00:00:00') as 'fechaPublicacion',
		(select COUNT(*) from Usuario_Noticia un where un.idNoticia = n.idNoticia and un.likes > 0) as 'totalLikes',
		(select COUNT(*) from Usuario_Noticia un where un.idNoticia = n.idNoticia and un.comentario is not null) as 'totalComents',
		n.fechaCreacion,
		n.fechaModificacion
		From Noticia n
		inner join CategoriaNoticia c on c.idCategoria = n.idCategoria
		where (n.estado = @estado or @estado = -1) and n.idNoticia = @idNoticia
		Order by n.fechaCreacion desc		

		select @info = CONCAT('Noticia ', descripcion) from Constants where nombre = 'encontrar'		
		set @error = 0

	end
	else
	begin

		select @info = CONCAT('Noticia ', descripcion) from Constants where nombre = 'no_encontrar'
		set @error = 1

	end

	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_Notificacion]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_B_Notificacion] 
		
	@estado int,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;			
	
	Select n.idNotificacion,
	n.nombre,
	n.estado,
	ISNULL(n.msgPersonalizado, 'N/A') as 'msgPersonalizado',
	ISNULL(n.descripcion, 'N/A') as 'descripcion',
	n.numDesc,
	n.enviarCorreo,
	n.fechaCreacion,
	n.fechaModificacion
	From Notificacion n
	Where (n.estado = @estado or @estado = -1)
	Order By n.fechaCreacion	

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_NotificacionById]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_B_NotificacionById] 
		
	@idNotificacion uniqueidentifier,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;			

	declare @existeId int = 0
	Select @existeId = COUNT(*) From Notificacion
	where idNotificacion = @idNotificacion

	if(@existeId > 0)
	begin

		Select * 
		From Notificacion n
		Where n.idNotificacion = @idNotificacion
		Order By n.fechaCreacion	

		select @info = CONCAT('Notificacion ', descripcion) from Constants where nombre = 'encontrar'		
		set @error = 0

	end
	else
	begin

		select @info = CONCAT('Notificacion ', descripcion) from Constants where nombre = 'no_encontrar'
		set @error = 1

	end

	print @info
	

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_NotificacionByNombre]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_B_NotificacionByNombre] 
		
	@nombre varchar(160),

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;			

	declare @existeNom int = 0
	Select @existeNom = COUNT(*) From Notificacion
	where nombre = @nombre

	if(@existeNom > 0)
	begin

		Select * 
		From Notificacion n
		Where n.nombre = @nombre
		Order By n.fechaCreacion	

		select @info = CONCAT('Notificacion ', descripcion) from Constants where nombre = 'encontrar'		
		set @error = 0

	end
	else
	begin

		select @info = CONCAT('Notificacion ', descripcion) from Constants where nombre = 'no_encontrar'
		set @error = 1

	end

	print @info
	

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_NovedadByIdUsuario]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_B_NovedadByIdUsuario] 
					
	@idUsuario uniqueidentifier,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;				
	
	Declare @tabla table (idNovedad uniqueidentifier, mensaje varchar(250), auxMsg varchar(99),  tabla varchar(30), ruta varchar(75), estado int, fechaCreacion datetime, fechaModificacion datetime)
	Declare @idNovedad uniqueidentifier, @mensaje varchar(250), @auxMsg varchar(99), @idTabla uniqueidentifier, @tableName varchar(30), @ruta varchar(60),  @estado int, @fechaC datetime, @fechaM datetime, @contNoLeidos int = 0

	-- Cursor
	DECLARE ProdInfo CURSOR FOR 

	Select 
		idNovedad, mensaje, auxMsg, idTabla, tabla, ruta, estado, fechaCreacion, fechaModificacion
	From Novedad
	Where idTabla is not null and tabla is not null and idUsuario = @idUsuario

	OPEN ProdInfo
	FETCH NEXT FROM ProdInfo INTO @idNovedad, @mensaje, @auxMsg, @idTabla, @tableName, @ruta, @estado, @fechaC, @fechaM
	WHILE @@fetch_status = 0
	BEGIN
    
		Declare @sql nvarchar(100), @nombre varchar(100), @columnIdTabla varchar(100), @auxIdTabla uniqueidentifier	

		Select @columnIdTabla = KU.COLUMN_NAME
		From INFORMATION_SCHEMA.TABLE_CONSTRAINTS AS TC
			INNER JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE AS KU
				ON TC.CONSTRAINT_TYPE = 'PRIMARY KEY'
				AND TC.CONSTRAINT_NAME = KU.CONSTRAINT_NAME
				AND KU.TABLE_NAME = @tableName
		Order By KU.TABLE_NAME, KU.ORDINAL_POSITION;

		set @sql = CONCAT('Select @nombre = nombre From ', QUOTENAME(@tableName), ' Where ',QUOTENAME(@columnIdTabla),'= @auxIdTabla');
		exec sp_executesql @sql, N'@auxIdTabla uniqueidentifier, @nombre varchar(100) output', @auxIdTabla = @idTabla, @nombre = @nombre output;

		Insert into @tabla (idNovedad, mensaje, auxMsg, tabla, ruta, estado, fechaCreacion, fechaModificacion) values
		(@idNovedad, 
		CONCAT(@mensaje,' ',@nombre),
		@auxMsg,
		@tableName,
		case when @ruta is null then null else CONCAT(@ruta,@idTabla) end,
		@estado,
		@fechaC, @fechaM
		)


		FETCH NEXT FROM ProdInfo INTO @idNovedad, @mensaje, @auxMsg, @idTabla, @tableName, @ruta, @estado, @fechaC, @fechaM
	END
	CLOSE ProdInfo
	DEALLOCATE ProdInfo
	-- Fin Cursor

	Insert into @tabla (idNovedad, mensaje, auxMsg, tabla, ruta, estado, fechaCreacion, fechaModificacion)
	Select 
		idNovedad,
		mensaje,
		@auxMsg,
		'N/A',
		ruta,
		estado,
		fechaCreacion,
		fechaModificacion
	From Novedad where idUsuario = @idUsuario and idTabla is null and tabla is null
		

	Select @contNoLeidos = COUNT(*) From @tabla where estado > 0
	Select * From @tabla Order By fechaCreacion desc

	print CONCAT('Cantidad de novedades: ',@@ROWCOUNT)
	set @info = CONCAT('Cantidad de novedades no leidas: ',@contNoLeidos)

	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_OpcionByIdPregunta]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_B_OpcionByIdPregunta] 
		
	@estado int,	
	@idPregunta uniqueidentifier,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;			

	Select 
	o.idOpcion,
	o.nombre,
	o.correcta,
	o.valor,
	o.estado,
	(select Count(*) from UsuarioxOpcion uxo where uxo.idOpcion = o.idOpcion) as 'cantVotos',
	(select Count(*) * o.valor from UsuarioxOpcion uxo where uxo.idOpcion = o.idOpcion) as 'cantVotosXvalor',
	idPregunta,
	o.idTipoEntrada,
	te.nombre as 'tipoEntrada',
	o.fechaCreacion,
	o.fechaModificacion
	from Opcion o
	Inner Join TipoEntrada te on te.idTipoEntrada = o.idTipoEntrada
	Where idPregunta = @idPregunta 
	and (o.estado = @estado or @estado = -1)
	Order By o.valor asc, o.fechaCreacion asc

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_OpcionByIdPreguntaIdUsuario]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_B_OpcionByIdPreguntaIdUsuario] 
		
	@estado int,	
	@idPregunta uniqueidentifier,
	@idUsuario uniqueidentifier,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;			

	Select 
	o.idOpcion,
	o.nombre,
	o.correcta,
	o.valor,
	o.estado,
	(select Count(*) from UsuarioxOpcion uxo where uxo.idOpcion = o.idOpcion and uxo.idUsuario = @idUsuario) as 'cantVotos',
	(select Count(*) * o.valor from UsuarioxOpcion uxo where uxo.idOpcion = o.idOpcion and uxo.idUsuario = @idUsuario) as 'cantVotosXvalor',
	idPregunta,
	o.idTipoEntrada,
	te.nombre as 'tipoEntrada',
	o.fechaCreacion,
	o.fechaModificacion
	from Opcion o
	Inner Join TipoEntrada te on te.idTipoEntrada = o.idTipoEntrada
	Where idPregunta = @idPregunta 
	and (o.estado = @estado or @estado = -1)
	Order By o.valor asc, o.fechaCreacion asc

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_Pais]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_B_Pais] 
		
	@estado int,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;			
		
	Select * From Pais p
	Where (p.estado = @estado or @estado = -1)
	Order By p.fechaCreacion desc

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_PaisById]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_B_PaisById] 
		
	@idPais uniqueidentifier,	
	@estado int,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;		
	
	declare @existeId int = 0
	Select @existeId = COUNT(*) From Pais
	where idPais = @idPais

	if(@existeId > 0)
	begin

		Select * From Pais p
		Where (p.estado = @estado or @estado = -1) and p.idPais = @idPais
		Order By p.fechaCreacion desc

		select @info = CONCAT('Pais ', descripcion) from Constants where nombre = 'encontrar'		
		set @error = 0
	end
	else
	begin

		select @info = CONCAT('Pais ', descripcion) from Constants where nombre = 'no_encontrar'
		set @error = 1

	end

	print @info
	

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_PreguntaByAll]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_B_PreguntaByAll] 
		
	@buscar varchar(max),	
	@idReto uniqueidentifier,	

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;	

	Declare @totalFilas int  = 0

	Select * 
	From Pregunta p
	Where (p.idReto = @idReto) and
	(p.nombre like '%'+@buscar+'%' or
	(select top 1 o.nombre from Opcion o where o.idPregunta = p.idPregunta) like '%'+@buscar+'%'
	)
	Order By p.fechaCreacion Desc						
	
	select @totalFilas = @@ROWCOUNT

	if(@totalFilas > 0)
	begin

		select @info = descripcion from Constants where nombre = 'encontrar'
		set @error = 0

	end
	else
	begin

		select @info = descripcion from Constants where nombre = 'cero_filas'
		set @error = 1

	end

	print @info		
END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_PreguntaById]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_B_PreguntaById] 
		
	@idPregunta uniqueidentifier,
	@estado int,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;	

	declare @existeId int = 0
	Select @existeId = COUNT(*) From Pregunta
	where idPregunta = @idPregunta

	if(@existeId > 0)
	begin
		
		Select * 
		From Pregunta p
		Where p.idPregunta = @idPregunta
		and (p.estado = @estado or @estado = -1)
		Order By p.fechaCreacion Desc			

		select @info = CONCAT('Pregunta ', descripcion) from Constants where nombre = 'encontrar'		
		set @error = 0

	end
	else
	begin

		select @info = CONCAT('Pregunta ', descripcion) from Constants where nombre = 'no_encontrar'
		set @error = 1

	end
			

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_PreguntaByIdReto]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_B_PreguntaByIdReto] 
		
	@estado int,
	@idReto uniqueidentifier,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;	
	
	Select * 
	From Pregunta p
	Where p.idReto = @idReto
	and (p.estado = @estado or @estado = -1)
	Order By p.fechaCreacion Desc			

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_Recompensa]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_B_Recompensa] 
		
	@estado int,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;			
	
	Select 
	r.idRecompensa,
	r.nombre,
	r.descripcion,		
	ISNULL(r.imagen, 'N/A') as 'imagen',
	r.cantDisponible,
	r.cantCanje,
	r.estado,
	(select COUNT(*) from Usuario_Recompensa ur where ur.idRecompensa = r.idRecompensa) as 'totalUsuarios',
	r.idCategoria,
	cr.nombre as 'categoria',
	r.fechaCreacion,
	r.fechaModificacion
	From Recompensa r
	Inner join CategoriaRecompensa cr on cr.idCategoria = r.idCategoria
	where (r.estado = @estado or @estado = -1)
	Order by r.fechaCreacion desc				

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_RecompensaByAll]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_B_RecompensaByAll] 
		
	@buscar varchar(max),
	@idCategoria varchar(40),

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;

	Declare @totalFilas int  = 0

	if(@idCategoria != '')
	begin

		Select r.idRecompensa,
		r.nombre,
		r.descripcion,		
		ISNULL(r.imagen, 'N/A') as 'imagen',
		r.cantDisponible,
		r.cantCanje,
		r.estado,
		(select COUNT(*) from Usuario_Recompensa ur where ur.idRecompensa = r.idRecompensa) as 'totalUsuarios',
		r.idCategoria,
		cr.nombre as 'categoria',
		r.fechaCreacion,
		r.fechaModificacion
		From Recompensa r
		Inner join CategoriaRecompensa cr on cr.idCategoria = r.idCategoria
		Where
		r.idCategoria = @idCategoria and 
		(r.nombre like '%'+@buscar+'%' or
		r.descripcion like '%'+@buscar+'%' or
		r.cantDisponible like '%'+@buscar+'%' or
		r.cantCanje like '%'+@buscar+'%')
		Order by r.fechaCreacion desc		

		set @totalFilas = @@ROWCOUNT

	end	
	else
	begin

		Select r.idRecompensa,
		r.nombre,
		r.descripcion,		
		ISNULL(r.imagen, 'N/A') as 'imagen',
		r.cantDisponible,
		r.cantCanje,
		r.estado,
		(select COUNT(*) from Usuario_Recompensa ur where ur.idRecompensa = r.idRecompensa) as 'totalUsuarios',
		r.idCategoria,
		cr.nombre as 'categoria',
		r.fechaCreacion,
		r.fechaModificacion
		From Recompensa r
		Inner join CategoriaRecompensa cr on cr.idCategoria = r.idCategoria
		Where
		r.nombre like '%'+@buscar+'%' or
		r.descripcion like '%'+@buscar+'%' or
		r.cantDisponible like '%'+@buscar+'%' or
		r.cantCanje like '%'+@buscar+'%'or
		cr.nombre like '%'+@buscar+'%'
		Order by r.fechaCreacion desc		

		set @totalFilas = @@ROWCOUNT

	end


	if(@totalFilas > 0)
	begin

		select @info = descripcion from Constants where nombre = 'encontrar'
		set @error = 0

	end
	else
	begin

		select @info = descripcion from Constants where nombre = 'cero_filas'
		set @error = 1

	end

	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_RecompensaById]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_B_RecompensaById] 
		
	@idRecompensa uniqueidentifier,	
	@estado int,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;			

	declare @existeId int = 0
	Select @existeId = COUNT(*) From Recompensa
	where idRecompensa = @idRecompensa
	
	if(@existeId > 0)
	begin
		
		Select r.idRecompensa,
		r.nombre,
		r.descripcion,		
		ISNULL(r.imagen, 'N/A') as 'imagen',
		r.cantDisponible,
		r.cantCanje,
		r.estado,
		(select COUNT(*) from Usuario_Recompensa ur where ur.idRecompensa = r.idRecompensa) as 'totalUsuarios',
		r.idCategoria,
		cr.nombre as 'categoria',
		r.fechaCreacion,
		r.fechaModificacion
		From Recompensa r
		Inner join CategoriaRecompensa cr on cr.idCategoria = r.idCategoria
		where (r.estado = @estado or @estado = -1) and r.idRecompensa = @idRecompensa
		Order by r.fechaCreacion desc				

		select @info = CONCAT('Recompensa ', descripcion) from Constants where nombre = 'encontrar'		
		set @error = 0

	end
	else
	begin

		select @info = CONCAT('Recompensa ', descripcion) from Constants where nombre = 'no_encontrar'
		set @error = 1

	end	

	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_RedSocial]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_B_RedSocial] 		
	
	@idUsuario uniqueidentifier,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;		

	Declare @tabla as table (idRed uniqueidentifier, descripcion varchar(30), usuario varchar(60), foto varchar(60), tipo varchar(60), dir varchar(12), imagen varchar(60), estado int, fechaPublicacion datetime, fechaCreacion datetime, fechaModificacion datetime)	
	
	Declare @idRed uniqueidentifier, @imagen varchar(60), @estado int, @fechaPublicacion datetime,  @fechaCreacion datetime, @fechaModificacion datetime
	Declare @desc varchar(30), @auxDesc varchar(150), @dir varchar(12),  @auxIdUsuario varchar(40), @idTipo varchar(40)
	Declare @usuario varchar(60), @foto varchar(60), @tipo varchar(60)


	DECLARE RedInfo CURSOR FOR 

	Select r.idRed, r.imagen, r.estado, r.fechaPublicacion, r.fechaCreacion, r.fechaModificacion From RedSocial r	

	OPEN RedInfo
	FETCH NEXT FROM RedInfo INTO @idRed, @imagen, @estado, @fechaPublicacion, @fechaCreacion, @fechaModificacion
	WHILE @@fetch_status = 0
	BEGIN

		Select @auxDesc = descripcion from RedSocial where idRed = @idRed		

		Select top 1 @auxIdUsuario = value from string_split(@auxDesc,'|')
		Select top 2 @desc = value from string_split(@auxDesc,'|')
		Select top 3 @idTipo = value from string_split(@auxDesc,'|')
		Select top 4 @dir  = value from string_split(@auxDesc,'|')

		Select @usuario = CONCAT(nombre,' ',apellido), @foto = foto from Usuario where idUsuario = @auxIdUsuario				
		
		Select @tipo = nombre from Medalla where idMedalla = @idTipo
		Select @tipo = nombre from Nivel where idNivel = @idTipo
		Select @tipo = nombre from Recompensa where idRecompensa = @idTipo

		Insert into @tabla (idRed, descripcion, usuario, foto, tipo, dir, imagen, estado, fechaPublicacion, fechaCreacion, fechaModificacion) values      
		(@idRed, @desc, @usuario, @foto, @tipo, @dir, @imagen, @estado, @fechaPublicacion, @fechaCreacion, @fechaModificacion)

		FETCH NEXT FROM RedInfo INTO @idRed, @imagen, @estado, @fechaPublicacion, @fechaCreacion, @fechaModificacion
	END
	CLOSE RedInfo
	DEALLOCATE RedInfo


	Select top 50
	r.idRed,
	r.descripcion,
	r.usuario,
	r.foto,
	r.tipo,
	r.dir,
	ISNULL(r.imagen,'N/A') as 'imagen',
	r.estado,
	ISNULL(r.fechaPublicacion, '1800-01-01 00:00:00') as 'fechaPublicacion',
	(select COUNT(*) from Usuario_RedSocial rs where rs.idRed = r.idRed and rs.likes > 0) as 'totalLikes',
	(select COUNT(*) from Usuario_RedSocial rs where rs.idRed = r.idRed and rs.comentario is not null) as 'totalComents',
	(select COUNT(*) from Usuario_RedSocial rs where rs.idRed = r.idRed and rs.idUsuario = @idUsuario and rs.likes = 1) as 'userLiked',
	r.fechaCreacion,
	r.fechaModificacion
	From @tabla r
	Order By r.fechaCreacion desc			

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_RedSocialByIdRedUser]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_B_RedSocialByIdRedUser] 
		
	@idRed uniqueidentifier,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;			
	
	Declare @desc varchar(200), @auxUserName AS nvarchar(60), @idUsuario varchar(40), @idUser uniqueidentifier, @userName varchar(60)
	Select @desc = descripcion from RedSocial where idRed = @idRed

	Select top 1 @idUsuario = value from string_split(@desc,'|')	

	Select @idUser = idUsuario, @userName = CONCAT(nombre,' ',apellido) from Usuario where idUsuario = @idUsuario

	if(@userName is null)
	begin

		set @id = @idUser
		set @info = 'Usuario no encontrado'
		set @error = 1

	end
	else 
	begin

		set @id = @idUser
		set @info = concat('Publicación de red social de ',ISNULL(@userName,'N/A'))
		set @error = 0

	end


	print @info	
	print @id
END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_resumenGeneral]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_B_resumenGeneral] 
	
	@idUsuario uniqueidentifier,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;			

	Declare @contId int = 0, @idRol varchar(9)
	Select @contId = COUNT(*), @idRol = idRol from Usuario where idUsuario = @idUsuario group by idRol		

	if(@contId > 0)
	begin
		
		Declare @table table(retosCompletados int, medallasConseguidas int, recompensasReclamadas int)
		Declare @retos int, @medallas int, @recompensas int


		if(@idRol = 'adm' or @idRol = 'sadm')
		begin

			Select @retos = COUNT(*) from Usuario_Reto where completado > 0
			Select @medallas = COUNT(*) from Usuario_Medalla
			Select @recompensas = COUNT(*) from Usuario_Recompensa

			Insert into @table (retosCompletados, medallasConseguidas, recompensasReclamadas) values
			(@retos, @medallas, @recompensas)

		end
		else
		begin
		
			Select @retos = COUNT(*) from Usuario_Reto where idUsuario = @idUsuario and completado > 0
			Select @medallas = COUNT(*) from Usuario_Medalla where idUsuario = @idUsuario
			Select @recompensas = COUNT(*) from Usuario_Recompensa where idUsuario = @idUsuario

			Insert into @table (retosCompletados, medallasConseguidas, recompensasReclamadas) values
			(@retos, @medallas, @recompensas)

		end

		Select * from @table	

		select @info = descripcion from Constants where nombre = 'encontrar'		
		set @error = 0
	end
	else
	begin

		select @info = descripcion from Constants where nombre = 'no_encontrar'
		set @error = 1

	end
	
		print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_Reto]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_B_Reto] 

	@estado int,
	@idUsuario uniqueidentifier,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;				
	
	Select r.idReto,
	r.nombre,
	r.fechaApetura,
	r.fechaCierre,	
	r.estado,
	r.vidas,
	r.tiempo_ms,
	r.puntosRecompensa,
	r.creditosObtenidos,
	r.instrucciones,
	ISNULL(r.imagen, 'N/A') as 'imagen',
	r.idTipoReto,
	tr.nombre as 'tipoReto',
	r.idTipoEncuesta,
	te.nombre as 'tipoEncuesta',
	r.idComportamiento,
	cp.nombre as 'comportamientoPregunta',	
	r.idTipoArchivo,
	ta.nombre as 'tipoArchivo',
	r.idTipoValidador,
	tv.nombre as 'tipoValidador',
	r.opsRequeridas,
	r.criterioMinimo,
	(select COUNT(*) from Pregunta p where p.idReto = r.idReto) as 'totalPreguntas', 

	(
		case r.enEquipo when 0 then 
			(select COUNT(*) from Usuario_Reto ur where ur.tieneEquipo = 0 and ur.validador = 0 and ur.idReto = r.idReto) 
		else 
			(select COUNT(*) from Usuario_Reto ur where ur.tieneEquipo = 1 and ur.validador = 0 and ur.idReto = r.idReto) 
		end
	) as 'usuariosAsignados',

	(dbo.sf_totalEquiposAsignadosByReto(r.idReto)) as 'equiposAsignados',	

	(select COUNT(*) from Usuario_Reto ur where ur.validador = 1 and ur.idReto = r.idReto) as 'validadores',

	(
		select COUNT(*)
		from Usuario_Reto ur		
		where ur.validador = 1 and ur.idUsuario = @idUsuario and ur.idReto = r.idReto
	) as 'puedeValidar', 

	r.enEquipo,
	r.items,	
	r.fechaCreacion,
	r.fechaModificacion
	From Reto r
	Inner Join tipoReto tr on tr.idTipoReto = r.idTipoReto
	Inner Join ComportamientoPregunta cp on cp.idComportamiento = r.idComportamiento
	Inner Join TipoEncuesta te on te.idTipoEncuesta = r.idTipoEncuesta
	Inner Join TipoValidador tv on tv.idTipoValidador = r.idTipoValidador
	Inner Join TipoArchivo ta on ta.idTipoArchivo = r.idTipoArchivo
	Where (r.estado = @estado or @estado = -1)
	Order By r.fechaCreacion Desc			

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_RetoByAll]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_B_RetoByAll] 

	@buscar varchar(max),
	@idUsuario uniqueidentifier,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;

	Declare @totalFilas int  = 0, @equipo varchar(10) = 'en equipo', @individual varchar(10) = 'individual'

	Select r.idReto,
	r.nombre,
	r.fechaApetura,
	r.fechaCierre,
	r.estado,
	r.vidas,
	r.tiempo_ms,
	r.puntosRecompensa,
	r.creditosObtenidos,
	r.instrucciones,
	ISNULL(r.imagen, 'N/A') as 'imagen',
	r.idTipoReto,
	tr.nombre as 'tipoReto',
	r.idTipoEncuesta,
	te.nombre as 'tipoEncuesta',
	r.idComportamiento,
	cp.nombre as 'comportamientoPregunta',	
	r.idTipoArchivo,
	ta.nombre as 'tipoArchivo',
	r.idTipoValidador,
	tv.nombre as 'tipoValidador',
	r.opsRequeridas,
	r.criterioMinimo,
	(select COUNT(*) from Pregunta p where p.idReto = r.idReto) as 'totalPreguntas', 

	(
		case r.enEquipo when 0 then 
			(select COUNT(*) from Usuario_Reto ur where ur.tieneEquipo = 0 and ur.validador = 0 and ur.idReto = r.idReto) 
		else 
			(select COUNT(*) from Usuario_Reto ur where ur.tieneEquipo = 1 and ur.validador = 0 and ur.idReto = r.idReto) 
		end
	) as 'usuariosAsignados',

	(dbo.sf_totalEquiposAsignadosByReto(r.idReto)) as 'equiposAsignados',	

	(select COUNT(*) from Usuario_Reto ur where ur.validador = 1 and ur.idReto = r.idReto) as 'validadores',

	(
		select COUNT(*)
		from Usuario_Reto ur		
		where ur.validador = 1 and ur.idUsuario = @idUsuario and ur.idReto = r.idReto
	) as 'puedeValidar', 

	r.enEquipo,
	r.items,	
	r.fechaCreacion,
	r.fechaModificacion
	From Reto r
	Inner Join tipoReto tr on tr.idTipoReto = r.idTipoReto
	Inner Join ComportamientoPregunta cp on cp.idComportamiento = r.idComportamiento
	Inner Join TipoEncuesta te on te.idTipoEncuesta = r.idTipoEncuesta
	Inner Join TipoValidador tv on tv.idTipoValidador = r.idTipoValidador
	Inner Join TipoArchivo ta on ta.idTipoArchivo = r.idTipoArchivo
	Where 
	r.nombre like '%'+@buscar+'%' or
	r.enEquipo = case when @equipo like '%'+@buscar+'%' then '1'
					when @individual like '%'+@buscar+'%' then '0' end or
	r.vidas like '%'+@buscar+'%' or
	r.tiempo_ms like '%'+@buscar+'%' or
	r.puntosRecompensa like '%'+@buscar+'%' or
	r.creditosObtenidos like '%'+@buscar+'%' or
	r.items like '%'+@buscar+'%' or	
	r.instrucciones like '%'+@buscar+'%' or
	tr.nombre like '%'+@buscar+'%' or
	cp.nombre like '%'+@buscar+'%' or
	te.nombre like '%'+@buscar+'%' or
	tv.nombre like '%'+@buscar+'%' or
	ta.nombre like '%'+@buscar+'%'
	Order By r.fechaCreacion Desc

	select @totalFilas = @@ROWCOUNT

	if(@totalFilas > 0)
	begin

		select @info = descripcion from Constants where nombre = 'encontrar'
		set @error = 0

	end
	else
	begin

		select @info = descripcion from Constants where nombre = 'cero_filas'
		set @error = 1

	end

	print @info	

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_RetoById]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_B_RetoById] 
	
	@idReto uniqueidentifier,
	@estado int,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;

	declare @existeId int = 0
	Select @existeId = COUNT(*) From Reto
	where idReto = @idReto

	if(@existeId > 0)
	begin
		
		Select r.idReto,
		r.nombre,
		r.fechaApetura,
		r.fechaCierre,
		r.estado,
		r.vidas,
		r.tiempo_ms,
		r.puntosRecompensa,
		r.creditosObtenidos,
		r.instrucciones,
		ISNULL(r.imagen,'N/A') as 'imagen',
		LOWER(r.idTipoReto) as 'idTipoReto',
		tr.nombre as 'tipoReto',
		LOWER(r.idTipoEncuesta) as 'idTipoEncuesta',
		te.nombre as 'tipoEncuesta',
		LOWER(r.idComportamiento) as 'idComportamiento',
		cp.nombre as 'comportamientoPregunta',
		r.idTipoArchivo,
		ta.nombre as 'tipoArchivo',
		ta.extension as 'extensionArchivo',
		r.idTipoValidador,
		tv.nombre as 'tipoValidador',
		r.opsRequeridas,
		r.criterioMinimo,
		(select COUNT(*) from Pregunta p where p.idReto = r.idReto) as 'totalPreguntas', 		
		r.enEquipo,
		r.items,		
		r.fechaCreacion,
		r.fechaModificacion
		From Reto r
		Inner Join tipoReto tr on tr.idTipoReto = r.idTipoReto
		Inner Join ComportamientoPregunta cp on cp.idComportamiento = r.idComportamiento
		Inner Join TipoEncuesta te on te.idTipoEncuesta = r.idTipoEncuesta
		Inner Join TipoValidador tv on tv.idTipoValidador = r.idTipoValidador
		Inner Join TipoArchivo ta on ta.idTipoArchivo = r.idTipoArchivo
		Where (r.estado = @estado or @estado = -1) and idReto = @idReto
		Order By r.fechaCreacion Desc				

		select @info = CONCAT('Reto ', descripcion) from Constants where nombre = 'encontrar'		
		set @error = 0

	end
	else
	begin

		select @info = CONCAT('Reto ', descripcion) from Constants where nombre = 'no_encontrar'
		set @error = 1

	end

	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_Rol]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_B_Rol] 

	@estado int,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;

	Select * From Rol Where (estado = @estado or @estado = -1)

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_TipoArchivo]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_B_TipoArchivo] 
		
	@estado int,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;				
		
	Select 
		ta.idTipoArchivo,
		ta.nombre,
		ta.extension,
		ta.descripcion,
		ta.estado,
		ta.fechaCreacion,
		ta.fechaModificacion
	From TipoArchivo ta
	Where (ta.estado = @estado or @estado = -1)
	Order By ta.fechaCreacion Desc		

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_TipoEncuesta]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_B_TipoEncuesta] 
		
	@estado int,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;				
		
	Select * 
	From TipoEncuesta te
	Where (te.estado = @estado or @estado = -1)
	Order By te.fechaCreacion Desc		

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_TipoEntrada]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_B_TipoEntrada] 
		
	@estado int,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;				
		
	Select * 
	From TipoEntrada te
	Where (te.estado = @estado or @estado = -1)
	Order By te.fechaCreacion Desc		

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_TipoReto]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_B_TipoReto] 
		
	@estado int,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;				
		
	Select * 
	From TipoReto tr
	Where (tr.estado = @estado or @estado = -1)
	Order By tr.fechaCreacion Desc		

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_TipoValidador]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_B_TipoValidador] 
		
	@estado int,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;				
		
	Select * 
	From tipoValidador tv
	Where (tv.estado = @estado or @estado = -1)
	Order By tv.fechaCreacion Desc		

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_TipoValidadorById]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_B_TipoValidadorById] 
		
	@estado int,
	@idTipoValidador uniqueidentifier,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;				

	declare @existeId int = 0
	Select @existeId = COUNT(*) From TipoValidador
	where idTipoValidador = @idTipoValidador

	if(@existeId > 0)
	begin		

		Select * 
		From tipoValidador tv
		Where tv.idTipoValidador = @idTipoValidador and (tv.estado = @estado or @estado = -1)
		Order By tv.fechaCreacion Desc		

		select @info = CONCAT('Tipo de validador ', descripcion) from Constants where nombre = 'encontrar'		
		set @error = 0
	end
	else
	begin

		select @info = CONCAT('Tipo de validador ', descripcion) from Constants where nombre = 'no_encontrar'
		set @error = 1

	end
		
	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_Usuario]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_B_Usuario] 
		
	@estado int,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;	
	
	Select u.idUsuario,
	u.nombre,
	u.apellido,
	u.correo,
	u.id,
	u.clave,
	u.paisIso2,
	Case When u.celular is not null then (case when u.paisCode is not null then CONCAT('+',u.paisCode,u.celular) else u.celular end) else 'N/A' end as 'celular',	
	ISNULL(u.foto, 'N/A') as 'foto',
	u.estado,
	u.idRol,
	r.nombre as 'rol',
	ISNULL(CAST(c.idPais as varchar(40)), 'N/A') as 'idPais',
	ISNULL((select p.nombre from Pais p where p.idPais = c.idPais),'N/A') as 'pais',
	ISNULL(CAST(u.idCiudad as varchar(40)), 'N/A') as 'idCiudad',
	ISNULL(c.nombre, 'N/A') as 'ciudad',		
	ISNULL(CAST(u.idArea as varchar(40)), 'N/A') as 'idArea',
	ISNULL(a.nombre, 'N/A') as 'area',		
	ISNULL(CAST(a.idEmpresa as varchar(40)), 'N/A') as 'idEmpresa',
	ISNULL((select e.nombre from Empresa e where e.idEmpresa = a.idEmpresa), 'N/A') as 'empresa',
	u.fechaCreacion,
	u.fechaModificacion
	From Usuario u 
	Inner Join Rol r on r.idRol = u.idRol 
	Left Join Area a on a.idArea = u.idArea
	Left Join Ciudad c on c.idCiudad = u.idCiudad
	where (u.estado = @estado or @estado = -1)
	Order by u.fechaCreacion desc	

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_Usuario_EquipoByIdEquipo]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_B_Usuario_EquipoByIdEquipo] 	

	@idEquipo uniqueidentifier,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;		

	Select 
	ue.idEquipo,
	u.idUsuario,
	isnull(u.foto, 'N/A') as 'foto',
	u.nombre,
	u.apellido,
	u.correo,
	u.idRol,
	(select nombre from Rol r where r.idRol = u.idRol) as 'rol',	
	u.estado,
	ue.fechaCreacion,
	ue.fechaModificacion
	From Usuario_Equipo ue
	Inner Join Usuario u on ue.idUsuario = u.idUsuario
	Where ue.idEquipo = @idEquipo
	Order by ue.fechaCreacion desc
		
END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_Usuario_EquipoByPuntos]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_B_Usuario_EquipoByPuntos] 

	@idUsuario uniqueidentifier,	
	@top int,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;

	Declare @table table (idEquipo uniqueidentifier, totalUsuarios int, nombre varchar(60), puntos int, tiempo int, posicion int, imagen varchar(60), estado int)
	Declare @idEquipo uniqueidentifier, @puntos int, @tiempo int, @posicion int, @auxPos int = 0
	
	DECLARE positionEquipo CURSOR FOR 
	
	Select 		
	ue.idEquipo,
	ROW_NUMBER() OVER(ORDER BY e.puntos desc) AS 'posicion'	
	From Usuario_Reto ur 
	inner join Usuario_Equipo ue on ue.idUsuario = ur.idUsuario
	inner join Equipo e on e.idEquipo = ue.idEquipo 
	Where ur.tieneEquipo = 1 and ur.completado > 0
	Group by ue.idEquipo, e.puntos, e.tiempo
	Order by e.puntos desc, e.tiempo asc

	OPEN positionEquipo
	FETCH NEXT FROM positionEquipo INTO @idEquipo, @posicion
	WHILE @@fetch_status = 0
	BEGIN
		
		declare @contue int = 0
		Select @contue = COUNT(*) from Usuario_Equipo where idEquipo = @idEquipo and idUsuario = @idUsuario

		if(@contue > 0)
		begin		
			set @id = @idEquipo
			set @auxPos = @posicion
		end

		FETCH NEXT FROM positionEquipo INTO @idEquipo, @posicion
	END
	CLOSE positionEquipo
	DEALLOCATE positionEquipo

	if((@auxPos <= 10 and @top <= 10) or (@auxPos <= @top))
	begin

		Select top (@top)			
		e.idEquipo,	
		count(ue.idEquipo) as 'totalUsuarios',
		e.nombre,
		e.puntos,
		e.tiempo,
		ROW_NUMBER() OVER(ORDER BY e.puntos desc) AS 'posicion',
		ISNULL(e.imagen, 'N/A') as 'imagen'	,
		e.estado
		From Usuario_Reto ur 
		inner join Usuario_Equipo ue on ue.idUsuario = ur.idUsuario
		inner join Equipo e on e.idEquipo = ue.idEquipo 
		Where ur.tieneEquipo = 1 and ur.completado > 0
		Group by ue.idEquipo, e.idEquipo, e.nombre, e.imagen, e.puntos, e.tiempo, e.estado
		Order by e.puntos desc, e.tiempo asc

	end
	else
	begin

		Insert into @table (idEquipo, totalUsuarios, nombre, puntos, tiempo, posicion, imagen, estado)
		Select top (@top)			
		e.idEquipo,	
		count(ue.idEquipo) as 'totalUsuarios',
		e.nombre,
		e.puntos,
		e.tiempo,
		ROW_NUMBER() OVER(ORDER BY e.puntos desc) AS 'posicion',
		ISNULL(e.imagen, 'N/A') as 'imagen'	,
		e.estado
		From Usuario_Reto ur 
		inner join Usuario_Equipo ue on ue.idUsuario = ur.idUsuario
		inner join Equipo e on e.idEquipo = ue.idEquipo 
		Where ur.tieneEquipo = 1 and ur.completado > 0
		Group by ue.idEquipo, e.idEquipo, e.nombre, e.imagen, e.puntos, e.tiempo, e.estado
		Order by e.puntos desc, e.tiempo asc

		Insert into @table (idEquipo, totalUsuarios, nombre, puntos, tiempo, posicion, imagen, estado)
		Select		
		e.idEquipo,	
		count(ue.idEquipo) as 'totalUsuarios',
		e.nombre,
		e.puntos,
		e.tiempo,
		@auxPos,
		ISNULL(e.imagen, 'N/A') as 'imagen'	,
		e.estado
		From Usuario_Reto ur 
		inner join Usuario_Equipo ue on ue.idUsuario = ur.idUsuario
		inner join Equipo e on e.idEquipo = ue.idEquipo 
		Where ur.tieneEquipo = 1 and ur.completado > 0 and e.idEquipo = @id
		Group by ue.idEquipo, e.idEquipo, e.nombre, e.imagen, e.puntos, e.tiempo, e.estado
		Order by e.puntos desc, e.tiempo asc

		Select * from @table

	end

	print concat('La posición del equipo es: ', @auxPos)	
END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_Usuario_fechaLogin]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_B_Usuario_fechaLogin] 
	
	@idUsuario uniqueidentifier,	

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;

	declare @existeId int = 0
	Select @existeId = COUNT(*) From Usuario 
	where idUsuario = @idUsuario		
	
	if(@existeId > 0)
	begin		

		Select top 5
		u.idUsuario,
		u.nombre,
		u.apellido,
		u.correo,
		u.id,
		u.clave,
		u.paisIso2,
		Case When u.celular is not null then CONCAT('+',u.paisCode,u.celular) else null end as 'celular',	
		ISNULL(u.foto, 'N/A') as 'foto',
		u.estado,
		u.idRol,
		r.nombre as 'rol',
		LOWER(CAST(c.idPais as varchar(40))) as 'idPais',
		(select p.nombre from Pais p where p.idPais = c.idPais) as 'pais',
		LOWER(CAST(u.idCiudad as varchar(40))) as 'idCiudad',
		c.nombre as 'ciudad',		
		LOWER(CAST(u.idArea as varchar(40))) as 'idArea',
		a.nombre as 'area',		
		LOWER(CAST(a.idEmpresa as varchar(40))) as 'idEmpresa',
		(select e.nombre from Empresa e where e.idEmpresa = a.idEmpresa) as 'empresa',
		u.fechaCreacion,
		u.fechaModificacion
		From Usuario u 
		Inner Join Rol r on r.idRol = u.idRol 
		Left Join Area a on a.idArea = u.idArea	
		Left Join Ciudad c on c.idCiudad = u.idCiudad
		Where u.idUsuario <> @idUsuario and u.fechaLogin is not null
		order by u.fechaLogin desc


		select @info = CONCAT('Usuario ', descripcion) from Constants where nombre = 'encontrar'		
		set @error = 0

	end
	else
	begin

		select @info = CONCAT('Usuario ', descripcion) from Constants where nombre = 'no_encontrar'
		set @error = 1
	
	end	

	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_Usuario_MedallaByIdUsuario]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_B_Usuario_MedallaByIdUsuario] 
		
	@idUsuario uniqueidentifier,		
	@top int = 1,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;		
	
	declare @existeId int = 0, @idRol varchar(9)
	Select @existeId = COUNT(*), @idRol = idRol From Usuario where idUsuario = @idUsuario group by idRol	
	
	if(@existeId > 0)
	begin

		if(@idRol = 'jug')
		begin

			Select top (case when @top < 0 then (select COUNT(*) from Usuario_Medalla) else @top end)
			um.idMedalla, 
			m.nombre, 
			ISNULL(m.imagen, 'N/A') as 'imagen',
			c.nombre as 'condicion',
			m.numCondicion as 'numCondicion', 
			um.idUsuario, 
			um.fechaCreacion, 
			um.fechaModificacion  
			From Usuario_Medalla um
			inner join Medalla m on m.idMedalla = um.idMedalla
			inner join Condicion c on c.idCondicion = m.idCondicion
			Where um.idUsuario = @idUsuario
			Order by um.fechaCreacion desc		

		end
		else
		begin

			Select *,
			m.nombre, 
			ISNULL(m.imagen, 'N/A') as 'imagen',
			c.nombre as 'condicion',
			m.numCondicion as 'numCondicion', 
			@idUsuario as 'idUsuario', 
			m.fechaCreacion, 
			m.fechaModificacion 
			From Medalla m
			inner join Condicion c on c.idCondicion = m.idCondicion
			Order by m.fechaCreacion desc		

		end

		
		select @info = CONCAT('Usuario ', descripcion) from Constants where nombre = 'encontrar'		
		set @error = 0

	end
	else
	begin

		select @info = CONCAT('Usuario ', descripcion) from Constants where nombre = 'no_encontrar'
		set @error = 1

	end

	print @info
	

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_Usuario_NivelByIdUsuario]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_B_Usuario_NivelByIdUsuario] 
		
	@idUsuario uniqueidentifier,		
	@top int = 1,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;		
	
	declare @existeId int = 0, @idRol varchar(9)
	Select @existeId = COUNT(*), @idRol = idRol From Usuario where idUsuario = @idUsuario group by idRol	
	
	if(@existeId > 0)
	begin

		if(@idRol = 'jug')
		begin

			Select top (case when @top < 0 then (select COUNT(*) from Usuario_Nivel) else @top end)
			un.idUsuario,
			un.idNivel,
			n.nombre,
			ISNULL(n.imagen, 'N/A') as 'imagen',
			ISNULL(n.descripcion, 'N/A') as 'descripcion',
			n.puntosNecesarios,
			un.fechaCreacion,
			un.fechaModificacion
			From Usuario_Nivel un
			inner join Nivel n on n.idNivel = un.idNivel
			Where idUsuario = @idUsuario -- (@idRol = 'adm' or @idRol = 'sadm') or (@idRol = 'jug' and idUsuario = @idUsuario)
			Order by n.puntosNecesarios desc

		end
		else
		begin

			Select top (case when @top < 0 then (select COUNT(*) from Nivel) else @top end)
			@idUsuario as 'idUsuario',
			n.idNivel,
			n.nombre,
			ISNULL(n.imagen, 'N/A') as 'imagen',
			ISNULL(n.descripcion, 'N/A') as 'descripcion',
			n.puntosNecesarios,
			n.fechaCreacion,
			n.fechaModificacion
			From Nivel n
			Order by n.puntosNecesarios desc

		end
		
		select @info = CONCAT('Usuario ', descripcion) from Constants where nombre = 'encontrar'		
		set @error = 0

	end
	else
	begin

		select @info = CONCAT('Usuario ', descripcion) from Constants where nombre = 'no_encontrar'
		set @error = 1

	end

	print @info
	

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_Usuario_NoticiaByIdNoticia]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_B_Usuario_NoticiaByIdNoticia] 
	
	@idNoticia uniqueidentifier,	

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;				

	Select un.idNoticia,
	un.idUsuario,
	CONCAT(u.nombre,' ',u.apellido) as 'usuario',
	un.likes,
	un.comentario,
	un.fechaCreacion,
	un.fechaModificacion
	From Usuario_Noticia un
	inner join Usuario u on u.idUsuario = un.idUsuario
	Where un.idNoticia = @idNoticia
	Order By un.fechaCreacion Desc

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_Usuario_RecompensaByIdUsuario]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_B_Usuario_RecompensaByIdUsuario]

	@idUsuario uniqueidentifier,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;			

	Select top 5 
	ur.idRecompensa,
	ur.idUsuario,	
	r.nombre,
	ISNULL(r.imagen, 'N/A') as 'imagen',
	ur.fechaCreacion,
	ur.fechaModificacion
	From Usuario_Recompensa ur
	Inner Join Recompensa r on ur.idRecompensa = r.idRecompensa
	Where idUsuario = @idUsuario
	Order by ur.fechaCreacion desc	

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_Usuario_RecompensaTotalUsuarios]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_B_Usuario_RecompensaTotalUsuarios]

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;			

	Select top 5
	ur.idRecompensa,
	COUNT(ur.idRecompensa) as 'totalUsuarios',
	r.nombre,
	ISNULL(r.imagen, 'N/A') as 'imagen'
	From Usuario_Recompensa ur
	Inner Join Recompensa r on ur.idRecompensa = r.idRecompensa
	Group by ur.idRecompensa, r.nombre, r.imagen
	Order by COUNT(ur.idRecompensa) desc	

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_Usuario_RedSocialByIdRed]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_B_Usuario_RedSocialByIdRed] 
	
	@idRed uniqueidentifier,	

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;				

	Select rs.idRed,
	rs.idUsuario,
	CONCAT(u.nombre,' ',u.apellido) as 'usuario',
	rs.likes,
	rs.comentario,
	rs.fechaCreacion,
	rs.fechaModificacion
	From Usuario_RedSocial rs
	inner join Usuario u on u.idUsuario = rs.idUsuario
	Where rs.idRed = @idRed
	Order By rs.fechaCreacion Desc

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_Usuario_RetoByIdReto]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_B_Usuario_RetoByIdReto] 	

	@idReto uniqueidentifier,
	@validador int,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;		

	Select 	
	ur.idReto,
	u.idUsuario,
	isnull(u.foto, 'N/A') as 'foto',
	u.nombre,
	u.apellido,
	u.correo,
	u.idRol,
	(select nombre from Rol r where r.idRol = u.idRol) as 'rol',
	ur.completado,
	ur.tieneEquipo,
	ur.validador,
	r.idTipoReto,
	tr.nombre as 'tipoReto',
	u.estado,
	ur.fechaCreacion,
	ur.fechaModificacion
	From  Usuario_Reto ur
	Inner Join Usuario u on ur.idUsuario = u.idUsuario
	Inner join Reto r on r.idReto = ur.idReto
	Inner join TipoReto tr on tr.idTipoReto = r.idTipoReto
	Where ur.idReto = @idReto and ur.tieneEquipo = 0 and ur.validador = @validador
	Order by ur.fechaCreacion desc
		
	-- ur.completado = 0	and	
END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_Usuario_RetoByIdUsuario]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_B_Usuario_RetoByIdUsuario] 
		
	@idUsuario uniqueidentifier,		
	@top int = 1,
	@completado int,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;		
	
	Declare @existeId int = 0

	Select @existeId = COUNT(*) From Usuario where idUsuario = @idUsuario	
	
	if(@existeId > 0)
	begin

		Select top (case when @top < 0 then (select COUNT(*) from Usuario_Reto) else @top end)
		ur.idUsuario,	
		ur.idReto,
		r.nombre,
		r.fechaApetura,
		r.fechaCierre,
		r.estado,
		r.vidas,
		r.tiempo_ms,
		r.puntosRecompensa,
		r.creditosObtenidos,
		r.instrucciones,
		ISNULL(r.imagen, 'N/A') as 'imagen',
		r.idTipoReto,
		tr.nombre as 'tipoReto',
		r.idComportamiento,
		cp.nombre as 'comportamientoPregunta',	
		r.idTipoValidador,
		tv.nombre as 'tipoValidador',
		r.criterioMinimo,
		(select COUNT(*) from Pregunta p where p.idReto = r.idReto) as 'totalPreguntas', 		
		r.enEquipo,
		ur.completado,
		ur.puntos,
		ur.tiempo,
		ur.vidas,
		r.items,		
		ur.fechaCreacion,
		ur.fechaModificacion
		From Usuario_Reto ur
		Inner Join  Reto r on r.idReto = ur.idReto
		Inner Join tipoReto tr on tr.idTipoReto = r.idTipoReto
		Inner Join ComportamientoPregunta cp on cp.idComportamiento = r.idComportamiento
		Inner Join TipoValidador tv on tv.idTipoValidador = r.idTipoValidador
		Where ur.idUsuario = @idUsuario and ur.validador = 0 and (ur.completado = @completado or @completado = -1)
		Order by ur.fechaAsignacion desc		

		
		select @info = CONCAT('Usuario ', descripcion) from Constants where nombre = 'encontrar'		
		set @error = 0

	end
	else
	begin

		select @info = CONCAT('Usuario ', descripcion) from Constants where nombre = 'no_encontrar'
		set @error = 1

	end

	print @info
	

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_Usuario_RetoByIdUsuarioByAll]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_B_Usuario_RetoByIdUsuarioByAll] 
		
	@buscar varchar(max),
	@idUsuario uniqueidentifier,			
	@completado int,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;		
	
	Declare @totalFilas int  = 0, @equipo varchar(10) = 'en equipo', @individual varchar(10) = 'individual' 	

	Select
	ur.idUsuario,	
	ur.idReto,
	r.nombre,
	r.fechaApetura,
	r.fechaCierre,
	r.estado,
	r.vidas,
	r.tiempo_ms,
	r.puntosRecompensa,
	r.creditosObtenidos,
	r.instrucciones,
	ISNULL(r.imagen, 'N/A') as 'imagen',
	r.idTipoReto,
	tr.nombre as 'tipoReto',
	r.idComportamiento,
	cp.nombre as 'comportamientoPregunta',		
	r.idTipoValidador,
	tv.nombre as 'tipoValidador',
	r.criterioMinimo,
	(select COUNT(*) from Pregunta p where p.idReto = r.idReto) as 'totalPreguntas', 
	r.enEquipo,		
	ur.completado,
	ur.puntos,
	ur.tiempo,
	ur.vidas,
	r.items,	
	ur.fechaCreacion,
	ur.fechaModificacion
	From Usuario_Reto ur
	Inner Join  Reto r on r.idReto = ur.idReto
	Inner Join tipoReto tr on tr.idTipoReto = r.idTipoReto
	Inner Join ComportamientoPregunta cp on cp.idComportamiento = r.idComportamiento
	Inner Join TipoValidador tv on tv.idTipoValidador = r.idTipoValidador
	Where ur.idUsuario = @idUsuario and ur.validador = 0 and (ur.completado = @completado or @completado = -1) and 
	(r.nombre like '%'+@buscar+'%' or
	r.enEquipo = case when @equipo like '%'+@buscar+'%' then '1'
					when @individual like '%'+@buscar+'%' then '0' end or
	r.vidas like '%'+@buscar+'%' or
	r.tiempo_ms like '%'+@buscar+'%' or
	r.puntosRecompensa like '%'+@buscar+'%' or
	r.creditosObtenidos like '%'+@buscar+'%' or
	r.items like '%'+@buscar+'%' or	
	r.instrucciones like '%'+@buscar+'%' or
	tr.nombre like '%'+@buscar+'%' or
	tv.nombre like '%'+@buscar+'%' or
	cp.nombre like '%'+@buscar+'%')
	Order by ur.fechaAsignacion desc
		
	select @totalFilas = @@ROWCOUNT	

	if(@totalFilas > 0)
	begin

		select @info = descripcion from Constants where nombre = 'encontrar'
		set @error = 0

	end
	else
	begin

		select @info = descripcion from Constants where nombre = 'cero_filas'
		set @error = 1

	end

	print @info	
	

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_Usuario_RetoByIdUsuarioYIdReto]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_B_Usuario_RetoByIdUsuarioYIdReto] 
		
	@idUsuario uniqueidentifier,		
	@idReto uniqueidentifier,			
	@completado int,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;		
	
	declare @existeId int = 0, @idRol varchar(9)
	Select @idRol = idRol From Usuario where idUsuario = @idUsuario
	Select @existeId = COUNT(*) from Usuario_Reto where idUsuario = @idUsuario and idReto = @idReto
	
	if(@existeId > 0)
	begin

		Select
		ur.idUsuario,	
		ur.idReto,
		r.nombre,
		r.fechaApetura,
		r.fechaCierre,
		r.estado,
		r.vidas as 'retoVidas',
		r.tiempo_ms,
		r.puntosRecompensa,
		r.creditosObtenidos,
		r.instrucciones,
		ISNULL(r.imagen, 'N/A') as 'imagen',
		r.idTipoReto,
		tr.nombre as 'tipoReto',
		r.idTipoEncuesta,
		te.nombre as 'tipoEncuesta',
		r.idComportamiento,
		cp.nombre as 'comportamientoPregunta',		
		r.idTipoArchivo,
		ta.nombre as 'tipoArchivo',
		r.idTipoValidador,
		tv.nombre as 'tipoValidador',
		r.opsRequeridas,
		r.criterioMinimo,
		(select COUNT(*) from Pregunta p where p.idReto = r.idReto) as 'totalPreguntas', 
		r.enEquipo,		
		ur.completado,
		ur.puntos,
		ur.tiempo,
		ur.vidas,
		r.items,		
		ur.correctas,
		ur.incorrectas,
		(select COUNT(*) from UsuarioxOpcion uxo where uxo.idUsuario = ur.idUsuario and uxo.idUserValidador is not null) as 'totalOpsValidaciones',
		ur.fechaCreacion,
		ur.fechaModificacion
		From Usuario_Reto ur
		Inner Join  Reto r on r.idReto = ur.idReto
		Inner Join tipoReto tr on tr.idTipoReto = r.idTipoReto
		Inner Join ComportamientoPregunta cp on cp.idComportamiento = r.idComportamiento
		Inner Join TipoEncuesta te on te.idTipoEncuesta = r.idTipoEncuesta
		Inner Join TipoValidador tv on tv.idTipoValidador = r.idTipoValidador
		Inner Join TipoArchivo ta on ta.idTipoArchivo = r.idTipoArchivo
		Where ur.idUsuario = @idUsuario and ur.idReto = @idReto and (ur.completado = @completado or @completado = -1)
		Order by ur.fechaAsignacion desc
		
		select @info = CONCAT('Usuario ', descripcion) from Constants where nombre = 'encontrar'		
		set @error = 0

	end
	else if (@idRol = 'adm' or @idRol = 'sadm')
	begin		

		Select
		@idUsuario as 'idUsuario',	
		@idReto as 'idReto',
		r.nombre,
		r.fechaApetura,
		r.fechaCierre,
		r.estado,
		r.vidas as 'retoVidas',
		r.tiempo_ms,
		r.puntosRecompensa,
		r.creditosObtenidos,
		r.instrucciones,
		ISNULL(r.imagen, 'N/A') as 'imagen',
		r.idTipoReto,
		tr.nombre as 'tipoReto',
		r.idTipoEncuesta,
		te.nombre as 'tipoEncuesta',
		r.idComportamiento,
		cp.nombre as 'comportamientoPregunta',		
		r.idTipoArchivo,
		ta.nombre as 'tipoArchivo',
		r.idTipoValidador,
		tv.nombre as 'tipoValidador',
		r.opsRequeridas,
		r.criterioMinimo,
		(select COUNT(*) from Pregunta p where p.idReto = r.idReto) as 'totalPreguntas', 
		r.enEquipo,		
		0 as 'completado',
		0 as 'puntos',
		0 as 'tiempo',
		0 as 'vidas',
		r.items,		
		0 as 'correctas',
		0 as 'incorrectas',
		0 as 'totalOpsValidaciones',
		r.fechaCreacion,
		r.fechaModificacion		
		From Reto r
		Inner Join tipoReto tr on tr.idTipoReto = r.idTipoReto
		Inner Join ComportamientoPregunta cp on cp.idComportamiento = r.idComportamiento
		Inner Join TipoEncuesta te on te.idTipoEncuesta = r.idTipoEncuesta
		Inner Join TipoValidador tv on tv.idTipoValidador = r.idTipoValidador
		Inner Join TipoArchivo ta on ta.idTipoArchivo = r.idTipoArchivo
		Where r.idReto = @idReto

		select @info = CONCAT('Usuario ', descripcion) from Constants where nombre = 'encontrar'		
		set @error = 0		
		
	end
	else
	begin

		select @info = 'El usuario no está asignado al reto'
		set @error = 1

	end

	print @info	

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_Usuario_RetoPtosMesesAños]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_B_Usuario_RetoPtosMesesAños] 		

	@idUsuario uniqueidentifier,
	
	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;

	Declare @idRol varchar(9) = ''

	Select @idRol = u.idRol 
	From Usuario_Reto ur
	Inner Join Usuario u on u.idUsuario = ur.idUsuario
	Where ur.idUsuario = @idUsuario


	if(@idRol = 'adm' or @idRol = 'sadm')
	begin

		Select SUM(puntos) as 'puntos', MONTH(fechaModificacion) as 'mes', YEAR(fechaModificacion) as 'año' 
		From Usuario_Reto 
		Where completado > 0 and puntos > 0
		Group by MONTH(fechaModificacion), YEAR(fechaModificacion)
		Order by MONTH(fechaModificacion) asc, YEAR(fechaModificacion) asc			

	end
	else
	begin

		Select SUM(puntos) as 'puntos', MONTH(fechaModificacion) as 'mes', YEAR(fechaModificacion) as 'año' 
		From Usuario_Reto 
		Where completado > 0 and puntos > 0 and idUsuario = @idUsuario
		Group by MONTH(fechaModificacion), YEAR(fechaModificacion)
		Order by MONTH(fechaModificacion) asc, YEAR(fechaModificacion) asc			

	end

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_Usuario_RetoSumaPuntos]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_B_Usuario_RetoSumaPuntos] -- Ranking	

	@idUsuario uniqueidentifier,
	@top int,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;		
	
	Declare @table table (totalRetos int, idUsuario uniqueidentifier, nombre varchar(20), apellido varchar(20), idArea varchar(40), area varchar(65), idCiudad varchar(40), ciudad varchar(65), foto varchar(60), puntos int, tiempo int, posicion int)
	Declare @auxIdUsuario uniqueidentifier, @puntos int, @tiempo int, @posicion int, @auxPos int = 0

	DECLARE PositionUser CURSOR FOR

	Select		
	ur.idUsuario,
	SUM(puntos) as 'puntos',
	SUM(tiempo) as 'tiempo',
	ROW_NUMBER() OVER(ORDER BY SUM(puntos) desc) AS 'posicion'
	From Usuario_Reto ur	
	Where ur.completado > 0 and puntos > 0
	Group by ur.idUsuario
	Order by puntos desc, tiempo asc

	OPEN PositionUser
	FETCH NEXT FROM PositionUser INTO @auxIdUsuario, @puntos, @tiempo, @posicion
	WHILE @@fetch_status = 0
	BEGIN
		
		if(@idUsuario = @auxIdUsuario)
		begin			
			set @auxPos = @posicion
		end

		FETCH NEXT FROM PositionUser INTO @auxIdUsuario, @puntos, @tiempo, @posicion
	END
	CLOSE PositionUser
	DEALLOCATE PositionUser
	

	if((@auxPos <= 10 and @top <= 10) or (@auxPos <= @top))
	begin

		Select top (@top)
		COUNT(ur.idUsuario) as 'totalRetos',	
		ur.idUsuario,
		(Select u.nombre from Usuario u where u.idUsuario = ur.idUsuario) as 'nombre',	
		(Select u.apellido from Usuario u where u.idUsuario = ur.idUsuario) as 'apellido',
		(Select a.idArea from Usuario u Inner Join Area a on a.idArea = u.idArea where u.idUsuario = ur.idUsuario) as 'idArea',
		ISNULL((Select a.nombre from Usuario u Inner Join Area a on a.idArea = u.idArea where u.idUsuario = ur.idUsuario),'N/A') as 'area',
		(Select c.idCiudad from Usuario u Inner Join Ciudad c on c.idCiudad = u.idCiudad where u.idUsuario = ur.idUsuario) as 'idCiudad',
		ISNULL((Select c.nombre from Usuario u Inner Join Ciudad c on c.idCiudad = u.idCiudad where u.idUsuario = ur.idUsuario),'N/A') as 'ciudad',
		(Select ISNULL(u.foto, 'N/A') from Usuario u where u.idUsuario = ur.idUsuario) as 'foto',
		SUM(puntos) as 'puntos',
		SUM(tiempo) as 'tiempo',
		ROW_NUMBER() OVER(ORDER BY SUM(puntos) desc) AS 'posicion'
		From Usuario_Reto ur	
		Where ur.completado > 0 and ur.puntos > 0
		Group by ur.idUsuario
		Order by puntos desc, tiempo asc	

	end	
	else
	begin

		Insert into @table (totalRetos, idUsuario, nombre, apellido, idArea, area, idCiudad, ciudad, foto, puntos, tiempo, posicion)
		Select top (@top)
		COUNT(ur.idUsuario) as 'totalRetos',	
		ur.idUsuario,
		(Select u.nombre from Usuario u where u.idUsuario = ur.idUsuario) as 'nombre',	
		(Select u.apellido from Usuario u where u.idUsuario = ur.idUsuario) as 'apellido',
		(Select a.idArea from Usuario u Inner Join Area a on a.idArea = u.idArea where u.idUsuario = ur.idUsuario) as 'idArea',
		ISNULL((Select a.nombre from Usuario u Inner Join Area a on a.idArea = u.idArea where u.idUsuario = ur.idUsuario),'N/A') as 'area',
		(Select c.idCiudad from Usuario u Inner Join Ciudad c on c.idCiudad = u.idCiudad where u.idUsuario = ur.idUsuario) as 'idCiudad',
		ISNULL((Select c.nombre from Usuario u Inner Join Ciudad c on c.idCiudad = u.idCiudad where u.idUsuario = ur.idUsuario),'N/A') as 'ciudad',
		(Select ISNULL(u.foto, 'N/A') from Usuario u where u.idUsuario = ur.idUsuario) as 'foto',
		SUM(puntos) as 'puntos',
		SUM(tiempo) as 'tiempo',
		ROW_NUMBER() OVER(ORDER BY SUM(puntos) desc) AS 'posicion'
		From Usuario_Reto ur	
		Where ur.completado > 0 and ur.puntos > 0
		Group by ur.idUsuario
		Order by puntos desc, tiempo asc
		
		Insert into @table (totalRetos, idUsuario, nombre, apellido, idArea, area, idCiudad, ciudad, foto, puntos, tiempo, posicion)
		Select
		COUNT(ur.idUsuario) as 'totalRetos',	
		ur.idUsuario,
		(Select u.nombre from Usuario u where u.idUsuario = ur.idUsuario) as 'nombre',	
		(Select u.apellido from Usuario u where u.idUsuario = ur.idUsuario) as 'apellido',
		(Select a.idArea from Usuario u Inner Join Area a on a.idArea = u.idArea where u.idUsuario = ur.idUsuario) as 'idArea',
		ISNULL((Select a.nombre from Usuario u Inner Join Area a on a.idArea = u.idArea where u.idUsuario = ur.idUsuario),'N/A') as 'area',
		(Select c.idCiudad from Usuario u Inner Join Ciudad c on c.idCiudad = u.idCiudad where u.idUsuario = ur.idUsuario) as 'idCiudad',
		ISNULL((Select c.nombre from Usuario u Inner Join Ciudad c on c.idCiudad = u.idCiudad where u.idUsuario = ur.idUsuario),'N/A') as 'ciudad',
		(Select ISNULL(u.foto, 'N/A') from Usuario u where u.idUsuario = ur.idUsuario) as 'foto',
		SUM(puntos) as 'puntos',
		SUM(tiempo) as 'tiempo',
		@auxPos
		From Usuario_Reto ur	
		Where ur.completado > 0 and ur.puntos > 0 and idUsuario = @idUsuario
		Group by ur.idUsuario
		Order by puntos desc, tiempo asc


		Select * from @table

	end	

	print concat('La posición del jugador es: ', @auxPos)	

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_Usuario_RetoValidador]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_B_Usuario_RetoValidador] 		

	@idReto uniqueidentifier,
	@idUsuario uniqueidentifier,
	
	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;


	Declare @contValidador int = 0, @idTipoValidador uniqueidentifier, @tipoValidador varchar(40)

	Select @idTipoValidador = idTipoValidador from Reto where idReto = @idReto
	Select @tipoValidador = nombre from TipoValidador where idTipoValidador = @idTipoValidador

	if(@tipoValidador like 'Usuario%')
	begin
		Select @contValidador = COUNT(*) from Usuario_Reto where idReto = @idReto and idUsuario = @idUsuario and validador = 1
	end
	else if(@tipoValidador like 'Todos%')
	begin
		Select @contValidador = COUNT(*) from Usuario_Reto where idReto = @idReto and idUsuario = @idUsuario and validador = 0
	end


	if (@contValidador > 0)
	begin

		set @info = 'El usuario si es validador para el reto'
		set @error = 0

	end
	else
	begin

		set @info = 'El usuario no es validador'
		set @error = 1

	end

	print @info	

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_Usuario_RetoxValidarByReto]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_B_Usuario_RetoxValidarByReto]
	
	@idReto uniqueidentifier,
	@idUserValidador uniqueidentifier,
	
	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;			

	Select 
	ur.idReto,
	ur.idUsuario,	
	isnull(u.foto, 'N/A') as 'foto',
	u.nombre,
	u.apellido,
	u.correo,
	ur.completado,
	r.enEquipo,
	(select COUNT(*) from UsuarioxArchivo uxa where uxa.idReto = @idReto and uxa.idUsuario = u.idUsuario) as 'itemsRecogidos',
	(select COUNT(*) from UsuarioxOpcion uxo where uxo.idUsuario = ur.idUsuario and uxo.idUserValidador = @idUserValidador) as 'totalOpsValidador',
	(select nombre from TipoArchivo ta where ta.idTipoArchivo = r.idTipoArchivo) as 'tipoArchivo', 
	r.idTipoReto,
	tr.nombre as 'tipoReto',
	ur.fechaCreacion,
	ur.fechaModificacion
	From Usuario_Reto ur
	Inner Join Usuario u on u.idUsuario = ur.idUsuario
	Inner Join Reto r on r.idReto = ur.idReto
	Inner Join TipoReto tr on tr.idTipoReto = r.idTipoReto
	Where ur.validador = 0 and ur.completado > 0 and ur.idReto = @idReto	

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_Usuario_RetoxValidarByValidador]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_B_Usuario_RetoxValidarByValidador]
	
	@idUserValidador uniqueidentifier,
	@top int,
	
	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;			

	Declare @tableIdsRetos table (id uniqueidentifier)
	Declare @tableRetosXverificar table (idUsuario uniqueidentifier, idReto uniqueidentifier, imagen varchar(60), nombre varchar(40), tipoReto varchar(30), estado int, validador int, usuariosXvalidar int, fechaCreacion datetime, fechaModificacion datetime)
	Declare @idTipoValidador uniqueidentifier	
	
	select @idTipoValidador = idTipoValidador from TipoValidador where nombre like 'Todos%'
	
	insert into @tableIdsRetos (id)
	select idReto from Reto where idTipoValidador = @idTipoValidador	
	

	Insert into @tableRetosXverificar (idUsuario, idReto, imagen, nombre, tipoReto, estado, validador, usuariosXvalidar, fechaCreacion, fechaModificacion)
	Select --top (case when @top < 0 then (select COUNT(*) from Usuario_Reto) else @top end)
	ur.idUsuario,	
	ur.idReto,
	ISNULL(r.imagen,'N/A') as 'imagen',
	r.nombre,
	(select nombre from TipoReto tr where tr.idTipoReto = r.idTipoReto) as 'tipoReto', 
	r.estado,
	ur.validador,	
	(select COUNT(*) from Usuario_Reto aur where aur.idReto = ur.idReto and aur.validador = 0 and aur.completado = 2) as 'usuariosXvalidar',
	ur.fechaCreacion,
	ur.fechaModificacion
	From Usuario_Reto ur
	Inner Join  Reto r on r.idReto = ur.idReto
	Where ur.validador = 1 and ur.idUsuario = @idUserValidador	


	Insert into @tableRetosXverificar (idUsuario, idReto, imagen, nombre, tipoReto, estado, validador, usuariosXvalidar, fechaCreacion, fechaModificacion)
	Select 
	ur.idUsuario,	
	ur.idReto,
	ISNULL(r.imagen,'N/A') as 'imagen',
	r.nombre,
	(select nombre from TipoReto tr where tr.idTipoReto = r.idTipoReto) as 'tipoReto', 
	r.estado,
	ur.validador,	
	(select COUNT(*) from Usuario_Reto aur where aur.idReto = ur.idReto and aur.validador = 0 and aur.completado = 2) as 'usuariosXvalidar',
	ur.fechaCreacion,
	ur.fechaModificacion
	From Usuario_Reto ur
	Inner Join  Reto r on r.idReto = ur.idReto	
	Where ur.idUsuario = @idUserValidador and ur.validador = 0 and ur.idReto in (select id from @tableIdsRetos)



	Select top (case when @top < 0 then (select COUNT(*) from @tableRetosXverificar) else @top end)
		*
	From @tableRetosXverificar
		
END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_UsuarioByAll]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_B_UsuarioByAll] 
		
	@buscar varchar(max),
	@incluirAdmins int,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;			

	Declare @totalFilas int  = 0	

	Select
	u.idUsuario,
	u.nombre,
	u.apellido,
	u.correo,
	u.id,
	u.clave,
	u.paisIso2,
	Case When u.celular is not null then CONCAT('+',u.paisCode,u.celular) else 'N/A' end as 'celular',	
	ISNULL(u.foto, 'N/A') as 'foto',
	u.estado,
	u.idRol,
	r.nombre as 'rol',				
	ISNULL(CAST(c.idPais as varchar(40)), 'N/A') as 'idPais',
	ISNULL((select p.nombre from Pais p where p.idPais = c.idPais),'N/A') as 'pais',
	ISNULL(CAST(u.idCiudad as varchar(40)), 'N/A') as 'idCiudad',
	ISNULL(c.nombre, 'N/A') as 'ciudad',		
	ISNULL(CAST(u.idArea as varchar(40)), 'N/A') as 'idArea',
	ISNULL(a.nombre, 'N/A') as 'area',	
	ISNULL(CAST(a.idEmpresa as varchar(40)), 'N/A') as 'idEmpresa',
	ISNULL((select e.nombre from Empresa e where e.idEmpresa = a.idEmpresa), 'N/A') as 'empresa',
	u.fechaCreacion,
	u.fechaModificacion
	From Usuario u 
	Inner Join Rol r on r.idRol = u.idRol 
	Left Join Area a on a.idArea = u.idArea
	Left Join Ciudad c on c.idCiudad = u.idCiudad		
	Where 
	(
		(@incluirAdmins = 1)
		or
		(@incluirAdmins = 0 and r.idRol not in ('adm','sadm'))
	) 
	and	
	(
		u.nombre like '%'+@buscar+'%' or	
		u.apellido like '%'+@buscar+'%' or
		CONCAT(u.nombre,' ',u.apellido) like '%'+@buscar+'%' or
		CONCAT(u.apellido,' ',u.nombre) like '%'+@buscar+'%' or
		u.correo like '%'+@buscar+'%' or
		u.paisIso2 like '%'+@buscar+'%' or
		u.paisCode like '%'+@buscar+'%' or
		u.celular like '%'+@buscar+'%' or
		(select p.nombre from Pais p where p.idPais = c.idPais) like '%'+@buscar+'%' or
		c.nombre like '%'+@buscar+'%' or
		(select e.nombre from Empresa e where e.idEmpresa = a.idEmpresa) like '%'+@buscar+'%' or
		r.nombre like '%'+@buscar+'%'
	)
	Order by u.fechaCreacion desc 

	select @totalFilas = @@ROWCOUNT

	if(@totalFilas > 0)
	begin

		select @info = descripcion from Constants where nombre = 'encontrar'
		set @error = 0

	end
	else
	begin

		select @info = descripcion from Constants where nombre = 'cero_filas'
		set @error = 1

	end

	print @info	
	

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_UsuarioByCorreo]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_B_UsuarioByCorreo] 

	@correo varchar(60),	

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;

	declare @contCorreo int = 0, @estado int = 0		
	Select @contCorreo = COUNT(*), @estado = estado from Usuario where correo = @correo --COLLATE SQL_Latin1_General_CP1_CS_AS	
	group by estado
	

	if(@contCorreo = 0)
	begin

		select @info = CONCAT('Usuario ',descripcion) from Constants where nombre = 'no_encontrar'
		set @error = 1

	end
	else if(@estado = 0)
	begin

		set @info = 'El usuario está desactivado'
		set @error = 2

	end
	else
	begin

		Select u.idUsuario,
		u.nombre,
		u.apellido,
		u.correo,
		u.id,
		u.clave,
		u.paisIso2,
		Case When u.celular is not null then CONCAT('+',u.paisCode,u.celular) else 'N/A' end as 'celular',		
		ISNULL(u.foto, 'N/A') as 'foto',
		u.estado,
		u.idRol,
		r.nombre as 'rol',
		ISNULL(CAST(u.idCiudad as varchar(40)), 'N/A') as 'idCiudad',
		ISNULL(c.nombre, 'N/A') as 'ciudad',		
		ISNULL(CAST(u.idArea as varchar(40)), 'N/A') as 'idArea',
		ISNULL(a.nombre, 'N/A') as 'area',		
		u.puntos,
		u.creditos,
		u.fechaCreacion,
		u.fechaModificacion
		From Usuario u 
		Inner Join Rol r on r.idRol = u.idRol 
		Left Join Area a on a.idArea = u.idArea
		Left Join Ciudad c on c.idCiudad = u.idCiudad
		Where u.estado > 0 and correo = @correo
		
		select @info = CONCAT('Usuario ',descripcion) from Constants where nombre = 'encontrar'
		set @error = 0		


		Update Usuario set 
		fechaLogin = GETDATE() 
		Where correo = @correo

	end	

	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_UsuarioById]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_B_UsuarioById] 
	
	@idUsuario uniqueidentifier,	
	@estado int,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;

	declare @existeId int = 0
	Select @existeId = COUNT(*) From Usuario 
	where idUsuario = @idUsuario			
	
	if(@existeId > 0)
	begin

		Select u.idUsuario,
		u.nombre,
		u.apellido,
		u.correo,
		u.id,
		u.clave,
		u.paisIso2,
		u.paisCode,
		u.celular,			
		ISNULL(u.foto, 'N/A') as 'foto',
		u.estado,
		u.idRol,
		r.nombre as 'rol',
		LOWER(CAST(c.idPais as varchar(40))) as 'idPais',
		(select p.nombre from Pais p where p.idPais = c.idPais) as 'pais',
		LOWER(CAST(u.idCiudad as varchar(40))) as 'idCiudad',
		c.nombre as 'ciudad',		
		LOWER(CAST(u.idArea as varchar(40))) as 'idArea',
		a.nombre as 'area',		
		LOWER(CAST(a.idEmpresa as varchar(40))) as 'idEmpresa',
		(select e.nombre from Empresa e where e.idEmpresa = a.idEmpresa) as 'empresa',
		u.puntos,
		u.creditos,
		u.fechaCreacion,
		u.fechaModificacion
		From Usuario u 
		Inner Join Rol r on r.idRol = u.idRol 
		Left Join Area a on a.idArea = u.idArea	
		Left Join Ciudad c on c.idCiudad = u.idCiudad
		Where (u.estado = @estado or @estado = -1) and u.idUsuario = @idUsuario			

		select @info = CONCAT('Usuario ', descripcion) from Constants where nombre = 'encontrar'		
		set @error = 0

	end
	else
	begin

		select @info = CONCAT('Usuario ', descripcion) from Constants where nombre = 'no_encontrar'
		set @error = 1
	
	end	

	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_UsuarioByRegister]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_B_UsuarioByRegister]

	@idU varchar(20), -- es la cédula o pasaporte, etc, etc
	@correo varchar(60),
	@codRegistro varchar(50),

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;		

	declare @contCorreo int = 0, @contIdU int = 0, @contCodReg int = 0
	Select @contCorreo = COUNT(*) from Usuario where correo = @correo 	
	Select @contIdU = COUNT(*) from Usuario where id = @idU

	Select @contCodReg = COUNT(*) from Configuracion where valor = @codRegistro
	

	if(@correo = '' or @idU = '')
	begin

		set @info = 'campos obligatorios'
		set @error = 1

	end
	else if(@contCorreo > 0)
	begin

		set @info = 'El correo electrónico ya esta registrado'
		set @error = 1

	end	
	else if(@contIdU > 0)
	begin 

		set @info = 'El número de identificación ya esta registrado'
		set @error = 1

	end
	else if(@contCodReg = 0)
	begin 

		set @info = 'El código de registro no existe'
		set @error = 3

	end		
	else
	begin

		set @info = 'Puede registrarse'
		set @error = 0

	end

	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_UsuarioPuntosCreditos]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_B_UsuarioPuntosCreditos] 
			
	@idUsuario uniqueidentifier,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;			

	Select @info = CONCAT('Los puntos y creditos del usuario son: ',puntos,' y ',creditos) -- pts, crts
	From Usuario
	Where idUsuario = @idUsuario

	if(@@ROWCOUNT = 0)
	begin		
		
		select @info = CONCAT('usuario ',descripcion) from Constants where nombre = 'no_encontrar'
		set @error = 1
	end
	else
	begin

		set @error = 0

	end

	print @info
	
END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_UsuarioxArchivoByIdRetoYIdUser]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_B_UsuarioxArchivoByIdRetoYIdUser]
	
	@idUsuario uniqueidentifier,
	@idReto uniqueidentifier,
	
	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;	
	
	Select 
		idReto,
		idUsuario,
		archivo,
		ISNULL(url, 'N/A') as 'url',
		fechaCreacion,
		fechaModificacion
	From UsuarioxArchivo 
	Where idReto = @idReto and idUsuario = @idUsuario

END
GO
/****** Object:  StoredProcedure [dbo].[sp_C_Area]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_C_Area] 
		
	@nombre varchar(65),
	@descripcion varchar(250),
	@idEmpresa uniqueidentifier,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;			

	Declare @contNombre int = 0
	Select @contNombre = COUNT(*) From Area Where nombre = @nombre and  idEmpresa = @idEmpresa
	
	if(@contNombre > 0)
	begin

		set @info = 'El nombre ya esta registrado'
		set @error = 1

	end
	else
	begin		
		
		BEGIN TRY  

			Insert into Area (nombre, descripcion, idEmpresa) values
			(NULLIF(@nombre, ''),
			NULLIF(@descripcion, ''),
			@idEmpresa
			)									

			Select @info = descripcion From Constants Where nombre = 'exito_insert'
			set @error = 0

		END TRY
		BEGIN CATCH	

			set @info = ERROR_MESSAGE()
			set @error = 1

		END CATCH;	

	end	

	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_C_CategoriaNoticia]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_C_CategoriaNoticia] 

	@nombre varchar(50),
	@descripcion varchar(250),	

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;	

	Declare @contNombre int = 0
	Select @contNombre = COUNT(*) From CategoriaNoticia Where nombre = @nombre	
	
	if(@contNombre > 0)
	begin

		set @info = 'El nombre ya esta registrado'
		set @error = 1

	end		
	else
	begin
		
		BEGIN TRY  
			
			Insert into CategoriaNoticia (nombre, descripcion) values
			(NULLIF(@nombre, ''),
			NULLIF(@descripcion, '')			
			)				

			Select @info = descripcion From Constants Where nombre = 'exito_insert'
			set @error = 0

		END TRY
		BEGIN CATCH	

			set @info = ERROR_MESSAGE()
			set @error = 1

		END CATCH;			

	end	

	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_C_CategoriaRecompensa]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_C_CategoriaRecompensa] 

	@nombre varchar(50),
	@descripcion varchar(250),	

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;	

	Declare @contNombre int = 0
	Select @contNombre = COUNT(*) From CategoriaRecompensa Where nombre = @nombre	
	
	if(@contNombre > 0)
	begin

		set @info = 'El nombre ya esta registrado'
		set @error = 1

	end		
	else
	begin
		
		BEGIN TRY  
			
			Insert into CategoriaRecompensa(nombre, descripcion) values
			(NULLIF(@nombre, ''),
			NULLIF(@descripcion, '')			
			)				

			Select @info = descripcion From Constants Where nombre = 'exito_insert'
			set @error = 0

		END TRY
		BEGIN CATCH	

			set @info = ERROR_MESSAGE()
			set @error = 1

		END CATCH;			

	end	

	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_C_Ciudad]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_C_Ciudad] 
		
	@nombre varchar(65),
	@descripcion varchar(250),
	@idPais uniqueidentifier,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;			

	Declare @contNombre int = 0
	Select @contNombre = COUNT(*) From Ciudad Where nombre = @nombre
	
	if(@contNombre > 0)
	begin

		set @info = 'El nombre ya esta registrado'
		set @error = 1

	end
	else
	begin		
		
		BEGIN TRY  

			Insert into Ciudad (nombre, descripcion, idPais) values
			(NULLIF(@nombre, ''),
			NULLIF(@descripcion, ''),
			@idPais
			)									

			Select @info = descripcion From Constants Where nombre = 'exito_insert'
			set @error = 0

		END TRY
		BEGIN CATCH	

			set @info = ERROR_MESSAGE()
			set @error = 1

		END CATCH;	

	end	

	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_C_Configuracion]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_C_Configuracion] 

	@tipo varchar(10),
	@propiedad varchar(40),
	@nombre varchar(30),
	@valor varchar(50),	
	@descripcion varchar(250),	
	@idUsuario uniqueidentifier = null,	

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;		

	declare @contNombre int = 0
	Select @contNombre = COUNT(*) From Configuracion where nombre = @nombre
	
	
	if(@contNombre > 0)
	begin

		set @info = 'El nombre ya esta registrado'
		set @error = 1

	end		
	else
	begin
		
		BEGIN TRY  

			Insert into Configuracion (tipo, propiedad, nombre, valor, descripcion, idUsuario) values
			(NULLIF(@tipo, ''),
			NULLIF(@propiedad, ''),
			NULLIF(@nombre, ''),
			NULLIF(@valor, ''),
			NULLIF(@descripcion, ''),			
			NULLIF(@idUsuario, '')
			)				

			Select @info = descripcion from Constants where nombre = 'exito_insert'
			set @error = 0

		END TRY
		BEGIN CATCH	

			set @info = ERROR_MESSAGE()
			set @error = 1

		END CATCH;			

	end	

	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_C_Empresa]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_C_Empresa] 
		
	@nombre varchar(100),
	@descripcion varchar(250),

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;			

	Declare @contNombre int = 0
	Select @contNombre = COUNT(*) From Empresa Where nombre = @nombre
	
	if(@contNombre > 0)
	begin

		set @info = 'El nombre ya esta registrado'
		set @error = 1

	end
	else
	begin		
		
		BEGIN TRY  

			Insert into Empresa (nombre, descripcion) values
			(NULLIF(@nombre, ''),
			NULLIF(@descripcion, '')
			)									

			Select @info = descripcion From Constants Where nombre = 'exito_insert'
			set @error = 0

		END TRY
		BEGIN CATCH	

			set @info = ERROR_MESSAGE()
			set @error = 1

		END CATCH;	

	end	

	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_C_Equipo]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_C_Equipo] 
		
	@nombre varchar(30),
	@imagen varchar(50),
	@descripcion varchar(250),			

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;		

	Declare @contNombre int = 0
	Select @contNombre = COUNT(*) From Equipo Where nombre = @nombre		
	
	
	if(@contNombre > 0)
	begin

		set @info = 'El nombre ya esta registrado'
		set @error = 1

	end		
	else
	begin		
		
		BEGIN TRY  

			Insert into Equipo(nombre, imagen, descripcion, estado) values
			(NULLIF(@nombre, ''),			
			NULLIF(@imagen, ''),
			NULLIF(@descripcion, ''),	
			0
			)									

			Select @info = descripcion From Constants Where nombre = 'exito_insert'
			set @error = 0

		END TRY
		BEGIN CATCH

			set @info = ERROR_MESSAGE()
			set @error = 1

		END CATCH;	

	end	

	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_C_Equipo_Reto]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_C_Equipo_Reto] 	

	@idEquipo uniqueidentifier,
	@idReto uniqueidentifier,	

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN 

	SET NOCOUNT ON;		
	
	Declare @existeIdReto int = 0, @existeIdEquipo int = 0, @nomEquipo varchar(60) = 'N/A', @info_C_Equipo_Reto varchar(max), @error_C_Equipo_Reto int, @id_C_Equipo_Reto varchar(max)
	Select @existeIdReto = COUNT(*) From Reto where idReto = @idReto		
	Select @existeIdEquipo = COUNT(*), @nomEquipo = nombre From Equipo where idEquipo = @idEquipo group by nombre


	if(@existeIdReto = 0 or @existeIdEquipo = 0)
	begin

		set @info = 'No existe el equipo o el reto'
		set @error = 0

		print @info

	end
	else
	begin

		Declare @idUsuario uniqueidentifier, @correo varchar(99)

		DECLARE insertUserReto CURSOR FOR 

		Select idUsuario From Usuario_Equipo where idEquipo = @idEquipo

		OPEN insertUserReto
		FETCH NEXT FROM insertUserReto INTO @idUsuario
		WHILE @@fetch_status = 0
		BEGIN

			select @correo = correo from Usuario where idUsuario = @idUsuario
			
			exec sp_C_Usuario_Reto
			@correo =  @correo,
			@idReto = @idReto,
			@puntos = 0,
			@tiempo = 0,
			@vidas = 0,
			@tieneEquipo = 1,
			@validador = 0,
			@error = @error_C_Equipo_Reto output,
			@info = @info_C_Equipo_Reto output,
			@id = @id_C_Equipo_Reto output
			

			FETCH NEXT FROM insertUserReto INTO @idUsuario
		END
		CLOSE insertUserReto
		DEALLOCATE insertUserReto			

		set @error = @error_C_Equipo_Reto
		set @info = @info_C_Equipo_Reto
		set @id = @nomEquipo

	end		
	

END
GO
/****** Object:  StoredProcedure [dbo].[sp_C_Licencia]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_C_Licencia] 

	@tabla varchar(60),	
	@nombre varchar(60),		
	@cantMax int,	

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;		


	declare @contNombre int = 0, @contTabla int = 0
	Select @contTabla = COUNT(*) From Licencia where tabla = @tabla
	Select @contNombre = COUNT(*) From Licencia where nombre = @nombre			

	if(@contTabla > 0)
	begin

		set @info = 'La tabla ya esta registrada'
		set @error = 1

	end	
	else if(@contNombre > 0)
	begin

		set @info = 'El nombre ya esta registrado'
		set @error = 1

	end
	else if(@cantMax = 0 or @cantMax < -1)
	begin

		set @info = 'La cantidad máxima no puede ser menor a 1'
		set @error = 1

	end
	else
	begin		
		
		BEGIN TRY  

			Insert into Licencia (tabla, nombre, cantidadMaxima) values
			(NULLIF(@tabla, ''),			
			NULLIF(@nombre, ''),
			NULLIF(@cantMax, '')
			)

			Select @info = descripcion from Constants where nombre = 'exito_insert'
			set @error = 0

		END TRY
		BEGIN CATCH	

			set @info = ERROR_MESSAGE()
			set @error = 1

		END CATCH;			

	end	

	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_C_Medalla]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_C_Medalla] 

	@nombre varchar(30),
	@descripcion varchar(250),
	@imagen varchar(50),
	@idCondicion uniqueidentifier,	
	@numCondicion int = 1,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;	

	Declare @contNombre int = 0, @contIdCondicion int = 0
	Select @contNombre = COUNT(*) From Medalla Where nombre = @nombre
	Select @contIdCondicion = COUNT(*) From Medalla Where idCondicion = @idCondicion
	
	if(@contNombre > 0)
	begin

		set @info = 'El nombre ya esta registrado'
		set @error = 1

	end	
	else if(@contIdCondicion > 0)
	begin
		
		set @info = 'La condición ya esta registrada'
		set @error = 1

	end
	else if(@numCondicion < 1)
	begin
		
		set @info = 'El número de condición no puede ser menor a uno'
		set @error = 1

	end
	else if(@numCondicion > 1000)
	begin
		
		set @info = 'El número de condición no puede ser mayor a mil'
		set @error = 1

	end
	else
	begin
		
		BEGIN TRY  
			
			Insert into Medalla (nombre, descripcion, imagen, idCondicion, numCondicion) values
			(NULLIF(@nombre, ''),
			NULLIF(@descripcion, ''),
			NULLIF(@imagen, ''),
			@idCondicion,
			case @numCondicion when '' then 1 else @numCondicion end
			)				

			Select @info = descripcion From Constants Where nombre = 'exito_insert'
			set @error = 0

		END TRY
		BEGIN CATCH	

			set @info = ERROR_MESSAGE()
			set @error = 1

		END CATCH;			

	end	

	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_C_Nivel]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_C_Nivel] 

	@nombre varchar(20),	
	@descripcion varchar(250),
	@puntosNecesarios int,
	@imagen varchar(50),	

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;		

	declare @contNombre int = 0, @contPuntos int = 0, @auxPuntos int = 0
	Select @contNombre = COUNT(*) From Nivel where nombre = @nombre
	Select @contPuntos = COUNT(*) From Nivel where puntosNecesarios = @puntosNecesarios
	
	
	if(@contNombre > 0)
	begin

		set @info = 'El nombre ya esta registrado'
		set @error = 1

	end	
	else if(@contPuntos > 0)
	begin

		set @info = 'Los puntos necesarios ya estan registrados'
		set @error = 1

	end
	else
	begin

		if(@puntosNecesarios < 1 or @puntosNecesarios = '') 
		begin

			Select top 1 @auxPuntos = puntosNecesarios from Nivel order by puntosNecesarios desc
			set @puntosNecesarios = @auxPuntos + 1
			set @error = 0

		end		
		
		BEGIN TRY  

			Insert into Nivel (nombre, descripcion, puntosNecesarios, imagen) values
			(NULLIF(@nombre, ''),			
			NULLIF(@descripcion, ''),
			NULLIF(@puntosNecesarios, 0),
			NULLIF(@imagen, '')
			)				

			Select @info = descripcion from Constants where nombre = 'exito_insert'
			set @error = 0

		END TRY
		BEGIN CATCH	

			set @info = ERROR_MESSAGE()
			set @error = 1

		END CATCH;			

	end	

	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_C_Noticia]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_C_Noticia] 

	@titular varchar(100),
	@descripcion varchar(500),
	@url varchar(250),
	@imagen varchar(50),	
	@fechaPublicacion datetime,
	@idCategoria uniqueidentifier,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;		
	
	BEGIN TRY  

		Insert into Noticia (titular, descripcion, url, imagen, idCategoria, fechaPublicacion) values
		(NULLIF(@titular, ''),
		NULLIF(@descripcion, ''),
		NULLIF(@url, ''),
		NULLIF(@imagen, ''),
		@idCategoria,
		NULLIF(@fechaPublicacion, '')
		)				

		Select @info = descripcion from Constants where nombre = 'exito_insert'
		set @error = 0

	END TRY
	BEGIN CATCH	

		set @info = ERROR_MESSAGE()
		set @error = 1

	END CATCH;

	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_C_Opcion]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_C_Opcion] 
		
	@nombre varchar(150),
	@correcta int, 	
	@valor int,
	@idPregunta uniqueidentifier,
	@idTipoEntrada uniqueidentifier,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;

	Declare @tableId TABLE (id uniqueidentifier);
	Declare @contNombre int = 0, @contOpcion int = 0, @idOpcion uniqueidentifier, @idReto uniqueidentifier, @tipoReto varchar(50), @tipoEncuesta varchar(50), @auxIdTipoEntrada uniqueidentifier, @maxOptions int = 0  

	Select @contNombre = COUNT(*), @idOpcion = idOpcion From Opcion Where idPregunta = @idPregunta and nombre = @nombre Group By idOpcion
	Select @contOpcion = COUNT(*) From Opcion Where idPregunta = @idPregunta
	Select @idReto = idReto From Pregunta Where idPregunta = @idPregunta	

	Select @tipoReto = tr.nombre, @tipoEncuesta = te.nombre
	From Reto r 
	Inner Join TipoReto tr on tr.idTipoReto = r.idTipoReto	
	Inner Join TipoEncuesta te on te.idTipoEncuesta = r.idTipoEncuesta
	where r.idReto = @idReto	

	Select @auxIdTipoEntrada = idTipoEntrada from TipoEntrada where nombre = 'otro'	
	

	if (@tipoReto = 'Trivia')
	begin

		set @maxOptions = 4
		set @idTipoEntrada = @auxIdTipoEntrada

	end
	else if(@tipoReto = 'Encuesta')
	begin

		if(@tipoEncuesta = 'Voto')
		begin
			set @maxOptions = 10
		end
		else if(@tipoEncuesta = 'Satisfacción')
		begin
			set @maxOptions = 5
		end

		set @idTipoEntrada = @auxIdTipoEntrada

	end	
	else if(@tipoReto = 'Seguimiento o Evaluación')
	begin

		set @maxOptions = 5

	end
	else if(@tipoReto = 'Comportamiento')
	begin

		set @maxOptions = 5
		set @idTipoEntrada = @auxIdTipoEntrada

	end
	


	BEGIN TRY  
		if(@contNombre > 0)
		begin

			Update Opcion set 
			nombre = @nombre,
			fechaModificacion = GETDATE()
			Where idOpcion = @idOpcion and idPregunta = @idPregunta

			Select @info = descripcion From Constants Where nombre = 'exito_update'
			set @error = 0
			set @id = @idOpcion

		end
		else
		begin		
		
			if(@contOpcion < @maxOptions + 1)
			begin
																
				Insert Into Opcion (nombre, correcta, valor, idPregunta, idTipoEntrada) output inserted.idOpcion into @tableId values
				(NULLIF(@nombre, ''),
				case @correcta when '' then 0 else @correcta end,
				case @valor when '' then 0 else @valor end,
				@idPregunta,
				@idTipoEntrada
				)					

				Select @info = descripcion From Constants Where nombre = 'exito_insert'
				set @error = 0
				select @id = id from @tableId				

			end
			else
			begin

				set @info = CONCAT('Solo se acepta máximo ', @maxOptions, ' opciones')
				set @error = 1
				set @id = 0

			end		

		end	

	END TRY
	BEGIN CATCH	

		set @info = ERROR_MESSAGE()
		set @error = 1
		set @id = 0

	END CATCH;	

	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_C_Pais]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_C_Pais] 
		
	@nombre varchar(65),
	@descripcion varchar(250),

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;			

	Declare @contNombre int = 0
	Select @contNombre = COUNT(*) From Pais Where nombre = @nombre
	
	if(@contNombre > 0)
	begin

		set @info = 'El nombre ya esta registrado'
		set @error = 1

	end
	else
	begin		
		
		BEGIN TRY  

			Insert into Pais (nombre, descripcion) values
			(NULLIF(@nombre, ''),
			NULLIF(@descripcion, '')
			)									

			Select @info = descripcion From Constants Where nombre = 'exito_insert'
			set @error = 0

		END TRY
		BEGIN CATCH	

			set @info = ERROR_MESSAGE()
			set @error = 1

		END CATCH;	

	end	

	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_C_Pregunta]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_C_Pregunta] 
		
	@nombre varchar(150),
	@idReto uniqueidentifier,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;			

	Declare @tableId TABLE (id uniqueidentifier);
	Declare @contNombre int = 0, @idPregunta uniqueidentifier, @contIdReto int = 0

	Select @contIdReto = COUNT(*) from Reto where idReto = @idReto
	Select @contNombre = COUNT(*), @idPregunta = idPregunta from Pregunta where idReto = @idReto and nombre = @nombre group by idPregunta

	if(@contIdReto = 0)
	begin

		set @info = 'El reto no existe'
		set @error = 1
		set @id = 0	

	end
	else
	begin

		BEGIN TRY 
			if(@contNombre > 0)
			begin

				Update Pregunta set 
				nombre = @nombre,
				fechaModificacion = GETDATE()
				Where idPregunta = @idPregunta and idReto = @idReto

				Select @info = descripcion From Constants Where nombre = 'exito_update'
				set @error = 0
				set @id = @idPregunta		

			end
			else
			begin				 

				Insert into Pregunta (nombre, idReto) output inserted.idPregunta into @tableId values
				(NULLIF(@nombre, ''),
				@idReto
				)						

				Select @info = descripcion From Constants Where nombre = 'exito_insert'
				set @error = 0
				select @id = id from @tableId

			end	
		END TRY
		BEGIN CATCH	

			set @info = ERROR_MESSAGE()
			set @error = 1
			set @id = 0	

		END CATCH;

	end
	

	print @info
	print @id
END
GO
/****** Object:  StoredProcedure [dbo].[sp_C_Recompensa]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_C_Recompensa] 

	@nombre varchar(60),
	@idCategoria uniqueidentifier,
	@descripcion varchar(250),
	@imagen varchar(50),
	@cantDisp int,	
	@cantCanje int,	

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;		


	Declare @contNombre int = 0, @cantMax int = 0, @cantRecompensa int = 0
	Select @contNombre = COUNT(*) From Recompensa where nombre = @nombre
	Select @cantRecompensa = COUNT(*) From Recompensa
	
	Select @cantMax = cantidadMaxima from Licencia where tabla = 'Recompensa'	
	
	if(@cantMax > 0 and @cantRecompensa >= @cantMax)
	begin
		
		select @info = descripcion from Constants where nombre = 'sin_licencias'
		set @error = 2

	end
	else if(@contNombre > 0)
	begin

		set @info = 'El nombre ya esta registrado'
		set @error = 1

	end	
	else if (@cantCanje < 1)
	begin
		
		set @info = 'La cantidad de canje no debe ser menor a 1'
		set @error = 1

	end
	else
	begin
		
		BEGIN TRY  
			
			Insert into Recompensa (nombre, idCategoria, descripcion, imagen, cantDisponible, cantCanje) values
			(NULLIF(@nombre, ''),
			@idCategoria,
			NULLIF(@descripcion, ''),
			NULLIF(@imagen, ''),
			@cantDisp,
			@cantCanje
			)				

			Select @info = descripcion From Constants Where nombre = 'exito_insert'
			set @error = 0

		END TRY
		BEGIN CATCH	

			set @info = ERROR_MESSAGE()
			set @error = 1

		END CATCH;			

	end	

	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_C_RedSocial]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_C_RedSocial] 
	
	@descripcion varchar(250),
	@imagen varchar(50),	
	@fechaPublicacion datetime,	

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;
	
	BEGIN TRY  

		Insert into RedSocial (descripcion, imagen, fechaPublicacion) values
		(NULLIF(@descripcion, ''),
		NULLIF(@imagen, ''),
		@fechaPublicacion
		)				

		set @info = 'Publicación guandada satisfactoriamente en la red social'
		set @error = 0

	END TRY
	BEGIN CATCH	

		set @info = ERROR_MESSAGE()
		set @error = 1

	END CATCH;

	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_C_Reto]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_C_Reto] 
		
	@nombre varchar(40),
	@fechaApertura datetime,
	@fechaCierre datetime,
	@vidas int,
	@tiempo int,
	@puntosRecompensa int,
	@creditosObtenidos int,
	@criterioMin int,
	@instrucciones varchar(300),
	@imagen varchar(50),
	@idTipoReto uniqueidentifier,
	@idTipoEncuesta uniqueidentifier,
	@idComportamiento uniqueidentifier,	
	@idTipoArchivo uniqueidentifier,		
	@idTipoValidador uniqueidentifier,		
	@items int,	
	@opsRequeridas int,
	@enEquipo int,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;		
		
	Declare @tableId TABLE (id uniqueidentifier);
	Declare @contNombre int = 0, @cantMax int = 0, @cantReto int = 0, @tipoReto varchar(30) = '', @auxIdTipoEncuesta uniqueidentifier, @auxIdComportamiento uniqueidentifier, @auxIdTipoValidador uniqueidentifier, @auxIdTipoArchivo uniqueidentifier

	Select @contNombre = COUNT(*) From Reto Where nombre = @nombre
	Select @tipoReto = nombre From tipoReto where idTipoReto = @idTipoReto
	Select @cantReto = COUNT(*) from Reto
	Select @auxIdTipoEncuesta = idTipoEncuesta from TipoEncuesta where nombre = 'otro'
	Select @auxIdComportamiento = idComportamiento from ComportamientoPregunta where nombre = 'Normal'
	Select @auxIdTipoValidador = idTipoValidador from tipoValidador where nombre = 'Automático'
	Select @auxIdTipoArchivo = idTipoArchivo from TipoArchivo where nombre = 'Ninguno'

	Select @cantMax = cantidadMaxima from Licencia where tabla = 'Reto'	
	

	if(@cantMax > 0 and @cantReto >= @cantMax)
	begin

		select @info = descripcion from Constants where nombre = 'sin_licencias'
		set @error = 2

	end	
	else if(@contNombre > 0)
	begin

		set @info = 'El nombre ya esta registrado'
		set @error = 1

	end	
	else if(@vidas < 0 or @puntosRecompensa < 1 or @creditosObtenidos < 0 or @criterioMin < 1 or @tiempo < 300000 or @items < 0)
	begin

		set @info = 'Incorrecto vidas, puntos de recompensa, créditos obtenidos, criterio mínimo, tiempo o items'
		set @error = 1

	end
	else if(@vidas > 10 or @puntosRecompensa > 1000 or @creditosObtenidos > 1000 or @criterioMin > 100 or @tiempo > 7200000)
	begin

		set @info = 'Incorrecto vidas, puntos de recompensa, créditos obtenidos, criterio mínimo o tiempo'
		set @error = 1

	end 	
	else if(@tipoReto = 'Trivia')  -- ******* SI ES TRIVIA ********************************************
	begin					
		
		BEGIN TRY  

			Insert into Reto (nombre, fechaApetura, fechaCierre, vidas, tiempo_ms, puntosRecompensa, creditosObtenidos, criterioMinimo, enEquipo, instrucciones, imagen, idTipoReto, idTipoEncuesta, idComportamiento, idTipoArchivo, idTipoValidador, items, estado) values
			(NULLIF(@nombre, ''),
			case @fechaApertura when '' then '1800-01-01' else @fechaApertura end,
			case @fechaCierre when '' then '1800-01-01' else @fechaCierre end,			
			case @vidas when '' then 0 else @vidas end,
			case @tiempo when '' then 300000 else @tiempo end,
			case @puntosRecompensa when '' then 1 else @puntosRecompensa end,
			case @creditosObtenidos when '' then 0 else @creditosObtenidos end,
			case when @criterioMin = '' then 100 when @criterioMin < 1 then 100 else @criterioMin end,
			case @enEquipo when '' then 0 else @enEquipo end,
			NULLIF(@instrucciones, ''),
			NULLIF(@imagen, ''),
			@idTipoReto,
			@auxIdTipoEncuesta,
			@idComportamiento,
			@auxIdTipoArchivo,
			@auxIdTipoValidador,
			-1,			
			0
			)									

			Select @info = descripcion From Constants Where nombre = 'exito_insert'
			set @error = 0
			set @id = 0			

		END TRY
		BEGIN CATCH	

			set @info = ERROR_MESSAGE()
			set @error = 1

		END CATCH;			

	end
	else if(@tipoReto = 'Encuesta') -- ******* SI ES ENCUESTA ********************************************
	begin
		
		BEGIN TRY  

			Insert into Reto (nombre, fechaApetura, fechaCierre, vidas, tiempo_ms, puntosRecompensa, creditosObtenidos, criterioMinimo, opsRequeridas, enEquipo, instrucciones, imagen, idTipoReto, idTipoEncuesta, idComportamiento, idTipoArchivo, idTipoValidador, items, estado) values
			(NULLIF(@nombre, ''),
			case @fechaApertura when '' then '1800-01-01' else @fechaApertura end,
			case @fechaCierre when '' then '1800-01-01' else @fechaCierre end,			
			0,
			0,
			case @puntosRecompensa when '' then 1 else @puntosRecompensa end,
			case @creditosObtenidos when '' then 0 else @creditosObtenidos end,
			0,
			case @opsRequeridas when '' then 0 else @opsRequeridas end,
			case @enEquipo when '' then 0 else @enEquipo end,
			NULLIF(@instrucciones, ''),
			NULLIF(@imagen, ''),
			@idTipoReto,
			@idTipoEncuesta,
			@auxIdComportamiento,
			@auxIdTipoArchivo,
			@auxIdTipoValidador,
			-1,			
			0
			)									

			Select @info = descripcion From Constants Where nombre = 'exito_insert'
			set @error = 0
			set @id = 0

		END TRY
		BEGIN CATCH	

			set @info = ERROR_MESSAGE()
			set @error = 1
			set @id = 0

		END CATCH;	


	end
	else if(@tipoReto = 'Seguimiento o Evaluación') -- ******* SI ES SEGUIMIENTO O EVALUACIÓN ********************************************
	begin
		
		BEGIN TRY  

			Insert into Reto (nombre, fechaApetura, fechaCierre, vidas, tiempo_ms, puntosRecompensa, creditosObtenidos, criterioMinimo, opsRequeridas, enEquipo, instrucciones, imagen, idTipoReto, idTipoEncuesta, idComportamiento, idTipoArchivo, idTipoValidador, items, estado) values
			(NULLIF(@nombre, ''),
			case @fechaApertura when '' then '1800-01-01' else @fechaApertura end,
			case @fechaCierre when '' then '1800-01-01' else @fechaCierre end,			
			0,
			0,
			case @puntosRecompensa when '' then 1 else @puntosRecompensa end,
			case @creditosObtenidos when '' then 0 else @creditosObtenidos end,
			0,
			case @opsRequeridas when '' then 0 else @opsRequeridas end,
			case @enEquipo when '' then 0 else @enEquipo end,
			NULLIF(@instrucciones, ''),
			NULLIF(@imagen, ''),
			@idTipoReto,
			@auxIdTipoEncuesta,
			@auxIdComportamiento,
			@auxIdTipoArchivo,
			@auxIdTipoValidador,
			-1,			
			0
			)									

			Select @info = descripcion From Constants Where nombre = 'exito_insert'
			set @error = 0
			set @id = 0

		END TRY
		BEGIN CATCH	

			set @info = ERROR_MESSAGE()
			set @error = 1
			set @id = 0

		END CATCH;	
		
	end 
	else if(@tipoReto = 'Recolección') -- ******* SI ES RECOLECCIÓN ********************************************
	begin		
		
		BEGIN TRY  

			Insert into Reto (nombre, fechaApetura, fechaCierre, vidas, tiempo_ms, puntosRecompensa, creditosObtenidos, criterioMinimo, opsRequeridas, enEquipo, instrucciones, imagen, idTipoReto, idTipoEncuesta, idComportamiento, idTipoArchivo, idTipoValidador, items, estado) output inserted.idReto into @tableId values
			(NULLIF(@nombre, ''),
			case @fechaApertura when '' then '1800-01-01' else @fechaApertura end,
			case @fechaCierre when '' then '1800-01-01' else @fechaCierre end,			
			0,
			0,
			case @puntosRecompensa when '' then 1 else @puntosRecompensa end,
			case @creditosObtenidos when '' then 0 else @creditosObtenidos end,
			0,
			case @opsRequeridas when '' then 0 else @opsRequeridas end,
			case @enEquipo when '' then 0 else @enEquipo end,
			NULLIF(@instrucciones, ''),
			NULLIF(@imagen, ''),
			@idTipoReto,
			@auxIdTipoEncuesta,
			@auxIdComportamiento,
			@idTipoArchivo,
			@idTipoValidador,
			case @items when '' then 1 else @items end,			
			0
			)									

			Select @info = descripcion From Constants Where nombre = 'exito_insert'
			set @error = 0		
			Select @id = id from @tableId

		END TRY
		BEGIN CATCH	

			set @info = ERROR_MESSAGE()
			set @error = 1
			set @id = 0

		END CATCH;	
		
	end	
	else if(@tipoReto = 'Comportamiento') -- ******* SI ES COMPORTAMIENTO ********************************************
	begin
		
		BEGIN TRY  

			Insert into Reto (nombre, fechaApetura, fechaCierre, vidas, tiempo_ms, puntosRecompensa, creditosObtenidos, criterioMinimo, opsRequeridas, enEquipo, instrucciones, imagen, idTipoReto, idTipoEncuesta, idComportamiento, idTipoArchivo, idTipoValidador, items, estado) output inserted.idReto into @tableId values
			(NULLIF(@nombre, ''),
			case @fechaApertura when '' then '1800-01-01' else @fechaApertura end,
			case @fechaCierre when '' then '1800-01-01' else @fechaCierre end,			
			0,
			0,
			case @puntosRecompensa when '' then 1 else @puntosRecompensa end,
			case @creditosObtenidos when '' then 0 else @creditosObtenidos end,
			0,
			case @opsRequeridas when '' then 0 else @opsRequeridas end,
			case @enEquipo when '' then 0 else @enEquipo end,
			NULLIF(@instrucciones, ''),
			NULLIF(@imagen, ''),
			@idTipoReto,
			@auxIdTipoEncuesta,
			@auxIdComportamiento,
			@auxIdTipoArchivo,
			@idTipoValidador,
			-1,			
			0
			)								

			Select @info = descripcion From Constants Where nombre = 'exito_insert'
			set @error = 0		
			Select @id = id from @tableId

		END TRY
		BEGIN CATCH	

			set @info = ERROR_MESSAGE()
			set @error = 1
			set @id = 0

		END CATCH;	
		
	end
	else
	begin

		set @info = 'No se encontró el tipo de reto'
		set @error = 1
		set @id = 0

	end


	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_C_Usuario]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_C_Usuario] 

	@nombre varchar(23),
	@apellido varchar(23),
	@correo varchar(60),
	@idU varchar(20), -- es la cédula o pasaporte, etc, etc
	@paisIso2 varchar(4),
	@paisCode varchar(5),
	@celular varchar(15),
	@foto varchar(50),
	@idRol varchar(9),	
	@idCiudad varchar(40),
	@idArea varchar(40),
	@clave varbinary(max),

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;	

	declare @contCelular int = 0, @contCorreo int = 0, @contIdU int = 0, @cantMax int = 0, @cantUsuario int = 0	
	Select @contCorreo = COUNT(*) from Usuario where correo = @correo 
	Select @contCelular = COUNT(*) from Usuario where celular = @celular
	Select @contIdU = COUNT(*) from Usuario where id = @idU
	Select @cantUsuario = COUNT(*) from Usuario

	Select @cantMax = cantidadMaxima from Licencia where tabla = 'Usuario'	

	if(@celular = '')
	begin
		set @celular = null
	end
	

	if(@cantMax > 0 and @cantUsuario >= @cantMax)
	begin

		select @info = descripcion from Constants where nombre = 'sin_licencias'
		set @error = 2

	end
	else if(@contCorreo > 0)
	begin

		set @info = 'El correo electrónico ya esta registrado'
		set @error = 1

	end
	else if(@contIdU > 0)
	begin 

		set @info = 'El id único ya esta registrado'
		set @error = 1

	end
	else if(@contCelular > 0)
	begin 

		set @info = 'El celular ya esta registrado'
		set @error = 1

	end	
	else
	begin
		
		BEGIN TRY  

			Insert into Usuario (nombre, apellido, correo, id, paisIso2, paisCode, celular, foto, idRol, idCiudad, idArea, clave, puntos, creditos) values
			(NULLIF(@nombre, ''),
			NULLIF(@apellido, ''),
			NULLIF(@correo, ''),
			NULLIF(@idU, ''),
			Case when @celular is not null then NULLIF(@paisIso2, '') else null end,
			Case when @celular is not null then NULLIF(@paisCode, '') else null end,			
			NULLIF(@celular, ''),
			NULLIF(@foto, ''),
			NULLIF(@idRol, ''),			
			NULLIF(@idCiudad, ''),			
			NULLIF(@idArea, ''),			
			--NULLIF(CAST(@clave as varbinary(max)), '')			
			NULLIF(@clave, ''),
			0,
			0
			)			

			Select @info = descripcion from Constants where nombre = 'exito_insert'
			set @error = 0

		END TRY
		BEGIN CATCH	

			set @info = ERROR_MESSAGE()
			set @error = 1

		END CATCH;			

	end	

	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_C_Usuario_Equipo]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_C_Usuario_Equipo] 

	@correo varchar(60),
	@idEquipo uniqueidentifier,	

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output

AS
BEGIN

	SET NOCOUNT ON;			

	Declare @contCorreo int = 0, @contUsuario_Equipo int = 0, @contUsuario_Equipos int = 0,  @idUsuario uniqueidentifier, @idReto uniqueidentifier, @info_C_Equipo_Reto varchar(max), @error_C_Equipo_Reto int, @id_C_Equipo_Reto varchar(max)	
	Select @contCorreo = COUNT(*), @idUsuario = idUsuario from Usuario where correo = @correo group by idUsuario		
	Select @contUsuario_Equipo = COUNT(*) from Usuario_Equipo where idEquipo = @idEquipo and idUsuario = @idUsuario
	Select @contUsuario_Equipos = COUNT(*) from Usuario_Equipo where idUsuario = @idUsuario

	if(@contUsuario_Equipo > 0)
	begin
		
		set @info = 'El usuario ya está asignado al equipo'
		set @error = 1

	end
	else if(@contUsuario_Equipos > 0)
	begin
		
		set @info = 'El usuario ya está asignado a otro equipo'
		set @error = 1

	end
	else if(@contCorreo = 0)
	begin
		
		set @info = 'El correo electrónico no existe'
		set @error = 1

	end
	else
	begin

		BEGIN TRY

			Insert into Usuario_Equipo (idUsuario, idEquipo) values
			(@idUsuario,
			@idEquipo			
			)
			
			if(@@ROWCOUNT > 0)
			begin

				DECLARE idsRetos CURSOR FOR 
			
				Select 	
				ur.idReto
				From Usuario_Reto ur 
				inner join Usuario_Equipo ue on ue.idUsuario = ur.idUsuario
				inner join Equipo e on e.idEquipo = ue.idEquipo 
				Where ur.tieneEquipo = 1 and e.idEquipo = @idEquipo
				Group by ue.idEquipo, ur.idReto

				OPEN idsRetos
				FETCH NEXT FROM idsRetos INTO @idReto
				WHILE @@fetch_status = 0
				BEGIN									

					exec sp_C_Usuario_Reto
					@correo =  @correo,
					@idReto = @idReto,
					@puntos = 0,
					@tiempo = 0,
					@vidas = 0,
					@tieneEquipo = 1,
					@validador = 0,
					@error = @error_C_Equipo_Reto output,
					@info = @info_C_Equipo_Reto output,
					@id = @id_C_Equipo_Reto output


					FETCH NEXT FROM idsRetos INTO @idReto
				END
				CLOSE idsRetos
				DEALLOCATE idsRetos			
				
				Select @info = 'Usuario asignado al equipo'
				set @error = 0

			end

		END TRY
		BEGIN CATCH	

			set @info = ERROR_MESSAGE()
			set @error = 1

		END CATCH;		

	end		

	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_C_Usuario_EquipoByCorreoIds]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_C_Usuario_EquipoByCorreoIds] 

	@correo_id varchar(99),
	@idEquipo uniqueidentifier,	

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output

AS
BEGIN

	SET NOCOUNT ON;		

	Declare @contCorreo int = 0, @contId int = 0, @contUsuario_Equipo int = 0, @contUsuario_Equipos int = 0,  @idUsuario uniqueidentifier	
	
	Select @contCorreo = COUNT(*), @idUsuario = idUsuario from Usuario where correo = @correo_id group by idUsuario		
	Select @contId = COUNT(*), @idUsuario = idUsuario from Usuario where id = @correo_id group by idUsuario			
	Select @contUsuario_Equipo = COUNT(*) from Usuario_Equipo where idEquipo = @idEquipo and idUsuario = @idUsuario
	Select @contUsuario_Equipos = COUNT(*) from Usuario_Equipo where idUsuario = @idUsuario

	if(@contUsuario_Equipo > 0)
	begin
		
		set @info = 'El usuario ya esta asignado al equipo'
		set @id = @correo_id
		set @error = 1

	end
	else if(@contUsuario_Equipos > 0)
	begin
		
		set @info = 'El usuario ya esta asignado a otro equipo'
		set @id = @correo_id
		set @error = 1

	end
	else if(@contCorreo = 0 and @contId = 0)
	begin
		
		set @info = 'No se encontró el correo o el id único del usuario'
		set @id = @correo_id
		set @error = 1

	end
	else
	begin

		BEGIN TRY

			Insert into Usuario_Equipo (idUsuario, idEquipo) values
			(@idUsuario,
			@idEquipo			
			)

			Select @info = descripcion from Constants where nombre = 'exito_insert'
			set @id = @correo_id
			set @error = 0

		END TRY
		BEGIN CATCH	

			set @info = ERROR_MESSAGE()
			set @id = @correo_id
			set @error = 1

		END CATCH;		

	end		

	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_C_Usuario_Medalla]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_C_Usuario_Medalla] 

	@idUsuario uniqueidentifier,
	@idMedalla uniqueidentifier,
	
	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;				

	Declare @contUsaruioMedalla int = 0
	Select @contUsaruioMedalla = COUNT(*) From Usuario_Medalla Where idUsuario = @idUsuario and idMedalla = @idMedalla	
	
	if(@contUsaruioMedalla > 0)
	begin
		
		set @info = 'Ya existe el usuario con la medalla'
		set @error = 1

	end
	else
	begin
		
		BEGIN TRY  

			Insert into Usuario_Medalla(idUsuario, idMedalla) values
			(@idUsuario, @idMedalla)					
		
			set @info = 'Medalla asignada al usuario satisfactoriamente'
			set @error = 0

		END TRY
		BEGIN CATCH	

			set @info = ERROR_MESSAGE()
			set @error = 1

		END CATCH;	

	end		

	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_C_Usuario_Nivel]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_C_Usuario_Nivel] 

	@idUsuario uniqueidentifier,
	@idNivel uniqueidentifier,
	
	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;				

	Declare @contUsaruioNivel int = 0
	Select @contUsaruioNivel = COUNT(*) From Usuario_Nivel Where idUsuario = @idUsuario and idNivel = @idNivel
	
	if(@contUsaruioNivel > 0)
	begin
		
		set @info = 'Ya existe el usuario con el nivel'
		set @error = 1

	end
	else
	begin
		
		BEGIN TRY  

			Insert into Usuario_Nivel (idUsuario, idNivel) values
			(@idUsuario, @idNivel)					
		
			Select @info = descripcion from Constants where nombre = 'exito_insert'
			set @error = 0

		END TRY
		BEGIN CATCH	

			set @info = ERROR_MESSAGE()
			set @error = 1

		END CATCH;	

	end		

	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_C_Usuario_Noticia]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_C_Usuario_Noticia] 

	@idUsuario uniqueidentifier,
	@idNoticia uniqueidentifier,
	@likes int,
	@comentario varchar(250),	

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;	
	
	if(@likes > -1)
	begin
		
		BEGIN TRY  

			Insert into Usuario_Noticia(idNoticia, idUsuario, likes, comentario) values
			(@idNoticia,
			@idUsuario,
			case @likes when '' then 0 else @likes end,
			NULLIF(@comentario, '')
			)			

			Select @info = descripcion from Constants where nombre = 'exito_insert'
			set @error = 0

		END TRY
		BEGIN CATCH	

			set @info = ERROR_MESSAGE()
			set @error = 1

		END CATCH;

	end
	else
	begin

		BEGIN TRY  
			
			Delete from Usuario_Noticia
			Where idUsuario = @idUsuario and idNoticia = @idNoticia and likes > 0

			Select @info = descripcion from Constants where nombre = 'exito_delete'
			set @error = 0

		END TRY
		BEGIN CATCH	

			set @info = ERROR_MESSAGE()
			set @error = 1

		END CATCH;

	end	

	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_C_Usuario_Recompensa]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_C_Usuario_Recompensa] 

	@idUsuario uniqueidentifier,
	@idRecompensa uniqueidentifier,
	
	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;				

	Declare @cantDisp int = 0, @contIdRecompensa int = 0
	Select @contIdRecompensa = COUNT(*) from Recompensa where idRecompensa = @idRecompensa
	Select @cantDisp = cantDisponible From Recompensa where idRecompensa = @idRecompensa		
	
	if(@contIdRecompensa = 0)
	begin
		
		set @info = 'El id de la recompensa no existe'
		set @error = 1

	end
	else if(@cantDisp < 1)
	begin
		
		set @info = 'La recompensa no tiene cantidad disponible'
		set @error = 1

	end
	else
	begin
		
		BEGIN TRY  
			
			Insert into Usuario_Recompensa(idUsuario, idRecompensa) values
			(@idUsuario, @idRecompensa)
		
			Select @info = descripcion from Constants where nombre = 'exito_insert'
			set @error = 0

		END TRY
		BEGIN CATCH	

			set @info = ERROR_MESSAGE()
			set @error = 1

		END CATCH;	

	end		

	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_C_Usuario_RedSocial]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_C_Usuario_RedSocial] 

	@idUsuario uniqueidentifier,
	@idRed uniqueidentifier,
	@likes int,
	@comentario varchar(250),	

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;	
	
	if(@likes > -1)
	begin
		
		BEGIN TRY  

			Insert into Usuario_RedSocial(idRed, idUsuario, likes, comentario) values
			(@idRed,
			@idUsuario,
			case @likes when '' then 0 else @likes end,
			NULLIF(@comentario, '')
			)			

			Select @info = descripcion from Constants where nombre = 'exito_insert'
			set @error = 0

		END TRY
		BEGIN CATCH	

			set @info = ERROR_MESSAGE()
			set @error = 1

		END CATCH;

	end
	else
	begin

		BEGIN TRY  
			
			Delete from Usuario_RedSocial
			Where idUsuario = @idUsuario and idRed = @idRed and likes > 0

			Select @info = descripcion from Constants where nombre = 'exito_delete'
			set @error = 0

		END TRY
		BEGIN CATCH	

			set @info = ERROR_MESSAGE()
			set @error = 1

		END CATCH;

	end	

	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_C_Usuario_Reto]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_C_Usuario_Reto] 

	@correo varchar(60),
	@idReto uniqueidentifier,
	@puntos int,
	@tiempo int,
	@vidas int,
	@tieneEquipo int,
	@validador int,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output

AS
BEGIN

	SET NOCOUNT ON;		

	Declare @contCorreo int = 0, @contUsuario_Reto int = 0,  @idUsuario uniqueidentifier, @idTipoReto uniqueidentifier,	@tipoReto varchar(30), @completado int = 0, @correctas int = 0, @incorrectas int = 0

	Select @contCorreo = COUNT(*), @idUsuario = idUsuario from Usuario where correo = @correo group by idUsuario		
	Select @contUsuario_Reto = COUNT(*) from Usuario_Reto where idReto = @idReto and idUsuario = @idUsuario and tieneEquipo = @tieneEquipo and validador = @validador
	Select @idTipoReto = idTipoReto from Reto where idReto = @idReto
	Select @tipoReto = nombre from TipoReto where idTipoReto = @idTipoReto	

	if(@tipoReto = 'Comportamiento')
	begin
		set @completado = 2
	end

	if(@validador > 0)
	begin
		set @correctas = -1
		set @incorrectas = -1
	end

	---
	if(@contUsuario_Reto > 0)
	begin
		
		set @info = 'El usuario ya esta asignado al reto'
		set @error = 1

	end
	else if(@contCorreo = 0)
	begin
		
		set @info = 'El correo electrónico no existe'
		set @error = 1

	end	
	else
	begin

		BEGIN TRY

			Insert into Usuario_Reto (idUsuario, idReto, puntos, tiempo, vidas, tieneEquipo, validador, completado, incorrectas, correctas) values
			(@idUsuario,
			@idReto,
			@puntos,
			@tiempo,
			@vidas,
			@tieneEquipo,
			@validador,
			@completado,
			@incorrectas,
			@correctas
			)			

			Select @info = descripcion from Constants where nombre = 'exito_insert'
			set @error = 0

		END TRY
		BEGIN CATCH	

			set @info = ERROR_MESSAGE()
			set @error = 1

		END CATCH;		

	end		

	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_C_Usuario_RetoByCorreoIds]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_C_Usuario_RetoByCorreoIds] 

	@correo_id varchar(99),
	@idReto uniqueidentifier,		

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output

AS
BEGIN

	SET NOCOUNT ON;		

	Declare @contCorreo int = 0, @contId int = 0, @contUsuario_Reto int = 0,  @idUsuario uniqueidentifier	
	
	Select @contCorreo = COUNT(*), @idUsuario = idUsuario from Usuario where correo = @correo_id group by idUsuario		
	Select @contId = COUNT(*), @idUsuario = idUsuario from Usuario where id = @correo_id group by idUsuario			
	Select @contUsuario_Reto = COUNT(*) from Usuario_Reto where idReto = @idReto and idUsuario = @idUsuario and tieneEquipo = 0

	if(@contUsuario_Reto > 0)
	begin
		
		set @info = 'El usuario ya esta asignado al reto'
		set @id = @correo_id
		set @error = 1

	end
	else if(@contCorreo = 0 and @contId = 0)
	begin
		
		set @info = 'No se encontró el correo o el id único del usuario'
		set @id = @correo_id
		set @error = 1

	end
	else
	begin

		BEGIN TRY

			Insert into Usuario_Reto (idUsuario, idReto, puntos, tiempo, vidas) values
			(@idUsuario,
			@idReto,
			0,0,0	
			)

			Select @info = descripcion from Constants where nombre = 'exito_insert'
			set @id = @correo_id
			set @error = 0

		END TRY
		BEGIN CATCH	

			set @info = ERROR_MESSAGE()
			set @id = @correo_id
			set @error = 1

		END CATCH;		

	end		

	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_C_UsuarioxArchivo]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_C_UsuarioxArchivo]
			
	@idReto uniqueidentifier,
	@idUsuario uniqueidentifier,
	@archivo varchar(100),
	@url varchar(150),

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;			

	Declare @contUserxOp int = 0, @countUser int = 0, @countReto int = 0

	Select @contUserxOp = COUNT(*) From UsuarioxArchivo Where idReto = @idReto and idUsuario = @idUsuario and archivo = @archivo
	Select @countUser = COUNT(*) from Usuario where idUsuario = @idUsuario
	Select @countReto = COUNT(*) from Reto where idReto = @idReto
	
	if(@contUserxOp > 0)
	begin

		set @info = 'El Usuario ya guardó el archivo'
		set @error = 1

	end
	else if(@countUser = 0 or @countReto = 0)
	begin

		set @info = 'No existe el usuario o el reto'
		set @error = 1

	end
	else
	begin		
		
		BEGIN TRY  

			Insert into UsuarioxArchivo (idReto, idUsuario, archivo, url) values
			(@idReto,
			@idUsuario,
			NULLIF(@archivo, ''),
			NULLIF(@url, '')
			)

			Select @info = descripcion From Constants Where nombre = 'exito_insert'
			set @error = 0

		END TRY
		BEGIN CATCH	

			set @info = ERROR_MESSAGE()
			set @error = 1

		END CATCH;	

	end	

	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_C_UsuarioxOpcion]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_C_UsuarioxOpcion]
			
	@idOpcion uniqueidentifier,
	@idUsuario uniqueidentifier,
	@respuesta varchar(350),
	@idUserValidador varchar(40),

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;			

	Declare @contUserxOp int = 0, @contValidadorxOp int = 0, @countUser int = 0, @countOp int = 0, @countUserValidador int = 0

	if(@idUserValidador = '')
	begin
		set @idUserValidador = null
	end
	
	Select @contUserxOp = COUNT(*) From UsuarioxOpcion Where idOpcion = @idOpcion and  idUsuario = @idUsuario
	Select @contValidadorxOp = COUNT(*) From UsuarioxOpcion Where idOpcion = @idOpcion and  idUsuario = @idUsuario and idUserValidador = @idUserValidador
	Select @countUser = COUNT(*) from Usuario where idUsuario = @idUsuario
	Select @countOp = COUNT(*) from Opcion where idOpcion = @idOpcion	
	Select @countUserValidador = COUNT(*) from Usuario where idUsuario = @idUserValidador	


	if(@contUserxOp > 0 and @idUserValidador is null)
	begin

		set @info = 'El Usuario ya votó en esa opcion'
		set @error = 1

	end
	else if(@contValidadorxOp > 0)
	begin

		set @info = 'El Validador ya votó en esa opcion con ese usuario'
		set @error = 1

	end
	else if(@countUser = 0 or @countOp = 0 or (@idUserValidador is not null and @countUserValidador = 0))
	begin

		set @info = 'No existe el usuario o la opción'
		set @error = 1

	end
	else
	begin		
		
		BEGIN TRY  

			Insert into UsuarioxOpcion (idOpcion, idUsuario, respuesta, idUserValidador) values
			(@idOpcion,
			@idUsuario,
			NULLIF(@respuesta, ''),
			@idUserValidador
			)			

			Select @info = descripcion From Constants Where nombre = 'exito_insert'
			set @error = 0

		END TRY
		BEGIN CATCH	

			set @info = ERROR_MESSAGE()
			set @error = 1

		END CATCH;	

	end		

	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_D_Equipo]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_D_Equipo] 
	
	@idEquipo uniqueidentifier,	

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;	

	Declare @tableUsuario table (idUsuario uniqueidentifier)
	Declare @tableReto table (idReto uniqueidentifier)
	Declare @contIdEquipo int = 0, @imagen varchar(50) = 'N/A', @idUsuario uniqueidentifier
	Select @contIdEquipo = COUNT(*), @imagen = ISNULL(imagen, 'N/A') From Equipo Where idEquipo = @idEquipo group by imagen		

	DECLARE idsUsuarios CURSOR FOR 

	Select idUsuario from Usuario_Equipo where idEquipo = @idEquipo

	OPEN idsUsuarios
	FETCH NEXT FROM idsUsuarios INTO @idUsuario
	WHILE @@fetch_status = 0
	BEGIN		

		insert into @tableUsuario (idUsuario) values
		(@idUsuario)		

		FETCH NEXT FROM idsUsuarios INTO @idUsuario
	END
	CLOSE idsUsuarios
	DEALLOCATE idsUsuarios

	
	if(@contIdEquipo = 0)
	begin

		set @info = 'No existe el id del equipo'
		set @error = 1

	end	
	else
	begin
		
		BEGIN TRY  			

			Delete from Usuario_Reto output deleted.idReto into @tableReto
			where tieneEquipo = 1 and idUsuario in (select idUsuario from @tableUsuario)

			Delete from Novedad
			where idUsuario in (select idUsuario from @tableUsuario) and idTabla in (select idReto from @tableReto)
			
			Delete From Usuario_Equipo
			where idEquipo = @idEquipo

			Delete From Equipo 
			where idEquipo = @idEquipo
			
			Select @info = CONCAT(descripcion,', image: ',@imagen) from Constants where nombre = 'exito_delete'
			set @error = 0

		END TRY
		BEGIN CATCH	

			set @info = ERROR_MESSAGE()
			set @error = 1

		END CATCH;			

	end	

	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_D_Equipo_Reto]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_D_Equipo_Reto] 
	
	@idEquipo uniqueidentifier,
	@idReto uniqueidentifier,	

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output

AS
BEGIN

	SET NOCOUNT ON;		

	Declare @table table (idUsuario uniqueidentifier)
	Declare @idUsuario uniqueidentifier, @contUsuarios int = 0	

	DECLARE idsUsuarios CURSOR FOR 

	Select idUsuario from Usuario_Reto where tieneEquipo = 1 and idReto = @idReto

	OPEN idsUsuarios
	FETCH NEXT FROM idsUsuarios INTO @idUsuario
	WHILE @@fetch_status = 0
	BEGIN

		declare @contIdUsuario int = 0
		Select @contIdUsuario = COUNT(*) from Usuario_Equipo where idEquipo = @idEquipo and idUsuario = @idUsuario

		if(@contIdUsuario > 0)
		begin
			insert into @table (idUsuario) values
			(@idUsuario)
		end		

		FETCH NEXT FROM idsUsuarios INTO @idUsuario
	END
	CLOSE idsUsuarios
	DEALLOCATE idsUsuarios

	Select @contUsuarios = COUNT(*) from @table

	if(@contUsuarios = 0)
	begin
		
		select @info = descripcion from Constants where nombre = 'no_encontrar'		
		set @error = 1

	end	
	else
	begin

		BEGIN TRY			

			Delete from Novedad
			where idUsuario in (select idUsuario from @table) and idTabla = @idReto

			Delete from Usuario_Reto where tieneEquipo = 1 and idReto = @idReto and idUsuario in (select idUsuario from @table)

			Select @info = descripcion from Constants where nombre = 'exito_delete'
			set @error = 0

			Select * from Usuario_Reto where idReto = @idReto
			if(@@ROWCOUNT = 0)
			begin				
				Update Reto set estado = 0 where idReto = @idReto
			end	

		END TRY
		BEGIN CATCH	

			set @info = ERROR_MESSAGE()
			set @error = 1

		END CATCH;		

	end		

	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_D_InicioByNoIds]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_D_InicioByNoIds] 

	@ids varchar(max),
	@idRol varchar(9),
	
	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;

	Delete From Inicio
	Where idRol = @idRol and idInicio not in (select value from string_split(@ids,'|'))  
	
	if(@@ROWCOUNT > 0)
	begin
		select @info = descripcion from Constants where nombre = 'exito_delete'				
	end
	else
	begin
		select @info = descripcion from Constants where nombre = 'no_delete'
	end

	set @error = 0
	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_D_Medalla]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_D_Medalla] 
	
	@idMedalla uniqueidentifier,	

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;	

	Declare @contIdMedalla int = 0, @imagen varchar(50) = 'N/A'
	Select @contIdMedalla = COUNT(*), @imagen = ISNULL(imagen, 'N/A') From Medalla Where idMedalla = @idMedalla	group by imagen	
	
	if(@contIdMedalla = 0)
	begin

		set @info = 'No existe el id de la Medalla'
		set @error = 1

	end	
	else
	begin
		
		BEGIN TRY  

			Delete from Novedad
			where idTabla = @idMedalla
			
			Delete From Usuario_Medalla 
			where idMedalla = @idMedalla

			Delete From Medalla 
			where idMedalla = @idMedalla
			
			Select @info = CONCAT(descripcion,', image: ',@imagen) from Constants where nombre = 'exito_delete'
			set @error = 0

		END TRY
		BEGIN CATCH	

			set @info = ERROR_MESSAGE()
			set @error = 1

		END CATCH;			

	end	

	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_D_Nivel]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_D_Nivel] 

	@idNivel uniqueidentifier,		

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;		

	Declare @contIdNivel int = 0, @imagen varchar(50) = 'N/A'
	Select @contIdNivel = COUNT(*), @imagen = ISNULL(imagen, 'N/A') from Nivel where idNivel = @idNivel group by imagen	
	
	
	if(@contIdNivel = 0)
	begin

		set @info = 'No existe el id del Nivel'
		set @error = 1

	end		
	else
	begin
		
		BEGIN TRY  

			Delete from Novedad
			where idTabla = @idNivel 

			Delete From Usuario_Nivel 
			where idNivel = @idNivel

			Delete From Nivel 
			where idNivel = @idNivel
						
			Select @info = CONCAT(descripcion,', image: ',@imagen) from Constants where nombre = 'exito_delete'
			set @error = 0

		END TRY
		BEGIN CATCH	

			set @info = ERROR_MESSAGE()
			set @error = 1

		END CATCH;			

	end	

	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_D_Noticia]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_D_Noticia] 
		
	@idNoticia uniqueidentifier,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;		
	
	Declare @contIdNoticia int = 0, @imagen varchar(50) = 'N/A'
	Select @contIdNoticia = COUNT(*), @imagen = ISNULL(imagen, 'N/A') From Noticia where idNoticia = @idNoticia group by imagen	


	if(@contIdNoticia = 0)
	begin
		
		set @info = 'No existe la Noticia'
		set @error = 1
		
	end
	else
	begin

		BEGIN TRY  
	
			Delete From Usuario_Noticia 
			Where idNoticia = @idNoticia

			Delete From Noticia 
			Where idNoticia = @idNoticia
			
			Select @info = CONCAT(descripcion,', image: ',@imagen) from Constants where nombre = 'exito_delete'
			set @error = 0

		END TRY
		BEGIN CATCH	

			set @info = ERROR_MESSAGE()
			set @error = 1

		END CATCH;		

	end		

	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_D_Novedad]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_D_Novedad] 
	
	@idNovedad uniqueidentifier,
	@idUsuario uniqueidentifier,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;	
	
	Declare @contIdNovedad int = 0
	Select @contIdNovedad = COUNT(*) From Novedad Where idNovedad = @idNovedad and idUsuario = @idUsuario	
	
	if(@contIdNovedad = 0)
	begin

		set @info = 'No existe el id de la Novedad con ese usuario'
		set @error = 1

	end	
	else
	begin
		
		BEGIN TRY  			

			Delete from Novedad
			where idNovedad = @idNovedad
									
			Select @info = descripcion from Constants where nombre = 'exito_delete'
			set @error = 0

		END TRY
		BEGIN CATCH	

			set @info = ERROR_MESSAGE()
			set @error = 1

		END CATCH;			

	end	

	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_D_NovedadByIdUsuario]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_D_NovedadByIdUsuario] 
	
	@idUsuario uniqueidentifier,	

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;	
	
	Declare @contIdUsuario int = 0
	Select @contIdUsuario = COUNT(*) From Novedad Where idUsuario = @idUsuario
	
	if(@contIdUsuario = 0)
	begin

		set @info = 'No existe el id del usuario'
		set @error = 1

	end	
	else
	begin
		
		BEGIN TRY  			

			Delete from Novedad
			where idUsuario = @idUsuario			
									
			Select @info = descripcion from Constants where nombre = 'exito_delete'
			set @error = 0

		END TRY
		BEGIN CATCH	

			set @info = ERROR_MESSAGE()
			set @error = 1

		END CATCH;			

	end	

	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_D_Opcion]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_D_Opcion] 

	@idOpcion uniqueidentifier,
	
	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;
	
	Declare @contIdOpcion int = 0
	Select @contIdOpcion = COUNT(*) From Opcion where idOpcion = @idOpcion
	
	
	if(@contIdOpcion = 0)
	begin

		set @info = 'No existe la opcion'
		set @error = 1

	end	
	else
	begin
		
		BEGIN TRY  
			
			Delete From Opcion
			Where idOpcion = @idOpcion	
			
			Delete From UsuarioxOpcion
			Where idOpcion = @idOpcion
			
			Select @info = descripcion from Constants where nombre = 'exito_delete'
			set @error = 0

		END TRY
		BEGIN CATCH	

			set @info = ERROR_MESSAGE()
			set @error = 1

		END CATCH;			

	end	

	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_D_OpcionByNoIds]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_D_OpcionByNoIds] 

	@ids varchar(max),
	@idPregunta uniqueidentifier,
	
	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;

	Declare @idsOpcion table (idOpcion uniqueidentifier)

	Delete From Opcion 
	Output deleted.idOpcion into @idsOpcion
	Where idPregunta = @idPregunta and idOpcion not in (select value from string_split(@ids,'|'))  
	
	if(@@ROWCOUNT > 0)
	begin
		
		Delete From UsuarioxOpcion
		Where idOpcion in (Select idOpcion from @idsOpcion)

		select @info = descripcion from Constants where nombre = 'exito_delete'				
	end
	else
	begin
		select @info = descripcion from Constants where nombre = 'no_delete'
	end

	set @error = 0
	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_D_Pregunta]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_D_Pregunta] 

	@idPregunta uniqueidentifier,
	
	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;
	
	Declare @contIdPregunta int = 0, @idReto uniqueidentifier
	Declare @idsOpcion table (idOpcion uniqueidentifier)
	Select @contIdPregunta = COUNT(*) From Pregunta where idPregunta = @idPregunta
	
	
	if(@contIdPregunta = 0)
	begin

		set @info = 'No existe la Pregunta'
		set @error = 1

	end	
	else
	begin
		
		BEGIN TRY  
			
			Select @idReto = idReto from Pregunta where idPregunta = @idPregunta

			Delete From Opcion
			Output deleted.idOpcion into @idsOpcion
			Where idPregunta = @idPregunta

			Delete From UsuarioxOpcion
			Where idOpcion in (Select idOpcion from @idsOpcion)

			Delete From Pregunta
			Where idPregunta = @idPregunta							
			
			Select @info = descripcion from Constants where nombre = 'exito_delete'
			set @error = 0
			
			Select * from Pregunta where idReto = @idReto
			if(@@ROWCOUNT < 5)
			begin				
				Update Reto set estado = 0 where idReto = @idReto
			end	

		END TRY
		BEGIN CATCH	

			set @info = ERROR_MESSAGE()
			set @error = 1

		END CATCH;			

	end	

	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_D_Recompensa]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_D_Recompensa] 

	@idRecompensa uniqueidentifier,
	
	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;		
	
	Declare @contIdRecom int = 0, @imagen varchar(50) = 'N/A'
	Select @contIdRecom = COUNT(*), @imagen = ISNULL(imagen, 'N/A') From Recompensa where idRecompensa = @idRecompensa group by imagen
	
	
	if(@contIdRecom = 0)
	begin

		set @info = 'No existe la recompensa'
		set @error = 1

	end	
	else
	begin
		
		BEGIN TRY  

			Delete from Novedad
			where idTabla = @idRecompensa
			
			Delete From Usuario_Recompensa
			Where idRecompensa = @idRecompensa

			Delete From Recompensa
			Where idRecompensa = @idRecompensa
			
			Select @info = CONCAT(descripcion,', image: ',@imagen) from Constants where nombre = 'exito_delete'
			set @error = 0

		END TRY
		BEGIN CATCH	

			set @info = ERROR_MESSAGE()
			set @error = 1

		END CATCH;			

	end	

	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_D_Reto]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_D_Reto] 
	
	@idReto uniqueidentifier,	

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;	

	Declare @contIdReto int = 0, @idPregunta uniqueidentifier, @imagen varchar(50) = 'N/A'
	Select @contIdReto = COUNT(*), @imagen = ISNULL(imagen, 'N/A') From Reto Where idReto = @idReto	group by imagen		
	
	if(@contIdReto = 0)
	begin

		set @info = 'No existe el id del reto'
		set @error = 1

	end	
	else
	begin
		
		BEGIN TRY  			
			-- INICIO CURSOR			
			DECLARE cur_pregunta CURSOR FOR 
			select idPregunta from Pregunta where idReto = @idReto
			OPEN cur_pregunta
			FETCH NEXT FROM cur_pregunta INTO @idPregunta
			WHILE @@fetch_status = 0
			BEGIN
				
				Delete from Opcion where idPregunta = @idPregunta;

				FETCH NEXT FROM cur_pregunta INTO @idPregunta
			END
			CLOSE cur_pregunta
			DEALLOCATE cur_pregunta
			-- FIN CURSOR			

			Delete From Pregunta 
			where idReto = @idReto					

			Delete from Novedad
			where idTabla = @idReto

			Delete From Usuario_Reto 
			where idReto = @idReto

			Delete From UsuarioxArchivo
			where idReto = @idReto

			Delete From Reto 
			where idReto = @idReto			
			
			Select @info = CONCAT(descripcion,', image: ',@imagen) from Constants where nombre = 'exito_delete'
			set @error = 0

		END TRY
		BEGIN CATCH	

			set @info = ERROR_MESSAGE()
			set @error = 1

		END CATCH;			

	end	

	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_D_Usuario_Equipo]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_D_Usuario_Equipo] 
	
	@idUsuario uniqueidentifier,
	@idEquipo uniqueidentifier,	

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output

AS
BEGIN

	SET NOCOUNT ON;		

	Declare @table table (idReto uniqueidentifier)
	Declare @contUsuario_Equipo int = 0	
	Select @contUsuario_Equipo = COUNT(*) from Usuario_Equipo where idEquipo = @idEquipo and idUsuario = @idUsuario

	if(@contUsuario_Equipo = 0)
	begin
		
		select @info = descripcion from Constants where nombre = 'no_encontrar'		
		set @error = 1

	end	
	else
	begin

		BEGIN TRY			

			Delete from Usuario_Reto output deleted.idReto into @table
			Where idUsuario = @idUsuario and tieneEquipo = 1

			Delete from Novedad
			where idUsuario = @idUsuario and idTabla in (select idReto from @table)

			Delete from Usuario_Equipo 
			where idEquipo = @idEquipo and idUsuario = @idUsuario

			Select @info = descripcion from Constants where nombre = 'exito_delete'
			set @error = 0

			Select * from Usuario_Equipo where idEquipo = @idEquipo			
			if(@@ROWCOUNT = 0)
			begin				
				Update Equipo set estado = 0 where idEquipo = @idEquipo
			end	

		END TRY
		BEGIN CATCH	

			set @info = ERROR_MESSAGE()
			set @error = 1

		END CATCH;		

	end		

	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_D_Usuario_Reto]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_D_Usuario_Reto] 
	
	@idUsuario uniqueidentifier,
	@idReto uniqueidentifier,	

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output

AS
BEGIN

	SET NOCOUNT ON;		

	Declare @contUsuario_Reto int = 0	
	Select @contUsuario_Reto = COUNT(*) from Usuario_Reto where idReto = @idReto and idUsuario = @idUsuario

	if(@contUsuario_Reto = 0)
	begin
		
		select @info = descripcion from Constants where nombre = 'no_encontrar'		
		set @error = 1

	end	
	else
	begin

		BEGIN TRY			

			Delete from Novedad
			where idUsuario = @idUsuario and idTabla = @idReto

			Delete from Usuario_Reto where idReto = @idReto and idUsuario = @idUsuario and tieneEquipo = 0

			Select @info = descripcion from Constants where nombre = 'exito_delete'
			set @error = 0

			Select * from Usuario_Reto where idReto = @idReto
			if(@@ROWCOUNT = 0)
			begin				
				Update Reto set estado = 0 where idReto = @idReto
			end			

		END TRY
		BEGIN CATCH	

			set @info = ERROR_MESSAGE()
			set @error = 1

		END CATCH;		

	end		

	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_U_Area]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_U_Area] 
		
	@idArea uniqueidentifier,
	@nombre varchar(65),
	@descripcion varchar(250),
	@idEmpresa uniqueidentifier,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;				

	Declare @contNombre int = 0
	Select @contNombre = COUNT(*) From Area Where nombre = @nombre and idArea <> @idArea
	
	if(@contNombre > 0)
	begin

		set @info = 'El nombre ya esta registrado'
		set @error = 1

	end
	else
	begin		
		
		BEGIN TRY  

			Update Area set
			nombre = NULLIF(@nombre, ''),
			descripcion = NULLIF(@descripcion, ''),
			idEmpresa = @idEmpresa,
			fechaModificacion = GETDATE()
			where idArea = @idArea
			
			Select @info = descripcion From Constants Where nombre = 'exito_update'
			set @error = 0

		END TRY
		BEGIN CATCH	

			set @info = ERROR_MESSAGE()
			set @error = 1

		END CATCH;	

	end	

	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_U_CategoriaNoticia]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_U_CategoriaNoticia] 

	@idCategoria uniqueidentifier,
	@nombre varchar(50),
	@descripcion varchar(250),	

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;	

	Declare @contNombre int = 0
	Select @contNombre = COUNT(*) From CategoriaNoticia Where nombre = @nombre and idCategoria <> @idCategoria
	
	if(@contNombre > 0)
	begin

		set @info = 'El nombre ya esta registrado'
		set @error = 1

	end		
	else
	begin
		
		BEGIN TRY  

			Update CategoriaNoticia set			
			nombre = NULLIF(@nombre, ''),
			descripcion = NULLIF(@descripcion, ''),
			fechaModificacion = GETDATE()
			Where idCategoria = @idCategoria							

			Select @info = descripcion From Constants Where nombre = 'exito_update'
			set @error = 0

		END TRY
		BEGIN CATCH	

			set @info = ERROR_MESSAGE()
			set @error = 1

		END CATCH;			

	end	

	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_U_CategoriaRecompensa]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_U_CategoriaRecompensa] 

	@idCategoria uniqueidentifier,
	@nombre varchar(50),
	@descripcion varchar(250),	

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;	

	Declare @contNombre int = 0
	Select @contNombre = COUNT(*) From CategoriaRecompensa Where nombre = @nombre and idCategoria <> @idCategoria
	
	if(@contNombre > 0)
	begin

		set @info = 'El nombre ya esta registrado'
		set @error = 1

	end		
	else
	begin
		
		BEGIN TRY  

			Update CategoriaRecompensa set			
			nombre = NULLIF(@nombre, ''),
			descripcion = NULLIF(@descripcion, ''),
			fechaModificacion = GETDATE()
			Where idCategoria = @idCategoria							

			Select @info = descripcion From Constants Where nombre = 'exito_update'
			set @error = 0

		END TRY
		BEGIN CATCH	

			set @info = ERROR_MESSAGE()
			set @error = 1

		END CATCH;			

	end	

	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_U_Ciudad]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_U_Ciudad] 
	
	@idCiudad uniqueidentifier,
	@nombre varchar(65),
	@descripcion varchar(250),
	@idPais uniqueidentifier,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;			

	Declare @contNombre int = 0
	Select @contNombre = COUNT(*) From Ciudad Where nombre = @nombre and idCiudad <> @idCiudad
	
	if(@contNombre > 0)
	begin

		set @info = 'El nombre ya esta registrado'
		set @error = 1

	end
	else
	begin		
		
		BEGIN TRY  

			Update Ciudad Set
			nombre = NULLIF(@nombre, ''),
			descripcion = NULLIF(@descripcion, ''),
			idPais = @idPais,
			fechaModificacion = GETDATE()
			Where idCiudad = @idCiudad

			Select @info = descripcion From Constants Where nombre = 'exito_update'
			set @error = 0

		END TRY
		BEGIN CATCH	

			set @info = ERROR_MESSAGE()
			set @error = 1

		END CATCH;	

	end	

	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_U_Configuracion]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_U_Configuracion] 

	@idConfig uniqueidentifier,	
	@valor varchar(50),		
	@idUsuario uniqueidentifier,	

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;		

	declare @oldValue varchar(50) = 'N/A'	
	select @oldValue = ISNULL(valor, 'N/A') from Configuracion where idConfig = @idConfig	
	
	BEGIN TRY  

		Update Configuracion Set						
		valor = Case @valor When '' then valor else @valor end,		
		idUsuario = @idUsuario,
		fechaModificacion = GETDATE()
		Where idConfig = @idConfig
			
		Select @info = CONCAT(descripcion,', old_value: ',@oldValue) from Constants where nombre = 'exito_update'
		set @error = 0

	END TRY
	BEGIN CATCH	

		set @info = ERROR_MESSAGE()
		set @error = 1

	END CATCH;	

	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_U_CorreoEnvio]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_U_CorreoEnvio] 

	@idCorreo uniqueidentifier,
	@nombre varchar(60),
	@correo varchar(60),
	@clave varbinary(max),
	@puerto int,
	@host varchar(60),

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;	

	declare @contIdC int = 0
	Select @contIdC = COUNT(*) from CorreoEnvio where idCorreo =  @idCorreo
	
	
	if(@contIdC = 0)
	begin

		set @info = 'No se encontró el id del correo'
		set @error = 1
	end		
	else
	begin
		
		BEGIN TRY  
						
			Update CorreoEnvio set 			
			nombre = NULLIF(@nombre, ''),
			correo =  NULLIF(@correo, ''),
			clave = case @clave when 0x then clave else @clave end,
			puerto = NULLIF(@puerto, ''),
			host = NULLIF(@host, ''),												
			fechaModificacion = GETDATE()
			Where idCorreo = @idCorreo
			
			Select @info = descripcion from Constants where nombre = 'exito_update'
			set @error = 0

		END TRY
		BEGIN CATCH	

			set @info = ERROR_MESSAGE()
			set @error = 1

		END CATCH;			

	end	

	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_U_Empresa]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_U_Empresa] 
		
	@idEmpresa uniqueidentifier,	
	@nombre varchar(100),
	@descripcion varchar(250),

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;			

	Declare @contNombre int = 0
	Select @contNombre = COUNT(*) From Empresa Where nombre = @nombre and idEmpresa <> @idEmpresa
	
	if(@contNombre > 0)
	begin

		set @info = 'El nombre ya esta registrado'
		set @error = 1

	end
	else
	begin		
		
		BEGIN TRY  

			Update Empresa Set
			nombre = NULLIF(@nombre, ''),
			descripcion = NULLIF(@descripcion, ''),
			fechaModificacion = GETDATE()
			Where idEmpresa = @idEmpresa												

			Select @info = descripcion From Constants Where nombre = 'exito_update'
			set @error = 0

		END TRY
		BEGIN CATCH	

			set @info = ERROR_MESSAGE()
			set @error = 1

		END CATCH;	

	end	

	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_U_Equipo]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_U_Equipo] 
		
	@idEquipo uniqueidentifier,
	@nombre varchar(30),
	@imagen varchar(50),
	@descripcion varchar(250),			

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;		

	Declare @contNombre int = 0, @contIdEquipo int = 0, @oldImage varchar(50) = 'N/A'
	Select @contNombre = COUNT(*) From Equipo Where nombre = @nombre and idEquipo <> @idEquipo		
	Select @contIdEquipo = COUNT(*), @oldImage = ISNULL(imagen, 'N/A') From Equipo where idEquipo = @idEquipo group by imagen	
	
	
	if(@contIdEquipo = 0)
	begin

		set @info = 'No existe el equipo'
		set @error = 1

	end
	else if(@contNombre > 0)
	begin

		set @info = 'El nombre ya esta registrado'
		set @error = 1

	end		
	else
	begin		
		
		BEGIN TRY  

			Update Equipo set
			nombre = NULLIF(@nombre, ''),			
			imagen =  case @imagen when '' then imagen else @imagen end,
			descripcion = NULLIF(@descripcion, ''),
			fechaModificacion = GETDATE()
			Where idEquipo = @idEquipo

			
			Select @info = CONCAT(descripcion,', old_image: ',@oldImage) from Constants where nombre = 'exito_update'
			set @error = 0

		END TRY
		BEGIN CATCH

			set @info = ERROR_MESSAGE()
			set @error = 1

		END CATCH;	

	end	

	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_U_EquipoByEstado]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_U_EquipoByEstado] 

	@idEquipo uniqueidentifier,
	@estado int,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;	

	declare @contIdE int = 0, @totalUsuarios int = 0
	Select @contIdE = COUNT(*) from Equipo where idEquipo = @idEquipo		
	select @totalUsuarios = COUNT(*) from Usuario_Equipo ue where ue.idEquipo = @idEquipo	
	
	if(@contIdE = 0)
	begin

		set @info = 'No se encontró el id del equipo'
		set @error = 1

	end	
	else if(@estado > 0 and @totalUsuarios = 0)
	begin

		set @info = 'No se puede activar el reto porque no tiene ningun usuario asignado'
		set @error = 1

	end
	else
	begin
		
		BEGIN TRY  
						
			Update Equipo set 
			estado = case @estado when '' then 0 else @estado end,
			fechaModificacion = GETDATE()
			Where idEquipo = @idEquipo
			
			Select @info = descripcion from Constants where nombre = 'exito_update'
			set @error = 0

		END TRY
		BEGIN CATCH	

			set @info = ERROR_MESSAGE()
			set @error = 1

		END CATCH;			

	end	

	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_U_Inicio]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_U_Inicio] 
		
	@idInicio uniqueidentifier,
	@nombre varchar(60),
	@indice int,
	@idRol varchar(9),
	@color varchar(10),	

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;					

	Declare @tableId TABLE (id uniqueidentifier);
	Declare @contId int = 0
	Select @contId = COUNT(*) From Inicio Where idInicio = @idInicio
	
	if(@contId > 0)
	begin
		
		BEGIN TRY  

			Update Inicio set
			nombre = NULLIF(@nombre, ''),
			indice = NULLIF(@indice, ''),
			color = NULLIF(@color, ''),
			idRol = @idRol,
			fechaModificacion = GETDATE()
			where idInicio = @idInicio
			
			Select @info = descripcion From Constants Where nombre = 'exito_update'
			set @error = 0
			set @id = @idInicio

		END TRY
		BEGIN CATCH	

			set @info = ERROR_MESSAGE()
			set @error = 1

		END CATCH;	

	end
	else
	begin		

		BEGIN TRY  

			Insert into Inicio (nombre, indice,color, idRol) output inserted.idInicio into @tableId values
			(NULLIF(@nombre, ''),
			NULLIF(@indice, ''),
			NULLIF(@color, ''),
			@idRol
			)						
						
			Select @info = descripcion From Constants Where nombre = 'exito_insert'
			set @error = 0
			Select @id = id from @tableId

		END TRY
		BEGIN CATCH	

			set @info = ERROR_MESSAGE()
			set @error = 1

		END CATCH;		

	end	

	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_U_Medalla]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_U_Medalla] 

	@idMedalla uniqueidentifier,
	@nombre varchar(30),
	@descripcion varchar(250),
	@imagen varchar(50),
	@idCondicion uniqueidentifier,	
	@numCondicion int,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;	

	Declare @contNombre int = 0, @contIdCondicion int = 0, @contIdMedalla int = 0, @oldImage varchar(50) = 'N/A'
	Select @contNombre = COUNT(*) From Medalla Where nombre = @nombre and idMedalla <> @idMedalla
	Select @contIdCondicion = COUNT(*) From Medalla Where idCondicion = @idCondicion and idMedalla <> @idMedalla
	Select @contIdMedalla = COUNT(*), @oldImage = ISNULL(imagen, 'N/A') From Medalla where idMedalla = @idMedalla group by imagen	
	
	if(@contIdMedalla = 0)
	begin

		set @info = 'No existe la medalla'
		set @error = 1

	end
	else if(@contNombre > 0)
	begin

		set @info = 'El nombre ya esta registrado'
		set @error = 1

	end	
	else if(@contIdCondicion > 0)
	begin
		
		set @info = 'La condición ya esta registrada'
		set @error = 1

	end
	else if(@numCondicion < 1)
	begin
		
		set @info = 'El número de condición no puede ser menor a uno'
		set @error = 1

	end
	else if(@numCondicion > 1000)
	begin
		
		set @info = 'El número de condición no puede ser mayor a mil'
		set @error = 1

	end
	else
	begin
		
		BEGIN TRY  
			
			Update Medalla set			
			nombre = NULLIF(@nombre, ''),
			descripcion = NULLIF(@descripcion, ''),
			imagen = case @imagen when '' then imagen else @imagen end,
			idCondicion = @idCondicion,
			numCondicion = case @numCondicion when '' then 1 else @numCondicion end,
			fechaModificacion = GETDATE()
			Where idMedalla = @idMedalla			

			Select @info = CONCAT(descripcion,', old_image: ',@oldImage) from Constants where nombre = 'exito_update'
			set @error = 0

		END TRY
		BEGIN CATCH	

			set @info = ERROR_MESSAGE()
			set @error = 1

		END CATCH;			

	end	

	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_U_Nivel]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_U_Nivel] 

	@idNivel uniqueidentifier,
	@nombre varchar(20),	
	@descripcion varchar(250),
	@puntosNecesarios int,
	@imagen varchar(50),	

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;			

	declare @contNombre int = 0, @contIdNivel int = 0, @contPuntos int = 0, @oldImage varchar(50) = 'N/A'
	Select @contNombre = COUNT(*) From Nivel where nombre = @nombre and idNivel <> @idNivel
	Select @contIdNivel = COUNT(*), @oldImage = ISNULL(imagen, 'N/A') From Nivel where idNivel = @idNivel group by imagen	
	Select @contPuntos = COUNT(*) From Nivel where puntosNecesarios = @puntosNecesarios and idNivel <> @idNivel
	
	if(@contIdNivel = 0)
	begin
		
		set @info = 'No existe el Nivel'
		set @error = 1

	end
	else if(@contNombre > 0)
	begin

		set @info = 'El nombre ya esta registrado'
		set @error = 1

	end	
	else if(@contPuntos > 0)
	begin

		set @info = 'Los puntos necesarios ya están registrados'
		set @error = 1

	end
	else
	begin

		if(@puntosNecesarios < 1 or @puntosNecesarios = '') 
		begin
			
			Select @puntosNecesarios = puntosNecesarios from Nivel where idNivel = @idNivel			
			set @error = 0

		end		
		
		BEGIN TRY  

			Update Nivel set			
			nombre = NULLIF(@nombre, ''),			
			descripcion = NULLIF(@descripcion, ''),
			puntosNecesarios = NULLIF(@puntosNecesarios, 0),
			imagen = case @imagen when '' then imagen else @imagen end,
			fechaModificacion = GETDATE()
			Where idNivel = @idNivel
			

			Select @info = CONCAT(descripcion,', old_image: ',@oldImage) from Constants where nombre = 'exito_update'
			set @error = 0

		END TRY
		BEGIN CATCH	

			set @info = ERROR_MESSAGE()
			set @error = 1

		END CATCH;			

	end	

	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_U_Noticia]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_U_Noticia] 

	@idNoticia uniqueidentifier,
	@titular varchar(100),
	@descripcion varchar(500),
	@url varchar(250),
	@imagen varchar(50),	
	@fechaPublicacion datetime,
	@idCategoria uniqueidentifier,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;		

	Declare @contIdNoticia int = 0, @oldImage varchar(50) = 'N/A'
	Select @contIdNoticia = COUNT(*), @oldImage = ISNULL(imagen, 'N/A') From Noticia where idNoticia = @idNoticia group by imagen	

	if(@contIdNoticia = 0)
	begin
		
		set @info = 'No existe la Noticia'
		set @error = 1

	end
	else
	begin

		BEGIN TRY  

			Update Noticia set		
			titular = NULLIF(@titular, ''),
			descripcion = NULLIF(@descripcion, ''),
			url = NULLIF(@url, ''),
			imagen = case @imagen when '' then imagen else @imagen end,
			idCategoria = @idCategoria,
			fechaPublicacion = NULLIF(@fechaPublicacion, ''),
			fechaModificacion = GETDATE()
			Where idNoticia = @idNoticia
		
			Select @info = CONCAT(descripcion,', old_image: ',@oldImage) from Constants where nombre = 'exito_update'
			set @error = 0

		END TRY
		BEGIN CATCH	

			set @info = ERROR_MESSAGE()
			set @error = 1

		END CATCH;

	end		

	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_U_Notificacion]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_U_Notificacion] 
		

	@idNotificacion uniqueidentifier,
	@estado int,
	@msgPers varchar(350),		
	@numDesc int,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;				
		
	
	BEGIN TRY  

		Update Notificacion set
		estado = case @estado when '' then 0 else @estado end,
		msgPersonalizado  = NULLIF(@msgPers, ''),
		numDesc = case @numDesc when '' then 0 else @numDesc end,
		fechaModificacion = GETDATE()
		Where idNotificacion = @idNotificacion
			
		Select @info = descripcion From Constants Where nombre = 'exito_update'
		set @error = 0

	END TRY
	BEGIN CATCH	

		set @info = ERROR_MESSAGE()
		set @error = 1

	END CATCH;	


	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_U_NotificacionByEstado]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_U_NotificacionByEstado] 
		
	@idNotificacion uniqueidentifier,
	@estado int,	

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;				
		
	
	BEGIN TRY  

		Update Notificacion set
		estado = case @estado when '' then 0 else @estado end,		
		fechaModificacion = GETDATE()
		Where idNotificacion = @idNotificacion
			
		Select @info = descripcion From Constants Where nombre = 'exito_update'
		set @error = 0

	END TRY
	BEGIN CATCH	

		set @info = ERROR_MESSAGE()
		set @error = 1

	END CATCH;	


	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_U_NovedadByEstado]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_U_NovedadByEstado] 

	@idNovedad uniqueidentifier,
	@idUsuario uniqueidentifier,
	@estado int,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;	

	declare @contIdN int = 0
	Select @contIdN = COUNT(*) from Novedad where idNovedad = @idNovedad and idUsuario = @idUsuario		
	
	
	if(@contIdN = 0)
	begin

		set @info = 'No se encontró el id de la novedad con ese usuario'
		set @error = 1

	end	
	else
	begin
		
		BEGIN TRY
						
			Update Novedad set 
			estado = case @estado when '' then 0 else @estado end,
			fechaModificacion = GETDATE()
			Where idNovedad = @idNovedad					
			
			Select @info = descripcion from Constants where nombre = 'exito_update'
			set @error = 0

		END TRY
		BEGIN CATCH	

			set @info = ERROR_MESSAGE()
			set @error = 1

		END CATCH;			

	end	

	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_U_Opcion]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_U_Opcion] 
	
	@idOpcion uniqueidentifier,
	@nombre varchar(150),
	@correcta int,	
	@valor int,
	@idPregunta uniqueidentifier,
	@idTipoEntrada uniqueidentifier,

	@error int output,
	@info varchar(max) output,
	@id varchar(max) output
AS
BEGIN		

	SET NOCOUNT ON;	
	Declare @contIdOpcion int = 0, @idReto uniqueidentifier, @auxIdTipoEntrada uniqueidentifier, @tipoReto varchar(50), @info_C_opcion varchar(max), @error_C_opcion int, @id_C_opcion varchar(max)
	Select @contIdOpcion = COUNT(*) From Opcion Where idOpcion = @idOpcion
	Select @idReto = idReto From Pregunta Where idPregunta = @idPregunta
	Select @auxIdTipoEntrada = idTipoEntrada from TipoEntrada where nombre = 'otro'	

	Select @tipoReto = tr.nombre
	From Reto r 
	Inner Join TipoReto tr on tr.idTipoReto = r.idTipoReto		
	where r.idReto = @idReto	

	if(@tipoReto <> 'Seguimiento o Evaluación')
	begin
		set @idTipoEntrada = @auxIdTipoEntrada
	end

	if(@contIdOpcion > 0)
	begin
		
		BEGIN TRY  
			Update Opcion set 
			nombre = NULLIF(@nombre, ''),
			correcta = case @correcta when '' then 0 else @correcta end,
			valor = case @valor when '' then 0 else @valor end,
			idTipoEntrada = @idTipoEntrada,
			fechaModificacion = GETDATE()
			where idOpcion = @idOpcion

			Select @info = descripcion From Constants Where nombre = 'exito_update'
			set @error = 0
			set @id = @idOpcion

		END TRY
		BEGIN CATCH	

			set @info = ERROR_MESSAGE()
			set @error = 1
			set @id = 0

		END CATCH;

		print @info
	end
	else
	begin
		
		exec sp_C_Opcion	
		@nombre = @nombre,	
		@correcta = @correcta,	
		@valor = @valor,
		@idPregunta = @idPregunta,	
		@idTipoEntrada = @idTipoEntrada,
		@info = @info_C_opcion output,
		@error = @error_C_opcion output,
		@id = @id_C_opcion output
		
		set @info = @info_C_opcion
		set @error = @error_C_opcion
		set @id = @id_C_opcion

	end		
	

END
GO
/****** Object:  StoredProcedure [dbo].[sp_U_Pais]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_U_Pais] 
		
	@idPais uniqueidentifier,
	@nombre varchar(65),
	@descripcion varchar(250),

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;				

	Declare @contNombre int = 0
	Select @contNombre = COUNT(*) From Pais Where nombre = @nombre and idPais <> @idPais
	
	if(@contNombre > 0)
	begin

		set @info = 'El nombre ya esta registrado'
		set @error = 1

	end
	else
	begin		
		
		BEGIN TRY  

			Update Pais set
			nombre = NULLIF(@nombre, ''),
			descripcion = NULLIF(@descripcion, ''),
			fechaModificacion = GETDATE()
			where idPais = @idPais
			
			Select @info = descripcion From Constants Where nombre = 'exito_update'
			set @error = 0

		END TRY
		BEGIN CATCH	

			set @info = ERROR_MESSAGE()
			set @error = 1

		END CATCH;	

	end	

	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_U_Pregunta]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_U_Pregunta] 
		
	@idPregunta uniqueidentifier,
	@nombre varchar(150),
	@idReto uniqueidentifier,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;			

	--Declare @contNombre int = 0
	--select @contNombre = COUNT(*) from Pregunta where idReto = @idReto and nombre = @nombre and idPregunta <> @idPregunta
		
	BEGIN TRY 

		Update Pregunta set 
		nombre = NULLIF(@nombre, ''),
		idReto = @idReto,
		fechaModificacion = GETDATE()
		where idPregunta = @idPregunta

		Select @info = descripcion From Constants Where nombre = 'exito_update'
		set @error = 0
		set @id = @idPregunta			

	END TRY
	BEGIN CATCH	

		set @info = ERROR_MESSAGE()
		set @error = 1
		set @id = 0

	END CATCH;

	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_U_Recompensa]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_U_Recompensa] 

	@idRecompensa uniqueidentifier,
	@idCategoria uniqueidentifier,
	@nombre varchar(60),
	@descripcion varchar(250),
	@imagen varchar(50),
	@cantDisp int,	
	@cantCanje int,	

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;			

	Declare @contNombre int = 0, @contIdRecompensa int = 0, @oldImage varchar(50) = 'N/A'
	Select @contNombre = COUNT(*) From Recompensa where nombre = @nombre and idRecompensa <> @idRecompensa	
	Select @contIdRecompensa = COUNT(*), @oldImage = ISNULL(imagen, 'N/A') From Recompensa where idRecompensa = @idRecompensa group by imagen	
	
	if(@contIdRecompensa = 0)
	begin
		
		set @info = 'No existe la recompensa'
		set @error = 1

	end else if(@contNombre > 0)
	begin

		set @info = 'El nombre ya esta registrado'
		set @error = 1

	end	
	else if (@cantCanje < 1)
	begin
		
		set @info = 'La cantidad de canje no debe ser menor a 1'
		set @error = 1

	end
	else
	begin
		
		BEGIN TRY  
			
			Update Recompensa set			
			nombre = NULLIF(@nombre, ''),
			idCategoria = @idCategoria,
			descripcion = NULLIF(@descripcion, ''),
			imagen = case @imagen when '' then imagen else @imagen end,
			cantDisponible = @cantDisp,
			cantCanje = @cantCanje,
			fechaModificacion = GETDATE()
			Where idRecompensa = @idRecompensa			

			Select @info = CONCAT(descripcion,', old_image: ',@oldImage) from Constants where nombre = 'exito_update'
			set @error = 0

		END TRY
		BEGIN CATCH	

			set @info = ERROR_MESSAGE()
			set @error = 1

		END CATCH;			

	end	

	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_U_RecompensaByEstado]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_U_RecompensaByEstado] 

	@idRecompensa uniqueidentifier,
	@estado int,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;	

	declare @contIdR int = 0
	Select @contIdR = COUNT(*) from Recompensa where idRecompensa = @idRecompensa
	
	if(@contIdR = 0)
	begin

		set @info = 'No se encontró el id de la recompensa'
		set @error = 1

	end	
	else
	begin
		
		BEGIN TRY  
						
			Update Recompensa set 
			estado = case @estado when '' then 0 else @estado end,
			fechaModificacion = GETDATE()
			Where idRecompensa = @idRecompensa
			
			Select @info = descripcion from Constants where nombre = 'exito_update'
			set @error = 0

		END TRY
		BEGIN CATCH	

			set @info = ERROR_MESSAGE()
			set @error = 1

		END CATCH;			

	end	

	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_U_Reto]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_U_Reto] 
		
	@idReto uniqueidentifier,
	@nombre varchar(40),
	@fechaApertura datetime,
	@fechaCierre datetime,
	@vidas int,
	@tiempo int,
	@puntosRecompensa int,
	@creditosObtenidos int,
	@criterioMin int,
	@instrucciones varchar(300),
	@imagen varchar(50),
	@idTipoReto uniqueidentifier,
	@idComportamiento uniqueidentifier,		
	@opsRequeridas int,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;				

	Declare @contNombre int = 0, @contIdReto int = 0, @oldImage varchar(50) = 'N/A', @tipoReto varchar(30) = '', @auxIdComportamiento uniqueidentifier

	Select @contNombre = COUNT(*) From Reto Where nombre = @nombre and idReto <> @idReto
	Select @tipoReto = nombre From tipoReto where idTipoReto = @idTipoReto
	Select @auxIdComportamiento = idComportamiento from ComportamientoPregunta where nombre = 'Normal'
	Select @contIdReto = COUNT(*), @oldImage = ISNULL(imagen, 'N/A') From Reto where idReto = @idReto group by imagen			
	
	
	if(@contNombre > 0)
	begin

		set @info = 'El nombre ya esta registrado'
		set @error = 1

	end
	else if(@vidas < 0 or @puntosRecompensa < 1 or @creditosObtenidos < 0 or @criterioMin < 1 or @tiempo < 300000)
	begin

		set @info = 'Incorrecto vidas, puntos de recompensa, créditos obtenidos, criterio mínimo o tiempo'
		set @error = 1

	end
	else if(@vidas > 10 or @puntosRecompensa > 1000 or @creditosObtenidos > 1000 or @criterioMin > 100 or @tiempo > 7200000)
	begin

		set @info = 'Incorrecto vidas, puntos de recompensa, créditos obtenidos, criterio mínimo o tiempo'
		set @error = 1

	end
	else if(@tipoReto = 'Trivia')  -- ******* SI ES TRIVIA ********************************************
	begin						
		
		BEGIN TRY  

			Update Reto set
			nombre =  NULLIF(@nombre, ''),
			fechaApetura = NULLIF(@fechaApertura, ''),
			fechaCierre = NULLIF(@fechaCierre, ''),
			vidas = case @vidas when '' then 0 else @vidas end,
			tiempo_ms = case @tiempo when '' then 0 else @tiempo end,
			puntosRecompensa = case @puntosRecompensa when '' then 0 else @puntosRecompensa end,
			creditosObtenidos = case @creditosObtenidos when '' then 0 else @creditosObtenidos end,			
			instrucciones = NULLIF(@instrucciones, ''),			
			criterioMinimo = case when @criterioMin = '' then 100 when @criterioMin < 1 then 100 else @criterioMin end,
			imagen = case @imagen when '' then imagen else @imagen end,				
			idComportamiento = @idComportamiento,
			fechaModificacion = GETDATE()
			Where idReto = @idReto

			Select @info = CONCAT(descripcion,', old_image: ',@oldImage) from Constants where nombre = 'exito_update'
			set @error = 0			

		END TRY
		BEGIN CATCH	

			set @info = ERROR_MESSAGE()
			set @error = 1

		END CATCH;			

	end
	else if(@tipoReto = 'Encuesta' or @tipoReto = 'Seguimiento o Evaluación' or @tipoReto = 'Recolección' or @tipoReto = 'Comportamiento') -- ******* SI ES ENCUESTA O SI ES SEGUIMIENTO O EVALUACIÓN  ********************************************
	begin
	
		BEGIN TRY  

			Update Reto set
			nombre =  NULLIF(@nombre, ''),
			fechaApetura = NULLIF(@fechaApertura, ''),
			fechaCierre = NULLIF(@fechaCierre, ''),		
			puntosRecompensa = case @puntosRecompensa when '' then 0 else @puntosRecompensa end,
			creditosObtenidos = case @creditosObtenidos when '' then 0 else @creditosObtenidos end,			
			instrucciones = NULLIF(@instrucciones, ''),			
			imagen = case @imagen when '' then imagen else @imagen end,			
			opsRequeridas = case @opsRequeridas when '' then 0 else @opsRequeridas end,			
			fechaModificacion = GETDATE()
			Where idReto = @idReto

			Select @info = CONCAT(descripcion,', old_image: ',@oldImage) from Constants where nombre = 'exito_update'
			set @error = 0				

		END TRY
		BEGIN CATCH	

			set @info = ERROR_MESSAGE()
			set @error = 1

		END CATCH;	

	end	
	else
	begin

		set @info = 'No se encontró el tipo de reto'
		set @error = 1

	end

	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_U_RetoByEstado]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_U_RetoByEstado] 

	@idReto uniqueidentifier,
	@estado int,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;	

	declare @contIdR int = 0, @contPreguntas int = 0, @contUR int = 0
	Select @contIdR = COUNT(*) from Reto where idReto = @idReto	
	Select @contPreguntas = COUNT(*) from Pregunta where idReto = @idReto
	Select @contUR = COUNT(*) from Usuario_Reto where idReto = @idReto
	
	if(@contIdR = 0)
	begin

		set @info = 'No se encontró el id del Reto'
		set @error = 1

	end	
	if(@contPreguntas < 5 and @estado > 0)
	begin

		set @info = 'El reto debe tener al menos 5 preguntas'
		set @error = 1

	end
	if(@contUR = 0 and @estado > 0)
	begin

		set @info = 'El reto debe tener asignado al menos a un usuario'
		set @error = 1

	end
	else
	begin
		
		BEGIN TRY  			
		
			Update Reto set 
			estado = case @estado when '' then 0 else @estado end,
			fechaModificacion = GETDATE()
			Where idReto = @idReto
			
			Select @info = descripcion from Constants where nombre = 'exito_update'
			set @error = 0

		END TRY
		BEGIN CATCH	

			set @info = ERROR_MESSAGE()
			set @error = 1

		END CATCH;			

	end	

	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_U_Usuario]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_U_Usuario] 

	@idUsuario uniqueidentifier,
	@nombre varchar(23),
	@apellido varchar(23),
	@correo varchar(60),
	@idU varchar(20), -- es la cédula o pasaporte, etc, etc
	@paisIso2 varchar(4),
	@paisCode varchar(5),
	@celular varchar(15),
	@foto varchar(50),
	@idRol varchar(9),
	@idCiudad varchar(40),
	@idArea varchar(40),
	@clave varbinary(max),

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;	

	declare @contIdU int = 0, @contCelular int = 0, @contCorreo int = 0, @contIdUs int = 0, @oldImage varchar(50) = 'N/A', @contRol int = 0, @auxIdRol varchar(9)	
	Select @contIdU = COUNT(*), @oldImage = ISNULL(foto, 'N/A') from Usuario where idUsuario = @idUsuario group by foto	
	Select @contCorreo = COUNT(*) from Usuario where correo = @correo and idUsuario <> @idUsuario
	Select @contCelular = COUNT(*) from Usuario where celular = @celular and idUsuario <> @idUsuario
	Select @contIdUs = COUNT(*) from Usuario where id = @idU and idUsuario <> @idUsuario

	Select @contRol = COUNT(*) from Usuario where idRol = 'adm' or idRol = 'sadm' 
	Select @auxIdRol = idRol from Usuario  where idUsuario = @idUsuario	

	if(@celular = '')
	begin
		set @celular = null
	end

	
	if(@contIdU = 0)
	begin

		set @info = 'No se encontró el id del usuario'
		set @error = 1

	end else if(@contCorreo > 0)
	begin

		set @info = 'El correo electrónico ya esta registrado'
		set @error = 1

	end
	else if(@contIdUs > 0)
	begin 

		set @info = 'El id único ya esta registrado'
		set @error = 1

	end
	else if(@contCelular > 0)
	begin 

		set @info = 'El celular ya esta registrado'
		set @error = 1

	end	
	else if ((@auxIdRol = 'adm' or @auxIdRol = 'sadm') and @idRol = 'jug' and @contRol < 2)
	begin

		set @info = 'No hay como cambiar el rol del usuario porque solo existe un Administrador'
		set @error = 1		

	end
	else
	begin
		
		BEGIN TRY  
						
			Update Usuario set 
			nombre = NULLIF(@nombre, ''),
			apellido = NULLIF(@apellido, ''),
			correo =  NULLIF(@correo, ''),
			id = NULLIF(@idU, ''), -- es la cédula o pasaporte, etc, etc
			paisIso2 = Case when @celular is not null then NULLIF(@paisIso2, '') else null end,
			paisCode = Case when @celular is not null then NULLIF(@paisCode, '') else null end,			
			celular = NULLIF(@celular, ''),			
			foto = case @foto when '' then foto else @foto end,
			idRol = NULLIF(@idRol, ''),
			idCiudad = case @idCiudad when '' then null else CONVERT(uniqueidentifier, @idCiudad) end, --NULLIF(@idCiudad, ''),
			idArea = case @idArea when '' then null else CONVERT(uniqueidentifier, @idArea) end, --NULLIF(@idArea, ''),			
			clave = case @clave when 0x then clave else @clave end,
			fechaModificacion = GETDATE()
			Where idUsuario = @idUsuario					
			
			Select @info = CONCAT(descripcion,', old_image: ',@oldImage) from Constants where nombre = 'exito_update'
			set @error = 0

		END TRY
		BEGIN CATCH	

			set @info = ERROR_MESSAGE()
			set @error = 1

		END CATCH;			

	end	

	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_U_Usuario_Reto]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_U_Usuario_Reto] 

	@idUsuario uniqueidentifier,
	@idReto uniqueidentifier,
	@puntos int,
	@tiempo int,
	@vidas int,	
	@completado int,
	@correctas int,
	@incorrectas int,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output

AS
BEGIN

	SET NOCOUNT ON;			

	Declare @contUsuarioReto int = 0, @idTipoReto uniqueidentifier, @idTipoValidador uniqueidentifier, @tipoReto varchar(50), @tipoValidador varchar(30), @auxPuntos int = 0

	Select @contUsuarioReto = COUNT(*) from Usuario_Reto where idReto = @idReto and idUsuario = @idUsuario and validador = 0 and (completado = 0 or completado = 2)
	Select @idTipoReto = idTipoReto, @auxPuntos = puntosRecompensa, @idTipoValidador = idTipoValidador  from Reto where idReto = @idReto
	Select @tipoReto = nombre from TipoReto where idTipoReto = @idTipoReto	
	Select @tipoValidador = nombre from TipoValidador where idTipoValidador = @idTipoValidador		

	if(@tipoReto != 'Trivia' and @tipoValidador = 'Automático')
	begin
		set @puntos = 1
		set @completado = 1
	end
	
	if(@tipoReto != 'Trivia' and @completado = 1 and @puntos > 0)
	begin
		set @puntos = @auxPuntos		
	end	


	if(@contUsuarioReto = 0)
	begin
	
		Select @info = descripcion from Constants where nombre = 'no_encontrar'
		set @error = 1

	end
	else
	begin

		BEGIN TRY
		
			Update Usuario_Reto set
			puntos = case @puntos when '' then 0 else @puntos end,
			tiempo = case @tiempo when '' then 0 else @tiempo end,
			vidas = case @vidas when '' then 0 else @vidas end,
			completado = case @completado when '' then 0 else @completado end,
			correctas = case @correctas when '' then 0 else @correctas end,
			incorrectas = case @incorrectas when '' then 0 else @incorrectas end,
			fechaModificacion = GETDATE()
			Where idReto = @idReto and idUsuario = @idUsuario and validador = 0		
		
			Select @info = descripcion from Constants where nombre = 'exito_update'
			set @error = 0

		END TRY
		BEGIN CATCH	

			set @info = ERROR_MESSAGE()
			set @error = 1

		END CATCH;	
	end

	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_U_UsuarioByEstado]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_U_UsuarioByEstado] 

	@idUsuario uniqueidentifier,
	@estado int,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;	

	declare @contIdU int = 0, @contRol int = 0, @idRol varchar(9)
	Select @contIdU = COUNT(*) from Usuario where idUsuario = @idUsuario	
	Select @contRol = COUNT(*) from Usuario where idRol = 'adm' or idRol = 'sadm' 
	Select @idRol = idRol from Usuario  where idUsuario = @idUsuario	
	
	if(@contIdU = 0)
	begin

		set @info = 'No se encontró el id del usuario'
		set @error = 1

	end
	else if((@idRol = 'adm' or @idRol = 'sadm') and @estado = 0 and @contRol < 2)
	begin

		set @info = 'No hay como desactivar el usuario porque solo existe un Administrador'
		set @error = 1		

	end
	else
	begin
		
		BEGIN TRY  
						
			Update Usuario set 
			estado = case @estado when '' then 0 else @estado end,
			fechaModificacion = GETDATE()
			Where idUsuario = @idUsuario					
			
			Select @info = descripcion from Constants where nombre = 'exito_update'
			set @error = 0

		END TRY
		BEGIN CATCH	

			set @info = ERROR_MESSAGE()
			set @error = 1

		END CATCH;			

	end	

	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_U_UsuarioByFoto]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_U_UsuarioByFoto] 

	@idUsuario uniqueidentifier,	
	@foto varchar(50),	

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;	

	declare @contIdU int = 0, @oldImage varchar(50) = 'N/A'	
	Select @contIdU = COUNT(*), @oldImage = ISNULL(foto, 'N/A') from Usuario where idUsuario = @idUsuario group by foto	
	
	if(@contIdU = 0)
	begin

		set @info = 'No se encontró de usuario'
		set @error = 1

	end	
	else
	begin
		
		BEGIN TRY  
						
			Update Usuario set
			foto = case @foto when '' then foto else @foto end,			
			fechaModificacion = GETDATE()
			Where idUsuario = @idUsuario					
			
			Select @info = CONCAT(descripcion,', old_image: ',@oldImage) from Constants where nombre = 'exito_update'
			set @error = 0

		END TRY
		BEGIN CATCH	

			set @info = ERROR_MESSAGE()
			set @error = 1

		END CATCH;			

	end	

	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_U_UsuarioEstadoByCorreoIds]    Script Date: 04/07/2024 9:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_U_UsuarioEstadoByCorreoIds] 

	@correo_id varchar(99),
	@estado int,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;		

	Declare @contRol int = 0, @idRol varchar(9), @contCorreo int = 0, @contId int = 0, @idUsuario uniqueidentifier
	
	Select @contCorreo = COUNT(*), @idRol  = idRol, @idUsuario = idUsuario from Usuario where correo = @correo_id  group by idRol, idUsuario	
	Select @contId = COUNT(*), @idRol = idRol, @idUsuario = idUsuario from Usuario where id = @correo_id group by idRol, idUsuario	
	Select @contRol = COUNT(*) from Usuario where idRol = 'adm' or idRol = 'sadm' 	

	
	if(@contCorreo = 0 and @contId = 0)
	begin

		set @info = 'No se encontró el correo o el id único del usuario'
		set @id = @correo_id
		set @error = 1

	end
	else if((@idRol = 'adm' or @idRol = 'sadm') and @estado = 0 and @contRol < 2)
	begin

		set @info = 'No hay como desactivar el usuario porque solo existe un Administrador'
		set @id = @correo_id
		set @error = 1		

	end
	else
	begin
		
		BEGIN TRY  
						
			Update Usuario set 
			estado = case @estado when '' then 0 else @estado end,
			fechaModificacion = GETDATE()
			Where idUsuario = @idUsuario					
			
			Select @info = descripcion from Constants where nombre = 'exito_update'
			set @id = @correo_id
			set @error = 0

		END TRY
		BEGIN CATCH	

			set @info = ERROR_MESSAGE()
			set @id = @correo_id
			set @error = 1

		END CATCH;			

	end	

	print @info

END
GO

USE [Evolution_db]
GO
/****** Object:  Table [dbo].[Area]    Script Date: 26/04/2024 9:36:50 ******/
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
/****** Object:  Table [dbo].[CategoriaNoticia]    Script Date: 26/04/2024 9:36:50 ******/
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
/****** Object:  Table [dbo].[CategoriaRecompensa]    Script Date: 26/04/2024 9:36:50 ******/
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
/****** Object:  Table [dbo].[Ciudad]    Script Date: 26/04/2024 9:36:50 ******/
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
/****** Object:  Table [dbo].[ComportamientoPregunta]    Script Date: 26/04/2024 9:36:50 ******/
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
/****** Object:  Table [dbo].[Condicion]    Script Date: 26/04/2024 9:36:50 ******/
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
/****** Object:  Table [dbo].[Configuracion]    Script Date: 26/04/2024 9:36:50 ******/
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
/****** Object:  Table [dbo].[Constants]    Script Date: 26/04/2024 9:36:50 ******/
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
/****** Object:  Table [dbo].[CorreoEnvio]    Script Date: 26/04/2024 9:36:50 ******/
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
PRIMARY KEY CLUSTERED 
(
	[idCorreo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Empresa]    Script Date: 26/04/2024 9:36:50 ******/
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
/****** Object:  Table [dbo].[Equipo]    Script Date: 26/04/2024 9:36:50 ******/
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
/****** Object:  Table [dbo].[Inicio]    Script Date: 26/04/2024 9:36:50 ******/
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
/****** Object:  Table [dbo].[Licencia]    Script Date: 26/04/2024 9:36:50 ******/
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
/****** Object:  Table [dbo].[Medalla]    Script Date: 26/04/2024 9:36:50 ******/
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
/****** Object:  Table [dbo].[Nivel]    Script Date: 26/04/2024 9:36:50 ******/
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
/****** Object:  Table [dbo].[Noticia]    Script Date: 26/04/2024 9:36:50 ******/
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
/****** Object:  Table [dbo].[Notificacion]    Script Date: 26/04/2024 9:36:50 ******/
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
/****** Object:  Table [dbo].[Opcion]    Script Date: 26/04/2024 9:36:50 ******/
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
PRIMARY KEY CLUSTERED 
(
	[idOpcion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pais]    Script Date: 26/04/2024 9:36:50 ******/
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
/****** Object:  Table [dbo].[Pregunta]    Script Date: 26/04/2024 9:36:50 ******/
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
/****** Object:  Table [dbo].[Puzzle]    Script Date: 26/04/2024 9:36:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Puzzle](
	[idPuzzle] [uniqueidentifier] NOT NULL,
	[imagen] [varchar](50) NOT NULL,
	[descripcion] [varchar](250) NULL,
	[idReto] [uniqueidentifier] NOT NULL,
	[fechaCreacion] [datetime] NULL,
	[fechaModificacion] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[idPuzzle] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Recompensa]    Script Date: 26/04/2024 9:36:50 ******/
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
/****** Object:  Table [dbo].[RedSocial]    Script Date: 26/04/2024 9:36:50 ******/
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
/****** Object:  Table [dbo].[Reto]    Script Date: 26/04/2024 9:36:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reto](
	[idReto] [uniqueidentifier] NOT NULL,
	[nombre] [varchar](30) NOT NULL,
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
PRIMARY KEY CLUSTERED 
(
	[idReto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Rol]    Script Date: 26/04/2024 9:36:50 ******/
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
/****** Object:  Table [dbo].[tipoReto]    Script Date: 26/04/2024 9:36:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tipoReto](
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
/****** Object:  Table [dbo].[Usuario]    Script Date: 26/04/2024 9:36:50 ******/
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
PRIMARY KEY CLUSTERED 
(
	[idUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuario_Equipo]    Script Date: 26/04/2024 9:36:50 ******/
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
/****** Object:  Table [dbo].[Usuario_Medalla]    Script Date: 26/04/2024 9:36:50 ******/
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
/****** Object:  Table [dbo].[Usuario_Nivel]    Script Date: 26/04/2024 9:36:50 ******/
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
/****** Object:  Table [dbo].[Usuario_Noticia]    Script Date: 26/04/2024 9:36:50 ******/
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
/****** Object:  Table [dbo].[Usuario_Recompensa]    Script Date: 26/04/2024 9:36:50 ******/
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
/****** Object:  Table [dbo].[Usuario_RedSocial]    Script Date: 26/04/2024 9:36:50 ******/
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
/****** Object:  Table [dbo].[Usuario_Reto]    Script Date: 26/04/2024 9:36:50 ******/
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
	[tieneEquipo] [int] NOT NULL
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
INSERT [dbo].[CorreoEnvio] ([idCorreo], [correo], [clave], [puerto], [host], [fechaCreacion], [fechaModificacion]) VALUES (N'45333b41-0022-42e3-8f26-164f5d157eb1', N'bcedeno@digimentore.com.ec', 0x7B2243697068657254657874223A22426D754C477466497879796A4C4C445A5239647667513D3D222C224956223A226F4C45677246584957506C474F5365366A68487555413D3D227D, 587, N'smtp.office365.com', CAST(N'2024-04-01T15:10:41.227' AS DateTime), CAST(N'2024-04-01T15:10:41.227' AS DateTime))
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
INSERT [dbo].[Inicio] ([idInicio], [nombre], [indice], [estado], [color], [idRol], [fechaCreacion], [fechaModificacion]) VALUES (N'568740a5-6764-4e15-8cbf-1618245445c1', N'Ranking por puntos', 4, 1, NULL, N'adm', CAST(N'2024-03-14T09:55:44.817' AS DateTime), CAST(N'2024-04-25T15:47:20.630' AS DateTime))
GO
INSERT [dbo].[Inicio] ([idInicio], [nombre], [indice], [estado], [color], [idRol], [fechaCreacion], [fechaModificacion]) VALUES (N'd419d4fa-eef6-4d4d-b1e8-16f7f0e76cdd', N'Puntos de experiencia', 5, 1, NULL, N'adm', CAST(N'2024-03-14T15:14:11.513' AS DateTime), CAST(N'2024-04-25T15:47:20.630' AS DateTime))
GO
INSERT [dbo].[Inicio] ([idInicio], [nombre], [indice], [estado], [color], [idRol], [fechaCreacion], [fechaModificacion]) VALUES (N'727a9ae6-b5f6-4a08-af68-1876aff92e0c', N'Usuarios más activos', 6, 1, NULL, N'adm', CAST(N'2024-04-03T17:48:45.890' AS DateTime), CAST(N'2024-04-25T15:47:20.630' AS DateTime))
GO
INSERT [dbo].[Inicio] ([idInicio], [nombre], [indice], [estado], [color], [idRol], [fechaCreacion], [fechaModificacion]) VALUES (N'65058300-b83d-4028-8732-24a978706e43', N'Retos completados', 10, 1, NULL, N'jug', CAST(N'2024-04-09T17:53:22.017' AS DateTime), CAST(N'2024-04-25T15:47:14.403' AS DateTime))
GO
INSERT [dbo].[Inicio] ([idInicio], [nombre], [indice], [estado], [color], [idRol], [fechaCreacion], [fechaModificacion]) VALUES (N'c23647f1-0975-43c7-9635-27c96899a288', N'Mis retos pendientes', 2, 1, NULL, N'jug', CAST(N'2024-04-09T17:53:22.013' AS DateTime), CAST(N'2024-04-25T15:47:14.400' AS DateTime))
GO
INSERT [dbo].[Inicio] ([idInicio], [nombre], [indice], [estado], [color], [idRol], [fechaCreacion], [fechaModificacion]) VALUES (N'03dff04a-5eec-4fbe-9432-3f4bc400cbef', N'Ranking por equipos', 8, 1, NULL, N'adm', CAST(N'2024-04-25T15:47:20.630' AS DateTime), CAST(N'2024-04-25T15:47:20.630' AS DateTime))
GO
INSERT [dbo].[Inicio] ([idInicio], [nombre], [indice], [estado], [color], [idRol], [fechaCreacion], [fechaModificacion]) VALUES (N'622bbb0e-5e21-4f80-a64c-41dff7a7ca47', N'Mis medallas', 3, 1, NULL, N'jug', CAST(N'2024-03-13T15:52:11.040' AS DateTime), CAST(N'2024-04-25T15:47:14.400' AS DateTime))
GO
INSERT [dbo].[Inicio] ([idInicio], [nombre], [indice], [estado], [color], [idRol], [fechaCreacion], [fechaModificacion]) VALUES (N'ed8f54e1-c1e6-4192-993b-48b57653d3fa', N'Usuarios más activos', 6, 1, NULL, N'jug', CAST(N'2024-04-09T17:53:22.017' AS DateTime), CAST(N'2024-04-25T15:47:14.400' AS DateTime))
GO
INSERT [dbo].[Inicio] ([idInicio], [nombre], [indice], [estado], [color], [idRol], [fechaCreacion], [fechaModificacion]) VALUES (N'3fb69c62-d3d2-46ed-bb10-54342a55bfe1', N'Noticias', 2, 1, NULL, N'adm', CAST(N'2024-03-13T16:41:09.810' AS DateTime), CAST(N'2024-04-25T15:47:20.630' AS DateTime))
GO
INSERT [dbo].[Inicio] ([idInicio], [nombre], [indice], [estado], [color], [idRol], [fechaCreacion], [fechaModificacion]) VALUES (N'ff17bf8f-837b-4247-9439-6907c11023b5', N'Resumen general', 1, 1, NULL, N'adm', CAST(N'2024-03-13T15:51:50.023' AS DateTime), CAST(N'2024-04-25T15:47:20.627' AS DateTime))
GO
INSERT [dbo].[Inicio] ([idInicio], [nombre], [indice], [estado], [color], [idRol], [fechaCreacion], [fechaModificacion]) VALUES (N'e1364975-2ef7-410d-abdc-6e991b407e18', N'Recompensas más reclamadas', 3, 1, NULL, N'adm', CAST(N'2024-03-14T09:23:21.610' AS DateTime), CAST(N'2024-04-25T15:47:20.630' AS DateTime))
GO
INSERT [dbo].[Inicio] ([idInicio], [nombre], [indice], [estado], [color], [idRol], [fechaCreacion], [fechaModificacion]) VALUES (N'e08dabb8-788a-439e-8075-75ab690d3255', N'Ranking por puntos', 5, 1, NULL, N'jug', CAST(N'2024-03-14T10:34:55.687' AS DateTime), CAST(N'2024-04-25T15:47:14.400' AS DateTime))
GO
INSERT [dbo].[Inicio] ([idInicio], [nombre], [indice], [estado], [color], [idRol], [fechaCreacion], [fechaModificacion]) VALUES (N'6d38188b-5c5b-4c6d-8cb8-806d93f5f5ab', N'Noticias', 8, 1, NULL, N'jug', CAST(N'2024-03-13T17:06:32.073' AS DateTime), CAST(N'2024-04-25T15:47:14.403' AS DateTime))
GO
INSERT [dbo].[Inicio] ([idInicio], [nombre], [indice], [estado], [color], [idRol], [fechaCreacion], [fechaModificacion]) VALUES (N'3e346378-31f6-4758-9c9a-8ab25fc61aba', N'Mi evolución', 4, 1, NULL, N'jug', CAST(N'2024-03-14T16:07:19.493' AS DateTime), CAST(N'2024-04-25T15:47:14.400' AS DateTime))
GO
INSERT [dbo].[Inicio] ([idInicio], [nombre], [indice], [estado], [color], [idRol], [fechaCreacion], [fechaModificacion]) VALUES (N'72751bda-5e5c-488e-8fd9-9f9b7a409607', N'Nivel de Experiencia', 1, 1, NULL, N'jug', CAST(N'2024-03-28T16:13:50.657' AS DateTime), CAST(N'2024-04-25T15:47:14.397' AS DateTime))
GO
INSERT [dbo].[Inicio] ([idInicio], [nombre], [indice], [estado], [color], [idRol], [fechaCreacion], [fechaModificacion]) VALUES (N'4807188d-02ce-4a4f-8a49-ca851f698b6b', N'Resumen general', 9, 1, NULL, N'jug', CAST(N'2024-03-14T17:14:37.477' AS DateTime), CAST(N'2024-04-25T15:47:14.403' AS DateTime))
GO
INSERT [dbo].[Inicio] ([idInicio], [nombre], [indice], [estado], [color], [idRol], [fechaCreacion], [fechaModificacion]) VALUES (N'be6d44ba-fdea-42b9-8d83-ed03eb81742c', N'Uso del plan', 7, 1, NULL, N'adm', CAST(N'2024-04-03T17:50:45.917' AS DateTime), CAST(N'2024-04-25T15:47:20.630' AS DateTime))
GO
INSERT [dbo].[Inicio] ([idInicio], [nombre], [indice], [estado], [color], [idRol], [fechaCreacion], [fechaModificacion]) VALUES (N'5fcb6814-6f71-4e8d-b0ee-f22a08c71632', N'Ranking por equipos', 7, 1, NULL, N'jug', CAST(N'2024-04-25T15:47:14.403' AS DateTime), CAST(N'2024-04-25T15:47:14.403' AS DateTime))
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
INSERT [dbo].[Notificacion] ([idNotificacion], [nombre], [estado], [msgPersonalizado], [descripcion], [numDesc], [enviarCorreo], [fechaCreacion], [fechaModificacion]) VALUES (N'69614aed-fc82-4eb0-91bd-1463cf6d75fc', N'Notificar a los usuarios cuando el reto esta por cerrarse', 0, N'prueba', N'Días restantes', 23, 1, CAST(N'2024-03-22T11:19:08.290' AS DateTime), CAST(N'2024-04-02T13:16:31.050' AS DateTime))
GO
INSERT [dbo].[Notificacion] ([idNotificacion], [nombre], [estado], [msgPersonalizado], [descripcion], [numDesc], [enviarCorreo], [fechaCreacion], [fechaModificacion]) VALUES (N'f8f1f0cd-7338-473d-b75a-2256a0924d84', N'Notificar a los usuarios cuando suben de nivel', 0, NULL, NULL, 0, 1, CAST(N'2024-03-22T11:19:08.290' AS DateTime), CAST(N'2024-03-22T16:23:35.133' AS DateTime))
GO
INSERT [dbo].[Notificacion] ([idNotificacion], [nombre], [estado], [msgPersonalizado], [descripcion], [numDesc], [enviarCorreo], [fechaCreacion], [fechaModificacion]) VALUES (N'531a630d-b453-4bd4-8fdd-35bee0a14a55', N'Notificar a los usuarios cuando se les agregaron a un reto', 1, NULL, NULL, 0, 1, CAST(N'2024-03-22T11:19:08.290' AS DateTime), CAST(N'2024-03-22T16:00:21.480' AS DateTime))
GO
INSERT [dbo].[Notificacion] ([idNotificacion], [nombre], [estado], [msgPersonalizado], [descripcion], [numDesc], [enviarCorreo], [fechaCreacion], [fechaModificacion]) VALUES (N'dd651785-32f9-431d-9883-3f475ace85aa', N'Notificar a los usuarios cuando este entre 10 primeros puestos del ranking', 0, NULL, NULL, 0, 1, CAST(N'2024-03-22T11:19:08.290' AS DateTime), CAST(N'2024-03-22T11:19:08.290' AS DateTime))
GO
INSERT [dbo].[Notificacion] ([idNotificacion], [nombre], [estado], [msgPersonalizado], [descripcion], [numDesc], [enviarCorreo], [fechaCreacion], [fechaModificacion]) VALUES (N'ce927ad8-342f-4d2b-b863-456c7756976c', N'Notificar a los usuarios cuando reciben una reacción en la red social', 0, NULL, NULL, 0, 0, CAST(N'2024-03-22T11:19:08.290' AS DateTime), CAST(N'2024-03-22T14:40:04.943' AS DateTime))
GO
INSERT [dbo].[Notificacion] ([idNotificacion], [nombre], [estado], [msgPersonalizado], [descripcion], [numDesc], [enviarCorreo], [fechaCreacion], [fechaModificacion]) VALUES (N'd31eba8e-985d-47c6-b6e0-4ea9739adc49', N'Notificar a los usuarios cuando ganan una medalla', 0, NULL, NULL, 0, 1, CAST(N'2024-03-22T11:19:08.290' AS DateTime), CAST(N'2024-03-22T11:19:08.290' AS DateTime))
GO
INSERT [dbo].[Notificacion] ([idNotificacion], [nombre], [estado], [msgPersonalizado], [descripcion], [numDesc], [enviarCorreo], [fechaCreacion], [fechaModificacion]) VALUES (N'00321384-1c44-4a73-8202-9f3cfba40582', N'Notificar a los usuarios cuando el administrador crea un nuevo usuario', 0, NULL, NULL, 0, 1, CAST(N'2024-03-22T11:19:08.290' AS DateTime), CAST(N'2024-03-22T15:51:41.960' AS DateTime))
GO
INSERT [dbo].[Notificacion] ([idNotificacion], [nombre], [estado], [msgPersonalizado], [descripcion], [numDesc], [enviarCorreo], [fechaCreacion], [fechaModificacion]) VALUES (N'1115961e-3ba2-482e-b664-a6547a4ed198', N'Notificar a los usuarios cuando canjean una recompensa', 1, N'Este es el mensaje del administrador', NULL, 0, 1, CAST(N'2024-03-22T11:19:08.290' AS DateTime), CAST(N'2024-04-23T12:35:42.497' AS DateTime))
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion]) VALUES (N'8f422900-4874-4e70-a2db-0ddc1bfd9d8b', N'Interfaz de programación de aplicaciones', 0, 1, N'43c4c9c4-b885-4bc4-83cb-1e3a257c3530', CAST(N'2024-02-27T16:55:53.443' AS DateTime), CAST(N'2024-02-27T16:55:53.443' AS DateTime))
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion]) VALUES (N'848dfb3c-c8f8-4322-a5e2-11f6cf0089b2', N'Interfaz de programación de aplicaciones', 1, 1, N'5089e889-89ff-4ca9-a614-9fe5d0567487', CAST(N'2024-02-27T16:56:20.283' AS DateTime), CAST(N'2024-02-27T16:56:20.283' AS DateTime))
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion]) VALUES (N'65bbda02-11c9-438d-81d7-120b2b34b369', N'Transferencia de estado representacional', 0, 1, N'5089e889-89ff-4ca9-a614-9fe5d0567487', CAST(N'2024-02-27T16:56:20.283' AS DateTime), CAST(N'2024-02-27T16:56:20.283' AS DateTime))
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion]) VALUES (N'1f7c8d9d-afe0-43f4-951a-d352b6727fa1', N'Transferencia de estado representacional', 1, 1, N'43c4c9c4-b885-4bc4-83cb-1e3a257c3530', CAST(N'2024-02-27T16:55:53.440' AS DateTime), CAST(N'2024-02-27T16:55:53.440' AS DateTime))
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion]) VALUES (N'e3330812-529e-461a-ab0b-e7e843a03a66', N'Falso', 1, 1, N'024fc029-063b-4179-ad7d-82fb599ac9ef', CAST(N'2024-02-28T09:35:18.063' AS DateTime), CAST(N'2024-02-28T09:35:18.063' AS DateTime))
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion]) VALUES (N'34768314-024a-4c34-ad26-f84ccdfc534e', N'Verdadero', 0, 1, N'024fc029-063b-4179-ad7d-82fb599ac9ef', CAST(N'2024-02-28T09:35:18.063' AS DateTime), CAST(N'2024-02-28T09:35:18.063' AS DateTime))
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
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'43c4c9c4-b885-4bc4-83cb-1e3a257c3530', N'¿Que significa REST?', 1, N'27c5527f-3ea3-431b-bedf-65841eaf5663', CAST(N'2024-02-27T16:55:53.433' AS DateTime), CAST(N'2024-02-27T16:55:53.433' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'024fc029-063b-4179-ad7d-82fb599ac9ef', N'¿React js es un framework?', 1, N'27c5527f-3ea3-431b-bedf-65841eaf5663', CAST(N'2024-02-28T09:35:18.057' AS DateTime), CAST(N'2024-02-28T09:35:18.057' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'5089e889-89ff-4ca9-a614-9fe5d0567487', N'¿Que significa API?', 1, N'27c5527f-3ea3-431b-bedf-65841eaf5663', CAST(N'2024-02-27T16:56:20.277' AS DateTime), CAST(N'2024-02-27T16:56:20.277' AS DateTime))
GO
INSERT [dbo].[Recompensa] ([idRecompensa], [nombre], [descripcion], [imagen], [cantDisponible], [cantCanje], [estado], [fechaCreacion], [fechaModificacion], [idCategoria]) VALUES (N'40853d25-1a7a-416a-a9ca-32c3f2c53814', N'mi recompensa', N'desc 1', NULL, 16, 10, 1, CAST(N'2024-04-16T14:49:23.880' AS DateTime), CAST(N'2024-04-16T14:51:49.697' AS DateTime), N'ee6ca0ed-f5e2-4640-aaf4-76d11c9762b2')
GO
INSERT [dbo].[Recompensa] ([idRecompensa], [nombre], [descripcion], [imagen], [cantDisponible], [cantCanje], [estado], [fechaCreacion], [fechaModificacion], [idCategoria]) VALUES (N'4d6da0f1-01a5-4efc-9ca3-4fd6a5130a11', N'Tarjeta supermaxi', N'Descripcion 1', NULL, 10, 40, 0, CAST(N'2024-03-12T17:04:26.230' AS DateTime), CAST(N'2024-04-16T14:52:05.287' AS DateTime), N'11283d21-ea6e-4945-9c59-a8868416016f')
GO
INSERT [dbo].[Recompensa] ([idRecompensa], [nombre], [descripcion], [imagen], [cantDisponible], [cantCanje], [estado], [fechaCreacion], [fechaModificacion], [idCategoria]) VALUES (N'56d57b18-2afe-46a9-822b-9540eb4f8e6a', N'Tomatodo personalizado', NULL, NULL, 47, 10, 1, CAST(N'2023-12-12T12:34:34.027' AS DateTime), CAST(N'2023-12-12T12:34:34.027' AS DateTime), N'11283d21-ea6e-4945-9c59-a8868416016f')
GO
INSERT [dbo].[Recompensa] ([idRecompensa], [nombre], [descripcion], [imagen], [cantDisponible], [cantCanje], [estado], [fechaCreacion], [fechaModificacion], [idCategoria]) VALUES (N'91f482c6-59a5-450f-a09a-9c745b861339', N'10 entradas al cine', NULL, N'entradas-cine.jpg', 8, 5, 1, CAST(N'2023-12-12T12:58:13.280' AS DateTime), CAST(N'2024-02-01T12:55:24.320' AS DateTime), N'11283d21-ea6e-4945-9c59-a8868416016f')
GO
INSERT [dbo].[Recompensa] ([idRecompensa], [nombre], [descripcion], [imagen], [cantDisponible], [cantCanje], [estado], [fechaCreacion], [fechaModificacion], [idCategoria]) VALUES (N'2517e519-acf6-42d4-90a7-df589bff4987', N'Reloj Apple Watch series 9', N'Color Midnight', N'apple watch series 9.PNG', 9, 100, 1, CAST(N'2024-02-01T12:57:47.847' AS DateTime), CAST(N'2024-02-01T12:57:47.847' AS DateTime), N'11283d21-ea6e-4945-9c59-a8868416016f')
GO
INSERT [dbo].[Recompensa] ([idRecompensa], [nombre], [descripcion], [imagen], [cantDisponible], [cantCanje], [estado], [fechaCreacion], [fechaModificacion], [idCategoria]) VALUES (N'3c18891d-48f7-44b1-9de9-e9eb833cee23', N'Bicicleta', N'Descripcion2', NULL, 2, 1000, 1, CAST(N'2024-03-12T17:04:26.230' AS DateTime), CAST(N'2024-04-16T14:52:16.870' AS DateTime), N'11283d21-ea6e-4945-9c59-a8868416016f')
GO
INSERT [dbo].[RedSocial] ([idRed], [descripcion], [imagen], [estado], [fechaPublicacion], [fechaCreacion], [fechaModificacion]) VALUES (N'9c76ea2c-549e-4bda-890c-1b26a4175200', N'AB37197C-BF33-44B8-BA5D-E246FA250B41|ha conseguido una recompensa,|91F482C6-59A5-450F-A09A-9C745B861339|Recompensa', N'entradas-cine.jpg', 1, CAST(N'2024-04-17T12:49:36.603' AS DateTime), CAST(N'2024-04-17T12:49:36.603' AS DateTime), CAST(N'2024-04-17T12:49:36.603' AS DateTime))
GO
INSERT [dbo].[RedSocial] ([idRed], [descripcion], [imagen], [estado], [fechaPublicacion], [fechaCreacion], [fechaModificacion]) VALUES (N'7e9ba644-ad66-4eb5-83bd-1cf06d922928', N'AB37197C-BF33-44B8-BA5D-E246FA250B41|ha conseguido una recompensa,|91F482C6-59A5-450F-A09A-9C745B861339|Recompensa', N'entradas-cine.jpg', 1, CAST(N'2024-04-17T12:43:02.697' AS DateTime), CAST(N'2024-04-17T12:43:02.697' AS DateTime), CAST(N'2024-04-17T12:43:02.697' AS DateTime))
GO
INSERT [dbo].[RedSocial] ([idRed], [descripcion], [imagen], [estado], [fechaPublicacion], [fechaCreacion], [fechaModificacion]) VALUES (N'a8c40b1b-69e1-47e2-9535-1dca08b468c2', N'AB37197C-BF33-44B8-BA5D-E246FA250B41|ha conseguido una recompensa,|91F482C6-59A5-450F-A09A-9C745B861339|Recompensa', N'entradas-cine.jpg', 1, CAST(N'2024-04-09T18:22:47.587' AS DateTime), CAST(N'2024-04-09T18:22:47.590' AS DateTime), CAST(N'2024-04-09T18:22:47.590' AS DateTime))
GO
INSERT [dbo].[RedSocial] ([idRed], [descripcion], [imagen], [estado], [fechaPublicacion], [fechaCreacion], [fechaModificacion]) VALUES (N'ce77c446-0fb5-4bae-ab40-2fdc754f8119', N'AB37197C-BF33-44B8-BA5D-E246FA250B41|ha conseguido una recompensa,|40853D25-1A7A-416A-A9CA-32C3F2C53814|Recompensa', NULL, 1, CAST(N'2024-04-17T12:42:48.427' AS DateTime), CAST(N'2024-04-17T12:42:48.427' AS DateTime), CAST(N'2024-04-17T12:42:48.427' AS DateTime))
GO
INSERT [dbo].[RedSocial] ([idRed], [descripcion], [imagen], [estado], [fechaPublicacion], [fechaCreacion], [fechaModificacion]) VALUES (N'18bb6c17-1fa4-49b0-8be0-3a8b22e3381a', N'AB37197C-BF33-44B8-BA5D-E246FA250B41|ha conseguido una recompensa,|91F482C6-59A5-450F-A09A-9C745B861339|Recompensa', N'entradas-cine.jpg', 1, CAST(N'2024-04-17T17:45:15.840' AS DateTime), CAST(N'2024-04-17T17:45:15.840' AS DateTime), CAST(N'2024-04-17T17:45:15.840' AS DateTime))
GO
INSERT [dbo].[RedSocial] ([idRed], [descripcion], [imagen], [estado], [fechaPublicacion], [fechaCreacion], [fechaModificacion]) VALUES (N'753e11df-2798-4efe-9f06-413862707a97', N'939C9C6D-9DCF-4B7E-BEA6-5C26169FA066|ha alcanzado el|CF68ECD4-FE5C-4E11-9AAB-69514424FD1B|Nivel', NULL, 1, CAST(N'2024-03-18T15:44:52.617' AS DateTime), CAST(N'2024-03-18T15:44:52.620' AS DateTime), CAST(N'2024-03-18T15:44:52.620' AS DateTime))
GO
INSERT [dbo].[RedSocial] ([idRed], [descripcion], [imagen], [estado], [fechaPublicacion], [fechaCreacion], [fechaModificacion]) VALUES (N'ceec0e73-0057-4121-b177-47b5c1b0cc70', N'AB37197C-BF33-44B8-BA5D-E246FA250B41|ha alcanzado el|A3AE5C3C-1D90-4306-882D-A092EDBD82EF|Nivel', NULL, 1, CAST(N'2024-03-14T16:49:12.327' AS DateTime), CAST(N'2024-03-14T16:49:12.327' AS DateTime), CAST(N'2024-03-14T16:49:12.327' AS DateTime))
GO
INSERT [dbo].[RedSocial] ([idRed], [descripcion], [imagen], [estado], [fechaPublicacion], [fechaCreacion], [fechaModificacion]) VALUES (N'd1a31210-f20f-481a-a842-4a21a7823b69', N'AB37197C-BF33-44B8-BA5D-E246FA250B41|ha conseguido una recompensa,|91F482C6-59A5-450F-A09A-9C745B861339|Recompensa', N'entradas-cine.jpg', 1, CAST(N'2024-04-17T12:50:02.083' AS DateTime), CAST(N'2024-04-17T12:50:02.083' AS DateTime), CAST(N'2024-04-17T12:50:02.083' AS DateTime))
GO
INSERT [dbo].[RedSocial] ([idRed], [descripcion], [imagen], [estado], [fechaPublicacion], [fechaCreacion], [fechaModificacion]) VALUES (N'871e559d-ce0f-4578-b159-4c7756b8e624', N'AB37197C-BF33-44B8-BA5D-E246FA250B41|ha conseguido una recompensa,|40853D25-1A7A-416A-A9CA-32C3F2C53814|Recompensa', NULL, 1, CAST(N'2024-04-17T10:42:28.640' AS DateTime), CAST(N'2024-04-17T10:42:28.643' AS DateTime), CAST(N'2024-04-17T10:42:28.643' AS DateTime))
GO
INSERT [dbo].[RedSocial] ([idRed], [descripcion], [imagen], [estado], [fechaPublicacion], [fechaCreacion], [fechaModificacion]) VALUES (N'992ac96b-a248-4757-9300-55733531b1fb', N'AB37197C-BF33-44B8-BA5D-E246FA250B41|ha alcanzado el|FFD99848-9D07-4CBD-93B1-B7CA5CC18452|Nivel', N'nivel3.png', 1, CAST(N'2024-03-12T15:16:40.480' AS DateTime), CAST(N'2024-03-12T15:16:40.480' AS DateTime), CAST(N'2024-03-12T15:16:40.480' AS DateTime))
GO
INSERT [dbo].[RedSocial] ([idRed], [descripcion], [imagen], [estado], [fechaPublicacion], [fechaCreacion], [fechaModificacion]) VALUES (N'f40d6f71-478e-47b4-b1f8-5ddab2be8268', N'015E40DD-58CE-401E-A0A9-075874BC0B68|ha alcanzado el|62629073-7CC1-4AD3-82F1-B57A823E0092|Nivel', NULL, 1, CAST(N'2024-03-12T15:37:27.070' AS DateTime), CAST(N'2024-03-12T15:37:27.070' AS DateTime), CAST(N'2024-03-12T15:37:27.070' AS DateTime))
GO
INSERT [dbo].[RedSocial] ([idRed], [descripcion], [imagen], [estado], [fechaPublicacion], [fechaCreacion], [fechaModificacion]) VALUES (N'27550f53-035b-4d16-a85d-749bc7810d76', N'AB37197C-BF33-44B8-BA5D-E246FA250B41|ha conseguido una recompensa,|91F482C6-59A5-450F-A09A-9C745B861339|Recompensa', N'entradas-cine.jpg', 1, CAST(N'2024-04-17T12:49:24.170' AS DateTime), CAST(N'2024-04-17T12:49:24.170' AS DateTime), CAST(N'2024-04-17T12:49:24.170' AS DateTime))
GO
INSERT [dbo].[RedSocial] ([idRed], [descripcion], [imagen], [estado], [fechaPublicacion], [fechaCreacion], [fechaModificacion]) VALUES (N'e43b6f9f-bd81-40cc-8219-87139b1821e5', N'AB37197C-BF33-44B8-BA5D-E246FA250B41|ha conseguido una recompensa,|91F482C6-59A5-450F-A09A-9C745B861339|Recompensa', N'entradas-cine.jpg', 1, CAST(N'2024-04-17T12:49:50.857' AS DateTime), CAST(N'2024-04-17T12:49:50.857' AS DateTime), CAST(N'2024-04-17T12:49:50.857' AS DateTime))
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
INSERT [dbo].[RedSocial] ([idRed], [descripcion], [imagen], [estado], [fechaPublicacion], [fechaCreacion], [fechaModificacion]) VALUES (N'a1c36622-c5c9-4acc-9a01-afda3187db82', N'91DB7BAE-7D2F-423D-B595-D227C63CA0A6|ha alcanzado el|1E7E4DD1-22B4-49B6-AAA9-705D0E49A7E5|Nivel', N'nivel4.png', 1, CAST(N'2024-03-12T15:13:27.803' AS DateTime), CAST(N'2024-03-12T15:13:27.803' AS DateTime), CAST(N'2024-03-12T15:13:27.803' AS DateTime))
GO
INSERT [dbo].[RedSocial] ([idRed], [descripcion], [imagen], [estado], [fechaPublicacion], [fechaCreacion], [fechaModificacion]) VALUES (N'92887343-0e10-494d-89b0-b1b363c7e20a', N'AB37197C-BF33-44B8-BA5D-E246FA250B41|ha conseguido una recompensa,|91F482C6-59A5-450F-A09A-9C745B861339|Recompensa', N'entradas-cine.jpg', 1, CAST(N'2024-04-17T12:48:51.900' AS DateTime), CAST(N'2024-04-17T12:48:51.900' AS DateTime), CAST(N'2024-04-17T12:48:51.900' AS DateTime))
GO
INSERT [dbo].[RedSocial] ([idRed], [descripcion], [imagen], [estado], [fechaPublicacion], [fechaCreacion], [fechaModificacion]) VALUES (N'46f01d50-f16a-4e50-9da8-b386f6828a89', N'91331754-1E83-417F-90E7-0E596E996510|ha alcanzado el|5690C0BA-70E1-4F3D-A0E2-2AB787446F37|Nivel', N'nivel1.png', 1, CAST(N'2024-03-11T00:00:00.000' AS DateTime), CAST(N'2024-03-11T15:48:42.310' AS DateTime), CAST(N'2024-03-11T15:48:42.310' AS DateTime))
GO
INSERT [dbo].[RedSocial] ([idRed], [descripcion], [imagen], [estado], [fechaPublicacion], [fechaCreacion], [fechaModificacion]) VALUES (N'7a3a2037-49ec-43cc-ae03-c913f92c50e4', N'AB37197C-BF33-44B8-BA5D-E246FA250B41|ha canjeado la recompensa:|40853D25-1A7A-416A-A9CA-32C3F2C53814|Recompensa', NULL, 1, CAST(N'2024-04-23T12:36:45.357' AS DateTime), CAST(N'2024-04-23T12:36:45.357' AS DateTime), CAST(N'2024-04-23T12:36:45.357' AS DateTime))
GO
INSERT [dbo].[RedSocial] ([idRed], [descripcion], [imagen], [estado], [fechaPublicacion], [fechaCreacion], [fechaModificacion]) VALUES (N'd42358c4-9253-4fcf-8190-dba1ec8b7ca4', N'AB37197C-BF33-44B8-BA5D-E246FA250B41|ha canjeado la recompensa:|40853D25-1A7A-416A-A9CA-32C3F2C53814|Recompensa', NULL, 1, CAST(N'2024-04-23T14:58:35.780' AS DateTime), CAST(N'2024-04-23T14:58:35.780' AS DateTime), CAST(N'2024-04-23T14:58:35.780' AS DateTime))
GO
INSERT [dbo].[RedSocial] ([idRed], [descripcion], [imagen], [estado], [fechaPublicacion], [fechaCreacion], [fechaModificacion]) VALUES (N'47bf5792-021c-4ba1-b51a-e115f3ff516d', N'AB37197C-BF33-44B8-BA5D-E246FA250B41|ha conseguido una recompensa,|91F482C6-59A5-450F-A09A-9C745B861339|Recompensa', N'entradas-cine.jpg', 1, CAST(N'2024-04-17T12:28:45.223' AS DateTime), CAST(N'2024-04-17T12:28:45.227' AS DateTime), CAST(N'2024-04-17T12:28:45.227' AS DateTime))
GO
INSERT [dbo].[RedSocial] ([idRed], [descripcion], [imagen], [estado], [fechaPublicacion], [fechaCreacion], [fechaModificacion]) VALUES (N'9f8ea6aa-1f62-499f-a260-e19c34f5476c', N'AB37197C-BF33-44B8-BA5D-E246FA250B41|ha conseguido una recompensa,|91F482C6-59A5-450F-A09A-9C745B861339|Recompensa', N'entradas-cine.jpg', 1, CAST(N'2024-04-17T17:44:05.903' AS DateTime), CAST(N'2024-04-17T17:44:05.903' AS DateTime), CAST(N'2024-04-17T17:44:05.903' AS DateTime))
GO
INSERT [dbo].[Reto] ([idReto], [nombre], [fechaApetura], [fechaCierre], [estado], [vidas], [tiempo_ms], [puntosRecompensa], [creditosObtenidos], [instrucciones], [imagen], [idTipoReto], [idComportamiento], [fechaCreacion], [fechaModificacion], [criterioMinimo], [enEquipo]) VALUES (N'27c5527f-3ea3-431b-bedf-65841eaf5663', N'mi segundo reto 25', CAST(N'1800-01-01T00:00:00.000' AS DateTime), CAST(N'1800-01-01T00:00:00.000' AS DateTime), 1, 0, 3600000, 11, 16, NULL, NULL, N'63aa060b-cde4-49c0-9d60-aaf069df1533', N'1dd28d88-34c7-4394-ab3d-525726001730', CAST(N'2024-02-27T12:45:15.930' AS DateTime), CAST(N'2024-04-12T09:20:45.530' AS DateTime), 40, 0)
GO
INSERT [dbo].[Reto] ([idReto], [nombre], [fechaApetura], [fechaCierre], [estado], [vidas], [tiempo_ms], [puntosRecompensa], [creditosObtenidos], [instrucciones], [imagen], [idTipoReto], [idComportamiento], [fechaCreacion], [fechaModificacion], [criterioMinimo], [enEquipo]) VALUES (N'd9ca3dcb-ee6a-4f35-ae4c-719843510a1a', N'mi segundo reto 24', CAST(N'2024-05-01T00:00:00.000' AS DateTime), CAST(N'2024-06-01T00:00:00.000' AS DateTime), 1, 3, 400002, 11, 16, NULL, NULL, N'63aa060b-cde4-49c0-9d60-aaf069df1533', N'1dd28d88-34c7-4394-ab3d-525726001730', CAST(N'2024-02-27T12:44:48.647' AS DateTime), CAST(N'2024-04-12T09:20:08.207' AS DateTime), 30, 1)
GO
INSERT [dbo].[Rol] ([idRol], [nombre], [descripcion], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'adm', N'Administrador', N'Este rol es para el administrador', 1, CAST(N'2023-11-30T10:24:19.633' AS DateTime), CAST(N'2023-11-30T10:24:19.633' AS DateTime))
GO
INSERT [dbo].[Rol] ([idRol], [nombre], [descripcion], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'jug', N'Jugador', N'Este rol es para los jugadores', 1, CAST(N'2023-11-30T10:29:18.137' AS DateTime), CAST(N'2023-11-30T10:29:18.137' AS DateTime))
GO
INSERT [dbo].[Rol] ([idRol], [nombre], [descripcion], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'sadm', N'Super Administrador', N'Este es para el super administrador', 0, CAST(N'2023-12-01T10:06:46.973' AS DateTime), CAST(N'2023-12-01T10:06:46.973' AS DateTime))
GO
INSERT [dbo].[tipoReto] ([idTipoReto], [nombre], [descripcion], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'f1e2f610-e277-4a29-b146-8c42ecada4c0', N'Puzzle', N'Es para los retos que hay que armar rompeczabezas', 0, CAST(N'2023-12-16T11:33:15.430' AS DateTime), CAST(N'2023-12-16T11:33:15.430' AS DateTime))
GO
INSERT [dbo].[tipoReto] ([idTipoReto], [nombre], [descripcion], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'63aa060b-cde4-49c0-9d60-aaf069df1533', N'Trivia', N'Es para los retos de preguntas', 1, CAST(N'2023-12-16T11:33:15.430' AS DateTime), CAST(N'2023-12-16T11:33:15.430' AS DateTime))
GO
INSERT [dbo].[tipoReto] ([idTipoReto], [nombre], [descripcion], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'bb0bdda2-05d0-42c6-b3bc-b32b99de18ef', N'Laberinto', N'Es para los retos que hay un laberinto', 0, CAST(N'2023-12-16T11:33:15.430' AS DateTime), CAST(N'2023-12-16T11:33:15.430' AS DateTime))
GO
INSERT [dbo].[Usuario] ([idUsuario], [nombre], [apellido], [correo], [celular], [foto], [estado], [idRol], [idArea], [fechaCreacion], [fechaModificacion], [clave], [idCiudad], [fechaLogin], [puntos], [creditos], [id]) VALUES (N'015e40dd-58ce-401e-a0a9-075874bc0b68', N'Diana', N'Gomez', N'diana@gmail.com', N'1234232323', N'user13.PNG', 1, N'jug', NULL, CAST(N'2023-12-05T16:47:54.067' AS DateTime), CAST(N'2024-04-05T12:27:55.027' AS DateTime), 0x7B2243697068657254657874223A224D6654546A71526963776D384C7353796E31446B39673D3D222C224956223A22745674762F4F61724A74665A55772B487A6542676B673D3D227D, NULL, CAST(N'2024-04-04T11:29:23.557' AS DateTime), 0, 0, N'1020304050')
GO
INSERT [dbo].[Usuario] ([idUsuario], [nombre], [apellido], [correo], [celular], [foto], [estado], [idRol], [idArea], [fechaCreacion], [fechaModificacion], [clave], [idCiudad], [fechaLogin], [puntos], [creditos], [id]) VALUES (N'91331754-1e83-417f-90e7-0e596e996510', N'Elver pablo', N'Galarraga', N'elver.galarga@gmail.com', N'1234567891', N'elver.PNG', 0, N'jug', N'c1df8d3c-0069-468e-8811-a0f404f12819', CAST(N'2023-12-07T10:27:03.510' AS DateTime), CAST(N'2024-04-04T11:51:09.593' AS DateTime), 0x7B2243697068657254657874223A2254576B68637955364E697A71764D354C7346306A39673D3D222C224956223A22776A4C5A46474B42775265316C6C64564470564F54413D3D227D, N'ca6c9451-3ea9-465f-88ce-07e078314731', CAST(N'2024-03-04T17:13:07.187' AS DateTime), 0, 0, N'1020304023')
GO
INSERT [dbo].[Usuario] ([idUsuario], [nombre], [apellido], [correo], [celular], [foto], [estado], [idRol], [idArea], [fechaCreacion], [fechaModificacion], [clave], [idCiudad], [fechaLogin], [puntos], [creditos], [id]) VALUES (N'939c9c6d-9dcf-4b7e-bea6-5c26169fa066', N'Admin', N'Admin', N'admin@hotmail.com', N'1234567892', N'user12.PNG', 1, N'adm', N'b7fc947e-8db6-415d-b361-e0c41fcc8344', CAST(N'2023-12-05T16:50:12.913' AS DateTime), CAST(N'2024-04-22T09:56:12.913' AS DateTime), 0x7B2243697068657254657874223A22692F444C66616A30636E7A7A74776D327572325249773D3D222C224956223A2230674A567079537A56674B31414741596D626A594F773D3D227D, N'48632ff5-b6f9-45f0-a514-c0a5ec544226', CAST(N'2024-04-25T18:08:22.157' AS DateTime), 0, 17, N'1020304053')
GO
INSERT [dbo].[Usuario] ([idUsuario], [nombre], [apellido], [correo], [celular], [foto], [estado], [idRol], [idArea], [fechaCreacion], [fechaModificacion], [clave], [idCiudad], [fechaLogin], [puntos], [creditos], [id]) VALUES (N'f42329d1-edaa-4f2c-9ae1-8f026c92c842', N'Pedro', N'Romero', N'pedro@gmail.com', N'1223456723', N'user3.PNG', 1, N'jug', NULL, CAST(N'2023-12-05T17:41:38.327' AS DateTime), CAST(N'2024-04-25T18:11:23.193' AS DateTime), 0x7B2243697068657254657874223A22652F54724D7849773741505264516C526E42737A65773D3D222C224956223A2237365330735A734F7A662B31353959796D37503246413D3D227D, NULL, CAST(N'2024-04-26T09:17:54.403' AS DateTime), 10, 38, N'1020304054')
GO
INSERT [dbo].[Usuario] ([idUsuario], [nombre], [apellido], [correo], [celular], [foto], [estado], [idRol], [idArea], [fechaCreacion], [fechaModificacion], [clave], [idCiudad], [fechaLogin], [puntos], [creditos], [id]) VALUES (N'91db7bae-7d2f-423d-b595-d227c63ca0a6', N'Marie', N'Guerrero', N'marie@gmail.com', N'1223456', NULL, 0, N'jug', NULL, CAST(N'2023-12-05T17:28:22.697' AS DateTime), CAST(N'2024-03-26T17:50:27.330' AS DateTime), 0x7B2243697068657254657874223A22392F37666B717362614A4B4C586233724764534547413D3D222C224956223A225078384C70486C3351454864614E347443656D6B73513D3D227D, NULL, NULL, 10, 80, N'1020304056')
GO
INSERT [dbo].[Usuario] ([idUsuario], [nombre], [apellido], [correo], [celular], [foto], [estado], [idRol], [idArea], [fechaCreacion], [fechaModificacion], [clave], [idCiudad], [fechaLogin], [puntos], [creditos], [id]) VALUES (N'6d3a6b25-c6c7-4ed4-a5e9-d992b1cc98a7', N'Benito', N'Camelas', N'benito@gmail.com', N'12234', NULL, 1, N'jug', NULL, CAST(N'2023-12-05T16:52:23.680' AS DateTime), CAST(N'2024-03-27T14:53:36.657' AS DateTime), 0x7B2243697068657254657874223A2276456B7A6C785776754A3865554373466B41776231673D3D222C224956223A224F66432B4E4F3874687A7A57655A5047333874514D513D3D227D, NULL, CAST(N'2024-03-14T09:08:18.583' AS DateTime), 23, 2, N'1020304057')
GO
INSERT [dbo].[Usuario] ([idUsuario], [nombre], [apellido], [correo], [celular], [foto], [estado], [idRol], [idArea], [fechaCreacion], [fechaModificacion], [clave], [idCiudad], [fechaLogin], [puntos], [creditos], [id]) VALUES (N'ab37197c-bf33-44b8-ba5d-e246fa250b41', N'prueba uno', N'prueba', N'user@correo.com', N'1234567811', NULL, 1, N'jug', N'b7fc947e-8db6-415d-b361-e0c41fcc8344', CAST(N'2024-01-31T16:38:57.650' AS DateTime), CAST(N'2024-04-03T13:06:18.600' AS DateTime), 0x7B2243697068657254657874223A2242796E476A34666933472B4B4B5145435835483172513D3D222C224956223A2238652B4A687244622B626442635972515A566A3051773D3D227D, N'48632ff5-b6f9-45f0-a514-c0a5ec544226', CAST(N'2024-04-25T09:59:56.503' AS DateTime), 11, 20, N'1020304058')
GO
INSERT [dbo].[Usuario_Equipo] ([idEquipo], [idUsuario], [fechaCreacion], [fechaModificacion]) VALUES (N'4638e1df-928a-442a-bcd8-388ad33a8829', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', CAST(N'2024-04-12T16:27:13.070' AS DateTime), CAST(N'2024-04-12T16:27:13.070' AS DateTime))
GO
INSERT [dbo].[Usuario_Equipo] ([idEquipo], [idUsuario], [fechaCreacion], [fechaModificacion]) VALUES (N'114ec699-77c3-4e52-999b-0e59861f46b9', N'6d3a6b25-c6c7-4ed4-a5e9-d992b1cc98a7', CAST(N'2024-04-25T10:58:54.060' AS DateTime), CAST(N'2024-04-25T10:58:54.060' AS DateTime))
GO
INSERT [dbo].[Usuario_Equipo] ([idEquipo], [idUsuario], [fechaCreacion], [fechaModificacion]) VALUES (N'4638e1df-928a-442a-bcd8-388ad33a8829', N'91db7bae-7d2f-423d-b595-d227c63ca0a6', CAST(N'2024-04-11T13:07:04.263' AS DateTime), CAST(N'2024-04-11T13:07:04.263' AS DateTime))
GO
INSERT [dbo].[Usuario_Equipo] ([idEquipo], [idUsuario], [fechaCreacion], [fechaModificacion]) VALUES (N'114ec699-77c3-4e52-999b-0e59861f46b9', N'91331754-1e83-417f-90e7-0e596e996510', CAST(N'2024-04-25T10:59:13.430' AS DateTime), CAST(N'2024-04-25T10:59:13.430' AS DateTime))
GO
INSERT [dbo].[Usuario_Equipo] ([idEquipo], [idUsuario], [fechaCreacion], [fechaModificacion]) VALUES (N'4638e1df-928a-442a-bcd8-388ad33a8829', N'015e40dd-58ce-401e-a0a9-075874bc0b68', CAST(N'2024-04-11T13:07:04.267' AS DateTime), CAST(N'2024-04-11T13:07:04.267' AS DateTime))
GO
INSERT [dbo].[Usuario_Medalla] ([idMedalla], [idUsuario], [fechaCreacion], [fechaModificacion]) VALUES (N'2eb8768c-f1ae-49be-83e0-b04c39eb64c2', N'f42329d1-edaa-4f2c-9ae1-8f026c92c842', CAST(N'2024-03-14T09:21:25.757' AS DateTime), CAST(N'2024-03-14T09:21:25.757' AS DateTime))
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
INSERT [dbo].[Usuario_Noticia] ([idNoticia], [idUsuario], [likes], [comentario], [fechaCreacion], [fechaModificacion]) VALUES (N'6c8c7b7c-c3be-4dbf-9e3a-3f8b8640d0e2', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', 1, NULL, CAST(N'2024-04-15T16:16:08.620' AS DateTime), CAST(N'2024-04-15T16:16:08.620' AS DateTime))
GO
INSERT [dbo].[Usuario_Noticia] ([idNoticia], [idUsuario], [likes], [comentario], [fechaCreacion], [fechaModificacion]) VALUES (N'70114d2e-1ba0-4251-a626-1cfdfdce6a40', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', 0, N'hola', CAST(N'2024-04-09T18:18:31.600' AS DateTime), CAST(N'2024-04-09T18:18:31.600' AS DateTime))
GO
INSERT [dbo].[Usuario_Noticia] ([idNoticia], [idUsuario], [likes], [comentario], [fechaCreacion], [fechaModificacion]) VALUES (N'70114d2e-1ba0-4251-a626-1cfdfdce6a40', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', 1, NULL, CAST(N'2024-04-15T16:16:14.243' AS DateTime), CAST(N'2024-04-15T16:16:14.243' AS DateTime))
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
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo]) VALUES (N'27c5527f-3ea3-431b-bedf-65841eaf5663', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', 11, 65000, -1, CAST(N'2024-03-28T18:32:02.993' AS DateTime), CAST(N'2024-04-23T08:59:53.437' AS DateTime), 1, CAST(N'2024-03-28T18:32:02.993' AS DateTime), 0)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo]) VALUES (N'27c5527f-3ea3-431b-bedf-65841eaf5663', N'91331754-1e83-417f-90e7-0e596e996510', 0, 0, 0, CAST(N'2024-03-07T16:07:10.130' AS DateTime), CAST(N'2024-03-07T16:07:10.130' AS DateTime), 0, CAST(N'2024-03-07T16:39:54.333' AS DateTime), 0)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo]) VALUES (N'27c5527f-3ea3-431b-bedf-65841eaf5663', N'939c9c6d-9dcf-4b7e-bea6-5c26169fa066', 0, 0, 0, CAST(N'2024-03-07T16:07:10.130' AS DateTime), CAST(N'2024-03-07T16:07:10.130' AS DateTime), 0, CAST(N'2024-03-07T16:39:54.333' AS DateTime), 0)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo]) VALUES (N'd9ca3dcb-ee6a-4f35-ae4c-719843510a1a', N'91db7bae-7d2f-423d-b595-d227c63ca0a6', 0, 0, 0, CAST(N'2024-04-12T10:25:43.477' AS DateTime), CAST(N'2024-04-12T10:25:43.477' AS DateTime), 0, CAST(N'2024-04-12T10:25:43.477' AS DateTime), 1)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo]) VALUES (N'27c5527f-3ea3-431b-bedf-65841eaf5663', N'f42329d1-edaa-4f2c-9ae1-8f026c92c842', 10, 100, -1, CAST(N'2024-03-07T16:07:10.130' AS DateTime), CAST(N'2024-03-29T16:43:08.860' AS DateTime), 1, CAST(N'2024-03-07T16:39:54.333' AS DateTime), 0)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo]) VALUES (N'd9ca3dcb-ee6a-4f35-ae4c-719843510a1a', N'015e40dd-58ce-401e-a0a9-075874bc0b68', 0, 0, 0, CAST(N'2024-04-12T10:25:43.477' AS DateTime), CAST(N'2024-04-12T10:25:43.477' AS DateTime), 0, CAST(N'2024-04-12T10:25:43.477' AS DateTime), 1)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo]) VALUES (N'27c5527f-3ea3-431b-bedf-65841eaf5663', N'015e40dd-58ce-401e-a0a9-075874bc0b68', 0, 0, 0, CAST(N'2024-04-09T13:00:16.287' AS DateTime), CAST(N'2024-04-09T13:00:16.287' AS DateTime), 0, CAST(N'2024-04-09T13:00:16.287' AS DateTime), 0)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo]) VALUES (N'd9ca3dcb-ee6a-4f35-ae4c-719843510a1a', N'6d3a6b25-c6c7-4ed4-a5e9-d992b1cc98a7', 0, 0, 0, CAST(N'2024-04-25T11:11:04.960' AS DateTime), CAST(N'2024-04-25T11:11:04.960' AS DateTime), 0, CAST(N'2024-04-25T11:11:04.960' AS DateTime), 1)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo]) VALUES (N'd9ca3dcb-ee6a-4f35-ae4c-719843510a1a', N'91331754-1e83-417f-90e7-0e596e996510', 0, 0, 0, CAST(N'2024-04-25T11:11:04.960' AS DateTime), CAST(N'2024-04-25T11:11:04.960' AS DateTime), 0, CAST(N'2024-04-25T11:11:04.960' AS DateTime), 1)
GO
INSERT [dbo].[Usuario_Reto] ([idReto], [idUsuario], [puntos], [tiempo], [vidas], [fechaCreacion], [fechaModificacion], [completado], [fechaAsignacion], [tieneEquipo]) VALUES (N'd9ca3dcb-ee6a-4f35-ae4c-719843510a1a', N'ab37197c-bf33-44b8-ba5d-e246fa250b41', 0, 0, 0, CAST(N'2024-04-12T16:27:13.073' AS DateTime), CAST(N'2024-04-12T16:27:13.073' AS DateTime), 0, CAST(N'2024-04-12T16:27:13.073' AS DateTime), 1)
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Area__72AFBCC6C2500A79]    Script Date: 26/04/2024 9:36:51 ******/
ALTER TABLE [dbo].[Area] ADD UNIQUE NONCLUSTERED 
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Categori__72AFBCC6B3607509]    Script Date: 26/04/2024 9:36:51 ******/
ALTER TABLE [dbo].[CategoriaNoticia] ADD UNIQUE NONCLUSTERED 
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Categori__72AFBCC6945FD353]    Script Date: 26/04/2024 9:36:51 ******/
ALTER TABLE [dbo].[CategoriaRecompensa] ADD UNIQUE NONCLUSTERED 
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Ciudad__72AFBCC60987AF52]    Script Date: 26/04/2024 9:36:51 ******/
ALTER TABLE [dbo].[Ciudad] ADD UNIQUE NONCLUSTERED 
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Comporta__72AFBCC6D24EDAA1]    Script Date: 26/04/2024 9:36:51 ******/
ALTER TABLE [dbo].[ComportamientoPregunta] ADD UNIQUE NONCLUSTERED 
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Condicio__72AFBCC66FA3235E]    Script Date: 26/04/2024 9:36:51 ******/
ALTER TABLE [dbo].[Condicion] ADD UNIQUE NONCLUSTERED 
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ_Configuracion_nom]    Script Date: 26/04/2024 9:36:51 ******/
ALTER TABLE [dbo].[Configuracion] ADD  CONSTRAINT [UQ_Configuracion_nom] UNIQUE NONCLUSTERED 
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Constant__72AFBCC6D3153B93]    Script Date: 26/04/2024 9:36:51 ******/
ALTER TABLE [dbo].[Constants] ADD UNIQUE NONCLUSTERED 
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__CorreoEn__2A586E0BB0F69B96]    Script Date: 26/04/2024 9:36:51 ******/
ALTER TABLE [dbo].[CorreoEnvio] ADD UNIQUE NONCLUSTERED 
(
	[correo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__CorreoEn__7F309E8F39900DF2]    Script Date: 26/04/2024 9:36:51 ******/
ALTER TABLE [dbo].[CorreoEnvio] ADD UNIQUE NONCLUSTERED 
(
	[host] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Empresa__72AFBCC630736C09]    Script Date: 26/04/2024 9:36:51 ******/
ALTER TABLE [dbo].[Empresa] ADD UNIQUE NONCLUSTERED 
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Equipo__72AFBCC63B05F2DF]    Script Date: 26/04/2024 9:36:51 ******/
ALTER TABLE [dbo].[Equipo] ADD UNIQUE NONCLUSTERED 
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Licencia__506462E02EF68D3A]    Script Date: 26/04/2024 9:36:51 ******/
ALTER TABLE [dbo].[Licencia] ADD UNIQUE NONCLUSTERED 
(
	[tabla] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Licencia__72AFBCC6AA2279C2]    Script Date: 26/04/2024 9:36:51 ******/
ALTER TABLE [dbo].[Licencia] ADD UNIQUE NONCLUSTERED 
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Medalla__72AFBCC6A797F12C]    Script Date: 26/04/2024 9:36:51 ******/
ALTER TABLE [dbo].[Medalla] ADD UNIQUE NONCLUSTERED 
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ_puntosNecesarios]    Script Date: 26/04/2024 9:36:51 ******/
ALTER TABLE [dbo].[Nivel] ADD  CONSTRAINT [UQ_puntosNecesarios] UNIQUE NONCLUSTERED 
(
	[puntosNecesarios] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Notifica__72AFBCC6F41559DF]    Script Date: 26/04/2024 9:36:51 ******/
ALTER TABLE [dbo].[Notificacion] ADD UNIQUE NONCLUSTERED 
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Pais__72AFBCC68522AA86]    Script Date: 26/04/2024 9:36:51 ******/
ALTER TABLE [dbo].[Pais] ADD UNIQUE NONCLUSTERED 
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Reto__72AFBCC683289CD8]    Script Date: 26/04/2024 9:36:51 ******/
ALTER TABLE [dbo].[Reto] ADD UNIQUE NONCLUSTERED 
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Rol__72AFBCC65215A463]    Script Date: 26/04/2024 9:36:51 ******/
ALTER TABLE [dbo].[Rol] ADD UNIQUE NONCLUSTERED 
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__tipoReto__72AFBCC679DDB36C]    Script Date: 26/04/2024 9:36:51 ******/
ALTER TABLE [dbo].[tipoReto] ADD UNIQUE NONCLUSTERED 
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Usuario__2A586E0BBB3CDCB2]    Script Date: 26/04/2024 9:36:51 ******/
ALTER TABLE [dbo].[Usuario] ADD  CONSTRAINT [UQ__Usuario__2A586E0BBB3CDCB2] UNIQUE NONCLUSTERED 
(
	[correo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ_Usuario_id]    Script Date: 26/04/2024 9:36:51 ******/
ALTER TABLE [dbo].[Usuario] ADD  CONSTRAINT [UQ_Usuario_id] UNIQUE NONCLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ__Usuario___645723A71F7E3A8D]    Script Date: 26/04/2024 9:36:51 ******/
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
ALTER TABLE [dbo].[Puzzle] ADD  DEFAULT (newid()) FOR [idPuzzle]
GO
ALTER TABLE [dbo].[Puzzle] ADD  DEFAULT (getdate()) FOR [fechaCreacion]
GO
ALTER TABLE [dbo].[Puzzle] ADD  DEFAULT (getdate()) FOR [fechaModificacion]
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
ALTER TABLE [dbo].[Rol] ADD  DEFAULT ((1)) FOR [estado]
GO
ALTER TABLE [dbo].[Rol] ADD  DEFAULT (getdate()) FOR [fechaCreacion]
GO
ALTER TABLE [dbo].[Rol] ADD  DEFAULT (getdate()) FOR [fechaModificacion]
GO
ALTER TABLE [dbo].[tipoReto] ADD  DEFAULT (newid()) FOR [idTipoReto]
GO
ALTER TABLE [dbo].[tipoReto] ADD  DEFAULT ((1)) FOR [estado]
GO
ALTER TABLE [dbo].[tipoReto] ADD  DEFAULT (getdate()) FOR [fechaCreacion]
GO
ALTER TABLE [dbo].[tipoReto] ADD  DEFAULT (getdate()) FOR [fechaModificacion]
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
ALTER TABLE [dbo].[Opcion]  WITH CHECK ADD FOREIGN KEY([idPregunta])
REFERENCES [dbo].[Pregunta] ([idPregunta])
GO
ALTER TABLE [dbo].[Pregunta]  WITH CHECK ADD FOREIGN KEY([idReto])
REFERENCES [dbo].[Reto] ([idReto])
GO
ALTER TABLE [dbo].[Puzzle]  WITH CHECK ADD FOREIGN KEY([idReto])
REFERENCES [dbo].[Reto] ([idReto])
GO
ALTER TABLE [dbo].[Recompensa]  WITH CHECK ADD FOREIGN KEY([idCategoria])
REFERENCES [dbo].[CategoriaRecompensa] ([idCategoria])
GO
ALTER TABLE [dbo].[Reto]  WITH CHECK ADD FOREIGN KEY([idComportamiento])
REFERENCES [dbo].[ComportamientoPregunta] ([idComportamiento])
GO
ALTER TABLE [dbo].[Reto]  WITH CHECK ADD FOREIGN KEY([idTipoReto])
REFERENCES [dbo].[tipoReto] ([idTipoReto])
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
/****** Object:  StoredProcedure [dbo].[sp_B_Area]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_B_AreaById]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_B_AreaByNombre]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_B_CategoriaNoticia]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_B_CategoriaNoticiaByAll]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_B_CategoriaNoticiaById]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_B_CategoriaRecompensa]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_B_CategoriaRecompensaByAll]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_B_CategoriaRecompensaById]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_B_Ciudad]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_B_CiudadById]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_B_CiudadByNombre]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_B_ComporPregu]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_B_Condicion]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_B_Configuracion]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_B_ConfiguracionByNombre]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_B_ConfiguracionByValor]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_B_CorreoEnvio]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_B_Empresa]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_B_EmpresaById]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_B_Equipo]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_B_Equipo_RetoByIdReto]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_B_EquipoByAll]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_B_EquipoById]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_B_Inicio]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_B_InicioByIdRol]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_B_Licencia]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_B_Medalla]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_B_MedallaByAll]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_B_MedallaById]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_B_Nivel]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_B_NivelByAll]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_B_NivelById]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_B_NivelByNextPuntos]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_B_Noticia]    Script Date: 26/04/2024 9:36:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_B_Noticia] 
		
	@estado int,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;			
		
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
	where (n.estado = @estado or @estado = -1)
	Order by n.fechaCreacion desc		

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_Noticia_enTendencia]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_B_NoticiaByAll]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_B_NoticiaById]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_B_Notificacion]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_B_NotificacionById]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_B_NotificacionByNombre]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_B_OpcionByIdPregunta]    Script Date: 26/04/2024 9:36:51 ******/
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

	Select * 
	from Opcion o
	Where idPregunta = @idPregunta 
	and (o.estado = @estado or @estado = -1)
	Order By o.fechaCreacion desc

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_Pais]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_B_PaisById]    Script Date: 26/04/2024 9:36:51 ******/
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

		select @info = CONCAT('Medalla ', descripcion) from Constants where nombre = 'no_encontrar'
		set @error = 1

	end

	print @info
	

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_PreguntaByAll]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_B_PreguntaById]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_B_PreguntaByIdReto]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_B_Recompensa]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_B_RecompensaByAll]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_B_RecompensaById]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_B_RedSocial]    Script Date: 26/04/2024 9:36:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_B_RedSocial] 		

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;		

	Declare @tabla as table (idRed uniqueidentifier, descripcion varchar(30), usuario varchar(60), foto varchar(60), tipo varchar(60), dir varchar(12), imagen varchar(60), estado int, fechaPublicacion datetime, fechaCreacion datetime, fechaModificacion datetime)	
	
	Declare @idRed uniqueidentifier, @imagen varchar(60), @estado int, @fechaPublicacion datetime,  @fechaCreacion datetime, @fechaModificacion datetime
	Declare @desc varchar(30), @auxDesc varchar(150), @dir varchar(12),  @idUsuario varchar(40), @idTipo varchar(40)
	Declare @usuario varchar(60), @foto varchar(60), @tipo varchar(60)


	DECLARE RedInfo CURSOR FOR 

	Select r.idRed, r.imagen, r.estado, r.fechaPublicacion, r.fechaCreacion, r.fechaModificacion From RedSocial r	

	OPEN RedInfo
	FETCH NEXT FROM RedInfo INTO @idRed, @imagen, @estado, @fechaPublicacion, @fechaCreacion, @fechaModificacion
	WHILE @@fetch_status = 0
	BEGIN

		Select @auxDesc = descripcion from RedSocial where idRed = @idRed		

		Select top 1 @idUsuario = value from string_split(@auxDesc,'|')
		Select top 2 @desc = value from string_split(@auxDesc,'|')
		Select top 3 @idTipo = value from string_split(@auxDesc,'|')
		Select top 4 @dir  = value from string_split(@auxDesc,'|')

		Select @usuario = CONCAT(nombre,' ',apellido), @foto = foto from Usuario where idUsuario = @idUsuario				
		
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
	r.fechaCreacion,
	r.fechaModificacion
	From @tabla r
	Order By r.fechaCreacion desc		

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_RedSocialByIdRedUser]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_B_resumenGeneral]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_B_Reto]    Script Date: 26/04/2024 9:36:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_B_Reto] 

	@estado int,

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
	r.idComportamiento,
	cp.nombre as 'comportamientoPregunta',	
	r.criterioMinimo,
	(select COUNT(*) from Pregunta p where p.idReto = r.idReto) as 'totalPreguntas', 

	(
		case r.enEquipo when 0 then 
			(select COUNT(*) from Usuario_Reto ur where ur.tieneEquipo = 0 and ur.idReto = r.idReto) 
		else 
			(select COUNT(*) from Usuario_Reto ur where ur.tieneEquipo = 1 and ur.idReto = r.idReto) 
		end
	) as 'usuariosAsignados',

	ISNULL((
		select 	
		COUNT(distinct ur.idReto)
		From Usuario_Reto ur 
		inner join Usuario_Equipo ue on ue.idUsuario = ur.idUsuario
		inner join Equipo e on e.idEquipo = ue.idEquipo 
		Where ur.tieneEquipo = 1 and ur.idReto = r.idReto
		Group by ur.idReto
	),0) as 'equiposAsignados',

	r.enEquipo,
	r.fechaCreacion,
	r.fechaModificacion
	From Reto r
	Inner Join tipoReto tr on tr.idTipoReto = r.idTipoReto
	Inner Join ComportamientoPregunta cp on cp.idComportamiento = r.idComportamiento
	Where (r.estado = @estado or @estado = -1)
	Order By r.fechaCreacion Desc		

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_RetoByAll]    Script Date: 26/04/2024 9:36:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_B_RetoByAll] 

	@buscar varchar(max),

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;

	Declare @totalFilas int  = 0

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
	r.idComportamiento,
	cp.nombre as 'comportamientoPregunta',		
	r.criterioMinimo,
	(select COUNT(*) from Pregunta p where p.idReto = r.idReto) as 'totalPreguntas', 

	(
		case r.enEquipo when 0 then 
			(select COUNT(*) from Usuario_Reto ur where ur.tieneEquipo = 0 and ur.idReto = r.idReto) 
		else 
			(select COUNT(*) from Usuario_Reto ur where ur.tieneEquipo = 1 and ur.idReto = r.idReto) 
		end
	) as 'usuariosAsignados',

	ISNULL((
		select 	
		COUNT(distinct ur.idReto)
		From Usuario_Reto ur 
		inner join Usuario_Equipo ue on ue.idUsuario = ur.idUsuario
		inner join Equipo e on e.idEquipo = ue.idEquipo 
		Where ur.tieneEquipo = 1 and ur.idReto = r.idReto
		Group by ur.idReto
	),0) as 'equiposAsignados',

	r.enEquipo,
	r.fechaCreacion,
	r.fechaModificacion
	From Reto r
	Inner Join tipoReto tr on tr.idTipoReto = r.idTipoReto
	Inner Join ComportamientoPregunta cp on cp.idComportamiento = r.idComportamiento
	Where 
	r.nombre like '%'+@buscar+'%' or
	r.vidas like '%'+@buscar+'%' or
	r.tiempo_ms like '%'+@buscar+'%' or
	r.puntosRecompensa like '%'+@buscar+'%' or
	r.creditosObtenidos like '%'+@buscar+'%' or
	r.instrucciones like '%'+@buscar+'%' or
	tr.nombre like '%'+@buscar+'%' or
	cp.nombre like '%'+@buscar+'%'
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
/****** Object:  StoredProcedure [dbo].[sp_B_RetoById]    Script Date: 26/04/2024 9:36:51 ******/
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
		LOWER(r.idComportamiento) as 'idComportamiento',
		cp.nombre as 'comportamientoPregunta',
		r.criterioMinimo,
		(select COUNT(*) from Pregunta p where p.idReto = r.idReto) as 'totalPreguntas', 
		r.enEquipo,
		r.fechaCreacion,
		r.fechaModificacion
		From Reto r
		Inner Join tipoReto tr on tr.idTipoReto = r.idTipoReto
		Inner Join ComportamientoPregunta cp on cp.idComportamiento = r.idComportamiento
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
/****** Object:  StoredProcedure [dbo].[sp_B_Rol]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_B_tipoReto]    Script Date: 26/04/2024 9:36:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_B_tipoReto] 
		
	@estado int,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;				
		
	Select * 
	From tipoReto tr
	Where (tr.estado = @estado or @estado = -1)
	Order By tr.fechaCreacion Desc		

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_Usuario]    Script Date: 26/04/2024 9:36:51 ******/
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
	ISNULL(u.celular, 'N/A') as 'celular',
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
/****** Object:  StoredProcedure [dbo].[sp_B_Usuario_EquipoByIdEquipo]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_B_Usuario_EquipoByPuntos]    Script Date: 26/04/2024 9:36:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_B_Usuario_EquipoByPuntos] 

	@idUsuario uniqueidentifier,	
	@top int,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;

	Declare @table table (idReto uniqueidentifier, idEquipo uniqueidentifier, totalUsuarios int, nombre varchar(60), puntos int, tiempo int, posicion int, imagen varchar(60), estado int)
	Declare @idEquipo uniqueidentifier, @puntos int, @tiempo int, @posicion int, @auxPos int = 0
	
	DECLARE positionEquipo CURSOR FOR 
	
	Select 		
	ue.idEquipo,
	ROW_NUMBER() OVER(ORDER BY e.puntos desc) AS 'posicion'	
	From Usuario_Reto ur 
	inner join Usuario_Equipo ue on ue.idUsuario = ur.idUsuario
	inner join Equipo e on e.idEquipo = ue.idEquipo 
	Where ur.tieneEquipo = 1 and ur.completado > 0
	Group by ue.idEquipo, ur.idReto, e.puntos, e.tiempo
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
		ur.idReto,
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
		Group by ue.idEquipo, ur.idReto, e.idEquipo, e.nombre, e.imagen, e.puntos, e.tiempo, e.estado
		Order by e.puntos desc, e.tiempo asc

	end
	else
	begin

		Insert into @table (idReto, idEquipo, totalUsuarios, nombre, puntos, tiempo, posicion, imagen, estado)
		Select top (@top)	
		ur.idReto,
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
		Group by ue.idEquipo, ur.idReto, e.idEquipo, e.nombre, e.imagen, e.puntos, e.tiempo, e.estado
		Order by e.puntos desc, e.tiempo asc

		Insert into @table (idReto, idEquipo, totalUsuarios, nombre, puntos, tiempo, posicion, imagen, estado)
		Select
		ur.idReto,
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
		Group by ue.idEquipo, ur.idReto, e.idEquipo, e.nombre, e.imagen, e.puntos, e.tiempo, e.estado
		Order by e.puntos desc, e.tiempo asc

		Select * from @table

	end

	print concat('La posición del equipo es: ', @auxPos)	
END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_Usuario_fechaLogin]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_B_Usuario_MedallaByIdUsuario]    Script Date: 26/04/2024 9:36:51 ******/
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
	
	declare @existeId int = 0
	Select @existeId = COUNT(*) From Usuario
	where idUsuario = @idUsuario
	
	if(@existeId > 0)
	begin

		if(@top > 0)
		begin 

			Select top (@top)
			um.idMedalla, 
			m.nombre, 
			ISNULL(m.imagen, 'N/A') as 'imagen',
			um.idUsuario, 
			um.fechaCreacion, 
			um.fechaModificacion  
			From Usuario_Medalla um
			inner join Medalla m on m.idMedalla = um.idMedalla
			Where um.idUsuario = @idUsuario
			Order by um.fechaCreacion desc

		end
		else 
		begin

			Select
			um.idMedalla, 
			m.nombre, 
			ISNULL(m.imagen, 'N/A') as 'imagen',
			um.idUsuario, 
			um.fechaCreacion, 
			um.fechaModificacion  
			From Usuario_Medalla um
			inner join Medalla m on m.idMedalla = um.idMedalla
			Where um.idUsuario = @idUsuario
			Order by um.fechaCreacion desc

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
/****** Object:  StoredProcedure [dbo].[sp_B_Usuario_NivelByIdUsuario]    Script Date: 26/04/2024 9:36:51 ******/
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
	
	declare @existeId int = 0
	Select @existeId = COUNT(*) From Usuario
	where idUsuario = @idUsuario
	
	if(@existeId > 0)
	begin

		if(@top > 0)
		begin 

			Select top (@top)
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
			Where idUsuario = @idUsuario
			Order by n.puntosNecesarios desc							

		end
		else 
		begin

			Select
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
			Where idUsuario = @idUsuario
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
/****** Object:  StoredProcedure [dbo].[sp_B_Usuario_NoticiaByIdNoticia]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_B_Usuario_RecompensaByIdUsuario]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_B_Usuario_RecompensaTotalUsuarios]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_B_Usuario_RedSocialByIdRed]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_B_Usuario_RetoByIdReto]    Script Date: 26/04/2024 9:36:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_B_Usuario_RetoByIdReto] 	

	@idReto uniqueidentifier,

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
	u.estado,
	ur.fechaCreacion,
	ur.fechaModificacion
	From  Usuario_Reto ur
	Inner Join Usuario u on ur.idUsuario = u.idUsuario
	Where ur.idReto = @idReto and ur.tieneEquipo = 0
	Order by ur.fechaCreacion desc
	
	-- ur.completado = 0	and
END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_Usuario_RetoByIdUsuario]    Script Date: 26/04/2024 9:36:51 ******/
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
	
	declare @existeId int = 0
	Select @existeId = COUNT(*) From Usuario
	where idUsuario = @idUsuario
	
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
		r.criterioMinimo,
		(select COUNT(*) from Pregunta p where p.idReto = r.idReto) as 'totalPreguntas', 		
		r.enEquipo,
		ur.completado,
		ur.puntos,
		ur.tiempo,
		ur.vidas,
		ur.fechaCreacion,
		ur.fechaModificacion
		From Usuario_Reto ur
		Inner Join  Reto r on r.idReto = ur.idReto
		Inner Join tipoReto tr on tr.idTipoReto = r.idTipoReto
		Inner Join ComportamientoPregunta cp on cp.idComportamiento = r.idComportamiento
		Where idUsuario = @idUsuario and (ur.completado = @completado or @completado = -1)
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
/****** Object:  StoredProcedure [dbo].[sp_B_Usuario_RetoByIdUsuarioByAll]    Script Date: 26/04/2024 9:36:51 ******/
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
	r.criterioMinimo,
	(select COUNT(*) from Pregunta p where p.idReto = r.idReto) as 'totalPreguntas', 
	r.enEquipo,		
	ur.completado,
	ur.puntos,
	ur.tiempo,
	ur.vidas,
	ur.fechaCreacion,
	ur.fechaModificacion
	From Usuario_Reto ur
	Inner Join  Reto r on r.idReto = ur.idReto
	Inner Join tipoReto tr on tr.idTipoReto = r.idTipoReto
	Inner Join ComportamientoPregunta cp on cp.idComportamiento = r.idComportamiento
	Where idUsuario = @idUsuario and (ur.completado = @completado or @completado = -1) and 
	(r.nombre like '%'+@buscar+'%' or
	r.enEquipo = case when @equipo like '%'+@buscar+'%' then '1'
					when @individual like '%'+@buscar+'%' then '0' end or
	r.vidas like '%'+@buscar+'%' or
	r.tiempo_ms like '%'+@buscar+'%' or
	r.puntosRecompensa like '%'+@buscar+'%' or
	r.creditosObtenidos like '%'+@buscar+'%' or
	r.instrucciones like '%'+@buscar+'%' or
	tr.nombre like '%'+@buscar+'%' or
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
/****** Object:  StoredProcedure [dbo].[sp_B_Usuario_RetoByIdUsuarioYIdReto]    Script Date: 26/04/2024 9:36:51 ******/
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
	
	declare @existeId int = 0
	Select @existeId = COUNT(*) From Usuario
	where idUsuario = @idUsuario
	
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
		r.idComportamiento,
		cp.nombre as 'comportamientoPregunta',		
		r.criterioMinimo,
		(select COUNT(*) from Pregunta p where p.idReto = r.idReto) as 'totalPreguntas', 
		r.enEquipo,		
		ur.completado,
		ur.puntos,
		ur.tiempo,
		ur.vidas,
		ur.fechaCreacion,
		ur.fechaModificacion
		From Usuario_Reto ur
		Inner Join  Reto r on r.idReto = ur.idReto
		Inner Join tipoReto tr on tr.idTipoReto = r.idTipoReto
		Inner Join ComportamientoPregunta cp on cp.idComportamiento = r.idComportamiento
		Where ur.idUsuario = @idUsuario and ur.idReto = @idReto and (ur.completado = @completado or @completado = -1)
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
/****** Object:  StoredProcedure [dbo].[sp_B_Usuario_RetoPtosMesesAños]    Script Date: 26/04/2024 9:36:51 ******/
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
		Where completado > 0
		Group by MONTH(fechaModificacion), YEAR(fechaModificacion)
		Order by MONTH(fechaModificacion) asc, YEAR(fechaModificacion) asc	

	end
	else
	begin

		Select SUM(puntos) as 'puntos', MONTH(fechaModificacion) as 'mes', YEAR(fechaModificacion) as 'año' 
		From Usuario_Reto 
		Where completado > 0 and idUsuario = @idUsuario
		Group by MONTH(fechaModificacion), YEAR(fechaModificacion)
		Order by MONTH(fechaModificacion) asc, YEAR(fechaModificacion) asc			

	end

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_Usuario_RetoSumaPuntos]    Script Date: 26/04/2024 9:36:51 ******/
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
	Where ur.completado > 0
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
		Where ur.completado > 0
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
		Where ur.completado > 0
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
		Where ur.completado > 0 and idUsuario = @idUsuario
		Group by ur.idUsuario
		Order by puntos desc, tiempo asc


		Select * from @table

	end	

	print concat('La posición del jugador es: ', @auxPos)	

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_UsuarioByAll]    Script Date: 26/04/2024 9:36:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_B_UsuarioByAll] 
		
	@buscar varchar(max),

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
	ISNULL(u.celular, 'N/A') as 'celular',
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
	u.nombre like '%'+@buscar+'%' or	
	u.apellido like '%'+@buscar+'%' or
	CONCAT(u.nombre,' ',u.apellido) like '%'+@buscar+'%' or
	CONCAT(u.apellido,' ',u.nombre) like '%'+@buscar+'%' or
	u.correo like '%'+@buscar+'%' or
	u.celular like '%'+@buscar+'%' or
	(select p.nombre from Pais p where p.idPais = c.idPais) like '%'+@buscar+'%' or
	c.nombre like '%'+@buscar+'%' or
	(select e.nombre from Empresa e where e.idEmpresa = a.idEmpresa) like '%'+@buscar+'%' or
	r.nombre like '%'+@buscar+'%'
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
/****** Object:  StoredProcedure [dbo].[sp_B_UsuarioByCorreo]    Script Date: 26/04/2024 9:36:51 ******/
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
		ISNULL(u.celular, 'N/A') as 'celular',
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
/****** Object:  StoredProcedure [dbo].[sp_B_UsuarioById]    Script Date: 26/04/2024 9:36:51 ******/
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

		if(@estado = -1)
		begin
			
			Select u.idUsuario,
			u.nombre,
			u.apellido,
			u.correo,
			u.id,
			u.clave,
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
			where u.idUsuario = @idUsuario

		end
		else
		begin
			
			Select u.idUsuario,
			u.nombre,
			u.apellido,
			u.correo,
			u.id,
			u.clave,
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
			where u.estado = @estado and u.idUsuario = @idUsuario

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
/****** Object:  StoredProcedure [dbo].[sp_B_UsuarioByRegister]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_C_Area]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_C_CategoriaNoticia]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_C_CategoriaRecompensa]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_C_Ciudad]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_C_Configuracion]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_C_Empresa]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_C_Equipo]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_C_Equipo_Reto]    Script Date: 26/04/2024 9:36:51 ******/
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
			@tieneEquipo = 1,
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
/****** Object:  StoredProcedure [dbo].[sp_C_Licencia]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_C_Medalla]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_C_Nivel]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_C_Noticia]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_C_Opcion]    Script Date: 26/04/2024 9:36:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_C_Opcion] 
		
	@nombre varchar(150),
	@correcta int, 	
	@idPregunta uniqueidentifier,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;

	Declare @tableId TABLE (id uniqueidentifier);
	Declare @contNombre int = 0, @contOpcion int = 0, @idOpcion uniqueidentifier
	Select @contNombre = COUNT(*), @idOpcion = idOpcion From Opcion Where idPregunta = @idPregunta and nombre = @nombre Group By idOpcion
	Select @contOpcion = COUNT(*) From Opcion Where idPregunta = @idPregunta
	

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
		
			if(@contOpcion < 4)
			begin						

				Insert Into Opcion (nombre, correcta, idPregunta) output inserted.idOpcion into @tableId values
				(NULLIF(@nombre, ''),
				case @correcta when '' then 0 else @correcta end,
				@idPregunta
				)									

				Select @info = descripcion From Constants Where nombre = 'exito_insert'
				set @error = 0
				select @id = id from @tableId				

			end
			else
			begin

				set @info = 'Solo se acepta máximo 4 opciones'
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
/****** Object:  StoredProcedure [dbo].[sp_C_Pais]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_C_Pregunta]    Script Date: 26/04/2024 9:36:51 ******/
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
	Declare @contNombre int = 0, @idPregunta uniqueidentifier
	select @contNombre = COUNT(*), @idPregunta = idPregunta from Pregunta where idReto = @idReto and nombre = @nombre group by idPregunta
	
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

	print @info
	print @id
END
GO
/****** Object:  StoredProcedure [dbo].[sp_C_Recompensa]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_C_RedSocial]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_C_Reto]    Script Date: 26/04/2024 9:36:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_C_Reto] 
		
	@nombre varchar(30),
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
	@enEquipo int,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;				

	Declare @contNombre int = 0, @cantMax int = 0, @cantReto int = 0
	Select @contNombre = COUNT(*) From Reto Where nombre = @nombre
	Select @cantReto = COUNT(*) from Reto

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
	else
	begin		
		
		BEGIN TRY  

			Insert into Reto (nombre, fechaApetura, fechaCierre, vidas, tiempo_ms, puntosRecompensa, creditosObtenidos, criterioMinimo, enEquipo, instrucciones, imagen, idTipoReto, idComportamiento) values
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
			@idComportamiento
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
/****** Object:  StoredProcedure [dbo].[sp_C_Usuario]    Script Date: 26/04/2024 9:36:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_C_Usuario] 

	@nombre varchar(23),
	@apellido varchar(23),
	@correo varchar(60),
	@idU varchar(20), -- es la cédula o pasaporte, etc, etc
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

			Insert into Usuario (nombre, apellido, correo, id, celular, foto, idRol, idCiudad, idArea, clave, puntos, creditos) values
			(NULLIF(@nombre, ''),
			NULLIF(@apellido, ''),
			NULLIF(@correo, ''),
			NULLIF(@idU, ''),
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
/****** Object:  StoredProcedure [dbo].[sp_C_Usuario_Equipo]    Script Date: 26/04/2024 9:36:51 ******/
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
					@tieneEquipo = 1,
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
/****** Object:  StoredProcedure [dbo].[sp_C_Usuario_EquipoByCorreoIds]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_C_Usuario_Medalla]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_C_Usuario_Nivel]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_C_Usuario_Noticia]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_C_Usuario_Recompensa]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_C_Usuario_RedSocial]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_C_Usuario_Reto]    Script Date: 26/04/2024 9:36:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_C_Usuario_Reto] 

	@correo varchar(60),
	@idReto uniqueidentifier,
	@tieneEquipo int,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output

AS
BEGIN

	SET NOCOUNT ON;		

	Declare @contCorreo int = 0, @contUsuario_Reto int = 0,  @idUsuario uniqueidentifier	
	Select @contCorreo = COUNT(*), @idUsuario = idUsuario from Usuario where correo = @correo group by idUsuario		
	Select @contUsuario_Reto = COUNT(*) from Usuario_Reto where idReto = @idReto and idUsuario = @idUsuario and tieneEquipo = @tieneEquipo

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

			Insert into Usuario_Reto (idUsuario, idReto, puntos, tiempo, vidas, tieneEquipo) values
			(@idUsuario,
			@idReto,
			0,0,0,
			@tieneEquipo
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
/****** Object:  StoredProcedure [dbo].[sp_C_Usuario_RetoByCorreoIds]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_D_Equipo]    Script Date: 26/04/2024 9:36:51 ******/
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

	Declare @table table (idUsuario uniqueidentifier)
	Declare @contIdEquipo int = 0, @imagen varchar(50) = 'N/A', @idUsuario uniqueidentifier
	Select @contIdEquipo = COUNT(*), @imagen = ISNULL(imagen, 'N/A') From Equipo Where idEquipo = @idEquipo group by imagen		

	DECLARE idsUsuarios CURSOR FOR 

	Select idUsuario from Usuario_Equipo where idEquipo = @idEquipo

	OPEN idsUsuarios
	FETCH NEXT FROM idsUsuarios INTO @idUsuario
	WHILE @@fetch_status = 0
	BEGIN		

		insert into @table (idUsuario) values
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

			Delete from Usuario_Reto
			where tieneEquipo = 1 and idUsuario in (select idUsuario from @table)
			
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
/****** Object:  StoredProcedure [dbo].[sp_D_Equipo_Reto]    Script Date: 26/04/2024 9:36:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_D_Equipo_Reto] 
	
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

			Delete from Usuario_Reto where tieneEquipo = 1 and idReto = @idReto and idUsuario in (select idUsuario from @table)

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
/****** Object:  StoredProcedure [dbo].[sp_D_InicioByNoIds]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_D_Medalla]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_D_Nivel]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_D_Noticia]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_D_Opcion]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_D_OpcionByNoIds]    Script Date: 26/04/2024 9:36:51 ******/
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

	Delete From Opcion 
	Where idPregunta = @idPregunta and idOpcion not in (select value from string_split(@ids,'|'))  
	
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
/****** Object:  StoredProcedure [dbo].[sp_D_Pregunta]    Script Date: 26/04/2024 9:36:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_D_Pregunta] 

	@idPregunta uniqueidentifier,
	
	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;
	
	Declare @contIdPregunta int = 0
	Select @contIdPregunta = COUNT(*) From Pregunta where idPregunta = @idPregunta
	
	
	if(@contIdPregunta = 0)
	begin

		set @info = 'No existe la Pregunta'
		set @error = 1

	end	
	else
	begin
		
		BEGIN TRY  
			
			Delete From Opcion
			Where idPregunta = @idPregunta

			Delete From Pregunta
			Where idPregunta = @idPregunta
			
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
/****** Object:  StoredProcedure [dbo].[sp_D_Recompensa]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_D_Reto]    Script Date: 26/04/2024 9:36:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_D_Reto] 
	
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
				--PRINT @idPregunta
				Delete from Opcion where idPregunta = @idPregunta;

				FETCH NEXT FROM cur_pregunta INTO @idPregunta
			END
			CLOSE cur_pregunta
			DEALLOCATE cur_pregunta
			-- FIN CURSOR			

			Delete From Pregunta 
			where idReto = @idReto

			Delete From Puzzle 
			where idReto = @idReto			

			Delete From Usuario_Reto 
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
/****** Object:  StoredProcedure [dbo].[sp_D_Usuario_Equipo]    Script Date: 26/04/2024 9:36:51 ******/
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

			Delete from Usuario_Reto
			Where idUsuario = @idUsuario and tieneEquipo = 1

			Delete from Usuario_Equipo 
			where idEquipo = @idEquipo and idUsuario = @idUsuario

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
/****** Object:  StoredProcedure [dbo].[sp_D_Usuario_Reto]    Script Date: 26/04/2024 9:36:51 ******/
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

			Delete from Usuario_Reto where idReto = @idReto and idUsuario = @idUsuario and tieneEquipo = 0

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
/****** Object:  StoredProcedure [dbo].[sp_U_Area]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_U_CategoriaNoticia]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_U_CategoriaRecompensa]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_U_Ciudad]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_U_Configuracion]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_U_Empresa]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_U_Equipo]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_U_EquipoByEstado]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_U_Inicio]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_U_Medalla]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_U_Nivel]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_U_Noticia]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_U_Notificacion]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_U_NotificacionByEstado]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_U_Opcion]    Script Date: 26/04/2024 9:36:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_U_Opcion] 
	
	@idOpcion uniqueidentifier,
	@nombre varchar(150),
	@correcta int,	
	@idPregunta uniqueidentifier,

	@error int output,
	@info varchar(max) output,
	@id varchar(max) output
AS
BEGIN		

	SET NOCOUNT ON;	
	Declare @contIdOpcion int = 0, @info_C_opcion varchar(max), @error_C_opcion int, @id_C_opcion varchar(max)
	Select @contIdOpcion = COUNT(*) From Opcion Where idOpcion = @idOpcion

	if(@contIdOpcion > 0)
	begin
		
		BEGIN TRY  
			Update Opcion set 
			nombre = NULLIF(@nombre, ''),
			correcta = case @correcta when '' then 0 else @correcta end,
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
		@idPregunta = @idPregunta,	
		@info = @info_C_opcion output,
		@error = @error_C_opcion output,
		@id = @id_C_opcion output
		
		set @info = @info_C_opcion
		set @error = @error_C_opcion
		set @id = @id_C_opcion

	end		
	

END
GO
/****** Object:  StoredProcedure [dbo].[sp_U_Pais]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_U_Pregunta]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_U_Recompensa]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_U_RecompensaByEstado]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_U_Reto]    Script Date: 26/04/2024 9:36:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_U_Reto] 
		
	@idReto uniqueidentifier,
	@nombre varchar(30),
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

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;				

	Declare @contNombre int = 0, @contIdReto int = 0, @oldImage varchar(50) = 'N/A'
	Select @contNombre = COUNT(*) From Reto Where nombre = @nombre and idReto <> @idReto
	Select @contIdReto = COUNT(*), @oldImage = ISNULL(imagen, 'N/A') From Reto where idReto = @idReto group by imagen
	
	if(@contNombre > 0)
	begin

		set @info = 'El nombre ya esta registrado'
		set @error = 1

	end
	else
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
			idTipoReto = @idTipoReto,
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

	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_U_RetoByEstado]    Script Date: 26/04/2024 9:36:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_U_RetoByEstado] 

	@idReto uniqueidentifier,
	@estado int,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;	

	declare @contIdR int = 0
	Select @contIdR = COUNT(*) from Reto where idReto = @idReto	
	
	if(@contIdR = 0)
	begin

		set @info = 'No se encontró el id del Reto'
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
/****** Object:  StoredProcedure [dbo].[sp_U_Usuario]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_U_Usuario_Reto]    Script Date: 26/04/2024 9:36:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_U_Usuario_Reto] 

	@idUsuario varchar(60),
	@idReto uniqueidentifier,
	@puntos int,
	@tiempo int,
	@vidas int,	
	@completado int,	

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output

AS
BEGIN

	SET NOCOUNT ON;			

	Declare @contUsuarioReto int = 0
	Select @contUsuarioReto = COUNT(*) from Usuario_Reto where idReto = @idReto and idUsuario = @idUsuario 

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
			fechaModificacion = GETDATE()
			Where idReto = @idReto and idUsuario = @idUsuario		
		
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
/****** Object:  StoredProcedure [dbo].[sp_U_UsuarioByEstado]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_U_UsuarioByFoto]    Script Date: 26/04/2024 9:36:51 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_U_UsuarioEstadoByCorreoIds]    Script Date: 26/04/2024 9:36:51 ******/
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

USE [Evolution_db]
GO
/****** Object:  Table [dbo].[Area]    Script Date: 19/12/2023 17:58:22 ******/
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
/****** Object:  Table [dbo].[CategoriaNoticia]    Script Date: 19/12/2023 17:58:22 ******/
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
/****** Object:  Table [dbo].[Ciudad]    Script Date: 19/12/2023 17:58:22 ******/
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
/****** Object:  Table [dbo].[ComportamientoPregunta]    Script Date: 19/12/2023 17:58:22 ******/
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
/****** Object:  Table [dbo].[Condicion]    Script Date: 19/12/2023 17:58:22 ******/
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
/****** Object:  Table [dbo].[Configuracion]    Script Date: 19/12/2023 17:58:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Configuracion](
	[idConfig] [uniqueidentifier] NOT NULL,
	[tipo] [varchar](10) NOT NULL,
	[propiedad] [varchar](40) NULL,
	[nombre] [varchar](30) NOT NULL,
	[valor] [varchar](50) NOT NULL,
	[descripcion] [varchar](250) NULL,
	[idUsuario] [uniqueidentifier] NOT NULL,
	[fechaCreacion] [datetime] NULL,
	[fechaModificacion] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[idConfig] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Constants]    Script Date: 19/12/2023 17:58:22 ******/
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
/****** Object:  Table [dbo].[Empresa]    Script Date: 19/12/2023 17:58:22 ******/
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
/****** Object:  Table [dbo].[Medalla]    Script Date: 19/12/2023 17:58:22 ******/
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
PRIMARY KEY CLUSTERED 
(
	[idMedalla] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Nivel]    Script Date: 19/12/2023 17:58:22 ******/
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
/****** Object:  Table [dbo].[Noticia]    Script Date: 19/12/2023 17:58:22 ******/
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
/****** Object:  Table [dbo].[Opcion]    Script Date: 19/12/2023 17:58:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Opcion](
	[idOpcion] [uniqueidentifier] NOT NULL,
	[nombre] [varchar](150) NOT NULL,
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
/****** Object:  Table [dbo].[Pais]    Script Date: 19/12/2023 17:58:22 ******/
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
/****** Object:  Table [dbo].[Pregunta]    Script Date: 19/12/2023 17:58:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pregunta](
	[idPregunta] [uniqueidentifier] NOT NULL,
	[nombre] [varchar](150) NOT NULL,
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
/****** Object:  Table [dbo].[Puzzle]    Script Date: 19/12/2023 17:58:22 ******/
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
/****** Object:  Table [dbo].[Recompensa]    Script Date: 19/12/2023 17:58:22 ******/
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
PRIMARY KEY CLUSTERED 
(
	[idRecompensa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RedSocial]    Script Date: 19/12/2023 17:58:22 ******/
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
/****** Object:  Table [dbo].[Reto]    Script Date: 19/12/2023 17:58:22 ******/
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
PRIMARY KEY CLUSTERED 
(
	[idReto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Rol]    Script Date: 19/12/2023 17:58:22 ******/
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
/****** Object:  Table [dbo].[tipoReto]    Script Date: 19/12/2023 17:58:22 ******/
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
/****** Object:  Table [dbo].[Usuario]    Script Date: 19/12/2023 17:58:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuario](
	[idUsuario] [uniqueidentifier] NOT NULL,
	[nombre] [varchar](23) NOT NULL,
	[apellido] [varchar](23) NOT NULL,
	[correo] [varchar](60) NULL,
	[celular] [varchar](15) NULL,
	[foto] [varchar](50) NULL,
	[estado] [int] NULL,
	[idRol] [varchar](9) NOT NULL,
	[idArea] [uniqueidentifier] NULL,
	[fechaCreacion] [datetime] NULL,
	[fechaModificacion] [datetime] NULL,
	[clave] [varbinary](max) NOT NULL,
	[idCiudad] [uniqueidentifier] NULL,
PRIMARY KEY CLUSTERED 
(
	[idUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuario_Medalla]    Script Date: 19/12/2023 17:58:22 ******/
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
/****** Object:  Table [dbo].[Usuario_Nivel]    Script Date: 19/12/2023 17:58:22 ******/
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
/****** Object:  Table [dbo].[Usuario_Noticia]    Script Date: 19/12/2023 17:58:22 ******/
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
/****** Object:  Table [dbo].[Usuario_Recompensa]    Script Date: 19/12/2023 17:58:22 ******/
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
/****** Object:  Table [dbo].[Usuario_RedSocial]    Script Date: 19/12/2023 17:58:22 ******/
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
/****** Object:  Table [dbo].[Usuario_Reto]    Script Date: 19/12/2023 17:58:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuario_Reto](
	[idReto] [uniqueidentifier] NOT NULL,
	[idUsuario] [uniqueidentifier] NOT NULL,
	[puntos] [int] NULL,
	[tiempo] [int] NULL,
	[vidas] [int] NULL,
	[fechaCreacion] [datetime] NULL,
	[fechaModificacion] [datetime] NULL
) ON [PRIMARY]
GO
INSERT [dbo].[Area] ([idArea], [nombre], [descripcion], [estado], [fechaCreacion], [fechaModificacion], [idEmpresa]) VALUES (N'914784e1-b67c-4e57-b53a-209f99944985', N'Desarrollo Multimedia', NULL, 1, CAST(N'2023-12-13T17:40:15.660' AS DateTime), CAST(N'2023-12-13T17:40:15.660' AS DateTime), N'4e87c6cd-992a-4f14-90c8-cb7bfd4b2dba')
GO
INSERT [dbo].[Area] ([idArea], [nombre], [descripcion], [estado], [fechaCreacion], [fechaModificacion], [idEmpresa]) VALUES (N'1b837374-0533-4885-af06-a3af2d6e3b50', N'preubn edit', N'Este es solo para la prueba', 1, CAST(N'2023-12-13T17:50:36.960' AS DateTime), CAST(N'2023-12-13T17:50:36.960' AS DateTime), N'4e87c6cd-992a-4f14-90c8-cb7bfd4b2dba')
GO
INSERT [dbo].[Area] ([idArea], [nombre], [descripcion], [estado], [fechaCreacion], [fechaModificacion], [idEmpresa]) VALUES (N'9452289a-57ca-4d8b-8618-cbd785690951', N'Preuab1', N'Este es solo para la prueba1', 1, CAST(N'2023-12-19T16:13:20.073' AS DateTime), CAST(N'2023-12-19T16:13:20.073' AS DateTime), N'4e87c6cd-992a-4f14-90c8-cb7bfd4b2dba')
GO
INSERT [dbo].[Area] ([idArea], [nombre], [descripcion], [estado], [fechaCreacion], [fechaModificacion], [idEmpresa]) VALUES (N'b7fc947e-8db6-415d-b361-e0c41fcc8344', N'Asistente de Tics', NULL, 1, CAST(N'2023-12-13T17:21:13.180' AS DateTime), CAST(N'2023-12-13T17:21:13.180' AS DateTime), N'4e87c6cd-992a-4f14-90c8-cb7bfd4b2dba')
GO
INSERT [dbo].[CategoriaNoticia] ([idCategoria], [nombre], [descripcion], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'65e3ec0d-24d9-4f06-9b9c-de5f21c925ae', N'Culturales', N'Cuando se refieren a sucesos de la vida artística, literaria y cultural del país.', 1, CAST(N'2023-12-13T14:49:22.407' AS DateTime), CAST(N'2023-12-13T14:49:22.407' AS DateTime))
GO
INSERT [dbo].[CategoriaNoticia] ([idCategoria], [nombre], [descripcion], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'622ff0ac-4ec0-461f-8eda-f8a487f80eb3', N'Científicas', NULL, 1, CAST(N'2023-12-12T15:45:48.870' AS DateTime), CAST(N'2023-12-12T15:45:48.870' AS DateTime))
GO
INSERT [dbo].[Ciudad] ([idCiudad], [nombre], [descripcion], [idPais], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'48632ff5-b6f9-45f0-a514-c0a5ec544226', N'Quito', NULL, N'1e539fef-7e19-4248-bd2c-d19b79726b0a', 1, CAST(N'2023-12-15T12:21:51.743' AS DateTime), CAST(N'2023-12-15T12:21:51.743' AS DateTime))
GO
INSERT [dbo].[Ciudad] ([idCiudad], [nombre], [descripcion], [idPais], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'679fdc16-b347-4a5b-b7b6-f00e92786c7f', N'ciudad edit', N'edit', N'd0a947c1-149a-4747-9a58-272f3eed7480', 1, CAST(N'2023-12-15T12:30:44.057' AS DateTime), CAST(N'2023-12-15T12:32:26.393' AS DateTime))
GO
INSERT [dbo].[ComportamientoPregunta] ([idComportamiento], [nombre], [descripcion], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'1dd28d88-34c7-4394-ab3d-525726001730', N'Aleatorio', N'Es para que se muestren de forma aleatoria las preguntas', 1, CAST(N'2023-12-16T10:23:46.323' AS DateTime), CAST(N'2023-12-16T10:23:46.323' AS DateTime))
GO
INSERT [dbo].[ComportamientoPregunta] ([idComportamiento], [nombre], [descripcion], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'cce31bb2-f39c-4328-823b-ef32e5bd8ca1', N'Normal', N'las preguntas se van a mostrar normalmente', 1, CAST(N'2023-12-16T10:23:46.323' AS DateTime), CAST(N'2023-12-16T10:23:46.323' AS DateTime))
GO
INSERT [dbo].[Condicion] ([idCondicion], [nombre], [descripcion], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'9314413a-5e41-49c5-b82d-14f616e94331', N'primero ranking', N'Ser el primero en el Ranking', 1, CAST(N'2023-12-12T11:23:49.307' AS DateTime), CAST(N'2023-12-12T11:23:49.307' AS DateTime))
GO
INSERT [dbo].[Condicion] ([idCondicion], [nombre], [descripcion], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'5f908fdb-6b0d-4903-ad1f-76826511c8a5', N'5 retos', N'Haber completado 5 retos en una semana', 1, CAST(N'2023-12-12T11:23:49.307' AS DateTime), CAST(N'2023-12-12T11:23:49.307' AS DateTime))
GO
INSERT [dbo].[Condicion] ([idCondicion], [nombre], [descripcion], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'2439150e-8525-4582-8203-9d1d2ac93739', N'5 puntos', N'tener al menos 5 puntos', 1, CAST(N'2023-12-12T11:23:49.307' AS DateTime), CAST(N'2023-12-12T11:23:49.307' AS DateTime))
GO
INSERT [dbo].[Configuracion] ([idConfig], [tipo], [propiedad], [nombre], [valor], [descripcion], [idUsuario], [fechaCreacion], [fechaModificacion]) VALUES (N'08e721ca-f201-4fa4-88ef-4d8c185e2109', N'imagen', NULL, N'Home', N'casita.jpg', NULL, N'939c9c6d-9dcf-4b7e-bea6-5c26169fa066', CAST(N'2023-12-14T11:35:42.520' AS DateTime), CAST(N'2023-12-14T11:35:42.520' AS DateTime))
GO
INSERT [dbo].[Configuracion] ([idConfig], [tipo], [propiedad], [nombre], [valor], [descripcion], [idUsuario], [fechaCreacion], [fechaModificacion]) VALUES (N'453657da-cc12-403d-888f-96d72035a4c0', N'color', N'--ColorBotonSecundario', N'boton secundario', N'#4CBB23', NULL, N'939c9c6d-9dcf-4b7e-bea6-5c26169fa066', CAST(N'2023-12-14T12:39:54.963' AS DateTime), CAST(N'2023-12-14T12:46:32.377' AS DateTime))
GO
INSERT [dbo].[Configuracion] ([idConfig], [tipo], [propiedad], [nombre], [valor], [descripcion], [idUsuario], [fechaCreacion], [fechaModificacion]) VALUES (N'72da4b34-3b78-49ea-8cd5-ccca8b923a8f', N'imagen', NULL, N'Login', N'login.jpg', NULL, N'939c9c6d-9dcf-4b7e-bea6-5c26169fa066', CAST(N'2023-12-14T11:34:06.120' AS DateTime), CAST(N'2023-12-14T11:34:06.120' AS DateTime))
GO
INSERT [dbo].[Configuracion] ([idConfig], [tipo], [propiedad], [nombre], [valor], [descripcion], [idUsuario], [fechaCreacion], [fechaModificacion]) VALUES (N'9f4d3868-a6a8-4e02-8f7f-e8997793d257', N'color', N'--ColorBotonPrimario', N'boton primario', N'#123E66', NULL, N'939c9c6d-9dcf-4b7e-bea6-5c26169fa066', CAST(N'2023-12-14T11:33:15.100' AS DateTime), CAST(N'2023-12-14T11:33:15.100' AS DateTime))
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
INSERT [dbo].[Empresa] ([idEmpresa], [nombre], [descripcion], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'c99ec2bd-7c18-499c-878a-5ee9ab6fe8c7', N'Prueba ediado', N'editado desc', 1, CAST(N'2023-12-15T10:51:14.030' AS DateTime), CAST(N'2023-12-15T10:52:24.913' AS DateTime))
GO
INSERT [dbo].[Empresa] ([idEmpresa], [nombre], [descripcion], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'4e87c6cd-992a-4f14-90c8-cb7bfd4b2dba', N'Digimentore', NULL, 1, CAST(N'2023-12-14T10:14:01.260' AS DateTime), CAST(N'2023-12-14T10:14:01.260' AS DateTime))
GO
INSERT [dbo].[Empresa] ([idEmpresa], [nombre], [descripcion], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'1cb1db77-b372-43d8-9fa1-eb64fa7b9cdd', N'Dinamica Mercados', NULL, 1, CAST(N'2023-12-15T10:44:49.083' AS DateTime), CAST(N'2023-12-15T10:44:49.083' AS DateTime))
GO
INSERT [dbo].[Medalla] ([idMedalla], [nombre], [descripcion], [imagen], [estado], [idCondicion], [fechaCreacion], [fechaModificacion]) VALUES (N'64c746d6-1607-489e-943e-3c64a6617a9c', N'medalla 1', NULL, NULL, 1, N'9314413a-5e41-49c5-b82d-14f616e94331', CAST(N'2023-12-12T11:28:49.580' AS DateTime), CAST(N'2023-12-12T11:28:49.580' AS DateTime))
GO
INSERT [dbo].[Medalla] ([idMedalla], [nombre], [descripcion], [imagen], [estado], [idCondicion], [fechaCreacion], [fechaModificacion]) VALUES (N'26763eaa-657d-4e10-bd82-78d29934c607', N'medalla 2', NULL, NULL, 1, N'5f908fdb-6b0d-4903-ad1f-76826511c8a5', CAST(N'2023-12-12T11:29:41.607' AS DateTime), CAST(N'2023-12-12T11:29:41.607' AS DateTime))
GO
INSERT [dbo].[Medalla] ([idMedalla], [nombre], [descripcion], [imagen], [estado], [idCondicion], [fechaCreacion], [fechaModificacion]) VALUES (N'2eb8768c-f1ae-49be-83e0-b04c39eb64c2', N'medalla', N'desc 1', NULL, 1, N'2439150e-8525-4582-8203-9d1d2ac93739', CAST(N'2023-12-12T11:58:46.920' AS DateTime), CAST(N'2023-12-12T11:58:46.920' AS DateTime))
GO
INSERT [dbo].[Nivel] ([idNivel], [nombre], [descripcion], [puntosNecesarios], [imagen], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'34fa60b2-4fcd-49a8-bebb-198e7a343cfa', N'nivel 3', NULL, 25, NULL, 1, CAST(N'2023-12-11T16:13:01.443' AS DateTime), CAST(N'2023-12-11T16:13:01.443' AS DateTime))
GO
INSERT [dbo].[Nivel] ([idNivel], [nombre], [descripcion], [puntosNecesarios], [imagen], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'cf68ecd4-fe5c-4e11-9aab-69514424fd1b', N'nivel 4', N'este es para el nivel 4', 10, NULL, 1, CAST(N'2023-12-11T16:50:33.887' AS DateTime), CAST(N'2023-12-11T16:50:33.887' AS DateTime))
GO
INSERT [dbo].[Nivel] ([idNivel], [nombre], [descripcion], [puntosNecesarios], [imagen], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'62629073-7cc1-4ad3-82f1-b57a823e0092', N'nivel 1', NULL, 23, NULL, 1, CAST(N'2023-12-11T16:13:01.443' AS DateTime), CAST(N'2023-12-11T16:13:01.443' AS DateTime))
GO
INSERT [dbo].[Nivel] ([idNivel], [nombre], [descripcion], [puntosNecesarios], [imagen], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'21fdd88c-9f5d-4c84-97fc-c11378d7169b', N'nivel 2', NULL, 24, NULL, 1, CAST(N'2023-12-11T16:13:01.443' AS DateTime), CAST(N'2023-12-11T16:13:01.443' AS DateTime))
GO
INSERT [dbo].[Noticia] ([idNoticia], [titular], [descripcion], [url], [imagen], [estado], [idCategoria], [fechaPublicacion], [fechaCreacion], [fechaModificacion]) VALUES (N'70114d2e-1ba0-4251-a626-1cfdfdce6a40', N'titular de prueba', N'descripcion de prueba', NULL, NULL, 1, N'622ff0ac-4ec0-461f-8eda-f8a487f80eb3', NULL, CAST(N'2023-12-12T16:37:49.343' AS DateTime), CAST(N'2023-12-12T16:37:49.343' AS DateTime))
GO
INSERT [dbo].[Noticia] ([idNoticia], [titular], [descripcion], [url], [imagen], [estado], [idCategoria], [fechaPublicacion], [fechaCreacion], [fechaModificacion]) VALUES (N'7cf3f854-abe0-4033-bd63-4a94dc7daf1a', N'A los enfermos de cáncer lo que nos cura es la investigación', N'Pacientes e investigadores se han encontrado hoy en un evento de la Asociación contra el Cáncer de Bizkaia. Subrayan que la lucha contra el cáncer avanza, aunque la "tarea pendiente" sigue siendo la metástasis. Es fundamental, añaden, una "financiación correcta" para poder avanzar a mejor ritmo.', NULL, NULL, 1, N'622ff0ac-4ec0-461f-8eda-f8a487f80eb3', NULL, CAST(N'2023-12-12T15:59:53.020' AS DateTime), CAST(N'2023-12-12T15:59:53.020' AS DateTime))
GO
INSERT [dbo].[Noticia] ([idNoticia], [titular], [descripcion], [url], [imagen], [estado], [idCategoria], [fechaPublicacion], [fechaCreacion], [fechaModificacion]) VALUES (N'e1f0d39f-a8f3-4297-9429-9a89dd88ee7d', N'titular 3  de prueba', N'descripcion 3  de prueba', NULL, NULL, 1, N'622ff0ac-4ec0-461f-8eda-f8a487f80eb3', CAST(N'2023-12-23T00:00:00.000' AS DateTime), CAST(N'2023-12-12T17:08:23.647' AS DateTime), CAST(N'2023-12-12T17:08:23.647' AS DateTime))
GO
INSERT [dbo].[Noticia] ([idNoticia], [titular], [descripcion], [url], [imagen], [estado], [idCategoria], [fechaPublicacion], [fechaCreacion], [fechaModificacion]) VALUES (N'c42b6a36-67b7-486b-85ed-dbbb4436d1db', N'titular 2  de prueba', N'descripcion 2  de prueba', NULL, NULL, 1, N'622ff0ac-4ec0-461f-8eda-f8a487f80eb3', NULL, CAST(N'2023-12-12T17:03:46.660' AS DateTime), CAST(N'2023-12-12T17:03:46.660' AS DateTime))
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion]) VALUES (N'ef500eb8-cd6d-48a2-b796-0ef6297363c8', N'Quito', 1, 1, N'efe6e2f4-091c-4b53-958c-cc1edc252445', CAST(N'2023-12-16T12:20:41.217' AS DateTime), CAST(N'2023-12-18T09:39:14.510' AS DateTime))
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion]) VALUES (N'3fdaa1d4-2742-4104-afdc-33be02ff2a7e', N'25', 0, 1, N'7178dea1-9a99-475f-9f42-32a77ff81dd0', CAST(N'2023-12-16T12:07:21.160' AS DateTime), CAST(N'2023-12-16T12:07:21.160' AS DateTime))
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion]) VALUES (N'd5bdf0fa-2dc3-4968-b296-4c1161e47199', N'29', 0, 1, N'7178dea1-9a99-475f-9f42-32a77ff81dd0', CAST(N'2023-12-16T16:10:37.120' AS DateTime), CAST(N'2023-12-16T16:10:37.120' AS DateTime))
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion]) VALUES (N'8ee73190-c353-420b-9453-92c1e9f075e6', N'Ambato', 0, 1, N'efe6e2f4-091c-4b53-958c-cc1edc252445', CAST(N'2023-12-16T12:20:41.217' AS DateTime), CAST(N'2023-12-18T13:02:59.760' AS DateTime))
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion]) VALUES (N'c9ebb4f2-52cc-4819-a340-97a18b58f828', N'Guayaquil', 0, 1, N'efe6e2f4-091c-4b53-958c-cc1edc252445', CAST(N'2023-12-18T09:39:37.533' AS DateTime), CAST(N'2023-12-18T09:39:45.603' AS DateTime))
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion]) VALUES (N'da16e0d7-d96c-4d72-bda9-c78eaaec5ee7', N'23', 0, 1, N'7178dea1-9a99-475f-9f42-32a77ff81dd0', CAST(N'2023-12-16T12:07:21.160' AS DateTime), CAST(N'2023-12-16T12:07:21.160' AS DateTime))
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion]) VALUES (N'7a0babc2-ae84-4ff5-b3da-e488b43abe66', N'Tulcan', 0, 1, N'efe6e2f4-091c-4b53-958c-cc1edc252445', CAST(N'2023-12-16T12:20:41.217' AS DateTime), CAST(N'2023-12-16T12:20:41.217' AS DateTime))
GO
INSERT [dbo].[Opcion] ([idOpcion], [nombre], [correcta], [estado], [idPregunta], [fechaCreacion], [fechaModificacion]) VALUES (N'a5c180c5-b0e7-4c49-84e2-fbc30edf2635', N'27', 1, 1, N'7178dea1-9a99-475f-9f42-32a77ff81dd0', CAST(N'2023-12-16T12:07:21.160' AS DateTime), CAST(N'2023-12-16T12:07:21.160' AS DateTime))
GO
INSERT [dbo].[Pais] ([idPais], [nombre], [descripcion], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'd0a947c1-149a-4747-9a58-272f3eed7480', N'pais prueba edit', N'este es para la prueba', 1, CAST(N'2023-12-15T11:40:45.600' AS DateTime), CAST(N'2023-12-15T12:32:20.630' AS DateTime))
GO
INSERT [dbo].[Pais] ([idPais], [nombre], [descripcion], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'1e539fef-7e19-4248-bd2c-d19b79726b0a', N'Ecuador', NULL, 1, CAST(N'2023-12-15T11:31:31.193' AS DateTime), CAST(N'2023-12-15T11:31:31.193' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'7178dea1-9a99-475f-9f42-32a77ff81dd0', N'¿Cuantos años tengo?', 1, N'21a9d4c2-0ead-4cc5-b4c7-1c264676dd30', CAST(N'2023-12-16T12:03:57.847' AS DateTime), CAST(N'2023-12-16T12:03:57.847' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'4d060801-0692-4be7-8559-52756b101caa', N'¿Esta es una pregunta de prueba editada?', 1, N'21a9d4c2-0ead-4cc5-b4c7-1c264676dd30', CAST(N'2023-12-18T12:05:14.090' AS DateTime), CAST(N'2023-12-18T12:33:20.203' AS DateTime))
GO
INSERT [dbo].[Pregunta] ([idPregunta], [nombre], [estado], [idReto], [fechaCreacion], [fechaModificacion]) VALUES (N'efe6e2f4-091c-4b53-958c-cc1edc252445', N'¿Cual es la capital del Ecuador?', 1, N'21a9d4c2-0ead-4cc5-b4c7-1c264676dd30', CAST(N'2023-12-16T12:19:23.667' AS DateTime), CAST(N'2023-12-16T12:19:23.667' AS DateTime))
GO
INSERT [dbo].[Recompensa] ([idRecompensa], [nombre], [descripcion], [imagen], [cantDisponible], [cantCanje], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'56d57b18-2afe-46a9-822b-9540eb4f8e6a', N'Tomatodo personalizado', NULL, NULL, 47, 10, 1, CAST(N'2023-12-12T12:34:34.027' AS DateTime), CAST(N'2023-12-12T12:34:34.027' AS DateTime))
GO
INSERT [dbo].[Recompensa] ([idRecompensa], [nombre], [descripcion], [imagen], [cantDisponible], [cantCanje], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'91f482c6-59a5-450f-a09a-9c745b861339', N'10 entradas al cine', NULL, NULL, 0, 5, 1, CAST(N'2023-12-12T12:58:13.280' AS DateTime), CAST(N'2023-12-12T12:58:13.280' AS DateTime))
GO
INSERT [dbo].[Recompensa] ([idRecompensa], [nombre], [descripcion], [imagen], [cantDisponible], [cantCanje], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'cc0b9551-17e1-453a-9ffa-d0ef55f02f70', N'rec', NULL, NULL, 0, 0, 1, CAST(N'2023-12-12T12:54:08.537' AS DateTime), CAST(N'2023-12-12T12:54:08.537' AS DateTime))
GO
INSERT [dbo].[RedSocial] ([idRed], [descripcion], [imagen], [estado], [fechaPublicacion], [fechaCreacion], [fechaModificacion]) VALUES (N'42c1822c-3ed4-4d06-bbe2-b8f180344c7a', N'Hola mundo', NULL, 1, NULL, CAST(N'2023-12-13T16:23:17.497' AS DateTime), CAST(N'2023-12-13T16:23:17.497' AS DateTime))
GO
INSERT [dbo].[RedSocial] ([idRed], [descripcion], [imagen], [estado], [fechaPublicacion], [fechaCreacion], [fechaModificacion]) VALUES (N'e7d76e78-ce50-4712-aabf-fbc79ea3cb46', N'esta es una prueba de publicacion en la red social', NULL, 1, CAST(N'2023-12-24T00:00:00.000' AS DateTime), CAST(N'2023-12-13T15:54:25.347' AS DateTime), CAST(N'2023-12-13T15:54:25.347' AS DateTime))
GO
INSERT [dbo].[Reto] ([idReto], [nombre], [fechaApetura], [fechaCierre], [estado], [vidas], [tiempo_ms], [puntosRecompensa], [creditosObtenidos], [instrucciones], [imagen], [idTipoReto], [idComportamiento], [fechaCreacion], [fechaModificacion]) VALUES (N'81642c08-9711-469b-b831-18c682b5122a', N'mi segundo reto editado', CAST(N'2023-12-29T00:00:00.000' AS DateTime), CAST(N'2023-12-31T00:00:00.000' AS DateTime), 1, 4, 50000, 12, 17, NULL, NULL, N'63aa060b-cde4-49c0-9d60-aaf069df1533', N'1dd28d88-34c7-4394-ab3d-525726001730', CAST(N'2023-12-18T13:08:57.850' AS DateTime), CAST(N'2023-12-18T14:45:58.650' AS DateTime))
GO
INSERT [dbo].[Reto] ([idReto], [nombre], [fechaApetura], [fechaCierre], [estado], [vidas], [tiempo_ms], [puntosRecompensa], [creditosObtenidos], [instrucciones], [imagen], [idTipoReto], [idComportamiento], [fechaCreacion], [fechaModificacion]) VALUES (N'21a9d4c2-0ead-4cc5-b4c7-1c264676dd30', N'Mi primer reto', CAST(N'2023-12-16T00:00:00.000' AS DateTime), CAST(N'2023-12-17T00:00:00.000' AS DateTime), 1, 3, 300000, 10, 5, NULL, NULL, N'63aa060b-cde4-49c0-9d60-aaf069df1533', N'1dd28d88-34c7-4394-ab3d-525726001730', CAST(N'2023-12-16T11:56:55.380' AS DateTime), CAST(N'2023-12-16T11:56:55.380' AS DateTime))
GO
INSERT [dbo].[Rol] ([idRol], [nombre], [descripcion], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'adm', N'Administrador', N'Este rol es para el administrador', 1, CAST(N'2023-11-30T10:24:19.633' AS DateTime), CAST(N'2023-11-30T10:24:19.633' AS DateTime))
GO
INSERT [dbo].[Rol] ([idRol], [nombre], [descripcion], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'jug', N'Jugador', N'Este rol es para los jugadores', 1, CAST(N'2023-11-30T10:29:18.137' AS DateTime), CAST(N'2023-11-30T10:29:18.137' AS DateTime))
GO
INSERT [dbo].[Rol] ([idRol], [nombre], [descripcion], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'sadm', N'Super Administrador', N'Este es para el super administrador', 0, CAST(N'2023-12-01T10:06:46.973' AS DateTime), CAST(N'2023-12-01T10:06:46.973' AS DateTime))
GO
INSERT [dbo].[tipoReto] ([idTipoReto], [nombre], [descripcion], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'f1e2f610-e277-4a29-b146-8c42ecada4c0', N'Puzzle', N'Es para los retos que hay que armar rompeczabezas', 1, CAST(N'2023-12-16T11:33:15.430' AS DateTime), CAST(N'2023-12-16T11:33:15.430' AS DateTime))
GO
INSERT [dbo].[tipoReto] ([idTipoReto], [nombre], [descripcion], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'63aa060b-cde4-49c0-9d60-aaf069df1533', N'Trivia', N'Es para los retos de preguntas', 1, CAST(N'2023-12-16T11:33:15.430' AS DateTime), CAST(N'2023-12-16T11:33:15.430' AS DateTime))
GO
INSERT [dbo].[tipoReto] ([idTipoReto], [nombre], [descripcion], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'bb0bdda2-05d0-42c6-b3bc-b32b99de18ef', N'Laberinto', N'Es para los retos que hay un laberinto', 1, CAST(N'2023-12-16T11:33:15.430' AS DateTime), CAST(N'2023-12-16T11:33:15.430' AS DateTime))
GO
INSERT [dbo].[Usuario] ([idUsuario], [nombre], [apellido], [correo], [celular], [foto], [estado], [idRol], [idArea], [fechaCreacion], [fechaModificacion], [clave], [idCiudad]) VALUES (N'015e40dd-58ce-401e-a0a9-075874bc0b68', N'Mia', N'Lomeli', N'mia@gmail.com', N'1234', NULL, 1, N'jug', NULL, CAST(N'2023-12-05T16:47:54.067' AS DateTime), CAST(N'2023-12-05T16:47:54.067' AS DateTime), 0x7B2243697068657254657874223A22547976723733766A666A7A4972794F536430596F43773D3D222C224956223A22323639436E764475395656566131546D4232784B46773D3D227D, NULL)
GO
INSERT [dbo].[Usuario] ([idUsuario], [nombre], [apellido], [correo], [celular], [foto], [estado], [idRol], [idArea], [fechaCreacion], [fechaModificacion], [clave], [idCiudad]) VALUES (N'60efcc1c-cd33-41c5-9f84-0e1a388cf0de', N'Daniela', N'Fernandez', N'daniela@gmail.com', N'1234567892', N'Daniela.jpg', 1, N'jug', NULL, CAST(N'2023-12-14T11:02:16.463' AS DateTime), CAST(N'2023-12-14T11:02:16.463' AS DateTime), 0x7B2243697068657254657874223A222B4248784C35746E64504265334A6C75463368627A773D3D222C224956223A2264324F7042346E3671467150586D6C546C6B625769513D3D227D, NULL)
GO
INSERT [dbo].[Usuario] ([idUsuario], [nombre], [apellido], [correo], [celular], [foto], [estado], [idRol], [idArea], [fechaCreacion], [fechaModificacion], [clave], [idCiudad]) VALUES (N'91331754-1e83-417f-90e7-0e596e996510', N'Elver', N'Galarraga', N'elver.ga.larga@gmail.com', N'1234567891', N'models.png', 1, N'jug', NULL, CAST(N'2023-12-07T10:27:03.510' AS DateTime), CAST(N'2023-12-14T10:38:07.330' AS DateTime), 0x7B2243697068657254657874223A2269577045546D6F64695A39424D735935766E4D6763513D3D222C224956223A2251636268502B747775744D654C6E38547557524857513D3D227D, NULL)
GO
INSERT [dbo].[Usuario] ([idUsuario], [nombre], [apellido], [correo], [celular], [foto], [estado], [idRol], [idArea], [fechaCreacion], [fechaModificacion], [clave], [idCiudad]) VALUES (N'7c8613da-dd4b-4883-ba12-15636828fa3a', N'Daniela edit', N'Dias edit', N'daniela_edit@gmail.com', N'0998467221', N'foto2.png', 1, N'jug', NULL, CAST(N'2023-12-05T17:09:02.680' AS DateTime), CAST(N'2023-12-14T11:04:25.290' AS DateTime), 0x7B2243697068657254657874223A2256627047667955375537496F2B6E36377430333632673D3D222C224956223A226E55417066735A324E6645724E636A4D745A395637513D3D227D, NULL)
GO
INSERT [dbo].[Usuario] ([idUsuario], [nombre], [apellido], [correo], [celular], [foto], [estado], [idRol], [idArea], [fechaCreacion], [fechaModificacion], [clave], [idCiudad]) VALUES (N'939c9c6d-9dcf-4b7e-bea6-5c26169fa066', N'Byron', N'Cedeno', N'david@gmail.com', N'12', NULL, 1, N'adm', NULL, CAST(N'2023-12-05T16:50:12.913' AS DateTime), CAST(N'2023-12-05T16:50:12.913' AS DateTime), 0x7B2243697068657254657874223A22656151563278312F676B59736F41313657344A4754413D3D222C224956223A2274525733483941386C734C4A766954304861486B37773D3D227D, NULL)
GO
INSERT [dbo].[Usuario] ([idUsuario], [nombre], [apellido], [correo], [celular], [foto], [estado], [idRol], [idArea], [fechaCreacion], [fechaModificacion], [clave], [idCiudad]) VALUES (N'f42329d1-edaa-4f2c-9ae1-8f026c92c842', N'David', N'Cedeño', N'dav@gmail.com', N'12234567', NULL, 0, N'jug', NULL, CAST(N'2023-12-05T17:41:38.327' AS DateTime), CAST(N'2023-12-05T17:41:38.327' AS DateTime), 0x7B2243697068657254657874223A22584D476C4F5059592F483575697734786C6E6D2B6D673D3D222C224956223A22506E6B56696A6D47386F5757553351323062637552413D3D227D, NULL)
GO
INSERT [dbo].[Usuario] ([idUsuario], [nombre], [apellido], [correo], [celular], [foto], [estado], [idRol], [idArea], [fechaCreacion], [fechaModificacion], [clave], [idCiudad]) VALUES (N'91db7bae-7d2f-423d-b595-d227c63ca0a6', N'Marie', N'Guerrero', N'marie@gmail.com', N'1223456', NULL, 1, N'jug', NULL, CAST(N'2023-12-05T17:28:22.697' AS DateTime), CAST(N'2023-12-05T17:28:22.697' AS DateTime), 0x7B2243697068657254657874223A224C7772707369434B6F3057644F32326E38686A4261773D3D222C224956223A22375332307774775046446542772B646B4B62387370413D3D227D, NULL)
GO
INSERT [dbo].[Usuario] ([idUsuario], [nombre], [apellido], [correo], [celular], [foto], [estado], [idRol], [idArea], [fechaCreacion], [fechaModificacion], [clave], [idCiudad]) VALUES (N'6d3a6b25-c6c7-4ed4-a5e9-d992b1cc98a7', N'Benito', N'Camelas', N'benito@gmail.com', N'12234', NULL, 1, N'jug', NULL, CAST(N'2023-12-05T16:52:23.680' AS DateTime), CAST(N'2023-12-05T16:52:23.680' AS DateTime), 0x7B2243697068657254657874223A224E4E6C6E55524D4649737158684849366D38413349673D3D222C224956223A224E6F51574C444967436632323756784D426A2B5431513D3D227D, NULL)
GO
INSERT [dbo].[Usuario_Medalla] ([idMedalla], [idUsuario], [fechaCreacion], [fechaModificacion]) VALUES (N'64c746d6-1607-489e-943e-3c64a6617a9c', N'91331754-1e83-417f-90e7-0e596e996510', CAST(N'2023-12-12T11:31:49.723' AS DateTime), CAST(N'2023-12-12T11:31:49.723' AS DateTime))
GO
INSERT [dbo].[Usuario_Medalla] ([idMedalla], [idUsuario], [fechaCreacion], [fechaModificacion]) VALUES (N'26763eaa-657d-4e10-bd82-78d29934c607', N'f42329d1-edaa-4f2c-9ae1-8f026c92c842', CAST(N'2023-12-12T12:21:01.547' AS DateTime), CAST(N'2023-12-12T12:21:01.547' AS DateTime))
GO
INSERT [dbo].[Usuario_Medalla] ([idMedalla], [idUsuario], [fechaCreacion], [fechaModificacion]) VALUES (N'26763eaa-657d-4e10-bd82-78d29934c607', N'6d3a6b25-c6c7-4ed4-a5e9-d992b1cc98a7', CAST(N'2023-12-12T12:22:18.027' AS DateTime), CAST(N'2023-12-12T12:22:18.027' AS DateTime))
GO
INSERT [dbo].[Usuario_Nivel] ([idUsuario], [idNivel], [fechaCreacion], [fechaModificacion]) VALUES (N'91331754-1e83-417f-90e7-0e596e996510', N'62629073-7cc1-4ad3-82f1-b57a823e0092', CAST(N'2023-12-11T16:29:52.420' AS DateTime), CAST(N'2023-12-11T16:29:52.420' AS DateTime))
GO
INSERT [dbo].[Usuario_Nivel] ([idUsuario], [idNivel], [fechaCreacion], [fechaModificacion]) VALUES (N'91db7bae-7d2f-423d-b595-d227c63ca0a6', N'62629073-7cc1-4ad3-82f1-b57a823e0092', CAST(N'2023-12-11T16:29:52.420' AS DateTime), CAST(N'2023-12-11T16:29:52.420' AS DateTime))
GO
INSERT [dbo].[Usuario_Nivel] ([idUsuario], [idNivel], [fechaCreacion], [fechaModificacion]) VALUES (N'7c8613da-dd4b-4883-ba12-15636828fa3a', N'21fdd88c-9f5d-4c84-97fc-c11378d7169b', CAST(N'2023-12-11T16:29:52.420' AS DateTime), CAST(N'2023-12-11T16:29:52.420' AS DateTime))
GO
INSERT [dbo].[Usuario_Nivel] ([idUsuario], [idNivel], [fechaCreacion], [fechaModificacion]) VALUES (N'91331754-1e83-417f-90e7-0e596e996510', N'34fa60b2-4fcd-49a8-bebb-198e7a343cfa', CAST(N'2023-12-12T10:40:03.137' AS DateTime), CAST(N'2023-12-12T10:40:03.137' AS DateTime))
GO
INSERT [dbo].[Usuario_Nivel] ([idUsuario], [idNivel], [fechaCreacion], [fechaModificacion]) VALUES (N'7c8613da-dd4b-4883-ba12-15636828fa3a', N'34fa60b2-4fcd-49a8-bebb-198e7a343cfa', CAST(N'2023-12-12T10:40:28.490' AS DateTime), CAST(N'2023-12-12T10:40:28.490' AS DateTime))
GO
INSERT [dbo].[Usuario_Nivel] ([idUsuario], [idNivel], [fechaCreacion], [fechaModificacion]) VALUES (N'939c9c6d-9dcf-4b7e-bea6-5c26169fa066', N'34fa60b2-4fcd-49a8-bebb-198e7a343cfa', CAST(N'2023-12-12T10:40:45.277' AS DateTime), CAST(N'2023-12-12T10:40:45.277' AS DateTime))
GO
INSERT [dbo].[Usuario_Noticia] ([idNoticia], [idUsuario], [likes], [comentario], [fechaCreacion], [fechaModificacion]) VALUES (N'7cf3f854-abe0-4033-bd63-4a94dc7daf1a', N'015e40dd-58ce-401e-a0a9-075874bc0b68', NULL, N'hola', CAST(N'2023-12-12T17:57:18.940' AS DateTime), CAST(N'2023-12-12T17:57:18.940' AS DateTime))
GO
INSERT [dbo].[Usuario_Noticia] ([idNoticia], [idUsuario], [likes], [comentario], [fechaCreacion], [fechaModificacion]) VALUES (N'7cf3f854-abe0-4033-bd63-4a94dc7daf1a', N'015e40dd-58ce-401e-a0a9-075874bc0b68', 0, NULL, CAST(N'2023-12-12T17:57:38.647' AS DateTime), CAST(N'2023-12-12T17:57:38.647' AS DateTime))
GO
INSERT [dbo].[Usuario_Noticia] ([idNoticia], [idUsuario], [likes], [comentario], [fechaCreacion], [fechaModificacion]) VALUES (N'7cf3f854-abe0-4033-bd63-4a94dc7daf1a', N'91331754-1e83-417f-90e7-0e596e996510', 0, N'saludos', CAST(N'2023-12-13T12:32:49.910' AS DateTime), CAST(N'2023-12-13T12:32:49.910' AS DateTime))
GO
INSERT [dbo].[Usuario_Noticia] ([idNoticia], [idUsuario], [likes], [comentario], [fechaCreacion], [fechaModificacion]) VALUES (N'7cf3f854-abe0-4033-bd63-4a94dc7daf1a', N'91331754-1e83-417f-90e7-0e596e996510', 0, N'buena noticia', CAST(N'2023-12-13T12:33:29.260' AS DateTime), CAST(N'2023-12-13T12:33:29.260' AS DateTime))
GO
INSERT [dbo].[Usuario_Noticia] ([idNoticia], [idUsuario], [likes], [comentario], [fechaCreacion], [fechaModificacion]) VALUES (N'7cf3f854-abe0-4033-bd63-4a94dc7daf1a', N'91331754-1e83-417f-90e7-0e596e996510', 0, NULL, CAST(N'2023-12-13T12:34:03.657' AS DateTime), CAST(N'2023-12-13T12:34:03.657' AS DateTime))
GO
INSERT [dbo].[Usuario_Noticia] ([idNoticia], [idUsuario], [likes], [comentario], [fechaCreacion], [fechaModificacion]) VALUES (N'7cf3f854-abe0-4033-bd63-4a94dc7daf1a', N'91331754-1e83-417f-90e7-0e596e996510', 1, NULL, CAST(N'2023-12-13T12:36:15.930' AS DateTime), CAST(N'2023-12-13T12:36:15.930' AS DateTime))
GO
INSERT [dbo].[Usuario_Noticia] ([idNoticia], [idUsuario], [likes], [comentario], [fechaCreacion], [fechaModificacion]) VALUES (N'e1f0d39f-a8f3-4297-9429-9a89dd88ee7d', N'f42329d1-edaa-4f2c-9ae1-8f026c92c842', 1, NULL, CAST(N'2023-12-13T15:39:03.813' AS DateTime), CAST(N'2023-12-13T15:39:03.813' AS DateTime))
GO
INSERT [dbo].[Usuario_Noticia] ([idNoticia], [idUsuario], [likes], [comentario], [fechaCreacion], [fechaModificacion]) VALUES (N'e1f0d39f-a8f3-4297-9429-9a89dd88ee7d', N'f42329d1-edaa-4f2c-9ae1-8f026c92c842', 0, N'Buenas tardes', CAST(N'2023-12-13T15:39:41.133' AS DateTime), CAST(N'2023-12-13T15:39:41.133' AS DateTime))
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
INSERT [dbo].[Usuario_RedSocial] ([idRed], [idUsuario], [likes], [comentario], [fechaCreacion], [fechaModificacion]) VALUES (N'42c1822c-3ed4-4d06-bbe2-b8f180344c7a', N'6d3a6b25-c6c7-4ed4-a5e9-d992b1cc98a7', 0, N'Saludos', CAST(N'2023-12-13T16:53:52.277' AS DateTime), CAST(N'2023-12-13T16:53:52.277' AS DateTime))
GO
INSERT [dbo].[Usuario_RedSocial] ([idRed], [idUsuario], [likes], [comentario], [fechaCreacion], [fechaModificacion]) VALUES (N'e7d76e78-ce50-4712-aabf-fbc79ea3cb46', N'6d3a6b25-c6c7-4ed4-a5e9-d992b1cc98a7', 1, NULL, CAST(N'2023-12-13T17:01:02.820' AS DateTime), CAST(N'2023-12-13T17:01:02.820' AS DateTime))
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Area__72AFBCC6C2500A79]    Script Date: 19/12/2023 17:58:22 ******/
ALTER TABLE [dbo].[Area] ADD UNIQUE NONCLUSTERED 
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Categori__72AFBCC6B3607509]    Script Date: 19/12/2023 17:58:22 ******/
ALTER TABLE [dbo].[CategoriaNoticia] ADD UNIQUE NONCLUSTERED 
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Ciudad__72AFBCC60987AF52]    Script Date: 19/12/2023 17:58:22 ******/
ALTER TABLE [dbo].[Ciudad] ADD UNIQUE NONCLUSTERED 
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Comporta__72AFBCC6D24EDAA1]    Script Date: 19/12/2023 17:58:22 ******/
ALTER TABLE [dbo].[ComportamientoPregunta] ADD UNIQUE NONCLUSTERED 
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Condicio__72AFBCC66FA3235E]    Script Date: 19/12/2023 17:58:22 ******/
ALTER TABLE [dbo].[Condicion] ADD UNIQUE NONCLUSTERED 
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ_Configuracion_nom]    Script Date: 19/12/2023 17:58:22 ******/
ALTER TABLE [dbo].[Configuracion] ADD  CONSTRAINT [UQ_Configuracion_nom] UNIQUE NONCLUSTERED 
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Constant__72AFBCC6D3153B93]    Script Date: 19/12/2023 17:58:22 ******/
ALTER TABLE [dbo].[Constants] ADD UNIQUE NONCLUSTERED 
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Empresa__72AFBCC630736C09]    Script Date: 19/12/2023 17:58:22 ******/
ALTER TABLE [dbo].[Empresa] ADD UNIQUE NONCLUSTERED 
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Medalla__72AFBCC6A797F12C]    Script Date: 19/12/2023 17:58:22 ******/
ALTER TABLE [dbo].[Medalla] ADD UNIQUE NONCLUSTERED 
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Pais__72AFBCC68522AA86]    Script Date: 19/12/2023 17:58:22 ******/
ALTER TABLE [dbo].[Pais] ADD UNIQUE NONCLUSTERED 
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Reto__72AFBCC683289CD8]    Script Date: 19/12/2023 17:58:22 ******/
ALTER TABLE [dbo].[Reto] ADD UNIQUE NONCLUSTERED 
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Rol__72AFBCC65215A463]    Script Date: 19/12/2023 17:58:22 ******/
ALTER TABLE [dbo].[Rol] ADD UNIQUE NONCLUSTERED 
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__tipoReto__72AFBCC679DDB36C]    Script Date: 19/12/2023 17:58:22 ******/
ALTER TABLE [dbo].[tipoReto] ADD UNIQUE NONCLUSTERED 
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Usuario__2A586E0BBB3CDCB2]    Script Date: 19/12/2023 17:58:22 ******/
ALTER TABLE [dbo].[Usuario] ADD UNIQUE NONCLUSTERED 
(
	[correo] ASC
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
ALTER TABLE [dbo].[Empresa] ADD  DEFAULT (newid()) FOR [idEmpresa]
GO
ALTER TABLE [dbo].[Empresa] ADD  DEFAULT ((1)) FOR [estado]
GO
ALTER TABLE [dbo].[Empresa] ADD  DEFAULT (getdate()) FOR [fechaCreacion]
GO
ALTER TABLE [dbo].[Empresa] ADD  DEFAULT (getdate()) FOR [fechaModificacion]
GO
ALTER TABLE [dbo].[Medalla] ADD  DEFAULT (newid()) FOR [idMedalla]
GO
ALTER TABLE [dbo].[Medalla] ADD  DEFAULT ((1)) FOR [estado]
GO
ALTER TABLE [dbo].[Medalla] ADD  DEFAULT (getdate()) FOR [fechaCreacion]
GO
ALTER TABLE [dbo].[Medalla] ADD  DEFAULT (getdate()) FOR [fechaModificacion]
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
ALTER TABLE [dbo].[Area]  WITH CHECK ADD FOREIGN KEY([idEmpresa])
REFERENCES [dbo].[Empresa] ([idEmpresa])
GO
ALTER TABLE [dbo].[Ciudad]  WITH CHECK ADD FOREIGN KEY([idPais])
REFERENCES [dbo].[Pais] ([idPais])
GO
ALTER TABLE [dbo].[Configuracion]  WITH CHECK ADD FOREIGN KEY([idUsuario])
REFERENCES [dbo].[Usuario] ([idUsuario])
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
/****** Object:  StoredProcedure [dbo].[sp_B_Area]    Script Date: 19/12/2023 17:58:22 ******/
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
	
	if(@estado = -1)
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
		Order By a.fechaCreacion desc					

	end
	else
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
		Where a.estado = @estado
		Order By a.fechaCreacion desc		

	end	

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_CategoriaNoticia]    Script Date: 19/12/2023 17:58:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_B_CategoriaNoticia] 
		
	@estado int,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;				
	
	if(@estado = -1)
	begin

		Select * From CategoriaNoticia c
		Order By c.fechaCreacion desc					

	end
	else
	begin

		Select * From CategoriaNoticia c
		where c.estado = @estado
		Order By c.fechaCreacion desc			

	end	

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_Ciudad]    Script Date: 19/12/2023 17:58:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_B_Ciudad] 
		
	@estado int,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;			
	
	if(@estado = -1)
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
		Order By c.fechaCreacion desc					

	end
	else
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
		Where c.estado = @estado
		Order By c.fechaCreacion desc			

	end	

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_ComporPregu]    Script Date: 19/12/2023 17:58:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_B_ComporPregu] 
		
	@estado int,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;				
	
	if(@estado = -1)
	begin

		Select * 
		From ComportamientoPregunta cp
		Order By cp.fechaCreacion desc						

	end
	else
	begin

		Select * 
		From ComportamientoPregunta cp
		Where cp.estado = @estado
		Order By cp.fechaCreacion desc		

	end	

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_Condicion]    Script Date: 19/12/2023 17:58:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_B_Condicion] 
		
	@estado int,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;			
	
	if(@estado = -1)
	begin

		Select * 
		From Condicion c
		Order By c.fechaCreacion Desc							

	end
	else
	begin
			
		Select * 
		From Condicion c
		Where c.estado = @estado
		Order By c.fechaCreacion Desc				

	end	

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_Configuracion]    Script Date: 19/12/2023 17:58:22 ******/
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
	c.valor,
	c.descripcion,
	c.idUsuario,
	CONCAT(u.nombre,' ',u.apellido) as 'usuario',
	c.fechaCreacion,
	c.fechaModificacion
	From Configuracion c
	Inner Join Usuario u on u.idUsuario = c.idUsuario
	Order By c.fechaCreacion desc

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_Empresa]    Script Date: 19/12/2023 17:58:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_B_Empresa] 
		
	@estado int,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;			
	
	if(@estado = -1)
	begin

		Select * From Empresa e
		Order By e.fechaCreacion desc					

	end
	else
	begin					

		Select * From Empresa e
		where e.estado = @estado
		Order By e.fechaCreacion desc

	end	

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_Medalla]    Script Date: 19/12/2023 17:58:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_B_Medalla] 
		
	@estado int,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;			
	
	if(@estado = -1)
	begin

		Select m.idMedalla,
		m.nombre,
		m.descripcion,		
		m.imagen,
		m.estado,
		(select COUNT(*) from Usuario_Medalla um where um.idMedalla = m.idMedalla) as 'totalUsuarios',
		m.idCondicion,		
		c.nombre as 'condicion',
		m.fechaCreacion,
		m.fechaModificacion
		From Medalla m
		Inner Join Condicion c on c.idCondicion = m.idCondicion
		Order by m.fechaCreacion desc				

	end
	else
	begin					

		Select m.idMedalla,
		m.nombre,
		m.descripcion,		
		m.imagen,
		m.estado,
		(select COUNT(*) from Usuario_Medalla um where um.idMedalla = m.idMedalla) as 'totalUsuarios',
		m.idCondicion,		
		c.nombre as 'condicion',
		m.fechaCreacion,
		m.fechaModificacion
		From Medalla m
		Inner Join Condicion c on c.idCondicion = m.idCondicion
		where m.estado = @estado
		Order by m.fechaCreacion desc	

	end	

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_Nivel]    Script Date: 19/12/2023 17:58:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_B_Nivel] 
		
	@estado int,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;		
	
	if(@estado = -1)
	begin

		Select n.idNivel,
		n.nombre,
		n.descripcion,
		n.puntosNecesarios,
		n.imagen,
		n.estado,
		(select COUNT(*) from Usuario_Nivel un where un.idNivel = n.idNivel) as 'totalUsuarios',
		n.fechaCreacion,
		n.fechaModificacion
		From Nivel n		
		Order by n.fechaCreacion desc				

	end
	else
	begin
			
		Select n.idNivel,
		n.nombre,
		n.descripcion,
		n.puntosNecesarios,
		n.imagen,
		n.estado,
		(select COUNT(*) from Usuario_Nivel un where un.idNivel = n.idNivel) as 'totalUsuarios',
		n.fechaCreacion,
		n.fechaModificacion
		From Nivel n		
		where n.estado = @estado
		Order by n.fechaCreacion desc		

	end	

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_Noticia]    Script Date: 19/12/2023 17:58:22 ******/
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
	
	if(@estado = -1)
	begin

		Select n.idNoticia,
		n.titular,
		n.descripcion,
		n.url,
		n.imagen,
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
		Order by n.fechaCreacion desc				

	end
	else
	begin
		
		Select n.idNoticia,
		n.titular,
		n.descripcion,
		n.url,
		n.imagen,
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
		where n.estado = @estado
		Order by n.fechaCreacion desc		

	end	

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_OpcionByIdPregunta]    Script Date: 19/12/2023 17:58:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_B_OpcionByIdPregunta] 
		
	@estado int,	
	@idPregunta uniqueidentifier,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;			
	
	if(@estado = -1)
	begin

		Select * 
		from Opcion o
		Where idPregunta = @idPregunta
		Order By o.fechaCreacion desc						

	end
	else
	begin					

		Select * 
		from Opcion o
		Where idPregunta = @idPregunta 
		and o.estado = @estado
		Order By o.fechaCreacion desc

	end	

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_Pais]    Script Date: 19/12/2023 17:58:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_B_Pais] 
		
	@estado int,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;			
	
	if(@estado = -1)
	begin

		Select * From Pais p
		Order By p.fechaCreacion desc					

	end
	else
	begin					

		Select * From Pais p
		Where p.estado = @estado
		Order By p.fechaCreacion desc

	end	

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_PreguntaByIdReto]    Script Date: 19/12/2023 17:58:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_B_PreguntaByIdReto] 
		
	@estado int,
	@idReto uniqueidentifier,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;	
	
	if(@estado = -1)
	begin
		
		Select * 
		From Pregunta p
		Where p.idReto = @idReto
		Order By p.fechaCreacion Desc						

	end
	else
	begin					

		Select * 
		From Pregunta p
		Where p.idReto = @idReto
		and p.estado = @estado
		Order By p.fechaCreacion Desc			

	end	

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_Recompensa]    Script Date: 19/12/2023 17:58:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_B_Recompensa] 
		
	@estado int,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;			
	
	if(@estado = -1)
	begin

		Select r.idRecompensa,
		r.nombre,
		r.descripcion,		
		r.imagen,
		r.cantDisponible,
		r.cantCanje,
		r.estado,
		(select COUNT(*) from Usuario_Recompensa ur where ur.idRecompensa = r.idRecompensa) as 'totalUsuarios',
		r.fechaCreacion,
		r.fechaModificacion
		From Recompensa r
		Order by r.fechaCreacion desc						

	end
	else
	begin
			
		Select r.idRecompensa,
		r.nombre,
		r.descripcion,		
		r.imagen,
		r.cantDisponible,
		r.cantCanje,
		r.estado,
		(select COUNT(*) from Usuario_Recompensa ur where ur.idRecompensa = r.idRecompensa) as 'totalUsuarios',
		r.fechaCreacion,
		r.fechaModificacion
		From Recompensa r
		where r.estado = @estado
		Order by r.fechaCreacion desc				

	end	

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_RedSocial]    Script Date: 19/12/2023 17:58:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_B_RedSocial] 
		
	@estado int,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;		
	
	if(@estado = -1)
	begin

		Select r.idRed,
		r.descripcion,
		r.imagen,
		r.estado,
		ISNULL(r.fechaPublicacion, '1800-01-01 00:00:00') as 'fechaPublicacion',
		(select COUNT(*) from Usuario_RedSocial rs where rs.idRed = r.idRed and rs.likes > 0) as 'totalLikes',
		(select COUNT(*) from Usuario_RedSocial rs where rs.idRed = r.idRed and rs.comentario is not null) as 'totalComents',
		r.fechaCreacion,
		r.fechaModificacion
		From RedSocial r
		Order By r.fechaCreacion desc					

	end
	else
	begin

		Select r.idRed,
		r.descripcion,
		r.imagen,
		r.estado,
		ISNULL(r.fechaPublicacion, '1800-01-01 00:00:00') as 'fechaPublicacion',
		(select COUNT(*) from Usuario_RedSocial rs where rs.idRed = r.idRed and rs.likes > 0) as 'totalLikes',
		(select COUNT(*) from Usuario_RedSocial rs where rs.idRed = r.idRed and rs.comentario is not null) as 'totalComents',
		r.fechaCreacion,
		r.fechaModificacion
		From RedSocial r
		where r.estado = @estado
		Order By r.fechaCreacion desc							

	end	

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_Reto]    Script Date: 19/12/2023 17:58:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_B_Reto] 

	@estado int,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;

	if(@estado = -1)
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
		r.imagen,
		r.idTipoReto,
		tr.nombre as 'TipoReto',
		r.idComportamiento,
		cp.nombre as 'ComportamientoPregunta',
		r.fechaCreacion,
		r.fechaModificacion
		From Reto r
		Inner Join tipoReto tr on tr.idTipoReto = r.idTipoReto
		Inner Join ComportamientoPregunta cp on cp.idComportamiento = r.idComportamiento
		Order By r.fechaCreacion Desc

	end
	else
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
		r.imagen,
		r.idTipoReto,
		tr.nombre as 'TipoReto',
		r.idComportamiento,
		cp.nombre as 'ComportamientoPregunta',
		r.fechaCreacion,
		r.fechaModificacion
		From Reto r
		Inner Join tipoReto tr on tr.idTipoReto = r.idTipoReto
		Inner Join ComportamientoPregunta cp on cp.idComportamiento = r.idComportamiento
		Where r.estado = @estado
		Order By r.fechaCreacion Desc		
	
	end	

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_RetoById]    Script Date: 19/12/2023 17:58:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_B_RetoById] 
	
	@idReto uniqueidentifier,
	@estado int,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;

	if(@estado = -1)
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
		r.imagen,
		r.idTipoReto,
		tr.nombre as 'TipoReto',
		r.idComportamiento,
		cp.nombre as 'ComportamientoPregunta',
		r.fechaCreacion,
		r.fechaModificacion
		From Reto r
		Inner Join tipoReto tr on tr.idTipoReto = r.idTipoReto
		Inner Join ComportamientoPregunta cp on cp.idComportamiento = r.idComportamiento
		Where idReto = @idReto
		Order By r.fechaCreacion Desc

	end
	else
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
		r.imagen,
		r.idTipoReto,
		tr.nombre as 'TipoReto',
		r.idComportamiento,
		cp.nombre as 'ComportamientoPregunta',
		r.fechaCreacion,
		r.fechaModificacion
		From Reto r
		Inner Join tipoReto tr on tr.idTipoReto = r.idTipoReto
		Inner Join ComportamientoPregunta cp on cp.idComportamiento = r.idComportamiento
		Where r.estado = @estado and idReto = @idReto
		Order By r.fechaCreacion Desc		
	
	end	

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_Rol]    Script Date: 19/12/2023 17:58:22 ******/
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

	if(@estado = -1)
	begin

		Select * From Rol		

	end
	else
	begin

		Select * From Rol Where estado = @estado
	
	end	

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_tipoReto]    Script Date: 19/12/2023 17:58:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_B_tipoReto] 
		
	@estado int,

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;				
	
	if(@estado = -1)
	begin

		Select * 
		From tipoReto tr
		Order By tr.fechaCreacion Desc	

	end
	else
	begin

		Select * 
		From tipoReto tr
		Where tr.estado = @estado
		Order By tr.fechaCreacion Desc		

	end	

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_Usuario]    Script Date: 19/12/2023 17:58:22 ******/
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
	
	if(@estado = -1)
	begin
			
		Select u.idUsuario,
		u.nombre,
		u.apellido,
		u.correo,
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
		u.fechaCreacion,
		u.fechaModificacion
		From Usuario u 
		Inner Join Rol r on r.idRol = u.idRol 
		Left Join Area a on a.idArea = u.idArea
		Left Join Ciudad c on c.idCiudad = u.idCiudad
		Order by u.fechaCreacion desc

	end
	else
	begin
			
		Select u.idUsuario,
		u.nombre,
		u.apellido,
		u.correo,
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
		u.fechaCreacion,
		u.fechaModificacion
		From Usuario u 
		Inner Join Rol r on r.idRol = u.idRol 
		Left Join Area a on a.idArea = u.idArea
		Left Join Ciudad c on c.idCiudad = u.idCiudad
		where u.estado = @estado
		Order by u.fechaCreacion desc

	end	

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_Usuario_NoticiaByIdNoticia]    Script Date: 19/12/2023 17:58:22 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_B_Usuario_RedSocialByIdRed]    Script Date: 19/12/2023 17:58:22 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_B_UsuarioByCorreo]    Script Date: 19/12/2023 17:58:22 ******/
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

	declare @contCorreo int = 0
	Select @contCorreo = COUNT(*) From Usuario where correo = @correo --COLLATE SQL_Latin1_General_CP1_CS_AS	
	and estado > 0
	
	if(@contCorreo > 0)
	begin

		Select u.idUsuario,
		u.nombre,
		u.apellido,
		u.correo,
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
		u.fechaCreacion,
		u.fechaModificacion
		From Usuario u 
		Inner Join Rol r on r.idRol = u.idRol 
		Left Join Area a on a.idArea = u.idArea
		Left Join Ciudad c on c.idCiudad = u.idCiudad
		Where u.estado > 0 and correo = @correo
		
		select @info = CONCAT('Usuario ',descripcion) from Constants where nombre = 'encontrar'
		set @error = 0

	end
	else
	begin

		select @info = CONCAT('Usuario ',descripcion) from Constants where nombre = 'no_encontrar'
		set @error = 1
	
	end	

	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_UsuarioById]    Script Date: 19/12/2023 17:58:22 ******/
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
	and estado > 0
	
	if(@existeId > 0)
	begin

		if(@estado = -1)
		begin
			
			Select u.idUsuario,
			u.nombre,
			u.apellido,
			u.correo,
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
/****** Object:  StoredProcedure [dbo].[sp_C_Area]    Script Date: 19/12/2023 17:58:22 ******/
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
	Select @contNombre = COUNT(*) From Area Where nombre = @nombre
	
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
/****** Object:  StoredProcedure [dbo].[sp_C_CategoriaNoticia]    Script Date: 19/12/2023 17:58:22 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_C_Ciudad]    Script Date: 19/12/2023 17:58:22 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_C_Configuracion]    Script Date: 19/12/2023 17:58:22 ******/
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
	@idUsuario uniqueidentifier,	

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
			@idUsuario
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
/****** Object:  StoredProcedure [dbo].[sp_C_Empresa]    Script Date: 19/12/2023 17:58:22 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_C_Medalla]    Script Date: 19/12/2023 17:58:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_C_Medalla] 

	@nombre varchar(30),
	@descripcion varchar(250),
	@imagen varchar(50),
	@idCondicion uniqueidentifier,	

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
	else
	begin
		
		BEGIN TRY  
			
			Insert into Medalla (nombre, descripcion, imagen, idCondicion) values
			(NULLIF(@nombre, ''),
			NULLIF(@descripcion, ''),
			NULLIF(@imagen, ''),
			@idCondicion
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
/****** Object:  StoredProcedure [dbo].[sp_C_Nivel]    Script Date: 19/12/2023 17:58:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_C_Nivel] 

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

	declare @contNombre int = 0
	Select @contNombre = COUNT(*) From Nivel where nombre = @nombre
	
	
	if(@contNombre > 0)
	begin

		set @info = 'El nombre ya esta registrado'
		set @error = 1

	end		
	else
	begin
		
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
/****** Object:  StoredProcedure [dbo].[sp_C_Noticia]    Script Date: 19/12/2023 17:58:22 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_C_Opcion]    Script Date: 19/12/2023 17:58:22 ******/
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

				Insert Into Opcion (nombre, correcta, idPregunta) values
				(NULLIF(@nombre, ''),
				case @correcta when '' then 0 else @correcta end,
				@idPregunta
				)									

				Select @info = descripcion From Constants Where nombre = 'exito_insert'
				set @error = 0
				set @id = SCOPE_IDENTITY()				

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
/****** Object:  StoredProcedure [dbo].[sp_C_Pais]    Script Date: 19/12/2023 17:58:22 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_C_Pregunta]    Script Date: 19/12/2023 17:58:22 ******/
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

			Insert into Pregunta (nombre, idReto) values
			(NULLIF(@nombre, ''),
			@idReto
			)						

			Select @info = descripcion From Constants Where nombre = 'exito_insert'
			set @error = 0
			set @id = SCOPE_IDENTITY()			

		end	
	END TRY
	BEGIN CATCH	

		set @info = ERROR_MESSAGE()
		set @error = 1

	END CATCH;

	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_C_Recompensa]    Script Date: 19/12/2023 17:58:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_C_Recompensa] 

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

	Declare @contNombre int = 0	
	Select @contNombre = COUNT(*) From Recompensa where nombre = @nombre
	
	if(@contNombre > 0)
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
			
			Insert into Recompensa (nombre, descripcion, imagen, cantDisponible, cantCanje) values
			(NULLIF(@nombre, ''),
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
/****** Object:  StoredProcedure [dbo].[sp_C_RedSocial]    Script Date: 19/12/2023 17:58:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_C_RedSocial] 
	
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
/****** Object:  StoredProcedure [dbo].[sp_C_Reto]    Script Date: 19/12/2023 17:58:22 ******/
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

	Declare @contNombre int = 0
	Select @contNombre = COUNT(*) From Reto Where nombre = @nombre
	
	if(@contNombre > 0)
	begin

		set @info = 'El nombre ya esta registrado'
		set @error = 1

	end
	else
	begin		
		
		BEGIN TRY  

			Insert into Reto (nombre, fechaApetura, fechaCierre, vidas, tiempo_ms, puntosRecompensa, creditosObtenidos, instrucciones, imagen, idTipoReto, idComportamiento) values
			(NULLIF(@nombre, ''),
			NULLIF(@fechaApertura, ''),
			NULLIF(@fechaCierre, ''),
			case @vidas when '' then 0 else @vidas end,
			case @tiempo when '' then 0 else @tiempo end,
			case @puntosRecompensa when '' then 0 else @puntosRecompensa end,
			case @creditosObtenidos when '' then 0 else @creditosObtenidos end,
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
/****** Object:  StoredProcedure [dbo].[sp_C_Usuario]    Script Date: 19/12/2023 17:58:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_C_Usuario] 

	@nombre varchar(23),
	@apellido varchar(23),
	@correo varchar(60),
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

	declare @contUsuario int = 0, @contCelular int = 0, @contCorreo int = 0	
	Select @contUsuario = COUNT(*) from Usuario where nombre = @nombre and apellido = @apellido
	Select @contCorreo = COUNT(*) from Usuario where correo = @correo 
	Select @contCelular = COUNT(*) from Usuario where celular = @celular
	
	if(@contCorreo > 0)
	begin

		set @info = 'El correo electrónico ya esta registrado'
		set @error = 1

	end
	else if(@contCelular > 0)
	begin 

		set @info = 'El celular ya esta registrado'
		set @error = 1

	end
	else if(@contUsuario > 0)
	begin

		set @info = 'El nombre y apellido ya esta registrado'
		set @error = 1

	end
	else
	begin
		
		BEGIN TRY  

			Insert into Usuario (nombre, apellido, correo, celular, foto, idRol, idCiudad, idArea, clave) values
			(NULLIF(@nombre, ''),
			NULLIF(@apellido, ''),
			NULLIF(@correo, ''),
			NULLIF(@celular, ''),
			NULLIF(@foto, ''),
			NULLIF(@idRol, ''),			
			NULLIF(@idCiudad, ''),			
			NULLIF(@idArea, ''),			
			--NULLIF(CAST(@clave as varbinary(max)), '')			
			NULLIF(@clave, '')			
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
/****** Object:  StoredProcedure [dbo].[sp_C_Usuario_Medalla]    Script Date: 19/12/2023 17:58:22 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_C_Usuario_Nivel]    Script Date: 19/12/2023 17:58:22 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_C_Usuario_Noticia]    Script Date: 19/12/2023 17:58:22 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_C_Usuario_Recompensa]    Script Date: 19/12/2023 17:58:22 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_C_Usuario_RedSocial]    Script Date: 19/12/2023 17:58:22 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_U_Area]    Script Date: 19/12/2023 17:58:22 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_U_Ciudad]    Script Date: 19/12/2023 17:58:22 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_U_Configuracion]    Script Date: 19/12/2023 17:58:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_U_Configuracion] 

	@idConfig uniqueidentifier,
	@tipo varchar(10),
	@propiedad varchar(40),
	@nombre varchar(30),
	@valor varchar(50),	
	@descripcion varchar(250),	
	@idUsuario uniqueidentifier,	

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;		

	declare @contNombre int = 0
	Select @contNombre = COUNT(*) From Configuracion where nombre = @nombre and idConfig <> @idConfig
	
	
	if(@contNombre > 0)
	begin

		set @info = 'El nombre ya esta registrado'
		set @error = 1

	end		
	else
	begin
		
		BEGIN TRY  

			Update Configuracion Set
			tipo = NULLIF(@tipo, ''),
			propiedad = NULLIF(@propiedad, ''),
			nombre = NULLIF(@nombre, ''),
			valor = NULLIF(@valor, ''),
			descripcion = NULLIF(@descripcion, ''),			
			idUsuario = @idUsuario,
			fechaModificacion = GETDATE()
			Where idConfig = @idConfig
			

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
/****** Object:  StoredProcedure [dbo].[sp_U_Empresa]    Script Date: 19/12/2023 17:58:22 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_U_Opcion]    Script Date: 19/12/2023 17:58:22 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_U_Pais]    Script Date: 19/12/2023 17:58:22 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_U_Pregunta]    Script Date: 19/12/2023 17:58:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_U_Pregunta] 
		
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

	END CATCH;

	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_U_Reto]    Script Date: 19/12/2023 17:58:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_U_Reto] 
		
	@idReto uniqueidentifier,
	@nombre varchar(30),
	@fechaApertura datetime,
	@fechaCierre datetime,
	@vidas int,
	@tiempo int,
	@puntosRecompensa int,
	@creditosObtenidos int,
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

	Declare @contNombre int = 0
	Select @contNombre = COUNT(*) From Reto Where nombre = @nombre and idReto <> @idReto
	
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
			imagen = NULLIF(@imagen, ''),
			idTipoReto = @idTipoReto,
			idComportamiento = @idComportamiento,
			fechaModificacion = GETDATE()
			Where idReto = @idReto

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
/****** Object:  StoredProcedure [dbo].[sp_U_Usuario]    Script Date: 19/12/2023 17:58:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_U_Usuario] 

	@idUsuario uniqueidentifier,
	@nombre varchar(23),
	@apellido varchar(23),
	@correo varchar(60),
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

	declare @contIdU int = 0, @contUsuario int = 0, @contCelular int = 0, @contCorreo int = 0, @oldImage varchar(50) = 'N/A'	
	Select @contIdU = COUNT(*), @oldImage = ISNULL(foto, 'N/A') from Usuario where idUsuario = @idUsuario group by foto
	Select @contUsuario = COUNT(*) from Usuario where nombre = @nombre and apellido = @apellido and idUsuario <> @idUsuario
	Select @contCorreo = COUNT(*) from Usuario where correo = @correo and idUsuario <> @idUsuario
	Select @contCelular = COUNT(*) from Usuario where celular = @celular and idUsuario <> @idUsuario
	
	if(@contIdU = 0)
	begin

		set @info = 'No se encontró el id del usuario'
		set @error = 1

	end else if(@contCorreo > 0)
	begin

		set @info = 'El correo electrónico ya esta registrado'
		set @error = 1

	end
	else if(@contCelular > 0)
	begin 

		set @info = 'El celular ya esta registrado'
		set @error = 1

	end
	else if(@contUsuario > 0)
	begin

		set @info = 'El nombre y apellido ya esta registrado'
		set @error = 1

	end
	else
	begin
		
		BEGIN TRY  
						
			Update Usuario set 
			nombre = NULLIF(@nombre, ''),
			apellido = NULLIF(@apellido, ''),
			correo =  NULLIF(@correo, ''),
			celular = NULLIF(@celular, ''),			
			foto = case @foto when '' then foto else @foto end,
			idRol = NULLIF(@idRol, ''),
			idCiudad = NULLIF(@idCiudad, ''),
			idArea = NULLIF(@idArea, ''),			
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

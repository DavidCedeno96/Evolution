USE [Evolution_db]
GO
/****** Object:  Table [dbo].[Area]    Script Date: 3/12/2023 19:45:01 ******/
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
PRIMARY KEY CLUSTERED 
(
	[idArea] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CategoriaNoticia]    Script Date: 3/12/2023 19:45:01 ******/
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
/****** Object:  Table [dbo].[ComportamientoPregunta]    Script Date: 3/12/2023 19:45:01 ******/
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
/****** Object:  Table [dbo].[Condicion]    Script Date: 3/12/2023 19:45:01 ******/
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
/****** Object:  Table [dbo].[Configuracion]    Script Date: 3/12/2023 19:45:01 ******/
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
/****** Object:  Table [dbo].[Medalla]    Script Date: 3/12/2023 19:45:01 ******/
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
/****** Object:  Table [dbo].[Nivel]    Script Date: 3/12/2023 19:45:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Nivel](
	[idNivel] [uniqueidentifier] NOT NULL,
	[nombre] [varchar](20) NOT NULL,
	[descripcion] [varchar](250) NULL,
	[puntosNecesarios] [int] NOT NULL,
	[imagen] [varchar](20) NULL,
	[estado] [int] NULL,
	[fechaCreacion] [datetime] NULL,
	[fechaModificacion] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[idNivel] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Noticia]    Script Date: 3/12/2023 19:45:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Noticia](
	[idNoticia] [uniqueidentifier] NOT NULL,
	[titular] [varchar](60) NOT NULL,
	[descripcion] [varchar](250) NULL,
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
/****** Object:  Table [dbo].[Opcion]    Script Date: 3/12/2023 19:45:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Opcion](
	[idOpcion] [uniqueidentifier] NOT NULL,
	[nombre] [varchar](60) NOT NULL,
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
/****** Object:  Table [dbo].[Pregunta]    Script Date: 3/12/2023 19:45:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pregunta](
	[idPregunta] [uniqueidentifier] NOT NULL,
	[nombre] [varchar](60) NOT NULL,
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
/****** Object:  Table [dbo].[Puzzle]    Script Date: 3/12/2023 19:45:01 ******/
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
/****** Object:  Table [dbo].[Recompensa]    Script Date: 3/12/2023 19:45:01 ******/
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
/****** Object:  Table [dbo].[RedSocial]    Script Date: 3/12/2023 19:45:01 ******/
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
/****** Object:  Table [dbo].[Reto]    Script Date: 3/12/2023 19:45:01 ******/
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
/****** Object:  Table [dbo].[Rol]    Script Date: 3/12/2023 19:45:01 ******/
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
/****** Object:  Table [dbo].[tipoReto]    Script Date: 3/12/2023 19:45:01 ******/
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
/****** Object:  Table [dbo].[Usuario]    Script Date: 3/12/2023 19:45:01 ******/
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
	[pais] [varchar](30) NULL,
	[ciudad] [varchar](30) NULL,
	[empresa] [varchar](40) NULL,
	[idArea] [uniqueidentifier] NULL,
	[fechaCreacion] [datetime] NULL,
	[fechaModificacion] [datetime] NULL,
	[clave] [varchar](30) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[idUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuario_Medalla]    Script Date: 3/12/2023 19:45:01 ******/
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
/****** Object:  Table [dbo].[Usuario_Nivel]    Script Date: 3/12/2023 19:45:01 ******/
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
/****** Object:  Table [dbo].[Usuario_Noticia]    Script Date: 3/12/2023 19:45:01 ******/
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
/****** Object:  Table [dbo].[Usuario_Recompensa]    Script Date: 3/12/2023 19:45:01 ******/
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
/****** Object:  Table [dbo].[Usuario_RedSocial]    Script Date: 3/12/2023 19:45:01 ******/
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
/****** Object:  Table [dbo].[Usuario_Reto]    Script Date: 3/12/2023 19:45:01 ******/
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
INSERT [dbo].[Rol] ([idRol], [nombre], [descripcion], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'adm', N'Administrador', N'Este rol es para el administrador', 1, CAST(N'2023-11-30T10:24:19.633' AS DateTime), CAST(N'2023-11-30T10:24:19.633' AS DateTime))
GO
INSERT [dbo].[Rol] ([idRol], [nombre], [descripcion], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'jug', N'Jugador', N'Este rol es para los jugadores', 1, CAST(N'2023-11-30T10:29:18.137' AS DateTime), CAST(N'2023-11-30T10:29:18.137' AS DateTime))
GO
INSERT [dbo].[Rol] ([idRol], [nombre], [descripcion], [estado], [fechaCreacion], [fechaModificacion]) VALUES (N'sadm', N'Super Administrador', N'Este es para el super administrador', 0, CAST(N'2023-12-01T10:06:46.973' AS DateTime), CAST(N'2023-12-01T10:06:46.973' AS DateTime))
GO
INSERT [dbo].[Usuario] ([idUsuario], [nombre], [apellido], [correo], [celular], [foto], [estado], [idRol], [pais], [ciudad], [empresa], [idArea], [fechaCreacion], [fechaModificacion], [clave]) VALUES (N'dfd02f9a-4617-4713-9a9b-19fbc2817258', N'Byron David', N'Cedeño Lucero', N'david@gmail.com', NULL, NULL, 1, N'adm', NULL, NULL, NULL, NULL, CAST(N'2023-11-30T11:00:32.430' AS DateTime), CAST(N'2023-11-30T11:00:32.430' AS DateTime), N'admin')
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Area__72AFBCC685BEF222]    Script Date: 3/12/2023 19:45:01 ******/
ALTER TABLE [dbo].[Area] ADD UNIQUE NONCLUSTERED 
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Categori__72AFBCC665089ED0]    Script Date: 3/12/2023 19:45:01 ******/
ALTER TABLE [dbo].[CategoriaNoticia] ADD UNIQUE NONCLUSTERED 
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Comporta__72AFBCC691E50709]    Script Date: 3/12/2023 19:45:01 ******/
ALTER TABLE [dbo].[ComportamientoPregunta] ADD UNIQUE NONCLUSTERED 
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Condicio__72AFBCC638613C47]    Script Date: 3/12/2023 19:45:01 ******/
ALTER TABLE [dbo].[Condicion] ADD UNIQUE NONCLUSTERED 
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Medalla__72AFBCC6558B9583]    Script Date: 3/12/2023 19:45:01 ******/
ALTER TABLE [dbo].[Medalla] ADD UNIQUE NONCLUSTERED 
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Reto__72AFBCC6FB11BCD4]    Script Date: 3/12/2023 19:45:01 ******/
ALTER TABLE [dbo].[Reto] ADD UNIQUE NONCLUSTERED 
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Rol__72AFBCC6DC7B5CF0]    Script Date: 3/12/2023 19:45:01 ******/
ALTER TABLE [dbo].[Rol] ADD UNIQUE NONCLUSTERED 
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__tipoReto__72AFBCC6446BBC13]    Script Date: 3/12/2023 19:45:01 ******/
ALTER TABLE [dbo].[tipoReto] ADD UNIQUE NONCLUSTERED 
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Usuario__2A586E0BBF9E060F]    Script Date: 3/12/2023 19:45:01 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_B_Rol]    Script Date: 3/12/2023 19:45:01 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_B_UsuarioById]    Script Date: 3/12/2023 19:45:01 ******/
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
			ISNULL(u.celular, 'N/A') as 'celular',
			ISNULL(u.foto, 'N/A') as 'foto',
			u.estado,
			u.idRol,
			r.nombre as 'rol',
			ISNULL(u.pais, 'N/A') as 'pais',
			ISNULL(u.ciudad, 'N/A') as 'ciudad',
			ISNULL(u.empresa, 'N/A') as 'empresa',
			ISNULL(CAST(u.idArea as varchar(40)), 'N/A') as 'idArea',
			ISNULL(a.nombre, 'N/A') as 'area',		
			u.fechaCreacion,
			u.fechaModificacion
			From Usuario u 
			Inner Join Rol r on r.idRol = u.idRol 
			Left Join Area a on a.idArea = u.idArea		
			where u.idUsuario = @idUsuario

		end
		else
		begin
			
			Select u.idUsuario,
			u.nombre,
			u.apellido,
			u.correo,
			ISNULL(u.celular, 'N/A') as 'celular',
			ISNULL(u.foto, 'N/A') as 'foto',
			u.estado,
			u.idRol,
			r.nombre as 'rol',
			ISNULL(u.pais, 'N/A') as 'pais',
			ISNULL(u.ciudad, 'N/A') as 'ciudad',
			ISNULL(u.empresa, 'N/A') as 'empresa',
			ISNULL(CAST(u.idArea as varchar(40)), 'N/A') as 'idArea',
			ISNULL(a.nombre, 'N/A') as 'area',		
			u.fechaCreacion,
			u.fechaModificacion
			From Usuario u 
			Inner Join Rol r on r.idRol = u.idRol 
			Left Join Area a on a.idArea = u.idArea
			where u.estado = @estado and u.idUsuario = @idUsuario

		end

		

		set @info = 'Usuario encontrado'
		set @error = 0

	end
	else
	begin

		set @info = 'No se encontro el usuario'
		set @error = 1
	
	end	

	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_B_UsuarioLogin]    Script Date: 3/12/2023 19:45:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_B_UsuarioLogin] 

	@correo varchar(60),
	@clave varchar(30),

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;

	declare @existeUsuario int = 0
	Select @existeUsuario = COUNT(*) From Usuario 
	where correo = @correo COLLATE SQL_Latin1_General_CP1_CS_AS
	and clave = @clave COLLATE SQL_Latin1_General_CP1_CS_AS
	and estado > 0
	
	if(@existeUsuario > 0)
	begin

		Select u.idUsuario,
		u.nombre,
		u.apellido,
		u.correo,
		ISNULL(u.celular, 'N/A') as 'celular',
		ISNULL(u.foto, 'N/A') as 'foto',
		u.estado,
		u.idRol,
		r.nombre as 'rol',
		ISNULL(u.pais, 'N/A') as 'pais',
		ISNULL(u.ciudad, 'N/A') as 'ciudad',
		ISNULL(u.empresa, 'N/A') as 'empresa',
		ISNULL(CAST(u.idArea as varchar(40)), 'N/A') as 'idArea',
		ISNULL(a.nombre, 'N/A') as 'area',		
		u.fechaCreacion,
		u.fechaModificacion

		From Usuario u 
		Inner Join Rol r on r.idRol = u.idRol 
		Left Join Area a on a.idArea = u.idArea
		where u.estado > 0

		set @info = 'Usuario encontrado'
		set @error = 0

	end
	else
	begin

		set @info = 'No se encontro el usuario'
		set @error = 1
	
	end	

	print @info

END
GO
/****** Object:  StoredProcedure [dbo].[sp_C_Usuario]    Script Date: 3/12/2023 19:45:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create procedure [dbo].[sp_C_Usuario] 

	@nombre varchar(23),
	@apellido varchar(23),
	@correo varchar(60),
	@celular varchar(15),
	@foto varchar(50),
	@idRol varchar(9),
	@pais varchar(30),
	@ciudad varchar(30),
	@empresa varchar(40),
	@idArea uniqueidentifier,
	@clave varchar(30),

	@error int output,
	@info varchar(max) output,	
	@id varchar(max) output
AS
BEGIN

	SET NOCOUNT ON;

	select * from Usuario

	declare @contUsuario int = 0
	select @contUsuario = COUNT(*) from Usuario where nombre = 'Byron David' and apellido = 'Cedeño Lucero'


	if(@contUsuario > 0)
	begin

		set @info = 'El nombre y apellido ya esta registrado'
		set @error = 1

	end
	else
	begin
		
		BEGIN TRY  

			Insert into Usuario (nombre, apellido, correo, celular, foto, idRol, pais, ciudad, empresa, idArea, clave) values
			(@nombre,
			@apellido,
			@correo,
			NULLIF(@celular, ''),
			NULLIF(@foto, ''),
			NULLIF(@idRol, ''),
			NULLIF(@pais, ''),
			NULLIF(@ciudad, ''),
			NULLIF(@empresa, ''),
			NULLIF(@idArea, ''),
			@clave
			)			

			set @info = 'Registro creado satisfactoriamente'
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

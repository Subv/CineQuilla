GO
/****** Object:  Database [cinequilla]    Script Date: 10/8/2015 7:47:23 PM ******/
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [cinequilla].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [cinequilla] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [cinequilla] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [cinequilla] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [cinequilla] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [cinequilla] SET ARITHABORT OFF 
GO
ALTER DATABASE [cinequilla] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [cinequilla] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [cinequilla] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [cinequilla] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [cinequilla] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [cinequilla] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [cinequilla] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [cinequilla] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [cinequilla] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [cinequilla] SET  DISABLE_BROKER 
GO
ALTER DATABASE [cinequilla] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [cinequilla] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [cinequilla] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [cinequilla] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [cinequilla] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [cinequilla] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [cinequilla] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [cinequilla] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [cinequilla] SET  MULTI_USER 
GO
ALTER DATABASE [cinequilla] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [cinequilla] SET DB_CHAINING OFF 
GO
ALTER DATABASE [cinequilla] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [cinequilla] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [cinequilla]
GO
/****** Object:  Table [dbo].[cards]    Script Date: 10/8/2015 7:47:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cards](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[points] [int] NOT NULL,
	[owner] [int] NOT NULL,
 CONSTRAINT [cards_pk] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[chairs]    Script Date: 10/8/2015 7:47:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[chairs](
	[transaction_id] [int] NOT NULL,
	[show_id] [int] NOT NULL,
	[row] [int] NOT NULL,
	[column] [int] NOT NULL,
	[date] [date] NOT NULL,
 CONSTRAINT [PK_chairs] PRIMARY KEY CLUSTERED 
(
	[show_id] ASC,
	[row] ASC,
	[column] ASC,
	[date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[clients]    Script Date: 10/8/2015 7:47:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[clients](
	[id] [int] NOT NULL,
	[first_name] [varchar](255) NOT NULL,
	[last_name] [varchar](255) NOT NULL,
	[email] [varchar](255) NOT NULL,
 CONSTRAINT [clients_pk] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[movies]    Script Date: 10/8/2015 7:47:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[movies](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](255) NOT NULL,
	[description] [text] NULL,
	[year] [int] NOT NULL,
	[director] [varchar](255) NULL,
	[length] [int] NOT NULL,
	[image] [text] NULL,
 CONSTRAINT [movies_pk] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[showroom]    Script Date: 10/8/2015 7:47:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[showroom](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[rows] [int] NOT NULL,
	[columns] [int] NOT NULL,
	[capable_3d] [int] NOT NULL,
	[active] [int] NOT NULL,
 CONSTRAINT [showroom_pk] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[shows]    Script Date: 10/8/2015 7:47:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[shows](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[movie_id] [int] NOT NULL,
	[showroom_id] [int] NOT NULL,
	[start_time] [time](0) NOT NULL,
	[end_time] [time](0) NOT NULL,
	[start_date] [date] NOT NULL,
	[end_date] [date] NOT NULL,
	[price] [int] NOT NULL,
 CONSTRAINT [shows_pk] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[transactions]    Script Date: 10/8/2015 7:47:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[transactions](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[payment_method] [int] NOT NULL,
	[date] [datetime] NOT NULL,
	[cashier_id] [int] NOT NULL,
	[client_id] [int] NOT NULL,
	[amount] [int] NOT NULL,
	[quantity] [int] NOT NULL,
	[debit_number] [int] NULL,
	[points_card_id] [int] NULL,
 CONSTRAINT [transactions_pk] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[users]    Script Date: 10/8/2015 7:47:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[users](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[username] [varchar](255) NOT NULL,
	[password_hash] [varchar](255) NOT NULL,
	[first_name] [varchar](255) NOT NULL,
	[last_name] [varchar](255) NOT NULL,
	[permission_level] [int] NOT NULL DEFAULT ((0)),
 CONSTRAINT [users_pk] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[cards] ON 

INSERT [dbo].[cards] ([id], [points], [owner]) VALUES (1, 219, 1)
INSERT [dbo].[cards] ([id], [points], [owner]) VALUES (2, 4, 1)
SET IDENTITY_INSERT [dbo].[cards] OFF
INSERT [dbo].[chairs] ([transaction_id], [show_id], [row], [column], [date]) VALUES (8, 4, 0, 5, CAST(N'2015-10-05' AS Date))
INSERT [dbo].[chairs] ([transaction_id], [show_id], [row], [column], [date]) VALUES (8, 4, 0, 6, CAST(N'2015-10-05' AS Date))
INSERT [dbo].[chairs] ([transaction_id], [show_id], [row], [column], [date]) VALUES (1, 4, 1, 1, CAST(N'2015-10-03' AS Date))
INSERT [dbo].[chairs] ([transaction_id], [show_id], [row], [column], [date]) VALUES (1, 4, 1, 1, CAST(N'2015-10-04' AS Date))
INSERT [dbo].[chairs] ([transaction_id], [show_id], [row], [column], [date]) VALUES (1, 4, 1, 2, CAST(N'2015-10-03' AS Date))
INSERT [dbo].[chairs] ([transaction_id], [show_id], [row], [column], [date]) VALUES (7, 4, 1, 3, CAST(N'2015-10-04' AS Date))
INSERT [dbo].[chairs] ([transaction_id], [show_id], [row], [column], [date]) VALUES (6, 6, 0, 0, CAST(N'2015-10-03' AS Date))
INSERT [dbo].[chairs] ([transaction_id], [show_id], [row], [column], [date]) VALUES (6, 6, 0, 1, CAST(N'2015-10-03' AS Date))
INSERT [dbo].[chairs] ([transaction_id], [show_id], [row], [column], [date]) VALUES (6, 6, 0, 2, CAST(N'2015-10-03' AS Date))
INSERT [dbo].[chairs] ([transaction_id], [show_id], [row], [column], [date]) VALUES (6, 6, 0, 3, CAST(N'2015-10-03' AS Date))
INSERT [dbo].[chairs] ([transaction_id], [show_id], [row], [column], [date]) VALUES (6, 6, 0, 4, CAST(N'2015-10-03' AS Date))
INSERT [dbo].[chairs] ([transaction_id], [show_id], [row], [column], [date]) VALUES (6, 6, 0, 5, CAST(N'2015-10-03' AS Date))
INSERT [dbo].[chairs] ([transaction_id], [show_id], [row], [column], [date]) VALUES (6, 6, 0, 6, CAST(N'2015-10-03' AS Date))
INSERT [dbo].[chairs] ([transaction_id], [show_id], [row], [column], [date]) VALUES (6, 6, 0, 7, CAST(N'2015-10-03' AS Date))
INSERT [dbo].[chairs] ([transaction_id], [show_id], [row], [column], [date]) VALUES (6, 6, 0, 8, CAST(N'2015-10-03' AS Date))
INSERT [dbo].[chairs] ([transaction_id], [show_id], [row], [column], [date]) VALUES (5, 6, 0, 9, CAST(N'2015-10-03' AS Date))
INSERT [dbo].[chairs] ([transaction_id], [show_id], [row], [column], [date]) VALUES (6, 6, 1, 0, CAST(N'2015-10-03' AS Date))
INSERT [dbo].[chairs] ([transaction_id], [show_id], [row], [column], [date]) VALUES (6, 6, 1, 1, CAST(N'2015-10-03' AS Date))
INSERT [dbo].[chairs] ([transaction_id], [show_id], [row], [column], [date]) VALUES (6, 6, 1, 2, CAST(N'2015-10-03' AS Date))
INSERT [dbo].[chairs] ([transaction_id], [show_id], [row], [column], [date]) VALUES (6, 6, 1, 3, CAST(N'2015-10-03' AS Date))
INSERT [dbo].[chairs] ([transaction_id], [show_id], [row], [column], [date]) VALUES (6, 6, 1, 4, CAST(N'2015-10-03' AS Date))
INSERT [dbo].[chairs] ([transaction_id], [show_id], [row], [column], [date]) VALUES (6, 6, 1, 5, CAST(N'2015-10-03' AS Date))
INSERT [dbo].[chairs] ([transaction_id], [show_id], [row], [column], [date]) VALUES (6, 6, 1, 6, CAST(N'2015-10-03' AS Date))
INSERT [dbo].[chairs] ([transaction_id], [show_id], [row], [column], [date]) VALUES (6, 6, 1, 7, CAST(N'2015-10-03' AS Date))
INSERT [dbo].[chairs] ([transaction_id], [show_id], [row], [column], [date]) VALUES (6, 6, 1, 8, CAST(N'2015-10-03' AS Date))
INSERT [dbo].[chairs] ([transaction_id], [show_id], [row], [column], [date]) VALUES (5, 6, 1, 9, CAST(N'2015-10-03' AS Date))
INSERT [dbo].[chairs] ([transaction_id], [show_id], [row], [column], [date]) VALUES (6, 6, 2, 0, CAST(N'2015-10-03' AS Date))
INSERT [dbo].[chairs] ([transaction_id], [show_id], [row], [column], [date]) VALUES (6, 6, 2, 1, CAST(N'2015-10-03' AS Date))
INSERT [dbo].[chairs] ([transaction_id], [show_id], [row], [column], [date]) VALUES (6, 6, 2, 2, CAST(N'2015-10-03' AS Date))
INSERT [dbo].[chairs] ([transaction_id], [show_id], [row], [column], [date]) VALUES (6, 6, 2, 3, CAST(N'2015-10-03' AS Date))
INSERT [dbo].[chairs] ([transaction_id], [show_id], [row], [column], [date]) VALUES (6, 6, 2, 4, CAST(N'2015-10-03' AS Date))
INSERT [dbo].[chairs] ([transaction_id], [show_id], [row], [column], [date]) VALUES (6, 6, 2, 5, CAST(N'2015-10-03' AS Date))
INSERT [dbo].[chairs] ([transaction_id], [show_id], [row], [column], [date]) VALUES (6, 6, 2, 6, CAST(N'2015-10-03' AS Date))
INSERT [dbo].[chairs] ([transaction_id], [show_id], [row], [column], [date]) VALUES (6, 6, 2, 7, CAST(N'2015-10-03' AS Date))
INSERT [dbo].[chairs] ([transaction_id], [show_id], [row], [column], [date]) VALUES (6, 6, 2, 8, CAST(N'2015-10-03' AS Date))
INSERT [dbo].[chairs] ([transaction_id], [show_id], [row], [column], [date]) VALUES (5, 6, 2, 9, CAST(N'2015-10-03' AS Date))
INSERT [dbo].[chairs] ([transaction_id], [show_id], [row], [column], [date]) VALUES (6, 6, 3, 0, CAST(N'2015-10-03' AS Date))
INSERT [dbo].[chairs] ([transaction_id], [show_id], [row], [column], [date]) VALUES (6, 6, 3, 1, CAST(N'2015-10-03' AS Date))
INSERT [dbo].[chairs] ([transaction_id], [show_id], [row], [column], [date]) VALUES (6, 6, 3, 2, CAST(N'2015-10-03' AS Date))
INSERT [dbo].[chairs] ([transaction_id], [show_id], [row], [column], [date]) VALUES (6, 6, 3, 3, CAST(N'2015-10-03' AS Date))
INSERT [dbo].[chairs] ([transaction_id], [show_id], [row], [column], [date]) VALUES (6, 6, 3, 4, CAST(N'2015-10-03' AS Date))
INSERT [dbo].[chairs] ([transaction_id], [show_id], [row], [column], [date]) VALUES (6, 6, 3, 5, CAST(N'2015-10-03' AS Date))
INSERT [dbo].[chairs] ([transaction_id], [show_id], [row], [column], [date]) VALUES (6, 6, 3, 6, CAST(N'2015-10-03' AS Date))
INSERT [dbo].[chairs] ([transaction_id], [show_id], [row], [column], [date]) VALUES (6, 6, 3, 7, CAST(N'2015-10-03' AS Date))
INSERT [dbo].[chairs] ([transaction_id], [show_id], [row], [column], [date]) VALUES (6, 6, 3, 8, CAST(N'2015-10-03' AS Date))
INSERT [dbo].[chairs] ([transaction_id], [show_id], [row], [column], [date]) VALUES (5, 6, 3, 9, CAST(N'2015-10-03' AS Date))
INSERT [dbo].[chairs] ([transaction_id], [show_id], [row], [column], [date]) VALUES (17, 9, 0, 0, CAST(N'2015-10-30' AS Date))
INSERT [dbo].[chairs] ([transaction_id], [show_id], [row], [column], [date]) VALUES (18, 9, 0, 0, CAST(N'2015-10-31' AS Date))
INSERT [dbo].[chairs] ([transaction_id], [show_id], [row], [column], [date]) VALUES (17, 9, 0, 1, CAST(N'2015-10-30' AS Date))
INSERT [dbo].[chairs] ([transaction_id], [show_id], [row], [column], [date]) VALUES (18, 9, 0, 1, CAST(N'2015-10-31' AS Date))
INSERT [dbo].[chairs] ([transaction_id], [show_id], [row], [column], [date]) VALUES (17, 9, 0, 2, CAST(N'2015-10-30' AS Date))
INSERT [dbo].[chairs] ([transaction_id], [show_id], [row], [column], [date]) VALUES (18, 9, 0, 2, CAST(N'2015-10-31' AS Date))
INSERT [dbo].[chairs] ([transaction_id], [show_id], [row], [column], [date]) VALUES (17, 9, 0, 3, CAST(N'2015-10-30' AS Date))
INSERT [dbo].[chairs] ([transaction_id], [show_id], [row], [column], [date]) VALUES (18, 9, 0, 3, CAST(N'2015-10-31' AS Date))
INSERT [dbo].[chairs] ([transaction_id], [show_id], [row], [column], [date]) VALUES (17, 9, 0, 4, CAST(N'2015-10-30' AS Date))
INSERT [dbo].[chairs] ([transaction_id], [show_id], [row], [column], [date]) VALUES (18, 9, 0, 4, CAST(N'2015-10-31' AS Date))
INSERT [dbo].[chairs] ([transaction_id], [show_id], [row], [column], [date]) VALUES (17, 9, 1, 0, CAST(N'2015-10-30' AS Date))
INSERT [dbo].[chairs] ([transaction_id], [show_id], [row], [column], [date]) VALUES (18, 9, 1, 0, CAST(N'2015-10-31' AS Date))
INSERT [dbo].[chairs] ([transaction_id], [show_id], [row], [column], [date]) VALUES (17, 9, 1, 1, CAST(N'2015-10-30' AS Date))
INSERT [dbo].[chairs] ([transaction_id], [show_id], [row], [column], [date]) VALUES (18, 9, 1, 1, CAST(N'2015-10-31' AS Date))
INSERT [dbo].[chairs] ([transaction_id], [show_id], [row], [column], [date]) VALUES (17, 9, 1, 2, CAST(N'2015-10-30' AS Date))
INSERT [dbo].[chairs] ([transaction_id], [show_id], [row], [column], [date]) VALUES (18, 9, 1, 2, CAST(N'2015-10-31' AS Date))
INSERT [dbo].[chairs] ([transaction_id], [show_id], [row], [column], [date]) VALUES (17, 9, 1, 3, CAST(N'2015-10-30' AS Date))
INSERT [dbo].[chairs] ([transaction_id], [show_id], [row], [column], [date]) VALUES (18, 9, 1, 3, CAST(N'2015-10-31' AS Date))
INSERT [dbo].[chairs] ([transaction_id], [show_id], [row], [column], [date]) VALUES (17, 9, 1, 4, CAST(N'2015-10-30' AS Date))
INSERT [dbo].[chairs] ([transaction_id], [show_id], [row], [column], [date]) VALUES (18, 9, 1, 4, CAST(N'2015-10-31' AS Date))
INSERT [dbo].[clients] ([id], [first_name], [last_name], [email]) VALUES (1, N'Sebas', N'Valle', N'subv2112@gmail.com')
INSERT [dbo].[clients] ([id], [first_name], [last_name], [email]) VALUES (2, N'Sebas', N'Valle', N'subv2112@gmail.com')
INSERT [dbo].[clients] ([id], [first_name], [last_name], [email]) VALUES (3, N'Sebas', N'Valle', N'subv2112@gmail.com')
SET IDENTITY_INSERT [dbo].[movies] ON 

INSERT [dbo].[movies] ([id], [name], [description], [year], [director], [length], [image]) VALUES (2, N'Dawn of the database', N'asd', 1554, N'Sebastian Valle', 15, N'Uploads/2048.png')
INSERT [dbo].[movies] ([id], [name], [description], [year], [director], [length], [image]) VALUES (3, N'Database of the dead', N'asdf', 2015, N'Sebastian', 40, N'Uploads/J9M3Hte.jpg')
SET IDENTITY_INSERT [dbo].[movies] OFF
SET IDENTITY_INSERT [dbo].[showroom] ON 

INSERT [dbo].[showroom] ([id], [rows], [columns], [capable_3d], [active]) VALUES (1, 2, 10, 1, 1)
INSERT [dbo].[showroom] ([id], [rows], [columns], [capable_3d], [active]) VALUES (4, 4, 10, 1, 1)
INSERT [dbo].[showroom] ([id], [rows], [columns], [capable_3d], [active]) VALUES (5, 2, 5, 0, 1)
SET IDENTITY_INSERT [dbo].[showroom] OFF
SET IDENTITY_INSERT [dbo].[shows] ON 

INSERT [dbo].[shows] ([id], [movie_id], [showroom_id], [start_time], [end_time], [start_date], [end_date], [price]) VALUES (4, 2, 1, CAST(N'13:00:00' AS Time), CAST(N'15:00:00' AS Time), CAST(N'2015-10-03' AS Date), CAST(N'2015-10-05' AS Date), 15)
INSERT [dbo].[shows] ([id], [movie_id], [showroom_id], [start_time], [end_time], [start_date], [end_date], [price]) VALUES (5, 2, 1, CAST(N'15:00:00' AS Time), CAST(N'17:00:00' AS Time), CAST(N'2015-10-03' AS Date), CAST(N'2015-10-03' AS Date), 20)
INSERT [dbo].[shows] ([id], [movie_id], [showroom_id], [start_time], [end_time], [start_date], [end_date], [price]) VALUES (6, 2, 4, CAST(N'19:00:00' AS Time), CAST(N'20:00:00' AS Time), CAST(N'2015-10-02' AS Date), CAST(N'2015-10-03' AS Date), 64)
INSERT [dbo].[shows] ([id], [movie_id], [showroom_id], [start_time], [end_time], [start_date], [end_date], [price]) VALUES (8, 2, 4, CAST(N'10:30:00' AS Time), CAST(N'12:30:00' AS Time), CAST(N'2015-10-29' AS Date), CAST(N'2015-12-05' AS Date), 421)
INSERT [dbo].[shows] ([id], [movie_id], [showroom_id], [start_time], [end_time], [start_date], [end_date], [price]) VALUES (9, 3, 5, CAST(N'10:00:00' AS Time), CAST(N'13:00:00' AS Time), CAST(N'2015-10-30' AS Date), CAST(N'2015-10-31' AS Date), 13)
INSERT [dbo].[shows] ([id], [movie_id], [showroom_id], [start_time], [end_time], [start_date], [end_date], [price]) VALUES (10, 3, 1, CAST(N'10:00:00' AS Time), CAST(N'11:00:00' AS Time), CAST(N'2015-10-31' AS Date), CAST(N'2015-11-07' AS Date), 400)
SET IDENTITY_INSERT [dbo].[shows] OFF
SET IDENTITY_INSERT [dbo].[transactions] ON 

INSERT [dbo].[transactions] ([id], [payment_method], [date], [cashier_id], [client_id], [amount], [quantity], [debit_number], [points_card_id]) VALUES (1, 1, CAST(N'2015-10-03 00:00:00.000' AS DateTime), 2, 1, 100, 1, 1234, NULL)
INSERT [dbo].[transactions] ([id], [payment_method], [date], [cashier_id], [client_id], [amount], [quantity], [debit_number], [points_card_id]) VALUES (5, 1, CAST(N'2015-10-03 00:00:00.000' AS DateTime), 2, 1, 256, 4, 1234, NULL)
INSERT [dbo].[transactions] ([id], [payment_method], [date], [cashier_id], [client_id], [amount], [quantity], [debit_number], [points_card_id]) VALUES (6, 1, CAST(N'2015-10-03 00:00:00.000' AS DateTime), 2, 1, 2304, 36, 1234, NULL)
INSERT [dbo].[transactions] ([id], [payment_method], [date], [cashier_id], [client_id], [amount], [quantity], [debit_number], [points_card_id]) VALUES (7, 2, CAST(N'2015-10-03 00:00:00.000' AS DateTime), 2, 1, 15, 1, NULL, 1)
INSERT [dbo].[transactions] ([id], [payment_method], [date], [cashier_id], [client_id], [amount], [quantity], [debit_number], [points_card_id]) VALUES (8, 1, CAST(N'2015-10-04 00:00:00.000' AS DateTime), 2, 2, 30, 2, 1234, NULL)
INSERT [dbo].[transactions] ([id], [payment_method], [date], [cashier_id], [client_id], [amount], [quantity], [debit_number], [points_card_id]) VALUES (15, 1, CAST(N'2015-10-05 00:00:00.000' AS DateTime), 2, 1, 45, 3, 1234, NULL)
INSERT [dbo].[transactions] ([id], [payment_method], [date], [cashier_id], [client_id], [amount], [quantity], [debit_number], [points_card_id]) VALUES (16, 1, CAST(N'2015-10-05 00:00:00.000' AS DateTime), 2, 1, 240, 16, 123, NULL)
INSERT [dbo].[transactions] ([id], [payment_method], [date], [cashier_id], [client_id], [amount], [quantity], [debit_number], [points_card_id]) VALUES (17, 1, CAST(N'2015-10-05 00:00:00.000' AS DateTime), 2, 1, 130, 10, 12334, NULL)
INSERT [dbo].[transactions] ([id], [payment_method], [date], [cashier_id], [client_id], [amount], [quantity], [debit_number], [points_card_id]) VALUES (18, 1, CAST(N'2015-10-05 00:00:00.000' AS DateTime), 2, 1, 130, 10, 1, NULL)
SET IDENTITY_INSERT [dbo].[transactions] OFF
SET IDENTITY_INSERT [dbo].[users] ON 

INSERT [dbo].[users] ([id], [username], [password_hash], [first_name], [last_name], [permission_level]) VALUES (2, N'admin', N'¬gBóá\vá¥âUðg•6#È³ˆ´Ežùx×ÈFô', N'Sebastian', N'Valle', 3)
INSERT [dbo].[users] ([id], [username], [password_hash], [first_name], [last_name], [permission_level]) VALUES (2002, N'user', N'¬gBóá\vá¥âUðg•6#È³ˆ´Ežùx×ÈFô', N'Cajero', N'Normal', 1)
SET IDENTITY_INSERT [dbo].[users] OFF
SET ANSI_PADDING ON

GO
/****** Object:  Index [username_index]    Script Date: 10/8/2015 7:47:24 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [username_index] ON [dbo].[users]
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[cards]  WITH CHECK ADD  CONSTRAINT [cards_clients] FOREIGN KEY([owner])
REFERENCES [dbo].[clients] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[cards] CHECK CONSTRAINT [cards_clients]
GO
ALTER TABLE [dbo].[chairs]  WITH CHECK ADD  CONSTRAINT [shows_chairs] FOREIGN KEY([show_id])
REFERENCES [dbo].[shows] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[chairs] CHECK CONSTRAINT [shows_chairs]
GO
ALTER TABLE [dbo].[chairs]  WITH CHECK ADD  CONSTRAINT [transactions_chairs] FOREIGN KEY([transaction_id])
REFERENCES [dbo].[transactions] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[chairs] CHECK CONSTRAINT [transactions_chairs]
GO
ALTER TABLE [dbo].[shows]  WITH CHECK ADD  CONSTRAINT [movies_shows] FOREIGN KEY([movie_id])
REFERENCES [dbo].[movies] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[shows] CHECK CONSTRAINT [movies_shows]
GO
ALTER TABLE [dbo].[shows]  WITH CHECK ADD  CONSTRAINT [showroom_shows] FOREIGN KEY([showroom_id])
REFERENCES [dbo].[showroom] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[shows] CHECK CONSTRAINT [showroom_shows]
GO
ALTER TABLE [dbo].[transactions]  WITH CHECK ADD  CONSTRAINT [transactions_cards] FOREIGN KEY([points_card_id])
REFERENCES [dbo].[cards] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[transactions] CHECK CONSTRAINT [transactions_cards]
GO
ALTER TABLE [dbo].[transactions]  WITH CHECK ADD  CONSTRAINT [transactions_clients] FOREIGN KEY([client_id])
REFERENCES [dbo].[clients] ([id])
GO
ALTER TABLE [dbo].[transactions] CHECK CONSTRAINT [transactions_clients]
GO
ALTER TABLE [dbo].[transactions]  WITH CHECK ADD  CONSTRAINT [transactions_users] FOREIGN KEY([cashier_id])
REFERENCES [dbo].[users] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[transactions] CHECK CONSTRAINT [transactions_users]
GO
USE [master]
GO
ALTER DATABASE [cinequilla] SET  READ_WRITE 
GO

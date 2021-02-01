USE [gt]
GO

/****** Object:  Table [dbo].[tbl_board_upload]    Script Date: 2021-02-01 오전 8:53:53 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tbl_board_upload](
	[idx] [int] IDENTITY(1,1) NOT NULL,
	[bidx] [int] NOT NULL,
	[fileRealName] [nvarchar](50) NOT NULL,
	[fileSaveName] [nvarchar](50) NOT NULL,
	[fileSize] [varchar](10) NOT NULL,
	[reg_ip] [varchar](20) NOT NULL,
	[mod_ip] [varchar](20) NULL,
	[reg_date] [datetime] NOT NULL,
	[mod_date] [datetime] NULL,
 CONSTRAINT [PK_tbl_board_upload] PRIMARY KEY CLUSTERED 
(
	[idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[tbl_board_upload] ADD  CONSTRAINT [DF_tbl_board_upload_fileSize]  DEFAULT ((0)) FOR [fileSize]
GO

ALTER TABLE [dbo].[tbl_board_upload] ADD  CONSTRAINT [DF_tbl_board_upload_reg_date]  DEFAULT (getdate()) FOR [reg_date]
GO

ALTER TABLE [dbo].[tbl_board_upload] ADD  CONSTRAINT [DF_tbl_board_upload_mod_date]  DEFAULT (getdate()) FOR [mod_date]
GO


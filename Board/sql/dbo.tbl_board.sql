USE [gt]
GO

/****** Object:  Table [dbo].[tbl_board]    Script Date: 2021-02-01 오전 8:52:30 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tbl_board](
	[idx] [int] IDENTITY(1,1) NOT NULL,
	[uname] [nvarchar](10) NOT NULL,
	[title] [nvarchar](30) NOT NULL,
	[pwd] [binary](100) NOT NULL,
	[contents] [ntext] NOT NULL,
	[count] [smallint] NULL,
	[ref] [int] NOT NULL,
	[re_step] [smallint] NOT NULL,
	[re_lvl] [smallint] NOT NULL,
	[deleted] [char](1) NULL,
	[reg_ip] [varchar](20) NULL,
	[mod_ip] [varchar](20) NULL,
	[reg_date] [datetime] NOT NULL,
	[mod_date] [datetime] NULL,
 CONSTRAINT [PK_tbl_board] PRIMARY KEY CLUSTERED 
(
	[idx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[tbl_board] ADD  CONSTRAINT [DF_tbl_board_count]  DEFAULT ((0)) FOR [count]
GO

ALTER TABLE [dbo].[tbl_board] ADD  CONSTRAINT [DF_tbl_board_ref]  DEFAULT ((0)) FOR [ref]
GO

ALTER TABLE [dbo].[tbl_board] ADD  CONSTRAINT [DF_tbl_board_re_step]  DEFAULT ((0)) FOR [re_step]
GO

ALTER TABLE [dbo].[tbl_board] ADD  CONSTRAINT [DF_tbl_board_re_lvl]  DEFAULT ((0)) FOR [re_lvl]
GO

ALTER TABLE [dbo].[tbl_board] ADD  CONSTRAINT [DF_tbl_board_deleted]  DEFAULT ((0)) FOR [deleted]
GO

ALTER TABLE [dbo].[tbl_board] ADD  CONSTRAINT [DF_tbl_board_reg_date]  DEFAULT (getdate()) FOR [reg_date]
GO

ALTER TABLE [dbo].[tbl_board] ADD  CONSTRAINT [DF_tbl_board_mod_date]  DEFAULT (getdate()) FOR [mod_date]
GO


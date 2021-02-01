USE [gt]
GO
/****** Object:  StoredProcedure [dbo].[sp_board_mod]    Script Date: 2021-02-01 오후 5:06:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create procedure [dbo].[sp_board_mod]
@idx varchar(10)
as
begin
SET NOCOUNT ON 
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	Declare @qry as nvarchar(1000)
	
	set @qry = ''
	set @qry = @qry + 'select idx,uname,title,pwd,contents,count,ref,re_step,re_lvl,reg_ip,reg_date,mod_date '
	set @qry = @qry + 'from tbl_board '
	set @qry = @qry + 'where idx='+@idx+'; '
	exec(@qry)

SET NOCOUNT OFF
--RETURN	
end

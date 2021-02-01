USE [gt]
GO
/****** Object:  StoredProcedure [dbo].[sp_board_view_upload]    Script Date: 2021-02-01 오후 5:43:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


Create procedure [dbo].[sp_board_view_upload]
@bidx varchar(10)
as
begin
SET NOCOUNT ON 
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	Declare @qry as nvarchar(1000)
	
	set @qry = ''
	set @qry = @qry + 'select top 2 idx,bidx,fileRealName,fileSaveName,fileSize,reg_ip,mod_ip,reg_date,mod_date '
	set @qry = @qry + 'from tbl_board_upload '
	set @qry = @qry + 'where bidx='+@bidx+' order by idx desc '
	exec(@qry)

SET NOCOUNT OFF
--RETURN	
end


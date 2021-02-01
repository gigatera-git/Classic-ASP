USE [gt]
GO
/****** Object:  StoredProcedure [dbo].[sp_board_list]    Script Date: 2021-02-01 오후 5:01:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create procedure [dbo].[sp_board_list]
@Page varchar(10),
@intPageSize varchar(5),
@SearchOpt varchar(10),
@SearchVal varchar(20),
@intTotalCount integer output,
@intTotalPage integer output
as
begin
SET NOCOUNT ON 
	Declare @qry as nvarchar(1000)

	Declare @TotalCount as int
	Declare @TotalPage as int
	set @qry = ''
	set @qry = @qry + 'DECLARE CUR CURSOR FOR '
	set @qry = @qry + 'Select Count(*),CEILING(CAST(Count(*) AS FLOAT)/'+@intPageSize+') '
	set @qry = @qry + 'from tbl_board '
	set @qry = @qry + 'where idx<>'''' '
	if @SearchOpt<>'' and @SearchVal<>'' 
		set @qry = @qry + 'and '+@SearchOpt+' like ''%'+@SearchVal+'%'' '
	exec(@qry) 	
	OPEN CUR
	FETCH NEXT FROM CUR INTO @intTotalCount,@intTotalPage
	CLOSE CUR
	DEALLOCATE CUR

	
	set @qry = ''
	set @qry = @qry + 'select idx,uname,title,pwd,count,ref,re_step,re_lvl,reg_ip,convert(char(10),reg_date,120) as reg_date '
	set @qry = @qry + 'from tbl_board '
	set @qry = @qry + 'where idx<>'''' '
	if @SearchOpt<>'' and @SearchVal<>'' 
		set @qry = @qry + 'and '+@SearchOpt+' like ''%'+@SearchVal+'%'' '
	set @qry = @qry + 'order by ref desc, re_step, re_lvl '
	set @qry = @qry + 'offset ('+@Page+'-1)*'+@intPageSize+' ROW  '
	set @qry = @qry + 'fetch next '+@intPageSize+' ROW ONLY '
	exec(@qry)
SET NOCOUNT OFF	
end

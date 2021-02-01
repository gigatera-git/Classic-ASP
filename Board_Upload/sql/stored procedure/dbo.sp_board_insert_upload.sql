USE [gt]
GO
/****** Object:  StoredProcedure [dbo].[sp_board_insert_upload]    Script Date: 2021-02-01 오후 5:39:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE  [dbo].[sp_board_insert_upload]
@bidx INTEGER,
@fileRealName nvarchar(50),
@fileSaveName nvarchar(50),
@fileSize varchar(10),
@reg_ip varchar(20),
@res smallint output
as
begin
SET NOCOUNT ON 	
	declare @last as datetime
	declare @diff as integer
	select @last=reg_date from tbl_board_upload where reg_ip=@reg_ip and bidx<>@bidx;
	set @diff = DATEDIFF(second,@last,getdate())
	if @diff<=60
	begin
		set @res = 2
	end
	else
	begin

		Declare @ref as int
		Declare @re_step as smallint
		Declare @re_lvl as smallint
		select @ref = isnull(max(ref)+1,1) from tbl_board
		set @re_step = 0
		set @re_lvl = 0	
			
		begin tran
			insert into tbl_board_upload(bidx,fileRealName,fileSaveName,fileSize,reg_ip) values(@bidx,@fileRealName,@fileSaveName,@fileSize,@reg_ip);
		if (@@error<>0) 
		begin
			ROLLBACK TRAN
			set @res = 1
		end
		else
		begin
			COMMIT TRAN
			set @res = 0
		end
	end 
SET NOCOUNT OFF
END

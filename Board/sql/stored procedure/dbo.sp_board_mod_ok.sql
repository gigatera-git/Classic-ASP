USE [gt]
GO
/****** Object:  StoredProcedure [dbo].[sp_board_mod_ok]    Script Date: 2021-02-01 오후 5:05:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE  [dbo].[sp_board_mod_ok]
@idx integer,
@uname nvarchar(10),
@title nvarchar(30),
@pwd varchar(20),
@contents ntext,
@mod_ip varchar(20),
@res smallint output
as
begin
SET NOCOUNT ON 	

	declare @cnt as smallint 

	select @cnt = count(idx) from tbl_board where idx=@idx and pwd=HASHBYTES('SHA2_512',@pwd)
	if @cnt<1
	begin
		set @res = 2
	end
	else
	begin
			
		begin tran
			update tbl_board set
			uname=@uname,
			title=@title,
			contents=@contents,
			mod_ip=@mod_ip,
			mod_date=getdate()
			where idx=@idx and pwd=HASHBYTES('SHA2_512',@pwd)
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
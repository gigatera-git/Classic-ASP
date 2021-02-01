USE [gt]
GO
/****** Object:  StoredProcedure [dbo].[sp_board_insert]    Script Date: 2021-02-01 오전 8:40:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE  [dbo].[sp_board_insert]
@uname nvarchar(10),
@title nvarchar(30),
@pwd varchar(20),
@contents ntext,
--@ref smallint,
--@re_step smallint,
--@re_lvl smallint,
@reg_ip varchar(20),
@res smallint output,
@bidx INTEGER output
as
begin
SET NOCOUNT ON 	
	declare @last as datetime
	declare @diff as integer
	select @last=reg_date from tbl_board where reg_ip=@reg_ip;
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
			insert into tbl_board(uname,title,pwd,contents,ref,re_step,re_lvl,reg_ip) values(@uname,@title,HASHBYTES('SHA2_512',@pwd),@contents,@ref,@re_step,@re_lvl,@reg_ip);
		if (@@error<>0) 
		begin
			ROLLBACK TRAN
			set @res = 1
			set @bidx = 0
		end
		else
		begin
			COMMIT TRAN
			set @res = 0
			set @bidx = @@IDENTITY
		end
	end 
SET NOCOUNT OFF
END

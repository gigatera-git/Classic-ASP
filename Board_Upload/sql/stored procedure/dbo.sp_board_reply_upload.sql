USE [gt]
GO
/****** Object:  StoredProcedure [dbo].[sp_board_reply_upload]    Script Date: 2021-02-01 오전 8:44:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE  [dbo].[sp_board_reply_upload]
@uname nvarchar(10),
@title nvarchar(30),
@pwd varchar(20),
@contents ntext,
@ref int,
@re_step smallint,
@re_lvl smallint,
@reg_ip varchar(20),
@res smallint output,
@bidx integer output
as
begin
SET NOCOUNT ON 	
	declare @last as datetime
	declare @diff as integer
	select @last=reg_date from tbl_board where reg_ip=@reg_ip and re_step>0;
	set @diff = DATEDIFF(second,@last,getdate())
	if @diff<=60
	begin
		set @res = 2
	end
	else
	begin

		begin tran
			Update tbl_board SET re_step=re_step+1 where ref=@ref AND re_step > @re_step;

			insert into tbl_board(uname,title,pwd,contents,ref,re_step,re_lvl,reg_ip) values(@uname,@title,HASHBYTES('SHA2_512',@pwd),@contents,@ref,@re_step+1,@re_lvl+1,@reg_ip);	

		if (@@error<>0) 
		begin
			ROLLBACK TRAN
			set @res = 1
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


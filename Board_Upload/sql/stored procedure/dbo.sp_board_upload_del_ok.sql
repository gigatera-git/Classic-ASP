USE [gt]
GO
/****** Object:  StoredProcedure [dbo].[sp_board_upload_del_ok]    Script Date: 2021-02-01 오후 5:41:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create procedure [dbo].[sp_board_upload_del_ok]
@fileSaveName nvarchar(50),
@res smallint output
as
begin
SET NOCOUNT ON 
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	begin tran
		delete from tbl_board_upload where fileSaveName=@fileSaveName
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

SET NOCOUNT OFF
--RETURN	415
end

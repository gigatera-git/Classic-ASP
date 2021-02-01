USE [gt]
GO
/****** Object:  StoredProcedure [dbo].[sp_board_pwd_chk]    Script Date: 2021-02-01 오전 8:49:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- check pwd
Create procedure [dbo].[sp_board_pwd_chk]
@idx integer,
@pwd varchar(20)
as 
begin
	SET NOCOUNT ON

	select count(*) from tbl_board where idx=@idx and pwd=HASHBYTES('SHA2_512',@pwd)


	SET NOCOUNT OFF
end
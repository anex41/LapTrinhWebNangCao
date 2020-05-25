create database LtrWnc
use LtrWnc
CREATE TABLE tblUser (
    id int NOT NULL identity(1,1),
    username varchar(50) NOT NULL,
    password varchar(256)  NOT NULL,
	displayName nvarchar(50) NOT NULL,
	phoneNumber varchar(12) NOT NULL,
	email varchar(50) NOT NULL,
	statusFlag int NOT NULL,
	role int NOT NULL
);

/* tạo user */

CREATE PROCEDURE getUser
@username varchar(50)
AS
select top 1 * from tblUser where @username = tblUser.username

exec getUser @username='user1'

drop proc getUser

/* lấy all client */

create proc getClient
as
select * from tblUser where tblUser.role = 0

exec getClient

/* thêm người dùng (Client)*/

create proc createNewClient
@username varchar(50),
@password varchar(256),
@displayName nvarchar(50),
@phoneNumber varchar(12),
@email varchar(50)
as
if EXISTS (SELECT username FROM tblUser WHERE tblUser.username = @username)
	return 0;
else 
	INSERT INTO tblUser
	VALUES (@username, @password, 0, N@displayName, @phoneNumber, @email, 0)
	return 1;

DECLARE @return_status int;  
exec @return_status = createNewClient @username='user2', @password='d756ac3191464e6e1f97d240635ceaba6d15d437811f4d06eb0508027357103a', @displayName = N'Người dùng 2', @phoneNumber='083xxxxxxx', @email='user2@xmail.com'
SELECT 'Return Status' = @return_status;  

drop proc createNewClient

/* Kiểm tra tên tài khoản (Client)*/

create proc checkUserName
@username varchar(50)
as
if EXISTS (SELECT username FROM tblUser WHERE tblUser.username = @username)
	return 1;
else 
	return 0;


DECLARE @return_status int;  
exec @return_status = checkUserName @username='user3'
SELECT 'Return Status' = @return_status;

drop proc checkUserName

/* Tạo ckEditorData*/

create table ckEditorContent (
	id varchar(20) NOT NULL,
	ckEditorContent ntext NOT NULL,
	activateFlag bit NOT NULL
);

drop table ckEditorContent

/* Thêm nội dung */

create proc addCkEditorContent
@id varchar(20),
@textContent ntext,
@activateFlag bit
as
if EXISTS (select 1 from ckEditorContent where ckEditorContent.id = @id )
	UPDATE ckEditorContent
	SET ckEditorContent.ckEditorContent = @textContent, ckEditorContent.activateFlag = @activateFlag
	WHERE ckEditorContent.id = @id;
else
	INSERT INTO ckEditorContent
	Values (@id,@textContent,@activateFlag)

drop proc addCkEditorContent

exec addCkEditorContent @id="introduction", @textContent=N'<p style="text-align:center"><span style="color:#2980b9"><strong><span style="font-size:24px">hiới thiệu về c&ocirc;ng ty</span></strong></span></p>', @activateFlag= 1

create proc getCkEditorContent
@id varchar(20)
as
select top 1 *
from ckEditorContent
where ckEditorContent.id = @id;

exec getCkEditorContent @id="introduction"
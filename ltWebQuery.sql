create database LtrWnc
use LtrWnc
CREATE TABLE tblUser (
    id int NOT NULL identity(1,1),
    username varchar(50) NOT NULL,
    password varchar(256)  NOT NULL,
	role int NOT NULL
);

/* tạo user */

CREATE PROCEDURE getUser
@username varchar(50)
AS
select * from tblUser where @username = tblUser.username

exec getUser @username='admin'
select * from tblUser

/* lấy all client */

create proc getClient
as
select * from tblUser where tblUser.role = 0

exec getClient

/* thêm người dùng (Client)*/

create proc createNewClient
@username varchar(50),
@password varchar(256)
as
INSERT INTO tblUser
VALUES (@username, @password, 0);

exec createNewClient @username='user2', @password='94b51c86cc51ecdedd2a448aa6792c704a93f86f70fc3dd4f4bdc2eabfb16752'

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
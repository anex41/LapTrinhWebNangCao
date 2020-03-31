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
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
	select top 1 tblUser.username, tblUser.password, tblUser.id, tblUser.role
	from tblUser where @username = tblUser.username

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
	VALUES (@username, @password, 0, @displayName, @phoneNumber, @email, 0)
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

/* Tạo bảng sản phẩm */

CREATE TABLE tblProduct (
    productId int NOT NULL identity(1,1),
    productName nvarchar(100) NOT NULL,
    productDescription ntext  NOT NULL,
	productCatalog int NOT NULL,
	productStatus int NOT NULL,
	productSeenNumber int NOT NULL,
	productAddedDate date NOT NULL,
	productPrice float NOT NULL,
	productAddress nvarchar(200) NOT NULL,
	productContent ntext NOT NULL,
	districtID int NOT NULL,
	userId int NOT NULL,
);

drop table tblProduct

/* Tạo bảng thành phố */

create table tblCity (
	cityId int NOT NULL identity(1,1),
	cityName nvarchar(30)
);

/* Tạo bảng quận */

create table tblDistrict(
	districtId int identity(1,1) NOT NULL,
	districtName nvarchar(50) NOT NULL,
	cityId int NOT NULL
);

/* Tạo proc truy vấn product */

create proc getAllProducts
as
	select tblProduct.productId, tblProduct.productName, tblProduct.productDescription,
	tblProduct.productCatalog, tblProduct.productStatus, tblProduct.productSeenNumber,
	tblProduct.productAddedDate, tblProduct.productPrice, tblProduct.productAddress,
	tblCity.cityName, tblDistrict.districtName, tblUser.displayName
	from tblProduct, tblCity, tblDistrict, tblUser
	where tblDistrict.cityId = tblCity.cityId and tblProduct.districtId = tblDistrict.districtId and tblProduct.userId = tblUser.id

exec getAllProducts

drop proc getAllProducts

create proc getProductById
@identity int
as
	select tblProduct.productId, tblProduct.productName, tblProduct.productDescription,
	tblProduct.productCatalog, tblProduct.productStatus, tblProduct.productSeenNumber,
	tblProduct.productAddedDate, tblProduct.productPrice, tblProduct.productAddress,
	tblProduct.productContent, tblCity.cityName, tblDistrict.districtName, tblUser.displayName
	from tblProduct, tblCity, tblDistrict, tblUser
	where tblDistrict.cityId = tblCity.cityId and tblProduct.districtId = tblDistrict.districtId and tblProduct.userId = tblUser.id
			and tblProduct.productId = @identity

exec getProductById @identity = 1

drop proc getProductById 

/* Thay đổi mật khẩu */

create proc changerUserPassword
@username varchar(50),
@password varchar(256),
@oldpassword varchar(256)
as
	if EXISTS (select * from tblUser where tblUser.username = @username)
	BEGIN
		declare @currentpassword varchar(256);
		set @currentpassword = (select tblUser.password from tblUser where tblUser.username = @username)
		if (@currentpassword = @password)
			BEGIN
				return -1
			END
		if (@currentpassword != @oldpassword)
			BEGIN
				return -2
			END
		else
			BEGIN
				UPDATE tblUser
				SET tblUser.password = @password
				WHERE tblUser.username = @username
				return 1;
			END
	END
	else
		Begin
			return 0;
		End

drop proc changerUserPassword

DECLARE @return_status int;  
exec @return_status = changerUserPassword @username = "user1", @password="4a8f0735dd8829f0390651339cb9368a76cc71e50918b0166a83925424de9ad1",
				@oldpassword = "d756ac3191464e6e1f97d240635ceaba6d15d437811f4d06eb0508027357103a"
SELECT 'Return Status' = @return_status;

/* Thêm sản phẩm */

create proc addProduct
@name nvarchar(100), @desription ntext,
@catalog int, @addedDate date,
@price float, @address  nvarchar(200),
@content ntext, @district int,
@userid int
as
	BEGIN
		INSERT INTO tblProduct
		VALUES (@name, @desription, @catalog, -1 , 0, @addedDate, @price,
		@address, @content, @district, @userid);
	END

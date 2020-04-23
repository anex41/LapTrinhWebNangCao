create table tblDanhGiaLaiXe(
iDanhgiaID int NOT NULL identity(1,1),
iLaixeID int NOT NULL,
dNgaydanhgia DateTime NOT NULL,
iSoSao int NOT NULL
)

/*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
create proc getDriverInfo
@driverID int
as
if EXISTS (select top 1 * from tblDanhGiaLaiXe where tblDanhGiaLaiXe.iLaixeID = @driverID)
	select iDanhgiaID, dNgaydanhgia, iSoSao from tblDanhGiaLaiXe
	where @driverID = tblDanhGiaLaiXe.iLaixeID
else
	return -1

drop proc getDriverInfo

DECLARE @return_status int;  
EXEC @return_status = getDriverInfo @driverID = 4;  
SELECT 'Return Status' = @return_status;  
GO

exec getDriverInfo @driverID = 4

/*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
create proc getDriverName
as
select sHoTen, iLaixe from tblLaixe

drop proc getDriverName
exec getDriverName

/*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
create proc getDriver
@driverID int
as
select top 1 * from tblLaixe where tblLaixe.iLaixe = @driverID

drop proc getDriver

exec getDriver @driverID = 2

/*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
create proc addReview
@driverID int,
@reviewPoint int,
@reviewDate Datetime
as
INSERT INTO tblDanhGiaLaiXe (iLaixeID, dNgaydanhgia, iSoSao)
values (@driverID, @reviewDate, @reviewPoint)

/*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
create table tblLoaisach(
iMaLoai int NOT NULL identity(1,1),
sLoaiSach nvarchar(60) NOT NULL
)

drop table tblLoaisach

/*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
create table tblSach(
iMaSach int NOT NULL identity(1,1),
iMaLoai int NOT NULL,
sTenSach nvarchar(60) NOT NULL
)

drop table tblSach

/*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/

create proc addtblLoaiSach
@sLoaiSach nvarchar(60)
as
insert into tblLoaiSach
values (@sLoaiSach)

delete tblLoaiSach

drop proc addTblLoaiSach

/*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/

create proc gettblLoaiSach
as
select * from tblLoaisach

exec gettblLoaiSach

/*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/

create proc gettblSach
@identity int
as
if @identity = 0
	select tblSach.iMaSach, tblSach.sTenSach,tblLoaiSach.iMaLoai, tblLoaiSach.sLoaiSach from tblSach,tblLoaiSach
	where tblLoaiSach.iMaLoai = tblSach.iMaLoai
else
	select tblSach.iMaSach, tblSach.sTenSach,tblLoaiSach.iMaLoai, tblLoaiSach.sLoaiSach from tblSach,tblLoaiSach
	where tblLoaiSach.iMaLoai = tblSach.iMaLoai and tblSach.iMaLoai = @identity

exec gettblSach @identity=0

drop proc gettblSach

/*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/

create table tblHangsanxuat(
	iHangsanxuat int NOT NULL identity(1,1),
	Tenhang nvarchar(30) NOT NULL
);

drop table tblHangsanxuat;

/*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/

create proc getHangsanxuatData
as
select * from tblHangsanxuat

exec getHangsanxuatData

/*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/

create table tblDienthoai(
	iDienthoaiID int NOT NULL identity(1,1),
	sTendienthoai nvarchar(30) NOT NULL,
	mGiaban float NOT NULL,
	iSoluong int NOT NULL,
	iNhasanxuat int NOT NULL
);

drop table tblDienthoai;

/*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
create proc addtblDienthoai
@sTenDT nvarchar(30),
@mGiaban float,
@iSoluong int,
@iNhasanxuat int
as
INSERT into tblDienthoai
values (@sTenDT,@mGiaban,@iSoluong,@iNhasanxuat);

/*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
create proc countRecordtblDienthoai
@nsx int,
@beginPrice float,
@endingPrice float
as
if @nsx = -1
	if @beginPrice = -1 and @endingPrice = -1
		SELECT COUNT(iDienthoaiID) as 'NumberOfProduct' FROM tblDienthoai
	else
		SELECT COUNT(iDienthoaiID) as 'NumberOfProduct' FROM tblDienthoai
		where tblDienthoai.mGiaban >= @beginPrice and tblDienthoai.mGiaban <= @endingPrice
else
	if @beginPrice = -1 and @endingPrice = -1
		SELECT COUNT(iDienthoaiID) as 'NumberOfProduct' FROM tblDienthoai 
		where tblDienthoai.iNhasanxuat = @nsx
	else
		SELECT COUNT(iDienthoaiID) as 'NumberOfProduct' FROM tblDienthoai 
		where tblDienthoai.iNhasanxuat = @nsx and tblDienthoai.mGiaban >= @beginPrice and tblDienthoai.mGiaban <= @endingPrice

exec countRecordtblDienthoai @nsx = -1, @beginPrice = 10000, @endingPrice = 30000

drop proc countRecordtblDienthoai

/*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/

create proc gettblDienthoaiData
@start int,
@end int,
@beginPrice float,
@endingPrice float,
@nsx int
as
if @beginPrice = -1 and @endingPrice = -1
	if @nsx = -1
		WITH tblDienthoaiData AS
		(
			SELECT *,
			ROW_NUMBER() OVER (ORDER BY iDienthoaiID) AS 'RowNumber'
			FROM tblDienthoai
		)
		SELECT *
		FROM tblDienthoaiData
		WHERE RowNumber BETWEEN @start AND @end;
	else
		WITH tblDienthoaiData AS
		(
			SELECT *,
			ROW_NUMBER() OVER (ORDER BY iDienthoaiID) AS 'RowNumber'
			FROM tblDienthoai where tblDienthoai.iNhasanxuat = @nsx
		) 
		SELECT *
		FROM tblDienthoaiData 
		WHERE RowNumber BETWEEN @start AND @end;
else
	if @nsx = -1
		WITH tblDienthoaiData AS
		(
			SELECT *,
			ROW_NUMBER() OVER (ORDER BY iDienthoaiID) AS 'RowNumber'
			FROM tblDienthoai where tblDienthoai.mGiaban >= @beginPrice and tblDienthoai.mGiaban <= @endingPrice
		) 
		SELECT * 
		FROM tblDienthoaiData 
		WHERE RowNumber BETWEEN @start AND @end;
	else
		WITH tblDienthoaiData AS
		(
			SELECT *,
			ROW_NUMBER() OVER (ORDER BY iDienthoaiID) AS 'RowNumber'
			FROM tblDienthoai where tblDienthoai.iNhasanxuat = @nsx 
				and tblDienthoai.mGiaban >= @beginPrice 
				and tblDienthoai.mGiaban <= @endingPrice
		) 
		SELECT *
		FROM tblDienthoaiData 
		WHERE RowNumber BETWEEN @start AND @end;

exec gettblDienthoaiData @start = 1, @end = 30, @beginPrice=10000, @endingPrice =30000, @nsx = -1;

select * from tblDienthoai where iDienthoaiID = 1771

drop proc gettblDienthoaiData

/*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/

create table tblUsersB24 (
	iUerID int identity(1,1) NOT NULL,
	sUserName varchar(20) NOT NULL,
	sPassword varchar(256) NOT NULL,
	iLoginTimes int NOT NULL
);

drop table tblUsersB24;

/*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/

create table tblNewsB24(
	iNewsID int identity(1,1) NOT NULL,
	sTitle nvarchar(60) NOT NULL,
	sAbstract nvarchar(60) NOT NULL,
	sContent ntext NOT NULL,
	tPostedDate datetime NOT NULL,
	iViewTimes int NOT NULL,
	bIsAproved bit NOT NULL,
	iUserID int NOT NULL
);

drop table tblNewsB24;

/*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/

create table tblNewsCategoryB24(
	iNewsCategory int identity(1,1) NOT NULL,
	iCategoryID int NOT NULL,
	iNewsID int NOT NULL
);

drop table tblNewsCategoryB24;

/*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/

create table tblCategoriesB24(
	iCategoryID int identity(1,1) NOT NULL,
	sCategoryName nvarchar(60) NOT NULL,
	sDecription nText
);

drop table tblCategoriesB24;

/*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/

create proc addtbltblNewsB24
	@sTitle nvarchar(60),
	@sAbstract nvarchar(60),
	@sContent ntext,
	@tPostedDate datetime,
	@iViewTimes int,
	@iUserID int,
	@category int
	as
		INSERT INTO tblNewsB24
		values (@sTitle,@sAbstract,@sContent,@tPostedDate,@iViewTimes,0,@iUserID)

		insert into tblNewsCategoryB24
		values (@category, SCOPE_IDENTITY())
	
exec addtbltblNewsB24 @sTitle = "Tình hình dịch bệnh căng thẳng",@sAbstract = "Cái gì đó", @sContent = "Thêm nhiều người đã khỏi bệnh, họ rất vui mừng được xuất viện",
	@tPostedDate = "11/11/2020", @iViewTimes = 5, @iUserID = 1, @category = 2;

exec addtbltblNewsB24 @sTitle = "Học sinh lớp 12 được điểm 10",@sAbstract = "Cái gì đó", @sContent = "Học sinh này giỏi quá",
	@tPostedDate = "11/11/2020", @iViewTimes = 5, @iUserID = 1, @category = 1;

exec addtbltblNewsB24 @sTitle = "Việt Nam Vô địch World Cup lần 3",@sAbstract = "Cái gì đó", @sContent = "Đảng CS quang vinh, vĩ đại, Đảng CS VN muôn năm, muôn năm",
	@tPostedDate = "11/11/2020", @iViewTimes = 5, @iUserID = 1, @category = 3;

drop proc addtbltblNewsB24

/*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/

create proc getDisApprovedtblNews
@category int
as
	if @category = -1
		select tblNewsB24.iNewsID, tblNewsB24.sTitle, tblCategoriesB24.sCategoryName from tblNewsB24, tblCategoriesB24, tblNewsCategoryB24
		where tblNewsB24.iNewsID = tblNewsCategoryB24.iNewsID and tblNewsCategoryB24.iCategoryID = tblCategoriesB24.iCategoryID
				and tblNewsB24.bIsAproved = 0
	else
		select tblNewsB24.iNewsID, tblNewsB24.sTitle, tblCategoriesB24.sCategoryName from tblNewsB24, tblNewsCategoryB24, tblCategoriesB24
		where tblNewsB24.iNewsID = tblNewsCategoryB24.iNewsID and tblNewsCategoryB24.iCategoryID = tblCategoriesB24.iCategoryID
				and tblCategoriesB24.iCategoryID = @category and tblNewsB24.bIsAproved = 0

drop proc getDisApprovedtblNews

exec getDisApprovedtblNews @category = -1

/*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/

create proc getApprovedtblNews
@category int
as
	if @category = -1
		select tblNewsB24.iNewsID, tblNewsB24.sTitle, tblCategoriesB24.sCategoryName from tblNewsB24, tblCategoriesB24, tblNewsCategoryB24
		where tblNewsB24.iNewsID = tblNewsCategoryB24.iNewsID and tblNewsCategoryB24.iCategoryID = tblCategoriesB24.iCategoryID
				and tblNewsB24.bIsAproved = 1
	else
		select tblNewsB24.iNewsID, tblNewsB24.sTitle, tblCategoriesB24.sCategoryName from tblNewsB24, tblNewsCategoryB24, tblCategoriesB24
		where tblNewsB24.iNewsID = tblNewsCategoryB24.iNewsID and tblNewsCategoryB24.iCategoryID = tblCategoriesB24.iCategoryID
				and tblCategoriesB24.iCategoryID = @category and tblNewsB24.bIsAproved = 1

drop proc getApprovedtblNews

exec getApprovedtblNews @category = -1

/*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/

create proc approveNews
@id int
as
	update tblNewsB24
	set tblNewsB24.bIsAproved = 1
	where tblNewsB24.iNewsID = @id;

drop proc approveNews

/*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/

create proc DisApproveNews
@id int
as
	update tblNewsB24
	set tblNewsB24.bIsAproved = 0
	where tblNewsB24.iNewsID = @id;

drop proc DisApproveNews

/*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/

create proc getB24News
@flag bit
as
	if @flag = 1
		select tblNewsB24.iNewsID, tblNewsB24.sTitle, tblNewsB24.sContent, tblNewsB24.tPostedDate, tblNewsB24.iUserID, tblCategoriesB24.sCategoryName
		from tblNewsB24, tblNewsCategoryB24, tblCategoriesB24 
		where tblNewsB24.iNewsID = tblNewsCategoryB24.iNewsID and tblNewsCategoryB24.iCategoryID = tblCategoriesB24.iCategoryID
		order by tblCategoriesB24.sCategoryName asc
	else
		select tblNewsB24.iNewsID, tblNewsB24.sTitle, tblNewsB24.sContent, tblNewsB24.tPostedDate, tblNewsB24.iUserID , tblCategoriesB24.sCategoryName
		from tblNewsB24, tblNewsCategoryB24, tblCategoriesB24 
		where tblNewsB24.bIsAproved = 1 and tblNewsB24.iNewsID = tblNewsCategoryB24.iNewsID and tblNewsCategoryB24.iCategoryID = tblCategoriesB24.iCategoryID
		order by tblCategoriesB24.sCategoryName asc

drop proc getB24News

exec getB24News @flag = 0

/*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
create proc getB24User
@name varchar(30)
as
	select top 1 tblUsersB24.sPassword, tblUsersB24.iLoginTimes
	from tblUsersB24
	where tblUsersB24.sUserName = @name

drop proc getB24User

exec getB24User @name = 'admin'

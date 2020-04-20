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
as
SELECT COUNT(iDienthoaiID) as 'NumberOfProduct' FROM tblDienthoai;

exec countRecordtblDienthoai

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
			FROM tblDienthoai
		) 
		SELECT * 
		FROM tblDienthoaiData 
		WHERE tblDienthoaiData.mGiaban >= @beginPrice and tblDienthoaiData.mGiaban <= @endingPrice and
				RowNumber BETWEEN @start AND @end;
	else
		WITH tblDienthoaiData AS
		(
			SELECT *,
			ROW_NUMBER() OVER (ORDER BY iDienthoaiID) AS 'RowNumber'
			FROM tblDienthoai where tblDienthoai.iNhasanxuat = @nsx
		) 
		SELECT *
		FROM tblDienthoaiData 
		WHERE tblDienthoaiData.mGiaban >= @beginPrice 
		and tblDienthoaiData.mGiaban <= @endingPrice and
				RowNumber BETWEEN @start AND @end;

exec gettblDienthoaiData @start = 1, @end = 30, @beginPrice=-1, @endingPrice =-1, @nsx = -1;

drop proc gettblDienthoaiData

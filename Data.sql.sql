CREATE DATABASE Quanlycafe
USE Quanlycafe
CREATE TABLE TableFood
(
    id INT IDENTITY PRIMARY KEY,
    name NVARCHAR(100) NOT NULL DEFAULT N'Ban chua dat ten',
    status NVARCHAR(100) NOT NULL DEFAULT N'trong'
)
CREATE TABLE Account 
(
    UserName NVARCHAR(100) PRIMARY KEY,
    DisplayName NVARCHAR(100) NOT NULL DEFAULT N'Kter',
    PassWord NVARCHAR(1000) NOT NULL DEFAULT 0,
    Type INT NOT NULL DEFAULT 0
)
CREATE TABLE FoodCategory
(
    id INT IDENTITY PRIMARY KEY,
    name NVARCHAR(100) NOT NULL DEFAULT N'chua dat ten'
)
CREATE TABLE Food
(
    id INT IDENTITY PRIMARY KEY,
    name NVARCHAR(100) NOT NULL DEFAULT N'chua dat ten',
    price FLOAT NOT NULL DEFAULT 0,
    idCategory INT NOT NULL
    FOREIGN KEY (idCategory) REFERENCES dbo.FoodCategory(id)
)
CREATE TABLE Bill
(
    id INT IDENTITY PRIMARY KEY,
    DateCheckIn DATE NOT NULL DEFAULT GETDATE(),
    DateCheckOut DATE,
    idTable INT NOT NULL,
    status INT NOT NULL DEFAULT 0
    FOREIGN KEY (idTable) REFERENCES dbo.TableFood(id)
)
CREATE TABLE BillInfo
(
    id INT IDENTITY PRIMARY KEY,
    idBill INT NOT NULL,
    idFood INT NOT NULL,
    count INT NOT NULL DEFAULT 0
    FOREIGN KEY (idBill) REFERENCES dbo.Bill(id),
    FOREIGN KEY (idFood) REFERENCES dbo.Food(id)
)
--them tai khoan
INSERT INTO dbo.Account
           (UserName ,
			DisplayName ,
			PassWord ,
			Type 
			)
VALUES     (
			N'Tram',
			N'Ngoc Tram',
			N'1',
			1
			)		
INSERT INTO dbo.Account
           (UserName ,
			DisplayName ,
			PassWord ,
			Type 
			)
VALUES     (
			N'T',
			N'Tran',
			N'1',
			0
			)	
CREATE PROC USP_GetAccountByUserName
@userName nvarchar(100)
AS
BEGIN
     SELECT * FROM dbo.Account WHERE UserName=@userName
END
EXEC dbo.USP_GetAccountByUserName @userName = N'Tram'

CREATE PROC USP_Login
@userName nvarchar(100), @passWord nvarchar(100)
AS
BEGIN
     SELECT * FROM dbo.Account WHERE UserName = @userName AND PassWord = @passWord 
END
--tao danh sach ban an
DECLARE @i INT = 0
WHILE @i <=10
BEGIN
	INSERT dbo.TableFood (name) VALUES (N'Bàn ' + CAST(@i As nvarchar(100)))
	SET @i=@i+1
END
--
CREATE PROC USP_GetTableList
AS SELECT * FROM dbo.TableFood

UPDATE dbo.TableFood SET STATUS = N'Có người'WHERE id =9

EXEC dbo.USP_GetTableList
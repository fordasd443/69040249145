--เริ่มจาก Master สร้างฐานข้อมูลชื่อ CSMinmart
Create Database CSMinimart
--ปรับให้ฐาข้อมูลสารมารถเพิ่มข้อมูลที่เป็นภาษาไทยได้
Alter Database CSMinimart Collate Thai_CT_AS
--สร้างตารางเก็บข้อมูลพนักงาน ชื่อ Employees
CREATE TABLE Employees (
    EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
    Title VARCHAR(20),
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50),
    Position VARCHAR(50),
    UserName VARCHAR(50) UNIQUE,
    PasswordHash VARCHAR(255) NOT NULL,
    IsActive BIT NOT NULL DEFAULT 1
);	---	สำหรับคนที่สร้างผิด ใช้ database เดิมก่อน master ----



--- ทดสอบเพิ่มข้อมูลในตาราง Employees 
INSERT INTO Employees
    (Title, FirstName, LastName, Position, UserName, PasswordHash)

    VALUES
    ('นาย', 'ภูชิต', 'สายวิชัย',    'Sale Manager', 'user2', 'hashed1');

-- เมื่อเพิ่มเเล้ว ทดสอบเรียกข้อมูลออกมาดู

select * from Employees
--- สร้างตารางหมวดหมู่สินค้า Categoroes
CREATE TABLE Categories (
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,
    CategoryName VARCHAR(50) NOT NULL UNIQUE,
    Description VARCHAR(200)
);
---เพิ่มข้อมูลในตาราง---
INSERT INTO Categories (CategoryName, Description)
VALUES ('เครื่องปรุง', 'น้ำปลา ซอสพริก น้ำส้มสายชู');

INSERT INTO Categories (CategoryName, Description)
VALUES ('เครื่องดื่ม', 'น้ำดื่ม เป๊ปซี่ ชาและกาแฟ');

INSERT INTO Categories (CategoryName, Description)
VALUES ('อาหารสำเร็จรูป', 'มาม่า แกงกะหรี่ โจ๊ก');

INSERT INTO Categories (CategoryName, Description)
VALUES ('เวชภัณฑ์ยา', 'แอลกอฮอล์ สำลี ยาแดง');

----- คำสั่ง ------------
select * from Categories

select * from Products
RUNCATE TABLE Products;

DELETE FROM Employees;

TRUNCATE TABLE Employees;



---- สร้างตารางสินค้า โดย Products โดยมีการอ้างอิง Categries
CREATE TABLE Products (
    ProductID VARCHAR(13) PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL DEFAULT 0,
    UnitsInStock INT NOT NULL DEFAULT 0,
    CategoryID INT NOT NULL,                                              
    Discontinued BIT NOT NULL DEFAULT 0,

    CONSTRAINT CK_Products_UnitPrice
        CHECK (UnitPrice >= 0),

    CONSTRAINT CK_Products_UnitsInStock
        CHECK (UnitsInStock >= 0),

    CONSTRAINT FK_Products_Categories
        FOREIGN KEY (CategoryID)
        REFERENCES Categories(CategoryID)
);
----- ทดสอบเพิ่มข้อมูล productsINSERT INTO Products
    INSERT INTO Products
    (ProductID, ProductName, UnitPrice,
     UnitsInStock, CategoryID)
VALUES
    ('8858757001948', 'โค้ก',
     15.00, 290, 1);


---- ทดสอบคำสั่งที่ 2 ( อย่าลืม อ่าน Rrror)
INSERT INTO Products
    (ProductID, ProductName, UnitPrice, UnitsInStock, CategoryID)
VALUES
    ('8858741304589', 'กระดาษA4', 15.00, 300, 1),
    ('8851907301675', 'ปากกา', 10.00, 400, 1),
    ('8850774031067', 'สมุด', 10.00, 500, 1),
    ('8850774031069', 'เป๊ปซี่', 40.00, 2000, 1),
    ('8850774031270', 'เมาส์', 200.00, 200, 1);


    --- สร้างตารางใบเสร็จ-----
   CREATE TABLE Receipts (
    ReceiptID INT IDENTITY(1,1) PRIMARY KEY,

    ReceiptDate DATETIME NOT NULL
        DEFAULT GETDATE(),

    EmployeeID INT NOT NULL,

    TotalCash DECIMAL(10,2) NOT NULL
        DEFAULT 0,

    CONSTRAINT CK_Receipts_TotalCash
        CHECK (TotalCash >= 0),

    CONSTRAINT FK_Receipts_Employees
        FOREIGN KEY (EmployeeID)
        REFERENCES Employees(EmployeeID)
);
    INSERT INTO Receipts
    (EmployeeID, TotalCash)
VALUES
    (1, 115.00);

SELECT *
FROM Receipts;

---- คำสั่งที่ 2 ---
INSERT INTO Receipts
    (EmployeeID, TotalCash)
VALUES
    (99, 100.00);


    --- ดูข้อมูลในตารางใบเสร็จ---

    selct * from Receipts

    ---- สร้างตาราง Details ---

    CREATE TABLE Details
(
    ReceiptID INT NOT NULL,
    ProductID VARCHAR(13) NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL,
    Quantity INT NOT NULL,

    CONSTRAINT PK_Details
        PRIMARY KEY (ReceiptID, ProductID),

    CONSTRAINT CK_Details_UnitPrice
        CHECK (UnitPrice >= 0),

    CONSTRAINT CK_Details_Quantity
        CHECK (Quantity > 0),

    CONSTRAINT FK_Details_Receipts
        FOREIGN KEY (ReceiptID)
        REFERENCES Receipts(ReceiptID),

    CONSTRAINT FK_Details_Products
        FOREIGN KEY (ProductID)
        REFERENCES Products(ProductID)
);
-- เพิ่มข้อมูล ในตาราง Details ----
INSERT INTO Details
    (ReceiptID, ProductID, UnitPrice, Quantity)
VALUES
    (1, '8858757001948', 15.00, 3);
  --  คำสั่งที่ 2  ---
  INSERT INTO Details
    (ReceiptID, ProductID, UnitPrice, Quantity)
VALUES
    (1, '8858757001948', 15.00, 0);



   --คำสั่งดูข้อมูล Details--
   selct * from Details
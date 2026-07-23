--- สำรวจรายชือตารางใน database

SELECT *
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE';

----- สำรวจโครงสร้างตาราง

EXEC sp_help 'employees';

----คำสั่ง SELECT เบื้องจ้น 
----ค้องการสินค้าทั้งหมด
SELECT* FROM dbo.Products
-----ต้องการรหสัสินค้า ชื่อสินค้า ราคา

Select ProductID,  ProductName, Unitprice from Products

----ค้องการ ชื่อสินค้า ราคา

Select ProductID  รหัส, ProductName  ชื่อสินค้า, Unitprice  ราคา from Products
---- ใช้ Distinct สำหรับข้อมูลที่ซ่ำกัน 
Select Distinct  Position From Employees
---- ใช้ Top(n) สำหรับเเสดงข้อมูล N รายการ
----ปรับปรุงราคาสินค้า " ดินสอ " เป็นราคาใหม่ 17 บาท
Update dbo.Products
set UnitPrice = 17, UnitsInStock = 100
where ProductName = 'ดินสอ'
--- หลังจากรันโค็ดเเล้วดูข้อมูลเปลียนรึไหม
Select * from products


select * From dbo.Products 
WHERE ProductID = N'P001';

---ปรับปรุงจำนวนคงเหลือของน้ำส้ม เพิ่มอีก 100ชิ้น

Update dbo.Products
SET UnitsInStock = UnitsInStock + 100
where ProductName = 'น้ำส้ม'



-----ปรับปรุงราคาเเชมพู ลดราคา 5 บาท
Update dbo.Products
SET UnitPrice = UnitPrice -5
where ProductName = 'เเชสพู'

--- การใช้ whereใน คำสั่ง Select
----ข้อมูลสินค้าที่มีราคาน้อยกว่า 20
Select * from Products
Where UnitPrice <20


-----ชื่อ นามสกุล พนักงาน ที่มีตำเเหน่ง 'Sale Manger'
SELECT FirstName, LastName
FROM Employees
WHERE [Position] = 'Sales Manager';
---- รหัส ชื่อสินค้า

SELECT ProductID, ProductName
FROM Products
WHERE Discontinued = 1

----AND, OR เเละ NOT
SELECT * From dbo.Products
WhERE UnitPrice >= 10
	AND UnitsInStock < 100;

	SELECT *
FROM dbo.Products
WHERE CategoryID = 2
   OR CategoryID = 4;


	---ต้องการข้อมูลสินค้าที่มีจำนวนคงเหลือ 300-500 ชิ้น
SELECT *
FROM Products
WHERE UnitsInStock BETWEEN 300 AND 500;

---
SELECT ProductID, ProductName
FROM dbo.Products
WHERE UnitPrice BETWEEN 10 AND 300;


----- การใช้เงือกไขร่วมกับ witd Card %
----- ต้องการขช้อมูลพนักงานที่มีชื่อต้นด้วย ก
SELECT *
FROM Employees
WHERE FirstName LIKE 'ก%';
----- ต้องการขช้อมูลพนักงานที่มีชื่อต้นด้วย คำ
SELECT *
FROM Employees
WHERE FirstName LIKE '%คำ';

------ เตรียมข้อมูลใช้กับคำสั่ง IS NULL
INSERT INTO Employees (FirstName, UserName, Password)
VALUES
    ('ฟอร์ด', 'ford', '145'),
    ('ลีโอ', 'LEO', '443'),
    ('เมสซี่', 'messi', '444');

--- ปรุงปรุงข้อมูลพนักงานที่ไม่ทราบ
SELECT * FROM dbo.Employees
WHERE LastName IS NULL or LastName =''
----- ปรัลปรุงข้อมูลทดสอบช่องว่าง
UPDATE Employees
SET LastName = ''
WHERE FirstName = 'เมสซี่';

----ปัญหาเบื้องต้นจกาค่า Null คือ ไปรวมกับใครก็เป็น null ไปหมด
SELECT FirstName + ' ' + ISNULL(LastName, '') AS [ชื่อพนักงาน]
FROM Employees;

----การค้นหาข้อมูลตารางวัน
SELECT * from Receipts
Where ReceiptDate < '2013-02-10'

---บางกรณีใช้ Function Year() หรือ Month() ร่วมกับเงือกไขได้
----การข้อมูลใบเสร็จที่ขายสินค้าในเดือนกุมภาพันธ์ ปี2013
select * from Receipts
where Year (ReceiptDate) = 2013
and Month(ReceiptDate)=02

---
SELECT ProductID, ProductName, UnitPrice
FROM dbo.Products
ORDER BY UnitPrice ASC;

SELECT ProductID, ProductName, UnitPrice
FROM dbo.Products
ORDER BY UnitPrice DESC;


----- ต้องการข้อมูลใบเสร็จอันใหม่ที่สุดขึ้นก่อน
Select * from Receipts
order by ReceiptDate desc
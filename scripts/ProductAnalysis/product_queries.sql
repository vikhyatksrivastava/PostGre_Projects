CREATE TABLE "ProductAnalysis".ProductCategory (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(255),
    CategoryDescription TEXT
);

CREATE TABLE "ProductAnalysis".Product (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(255),
    ProductDescription TEXT,
    Price DECIMAL(10, 2),
    CategoryID INT,
    FOREIGN KEY (CategoryID) REFERENCES "ProductAnalysis".ProductCategory(CategoryID)
);

CREATE TABLE "ProductAnalysis".Customer (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(255),
    LastName VARCHAR(255),
    Email VARCHAR(255),
    Phone VARCHAR(20),
    Address TEXT
);

CREATE TABLE "ProductAnalysis".ProductPurchase (
    PurchaseID INT PRIMARY KEY,
    CustomerID INT,
    ProductID INT,
    PurchaseDate DATE,
    Quantity INT,
    TotalPrice DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES "ProductAnalysis".Customer(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES "ProductAnalysis".Product(ProductID)
);

SET datestyle = 'DMY';

COPY "ProductAnalysis".ProductCategory (CategoryID,CategoryName,CategoryDescription)
FROM 'C:\Projects\postgre\Product_Source_file\ProductCategory.csv'
WITH (FORMAT csv, HEADER);

COPY "ProductAnalysis".Product (ProductID,ProductName,ProductDescription,Price,CategoryID)
FROM 'C:\Projects\postgre\Product_Source_file\Product.csv'
WITH (FORMAT csv, HEADER);

COPY "ProductAnalysis".Customer (CustomerID,FirstName,LastName,Email,Phone,Address)
FROM 'C:\Projects\postgre\Product_Source_file\Customer_1.csv'
WITH (FORMAT csv, HEADER);

COPY "ProductAnalysis".ProductPurchase (PurchaseID,CustomerID,ProductID,PurchaseDate,Quantity,TotalPrice)
FROM 'C:\Projects\postgre\Product_Source_file\ProductPurchase.csv'
WITH (FORMAT csv, HEADER);

DELETE FROM "ProductAnalysis".ProductCategory;
DELETE FROM "ProductAnalysis".Product;
DELETE FROM "ProductAnalysis".Customer;
DELETE FROM "ProductAnalysis".ProductPurchase;

-- Fetch the list of customer (firstName and lastName from product database to get the number of products purchased and total amount spent.)

select 
	cust.firstname, 
	cust.lastname, 
	count(prod.productname) as number_of_product, 
	sum(prod_pur.totalprice) as total_expense
from 
	"ProductAnalysis".product prod 
join 
	"ProductAnalysis".productpurchase prod_pur	on prod.productid = prod_pur.productid
join 
	"ProductAnalysis".customer cust on prod_pur.customerid = cust.customerid
group by 
	cust.customerid, cust.firstname, cust.lastname
order by 
	number_of_product desc;




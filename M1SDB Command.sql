use M1S


---- Begin [Create Database Procedure] ------------------------------------------------
-- Verify that the stored procedure does not already exist.  
IF OBJECT_ID ( 'Create_Database_Procedure', 'P' ) IS NOT NULL   
    DROP PROCEDURE Create_Database_Procedure;  
GO  
  
-- Create procedure to retrieve error information.  
CREATE PROCEDURE Create_Database_Procedure  
AS  
BEGIN
	BEGIN TRY  
		create table [Products_Detail] (
			[Id] varchar(120) default 'PD000000',
			[Name] varchar(max),
			[Product_type] int,
			[Description] text,
			[Image_link] varchar(120),
			[Price] int,
			PRIMARY KEY (Id)
		)
		create table [Products_type] (
			[Id] varchar(120) default 'PT000000',
			[Name] varchar(max),
			[Description] text,
			[Image_link] varchar(120),
			PRIMARY KEY (Id)
		)
		create table [Buyers_Buyer] (
			[Id] varchar(120) default 'BB000000',
			[Name] varchar(max),
			[Account_type] int,
			[IsAccountVerified] bit,
			[Image_link] varchar(120),
			[Email] varchar(200),
			[Address1] text,
			[Address2] text,
			PRIMARY KEY (Id)
		) 
		create table [Trading_Discount] (
			[Id] varchar(120) default 'TD000000',
			[Name] varchar(max),
			[Type] int,
			[Percent] int,
			[Amount] int,
			[Product_Type_ID] varchar(120) FOREIGN KEY REFERENCES [Products_type](Id),
			PRIMARY KEY (Id)
		)
		create table [Trading_Buy] (
			[Id] varchar(120) default 'TB000000',
			[MemberID] varchar(120) FOREIGN KEY REFERENCES [Buyers_Buyer](Id),
			[ProductID] varchar(120) FOREIGN KEY REFERENCES [Products_Detail](Id),
			[Date_Purchased] datetime,
			[Number_of_Products] int,
			[Discount_ID] varchar(120) FOREIGN KEY REFERENCES [Trading_Discount](Id),
			[Price_at_time] int,
			PRIMARY KEY (Id)
		) 
	END TRY  
	BEGIN CATCH  
		 SELECT ERROR_NUMBER() AS [Error Number],ERROR_MESSAGE() AS [Error Message]; 
	END CATCH;  
END
GO

-- Change Servername if DB move to new PC or change PC Name --
-- Step 1: Check Hostname/Servername stored in DB and Hostname/Servername exist
-- SELECT @@SERVERNAME AS 'Server Name' 
-- Step 2: Excute (Example change DESKTOP-MP6DLQ8\M1SSEVER to MIRRORSPC\M1SSEVER)
/* 
sp_dropserver 'DESKTOP-MP6DLQ8\M1SSEVER';
GO
sp_addserver 'MIRRORSPC\M1SSEVER', local;
GO
*/


-- Excute --
-- EXEC [Create_Database_Procedure]

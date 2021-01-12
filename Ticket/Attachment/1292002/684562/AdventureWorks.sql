USE [AdventureWorks]
GO
/****** Object:  Schema [HumanResources]    Script Date: 11/22/2013 20:49:42 ******/
CREATE SCHEMA [HumanResources] AUTHORIZATION [dbo]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Contains objects related to employees and departments.' , @level0type=N'SCHEMA',@level0name=N'HumanResources'
GO
/****** Object:  Schema [Person]    Script Date: 11/22/2013 20:49:42 ******/
CREATE SCHEMA [Person] AUTHORIZATION [dbo]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Contains objects related to names and addresses of customers, vendors, and employees' , @level0type=N'SCHEMA',@level0name=N'Person'
GO
/****** Object:  Schema [Production]    Script Date: 11/22/2013 20:49:42 ******/
CREATE SCHEMA [Production] AUTHORIZATION [dbo]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Contains objects related to products, inventory, and manufacturing.' , @level0type=N'SCHEMA',@level0name=N'Production'
GO
/****** Object:  Schema [Purchasing]    Script Date: 11/22/2013 20:49:42 ******/
CREATE SCHEMA [Purchasing] AUTHORIZATION [dbo]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Contains objects related to vendors and purchase orders.' , @level0type=N'SCHEMA',@level0name=N'Purchasing'
GO
/****** Object:  Schema [Sales]    Script Date: 11/22/2013 20:49:42 ******/
CREATE SCHEMA [Sales] AUTHORIZATION [dbo]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Contains objects related to customers, sales orders, and sales territories.' , @level0type=N'SCHEMA',@level0name=N'Sales'
GO
/****** Object:  Table [Production].[TransactionHistoryArchive]    Script Date: 11/22/2013 20:49:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Production].[TransactionHistoryArchive](
	[TransactionID] [int] NOT NULL,
	[ProductID] [int] NOT NULL,
	[ReferenceOrderID] [int] NOT NULL,
	[ReferenceOrderLineID] [int] NOT NULL,
	[TransactionDate] [datetime] NOT NULL,
	[TransactionType] [nchar](1) NOT NULL,
	[Quantity] [int] NOT NULL,
	[ActualCost] [money] NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_TransactionHistoryArchive_TransactionID] PRIMARY KEY CLUSTERED 
(
	[TransactionID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key for TransactionHistoryArchive records.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'TransactionHistoryArchive', @level2type=N'COLUMN',@level2name=N'TransactionID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Product identification number. Foreign key to Product.ProductID.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'TransactionHistoryArchive', @level2type=N'COLUMN',@level2name=N'ProductID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Purchase order, sales order, or work order identification number.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'TransactionHistoryArchive', @level2type=N'COLUMN',@level2name=N'ReferenceOrderID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Line number associated with the purchase order, sales order, or work order.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'TransactionHistoryArchive', @level2type=N'COLUMN',@level2name=N'ReferenceOrderLineID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time of the transaction.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'TransactionHistoryArchive', @level2type=N'COLUMN',@level2name=N'TransactionDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'W = Work Order, S = Sales Order, P = Purchase Order' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'TransactionHistoryArchive', @level2type=N'COLUMN',@level2name=N'TransactionType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Product quantity.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'TransactionHistoryArchive', @level2type=N'COLUMN',@level2name=N'Quantity'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Product cost.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'TransactionHistoryArchive', @level2type=N'COLUMN',@level2name=N'ActualCost'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'TransactionHistoryArchive', @level2type=N'COLUMN',@level2name=N'ModifiedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Transactions for previous years.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'TransactionHistoryArchive'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key (clustered) constraint' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'TransactionHistoryArchive', @level2type=N'CONSTRAINT',@level2name=N'PK_TransactionHistoryArchive_TransactionID'
GO
/****** Object:  XmlSchemaCollection [Sales].[StoreSurveySchemaCollection]    Script Date: 11/22/2013 20:49:42 ******/
CREATE XML SCHEMA COLLECTION [Sales].[StoreSurveySchemaCollection] AS N'<xsd:schema xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:t="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey" targetNamespace="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey" elementFormDefault="qualified"><xsd:element name="StoreSurvey"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:element name="ContactName" type="xsd:string" minOccurs="0" /><xsd:element name="JobTitle" type="xsd:string" minOccurs="0" /><xsd:element name="AnnualSales" type="xsd:decimal" minOccurs="0" /><xsd:element name="AnnualRevenue" type="xsd:decimal" minOccurs="0" /><xsd:element name="BankName" type="xsd:string" minOccurs="0" /><xsd:element name="BusinessType" type="t:BusinessType" minOccurs="0" /><xsd:element name="YearOpened" type="xsd:gYear" minOccurs="0" /><xsd:element name="Specialty" type="t:SpecialtyType" minOccurs="0" /><xsd:element name="SquareFeet" type="xsd:float" minOccurs="0" /><xsd:element name="Brands" type="t:BrandType" minOccurs="0" /><xsd:element name="Internet" type="t:InternetType" minOccurs="0" /><xsd:element name="NumberEmployees" type="xsd:int" minOccurs="0" /><xsd:element name="Comments" type="xsd:string" minOccurs="0" /></xsd:sequence></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:simpleType name="BrandType"><xsd:restriction base="xsd:string"><xsd:enumeration value="AW" /><xsd:enumeration value="2" /><xsd:enumeration value="3" /><xsd:enumeration value="4+" /></xsd:restriction></xsd:simpleType><xsd:simpleType name="BusinessType"><xsd:restriction base="xsd:string"><xsd:enumeration value="BM" /><xsd:enumeration value="BS" /><xsd:enumeration value="D" /><xsd:enumeration value="OS" /><xsd:enumeration value="SGS" /></xsd:restriction></xsd:simpleType><xsd:simpleType name="InternetType"><xsd:restriction base="xsd:string"><xsd:enumeration value="56kb" /><xsd:enumeration value="ISDN" /><xsd:enumeration value="DSL" /><xsd:enumeration value="T1" /><xsd:enumeration value="T2" /><xsd:enumeration value="T3" /></xsd:restriction></xsd:simpleType><xsd:simpleType name="SpecialtyType"><xsd:restriction base="xsd:string"><xsd:enumeration value="Family" /><xsd:enumeration value="Kids" /><xsd:enumeration value="BMX" /><xsd:enumeration value="Touring" /><xsd:enumeration value="Road" /><xsd:enumeration value="Mountain" /><xsd:enumeration value="All" /></xsd:restriction></xsd:simpleType></xsd:schema>'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Collection of XML schemas for the Demographics column in the Sales.Store table.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'XML SCHEMA COLLECTION',@level1name=N'StoreSurveySchemaCollection'
GO
/****** Object:  Table [Sales].[SpecialOffer]    Script Date: 11/22/2013 20:49:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Sales].[SpecialOffer](
	[SpecialOfferID] [int] IDENTITY(1,1) NOT NULL,
	[Description] [nvarchar](255) NOT NULL,
	[DiscountPct] [smallmoney] NOT NULL,
	[Type] [nvarchar](50) NOT NULL,
	[Category] [nvarchar](50) NOT NULL,
	[StartDate] [datetime] NOT NULL,
	[EndDate] [datetime] NOT NULL,
	[MinQty] [int] NOT NULL,
	[MaxQty] [int] NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_SpecialOffer_SpecialOfferID] PRIMARY KEY CLUSTERED 
(
	[SpecialOfferID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key for SpecialOffer records.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SpecialOffer', @level2type=N'COLUMN',@level2name=N'SpecialOfferID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Discount description.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SpecialOffer', @level2type=N'COLUMN',@level2name=N'Description'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Discount precentage.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SpecialOffer', @level2type=N'COLUMN',@level2name=N'DiscountPct'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Discount type category.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SpecialOffer', @level2type=N'COLUMN',@level2name=N'Type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Group the discount applies to such as Reseller or Customer.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SpecialOffer', @level2type=N'COLUMN',@level2name=N'Category'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Discount start date.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SpecialOffer', @level2type=N'COLUMN',@level2name=N'StartDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Discount end date.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SpecialOffer', @level2type=N'COLUMN',@level2name=N'EndDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Minimum discount percent allowed.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SpecialOffer', @level2type=N'COLUMN',@level2name=N'MinQty'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Maximum discount percent allowed.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SpecialOffer', @level2type=N'COLUMN',@level2name=N'MaxQty'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SpecialOffer', @level2type=N'COLUMN',@level2name=N'rowguid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SpecialOffer', @level2type=N'COLUMN',@level2name=N'ModifiedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Sale discounts lookup table.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SpecialOffer'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key (clustered) constraint' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SpecialOffer', @level2type=N'CONSTRAINT',@level2name=N'PK_SpecialOffer_SpecialOfferID'
GO
/****** Object:  XmlSchemaCollection [Production].[ProductDescriptionSchemaCollection]    Script Date: 11/22/2013 20:49:42 ******/
CREATE XML SCHEMA COLLECTION [Production].[ProductDescriptionSchemaCollection] AS N'<xsd:schema xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:t="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelWarrAndMain" targetNamespace="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelWarrAndMain" elementFormDefault="qualified"><xsd:element name="Maintenance"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:element name="NoOfYears" type="xsd:string" /><xsd:element name="Description" type="xsd:string" /></xsd:sequence></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="Warranty"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:element name="WarrantyPeriod" type="xsd:string" /><xsd:element name="Description" type="xsd:string" /></xsd:sequence></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element></xsd:schema><xsd:schema xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:ns1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelWarrAndMain" xmlns:t="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription" targetNamespace="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription" elementFormDefault="qualified"><xsd:import namespace="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelWarrAndMain" /><xsd:element name="Code" type="xsd:string" /><xsd:element name="Description" type="xsd:string" /><xsd:element name="ProductDescription" type="t:ProductDescription" /><xsd:element name="Taxonomy" type="xsd:string" /><xsd:complexType name="Category"><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:element ref="t:Taxonomy" /><xsd:element ref="t:Code" /><xsd:element ref="t:Description" minOccurs="0" /></xsd:sequence></xsd:restriction></xsd:complexContent></xsd:complexType><xsd:complexType name="Features" mixed="true"><xsd:complexContent mixed="true"><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:element ref="ns1:Warranty" /><xsd:element ref="ns1:Maintenance" /><xsd:any namespace="##other" processContents="skip" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence></xsd:restriction></xsd:complexContent></xsd:complexType><xsd:complexType name="Manufacturer"><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:element name="Name" type="xsd:string" minOccurs="0" /><xsd:element name="CopyrightURL" type="xsd:string" minOccurs="0" /><xsd:element name="Copyright" type="xsd:string" minOccurs="0" /><xsd:element name="ProductURL" type="xsd:string" minOccurs="0" /></xsd:sequence></xsd:restriction></xsd:complexContent></xsd:complexType><xsd:complexType name="Picture"><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:element name="Name" type="xsd:string" minOccurs="0" /><xsd:element name="Angle" type="xsd:string" minOccurs="0" /><xsd:element name="Size" type="xsd:string" minOccurs="0" /><xsd:element name="ProductPhotoID" type="xsd:integer" minOccurs="0" /></xsd:sequence></xsd:restriction></xsd:complexContent></xsd:complexType><xsd:complexType name="ProductDescription"><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:element name="Summary" type="t:Summary" minOccurs="0" /><xsd:element name="Manufacturer" type="t:Manufacturer" minOccurs="0" /><xsd:element name="Features" type="t:Features" minOccurs="0" maxOccurs="unbounded" /><xsd:element name="Picture" type="t:Picture" minOccurs="0" maxOccurs="unbounded" /><xsd:element name="Category" type="t:Category" minOccurs="0" maxOccurs="unbounded" /><xsd:element name="Specifications" type="t:Specifications" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute name="ProductModelID" type="xsd:string" /><xsd:attribute name="ProductModelName" type="xsd:string" /></xsd:restriction></xsd:complexContent></xsd:complexType><xsd:complexType name="Specifications" mixed="true"><xsd:complexContent mixed="true"><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:any processContents="skip" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence></xsd:restriction></xsd:complexContent></xsd:complexType><xsd:complexType name="Summary" mixed="true"><xsd:complexContent mixed="true"><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:any namespace="http://www.w3.org/1999/xhtml" processContents="skip" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:schema>'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Collection of XML schemas for the CatalogDescription column in the Production.ProductModel table.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'XML SCHEMA COLLECTION',@level1name=N'ProductDescriptionSchemaCollection'
GO
/****** Object:  Table [Production].[ProductDescription]    Script Date: 11/22/2013 20:49:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Production].[ProductDescription](
	[ProductDescriptionID] [int] IDENTITY(1,1) NOT NULL,
	[Description] [nvarchar](400) NOT NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_ProductDescription_ProductDescriptionID] PRIMARY KEY CLUSTERED 
(
	[ProductDescriptionID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key for ProductDescription records.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductDescription', @level2type=N'COLUMN',@level2name=N'ProductDescriptionID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Description of the product.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductDescription', @level2type=N'COLUMN',@level2name=N'Description'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductDescription', @level2type=N'COLUMN',@level2name=N'rowguid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductDescription', @level2type=N'COLUMN',@level2name=N'ModifiedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Product descriptions in several languages.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductDescription'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key (clustered) constraint' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductDescription', @level2type=N'CONSTRAINT',@level2name=N'PK_ProductDescription_ProductDescriptionID'
GO
/****** Object:  Table [Production].[ProductPhoto]    Script Date: 11/22/2013 20:49:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Production].[ProductPhoto](
	[ProductPhotoID] [int] IDENTITY(1,1) NOT NULL,
	[ThumbNailPhoto] [varbinary](max) NULL,
	[ThumbnailPhotoFileName] [nvarchar](50) NULL,
	[LargePhoto] [varbinary](max) NULL,
	[LargePhotoFileName] [nvarchar](50) NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_ProductPhoto_ProductPhotoID] PRIMARY KEY CLUSTERED 
(
	[ProductPhotoID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key for ProductPhoto records.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductPhoto', @level2type=N'COLUMN',@level2name=N'ProductPhotoID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Small image of the product.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductPhoto', @level2type=N'COLUMN',@level2name=N'ThumbNailPhoto'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Small image file name.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductPhoto', @level2type=N'COLUMN',@level2name=N'ThumbnailPhotoFileName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Large image of the product.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductPhoto', @level2type=N'COLUMN',@level2name=N'LargePhoto'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Large image file name.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductPhoto', @level2type=N'COLUMN',@level2name=N'LargePhotoFileName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductPhoto', @level2type=N'COLUMN',@level2name=N'ModifiedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Product images.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductPhoto'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key (clustered) constraint' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductPhoto', @level2type=N'CONSTRAINT',@level2name=N'PK_ProductPhoto_ProductPhotoID'
GO
/****** Object:  XmlSchemaCollection [Person].[AdditionalContactInfoSchemaCollection]    Script Date: 11/22/2013 20:49:42 ******/
CREATE XML SCHEMA COLLECTION [Person].[AdditionalContactInfoSchemaCollection] AS N'<xsd:schema xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:t="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactInfo" targetNamespace="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactInfo"><xsd:element name="AdditionalContactInfo"><xsd:complexType mixed="true"><xsd:complexContent mixed="true"><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:any namespace="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactRecord http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactTypes" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element></xsd:schema><xsd:schema xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:t="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactRecord" targetNamespace="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactRecord"><xsd:element name="ContactRecord"><xsd:complexType mixed="true"><xsd:complexContent mixed="true"><xsd:restriction base="xsd:anyType"><xsd:choice minOccurs="0" maxOccurs="unbounded"><xsd:any namespace="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactTypes" /></xsd:choice><xsd:attribute name="date" type="xsd:date" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element></xsd:schema><xsd:schema xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:t="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactTypes" targetNamespace="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactTypes" elementFormDefault="qualified"><xsd:element name="eMail" type="t:eMailType" /><xsd:element name="facsimileTelephoneNumber" type="t:phoneNumberType" /><xsd:element name="homePostalAddress" type="t:addressType" /><xsd:element name="internationaliSDNNumber" type="t:phoneNumberType" /><xsd:element name="mobile" type="t:phoneNumberType" /><xsd:element name="pager" type="t:phoneNumberType" /><xsd:element name="physicalDeliveryOfficeName" type="t:addressType" /><xsd:element name="registeredAddress" type="t:addressType" /><xsd:element name="telephoneNumber" type="t:phoneNumberType" /><xsd:element name="telexNumber" type="t:phoneNumberType" /><xsd:complexType name="addressType"><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:element name="Street" type="xsd:string" maxOccurs="2" /><xsd:element name="City" type="xsd:string" /><xsd:element name="StateProvince" type="xsd:string" /><xsd:element name="PostalCode" type="xsd:string" minOccurs="0" /><xsd:element name="CountryRegion" type="xsd:string" /><xsd:element name="SpecialInstructions" type="t:specialInstructionsType" minOccurs="0" /></xsd:sequence></xsd:restriction></xsd:complexContent></xsd:complexType><xsd:complexType name="eMailType"><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:element name="eMailAddress" type="xsd:string" /><xsd:element name="SpecialInstructions" type="t:specialInstructionsType" minOccurs="0" /></xsd:sequence></xsd:restriction></xsd:complexContent></xsd:complexType><xsd:complexType name="phoneNumberType"><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:element name="number"><xsd:simpleType><xsd:restriction base="xsd:string"><xsd:pattern value="[0-9\(\)\-]*" /></xsd:restriction></xsd:simpleType></xsd:element><xsd:element name="SpecialInstructions" type="t:specialInstructionsType" minOccurs="0" /></xsd:sequence></xsd:restriction></xsd:complexContent></xsd:complexType><xsd:complexType name="specialInstructionsType" mixed="true"><xsd:complexContent mixed="true"><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:any namespace="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactTypes" minOccurs="0" maxOccurs="unbounded" /></xsd:sequence></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:schema>'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Collection of XML schemas for the AdditionalContactInfo column in the Person.Contact table.' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'XML SCHEMA COLLECTION',@level1name=N'AdditionalContactInfoSchemaCollection'
GO
/****** Object:  Table [Person].[BusinessEntity]    Script Date: 11/22/2013 20:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Person].[BusinessEntity](
	[BusinessEntityID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_BusinessEntity_BusinessEntityID] PRIMARY KEY CLUSTERED 
(
	[BusinessEntityID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key for all customers, vendors, and employees.' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'BusinessEntity', @level2type=N'COLUMN',@level2name=N'BusinessEntityID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'BusinessEntity', @level2type=N'COLUMN',@level2name=N'rowguid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'BusinessEntity', @level2type=N'COLUMN',@level2name=N'ModifiedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Source of the ID that connects vendors, customers, and employees with address and contact information.' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'BusinessEntity'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key (clustered) constraint' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'BusinessEntity', @level2type=N'CONSTRAINT',@level2name=N'PK_BusinessEntity_BusinessEntityID'
GO
/****** Object:  Table [dbo].[AWBuildVersion]    Script Date: 11/22/2013 20:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AWBuildVersion](
	[SystemInformationID] [tinyint] IDENTITY(1,1) NOT NULL,
	[Database Version] [nvarchar](25) NOT NULL,
	[VersionDate] [datetime] NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_AWBuildVersion_SystemInformationID] PRIMARY KEY CLUSTERED 
(
	[SystemInformationID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key for AWBuildVersion records.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AWBuildVersion', @level2type=N'COLUMN',@level2name=N'SystemInformationID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Version number of the database in 9.yy.mm.dd.00 format.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AWBuildVersion', @level2type=N'COLUMN',@level2name=N'Database Version'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AWBuildVersion', @level2type=N'COLUMN',@level2name=N'VersionDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AWBuildVersion', @level2type=N'COLUMN',@level2name=N'ModifiedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Current version number of the AdventureWorks2008R2 sample database. ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AWBuildVersion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key (clustered) constraint' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AWBuildVersion', @level2type=N'CONSTRAINT',@level2name=N'PK_AWBuildVersion_SystemInformationID'
GO
/****** Object:  Table [Sales].[CreditCard]    Script Date: 11/22/2013 20:49:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Sales].[CreditCard](
	[CreditCardID] [int] IDENTITY(1,1) NOT NULL,
	[CardType] [nvarchar](50) NOT NULL,
	[CardNumber] [nvarchar](25) NOT NULL,
	[ExpMonth] [tinyint] NOT NULL,
	[ExpYear] [smallint] NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_CreditCard_CreditCardID] PRIMARY KEY CLUSTERED 
(
	[CreditCardID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key for CreditCard records.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'CreditCard', @level2type=N'COLUMN',@level2name=N'CreditCardID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Credit card name.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'CreditCard', @level2type=N'COLUMN',@level2name=N'CardType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Credit card number.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'CreditCard', @level2type=N'COLUMN',@level2name=N'CardNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Credit card expiration month.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'CreditCard', @level2type=N'COLUMN',@level2name=N'ExpMonth'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Credit card expiration year.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'CreditCard', @level2type=N'COLUMN',@level2name=N'ExpYear'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'CreditCard', @level2type=N'COLUMN',@level2name=N'ModifiedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Customer credit card information.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'CreditCard'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key (clustered) constraint' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'CreditCard', @level2type=N'CONSTRAINT',@level2name=N'PK_CreditCard_CreditCardID'
GO
/****** Object:  Table [dbo].[DatabaseLog]    Script Date: 11/22/2013 20:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DatabaseLog](
	[DatabaseLogID] [int] IDENTITY(1,1) NOT NULL,
	[PostTime] [datetime] NOT NULL,
	[DatabaseUser] [sysname] NOT NULL,
	[Event] [sysname] NOT NULL,
	[Schema] [sysname] NULL,
	[Object] [sysname] NULL,
	[TSQL] [nvarchar](max) NOT NULL,
	[XmlEvent] [xml] NOT NULL,
 CONSTRAINT [PK_DatabaseLog_DatabaseLogID] PRIMARY KEY NONCLUSTERED 
(
	[DatabaseLogID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key for DatabaseLog records.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DatabaseLog', @level2type=N'COLUMN',@level2name=N'DatabaseLogID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The date and time the DDL change occurred.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DatabaseLog', @level2type=N'COLUMN',@level2name=N'PostTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The user who implemented the DDL change.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DatabaseLog', @level2type=N'COLUMN',@level2name=N'DatabaseUser'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The type of DDL statement that was executed.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DatabaseLog', @level2type=N'COLUMN',@level2name=N'Event'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The schema to which the changed object belongs.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DatabaseLog', @level2type=N'COLUMN',@level2name=N'Schema'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The object that was changed by the DDL statment.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DatabaseLog', @level2type=N'COLUMN',@level2name=N'Object'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The exact Transact-SQL statement that was executed.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DatabaseLog', @level2type=N'COLUMN',@level2name=N'TSQL'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The raw XML data generated by database trigger.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DatabaseLog', @level2type=N'COLUMN',@level2name=N'XmlEvent'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Audit table tracking all DDL changes made to the AdventureWorks database. Data is captured by the database trigger ddlDatabaseTriggerLog.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DatabaseLog'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key (nonclustered) constraint' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DatabaseLog', @level2type=N'CONSTRAINT',@level2name=N'PK_DatabaseLog_DatabaseLogID'
GO
/****** Object:  XmlSchemaCollection [Person].[IndividualSurveySchemaCollection]    Script Date: 11/22/2013 20:49:42 ******/
CREATE XML SCHEMA COLLECTION [Person].[IndividualSurveySchemaCollection] AS N'<xsd:schema xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:t="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey" targetNamespace="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey" elementFormDefault="qualified"><xsd:element name="IndividualSurvey"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:element name="TotalPurchaseYTD" type="xsd:decimal" minOccurs="0" /><xsd:element name="DateFirstPurchase" type="xsd:date" minOccurs="0" /><xsd:element name="BirthDate" type="xsd:date" minOccurs="0" /><xsd:element name="MaritalStatus" type="xsd:string" minOccurs="0" /><xsd:element name="YearlyIncome" type="t:SalaryType" minOccurs="0" /><xsd:element name="Gender" type="xsd:string" minOccurs="0" /><xsd:element name="TotalChildren" type="xsd:int" minOccurs="0" /><xsd:element name="NumberChildrenAtHome" type="xsd:int" minOccurs="0" /><xsd:element name="Education" type="xsd:string" minOccurs="0" /><xsd:element name="Occupation" type="xsd:string" minOccurs="0" /><xsd:element name="HomeOwnerFlag" type="xsd:string" minOccurs="0" /><xsd:element name="NumberCarsOwned" type="xsd:int" minOccurs="0" /><xsd:element name="Hobby" type="xsd:string" minOccurs="0" maxOccurs="unbounded" /><xsd:element name="CommuteDistance" type="t:MileRangeType" minOccurs="0" /><xsd:element name="Comments" type="xsd:string" minOccurs="0" /></xsd:sequence></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:simpleType name="MileRangeType"><xsd:restriction base="xsd:string"><xsd:enumeration value="0-1 Miles" /><xsd:enumeration value="1-2 Miles" /><xsd:enumeration value="2-5 Miles" /><xsd:enumeration value="5-10 Miles" /><xsd:enumeration value="10+ Miles" /></xsd:restriction></xsd:simpleType><xsd:simpleType name="SalaryType"><xsd:restriction base="xsd:string"><xsd:enumeration value="0-25000" /><xsd:enumeration value="25001-50000" /><xsd:enumeration value="50001-75000" /><xsd:enumeration value="75001-100000" /><xsd:enumeration value="greater than 100000" /></xsd:restriction></xsd:simpleType></xsd:schema>'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Collection of XML schemas for the Demographics column in the Person.Person table.' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'XML SCHEMA COLLECTION',@level1name=N'IndividualSurveySchemaCollection'
GO
/****** Object:  Table [Production].[Illustration]    Script Date: 11/22/2013 20:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Production].[Illustration](
	[IllustrationID] [int] IDENTITY(1,1) NOT NULL,
	[Diagram] [xml] NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Illustration_IllustrationID] PRIMARY KEY CLUSTERED 
(
	[IllustrationID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key for Illustration records.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'Illustration', @level2type=N'COLUMN',@level2name=N'IllustrationID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Illustrations used in manufacturing instructions. Stored as XML.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'Illustration', @level2type=N'COLUMN',@level2name=N'Diagram'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'Illustration', @level2type=N'COLUMN',@level2name=N'ModifiedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Bicycle assembly diagrams.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'Illustration'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key (clustered) constraint' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'Illustration', @level2type=N'CONSTRAINT',@level2name=N'PK_Illustration_IllustrationID'
GO
/****** Object:  XmlSchemaCollection [HumanResources].[HRResumeSchemaCollection]    Script Date: 11/22/2013 20:49:42 ******/
CREATE XML SCHEMA COLLECTION [HumanResources].[HRResumeSchemaCollection] AS N'<xsd:schema xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:t="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume" targetNamespace="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume" elementFormDefault="qualified"><xsd:element name="Address" type="t:AddressType" /><xsd:element name="Education" type="t:EducationType" /><xsd:element name="Employment" type="t:EmploymentType" /><xsd:element name="Location" type="t:LocationType" /><xsd:element name="Name" type="t:NameType" /><xsd:element name="Resume" type="t:ResumeType" /><xsd:element name="Telephone" type="t:TelephoneType" /><xsd:complexType name="AddressType"><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:element name="Addr.Type" type="xsd:string" /><xsd:element name="Addr.OrgName" type="xsd:string" minOccurs="0" /><xsd:element name="Addr.Street" type="xsd:string" maxOccurs="unbounded" /><xsd:element name="Addr.Location"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:element ref="t:Location" /></xsd:sequence></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="Addr.PostalCode" type="xsd:string" /><xsd:element name="Addr.Telephone" minOccurs="0"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:element ref="t:Telephone" maxOccurs="unbounded" /></xsd:sequence></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element></xsd:sequence></xsd:restriction></xsd:complexContent></xsd:complexType><xsd:complexType name="EducationType"><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:element name="Edu.Level" type="xsd:string" /><xsd:element name="Edu.StartDate" type="xsd:date" /><xsd:element name="Edu.EndDate" type="xsd:date" /><xsd:element name="Edu.Degree" type="xsd:string" minOccurs="0" /><xsd:element name="Edu.Major" type="xsd:string" minOccurs="0" /><xsd:element name="Edu.Minor" type="xsd:string" minOccurs="0" /><xsd:element name="Edu.GPA" type="xsd:string" minOccurs="0" /><xsd:element name="Edu.GPAAlternate" type="xsd:decimal" minOccurs="0" /><xsd:element name="Edu.GPAScale" type="xsd:decimal" minOccurs="0" /><xsd:element name="Edu.School" type="xsd:string" minOccurs="0" /><xsd:element name="Edu.Location" minOccurs="0"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:element ref="t:Location" /></xsd:sequence></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element></xsd:sequence></xsd:restriction></xsd:complexContent></xsd:complexType><xsd:complexType name="EmploymentType"><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:element name="Emp.StartDate" type="xsd:date" minOccurs="0" /><xsd:element name="Emp.EndDate" type="xsd:date" minOccurs="0" /><xsd:element name="Emp.OrgName" type="xsd:string" /><xsd:element name="Emp.JobTitle" type="xsd:string" /><xsd:element name="Emp.Responsibility" type="xsd:string" /><xsd:element name="Emp.FunctionCategory" type="xsd:string" minOccurs="0" /><xsd:element name="Emp.IndustryCategory" type="xsd:string" minOccurs="0" /><xsd:element name="Emp.Location" minOccurs="0"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:element ref="t:Location" /></xsd:sequence></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element></xsd:sequence></xsd:restriction></xsd:complexContent></xsd:complexType><xsd:complexType name="LocationType"><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:element name="Loc.CountryRegion" type="xsd:string" /><xsd:element name="Loc.State" type="xsd:string" minOccurs="0" /><xsd:element name="Loc.City" type="xsd:string" minOccurs="0" /></xsd:sequence></xsd:restriction></xsd:complexContent></xsd:complexType><xsd:complexType name="NameType"><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:element name="Name.Prefix" type="xsd:string" minOccurs="0" /><xsd:element name="Name.First" type="xsd:string" /><xsd:element name="Name.Middle" type="xsd:string" minOccurs="0" /><xsd:element name="Name.Last" type="xsd:string" /><xsd:element name="Name.Suffix" type="xsd:string" minOccurs="0" /></xsd:sequence></xsd:restriction></xsd:complexContent></xsd:complexType><xsd:complexType name="ResumeType"><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:element ref="t:Name" /><xsd:element name="Skills" type="xsd:string" minOccurs="0" /><xsd:element ref="t:Employment" maxOccurs="unbounded" /><xsd:element ref="t:Education" maxOccurs="unbounded" /><xsd:element ref="t:Address" maxOccurs="unbounded" /><xsd:element ref="t:Telephone" minOccurs="0" /><xsd:element name="EMail" type="xsd:string" minOccurs="0" /><xsd:element name="WebSite" type="xsd:string" minOccurs="0" /></xsd:sequence></xsd:restriction></xsd:complexContent></xsd:complexType><xsd:complexType name="TelephoneType"><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:element name="Tel.Type" type="xsd:anyType" minOccurs="0" /><xsd:element name="Tel.IntlCode" type="xsd:int" minOccurs="0" /><xsd:element name="Tel.AreaCode" type="xsd:int" minOccurs="0" /><xsd:element name="Tel.Number" type="xsd:string" /><xsd:element name="Tel.Extension" type="xsd:int" minOccurs="0" /></xsd:sequence></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:schema>'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Collection of XML schemas for the Resume column in the HumanResources.JobCandidate table.' , @level0type=N'SCHEMA',@level0name=N'HumanResources', @level1type=N'XML SCHEMA COLLECTION',@level1name=N'HRResumeSchemaCollection'
GO
/****** Object:  Table [dbo].[ErrorLog]    Script Date: 11/22/2013 20:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ErrorLog](
	[ErrorLogID] [int] IDENTITY(1,1) NOT NULL,
	[ErrorTime] [datetime] NOT NULL,
	[UserName] [sysname] NOT NULL,
	[ErrorNumber] [int] NOT NULL,
	[ErrorSeverity] [int] NULL,
	[ErrorState] [int] NULL,
	[ErrorProcedure] [nvarchar](126) NULL,
	[ErrorLine] [int] NULL,
	[ErrorMessage] [nvarchar](4000) NOT NULL,
 CONSTRAINT [PK_ErrorLog_ErrorLogID] PRIMARY KEY CLUSTERED 
(
	[ErrorLogID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key for ErrorLog records.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ErrorLog', @level2type=N'COLUMN',@level2name=N'ErrorLogID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The date and time at which the error occurred.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ErrorLog', @level2type=N'COLUMN',@level2name=N'ErrorTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The user who executed the batch in which the error occurred.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ErrorLog', @level2type=N'COLUMN',@level2name=N'UserName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The error number of the error that occurred.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ErrorLog', @level2type=N'COLUMN',@level2name=N'ErrorNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The severity of the error that occurred.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ErrorLog', @level2type=N'COLUMN',@level2name=N'ErrorSeverity'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The state number of the error that occurred.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ErrorLog', @level2type=N'COLUMN',@level2name=N'ErrorState'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The name of the stored procedure or trigger where the error occurred.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ErrorLog', @level2type=N'COLUMN',@level2name=N'ErrorProcedure'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The line number at which the error occurred.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ErrorLog', @level2type=N'COLUMN',@level2name=N'ErrorLine'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The message text of the error that occurred.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ErrorLog', @level2type=N'COLUMN',@level2name=N'ErrorMessage'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Audit table tracking errors in the the AdventureWorks database that are caught by the CATCH block of a TRY...CATCH construct. Data is inserted by stored procedure dbo.uspLogError when it is executed from inside the CATCH block of a TRY...CATCH construct.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ErrorLog'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key (clustered) constraint' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ErrorLog', @level2type=N'CONSTRAINT',@level2name=N'PK_ErrorLog_ErrorLogID'
GO
/****** Object:  XmlSchemaCollection [Production].[ManuInstructionsSchemaCollection]    Script Date: 11/22/2013 20:49:42 ******/
CREATE XML SCHEMA COLLECTION [Production].[ManuInstructionsSchemaCollection] AS N'<xsd:schema xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:t="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelManuInstructions" targetNamespace="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelManuInstructions" elementFormDefault="qualified"><xsd:element name="root"><xsd:complexType mixed="true"><xsd:complexContent mixed="true"><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:element name="Location" maxOccurs="unbounded"><xsd:complexType mixed="true"><xsd:complexContent mixed="true"><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:element name="step" type="t:StepType" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute name="LocationID" type="xsd:integer" use="required" /><xsd:attribute name="SetupHours" type="xsd:decimal" /><xsd:attribute name="MachineHours" type="xsd:decimal" /><xsd:attribute name="LaborHours" type="xsd:decimal" /><xsd:attribute name="LotSize" type="xsd:decimal" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element></xsd:sequence></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:complexType name="StepType" mixed="true"><xsd:complexContent mixed="true"><xsd:restriction base="xsd:anyType"><xsd:choice minOccurs="0" maxOccurs="unbounded"><xsd:element name="tool" type="xsd:string" /><xsd:element name="material" type="xsd:string" /><xsd:element name="blueprint" type="xsd:string" /><xsd:element name="specs" type="xsd:string" /><xsd:element name="diag" type="xsd:string" /></xsd:choice></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:schema>'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Collection of XML schemas for the Instructions column in the Production.ProductModel table.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'XML SCHEMA COLLECTION',@level1name=N'ManuInstructionsSchemaCollection'
GO
/****** Object:  Table [Production].[Location]    Script Date: 11/22/2013 20:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Production].[Location](
	[LocationID] [smallint] IDENTITY(1,1) NOT NULL,
	[Name] [dbo].[Name] NOT NULL,
	[CostRate] [smallmoney] NOT NULL,
	[Availability] [decimal](8, 2) NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Location_LocationID] PRIMARY KEY CLUSTERED 
(
	[LocationID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key for Location records.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'Location', @level2type=N'COLUMN',@level2name=N'LocationID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Location description.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'Location', @level2type=N'COLUMN',@level2name=N'Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Standard hourly cost of the manufacturing location.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'Location', @level2type=N'COLUMN',@level2name=N'CostRate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Work capacity (in hours) of the manufacturing location.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'Location', @level2type=N'COLUMN',@level2name=N'Availability'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'Location', @level2type=N'COLUMN',@level2name=N'ModifiedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Product inventory and manufacturing locations.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'Location'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key (clustered) constraint' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'Location', @level2type=N'CONSTRAINT',@level2name=N'PK_Location_LocationID'
GO
/****** Object:  Table [Person].[Person]    Script Date: 11/22/2013 20:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Person].[Person](
	[BusinessEntityID] [int] NOT NULL,
	[PersonType] [nchar](2) NOT NULL,
	[NameStyle] [dbo].[NameStyle] NOT NULL,
	[Title] [nvarchar](8) NULL,
	[FirstName] [dbo].[Name] NOT NULL,
	[MiddleName] [dbo].[Name] NULL,
	[LastName] [dbo].[Name] NOT NULL,
	[Suffix] [nvarchar](10) NULL,
	[EmailPromotion] [int] NOT NULL,
	[AdditionalContactInfo] [xml](CONTENT [Person].[AdditionalContactInfoSchemaCollection]) NULL,
	[Demographics] [xml](CONTENT [Person].[IndividualSurveySchemaCollection]) NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Person_BusinessEntityID] PRIMARY KEY CLUSTERED 
(
	[BusinessEntityID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key for Person records.' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'Person', @level2type=N'COLUMN',@level2name=N'BusinessEntityID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary type of person: SC = Store Contact, IN = Individual (retail) customer, SP = Sales person, EM = Employee (non-sales), VC = Vendor contact, GC = General contact' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'Person', @level2type=N'COLUMN',@level2name=N'PersonType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0 = The data in FirstName and LastName are stored in western style (first name, last name) order.  1 = Eastern style (last name, first name) order.' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'Person', @level2type=N'COLUMN',@level2name=N'NameStyle'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'A courtesy title. For example, Mr. or Ms.' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'Person', @level2type=N'COLUMN',@level2name=N'Title'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'First name of the person.' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'Person', @level2type=N'COLUMN',@level2name=N'FirstName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Middle name or middle initial of the person.' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'Person', @level2type=N'COLUMN',@level2name=N'MiddleName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last name of the person.' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'Person', @level2type=N'COLUMN',@level2name=N'LastName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Surname suffix. For example, Sr. or Jr.' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'Person', @level2type=N'COLUMN',@level2name=N'Suffix'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0 = Contact does not wish to receive e-mail promotions, 1 = Contact does wish to receive e-mail promotions from AdventureWorks, 2 = Contact does wish to receive e-mail promotions from AdventureWorks and selected partners. ' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'Person', @level2type=N'COLUMN',@level2name=N'EmailPromotion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Additional contact information about the person stored in xml format. ' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'Person', @level2type=N'COLUMN',@level2name=N'AdditionalContactInfo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Personal information such as hobbies, and income collected from online shoppers. Used for sales analysis.' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'Person', @level2type=N'COLUMN',@level2name=N'Demographics'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'Person', @level2type=N'COLUMN',@level2name=N'rowguid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'Person', @level2type=N'COLUMN',@level2name=N'ModifiedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Human beings involved with AdventureWorks: employees, customer contacts, and vendor contacts.' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'Person'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key (clustered) constraint' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'Person', @level2type=N'CONSTRAINT',@level2name=N'PK_Person_BusinessEntityID'
GO
/****** Object:  Table [HumanResources].[Department]    Script Date: 11/22/2013 20:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HumanResources].[Department](
	[DepartmentID] [smallint] IDENTITY(1,1) NOT NULL,
	[Name] [dbo].[Name] NOT NULL,
	[GroupName] [dbo].[Name] NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Department_DepartmentID] PRIMARY KEY CLUSTERED 
(
	[DepartmentID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key for Department records.' , @level0type=N'SCHEMA',@level0name=N'HumanResources', @level1type=N'TABLE',@level1name=N'Department', @level2type=N'COLUMN',@level2name=N'DepartmentID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Name of the department.' , @level0type=N'SCHEMA',@level0name=N'HumanResources', @level1type=N'TABLE',@level1name=N'Department', @level2type=N'COLUMN',@level2name=N'Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Name of the group to which the department belongs.' , @level0type=N'SCHEMA',@level0name=N'HumanResources', @level1type=N'TABLE',@level1name=N'Department', @level2type=N'COLUMN',@level2name=N'GroupName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'HumanResources', @level1type=N'TABLE',@level1name=N'Department', @level2type=N'COLUMN',@level2name=N'ModifiedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Lookup table containing the departments within the Adventure Works Cycles company.' , @level0type=N'SCHEMA',@level0name=N'HumanResources', @level1type=N'TABLE',@level1name=N'Department'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key (clustered) constraint' , @level0type=N'SCHEMA',@level0name=N'HumanResources', @level1type=N'TABLE',@level1name=N'Department', @level2type=N'CONSTRAINT',@level2name=N'PK_Department_DepartmentID'
GO
/****** Object:  Table [Sales].[Currency]    Script Date: 11/22/2013 20:49:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Sales].[Currency](
	[CurrencyCode] [nchar](3) NOT NULL,
	[Name] [dbo].[Name] NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Currency_CurrencyCode] PRIMARY KEY CLUSTERED 
(
	[CurrencyCode] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The ISO code for the Currency.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'Currency', @level2type=N'COLUMN',@level2name=N'CurrencyCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Currency name.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'Currency', @level2type=N'COLUMN',@level2name=N'Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'Currency', @level2type=N'COLUMN',@level2name=N'ModifiedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Lookup table containing standard ISO currencies.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'Currency'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key (clustered) constraint' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'Currency', @level2type=N'CONSTRAINT',@level2name=N'PK_Currency_CurrencyCode'
GO
/****** Object:  Table [Production].[Culture]    Script Date: 11/22/2013 20:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Production].[Culture](
	[CultureID] [nchar](6) NOT NULL,
	[Name] [dbo].[Name] NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Culture_CultureID] PRIMARY KEY CLUSTERED 
(
	[CultureID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key for Culture records.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'Culture', @level2type=N'COLUMN',@level2name=N'CultureID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Culture description.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'Culture', @level2type=N'COLUMN',@level2name=N'Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'Culture', @level2type=N'COLUMN',@level2name=N'ModifiedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Lookup table containing the languages in which some AdventureWorks data is stored.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'Culture'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key (clustered) constraint' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'Culture', @level2type=N'CONSTRAINT',@level2name=N'PK_Culture_CultureID'
GO
/****** Object:  Table [Person].[AddressType]    Script Date: 11/22/2013 20:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Person].[AddressType](
	[AddressTypeID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [dbo].[Name] NOT NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_AddressType_AddressTypeID] PRIMARY KEY CLUSTERED 
(
	[AddressTypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key for AddressType records.' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'AddressType', @level2type=N'COLUMN',@level2name=N'AddressTypeID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Address type description. For example, Billing, Home, or Shipping.' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'AddressType', @level2type=N'COLUMN',@level2name=N'Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'AddressType', @level2type=N'COLUMN',@level2name=N'rowguid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'AddressType', @level2type=N'COLUMN',@level2name=N'ModifiedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Types of addresses stored in the Address table. ' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'AddressType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key (clustered) constraint' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'AddressType', @level2type=N'CONSTRAINT',@level2name=N'PK_AddressType_AddressTypeID'
GO
/****** Object:  Table [Person].[CountryRegion]    Script Date: 11/22/2013 20:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Person].[CountryRegion](
	[CountryRegionCode] [nvarchar](3) NOT NULL,
	[Name] [dbo].[Name] NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_CountryRegion_CountryRegionCode] PRIMARY KEY CLUSTERED 
(
	[CountryRegionCode] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ISO standard code for countries and regions.' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'CountryRegion', @level2type=N'COLUMN',@level2name=N'CountryRegionCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Country or region name.' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'CountryRegion', @level2type=N'COLUMN',@level2name=N'Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'CountryRegion', @level2type=N'COLUMN',@level2name=N'ModifiedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Lookup table containing the ISO standard codes for countries and regions.' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'CountryRegion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key (clustered) constraint' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'CountryRegion', @level2type=N'CONSTRAINT',@level2name=N'PK_CountryRegion_CountryRegionCode'
GO
/****** Object:  Table [Person].[ContactType]    Script Date: 11/22/2013 20:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Person].[ContactType](
	[ContactTypeID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [dbo].[Name] NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_ContactType_ContactTypeID] PRIMARY KEY CLUSTERED 
(
	[ContactTypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key for ContactType records.' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'ContactType', @level2type=N'COLUMN',@level2name=N'ContactTypeID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Contact type description.' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'ContactType', @level2type=N'COLUMN',@level2name=N'Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'ContactType', @level2type=N'COLUMN',@level2name=N'ModifiedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Lookup table containing the types of business entity contacts.' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'ContactType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key (clustered) constraint' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'ContactType', @level2type=N'CONSTRAINT',@level2name=N'PK_ContactType_ContactTypeID'
GO
/****** Object:  Table [Production].[ProductModel]    Script Date: 11/22/2013 20:49:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Production].[ProductModel](
	[ProductModelID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [dbo].[Name] NOT NULL,
	[CatalogDescription] [xml](CONTENT [Production].[ProductDescriptionSchemaCollection]) NULL,
	[Instructions] [xml](CONTENT [Production].[ManuInstructionsSchemaCollection]) NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_ProductModel_ProductModelID] PRIMARY KEY CLUSTERED 
(
	[ProductModelID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key for ProductModel records.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductModel', @level2type=N'COLUMN',@level2name=N'ProductModelID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Product model description.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductModel', @level2type=N'COLUMN',@level2name=N'Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Detailed product catalog information in xml format.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductModel', @level2type=N'COLUMN',@level2name=N'CatalogDescription'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Manufacturing instructions in xml format.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductModel', @level2type=N'COLUMN',@level2name=N'Instructions'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductModel', @level2type=N'COLUMN',@level2name=N'rowguid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductModel', @level2type=N'COLUMN',@level2name=N'ModifiedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Product model classification.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductModel'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key (clustered) constraint' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductModel', @level2type=N'CONSTRAINT',@level2name=N'PK_ProductModel_ProductModelID'
GO
/****** Object:  Table [Production].[ProductCategory]    Script Date: 11/22/2013 20:49:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Production].[ProductCategory](
	[ProductCategoryID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [dbo].[Name] NOT NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_ProductCategory_ProductCategoryID] PRIMARY KEY CLUSTERED 
(
	[ProductCategoryID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key for ProductCategory records.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductCategory', @level2type=N'COLUMN',@level2name=N'ProductCategoryID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Category description.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductCategory', @level2type=N'COLUMN',@level2name=N'Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductCategory', @level2type=N'COLUMN',@level2name=N'rowguid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductCategory', @level2type=N'COLUMN',@level2name=N'ModifiedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'High-level product categorization.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductCategory'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key (clustered) constraint' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductCategory', @level2type=N'CONSTRAINT',@level2name=N'PK_ProductCategory_ProductCategoryID'
GO
/****** Object:  Table [Person].[PhoneNumberType]    Script Date: 11/22/2013 20:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Person].[PhoneNumberType](
	[PhoneNumberTypeID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [dbo].[Name] NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_PhoneNumberType_PhoneNumberTypeID] PRIMARY KEY CLUSTERED 
(
	[PhoneNumberTypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key for telephone number type records.' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'PhoneNumberType', @level2type=N'COLUMN',@level2name=N'PhoneNumberTypeID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Name of the telephone number type' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'PhoneNumberType', @level2type=N'COLUMN',@level2name=N'Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'PhoneNumberType', @level2type=N'COLUMN',@level2name=N'ModifiedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Type of phone number of a person.' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'PhoneNumberType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key (clustered) constraint' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'PhoneNumberType', @level2type=N'CONSTRAINT',@level2name=N'PK_PhoneNumberType_PhoneNumberTypeID'
GO
/****** Object:  Table [Sales].[SalesReason]    Script Date: 11/22/2013 20:49:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Sales].[SalesReason](
	[SalesReasonID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [dbo].[Name] NOT NULL,
	[ReasonType] [dbo].[Name] NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_SalesReason_SalesReasonID] PRIMARY KEY CLUSTERED 
(
	[SalesReasonID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key for SalesReason records.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesReason', @level2type=N'COLUMN',@level2name=N'SalesReasonID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Sales reason description.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesReason', @level2type=N'COLUMN',@level2name=N'Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Category the sales reason belongs to.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesReason', @level2type=N'COLUMN',@level2name=N'ReasonType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesReason', @level2type=N'COLUMN',@level2name=N'ModifiedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Lookup table of customer purchase reasons.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesReason'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key (clustered) constraint' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesReason', @level2type=N'CONSTRAINT',@level2name=N'PK_SalesReason_SalesReasonID'
GO
/****** Object:  Table [Purchasing].[ShipMethod]    Script Date: 11/22/2013 20:49:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Purchasing].[ShipMethod](
	[ShipMethodID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [dbo].[Name] NOT NULL,
	[ShipBase] [money] NOT NULL,
	[ShipRate] [money] NOT NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_ShipMethod_ShipMethodID] PRIMARY KEY CLUSTERED 
(
	[ShipMethodID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key for ShipMethod records.' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'ShipMethod', @level2type=N'COLUMN',@level2name=N'ShipMethodID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Shipping company name.' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'ShipMethod', @level2type=N'COLUMN',@level2name=N'Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Minimum shipping charge.' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'ShipMethod', @level2type=N'COLUMN',@level2name=N'ShipBase'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Shipping charge per pound.' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'ShipMethod', @level2type=N'COLUMN',@level2name=N'ShipRate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'ShipMethod', @level2type=N'COLUMN',@level2name=N'rowguid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'ShipMethod', @level2type=N'COLUMN',@level2name=N'ModifiedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Shipping company lookup table.' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'ShipMethod'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key (clustered) constraint' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'ShipMethod', @level2type=N'CONSTRAINT',@level2name=N'PK_ShipMethod_ShipMethodID'
GO
/****** Object:  Table [HumanResources].[Shift]    Script Date: 11/22/2013 20:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HumanResources].[Shift](
	[ShiftID] [tinyint] IDENTITY(1,1) NOT NULL,
	[Name] [dbo].[Name] NOT NULL,
	[StartTime] [time](7) NOT NULL,
	[EndTime] [time](7) NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Shift_ShiftID] PRIMARY KEY CLUSTERED 
(
	[ShiftID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key for Shift records.' , @level0type=N'SCHEMA',@level0name=N'HumanResources', @level1type=N'TABLE',@level1name=N'Shift', @level2type=N'COLUMN',@level2name=N'ShiftID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Shift description.' , @level0type=N'SCHEMA',@level0name=N'HumanResources', @level1type=N'TABLE',@level1name=N'Shift', @level2type=N'COLUMN',@level2name=N'Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Shift start time.' , @level0type=N'SCHEMA',@level0name=N'HumanResources', @level1type=N'TABLE',@level1name=N'Shift', @level2type=N'COLUMN',@level2name=N'StartTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Shift end time.' , @level0type=N'SCHEMA',@level0name=N'HumanResources', @level1type=N'TABLE',@level1name=N'Shift', @level2type=N'COLUMN',@level2name=N'EndTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'HumanResources', @level1type=N'TABLE',@level1name=N'Shift', @level2type=N'COLUMN',@level2name=N'ModifiedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Work shift lookup table.' , @level0type=N'SCHEMA',@level0name=N'HumanResources', @level1type=N'TABLE',@level1name=N'Shift'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key (clustered) constraint' , @level0type=N'SCHEMA',@level0name=N'HumanResources', @level1type=N'TABLE',@level1name=N'Shift', @level2type=N'CONSTRAINT',@level2name=N'PK_Shift_ShiftID'
GO
/****** Object:  Table [Production].[ScrapReason]    Script Date: 11/22/2013 20:49:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Production].[ScrapReason](
	[ScrapReasonID] [smallint] IDENTITY(1,1) NOT NULL,
	[Name] [dbo].[Name] NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_ScrapReason_ScrapReasonID] PRIMARY KEY CLUSTERED 
(
	[ScrapReasonID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key for ScrapReason records.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ScrapReason', @level2type=N'COLUMN',@level2name=N'ScrapReasonID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Failure description.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ScrapReason', @level2type=N'COLUMN',@level2name=N'Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ScrapReason', @level2type=N'COLUMN',@level2name=N'ModifiedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Manufacturing failure reasons lookup table.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ScrapReason'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key (clustered) constraint' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ScrapReason', @level2type=N'CONSTRAINT',@level2name=N'PK_ScrapReason_ScrapReasonID'
GO
/****** Object:  Table [Production].[UnitMeasure]    Script Date: 11/22/2013 20:49:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Production].[UnitMeasure](
	[UnitMeasureCode] [nchar](3) NOT NULL,
	[Name] [dbo].[Name] NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_UnitMeasure_UnitMeasureCode] PRIMARY KEY CLUSTERED 
(
	[UnitMeasureCode] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'UnitMeasure', @level2type=N'COLUMN',@level2name=N'UnitMeasureCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Unit of measure description.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'UnitMeasure', @level2type=N'COLUMN',@level2name=N'Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'UnitMeasure', @level2type=N'COLUMN',@level2name=N'ModifiedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Unit of measure lookup table.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'UnitMeasure'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key (clustered) constraint' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'UnitMeasure', @level2type=N'CONSTRAINT',@level2name=N'PK_UnitMeasure_UnitMeasureCode'
GO
/****** Object:  View [Person].[vAdditionalContactInfo]    Script Date: 11/22/2013 20:49:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [Person].[vAdditionalContactInfo] 
AS 
SELECT 
    [BusinessEntityID] 
    ,[FirstName]
    ,[MiddleName]
    ,[LastName]
    ,[ContactInfo].ref.value(N'declare namespace ci="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactInfo"; 
        declare namespace act="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactTypes"; 
        (act:telephoneNumber)[1]/act:number', 'nvarchar(50)') AS [TelephoneNumber] 
    ,LTRIM(RTRIM([ContactInfo].ref.value(N'declare namespace ci="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactInfo"; 
        declare namespace act="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactTypes"; 
        (act:telephoneNumber/act:SpecialInstructions/text())[1]', 'nvarchar(max)'))) AS [TelephoneSpecialInstructions] 
    ,[ContactInfo].ref.value(N'declare namespace ci="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactInfo"; 
        declare namespace act="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactTypes";
        (act:homePostalAddress/act:Street)[1]', 'nvarchar(50)') AS [Street] 
    ,[ContactInfo].ref.value(N'declare namespace ci="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactInfo"; 
        declare namespace act="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactTypes"; 
        (act:homePostalAddress/act:City)[1]', 'nvarchar(50)') AS [City] 
    ,[ContactInfo].ref.value(N'declare namespace ci="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactInfo"; 
        declare namespace act="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactTypes"; 
        (act:homePostalAddress/act:StateProvince)[1]', 'nvarchar(50)') AS [StateProvince] 
    ,[ContactInfo].ref.value(N'declare namespace ci="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactInfo"; 
        declare namespace act="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactTypes"; 
        (act:homePostalAddress/act:PostalCode)[1]', 'nvarchar(50)') AS [PostalCode] 
    ,[ContactInfo].ref.value(N'declare namespace ci="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactInfo"; 
        declare namespace act="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactTypes"; 
        (act:homePostalAddress/act:CountryRegion)[1]', 'nvarchar(50)') AS [CountryRegion] 
    ,[ContactInfo].ref.value(N'declare namespace ci="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactInfo"; 
        declare namespace act="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactTypes"; 
        (act:homePostalAddress/act:SpecialInstructions/text())[1]', 'nvarchar(max)') AS [HomeAddressSpecialInstructions] 
    ,[ContactInfo].ref.value(N'declare namespace ci="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactInfo"; 
        declare namespace act="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactTypes"; 
        (act:eMail/act:eMailAddress)[1]', 'nvarchar(128)') AS [EMailAddress] 
    ,LTRIM(RTRIM([ContactInfo].ref.value(N'declare namespace ci="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactInfo"; 
        declare namespace act="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactTypes"; 
        (act:eMail/act:SpecialInstructions/text())[1]', 'nvarchar(max)'))) AS [EMailSpecialInstructions] 
    ,[ContactInfo].ref.value(N'declare namespace ci="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactInfo"; 
        declare namespace act="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactTypes"; 
        (act:eMail/act:SpecialInstructions/act:telephoneNumber/act:number)[1]', 'nvarchar(50)') AS [EMailTelephoneNumber] 
    ,[rowguid] 
    ,[ModifiedDate]
FROM [Person].[Person]
OUTER APPLY [AdditionalContactInfo].nodes(
    'declare namespace ci="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactInfo"; 
    /ci:AdditionalContactInfo') AS ContactInfo(ref) 
WHERE [AdditionalContactInfo] IS NOT NULL;
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Displays the contact name and content from each element in the xml column AdditionalContactInfo for that person.' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'VIEW',@level1name=N'vAdditionalContactInfo'
GO
/****** Object:  Table [Sales].[SalesTerritory]    Script Date: 11/22/2013 20:49:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Sales].[SalesTerritory](
	[TerritoryID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [dbo].[Name] NOT NULL,
	[CountryRegionCode] [nvarchar](3) NOT NULL,
	[Group] [nvarchar](50) NOT NULL,
	[SalesYTD] [money] NOT NULL,
	[SalesLastYear] [money] NOT NULL,
	[CostYTD] [money] NOT NULL,
	[CostLastYear] [money] NOT NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_SalesTerritory_TerritoryID] PRIMARY KEY CLUSTERED 
(
	[TerritoryID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key for SalesTerritory records.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesTerritory', @level2type=N'COLUMN',@level2name=N'TerritoryID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Sales territory description' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesTerritory', @level2type=N'COLUMN',@level2name=N'Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ISO standard country or region code. Foreign key to CountryRegion.CountryRegionCode. ' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesTerritory', @level2type=N'COLUMN',@level2name=N'CountryRegionCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Geographic area to which the sales territory belong.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesTerritory', @level2type=N'COLUMN',@level2name=N'Group'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Sales in the territory year to date.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesTerritory', @level2type=N'COLUMN',@level2name=N'SalesYTD'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Sales in the territory the previous year.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesTerritory', @level2type=N'COLUMN',@level2name=N'SalesLastYear'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Business costs in the territory year to date.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesTerritory', @level2type=N'COLUMN',@level2name=N'CostYTD'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Business costs in the territory the previous year.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesTerritory', @level2type=N'COLUMN',@level2name=N'CostLastYear'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesTerritory', @level2type=N'COLUMN',@level2name=N'rowguid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesTerritory', @level2type=N'COLUMN',@level2name=N'ModifiedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Sales territory lookup table.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesTerritory'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key (clustered) constraint' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesTerritory', @level2type=N'CONSTRAINT',@level2name=N'PK_SalesTerritory_TerritoryID'
GO
/****** Object:  Table [Person].[PersonPhone]    Script Date: 11/22/2013 20:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Person].[PersonPhone](
	[BusinessEntityID] [int] NOT NULL,
	[PhoneNumber] [dbo].[Phone] NOT NULL,
	[PhoneNumberTypeID] [int] NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_PersonPhone_BusinessEntityID_PhoneNumber_PhoneNumberTypeID] PRIMARY KEY CLUSTERED 
(
	[BusinessEntityID] ASC,
	[PhoneNumber] ASC,
	[PhoneNumberTypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Business entity identification number. Foreign key to Person.BusinessEntityID.' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'PersonPhone', @level2type=N'COLUMN',@level2name=N'BusinessEntityID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Telephone number identification number.' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'PersonPhone', @level2type=N'COLUMN',@level2name=N'PhoneNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Kind of phone number. Foreign key to PhoneNumberType.PhoneNumberTypeID.' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'PersonPhone', @level2type=N'COLUMN',@level2name=N'PhoneNumberTypeID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'PersonPhone', @level2type=N'COLUMN',@level2name=N'ModifiedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Telephone number and type of a person.' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'PersonPhone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key (clustered) constraint' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'PersonPhone', @level2type=N'CONSTRAINT',@level2name=N'PK_PersonPhone_BusinessEntityID_PhoneNumber_PhoneNumberTypeID'
GO
/****** Object:  Table [Sales].[PersonCreditCard]    Script Date: 11/22/2013 20:49:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Sales].[PersonCreditCard](
	[BusinessEntityID] [int] NOT NULL,
	[CreditCardID] [int] NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_PersonCreditCard_BusinessEntityID_CreditCardID] PRIMARY KEY CLUSTERED 
(
	[BusinessEntityID] ASC,
	[CreditCardID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Business entity identification number. Foreign key to Person.BusinessEntityID.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'PersonCreditCard', @level2type=N'COLUMN',@level2name=N'BusinessEntityID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Credit card identification number. Foreign key to CreditCard.CreditCardID.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'PersonCreditCard', @level2type=N'COLUMN',@level2name=N'CreditCardID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'PersonCreditCard', @level2type=N'COLUMN',@level2name=N'ModifiedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Cross-reference table mapping people to their credit card information in the CreditCard table. ' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'PersonCreditCard'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key (clustered) constraint' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'PersonCreditCard', @level2type=N'CONSTRAINT',@level2name=N'PK_PersonCreditCard_BusinessEntityID_CreditCardID'
GO
/****** Object:  Table [Production].[ProductModelProductDescriptionCulture]    Script Date: 11/22/2013 20:49:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Production].[ProductModelProductDescriptionCulture](
	[ProductModelID] [int] NOT NULL,
	[ProductDescriptionID] [int] NOT NULL,
	[CultureID] [nchar](6) NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_ProductModelProductDescriptionCulture_ProductModelID_ProductDescriptionID_CultureID] PRIMARY KEY CLUSTERED 
(
	[ProductModelID] ASC,
	[ProductDescriptionID] ASC,
	[CultureID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key. Foreign key to ProductModel.ProductModelID.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductModelProductDescriptionCulture', @level2type=N'COLUMN',@level2name=N'ProductModelID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key. Foreign key to ProductDescription.ProductDescriptionID.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductModelProductDescriptionCulture', @level2type=N'COLUMN',@level2name=N'ProductDescriptionID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Culture identification number. Foreign key to Culture.CultureID.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductModelProductDescriptionCulture', @level2type=N'COLUMN',@level2name=N'CultureID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductModelProductDescriptionCulture', @level2type=N'COLUMN',@level2name=N'ModifiedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Cross-reference table mapping product descriptions and the language the description is written in.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductModelProductDescriptionCulture'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key (clustered) constraint' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductModelProductDescriptionCulture', @level2type=N'CONSTRAINT',@level2name=N'PK_ProductModelProductDescriptionCulture_ProductModelID_ProductDescriptionID_CultureID'
GO
/****** Object:  Table [Production].[ProductModelIllustration]    Script Date: 11/22/2013 20:49:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Production].[ProductModelIllustration](
	[ProductModelID] [int] NOT NULL,
	[IllustrationID] [int] NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_ProductModelIllustration_ProductModelID_IllustrationID] PRIMARY KEY CLUSTERED 
(
	[ProductModelID] ASC,
	[IllustrationID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key. Foreign key to ProductModel.ProductModelID.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductModelIllustration', @level2type=N'COLUMN',@level2name=N'ProductModelID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key. Foreign key to Illustration.IllustrationID.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductModelIllustration', @level2type=N'COLUMN',@level2name=N'IllustrationID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductModelIllustration', @level2type=N'COLUMN',@level2name=N'ModifiedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Cross-reference table mapping product models and illustrations.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductModelIllustration'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key (clustered) constraint' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductModelIllustration', @level2type=N'CONSTRAINT',@level2name=N'PK_ProductModelIllustration_ProductModelID_IllustrationID'
GO
/****** Object:  Table [Production].[ProductSubcategory]    Script Date: 11/22/2013 20:49:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Production].[ProductSubcategory](
	[ProductSubcategoryID] [int] IDENTITY(1,1) NOT NULL,
	[ProductCategoryID] [int] NOT NULL,
	[Name] [dbo].[Name] NOT NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_ProductSubcategory_ProductSubcategoryID] PRIMARY KEY CLUSTERED 
(
	[ProductSubcategoryID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key for ProductSubcategory records.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductSubcategory', @level2type=N'COLUMN',@level2name=N'ProductSubcategoryID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Product category identification number. Foreign key to ProductCategory.ProductCategoryID.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductSubcategory', @level2type=N'COLUMN',@level2name=N'ProductCategoryID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Subcategory description.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductSubcategory', @level2type=N'COLUMN',@level2name=N'Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductSubcategory', @level2type=N'COLUMN',@level2name=N'rowguid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductSubcategory', @level2type=N'COLUMN',@level2name=N'ModifiedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Product subcategories. See ProductCategory table.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductSubcategory'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key (clustered) constraint' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductSubcategory', @level2type=N'CONSTRAINT',@level2name=N'PK_ProductSubcategory_ProductSubcategoryID'
GO
/****** Object:  Table [Sales].[CurrencyRate]    Script Date: 11/22/2013 20:49:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Sales].[CurrencyRate](
	[CurrencyRateID] [int] IDENTITY(1,1) NOT NULL,
	[CurrencyRateDate] [datetime] NOT NULL,
	[FromCurrencyCode] [nchar](3) NOT NULL,
	[ToCurrencyCode] [nchar](3) NOT NULL,
	[AverageRate] [money] NOT NULL,
	[EndOfDayRate] [money] NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_CurrencyRate_CurrencyRateID] PRIMARY KEY CLUSTERED 
(
	[CurrencyRateID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key for CurrencyRate records.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'CurrencyRate', @level2type=N'COLUMN',@level2name=N'CurrencyRateID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the exchange rate was obtained.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'CurrencyRate', @level2type=N'COLUMN',@level2name=N'CurrencyRateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Exchange rate was converted from this currency code.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'CurrencyRate', @level2type=N'COLUMN',@level2name=N'FromCurrencyCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Exchange rate was converted to this currency code.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'CurrencyRate', @level2type=N'COLUMN',@level2name=N'ToCurrencyCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Average exchange rate for the day.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'CurrencyRate', @level2type=N'COLUMN',@level2name=N'AverageRate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Final exchange rate for the day.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'CurrencyRate', @level2type=N'COLUMN',@level2name=N'EndOfDayRate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'CurrencyRate', @level2type=N'COLUMN',@level2name=N'ModifiedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Currency exchange rates.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'CurrencyRate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key (clustered) constraint' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'CurrencyRate', @level2type=N'CONSTRAINT',@level2name=N'PK_CurrencyRate_CurrencyRateID'
GO
/****** Object:  Table [Person].[BusinessEntityContact]    Script Date: 11/22/2013 20:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Person].[BusinessEntityContact](
	[BusinessEntityID] [int] NOT NULL,
	[PersonID] [int] NOT NULL,
	[ContactTypeID] [int] NOT NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_BusinessEntityContact_BusinessEntityID_PersonID_ContactTypeID] PRIMARY KEY CLUSTERED 
(
	[BusinessEntityID] ASC,
	[PersonID] ASC,
	[ContactTypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key. Foreign key to BusinessEntity.BusinessEntityID.' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'BusinessEntityContact', @level2type=N'COLUMN',@level2name=N'BusinessEntityID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key. Foreign key to Person.BusinessEntityID.' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'BusinessEntityContact', @level2type=N'COLUMN',@level2name=N'PersonID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key.  Foreign key to ContactType.ContactTypeID.' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'BusinessEntityContact', @level2type=N'COLUMN',@level2name=N'ContactTypeID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'BusinessEntityContact', @level2type=N'COLUMN',@level2name=N'rowguid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'BusinessEntityContact', @level2type=N'COLUMN',@level2name=N'ModifiedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Cross-reference table mapping stores, vendors, and employees to people' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'BusinessEntityContact'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key (clustered) constraint' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'BusinessEntityContact', @level2type=N'CONSTRAINT',@level2name=N'PK_BusinessEntityContact_BusinessEntityID_PersonID_ContactTypeID'
GO
/****** Object:  Table [Sales].[CountryRegionCurrency]    Script Date: 11/22/2013 20:49:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Sales].[CountryRegionCurrency](
	[CountryRegionCode] [nvarchar](3) NOT NULL,
	[CurrencyCode] [nchar](3) NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_CountryRegionCurrency_CountryRegionCode_CurrencyCode] PRIMARY KEY CLUSTERED 
(
	[CountryRegionCode] ASC,
	[CurrencyCode] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ISO code for countries and regions. Foreign key to CountryRegion.CountryRegionCode.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'CountryRegionCurrency', @level2type=N'COLUMN',@level2name=N'CountryRegionCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ISO standard currency code. Foreign key to Currency.CurrencyCode.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'CountryRegionCurrency', @level2type=N'COLUMN',@level2name=N'CurrencyCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'CountryRegionCurrency', @level2type=N'COLUMN',@level2name=N'ModifiedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Cross-reference table mapping ISO currency codes to a country or region.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'CountryRegionCurrency'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key (clustered) constraint' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'CountryRegionCurrency', @level2type=N'CONSTRAINT',@level2name=N'PK_CountryRegionCurrency_CountryRegionCode_CurrencyCode'
GO
/****** Object:  Table [HumanResources].[Employee]    Script Date: 11/22/2013 20:49:40 ******/
SET ARITHABORT ON
GO
SET CONCAT_NULL_YIELDS_NULL ON
GO
SET ANSI_NULLS ON
GO
SET ANSI_PADDING ON
GO
SET ANSI_WARNINGS ON
GO
SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ARITHABORT ON
GO
CREATE TABLE [HumanResources].[Employee](
	[BusinessEntityID] [int] NOT NULL,
	[NationalIDNumber] [nvarchar](15) NOT NULL,
	[LoginID] [nvarchar](256) NOT NULL,
	[OrganizationNode] [hierarchyid] NULL,
	[OrganizationLevel]  AS ([OrganizationNode].[GetLevel]()),
	[JobTitle] [nvarchar](50) NOT NULL,
	[BirthDate] [date] NOT NULL,
	[MaritalStatus] [nchar](1) NOT NULL,
	[Gender] [nchar](1) NOT NULL,
	[HireDate] [date] NOT NULL,
	[SalariedFlag] [dbo].[Flag] NOT NULL,
	[VacationHours] [smallint] NOT NULL,
	[SickLeaveHours] [smallint] NOT NULL,
	[CurrentFlag] [dbo].[Flag] NOT NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Employee_BusinessEntityID] PRIMARY KEY CLUSTERED 
(
	[BusinessEntityID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key for Employee records.  Foreign key to BusinessEntity.BusinessEntityID.' , @level0type=N'SCHEMA',@level0name=N'HumanResources', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'BusinessEntityID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Unique national identification number such as a social security number.' , @level0type=N'SCHEMA',@level0name=N'HumanResources', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'NationalIDNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Network login.' , @level0type=N'SCHEMA',@level0name=N'HumanResources', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'LoginID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Where the employee is located in corporate hierarchy.' , @level0type=N'SCHEMA',@level0name=N'HumanResources', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'OrganizationNode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The depth of the employee in the corporate hierarchy.' , @level0type=N'SCHEMA',@level0name=N'HumanResources', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'OrganizationLevel'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Work title such as Buyer or Sales Representative.' , @level0type=N'SCHEMA',@level0name=N'HumanResources', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'JobTitle'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date of birth.' , @level0type=N'SCHEMA',@level0name=N'HumanResources', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'BirthDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'M = Married, S = Single' , @level0type=N'SCHEMA',@level0name=N'HumanResources', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'MaritalStatus'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'M = Male, F = Female' , @level0type=N'SCHEMA',@level0name=N'HumanResources', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'Gender'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Employee hired on this date.' , @level0type=N'SCHEMA',@level0name=N'HumanResources', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'HireDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Job classification. 0 = Hourly, not exempt from collective bargaining. 1 = Salaried, exempt from collective bargaining.' , @level0type=N'SCHEMA',@level0name=N'HumanResources', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'SalariedFlag'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Number of available vacation hours.' , @level0type=N'SCHEMA',@level0name=N'HumanResources', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'VacationHours'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Number of available sick leave hours.' , @level0type=N'SCHEMA',@level0name=N'HumanResources', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'SickLeaveHours'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0 = Inactive, 1 = Active' , @level0type=N'SCHEMA',@level0name=N'HumanResources', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'CurrentFlag'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.' , @level0type=N'SCHEMA',@level0name=N'HumanResources', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'rowguid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'HumanResources', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'COLUMN',@level2name=N'ModifiedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Employee information such as salary, department, and title.' , @level0type=N'SCHEMA',@level0name=N'HumanResources', @level1type=N'TABLE',@level1name=N'Employee'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key (clustered) constraint' , @level0type=N'SCHEMA',@level0name=N'HumanResources', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'CONSTRAINT',@level2name=N'PK_Employee_BusinessEntityID'
GO
/****** Object:  Table [Person].[EmailAddress]    Script Date: 11/22/2013 20:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Person].[EmailAddress](
	[BusinessEntityID] [int] NOT NULL,
	[EmailAddressID] [int] IDENTITY(1,1) NOT NULL,
	[EmailAddress] [nvarchar](50) NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_EmailAddress_BusinessEntityID_EmailAddressID] PRIMARY KEY CLUSTERED 
(
	[BusinessEntityID] ASC,
	[EmailAddressID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key. Person associated with this email address.  Foreign key to Person.BusinessEntityID' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'EmailAddress', @level2type=N'COLUMN',@level2name=N'BusinessEntityID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key. ID of this email address.' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'EmailAddress', @level2type=N'COLUMN',@level2name=N'EmailAddressID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'E-mail address for the person.' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'EmailAddress', @level2type=N'COLUMN',@level2name=N'EmailAddress'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'EmailAddress', @level2type=N'COLUMN',@level2name=N'rowguid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'EmailAddress', @level2type=N'COLUMN',@level2name=N'ModifiedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Where to send a person email.' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'EmailAddress'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key (clustered) constraint' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'EmailAddress', @level2type=N'CONSTRAINT',@level2name=N'PK_EmailAddress_BusinessEntityID_EmailAddressID'
GO
/****** Object:  Table [Person].[Password]    Script Date: 11/22/2013 20:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Person].[Password](
	[BusinessEntityID] [int] NOT NULL,
	[PasswordHash] [varchar](128) NOT NULL,
	[PasswordSalt] [varchar](10) NOT NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Password_BusinessEntityID] PRIMARY KEY CLUSTERED 
(
	[BusinessEntityID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Password for the e-mail account.' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'Password', @level2type=N'COLUMN',@level2name=N'PasswordHash'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Random value concatenated with the password string before the password is hashed.' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'Password', @level2type=N'COLUMN',@level2name=N'PasswordSalt'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'Password', @level2type=N'COLUMN',@level2name=N'rowguid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'Password', @level2type=N'COLUMN',@level2name=N'ModifiedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'One way hashed authentication information' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'Password'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key (clustered) constraint' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'Password', @level2type=N'CONSTRAINT',@level2name=N'PK_Password_BusinessEntityID'
GO
/****** Object:  View [Production].[vProductModelInstructions]    Script Date: 11/22/2013 20:49:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [Production].[vProductModelInstructions] 
AS 
SELECT 
    [ProductModelID] 
    ,[Name] 
    ,[Instructions].value(N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelManuInstructions"; 
        (/root/text())[1]', 'nvarchar(max)') AS [Instructions] 
    ,[MfgInstructions].ref.value('@LocationID[1]', 'int') AS [LocationID] 
    ,[MfgInstructions].ref.value('@SetupHours[1]', 'decimal(9, 4)') AS [SetupHours] 
    ,[MfgInstructions].ref.value('@MachineHours[1]', 'decimal(9, 4)') AS [MachineHours] 
    ,[MfgInstructions].ref.value('@LaborHours[1]', 'decimal(9, 4)') AS [LaborHours] 
    ,[MfgInstructions].ref.value('@LotSize[1]', 'int') AS [LotSize] 
    ,[Steps].ref.value('string(.)[1]', 'nvarchar(1024)') AS [Step] 
    ,[rowguid] 
    ,[ModifiedDate]
FROM [Production].[ProductModel] 
CROSS APPLY [Instructions].nodes(N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelManuInstructions"; 
    /root/Location') MfgInstructions(ref)
CROSS APPLY [MfgInstructions].ref.nodes('declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelManuInstructions"; 
    step') Steps(ref);
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Displays the content from each element in the xml column Instructions for each product in the Production.ProductModel table that has manufacturing instructions.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'VIEW',@level1name=N'vProductModelInstructions'
GO
/****** Object:  View [Production].[vProductModelCatalogDescription]    Script Date: 11/22/2013 20:49:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [Production].[vProductModelCatalogDescription] 
AS 
SELECT 
    [ProductModelID] 
    ,[Name] 
    ,[CatalogDescription].value(N'declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        declare namespace html="http://www.w3.org/1999/xhtml"; 
        (/p1:ProductDescription/p1:Summary/html:p)[1]', 'nvarchar(max)') AS [Summary] 
    ,[CatalogDescription].value(N'declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        (/p1:ProductDescription/p1:Manufacturer/p1:Name)[1]', 'nvarchar(max)') AS [Manufacturer] 
    ,[CatalogDescription].value(N'declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        (/p1:ProductDescription/p1:Manufacturer/p1:Copyright)[1]', 'nvarchar(30)') AS [Copyright] 
    ,[CatalogDescription].value(N'declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        (/p1:ProductDescription/p1:Manufacturer/p1:ProductURL)[1]', 'nvarchar(256)') AS [ProductURL] 
    ,[CatalogDescription].value(N'declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        declare namespace wm="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelWarrAndMain"; 
        (/p1:ProductDescription/p1:Features/wm:Warranty/wm:WarrantyPeriod)[1]', 'nvarchar(256)') AS [WarrantyPeriod] 
    ,[CatalogDescription].value(N'declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        declare namespace wm="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelWarrAndMain"; 
        (/p1:ProductDescription/p1:Features/wm:Warranty/wm:Description)[1]', 'nvarchar(256)') AS [WarrantyDescription] 
    ,[CatalogDescription].value(N'declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        declare namespace wm="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelWarrAndMain"; 
        (/p1:ProductDescription/p1:Features/wm:Maintenance/wm:NoOfYears)[1]', 'nvarchar(256)') AS [NoOfYears] 
    ,[CatalogDescription].value(N'declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        declare namespace wm="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelWarrAndMain"; 
        (/p1:ProductDescription/p1:Features/wm:Maintenance/wm:Description)[1]', 'nvarchar(256)') AS [MaintenanceDescription] 
    ,[CatalogDescription].value(N'declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        declare namespace wf="http://www.adventure-works.com/schemas/OtherFeatures"; 
        (/p1:ProductDescription/p1:Features/wf:wheel)[1]', 'nvarchar(256)') AS [Wheel] 
    ,[CatalogDescription].value(N'declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        declare namespace wf="http://www.adventure-works.com/schemas/OtherFeatures"; 
        (/p1:ProductDescription/p1:Features/wf:saddle)[1]', 'nvarchar(256)') AS [Saddle] 
    ,[CatalogDescription].value(N'declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        declare namespace wf="http://www.adventure-works.com/schemas/OtherFeatures"; 
        (/p1:ProductDescription/p1:Features/wf:pedal)[1]', 'nvarchar(256)') AS [Pedal] 
    ,[CatalogDescription].value(N'declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        declare namespace wf="http://www.adventure-works.com/schemas/OtherFeatures"; 
        (/p1:ProductDescription/p1:Features/wf:BikeFrame)[1]', 'nvarchar(max)') AS [BikeFrame] 
    ,[CatalogDescription].value(N'declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        declare namespace wf="http://www.adventure-works.com/schemas/OtherFeatures"; 
        (/p1:ProductDescription/p1:Features/wf:crankset)[1]', 'nvarchar(256)') AS [Crankset] 
    ,[CatalogDescription].value(N'declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        (/p1:ProductDescription/p1:Picture/p1:Angle)[1]', 'nvarchar(256)') AS [PictureAngle] 
    ,[CatalogDescription].value(N'declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        (/p1:ProductDescription/p1:Picture/p1:Size)[1]', 'nvarchar(256)') AS [PictureSize] 
    ,[CatalogDescription].value(N'declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        (/p1:ProductDescription/p1:Picture/p1:ProductPhotoID)[1]', 'nvarchar(256)') AS [ProductPhotoID] 
    ,[CatalogDescription].value(N'declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        (/p1:ProductDescription/p1:Specifications/Material)[1]', 'nvarchar(256)') AS [Material] 
    ,[CatalogDescription].value(N'declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        (/p1:ProductDescription/p1:Specifications/Color)[1]', 'nvarchar(256)') AS [Color] 
    ,[CatalogDescription].value(N'declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        (/p1:ProductDescription/p1:Specifications/ProductLine)[1]', 'nvarchar(256)') AS [ProductLine] 
    ,[CatalogDescription].value(N'declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        (/p1:ProductDescription/p1:Specifications/Style)[1]', 'nvarchar(256)') AS [Style] 
    ,[CatalogDescription].value(N'declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        (/p1:ProductDescription/p1:Specifications/RiderExperience)[1]', 'nvarchar(1024)') AS [RiderExperience] 
    ,[rowguid] 
    ,[ModifiedDate]
FROM [Production].[ProductModel] 
WHERE [CatalogDescription] IS NOT NULL;
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Displays the content from each element in the xml column CatalogDescription for each product in the Production.ProductModel table that has catalog data.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'VIEW',@level1name=N'vProductModelCatalogDescription'
GO
/****** Object:  View [Sales].[vPersonDemographics]    Script Date: 11/22/2013 20:49:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [Sales].[vPersonDemographics] 
AS 
SELECT 
    p.[BusinessEntityID] 
    ,[IndividualSurvey].[ref].[value](N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"; 
        TotalPurchaseYTD[1]', 'money') AS [TotalPurchaseYTD] 
    ,CONVERT(datetime, REPLACE([IndividualSurvey].[ref].[value](N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"; 
        DateFirstPurchase[1]', 'nvarchar(20)') ,'Z', ''), 101) AS [DateFirstPurchase] 
    ,CONVERT(datetime, REPLACE([IndividualSurvey].[ref].[value](N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"; 
        BirthDate[1]', 'nvarchar(20)') ,'Z', ''), 101) AS [BirthDate] 
    ,[IndividualSurvey].[ref].[value](N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"; 
        MaritalStatus[1]', 'nvarchar(1)') AS [MaritalStatus] 
    ,[IndividualSurvey].[ref].[value](N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"; 
        YearlyIncome[1]', 'nvarchar(30)') AS [YearlyIncome] 
    ,[IndividualSurvey].[ref].[value](N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"; 
        Gender[1]', 'nvarchar(1)') AS [Gender] 
    ,[IndividualSurvey].[ref].[value](N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"; 
        TotalChildren[1]', 'integer') AS [TotalChildren] 
    ,[IndividualSurvey].[ref].[value](N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"; 
        NumberChildrenAtHome[1]', 'integer') AS [NumberChildrenAtHome] 
    ,[IndividualSurvey].[ref].[value](N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"; 
        Education[1]', 'nvarchar(30)') AS [Education] 
    ,[IndividualSurvey].[ref].[value](N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"; 
        Occupation[1]', 'nvarchar(30)') AS [Occupation] 
    ,[IndividualSurvey].[ref].[value](N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"; 
        HomeOwnerFlag[1]', 'bit') AS [HomeOwnerFlag] 
    ,[IndividualSurvey].[ref].[value](N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"; 
        NumberCarsOwned[1]', 'integer') AS [NumberCarsOwned] 
FROM [Person].[Person] p 
CROSS APPLY p.[Demographics].nodes(N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"; 
    /IndividualSurvey') AS [IndividualSurvey](ref) 
WHERE [Demographics] IS NOT NULL;
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Displays the content from each element in the xml column Demographics for each customer in the Person.Person table.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'VIEW',@level1name=N'vPersonDemographics'
GO
/****** Object:  Table [Purchasing].[Vendor]    Script Date: 11/22/2013 20:49:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Purchasing].[Vendor](
	[BusinessEntityID] [int] NOT NULL,
	[AccountNumber] [dbo].[AccountNumber] NOT NULL,
	[Name] [dbo].[Name] NOT NULL,
	[CreditRating] [tinyint] NOT NULL,
	[PreferredVendorStatus] [dbo].[Flag] NOT NULL,
	[ActiveFlag] [dbo].[Flag] NOT NULL,
	[PurchasingWebServiceURL] [nvarchar](1024) NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Vendor_BusinessEntityID] PRIMARY KEY CLUSTERED 
(
	[BusinessEntityID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key for Vendor records.  Foreign key to BusinessEntity.BusinessEntityID' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'Vendor', @level2type=N'COLUMN',@level2name=N'BusinessEntityID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Vendor account (identification) number.' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'Vendor', @level2type=N'COLUMN',@level2name=N'AccountNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Company name.' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'Vendor', @level2type=N'COLUMN',@level2name=N'Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'1 = Superior, 2 = Excellent, 3 = Above average, 4 = Average, 5 = Below average' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'Vendor', @level2type=N'COLUMN',@level2name=N'CreditRating'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0 = Do not use if another vendor is available. 1 = Preferred over other vendors supplying the same product.' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'Vendor', @level2type=N'COLUMN',@level2name=N'PreferredVendorStatus'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0 = Vendor no longer used. 1 = Vendor is actively used.' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'Vendor', @level2type=N'COLUMN',@level2name=N'ActiveFlag'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Vendor URL.' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'Vendor', @level2type=N'COLUMN',@level2name=N'PurchasingWebServiceURL'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'Vendor', @level2type=N'COLUMN',@level2name=N'ModifiedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Companies from whom Adventure Works Cycles purchases parts or other goods.' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'Vendor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key (clustered) constraint' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'Vendor', @level2type=N'CONSTRAINT',@level2name=N'PK_Vendor_BusinessEntityID'
GO
/****** Object:  View [Purchasing].[vVendorWithContacts]    Script Date: 11/22/2013 20:49:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [Purchasing].[vVendorWithContacts] AS 
SELECT 
    v.[BusinessEntityID]
    ,v.[Name]
    ,ct.[Name] AS [ContactType] 
    ,p.[Title] 
    ,p.[FirstName] 
    ,p.[MiddleName] 
    ,p.[LastName] 
    ,p.[Suffix] 
    ,pp.[PhoneNumber] 
	,pnt.[Name] AS [PhoneNumberType]
    ,ea.[EmailAddress] 
    ,p.[EmailPromotion] 
FROM [Purchasing].[Vendor] v
    INNER JOIN [Person].[BusinessEntityContact] bec 
    ON bec.[BusinessEntityID] = v.[BusinessEntityID]
	INNER JOIN [Person].ContactType ct
	ON ct.[ContactTypeID] = bec.[ContactTypeID]
	INNER JOIN [Person].[Person] p
	ON p.[BusinessEntityID] = bec.[PersonID]
	LEFT OUTER JOIN [Person].[EmailAddress] ea
	ON ea.[BusinessEntityID] = p.[BusinessEntityID]
	LEFT OUTER JOIN [Person].[PersonPhone] pp
	ON pp.[BusinessEntityID] = p.[BusinessEntityID]
	LEFT OUTER JOIN [Person].[PhoneNumberType] pnt
	ON pnt.[PhoneNumberTypeID] = pp.[PhoneNumberTypeID];
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Vendor (company) names  and the names of vendor employees to contact.' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'VIEW',@level1name=N'vVendorWithContacts'
GO
/****** Object:  Table [HumanResources].[EmployeePayHistory]    Script Date: 11/22/2013 20:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HumanResources].[EmployeePayHistory](
	[BusinessEntityID] [int] NOT NULL,
	[RateChangeDate] [datetime] NOT NULL,
	[Rate] [money] NOT NULL,
	[PayFrequency] [tinyint] NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_EmployeePayHistory_BusinessEntityID_RateChangeDate] PRIMARY KEY CLUSTERED 
(
	[BusinessEntityID] ASC,
	[RateChangeDate] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Employee identification number. Foreign key to Employee.BusinessEntityID.' , @level0type=N'SCHEMA',@level0name=N'HumanResources', @level1type=N'TABLE',@level1name=N'EmployeePayHistory', @level2type=N'COLUMN',@level2name=N'BusinessEntityID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date the change in pay is effective' , @level0type=N'SCHEMA',@level0name=N'HumanResources', @level1type=N'TABLE',@level1name=N'EmployeePayHistory', @level2type=N'COLUMN',@level2name=N'RateChangeDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Salary hourly rate.' , @level0type=N'SCHEMA',@level0name=N'HumanResources', @level1type=N'TABLE',@level1name=N'EmployeePayHistory', @level2type=N'COLUMN',@level2name=N'Rate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'1 = Salary received monthly, 2 = Salary received biweekly' , @level0type=N'SCHEMA',@level0name=N'HumanResources', @level1type=N'TABLE',@level1name=N'EmployeePayHistory', @level2type=N'COLUMN',@level2name=N'PayFrequency'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'HumanResources', @level1type=N'TABLE',@level1name=N'EmployeePayHistory', @level2type=N'COLUMN',@level2name=N'ModifiedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Employee pay history.' , @level0type=N'SCHEMA',@level0name=N'HumanResources', @level1type=N'TABLE',@level1name=N'EmployeePayHistory'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key (clustered) constraint' , @level0type=N'SCHEMA',@level0name=N'HumanResources', @level1type=N'TABLE',@level1name=N'EmployeePayHistory', @level2type=N'CONSTRAINT',@level2name=N'PK_EmployeePayHistory_BusinessEntityID_RateChangeDate'
GO
/****** Object:  Table [HumanResources].[EmployeeDepartmentHistory]    Script Date: 11/22/2013 20:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HumanResources].[EmployeeDepartmentHistory](
	[BusinessEntityID] [int] NOT NULL,
	[DepartmentID] [smallint] NOT NULL,
	[ShiftID] [tinyint] NOT NULL,
	[StartDate] [date] NOT NULL,
	[EndDate] [date] NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_EmployeeDepartmentHistory_BusinessEntityID_StartDate_DepartmentID] PRIMARY KEY CLUSTERED 
(
	[BusinessEntityID] ASC,
	[StartDate] ASC,
	[DepartmentID] ASC,
	[ShiftID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Employee identification number. Foreign key to Employee.BusinessEntityID.' , @level0type=N'SCHEMA',@level0name=N'HumanResources', @level1type=N'TABLE',@level1name=N'EmployeeDepartmentHistory', @level2type=N'COLUMN',@level2name=N'BusinessEntityID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Department in which the employee worked including currently. Foreign key to Department.DepartmentID.' , @level0type=N'SCHEMA',@level0name=N'HumanResources', @level1type=N'TABLE',@level1name=N'EmployeeDepartmentHistory', @level2type=N'COLUMN',@level2name=N'DepartmentID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Identifies which 8-hour shift the employee works. Foreign key to Shift.Shift.ID.' , @level0type=N'SCHEMA',@level0name=N'HumanResources', @level1type=N'TABLE',@level1name=N'EmployeeDepartmentHistory', @level2type=N'COLUMN',@level2name=N'ShiftID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date the employee started work in the department.' , @level0type=N'SCHEMA',@level0name=N'HumanResources', @level1type=N'TABLE',@level1name=N'EmployeeDepartmentHistory', @level2type=N'COLUMN',@level2name=N'StartDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date the employee left the department. NULL = Current department.' , @level0type=N'SCHEMA',@level0name=N'HumanResources', @level1type=N'TABLE',@level1name=N'EmployeeDepartmentHistory', @level2type=N'COLUMN',@level2name=N'EndDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'HumanResources', @level1type=N'TABLE',@level1name=N'EmployeeDepartmentHistory', @level2type=N'COLUMN',@level2name=N'ModifiedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Employee department transfers.' , @level0type=N'SCHEMA',@level0name=N'HumanResources', @level1type=N'TABLE',@level1name=N'EmployeeDepartmentHistory'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key (clustered) constraint' , @level0type=N'SCHEMA',@level0name=N'HumanResources', @level1type=N'TABLE',@level1name=N'EmployeeDepartmentHistory', @level2type=N'CONSTRAINT',@level2name=N'PK_EmployeeDepartmentHistory_BusinessEntityID_StartDate_DepartmentID'
GO
/****** Object:  Table [HumanResources].[JobCandidate]    Script Date: 11/22/2013 20:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HumanResources].[JobCandidate](
	[JobCandidateID] [int] IDENTITY(1,1) NOT NULL,
	[BusinessEntityID] [int] NULL,
	[Resume] [xml](CONTENT [HumanResources].[HRResumeSchemaCollection]) NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_JobCandidate_JobCandidateID] PRIMARY KEY CLUSTERED 
(
	[JobCandidateID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key for JobCandidate records.' , @level0type=N'SCHEMA',@level0name=N'HumanResources', @level1type=N'TABLE',@level1name=N'JobCandidate', @level2type=N'COLUMN',@level2name=N'JobCandidateID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Employee identification number if applicant was hired. Foreign key to Employee.BusinessEntityID.' , @level0type=N'SCHEMA',@level0name=N'HumanResources', @level1type=N'TABLE',@level1name=N'JobCandidate', @level2type=N'COLUMN',@level2name=N'BusinessEntityID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Résumé in XML format.' , @level0type=N'SCHEMA',@level0name=N'HumanResources', @level1type=N'TABLE',@level1name=N'JobCandidate', @level2type=N'COLUMN',@level2name=N'Resume'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'HumanResources', @level1type=N'TABLE',@level1name=N'JobCandidate', @level2type=N'COLUMN',@level2name=N'ModifiedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Résumés submitted to Human Resources by job applicants.' , @level0type=N'SCHEMA',@level0name=N'HumanResources', @level1type=N'TABLE',@level1name=N'JobCandidate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key (clustered) constraint' , @level0type=N'SCHEMA',@level0name=N'HumanResources', @level1type=N'TABLE',@level1name=N'JobCandidate', @level2type=N'CONSTRAINT',@level2name=N'PK_JobCandidate_JobCandidateID'
GO
/****** Object:  Table [Production].[Document]    Script Date: 11/22/2013 20:49:40 ******/
SET ARITHABORT ON
GO
SET CONCAT_NULL_YIELDS_NULL ON
GO
SET ANSI_NULLS ON
GO
SET ANSI_PADDING ON
GO
SET ANSI_WARNINGS ON
GO
SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
SET ARITHABORT ON
GO
CREATE TABLE [Production].[Document](
	[DocumentNode] [hierarchyid] NOT NULL,
	[DocumentLevel]  AS ([DocumentNode].[GetLevel]()),
	[Title] [nvarchar](50) NOT NULL,
	[Owner] [int] NOT NULL,
	[FolderFlag] [bit] NOT NULL,
	[FileName] [nvarchar](400) NOT NULL,
	[FileExtension] [nvarchar](8) NOT NULL,
	[Revision] [nchar](5) NOT NULL,
	[ChangeNumber] [int] NOT NULL,
	[Status] [tinyint] NOT NULL,
	[DocumentSummary] [nvarchar](max) NULL,
	[Document] [varbinary](max) NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Document_DocumentNode] PRIMARY KEY CLUSTERED 
(
	[DocumentNode] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[rowguid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key for Document records.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'Document', @level2type=N'COLUMN',@level2name=N'DocumentNode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Depth in the document hierarchy.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'Document', @level2type=N'COLUMN',@level2name=N'DocumentLevel'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Title of the document.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'Document', @level2type=N'COLUMN',@level2name=N'Title'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Employee who controls the document.  Foreign key to Employee.BusinessEntityID' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'Document', @level2type=N'COLUMN',@level2name=N'Owner'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0 = This is a folder, 1 = This is a document.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'Document', @level2type=N'COLUMN',@level2name=N'FolderFlag'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'File name of the document' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'Document', @level2type=N'COLUMN',@level2name=N'FileName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'File extension indicating the document type. For example, .doc or .txt.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'Document', @level2type=N'COLUMN',@level2name=N'FileExtension'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Revision number of the document. ' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'Document', @level2type=N'COLUMN',@level2name=N'Revision'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Engineering change approval number.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'Document', @level2type=N'COLUMN',@level2name=N'ChangeNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'1 = Pending approval, 2 = Approved, 3 = Obsolete' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'Document', @level2type=N'COLUMN',@level2name=N'Status'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Document abstract.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'Document', @level2type=N'COLUMN',@level2name=N'DocumentSummary'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Complete document.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'Document', @level2type=N'COLUMN',@level2name=N'Document'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ROWGUIDCOL number uniquely identifying the record. Required for FileStream.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'Document', @level2type=N'COLUMN',@level2name=N'rowguid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'Document', @level2type=N'COLUMN',@level2name=N'ModifiedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Product maintenance documents.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'Document'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key (clustered) constraint' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'Document', @level2type=N'CONSTRAINT',@level2name=N'PK_Document_DocumentNode'
GO
/****** Object:  Table [Sales].[SalesPerson]    Script Date: 11/22/2013 20:49:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Sales].[SalesPerson](
	[BusinessEntityID] [int] NOT NULL,
	[TerritoryID] [int] NULL,
	[SalesQuota] [money] NULL,
	[Bonus] [money] NOT NULL,
	[CommissionPct] [smallmoney] NOT NULL,
	[SalesYTD] [money] NOT NULL,
	[SalesLastYear] [money] NOT NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_SalesPerson_BusinessEntityID] PRIMARY KEY CLUSTERED 
(
	[BusinessEntityID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key for SalesPerson records. Foreign key to Employee.BusinessEntityID' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesPerson', @level2type=N'COLUMN',@level2name=N'BusinessEntityID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Territory currently assigned to. Foreign key to SalesTerritory.SalesTerritoryID.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesPerson', @level2type=N'COLUMN',@level2name=N'TerritoryID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Projected yearly sales.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesPerson', @level2type=N'COLUMN',@level2name=N'SalesQuota'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Bonus due if quota is met.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesPerson', @level2type=N'COLUMN',@level2name=N'Bonus'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Commision percent received per sale.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesPerson', @level2type=N'COLUMN',@level2name=N'CommissionPct'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Sales total year to date.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesPerson', @level2type=N'COLUMN',@level2name=N'SalesYTD'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Sales total of previous year.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesPerson', @level2type=N'COLUMN',@level2name=N'SalesLastYear'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesPerson', @level2type=N'COLUMN',@level2name=N'rowguid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesPerson', @level2type=N'COLUMN',@level2name=N'ModifiedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Sales representative current information.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesPerson'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key (clustered) constraint' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesPerson', @level2type=N'CONSTRAINT',@level2name=N'PK_SalesPerson_BusinessEntityID'
GO
/****** Object:  Table [Purchasing].[PurchaseOrderHeader]    Script Date: 11/22/2013 20:49:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Purchasing].[PurchaseOrderHeader](
	[PurchaseOrderID] [int] IDENTITY(1,1) NOT NULL,
	[RevisionNumber] [tinyint] NOT NULL,
	[Status] [tinyint] NOT NULL,
	[EmployeeID] [int] NOT NULL,
	[VendorID] [int] NOT NULL,
	[ShipMethodID] [int] NOT NULL,
	[OrderDate] [datetime] NOT NULL,
	[ShipDate] [datetime] NULL,
	[SubTotal] [money] NOT NULL,
	[TaxAmt] [money] NOT NULL,
	[Freight] [money] NOT NULL,
	[TotalDue]  AS (isnull(([SubTotal]+[TaxAmt])+[Freight],(0))) PERSISTED NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_PurchaseOrderHeader_PurchaseOrderID] PRIMARY KEY CLUSTERED 
(
	[PurchaseOrderID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key.' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'PurchaseOrderHeader', @level2type=N'COLUMN',@level2name=N'PurchaseOrderID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Incremental number to track changes to the purchase order over time.' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'PurchaseOrderHeader', @level2type=N'COLUMN',@level2name=N'RevisionNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Order current status. 1 = Pending; 2 = Approved; 3 = Rejected; 4 = Complete' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'PurchaseOrderHeader', @level2type=N'COLUMN',@level2name=N'Status'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Employee who created the purchase order. Foreign key to Employee.BusinessEntityID.' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'PurchaseOrderHeader', @level2type=N'COLUMN',@level2name=N'EmployeeID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Vendor with whom the purchase order is placed. Foreign key to Vendor.BusinessEntityID.' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'PurchaseOrderHeader', @level2type=N'COLUMN',@level2name=N'VendorID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Shipping method. Foreign key to ShipMethod.ShipMethodID.' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'PurchaseOrderHeader', @level2type=N'COLUMN',@level2name=N'ShipMethodID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Purchase order creation date.' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'PurchaseOrderHeader', @level2type=N'COLUMN',@level2name=N'OrderDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Estimated shipment date from the vendor.' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'PurchaseOrderHeader', @level2type=N'COLUMN',@level2name=N'ShipDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Purchase order subtotal. Computed as SUM(PurchaseOrderDetail.LineTotal)for the appropriate PurchaseOrderID.' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'PurchaseOrderHeader', @level2type=N'COLUMN',@level2name=N'SubTotal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tax amount.' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'PurchaseOrderHeader', @level2type=N'COLUMN',@level2name=N'TaxAmt'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Shipping cost.' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'PurchaseOrderHeader', @level2type=N'COLUMN',@level2name=N'Freight'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Total due to vendor. Computed as Subtotal + TaxAmt + Freight.' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'PurchaseOrderHeader', @level2type=N'COLUMN',@level2name=N'TotalDue'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'PurchaseOrderHeader', @level2type=N'COLUMN',@level2name=N'ModifiedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'General purchase order information. See PurchaseOrderDetail.' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'PurchaseOrderHeader'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key (clustered) constraint' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'PurchaseOrderHeader', @level2type=N'CONSTRAINT',@level2name=N'PK_PurchaseOrderHeader_PurchaseOrderID'
GO
/****** Object:  Table [Production].[Product]    Script Date: 11/22/2013 20:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Production].[Product](
	[ProductID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [dbo].[Name] NOT NULL,
	[ProductNumber] [nvarchar](25) NOT NULL,
	[MakeFlag] [dbo].[Flag] NOT NULL,
	[FinishedGoodsFlag] [dbo].[Flag] NOT NULL,
	[Color] [nvarchar](15) NULL,
	[SafetyStockLevel] [smallint] NOT NULL,
	[ReorderPoint] [smallint] NOT NULL,
	[StandardCost] [money] NOT NULL,
	[ListPrice] [money] NOT NULL,
	[Size] [nvarchar](5) NULL,
	[SizeUnitMeasureCode] [nchar](3) NULL,
	[WeightUnitMeasureCode] [nchar](3) NULL,
	[Weight] [decimal](8, 2) NULL,
	[DaysToManufacture] [int] NOT NULL,
	[ProductLine] [nchar](2) NULL,
	[Class] [nchar](2) NULL,
	[Style] [nchar](2) NULL,
	[ProductSubcategoryID] [int] NULL,
	[ProductModelID] [int] NULL,
	[SellStartDate] [datetime] NOT NULL,
	[SellEndDate] [datetime] NULL,
	[DiscontinuedDate] [datetime] NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Product_ProductID] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key for Product records.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'Product', @level2type=N'COLUMN',@level2name=N'ProductID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Name of the product.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'Product', @level2type=N'COLUMN',@level2name=N'Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Unique product identification number.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'Product', @level2type=N'COLUMN',@level2name=N'ProductNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0 = Product is purchased, 1 = Product is manufactured in-house.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'Product', @level2type=N'COLUMN',@level2name=N'MakeFlag'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0 = Product is not a salable item. 1 = Product is salable.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'Product', @level2type=N'COLUMN',@level2name=N'FinishedGoodsFlag'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Product color.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'Product', @level2type=N'COLUMN',@level2name=N'Color'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Minimum inventory quantity. ' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'Product', @level2type=N'COLUMN',@level2name=N'SafetyStockLevel'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Inventory level that triggers a purchase order or work order. ' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'Product', @level2type=N'COLUMN',@level2name=N'ReorderPoint'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Standard cost of the product.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'Product', @level2type=N'COLUMN',@level2name=N'StandardCost'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Selling price.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'Product', @level2type=N'COLUMN',@level2name=N'ListPrice'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Product size.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'Product', @level2type=N'COLUMN',@level2name=N'Size'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Unit of measure for Size column.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'Product', @level2type=N'COLUMN',@level2name=N'SizeUnitMeasureCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Unit of measure for Weight column.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'Product', @level2type=N'COLUMN',@level2name=N'WeightUnitMeasureCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Product weight.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'Product', @level2type=N'COLUMN',@level2name=N'Weight'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Number of days required to manufacture the product.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'Product', @level2type=N'COLUMN',@level2name=N'DaysToManufacture'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'R = Road, M = Mountain, T = Touring, S = Standard' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'Product', @level2type=N'COLUMN',@level2name=N'ProductLine'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'H = High, M = Medium, L = Low' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'Product', @level2type=N'COLUMN',@level2name=N'Class'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'W = Womens, M = Mens, U = Universal' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'Product', @level2type=N'COLUMN',@level2name=N'Style'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Product is a member of this product subcategory. Foreign key to ProductSubCategory.ProductSubCategoryID. ' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'Product', @level2type=N'COLUMN',@level2name=N'ProductSubcategoryID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Product is a member of this product model. Foreign key to ProductModel.ProductModelID.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'Product', @level2type=N'COLUMN',@level2name=N'ProductModelID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date the product was available for sale.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'Product', @level2type=N'COLUMN',@level2name=N'SellStartDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date the product was no longer available for sale.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'Product', @level2type=N'COLUMN',@level2name=N'SellEndDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date the product was discontinued.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'Product', @level2type=N'COLUMN',@level2name=N'DiscontinuedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'Product', @level2type=N'COLUMN',@level2name=N'rowguid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'Product', @level2type=N'COLUMN',@level2name=N'ModifiedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Products sold or used in the manfacturing of sold products.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'Product'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key (clustered) constraint' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'Product', @level2type=N'CONSTRAINT',@level2name=N'PK_Product_ProductID'
GO
/****** Object:  Table [Person].[StateProvince]    Script Date: 11/22/2013 20:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Person].[StateProvince](
	[StateProvinceID] [int] IDENTITY(1,1) NOT NULL,
	[StateProvinceCode] [nchar](3) NOT NULL,
	[CountryRegionCode] [nvarchar](3) NOT NULL,
	[IsOnlyStateProvinceFlag] [dbo].[Flag] NOT NULL,
	[Name] [dbo].[Name] NOT NULL,
	[TerritoryID] [int] NOT NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_StateProvince_StateProvinceID] PRIMARY KEY CLUSTERED 
(
	[StateProvinceID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key for StateProvince records.' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'StateProvince', @level2type=N'COLUMN',@level2name=N'StateProvinceID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ISO standard state or province code.' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'StateProvince', @level2type=N'COLUMN',@level2name=N'StateProvinceCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ISO standard country or region code. Foreign key to CountryRegion.CountryRegionCode. ' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'StateProvince', @level2type=N'COLUMN',@level2name=N'CountryRegionCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0 = StateProvinceCode exists. 1 = StateProvinceCode unavailable, using CountryRegionCode.' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'StateProvince', @level2type=N'COLUMN',@level2name=N'IsOnlyStateProvinceFlag'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'State or province description.' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'StateProvince', @level2type=N'COLUMN',@level2name=N'Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ID of the territory in which the state or province is located. Foreign key to SalesTerritory.SalesTerritoryID.' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'StateProvince', @level2type=N'COLUMN',@level2name=N'TerritoryID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'StateProvince', @level2type=N'COLUMN',@level2name=N'rowguid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'StateProvince', @level2type=N'COLUMN',@level2name=N'ModifiedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'State and province lookup table.' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'StateProvince'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key (clustered) constraint' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'StateProvince', @level2type=N'CONSTRAINT',@level2name=N'PK_StateProvince_StateProvinceID'
GO
/****** Object:  Table [Production].[TransactionHistory]    Script Date: 11/22/2013 20:49:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Production].[TransactionHistory](
	[TransactionID] [int] IDENTITY(100000,1) NOT NULL,
	[ProductID] [int] NOT NULL,
	[ReferenceOrderID] [int] NOT NULL,
	[ReferenceOrderLineID] [int] NOT NULL,
	[TransactionDate] [datetime] NOT NULL,
	[TransactionType] [nchar](1) NOT NULL,
	[Quantity] [int] NOT NULL,
	[ActualCost] [money] NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_TransactionHistory_TransactionID] PRIMARY KEY CLUSTERED 
(
	[TransactionID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key for TransactionHistory records.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'TransactionHistory', @level2type=N'COLUMN',@level2name=N'TransactionID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Product identification number. Foreign key to Product.ProductID.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'TransactionHistory', @level2type=N'COLUMN',@level2name=N'ProductID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Purchase order, sales order, or work order identification number.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'TransactionHistory', @level2type=N'COLUMN',@level2name=N'ReferenceOrderID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Line number associated with the purchase order, sales order, or work order.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'TransactionHistory', @level2type=N'COLUMN',@level2name=N'ReferenceOrderLineID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time of the transaction.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'TransactionHistory', @level2type=N'COLUMN',@level2name=N'TransactionDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'W = WorkOrder, S = SalesOrder, P = PurchaseOrder' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'TransactionHistory', @level2type=N'COLUMN',@level2name=N'TransactionType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Product quantity.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'TransactionHistory', @level2type=N'COLUMN',@level2name=N'Quantity'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Product cost.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'TransactionHistory', @level2type=N'COLUMN',@level2name=N'ActualCost'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'TransactionHistory', @level2type=N'COLUMN',@level2name=N'ModifiedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Record of each purchase order, sales order, or work order transaction year to date.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'TransactionHistory'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key (clustered) constraint' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'TransactionHistory', @level2type=N'CONSTRAINT',@level2name=N'PK_TransactionHistory_TransactionID'
GO
/****** Object:  Table [Sales].[Store]    Script Date: 11/22/2013 20:49:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Sales].[Store](
	[BusinessEntityID] [int] NOT NULL,
	[Name] [dbo].[Name] NOT NULL,
	[SalesPersonID] [int] NULL,
	[Demographics] [xml](CONTENT [Sales].[StoreSurveySchemaCollection]) NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Store_BusinessEntityID] PRIMARY KEY CLUSTERED 
(
	[BusinessEntityID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key. Foreign key to Customer.BusinessEntityID.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'Store', @level2type=N'COLUMN',@level2name=N'BusinessEntityID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Name of the store.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'Store', @level2type=N'COLUMN',@level2name=N'Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ID of the sales person assigned to the customer. Foreign key to SalesPerson.BusinessEntityID.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'Store', @level2type=N'COLUMN',@level2name=N'SalesPersonID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Demographic informationg about the store such as the number of employees, annual sales and store type.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'Store', @level2type=N'COLUMN',@level2name=N'Demographics'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'Store', @level2type=N'COLUMN',@level2name=N'rowguid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'Store', @level2type=N'COLUMN',@level2name=N'ModifiedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Customers (resellers) of Adventure Works products.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'Store'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key (clustered) constraint' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'Store', @level2type=N'CONSTRAINT',@level2name=N'PK_Store_BusinessEntityID'
GO
/****** Object:  Table [Sales].[ShoppingCartItem]    Script Date: 11/22/2013 20:49:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Sales].[ShoppingCartItem](
	[ShoppingCartItemID] [int] IDENTITY(1,1) NOT NULL,
	[ShoppingCartID] [nvarchar](50) NOT NULL,
	[Quantity] [int] NOT NULL,
	[ProductID] [int] NOT NULL,
	[DateCreated] [datetime] NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_ShoppingCartItem_ShoppingCartItemID] PRIMARY KEY CLUSTERED 
(
	[ShoppingCartItemID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key for ShoppingCartItem records.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'ShoppingCartItem', @level2type=N'COLUMN',@level2name=N'ShoppingCartItemID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Shopping cart identification number.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'ShoppingCartItem', @level2type=N'COLUMN',@level2name=N'ShoppingCartID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Product quantity ordered.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'ShoppingCartItem', @level2type=N'COLUMN',@level2name=N'Quantity'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Product ordered. Foreign key to Product.ProductID.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'ShoppingCartItem', @level2type=N'COLUMN',@level2name=N'ProductID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date the time the record was created.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'ShoppingCartItem', @level2type=N'COLUMN',@level2name=N'DateCreated'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'ShoppingCartItem', @level2type=N'COLUMN',@level2name=N'ModifiedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Contains online customer orders until the order is submitted or cancelled.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'ShoppingCartItem'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key (clustered) constraint' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'ShoppingCartItem', @level2type=N'CONSTRAINT',@level2name=N'PK_ShoppingCartItem_ShoppingCartItemID'
GO
/****** Object:  Table [Sales].[SalesPersonQuotaHistory]    Script Date: 11/22/2013 20:49:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Sales].[SalesPersonQuotaHistory](
	[BusinessEntityID] [int] NOT NULL,
	[QuotaDate] [datetime] NOT NULL,
	[SalesQuota] [money] NOT NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_SalesPersonQuotaHistory_BusinessEntityID_QuotaDate] PRIMARY KEY CLUSTERED 
(
	[BusinessEntityID] ASC,
	[QuotaDate] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Sales person identification number. Foreign key to SalesPerson.BusinessEntityID.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesPersonQuotaHistory', @level2type=N'COLUMN',@level2name=N'BusinessEntityID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Sales quota date.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesPersonQuotaHistory', @level2type=N'COLUMN',@level2name=N'QuotaDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Sales quota amount.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesPersonQuotaHistory', @level2type=N'COLUMN',@level2name=N'SalesQuota'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesPersonQuotaHistory', @level2type=N'COLUMN',@level2name=N'rowguid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesPersonQuotaHistory', @level2type=N'COLUMN',@level2name=N'ModifiedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Sales performance tracking.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesPersonQuotaHistory'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key (clustered) constraint' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesPersonQuotaHistory', @level2type=N'CONSTRAINT',@level2name=N'PK_SalesPersonQuotaHistory_BusinessEntityID_QuotaDate'
GO
/****** Object:  Table [Sales].[SpecialOfferProduct]    Script Date: 11/22/2013 20:49:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Sales].[SpecialOfferProduct](
	[SpecialOfferID] [int] NOT NULL,
	[ProductID] [int] NOT NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_SpecialOfferProduct_SpecialOfferID_ProductID] PRIMARY KEY CLUSTERED 
(
	[SpecialOfferID] ASC,
	[ProductID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key for SpecialOfferProduct records.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SpecialOfferProduct', @level2type=N'COLUMN',@level2name=N'SpecialOfferID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Product identification number. Foreign key to Product.ProductID.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SpecialOfferProduct', @level2type=N'COLUMN',@level2name=N'ProductID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SpecialOfferProduct', @level2type=N'COLUMN',@level2name=N'rowguid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SpecialOfferProduct', @level2type=N'COLUMN',@level2name=N'ModifiedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Cross-reference table mapping products to special offer discounts.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SpecialOfferProduct'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key (clustered) constraint' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SpecialOfferProduct', @level2type=N'CONSTRAINT',@level2name=N'PK_SpecialOfferProduct_SpecialOfferID_ProductID'
GO
/****** Object:  Table [Sales].[SalesTerritoryHistory]    Script Date: 11/22/2013 20:49:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Sales].[SalesTerritoryHistory](
	[BusinessEntityID] [int] NOT NULL,
	[TerritoryID] [int] NOT NULL,
	[StartDate] [datetime] NOT NULL,
	[EndDate] [datetime] NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_SalesTerritoryHistory_BusinessEntityID_StartDate_TerritoryID] PRIMARY KEY CLUSTERED 
(
	[BusinessEntityID] ASC,
	[StartDate] ASC,
	[TerritoryID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key. The sales rep.  Foreign key to SalesPerson.BusinessEntityID.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesTerritoryHistory', @level2type=N'COLUMN',@level2name=N'BusinessEntityID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key. Territory identification number. Foreign key to SalesTerritory.SalesTerritoryID.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesTerritoryHistory', @level2type=N'COLUMN',@level2name=N'TerritoryID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key. Date the sales representive started work in the territory.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesTerritoryHistory', @level2type=N'COLUMN',@level2name=N'StartDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date the sales representative left work in the territory.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesTerritoryHistory', @level2type=N'COLUMN',@level2name=N'EndDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesTerritoryHistory', @level2type=N'COLUMN',@level2name=N'rowguid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesTerritoryHistory', @level2type=N'COLUMN',@level2name=N'ModifiedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Sales representative transfers to other sales territories.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesTerritoryHistory'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key (clustered) constraint' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesTerritoryHistory', @level2type=N'CONSTRAINT',@level2name=N'PK_SalesTerritoryHistory_BusinessEntityID_StartDate_TerritoryID'
GO
/****** Object:  Table [Sales].[SalesTaxRate]    Script Date: 11/22/2013 20:49:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Sales].[SalesTaxRate](
	[SalesTaxRateID] [int] IDENTITY(1,1) NOT NULL,
	[StateProvinceID] [int] NOT NULL,
	[TaxType] [tinyint] NOT NULL,
	[TaxRate] [smallmoney] NOT NULL,
	[Name] [dbo].[Name] NOT NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_SalesTaxRate_SalesTaxRateID] PRIMARY KEY CLUSTERED 
(
	[SalesTaxRateID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key for SalesTaxRate records.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesTaxRate', @level2type=N'COLUMN',@level2name=N'SalesTaxRateID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'State, province, or country/region the sales tax applies to.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesTaxRate', @level2type=N'COLUMN',@level2name=N'StateProvinceID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'1 = Tax applied to retail transactions, 2 = Tax applied to wholesale transactions, 3 = Tax applied to all sales (retail and wholesale) transactions.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesTaxRate', @level2type=N'COLUMN',@level2name=N'TaxType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tax rate amount.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesTaxRate', @level2type=N'COLUMN',@level2name=N'TaxRate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tax rate description.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesTaxRate', @level2type=N'COLUMN',@level2name=N'Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesTaxRate', @level2type=N'COLUMN',@level2name=N'rowguid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesTaxRate', @level2type=N'COLUMN',@level2name=N'ModifiedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tax rate lookup table.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesTaxRate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key (clustered) constraint' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesTaxRate', @level2type=N'CONSTRAINT',@level2name=N'PK_SalesTaxRate_SalesTaxRateID'
GO
/****** Object:  Table [Production].[ProductCostHistory]    Script Date: 11/22/2013 20:49:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Production].[ProductCostHistory](
	[ProductID] [int] NOT NULL,
	[StartDate] [datetime] NOT NULL,
	[EndDate] [datetime] NULL,
	[StandardCost] [money] NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_ProductCostHistory_ProductID_StartDate] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC,
	[StartDate] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Product identification number. Foreign key to Product.ProductID' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductCostHistory', @level2type=N'COLUMN',@level2name=N'ProductID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Product cost start date.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductCostHistory', @level2type=N'COLUMN',@level2name=N'StartDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Product cost end date.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductCostHistory', @level2type=N'COLUMN',@level2name=N'EndDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Standard cost of the product.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductCostHistory', @level2type=N'COLUMN',@level2name=N'StandardCost'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductCostHistory', @level2type=N'COLUMN',@level2name=N'ModifiedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Changes in the cost of a product over time.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductCostHistory'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key (clustered) constraint' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductCostHistory', @level2type=N'CONSTRAINT',@level2name=N'PK_ProductCostHistory_ProductID_StartDate'
GO
/****** Object:  Table [Production].[ProductReview]    Script Date: 11/22/2013 20:49:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Production].[ProductReview](
	[ProductReviewID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NOT NULL,
	[ReviewerName] [dbo].[Name] NOT NULL,
	[ReviewDate] [datetime] NOT NULL,
	[EmailAddress] [nvarchar](50) NOT NULL,
	[Rating] [int] NOT NULL,
	[Comments] [nvarchar](3850) NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_ProductReview_ProductReviewID] PRIMARY KEY CLUSTERED 
(
	[ProductReviewID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key for ProductReview records.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductReview', @level2type=N'COLUMN',@level2name=N'ProductReviewID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Product identification number. Foreign key to Product.ProductID.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductReview', @level2type=N'COLUMN',@level2name=N'ProductID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Name of the reviewer.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductReview', @level2type=N'COLUMN',@level2name=N'ReviewerName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date review was submitted.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductReview', @level2type=N'COLUMN',@level2name=N'ReviewDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Reviewer''s e-mail address.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductReview', @level2type=N'COLUMN',@level2name=N'EmailAddress'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Product rating given by the reviewer. Scale is 1 to 5 with 5 as the highest rating.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductReview', @level2type=N'COLUMN',@level2name=N'Rating'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Reviewer''s comments' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductReview', @level2type=N'COLUMN',@level2name=N'Comments'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductReview', @level2type=N'COLUMN',@level2name=N'ModifiedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Customer reviews of products they have purchased.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductReview'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key (clustered) constraint' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductReview', @level2type=N'CONSTRAINT',@level2name=N'PK_ProductReview_ProductReviewID'
GO
/****** Object:  Table [Production].[ProductProductPhoto]    Script Date: 11/22/2013 20:49:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Production].[ProductProductPhoto](
	[ProductID] [int] NOT NULL,
	[ProductPhotoID] [int] NOT NULL,
	[Primary] [dbo].[Flag] NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_ProductProductPhoto_ProductID_ProductPhotoID] PRIMARY KEY NONCLUSTERED 
(
	[ProductID] ASC,
	[ProductPhotoID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Product identification number. Foreign key to Product.ProductID.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductProductPhoto', @level2type=N'COLUMN',@level2name=N'ProductID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Product photo identification number. Foreign key to ProductPhoto.ProductPhotoID.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductProductPhoto', @level2type=N'COLUMN',@level2name=N'ProductPhotoID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0 = Photo is not the principal image. 1 = Photo is the principal image.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductProductPhoto', @level2type=N'COLUMN',@level2name=N'Primary'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductProductPhoto', @level2type=N'COLUMN',@level2name=N'ModifiedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Cross-reference table mapping products and product photos.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductProductPhoto'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key (clustered) constraint' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductProductPhoto', @level2type=N'CONSTRAINT',@level2name=N'PK_ProductProductPhoto_ProductID_ProductPhotoID'
GO
/****** Object:  Table [Production].[ProductListPriceHistory]    Script Date: 11/22/2013 20:49:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Production].[ProductListPriceHistory](
	[ProductID] [int] NOT NULL,
	[StartDate] [datetime] NOT NULL,
	[EndDate] [datetime] NULL,
	[ListPrice] [money] NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_ProductListPriceHistory_ProductID_StartDate] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC,
	[StartDate] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Product identification number. Foreign key to Product.ProductID' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductListPriceHistory', @level2type=N'COLUMN',@level2name=N'ProductID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'List price start date.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductListPriceHistory', @level2type=N'COLUMN',@level2name=N'StartDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'List price end date' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductListPriceHistory', @level2type=N'COLUMN',@level2name=N'EndDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Product list price.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductListPriceHistory', @level2type=N'COLUMN',@level2name=N'ListPrice'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductListPriceHistory', @level2type=N'COLUMN',@level2name=N'ModifiedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Changes in the list price of a product over time.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductListPriceHistory'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key (clustered) constraint' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductListPriceHistory', @level2type=N'CONSTRAINT',@level2name=N'PK_ProductListPriceHistory_ProductID_StartDate'
GO
/****** Object:  Table [Production].[ProductInventory]    Script Date: 11/22/2013 20:49:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Production].[ProductInventory](
	[ProductID] [int] NOT NULL,
	[LocationID] [smallint] NOT NULL,
	[Shelf] [nvarchar](10) NOT NULL,
	[Bin] [tinyint] NOT NULL,
	[Quantity] [smallint] NOT NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_ProductInventory_ProductID_LocationID] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC,
	[LocationID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Product identification number. Foreign key to Product.ProductID.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductInventory', @level2type=N'COLUMN',@level2name=N'ProductID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Inventory location identification number. Foreign key to Location.LocationID. ' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductInventory', @level2type=N'COLUMN',@level2name=N'LocationID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Storage compartment within an inventory location.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductInventory', @level2type=N'COLUMN',@level2name=N'Shelf'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Storage container on a shelf in an inventory location.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductInventory', @level2type=N'COLUMN',@level2name=N'Bin'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Quantity of products in the inventory location.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductInventory', @level2type=N'COLUMN',@level2name=N'Quantity'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductInventory', @level2type=N'COLUMN',@level2name=N'rowguid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductInventory', @level2type=N'COLUMN',@level2name=N'ModifiedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Product inventory information.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductInventory'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key (clustered) constraint' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductInventory', @level2type=N'CONSTRAINT',@level2name=N'PK_ProductInventory_ProductID_LocationID'
GO
/****** Object:  Table [Production].[ProductDocument]    Script Date: 11/22/2013 20:49:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Production].[ProductDocument](
	[ProductID] [int] NOT NULL,
	[DocumentNode] [hierarchyid] NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_ProductDocument_ProductID_DocumentNode] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC,
	[DocumentNode] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Product identification number. Foreign key to Product.ProductID.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductDocument', @level2type=N'COLUMN',@level2name=N'ProductID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Document identification number. Foreign key to Document.DocumentNode.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductDocument', @level2type=N'COLUMN',@level2name=N'DocumentNode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductDocument', @level2type=N'COLUMN',@level2name=N'ModifiedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Cross-reference table mapping products to related product documents.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductDocument'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key (clustered) constraint' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductDocument', @level2type=N'CONSTRAINT',@level2name=N'PK_ProductDocument_ProductID_DocumentNode'
GO
/****** Object:  Table [Production].[BillOfMaterials]    Script Date: 11/22/2013 20:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Production].[BillOfMaterials](
	[BillOfMaterialsID] [int] IDENTITY(1,1) NOT NULL,
	[ProductAssemblyID] [int] NULL,
	[ComponentID] [int] NOT NULL,
	[StartDate] [datetime] NOT NULL,
	[EndDate] [datetime] NULL,
	[UnitMeasureCode] [nchar](3) NOT NULL,
	[BOMLevel] [smallint] NOT NULL,
	[PerAssemblyQty] [decimal](8, 2) NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_BillOfMaterials_BillOfMaterialsID] PRIMARY KEY NONCLUSTERED 
(
	[BillOfMaterialsID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key for BillOfMaterials records.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'BillOfMaterials', @level2type=N'COLUMN',@level2name=N'BillOfMaterialsID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Parent product identification number. Foreign key to Product.ProductID.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'BillOfMaterials', @level2type=N'COLUMN',@level2name=N'ProductAssemblyID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Component identification number. Foreign key to Product.ProductID.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'BillOfMaterials', @level2type=N'COLUMN',@level2name=N'ComponentID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date the component started being used in the assembly item.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'BillOfMaterials', @level2type=N'COLUMN',@level2name=N'StartDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date the component stopped being used in the assembly item.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'BillOfMaterials', @level2type=N'COLUMN',@level2name=N'EndDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Standard code identifying the unit of measure for the quantity.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'BillOfMaterials', @level2type=N'COLUMN',@level2name=N'UnitMeasureCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Indicates the depth the component is from its parent (AssemblyID).' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'BillOfMaterials', @level2type=N'COLUMN',@level2name=N'BOMLevel'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Quantity of the component needed to create the assembly.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'BillOfMaterials', @level2type=N'COLUMN',@level2name=N'PerAssemblyQty'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'BillOfMaterials', @level2type=N'COLUMN',@level2name=N'ModifiedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Items required to make bicycles and bicycle subassemblies. It identifies the heirarchical relationship between a parent product and its components.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'BillOfMaterials'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key (clustered) constraint' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'BillOfMaterials', @level2type=N'CONSTRAINT',@level2name=N'PK_BillOfMaterials_BillOfMaterialsID'
GO
/****** Object:  Table [Person].[Address]    Script Date: 11/22/2013 20:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Person].[Address](
	[AddressID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[AddressLine1] [nvarchar](60) NOT NULL,
	[AddressLine2] [nvarchar](60) NULL,
	[City] [nvarchar](30) NOT NULL,
	[StateProvinceID] [int] NOT NULL,
	[PostalCode] [nvarchar](15) NOT NULL,
	[SpatialLocation] [geography] NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Address_AddressID] PRIMARY KEY CLUSTERED 
(
	[AddressID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key for Address records.' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'Address', @level2type=N'COLUMN',@level2name=N'AddressID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'First street address line.' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'Address', @level2type=N'COLUMN',@level2name=N'AddressLine1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Second street address line.' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'Address', @level2type=N'COLUMN',@level2name=N'AddressLine2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Name of the city.' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'Address', @level2type=N'COLUMN',@level2name=N'City'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Unique identification number for the state or province. Foreign key to StateProvince table.' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'Address', @level2type=N'COLUMN',@level2name=N'StateProvinceID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Postal code for the street address.' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'Address', @level2type=N'COLUMN',@level2name=N'PostalCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Latitude and longitude of this address.' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'Address', @level2type=N'COLUMN',@level2name=N'SpatialLocation'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'Address', @level2type=N'COLUMN',@level2name=N'rowguid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'Address', @level2type=N'COLUMN',@level2name=N'ModifiedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Street address information for customers, employees, and vendors.' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'Address'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key (clustered) constraint' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'Address', @level2type=N'CONSTRAINT',@level2name=N'PK_Address_AddressID'
GO
/****** Object:  View [HumanResources].[vEmployeeDepartmentHistory]    Script Date: 11/22/2013 20:49:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [HumanResources].[vEmployeeDepartmentHistory] 
AS 
SELECT 
    e.[BusinessEntityID] 
    ,p.[Title] 
    ,p.[FirstName] 
    ,p.[MiddleName] 
    ,p.[LastName] 
    ,p.[Suffix] 
    ,s.[Name] AS [Shift]
    ,d.[Name] AS [Department] 
    ,d.[GroupName] 
    ,edh.[StartDate] 
    ,edh.[EndDate]
FROM [HumanResources].[Employee] e
	INNER JOIN [Person].[Person] p
	ON p.[BusinessEntityID] = e.[BusinessEntityID]
    INNER JOIN [HumanResources].[EmployeeDepartmentHistory] edh 
    ON e.[BusinessEntityID] = edh.[BusinessEntityID] 
    INNER JOIN [HumanResources].[Department] d 
    ON edh.[DepartmentID] = d.[DepartmentID] 
    INNER JOIN [HumanResources].[Shift] s
    ON s.[ShiftID] = edh.[ShiftID];
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Returns employee name and current and previous departments.' , @level0type=N'SCHEMA',@level0name=N'HumanResources', @level1type=N'VIEW',@level1name=N'vEmployeeDepartmentHistory'
GO
/****** Object:  View [HumanResources].[vEmployeeDepartment]    Script Date: 11/22/2013 20:49:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [HumanResources].[vEmployeeDepartment] 
AS 
SELECT 
    e.[BusinessEntityID] 
    ,p.[Title] 
    ,p.[FirstName] 
    ,p.[MiddleName] 
    ,p.[LastName] 
    ,p.[Suffix] 
    ,e.[JobTitle]
    ,d.[Name] AS [Department] 
    ,d.[GroupName] 
    ,edh.[StartDate] 
FROM [HumanResources].[Employee] e
	INNER JOIN [Person].[Person] p
	ON p.[BusinessEntityID] = e.[BusinessEntityID]
    INNER JOIN [HumanResources].[EmployeeDepartmentHistory] edh 
    ON e.[BusinessEntityID] = edh.[BusinessEntityID] 
    INNER JOIN [HumanResources].[Department] d 
    ON edh.[DepartmentID] = d.[DepartmentID] 
WHERE GETDATE() BETWEEN edh.[StartDate] AND ISNULL(edh.[EndDate], GETDATE());
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Returns employee name, title, and current department.' , @level0type=N'SCHEMA',@level0name=N'HumanResources', @level1type=N'VIEW',@level1name=N'vEmployeeDepartment'
GO
/****** Object:  View [HumanResources].[vJobCandidateEmployment]    Script Date: 11/22/2013 20:49:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [HumanResources].[vJobCandidateEmployment] 
AS 
SELECT 
    jc.[JobCandidateID] 
    ,CONVERT(datetime, REPLACE([Employment].ref.value(N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Emp.StartDate)[1]', 'nvarchar(20)') ,'Z', ''), 101) AS [Emp.StartDate] 
    ,CONVERT(datetime, REPLACE([Employment].ref.value(N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Emp.EndDate)[1]', 'nvarchar(20)') ,'Z', ''), 101) AS [Emp.EndDate] 
    ,[Employment].ref.value(N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Emp.OrgName)[1]', 'nvarchar(100)') AS [Emp.OrgName]
    ,[Employment].ref.value(N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Emp.JobTitle)[1]', 'nvarchar(100)') AS [Emp.JobTitle]
    ,[Employment].ref.value(N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Emp.Responsibility)[1]', 'nvarchar(max)') AS [Emp.Responsibility]
    ,[Employment].ref.value(N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Emp.FunctionCategory)[1]', 'nvarchar(max)') AS [Emp.FunctionCategory]
    ,[Employment].ref.value(N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Emp.IndustryCategory)[1]', 'nvarchar(max)') AS [Emp.IndustryCategory]
    ,[Employment].ref.value(N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Emp.Location/Location/Loc.CountryRegion)[1]', 'nvarchar(max)') AS [Emp.Loc.CountryRegion]
    ,[Employment].ref.value(N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Emp.Location/Location/Loc.State)[1]', 'nvarchar(max)') AS [Emp.Loc.State]
    ,[Employment].ref.value(N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Emp.Location/Location/Loc.City)[1]', 'nvarchar(max)') AS [Emp.Loc.City]
FROM [HumanResources].[JobCandidate] jc 
CROSS APPLY jc.[Resume].nodes(N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
    /Resume/Employment') AS Employment(ref);
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Displays the content from each employement history related element in the xml column Resume in the HumanResources.JobCandidate table. The content has been localized into French, Simplified Chinese and Thai. Some data may not display correctly unless supplemental language support is installed.' , @level0type=N'SCHEMA',@level0name=N'HumanResources', @level1type=N'VIEW',@level1name=N'vJobCandidateEmployment'
GO
/****** Object:  View [HumanResources].[vJobCandidateEducation]    Script Date: 11/22/2013 20:49:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [HumanResources].[vJobCandidateEducation] 
AS 
SELECT 
    jc.[JobCandidateID] 
    ,[Education].ref.value(N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Edu.Level)[1]', 'nvarchar(max)') AS [Edu.Level]
    ,CONVERT(datetime, REPLACE([Education].ref.value(N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Edu.StartDate)[1]', 'nvarchar(20)') ,'Z', ''), 101) AS [Edu.StartDate] 
    ,CONVERT(datetime, REPLACE([Education].ref.value(N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Edu.EndDate)[1]', 'nvarchar(20)') ,'Z', ''), 101) AS [Edu.EndDate] 
    ,[Education].ref.value(N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Edu.Degree)[1]', 'nvarchar(50)') AS [Edu.Degree]
    ,[Education].ref.value(N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Edu.Major)[1]', 'nvarchar(50)') AS [Edu.Major]
    ,[Education].ref.value(N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Edu.Minor)[1]', 'nvarchar(50)') AS [Edu.Minor]
    ,[Education].ref.value(N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Edu.GPA)[1]', 'nvarchar(5)') AS [Edu.GPA]
    ,[Education].ref.value(N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Edu.GPAScale)[1]', 'nvarchar(5)') AS [Edu.GPAScale]
    ,[Education].ref.value(N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Edu.School)[1]', 'nvarchar(100)') AS [Edu.School]
    ,[Education].ref.value(N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Edu.Location/Location/Loc.CountryRegion)[1]', 'nvarchar(100)') AS [Edu.Loc.CountryRegion]
    ,[Education].ref.value(N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Edu.Location/Location/Loc.State)[1]', 'nvarchar(100)') AS [Edu.Loc.State]
    ,[Education].ref.value(N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Edu.Location/Location/Loc.City)[1]', 'nvarchar(100)') AS [Edu.Loc.City]
FROM [HumanResources].[JobCandidate] jc 
CROSS APPLY jc.[Resume].nodes(N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
    /Resume/Education') AS [Education](ref);
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Displays the content from each education related element in the xml column Resume in the HumanResources.JobCandidate table. The content has been localized into French, Simplified Chinese and Thai. Some data may not display correctly unless supplemental language support is installed.' , @level0type=N'SCHEMA',@level0name=N'HumanResources', @level1type=N'VIEW',@level1name=N'vJobCandidateEducation'
GO
/****** Object:  View [HumanResources].[vJobCandidate]    Script Date: 11/22/2013 20:49:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [HumanResources].[vJobCandidate] 
AS 
SELECT 
    jc.[JobCandidateID] 
    ,jc.[BusinessEntityID] 
    ,[Resume].ref.value(N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (/Resume/Name/Name.Prefix)[1]', 'nvarchar(30)') AS [Name.Prefix] 
    ,[Resume].ref.value(N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume";
        (/Resume/Name/Name.First)[1]', 'nvarchar(30)') AS [Name.First] 
    ,[Resume].ref.value(N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (/Resume/Name/Name.Middle)[1]', 'nvarchar(30)') AS [Name.Middle] 
    ,[Resume].ref.value(N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (/Resume/Name/Name.Last)[1]', 'nvarchar(30)') AS [Name.Last] 
    ,[Resume].ref.value(N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (/Resume/Name/Name.Suffix)[1]', 'nvarchar(30)') AS [Name.Suffix] 
    ,[Resume].ref.value(N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (/Resume/Skills)[1]', 'nvarchar(max)') AS [Skills] 
    ,[Resume].ref.value(N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Address/Addr.Type)[1]', 'nvarchar(30)') AS [Addr.Type]
    ,[Resume].ref.value(N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Address/Addr.Location/Location/Loc.CountryRegion)[1]', 'nvarchar(100)') AS [Addr.Loc.CountryRegion]
    ,[Resume].ref.value(N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Address/Addr.Location/Location/Loc.State)[1]', 'nvarchar(100)') AS [Addr.Loc.State]
    ,[Resume].ref.value(N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Address/Addr.Location/Location/Loc.City)[1]', 'nvarchar(100)') AS [Addr.Loc.City]
    ,[Resume].ref.value(N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Address/Addr.PostalCode)[1]', 'nvarchar(20)') AS [Addr.PostalCode]
    ,[Resume].ref.value(N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (/Resume/EMail)[1]', 'nvarchar(max)') AS [EMail] 
    ,[Resume].ref.value(N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (/Resume/WebSite)[1]', 'nvarchar(max)') AS [WebSite] 
    ,jc.[ModifiedDate] 
FROM [HumanResources].[JobCandidate] jc 
CROSS APPLY jc.[Resume].nodes(N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
    /Resume') AS Resume(ref);
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Job candidate names and resumes.' , @level0type=N'SCHEMA',@level0name=N'HumanResources', @level1type=N'VIEW',@level1name=N'vJobCandidate'
GO
/****** Object:  View [Production].[vProductAndDescription]    Script Date: 11/22/2013 20:49:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [Production].[vProductAndDescription] 
WITH SCHEMABINDING 
AS 
-- View (indexed or standard) to display products and product descriptions by language.
SELECT 
    p.[ProductID] 
    ,p.[Name] 
    ,pm.[Name] AS [ProductModel] 
    ,pmx.[CultureID] 
    ,pd.[Description] 
FROM [Production].[Product] p 
    INNER JOIN [Production].[ProductModel] pm 
    ON p.[ProductModelID] = pm.[ProductModelID] 
    INNER JOIN [Production].[ProductModelProductDescriptionCulture] pmx 
    ON pm.[ProductModelID] = pmx.[ProductModelID] 
    INNER JOIN [Production].[ProductDescription] pd 
    ON pmx.[ProductDescriptionID] = pd.[ProductDescriptionID];
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Clustered index on the view vProductAndDescription.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'VIEW',@level1name=N'vProductAndDescription', @level2type=N'INDEX',@level2name=N'IX_vProductAndDescription'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Product names and descriptions. Product descriptions are provided in multiple languages.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'VIEW',@level1name=N'vProductAndDescription'
GO
/****** Object:  Table [Purchasing].[ProductVendor]    Script Date: 11/22/2013 20:49:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Purchasing].[ProductVendor](
	[ProductID] [int] NOT NULL,
	[BusinessEntityID] [int] NOT NULL,
	[AverageLeadTime] [int] NOT NULL,
	[StandardPrice] [money] NOT NULL,
	[LastReceiptCost] [money] NULL,
	[LastReceiptDate] [datetime] NULL,
	[MinOrderQty] [int] NOT NULL,
	[MaxOrderQty] [int] NOT NULL,
	[OnOrderQty] [int] NULL,
	[UnitMeasureCode] [nchar](3) NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_ProductVendor_ProductID_BusinessEntityID] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC,
	[BusinessEntityID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key. Foreign key to Product.ProductID.' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'ProductVendor', @level2type=N'COLUMN',@level2name=N'ProductID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key. Foreign key to Vendor.BusinessEntityID.' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'ProductVendor', @level2type=N'COLUMN',@level2name=N'BusinessEntityID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The average span of time (in days) between placing an order with the vendor and receiving the purchased product.' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'ProductVendor', @level2type=N'COLUMN',@level2name=N'AverageLeadTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The vendor''s usual selling price.' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'ProductVendor', @level2type=N'COLUMN',@level2name=N'StandardPrice'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The selling price when last purchased.' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'ProductVendor', @level2type=N'COLUMN',@level2name=N'LastReceiptCost'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date the product was last received by the vendor.' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'ProductVendor', @level2type=N'COLUMN',@level2name=N'LastReceiptDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The maximum quantity that should be ordered.' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'ProductVendor', @level2type=N'COLUMN',@level2name=N'MinOrderQty'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The minimum quantity that should be ordered.' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'ProductVendor', @level2type=N'COLUMN',@level2name=N'MaxOrderQty'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The quantity currently on order.' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'ProductVendor', @level2type=N'COLUMN',@level2name=N'OnOrderQty'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The product''s unit of measure.' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'ProductVendor', @level2type=N'COLUMN',@level2name=N'UnitMeasureCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'ProductVendor', @level2type=N'COLUMN',@level2name=N'ModifiedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Cross-reference table mapping vendors with the products they supply.' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'ProductVendor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key (clustered) constraint' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'ProductVendor', @level2type=N'CONSTRAINT',@level2name=N'PK_ProductVendor_ProductID_BusinessEntityID'
GO
/****** Object:  View [Person].[vStateProvinceCountryRegion]    Script Date: 11/22/2013 20:49:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [Person].[vStateProvinceCountryRegion] 
WITH SCHEMABINDING 
AS 
SELECT 
    sp.[StateProvinceID] 
    ,sp.[StateProvinceCode] 
    ,sp.[IsOnlyStateProvinceFlag] 
    ,sp.[Name] AS [StateProvinceName] 
    ,sp.[TerritoryID] 
    ,cr.[CountryRegionCode] 
    ,cr.[Name] AS [CountryRegionName]
FROM [Person].[StateProvince] sp 
    INNER JOIN [Person].[CountryRegion] cr 
    ON sp.[CountryRegionCode] = cr.[CountryRegionCode];
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Clustered index on the view vStateProvinceCountryRegion.' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'VIEW',@level1name=N'vStateProvinceCountryRegion', @level2type=N'INDEX',@level2name=N'IX_vStateProvinceCountryRegion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Joins StateProvince table with CountryRegion table.' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'VIEW',@level1name=N'vStateProvinceCountryRegion'
GO
/****** Object:  View [Sales].[vStoreWithDemographics]    Script Date: 11/22/2013 20:49:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [Sales].[vStoreWithDemographics] AS 
SELECT 
    s.[BusinessEntityID] 
    ,s.[Name] 
    ,s.[Demographics].value('declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey"; 
        (/StoreSurvey/AnnualSales)[1]', 'money') AS [AnnualSales] 
    ,s.[Demographics].value('declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey"; 
        (/StoreSurvey/AnnualRevenue)[1]', 'money') AS [AnnualRevenue] 
    ,s.[Demographics].value('declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey"; 
        (/StoreSurvey/BankName)[1]', 'nvarchar(50)') AS [BankName] 
    ,s.[Demographics].value('declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey"; 
        (/StoreSurvey/BusinessType)[1]', 'nvarchar(5)') AS [BusinessType] 
    ,s.[Demographics].value('declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey"; 
        (/StoreSurvey/YearOpened)[1]', 'integer') AS [YearOpened] 
    ,s.[Demographics].value('declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey"; 
        (/StoreSurvey/Specialty)[1]', 'nvarchar(50)') AS [Specialty] 
    ,s.[Demographics].value('declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey"; 
        (/StoreSurvey/SquareFeet)[1]', 'integer') AS [SquareFeet] 
    ,s.[Demographics].value('declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey"; 
        (/StoreSurvey/Brands)[1]', 'nvarchar(30)') AS [Brands] 
    ,s.[Demographics].value('declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey"; 
        (/StoreSurvey/Internet)[1]', 'nvarchar(30)') AS [Internet] 
    ,s.[Demographics].value('declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey"; 
        (/StoreSurvey/NumberEmployees)[1]', 'integer') AS [NumberEmployees] 
FROM [Sales].[Store] s;
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Stores (including demographics) that sell Adventure Works Cycles products to consumers.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'VIEW',@level1name=N'vStoreWithDemographics'
GO
/****** Object:  View [Sales].[vStoreWithContacts]    Script Date: 11/22/2013 20:49:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [Sales].[vStoreWithContacts] AS 
SELECT 
    s.[BusinessEntityID] 
    ,s.[Name] 
    ,ct.[Name] AS [ContactType] 
    ,p.[Title] 
    ,p.[FirstName] 
    ,p.[MiddleName] 
    ,p.[LastName] 
    ,p.[Suffix] 
    ,pp.[PhoneNumber] 
	,pnt.[Name] AS [PhoneNumberType]
    ,ea.[EmailAddress] 
    ,p.[EmailPromotion] 
FROM [Sales].[Store] s
    INNER JOIN [Person].[BusinessEntityContact] bec 
    ON bec.[BusinessEntityID] = s.[BusinessEntityID]
	INNER JOIN [Person].[ContactType] ct
	ON ct.[ContactTypeID] = bec.[ContactTypeID]
	INNER JOIN [Person].[Person] p
	ON p.[BusinessEntityID] = bec.[PersonID]
	LEFT OUTER JOIN [Person].[EmailAddress] ea
	ON ea.[BusinessEntityID] = p.[BusinessEntityID]
	LEFT OUTER JOIN [Person].[PersonPhone] pp
	ON pp.[BusinessEntityID] = p.[BusinessEntityID]
	LEFT OUTER JOIN [Person].[PhoneNumberType] pnt
	ON pnt.[PhoneNumberTypeID] = pp.[PhoneNumberTypeID];
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Stores (including store contacts) that sell Adventure Works Cycles products to consumers.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'VIEW',@level1name=N'vStoreWithContacts'
GO
/****** Object:  Table [Production].[WorkOrder]    Script Date: 11/22/2013 20:49:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Production].[WorkOrder](
	[WorkOrderID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NOT NULL,
	[OrderQty] [int] NOT NULL,
	[StockedQty]  AS (isnull([OrderQty]-[ScrappedQty],(0))),
	[ScrappedQty] [smallint] NOT NULL,
	[StartDate] [datetime] NOT NULL,
	[EndDate] [datetime] NULL,
	[DueDate] [datetime] NOT NULL,
	[ScrapReasonID] [smallint] NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_WorkOrder_WorkOrderID] PRIMARY KEY CLUSTERED 
(
	[WorkOrderID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key for WorkOrder records.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'WorkOrder', @level2type=N'COLUMN',@level2name=N'WorkOrderID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Product identification number. Foreign key to Product.ProductID.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'WorkOrder', @level2type=N'COLUMN',@level2name=N'ProductID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Product quantity to build.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'WorkOrder', @level2type=N'COLUMN',@level2name=N'OrderQty'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Quantity built and put in inventory.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'WorkOrder', @level2type=N'COLUMN',@level2name=N'StockedQty'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Quantity that failed inspection.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'WorkOrder', @level2type=N'COLUMN',@level2name=N'ScrappedQty'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Work order start date.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'WorkOrder', @level2type=N'COLUMN',@level2name=N'StartDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Work order end date.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'WorkOrder', @level2type=N'COLUMN',@level2name=N'EndDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Work order due date.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'WorkOrder', @level2type=N'COLUMN',@level2name=N'DueDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Reason for inspection failure.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'WorkOrder', @level2type=N'COLUMN',@level2name=N'ScrapReasonID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'WorkOrder', @level2type=N'COLUMN',@level2name=N'ModifiedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Manufacturing work orders.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'WorkOrder'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key (clustered) constraint' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'WorkOrder', @level2type=N'CONSTRAINT',@level2name=N'PK_WorkOrder_WorkOrderID'
GO
/****** Object:  Table [Sales].[Customer]    Script Date: 11/22/2013 20:49:41 ******/
SET ARITHABORT ON
GO
SET CONCAT_NULL_YIELDS_NULL ON
GO
SET ANSI_NULLS ON
GO
SET ANSI_PADDING ON
GO
SET ANSI_WARNINGS ON
GO
SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
SET ARITHABORT ON
GO
CREATE TABLE [Sales].[Customer](
	[CustomerID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[PersonID] [int] NULL,
	[StoreID] [int] NULL,
	[TerritoryID] [int] NULL,
	[AccountNumber]  AS (isnull('AW'+[dbo].[ufnLeadingZeros]([CustomerID]),'')),
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Customer_CustomerID] PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'CustomerID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key to Person.BusinessEntityID' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'PersonID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key to Store.BusinessEntityID' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'StoreID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ID of the territory in which the customer is located. Foreign key to SalesTerritory.SalesTerritoryID.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'TerritoryID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Unique number identifying the customer assigned by the accounting system.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'AccountNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'rowguid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'COLUMN',@level2name=N'ModifiedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Current customer information. Also see the Person and Store tables.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'Customer'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key (clustered) constraint' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'CONSTRAINT',@level2name=N'PK_Customer_CustomerID'
GO
/****** Object:  Table [Person].[BusinessEntityAddress]    Script Date: 11/22/2013 20:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Person].[BusinessEntityAddress](
	[BusinessEntityID] [int] NOT NULL,
	[AddressID] [int] NOT NULL,
	[AddressTypeID] [int] NOT NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_BusinessEntityAddress_BusinessEntityID_AddressID_AddressTypeID] PRIMARY KEY CLUSTERED 
(
	[BusinessEntityID] ASC,
	[AddressID] ASC,
	[AddressTypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key. Foreign key to BusinessEntity.BusinessEntityID.' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'BusinessEntityAddress', @level2type=N'COLUMN',@level2name=N'BusinessEntityID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key. Foreign key to Address.AddressID.' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'BusinessEntityAddress', @level2type=N'COLUMN',@level2name=N'AddressID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key. Foreign key to AddressType.AddressTypeID.' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'BusinessEntityAddress', @level2type=N'COLUMN',@level2name=N'AddressTypeID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'BusinessEntityAddress', @level2type=N'COLUMN',@level2name=N'rowguid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'BusinessEntityAddress', @level2type=N'COLUMN',@level2name=N'ModifiedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Cross-reference table mapping customers, vendors, and employees to their addresses.' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'BusinessEntityAddress'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key (clustered) constraint' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'BusinessEntityAddress', @level2type=N'CONSTRAINT',@level2name=N'PK_BusinessEntityAddress_BusinessEntityID_AddressID_AddressTypeID'
GO
/****** Object:  Table [Purchasing].[PurchaseOrderDetail]    Script Date: 11/22/2013 20:49:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Purchasing].[PurchaseOrderDetail](
	[PurchaseOrderID] [int] NOT NULL,
	[PurchaseOrderDetailID] [int] IDENTITY(1,1) NOT NULL,
	[DueDate] [datetime] NOT NULL,
	[OrderQty] [smallint] NOT NULL,
	[ProductID] [int] NOT NULL,
	[UnitPrice] [money] NOT NULL,
	[LineTotal]  AS (isnull([OrderQty]*[UnitPrice],(0.00))),
	[ReceivedQty] [decimal](8, 2) NOT NULL,
	[RejectedQty] [decimal](8, 2) NOT NULL,
	[StockedQty]  AS (isnull([ReceivedQty]-[RejectedQty],(0.00))),
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_PurchaseOrderDetail_PurchaseOrderID_PurchaseOrderDetailID] PRIMARY KEY CLUSTERED 
(
	[PurchaseOrderID] ASC,
	[PurchaseOrderDetailID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key. Foreign key to PurchaseOrderHeader.PurchaseOrderID.' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'PurchaseOrderDetail', @level2type=N'COLUMN',@level2name=N'PurchaseOrderID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key. One line number per purchased product.' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'PurchaseOrderDetail', @level2type=N'COLUMN',@level2name=N'PurchaseOrderDetailID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date the product is expected to be received.' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'PurchaseOrderDetail', @level2type=N'COLUMN',@level2name=N'DueDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Quantity ordered.' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'PurchaseOrderDetail', @level2type=N'COLUMN',@level2name=N'OrderQty'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Product identification number. Foreign key to Product.ProductID.' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'PurchaseOrderDetail', @level2type=N'COLUMN',@level2name=N'ProductID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Vendor''s selling price of a single product.' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'PurchaseOrderDetail', @level2type=N'COLUMN',@level2name=N'UnitPrice'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Per product subtotal. Computed as OrderQty * UnitPrice.' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'PurchaseOrderDetail', @level2type=N'COLUMN',@level2name=N'LineTotal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Quantity actually received from the vendor.' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'PurchaseOrderDetail', @level2type=N'COLUMN',@level2name=N'ReceivedQty'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Quantity rejected during inspection.' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'PurchaseOrderDetail', @level2type=N'COLUMN',@level2name=N'RejectedQty'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Quantity accepted into inventory. Computed as ReceivedQty - RejectedQty.' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'PurchaseOrderDetail', @level2type=N'COLUMN',@level2name=N'StockedQty'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'PurchaseOrderDetail', @level2type=N'COLUMN',@level2name=N'ModifiedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Individual products associated with a specific purchase order. See PurchaseOrderHeader.' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'PurchaseOrderDetail'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key (clustered) constraint' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'PurchaseOrderDetail', @level2type=N'CONSTRAINT',@level2name=N'PK_PurchaseOrderDetail_PurchaseOrderID_PurchaseOrderDetailID'
GO
/****** Object:  Table [Sales].[SalesOrderHeader]    Script Date: 11/22/2013 20:49:41 ******/
SET ARITHABORT ON
GO
SET CONCAT_NULL_YIELDS_NULL ON
GO
SET ANSI_NULLS ON
GO
SET ANSI_PADDING ON
GO
SET ANSI_WARNINGS ON
GO
SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
SET ARITHABORT ON
GO
CREATE TABLE [Sales].[SalesOrderHeader](
	[SalesOrderID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[RevisionNumber] [tinyint] NOT NULL,
	[OrderDate] [datetime] NOT NULL,
	[DueDate] [datetime] NOT NULL,
	[ShipDate] [datetime] NULL,
	[Status] [tinyint] NOT NULL,
	[OnlineOrderFlag] [dbo].[Flag] NOT NULL,
	[SalesOrderNumber]  AS (isnull(N'SO'+CONVERT([nvarchar](23),[SalesOrderID],0),N'*** ERROR ***')),
	[PurchaseOrderNumber] [dbo].[OrderNumber] NULL,
	[AccountNumber] [dbo].[AccountNumber] NULL,
	[CustomerID] [int] NOT NULL,
	[SalesPersonID] [int] NULL,
	[TerritoryID] [int] NULL,
	[BillToAddressID] [int] NOT NULL,
	[ShipToAddressID] [int] NOT NULL,
	[ShipMethodID] [int] NOT NULL,
	[CreditCardID] [int] NULL,
	[CreditCardApprovalCode] [varchar](15) NULL,
	[CurrencyRateID] [int] NULL,
	[SubTotal] [money] NOT NULL,
	[TaxAmt] [money] NOT NULL,
	[Freight] [money] NOT NULL,
	[TotalDue]  AS (isnull(([SubTotal]+[TaxAmt])+[Freight],(0))),
	[Comment] [nvarchar](128) NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_SalesOrderHeader_SalesOrderID] PRIMARY KEY CLUSTERED 
(
	[SalesOrderID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesOrderHeader', @level2type=N'COLUMN',@level2name=N'SalesOrderID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Incremental number to track changes to the sales order over time.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesOrderHeader', @level2type=N'COLUMN',@level2name=N'RevisionNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Dates the sales order was created.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesOrderHeader', @level2type=N'COLUMN',@level2name=N'OrderDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date the order is due to the customer.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesOrderHeader', @level2type=N'COLUMN',@level2name=N'DueDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date the order was shipped to the customer.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesOrderHeader', @level2type=N'COLUMN',@level2name=N'ShipDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Order current status. 1 = In process; 2 = Approved; 3 = Backordered; 4 = Rejected; 5 = Shipped; 6 = Cancelled' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesOrderHeader', @level2type=N'COLUMN',@level2name=N'Status'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0 = Order placed by sales person. 1 = Order placed online by customer.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesOrderHeader', @level2type=N'COLUMN',@level2name=N'OnlineOrderFlag'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Unique sales order identification number.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesOrderHeader', @level2type=N'COLUMN',@level2name=N'SalesOrderNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Customer purchase order number reference. ' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesOrderHeader', @level2type=N'COLUMN',@level2name=N'PurchaseOrderNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Financial accounting number reference.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesOrderHeader', @level2type=N'COLUMN',@level2name=N'AccountNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Customer identification number. Foreign key to Customer.BusinessEntityID.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesOrderHeader', @level2type=N'COLUMN',@level2name=N'CustomerID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Sales person who created the sales order. Foreign key to SalesPerson.BusinessEntityID.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesOrderHeader', @level2type=N'COLUMN',@level2name=N'SalesPersonID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Territory in which the sale was made. Foreign key to SalesTerritory.SalesTerritoryID.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesOrderHeader', @level2type=N'COLUMN',@level2name=N'TerritoryID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Customer billing address. Foreign key to Address.AddressID.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesOrderHeader', @level2type=N'COLUMN',@level2name=N'BillToAddressID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Customer shipping address. Foreign key to Address.AddressID.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesOrderHeader', @level2type=N'COLUMN',@level2name=N'ShipToAddressID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Shipping method. Foreign key to ShipMethod.ShipMethodID.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesOrderHeader', @level2type=N'COLUMN',@level2name=N'ShipMethodID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Credit card identification number. Foreign key to CreditCard.CreditCardID.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesOrderHeader', @level2type=N'COLUMN',@level2name=N'CreditCardID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Approval code provided by the credit card company.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesOrderHeader', @level2type=N'COLUMN',@level2name=N'CreditCardApprovalCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Currency exchange rate used. Foreign key to CurrencyRate.CurrencyRateID.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesOrderHeader', @level2type=N'COLUMN',@level2name=N'CurrencyRateID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Sales subtotal. Computed as SUM(SalesOrderDetail.LineTotal)for the appropriate SalesOrderID.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesOrderHeader', @level2type=N'COLUMN',@level2name=N'SubTotal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tax amount.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesOrderHeader', @level2type=N'COLUMN',@level2name=N'TaxAmt'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Shipping cost.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesOrderHeader', @level2type=N'COLUMN',@level2name=N'Freight'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Total due from customer. Computed as Subtotal + TaxAmt + Freight.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesOrderHeader', @level2type=N'COLUMN',@level2name=N'TotalDue'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Sales representative comments.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesOrderHeader', @level2type=N'COLUMN',@level2name=N'Comment'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesOrderHeader', @level2type=N'COLUMN',@level2name=N'rowguid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesOrderHeader', @level2type=N'COLUMN',@level2name=N'ModifiedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'General sales order information.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesOrderHeader'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key (clustered) constraint' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesOrderHeader', @level2type=N'CONSTRAINT',@level2name=N'PK_SalesOrderHeader_SalesOrderID'
GO
/****** Object:  View [Sales].[vSalesPerson]    Script Date: 11/22/2013 20:49:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [Sales].[vSalesPerson] 
AS 
SELECT 
    s.[BusinessEntityID]
    ,p.[Title]
    ,p.[FirstName]
    ,p.[MiddleName]
    ,p.[LastName]
    ,p.[Suffix]
    ,e.[JobTitle]
    ,pp.[PhoneNumber]
	,pnt.[Name] AS [PhoneNumberType]
    ,ea.[EmailAddress]
    ,p.[EmailPromotion]
    ,a.[AddressLine1]
    ,a.[AddressLine2]
    ,a.[City]
    ,[StateProvinceName] = sp.[Name]
    ,a.[PostalCode]
    ,[CountryRegionName] = cr.[Name]
    ,[TerritoryName] = st.[Name]
    ,[TerritoryGroup] = st.[Group]
    ,s.[SalesQuota]
    ,s.[SalesYTD]
    ,s.[SalesLastYear]
FROM [Sales].[SalesPerson] s
    INNER JOIN [HumanResources].[Employee] e 
    ON e.[BusinessEntityID] = s.[BusinessEntityID]
	INNER JOIN [Person].[Person] p
	ON p.[BusinessEntityID] = s.[BusinessEntityID]
    INNER JOIN [Person].[BusinessEntityAddress] bea 
    ON bea.[BusinessEntityID] = s.[BusinessEntityID] 
    INNER JOIN [Person].[Address] a 
    ON a.[AddressID] = bea.[AddressID]
    INNER JOIN [Person].[StateProvince] sp 
    ON sp.[StateProvinceID] = a.[StateProvinceID]
    INNER JOIN [Person].[CountryRegion] cr 
    ON cr.[CountryRegionCode] = sp.[CountryRegionCode]
    LEFT OUTER JOIN [Sales].[SalesTerritory] st 
    ON st.[TerritoryID] = s.[TerritoryID]
	LEFT OUTER JOIN [Person].[EmailAddress] ea
	ON ea.[BusinessEntityID] = p.[BusinessEntityID]
	LEFT OUTER JOIN [Person].[PersonPhone] pp
	ON pp.[BusinessEntityID] = p.[BusinessEntityID]
	LEFT OUTER JOIN [Person].[PhoneNumberType] pnt
	ON pnt.[PhoneNumberTypeID] = pp.[PhoneNumberTypeID];
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Sales representiatives (names and addresses) and their sales-related information.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'VIEW',@level1name=N'vSalesPerson'
GO
/****** Object:  View [Sales].[vIndividualCustomer]    Script Date: 11/22/2013 20:49:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [Sales].[vIndividualCustomer] 
AS 
SELECT 
    p.[BusinessEntityID]
    ,p.[Title]
    ,p.[FirstName]
    ,p.[MiddleName]
    ,p.[LastName]
    ,p.[Suffix]
    ,pp.[PhoneNumber]
	,pnt.[Name] AS [PhoneNumberType]
    ,ea.[EmailAddress]
    ,p.[EmailPromotion]
    ,at.[Name] AS [AddressType]
    ,a.[AddressLine1]
    ,a.[AddressLine2]
    ,a.[City]
    ,[StateProvinceName] = sp.[Name]
    ,a.[PostalCode]
    ,[CountryRegionName] = cr.[Name]
    ,p.[Demographics]
FROM [Person].[Person] p
    INNER JOIN [Person].[BusinessEntityAddress] bea 
    ON bea.[BusinessEntityID] = p.[BusinessEntityID] 
    INNER JOIN [Person].[Address] a 
    ON a.[AddressID] = bea.[AddressID]
    INNER JOIN [Person].[StateProvince] sp 
    ON sp.[StateProvinceID] = a.[StateProvinceID]
    INNER JOIN [Person].[CountryRegion] cr 
    ON cr.[CountryRegionCode] = sp.[CountryRegionCode]
    INNER JOIN [Person].[AddressType] at 
    ON at.[AddressTypeID] = bea.[AddressTypeID]
	INNER JOIN [Sales].[Customer] c
	ON c.[PersonID] = p.[BusinessEntityID]
	LEFT OUTER JOIN [Person].[EmailAddress] ea
	ON ea.[BusinessEntityID] = p.[BusinessEntityID]
	LEFT OUTER JOIN [Person].[PersonPhone] pp
	ON pp.[BusinessEntityID] = p.[BusinessEntityID]
	LEFT OUTER JOIN [Person].[PhoneNumberType] pnt
	ON pnt.[PhoneNumberTypeID] = pp.[PhoneNumberTypeID]
WHERE c.StoreID IS NULL;
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Individual customers (names and addresses) that purchase Adventure Works Cycles products online.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'VIEW',@level1name=N'vIndividualCustomer'
GO
/****** Object:  View [HumanResources].[vEmployee]    Script Date: 11/22/2013 20:49:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [HumanResources].[vEmployee] 
AS 
SELECT 
    e.[BusinessEntityID]
    ,p.[Title]
    ,p.[FirstName]
    ,p.[MiddleName]
    ,p.[LastName]
    ,p.[Suffix]
    ,e.[JobTitle]  
    ,pp.[PhoneNumber]
    ,pnt.[Name] AS [PhoneNumberType]
    ,ea.[EmailAddress]
    ,p.[EmailPromotion]
    ,a.[AddressLine1]
    ,a.[AddressLine2]
    ,a.[City]
    ,sp.[Name] AS [StateProvinceName] 
    ,a.[PostalCode]
    ,cr.[Name] AS [CountryRegionName] 
    ,p.[AdditionalContactInfo]
FROM [HumanResources].[Employee] e
	INNER JOIN [Person].[Person] p
	ON p.[BusinessEntityID] = e.[BusinessEntityID]
    INNER JOIN [Person].[BusinessEntityAddress] bea 
    ON bea.[BusinessEntityID] = e.[BusinessEntityID] 
    INNER JOIN [Person].[Address] a 
    ON a.[AddressID] = bea.[AddressID]
    INNER JOIN [Person].[StateProvince] sp 
    ON sp.[StateProvinceID] = a.[StateProvinceID]
    INNER JOIN [Person].[CountryRegion] cr 
    ON cr.[CountryRegionCode] = sp.[CountryRegionCode]
    LEFT OUTER JOIN [Person].[PersonPhone] pp
    ON pp.BusinessEntityID = p.[BusinessEntityID]
    LEFT OUTER JOIN [Person].[PhoneNumberType] pnt
    ON pp.[PhoneNumberTypeID] = pnt.[PhoneNumberTypeID]
    LEFT OUTER JOIN [Person].[EmailAddress] ea
    ON p.[BusinessEntityID] = ea.[BusinessEntityID];
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Employee names and addresses.' , @level0type=N'SCHEMA',@level0name=N'HumanResources', @level1type=N'VIEW',@level1name=N'vEmployee'
GO
/****** Object:  Table [Production].[WorkOrderRouting]    Script Date: 11/22/2013 20:49:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Production].[WorkOrderRouting](
	[WorkOrderID] [int] NOT NULL,
	[ProductID] [int] NOT NULL,
	[OperationSequence] [smallint] NOT NULL,
	[LocationID] [smallint] NOT NULL,
	[ScheduledStartDate] [datetime] NOT NULL,
	[ScheduledEndDate] [datetime] NOT NULL,
	[ActualStartDate] [datetime] NULL,
	[ActualEndDate] [datetime] NULL,
	[ActualResourceHrs] [decimal](9, 4) NULL,
	[PlannedCost] [money] NOT NULL,
	[ActualCost] [money] NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_WorkOrderRouting_WorkOrderID_ProductID_OperationSequence] PRIMARY KEY CLUSTERED 
(
	[WorkOrderID] ASC,
	[ProductID] ASC,
	[OperationSequence] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key. Foreign key to WorkOrder.WorkOrderID.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'WorkOrderRouting', @level2type=N'COLUMN',@level2name=N'WorkOrderID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key. Foreign key to Product.ProductID.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'WorkOrderRouting', @level2type=N'COLUMN',@level2name=N'ProductID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key. Indicates the manufacturing process sequence.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'WorkOrderRouting', @level2type=N'COLUMN',@level2name=N'OperationSequence'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Manufacturing location where the part is processed. Foreign key to Location.LocationID.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'WorkOrderRouting', @level2type=N'COLUMN',@level2name=N'LocationID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Planned manufacturing start date.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'WorkOrderRouting', @level2type=N'COLUMN',@level2name=N'ScheduledStartDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Planned manufacturing end date.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'WorkOrderRouting', @level2type=N'COLUMN',@level2name=N'ScheduledEndDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Actual start date.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'WorkOrderRouting', @level2type=N'COLUMN',@level2name=N'ActualStartDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Actual end date.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'WorkOrderRouting', @level2type=N'COLUMN',@level2name=N'ActualEndDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Number of manufacturing hours used.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'WorkOrderRouting', @level2type=N'COLUMN',@level2name=N'ActualResourceHrs'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Estimated manufacturing cost.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'WorkOrderRouting', @level2type=N'COLUMN',@level2name=N'PlannedCost'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Actual manufacturing cost.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'WorkOrderRouting', @level2type=N'COLUMN',@level2name=N'ActualCost'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'WorkOrderRouting', @level2type=N'COLUMN',@level2name=N'ModifiedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Work order details.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'WorkOrderRouting'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key (clustered) constraint' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'WorkOrderRouting', @level2type=N'CONSTRAINT',@level2name=N'PK_WorkOrderRouting_WorkOrderID_ProductID_OperationSequence'
GO
/****** Object:  View [Purchasing].[vVendorWithAddresses]    Script Date: 11/22/2013 20:49:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [Purchasing].[vVendorWithAddresses] AS 
SELECT 
    v.[BusinessEntityID]
    ,v.[Name]
    ,at.[Name] AS [AddressType]
    ,a.[AddressLine1] 
    ,a.[AddressLine2] 
    ,a.[City] 
    ,sp.[Name] AS [StateProvinceName] 
    ,a.[PostalCode] 
    ,cr.[Name] AS [CountryRegionName] 
FROM [Purchasing].[Vendor] v
    INNER JOIN [Person].[BusinessEntityAddress] bea 
    ON bea.[BusinessEntityID] = v.[BusinessEntityID] 
    INNER JOIN [Person].[Address] a 
    ON a.[AddressID] = bea.[AddressID]
    INNER JOIN [Person].[StateProvince] sp 
    ON sp.[StateProvinceID] = a.[StateProvinceID]
    INNER JOIN [Person].[CountryRegion] cr 
    ON cr.[CountryRegionCode] = sp.[CountryRegionCode]
    INNER JOIN [Person].[AddressType] at 
    ON at.[AddressTypeID] = bea.[AddressTypeID];
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Vendor (company) names and addresses .' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'VIEW',@level1name=N'vVendorWithAddresses'
GO
/****** Object:  View [Sales].[vStoreWithAddresses]    Script Date: 11/22/2013 20:49:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [Sales].[vStoreWithAddresses] AS 
SELECT 
    s.[BusinessEntityID] 
    ,s.[Name] 
    ,at.[Name] AS [AddressType]
    ,a.[AddressLine1] 
    ,a.[AddressLine2] 
    ,a.[City] 
    ,sp.[Name] AS [StateProvinceName] 
    ,a.[PostalCode] 
    ,cr.[Name] AS [CountryRegionName] 
FROM [Sales].[Store] s
    INNER JOIN [Person].[BusinessEntityAddress] bea 
    ON bea.[BusinessEntityID] = s.[BusinessEntityID] 
    INNER JOIN [Person].[Address] a 
    ON a.[AddressID] = bea.[AddressID]
    INNER JOIN [Person].[StateProvince] sp 
    ON sp.[StateProvinceID] = a.[StateProvinceID]
    INNER JOIN [Person].[CountryRegion] cr 
    ON cr.[CountryRegionCode] = sp.[CountryRegionCode]
    INNER JOIN [Person].[AddressType] at 
    ON at.[AddressTypeID] = bea.[AddressTypeID];
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Stores (including store addresses) that sell Adventure Works Cycles products to consumers.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'VIEW',@level1name=N'vStoreWithAddresses'
GO
/****** Object:  View [Sales].[vSalesPersonSalesByFiscalYears]    Script Date: 11/22/2013 20:49:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [Sales].[vSalesPersonSalesByFiscalYears] 
AS 
SELECT 
    pvt.[SalesPersonID]
    ,pvt.[FullName]
    ,pvt.[JobTitle]
    ,pvt.[SalesTerritory]
    ,pvt.[2002]
    ,pvt.[2003]
    ,pvt.[2004] 
FROM (SELECT 
        soh.[SalesPersonID]
        ,p.[FirstName] + ' ' + COALESCE(p.[MiddleName], '') + ' ' + p.[LastName] AS [FullName]
        ,e.[JobTitle]
        ,st.[Name] AS [SalesTerritory]
        ,soh.[SubTotal]
        ,YEAR(DATEADD(m, 6, soh.[OrderDate])) AS [FiscalYear] 
    FROM [Sales].[SalesPerson] sp 
        INNER JOIN [Sales].[SalesOrderHeader] soh 
        ON sp.[BusinessEntityID] = soh.[SalesPersonID]
        INNER JOIN [Sales].[SalesTerritory] st 
        ON sp.[TerritoryID] = st.[TerritoryID] 
        INNER JOIN [HumanResources].[Employee] e 
        ON soh.[SalesPersonID] = e.[BusinessEntityID] 
		INNER JOIN [Person].[Person] p
		ON p.[BusinessEntityID] = sp.[BusinessEntityID]
	 ) AS soh 
PIVOT 
(
    SUM([SubTotal]) 
    FOR [FiscalYear] 
    IN ([2002], [2003], [2004])
) AS pvt;
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Uses PIVOT to return aggregated sales information for each sales representative.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'VIEW',@level1name=N'vSalesPersonSalesByFiscalYears'
GO
/****** Object:  Table [Sales].[SalesOrderHeaderSalesReason]    Script Date: 11/22/2013 20:49:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Sales].[SalesOrderHeaderSalesReason](
	[SalesOrderID] [int] NOT NULL,
	[SalesReasonID] [int] NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_SalesOrderHeaderSalesReason_SalesOrderID_SalesReasonID] PRIMARY KEY CLUSTERED 
(
	[SalesOrderID] ASC,
	[SalesReasonID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key. Foreign key to SalesOrderHeader.SalesOrderID.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesOrderHeaderSalesReason', @level2type=N'COLUMN',@level2name=N'SalesOrderID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key. Foreign key to SalesReason.SalesReasonID.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesOrderHeaderSalesReason', @level2type=N'COLUMN',@level2name=N'SalesReasonID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesOrderHeaderSalesReason', @level2type=N'COLUMN',@level2name=N'ModifiedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Cross-reference table mapping sales orders to sales reason codes.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesOrderHeaderSalesReason'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key (clustered) constraint' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesOrderHeaderSalesReason', @level2type=N'CONSTRAINT',@level2name=N'PK_SalesOrderHeaderSalesReason_SalesOrderID_SalesReasonID'
GO
/****** Object:  Table [Sales].[SalesOrderDetail]    Script Date: 11/22/2013 20:49:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Sales].[SalesOrderDetail](
	[SalesOrderID] [int] NOT NULL,
	[SalesOrderDetailID] [int] IDENTITY(1,1) NOT NULL,
	[CarrierTrackingNumber] [nvarchar](25) NULL,
	[OrderQty] [smallint] NOT NULL,
	[ProductID] [int] NOT NULL,
	[SpecialOfferID] [int] NOT NULL,
	[UnitPrice] [money] NOT NULL,
	[UnitPriceDiscount] [money] NOT NULL,
	[LineTotal]  AS (isnull(([UnitPrice]*((1.0)-[UnitPriceDiscount]))*[OrderQty],(0.0))),
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_SalesOrderDetail_SalesOrderID_SalesOrderDetailID] PRIMARY KEY CLUSTERED 
(
	[SalesOrderID] ASC,
	[SalesOrderDetailID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key. Foreign key to SalesOrderHeader.SalesOrderID.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesOrderDetail', @level2type=N'COLUMN',@level2name=N'SalesOrderID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key. One incremental unique number per product sold.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesOrderDetail', @level2type=N'COLUMN',@level2name=N'SalesOrderDetailID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Shipment tracking number supplied by the shipper.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesOrderDetail', @level2type=N'COLUMN',@level2name=N'CarrierTrackingNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Quantity ordered per product.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesOrderDetail', @level2type=N'COLUMN',@level2name=N'OrderQty'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Product sold to customer. Foreign key to Product.ProductID.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesOrderDetail', @level2type=N'COLUMN',@level2name=N'ProductID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Promotional code. Foreign key to SpecialOffer.SpecialOfferID.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesOrderDetail', @level2type=N'COLUMN',@level2name=N'SpecialOfferID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Selling price of a single product.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesOrderDetail', @level2type=N'COLUMN',@level2name=N'UnitPrice'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Discount amount.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesOrderDetail', @level2type=N'COLUMN',@level2name=N'UnitPriceDiscount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Per product subtotal. Computed as UnitPrice * (1 - UnitPriceDiscount) * OrderQty.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesOrderDetail', @level2type=N'COLUMN',@level2name=N'LineTotal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesOrderDetail', @level2type=N'COLUMN',@level2name=N'rowguid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesOrderDetail', @level2type=N'COLUMN',@level2name=N'ModifiedDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Individual products associated with a specific sales order. See SalesOrderHeader.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesOrderDetail'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key (clustered) constraint' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesOrderDetail', @level2type=N'CONSTRAINT',@level2name=N'PK_SalesOrderDetail_SalesOrderID_SalesOrderDetailID'
GO
/****** Object:  Default [DF_AWBuildVersion_ModifiedDate]    Script Date: 11/22/2013 20:49:40 ******/
ALTER TABLE [dbo].[AWBuildVersion] ADD  CONSTRAINT [DF_AWBuildVersion_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of GETDATE()' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AWBuildVersion', @level2type=N'CONSTRAINT',@level2name=N'DF_AWBuildVersion_ModifiedDate'
GO
/****** Object:  Default [DF_ErrorLog_ErrorTime]    Script Date: 11/22/2013 20:49:40 ******/
ALTER TABLE [dbo].[ErrorLog] ADD  CONSTRAINT [DF_ErrorLog_ErrorTime]  DEFAULT (getdate()) FOR [ErrorTime]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of GETDATE()' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ErrorLog', @level2type=N'CONSTRAINT',@level2name=N'DF_ErrorLog_ErrorTime'
GO
/****** Object:  Default [DF_Department_ModifiedDate]    Script Date: 11/22/2013 20:49:40 ******/
ALTER TABLE [HumanResources].[Department] ADD  CONSTRAINT [DF_Department_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of GETDATE()' , @level0type=N'SCHEMA',@level0name=N'HumanResources', @level1type=N'TABLE',@level1name=N'Department', @level2type=N'CONSTRAINT',@level2name=N'DF_Department_ModifiedDate'
GO
/****** Object:  Default [DF_Employee_SalariedFlag]    Script Date: 11/22/2013 20:49:40 ******/
ALTER TABLE [HumanResources].[Employee] ADD  CONSTRAINT [DF_Employee_SalariedFlag]  DEFAULT ((1)) FOR [SalariedFlag]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of 1 (TRUE)' , @level0type=N'SCHEMA',@level0name=N'HumanResources', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'CONSTRAINT',@level2name=N'DF_Employee_SalariedFlag'
GO
/****** Object:  Default [DF_Employee_VacationHours]    Script Date: 11/22/2013 20:49:40 ******/
ALTER TABLE [HumanResources].[Employee] ADD  CONSTRAINT [DF_Employee_VacationHours]  DEFAULT ((0)) FOR [VacationHours]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of 0' , @level0type=N'SCHEMA',@level0name=N'HumanResources', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'CONSTRAINT',@level2name=N'DF_Employee_VacationHours'
GO
/****** Object:  Default [DF_Employee_SickLeaveHours]    Script Date: 11/22/2013 20:49:40 ******/
ALTER TABLE [HumanResources].[Employee] ADD  CONSTRAINT [DF_Employee_SickLeaveHours]  DEFAULT ((0)) FOR [SickLeaveHours]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of 0' , @level0type=N'SCHEMA',@level0name=N'HumanResources', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'CONSTRAINT',@level2name=N'DF_Employee_SickLeaveHours'
GO
/****** Object:  Default [DF_Employee_CurrentFlag]    Script Date: 11/22/2013 20:49:40 ******/
ALTER TABLE [HumanResources].[Employee] ADD  CONSTRAINT [DF_Employee_CurrentFlag]  DEFAULT ((1)) FOR [CurrentFlag]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of 1' , @level0type=N'SCHEMA',@level0name=N'HumanResources', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'CONSTRAINT',@level2name=N'DF_Employee_CurrentFlag'
GO
/****** Object:  Default [DF_Employee_rowguid]    Script Date: 11/22/2013 20:49:40 ******/
ALTER TABLE [HumanResources].[Employee] ADD  CONSTRAINT [DF_Employee_rowguid]  DEFAULT (newid()) FOR [rowguid]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of NEWID()' , @level0type=N'SCHEMA',@level0name=N'HumanResources', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'CONSTRAINT',@level2name=N'DF_Employee_rowguid'
GO
/****** Object:  Default [DF_Employee_ModifiedDate]    Script Date: 11/22/2013 20:49:40 ******/
ALTER TABLE [HumanResources].[Employee] ADD  CONSTRAINT [DF_Employee_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of GETDATE()' , @level0type=N'SCHEMA',@level0name=N'HumanResources', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'CONSTRAINT',@level2name=N'DF_Employee_ModifiedDate'
GO
/****** Object:  Default [DF_EmployeeDepartmentHistory_ModifiedDate]    Script Date: 11/22/2013 20:49:40 ******/
ALTER TABLE [HumanResources].[EmployeeDepartmentHistory] ADD  CONSTRAINT [DF_EmployeeDepartmentHistory_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of GETDATE()' , @level0type=N'SCHEMA',@level0name=N'HumanResources', @level1type=N'TABLE',@level1name=N'EmployeeDepartmentHistory', @level2type=N'CONSTRAINT',@level2name=N'DF_EmployeeDepartmentHistory_ModifiedDate'
GO
/****** Object:  Default [DF_EmployeePayHistory_ModifiedDate]    Script Date: 11/22/2013 20:49:40 ******/
ALTER TABLE [HumanResources].[EmployeePayHistory] ADD  CONSTRAINT [DF_EmployeePayHistory_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of GETDATE()' , @level0type=N'SCHEMA',@level0name=N'HumanResources', @level1type=N'TABLE',@level1name=N'EmployeePayHistory', @level2type=N'CONSTRAINT',@level2name=N'DF_EmployeePayHistory_ModifiedDate'
GO
/****** Object:  Default [DF_JobCandidate_ModifiedDate]    Script Date: 11/22/2013 20:49:40 ******/
ALTER TABLE [HumanResources].[JobCandidate] ADD  CONSTRAINT [DF_JobCandidate_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of GETDATE()' , @level0type=N'SCHEMA',@level0name=N'HumanResources', @level1type=N'TABLE',@level1name=N'JobCandidate', @level2type=N'CONSTRAINT',@level2name=N'DF_JobCandidate_ModifiedDate'
GO
/****** Object:  Default [DF_Shift_ModifiedDate]    Script Date: 11/22/2013 20:49:40 ******/
ALTER TABLE [HumanResources].[Shift] ADD  CONSTRAINT [DF_Shift_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of GETDATE()' , @level0type=N'SCHEMA',@level0name=N'HumanResources', @level1type=N'TABLE',@level1name=N'Shift', @level2type=N'CONSTRAINT',@level2name=N'DF_Shift_ModifiedDate'
GO
/****** Object:  Default [DF_Address_rowguid]    Script Date: 11/22/2013 20:49:40 ******/
ALTER TABLE [Person].[Address] ADD  CONSTRAINT [DF_Address_rowguid]  DEFAULT (newid()) FOR [rowguid]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of NEWID()' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'Address', @level2type=N'CONSTRAINT',@level2name=N'DF_Address_rowguid'
GO
/****** Object:  Default [DF_Address_ModifiedDate]    Script Date: 11/22/2013 20:49:40 ******/
ALTER TABLE [Person].[Address] ADD  CONSTRAINT [DF_Address_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of GETDATE()' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'Address', @level2type=N'CONSTRAINT',@level2name=N'DF_Address_ModifiedDate'
GO
/****** Object:  Default [DF_AddressType_rowguid]    Script Date: 11/22/2013 20:49:40 ******/
ALTER TABLE [Person].[AddressType] ADD  CONSTRAINT [DF_AddressType_rowguid]  DEFAULT (newid()) FOR [rowguid]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of NEWID()' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'AddressType', @level2type=N'CONSTRAINT',@level2name=N'DF_AddressType_rowguid'
GO
/****** Object:  Default [DF_AddressType_ModifiedDate]    Script Date: 11/22/2013 20:49:40 ******/
ALTER TABLE [Person].[AddressType] ADD  CONSTRAINT [DF_AddressType_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of GETDATE()' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'AddressType', @level2type=N'CONSTRAINT',@level2name=N'DF_AddressType_ModifiedDate'
GO
/****** Object:  Default [DF_BusinessEntity_rowguid]    Script Date: 11/22/2013 20:49:40 ******/
ALTER TABLE [Person].[BusinessEntity] ADD  CONSTRAINT [DF_BusinessEntity_rowguid]  DEFAULT (newid()) FOR [rowguid]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of NEWID()' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'BusinessEntity', @level2type=N'CONSTRAINT',@level2name=N'DF_BusinessEntity_rowguid'
GO
/****** Object:  Default [DF_BusinessEntity_ModifiedDate]    Script Date: 11/22/2013 20:49:40 ******/
ALTER TABLE [Person].[BusinessEntity] ADD  CONSTRAINT [DF_BusinessEntity_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of GETDATE()' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'BusinessEntity', @level2type=N'CONSTRAINT',@level2name=N'DF_BusinessEntity_ModifiedDate'
GO
/****** Object:  Default [DF_BusinessEntityAddress_rowguid]    Script Date: 11/22/2013 20:49:40 ******/
ALTER TABLE [Person].[BusinessEntityAddress] ADD  CONSTRAINT [DF_BusinessEntityAddress_rowguid]  DEFAULT (newid()) FOR [rowguid]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of NEWID()' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'BusinessEntityAddress', @level2type=N'CONSTRAINT',@level2name=N'DF_BusinessEntityAddress_rowguid'
GO
/****** Object:  Default [DF_BusinessEntityAddress_ModifiedDate]    Script Date: 11/22/2013 20:49:40 ******/
ALTER TABLE [Person].[BusinessEntityAddress] ADD  CONSTRAINT [DF_BusinessEntityAddress_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of GETDATE()' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'BusinessEntityAddress', @level2type=N'CONSTRAINT',@level2name=N'DF_BusinessEntityAddress_ModifiedDate'
GO
/****** Object:  Default [DF_BusinessEntityContact_rowguid]    Script Date: 11/22/2013 20:49:40 ******/
ALTER TABLE [Person].[BusinessEntityContact] ADD  CONSTRAINT [DF_BusinessEntityContact_rowguid]  DEFAULT (newid()) FOR [rowguid]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of NEWID()' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'BusinessEntityContact', @level2type=N'CONSTRAINT',@level2name=N'DF_BusinessEntityContact_rowguid'
GO
/****** Object:  Default [DF_BusinessEntityContact_ModifiedDate]    Script Date: 11/22/2013 20:49:40 ******/
ALTER TABLE [Person].[BusinessEntityContact] ADD  CONSTRAINT [DF_BusinessEntityContact_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of GETDATE()' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'BusinessEntityContact', @level2type=N'CONSTRAINT',@level2name=N'DF_BusinessEntityContact_ModifiedDate'
GO
/****** Object:  Default [DF_ContactType_ModifiedDate]    Script Date: 11/22/2013 20:49:40 ******/
ALTER TABLE [Person].[ContactType] ADD  CONSTRAINT [DF_ContactType_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of GETDATE()' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'ContactType', @level2type=N'CONSTRAINT',@level2name=N'DF_ContactType_ModifiedDate'
GO
/****** Object:  Default [DF_CountryRegion_ModifiedDate]    Script Date: 11/22/2013 20:49:40 ******/
ALTER TABLE [Person].[CountryRegion] ADD  CONSTRAINT [DF_CountryRegion_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of GETDATE()' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'CountryRegion', @level2type=N'CONSTRAINT',@level2name=N'DF_CountryRegion_ModifiedDate'
GO
/****** Object:  Default [DF_EmailAddress_rowguid]    Script Date: 11/22/2013 20:49:40 ******/
ALTER TABLE [Person].[EmailAddress] ADD  CONSTRAINT [DF_EmailAddress_rowguid]  DEFAULT (newid()) FOR [rowguid]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of NEWID()' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'EmailAddress', @level2type=N'CONSTRAINT',@level2name=N'DF_EmailAddress_rowguid'
GO
/****** Object:  Default [DF_EmailAddress_ModifiedDate]    Script Date: 11/22/2013 20:49:40 ******/
ALTER TABLE [Person].[EmailAddress] ADD  CONSTRAINT [DF_EmailAddress_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of GETDATE()' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'EmailAddress', @level2type=N'CONSTRAINT',@level2name=N'DF_EmailAddress_ModifiedDate'
GO
/****** Object:  Default [DF_Password_rowguid]    Script Date: 11/22/2013 20:49:40 ******/
ALTER TABLE [Person].[Password] ADD  CONSTRAINT [DF_Password_rowguid]  DEFAULT (newid()) FOR [rowguid]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of NEWID()' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'Password', @level2type=N'CONSTRAINT',@level2name=N'DF_Password_rowguid'
GO
/****** Object:  Default [DF_Password_ModifiedDate]    Script Date: 11/22/2013 20:49:40 ******/
ALTER TABLE [Person].[Password] ADD  CONSTRAINT [DF_Password_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of GETDATE()' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'Password', @level2type=N'CONSTRAINT',@level2name=N'DF_Password_ModifiedDate'
GO
/****** Object:  Default [DF_Person_NameStyle]    Script Date: 11/22/2013 20:49:40 ******/
ALTER TABLE [Person].[Person] ADD  CONSTRAINT [DF_Person_NameStyle]  DEFAULT ((0)) FOR [NameStyle]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of 0' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'Person', @level2type=N'CONSTRAINT',@level2name=N'DF_Person_NameStyle'
GO
/****** Object:  Default [DF_Person_EmailPromotion]    Script Date: 11/22/2013 20:49:40 ******/
ALTER TABLE [Person].[Person] ADD  CONSTRAINT [DF_Person_EmailPromotion]  DEFAULT ((0)) FOR [EmailPromotion]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of 0' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'Person', @level2type=N'CONSTRAINT',@level2name=N'DF_Person_EmailPromotion'
GO
/****** Object:  Default [DF_Person_rowguid]    Script Date: 11/22/2013 20:49:40 ******/
ALTER TABLE [Person].[Person] ADD  CONSTRAINT [DF_Person_rowguid]  DEFAULT (newid()) FOR [rowguid]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of NEWID()' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'Person', @level2type=N'CONSTRAINT',@level2name=N'DF_Person_rowguid'
GO
/****** Object:  Default [DF_Person_ModifiedDate]    Script Date: 11/22/2013 20:49:40 ******/
ALTER TABLE [Person].[Person] ADD  CONSTRAINT [DF_Person_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of GETDATE()' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'Person', @level2type=N'CONSTRAINT',@level2name=N'DF_Person_ModifiedDate'
GO
/****** Object:  Default [DF_PersonPhone_ModifiedDate]    Script Date: 11/22/2013 20:49:40 ******/
ALTER TABLE [Person].[PersonPhone] ADD  CONSTRAINT [DF_PersonPhone_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of GETDATE()' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'PersonPhone', @level2type=N'CONSTRAINT',@level2name=N'DF_PersonPhone_ModifiedDate'
GO
/****** Object:  Default [DF_PhoneNumberType_ModifiedDate]    Script Date: 11/22/2013 20:49:40 ******/
ALTER TABLE [Person].[PhoneNumberType] ADD  CONSTRAINT [DF_PhoneNumberType_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of GETDATE()' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'PhoneNumberType', @level2type=N'CONSTRAINT',@level2name=N'DF_PhoneNumberType_ModifiedDate'
GO
/****** Object:  Default [DF_StateProvince_IsOnlyStateProvinceFlag]    Script Date: 11/22/2013 20:49:40 ******/
ALTER TABLE [Person].[StateProvince] ADD  CONSTRAINT [DF_StateProvince_IsOnlyStateProvinceFlag]  DEFAULT ((1)) FOR [IsOnlyStateProvinceFlag]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of 1 (TRUE)' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'StateProvince', @level2type=N'CONSTRAINT',@level2name=N'DF_StateProvince_IsOnlyStateProvinceFlag'
GO
/****** Object:  Default [DF_StateProvince_rowguid]    Script Date: 11/22/2013 20:49:40 ******/
ALTER TABLE [Person].[StateProvince] ADD  CONSTRAINT [DF_StateProvince_rowguid]  DEFAULT (newid()) FOR [rowguid]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of NEWID()' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'StateProvince', @level2type=N'CONSTRAINT',@level2name=N'DF_StateProvince_rowguid'
GO
/****** Object:  Default [DF_StateProvince_ModifiedDate]    Script Date: 11/22/2013 20:49:40 ******/
ALTER TABLE [Person].[StateProvince] ADD  CONSTRAINT [DF_StateProvince_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of GETDATE()' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'StateProvince', @level2type=N'CONSTRAINT',@level2name=N'DF_StateProvince_ModifiedDate'
GO
/****** Object:  Default [DF_BillOfMaterials_StartDate]    Script Date: 11/22/2013 20:49:40 ******/
ALTER TABLE [Production].[BillOfMaterials] ADD  CONSTRAINT [DF_BillOfMaterials_StartDate]  DEFAULT (getdate()) FOR [StartDate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of GETDATE()' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'BillOfMaterials', @level2type=N'CONSTRAINT',@level2name=N'DF_BillOfMaterials_StartDate'
GO
/****** Object:  Default [DF_BillOfMaterials_PerAssemblyQty]    Script Date: 11/22/2013 20:49:40 ******/
ALTER TABLE [Production].[BillOfMaterials] ADD  CONSTRAINT [DF_BillOfMaterials_PerAssemblyQty]  DEFAULT ((1.00)) FOR [PerAssemblyQty]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of 1.0' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'BillOfMaterials', @level2type=N'CONSTRAINT',@level2name=N'DF_BillOfMaterials_PerAssemblyQty'
GO
/****** Object:  Default [DF_BillOfMaterials_ModifiedDate]    Script Date: 11/22/2013 20:49:40 ******/
ALTER TABLE [Production].[BillOfMaterials] ADD  CONSTRAINT [DF_BillOfMaterials_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of GETDATE()' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'BillOfMaterials', @level2type=N'CONSTRAINT',@level2name=N'DF_BillOfMaterials_ModifiedDate'
GO
/****** Object:  Default [DF_Culture_ModifiedDate]    Script Date: 11/22/2013 20:49:40 ******/
ALTER TABLE [Production].[Culture] ADD  CONSTRAINT [DF_Culture_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of GETDATE()' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'Culture', @level2type=N'CONSTRAINT',@level2name=N'DF_Culture_ModifiedDate'
GO
/****** Object:  Default [DF_Document_FolderFlag]    Script Date: 11/22/2013 20:49:40 ******/
ALTER TABLE [Production].[Document] ADD  CONSTRAINT [DF_Document_FolderFlag]  DEFAULT ((0)) FOR [FolderFlag]
GO
/****** Object:  Default [DF_Document_ChangeNumber]    Script Date: 11/22/2013 20:49:40 ******/
ALTER TABLE [Production].[Document] ADD  CONSTRAINT [DF_Document_ChangeNumber]  DEFAULT ((0)) FOR [ChangeNumber]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of 0' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'Document', @level2type=N'CONSTRAINT',@level2name=N'DF_Document_ChangeNumber'
GO
/****** Object:  Default [DF_Document_rowguid]    Script Date: 11/22/2013 20:49:40 ******/
ALTER TABLE [Production].[Document] ADD  CONSTRAINT [DF_Document_rowguid]  DEFAULT (newid()) FOR [rowguid]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of NEWID()' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'Document', @level2type=N'CONSTRAINT',@level2name=N'DF_Document_rowguid'
GO
/****** Object:  Default [DF_Document_ModifiedDate]    Script Date: 11/22/2013 20:49:40 ******/
ALTER TABLE [Production].[Document] ADD  CONSTRAINT [DF_Document_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of GETDATE()' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'Document', @level2type=N'CONSTRAINT',@level2name=N'DF_Document_ModifiedDate'
GO
/****** Object:  Default [DF_Illustration_ModifiedDate]    Script Date: 11/22/2013 20:49:40 ******/
ALTER TABLE [Production].[Illustration] ADD  CONSTRAINT [DF_Illustration_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of GETDATE()' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'Illustration', @level2type=N'CONSTRAINT',@level2name=N'DF_Illustration_ModifiedDate'
GO
/****** Object:  Default [DF_Location_CostRate]    Script Date: 11/22/2013 20:49:40 ******/
ALTER TABLE [Production].[Location] ADD  CONSTRAINT [DF_Location_CostRate]  DEFAULT ((0.00)) FOR [CostRate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of 0.0' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'Location', @level2type=N'CONSTRAINT',@level2name=N'DF_Location_CostRate'
GO
/****** Object:  Default [DF_Location_Availability]    Script Date: 11/22/2013 20:49:40 ******/
ALTER TABLE [Production].[Location] ADD  CONSTRAINT [DF_Location_Availability]  DEFAULT ((0.00)) FOR [Availability]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of 0.00' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'Location', @level2type=N'CONSTRAINT',@level2name=N'DF_Location_Availability'
GO
/****** Object:  Default [DF_Location_ModifiedDate]    Script Date: 11/22/2013 20:49:40 ******/
ALTER TABLE [Production].[Location] ADD  CONSTRAINT [DF_Location_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of GETDATE()' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'Location', @level2type=N'CONSTRAINT',@level2name=N'DF_Location_ModifiedDate'
GO
/****** Object:  Default [DF_Product_MakeFlag]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Production].[Product] ADD  CONSTRAINT [DF_Product_MakeFlag]  DEFAULT ((1)) FOR [MakeFlag]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of  1' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'Product', @level2type=N'CONSTRAINT',@level2name=N'DF_Product_MakeFlag'
GO
/****** Object:  Default [DF_Product_FinishedGoodsFlag]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Production].[Product] ADD  CONSTRAINT [DF_Product_FinishedGoodsFlag]  DEFAULT ((1)) FOR [FinishedGoodsFlag]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of  1' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'Product', @level2type=N'CONSTRAINT',@level2name=N'DF_Product_FinishedGoodsFlag'
GO
/****** Object:  Default [DF_Product_rowguid]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Production].[Product] ADD  CONSTRAINT [DF_Product_rowguid]  DEFAULT (newid()) FOR [rowguid]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of NEWID()' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'Product', @level2type=N'CONSTRAINT',@level2name=N'DF_Product_rowguid'
GO
/****** Object:  Default [DF_Product_ModifiedDate]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Production].[Product] ADD  CONSTRAINT [DF_Product_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of GETDATE()' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'Product', @level2type=N'CONSTRAINT',@level2name=N'DF_Product_ModifiedDate'
GO
/****** Object:  Default [DF_ProductCategory_rowguid]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Production].[ProductCategory] ADD  CONSTRAINT [DF_ProductCategory_rowguid]  DEFAULT (newid()) FOR [rowguid]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of NEWID()()' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductCategory', @level2type=N'CONSTRAINT',@level2name=N'DF_ProductCategory_rowguid'
GO
/****** Object:  Default [DF_ProductCategory_ModifiedDate]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Production].[ProductCategory] ADD  CONSTRAINT [DF_ProductCategory_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of GETDATE()' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductCategory', @level2type=N'CONSTRAINT',@level2name=N'DF_ProductCategory_ModifiedDate'
GO
/****** Object:  Default [DF_ProductCostHistory_ModifiedDate]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Production].[ProductCostHistory] ADD  CONSTRAINT [DF_ProductCostHistory_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of GETDATE()' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductCostHistory', @level2type=N'CONSTRAINT',@level2name=N'DF_ProductCostHistory_ModifiedDate'
GO
/****** Object:  Default [DF_ProductDescription_rowguid]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Production].[ProductDescription] ADD  CONSTRAINT [DF_ProductDescription_rowguid]  DEFAULT (newid()) FOR [rowguid]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of NEWID()' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductDescription', @level2type=N'CONSTRAINT',@level2name=N'DF_ProductDescription_rowguid'
GO
/****** Object:  Default [DF_ProductDescription_ModifiedDate]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Production].[ProductDescription] ADD  CONSTRAINT [DF_ProductDescription_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of GETDATE()' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductDescription', @level2type=N'CONSTRAINT',@level2name=N'DF_ProductDescription_ModifiedDate'
GO
/****** Object:  Default [DF_ProductDocument_ModifiedDate]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Production].[ProductDocument] ADD  CONSTRAINT [DF_ProductDocument_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of GETDATE()' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductDocument', @level2type=N'CONSTRAINT',@level2name=N'DF_ProductDocument_ModifiedDate'
GO
/****** Object:  Default [DF_ProductInventory_Quantity]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Production].[ProductInventory] ADD  CONSTRAINT [DF_ProductInventory_Quantity]  DEFAULT ((0)) FOR [Quantity]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of 0' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductInventory', @level2type=N'CONSTRAINT',@level2name=N'DF_ProductInventory_Quantity'
GO
/****** Object:  Default [DF_ProductInventory_rowguid]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Production].[ProductInventory] ADD  CONSTRAINT [DF_ProductInventory_rowguid]  DEFAULT (newid()) FOR [rowguid]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of NEWID()' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductInventory', @level2type=N'CONSTRAINT',@level2name=N'DF_ProductInventory_rowguid'
GO
/****** Object:  Default [DF_ProductInventory_ModifiedDate]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Production].[ProductInventory] ADD  CONSTRAINT [DF_ProductInventory_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of GETDATE()' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductInventory', @level2type=N'CONSTRAINT',@level2name=N'DF_ProductInventory_ModifiedDate'
GO
/****** Object:  Default [DF_ProductListPriceHistory_ModifiedDate]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Production].[ProductListPriceHistory] ADD  CONSTRAINT [DF_ProductListPriceHistory_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of GETDATE()' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductListPriceHistory', @level2type=N'CONSTRAINT',@level2name=N'DF_ProductListPriceHistory_ModifiedDate'
GO
/****** Object:  Default [DF_ProductModel_rowguid]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Production].[ProductModel] ADD  CONSTRAINT [DF_ProductModel_rowguid]  DEFAULT (newid()) FOR [rowguid]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of NEWID()' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductModel', @level2type=N'CONSTRAINT',@level2name=N'DF_ProductModel_rowguid'
GO
/****** Object:  Default [DF_ProductModel_ModifiedDate]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Production].[ProductModel] ADD  CONSTRAINT [DF_ProductModel_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of GETDATE()' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductModel', @level2type=N'CONSTRAINT',@level2name=N'DF_ProductModel_ModifiedDate'
GO
/****** Object:  Default [DF_ProductModelIllustration_ModifiedDate]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Production].[ProductModelIllustration] ADD  CONSTRAINT [DF_ProductModelIllustration_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of GETDATE()' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductModelIllustration', @level2type=N'CONSTRAINT',@level2name=N'DF_ProductModelIllustration_ModifiedDate'
GO
/****** Object:  Default [DF_ProductModelProductDescriptionCulture_ModifiedDate]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Production].[ProductModelProductDescriptionCulture] ADD  CONSTRAINT [DF_ProductModelProductDescriptionCulture_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of GETDATE()' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductModelProductDescriptionCulture', @level2type=N'CONSTRAINT',@level2name=N'DF_ProductModelProductDescriptionCulture_ModifiedDate'
GO
/****** Object:  Default [DF_ProductPhoto_ModifiedDate]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Production].[ProductPhoto] ADD  CONSTRAINT [DF_ProductPhoto_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of GETDATE()' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductPhoto', @level2type=N'CONSTRAINT',@level2name=N'DF_ProductPhoto_ModifiedDate'
GO
/****** Object:  Default [DF_ProductProductPhoto_Primary]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Production].[ProductProductPhoto] ADD  CONSTRAINT [DF_ProductProductPhoto_Primary]  DEFAULT ((0)) FOR [Primary]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of 0 (FALSE)' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductProductPhoto', @level2type=N'CONSTRAINT',@level2name=N'DF_ProductProductPhoto_Primary'
GO
/****** Object:  Default [DF_ProductProductPhoto_ModifiedDate]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Production].[ProductProductPhoto] ADD  CONSTRAINT [DF_ProductProductPhoto_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of GETDATE()' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductProductPhoto', @level2type=N'CONSTRAINT',@level2name=N'DF_ProductProductPhoto_ModifiedDate'
GO
/****** Object:  Default [DF_ProductReview_ReviewDate]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Production].[ProductReview] ADD  CONSTRAINT [DF_ProductReview_ReviewDate]  DEFAULT (getdate()) FOR [ReviewDate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of GETDATE()' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductReview', @level2type=N'CONSTRAINT',@level2name=N'DF_ProductReview_ReviewDate'
GO
/****** Object:  Default [DF_ProductReview_ModifiedDate]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Production].[ProductReview] ADD  CONSTRAINT [DF_ProductReview_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of GETDATE()' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductReview', @level2type=N'CONSTRAINT',@level2name=N'DF_ProductReview_ModifiedDate'
GO
/****** Object:  Default [DF_ProductSubcategory_rowguid]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Production].[ProductSubcategory] ADD  CONSTRAINT [DF_ProductSubcategory_rowguid]  DEFAULT (newid()) FOR [rowguid]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of NEWID()' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductSubcategory', @level2type=N'CONSTRAINT',@level2name=N'DF_ProductSubcategory_rowguid'
GO
/****** Object:  Default [DF_ProductSubcategory_ModifiedDate]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Production].[ProductSubcategory] ADD  CONSTRAINT [DF_ProductSubcategory_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of GETDATE()' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductSubcategory', @level2type=N'CONSTRAINT',@level2name=N'DF_ProductSubcategory_ModifiedDate'
GO
/****** Object:  Default [DF_ScrapReason_ModifiedDate]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Production].[ScrapReason] ADD  CONSTRAINT [DF_ScrapReason_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of GETDATE()' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ScrapReason', @level2type=N'CONSTRAINT',@level2name=N'DF_ScrapReason_ModifiedDate'
GO
/****** Object:  Default [DF_TransactionHistory_ReferenceOrderLineID]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Production].[TransactionHistory] ADD  CONSTRAINT [DF_TransactionHistory_ReferenceOrderLineID]  DEFAULT ((0)) FOR [ReferenceOrderLineID]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of 0' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'TransactionHistory', @level2type=N'CONSTRAINT',@level2name=N'DF_TransactionHistory_ReferenceOrderLineID'
GO
/****** Object:  Default [DF_TransactionHistory_TransactionDate]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Production].[TransactionHistory] ADD  CONSTRAINT [DF_TransactionHistory_TransactionDate]  DEFAULT (getdate()) FOR [TransactionDate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of GETDATE()' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'TransactionHistory', @level2type=N'CONSTRAINT',@level2name=N'DF_TransactionHistory_TransactionDate'
GO
/****** Object:  Default [DF_TransactionHistory_ModifiedDate]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Production].[TransactionHistory] ADD  CONSTRAINT [DF_TransactionHistory_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of GETDATE()' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'TransactionHistory', @level2type=N'CONSTRAINT',@level2name=N'DF_TransactionHistory_ModifiedDate'
GO
/****** Object:  Default [DF_TransactionHistoryArchive_ReferenceOrderLineID]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Production].[TransactionHistoryArchive] ADD  CONSTRAINT [DF_TransactionHistoryArchive_ReferenceOrderLineID]  DEFAULT ((0)) FOR [ReferenceOrderLineID]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of 0' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'TransactionHistoryArchive', @level2type=N'CONSTRAINT',@level2name=N'DF_TransactionHistoryArchive_ReferenceOrderLineID'
GO
/****** Object:  Default [DF_TransactionHistoryArchive_TransactionDate]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Production].[TransactionHistoryArchive] ADD  CONSTRAINT [DF_TransactionHistoryArchive_TransactionDate]  DEFAULT (getdate()) FOR [TransactionDate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of GETDATE()' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'TransactionHistoryArchive', @level2type=N'CONSTRAINT',@level2name=N'DF_TransactionHistoryArchive_TransactionDate'
GO
/****** Object:  Default [DF_TransactionHistoryArchive_ModifiedDate]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Production].[TransactionHistoryArchive] ADD  CONSTRAINT [DF_TransactionHistoryArchive_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of GETDATE()' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'TransactionHistoryArchive', @level2type=N'CONSTRAINT',@level2name=N'DF_TransactionHistoryArchive_ModifiedDate'
GO
/****** Object:  Default [DF_UnitMeasure_ModifiedDate]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Production].[UnitMeasure] ADD  CONSTRAINT [DF_UnitMeasure_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of GETDATE()' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'UnitMeasure', @level2type=N'CONSTRAINT',@level2name=N'DF_UnitMeasure_ModifiedDate'
GO
/****** Object:  Default [DF_WorkOrder_ModifiedDate]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Production].[WorkOrder] ADD  CONSTRAINT [DF_WorkOrder_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of GETDATE()' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'WorkOrder', @level2type=N'CONSTRAINT',@level2name=N'DF_WorkOrder_ModifiedDate'
GO
/****** Object:  Default [DF_WorkOrderRouting_ModifiedDate]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Production].[WorkOrderRouting] ADD  CONSTRAINT [DF_WorkOrderRouting_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of GETDATE()' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'WorkOrderRouting', @level2type=N'CONSTRAINT',@level2name=N'DF_WorkOrderRouting_ModifiedDate'
GO
/****** Object:  Default [DF_ProductVendor_ModifiedDate]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Purchasing].[ProductVendor] ADD  CONSTRAINT [DF_ProductVendor_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of GETDATE()' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'ProductVendor', @level2type=N'CONSTRAINT',@level2name=N'DF_ProductVendor_ModifiedDate'
GO
/****** Object:  Default [DF_PurchaseOrderDetail_ModifiedDate]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Purchasing].[PurchaseOrderDetail] ADD  CONSTRAINT [DF_PurchaseOrderDetail_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of GETDATE()' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'PurchaseOrderDetail', @level2type=N'CONSTRAINT',@level2name=N'DF_PurchaseOrderDetail_ModifiedDate'
GO
/****** Object:  Default [DF_PurchaseOrderHeader_RevisionNumber]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Purchasing].[PurchaseOrderHeader] ADD  CONSTRAINT [DF_PurchaseOrderHeader_RevisionNumber]  DEFAULT ((0)) FOR [RevisionNumber]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of 0' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'PurchaseOrderHeader', @level2type=N'CONSTRAINT',@level2name=N'DF_PurchaseOrderHeader_RevisionNumber'
GO
/****** Object:  Default [DF_PurchaseOrderHeader_Status]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Purchasing].[PurchaseOrderHeader] ADD  CONSTRAINT [DF_PurchaseOrderHeader_Status]  DEFAULT ((1)) FOR [Status]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of 1' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'PurchaseOrderHeader', @level2type=N'CONSTRAINT',@level2name=N'DF_PurchaseOrderHeader_Status'
GO
/****** Object:  Default [DF_PurchaseOrderHeader_OrderDate]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Purchasing].[PurchaseOrderHeader] ADD  CONSTRAINT [DF_PurchaseOrderHeader_OrderDate]  DEFAULT (getdate()) FOR [OrderDate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of GETDATE()' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'PurchaseOrderHeader', @level2type=N'CONSTRAINT',@level2name=N'DF_PurchaseOrderHeader_OrderDate'
GO
/****** Object:  Default [DF_PurchaseOrderHeader_SubTotal]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Purchasing].[PurchaseOrderHeader] ADD  CONSTRAINT [DF_PurchaseOrderHeader_SubTotal]  DEFAULT ((0.00)) FOR [SubTotal]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of 0.0' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'PurchaseOrderHeader', @level2type=N'CONSTRAINT',@level2name=N'DF_PurchaseOrderHeader_SubTotal'
GO
/****** Object:  Default [DF_PurchaseOrderHeader_TaxAmt]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Purchasing].[PurchaseOrderHeader] ADD  CONSTRAINT [DF_PurchaseOrderHeader_TaxAmt]  DEFAULT ((0.00)) FOR [TaxAmt]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of 0.0' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'PurchaseOrderHeader', @level2type=N'CONSTRAINT',@level2name=N'DF_PurchaseOrderHeader_TaxAmt'
GO
/****** Object:  Default [DF_PurchaseOrderHeader_Freight]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Purchasing].[PurchaseOrderHeader] ADD  CONSTRAINT [DF_PurchaseOrderHeader_Freight]  DEFAULT ((0.00)) FOR [Freight]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of 0.0' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'PurchaseOrderHeader', @level2type=N'CONSTRAINT',@level2name=N'DF_PurchaseOrderHeader_Freight'
GO
/****** Object:  Default [DF_PurchaseOrderHeader_ModifiedDate]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Purchasing].[PurchaseOrderHeader] ADD  CONSTRAINT [DF_PurchaseOrderHeader_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of GETDATE()' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'PurchaseOrderHeader', @level2type=N'CONSTRAINT',@level2name=N'DF_PurchaseOrderHeader_ModifiedDate'
GO
/****** Object:  Default [DF_ShipMethod_ShipBase]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Purchasing].[ShipMethod] ADD  CONSTRAINT [DF_ShipMethod_ShipBase]  DEFAULT ((0.00)) FOR [ShipBase]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of 0.0' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'ShipMethod', @level2type=N'CONSTRAINT',@level2name=N'DF_ShipMethod_ShipBase'
GO
/****** Object:  Default [DF_ShipMethod_ShipRate]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Purchasing].[ShipMethod] ADD  CONSTRAINT [DF_ShipMethod_ShipRate]  DEFAULT ((0.00)) FOR [ShipRate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of 0.0' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'ShipMethod', @level2type=N'CONSTRAINT',@level2name=N'DF_ShipMethod_ShipRate'
GO
/****** Object:  Default [DF_ShipMethod_rowguid]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Purchasing].[ShipMethod] ADD  CONSTRAINT [DF_ShipMethod_rowguid]  DEFAULT (newid()) FOR [rowguid]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of NEWID()' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'ShipMethod', @level2type=N'CONSTRAINT',@level2name=N'DF_ShipMethod_rowguid'
GO
/****** Object:  Default [DF_ShipMethod_ModifiedDate]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Purchasing].[ShipMethod] ADD  CONSTRAINT [DF_ShipMethod_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of GETDATE()' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'ShipMethod', @level2type=N'CONSTRAINT',@level2name=N'DF_ShipMethod_ModifiedDate'
GO
/****** Object:  Default [DF_Vendor_PreferredVendorStatus]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Purchasing].[Vendor] ADD  CONSTRAINT [DF_Vendor_PreferredVendorStatus]  DEFAULT ((1)) FOR [PreferredVendorStatus]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of 1 (TRUE)' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'Vendor', @level2type=N'CONSTRAINT',@level2name=N'DF_Vendor_PreferredVendorStatus'
GO
/****** Object:  Default [DF_Vendor_ActiveFlag]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Purchasing].[Vendor] ADD  CONSTRAINT [DF_Vendor_ActiveFlag]  DEFAULT ((1)) FOR [ActiveFlag]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of 1 (TRUE)' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'Vendor', @level2type=N'CONSTRAINT',@level2name=N'DF_Vendor_ActiveFlag'
GO
/****** Object:  Default [DF_Vendor_ModifiedDate]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Purchasing].[Vendor] ADD  CONSTRAINT [DF_Vendor_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of GETDATE()' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'Vendor', @level2type=N'CONSTRAINT',@level2name=N'DF_Vendor_ModifiedDate'
GO
/****** Object:  Default [DF_CountryRegionCurrency_ModifiedDate]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[CountryRegionCurrency] ADD  CONSTRAINT [DF_CountryRegionCurrency_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of GETDATE()' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'CountryRegionCurrency', @level2type=N'CONSTRAINT',@level2name=N'DF_CountryRegionCurrency_ModifiedDate'
GO
/****** Object:  Default [DF_CreditCard_ModifiedDate]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[CreditCard] ADD  CONSTRAINT [DF_CreditCard_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of GETDATE()' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'CreditCard', @level2type=N'CONSTRAINT',@level2name=N'DF_CreditCard_ModifiedDate'
GO
/****** Object:  Default [DF_Currency_ModifiedDate]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[Currency] ADD  CONSTRAINT [DF_Currency_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of GETDATE()' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'Currency', @level2type=N'CONSTRAINT',@level2name=N'DF_Currency_ModifiedDate'
GO
/****** Object:  Default [DF_CurrencyRate_ModifiedDate]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[CurrencyRate] ADD  CONSTRAINT [DF_CurrencyRate_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of GETDATE()' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'CurrencyRate', @level2type=N'CONSTRAINT',@level2name=N'DF_CurrencyRate_ModifiedDate'
GO
/****** Object:  Default [DF_Customer_rowguid]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[Customer] ADD  CONSTRAINT [DF_Customer_rowguid]  DEFAULT (newid()) FOR [rowguid]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of NEWID()' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'CONSTRAINT',@level2name=N'DF_Customer_rowguid'
GO
/****** Object:  Default [DF_Customer_ModifiedDate]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[Customer] ADD  CONSTRAINT [DF_Customer_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of GETDATE()' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'CONSTRAINT',@level2name=N'DF_Customer_ModifiedDate'
GO
/****** Object:  Default [DF_PersonCreditCard_ModifiedDate]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[PersonCreditCard] ADD  CONSTRAINT [DF_PersonCreditCard_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of GETDATE()' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'PersonCreditCard', @level2type=N'CONSTRAINT',@level2name=N'DF_PersonCreditCard_ModifiedDate'
GO
/****** Object:  Default [DF_SalesOrderDetail_UnitPriceDiscount]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[SalesOrderDetail] ADD  CONSTRAINT [DF_SalesOrderDetail_UnitPriceDiscount]  DEFAULT ((0.0)) FOR [UnitPriceDiscount]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of 0.0' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesOrderDetail', @level2type=N'CONSTRAINT',@level2name=N'DF_SalesOrderDetail_UnitPriceDiscount'
GO
/****** Object:  Default [DF_SalesOrderDetail_rowguid]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[SalesOrderDetail] ADD  CONSTRAINT [DF_SalesOrderDetail_rowguid]  DEFAULT (newid()) FOR [rowguid]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of NEWID()' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesOrderDetail', @level2type=N'CONSTRAINT',@level2name=N'DF_SalesOrderDetail_rowguid'
GO
/****** Object:  Default [DF_SalesOrderDetail_ModifiedDate]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[SalesOrderDetail] ADD  CONSTRAINT [DF_SalesOrderDetail_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of GETDATE()' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesOrderDetail', @level2type=N'CONSTRAINT',@level2name=N'DF_SalesOrderDetail_ModifiedDate'
GO
/****** Object:  Default [DF_SalesOrderHeader_RevisionNumber]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[SalesOrderHeader] ADD  CONSTRAINT [DF_SalesOrderHeader_RevisionNumber]  DEFAULT ((0)) FOR [RevisionNumber]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of 0' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesOrderHeader', @level2type=N'CONSTRAINT',@level2name=N'DF_SalesOrderHeader_RevisionNumber'
GO
/****** Object:  Default [DF_SalesOrderHeader_OrderDate]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[SalesOrderHeader] ADD  CONSTRAINT [DF_SalesOrderHeader_OrderDate]  DEFAULT (getdate()) FOR [OrderDate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of GETDATE()' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesOrderHeader', @level2type=N'CONSTRAINT',@level2name=N'DF_SalesOrderHeader_OrderDate'
GO
/****** Object:  Default [DF_SalesOrderHeader_Status]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[SalesOrderHeader] ADD  CONSTRAINT [DF_SalesOrderHeader_Status]  DEFAULT ((1)) FOR [Status]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of 1' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesOrderHeader', @level2type=N'CONSTRAINT',@level2name=N'DF_SalesOrderHeader_Status'
GO
/****** Object:  Default [DF_SalesOrderHeader_OnlineOrderFlag]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[SalesOrderHeader] ADD  CONSTRAINT [DF_SalesOrderHeader_OnlineOrderFlag]  DEFAULT ((1)) FOR [OnlineOrderFlag]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of 1 (TRUE)' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesOrderHeader', @level2type=N'CONSTRAINT',@level2name=N'DF_SalesOrderHeader_OnlineOrderFlag'
GO
/****** Object:  Default [DF_SalesOrderHeader_SubTotal]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[SalesOrderHeader] ADD  CONSTRAINT [DF_SalesOrderHeader_SubTotal]  DEFAULT ((0.00)) FOR [SubTotal]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of 0.0' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesOrderHeader', @level2type=N'CONSTRAINT',@level2name=N'DF_SalesOrderHeader_SubTotal'
GO
/****** Object:  Default [DF_SalesOrderHeader_TaxAmt]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[SalesOrderHeader] ADD  CONSTRAINT [DF_SalesOrderHeader_TaxAmt]  DEFAULT ((0.00)) FOR [TaxAmt]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of 0.0' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesOrderHeader', @level2type=N'CONSTRAINT',@level2name=N'DF_SalesOrderHeader_TaxAmt'
GO
/****** Object:  Default [DF_SalesOrderHeader_Freight]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[SalesOrderHeader] ADD  CONSTRAINT [DF_SalesOrderHeader_Freight]  DEFAULT ((0.00)) FOR [Freight]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of 0.0' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesOrderHeader', @level2type=N'CONSTRAINT',@level2name=N'DF_SalesOrderHeader_Freight'
GO
/****** Object:  Default [DF_SalesOrderHeader_rowguid]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[SalesOrderHeader] ADD  CONSTRAINT [DF_SalesOrderHeader_rowguid]  DEFAULT (newid()) FOR [rowguid]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of NEWID()' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesOrderHeader', @level2type=N'CONSTRAINT',@level2name=N'DF_SalesOrderHeader_rowguid'
GO
/****** Object:  Default [DF_SalesOrderHeader_ModifiedDate]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[SalesOrderHeader] ADD  CONSTRAINT [DF_SalesOrderHeader_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of GETDATE()' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesOrderHeader', @level2type=N'CONSTRAINT',@level2name=N'DF_SalesOrderHeader_ModifiedDate'
GO
/****** Object:  Default [DF_SalesOrderHeaderSalesReason_ModifiedDate]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[SalesOrderHeaderSalesReason] ADD  CONSTRAINT [DF_SalesOrderHeaderSalesReason_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of GETDATE()' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesOrderHeaderSalesReason', @level2type=N'CONSTRAINT',@level2name=N'DF_SalesOrderHeaderSalesReason_ModifiedDate'
GO
/****** Object:  Default [DF_SalesPerson_Bonus]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[SalesPerson] ADD  CONSTRAINT [DF_SalesPerson_Bonus]  DEFAULT ((0.00)) FOR [Bonus]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of 0.0' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesPerson', @level2type=N'CONSTRAINT',@level2name=N'DF_SalesPerson_Bonus'
GO
/****** Object:  Default [DF_SalesPerson_CommissionPct]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[SalesPerson] ADD  CONSTRAINT [DF_SalesPerson_CommissionPct]  DEFAULT ((0.00)) FOR [CommissionPct]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of 0.0' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesPerson', @level2type=N'CONSTRAINT',@level2name=N'DF_SalesPerson_CommissionPct'
GO
/****** Object:  Default [DF_SalesPerson_SalesYTD]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[SalesPerson] ADD  CONSTRAINT [DF_SalesPerson_SalesYTD]  DEFAULT ((0.00)) FOR [SalesYTD]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of 0.0' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesPerson', @level2type=N'CONSTRAINT',@level2name=N'DF_SalesPerson_SalesYTD'
GO
/****** Object:  Default [DF_SalesPerson_SalesLastYear]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[SalesPerson] ADD  CONSTRAINT [DF_SalesPerson_SalesLastYear]  DEFAULT ((0.00)) FOR [SalesLastYear]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of 0.0' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesPerson', @level2type=N'CONSTRAINT',@level2name=N'DF_SalesPerson_SalesLastYear'
GO
/****** Object:  Default [DF_SalesPerson_rowguid]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[SalesPerson] ADD  CONSTRAINT [DF_SalesPerson_rowguid]  DEFAULT (newid()) FOR [rowguid]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of NEWID()' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesPerson', @level2type=N'CONSTRAINT',@level2name=N'DF_SalesPerson_rowguid'
GO
/****** Object:  Default [DF_SalesPerson_ModifiedDate]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[SalesPerson] ADD  CONSTRAINT [DF_SalesPerson_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of GETDATE()' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesPerson', @level2type=N'CONSTRAINT',@level2name=N'DF_SalesPerson_ModifiedDate'
GO
/****** Object:  Default [DF_SalesPersonQuotaHistory_rowguid]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[SalesPersonQuotaHistory] ADD  CONSTRAINT [DF_SalesPersonQuotaHistory_rowguid]  DEFAULT (newid()) FOR [rowguid]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of NEWID()' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesPersonQuotaHistory', @level2type=N'CONSTRAINT',@level2name=N'DF_SalesPersonQuotaHistory_rowguid'
GO
/****** Object:  Default [DF_SalesPersonQuotaHistory_ModifiedDate]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[SalesPersonQuotaHistory] ADD  CONSTRAINT [DF_SalesPersonQuotaHistory_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of GETDATE()' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesPersonQuotaHistory', @level2type=N'CONSTRAINT',@level2name=N'DF_SalesPersonQuotaHistory_ModifiedDate'
GO
/****** Object:  Default [DF_SalesReason_ModifiedDate]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[SalesReason] ADD  CONSTRAINT [DF_SalesReason_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of GETDATE()' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesReason', @level2type=N'CONSTRAINT',@level2name=N'DF_SalesReason_ModifiedDate'
GO
/****** Object:  Default [DF_SalesTaxRate_TaxRate]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[SalesTaxRate] ADD  CONSTRAINT [DF_SalesTaxRate_TaxRate]  DEFAULT ((0.00)) FOR [TaxRate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of 0.0' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesTaxRate', @level2type=N'CONSTRAINT',@level2name=N'DF_SalesTaxRate_TaxRate'
GO
/****** Object:  Default [DF_SalesTaxRate_rowguid]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[SalesTaxRate] ADD  CONSTRAINT [DF_SalesTaxRate_rowguid]  DEFAULT (newid()) FOR [rowguid]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of NEWID()' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesTaxRate', @level2type=N'CONSTRAINT',@level2name=N'DF_SalesTaxRate_rowguid'
GO
/****** Object:  Default [DF_SalesTaxRate_ModifiedDate]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[SalesTaxRate] ADD  CONSTRAINT [DF_SalesTaxRate_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of GETDATE()' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesTaxRate', @level2type=N'CONSTRAINT',@level2name=N'DF_SalesTaxRate_ModifiedDate'
GO
/****** Object:  Default [DF_SalesTerritory_SalesYTD]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[SalesTerritory] ADD  CONSTRAINT [DF_SalesTerritory_SalesYTD]  DEFAULT ((0.00)) FOR [SalesYTD]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of 0.0' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesTerritory', @level2type=N'CONSTRAINT',@level2name=N'DF_SalesTerritory_SalesYTD'
GO
/****** Object:  Default [DF_SalesTerritory_SalesLastYear]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[SalesTerritory] ADD  CONSTRAINT [DF_SalesTerritory_SalesLastYear]  DEFAULT ((0.00)) FOR [SalesLastYear]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of 0.0' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesTerritory', @level2type=N'CONSTRAINT',@level2name=N'DF_SalesTerritory_SalesLastYear'
GO
/****** Object:  Default [DF_SalesTerritory_CostYTD]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[SalesTerritory] ADD  CONSTRAINT [DF_SalesTerritory_CostYTD]  DEFAULT ((0.00)) FOR [CostYTD]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of 0.0' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesTerritory', @level2type=N'CONSTRAINT',@level2name=N'DF_SalesTerritory_CostYTD'
GO
/****** Object:  Default [DF_SalesTerritory_CostLastYear]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[SalesTerritory] ADD  CONSTRAINT [DF_SalesTerritory_CostLastYear]  DEFAULT ((0.00)) FOR [CostLastYear]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of 0.0' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesTerritory', @level2type=N'CONSTRAINT',@level2name=N'DF_SalesTerritory_CostLastYear'
GO
/****** Object:  Default [DF_SalesTerritory_rowguid]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[SalesTerritory] ADD  CONSTRAINT [DF_SalesTerritory_rowguid]  DEFAULT (newid()) FOR [rowguid]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of NEWID()' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesTerritory', @level2type=N'CONSTRAINT',@level2name=N'DF_SalesTerritory_rowguid'
GO
/****** Object:  Default [DF_SalesTerritory_ModifiedDate]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[SalesTerritory] ADD  CONSTRAINT [DF_SalesTerritory_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of GETDATE()' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesTerritory', @level2type=N'CONSTRAINT',@level2name=N'DF_SalesTerritory_ModifiedDate'
GO
/****** Object:  Default [DF_SalesTerritoryHistory_rowguid]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[SalesTerritoryHistory] ADD  CONSTRAINT [DF_SalesTerritoryHistory_rowguid]  DEFAULT (newid()) FOR [rowguid]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of NEWID()' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesTerritoryHistory', @level2type=N'CONSTRAINT',@level2name=N'DF_SalesTerritoryHistory_rowguid'
GO
/****** Object:  Default [DF_SalesTerritoryHistory_ModifiedDate]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[SalesTerritoryHistory] ADD  CONSTRAINT [DF_SalesTerritoryHistory_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of GETDATE()' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesTerritoryHistory', @level2type=N'CONSTRAINT',@level2name=N'DF_SalesTerritoryHistory_ModifiedDate'
GO
/****** Object:  Default [DF_ShoppingCartItem_Quantity]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[ShoppingCartItem] ADD  CONSTRAINT [DF_ShoppingCartItem_Quantity]  DEFAULT ((1)) FOR [Quantity]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of 1' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'ShoppingCartItem', @level2type=N'CONSTRAINT',@level2name=N'DF_ShoppingCartItem_Quantity'
GO
/****** Object:  Default [DF_ShoppingCartItem_DateCreated]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[ShoppingCartItem] ADD  CONSTRAINT [DF_ShoppingCartItem_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of GETDATE()' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'ShoppingCartItem', @level2type=N'CONSTRAINT',@level2name=N'DF_ShoppingCartItem_DateCreated'
GO
/****** Object:  Default [DF_ShoppingCartItem_ModifiedDate]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[ShoppingCartItem] ADD  CONSTRAINT [DF_ShoppingCartItem_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of GETDATE()' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'ShoppingCartItem', @level2type=N'CONSTRAINT',@level2name=N'DF_ShoppingCartItem_ModifiedDate'
GO
/****** Object:  Default [DF_SpecialOffer_DiscountPct]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[SpecialOffer] ADD  CONSTRAINT [DF_SpecialOffer_DiscountPct]  DEFAULT ((0.00)) FOR [DiscountPct]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of 0.0' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SpecialOffer', @level2type=N'CONSTRAINT',@level2name=N'DF_SpecialOffer_DiscountPct'
GO
/****** Object:  Default [DF_SpecialOffer_MinQty]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[SpecialOffer] ADD  CONSTRAINT [DF_SpecialOffer_MinQty]  DEFAULT ((0)) FOR [MinQty]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of 0.0' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SpecialOffer', @level2type=N'CONSTRAINT',@level2name=N'DF_SpecialOffer_MinQty'
GO
/****** Object:  Default [DF_SpecialOffer_rowguid]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[SpecialOffer] ADD  CONSTRAINT [DF_SpecialOffer_rowguid]  DEFAULT (newid()) FOR [rowguid]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of NEWID()' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SpecialOffer', @level2type=N'CONSTRAINT',@level2name=N'DF_SpecialOffer_rowguid'
GO
/****** Object:  Default [DF_SpecialOffer_ModifiedDate]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[SpecialOffer] ADD  CONSTRAINT [DF_SpecialOffer_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of GETDATE()' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SpecialOffer', @level2type=N'CONSTRAINT',@level2name=N'DF_SpecialOffer_ModifiedDate'
GO
/****** Object:  Default [DF_SpecialOfferProduct_rowguid]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[SpecialOfferProduct] ADD  CONSTRAINT [DF_SpecialOfferProduct_rowguid]  DEFAULT (newid()) FOR [rowguid]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of NEWID()' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SpecialOfferProduct', @level2type=N'CONSTRAINT',@level2name=N'DF_SpecialOfferProduct_rowguid'
GO
/****** Object:  Default [DF_SpecialOfferProduct_ModifiedDate]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[SpecialOfferProduct] ADD  CONSTRAINT [DF_SpecialOfferProduct_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of GETDATE()' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SpecialOfferProduct', @level2type=N'CONSTRAINT',@level2name=N'DF_SpecialOfferProduct_ModifiedDate'
GO
/****** Object:  Default [DF_Store_rowguid]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[Store] ADD  CONSTRAINT [DF_Store_rowguid]  DEFAULT (newid()) FOR [rowguid]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of NEWID()' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'Store', @level2type=N'CONSTRAINT',@level2name=N'DF_Store_rowguid'
GO
/****** Object:  Default [DF_Store_ModifiedDate]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[Store] ADD  CONSTRAINT [DF_Store_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Default constraint value of GETDATE()' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'Store', @level2type=N'CONSTRAINT',@level2name=N'DF_Store_ModifiedDate'
GO
/****** Object:  Check [CK_Employee_BirthDate]    Script Date: 11/22/2013 20:49:40 ******/
ALTER TABLE [HumanResources].[Employee]  WITH CHECK ADD  CONSTRAINT [CK_Employee_BirthDate] CHECK  (([BirthDate]>='1930-01-01' AND [BirthDate]<=dateadd(year,(-18),getdate())))
GO
ALTER TABLE [HumanResources].[Employee] CHECK CONSTRAINT [CK_Employee_BirthDate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Check constraint [BirthDate] >= ''1930-01-01'' AND [BirthDate] <= dateadd(year,(-18),GETDATE())' , @level0type=N'SCHEMA',@level0name=N'HumanResources', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'CONSTRAINT',@level2name=N'CK_Employee_BirthDate'
GO
/****** Object:  Check [CK_Employee_Gender]    Script Date: 11/22/2013 20:49:40 ******/
ALTER TABLE [HumanResources].[Employee]  WITH CHECK ADD  CONSTRAINT [CK_Employee_Gender] CHECK  ((upper([Gender])='F' OR upper([Gender])='M'))
GO
ALTER TABLE [HumanResources].[Employee] CHECK CONSTRAINT [CK_Employee_Gender]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Check constraint [Gender]=''f'' OR [Gender]=''m'' OR [Gender]=''F'' OR [Gender]=''M''' , @level0type=N'SCHEMA',@level0name=N'HumanResources', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'CONSTRAINT',@level2name=N'CK_Employee_Gender'
GO
/****** Object:  Check [CK_Employee_HireDate]    Script Date: 11/22/2013 20:49:40 ******/
ALTER TABLE [HumanResources].[Employee]  WITH CHECK ADD  CONSTRAINT [CK_Employee_HireDate] CHECK  (([HireDate]>='1996-07-01' AND [HireDate]<=dateadd(day,(1),getdate())))
GO
ALTER TABLE [HumanResources].[Employee] CHECK CONSTRAINT [CK_Employee_HireDate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Check constraint [HireDate] >= ''1996-07-01'' AND [HireDate] <= dateadd(day,(1),GETDATE())' , @level0type=N'SCHEMA',@level0name=N'HumanResources', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'CONSTRAINT',@level2name=N'CK_Employee_HireDate'
GO
/****** Object:  Check [CK_Employee_MaritalStatus]    Script Date: 11/22/2013 20:49:40 ******/
ALTER TABLE [HumanResources].[Employee]  WITH CHECK ADD  CONSTRAINT [CK_Employee_MaritalStatus] CHECK  ((upper([MaritalStatus])='S' OR upper([MaritalStatus])='M'))
GO
ALTER TABLE [HumanResources].[Employee] CHECK CONSTRAINT [CK_Employee_MaritalStatus]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Check constraint [MaritalStatus]=''s'' OR [MaritalStatus]=''m'' OR [MaritalStatus]=''S'' OR [MaritalStatus]=''M''' , @level0type=N'SCHEMA',@level0name=N'HumanResources', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'CONSTRAINT',@level2name=N'CK_Employee_MaritalStatus'
GO
/****** Object:  Check [CK_Employee_SickLeaveHours]    Script Date: 11/22/2013 20:49:40 ******/
ALTER TABLE [HumanResources].[Employee]  WITH CHECK ADD  CONSTRAINT [CK_Employee_SickLeaveHours] CHECK  (([SickLeaveHours]>=(0) AND [SickLeaveHours]<=(120)))
GO
ALTER TABLE [HumanResources].[Employee] CHECK CONSTRAINT [CK_Employee_SickLeaveHours]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Check constraint [SickLeaveHours] >= (0) AND [SickLeaveHours] <= (120)' , @level0type=N'SCHEMA',@level0name=N'HumanResources', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'CONSTRAINT',@level2name=N'CK_Employee_SickLeaveHours'
GO
/****** Object:  Check [CK_Employee_VacationHours]    Script Date: 11/22/2013 20:49:40 ******/
ALTER TABLE [HumanResources].[Employee]  WITH CHECK ADD  CONSTRAINT [CK_Employee_VacationHours] CHECK  (([VacationHours]>=(-40) AND [VacationHours]<=(240)))
GO
ALTER TABLE [HumanResources].[Employee] CHECK CONSTRAINT [CK_Employee_VacationHours]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Check constraint [VacationHours] >= (-40) AND [VacationHours] <= (240)' , @level0type=N'SCHEMA',@level0name=N'HumanResources', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'CONSTRAINT',@level2name=N'CK_Employee_VacationHours'
GO
/****** Object:  Check [CK_EmployeeDepartmentHistory_EndDate]    Script Date: 11/22/2013 20:49:40 ******/
ALTER TABLE [HumanResources].[EmployeeDepartmentHistory]  WITH CHECK ADD  CONSTRAINT [CK_EmployeeDepartmentHistory_EndDate] CHECK  (([EndDate]>=[StartDate] OR [EndDate] IS NULL))
GO
ALTER TABLE [HumanResources].[EmployeeDepartmentHistory] CHECK CONSTRAINT [CK_EmployeeDepartmentHistory_EndDate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Check constraint [EndDate] >= [StartDate] OR [EndDate] IS NUL' , @level0type=N'SCHEMA',@level0name=N'HumanResources', @level1type=N'TABLE',@level1name=N'EmployeeDepartmentHistory', @level2type=N'CONSTRAINT',@level2name=N'CK_EmployeeDepartmentHistory_EndDate'
GO
/****** Object:  Check [CK_EmployeePayHistory_PayFrequency]    Script Date: 11/22/2013 20:49:40 ******/
ALTER TABLE [HumanResources].[EmployeePayHistory]  WITH CHECK ADD  CONSTRAINT [CK_EmployeePayHistory_PayFrequency] CHECK  (([PayFrequency]=(2) OR [PayFrequency]=(1)))
GO
ALTER TABLE [HumanResources].[EmployeePayHistory] CHECK CONSTRAINT [CK_EmployeePayHistory_PayFrequency]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Check constraint [PayFrequency]=(3) OR [PayFrequency]=(2) OR [PayFrequency]=(1)' , @level0type=N'SCHEMA',@level0name=N'HumanResources', @level1type=N'TABLE',@level1name=N'EmployeePayHistory', @level2type=N'CONSTRAINT',@level2name=N'CK_EmployeePayHistory_PayFrequency'
GO
/****** Object:  Check [CK_EmployeePayHistory_Rate]    Script Date: 11/22/2013 20:49:40 ******/
ALTER TABLE [HumanResources].[EmployeePayHistory]  WITH CHECK ADD  CONSTRAINT [CK_EmployeePayHistory_Rate] CHECK  (([Rate]>=(6.50) AND [Rate]<=(200.00)))
GO
ALTER TABLE [HumanResources].[EmployeePayHistory] CHECK CONSTRAINT [CK_EmployeePayHistory_Rate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Check constraint [Rate] >= (6.50) AND [Rate] <= (200.00)' , @level0type=N'SCHEMA',@level0name=N'HumanResources', @level1type=N'TABLE',@level1name=N'EmployeePayHistory', @level2type=N'CONSTRAINT',@level2name=N'CK_EmployeePayHistory_Rate'
GO
/****** Object:  Check [CK_Person_EmailPromotion]    Script Date: 11/22/2013 20:49:40 ******/
ALTER TABLE [Person].[Person]  WITH CHECK ADD  CONSTRAINT [CK_Person_EmailPromotion] CHECK  (([EmailPromotion]>=(0) AND [EmailPromotion]<=(2)))
GO
ALTER TABLE [Person].[Person] CHECK CONSTRAINT [CK_Person_EmailPromotion]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Check constraint [EmailPromotion] >= (0) AND [EmailPromotion] <= (2)' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'Person', @level2type=N'CONSTRAINT',@level2name=N'CK_Person_EmailPromotion'
GO
/****** Object:  Check [CK_Person_PersonType]    Script Date: 11/22/2013 20:49:40 ******/
ALTER TABLE [Person].[Person]  WITH CHECK ADD  CONSTRAINT [CK_Person_PersonType] CHECK  (([PersonType] IS NULL OR (upper([PersonType])='GC' OR upper([PersonType])='SP' OR upper([PersonType])='EM' OR upper([PersonType])='IN' OR upper([PersonType])='VC' OR upper([PersonType])='SC')))
GO
ALTER TABLE [Person].[Person] CHECK CONSTRAINT [CK_Person_PersonType]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Check constraint [PersonType] is one of SC, VC, IN, EM or SP.' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'Person', @level2type=N'CONSTRAINT',@level2name=N'CK_Person_PersonType'
GO
/****** Object:  Check [CK_BillOfMaterials_BOMLevel]    Script Date: 11/22/2013 20:49:40 ******/
ALTER TABLE [Production].[BillOfMaterials]  WITH CHECK ADD  CONSTRAINT [CK_BillOfMaterials_BOMLevel] CHECK  (([ProductAssemblyID] IS NULL AND [BOMLevel]=(0) AND [PerAssemblyQty]=(1.00) OR [ProductAssemblyID] IS NOT NULL AND [BOMLevel]>=(1)))
GO
ALTER TABLE [Production].[BillOfMaterials] CHECK CONSTRAINT [CK_BillOfMaterials_BOMLevel]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Check constraint [ProductAssemblyID] IS NULL AND [BOMLevel] = (0) AND [PerAssemblyQty] = (1) OR [ProductAssemblyID] IS NOT NULL AND [BOMLevel] >= (1)' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'BillOfMaterials', @level2type=N'CONSTRAINT',@level2name=N'CK_BillOfMaterials_BOMLevel'
GO
/****** Object:  Check [CK_BillOfMaterials_EndDate]    Script Date: 11/22/2013 20:49:40 ******/
ALTER TABLE [Production].[BillOfMaterials]  WITH CHECK ADD  CONSTRAINT [CK_BillOfMaterials_EndDate] CHECK  (([EndDate]>[StartDate] OR [EndDate] IS NULL))
GO
ALTER TABLE [Production].[BillOfMaterials] CHECK CONSTRAINT [CK_BillOfMaterials_EndDate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Check constraint EndDate] > [StartDate] OR [EndDate] IS NULL' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'BillOfMaterials', @level2type=N'CONSTRAINT',@level2name=N'CK_BillOfMaterials_EndDate'
GO
/****** Object:  Check [CK_BillOfMaterials_PerAssemblyQty]    Script Date: 11/22/2013 20:49:40 ******/
ALTER TABLE [Production].[BillOfMaterials]  WITH CHECK ADD  CONSTRAINT [CK_BillOfMaterials_PerAssemblyQty] CHECK  (([PerAssemblyQty]>=(1.00)))
GO
ALTER TABLE [Production].[BillOfMaterials] CHECK CONSTRAINT [CK_BillOfMaterials_PerAssemblyQty]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Check constraint [PerAssemblyQty] >= (1.00)' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'BillOfMaterials', @level2type=N'CONSTRAINT',@level2name=N'CK_BillOfMaterials_PerAssemblyQty'
GO
/****** Object:  Check [CK_BillOfMaterials_ProductAssemblyID]    Script Date: 11/22/2013 20:49:40 ******/
ALTER TABLE [Production].[BillOfMaterials]  WITH CHECK ADD  CONSTRAINT [CK_BillOfMaterials_ProductAssemblyID] CHECK  (([ProductAssemblyID]<>[ComponentID]))
GO
ALTER TABLE [Production].[BillOfMaterials] CHECK CONSTRAINT [CK_BillOfMaterials_ProductAssemblyID]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Check constraint [ProductAssemblyID] <> [ComponentID]' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'BillOfMaterials', @level2type=N'CONSTRAINT',@level2name=N'CK_BillOfMaterials_ProductAssemblyID'
GO
/****** Object:  Check [CK_Document_Status]    Script Date: 11/22/2013 20:49:40 ******/
ALTER TABLE [Production].[Document]  WITH CHECK ADD  CONSTRAINT [CK_Document_Status] CHECK  (([Status]>=(1) AND [Status]<=(3)))
GO
ALTER TABLE [Production].[Document] CHECK CONSTRAINT [CK_Document_Status]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Check constraint [Status] BETWEEN (1) AND (3)' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'Document', @level2type=N'CONSTRAINT',@level2name=N'CK_Document_Status'
GO
/****** Object:  Check [CK_Location_Availability]    Script Date: 11/22/2013 20:49:40 ******/
ALTER TABLE [Production].[Location]  WITH CHECK ADD  CONSTRAINT [CK_Location_Availability] CHECK  (([Availability]>=(0.00)))
GO
ALTER TABLE [Production].[Location] CHECK CONSTRAINT [CK_Location_Availability]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Check constraint [Availability] >= (0.00)' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'Location', @level2type=N'CONSTRAINT',@level2name=N'CK_Location_Availability'
GO
/****** Object:  Check [CK_Location_CostRate]    Script Date: 11/22/2013 20:49:40 ******/
ALTER TABLE [Production].[Location]  WITH CHECK ADD  CONSTRAINT [CK_Location_CostRate] CHECK  (([CostRate]>=(0.00)))
GO
ALTER TABLE [Production].[Location] CHECK CONSTRAINT [CK_Location_CostRate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Check constraint [CostRate] >= (0.00)' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'Location', @level2type=N'CONSTRAINT',@level2name=N'CK_Location_CostRate'
GO
/****** Object:  Check [CK_Product_Class]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Production].[Product]  WITH CHECK ADD  CONSTRAINT [CK_Product_Class] CHECK  ((upper([Class])='H' OR upper([Class])='M' OR upper([Class])='L' OR [Class] IS NULL))
GO
ALTER TABLE [Production].[Product] CHECK CONSTRAINT [CK_Product_Class]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Check constraint [Class]=''h'' OR [Class]=''m'' OR [Class]=''l'' OR [Class]=''H'' OR [Class]=''M'' OR [Class]=''L'' OR [Class] IS NULL' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'Product', @level2type=N'CONSTRAINT',@level2name=N'CK_Product_Class'
GO
/****** Object:  Check [CK_Product_DaysToManufacture]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Production].[Product]  WITH CHECK ADD  CONSTRAINT [CK_Product_DaysToManufacture] CHECK  (([DaysToManufacture]>=(0)))
GO
ALTER TABLE [Production].[Product] CHECK CONSTRAINT [CK_Product_DaysToManufacture]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Check constraint [DaysToManufacture] >= (0)' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'Product', @level2type=N'CONSTRAINT',@level2name=N'CK_Product_DaysToManufacture'
GO
/****** Object:  Check [CK_Product_ListPrice]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Production].[Product]  WITH CHECK ADD  CONSTRAINT [CK_Product_ListPrice] CHECK  (([ListPrice]>=(0.00)))
GO
ALTER TABLE [Production].[Product] CHECK CONSTRAINT [CK_Product_ListPrice]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Check constraint [ListPrice] >= (0.00)' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'Product', @level2type=N'CONSTRAINT',@level2name=N'CK_Product_ListPrice'
GO
/****** Object:  Check [CK_Product_ProductLine]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Production].[Product]  WITH CHECK ADD  CONSTRAINT [CK_Product_ProductLine] CHECK  ((upper([ProductLine])='R' OR upper([ProductLine])='M' OR upper([ProductLine])='T' OR upper([ProductLine])='S' OR [ProductLine] IS NULL))
GO
ALTER TABLE [Production].[Product] CHECK CONSTRAINT [CK_Product_ProductLine]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Check constraint [ProductLine]=''r'' OR [ProductLine]=''m'' OR [ProductLine]=''t'' OR [ProductLine]=''s'' OR [ProductLine]=''R'' OR [ProductLine]=''M'' OR [ProductLine]=''T'' OR [ProductLine]=''S'' OR [ProductLine] IS NULL' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'Product', @level2type=N'CONSTRAINT',@level2name=N'CK_Product_ProductLine'
GO
/****** Object:  Check [CK_Product_ReorderPoint]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Production].[Product]  WITH CHECK ADD  CONSTRAINT [CK_Product_ReorderPoint] CHECK  (([ReorderPoint]>(0)))
GO
ALTER TABLE [Production].[Product] CHECK CONSTRAINT [CK_Product_ReorderPoint]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Check constraint [ReorderPoint] > (0)' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'Product', @level2type=N'CONSTRAINT',@level2name=N'CK_Product_ReorderPoint'
GO
/****** Object:  Check [CK_Product_SafetyStockLevel]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Production].[Product]  WITH CHECK ADD  CONSTRAINT [CK_Product_SafetyStockLevel] CHECK  (([SafetyStockLevel]>(0)))
GO
ALTER TABLE [Production].[Product] CHECK CONSTRAINT [CK_Product_SafetyStockLevel]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Check constraint [SafetyStockLevel] > (0)' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'Product', @level2type=N'CONSTRAINT',@level2name=N'CK_Product_SafetyStockLevel'
GO
/****** Object:  Check [CK_Product_SellEndDate]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Production].[Product]  WITH CHECK ADD  CONSTRAINT [CK_Product_SellEndDate] CHECK  (([SellEndDate]>=[SellStartDate] OR [SellEndDate] IS NULL))
GO
ALTER TABLE [Production].[Product] CHECK CONSTRAINT [CK_Product_SellEndDate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Check constraint [SellEndDate] >= [SellStartDate] OR [SellEndDate] IS NULL' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'Product', @level2type=N'CONSTRAINT',@level2name=N'CK_Product_SellEndDate'
GO
/****** Object:  Check [CK_Product_StandardCost]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Production].[Product]  WITH CHECK ADD  CONSTRAINT [CK_Product_StandardCost] CHECK  (([StandardCost]>=(0.00)))
GO
ALTER TABLE [Production].[Product] CHECK CONSTRAINT [CK_Product_StandardCost]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Check constraint [SafetyStockLevel] > (0)' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'Product', @level2type=N'CONSTRAINT',@level2name=N'CK_Product_StandardCost'
GO
/****** Object:  Check [CK_Product_Style]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Production].[Product]  WITH CHECK ADD  CONSTRAINT [CK_Product_Style] CHECK  ((upper([Style])='U' OR upper([Style])='M' OR upper([Style])='W' OR [Style] IS NULL))
GO
ALTER TABLE [Production].[Product] CHECK CONSTRAINT [CK_Product_Style]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Check constraint [Style]=''u'' OR [Style]=''m'' OR [Style]=''w'' OR [Style]=''U'' OR [Style]=''M'' OR [Style]=''W'' OR [Style] IS NULL' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'Product', @level2type=N'CONSTRAINT',@level2name=N'CK_Product_Style'
GO
/****** Object:  Check [CK_Product_Weight]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Production].[Product]  WITH CHECK ADD  CONSTRAINT [CK_Product_Weight] CHECK  (([Weight]>(0.00)))
GO
ALTER TABLE [Production].[Product] CHECK CONSTRAINT [CK_Product_Weight]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Check constraint [Weight] > (0.00)' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'Product', @level2type=N'CONSTRAINT',@level2name=N'CK_Product_Weight'
GO
/****** Object:  Check [CK_ProductCostHistory_EndDate]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Production].[ProductCostHistory]  WITH CHECK ADD  CONSTRAINT [CK_ProductCostHistory_EndDate] CHECK  (([EndDate]>=[StartDate] OR [EndDate] IS NULL))
GO
ALTER TABLE [Production].[ProductCostHistory] CHECK CONSTRAINT [CK_ProductCostHistory_EndDate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Check constraint [EndDate] >= [StartDate] OR [EndDate] IS NULL' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductCostHistory', @level2type=N'CONSTRAINT',@level2name=N'CK_ProductCostHistory_EndDate'
GO
/****** Object:  Check [CK_ProductCostHistory_StandardCost]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Production].[ProductCostHistory]  WITH CHECK ADD  CONSTRAINT [CK_ProductCostHistory_StandardCost] CHECK  (([StandardCost]>=(0.00)))
GO
ALTER TABLE [Production].[ProductCostHistory] CHECK CONSTRAINT [CK_ProductCostHistory_StandardCost]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Check constraint [StandardCost] >= (0.00)' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductCostHistory', @level2type=N'CONSTRAINT',@level2name=N'CK_ProductCostHistory_StandardCost'
GO
/****** Object:  Check [CK_ProductInventory_Bin]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Production].[ProductInventory]  WITH CHECK ADD  CONSTRAINT [CK_ProductInventory_Bin] CHECK  (([Bin]>=(0) AND [Bin]<=(100)))
GO
ALTER TABLE [Production].[ProductInventory] CHECK CONSTRAINT [CK_ProductInventory_Bin]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Check constraint [Bin] BETWEEN (0) AND (100)' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductInventory', @level2type=N'CONSTRAINT',@level2name=N'CK_ProductInventory_Bin'
GO
/****** Object:  Check [CK_ProductInventory_Shelf]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Production].[ProductInventory]  WITH CHECK ADD  CONSTRAINT [CK_ProductInventory_Shelf] CHECK  (([Shelf] like '[A-Za-z]' OR [Shelf]='N/A'))
GO
ALTER TABLE [Production].[ProductInventory] CHECK CONSTRAINT [CK_ProductInventory_Shelf]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Check constraint [Shelf] like ''[A-Za-z]'' OR [Shelf]=''N/A''' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductInventory', @level2type=N'CONSTRAINT',@level2name=N'CK_ProductInventory_Shelf'
GO
/****** Object:  Check [CK_ProductListPriceHistory_EndDate]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Production].[ProductListPriceHistory]  WITH CHECK ADD  CONSTRAINT [CK_ProductListPriceHistory_EndDate] CHECK  (([EndDate]>=[StartDate] OR [EndDate] IS NULL))
GO
ALTER TABLE [Production].[ProductListPriceHistory] CHECK CONSTRAINT [CK_ProductListPriceHistory_EndDate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Check constraint [EndDate] >= [StartDate] OR [EndDate] IS NULL' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductListPriceHistory', @level2type=N'CONSTRAINT',@level2name=N'CK_ProductListPriceHistory_EndDate'
GO
/****** Object:  Check [CK_ProductListPriceHistory_ListPrice]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Production].[ProductListPriceHistory]  WITH CHECK ADD  CONSTRAINT [CK_ProductListPriceHistory_ListPrice] CHECK  (([ListPrice]>(0.00)))
GO
ALTER TABLE [Production].[ProductListPriceHistory] CHECK CONSTRAINT [CK_ProductListPriceHistory_ListPrice]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Check constraint [ListPrice] > (0.00)' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductListPriceHistory', @level2type=N'CONSTRAINT',@level2name=N'CK_ProductListPriceHistory_ListPrice'
GO
/****** Object:  Check [CK_ProductReview_Rating]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Production].[ProductReview]  WITH CHECK ADD  CONSTRAINT [CK_ProductReview_Rating] CHECK  (([Rating]>=(1) AND [Rating]<=(5)))
GO
ALTER TABLE [Production].[ProductReview] CHECK CONSTRAINT [CK_ProductReview_Rating]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Check constraint [Rating] BETWEEN (1) AND (5)' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductReview', @level2type=N'CONSTRAINT',@level2name=N'CK_ProductReview_Rating'
GO
/****** Object:  Check [CK_TransactionHistory_TransactionType]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Production].[TransactionHistory]  WITH CHECK ADD  CONSTRAINT [CK_TransactionHistory_TransactionType] CHECK  ((upper([TransactionType])='P' OR upper([TransactionType])='S' OR upper([TransactionType])='W'))
GO
ALTER TABLE [Production].[TransactionHistory] CHECK CONSTRAINT [CK_TransactionHistory_TransactionType]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Check constraint [TransactionType]=''p'' OR [TransactionType]=''s'' OR [TransactionType]=''w'' OR [TransactionType]=''P'' OR [TransactionType]=''S'' OR [TransactionType]=''W'')' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'TransactionHistory', @level2type=N'CONSTRAINT',@level2name=N'CK_TransactionHistory_TransactionType'
GO
/****** Object:  Check [CK_TransactionHistoryArchive_TransactionType]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Production].[TransactionHistoryArchive]  WITH CHECK ADD  CONSTRAINT [CK_TransactionHistoryArchive_TransactionType] CHECK  ((upper([TransactionType])='P' OR upper([TransactionType])='S' OR upper([TransactionType])='W'))
GO
ALTER TABLE [Production].[TransactionHistoryArchive] CHECK CONSTRAINT [CK_TransactionHistoryArchive_TransactionType]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Check constraint [TransactionType]=''p'' OR [TransactionType]=''s'' OR [TransactionType]=''w'' OR [TransactionType]=''P'' OR [TransactionType]=''S'' OR [TransactionType]=''W''' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'TransactionHistoryArchive', @level2type=N'CONSTRAINT',@level2name=N'CK_TransactionHistoryArchive_TransactionType'
GO
/****** Object:  Check [CK_WorkOrder_EndDate]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Production].[WorkOrder]  WITH CHECK ADD  CONSTRAINT [CK_WorkOrder_EndDate] CHECK  (([EndDate]>=[StartDate] OR [EndDate] IS NULL))
GO
ALTER TABLE [Production].[WorkOrder] CHECK CONSTRAINT [CK_WorkOrder_EndDate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Check constraint [EndDate] >= [StartDate] OR [EndDate] IS NULL' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'WorkOrder', @level2type=N'CONSTRAINT',@level2name=N'CK_WorkOrder_EndDate'
GO
/****** Object:  Check [CK_WorkOrder_OrderQty]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Production].[WorkOrder]  WITH CHECK ADD  CONSTRAINT [CK_WorkOrder_OrderQty] CHECK  (([OrderQty]>(0)))
GO
ALTER TABLE [Production].[WorkOrder] CHECK CONSTRAINT [CK_WorkOrder_OrderQty]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Check constraint [OrderQty] > (0)' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'WorkOrder', @level2type=N'CONSTRAINT',@level2name=N'CK_WorkOrder_OrderQty'
GO
/****** Object:  Check [CK_WorkOrder_ScrappedQty]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Production].[WorkOrder]  WITH CHECK ADD  CONSTRAINT [CK_WorkOrder_ScrappedQty] CHECK  (([ScrappedQty]>=(0)))
GO
ALTER TABLE [Production].[WorkOrder] CHECK CONSTRAINT [CK_WorkOrder_ScrappedQty]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Check constraint [ScrappedQty] >= (0)' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'WorkOrder', @level2type=N'CONSTRAINT',@level2name=N'CK_WorkOrder_ScrappedQty'
GO
/****** Object:  Check [CK_WorkOrderRouting_ActualCost]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Production].[WorkOrderRouting]  WITH CHECK ADD  CONSTRAINT [CK_WorkOrderRouting_ActualCost] CHECK  (([ActualCost]>(0.00)))
GO
ALTER TABLE [Production].[WorkOrderRouting] CHECK CONSTRAINT [CK_WorkOrderRouting_ActualCost]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Check constraint [ActualCost] > (0.00)' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'WorkOrderRouting', @level2type=N'CONSTRAINT',@level2name=N'CK_WorkOrderRouting_ActualCost'
GO
/****** Object:  Check [CK_WorkOrderRouting_ActualEndDate]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Production].[WorkOrderRouting]  WITH CHECK ADD  CONSTRAINT [CK_WorkOrderRouting_ActualEndDate] CHECK  (([ActualEndDate]>=[ActualStartDate] OR [ActualEndDate] IS NULL OR [ActualStartDate] IS NULL))
GO
ALTER TABLE [Production].[WorkOrderRouting] CHECK CONSTRAINT [CK_WorkOrderRouting_ActualEndDate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Check constraint [ActualEndDate] >= [ActualStartDate] OR [ActualEndDate] IS NULL OR [ActualStartDate] IS NULL' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'WorkOrderRouting', @level2type=N'CONSTRAINT',@level2name=N'CK_WorkOrderRouting_ActualEndDate'
GO
/****** Object:  Check [CK_WorkOrderRouting_ActualResourceHrs]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Production].[WorkOrderRouting]  WITH CHECK ADD  CONSTRAINT [CK_WorkOrderRouting_ActualResourceHrs] CHECK  (([ActualResourceHrs]>=(0.0000)))
GO
ALTER TABLE [Production].[WorkOrderRouting] CHECK CONSTRAINT [CK_WorkOrderRouting_ActualResourceHrs]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Check constraint [ActualResourceHrs] >= (0.0000)' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'WorkOrderRouting', @level2type=N'CONSTRAINT',@level2name=N'CK_WorkOrderRouting_ActualResourceHrs'
GO
/****** Object:  Check [CK_WorkOrderRouting_PlannedCost]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Production].[WorkOrderRouting]  WITH CHECK ADD  CONSTRAINT [CK_WorkOrderRouting_PlannedCost] CHECK  (([PlannedCost]>(0.00)))
GO
ALTER TABLE [Production].[WorkOrderRouting] CHECK CONSTRAINT [CK_WorkOrderRouting_PlannedCost]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Check constraint [PlannedCost] > (0.00)' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'WorkOrderRouting', @level2type=N'CONSTRAINT',@level2name=N'CK_WorkOrderRouting_PlannedCost'
GO
/****** Object:  Check [CK_WorkOrderRouting_ScheduledEndDate]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Production].[WorkOrderRouting]  WITH CHECK ADD  CONSTRAINT [CK_WorkOrderRouting_ScheduledEndDate] CHECK  (([ScheduledEndDate]>=[ScheduledStartDate]))
GO
ALTER TABLE [Production].[WorkOrderRouting] CHECK CONSTRAINT [CK_WorkOrderRouting_ScheduledEndDate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Check constraint [ScheduledEndDate] >= [ScheduledStartDate]' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'WorkOrderRouting', @level2type=N'CONSTRAINT',@level2name=N'CK_WorkOrderRouting_ScheduledEndDate'
GO
/****** Object:  Check [CK_ProductVendor_AverageLeadTime]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Purchasing].[ProductVendor]  WITH CHECK ADD  CONSTRAINT [CK_ProductVendor_AverageLeadTime] CHECK  (([AverageLeadTime]>=(1)))
GO
ALTER TABLE [Purchasing].[ProductVendor] CHECK CONSTRAINT [CK_ProductVendor_AverageLeadTime]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Check constraint [AverageLeadTime] >= (1)' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'ProductVendor', @level2type=N'CONSTRAINT',@level2name=N'CK_ProductVendor_AverageLeadTime'
GO
/****** Object:  Check [CK_ProductVendor_LastReceiptCost]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Purchasing].[ProductVendor]  WITH CHECK ADD  CONSTRAINT [CK_ProductVendor_LastReceiptCost] CHECK  (([LastReceiptCost]>(0.00)))
GO
ALTER TABLE [Purchasing].[ProductVendor] CHECK CONSTRAINT [CK_ProductVendor_LastReceiptCost]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Check constraint [LastReceiptCost] > (0.00)' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'ProductVendor', @level2type=N'CONSTRAINT',@level2name=N'CK_ProductVendor_LastReceiptCost'
GO
/****** Object:  Check [CK_ProductVendor_MaxOrderQty]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Purchasing].[ProductVendor]  WITH CHECK ADD  CONSTRAINT [CK_ProductVendor_MaxOrderQty] CHECK  (([MaxOrderQty]>=(1)))
GO
ALTER TABLE [Purchasing].[ProductVendor] CHECK CONSTRAINT [CK_ProductVendor_MaxOrderQty]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Check constraint [MaxOrderQty] >= (1)' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'ProductVendor', @level2type=N'CONSTRAINT',@level2name=N'CK_ProductVendor_MaxOrderQty'
GO
/****** Object:  Check [CK_ProductVendor_MinOrderQty]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Purchasing].[ProductVendor]  WITH CHECK ADD  CONSTRAINT [CK_ProductVendor_MinOrderQty] CHECK  (([MinOrderQty]>=(1)))
GO
ALTER TABLE [Purchasing].[ProductVendor] CHECK CONSTRAINT [CK_ProductVendor_MinOrderQty]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Check constraint [MinOrderQty] >= (1)' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'ProductVendor', @level2type=N'CONSTRAINT',@level2name=N'CK_ProductVendor_MinOrderQty'
GO
/****** Object:  Check [CK_ProductVendor_OnOrderQty]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Purchasing].[ProductVendor]  WITH CHECK ADD  CONSTRAINT [CK_ProductVendor_OnOrderQty] CHECK  (([OnOrderQty]>=(0)))
GO
ALTER TABLE [Purchasing].[ProductVendor] CHECK CONSTRAINT [CK_ProductVendor_OnOrderQty]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Check constraint [OnOrderQty] >= (0)' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'ProductVendor', @level2type=N'CONSTRAINT',@level2name=N'CK_ProductVendor_OnOrderQty'
GO
/****** Object:  Check [CK_ProductVendor_StandardPrice]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Purchasing].[ProductVendor]  WITH CHECK ADD  CONSTRAINT [CK_ProductVendor_StandardPrice] CHECK  (([StandardPrice]>(0.00)))
GO
ALTER TABLE [Purchasing].[ProductVendor] CHECK CONSTRAINT [CK_ProductVendor_StandardPrice]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Check constraint [StandardPrice] > (0.00)' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'ProductVendor', @level2type=N'CONSTRAINT',@level2name=N'CK_ProductVendor_StandardPrice'
GO
/****** Object:  Check [CK_PurchaseOrderDetail_OrderQty]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Purchasing].[PurchaseOrderDetail]  WITH CHECK ADD  CONSTRAINT [CK_PurchaseOrderDetail_OrderQty] CHECK  (([OrderQty]>(0)))
GO
ALTER TABLE [Purchasing].[PurchaseOrderDetail] CHECK CONSTRAINT [CK_PurchaseOrderDetail_OrderQty]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Check constraint [OrderQty] > (0)' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'PurchaseOrderDetail', @level2type=N'CONSTRAINT',@level2name=N'CK_PurchaseOrderDetail_OrderQty'
GO
/****** Object:  Check [CK_PurchaseOrderDetail_ReceivedQty]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Purchasing].[PurchaseOrderDetail]  WITH CHECK ADD  CONSTRAINT [CK_PurchaseOrderDetail_ReceivedQty] CHECK  (([ReceivedQty]>=(0.00)))
GO
ALTER TABLE [Purchasing].[PurchaseOrderDetail] CHECK CONSTRAINT [CK_PurchaseOrderDetail_ReceivedQty]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Check constraint [ReceivedQty] >= (0.00)' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'PurchaseOrderDetail', @level2type=N'CONSTRAINT',@level2name=N'CK_PurchaseOrderDetail_ReceivedQty'
GO
/****** Object:  Check [CK_PurchaseOrderDetail_RejectedQty]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Purchasing].[PurchaseOrderDetail]  WITH CHECK ADD  CONSTRAINT [CK_PurchaseOrderDetail_RejectedQty] CHECK  (([RejectedQty]>=(0.00)))
GO
ALTER TABLE [Purchasing].[PurchaseOrderDetail] CHECK CONSTRAINT [CK_PurchaseOrderDetail_RejectedQty]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Check constraint [RejectedQty] >= (0.00)' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'PurchaseOrderDetail', @level2type=N'CONSTRAINT',@level2name=N'CK_PurchaseOrderDetail_RejectedQty'
GO
/****** Object:  Check [CK_PurchaseOrderDetail_UnitPrice]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Purchasing].[PurchaseOrderDetail]  WITH CHECK ADD  CONSTRAINT [CK_PurchaseOrderDetail_UnitPrice] CHECK  (([UnitPrice]>=(0.00)))
GO
ALTER TABLE [Purchasing].[PurchaseOrderDetail] CHECK CONSTRAINT [CK_PurchaseOrderDetail_UnitPrice]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Check constraint [UnitPrice] >= (0.00)' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'PurchaseOrderDetail', @level2type=N'CONSTRAINT',@level2name=N'CK_PurchaseOrderDetail_UnitPrice'
GO
/****** Object:  Check [CK_PurchaseOrderHeader_Freight]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Purchasing].[PurchaseOrderHeader]  WITH CHECK ADD  CONSTRAINT [CK_PurchaseOrderHeader_Freight] CHECK  (([Freight]>=(0.00)))
GO
ALTER TABLE [Purchasing].[PurchaseOrderHeader] CHECK CONSTRAINT [CK_PurchaseOrderHeader_Freight]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Check constraint [Freight] >= (0.00)' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'PurchaseOrderHeader', @level2type=N'CONSTRAINT',@level2name=N'CK_PurchaseOrderHeader_Freight'
GO
/****** Object:  Check [CK_PurchaseOrderHeader_ShipDate]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Purchasing].[PurchaseOrderHeader]  WITH CHECK ADD  CONSTRAINT [CK_PurchaseOrderHeader_ShipDate] CHECK  (([ShipDate]>=[OrderDate] OR [ShipDate] IS NULL))
GO
ALTER TABLE [Purchasing].[PurchaseOrderHeader] CHECK CONSTRAINT [CK_PurchaseOrderHeader_ShipDate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Check constraint [ShipDate] >= [OrderDate] OR [ShipDate] IS NULL' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'PurchaseOrderHeader', @level2type=N'CONSTRAINT',@level2name=N'CK_PurchaseOrderHeader_ShipDate'
GO
/****** Object:  Check [CK_PurchaseOrderHeader_Status]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Purchasing].[PurchaseOrderHeader]  WITH CHECK ADD  CONSTRAINT [CK_PurchaseOrderHeader_Status] CHECK  (([Status]>=(1) AND [Status]<=(4)))
GO
ALTER TABLE [Purchasing].[PurchaseOrderHeader] CHECK CONSTRAINT [CK_PurchaseOrderHeader_Status]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Check constraint [Status] BETWEEN (1) AND (4)' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'PurchaseOrderHeader', @level2type=N'CONSTRAINT',@level2name=N'CK_PurchaseOrderHeader_Status'
GO
/****** Object:  Check [CK_PurchaseOrderHeader_SubTotal]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Purchasing].[PurchaseOrderHeader]  WITH CHECK ADD  CONSTRAINT [CK_PurchaseOrderHeader_SubTotal] CHECK  (([SubTotal]>=(0.00)))
GO
ALTER TABLE [Purchasing].[PurchaseOrderHeader] CHECK CONSTRAINT [CK_PurchaseOrderHeader_SubTotal]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Check constraint [SubTotal] >= (0.00)' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'PurchaseOrderHeader', @level2type=N'CONSTRAINT',@level2name=N'CK_PurchaseOrderHeader_SubTotal'
GO
/****** Object:  Check [CK_PurchaseOrderHeader_TaxAmt]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Purchasing].[PurchaseOrderHeader]  WITH CHECK ADD  CONSTRAINT [CK_PurchaseOrderHeader_TaxAmt] CHECK  (([TaxAmt]>=(0.00)))
GO
ALTER TABLE [Purchasing].[PurchaseOrderHeader] CHECK CONSTRAINT [CK_PurchaseOrderHeader_TaxAmt]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Check constraint [TaxAmt] >= (0.00)' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'PurchaseOrderHeader', @level2type=N'CONSTRAINT',@level2name=N'CK_PurchaseOrderHeader_TaxAmt'
GO
/****** Object:  Check [CK_ShipMethod_ShipBase]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Purchasing].[ShipMethod]  WITH CHECK ADD  CONSTRAINT [CK_ShipMethod_ShipBase] CHECK  (([ShipBase]>(0.00)))
GO
ALTER TABLE [Purchasing].[ShipMethod] CHECK CONSTRAINT [CK_ShipMethod_ShipBase]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Check constraint [ShipBase] > (0.00)' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'ShipMethod', @level2type=N'CONSTRAINT',@level2name=N'CK_ShipMethod_ShipBase'
GO
/****** Object:  Check [CK_ShipMethod_ShipRate]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Purchasing].[ShipMethod]  WITH CHECK ADD  CONSTRAINT [CK_ShipMethod_ShipRate] CHECK  (([ShipRate]>(0.00)))
GO
ALTER TABLE [Purchasing].[ShipMethod] CHECK CONSTRAINT [CK_ShipMethod_ShipRate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Check constraint [ShipRate] > (0.00)' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'ShipMethod', @level2type=N'CONSTRAINT',@level2name=N'CK_ShipMethod_ShipRate'
GO
/****** Object:  Check [CK_Vendor_CreditRating]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Purchasing].[Vendor]  WITH CHECK ADD  CONSTRAINT [CK_Vendor_CreditRating] CHECK  (([CreditRating]>=(1) AND [CreditRating]<=(5)))
GO
ALTER TABLE [Purchasing].[Vendor] CHECK CONSTRAINT [CK_Vendor_CreditRating]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Check constraint [CreditRating] BETWEEN (1) AND (5)' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'Vendor', @level2type=N'CONSTRAINT',@level2name=N'CK_Vendor_CreditRating'
GO
/****** Object:  Check [CK_SalesOrderDetail_OrderQty]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[SalesOrderDetail]  WITH CHECK ADD  CONSTRAINT [CK_SalesOrderDetail_OrderQty] CHECK  (([OrderQty]>(0)))
GO
ALTER TABLE [Sales].[SalesOrderDetail] CHECK CONSTRAINT [CK_SalesOrderDetail_OrderQty]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Check constraint [OrderQty] > (0)' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesOrderDetail', @level2type=N'CONSTRAINT',@level2name=N'CK_SalesOrderDetail_OrderQty'
GO
/****** Object:  Check [CK_SalesOrderDetail_UnitPrice]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[SalesOrderDetail]  WITH CHECK ADD  CONSTRAINT [CK_SalesOrderDetail_UnitPrice] CHECK  (([UnitPrice]>=(0.00)))
GO
ALTER TABLE [Sales].[SalesOrderDetail] CHECK CONSTRAINT [CK_SalesOrderDetail_UnitPrice]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Check constraint [UnitPrice] >= (0.00)' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesOrderDetail', @level2type=N'CONSTRAINT',@level2name=N'CK_SalesOrderDetail_UnitPrice'
GO
/****** Object:  Check [CK_SalesOrderDetail_UnitPriceDiscount]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[SalesOrderDetail]  WITH CHECK ADD  CONSTRAINT [CK_SalesOrderDetail_UnitPriceDiscount] CHECK  (([UnitPriceDiscount]>=(0.00)))
GO
ALTER TABLE [Sales].[SalesOrderDetail] CHECK CONSTRAINT [CK_SalesOrderDetail_UnitPriceDiscount]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Check constraint [UnitPriceDiscount] >= (0.00)' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesOrderDetail', @level2type=N'CONSTRAINT',@level2name=N'CK_SalesOrderDetail_UnitPriceDiscount'
GO
/****** Object:  Check [CK_SalesOrderHeader_DueDate]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[SalesOrderHeader]  WITH CHECK ADD  CONSTRAINT [CK_SalesOrderHeader_DueDate] CHECK  (([DueDate]>=[OrderDate]))
GO
ALTER TABLE [Sales].[SalesOrderHeader] CHECK CONSTRAINT [CK_SalesOrderHeader_DueDate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Check constraint [DueDate] >= [OrderDate]' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesOrderHeader', @level2type=N'CONSTRAINT',@level2name=N'CK_SalesOrderHeader_DueDate'
GO
/****** Object:  Check [CK_SalesOrderHeader_Freight]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[SalesOrderHeader]  WITH CHECK ADD  CONSTRAINT [CK_SalesOrderHeader_Freight] CHECK  (([Freight]>=(0.00)))
GO
ALTER TABLE [Sales].[SalesOrderHeader] CHECK CONSTRAINT [CK_SalesOrderHeader_Freight]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Check constraint [Freight] >= (0.00)' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesOrderHeader', @level2type=N'CONSTRAINT',@level2name=N'CK_SalesOrderHeader_Freight'
GO
/****** Object:  Check [CK_SalesOrderHeader_ShipDate]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[SalesOrderHeader]  WITH CHECK ADD  CONSTRAINT [CK_SalesOrderHeader_ShipDate] CHECK  (([ShipDate]>=[OrderDate] OR [ShipDate] IS NULL))
GO
ALTER TABLE [Sales].[SalesOrderHeader] CHECK CONSTRAINT [CK_SalesOrderHeader_ShipDate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Check constraint [ShipDate] >= [OrderDate] OR [ShipDate] IS NULL' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesOrderHeader', @level2type=N'CONSTRAINT',@level2name=N'CK_SalesOrderHeader_ShipDate'
GO
/****** Object:  Check [CK_SalesOrderHeader_Status]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[SalesOrderHeader]  WITH CHECK ADD  CONSTRAINT [CK_SalesOrderHeader_Status] CHECK  (([Status]>=(0) AND [Status]<=(8)))
GO
ALTER TABLE [Sales].[SalesOrderHeader] CHECK CONSTRAINT [CK_SalesOrderHeader_Status]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Check constraint [Status] BETWEEN (0) AND (8)' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesOrderHeader', @level2type=N'CONSTRAINT',@level2name=N'CK_SalesOrderHeader_Status'
GO
/****** Object:  Check [CK_SalesOrderHeader_SubTotal]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[SalesOrderHeader]  WITH CHECK ADD  CONSTRAINT [CK_SalesOrderHeader_SubTotal] CHECK  (([SubTotal]>=(0.00)))
GO
ALTER TABLE [Sales].[SalesOrderHeader] CHECK CONSTRAINT [CK_SalesOrderHeader_SubTotal]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Check constraint [SubTotal] >= (0.00)' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesOrderHeader', @level2type=N'CONSTRAINT',@level2name=N'CK_SalesOrderHeader_SubTotal'
GO
/****** Object:  Check [CK_SalesOrderHeader_TaxAmt]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[SalesOrderHeader]  WITH CHECK ADD  CONSTRAINT [CK_SalesOrderHeader_TaxAmt] CHECK  (([TaxAmt]>=(0.00)))
GO
ALTER TABLE [Sales].[SalesOrderHeader] CHECK CONSTRAINT [CK_SalesOrderHeader_TaxAmt]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Check constraint [TaxAmt] >= (0.00)' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesOrderHeader', @level2type=N'CONSTRAINT',@level2name=N'CK_SalesOrderHeader_TaxAmt'
GO
/****** Object:  Check [CK_SalesPerson_Bonus]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[SalesPerson]  WITH CHECK ADD  CONSTRAINT [CK_SalesPerson_Bonus] CHECK  (([Bonus]>=(0.00)))
GO
ALTER TABLE [Sales].[SalesPerson] CHECK CONSTRAINT [CK_SalesPerson_Bonus]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Check constraint [Bonus] >= (0.00)' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesPerson', @level2type=N'CONSTRAINT',@level2name=N'CK_SalesPerson_Bonus'
GO
/****** Object:  Check [CK_SalesPerson_CommissionPct]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[SalesPerson]  WITH CHECK ADD  CONSTRAINT [CK_SalesPerson_CommissionPct] CHECK  (([CommissionPct]>=(0.00)))
GO
ALTER TABLE [Sales].[SalesPerson] CHECK CONSTRAINT [CK_SalesPerson_CommissionPct]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Check constraint [CommissionPct] >= (0.00)' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesPerson', @level2type=N'CONSTRAINT',@level2name=N'CK_SalesPerson_CommissionPct'
GO
/****** Object:  Check [CK_SalesPerson_SalesLastYear]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[SalesPerson]  WITH CHECK ADD  CONSTRAINT [CK_SalesPerson_SalesLastYear] CHECK  (([SalesLastYear]>=(0.00)))
GO
ALTER TABLE [Sales].[SalesPerson] CHECK CONSTRAINT [CK_SalesPerson_SalesLastYear]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Check constraint [SalesLastYear] >= (0.00)' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesPerson', @level2type=N'CONSTRAINT',@level2name=N'CK_SalesPerson_SalesLastYear'
GO
/****** Object:  Check [CK_SalesPerson_SalesQuota]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[SalesPerson]  WITH CHECK ADD  CONSTRAINT [CK_SalesPerson_SalesQuota] CHECK  (([SalesQuota]>(0.00)))
GO
ALTER TABLE [Sales].[SalesPerson] CHECK CONSTRAINT [CK_SalesPerson_SalesQuota]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Check constraint [SalesQuota] > (0.00)' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesPerson', @level2type=N'CONSTRAINT',@level2name=N'CK_SalesPerson_SalesQuota'
GO
/****** Object:  Check [CK_SalesPerson_SalesYTD]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[SalesPerson]  WITH CHECK ADD  CONSTRAINT [CK_SalesPerson_SalesYTD] CHECK  (([SalesYTD]>=(0.00)))
GO
ALTER TABLE [Sales].[SalesPerson] CHECK CONSTRAINT [CK_SalesPerson_SalesYTD]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Check constraint [SalesYTD] >= (0.00)' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesPerson', @level2type=N'CONSTRAINT',@level2name=N'CK_SalesPerson_SalesYTD'
GO
/****** Object:  Check [CK_SalesPersonQuotaHistory_SalesQuota]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[SalesPersonQuotaHistory]  WITH CHECK ADD  CONSTRAINT [CK_SalesPersonQuotaHistory_SalesQuota] CHECK  (([SalesQuota]>(0.00)))
GO
ALTER TABLE [Sales].[SalesPersonQuotaHistory] CHECK CONSTRAINT [CK_SalesPersonQuotaHistory_SalesQuota]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Check constraint [SalesQuota] > (0.00)' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesPersonQuotaHistory', @level2type=N'CONSTRAINT',@level2name=N'CK_SalesPersonQuotaHistory_SalesQuota'
GO
/****** Object:  Check [CK_SalesTaxRate_TaxType]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[SalesTaxRate]  WITH CHECK ADD  CONSTRAINT [CK_SalesTaxRate_TaxType] CHECK  (([TaxType]>=(1) AND [TaxType]<=(3)))
GO
ALTER TABLE [Sales].[SalesTaxRate] CHECK CONSTRAINT [CK_SalesTaxRate_TaxType]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Check constraint [TaxType] BETWEEN (1) AND (3)' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesTaxRate', @level2type=N'CONSTRAINT',@level2name=N'CK_SalesTaxRate_TaxType'
GO
/****** Object:  Check [CK_SalesTerritory_CostLastYear]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[SalesTerritory]  WITH CHECK ADD  CONSTRAINT [CK_SalesTerritory_CostLastYear] CHECK  (([CostLastYear]>=(0.00)))
GO
ALTER TABLE [Sales].[SalesTerritory] CHECK CONSTRAINT [CK_SalesTerritory_CostLastYear]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Check constraint [CostLastYear] >= (0.00)' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesTerritory', @level2type=N'CONSTRAINT',@level2name=N'CK_SalesTerritory_CostLastYear'
GO
/****** Object:  Check [CK_SalesTerritory_CostYTD]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[SalesTerritory]  WITH CHECK ADD  CONSTRAINT [CK_SalesTerritory_CostYTD] CHECK  (([CostYTD]>=(0.00)))
GO
ALTER TABLE [Sales].[SalesTerritory] CHECK CONSTRAINT [CK_SalesTerritory_CostYTD]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Check constraint [CostYTD] >= (0.00)' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesTerritory', @level2type=N'CONSTRAINT',@level2name=N'CK_SalesTerritory_CostYTD'
GO
/****** Object:  Check [CK_SalesTerritory_SalesLastYear]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[SalesTerritory]  WITH CHECK ADD  CONSTRAINT [CK_SalesTerritory_SalesLastYear] CHECK  (([SalesLastYear]>=(0.00)))
GO
ALTER TABLE [Sales].[SalesTerritory] CHECK CONSTRAINT [CK_SalesTerritory_SalesLastYear]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Check constraint [SalesLastYear] >= (0.00)' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesTerritory', @level2type=N'CONSTRAINT',@level2name=N'CK_SalesTerritory_SalesLastYear'
GO
/****** Object:  Check [CK_SalesTerritory_SalesYTD]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[SalesTerritory]  WITH CHECK ADD  CONSTRAINT [CK_SalesTerritory_SalesYTD] CHECK  (([SalesYTD]>=(0.00)))
GO
ALTER TABLE [Sales].[SalesTerritory] CHECK CONSTRAINT [CK_SalesTerritory_SalesYTD]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Check constraint [SalesYTD] >= (0.00)' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesTerritory', @level2type=N'CONSTRAINT',@level2name=N'CK_SalesTerritory_SalesYTD'
GO
/****** Object:  Check [CK_SalesTerritoryHistory_EndDate]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[SalesTerritoryHistory]  WITH CHECK ADD  CONSTRAINT [CK_SalesTerritoryHistory_EndDate] CHECK  (([EndDate]>=[StartDate] OR [EndDate] IS NULL))
GO
ALTER TABLE [Sales].[SalesTerritoryHistory] CHECK CONSTRAINT [CK_SalesTerritoryHistory_EndDate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Check constraint [EndDate] >= [StartDate] OR [EndDate] IS NULL' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesTerritoryHistory', @level2type=N'CONSTRAINT',@level2name=N'CK_SalesTerritoryHistory_EndDate'
GO
/****** Object:  Check [CK_ShoppingCartItem_Quantity]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[ShoppingCartItem]  WITH CHECK ADD  CONSTRAINT [CK_ShoppingCartItem_Quantity] CHECK  (([Quantity]>=(1)))
GO
ALTER TABLE [Sales].[ShoppingCartItem] CHECK CONSTRAINT [CK_ShoppingCartItem_Quantity]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Check constraint [Quantity] >= (1)' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'ShoppingCartItem', @level2type=N'CONSTRAINT',@level2name=N'CK_ShoppingCartItem_Quantity'
GO
/****** Object:  Check [CK_SpecialOffer_DiscountPct]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[SpecialOffer]  WITH CHECK ADD  CONSTRAINT [CK_SpecialOffer_DiscountPct] CHECK  (([DiscountPct]>=(0.00)))
GO
ALTER TABLE [Sales].[SpecialOffer] CHECK CONSTRAINT [CK_SpecialOffer_DiscountPct]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Check constraint [DiscountPct] >= (0.00)' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SpecialOffer', @level2type=N'CONSTRAINT',@level2name=N'CK_SpecialOffer_DiscountPct'
GO
/****** Object:  Check [CK_SpecialOffer_EndDate]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[SpecialOffer]  WITH CHECK ADD  CONSTRAINT [CK_SpecialOffer_EndDate] CHECK  (([EndDate]>=[StartDate]))
GO
ALTER TABLE [Sales].[SpecialOffer] CHECK CONSTRAINT [CK_SpecialOffer_EndDate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Check constraint [EndDate] >= [StartDate]' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SpecialOffer', @level2type=N'CONSTRAINT',@level2name=N'CK_SpecialOffer_EndDate'
GO
/****** Object:  Check [CK_SpecialOffer_MaxQty]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[SpecialOffer]  WITH CHECK ADD  CONSTRAINT [CK_SpecialOffer_MaxQty] CHECK  (([MaxQty]>=(0)))
GO
ALTER TABLE [Sales].[SpecialOffer] CHECK CONSTRAINT [CK_SpecialOffer_MaxQty]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Check constraint [MaxQty] >= (0)' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SpecialOffer', @level2type=N'CONSTRAINT',@level2name=N'CK_SpecialOffer_MaxQty'
GO
/****** Object:  Check [CK_SpecialOffer_MinQty]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[SpecialOffer]  WITH CHECK ADD  CONSTRAINT [CK_SpecialOffer_MinQty] CHECK  (([MinQty]>=(0)))
GO
ALTER TABLE [Sales].[SpecialOffer] CHECK CONSTRAINT [CK_SpecialOffer_MinQty]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Check constraint [MinQty] >= (0)' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SpecialOffer', @level2type=N'CONSTRAINT',@level2name=N'CK_SpecialOffer_MinQty'
GO
/****** Object:  ForeignKey [FK_Employee_Person_BusinessEntityID]    Script Date: 11/22/2013 20:49:40 ******/
ALTER TABLE [HumanResources].[Employee]  WITH CHECK ADD  CONSTRAINT [FK_Employee_Person_BusinessEntityID] FOREIGN KEY([BusinessEntityID])
REFERENCES [Person].[Person] ([BusinessEntityID])
GO
ALTER TABLE [HumanResources].[Employee] CHECK CONSTRAINT [FK_Employee_Person_BusinessEntityID]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key constraint referencing Person.BusinessEntityID.' , @level0type=N'SCHEMA',@level0name=N'HumanResources', @level1type=N'TABLE',@level1name=N'Employee', @level2type=N'CONSTRAINT',@level2name=N'FK_Employee_Person_BusinessEntityID'
GO
/****** Object:  ForeignKey [FK_EmployeeDepartmentHistory_Department_DepartmentID]    Script Date: 11/22/2013 20:49:40 ******/
ALTER TABLE [HumanResources].[EmployeeDepartmentHistory]  WITH CHECK ADD  CONSTRAINT [FK_EmployeeDepartmentHistory_Department_DepartmentID] FOREIGN KEY([DepartmentID])
REFERENCES [HumanResources].[Department] ([DepartmentID])
GO
ALTER TABLE [HumanResources].[EmployeeDepartmentHistory] CHECK CONSTRAINT [FK_EmployeeDepartmentHistory_Department_DepartmentID]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key constraint referencing Department.DepartmentID.' , @level0type=N'SCHEMA',@level0name=N'HumanResources', @level1type=N'TABLE',@level1name=N'EmployeeDepartmentHistory', @level2type=N'CONSTRAINT',@level2name=N'FK_EmployeeDepartmentHistory_Department_DepartmentID'
GO
/****** Object:  ForeignKey [FK_EmployeeDepartmentHistory_Employee_BusinessEntityID]    Script Date: 11/22/2013 20:49:40 ******/
ALTER TABLE [HumanResources].[EmployeeDepartmentHistory]  WITH CHECK ADD  CONSTRAINT [FK_EmployeeDepartmentHistory_Employee_BusinessEntityID] FOREIGN KEY([BusinessEntityID])
REFERENCES [HumanResources].[Employee] ([BusinessEntityID])
GO
ALTER TABLE [HumanResources].[EmployeeDepartmentHistory] CHECK CONSTRAINT [FK_EmployeeDepartmentHistory_Employee_BusinessEntityID]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key constraint referencing Employee.EmployeeID.' , @level0type=N'SCHEMA',@level0name=N'HumanResources', @level1type=N'TABLE',@level1name=N'EmployeeDepartmentHistory', @level2type=N'CONSTRAINT',@level2name=N'FK_EmployeeDepartmentHistory_Employee_BusinessEntityID'
GO
/****** Object:  ForeignKey [FK_EmployeeDepartmentHistory_Shift_ShiftID]    Script Date: 11/22/2013 20:49:40 ******/
ALTER TABLE [HumanResources].[EmployeeDepartmentHistory]  WITH CHECK ADD  CONSTRAINT [FK_EmployeeDepartmentHistory_Shift_ShiftID] FOREIGN KEY([ShiftID])
REFERENCES [HumanResources].[Shift] ([ShiftID])
GO
ALTER TABLE [HumanResources].[EmployeeDepartmentHistory] CHECK CONSTRAINT [FK_EmployeeDepartmentHistory_Shift_ShiftID]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key constraint referencing Shift.ShiftID' , @level0type=N'SCHEMA',@level0name=N'HumanResources', @level1type=N'TABLE',@level1name=N'EmployeeDepartmentHistory', @level2type=N'CONSTRAINT',@level2name=N'FK_EmployeeDepartmentHistory_Shift_ShiftID'
GO
/****** Object:  ForeignKey [FK_EmployeePayHistory_Employee_BusinessEntityID]    Script Date: 11/22/2013 20:49:40 ******/
ALTER TABLE [HumanResources].[EmployeePayHistory]  WITH CHECK ADD  CONSTRAINT [FK_EmployeePayHistory_Employee_BusinessEntityID] FOREIGN KEY([BusinessEntityID])
REFERENCES [HumanResources].[Employee] ([BusinessEntityID])
GO
ALTER TABLE [HumanResources].[EmployeePayHistory] CHECK CONSTRAINT [FK_EmployeePayHistory_Employee_BusinessEntityID]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key constraint referencing Employee.EmployeeID.' , @level0type=N'SCHEMA',@level0name=N'HumanResources', @level1type=N'TABLE',@level1name=N'EmployeePayHistory', @level2type=N'CONSTRAINT',@level2name=N'FK_EmployeePayHistory_Employee_BusinessEntityID'
GO
/****** Object:  ForeignKey [FK_JobCandidate_Employee_BusinessEntityID]    Script Date: 11/22/2013 20:49:40 ******/
ALTER TABLE [HumanResources].[JobCandidate]  WITH CHECK ADD  CONSTRAINT [FK_JobCandidate_Employee_BusinessEntityID] FOREIGN KEY([BusinessEntityID])
REFERENCES [HumanResources].[Employee] ([BusinessEntityID])
GO
ALTER TABLE [HumanResources].[JobCandidate] CHECK CONSTRAINT [FK_JobCandidate_Employee_BusinessEntityID]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key constraint referencing Employee.EmployeeID.' , @level0type=N'SCHEMA',@level0name=N'HumanResources', @level1type=N'TABLE',@level1name=N'JobCandidate', @level2type=N'CONSTRAINT',@level2name=N'FK_JobCandidate_Employee_BusinessEntityID'
GO
/****** Object:  ForeignKey [FK_Address_StateProvince_StateProvinceID]    Script Date: 11/22/2013 20:49:40 ******/
ALTER TABLE [Person].[Address]  WITH CHECK ADD  CONSTRAINT [FK_Address_StateProvince_StateProvinceID] FOREIGN KEY([StateProvinceID])
REFERENCES [Person].[StateProvince] ([StateProvinceID])
GO
ALTER TABLE [Person].[Address] CHECK CONSTRAINT [FK_Address_StateProvince_StateProvinceID]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key constraint referencing StateProvince.StateProvinceID.' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'Address', @level2type=N'CONSTRAINT',@level2name=N'FK_Address_StateProvince_StateProvinceID'
GO
/****** Object:  ForeignKey [FK_BusinessEntityAddress_Address_AddressID]    Script Date: 11/22/2013 20:49:40 ******/
ALTER TABLE [Person].[BusinessEntityAddress]  WITH CHECK ADD  CONSTRAINT [FK_BusinessEntityAddress_Address_AddressID] FOREIGN KEY([AddressID])
REFERENCES [Person].[Address] ([AddressID])
GO
ALTER TABLE [Person].[BusinessEntityAddress] CHECK CONSTRAINT [FK_BusinessEntityAddress_Address_AddressID]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key constraint referencing Address.AddressID.' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'BusinessEntityAddress', @level2type=N'CONSTRAINT',@level2name=N'FK_BusinessEntityAddress_Address_AddressID'
GO
/****** Object:  ForeignKey [FK_BusinessEntityAddress_AddressType_AddressTypeID]    Script Date: 11/22/2013 20:49:40 ******/
ALTER TABLE [Person].[BusinessEntityAddress]  WITH CHECK ADD  CONSTRAINT [FK_BusinessEntityAddress_AddressType_AddressTypeID] FOREIGN KEY([AddressTypeID])
REFERENCES [Person].[AddressType] ([AddressTypeID])
GO
ALTER TABLE [Person].[BusinessEntityAddress] CHECK CONSTRAINT [FK_BusinessEntityAddress_AddressType_AddressTypeID]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key constraint referencing AddressType.AddressTypeID.' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'BusinessEntityAddress', @level2type=N'CONSTRAINT',@level2name=N'FK_BusinessEntityAddress_AddressType_AddressTypeID'
GO
/****** Object:  ForeignKey [FK_BusinessEntityAddress_BusinessEntity_BusinessEntityID]    Script Date: 11/22/2013 20:49:40 ******/
ALTER TABLE [Person].[BusinessEntityAddress]  WITH CHECK ADD  CONSTRAINT [FK_BusinessEntityAddress_BusinessEntity_BusinessEntityID] FOREIGN KEY([BusinessEntityID])
REFERENCES [Person].[BusinessEntity] ([BusinessEntityID])
GO
ALTER TABLE [Person].[BusinessEntityAddress] CHECK CONSTRAINT [FK_BusinessEntityAddress_BusinessEntity_BusinessEntityID]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key constraint referencing BusinessEntity.BusinessEntityID.' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'BusinessEntityAddress', @level2type=N'CONSTRAINT',@level2name=N'FK_BusinessEntityAddress_BusinessEntity_BusinessEntityID'
GO
/****** Object:  ForeignKey [FK_BusinessEntityContact_BusinessEntity_BusinessEntityID]    Script Date: 11/22/2013 20:49:40 ******/
ALTER TABLE [Person].[BusinessEntityContact]  WITH CHECK ADD  CONSTRAINT [FK_BusinessEntityContact_BusinessEntity_BusinessEntityID] FOREIGN KEY([BusinessEntityID])
REFERENCES [Person].[BusinessEntity] ([BusinessEntityID])
GO
ALTER TABLE [Person].[BusinessEntityContact] CHECK CONSTRAINT [FK_BusinessEntityContact_BusinessEntity_BusinessEntityID]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key constraint referencing BusinessEntity.BusinessEntityID.' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'BusinessEntityContact', @level2type=N'CONSTRAINT',@level2name=N'FK_BusinessEntityContact_BusinessEntity_BusinessEntityID'
GO
/****** Object:  ForeignKey [FK_BusinessEntityContact_ContactType_ContactTypeID]    Script Date: 11/22/2013 20:49:40 ******/
ALTER TABLE [Person].[BusinessEntityContact]  WITH CHECK ADD  CONSTRAINT [FK_BusinessEntityContact_ContactType_ContactTypeID] FOREIGN KEY([ContactTypeID])
REFERENCES [Person].[ContactType] ([ContactTypeID])
GO
ALTER TABLE [Person].[BusinessEntityContact] CHECK CONSTRAINT [FK_BusinessEntityContact_ContactType_ContactTypeID]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key constraint referencing ContactType.ContactTypeID.' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'BusinessEntityContact', @level2type=N'CONSTRAINT',@level2name=N'FK_BusinessEntityContact_ContactType_ContactTypeID'
GO
/****** Object:  ForeignKey [FK_BusinessEntityContact_Person_PersonID]    Script Date: 11/22/2013 20:49:40 ******/
ALTER TABLE [Person].[BusinessEntityContact]  WITH CHECK ADD  CONSTRAINT [FK_BusinessEntityContact_Person_PersonID] FOREIGN KEY([PersonID])
REFERENCES [Person].[Person] ([BusinessEntityID])
GO
ALTER TABLE [Person].[BusinessEntityContact] CHECK CONSTRAINT [FK_BusinessEntityContact_Person_PersonID]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key constraint referencing Person.BusinessEntityID.' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'BusinessEntityContact', @level2type=N'CONSTRAINT',@level2name=N'FK_BusinessEntityContact_Person_PersonID'
GO
/****** Object:  ForeignKey [FK_EmailAddress_Person_BusinessEntityID]    Script Date: 11/22/2013 20:49:40 ******/
ALTER TABLE [Person].[EmailAddress]  WITH CHECK ADD  CONSTRAINT [FK_EmailAddress_Person_BusinessEntityID] FOREIGN KEY([BusinessEntityID])
REFERENCES [Person].[Person] ([BusinessEntityID])
GO
ALTER TABLE [Person].[EmailAddress] CHECK CONSTRAINT [FK_EmailAddress_Person_BusinessEntityID]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key constraint referencing Person.BusinessEntityID.' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'EmailAddress', @level2type=N'CONSTRAINT',@level2name=N'FK_EmailAddress_Person_BusinessEntityID'
GO
/****** Object:  ForeignKey [FK_Password_Person_BusinessEntityID]    Script Date: 11/22/2013 20:49:40 ******/
ALTER TABLE [Person].[Password]  WITH CHECK ADD  CONSTRAINT [FK_Password_Person_BusinessEntityID] FOREIGN KEY([BusinessEntityID])
REFERENCES [Person].[Person] ([BusinessEntityID])
GO
ALTER TABLE [Person].[Password] CHECK CONSTRAINT [FK_Password_Person_BusinessEntityID]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key constraint referencing Person.BusinessEntityID.' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'Password', @level2type=N'CONSTRAINT',@level2name=N'FK_Password_Person_BusinessEntityID'
GO
/****** Object:  ForeignKey [FK_Person_BusinessEntity_BusinessEntityID]    Script Date: 11/22/2013 20:49:40 ******/
ALTER TABLE [Person].[Person]  WITH CHECK ADD  CONSTRAINT [FK_Person_BusinessEntity_BusinessEntityID] FOREIGN KEY([BusinessEntityID])
REFERENCES [Person].[BusinessEntity] ([BusinessEntityID])
GO
ALTER TABLE [Person].[Person] CHECK CONSTRAINT [FK_Person_BusinessEntity_BusinessEntityID]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key constraint referencing BusinessEntity.BusinessEntityID.' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'Person', @level2type=N'CONSTRAINT',@level2name=N'FK_Person_BusinessEntity_BusinessEntityID'
GO
/****** Object:  ForeignKey [FK_PersonPhone_Person_BusinessEntityID]    Script Date: 11/22/2013 20:49:40 ******/
ALTER TABLE [Person].[PersonPhone]  WITH CHECK ADD  CONSTRAINT [FK_PersonPhone_Person_BusinessEntityID] FOREIGN KEY([BusinessEntityID])
REFERENCES [Person].[Person] ([BusinessEntityID])
GO
ALTER TABLE [Person].[PersonPhone] CHECK CONSTRAINT [FK_PersonPhone_Person_BusinessEntityID]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key constraint referencing Person.BusinessEntityID.' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'PersonPhone', @level2type=N'CONSTRAINT',@level2name=N'FK_PersonPhone_Person_BusinessEntityID'
GO
/****** Object:  ForeignKey [FK_PersonPhone_PhoneNumberType_PhoneNumberTypeID]    Script Date: 11/22/2013 20:49:40 ******/
ALTER TABLE [Person].[PersonPhone]  WITH CHECK ADD  CONSTRAINT [FK_PersonPhone_PhoneNumberType_PhoneNumberTypeID] FOREIGN KEY([PhoneNumberTypeID])
REFERENCES [Person].[PhoneNumberType] ([PhoneNumberTypeID])
GO
ALTER TABLE [Person].[PersonPhone] CHECK CONSTRAINT [FK_PersonPhone_PhoneNumberType_PhoneNumberTypeID]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key constraint referencing PhoneNumberType.PhoneNumberTypeID.' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'PersonPhone', @level2type=N'CONSTRAINT',@level2name=N'FK_PersonPhone_PhoneNumberType_PhoneNumberTypeID'
GO
/****** Object:  ForeignKey [FK_StateProvince_CountryRegion_CountryRegionCode]    Script Date: 11/22/2013 20:49:40 ******/
ALTER TABLE [Person].[StateProvince]  WITH CHECK ADD  CONSTRAINT [FK_StateProvince_CountryRegion_CountryRegionCode] FOREIGN KEY([CountryRegionCode])
REFERENCES [Person].[CountryRegion] ([CountryRegionCode])
GO
ALTER TABLE [Person].[StateProvince] CHECK CONSTRAINT [FK_StateProvince_CountryRegion_CountryRegionCode]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key constraint referencing CountryRegion.CountryRegionCode.' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'StateProvince', @level2type=N'CONSTRAINT',@level2name=N'FK_StateProvince_CountryRegion_CountryRegionCode'
GO
/****** Object:  ForeignKey [FK_StateProvince_SalesTerritory_TerritoryID]    Script Date: 11/22/2013 20:49:40 ******/
ALTER TABLE [Person].[StateProvince]  WITH CHECK ADD  CONSTRAINT [FK_StateProvince_SalesTerritory_TerritoryID] FOREIGN KEY([TerritoryID])
REFERENCES [Sales].[SalesTerritory] ([TerritoryID])
GO
ALTER TABLE [Person].[StateProvince] CHECK CONSTRAINT [FK_StateProvince_SalesTerritory_TerritoryID]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key constraint referencing SalesTerritory.TerritoryID.' , @level0type=N'SCHEMA',@level0name=N'Person', @level1type=N'TABLE',@level1name=N'StateProvince', @level2type=N'CONSTRAINT',@level2name=N'FK_StateProvince_SalesTerritory_TerritoryID'
GO
/****** Object:  ForeignKey [FK_BillOfMaterials_Product_ComponentID]    Script Date: 11/22/2013 20:49:40 ******/
ALTER TABLE [Production].[BillOfMaterials]  WITH CHECK ADD  CONSTRAINT [FK_BillOfMaterials_Product_ComponentID] FOREIGN KEY([ComponentID])
REFERENCES [Production].[Product] ([ProductID])
GO
ALTER TABLE [Production].[BillOfMaterials] CHECK CONSTRAINT [FK_BillOfMaterials_Product_ComponentID]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key constraint referencing Product.ComponentID.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'BillOfMaterials', @level2type=N'CONSTRAINT',@level2name=N'FK_BillOfMaterials_Product_ComponentID'
GO
/****** Object:  ForeignKey [FK_BillOfMaterials_Product_ProductAssemblyID]    Script Date: 11/22/2013 20:49:40 ******/
ALTER TABLE [Production].[BillOfMaterials]  WITH CHECK ADD  CONSTRAINT [FK_BillOfMaterials_Product_ProductAssemblyID] FOREIGN KEY([ProductAssemblyID])
REFERENCES [Production].[Product] ([ProductID])
GO
ALTER TABLE [Production].[BillOfMaterials] CHECK CONSTRAINT [FK_BillOfMaterials_Product_ProductAssemblyID]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key constraint referencing Product.ProductAssemblyID.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'BillOfMaterials', @level2type=N'CONSTRAINT',@level2name=N'FK_BillOfMaterials_Product_ProductAssemblyID'
GO
/****** Object:  ForeignKey [FK_BillOfMaterials_UnitMeasure_UnitMeasureCode]    Script Date: 11/22/2013 20:49:40 ******/
ALTER TABLE [Production].[BillOfMaterials]  WITH CHECK ADD  CONSTRAINT [FK_BillOfMaterials_UnitMeasure_UnitMeasureCode] FOREIGN KEY([UnitMeasureCode])
REFERENCES [Production].[UnitMeasure] ([UnitMeasureCode])
GO
ALTER TABLE [Production].[BillOfMaterials] CHECK CONSTRAINT [FK_BillOfMaterials_UnitMeasure_UnitMeasureCode]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key constraint referencing UnitMeasure.UnitMeasureCode.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'BillOfMaterials', @level2type=N'CONSTRAINT',@level2name=N'FK_BillOfMaterials_UnitMeasure_UnitMeasureCode'
GO
/****** Object:  ForeignKey [FK_Document_Employee_Owner]    Script Date: 11/22/2013 20:49:40 ******/
ALTER TABLE [Production].[Document]  WITH CHECK ADD  CONSTRAINT [FK_Document_Employee_Owner] FOREIGN KEY([Owner])
REFERENCES [HumanResources].[Employee] ([BusinessEntityID])
GO
ALTER TABLE [Production].[Document] CHECK CONSTRAINT [FK_Document_Employee_Owner]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key constraint referencing Employee.BusinessEntityID.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'Document', @level2type=N'CONSTRAINT',@level2name=N'FK_Document_Employee_Owner'
GO
/****** Object:  ForeignKey [FK_Product_ProductModel_ProductModelID]    Script Date: 11/22/2013 20:49:40 ******/
ALTER TABLE [Production].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_ProductModel_ProductModelID] FOREIGN KEY([ProductModelID])
REFERENCES [Production].[ProductModel] ([ProductModelID])
GO
ALTER TABLE [Production].[Product] CHECK CONSTRAINT [FK_Product_ProductModel_ProductModelID]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key constraint referencing ProductModel.ProductModelID.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'Product', @level2type=N'CONSTRAINT',@level2name=N'FK_Product_ProductModel_ProductModelID'
GO
/****** Object:  ForeignKey [FK_Product_ProductSubcategory_ProductSubcategoryID]    Script Date: 11/22/2013 20:49:40 ******/
ALTER TABLE [Production].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_ProductSubcategory_ProductSubcategoryID] FOREIGN KEY([ProductSubcategoryID])
REFERENCES [Production].[ProductSubcategory] ([ProductSubcategoryID])
GO
ALTER TABLE [Production].[Product] CHECK CONSTRAINT [FK_Product_ProductSubcategory_ProductSubcategoryID]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key constraint referencing ProductSubcategory.ProductSubcategoryID.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'Product', @level2type=N'CONSTRAINT',@level2name=N'FK_Product_ProductSubcategory_ProductSubcategoryID'
GO
/****** Object:  ForeignKey [FK_Product_UnitMeasure_SizeUnitMeasureCode]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Production].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_UnitMeasure_SizeUnitMeasureCode] FOREIGN KEY([SizeUnitMeasureCode])
REFERENCES [Production].[UnitMeasure] ([UnitMeasureCode])
GO
ALTER TABLE [Production].[Product] CHECK CONSTRAINT [FK_Product_UnitMeasure_SizeUnitMeasureCode]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key constraint referencing UnitMeasure.UnitMeasureCode.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'Product', @level2type=N'CONSTRAINT',@level2name=N'FK_Product_UnitMeasure_SizeUnitMeasureCode'
GO
/****** Object:  ForeignKey [FK_Product_UnitMeasure_WeightUnitMeasureCode]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Production].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_UnitMeasure_WeightUnitMeasureCode] FOREIGN KEY([WeightUnitMeasureCode])
REFERENCES [Production].[UnitMeasure] ([UnitMeasureCode])
GO
ALTER TABLE [Production].[Product] CHECK CONSTRAINT [FK_Product_UnitMeasure_WeightUnitMeasureCode]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key constraint referencing UnitMeasure.UnitMeasureCode.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'Product', @level2type=N'CONSTRAINT',@level2name=N'FK_Product_UnitMeasure_WeightUnitMeasureCode'
GO
/****** Object:  ForeignKey [FK_ProductCostHistory_Product_ProductID]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Production].[ProductCostHistory]  WITH CHECK ADD  CONSTRAINT [FK_ProductCostHistory_Product_ProductID] FOREIGN KEY([ProductID])
REFERENCES [Production].[Product] ([ProductID])
GO
ALTER TABLE [Production].[ProductCostHistory] CHECK CONSTRAINT [FK_ProductCostHistory_Product_ProductID]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key constraint referencing Product.ProductID.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductCostHistory', @level2type=N'CONSTRAINT',@level2name=N'FK_ProductCostHistory_Product_ProductID'
GO
/****** Object:  ForeignKey [FK_ProductDocument_Document_DocumentNode]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Production].[ProductDocument]  WITH CHECK ADD  CONSTRAINT [FK_ProductDocument_Document_DocumentNode] FOREIGN KEY([DocumentNode])
REFERENCES [Production].[Document] ([DocumentNode])
GO
ALTER TABLE [Production].[ProductDocument] CHECK CONSTRAINT [FK_ProductDocument_Document_DocumentNode]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key constraint referencing Document.DocumentNode.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductDocument', @level2type=N'CONSTRAINT',@level2name=N'FK_ProductDocument_Document_DocumentNode'
GO
/****** Object:  ForeignKey [FK_ProductDocument_Product_ProductID]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Production].[ProductDocument]  WITH CHECK ADD  CONSTRAINT [FK_ProductDocument_Product_ProductID] FOREIGN KEY([ProductID])
REFERENCES [Production].[Product] ([ProductID])
GO
ALTER TABLE [Production].[ProductDocument] CHECK CONSTRAINT [FK_ProductDocument_Product_ProductID]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key constraint referencing Product.ProductID.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductDocument', @level2type=N'CONSTRAINT',@level2name=N'FK_ProductDocument_Product_ProductID'
GO
/****** Object:  ForeignKey [FK_ProductInventory_Location_LocationID]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Production].[ProductInventory]  WITH CHECK ADD  CONSTRAINT [FK_ProductInventory_Location_LocationID] FOREIGN KEY([LocationID])
REFERENCES [Production].[Location] ([LocationID])
GO
ALTER TABLE [Production].[ProductInventory] CHECK CONSTRAINT [FK_ProductInventory_Location_LocationID]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key constraint referencing Location.LocationID.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductInventory', @level2type=N'CONSTRAINT',@level2name=N'FK_ProductInventory_Location_LocationID'
GO
/****** Object:  ForeignKey [FK_ProductInventory_Product_ProductID]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Production].[ProductInventory]  WITH CHECK ADD  CONSTRAINT [FK_ProductInventory_Product_ProductID] FOREIGN KEY([ProductID])
REFERENCES [Production].[Product] ([ProductID])
GO
ALTER TABLE [Production].[ProductInventory] CHECK CONSTRAINT [FK_ProductInventory_Product_ProductID]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key constraint referencing Product.ProductID.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductInventory', @level2type=N'CONSTRAINT',@level2name=N'FK_ProductInventory_Product_ProductID'
GO
/****** Object:  ForeignKey [FK_ProductListPriceHistory_Product_ProductID]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Production].[ProductListPriceHistory]  WITH CHECK ADD  CONSTRAINT [FK_ProductListPriceHistory_Product_ProductID] FOREIGN KEY([ProductID])
REFERENCES [Production].[Product] ([ProductID])
GO
ALTER TABLE [Production].[ProductListPriceHistory] CHECK CONSTRAINT [FK_ProductListPriceHistory_Product_ProductID]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key constraint referencing Product.ProductID.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductListPriceHistory', @level2type=N'CONSTRAINT',@level2name=N'FK_ProductListPriceHistory_Product_ProductID'
GO
/****** Object:  ForeignKey [FK_ProductModelIllustration_Illustration_IllustrationID]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Production].[ProductModelIllustration]  WITH CHECK ADD  CONSTRAINT [FK_ProductModelIllustration_Illustration_IllustrationID] FOREIGN KEY([IllustrationID])
REFERENCES [Production].[Illustration] ([IllustrationID])
GO
ALTER TABLE [Production].[ProductModelIllustration] CHECK CONSTRAINT [FK_ProductModelIllustration_Illustration_IllustrationID]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key constraint referencing Illustration.IllustrationID.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductModelIllustration', @level2type=N'CONSTRAINT',@level2name=N'FK_ProductModelIllustration_Illustration_IllustrationID'
GO
/****** Object:  ForeignKey [FK_ProductModelIllustration_ProductModel_ProductModelID]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Production].[ProductModelIllustration]  WITH CHECK ADD  CONSTRAINT [FK_ProductModelIllustration_ProductModel_ProductModelID] FOREIGN KEY([ProductModelID])
REFERENCES [Production].[ProductModel] ([ProductModelID])
GO
ALTER TABLE [Production].[ProductModelIllustration] CHECK CONSTRAINT [FK_ProductModelIllustration_ProductModel_ProductModelID]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key constraint referencing ProductModel.ProductModelID.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductModelIllustration', @level2type=N'CONSTRAINT',@level2name=N'FK_ProductModelIllustration_ProductModel_ProductModelID'
GO
/****** Object:  ForeignKey [FK_ProductModelProductDescriptionCulture_Culture_CultureID]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Production].[ProductModelProductDescriptionCulture]  WITH CHECK ADD  CONSTRAINT [FK_ProductModelProductDescriptionCulture_Culture_CultureID] FOREIGN KEY([CultureID])
REFERENCES [Production].[Culture] ([CultureID])
GO
ALTER TABLE [Production].[ProductModelProductDescriptionCulture] CHECK CONSTRAINT [FK_ProductModelProductDescriptionCulture_Culture_CultureID]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key constraint referencing Culture.CultureID.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductModelProductDescriptionCulture', @level2type=N'CONSTRAINT',@level2name=N'FK_ProductModelProductDescriptionCulture_Culture_CultureID'
GO
/****** Object:  ForeignKey [FK_ProductModelProductDescriptionCulture_ProductDescription_ProductDescriptionID]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Production].[ProductModelProductDescriptionCulture]  WITH CHECK ADD  CONSTRAINT [FK_ProductModelProductDescriptionCulture_ProductDescription_ProductDescriptionID] FOREIGN KEY([ProductDescriptionID])
REFERENCES [Production].[ProductDescription] ([ProductDescriptionID])
GO
ALTER TABLE [Production].[ProductModelProductDescriptionCulture] CHECK CONSTRAINT [FK_ProductModelProductDescriptionCulture_ProductDescription_ProductDescriptionID]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key constraint referencing ProductDescription.ProductDescriptionID.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductModelProductDescriptionCulture', @level2type=N'CONSTRAINT',@level2name=N'FK_ProductModelProductDescriptionCulture_ProductDescription_ProductDescriptionID'
GO
/****** Object:  ForeignKey [FK_ProductModelProductDescriptionCulture_ProductModel_ProductModelID]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Production].[ProductModelProductDescriptionCulture]  WITH CHECK ADD  CONSTRAINT [FK_ProductModelProductDescriptionCulture_ProductModel_ProductModelID] FOREIGN KEY([ProductModelID])
REFERENCES [Production].[ProductModel] ([ProductModelID])
GO
ALTER TABLE [Production].[ProductModelProductDescriptionCulture] CHECK CONSTRAINT [FK_ProductModelProductDescriptionCulture_ProductModel_ProductModelID]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key constraint referencing ProductModel.ProductModelID.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductModelProductDescriptionCulture', @level2type=N'CONSTRAINT',@level2name=N'FK_ProductModelProductDescriptionCulture_ProductModel_ProductModelID'
GO
/****** Object:  ForeignKey [FK_ProductProductPhoto_Product_ProductID]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Production].[ProductProductPhoto]  WITH CHECK ADD  CONSTRAINT [FK_ProductProductPhoto_Product_ProductID] FOREIGN KEY([ProductID])
REFERENCES [Production].[Product] ([ProductID])
GO
ALTER TABLE [Production].[ProductProductPhoto] CHECK CONSTRAINT [FK_ProductProductPhoto_Product_ProductID]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key constraint referencing Product.ProductID.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductProductPhoto', @level2type=N'CONSTRAINT',@level2name=N'FK_ProductProductPhoto_Product_ProductID'
GO
/****** Object:  ForeignKey [FK_ProductProductPhoto_ProductPhoto_ProductPhotoID]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Production].[ProductProductPhoto]  WITH CHECK ADD  CONSTRAINT [FK_ProductProductPhoto_ProductPhoto_ProductPhotoID] FOREIGN KEY([ProductPhotoID])
REFERENCES [Production].[ProductPhoto] ([ProductPhotoID])
GO
ALTER TABLE [Production].[ProductProductPhoto] CHECK CONSTRAINT [FK_ProductProductPhoto_ProductPhoto_ProductPhotoID]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key constraint referencing ProductPhoto.ProductPhotoID.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductProductPhoto', @level2type=N'CONSTRAINT',@level2name=N'FK_ProductProductPhoto_ProductPhoto_ProductPhotoID'
GO
/****** Object:  ForeignKey [FK_ProductReview_Product_ProductID]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Production].[ProductReview]  WITH CHECK ADD  CONSTRAINT [FK_ProductReview_Product_ProductID] FOREIGN KEY([ProductID])
REFERENCES [Production].[Product] ([ProductID])
GO
ALTER TABLE [Production].[ProductReview] CHECK CONSTRAINT [FK_ProductReview_Product_ProductID]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key constraint referencing Product.ProductID.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductReview', @level2type=N'CONSTRAINT',@level2name=N'FK_ProductReview_Product_ProductID'
GO
/****** Object:  ForeignKey [FK_ProductSubcategory_ProductCategory_ProductCategoryID]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Production].[ProductSubcategory]  WITH CHECK ADD  CONSTRAINT [FK_ProductSubcategory_ProductCategory_ProductCategoryID] FOREIGN KEY([ProductCategoryID])
REFERENCES [Production].[ProductCategory] ([ProductCategoryID])
GO
ALTER TABLE [Production].[ProductSubcategory] CHECK CONSTRAINT [FK_ProductSubcategory_ProductCategory_ProductCategoryID]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key constraint referencing ProductCategory.ProductCategoryID.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'ProductSubcategory', @level2type=N'CONSTRAINT',@level2name=N'FK_ProductSubcategory_ProductCategory_ProductCategoryID'
GO
/****** Object:  ForeignKey [FK_TransactionHistory_Product_ProductID]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Production].[TransactionHistory]  WITH CHECK ADD  CONSTRAINT [FK_TransactionHistory_Product_ProductID] FOREIGN KEY([ProductID])
REFERENCES [Production].[Product] ([ProductID])
GO
ALTER TABLE [Production].[TransactionHistory] CHECK CONSTRAINT [FK_TransactionHistory_Product_ProductID]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key constraint referencing Product.ProductID.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'TransactionHistory', @level2type=N'CONSTRAINT',@level2name=N'FK_TransactionHistory_Product_ProductID'
GO
/****** Object:  ForeignKey [FK_WorkOrder_Product_ProductID]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Production].[WorkOrder]  WITH CHECK ADD  CONSTRAINT [FK_WorkOrder_Product_ProductID] FOREIGN KEY([ProductID])
REFERENCES [Production].[Product] ([ProductID])
GO
ALTER TABLE [Production].[WorkOrder] CHECK CONSTRAINT [FK_WorkOrder_Product_ProductID]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key constraint referencing Product.ProductID.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'WorkOrder', @level2type=N'CONSTRAINT',@level2name=N'FK_WorkOrder_Product_ProductID'
GO
/****** Object:  ForeignKey [FK_WorkOrder_ScrapReason_ScrapReasonID]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Production].[WorkOrder]  WITH CHECK ADD  CONSTRAINT [FK_WorkOrder_ScrapReason_ScrapReasonID] FOREIGN KEY([ScrapReasonID])
REFERENCES [Production].[ScrapReason] ([ScrapReasonID])
GO
ALTER TABLE [Production].[WorkOrder] CHECK CONSTRAINT [FK_WorkOrder_ScrapReason_ScrapReasonID]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key constraint referencing ScrapReason.ScrapReasonID.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'WorkOrder', @level2type=N'CONSTRAINT',@level2name=N'FK_WorkOrder_ScrapReason_ScrapReasonID'
GO
/****** Object:  ForeignKey [FK_WorkOrderRouting_Location_LocationID]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Production].[WorkOrderRouting]  WITH CHECK ADD  CONSTRAINT [FK_WorkOrderRouting_Location_LocationID] FOREIGN KEY([LocationID])
REFERENCES [Production].[Location] ([LocationID])
GO
ALTER TABLE [Production].[WorkOrderRouting] CHECK CONSTRAINT [FK_WorkOrderRouting_Location_LocationID]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key constraint referencing Location.LocationID.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'WorkOrderRouting', @level2type=N'CONSTRAINT',@level2name=N'FK_WorkOrderRouting_Location_LocationID'
GO
/****** Object:  ForeignKey [FK_WorkOrderRouting_WorkOrder_WorkOrderID]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Production].[WorkOrderRouting]  WITH CHECK ADD  CONSTRAINT [FK_WorkOrderRouting_WorkOrder_WorkOrderID] FOREIGN KEY([WorkOrderID])
REFERENCES [Production].[WorkOrder] ([WorkOrderID])
GO
ALTER TABLE [Production].[WorkOrderRouting] CHECK CONSTRAINT [FK_WorkOrderRouting_WorkOrder_WorkOrderID]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key constraint referencing WorkOrder.WorkOrderID.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'TABLE',@level1name=N'WorkOrderRouting', @level2type=N'CONSTRAINT',@level2name=N'FK_WorkOrderRouting_WorkOrder_WorkOrderID'
GO
/****** Object:  ForeignKey [FK_ProductVendor_Product_ProductID]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Purchasing].[ProductVendor]  WITH CHECK ADD  CONSTRAINT [FK_ProductVendor_Product_ProductID] FOREIGN KEY([ProductID])
REFERENCES [Production].[Product] ([ProductID])
GO
ALTER TABLE [Purchasing].[ProductVendor] CHECK CONSTRAINT [FK_ProductVendor_Product_ProductID]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key constraint referencing Product.ProductID.' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'ProductVendor', @level2type=N'CONSTRAINT',@level2name=N'FK_ProductVendor_Product_ProductID'
GO
/****** Object:  ForeignKey [FK_ProductVendor_UnitMeasure_UnitMeasureCode]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Purchasing].[ProductVendor]  WITH CHECK ADD  CONSTRAINT [FK_ProductVendor_UnitMeasure_UnitMeasureCode] FOREIGN KEY([UnitMeasureCode])
REFERENCES [Production].[UnitMeasure] ([UnitMeasureCode])
GO
ALTER TABLE [Purchasing].[ProductVendor] CHECK CONSTRAINT [FK_ProductVendor_UnitMeasure_UnitMeasureCode]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key constraint referencing UnitMeasure.UnitMeasureCode.' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'ProductVendor', @level2type=N'CONSTRAINT',@level2name=N'FK_ProductVendor_UnitMeasure_UnitMeasureCode'
GO
/****** Object:  ForeignKey [FK_ProductVendor_Vendor_BusinessEntityID]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Purchasing].[ProductVendor]  WITH CHECK ADD  CONSTRAINT [FK_ProductVendor_Vendor_BusinessEntityID] FOREIGN KEY([BusinessEntityID])
REFERENCES [Purchasing].[Vendor] ([BusinessEntityID])
GO
ALTER TABLE [Purchasing].[ProductVendor] CHECK CONSTRAINT [FK_ProductVendor_Vendor_BusinessEntityID]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key constraint referencing Vendor.BusinessEntityID.' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'ProductVendor', @level2type=N'CONSTRAINT',@level2name=N'FK_ProductVendor_Vendor_BusinessEntityID'
GO
/****** Object:  ForeignKey [FK_PurchaseOrderDetail_Product_ProductID]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Purchasing].[PurchaseOrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_PurchaseOrderDetail_Product_ProductID] FOREIGN KEY([ProductID])
REFERENCES [Production].[Product] ([ProductID])
GO
ALTER TABLE [Purchasing].[PurchaseOrderDetail] CHECK CONSTRAINT [FK_PurchaseOrderDetail_Product_ProductID]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key constraint referencing Product.ProductID.' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'PurchaseOrderDetail', @level2type=N'CONSTRAINT',@level2name=N'FK_PurchaseOrderDetail_Product_ProductID'
GO
/****** Object:  ForeignKey [FK_PurchaseOrderDetail_PurchaseOrderHeader_PurchaseOrderID]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Purchasing].[PurchaseOrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_PurchaseOrderDetail_PurchaseOrderHeader_PurchaseOrderID] FOREIGN KEY([PurchaseOrderID])
REFERENCES [Purchasing].[PurchaseOrderHeader] ([PurchaseOrderID])
GO
ALTER TABLE [Purchasing].[PurchaseOrderDetail] CHECK CONSTRAINT [FK_PurchaseOrderDetail_PurchaseOrderHeader_PurchaseOrderID]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key constraint referencing PurchaseOrderHeader.PurchaseOrderID.' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'PurchaseOrderDetail', @level2type=N'CONSTRAINT',@level2name=N'FK_PurchaseOrderDetail_PurchaseOrderHeader_PurchaseOrderID'
GO
/****** Object:  ForeignKey [FK_PurchaseOrderHeader_Employee_EmployeeID]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Purchasing].[PurchaseOrderHeader]  WITH CHECK ADD  CONSTRAINT [FK_PurchaseOrderHeader_Employee_EmployeeID] FOREIGN KEY([EmployeeID])
REFERENCES [HumanResources].[Employee] ([BusinessEntityID])
GO
ALTER TABLE [Purchasing].[PurchaseOrderHeader] CHECK CONSTRAINT [FK_PurchaseOrderHeader_Employee_EmployeeID]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key constraint referencing Employee.EmployeeID.' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'PurchaseOrderHeader', @level2type=N'CONSTRAINT',@level2name=N'FK_PurchaseOrderHeader_Employee_EmployeeID'
GO
/****** Object:  ForeignKey [FK_PurchaseOrderHeader_ShipMethod_ShipMethodID]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Purchasing].[PurchaseOrderHeader]  WITH CHECK ADD  CONSTRAINT [FK_PurchaseOrderHeader_ShipMethod_ShipMethodID] FOREIGN KEY([ShipMethodID])
REFERENCES [Purchasing].[ShipMethod] ([ShipMethodID])
GO
ALTER TABLE [Purchasing].[PurchaseOrderHeader] CHECK CONSTRAINT [FK_PurchaseOrderHeader_ShipMethod_ShipMethodID]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key constraint referencing ShipMethod.ShipMethodID.' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'PurchaseOrderHeader', @level2type=N'CONSTRAINT',@level2name=N'FK_PurchaseOrderHeader_ShipMethod_ShipMethodID'
GO
/****** Object:  ForeignKey [FK_PurchaseOrderHeader_Vendor_VendorID]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Purchasing].[PurchaseOrderHeader]  WITH CHECK ADD  CONSTRAINT [FK_PurchaseOrderHeader_Vendor_VendorID] FOREIGN KEY([VendorID])
REFERENCES [Purchasing].[Vendor] ([BusinessEntityID])
GO
ALTER TABLE [Purchasing].[PurchaseOrderHeader] CHECK CONSTRAINT [FK_PurchaseOrderHeader_Vendor_VendorID]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key constraint referencing Vendor.VendorID.' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'PurchaseOrderHeader', @level2type=N'CONSTRAINT',@level2name=N'FK_PurchaseOrderHeader_Vendor_VendorID'
GO
/****** Object:  ForeignKey [FK_Vendor_BusinessEntity_BusinessEntityID]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Purchasing].[Vendor]  WITH CHECK ADD  CONSTRAINT [FK_Vendor_BusinessEntity_BusinessEntityID] FOREIGN KEY([BusinessEntityID])
REFERENCES [Person].[BusinessEntity] ([BusinessEntityID])
GO
ALTER TABLE [Purchasing].[Vendor] CHECK CONSTRAINT [FK_Vendor_BusinessEntity_BusinessEntityID]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key constraint referencing BusinessEntity.BusinessEntityID' , @level0type=N'SCHEMA',@level0name=N'Purchasing', @level1type=N'TABLE',@level1name=N'Vendor', @level2type=N'CONSTRAINT',@level2name=N'FK_Vendor_BusinessEntity_BusinessEntityID'
GO
/****** Object:  ForeignKey [FK_CountryRegionCurrency_CountryRegion_CountryRegionCode]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[CountryRegionCurrency]  WITH CHECK ADD  CONSTRAINT [FK_CountryRegionCurrency_CountryRegion_CountryRegionCode] FOREIGN KEY([CountryRegionCode])
REFERENCES [Person].[CountryRegion] ([CountryRegionCode])
GO
ALTER TABLE [Sales].[CountryRegionCurrency] CHECK CONSTRAINT [FK_CountryRegionCurrency_CountryRegion_CountryRegionCode]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key constraint referencing CountryRegion.CountryRegionCode.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'CountryRegionCurrency', @level2type=N'CONSTRAINT',@level2name=N'FK_CountryRegionCurrency_CountryRegion_CountryRegionCode'
GO
/****** Object:  ForeignKey [FK_CountryRegionCurrency_Currency_CurrencyCode]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[CountryRegionCurrency]  WITH CHECK ADD  CONSTRAINT [FK_CountryRegionCurrency_Currency_CurrencyCode] FOREIGN KEY([CurrencyCode])
REFERENCES [Sales].[Currency] ([CurrencyCode])
GO
ALTER TABLE [Sales].[CountryRegionCurrency] CHECK CONSTRAINT [FK_CountryRegionCurrency_Currency_CurrencyCode]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key constraint referencing Currency.CurrencyCode.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'CountryRegionCurrency', @level2type=N'CONSTRAINT',@level2name=N'FK_CountryRegionCurrency_Currency_CurrencyCode'
GO
/****** Object:  ForeignKey [FK_CurrencyRate_Currency_FromCurrencyCode]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[CurrencyRate]  WITH CHECK ADD  CONSTRAINT [FK_CurrencyRate_Currency_FromCurrencyCode] FOREIGN KEY([FromCurrencyCode])
REFERENCES [Sales].[Currency] ([CurrencyCode])
GO
ALTER TABLE [Sales].[CurrencyRate] CHECK CONSTRAINT [FK_CurrencyRate_Currency_FromCurrencyCode]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key constraint referencing Currency.FromCurrencyCode.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'CurrencyRate', @level2type=N'CONSTRAINT',@level2name=N'FK_CurrencyRate_Currency_FromCurrencyCode'
GO
/****** Object:  ForeignKey [FK_CurrencyRate_Currency_ToCurrencyCode]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[CurrencyRate]  WITH CHECK ADD  CONSTRAINT [FK_CurrencyRate_Currency_ToCurrencyCode] FOREIGN KEY([ToCurrencyCode])
REFERENCES [Sales].[Currency] ([CurrencyCode])
GO
ALTER TABLE [Sales].[CurrencyRate] CHECK CONSTRAINT [FK_CurrencyRate_Currency_ToCurrencyCode]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key constraint referencing Currency.ToCurrencyCode.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'CurrencyRate', @level2type=N'CONSTRAINT',@level2name=N'FK_CurrencyRate_Currency_ToCurrencyCode'
GO
/****** Object:  ForeignKey [FK_Customer_Person_PersonID]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[Customer]  WITH CHECK ADD  CONSTRAINT [FK_Customer_Person_PersonID] FOREIGN KEY([PersonID])
REFERENCES [Person].[Person] ([BusinessEntityID])
GO
ALTER TABLE [Sales].[Customer] CHECK CONSTRAINT [FK_Customer_Person_PersonID]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key constraint referencing Person.BusinessEntityID.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'CONSTRAINT',@level2name=N'FK_Customer_Person_PersonID'
GO
/****** Object:  ForeignKey [FK_Customer_SalesTerritory_TerritoryID]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[Customer]  WITH CHECK ADD  CONSTRAINT [FK_Customer_SalesTerritory_TerritoryID] FOREIGN KEY([TerritoryID])
REFERENCES [Sales].[SalesTerritory] ([TerritoryID])
GO
ALTER TABLE [Sales].[Customer] CHECK CONSTRAINT [FK_Customer_SalesTerritory_TerritoryID]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key constraint referencing SalesTerritory.TerritoryID.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'CONSTRAINT',@level2name=N'FK_Customer_SalesTerritory_TerritoryID'
GO
/****** Object:  ForeignKey [FK_Customer_Store_StoreID]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[Customer]  WITH CHECK ADD  CONSTRAINT [FK_Customer_Store_StoreID] FOREIGN KEY([StoreID])
REFERENCES [Sales].[Store] ([BusinessEntityID])
GO
ALTER TABLE [Sales].[Customer] CHECK CONSTRAINT [FK_Customer_Store_StoreID]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key constraint referencing Store.BusinessEntityID.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'Customer', @level2type=N'CONSTRAINT',@level2name=N'FK_Customer_Store_StoreID'
GO
/****** Object:  ForeignKey [FK_PersonCreditCard_CreditCard_CreditCardID]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[PersonCreditCard]  WITH CHECK ADD  CONSTRAINT [FK_PersonCreditCard_CreditCard_CreditCardID] FOREIGN KEY([CreditCardID])
REFERENCES [Sales].[CreditCard] ([CreditCardID])
GO
ALTER TABLE [Sales].[PersonCreditCard] CHECK CONSTRAINT [FK_PersonCreditCard_CreditCard_CreditCardID]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key constraint referencing CreditCard.CreditCardID.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'PersonCreditCard', @level2type=N'CONSTRAINT',@level2name=N'FK_PersonCreditCard_CreditCard_CreditCardID'
GO
/****** Object:  ForeignKey [FK_PersonCreditCard_Person_BusinessEntityID]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[PersonCreditCard]  WITH CHECK ADD  CONSTRAINT [FK_PersonCreditCard_Person_BusinessEntityID] FOREIGN KEY([BusinessEntityID])
REFERENCES [Person].[Person] ([BusinessEntityID])
GO
ALTER TABLE [Sales].[PersonCreditCard] CHECK CONSTRAINT [FK_PersonCreditCard_Person_BusinessEntityID]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key constraint referencing Person.BusinessEntityID.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'PersonCreditCard', @level2type=N'CONSTRAINT',@level2name=N'FK_PersonCreditCard_Person_BusinessEntityID'
GO
/****** Object:  ForeignKey [FK_SalesOrderDetail_SalesOrderHeader_SalesOrderID]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[SalesOrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_SalesOrderDetail_SalesOrderHeader_SalesOrderID] FOREIGN KEY([SalesOrderID])
REFERENCES [Sales].[SalesOrderHeader] ([SalesOrderID])
ON DELETE CASCADE
GO
ALTER TABLE [Sales].[SalesOrderDetail] CHECK CONSTRAINT [FK_SalesOrderDetail_SalesOrderHeader_SalesOrderID]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key constraint referencing SalesOrderHeader.PurchaseOrderID.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesOrderDetail', @level2type=N'CONSTRAINT',@level2name=N'FK_SalesOrderDetail_SalesOrderHeader_SalesOrderID'
GO
/****** Object:  ForeignKey [FK_SalesOrderDetail_SpecialOfferProduct_SpecialOfferIDProductID]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[SalesOrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_SalesOrderDetail_SpecialOfferProduct_SpecialOfferIDProductID] FOREIGN KEY([SpecialOfferID], [ProductID])
REFERENCES [Sales].[SpecialOfferProduct] ([SpecialOfferID], [ProductID])
GO
ALTER TABLE [Sales].[SalesOrderDetail] CHECK CONSTRAINT [FK_SalesOrderDetail_SpecialOfferProduct_SpecialOfferIDProductID]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key constraint referencing SpecialOfferProduct.SpecialOfferIDProductID.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesOrderDetail', @level2type=N'CONSTRAINT',@level2name=N'FK_SalesOrderDetail_SpecialOfferProduct_SpecialOfferIDProductID'
GO
/****** Object:  ForeignKey [FK_SalesOrderHeader_Address_BillToAddressID]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[SalesOrderHeader]  WITH CHECK ADD  CONSTRAINT [FK_SalesOrderHeader_Address_BillToAddressID] FOREIGN KEY([BillToAddressID])
REFERENCES [Person].[Address] ([AddressID])
GO
ALTER TABLE [Sales].[SalesOrderHeader] CHECK CONSTRAINT [FK_SalesOrderHeader_Address_BillToAddressID]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key constraint referencing Address.AddressID.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesOrderHeader', @level2type=N'CONSTRAINT',@level2name=N'FK_SalesOrderHeader_Address_BillToAddressID'
GO
/****** Object:  ForeignKey [FK_SalesOrderHeader_Address_ShipToAddressID]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[SalesOrderHeader]  WITH CHECK ADD  CONSTRAINT [FK_SalesOrderHeader_Address_ShipToAddressID] FOREIGN KEY([ShipToAddressID])
REFERENCES [Person].[Address] ([AddressID])
GO
ALTER TABLE [Sales].[SalesOrderHeader] CHECK CONSTRAINT [FK_SalesOrderHeader_Address_ShipToAddressID]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key constraint referencing Address.AddressID.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesOrderHeader', @level2type=N'CONSTRAINT',@level2name=N'FK_SalesOrderHeader_Address_ShipToAddressID'
GO
/****** Object:  ForeignKey [FK_SalesOrderHeader_CreditCard_CreditCardID]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[SalesOrderHeader]  WITH CHECK ADD  CONSTRAINT [FK_SalesOrderHeader_CreditCard_CreditCardID] FOREIGN KEY([CreditCardID])
REFERENCES [Sales].[CreditCard] ([CreditCardID])
GO
ALTER TABLE [Sales].[SalesOrderHeader] CHECK CONSTRAINT [FK_SalesOrderHeader_CreditCard_CreditCardID]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key constraint referencing CreditCard.CreditCardID.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesOrderHeader', @level2type=N'CONSTRAINT',@level2name=N'FK_SalesOrderHeader_CreditCard_CreditCardID'
GO
/****** Object:  ForeignKey [FK_SalesOrderHeader_CurrencyRate_CurrencyRateID]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[SalesOrderHeader]  WITH CHECK ADD  CONSTRAINT [FK_SalesOrderHeader_CurrencyRate_CurrencyRateID] FOREIGN KEY([CurrencyRateID])
REFERENCES [Sales].[CurrencyRate] ([CurrencyRateID])
GO
ALTER TABLE [Sales].[SalesOrderHeader] CHECK CONSTRAINT [FK_SalesOrderHeader_CurrencyRate_CurrencyRateID]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key constraint referencing CurrencyRate.CurrencyRateID.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesOrderHeader', @level2type=N'CONSTRAINT',@level2name=N'FK_SalesOrderHeader_CurrencyRate_CurrencyRateID'
GO
/****** Object:  ForeignKey [FK_SalesOrderHeader_Customer_CustomerID]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[SalesOrderHeader]  WITH CHECK ADD  CONSTRAINT [FK_SalesOrderHeader_Customer_CustomerID] FOREIGN KEY([CustomerID])
REFERENCES [Sales].[Customer] ([CustomerID])
GO
ALTER TABLE [Sales].[SalesOrderHeader] CHECK CONSTRAINT [FK_SalesOrderHeader_Customer_CustomerID]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key constraint referencing Customer.CustomerID.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesOrderHeader', @level2type=N'CONSTRAINT',@level2name=N'FK_SalesOrderHeader_Customer_CustomerID'
GO
/****** Object:  ForeignKey [FK_SalesOrderHeader_SalesPerson_SalesPersonID]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[SalesOrderHeader]  WITH CHECK ADD  CONSTRAINT [FK_SalesOrderHeader_SalesPerson_SalesPersonID] FOREIGN KEY([SalesPersonID])
REFERENCES [Sales].[SalesPerson] ([BusinessEntityID])
GO
ALTER TABLE [Sales].[SalesOrderHeader] CHECK CONSTRAINT [FK_SalesOrderHeader_SalesPerson_SalesPersonID]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key constraint referencing SalesPerson.SalesPersonID.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesOrderHeader', @level2type=N'CONSTRAINT',@level2name=N'FK_SalesOrderHeader_SalesPerson_SalesPersonID'
GO
/****** Object:  ForeignKey [FK_SalesOrderHeader_SalesTerritory_TerritoryID]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[SalesOrderHeader]  WITH CHECK ADD  CONSTRAINT [FK_SalesOrderHeader_SalesTerritory_TerritoryID] FOREIGN KEY([TerritoryID])
REFERENCES [Sales].[SalesTerritory] ([TerritoryID])
GO
ALTER TABLE [Sales].[SalesOrderHeader] CHECK CONSTRAINT [FK_SalesOrderHeader_SalesTerritory_TerritoryID]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key constraint referencing SalesTerritory.TerritoryID.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesOrderHeader', @level2type=N'CONSTRAINT',@level2name=N'FK_SalesOrderHeader_SalesTerritory_TerritoryID'
GO
/****** Object:  ForeignKey [FK_SalesOrderHeader_ShipMethod_ShipMethodID]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[SalesOrderHeader]  WITH CHECK ADD  CONSTRAINT [FK_SalesOrderHeader_ShipMethod_ShipMethodID] FOREIGN KEY([ShipMethodID])
REFERENCES [Purchasing].[ShipMethod] ([ShipMethodID])
GO
ALTER TABLE [Sales].[SalesOrderHeader] CHECK CONSTRAINT [FK_SalesOrderHeader_ShipMethod_ShipMethodID]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key constraint referencing ShipMethod.ShipMethodID.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesOrderHeader', @level2type=N'CONSTRAINT',@level2name=N'FK_SalesOrderHeader_ShipMethod_ShipMethodID'
GO
/****** Object:  ForeignKey [FK_SalesOrderHeaderSalesReason_SalesOrderHeader_SalesOrderID]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[SalesOrderHeaderSalesReason]  WITH CHECK ADD  CONSTRAINT [FK_SalesOrderHeaderSalesReason_SalesOrderHeader_SalesOrderID] FOREIGN KEY([SalesOrderID])
REFERENCES [Sales].[SalesOrderHeader] ([SalesOrderID])
ON DELETE CASCADE
GO
ALTER TABLE [Sales].[SalesOrderHeaderSalesReason] CHECK CONSTRAINT [FK_SalesOrderHeaderSalesReason_SalesOrderHeader_SalesOrderID]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key constraint referencing SalesOrderHeader.SalesOrderID.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesOrderHeaderSalesReason', @level2type=N'CONSTRAINT',@level2name=N'FK_SalesOrderHeaderSalesReason_SalesOrderHeader_SalesOrderID'
GO
/****** Object:  ForeignKey [FK_SalesOrderHeaderSalesReason_SalesReason_SalesReasonID]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[SalesOrderHeaderSalesReason]  WITH CHECK ADD  CONSTRAINT [FK_SalesOrderHeaderSalesReason_SalesReason_SalesReasonID] FOREIGN KEY([SalesReasonID])
REFERENCES [Sales].[SalesReason] ([SalesReasonID])
GO
ALTER TABLE [Sales].[SalesOrderHeaderSalesReason] CHECK CONSTRAINT [FK_SalesOrderHeaderSalesReason_SalesReason_SalesReasonID]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key constraint referencing SalesReason.SalesReasonID.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesOrderHeaderSalesReason', @level2type=N'CONSTRAINT',@level2name=N'FK_SalesOrderHeaderSalesReason_SalesReason_SalesReasonID'
GO
/****** Object:  ForeignKey [FK_SalesPerson_Employee_BusinessEntityID]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[SalesPerson]  WITH CHECK ADD  CONSTRAINT [FK_SalesPerson_Employee_BusinessEntityID] FOREIGN KEY([BusinessEntityID])
REFERENCES [HumanResources].[Employee] ([BusinessEntityID])
GO
ALTER TABLE [Sales].[SalesPerson] CHECK CONSTRAINT [FK_SalesPerson_Employee_BusinessEntityID]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key constraint referencing Employee.EmployeeID.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesPerson', @level2type=N'CONSTRAINT',@level2name=N'FK_SalesPerson_Employee_BusinessEntityID'
GO
/****** Object:  ForeignKey [FK_SalesPerson_SalesTerritory_TerritoryID]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[SalesPerson]  WITH CHECK ADD  CONSTRAINT [FK_SalesPerson_SalesTerritory_TerritoryID] FOREIGN KEY([TerritoryID])
REFERENCES [Sales].[SalesTerritory] ([TerritoryID])
GO
ALTER TABLE [Sales].[SalesPerson] CHECK CONSTRAINT [FK_SalesPerson_SalesTerritory_TerritoryID]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key constraint referencing SalesTerritory.TerritoryID.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesPerson', @level2type=N'CONSTRAINT',@level2name=N'FK_SalesPerson_SalesTerritory_TerritoryID'
GO
/****** Object:  ForeignKey [FK_SalesPersonQuotaHistory_SalesPerson_BusinessEntityID]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[SalesPersonQuotaHistory]  WITH CHECK ADD  CONSTRAINT [FK_SalesPersonQuotaHistory_SalesPerson_BusinessEntityID] FOREIGN KEY([BusinessEntityID])
REFERENCES [Sales].[SalesPerson] ([BusinessEntityID])
GO
ALTER TABLE [Sales].[SalesPersonQuotaHistory] CHECK CONSTRAINT [FK_SalesPersonQuotaHistory_SalesPerson_BusinessEntityID]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key constraint referencing SalesPerson.SalesPersonID.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesPersonQuotaHistory', @level2type=N'CONSTRAINT',@level2name=N'FK_SalesPersonQuotaHistory_SalesPerson_BusinessEntityID'
GO
/****** Object:  ForeignKey [FK_SalesTaxRate_StateProvince_StateProvinceID]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[SalesTaxRate]  WITH CHECK ADD  CONSTRAINT [FK_SalesTaxRate_StateProvince_StateProvinceID] FOREIGN KEY([StateProvinceID])
REFERENCES [Person].[StateProvince] ([StateProvinceID])
GO
ALTER TABLE [Sales].[SalesTaxRate] CHECK CONSTRAINT [FK_SalesTaxRate_StateProvince_StateProvinceID]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key constraint referencing StateProvince.StateProvinceID.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesTaxRate', @level2type=N'CONSTRAINT',@level2name=N'FK_SalesTaxRate_StateProvince_StateProvinceID'
GO
/****** Object:  ForeignKey [FK_SalesTerritory_CountryRegion_CountryRegionCode]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[SalesTerritory]  WITH CHECK ADD  CONSTRAINT [FK_SalesTerritory_CountryRegion_CountryRegionCode] FOREIGN KEY([CountryRegionCode])
REFERENCES [Person].[CountryRegion] ([CountryRegionCode])
GO
ALTER TABLE [Sales].[SalesTerritory] CHECK CONSTRAINT [FK_SalesTerritory_CountryRegion_CountryRegionCode]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key constraint referencing CountryRegion.CountryRegionCode.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesTerritory', @level2type=N'CONSTRAINT',@level2name=N'FK_SalesTerritory_CountryRegion_CountryRegionCode'
GO
/****** Object:  ForeignKey [FK_SalesTerritoryHistory_SalesPerson_BusinessEntityID]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[SalesTerritoryHistory]  WITH CHECK ADD  CONSTRAINT [FK_SalesTerritoryHistory_SalesPerson_BusinessEntityID] FOREIGN KEY([BusinessEntityID])
REFERENCES [Sales].[SalesPerson] ([BusinessEntityID])
GO
ALTER TABLE [Sales].[SalesTerritoryHistory] CHECK CONSTRAINT [FK_SalesTerritoryHistory_SalesPerson_BusinessEntityID]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key constraint referencing SalesPerson.SalesPersonID.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesTerritoryHistory', @level2type=N'CONSTRAINT',@level2name=N'FK_SalesTerritoryHistory_SalesPerson_BusinessEntityID'
GO
/****** Object:  ForeignKey [FK_SalesTerritoryHistory_SalesTerritory_TerritoryID]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[SalesTerritoryHistory]  WITH CHECK ADD  CONSTRAINT [FK_SalesTerritoryHistory_SalesTerritory_TerritoryID] FOREIGN KEY([TerritoryID])
REFERENCES [Sales].[SalesTerritory] ([TerritoryID])
GO
ALTER TABLE [Sales].[SalesTerritoryHistory] CHECK CONSTRAINT [FK_SalesTerritoryHistory_SalesTerritory_TerritoryID]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key constraint referencing SalesTerritory.TerritoryID.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SalesTerritoryHistory', @level2type=N'CONSTRAINT',@level2name=N'FK_SalesTerritoryHistory_SalesTerritory_TerritoryID'
GO
/****** Object:  ForeignKey [FK_ShoppingCartItem_Product_ProductID]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[ShoppingCartItem]  WITH CHECK ADD  CONSTRAINT [FK_ShoppingCartItem_Product_ProductID] FOREIGN KEY([ProductID])
REFERENCES [Production].[Product] ([ProductID])
GO
ALTER TABLE [Sales].[ShoppingCartItem] CHECK CONSTRAINT [FK_ShoppingCartItem_Product_ProductID]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key constraint referencing Product.ProductID.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'ShoppingCartItem', @level2type=N'CONSTRAINT',@level2name=N'FK_ShoppingCartItem_Product_ProductID'
GO
/****** Object:  ForeignKey [FK_SpecialOfferProduct_Product_ProductID]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[SpecialOfferProduct]  WITH CHECK ADD  CONSTRAINT [FK_SpecialOfferProduct_Product_ProductID] FOREIGN KEY([ProductID])
REFERENCES [Production].[Product] ([ProductID])
GO
ALTER TABLE [Sales].[SpecialOfferProduct] CHECK CONSTRAINT [FK_SpecialOfferProduct_Product_ProductID]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key constraint referencing Product.ProductID.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SpecialOfferProduct', @level2type=N'CONSTRAINT',@level2name=N'FK_SpecialOfferProduct_Product_ProductID'
GO
/****** Object:  ForeignKey [FK_SpecialOfferProduct_SpecialOffer_SpecialOfferID]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[SpecialOfferProduct]  WITH CHECK ADD  CONSTRAINT [FK_SpecialOfferProduct_SpecialOffer_SpecialOfferID] FOREIGN KEY([SpecialOfferID])
REFERENCES [Sales].[SpecialOffer] ([SpecialOfferID])
GO
ALTER TABLE [Sales].[SpecialOfferProduct] CHECK CONSTRAINT [FK_SpecialOfferProduct_SpecialOffer_SpecialOfferID]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key constraint referencing SpecialOffer.SpecialOfferID.' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'SpecialOfferProduct', @level2type=N'CONSTRAINT',@level2name=N'FK_SpecialOfferProduct_SpecialOffer_SpecialOfferID'
GO
/****** Object:  ForeignKey [FK_Store_BusinessEntity_BusinessEntityID]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[Store]  WITH CHECK ADD  CONSTRAINT [FK_Store_BusinessEntity_BusinessEntityID] FOREIGN KEY([BusinessEntityID])
REFERENCES [Person].[BusinessEntity] ([BusinessEntityID])
GO
ALTER TABLE [Sales].[Store] CHECK CONSTRAINT [FK_Store_BusinessEntity_BusinessEntityID]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key constraint referencing BusinessEntity.BusinessEntityID' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'Store', @level2type=N'CONSTRAINT',@level2name=N'FK_Store_BusinessEntity_BusinessEntityID'
GO
/****** Object:  ForeignKey [FK_Store_SalesPerson_SalesPersonID]    Script Date: 11/22/2013 20:49:41 ******/
ALTER TABLE [Sales].[Store]  WITH CHECK ADD  CONSTRAINT [FK_Store_SalesPerson_SalesPersonID] FOREIGN KEY([SalesPersonID])
REFERENCES [Sales].[SalesPerson] ([BusinessEntityID])
GO
ALTER TABLE [Sales].[Store] CHECK CONSTRAINT [FK_Store_SalesPerson_SalesPersonID]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key constraint referencing SalesPerson.SalesPersonID' , @level0type=N'SCHEMA',@level0name=N'Sales', @level1type=N'TABLE',@level1name=N'Store', @level2type=N'CONSTRAINT',@level2name=N'FK_Store_SalesPerson_SalesPersonID'
GO
/****** Object:  DdlTrigger [ddlDatabaseTriggerLog]    Script Date: 11/22/2013 20:49:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [ddlDatabaseTriggerLog] ON DATABASE 
FOR DDL_DATABASE_LEVEL_EVENTS AS 
BEGIN
    SET NOCOUNT ON;

    DECLARE @data XML;
    DECLARE @schema sysname;
    DECLARE @object sysname;
    DECLARE @eventType sysname;

    SET @data = EVENTDATA();
    SET @eventType = @data.value('(/EVENT_INSTANCE/EventType)[1]', 'sysname');
    SET @schema = @data.value('(/EVENT_INSTANCE/SchemaName)[1]', 'sysname');
    SET @object = @data.value('(/EVENT_INSTANCE/ObjectName)[1]', 'sysname') 

    IF @object IS NOT NULL
        PRINT '  ' + @eventType + ' - ' + @schema + '.' + @object;
    ELSE
        PRINT '  ' + @eventType + ' - ' + @schema;

    IF @eventType IS NULL
        PRINT CONVERT(nvarchar(max), @data);

    INSERT [dbo].[DatabaseLog] 
        (
        [PostTime], 
        [DatabaseUser], 
        [Event], 
        [Schema], 
        [Object], 
        [TSQL], 
        [XmlEvent]
        ) 
    VALUES 
        (
        GETDATE(), 
        CONVERT(sysname, CURRENT_USER), 
        @eventType, 
        CONVERT(sysname, @schema), 
        CONVERT(sysname, @object), 
        @data.value('(/EVENT_INSTANCE/TSQLCommand)[1]', 'nvarchar(max)'), 
        @data
        );
END;
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
DISABLE TRIGGER [ddlDatabaseTriggerLog] ON DATABASE
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Database trigger to audit all of the DDL changes made to the AdventureWorks2008R2 database.' , @level0type=N'TRIGGER',@level0name=N'ddlDatabaseTriggerLog'
GO

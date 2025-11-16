-- Script tạo database và các bảng cho hệ thống Libman
-- Chạy script này trong MySQL để tạo database và các bảng

CREATE DATABASE IF NOT EXISTS libman CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE libman;

-- Bảng Fullname
CREATE TABLE IF NOT EXISTS tblFullname (
    id INT(10) AUTO_INCREMENT PRIMARY KEY,
    firstname VARCHAR(255),
    middlename VARCHAR(255),
    lastname VARCHAR(255)
);

-- Bảng Address
CREATE TABLE IF NOT EXISTS tblAddress (
    id INT(10) AUTO_INCREMENT PRIMARY KEY,
    homenumber VARCHAR(255),
    building VARCHAR(255),
    street VARCHAR(255),
    wardcommune VARCHAR(255)
);

-- Bảng Member
CREATE TABLE IF NOT EXISTS tblMember (
    id INT(10) AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) UNIQUE,
    password VARCHAR(255),
    tblFullnameid INT(10),
    email VARCHAR(255) UNIQUE,
    phonenumber VARCHAR(255) UNIQUE,
    tblAddressid INT(10),
    role VARCHAR(255),
    note VARCHAR(255),
    FOREIGN KEY (tblFullnameid) REFERENCES tblFullname(id),
    FOREIGN KEY (tblAddressid) REFERENCES tblAddress(id)
);

-- Bảng Reader
CREATE TABLE IF NOT EXISTS tblReader (
    id INT(10) AUTO_INCREMENT PRIMARY KEY,
    reputationScore INT(10),
    note VARCHAR(255),
    tblMemberid INT(10),
    FOREIGN KEY (tblMemberid) REFERENCES tblMember(id)
);

-- Bảng ReaderCard
CREATE TABLE IF NOT EXISTS tblReaderCard (
    id INT(10) AUTO_INCREMENT PRIMARY KEY,
    cardcode VARCHAR(25) UNIQUE,
    userimage VARCHAR(500),
    registerdate DATE,
    status VARCHAR(25),
    tblReaderid INT(10),
    FOREIGN KEY (tblReaderid) REFERENCES tblReader(id)
);

-- Bảng Staff
CREATE TABLE IF NOT EXISTS tblStaff (
    id INT(10) AUTO_INCREMENT PRIMARY KEY,
    staffCode VARCHAR(255) UNIQUE,
    position VARCHAR(255),
    tblMemberid INT(10),
    FOREIGN KEY (tblMemberid) REFERENCES tblMember(id)
);

-- Bảng Supplier
CREATE TABLE IF NOT EXISTS tblSupplier (
    id INT(10) AUTO_INCREMENT PRIMARY KEY,
    supplierCode VARCHAR(255) UNIQUE,
    supplierName VARCHAR(255),
    phoneNumber VARCHAR(255),
    address VARCHAR(255)
);

-- Bảng Document
CREATE TABLE IF NOT EXISTS tblDocument (
    id INT(10) AUTO_INCREMENT PRIMARY KEY,
    documentCode VARCHAR(255) UNIQUE,
    documentName VARCHAR(255),
    author VARCHAR(255),
    publisherYear DATE
);

-- Bảng ImportedInvoice
CREATE TABLE IF NOT EXISTS tblImportedInvoice (
    id INT(10) AUTO_INCREMENT PRIMARY KEY,
    importedCode INT(10) UNIQUE,
    importedDate DATE,
    tblSupplierid INT(10),
    tblStaffid INT(10),
    FOREIGN KEY (tblSupplierid) REFERENCES tblSupplier(id),
    FOREIGN KEY (tblStaffid) REFERENCES tblStaff(id)
);

-- Bảng ImportedInvoiceDetail
CREATE TABLE IF NOT EXISTS tblImportedInvoiceDetail (
    id INT(10) AUTO_INCREMENT PRIMARY KEY,
    code VARCHAR(255) UNIQUE,
    tblImportedInvoiceid INT(10),
    tblDocumentid INT(10),
    FOREIGN KEY (tblImportedInvoiceid) REFERENCES tblImportedInvoice(id),
    FOREIGN KEY (tblDocumentid) REFERENCES tblDocument(id)
);

-- Bảng LoanSlip
CREATE TABLE IF NOT EXISTS tblLoanSlip (
    id INT(10) AUTO_INCREMENT PRIMARY KEY,
    loanCode VARCHAR(255) UNIQUE,
    checkoutTime DATE,
    borrowingTime DATE
);

-- Bảng LoanSlipDetail
CREATE TABLE IF NOT EXISTS tblLoanSlipDetail (
    id INT(10) AUTO_INCREMENT PRIMARY KEY,
    code VARCHAR(255) UNIQUE,
    tblLoanSlipid INT(10),
    tblDocumentid INT(10),
    FOREIGN KEY (tblLoanSlipid) REFERENCES tblLoanSlip(id),
    FOREIGN KEY (tblDocumentid) REFERENCES tblDocument(id)
);

-- Bảng ReturnSlip
CREATE TABLE IF NOT EXISTS tblReturnSlip (
    id INT(10) AUTO_INCREMENT PRIMARY KEY,
    code VARCHAR(255) UNIQUE,
    tblReaderid INT(10),
    tblStaffid INT(10),
    FOREIGN KEY (tblReaderid) REFERENCES tblReader(id),
    FOREIGN KEY (tblStaffid) REFERENCES tblStaff(id)
);

-- Bảng ReturnSlipDetail
CREATE TABLE IF NOT EXISTS tblReturnSlipDetail (
    id INT(10) AUTO_INCREMENT PRIMARY KEY,
    code VARCHAR(255) UNIQUE,
    tblReturnSlipid INT(10),
    FOREIGN KEY (tblReturnSlipid) REFERENCES tblReturnSlip(id)
);


use libman;
select * from user_accounts;
select * from username;
select * from tblMember;
select * from tblSupplier;
select * from tblImportedInvoice;
select * from tblImportedInvoiceDetail;
select * from tblDocument;
select * from tblStaff;
select * from user_accounts;
INSERT INTO tblMember
(id, username, password, tblFullnameid, email, phonenumber, tblAddressid, role, note) VALUES
(10, 'reader6',  '123456', 1, 'reader6@example.com',  '0911111111', 1, 'Reader', 'Đọc giả mẫu'),
(11, 'reader7',  '123456', 2, 'reader7@example.com',  '0922222222', 2, 'Reader', 'Đọc giả mẫu'),
(12, 'reader8',  '123456', 4, 'reader8@example.com',  '0933333333', 4, 'Reader', 'Đọc giả mẫu'),
(13, 'reader9',  '123456', 5, 'reader9@example.com',  '0944444444', 5, 'Reader', 'Đọc giả mẫu'),
(14, 'reader10', '123456', 8, 'reader10@example.com', '0955555555', 9, 'Reader', 'Đọc giả mẫu'),
(15, 'user1',    '123456', 1, 'user1@example.com',    '0966666666', 1, 'Reader', 'Đọc giả mẫu'),
(16, 'user2',    '123456', 2, 'user2@example.com',    '0977777777', 2, 'Reader', 'Đọc giả mẫu'),
(17, 'user3',    '123456', 4, 'user3@example.com',    '0988888888', 4, 'Reader', 'Đọc giả mẫu'),
(18, 'user4',    '123456', 5, 'user4@example.com',    '0999999999', 5, 'Reader', 'Đọc giả mẫu'),
(19, 'user5',    '123456', 8, 'user5@example.com',    '0900000000', 9, 'Reader', 'Đọc giả mẫu');

INSERT INTO tblMember
(id, username, password, tblFullnameid, email, phonenumber, tblAddressid, role, note) VALUES
(20, 'libstaff1',  '123456', 1, 'libstaff1@example.com', '0901111111', 1, 'LibraryStaff', 'Nhân viên thư viện mẫu'),
(21, 'libstaff2',  '123456', 2, 'libstaff2@example.com', '0902222222', 2, 'LibraryStaff', 'Nhân viên thư viện mẫu'),
(22, 'libstaff3',  '123456', 4, 'libstaff3@example.com', '0903333333', 4, 'LibraryStaff', 'Nhân viên thư viện mẫu'),
(23, 'libstaff4',  '123456', 5, 'libstaff4@example.com', '0904444444', 5, 'LibraryStaff', 'Nhân viên thư viện mẫu'),
(24, 'libstaff5',  '123456', 8, 'libstaff5@example.com', '0905555555', 9, 'LibraryStaff', 'Nhân viên thư viện mẫu'),
(25, 'libstaff6',  '123456', 1, 'libstaff6@example.com', '0906666666', 1, 'LibraryStaff', 'Nhân viên thư viện mẫu'),
(26, 'libstaff7',  '123456', 2, 'libstaff7@example.com', '0907777777', 2, 'LibraryStaff', 'Nhân viên thư viện mẫu'),
(27, 'libstaff8',  '123456', 4, 'libstaff8@example.com', '0908888888', 4, 'LibraryStaff', 'Nhân viên thư viện mẫu'),
(28, 'libstaff9',  '123456', 5, 'libstaff9@example.com', '0909999999', 5, 'LibraryStaff', 'Nhân viên thư viện mẫu'),
(29, 'libstaff10', '123456', 8, 'libstaff10@example.com', '0910000000', 9, 'LibraryStaff', 'Nhân viên thư viện mẫu');

INSERT INTO tblSupplier (id, supplierCode, supplierName, phoneNumber, address) VALUES
(3,  'SUP003', 'Nhà sách GHI',            '0123456782', '789 Đường ABC, Quận 3, TP.HCM'),
(4,  'SUP004', 'Công ty phát hành sách JKL', '0123456783', '321 Đường DEF, Quận 4, TP.HCM'),
(5,  'SUP005', 'Nhà xuất bản MNO',        '0123456784', '654 Đường GHI, Quận 5, TP.HCM'),
(6,  'SUP006', 'Nhà sách PQR',            '0123456785', '987 Đường JKL, Quận 6, TP.HCM'),
(7,  'SUP007', 'Công ty sách STU',        '0123456786', '159 Đường MNO, Quận 7, TP.HCM'),
(8,  'SUP008', 'Nhà sách VWX',            '0123456787', '753 Đường PQR, Quận 8, TP.HCM'),
(9,  'SUP009', 'Nhà phân phối sách YZA',  '0123456788', '852 Đường STU, Quận 9, TP.HCM'),
(10, 'SUP010', 'Company Book BCD',        '0123456789', '951 Đường VWX, TP Thủ Đức, TP.HCM'),
(11, 'SUP011', 'Nhà sách EFG',            '0123456790', '246 Đường ABC, TP Thủ Đức, TP.HCM'),
(12, 'SUP012', 'Công ty sách HIJ',        '0123456791', '135 Đường DEF, Quận 10, TP.HCM');

update tblStaff 
set position = "Management Staff"
where id = 1;

INSERT INTO tblStaff (id, staffCode, position, tblMemberid) VALUES
(2,  'ST002', 'Library Staff', 20),
(3,  'ST003', 'Library Staff', 21),
(4,  'ST004', 'Library Staff', 22),
(5,  'ST005', 'Library Staff', 23),
(6,  'ST006', 'Library Staff', 24),
(7,  'ST007', 'Library Staff', 25),
(8,  'ST008', 'Library Staff', 26),
(9,  'ST009', 'Library Staff', 27),
(10, 'ST010', 'Library Staff', 28),
(11, 'ST011', 'Library Staff', 29);
INSERT INTO tblDocument (id, documentCode, documentName, author, publisherYear) VALUES
(4,  'DOC004', 'Cấu trúc dữ liệu và giải thuật', 'Nguyễn Minh D', '2023-04-01'),
(5,  'DOC005', 'Hệ điều hành', 'Trần Thanh E', '2023-05-01'),
(6,  'DOC006', 'Công nghệ phần mềm', 'Lê Hoàng F', '2023-06-01'),
(7,  'DOC007', 'Nhập môn trí tuệ nhân tạo', 'Phạm Ngọc G', '2023-07-01'),
(8,  'DOC008', 'Học máy cơ bản', 'Hoàng Văn H', '2023-08-01'),
(9,  'DOC009', 'Thị giác máy tính', 'Ngô Thanh I', '2023-09-01'),
(10, 'DOC010', 'Xử lý ảnh số', 'Đỗ Minh K', '2023-10-01'),
(11, 'DOC011', 'Lập trình Python', 'Nguyễn Quốc L', '2023-11-01'),
(12, 'DOC012', 'Lập trình C++ nâng cao', 'Trần Sơn M', '2023-12-01'),
(13, 'DOC013', 'Cơ sở mạng máy tính', 'Phạm Văn N', '2024-01-01'),
(14, 'DOC014', 'Phân tích thiết kế hệ thống', 'Đinh Hải O', '2024-02-01'),
(15, 'DOC015', 'Quản trị cơ sở dữ liệu', 'Lê Chí P', '2024-03-01'),
(16, 'DOC016', 'Nhập môn an toàn thông tin', 'Võ Trọng Q', '2024-04-01'),
(17, 'DOC017', 'Điện toán đám mây', 'Nguyễn Tấn R', '2024-05-01'),
(18, 'DOC018', 'Khai phá dữ liệu', 'Trần Thái S', '2024-06-01'),
(19, 'DOC019', 'Phân tích dữ liệu lớn', 'Lê Nhật T', '2024-07-01'),
(20, 'DOC020', 'Kỹ thuật lập trình', 'Đặng Hữu U', '2024-08-01'),
(21, 'DOC021', 'Nhập môn IoT', 'Nguyễn Hải V', '2024-09-01'),
(22, 'DOC022', 'Thiết kế web', 'Phạm Trung X', '2024-10-01'),
(23, 'DOC023', 'Phát triển ứng dụng di động', 'Lê Văn Y', '2024-11-01');

INSERT INTO tblImportedInvoice (id, importedCode, importedDate, tblSupplierid, tblStaffid) VALUES
(1, 1001, '2025-09-01', 3, 2),
(2, 1002, '2025-09-02', 1, 4),
(3, 1003, '2025-09-03', 5, 6),
(4, 1004, '2025-09-05', 2, 7),
(5, 1005, '2025-09-06', 7, 3),
(6, 1006, '2025-09-08', 4, 8),
(7, 1007, '2025-09-10', 9, 10),
(8, 1008, '2025-09-12', 6, 5),
(9, 1009, '2025-09-14', 8, 9),
(10, 1010, '2025-09-15', 11, 11),
(11, 1011, '2025-09-17', 10, 2),
(12, 1012, '2025-09-19', 12, 3),
(13, 1013, '2025-09-20', 3, 4),
(14, 1014, '2025-09-22', 5, 6),
(15, 1015, '2025-09-23', 7, 7),
(16, 1016, '2025-09-25', 1, 8),
(17, 1017, '2025-09-27', 4, 9),
(18, 1018, '2025-09-29', 6, 10),
(19, 1019, '2025-09-30', 8, 11),

(20, 1020, '2025-10-02', 2, 2),
(21, 1021, '2025-10-04', 3, 3),
(22, 1022, '2025-10-06', 5, 4),
(23, 1023, '2025-10-07', 7, 5),
(24, 1024, '2025-10-09', 4, 6),
(25, 1025, '2025-10-11', 1, 7),
(26, 1026, '2025-10-13', 9, 8),
(27, 1027, '2025-10-14', 8, 9),
(28, 1028, '2025-10-16', 6, 10),
(29, 1029, '2025-10-18', 12, 11),
(30, 1030, '2025-10-20', 10, 2),
(31, 1031, '2025-10-21', 11, 3),
(32, 1032, '2025-10-23', 9, 4),
(33, 1033, '2025-10-24', 3, 5),
(34, 1034, '2025-10-26', 4, 6),
(35, 1035, '2025-10-28', 7, 7),
(36, 1036, '2025-10-29', 5, 8),
(37, 1037, '2025-10-31', 2, 9),

(38, 1038, '2025-11-01', 1, 10),
(39, 1039, '2025-11-03', 8, 11),
(40, 1040, '2025-11-04', 6, 2),
(41, 1041, '2025-11-06', 7, 3),
(42, 1042, '2025-11-07', 5, 4),
(43, 1043, '2025-11-09', 2, 5),
(44, 1044, '2025-11-10', 3, 6),
(45, 1045, '2025-11-12', 4, 7),
(46, 1046, '2025-11-13', 10, 8),
(47, 1047, '2025-11-14', 12, 9),
(48, 1048, '2025-11-15', 9, 10),
(49, 1049, '2025-11-16', 8, 11),
(50, 1050, '2025-11-16', 6, 3);


INSERT INTO tblImportedInvoiceDetail (id, code, tblImportedInvoiceid, tblDocumentid) VALUES
(1, 'DT001', 1, 5),
(2, 'DT002', 2, 12),
(3, 'DT003', 3, 7),
(4, 'DT004', 4, 18),
(5, 'DT005', 5, 3),
(6, 'DT006', 6, 9),
(7, 'DT007', 7, 14),
(8, 'DT008', 8, 21),
(9, 'DT009', 9, 1),
(10, 'DT010', 10, 11),

(11, 'DT011', 11, 4),
(12, 'DT012', 12, 16),
(13, 'DT013', 13, 20),
(14, 'DT014', 14, 23),
(15, 'DT015', 15, 8),
(16, 'DT016', 16, 6),
(17, 'DT017', 17, 2),
(18, 'DT018', 18, 19),
(19, 'DT019', 19, 13),
(20, 'DT020', 20, 10),

(21, 'DT021', 21, 17),
(22, 'DT022', 22, 5),
(23, 'DT023', 23, 7),
(24, 'DT024', 24, 3),
(25, 'DT025', 25, 15),
(26, 'DT026', 26, 9),
(27, 'DT027', 27, 12),
(28, 'DT028', 28, 4),
(29, 'DT029', 29, 20),
(30, 'DT030', 30, 18),

(31, 'DT031', 31, 16),
(32, 'DT032', 32, 22),
(33, 'DT033', 33, 11),
(34, 'DT034', 34, 3),
(35, 'DT035', 35, 14),
(36, 'DT036', 36, 1),
(37, 'DT037', 37, 8),
(38, 'DT038', 38, 23),
(39, 'DT039', 39, 10),
(40, 'DT040', 40, 6),

(41, 'DT041', 41, 19),
(42, 'DT042', 42, 5),
(43, 'DT043', 43, 9),
(44, 'DT044', 44, 15),
(45, 'DT045', 45, 7),
(46, 'DT046', 46, 12),
(47, 'DT047', 47, 4),
(48, 'DT048', 48, 17),
(49, 'DT049', 49, 22),
(50, 'DT050', 50, 2);

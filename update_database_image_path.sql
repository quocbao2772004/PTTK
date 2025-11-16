-- Script để cập nhật database từ BLOB sang VARCHAR cho userimage
-- Chạy script này trong MySQL để cập nhật schema

USE libman;

-- Đổi cột userimage từ BLOB sang VARCHAR(500) để lưu đường dẫn
ALTER TABLE tblReaderCard MODIFY COLUMN userimage VARCHAR(500);


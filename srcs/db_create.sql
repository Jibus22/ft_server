CREATE DATABASE admindb;
CREATE USER 'admin'@localhost IDENTIFIED BY 'admin';
GRANT ALL PRIVILEGES ON admindb.* TO 'admin'@localhost;
FLUSH PRIVILEGES;

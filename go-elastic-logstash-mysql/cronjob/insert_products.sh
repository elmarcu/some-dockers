#!/bin/bash

# Insert a new product into the MySQL database
mysql -h mysql_db -uuser -ppassword -e "
USE your_database;
INSERT INTO products (name, description, price, updated_at) 
VALUES ('Product $(date +%s)', 'Auto-generated product', ROUND(RAND()*100, 2), NOW());
"

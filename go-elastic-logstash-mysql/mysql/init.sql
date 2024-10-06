CREATE DATABASE IF NOT EXISTS your_database;

USE your_database;

CREATE TABLE IF NOT EXISTS products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO products (name, description, price, updated_at) VALUES
('Product 1', 'Description for product 1', 19.99, NOW()),
('Product 2', 'Description for product 2', 29.99, NOW()),
('Product 3', 'Description for product 3', 9.99, NOW());

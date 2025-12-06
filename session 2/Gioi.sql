CREATE DATABASE SalesDB;

CREATE SCHEMA sales;

set search_path to sales;

CREATE TABLE Customers (
                                 customer_id SERIAL PRIMARY KEY,
                                 first_name VARCHAR(50) NOT NULL,
                                 last_name VARCHAR(50) NOT NULL,
                                 email VARCHAR(100) NOT NULL UNIQUE,
                                 phone VARCHAR(20)
);

CREATE TABLE Products (
                                product_id SERIAL PRIMARY KEY,
                                product_name VARCHAR(100) NOT NULL,
                                price NUMERIC(10, 2) NOT NULL,
                                stock_quantity INTEGER NOT NULL
);

CREATE TABLE Orders (
                              order_id SERIAL PRIMARY KEY,
                              customer_id INTEGER REFERENCES Customers(customer_id),
                              order_date DATE NOT NULL
);

CREATE TABLE sales.OrderItems (
                                  order_item_id SERIAL PRIMARY KEY,
                                  order_id INTEGER REFERENCES Orders(order_id),
                                  product_id INTEGER REFERENCES Products(product_id),
                                  quantity INTEGER NOT NULL CHECK (quantity >= 1),
                                  UNIQUE (order_id, product_id)
);
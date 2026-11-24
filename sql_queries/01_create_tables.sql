-- Run in Query Tool connected to database: computer_repair_analysis
CREATE TABLE categories (
    category_id INTEGER PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL,
    category_type VARCHAR(20) NOT NULL
);
CREATE TABLE services_products (
    item_id INTEGER PRIMARY KEY,
    category_id INTEGER NOT NULL REFERENCES categories(category_id),
    item_name VARCHAR(120) NOT NULL,
    standard_unit_price NUMERIC(10,2) NOT NULL,
    estimated_unit_cost NUMERIC(10,2) NOT NULL
);
CREATE TABLE customers (
    customer_id INTEGER PRIMARY KEY,
    customer_label VARCHAR(50) NOT NULL,
    customer_type VARCHAR(30) NOT NULL
);
CREATE TABLE transactions (
    transaction_id INTEGER PRIMARY KEY,
    transaction_date DATE NOT NULL,
    customer_id INTEGER NOT NULL REFERENCES customers(customer_id),
    item_id INTEGER NOT NULL REFERENCES services_products(item_id),
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    unit_price NUMERIC(10,2) NOT NULL CHECK (unit_price >= 0),
    unit_cost NUMERIC(10,2) NOT NULL CHECK (unit_cost >= 0),
    payment_method VARCHAR(30) NOT NULL
);

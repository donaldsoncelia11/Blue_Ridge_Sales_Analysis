-- 1. Verify the import (expected: 6, 18, 180, 900)
SELECT 'categories' AS table_name, COUNT(*) AS row_count FROM categories
UNION ALL SELECT 'services_products', COUNT(*) FROM services_products
UNION ALL SELECT 'customers', COUNT(*) FROM customers
UNION ALL SELECT 'transactions', COUNT(*) FROM transactions;

-- 2. Preview transactions
SELECT * FROM transactions ORDER BY transaction_date LIMIT 10;

-- 3. Check for nulls in important columns
SELECT COUNT(*) AS rows_with_missing_values
FROM transactions
WHERE transaction_date IS NULL OR customer_id IS NULL
   OR item_id IS NULL OR unit_price IS NULL OR unit_cost IS NULL;

-- 4. Count distinct transactions and inspect date coverage
SELECT COUNT(*) AS transaction_count,
       MIN(transaction_date) AS first_date,
       MAX(transaction_date) AS last_date
FROM transactions;

-- 5. Join transactions to item names and categories
SELECT t.transaction_id, t.transaction_date, s.item_name,
       c.category_name, t.quantity, t.unit_price,
       t.quantity * t.unit_price AS revenue
FROM transactions t
JOIN services_products s ON t.item_id = s.item_id
JOIN categories c ON s.category_id = c.category_id
ORDER BY t.transaction_date
LIMIT 20;



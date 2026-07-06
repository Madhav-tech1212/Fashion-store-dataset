-- ==========================================
-- Project : Retail Fashion Sales Analytics
-- File    : 01_data_quality.sql
-- Purpose : Validate imported data
-- Author  : Madhav Karthickk
-- ==========================================

-- ==========================================
-- Import Validation
-- ==========================================

SELECT * FROM `fashion_db.fashion_sales`;

-- Check total records

SELECT COUNT(*) AS total_records
FROM `fashion_db.fashion_sales`;

-- Preview first 10 records

SELECT *
FROM `fashion_db.fashion_sales`
LIMIT 10;

-- Check duplicate product IDs

SELECT
    product_id,
    COUNT(*) AS duplicate_count
FROM `fashion_db.fashion_sales`
GROUP BY product_id
HAVING COUNT(*) > 1;

-- ==========================================
-- Missing Value Analysis
-- ==========================================

-- Missing customer ratings

SELECT
    COUNT(*) AS total_records,
    COUNTIF(customer_rating IS NULL) AS missing_customer_rating,
    ROUND(COUNTIF(customer_rating IS NULL)*100 / COUNT(*),2) AS missing_customer_rating_percentage
FROM `fashion_db.fashion_sales`;

-- Missing sizes

SELECT
    COUNT(*) AS total_records,
    COUNTIF(size IS NULL) AS missing_size,
    ROUND(COUNTIF(size IS NULL)*100/COUNT(*),2) AS missing_size_percentage
FROM `fashion_db.fashion_sales`;

-- Missing return reasons

SELECT
    COUNT(*) AS total_records,
    COUNTIF(return_reason IS NULL) AS missing_return_reason,
    ROUND(COUNTIF(return_reason IS NULL)*100/COUNT(*),2) AS missing_return_reason_percentage
FROM `fashion_db.fashion_sales`;

-- Missing size in each category

SELECT
    category,
    COUNT(*) AS total_size,
    COUNTIF(size IS NULL) AS missing_size,
    ROUND(COUNTIF(size IS NULL)*100/COUNT(*),2) AS missing_size_percentage
FROM `fashion_db.fashion_sales`
GROUP BY category;

-- ==========================================
-- Business Rule Validation
-- ==========================================

-- Are there any returned products without a return reason

SELECT COUNT(*) AS missing_return_reason
FROM `fashion_db.fashion_sales`
WHERE is_returned = TRUE
AND return_reason IS NULL;

-- Check for invalid customer ratings (outside 1–5)

SELECT *
FROM `fashion_db.fashion_sales`
WHERE customer_rating < 1
OR customer_rating > 5;

-- Validate Discounts

SELECT *
FROM `fashion_db.fashion_sales`
WHERE markdown_percentage < 0
OR markdown_percentage > 100;

-- Validate Stock

SELECT *
FROM `fashion_db.fashion_sales`
WHERE stock_quantity < 0;

-- Validate Current Price

SELECT *
FROM `fashion_db.fashion_sales`
WHERE ROUND(original_price * (1 - markdown_percentage / 100), 2) != current_price;
-- ============================================================
-- Project : Retail Fashion Sales Analytics Dashboard
-- File    : 02_exploratory_data_analysis.sql
-- Purpose : Exploratory Data Analysis (EDA)
-- Author  : Madhav Karthickk
-- Database: BigQuery
-- ============================================================


-- ============================================================
-- SECTION 1 : DATASET OVERVIEW
-- ============================================================

-- Total Records
SELECT
    COUNT(*) AS total_records
FROM `fashion_db.fashion_sales`;

-- Total Brands
SELECT
    COUNT(DISTINCT brand) AS total_brands
FROM `fashion_db.fashion_sales`;

-- Total Categories
SELECT
    COUNT(DISTINCT category) AS total_categories
FROM `fashion_db.fashion_sales`;

-- Total Colors
SELECT
    COUNT(DISTINCT color) AS total_colors
FROM `fashion_db.fashion_sales`;

-- Total Seasons
SELECT
    COUNT(DISTINCT season) AS total_seasons
FROM `fashion_db.fashion_sales`;

-- Total Sizes
SELECT
    COUNT(DISTINCT size) AS total_sizes
FROM `fashion_db.fashion_sales`;

-- Purchase Date Range
SELECT
    MIN(purchase_date) AS first_purchase_date,
    MAX(purchase_date) AS last_purchase_date
FROM `fashion_db.fashion_sales`;


-- ============================================================
-- SECTION 2 : PRODUCT DISTRIBUTION
-- ============================================================

-- Products by Category
SELECT
    category,
    COUNT(*) AS total_products
FROM `fashion_db.fashion_sales`
GROUP BY category
ORDER BY total_products DESC;

-- Products by Brand
SELECT
    brand,
    COUNT(*) AS total_products
FROM `fashion_db.fashion_sales`
GROUP BY brand
ORDER BY total_products DESC;

-- Products by Season
SELECT
    season,
    COUNT(*) AS total_products
FROM `fashion_db.fashion_sales`
GROUP BY season
ORDER BY total_products DESC;

-- Products by Color
SELECT
    color,
    COUNT(*) AS total_products
FROM `fashion_db.fashion_sales`
GROUP BY color
ORDER BY total_products DESC;

-- Products by Size
SELECT
    size,
    COUNT(*) AS total_products
FROM `fashion_db.fashion_sales`
GROUP BY size
ORDER BY total_products DESC;


-- ============================================================
-- SECTION 3 : PRICING OVERVIEW
-- ============================================================

-- Original Price Statistics
SELECT
    MIN(original_price) AS minimum_price,
    MAX(original_price) AS maximum_price,
    ROUND(AVG(original_price),2) AS average_price
FROM `fashion_db.fashion_sales`;

-- Current Price Statistics
SELECT
    MIN(current_price) AS minimum_current_price,
    MAX(current_price) AS maximum_current_price,
    ROUND(AVG(current_price),2) AS average_current_price
FROM `fashion_db.fashion_sales`;

-- Markdown Statistics
SELECT
    MIN(markdown_percentage) AS minimum_discount,
    MAX(markdown_percentage) AS maximum_discount,
    ROUND(AVG(markdown_percentage),2) AS average_discount
FROM `fashion_db.fashion_sales`;


-- ============================================================
-- SECTION 4 : INVENTORY OVERVIEW
-- ============================================================

-- Inventory Summary
SELECT
    SUM(stock_quantity) AS total_stock,
    ROUND(AVG(stock_quantity),2) AS average_stock,
    MIN(stock_quantity) AS minimum_stock,
    MAX(stock_quantity) AS maximum_stock
FROM `fashion_db.fashion_sales`;

-- Out of Stock Products
SELECT
    COUNT(*) AS out_of_stock_products
FROM `fashion_db.fashion_sales`
WHERE stock_quantity = 0;

-- Low Stock Products (<5)
SELECT
    COUNT(*) AS low_stock_products
FROM `fashion_db.fashion_sales`
WHERE stock_quantity < 5;


-- ============================================================
-- SECTION 5 : CUSTOMER RATING OVERVIEW
-- ============================================================

-- Rating Statistics
SELECT
    ROUND(AVG(customer_rating),2) AS average_rating,
    MIN(customer_rating) AS minimum_rating,
    MAX(customer_rating) AS maximum_rating
FROM `fashion_db.fashion_sales`;

-- Rating Distribution
SELECT
    customer_rating,
    COUNT(*) AS total_products
FROM `fashion_db.fashion_sales`
GROUP BY customer_rating
ORDER BY customer_rating DESC;

-- Products Without Rating
SELECT
    COUNT(*) AS unrated_products
FROM `fashion_db.fashion_sales`
WHERE customer_rating IS NULL;


-- ============================================================
-- SECTION 6 : RETURNS OVERVIEW
-- ============================================================

-- Returned vs Not Returned
SELECT
    is_returned,
    COUNT(*) AS total_products
FROM `fashion_db.fashion_sales`
GROUP BY is_returned;

-- Return Rate
SELECT
    COUNT(*) AS total_products,
    COUNTIF(is_returned = TRUE) AS returned_products,
    ROUND(COUNTIF(is_returned = TRUE) * 100.0 / COUNT(*),2) AS return_rate_percentage
FROM `fashion_db.fashion_sales`;

-- Return Reasons
SELECT
    return_reason,
    COUNT(*) AS total_returns
FROM `fashion_db.fashion_sales`
WHERE is_returned = TRUE
GROUP BY return_reason
ORDER BY total_returns DESC;


-- ============================================================
-- SECTION 7 : TIME ANALYSIS
-- ============================================================

-- Transactions by Year
SELECT
    EXTRACT(YEAR FROM purchase_date) AS purchase_year,
    COUNT(*) AS total_transactions
FROM `fashion_db.fashion_sales`
GROUP BY purchase_year
ORDER BY purchase_year;

-- Transactions by Month
SELECT
    FORMAT_DATE('%B', purchase_date) AS purchase_month,
    COUNT(*) AS total_transactions
FROM `fashion_db.fashion_sales`
GROUP BY purchase_month
ORDER BY MIN(EXTRACT(MONTH FROM purchase_date));

-- Transactions by Season
SELECT
    season,
    COUNT(*) AS total_transactions
FROM `fashion_db.fashion_sales`
GROUP BY season
ORDER BY total_transactions DESC;


-- ============================================================
-- SECTION 8 : BRAND OVERVIEW
-- ============================================================

-- Brand Summary
SELECT
    brand,
    COUNT(*) AS total_products,
    ROUND(AVG(original_price),2) AS average_price,
    ROUND(AVG(customer_rating),2) AS average_rating,
    ROUND(AVG(stock_quantity),2) AS average_stock
FROM `fashion_db.fashion_sales`
GROUP BY brand
ORDER BY total_products DESC;


-- ============================================================
-- SECTION 9 : CATEGORY OVERVIEW
-- ============================================================

-- Category Summary
SELECT
    category,
    COUNT(*) AS total_products,
    ROUND(AVG(original_price),2) AS average_price,
    ROUND(AVG(customer_rating),2) AS average_rating,
    ROUND(AVG(stock_quantity),2) AS average_stock
FROM `fashion_db.fashion_sales`
GROUP BY category
ORDER BY total_products DESC;
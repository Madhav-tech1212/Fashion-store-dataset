-- ============================================================
-- Project : Retail Fashion Sales Analytics Dashboard
-- File    : 03_business_analysis.sql
-- Part    : 1
-- Purpose : Business Analysis
-- Database: Google BigQuery
-- ============================================================



-- ============================================================
-- SECTION 1 : SALES PERFORMANCE ANALYSIS
-- ============================================================

-- 1. Total Revenue

SELECT
    ROUND(SUM(current_price),2) AS total_revenue
FROM `fashion_db.fashion_sales`;



-- 2. Average Revenue Per Product

SELECT
    ROUND(AVG(current_price),2) AS average_revenue
FROM `fashion_db.fashion_sales`;



-- 3. Revenue by Brand

SELECT
    brand,
    ROUND(SUM(current_price),2) AS total_revenue
FROM `fashion_db.fashion_sales`
GROUP BY brand
ORDER BY total_revenue DESC;



-- 4. Revenue by Category

SELECT
    category,
    ROUND(SUM(current_price),2) AS total_revenue
FROM `fashion_db.fashion_sales`
GROUP BY category
ORDER BY total_revenue DESC;



-- 5. Revenue by Season

SELECT
    season,
    ROUND(SUM(current_price),2) AS total_revenue
FROM `fashion_db.fashion_sales`
GROUP BY season
ORDER BY total_revenue DESC;



-- 6. Average Revenue by Brand

SELECT
    brand,
    ROUND(AVG(current_price),2) AS average_revenue
FROM `fashion_db.fashion_sales`
GROUP BY brand
ORDER BY average_revenue DESC;



-- 7. Average Revenue by Category

SELECT
    category,
    ROUND(AVG(current_price),2) AS average_revenue
FROM `fashion_db.fashion_sales`
GROUP BY category
ORDER BY average_revenue DESC;



-- 8. Top 10 Highest Revenue Products

SELECT
    product_id,
    brand,
    category,
    current_price
FROM `fashion_db.fashion_sales`
ORDER BY current_price DESC
LIMIT 10;



-- 9. Bottom 10 Lowest Revenue Products

SELECT
    product_id,
    brand,
    category,
    current_price
FROM `fashion_db.fashion_sales`
ORDER BY current_price
LIMIT 10;



-- 10. Revenue Contribution by Brand

SELECT
    brand,
    ROUND(SUM(current_price),2) AS revenue,
    ROUND(
        SUM(current_price) * 100 /
        SUM(SUM(current_price)) OVER(),2
    ) AS revenue_percentage
FROM `fashion_db.fashion_sales`
GROUP BY brand
ORDER BY revenue DESC;



-- ============================================================
-- SECTION 2 : BRAND ANALYSIS
-- ============================================================

-- 11. Total Products by Brand

SELECT
    brand,
    COUNT(*) AS total_products
FROM `fashion_db.fashion_sales`
GROUP BY brand
ORDER BY total_products DESC;



-- 12. Average Original Price by Brand

SELECT
    brand,
    ROUND(AVG(original_price),2) AS average_original_price
FROM `fashion_db.fashion_sales`
GROUP BY brand
ORDER BY average_original_price DESC;



-- 13. Average Selling Price by Brand

SELECT
    brand,
    ROUND(AVG(current_price),2) AS average_selling_price
FROM `fashion_db.fashion_sales`
GROUP BY brand
ORDER BY average_selling_price DESC;



-- 14. Average Discount by Brand

SELECT
    brand,
    ROUND(AVG(markdown_percentage),2) AS average_discount
FROM `fashion_db.fashion_sales`
GROUP BY brand
ORDER BY average_discount DESC;



-- 15. Total Stock by Brand

SELECT
    brand,
    SUM(stock_quantity) AS total_stock
FROM `fashion_db.fashion_sales`
GROUP BY brand
ORDER BY total_stock DESC;



-- 16. Average Rating by Brand

SELECT
    brand,
    ROUND(AVG(customer_rating),2) AS average_rating
FROM `fashion_db.fashion_sales`
GROUP BY brand
ORDER BY average_rating DESC;



-- 17. Returned Products by Brand

SELECT
    brand,
    COUNT(*) AS returned_products
FROM `fashion_db.fashion_sales`
WHERE is_returned = TRUE
GROUP BY brand
ORDER BY returned_products DESC;



-- 18. Return Rate by Brand

SELECT
    brand,
    COUNT(*) AS total_products,
    COUNTIF(is_returned=TRUE) AS returned_products,
    ROUND(
        COUNTIF(is_returned=TRUE)*100/COUNT(*),2
    ) AS return_rate
FROM `fashion_db.fashion_sales`
GROUP BY brand
ORDER BY return_rate DESC;



-- 19. Highest Rated Brand

SELECT
    brand,
    ROUND(AVG(customer_rating),2) AS average_rating
FROM `fashion_db.fashion_sales`
GROUP BY brand
ORDER BY average_rating DESC
LIMIT 1;



-- 20. Lowest Rated Brand

SELECT
    brand,
    ROUND(AVG(customer_rating),2) AS average_rating
FROM `fashion_db.fashion_sales`
GROUP BY brand
ORDER BY average_rating
LIMIT 1;



-- ============================================================
-- SECTION 3 : CATEGORY ANALYSIS
-- ============================================================

-- 21. Total Products by Category

SELECT
    category,
    COUNT(*) AS total_products
FROM `fashion_db.fashion_sales`
GROUP BY category
ORDER BY total_products DESC;



-- 22. Revenue by Category

SELECT
    category,
    ROUND(SUM(current_price),2) AS revenue
FROM `fashion_db.fashion_sales`
GROUP BY category
ORDER BY revenue DESC;



-- 23. Average Selling Price by Category

SELECT
    category,
    ROUND(AVG(current_price),2) AS average_price
FROM `fashion_db.fashion_sales`
GROUP BY category
ORDER BY average_price DESC;



-- 24. Average Discount by Category

SELECT
    category,
    ROUND(AVG(markdown_percentage),2) AS average_discount
FROM `fashion_db.fashion_sales`
GROUP BY category
ORDER BY average_discount DESC;



-- 25. Total Stock by Category

SELECT
    category,
    SUM(stock_quantity) AS total_stock
FROM `fashion_db.fashion_sales`
GROUP BY category
ORDER BY total_stock DESC;



-- 26. Average Rating by Category

SELECT
    category,
    ROUND(AVG(customer_rating),2) AS average_rating
FROM `fashion_db.fashion_sales`
GROUP BY category
ORDER BY average_rating DESC;



-- 27. Return Rate by Category

SELECT
    category,
    COUNT(*) AS total_products,
    COUNTIF(is_returned=TRUE) AS returned_products,
    ROUND(
        COUNTIF(is_returned=TRUE)*100/COUNT(*),2
    ) AS return_rate
FROM `fashion_db.fashion_sales`
GROUP BY category
ORDER BY return_rate DESC;



-- 28. Highest Rated Category

SELECT
    category,
    ROUND(AVG(customer_rating),2) AS average_rating
FROM `fashion_db.fashion_sales`
GROUP BY category
ORDER BY average_rating DESC
LIMIT 1;



-- 29. Lowest Rated Category

SELECT
    category,
    ROUND(AVG(customer_rating),2) AS average_rating
FROM `fashion_db.fashion_sales`
GROUP BY category
ORDER BY average_rating
LIMIT 1;



-- 30. Category Revenue Contribution

SELECT
    category,
    ROUND(SUM(current_price),2) AS revenue,
    ROUND(
        SUM(current_price)*100/
        SUM(SUM(current_price)) OVER(),2
    ) AS revenue_percentage
FROM `fashion_db.fashion_sales`
GROUP BY category
ORDER BY revenue DESC;

-- ============================================================
-- Project : Retail Fashion Sales Analytics Dashboard
-- File    : 03_business_analysis.sql
-- Part    : 2
-- Purpose : Pricing, Inventory, Customer & Return Analysis
-- Database: Google BigQuery
-- ============================================================



-- ============================================================
-- SECTION 4 : PRICING ANALYSIS
-- ============================================================

-- 31. Overall Discount Statistics

SELECT
    MIN(markdown_percentage) AS minimum_discount,
    MAX(markdown_percentage) AS maximum_discount,
    ROUND(AVG(markdown_percentage),2) AS average_discount
FROM `fashion_db.fashion_sales`;



-- 32. Top 10 Highest Discount Products

SELECT
    product_id,
    brand,
    category,
    markdown_percentage
FROM `fashion_db.fashion_sales`
ORDER BY markdown_percentage DESC
LIMIT 10;



-- 33. Top 10 Lowest Discount Products

SELECT
    product_id,
    brand,
    category,
    markdown_percentage
FROM `fashion_db.fashion_sales`
ORDER BY markdown_percentage ASC
LIMIT 10;



-- 34. Average Discount by Season

SELECT
    season,
    ROUND(AVG(markdown_percentage),2) AS average_discount
FROM `fashion_db.fashion_sales`
GROUP BY season
ORDER BY average_discount DESC;



-- 35. Average Discount by Color

SELECT
    color,
    ROUND(AVG(markdown_percentage),2) AS average_discount
FROM `fashion_db.fashion_sales`
GROUP BY color
ORDER BY average_discount DESC;



-- 36. Average Original Price vs Current Price

SELECT
    ROUND(AVG(original_price),2) AS avg_original_price,
    ROUND(AVG(current_price),2) AS avg_current_price
FROM `fashion_db.fashion_sales`;



-- 37. Total Discount Value

SELECT
    ROUND(SUM(original_price-current_price),2) AS total_discount_given
FROM `fashion_db.fashion_sales`;



-- 38. Products Sold Without Discount

SELECT
    COUNT(*) AS products_without_discount
FROM `fashion_db.fashion_sales`
WHERE markdown_percentage = 0;



-- 39. Products Sold With Discount

SELECT
    COUNT(*) AS discounted_products
FROM `fashion_db.fashion_sales`
WHERE markdown_percentage > 0;



-- 40. Highest Original Price Products

SELECT
    product_id,
    brand,
    category,
    original_price
FROM `fashion_db.fashion_sales`
ORDER BY original_price DESC
LIMIT 10;




-- ============================================================
-- SECTION 5 : INVENTORY ANALYSIS
-- ============================================================

-- 41. Inventory Summary

SELECT
    SUM(stock_quantity) AS total_stock,
    ROUND(AVG(stock_quantity),2) AS average_stock
FROM `fashion_db.fashion_sales`;



-- 42. Highest Stock Products

SELECT
    product_id,
    brand,
    category,
    stock_quantity
FROM `fashion_db.fashion_sales`
ORDER BY stock_quantity DESC
LIMIT 10;



-- 43. Lowest Stock Products

SELECT
    product_id,
    brand,
    category,
    stock_quantity
FROM `fashion_db.fashion_sales`
ORDER BY stock_quantity ASC
LIMIT 10;



-- 44. Products Out of Stock

SELECT *
FROM `fashion_db.fashion_sales`
WHERE stock_quantity = 0;



-- 45. Low Stock Products (<5)

SELECT *
FROM `fashion_db.fashion_sales`
WHERE stock_quantity < 5
ORDER BY stock_quantity;



-- 46. Average Stock by Brand

SELECT
    brand,
    ROUND(AVG(stock_quantity),2) AS average_stock
FROM `fashion_db.fashion_sales`
GROUP BY brand
ORDER BY average_stock DESC;



-- 47. Average Stock by Category

SELECT
    category,
    ROUND(AVG(stock_quantity),2) AS average_stock
FROM `fashion_db.fashion_sales`
GROUP BY category
ORDER BY average_stock DESC;



-- 48. Average Stock by Season

SELECT
    season,
    ROUND(AVG(stock_quantity),2) AS average_stock
FROM `fashion_db.fashion_sales`
GROUP BY season
ORDER BY average_stock DESC;



-- 49. Inventory by Color

SELECT
    color,
    SUM(stock_quantity) AS total_stock
FROM `fashion_db.fashion_sales`
GROUP BY color
ORDER BY total_stock DESC;



-- 50. Inventory by Size

SELECT
    size,
    SUM(stock_quantity) AS total_stock
FROM `fashion_db.fashion_sales`
WHERE size IS NOT NULL
GROUP BY size
ORDER BY total_stock DESC;




-- ============================================================
-- SECTION 6 : CUSTOMER RATING ANALYSIS
-- ============================================================

-- 51. Overall Rating Summary

SELECT
    ROUND(AVG(customer_rating),2) AS average_rating,
    MIN(customer_rating) AS minimum_rating,
    MAX(customer_rating) AS maximum_rating
FROM `fashion_db.fashion_sales`;



-- 52. Highest Rated Products

SELECT
    product_id,
    brand,
    category,
    customer_rating
FROM `fashion_db.fashion_sales`
ORDER BY customer_rating DESC
LIMIT 10;



-- 53. Lowest Rated Products

SELECT
    product_id,
    brand,
    category,
    customer_rating
FROM `fashion_db.fashion_sales`
WHERE customer_rating IS NOT NULL
ORDER BY customer_rating
LIMIT 10;



-- 54. Average Rating by Season

SELECT
    season,
    ROUND(AVG(customer_rating),2) AS average_rating
FROM `fashion_db.fashion_sales`
GROUP BY season
ORDER BY average_rating DESC;



-- 55. Average Rating by Color

SELECT
    color,
    ROUND(AVG(customer_rating),2) AS average_rating
FROM `fashion_db.fashion_sales`
GROUP BY color
ORDER BY average_rating DESC;



-- 56. Products Without Rating

SELECT
    COUNT(*) AS unrated_products
FROM `fashion_db.fashion_sales`
WHERE customer_rating IS NULL;



-- 57. Rating Distribution

SELECT
    customer_rating,
    COUNT(*) AS total_products
FROM `fashion_db.fashion_sales`
GROUP BY customer_rating
ORDER BY customer_rating DESC;



-- ============================================================
-- SECTION 7 : RETURN ANALYSIS
-- ============================================================

-- 58. Overall Return Rate

SELECT
    COUNT(*) AS total_products,
    COUNTIF(is_returned=TRUE) AS returned_products,
    ROUND(COUNTIF(is_returned=TRUE)*100/COUNT(*),2) AS return_rate
FROM `fashion_db.fashion_sales`;



-- 59. Return Reasons

SELECT
    return_reason,
    COUNT(*) AS total_returns
FROM `fashion_db.fashion_sales`
WHERE is_returned=TRUE
GROUP BY return_reason
ORDER BY total_returns DESC;



-- 60. Returns by Season

SELECT
    season,
    COUNTIF(is_returned=TRUE) AS returned_products
FROM `fashion_db.fashion_sales`
GROUP BY season
ORDER BY returned_products DESC;

-- ============================================================
-- Project : Retail Fashion Sales Analytics Dashboard
-- File    : 03_business_analysis.sql
-- Part    : 3
-- Purpose : Seasonal, Product Performance & Executive KPIs
-- Database: Google BigQuery
-- ============================================================



-- ============================================================
-- SECTION 8 : SEASONAL ANALYSIS
-- ============================================================

-- 61. Revenue by Season

SELECT
    season,
    ROUND(SUM(current_price),2) AS total_revenue
FROM `fashion_db.fashion_sales`
GROUP BY season
ORDER BY total_revenue DESC;



-- 62. Products by Season

SELECT
    season,
    COUNT(*) AS total_products
FROM `fashion_db.fashion_sales`
GROUP BY season
ORDER BY total_products DESC;



-- 63. Average Rating by Season

SELECT
    season,
    ROUND(AVG(customer_rating),2) AS average_rating
FROM `fashion_db.fashion_sales`
GROUP BY season
ORDER BY average_rating DESC;



-- 64. Average Discount by Season

SELECT
    season,
    ROUND(AVG(markdown_percentage),2) AS average_discount
FROM `fashion_db.fashion_sales`
GROUP BY season
ORDER BY average_discount DESC;



-- 65. Return Rate by Season

SELECT
    season,
    COUNT(*) AS total_products,
    COUNTIF(is_returned = TRUE) AS returned_products,
    ROUND(COUNTIF(is_returned = TRUE)*100.0/COUNT(*),2) AS return_rate
FROM `fashion_db.fashion_sales`
GROUP BY season
ORDER BY return_rate DESC;



-- 66. Inventory by Season

SELECT
    season,
    SUM(stock_quantity) AS total_stock
FROM `fashion_db.fashion_sales`
GROUP BY season
ORDER BY total_stock DESC;



-- ============================================================
-- SECTION 9 : PRODUCT PERFORMANCE
-- ============================================================

-- 67. Top 20 Most Expensive Products

SELECT
    product_id,
    brand,
    category,
    current_price
FROM `fashion_db.fashion_sales`
ORDER BY current_price DESC
LIMIT 20;



-- 68. Top 20 Cheapest Products

SELECT
    product_id,
    brand,
    category,
    current_price
FROM `fashion_db.fashion_sales`
ORDER BY current_price ASC
LIMIT 20;



-- 69. Highest Rated Products

SELECT
    product_id,
    brand,
    category,
    current_price,
    customer_rating
FROM `fashion_db.fashion_sales`
WHERE customer_rating IS NOT NULL
ORDER BY customer_rating DESC, current_price DESC
LIMIT 20;



-- 70. Lowest Rated Products

SELECT
    product_id,
    brand,
    category,
    current_price,
    customer_rating
FROM `fashion_db.fashion_sales`
WHERE customer_rating IS NOT NULL
ORDER BY customer_rating ASC, current_price DESC
LIMIT 20;



-- 71. High Price + Low Rating

SELECT
    product_id,
    brand,
    category,
    current_price,
    customer_rating
FROM `fashion_db.fashion_sales`
WHERE current_price >
(
    SELECT AVG(current_price)
    FROM `fashion_db.fashion_sales`
)
AND customer_rating <
(
    SELECT AVG(customer_rating)
    FROM `fashion_db.fashion_sales`
)
ORDER BY current_price DESC;



-- 72. Low Price + High Rating

SELECT
    product_id,
    brand,
    category,
    current_price,
    customer_rating
FROM `fashion_db.fashion_sales`
WHERE current_price <
(
    SELECT AVG(current_price)
    FROM `fashion_db.fashion_sales`
)
AND customer_rating >
(
    SELECT AVG(customer_rating)
    FROM `fashion_db.fashion_sales`
)
ORDER BY customer_rating DESC;



-- 73. Products Returned Most

SELECT
    product_id,
    brand,
    category,
    COUNT(*) AS return_count
FROM `fashion_db.fashion_sales`
WHERE is_returned = TRUE
GROUP BY product_id,brand,category
ORDER BY return_count DESC;



-- 74. Average Product Price by Color

SELECT
    color,
    ROUND(AVG(current_price),2) AS average_price
FROM `fashion_db.fashion_sales`
GROUP BY color
ORDER BY average_price DESC;



-- 75. Average Product Rating by Size

SELECT
    size,
    ROUND(AVG(customer_rating),2) AS average_rating
FROM `fashion_db.fashion_sales`
WHERE size IS NOT NULL
GROUP BY size
ORDER BY average_rating DESC;



-- ============================================================
-- SECTION 10 : EXECUTIVE KPI QUERIES
-- ============================================================

-- 76. Total Revenue

SELECT
    ROUND(SUM(current_price),2) AS total_revenue
FROM `fashion_db.fashion_sales`;



-- 77. Total Products

SELECT
    COUNT(*) AS total_products
FROM `fashion_db.fashion_sales`;



-- 78. Total Brands

SELECT
    COUNT(DISTINCT brand) AS total_brands
FROM `fashion_db.fashion_sales`;



-- 79. Total Categories

SELECT
    COUNT(DISTINCT category) AS total_categories
FROM `fashion_db.fashion_sales`;



-- 80. Average Selling Price

SELECT
    ROUND(AVG(current_price),2) AS average_selling_price
FROM `fashion_db.fashion_sales`;



-- 81. Average Discount

SELECT
    ROUND(AVG(markdown_percentage),2) AS average_discount
FROM `fashion_db.fashion_sales`;



-- 82. Average Customer Rating

SELECT
    ROUND(AVG(customer_rating),2) AS average_customer_rating
FROM `fashion_db.fashion_sales`;



-- 83. Return Rate

SELECT
    ROUND(COUNTIF(is_returned=TRUE)*100.0/COUNT(*),2) AS return_rate
FROM `fashion_db.fashion_sales`;



-- 84. Total Inventory

SELECT
    SUM(stock_quantity) AS total_inventory
FROM `fashion_db.fashion_sales`;



-- 85. Inventory Value

SELECT
    ROUND(SUM(stock_quantity * current_price),2) AS inventory_value
FROM `fashion_db.fashion_sales`;



-- 86. Highest Revenue Brand

SELECT
    brand,
    ROUND(SUM(current_price),2) AS revenue
FROM `fashion_db.fashion_sales`
GROUP BY brand
ORDER BY revenue DESC
LIMIT 1;



-- 87. Highest Revenue Category

SELECT
    category,
    ROUND(SUM(current_price),2) AS revenue
FROM `fashion_db.fashion_sales`
GROUP BY category
ORDER BY revenue DESC
LIMIT 1;



-- 88. Highest Rated Brand

SELECT
    brand,
    ROUND(AVG(customer_rating),2) AS rating
FROM `fashion_db.fashion_sales`
GROUP BY brand
ORDER BY rating DESC
LIMIT 1;



-- 89. Highest Return Category

SELECT
    category,
    ROUND(COUNTIF(is_returned=TRUE)*100.0/COUNT(*),2) AS return_rate
FROM `fashion_db.fashion_sales`
GROUP BY category
ORDER BY return_rate DESC
LIMIT 1;



-- 90. Dashboard Summary

SELECT
    COUNT(*) AS total_products,
    ROUND(SUM(current_price),2) AS total_revenue,
    ROUND(AVG(current_price),2) AS average_price,
    ROUND(AVG(markdown_percentage),2) AS average_discount,
    ROUND(AVG(customer_rating),2) AS average_rating,
    ROUND(COUNTIF(is_returned=TRUE)*100.0/COUNT(*),2) AS return_rate,
    SUM(stock_quantity) AS total_inventory
FROM `fashion_db.fashion_sales`;
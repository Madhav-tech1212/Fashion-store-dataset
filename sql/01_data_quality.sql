-- ==========================================
-- Project : Retail Fashion Sales Analytics
-- File    : 01_data_quality.sql
-- Purpose : Validate imported data
-- Author  : Madhav Karthickk
-- ==========================================

-- Check total records

SELECT COUNT(*) AS total_records
FROM `fashion_db.fashion_sales`;
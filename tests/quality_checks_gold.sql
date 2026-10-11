/*
===============================================================================
Quality Checks - Gold Layer (MySQL)
===============================================================================
Script Purpose:
    Validates the integrity, consistency, and accuracy of the Gold Layer.

    Checks:
    - Uniqueness of surrogate keys in dimension tables.
    - Referential integrity between fact and dimension tables.
    - Connectivity between fact and dimension tables.

Usage:
    Execute this script after loading the Gold Layer.
===============================================================================
*/


-- ====================================================================
-- 1. Checking gold.dim_customers
-- ====================================================================

-- Check uniqueness of Customer Key
-- Expectation: No results

SELECT
    customer_key,
    COUNT(*) AS duplicate_count
FROM gold.dim_customers
GROUP BY customer_key
HAVING COUNT(*) > 1;


-- ====================================================================
-- 2. Checking gold.dim_products
-- ====================================================================

-- Check uniqueness of Product Key
-- Expectation: No results

SELECT
    product_key,
    COUNT(*) AS duplicate_count
FROM gold.dim_products
GROUP BY product_key
HAVING COUNT(*) > 1;


-- ====================================================================
-- 3. Checking gold.fact_sales
-- ====================================================================

-- Check referential integrity between fact and dimension tables
-- Expectation: No results

SELECT
    f.*
FROM gold.fact_sales AS f
LEFT JOIN gold.dim_customers AS c
    ON c.customer_key = f.customer_key
LEFT JOIN gold.dim_products AS p
    ON p.product_key = f.product_key
WHERE
    p.product_key IS NULL
    OR c.customer_key IS NULL;

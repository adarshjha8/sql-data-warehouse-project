/*
===============================================================================
Load Bronze Layer (Source -> Bronze) - MySQL
===============================================================================
Purpose:
    - Truncate Bronze tables before loading.
    - Load data from CSV files.
    - Display individual and total load durations.

Usage:
    Execute the entire script in MySQL Workbench.
===============================================================================
*/

-- Record batch start time
SET @batch_start_time = NOW(6);

SELECT '================================================' AS Message;
SELECT 'Loading Bronze Layer' AS Message;
SELECT '================================================' AS Message;


-- =================================================
-- Loading CRM Tables
-- =================================================

SELECT '------------------------------------------------' AS Message;
SELECT 'Loading CRM Tables' AS Message;
SELECT '------------------------------------------------' AS Message;


-- 1. CRM Customer Info
SET @start_time = NOW(6);

SELECT 'Truncating Table: bronze.crm_cust_info' AS Message;
TRUNCATE TABLE bronze.crm_cust_info;

SELECT 'Loading Data Into: bronze.crm_cust_info' AS Message;

LOAD DATA LOCAL INFILE
'D:/assasin/sql-data-warehouse-project/sql-data-warehouse-project/datasets/source_crm/cust_info.csv'
INTO TABLE bronze.crm_cust_info
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

SET @end_time = NOW(6);

SELECT 'crm_cust_info' AS Table_Name,
       ROUND(TIMESTAMPDIFF(MICROSECOND, @start_time, @end_time) / 1000000, 3)
       AS Load_Duration_Seconds;


-- 2. CRM Product Info
SET @start_time = NOW(6);

SELECT 'Truncating Table: bronze.crm_prd_info' AS Message;
TRUNCATE TABLE bronze.crm_prd_info;

SELECT 'Loading Data Into: bronze.crm_prd_info' AS Message;

LOAD DATA LOCAL INFILE
'D:/assasin/sql-data-warehouse-project/sql-data-warehouse-project/datasets/source_crm/prd_info.csv'
INTO TABLE bronze.crm_prd_info
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

SET @end_time = NOW(6);

SELECT 'crm_prd_info' AS Table_Name,
       ROUND(TIMESTAMPDIFF(MICROSECOND, @start_time, @end_time) / 1000000, 3)
       AS Load_Duration_Seconds;


-- 3. CRM Sales Details
SET @start_time = NOW(6);

SELECT 'Truncating Table: bronze.crm_sales_details' AS Message;
TRUNCATE TABLE bronze.crm_sales_details;

SELECT 'Loading Data Into: bronze.crm_sales_details' AS Message;

LOAD DATA LOCAL INFILE
'D:/assasin/sql-data-warehouse-project/sql-data-warehouse-project/datasets/source_crm/sales_details.csv'
INTO TABLE bronze.crm_sales_details
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

SET @end_time = NOW(6);

SELECT 'crm_sales_details' AS Table_Name,
       ROUND(TIMESTAMPDIFF(MICROSECOND, @start_time, @end_time) / 1000000, 3)
       AS Load_Duration_Seconds;


-- =================================================
-- Loading ERP Tables
-- =================================================

SELECT '------------------------------------------------' AS Message;
SELECT 'Loading ERP Tables' AS Message;
SELECT '------------------------------------------------' AS Message;


-- 4. ERP Location A101
SET @start_time = NOW(6);

SELECT 'Truncating Table: bronze.erp_loc_a101' AS Message;
TRUNCATE TABLE bronze.erp_loc_a101;

SELECT 'Loading Data Into: bronze.erp_loc_a101' AS Message;

LOAD DATA LOCAL INFILE
'D:/assasin/sql-data-warehouse-project/sql-data-warehouse-project/datasets/source_erp/LOC_A101.csv'
INTO TABLE bronze.erp_loc_a101
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

SET @end_time = NOW(6);

SELECT 'erp_loc_a101' AS Table_Name,
       ROUND(TIMESTAMPDIFF(MICROSECOND, @start_time, @end_time) / 1000000, 3)
       AS Load_Duration_Seconds;


-- 5. ERP Customer AZ12
SET @start_time = NOW(6);

SELECT 'Truncating Table: bronze.erp_cust_az12' AS Message;
TRUNCATE TABLE bronze.erp_cust_az12;

SELECT 'Loading Data Into: bronze.erp_cust_az12' AS Message;

LOAD DATA LOCAL INFILE
'D:/assasin/sql-data-warehouse-project/sql-data-warehouse-project/datasets/source_erp/CUST_AZ12.csv'
INTO TABLE bronze.erp_cust_az12
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

SET @end_time = NOW(6);

SELECT 'erp_cust_az12' AS Table_Name,
       ROUND(TIMESTAMPDIFF(MICROSECOND, @start_time, @end_time) / 1000000, 3)
       AS Load_Duration_Seconds;


-- 6. ERP Product Category G1V2
SET @start_time = NOW(6);

SELECT 'Truncating Table: bronze.erp_px_cat_g1v2' AS Message;
TRUNCATE TABLE bronze.erp_px_cat_g1v2;

SELECT 'Loading Data Into: bronze.erp_px_cat_g1v2' AS Message;

LOAD DATA LOCAL INFILE
'D:/assasin/sql-data-warehouse-project/sql-data-warehouse-project/datasets/source_erp/PX_CAT_G1V2.csv'
INTO TABLE bronze.erp_px_cat_g1v2
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

SET @end_time = NOW(6);

SELECT 'erp_px_cat_g1v2' AS Table_Name,
       ROUND(TIMESTAMPDIFF(MICROSECOND, @start_time, @end_time) / 1000000, 3)
       AS Load_Duration_Seconds;


-- =================================================
-- Batch Completion
-- =================================================

SET @batch_end_time = NOW(6);

SELECT 'Loading Bronze Layer is Completed' AS Status,
       ROUND(
           TIMESTAMPDIFF(
               MICROSECOND,
               @batch_start_time,
               @batch_end_time
           ) / 1000000,
           3
       ) AS Total_Load_Duration_Seconds;

SELECT '================================================' AS Message;

SELECT * FROM bronze.crm_cust_info;
SELECT * FROM bronze.crm_prd_info;
SELECT * FROM bronze.crm_sales_details;

SELECT * FROM bronze.erp_cust_az12;
SELECT * FROM bronze.erp_loc_a101;
SELECT * FROM bronze.erp_px_cat_g1v2;




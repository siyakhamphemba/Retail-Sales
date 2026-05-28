-- Databricks notebook source
--  Review column names and data types
DESCRIBE retail.sales.dataset
--  Summary statistics to understand the data
SELECT 
    COUNT(*)                        AS total_rows,
    MIN(Date)                       AS earliest_date,
    MAX(Date)                       AS latest_date,
    MIN(Age)                        AS min_age,
    MAX(Age)                        AS max_age,
    MIN(`Total Amount`)             AS min_spend,
    MAX(`Total Amount`)             AS max_spend,
    ROUND(AVG(`Total Amount`), 2)   AS avg_spend
FROM retail.sales.dataset;

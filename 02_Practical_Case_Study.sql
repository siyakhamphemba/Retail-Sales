-- Databricks notebook source
-- Exploring the dataset before analysis 

SELECT *
FROM retail.sales.dataset;

-- Classifying customers by Age Group and Spend Group for visualisation
-- Age Groups: Pensioner (60+), Adult (30-59), Youth (18-29), Kids (under 18)
-- Spend Groups: High (1000+), Medium (500-999.9), Low (under 500)

    SELECT
      CASE 
          WHEN age >= 60 THEN 'Pensioner'
          WHEN age BETWEEN 30 AND 59 THEN 'Adult'
          WHEN age BETWEEN 18 AND 29 THEN 'Youth'
          WHEN age < 18 THEN 'Kids'
      END AS Age_Group,

              CASE 
          WHEN `Total Amount` >= 1000 THEN 'High Spend'
          WHEN `Total Amount` BETWEEN 500 AND 999.9 THEN 'Medium Spend'
          WHEN `Total Amount` < 500 THEN 'Low Spend'
      END AS Spend_Group,

-- Metrics

  COUNT(DISTINCT `Customer ID`) AS Number_Of_Customers,
      COUNT(DISTINCT `Transaction ID`) AS Number_Of_Transactions,
      SUM(`Total Amount`) AS Total_Revenue,
      ROUND(AVG(`Total Amount`), 2) AS Avg_Spend_Per_Transaction

-- Group by both CASE expressions to aggregate metrics per group combination

FROM retail.sales.dataset
GROUP BY Age_Group, Spend_Group
ORDER BY Age_Group, Spend_Group;

-- Analyzing daily sales performance for January 2026
-- Filtered to Male customers purchasing Electronics or Clothing
-- Classifies each day as a Weekday or Weekend

SELECT Date AS Purchase_Date,
       YEAR(Date) AS Year_Of_Purchase ,
       MONTH(Date) AS Month_Of_Purchase,
       MONTHNAME(Date) AS Month_Name_Of_Purchase,
       DAY(Date) AS Day_Of_Purchase,
       DAYNAME(Date) AS Day_Name_Of_Purchase,

          CASE 
              WHEN DAYNAME(Date) IN ('Sun','Sat') THEN 'Weekend'
              ELSE 'Weekday'
              END AS Day_Classification,
              COUNT(DISTINCT `Customer ID`) AS Number_Of_Customers,
              COUNT(DISTINCT `Transaction ID`) AS Number_Of_Sales,
              SUM(`Total Amount`) AS Total_Revenue,
              SUM(Quantity) AS Number_Of_Units_Sold

FROM retail.sales.dataset

-- Filter: January 2026, Male customers, Electronics and Clothing only

WHERE Date BETWEEN '2023-01-01'AND '2023-01-31'
      AND Gender ='Male'
      AND `Product Category` IN ('Electronics','Clothing')

-- Group by all non-aggregated columns including the CASE expression

GROUP BY Date, YEAR(Date), MONTH(Date), MONTHNAME(Date), DAY(Date), DAYNAME(Date), 
         CASE WHEN DAYNAME(Date) IN ('Sun','Sat') THEN 'Weekend' ELSE 'Weekday' END;

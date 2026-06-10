USE retail_store;

-- total sales
SELECT ROUND(SUM(Weekly_Sales),2) AS total_sales
FROM sales ;


-- Average Weekly Sales
SELECT ROUND(AVG(Weekly_Sales),2) AS avg_sales
FROM sales ;

-- Maximum Weekly Sale
SELECT MAX(Weekly_Sales) AS max_sales
FROM sales ;


-- Minimum Weekly Sale
SELECT MIN(Weekly_Sales) AS min_sales
FROM sales ;


-- Total Number of Stores
SELECT COUNT(*) AS total_stores
FROM stores ;


-- Total Sales by Store
SELECT Store,
ROUND(SUM(Weekly_Sales),2) AS total_sales
FROM sales
GROUP BY Store
ORDER BY total_sales DESC 
LIMIT 10 ;


-- Bottom 10 Stores
SELECT Store,
ROUND(SUM(Weekly_Sales),2) AS total_sales
FROM sales
GROUP BY Store
ORDER BY total_sales 
LIMIT 10 ;


-- Average Sales per Store
SELECT Store,
ROUND(AVG(Weekly_Sales),2) AS avg_sales
FROM sales
GROUP BY Store
ORDER BY avg_sales DESC 
LIMIT 10 ;


-- Store Size and Sales
SELECT st.Store,
st.Size,
ROUND(SUM(Weekly_Sales),2) AS total_sales
FROM sales sa
JOIN stores st
ON st.Store = sa.Store
GROUP BY st.Store, st.Size
ORDER BY total_sales ;


-- Total Sales by Department
SELECT Dept,
ROUND(SUM(Weekly_Sales),2) AS total_sales
FROM sales
GROUP BY Dept
ORDER BY total_sales ;


-- Top 5 Departments
SELECT Dept,
ROUND(SUM(Weekly_Sales),2) AS total_sales
FROM sales
GROUP BY Dept
ORDER BY total_sales DESC
LIMIT 5 ;


-- Average Sales by Department
SELECT Dept,
ROUND(AVG(Weekly_Sales),2) AS avg_sales
FROM sales
GROUP BY Dept ;


-- Holiday vs Non-Holiday Sales
SELECT IsHoliday,
ROUND(SUM(Weekly_Sales),2) AS total_sales
FROM sales
GROUP BY IsHoliday
ORDER BY total_sales DESC ;


-- Average Holiday Sales
SELECT ROUND(AVG(Weekly_Sales),2) AS Avg_Holiday_Sales
FROM sales
WHERE IsHoliday = "TRUE";


-- Holiday Sales by Store
SELECT 
ROUND(SUM(Weekly_Sales),2) AS holiday_sales
FROM sales
WHERE IsHoliday = "TRUE"
GROUP BY Store
ORDER BY holiday_sales DESC ;

-- Monthly Sales Trend
SELECT YEAR(Date) AS Year,
MONTH(Date) AS Month,
ROUND(SUM(Weekly_Sales),2) AS total_sales
FROM sales
GROUP BY Year, Month
ORDER BY Year, Month ;
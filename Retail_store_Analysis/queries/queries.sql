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


-- Yearly Sales
SELECT COALESCE(YEAR(Date), 'Unknown') AS Year, 
SUM(Weekly_Sales) AS Total_Sales 
FROM sales 
GROUP BY Year;


-- Weekly Sales Trend
SELECT Date,
SUM(Weekly_Sales) AS weekly_Sales 
FROM sales
GROUP BY Date
ORDER BY Date ;


-- Highest Sales Date
SELECT Date,
SUM(Weekly_Sales) AS weekly_Sales 
FROM sales
GROUP BY Date
ORDER BY Date DESC
LIMIT 1 ;


-- Average Temperature by Store
SELECT Store,
ROUND(AVG(Temperature),2) AS avg_temp
FROM features
GROUP BY Store
ORDER BY avg_temp ;


-- Average Fuel Price
SELECT 
ROUND(AVG(Fuel_Price),2) AS avg_fuel_price
FROM features ;


-- Stores with Highest Unemployment
SELECT Store,
ROUND(SUM(Unemployment),2) AS unemployment
FROM features
GROUP BY Store
ORDER BY unemployment DESC 
LIMIT 5 ;


-- Store Type Wise Sales
SELECT st.Type,
ROUND(SUM(Weekly_Sales),2) AS total_sales
FROM stores st 
JOIN sales sa
ON st.Store = sa.Store
GROUP BY st.Type
ORDER BY total_sales DESC ;


-- Average Sales by Store Type
SELECT st.Type,
ROUND(AVG(Weekly_Sales),2) AS avg_sales
FROM stores st 
JOIN sales sa
ON st.Store = sa.Store
GROUP BY st.Type
ORDER BY avg_sales DESC ;


-- Sales with Temperature
SELECT sa.Store,
sa.Date,
sa.Weekly_Sales,
ft.Temperature
FROM sales sa
JOIN features ft
ON sa.Store = ft.Store
AND sa.Date = ft.Date
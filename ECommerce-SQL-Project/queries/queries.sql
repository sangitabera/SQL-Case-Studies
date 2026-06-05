USE e_commerce;

-- total revenue generated
SELECT ROUND(SUM(Amount),2) AS total_rev 
FROM amazon_sales
WHERE Amount IS NOT NULL ;

-- total orders received
SELECT COUNT(DISTINCT Order_ID) AS total_ords
FROM amazon_sales;

-- total units sold
SELECT COUNT(Qty) AS total_units_sold
FROM amazon_sales;

-- top 10 selling categories
SELECT Category,
COUNT(Qty) AS total_units_sold
FROM amazon_sales
GROUP BY Category
ORDER BY total_units_sold DESC
LIMIT 10;

-- top 10 revenue generating categories
SELECT Category,
COUNT(Amount) AS total_rev
FROM amazon_sales
GROUP BY Category
ORDER BY total_units_sold DESC
LIMIT 10;

-- top 10 best selling products
SELECT SKU,
COUNT(Qty) AS total_units_sold
FROM amazon_sales
GROUP BY SKU
ORDER BY total_units_sold DESC
LIMIT 10;


-- order status distribution
SELECT Status,
COUNT(*) AS orders
FROM amazon_sales
GROUP BY Status
ORDER BY orders DESC
LIMIT 10;
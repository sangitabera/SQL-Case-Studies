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


-- cancellation rate
SELECT 
ROUND(
COUNT(
CASE 
	WHEN Status = 'Cancelled'
    THEN 1
END)*100 / COUNT(*),2) 
AS cancellation_rate
FROM amazon_sales ;

-- revenue by fulfillment type
SELECT 
Fulfilment,
ROUND(SUM(Amount),2) AS revenue
FROM amazon_sales
GROUP BY Fulfilment
ORDER BY revenue DESC;

-- state-wise revenue analysis
SELECT 
ship_state,
ROUND(SUM(Amount),2) AS revenue
FROM amazon_sales
GROUP BY ship_state
ORDER BY revenue DESC;

-- top 10 cities by revenue
SELECT 
ship_city,
ROUND(SUM(Amount),2) AS revenue
FROM amazon_sales
GROUP BY ship_city
ORDER BY revenue DESC
LIMIT 10 ;


-- average order values
SELECT 
ROUND(AVG(Amount),2) AS avg_ord_value
FROM amazon_sales ;



-- B2B Vs B2C revenue
SELECT B2B,
ROUND(SUM(Amount),2) AS revnue
FROM amazon_sales
GROUP BY B2B ;



-- size-wise sales analysis
SELECT Size,
SUM(Qty) AS qty_sold
FROM amazon_sales
GROUP BY Size
ORDER BY qty_sold DESC ;


-- category revenue ranking
SELECT Category,
ROUND(SUM(Amount),2) AS revnue,
RANK() OVER(
		ORDER BY SUM(Amount) DESC
        ) AS revenue_rank
FROM amazon_sales
GROUP BY Category ;



-- top products in every category
WITH ranked_products AS
(
	SELECT Category,
    SKU,
    ROUND(SUM(Amount),2) AS revnue,
    ROW_NUMBER() 
    OVER(
    PARTITION BY Category
    ORDER BY SUM(Amount) DESC) rn
FROM amazon_sales
GROUP BY Category,SKU
)
SELECT *
FROM ranked_products
WHERE rn=1 ;
    

-- revenue contribution %
WITH total_sales AS
(
 SELECT SUM(Amount) AS total_revnue
 FROM amazon_sales
 )
 
 SELECT Category,
		 ROUND(SUM(Amount),2) AS revnue,
         ROUND(
			SUM(Amount) * 100 / (SELECT total_revnue 
									FROM total_sales),2) 
			AS con_percent
FROM amazon_sales
GROUP BY Category
ORDER BY con_percent DESC;



-- monthly sales trend
SELECT DATE_FORMAT(
		STR_TO_DATE(Date, '%m-%d-%y'),
        '%Y-%m'
        ) AS month,
        ROUND(SUM(Amount),2) AS revnue
FROM amazon_sales
GROUP BY month
ORDER BY month ;



-- running revenue analysis
SELECT
DATE,
SUM(Amount) AS revnue,
SUM(SUM(Amount))
OVER(
	ORDER BY DATE
	) running_revnue
FROM amazon_sales
GROUP BY DATE ;

-- revenue quartiles
SELECT SKU,
SUM(Amount) revnue,
NTILE(4)
OVER(
	 ORDER BY SUM(Amount) DESC
	) AS revnue_quartile
FROM amazon_sales
GROUP BY SKU ;
     

-- fullfillment performance dashboard
SELECT
Fulfilment,
COUNT(*) orders,
SUM(Qty) units,
ROUND(SUM(Amount),2) revnue,
ROUND(AVG(Amount),2) avg_revnue
FROM amazon_sales
GROUP BY Fulfilment ; 

-- top 3 revenue products per category
WITH ranked_products AS
(
SELECT Category,
SKU,
ROUND(SUM(Amount),2) AS revnue,
DENSE_RANK() 
OVER(
	PARTITION BY Category
    ORDER BY ROUND(SUM(Amount),2)
) AS rnk
FROM amazon_sales
GROUP BY Category,
SKU
)
SELECT * 
FROM ranked_products
WHERE rnk <= 3 ;
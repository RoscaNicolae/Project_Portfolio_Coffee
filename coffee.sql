#select * from coffee;
/*SELECT 
	CONCAT((ROUND(SUM(unit_price * transaction_qty)))/1000, "K")  AS Total_Sales
FROM
    coffee
WHERE
    MONTH(transaction_date) = 3; */
    
/*SELECT 
	COUNT(transaction_id) AS Total_Orders
FROM
    coffee
WHERE
    MONTH(transaction_date) = 3; */

/*SELECT 
	SUM(transaction_qty) AS Total_Quantity_Sold
FROM
    coffee
WHERE
    MONTH(transaction_date) = 5;*/
    
/*SELECT
	MONTH(transaction_date) AS month, -- Number of Month
    ROUND(SUM(unit_price * transaction_qty)) AS total_sales, -- Total Sales Column
    (SUM(unit_price * transaction_qty)- LAG(SUM(unit_price * transaction_qty),1) -- Month Sales Difference
    OVER (ORDER BY MONTH(transaction_date))) / LAG(SUM(unit_price * transaction_qty),1) -- Divisioin by Privision Month Sales
    OVER (ORDER BY MONTH(transaction_date)) * 100 AS mom_increase_percentage -- Percentage
FROM coffee
WHERE 
	MONTH(transaction_date) in(4,5)
GROUP BY
	MONTH(transaction_date)
ORDER BY 
	MONTH(transaction_date);*/
    
/*SELECT
	MONTH(transaction_date) AS month, -- Number of Month
    ROUND(COUNT(transaction_id)) AS total_orders, -- Total Orders Column
    (COUNT(unit_price * transaction_qty)- LAG(COUNT(unit_price * transaction_qty),1) -- Month Sales Difference
    OVER (ORDER BY MONTH(transaction_date))) / LAG(COUNT(unit_price * transaction_qty),1) -- Divisioin by Privision Month Orders
    OVER (ORDER BY MONTH(transaction_date)) * 100 AS mom_increase_percentage -- Percentage
FROM coffee
WHERE 
	MONTH(transaction_date) in(4,5)
GROUP BY
	MONTH(transaction_date)
ORDER BY 
	MONTH(transaction_date);*/

/*SELECT
	MONTH(transaction_date) AS month, -- Number of Month
    SUM(transaction_qty) AS total_quantity_sold, -- Total Quantity Column
    (SUM(transaction_qty)- LAG(SUM(transaction_qty),1) -- Month Sales Difference
    OVER (ORDER BY MONTH(transaction_date))) / LAG(SUM(transaction_qty),1) -- Divisioin by Privision Month Quantity
    OVER (ORDER BY MONTH(transaction_date)) * 100 AS mom_increase_percentage -- Percentage
FROM coffee
WHERE 
	MONTH(transaction_date) in (4,5)
GROUP BY
	MONTH(transaction_date)
ORDER BY 
	MONTH(transaction_date);*/

/*SELECT 
    CONCAT(ROUND(SUM(unit_price * transaction_qty)/1000,1),'K') AS total_sales,
    CONCAT(ROUND(SUM(transaction_qty)/1000,1),'K') AS total_quantity_sold,
    CONCAT(ROUND(COUNT(transaction_id)/1000,1),'K') AS total_orders
FROM
    coffee
WHERE
    DAY(transaction_date) = 18
        AND MONTH(transaction_date) = 5*/
        
/*SELECT 
    CASE
        WHEN DAYOFWEEK(transaction_date) IN (1 , 7) THEN 'Weekends'
        ELSE 'Weekdays'
    END AS DAY_TYPE,
    CONCAT(ROUND(SUM(unit_price * transaction_qty) / 1000,
                    1),
            'K') AS total_sales
FROM
    coffee
WHERE
    MONTH(transaction_date) = 2
GROUP BY DAY_TYPE WITH ROLLUP*/

/*SELECT 
    store_location AS Store_Location,
    CONCAT(ROUND(SUM(unit_price * transaction_qty)/1000,2),'K') AS Total_Sales
FROM
    coffee
WHERE
    MONTH(transaction_date) = 5
GROUP BY store_location
ORDER BY Total_Sales DESC*/

/*SELECT 
	
    AVG(total_sales) AS Avg_Sales
FROM
    (SELECT 
	
        SUM(transaction_qty * unit_price) AS total_sales
    FROM
        coffee
    WHERE
        MONTH(transaction_date) = 5
    GROUP BY transaction_date) AS Internal_query;
    
SELECT 
    DAY(transaction_date) AS day_of_month,
    SUM(unit_price * transaction_qty) AS total_sales
FROM
    coffee
WHERE
    MONTH(transaction_date) = 5
GROUP BY DAY(transaction_date)
ORDER BY DAY(transaction_date); 

SELECT
	day_of_month,
	CASE 
		WHEN total_sales > avg_sales THEN 'Above Average'
		WHEN total_sales < avg_sales THEN 'Below Average'
	ELSE 'Equal to Average'
	END AS sales_status,
	total_sales
FROM (SELECT 
    DAY(transaction_date) AS day_of_month,
    SUM(unit_price * transaction_qty) AS total_sales,
    AVG(SUM(unit_price * transaction_qty)) OVER () avg_sales
FROM
    coffee
WHERE
    MONTH(transaction_date) = 5
GROUP BY DAY(transaction_date)
) AS sales_data
GROUP BY day_of_month;*/

SELECT 
	product_category,
    SUM(unit_price * transaction_qty) AS total_sales
FROM coffee
WHERE
    MONTH(transaction_date) = 5
GROUP BY product_category
ORDER BY  total_sales DESC;

SELECT 
	product_type,
    SUM(unit_price * transaction_qty) AS total_sales
FROM
    coffee
WHERE
    MONTH(transaction_date) = 5
GROUP BY product_type
ORDER BY total_sales DESC
LIMIT 10;

SELECT 
	DAY(transaction_date) as DAY,
    SUM(unit_price * transaction_qty) AS total_sales,
    SUM(transaction_qty) AS Total_qts_sold,
    COUNT(*) AS Total_orders
FROM
    coffee
WHERE
    MONTH(transaction_date) = 5
        AND DAYOFWEEK(transaction_date) = 5
			AND HOUR(transaction_time) = 14
GROUP BY DAY(transaction_date) ;

SELECT 
    HOUR(transaction_time) AS TIME,
    SUM(unit_price * transaction_qty) AS total_sales
FROM
    coffee
WHERE
    MONTH(transaction_date) = 5
GROUP BY HOUR(transaction_time)
ORDER BY HOUR(transaction_time);

SELECT
	CASE
		WHEN DAYOFWEEK(transaction_date) = 2 THEN 'Monday'
        WHEN DAYOFWEEK(transaction_date) = 3 THEN 'Tuesday'
        WHEN DAYOFWEEK(transaction_date) = 4 THEN 'Wednesday'
        WHEN DAYOFWEEK(transaction_date) = 5 THEN 'Thursday'
        WHEN DAYOFWEEK(transaction_date) = 6 THEN 'Friday' 
        WHEN DAYOFWEEK(transaction_date) = 7 THEN 'Saturday'  
        ELSE 'Sunday'
	END AS Day_of_Week,
    ROUND(SUM(unit_price * transaction_qty)) AS Total_Sales
FROM
    coffee
WHERE
    MONTH(transaction_date) = 5
GROUP BY Day_of_Week ;
    
	
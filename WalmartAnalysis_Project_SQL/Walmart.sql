SELECT *
FROM
	salesdatawalmart.sales;
    
-- ---------------------------------------------------
-- ---------------Feature Engineeering----------------

-- Time_of_day

SELECT
	time,
    (CASE
		WHEN time BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
        WHEN time BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
        ELSE "Evening"    
	END
    ) AS time_of_date
FROM sales;

ALTER TABLE sales ADD COLUMN time_of_day VARCHAR(20);
UPDATE sales
SET time_of_day = (CASE
		WHEN time BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
        WHEN time BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
        ELSE "Evening"    
	END
);



-- -----------------------------------------------------------------
-- -- day_Name

SELECT
    DAYNAME(date) AS day_name
FROM
    sales;
    
ALTER TABLE sales ADD COLUMN day_name VARCHAR(30);

UPDATE sales
SET day_name = DAYNAME(date);

-- -----------------------------------------------------------------
-- -- month_name

SELECT
	MONTHNAME(date) AS month_name
FROM sales;

ALTER TABLE sales ADD COLUMN month_name VARCHAR(10);

UPDATE sales
SET month_name = MONTHNAME(date);

-- --------------------------------------------------------
-- --------------Generic Questions-------------------------
-- How many unique cities does the data have?

SELECT DISTINCT city AS unique_cities
FROM sales;

-- -- In which city is each branch?

SELECT
	DISTINCT city,
    branch
FROM sales;


-- --------------------------------------------------------
-- --------------Product Questions-------------------------
-- How many unique product lines does the data have?
SELECT
	COUNT(DISTINCT product_line) AS unique_product_line
FROM	
	sales;

-- What is the most common payment method?
SELECT 
	payment_method,
	COUNT(payment_method) AS payment_count
FROM sales
GROUP BY payment_method
ORDER BY payment_count DESC;

-- What is the most selling product line?

SELECT 
	product_line,
    count(product_line) AS Count_product_line
FROM 
	sales
GROUP BY product_line
ORDER BY Count_product_line DESC;

-- What is the total revenue by month?------------------------

SELECT
	month_name as Month,
    ROUND(SUM(total),0) as Revenue
FROM sales
GROUP BY Month
ORDER BY Revenue DESC;

-- What month had the largest COGS?

SELECT 
	month_name,
    ROUND(SUM(cogs),0) as largest_cogs
FROM sales
GROUP BY month_name
ORDER BY largest_cogs DESC;

-- What product line had the largest revenue?

SELECT
	product_line,
    ROUND(SUM(total),0) AS Revenue
FROM sales
GROUP BY product_line
ORDER BY Revenue DESC;

-- What is the city with the largest revenue?
SELECT
	city, branch,
    ROUND(SUM(total),0) AS Revenue
FROM sales
GROUP BY city, branch
ORDER BY Revenue DESC;

-- What product line had the largest VAT?

SELECT
	product_line,
    ROUND(AVG(VAT),2) AS avg_tax
FROM sales
GROUP BY product_line
ORDER BY avg_tax DESC;

-- Which branch sold more products than average product sold?

SELECT 
	branch,
    product_line,
    SUM(quantity) AS QTY
FROM sales
GROUP BY branch, product_line
HAVING SUM(quantity) > (SELECT AVG(quantity) FROM sales);

-- What is the most common product line by gender?
SELECT
    gender,
	product_line,
    COUNT(gender) AS total_cnt
FROM sales
GROUP BY gender, product_line
ORDER BY total_cnt DESC;

-- What is the average rating of each product line?

SELECT
	product_line,
    ROUND(AVG(rating),2) AS avg_rating
FROM sales
GROUP BY product_line
ORDER BY  avg_rating DESC;

-- --------------------------------------------------------
-- ------------------------ Sales -------------------------- 

-- Number of sales made in each time of the day per weekday

SELECT
	day_name,
	time_of_day,
    COUNT(*) AS total_sales
FROM sales
GROUP BY time_of_day, day_name
ORDER BY total_sales DESC;

-- Which of the customer types brings the most revenue?
SELECT
	customer_type,
    ROUND(sum(total),2) AS revenue
FROM sales
GROUP BY customer_type
ORDER BY revenue DESC;

-- Which city has the largest tax percent/ VAT (Value Added Tax)?

SELECT
	city,
    AVG(VAT) AS VAT
FROM sales
GROUP BY city
ORDER BY VAT DESC;

-- Which customer type pays the most in VAT?

SELECT
	customer_type,
    ROUND(AVG(VAT),2) AS VAT
FROM sales
GROUP BY customer_type
ORDER BY VAT DESC;

-- --------------------------
-- Customer -----------------

-- How many unique customer types does the data have?

SELECT 
	DISTINCT customer_type,
    count(customer_type) AS CNT
FROM sales
GROUP BY customer_type
ORDER BY CNT DESC;

-- How many unique payment methods does the data have?
SELECT 
	DISTINCT payment_method,
    count(payment_method) AS CNT
FROM sales
GROUP BY payment_method
ORDER BY CNT DESC;

-- What is the most common customer type?
SELECT 
	DISTINCT customer_type,
    count(customer_type) AS CNT
FROM sales
GROUP BY customer_type
ORDER BY CNT DESC;

-- Which customer type buys the most?

SELECT 
	customer_type,
    ROUND(SUM(total),0) AS Most
FROM sales
GROUP BY customer_type
ORDER BY Most DESC;

-- What is the gender of most of the customers?

SELECT
	gender,
    COUNT(*) AS CNT
FROM sales
GROUP BY gender
ORDER BY CNT DESC;

-- What is the gender distribution per branch?

SELECT
	branch,
	gender,
    COUNT(*) AS CNT
FROM sales
GROUP BY branch, gender
ORDER BY CNT DESC;

-- Which time of the day do customers give most ratings?

SELECT 	
	time_of_day,
    ROUND(AVG(rating),2) AS avg_rating
FROM sales
GROUP BY time_of_day
ORDER BY avg_rating DESC;

-- Which time of the day do customers give most ratings per branch?

SELECT 
	branch,
	time_of_day,
    ROUND(AVG(rating),2) AS avg_rating
FROM sales
GROUP BY branch ,time_of_day
ORDER BY avg_rating DESC;

-- Which day fo the week has the best avg ratings?

SELECT 
	day_name,
    ROUND(AVG(rating),2) AS avg_rating
FROM sales
GROUP BY day_name
ORDER BY avg_rating DESC;

-- Which day of the week has the best average ratings per branch?

SELECT 
	branch,
	day_name,
    ROUND(AVG(rating),2) AS avg_rating
FROM sales
GROUP BY branch , day_name
ORDER BY avg_rating DESC;














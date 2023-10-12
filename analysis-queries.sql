--Check the data
select * from sales_data

--eyeball the distinct values in different columns
SELECT DISTINCT status FROM sales_data; 

SELECT DISTINCT country FROM sales_data; 

SELECT DISTINCT productline FROM sales_data; 

SELECT DISTINCT year_id FROM sales_data;

SELECT DISTINCT territory FROM sales_data; 

SELECT DISTINCT dealsize FROM sales_data; 

SELECT DISTINCT month_id FROM sales_data WHERE year_id = 2005;

--Grouping sales by year_id
SELECT year_id, sum(sales) AS revenue
FROM sales_data
GROUP BY year_id
ORDER BY revenue DESC;

-- Grouping sales by productline
SELECT productline, sum(sales) AS revenue
FROM sales_data
GROUP BY productline
ORDER BY revenue DESC;

--Grouping sales by dealsize
SELECT dealsize, sum(sales) AS revenue
FROM sales_data
GROUP BY dealsize
ORDER BY revenue DESC;

-- Best month for sales in a specific year
SELECT month_id, sum(sales) AS revenue, count(ordernumber) AS frequency_of_orders
FROM sales_data
WHERE year_id = 2003
GROUP BY month_id
ORDER BY revenue desc;

-- Product sold in the best month 
SELECT month_id, productline, sum(sales) AS revenue, count(ordernumber) AS frequency_of_orders
FROM sales_data
WHERE year_id = 2004 AND month_id = 8 
GROUP BY month_id, productline
ORDER BY revenue DESC;

-- Best customer segmentation using RFM (Recency, Frequency, Monetary Value)

CREATE TEMP TABLE rfm_table AS
WITH rfm_cte AS (
    SELECT
        customername,
        sum(sales) AS monetaryvalue,
        avg(sales) AS avgmonetaryvalue,
        count(ordernumber) AS frequency,
        max(orderdate) AS last_order_date,
        (SELECT max(orderdate) FROM sales_data) AS max_order_date,
        EXTRACT(DAY FROM AGE(current_date, max(orderdate))) AS recency
    FROM sales_data
    GROUP BY customername
)
SELECT
    c.*,
    rfm_recency + rfm_frequency + rfm_monetary AS rfm_cell,
    CONCAT(rfm_recency::TEXT, rfm_frequency::TEXT, rfm_monetary::TEXT) AS rfm_cell_string
INTO TEMP rfm
FROM (
    SELECT
        r.*,
        NTILE(4) OVER (ORDER BY recency DESC) AS rfm_recency,
        NTILE(4) OVER (ORDER BY frequency) AS rfm_frequency,
        NTILE(4) OVER (ORDER BY monetaryvalue) AS rfm_monetary
    FROM rfm_cte r
) c;


SELECT
    customername,
    rfm_recency,
    rfm_frequency,
    rfm_monetary,
    CASE
        WHEN rfm_cell_string IN ('111', '112', '121', '122', '123', '132', '211', '212', '114', '141') THEN 'lost_customers'
        WHEN rfm_cell_string IN ('133', '134', '143', '244', '334', '343', '344', '144') THEN 'slipping_away_cannot_lose'
        WHEN rfm_cell_string IN ('311', '411', '331') THEN 'new_customers'
        WHEN rfm_cell_string IN ('222', '223', '233', '322') THEN 'potential_churners'
        WHEN rfm_cell_string IN ('323', '333', '321', '422', '332', '432') THEN 'active'
        WHEN rfm_cell_string IN ('433', '434', '443', '444') THEN 'loyal'
    END AS rfm_segment
FROM rfm;

-- Products most often sold together
SELECT DISTINCT ordernumber,
       string_agg(productcode::text, ',' ORDER BY productcode) AS productcodes
FROM sales_data s
WHERE ordernumber IN (
    SELECT ordernumber
    FROM (
        SELECT ordernumber, COUNT(*) AS rn
        FROM sales_data
        WHERE status = 'Shipped'
        GROUP BY ordernumber
    ) m
    WHERE rn = 3
)
GROUP BY ordernumber
ORDER BY productcodes DESC;

--City with the highest number of sales in a specific country (e.g., UK)
SELECT city, sum(sales) AS revenue
FROM sales_data
WHERE country = 'UK'
GROUP BY city
ORDER BY revenue DESC;

--Best product in the United States (e.g., USA)
SELECT country, year_id, productline, sum(sales) AS revenue
FROM sales_data
WHERE country = 'USA'
GROUP BY country, year_id, productline
ORDER BY revenue DESC;

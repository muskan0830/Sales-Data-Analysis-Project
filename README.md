# Sales-Data-Analysis-Project
This SQL project delves into the comprehensive analysis of sales data, aiming to extract valuable insights, identify customer segments, and uncover patterns within the dataset. The project's primary objective is to empower decision-makers with actionable information to optimize sales strategies, improve customer engagement, and enhance revenue generation.
(Data is sourced from Kaggle)

Problem Statement: The sales team requires actionable insights from historical sales data to enhance decision-making processes, segment customers effectively, and identify opportunities for revenue growth. Additionally, understanding which products are frequently sold together can inform product bundling strategies. The project seeks to address these challenges through data analysis.

Concepts Used:
This project leverages various SQL concepts and techniques:
1. Data Exploration:
   - SELECT DISTINCT: This concept is used to identify and retrieve unique values in specific columns such as "status," "country," "productline," "year_id," "territory," "dealsize," and "month_id." It helps in understanding the variety of data and ensuring data quality.

2. Sales Trends Analysis:
   - GROUP BY: This concept is utilized to group the sales data by specific columns like "year_id," "productline," and "dealsize." It allows aggregation of data based on these attributes.
   - SUM: The SUM function is employed to calculate the total sales within each group, providing insights into the overall revenue generated.
   - ORDER BY: It is used to sort the results in descending order, helping to identify top-performing years, product lines, or deal sizes.
   - WHERE: The WHERE clause is employed to filter data, e.g., selecting sales data for a specific year (e.g., 2003) or month (e.g., August 2004).

3. Customer Segmentation (RFM Analysis):
   - WITH: This clause allows the creation of a temporary table (rfm_cte) to perform intermediate calculations.
   - EXTRACT: It is used to calculate the recency of customer orders by finding the difference between the current date and the last order date.
   - NTILE: NTILE is employed to divide customers into quartiles (RFM scores) based on recency, frequency, and monetary value. It helps segment customers effectively.
   - CASE: Conditional statements are used to assign customers to specific segments (e.g., loyal, lost, active) based on their RFM scores.

4. Market Basket Analysis:
   - DISTINCT: This keyword ensures that only unique order numbers are selected.
   - string_agg: It aggregates product codes into a comma-separated list for each order, facilitating identification of products frequently sold together.
   - IN: The IN operator is used to filter orders with a specific count of items, in this case, orders with three items.

5. Regional Analysis:
   - WHERE: It is used to filter sales data for a specific country (e.g., 'UK' or 'USA').
   - GROUP BY: The GROUP BY clause groups sales data by city in the selected country.
   - SUM: It calculates the total revenue generated in each city.
   - ORDER BY: The ORDER BY clause sorts cities by revenue in descending order.

These SQL concepts collectively enable the extraction of valuable insights from the sales data, such as annual revenue trends, top-performing products, customer segmentation, product associations, and regional sales patterns. By applying these concepts, the project effectively addresses the objectives of improving decision-making, customer engagement, and revenue growth.

Summary of Insights:
1. Annual revenue trends reveal the most profitable years.
2. Top-performing product lines can be identified to focus on product development efforts.
3. Understanding deal size impact on revenue aids in pricing strategies.
4. The best sales month provides insight into seasonality.
5. Customer segmentation allows for tailored marketing strategies.
6. Market basket analysis highlights products suitable for bundling.
7. Regional analysis helps in optimizing marketing efforts.

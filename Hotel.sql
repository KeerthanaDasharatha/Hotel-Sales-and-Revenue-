CREATE database hotel;
use hotel;

SELECT  * from hotel_sales;

-- 1 What is the total number of transaction
SELECT COUNT(*) as total_count
FROM hotel_sales;


 -- 2 What is the total gross sales?
SELECT SUM(Gross_Amount) as total_sales 
FROM hotel_sales;
 
 
-- 3 Most Popular Payment Mode
SELECT Payment_Modes,
SUM(Gross_Amount) AS Total_Sales
FROM hotel_sales
GROUP BY Payment_Modes
ORDER BY Total_Sales DESC;
 
 
-- 4 What are the total and average gross sales in each city?
SELECT city,
SUM(Gross_Amount) as Total_sales,
avg(Gross_Amount) as avg_sales
FROM hotel_sales
GROUP BY City;


-- 5 How many items were sold in each category?
SELECT Category,
SUM(Sale_Item_Qty) as Total_sales 
FROM hotel_sales
GROUP BY Category
ORDER BY total_sales DESC;


-- 6 What is the total gross sales for each day of the week?
SELECT day,
SUM(Gross_Amount) as Total_sales 
FROM hotel_sales
GROUP BY day
ORDER BY total_sales DESC;


-- 7 Top 10 category and payment mode combos by total sales
SELECT Category, Payment_Modes,
SUM(Gross_Amount) AS Total_Sales
FROM hotel_sales
GROUP BY Category, Payment_Modes
ORDER BY Total_Sales DESC
LIMIT 10;


-- 8 How much discount (as a percentage) does each branch in each city give on total sales?
SELECT Branch_Name,City,
ROUND(SUM(Discounts) * 100.0 / SUM(Gross_Amount), 2) AS discount_percentage
FROM hotel_sales
GROUP BY Branch_Name,city
ORDER BY discount_percentage DESC;


-- 9  Rank branches by total gross sales
SELECT Branch_Name,City,
SUM(Gross_Amount) AS Total_Sales,
RANK() OVER (ORDER BY SUM(Gross_Amount) DESC) AS Sales_Rank
FROM hotel_sales
GROUP BY Branch_Name, City;


-- 10 Most popular payment mode in each city 
 SELECT * FROM (
SELECT City,Payment_Modes,
SUM(Gross_Amount) AS Total_Sales,
RANK() OVER (PARTITION BY City ORDER BY SUM(Gross_Amount) DESC) AS Payment_Rank
FROM hotel_sales
GROUP BY City, Payment_Modes
) AS ranked_payments
WHERE Payment_Rank = 1;


-- 11 Daily Gross Sales
SELECT Day,
DATE_FORMAT(Business_Date, '%Y-%m-%d') AS Sales_date,
SUM(Gross_Amount) AS Monthly_Sales
FROM hotel_sales
GROUP BY Day,DATE_FORMAT(Business_Date, '%Y-%m-%d')
ORDER BY Sales_date;


-- 12  Most Selling Category per City
SELECT City, Category,
SUM(Sale_Item_Qty) AS Items_Sold
FROM hotel_sales
GROUP BY City, Category
ORDER BY City, Items_Sold DESC;


-- 13 Branch Performance Over Time
SELECT Branch_Name,
DATE_FORMAT(Business_Date, '%Y-%m') AS Month,
SUM(Gross_Amount) AS Monthly_Sales
FROM hotel_sales
GROUP BY Month, Branch_Name
ORDER BY Month, Branch_Name;


-- 14  Top 5 Invoices with Highest Discount
SELECT Invoice_Number, Branch_Name, Gross_Amount, Discounts
FROM hotel_sales
ORDER BY Discounts DESC
LIMIT 5;


-- 15 Peak Sales Hour 
SELECT 
HOUR(Invoice_Time) AS Hour, 
COUNT(*) AS Transactions, 
SUM(Gross_Amount) AS Total_Sales
FROM hotel_sales
GROUP BY Hour
ORDER BY Total_Sales DESC;

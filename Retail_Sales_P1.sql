Create Database Project_P2;
Use Project_P2;

-- Creating Table
Drop Table if exists Retail_Sales;

Create table Retail_Sales
	(
		transaction_id INT Primary Key,
		sale_date DATE,
		sale_time TIME,
		customer_id INT,
		gender VARCHAR (15), 
		age	INT,
		category VARCHAR (15),
		quantity INT,
		price_per_unit FLOAT,
		cogs FLOAT,
		total_sale FLOAT
    );
    
Select * from Retail_Sales;

-- *************
-- DATA CLEANING
-- *************
Select count(*) from Retail_Sales;

-- Finding Null Values
SELECT * FROM retail_sales
WHERE
transaction_id IS NULL
OR
sale_date IS NULL
OR
sale_time IS NULL
OR
gender IS NULL
OR
category IS NULL
OR
quantity IS NULL
OR
cogs IS NULL
OR
total_sale IS NULL;

-- Removing Null Values
Delete FROM retail_sales
WHERE
transaction_id IS NULL
OR
sale_date IS NULL
OR
sale_time IS NULL
OR
gender IS NULL
OR
category IS NULL
OR
quantity IS NULL
OR
cogs IS NULL
OR
total_sale IS NULL;

-- ****************
-- DATA EXPLORATION
-- ****************
Select * from Retail_Sales;

-- How many Sales we have?
Select Count(*) as Total_Sales from Retail_Sales;

-- How many Unique Customers we Have?
Select count(Distinct Customer_id) as Unique_Customers from Retail_Sales;

-- How many Unique Categories we Have?
Select Distinct Category from Retail_Sales;

-- ***********************************************
-- Data Analysis & Business Key Problems & Answers
-- ***********************************************
Select * from Retail_Sales;

-- Q.1 Write the SQL Query to retrieve all columns fro Sales made on '2022-11-05'
Select * from Retail_Sales where Sale_date = '2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 3 in
-- the month of Nov-2022
Select * from Retail_Sales
where Category = 'Clothing' AND Quantity >= 3 AND Year(Sale_date) = '2022' AND Month(Sale_date) = '11';

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
Select Category, Sum(total_Sale) As Total_Sales, Count(*) as Total_Orders from Retail_Sales group by Category;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
Select Round(Avg(age), 2) As Average_Age from Retail_Sales Where Category = 'Beauty';

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
Select * from Retail_Sales Where Total_Sale > 1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
Select Category, Gender, Count(*) As Total_Transection_Id from Retail_Sales group by Category, Gender;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
Select Year(sale_Date) as Sale_Year, Month(sale_Date) as Sale_Month, Round(Avg(Total_sale), 2) As Sales from Retail_Sales
Group by Sale_Year, Sale_Month order by Sale_Year, Sale_Month;

-- Find out best selling month in each year
-- By Window Function
Select * from (Select *, Rank() over(Partition by Sale_Year order by Sales Desc) as Rnk from
(Select Year(sale_Date) as Sale_Year, Month(sale_Date) as Sale_Month, Round(Avg(Total_sale), 2) As Sales from Retail_Sales
Group by Sale_Year, Sale_Month order by Sale_Year, Sale_Month) as a) as b
where Rnk = 1;

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales
Select Customer_id, sum(Total_Sale) As Sales from Retail_Sales group by Customer_id order by Sales desc Limit 5;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
Select Category, Count(Distinct Customer_id) as cnt_unique_cs from Retail_sales group by Category;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
with Hourly_Sales
as (
Select *,
	Case 
		When Hour(Sale_time) <= 12 then 'Morning'
        when Hour(Sale_time) Between  12 and 17 then 'Afternoon'
        else 'Evening'
	End as Shift
From Retail_Sales
)
Select Shift, Count(*) as Total_Orders from Hourly_Sales group by Shift;

-- Q.11 Write a SQL query to find the number of Unique Customer Purchased item from Each Categories.
Select Count(*) as Unique_Customers from (Select Customer_id, Count(Category) as Purchased_Categories from
(Select Customer_id, Category from Retail_Sales Group by Customer_id, Category Order by Customer_id, Category) as a
group by Customer_id Having Purchased_Categories = (Select count(Distinct Category) from Retail_Sales)) as b;


-- **************
-- End Of Project
-- **************
# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis	
**Database**: `Project_P2`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `p1_retail_db`.
- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
Create Database Project_P2;
Use Project_P2;

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
```

### 2. Data Cleaning

- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

**Finding Null Values**:
```sql
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
```
**Removing Null Values**:
```sql
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
```
### 3. Data Exploration

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.

**How many Sales we have?**:
```sql
Select Count(*) as Total_Sales from Retail_Sales;
```
**How many Unique Customers we Have?**:
```sql
Select count(Distinct Customer_id) as Unique_Customers from Retail_Sales;
```
**How many Unique Categories we Have?**:
```sql
Select Distinct Category from Retail_Sales;
```

### 4. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05**:
```sql
Select * from Retail_Sales where Sale_date = '2022-11-05';
```

2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022**:
```sql
Select * from Retail_Sales
where Category = 'Clothing' AND Quantity >= 3 AND Year(Sale_date) = '2022' AND Month(Sale_date) = '11';
```

3. **Write a SQL query to calculate the total sales (total_sale) for each category.**:
```sql
Select Category, Sum(total_Sale) As Total_Sales, Count(*) as Total_Orders from Retail_Sales group by Category;
```

4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:
```sql
Select Round(Avg(age), 2) As Average_Age from Retail_Sales Where Category = 'Beauty';
```

5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:
```sql
Select * from Retail_Sales Where Total_Sale > 1000;
```

6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:
```sql
Select Category, Gender, Count(*) As Total_Transection_Id from Retail_Sales group by Category, Gender;
```

7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:
```sql
Select Year(sale_Date) as Sale_Year, Month(sale_Date) as Sale_Month, Round(Avg(Total_sale), 2) As Sales from Retail_Sales
Group by Sale_Year, Sale_Month order by Sale_Year, Sale_Month;
```

8. **Write a SQL query to find the top 5 customers based on the highest total sales **:
```sql
Select Customer_id, sum(Total_Sale) As Sales from Retail_Sales group by Customer_id order by Sales desc Limit 5;
```

9. **Write a SQL query to find the number of unique customers who purchased items from each category.**:
```sql
Select Category, Count(Distinct Customer_id) as cnt_unique_cs from Retail_sales group by Category;
```

10. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:
```sql
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
```

## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.

## Author - SAGAR PANCHAL

This project is part of my portfolio, showcasing the SQL skills essential for data analyst roles.

create table retail_shop(
			transactions_id int primary key,	
			sale_date date,
			sale_time time,
			customer_id int,
			gender varchar(15),
			age	int,
			category varchar(15),
			quantiy int,
			price_per_unit int,
			cogs	float,
			total_sale float

);
copy
retail_shop(transactions_id, sale_date, sale_time, customer_id, gender,	age, category, quantiy,	price_per_unit, cogs, total_sale)
from 'D:\Projects(github)\SQL - Retail Sales Analysis_utf  (1).csv'
delimiter','
CSV Header;
select * from retail_shop;

select * from retail_shop;

Select count(*) from retail_shop;

--- to iditify the null values
select * from retail_shop
where transactions_id is null 

select * from retail_shop
where sale_date is null 

---- data cleaning 
--- to null values from all coloumn
select * from retail_shop
where 
	transactions_id is null
	OR
	sale_date is null
	OR
	gender is null
	OR
	sale_time is null
	OR 
	category is null
	OR
	quantiy is null
	OR
	cogs is null
	OR
	total_sale is null
--how to delete the null values 
DELETE from retail_shop
where 
transactions_id is null
	OR
	sale_date is null
	OR
	gender is null
	OR
	sale_time is null
	OR 
	category is null
	OR
	quantiy is null
	OR
	cogs is null
	OR
	total_sale is null

--- Data exploration
--- how many sales we have 
select count(*) as total_sale from retail_shop

--- how many customer we have 
select count(distinct customer_id) as count_of_customers 
from retail_shop

--- how many categories we have 
select distinct category as count_of_customers 
from retail_shop

---- Data Analysis & business key problems & answers 

My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
select *
from retail_shop
where sale_date='2022-11-05'

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' 
---and the quantity sold is more than 10 in the month of Nov-2022
select 
	category ,
sum(quantiy)
from retail_shop
where category = 'Clothing'
group by 1
-------------------------------------------------
select *
from retail_shop
where category ='Clothing'
and 
To_char(sale_date,'YYYY-MM') = '2022-11'
and quantiy>=4
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
select 
	category,
sum(total_sale) as net_sale,
count(*) as total_order
from retail_shop
group by 1


-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

select 
	round(avg(age),2) as avg_age 
from retail_shop
where category = 'Beauty'
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
select * from retail_shop
where total_sale > 1000


-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
select 
	category ,
	gender,
	count(*) as total_trans
from retail_shop
group by category , gender
order by 1
	

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
select 
	EXTRACT(YEAR from sale_date ) as year,
	EXTRACT(month from sale_date)as month,
	round(avg(total_sale)) as avg_total_Sale,
	rank() over (partition by extract (year from sale_date) order by avg(total_sale)desc)
from retail_shop
group by 1,2
----order by 1,3 desc

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
select 
	customer_id,
	sum(total_sale) as total_Sales
from retail_shop 
group by 1
order by 2 desc
limit 5

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
select 
category,
count(distinct customer_id) as unique_customer
from retail_shop
group by category 

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
select * from retail_shop

with hourly_sales
as(
select *,
	case 
	when EXTRACT(HOUR FROM sale_time) < 12 then 'Morning'
	when EXTRACT (HOUR FROM sale_time) between 12 and 17 then 'Afternoon'
	else 'Evening'
		end as shift 
	from retail_shop
)
select 
	shift ,
	count(*) as total_order
from hourly_sales
group by shift

--- End of project 
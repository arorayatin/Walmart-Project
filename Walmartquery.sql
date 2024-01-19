-- ------------------------------Feature engineering-------------------------------------------
-- Add a new column named time_of_day to give insight of sales in the Morning, Afternoon and Evening--------- 
select  (case when `time` between '00:00:00' and '12:00:00' then 'Morning'
when `time` between '12:00:01' and '16:00:00' then 'Afternoon'
else 'evening' end ) as time_of_day
from sales ; 

ALTER TABLE sales Add column time_of_day varchar(20) ;

UPDATE sales Set time_of_day = (case when `time` between '00:00:00' and '12:00:00' then 'Morning'
when `time` between '12:00:01' and '16:00:00' then 'Afternoon'
else 'evening' end ) ; 

-- Add a new column named day_name that contains the extracted days of the week-------------------------
select date, dayname(date)
from sales ; 

Alter table sales add Column day_name varchar(30) ; 

Update sales set day_name = (dayname(date) ) ; 

-- Add a new column named month_name that contains the extracted months of the year-----------------------
select monthname(date) from sales ; 

alter table sales add column Month_name varchar(30) ;

update sales set Month_name = (monthname(date) ) ; 

-- -------------------------------------------------------------------------------------------------------
-- ---------------------------------------Generic Question----------------------------- 

-- How many unique cities does the data have?
select count(distinct(city)) from sales ; 

-- In which city is each branch?
select distinct city 
from sales 
where branch = 'A' Or branch = 'B' Or branch = 'C' ; 

-- --------------------------------------------------------------------------------------------------------
-- -------------------------------------------Product------------------------------------------------------

-- How many unique product lines does the data have? 
select distinct(product_line) 
from sales ; 

-- What is the most common payment method?
 select payment, count(payment)
 from sales 
 group by payment ; 
 
 -- What is the most selling product line?
 select product_line  , sum(quantity)as total_quantity_sold
 from sales 
 group by product_line 
 order by total_quantity_sold desc 
 limit 1; 
 
 -- What is the total revenue by month? 
 
select month_name, sum(gross_income) as total_revenue 
from sales 
group by month_name ; 

-- What month had the largest COGS? 
 select month_name , sum(cogs) as Largest_COGS 
 from sales 
 group by month_name 
 order by Largest_COGS  desc ; 

-- What product line had the largest revenue? 
select product_line , sum(gross_margin_pct) as Largest_revenue
from sales 
group by product_line
order by Largest_revenue desc ; 

-- What product line had the largest VAT? 
select product_line , sum(tax_pct) as 'Largest Vat'
from sales 
group by product_line 
order by 'Largest Vat' desc ;

-- Fetch each product line and add a column to those product line showing "Good", "Bad". Good if its greater than average sales

select product_line , avg(total) as 'average_sales' , (case when sum(total) > 'average_sales' then 'Good' 
                      when sum(total) < 'average_sales' then 'Bad' end ) as Product_rating 
  from sales 
  group by product_line ; 
  
  
-- Which branch sold more products than average product sold? 
select branch , sum(quantity) as qty
from sales 
group by branch 
having qty > (select avg(quantity) from sales ) ;

-- What is the most common product line by gender? 
 select product_line , gender , count(gender) as cnt
 from sales 
 group by product_line , gender 
 order by cnt desc; 
 
 -- What is the average rating of each product line?
 
 select product_line , avg(rating) as 'avg_rating'
 from sales 
 group by product_line ; 
 
 -- --------------------------------------------------------------------------------------------------------
 -- -----------------------------------------Sales----------------------------------------------------------
 
 -- Number of sales made in each time of the day per weekday? 
 select count(total) as 'no_of_sales' , time_of_day
 from sales 
 group by time_of_day ; 
 
 -- Which of the customer types brings the most revenue? 
 select customer_type , sum(total) as 'Most revenue'
 from sales 
 group by customer_type 
 order by 2 desc ;

-- Which city has the largest tax percent/ VAT (Value Added Tax)? 
select sum(tax_pct) , city 
from sales 
group by city 
order by 1 desc ; 

-- ----------------------------------------------------------------------------------------------------------
-- ---------------------------------------------Customer-----------------------------------------------------

-- Which time of the day do customers give most ratings? 

select time_of_day , avg(rating) as most_ratings 
from sales 
group by 1 
order by 2 desc;  

-- Which day of the week has the best average ratings per branch?
select day_name , avg(rating) as most_ratings 
from sales 
group by 1 
order by 2 desc;  

-- ----------------------------------------------------------------------------------------------------------























 
 
 
 
 
 





















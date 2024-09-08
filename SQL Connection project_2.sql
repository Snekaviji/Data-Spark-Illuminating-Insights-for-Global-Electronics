create database customer_sales;

select * from customer_sales.customer_details;
select * from customer_sales.exchange_details;
select * from customer_sales.product_details;
select * from customer_sales.sales_details;
select * from customer_sales.stores_details;

SET SQL_SAFE_UPDATES = 0;

describe  customer_sales.customer_details;
describe  customer_sales.exchange_details;
describe  customer_sales.product_details;
describe  customer_sales.sales_details;
describe  customer_sales.stores_details;

-- queries to get insights from 5 tables
-- 1.overall female count
select count(Gender) as Female_count from customer_sales.customer_details 
where Gender="Female";

-- 2.overall male count
select count(Gender) as Male_count from customer_sales.customer_details 
where Gender="Male";

-- 3.count of customers in country wise
select sd.Country, count(distinct c.CustomerKey) as customer_count
from customer_sales.sales_details c 
join customer_sales.stores_details sd on c.StoreKey = sd.StoreKey
group by sd.Country 
order by customer_count desc;

-- 4.overall count of customers
select count(distinct s.CustomerKey) as customer_count
from customer_sales.sales_details s;

-- 5.Country-wise store count
select Country, count(StoreKey) 
from customer_sales.stores_details 
group by Country 
order by count(StoreKey) desc;

-- 6.store wise sales
select s.StoreKey, sd.Country, sum(pd.Unit_Price_USD * s.Quantity) as total_sales_amount
from customer_sales.product_details pd
join customer_sales.sales_details s on pd.ProductKey = s.ProductKey
join customer_sales.stores_details sd on s.StoreKey = sd.StoreKey
group by s.StoreKey, sd.Country;

-- 7.overall total sales
select sum(pd.Unit_Price_USD * sd.Quantity) as total_sales_amount
from customer_sales.product_details pd
join customer_sales.sales_details sd on pd.ProductKey = sd.ProductKey;

-- 8. brand count
select Brand, count(Brand) as brand_count 
from customer_sales.product_details 
group by Brand;

-- 9. brand wise total sales
select Brand, round(sum(pd.Unit_price_USD * sd.Quantity), 2) as sales_amount
from customer_sales.product_details pd
join customer_sales.sales_details sd on pd.ProductKey = sd.ProductKey
group by Brand;

-- 10.country wise overall sales
use customer_sales;
SELECT s.Country, SUM(pd.Unit_price_USD * sd.Quantity) AS total_sales
FROM product_details pd
JOIN sales_details sd ON pd.ProductKey = sd.ProductKey
JOIN stores_details s ON sd.StoreKey = s.StoreKey
GROUP BY s.Country;

SELECT s.Country, COUNT(DISTINCT s.StoreKey), SUM(pd.Unit_price_USD * sd.Quantity) AS total_sales
FROM product_details pd
JOIN sales_details sd ON pd.ProductKey = sd.ProductKey
JOIN stores_details s ON sd.StoreKey = s.StoreKey
GROUP BY s.Country;    


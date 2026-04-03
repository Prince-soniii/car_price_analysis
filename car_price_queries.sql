create database car_price_analysis;
use  car_price_analysis;
select* from car_details;

-- 1. Find the total number of cars and the average price.
select count(car_id) as total_no_of_cars , round(avg(price),2) as avg_price
from car_details


-- 2. Count how many cars are available for each brand.
select brand, count(car_id) as total_cars
from car_details
group by (brand)

-- 3. Identify the most expensive car in the dataset.
select brand,model,price
from car_details 
order by price desc
limit 1;


-- 🟡 Medium
-- 4.Calculate the average price for each brand.
select brand, round(avg(price),2) as avg_price
from car_details
group by (brand);

-- 5.Count the number of cars in each price category.
select price_category, count(car_id)
from car_details
group by price_category;

-- 6.Retrieve the top 5 most expensive cars.
select brand,price
from car_details
order by price desc
limit 5;

-- 7.Analyze the average price of cars by year (trend analysis).
select  year,round(avg(price),2) as avg_price
from car_details
group by year
order by year;

-- 8.Find the most expensive car for each brand.
with car as (select
	brand,
	model,
	price,
    row_number() over(partition by brand order by price desc ) as rnk
    from  car_details
)
select brand,model,price 
from car
where rnk =2;

-- 9.Retrieve the top 3 most expensive cars within each brand.
with carss as (select
	brand,
    model,
    price,
	row_number() over(partition by brand order by price desc ) as rnnk
    from car_details
)
select brand,model,price
from carss
where rnnk <=3
order by  brand , rnnk ;


-- 10. Identify cars whose price is higher than the average price of their respective brand.
WITH avg_table AS (
    SELECT brand, AVG(price) AS avg_price
    FROM car_details
    GROUP BY brand
)

SELECT 
    c.brand,
    COUNT(CASE WHEN c.price > a.avg_price THEN 1 END) AS above_avg_count
FROM car_details c
JOIN avg_table a
ON c.brand = a.brand
GROUP BY c.brand;


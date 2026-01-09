USE pizza_sales_analysis;
select * from pizza_sales;
rename table `pizza_sales` to Pizzeria;
select * from Pizzeria;
set SQL_SAFE_UPDATES = 0;
update pizzeria set total_price="13.50" where order_id=1;
DELETE FROM Pizzeria where pizza_id="ital_supr_l";
select pizza_size,pizza_category from Pizzeria;
select * from pizzeria where total_price>16;
select pizza_id from pizzeria where pizza_id like "m%";
select * from pizzeria where pizza_id IN ("cali_ckn_l","chicken");
select * from pizzeria order by total_price ASC;
select * from pizzeria order by total_price DESC;

#total sales by category
SELECT pizza_category, SUM(total_price) AS total_sales 
FROM pizzeria
GROUP BY pizza_category;

#most ordered pizza
SELECT pizza_name, SUM(quantity) AS total_quantity
FROM Pizzeria
GROUP BY pizza_name
ORDER BY total_quantity DESC
LIMIT 1;

#Daily Sales Summary
SELECT order_date, SUM(total_price) AS daily_sales
FROM Pizzeria
GROUP BY order_date
ORDER BY order_date;

#Avergae order value
SELECT AVG(total_price) AS avg_order_value
FROM Pizzeria;

#Top 5 most Expensive pizza;
SELECT pizza_name, unit_price
FROM Pizzeria
GROUP BY pizza_name, unit_price
ORDER BY unit_price DESC
LIMIT 5;

#offset
SELECT pizza_name, unit_price
FROM Pizzeria
GROUP BY pizza_name, unit_price
ORDER BY unit_price DESC
LIMIT 5 OFFSET 5;

INSERT INTO Pizzeria VALUES 
(1, 1, 'hawaiian_m', 1, '2015-01-01', '11:38:36 AM', 13.25, 13.25, 'M', 'Classic', 'Sliced Ham, Pineapple, Mozzarella Cheese', 'The Hawaiian Pizza'),
(2, 2, 'classic_dlx_m', 1, '2015-01-01', '11:57:40 AM', 16.00, 16.00, 'M', 'Classic', 'Pepperoni, Mushrooms, Red Onions, Red Peppers, Mozzarella Cheese', 'The Classic Deluxe Pizza');

SELECT *
FROM Pizzeria
WHERE pizza_category = 'Veggie'
  AND pizza_size IN ('L');

#Joins
CREATE TABLE Customers (customer_id INT PRIMARY KEY,customer_name VARCHAR(100),
    email VARCHAR(100),city VARCHAR(50));
    
    INSERT INTO Customers VALUES(1, 'Rahul Mehta',    'rahul@gmail.com',    'Mumbai'),(2, 'Priya Sharma',   'priya@yahoo.com',    'Delhi'),
(3, 'Amit Verma',     'amitv@hotmail.com',  'Bangalore'),(4, 'Sneha Kapoor',   'sneha@gmail.com',    'Chennai'),
(5, 'Ravi Desai',     'ravi@outlook.com',   'Pune');
select * from customers;
ALTER TABLE Pizzeria ADD COLUMN customer_id INT;

UPDATE Pizzeria
SET customer_id = FLOOR(1 + RAND() * 5);

select p.name, sum(oi.quantity) AS total_sold, count(oi.order_id) as order_count from products p
inner join OrderItems oi on p.product_id = oi.product_id
group by p.product_id,p.name;

#inner join
select
 p.order_id,c.customer_name AS customer, p.order_date,p.total_price 
 from pizzeria p 
 inner join 
 customers c on p.customer_id=c.customer_id;

select c.customer_name, sum(p.quantity) AS total_sold, count(p.order_id) as order_count from pizzeria p
inner join customers c on p.customer_id = c.customer_id
group by p.customer_id,p.order_id;

select pizza_category, count(order_id) as total_orders, round(sum(total_price),2) as total_sales
 from pizzeria
 group by pizza_category;
 
 
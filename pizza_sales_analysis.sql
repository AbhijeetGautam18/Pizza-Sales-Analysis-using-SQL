
-- create "TASTY_PIZZA" database
CREATE DATABASE TASTY_PIZZA;

-- using "TASTY_PIZZA" database
USE TASTY_PIZZA;

---------------------------------------------------------------------------------------------------------------------------------------------

-- 1. Retrieve the total number of orders placed.
SELECT 
    COUNT(order_id)
FROM
    orders;

-- Total numbers of orders placed is 21350.

---------------------------------------------------------------------------------------------------------------------------------------------

-- 2. Calculate the total revenue generated from pizza sales.
SELECT 
    SUM(od.quantity * p.price) AS Revenue_Generated
FROM
    order_details od
        LEFT JOIN
    pizzas p ON od.pizza_id = p.pizza_id;

-- Total revenue generated from pizza sales is 817860.05

---------------------------------------------------------------------------------------------------------------------------------------------

-- 3. Identify the highest-priced pizza.
SELECT 
    pt.name, p.price
FROM
    pizza_types pt
        JOIN
    pizzas p ON pt.pizza_type_id = p.pizza_type_id
ORDER BY price DESC
LIMIT 1;

-- The highest priced pizza is "The Greek Pizza".

---------------------------------------------------------------------------------------------------------------------------------------------

-- 4. Identify the most common pizza size ordered.

SELECT 
    p.size, COUNT(p.size) AS Commom_Size
FROM
    order_details od
        JOIN
    pizzas p ON od.pizza_id = p.pizza_id
GROUP BY 1
ORDER BY Commom_Size DESC
LIMIT 1;

-- The most common size is L ordered 18526 times.

---------------------------------------------------------------------------------------------------------------------------------------------

-- 5. List the top 5 most ordered pizza types along with their quantities.
SELECT 
    pt.name, SUM(od.quantity) AS Quantity_Ordered
FROM
    pizza_types pt
        JOIN
    pizzas p ON pt.pizza_type_id = p.pizza_type_id
        JOIN
    order_details od ON p.pizza_id = od.pizza_id
GROUP BY 1
ORDER BY Quantity_Ordered DESC
LIMIT 5;

/* 	The Thai Chicken Pizza	2371
	The Pepperoni Pizza	2418
	The Hawaiian Pizza	2422
	The Classic Deluxe Pizza	2453
	The Barbecue Chicken Pizza	2432
*/

---------------------------------------------------------------------------------------------------------------------------------------------

-- 6. Join the necessary tables to find the total quantity of each pizza category ordered.

SELECT 
    pt.category, SUM(od.quantity) AS Quantity
FROM
    pizza_types pt
        JOIN
    pizzas p ON pt.pizza_type_id = p.pizza_type_id
        JOIN
    order_details od ON p.pizza_id = od.pizza_id
GROUP BY 1;

/* 
Veggie	11649
Supreme	11987
Classic	14888
Chicken	11050
*/

---------------------------------------------------------------------------------------------------------------------------------------------

-- 7. Determine the distribution of orders by hour of the day.

SELECT 
    HOUR(time) AS hours, COUNT(order_id) AS qtd_ordered
FROM
    orders
GROUP BY 1;


/*
11	1231
12	2520
13	2455
14	1472
15	1468
16	1920
17	2336
18	2399
19	2009
20	1642
21	1198
22	663
23	28
10	8
9	1
*/

---------------------------------------------------------------------------------------------------------------------------------------------

-- 8. Join relevant tables to find the category-wise distribution of pizzas.

SELECT 
    pt.category, COUNT(od.order_id) AS distribution
FROM
    pizzas p
        JOIN
    pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
        JOIN
    order_details od ON p.pizza_id = od.pizza_id
GROUP BY 1;

/*
Classic	14579
Veggie	11449
Supreme	11777
Chicken	10815
*/

---------------------------------------------------------------------------------------------------------------------------------------------

-- 9. Group the orders by date and calculate the average number of pizzas ordered per day.

SELECT 
    AVG(total_order) AS AVG_ORDER_PER_DAY
FROM
    (SELECT 
        date, SUM(od.quantity) AS total_order
    FROM
        orders o
    JOIN order_details od ON o.order_id = od.order_id
    GROUP BY 1) AS sum_order
    
    -- AVG ORDER PER DAY IS 138.47
    
---------------------------------------------------------------------------------------------------------------------------------------------
    
-- 10. Determine the top 3 most ordered pizza types based on revenue.
    
SELECT 
    pt.name, SUM(od.quantity * p.price) AS Revenue
FROM
    pizzas p
        JOIN
    pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
        JOIN
    order_details od ON p.pizza_id = od.pizza_id
GROUP BY 1
ORDER BY Revenue DESC
LIMIT 3;

/*
The Thai Chicken Pizza	43434.25
The Barbecue Chicken Pizza	42768
The California Chicken Pizza	41409.5
*/

---------------------------------------------------------------------------------------------------------------------------------------------

-- 11 . Calculate the percentage contribution of each pizza type to total revenue.

SELECT 
    pt.category, SUM(od.quantity * p.price) AS Revenue
FROM
    pizzas p
        JOIN
    pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
        JOIN
    order_details od ON p.pizza_id = od.pizza_id
GROUP BY 1
ORDER BY Revenue;

/*
Veggie	193690.45000000298
Chicken	195919.5
Supreme	208196.99999999822
Classic	220053.1000000001
*/

---------------------------------------------------------------------------------------------------------------------------------------------

-- 12. Calculate the percentage contribution of each pizza type to total revenue.
SELECT 
    pt.category,
    ROUND((SUM(od.quantity * p.price) /(SELECT 
            SUM(od.quantity * p.price)
        FROM
            pizzas p
                JOIN
            order_details od ON p.pizza_id = od.pizza_id) * 100),2) AS percent_revenue
FROM
    pizzas p
        JOIN
    pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
        JOIN
    order_details od ON p.pizza_id = od.pizza_id
GROUP BY 1;

/*
Classic	26.91
Veggie	23.68
Supreme	25.46
Chicken	23.96
*/

---------------------------------------------------------------------------------------------------------------------------------------------

-- 12. Analyze the cumulative revenue generated over time.
SELECT date, SUM(revenue) OVER (ORDER BY date) as cumulative_revenue
FROM
(SELECT o.date, SUM(od.quantity*p.price) as revenue
FROM pizzas p
JOIN order_details od
ON p.pizza_id = od.pizza_id
JOIN orders o
ON od.order_id = o.order_id
GROUP BY 1) as sales;

---------------------------------------------------------------------------------------------------------------------------------------------

-- 13. Determine the top 3 most ordered pizza types based on revenue for each pizza category.
SELECT category, name, revenue
FROM
(SELECT category, name, revenue, RANK() OVER (PARTITION BY category ORDER BY revenue DESC) as rn
FROM
(SELECT pt.category, pt.name, SUM(od.quantity*p.price) as revenue
FROM pizzas p
JOIN pizza_types pt
ON p.pizza_type_id = pt.pizza_type_id
JOIN order_details od
ON p.pizza_id = od.pizza_id
GROUP BY 1,2) as revenue_table) as rank_table
WHERE rn <= 3;

/*
Chicken	The Thai Chicken Pizza	43434.25
Chicken	The Barbecue Chicken Pizza	42768
Chicken	The California Chicken Pizza	41409.5
Classic	The Classic Deluxe Pizza	38180.5
Classic	The Hawaiian Pizza	32273.25
Classic	The Pepperoni Pizza	30161.75
Supreme	The Spicy Italian Pizza	34831.25
Supreme	The Italian Supreme Pizza	33476.75
Supreme	The Sicilian Pizza	30940.5
Veggie	The Four Cheese Pizza	32265.70000000065
Veggie	The Mexicana Pizza	26780.75
Veggie	The Five Cheese Pizza	26066.5
*/
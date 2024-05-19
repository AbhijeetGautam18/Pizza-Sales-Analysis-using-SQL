# Pizza-Sales-Analysis-using-SQL
Sales analysis of a pizza shop using SQL queries.

## Data Sources
There are four .csv files which are used in this analysis.

### 1. pizzas.csv
There are four attributes (columns) in this table <br>
i. pizza_id --> id of different kinds of pizza, basically three sizes ( s, m , l) of each pizza type <br>
ii. pizza_type_id --> id of pizza types <br>
iii. size --> size of pizza (small, medium, large) <br>
iv. price --> price of pizza

### 2. pizza_types
There are four attributes (columns) in this table <br>
i. pizza_type_id --> id of pizza types <br>
ii. name --> name of pizza <br>
iii. category --> category of each pizza (classic, veggie, supreme, chicken) <br>
iv. ingredients --> ingredients used

### 3 . orders
There are three attributes (columns) in this table <br>
i. order_id --> Distinct id of pizza ordered <br>
ii. date --> date of order <br>
iii. time --> time of order

### 4. order_details
There are four attributes (columns) in this table <br>
i. order_details_id --> Distinct order id of pizza <br>
ii. order_id --> order id of pizza (contains duplicate) <br>
iii. pizza_id --> id of different kinds of pizza, basically three sizes ( s, m , l) of each pizza type <br>
iv. quantity --> quantity ordered <br>
<br>
Difference between order_details_id and order_id is that order_id contains duplicate while order_details_id is unique. This can be understood as a person ordered 4 different pizzas then order_id of all 4 pizzas will be same but order_details_id will be different.

## Questions
These are the problems (based on difficulty level) whose solutions we have to find using SQL queries 
<br>
Basic: <br>
1. Retrieve the total number of orders placed. <br>
2. Calculate the total revenue generated from pizza sales.<br>
3. Identify the highest-priced pizza.<br>
4. Identify the most common pizza size ordered.<br>
5. List the top 5 most ordered pizza types along with their quantities.<br>
<br>
Intermediate:<br>
6. Join the necessary tables to find the total quantity of each pizza category ordered.<br>
7. Determine the distribution of orders by hour of the day.<br>
8. Join relevant tables to find the category-wise distribution of pizzas.<br>
9. Group the orders by date and calculate the average number of pizzas ordered per day.<br>
10. Determine the top 3 most ordered pizza types based on revenue.<br>
<br>
Advanced:<br>
11. Calculate the percentage contribution of each pizza type to total revenue.<br>
12. Analyze the cumulative revenue generated over time.<br>
13. Determine the top 3 most ordered pizza types based on revenue for each pizza category.




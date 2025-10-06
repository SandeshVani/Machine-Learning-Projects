use churn_db;

-- Data Exploration 

select * from customer_data;

-- Count of Genders

select gender, count(gender) as gender_count, 
concat(round(count(gender) * 100.0 / (select count(*) from customer_data), 2), '%') as gender_percentage
from customer_data
group by gender;

-- Count of Contract

select contract, count(contract) as contract_count, 
concat(round(count(contract) * 100.0 / (select count(*) from customer_data), 2), '%') as gender_percentage
from customer_data
group by contract;

-- Customer Status-wise Revenue Contribution Analysis

-- This query shows how much total revenue each customer status group contributes, 
-- along with the count and percentage of total revenue.

select customer_status, Count(Customer_Status) as total_count, 
round(sum(total_revenue), 2) as total_revenue,
concat(round(sum(total_revenue)/ (Select sum(Total_Revenue) from customer_data)*100, 2), '%')  as revenue_percentage
from customer_data
Group by customer_status;

-- State-wise Customer Distribution with Percentage Share"

-- This query displays the number of customers in each state and their percentage share of the total customer base.

select state, count(state) as total_count, 
concat(round(count(state) * 100.0 / (select count(*) from customer_data), 2), '%') as customer_percentage
from customer_data
group by state
order by customer_percentage desc;











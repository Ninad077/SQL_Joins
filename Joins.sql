-- Joins
-- Parent table
drop table product1;
create table product1(
Pid int primary key,
product_name varchar(50) not null,
product_quantity int,
per_unit_price float
);
insert into product1(Pid,product_name,product_quantity,per_unit_price)
values
(1,"Phone",20,10000.20),
(2,"laptop",30,40000.50),
(3,"Charger",15,1000);

-- Child Table
drop table transaction_details;
create table transaction_details(
Trans_id int primary key,
Trans_time timestamp default current_timestamp,
Pid int,
foreign key(Pid) references product1(Pid)
);
insert into transaction_details(Trans_id,Pid)
values
(111,1),
(112,2),
(113,3),
(114,1);

-- Inner join (Matching values from Table 1 and Table 2)
select Trans_id, Trans_time, product_name,per_unit_price
from product1 inner join transaction_details using(Pid);

-- Left join (All values from table 1 and matching values from Table 2)
select Transid, Trans_time, product_name,per_unit_price
from product1 left join transaction_details using(Pid);

-- Right join (All values from Table 2 and matching values from Table 1)
select Transid, Trans_time, product_name,per_unit_price
from product1 right join transaction_details using(Pid);


-- Fetch details of customers who placed the order
select customerNumber,customerName,orderNumber,orderDate
from customers inner join orders using(customerNumber);

select customerNumber,customerName,orderNumber,orderDate
from orders left join customers using(customerNumber);

-- Fetch details of Customers from USA who placed the order
select customerNumber,customerName,orderNumber,orderDate,country
from orders left join customers using(customerNumber)
where country="USA";

-- Fetch cutomers who placed the order and order got cancelled.
select customerNumber,customerName,orderNumber,orderDate,country,status
from orders left join customers using(customerNumber)
where status="Cancelled";

-- Joining more than 2 Tables
-- Name of Customers and Product names for all the orders they have placed 

select customerNumber,customerName,orderNumber,productCode,productName
from customers inner join orders using(customerNumber)
inner join orderdetails using(orderNumber)
inner join products using(productCode);

-- Number of orders placed by each customer
-- Fetch the details of the total payment amount of each customer
select customerNumber,customerName,count(orderNumber),sum(amount)
from orders left join customers using(customerNumber)
left join payments using(customerNumber)
group by customerNumber;

-- Fetch the details of total payment of each customer from USA and Total_amount>=100000

select customerNumber,customerName, sum(amount) as Total_amount
from customers inner join payments using(customerNumber)
where country="USA"
group by customerNumber
having Total_amount>=100000
order by Total_amount desc;

-- Self Join
select e1.employeeNumber, concat(e1.firstName," ", e1.lastName) as employee, concat(e2.firstName," ",e2.LastName) as manager
from employees as e1 join employees as e2
on(e1.reportsTo=e2.employeeNumber);

-- Cross Join
-- Use orders and customers table to do cross join
select orderNumber,orderDate,city,state
from orders cross join customers;

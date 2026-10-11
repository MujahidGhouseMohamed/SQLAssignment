create database ecommerce_db;
use ecommerce_db;
-- 1) customers
create table Customers (customer_id int primary key, first_name varchar(50), last_name varchar(50), email varchar(100), 
city varchar(50), country varchar(50));

-- 2) employees
create table Employees (employee_id int primary key, first_name varchar(50), last_name varchar(50), 
manager_id int, foreign key (manager_id) references Employees(employee_id));

-- 3) shippers
create table Shippers (shipper_id int primary key, shipper_name varchar(100), phone varchar(20));

-- 4) suppliers
create table Suppliers (supplier_id int primary key, supplier_name varchar(100), city varchar(50), country varchar(50));

-- 5) categories
create table Categories (category_id int primary key, category_name varchar(100));

-- 6) products
create table Products (product_id int primary key, product_name varchar(100),
 category_id int, supplier_id int, unit_price decimal(10,2), foreign key (category_id) references Categories(category_id), foreign key (supplier_id) references Suppliers(supplier_id));

-- 7) orders
create table Orders (order_id int primary key, customer_id int, employee_id int, 
shipper_id int, order_date date, status varchar(30), foreign key (customer_id) references Customers(customer_id), 
foreign key (employee_id) references Employees(employee_id), foreign key (shipper_id) references Shippers(shipper_id));

-- 8) order_items
create table Order_Items (order_item_id int primary key, order_id int, product_id int, quantity int, 
unit_price decimal(10,2), foreign key (order_id) references Orders(order_id), foreign key (product_id) references Products(product_id));

-- customers
insert into Customers values
(1,'Arun','Kumar','arun@gmail.com','Chennai','India'),
(2,'Priya','Sharma','priya@gmail.com','Bengaluru','India'),
(3,'Rahul','Verma','rahul@gmail.com','Mumbai','India'),
(4,'Sneha','Ravi','sneha@gmail.com','Puducherry','India'),
(5,'Vikram','Singh','vikram@gmail.com','Delhi','India'),
(6,'Aisha','Khan','aisha@gmail.com','Hyderabad','India'),
(7,'Karthik','Raj','karthik@gmail.com','Coimbatore','India'),
(8,'Meera','Das','meera@gmail.com','Kochi','India');


-- employees
insert into Employees values
(1,'Ramesh','Iyer',NULL),
(2,'Divya','Nair',1),
(3,'Suresh','Babu',1),
(4,'Anitha','Rao',2);


-- shippers
insert into Shippers values
(1,'BlueDart','9876500001'),
(2,'Delhivery','9876500002'),
(3,'DTDC','9876500003');


-- suppliers
insert into Suppliers values
(1,'TechSource','Chennai','India'),
(2,'FashionHub','Mumbai','India'),
(3,'HomeEssentials','Bengaluru','India'),
(4,'GadgetWorld','Delhi','India'),
(5,'TechHub','Kochi','India');


-- categories
insert into Categories values
(1,'Electronics'),
(2,'Clothing'),
(3,'Home & Kitchen'),
(4,'Books'),
(5,'Sports'),
(6,'Toys');


-- products
insert into Products values
(1,'Laptop',1,1,60000),
(2,'Smartphone',1,4,30000),
(3,'Headphones',1,1,2500),
(4,'T-Shirt',2,2,800),
(5,'Jeans',2,2,1800),
(6,'Office Chair',3,3,7500),
(7,'Coffee Maker',3,3,3500),
(8,'SQL Book',4,1,600),
(9,'Cricket Bat',5,2,2200),
(10,'Gaming Monitor',1,4,18000),
(11,'SmartWatch mini',3,3,1200);


-- orders
insert into Orders values
(1,1,2,1,'2026-01-05','Delivered'),
(2,2,3,2,'2026-01-12','Delivered'),
(3,1,2,1,'2026-02-10','Delivered'),
(4,3,4,3,'2026-02-18','Delivered'),
(5,4,3,2,'2026-03-02','Delivered'),
(6,5,2,1,'2026-03-15','Shipped'),
(7,6,4,3,'2026-04-01','Delivered'),
(8,2,3,2,'2026-04-20','Pending'),
(9,7,2,1,'2026-05-05','Delivered');


-- order_items
insert into Order_Items values
(1,1,1,1,60000),
(2,1,3,2,2500),
(3,2,2,1,30000),
(4,2,4,3,800),
(5,3,1,1,58000),
(6,3,8,2,600),
(7,3,7,1,3500),
(8,3,5,1,1800),
(9,4,6,2,7500),
(10,4,3,1,2500),
(11,5,4,2,800),
(12,5,9,1,2200),
(13,6,2,2,29000),
(14,6,10,1,18000),
(15,7,1,1,60000),
(16,7,5,2,1800),
(17,8,8,3,600),
(18,8,3,1,2500),
(19,9,7,1,3500),
(20,9,4,1,800);

-- 1 Display all customers with their orders
select c.customer_id, c.first_name,c.last_name, o.order_date, o.order_id from Customers c join Orders o 
on c.customer_id = o.customer_id;

-- 2  Display order details with customer names
select o.*, c.first_name, c.last_name from Orders o join Customers c on o.customer_id = c.customer_id;

-- 3 Show every product with its category
select p.product_name, c.category_name from Products p join Categories c on p.category_id = c.category_id;

-- 4 Display products with supplier names
select p.product_name, s.supplier_name from Products p join Suppliers s on p.supplier_id = s.supplier_id;

-- 5 Show orders handled by each employee
select concat(e.first_name, e.last_name) as employee_name, o.order_id, o.order_date from Employees e join Orders o 
on e.employee_id = o.employee_id;

-- 6 Display orders with shipper names

SELECT o.order_id, o.order_date, o.order_date, s.shipper_name from Orders o join shippers s on  o.shipper_id=s.shipper_id;

-- 7. Show customers who placed at least one order

Select distinct concat(c.first_name, c.last_name) as customer from customers c join orders o on c.customer_id=o.customer_id;

-- 8 Display products purchased in each order

select o.order_id,o.order_date,p.product_name from Orders o join order_items oi on o.order_id=oi.order_id join products p 
on oi.product_id=p.product_id;

-- 9 Display product name and quantity ordered

select p.product_name, oi.quantity from products p left join order_items oi on p.product_id=oi.order_id;

-- 10 Display employee names and customer names

select concat(c.first_name,' ',c.last_name) as customer_name, concat(e.first_name,' ', e.last_name) as employee_name from customers c 
join orders o on c.customer_id = o.customer_id join employees e on o.employee_id=e.employee_id;

-- 11	Display customer, order, product, quantity and price. 

select concat(c.first_name,' ',c.last_name) as customer_name, o.order_id, p.product_name, oi.quantity, oi.unit_price 
from customers c join orders o on c.customer_id = o.customer_id join order_items oi on o.order_id = oi.order_id join products p 
on oi.product_id = p.product_id;

-- 12 Display supplier name with products sold.
select s.supplier_name, p.product_name from suppliers s join products p on s.supplier_id = p.supplier_id;

-- 13 Display category-wise product count.

select c.category_name, count(p.product_id) as total_products from categories c  join products p on c.category_id = p.category_id
group by c.category_id, c.category_name;

-- 14 Find total orders for each customer.

select concat(c.first_name,' ',c.last_name) as customer_name, count(o.order_id) as total_orders from customers c left join orders o
on c.customer_id = o.customer_id group by c.customer_id, c.first_name, c.last_name;

-- 15 Find total sales by employee.

select concat(e.first_name,' ',e.last_name) as employee_name, sum(oi.quantity * oi.unit_price) as total_sales from employees e 
join orders o on e.employee_id = o.employee_id join order_items oi on o.order_id = oi.order_id group by  e.first_name, e.last_name;


-- 16 Find total revenue by category.

select c.category_name, sum(oi.quantity * oi.unit_price) as total_revenue from categories c join products p 
on c.category_id = p.category_id join order_items oi on p.product_id = oi.product_id group by c.category_id, c.category_name;

-- 17 Display the most expensive product in every category.

select c.category_name, p.product_name, p.unit_price from categories c join products p on c.category_id = p.category_id
where p.unit_price = (select max(p2.unit_price) from products p2 where category_id = p.category_id);


-- 18 Find products never ordered.

select p.product_id, p.product_name from products p left join order_items oi on p.product_id = oi.product_id where oi.product_id is null;

-- 19 Find customers who never placed orders.

select concat(c.first_name,' ',c.last_name) as customer_name from customers c left join orders o on c.customer_id = o.customer_id
where order_id is null;

-- 20 Display suppliers without products.

select s.supplier_id, s.supplier_name from suppliers s left join products p on s.supplier_id = p.supplier_id where p.product_id is null;

-- 21 Find top five customers by spending.

select concat(c.first_name,' ',c.last_name) as customer_name, sum(oi.quantity * oi.unit_price) as total_spending from customers c 
join orders o on c.customer_id = o.customer_id join order_items oi on o.order_id = oi.order_id group by c.customer_id 
order by total_spending desc limit 5;

-- 22 Display monthly sales by employee.

select concat(e.first_name, ' ', e.last_name) AS employee_name, date_format(o.order_date, '%Y-%m') AS sales_month,
sum(oi.quantity * oi.unit_price) AS monthly_sales from employees e join orders o on e.employee_id = o.employee_id join order_items oi 
on o.order_id = oi.order_id group by employee_name, sales_month order by sales_month;

-- 23 Find the best-selling product.

select p.product_name, sum(oi.quantity) as total_quantity_sold from products p join order_items oi on p.product_id = oi.product_id
group by p.product_id, p.product_name order by total_quantity_sold desc limit 1;


-- 24 Display supplier-wise revenue.

select s.supplier_name, coalesce(sum(oi.quantity * oi.unit_price),0) as total_revenue from suppliers s left join products p
on s.supplier_id = p.supplier_id left join order_items oi on p.product_id = oi.product_id group by s.supplier_id, s.supplier_name;

-- 25 Find average order value per customer.

select concat(c.first_name,' ',c.last_name) as customer_name, avg(ot.order_total) as average_order_value from customers c join orders o
on c.customer_id = o.customer_id join ( select order_id, sum(quantity * unit_price) as order_total from order_items group by order_id) ot
on o.order_id = ot.order_id group by c.customer_id, c.first_name, c.last_name;


-- 26 Display orders with more than three products.

select o.order_id, count(distinct oi.product_id) as total_products from orders o join order_items oi on o.order_id = oi.order_id
group by o.order_id having count(distinct oi.product_id) > 3;


-- 27 Find customers ordering from multiple categories.

select concat(c.first_name,' ',c.last_name) as customer_name, count(distinct p.category_id) as total_categories from customers c 
join orders o on c.customer_id = o.customer_id join order_items oi on o.order_id = oi.order_id join products p 
on oi.product_id = p.product_id group by c.customer_id, c.first_name, c.last_name having count(distinct p.category_id) > 1;

-- 28 Display categories with no sales.

select c.category_name from categories c left join products p on c.category_id = p.category_id left join order_items oi 
on p.product_id = oi.product_id where oi.order_item_id is null group by c.category_name;

-- 29 Display the highest-value order.

select o.order_id, sum(oi.quantity * oi.unit_price) as order_total from orders o join order_items oi on o.order_id = oi.order_id
group by o.order_id order by order_total desc limit 1;


-- 30 Generate a complete invoice report using all tables.

select o.order_id, o.order_date, o.status, concat(c.first_name,' ',c.last_name) as customer_name,concat(e.first_name,' ',e.last_name) as 
employee_name, s.shipper_name, p.product_name, cat.category_name, sup.supplier_name, oi.quantity, oi.unit_price,
oi.quantity * oi.unit_price as line_total,
sum(oi.quantity * oi.unit_price) over (partition by o.order_id) as invoice_total
from orders o join customers c on o.customer_id = c.customer_id join employees e on o.employee_id = e.employee_id
join shippers s on o.shipper_id = s.shipper_id join order_items oi on o.order_id = oi.order_id join products p 
on oi.product_id = p.product_id join categories cat on p.category_id = cat.category_id join suppliers sup 
on p.supplier_id = sup.supplier_id order by o.order_id;








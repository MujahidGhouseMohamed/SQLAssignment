-- 1)  Create a database called company and select it. 
CREATE DATABASE company;
USE company;

-- 2)

create table departments(dept_id int primary key, 
dept_name varchar(20) unique, 
location varchar(20));


-- 3)3.  Create the Employees table with all its 
-- constraints (primary key, auto increment, not null, 
-- unique, check, default, foreign key). 

	create table employees(emp_id int 
    auto_increment primary key, name varchar(30) not null, 
    email varchar(60) unique,
    salary float(10,2) check(salary>0), city varchar(20) 
    default 'Chennai', hire_date date, dept_id int,
    foreign key(dept_id) references departments(dept_id));
    
    
   -- 4) 
   alter table employees add phone varchar(15);
    
  -- 5)
   alter table employees drop phone;
    
   -- 6) 'B'  since dept_id autoincrement there
   is change of duplicate value of dept_id=9
   
   -- 7) if we since used condtion unique the value might be
   duplicate
   -- 8) salary cannot be -500 since we have check() condtion
   
   -- 9) name is 'not null' so cannot be NULL
   -- 10) 
   insert into departments values(1,'IT','Chennai');
   insert into departments values(2,'HR','Bangalore');
   insert into departments values(3,'Sales','Mumbai');
   select * from departments;
   
   -- 11)
insert into employees(name,email,salary,city,dept_id,hire_date) values('Arun','arun@co.com',55000,
'Chennai',1,'2022-03-15');
insert into employees(name,email,salary,city,dept_id,hire_date) values('Divya','divya@co.com',
48000,'Madurai',2,'2021-07-01');
insert into employees(name,email,salary,dept_id,hire_date) values('Karthik','karthik@co.com',
62000,1,'2020-01-10');
insert into employees(name,email,salary,city,dept_id,hire_date) values('Meena','meena@co.com',40000,
'Coimbatore',3,'2023-05-20');
insert into employees(name,email,salary,dept_id,hire_date) values('Ravi','ravi@co.com',52000,3,'2022-11-05');


-- 12)  Insert a new employee Sana 
-- (sana@co.com, 45000, dept 2, hired 2024-02-01) without 
-- giving the city. What city is stored? 
-- "Chennai" as  it is default
insert into employees(name,email,salary,dept_id,hire_date) values('saan','sana@co.com',45000,2,'2024-02-01');


-- 13.  Give a 10% raise to all employees in the IT 
-- department (dept_id = 1). 

update employees set salary=salary*1.10 where 
dept_id=1

-- 14 
delete from employees where emp_id=6;

-- D

-- 15)
select * from employees;

-- 16)
select name,salary from employees where salary>50000;

-- 17)
select * from employees where city='Chennai' order by desc;

-- 17)
select * from employees where city='Chennai' order by salary desc;


-- 18)
select dept_id, count(*) as employee_count from employees 
group by dept_id;


-- 19)
select avg(salary) as average_salary, max(salary) as maximum_salary 
from employees;


-- 20)
select employees.name, departments.dept_name from employees 
inner join departments on employees.dept_id=departments.dept_id;


-- 21)
select * from employees where name like 'M%';


-- E

-- 22)
start transaction;
update employees set salary=salary+5000 where name='Arun';
savepoint sp1;
delete from employees where name='Ravi';
rollback to savepoint sp1;
commit;


-- 23)
-- Ravi will still be in the table because we rolled back the deletion.
- Arun's salary increase is saved because we committed the transaction.


-- 24)
set autocommit=0;


-- 25)
-- We cannot rollback a truncate in MySQL because it automatically commits the changes.


-- F

-- 26)
create user 'hr_user'@'localhost' identified by 'HrUser@123';


-- 27)
grant select, update on company.employees 
to 'hr_user'@'localhost';

-- 28)
show grants for 'hr_user'@'localhost';

-- 29)
revoke update on company.employees 
from 'hr_user'@'localhost';

  

-- 30)
drop user 'hr_user'@'localhost';

    

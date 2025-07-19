


1. select MIN(salary) as min_salary from employees 


2. select AVG(price) as avg_price from products
where price > 'avg_price'  




3. select * from departments as d join employees as e on d.id=e.department_id
where department_name= 'sales'



4. select * from customers as c left join orders as o on c.customer_id=o.order_id 
where o.order_id is null





5. select category_id MAX(price) as max_price from products 
group by category_id




6. with avg_salary as (select e.department_id AVG(salary) as total from employees as e join departments as d on  e.id=d.department_id
group by e.deartment_id)
select * from  avg_salary 
where total< 'e.salary'





7. select name from employees 
group by name
having  AVG (salary) as higest_salary < 'salary'







8. select * from grades
select name,  course_id MAX(grade) as max_grade from students as s join grades as g on s.student_id=g.student_id
group by name,  course_id







9. select  id, product_name, price, category_id from  (
 select id, product_name, price, category_id,
 DENSE_RANK() over (partition by category_id order by  price desc) as  price_rank from  products
) as ranked_products
where  price_rank = 3;










10. select e.id, e.name, e.salary, e.department_id from employees e
JOIN ( select  AVG(salary) AS company_avg_salary from employees
) as avg_table on  1 = 1
JOIN ( select  department_id, MAX(salary) as max_salary from employees
 group by department_id
) as dept_max  on e.department_id = dept_max.department_id
where e.salary > avg_table.company_avg_salary
  and e.salary < dept_max.max_salary;

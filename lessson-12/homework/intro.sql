1.select firstName, lastName,  city,state from Person  as p  left join Address as a on p.personId=a.personId;


2.select e1.name as employee from Employee as e1 join Employee as e2 on  e1.managerId=e2.Id where e2.salary < e1.salary ;



3. select email from person group by email having count(*) > 1;



4. delete from person where id not in (select min(id) from person group by email);

5. select * from girls 
 except
 select * from boys;



6. SELECT custid, SUM(unitprice*qty*(1-discount)), MIN(weight) FROM [TSQL2012].[Sales].[Orders] o
join [TSQL2012].[Sales].[OrderDetails] od
on o.orderid = od.orderid
where weight > 50
group by custid;



7.Select isnull(c1.item, '') as [Item Cart 1], isnull(c2.item, '') as [Item Cart 2] from cart1 c1 full join cart2 c2 on c1.item = c2.item
order by c1.item desc;




8.Select name as Customers from customers c left join orders o 
on c.id = o.customerid  where o.id is null;



9.Select s.student_id, s.student_name, sb.subject_name, count(e.student_id) attended_exams from Students s cross join Subjects sb left join Examinations e on s.student_id = e.student_id and sb.subject_name = e.subject_name
group by s.student_id, s.student_name, sb.subject_name
order by s.student_id, student_name;

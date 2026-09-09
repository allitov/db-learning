-- task 1
select count(distinct name)
from prod
where length(name) > 7;

-- task 2
select min(comm), max(comm)
from sal;

-- task 3
select snum as saller_id, min(pnum) as product_id
from ord
group by snum;

-- task 4
select snum as saller_id, count(distinct pnum) as unique_products
from ord
group by snum
having snum between 3001 and 3004;

-- task 5
select pnum as prod_id, sum(amt) as amount
from ord
group by pnum
having sum(amt) >= 15;

-- task 6
select pnum, cnum, count(*)
from ord
group by pnum, cnum;

-- task 7
select ord_date
from ord
group by ord_date
having count(distinct snum) = 2 and count(distinct pnum) > 1
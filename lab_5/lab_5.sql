-- task 1
select s.*, o.*
from sal as s
left join ord as o on s.snum = o.snum;

-- task 2
select o.onum, o.amt, c.name, c.city
from ord as o
join cust as c on o.cnum = c.cnum
where c.city != 'Moscow';

-- task 3
select s.name, min_amt
from sal as s
left join (
    select o.snum, min(o.amt) as min_amt
    from ord as o
    group by o.snum
) as o on o.snum = s.snum and s.comm < 0.15;

-- task 4
select p.pnum, c.cnum
from prod as p
cross join cust as c
where p.city = c.city;

-- task 5
select *
from ord
natural join sal;

-- task 6
select right(c.name, 1) as last_letter
from cust as c
union
select right(c.city, 1) as last_letter
from cust as c;

-- task 7
select s.city
from sal as s
intersect
select c.city
from cust as c
except
select p.city
from prod as p;

-- task 8
select distinct s.name
from sal as s
where s.snum in (
    select o.snum
    from ord as o
    where o.pnum in (
        select o2.pnum
        from ord as o2
        group by o2.pnum
        having count(*) > 5
    )
);

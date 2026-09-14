-- task 1
select s.snum, s.name, s.comm, s.city
from sal as s
where s.comm >= (select avg(s2.comm) from sal as s2);

-- task 2
select o.cnum, sum(o.amt) as total_amt
from ord as o
group by o.cnum
having sum(o.amt) <= (select sum(o2.amt) from ord as o2 where o2.cnum = 2003);

-- task 3
select s.snum, s.name, s.comm, s.city
from sal as s
where s.snum in (
    select o1.snum
    from ord as o1
    where o1.pnum = 1001
      and o1.cnum in (
          select o2.cnum
          from ord as o2
          where o2.pnum = 1005
      )
);

-- task 4
select p.name
from prod as p
where p.pnum not in (
    select o.pnum
    from ord as o
    where o.snum in (
        select s.snum
        from sal as s
        where s.city = 'Москва'
    )
);

-- task 5
select c.cnum, c.name, c.rating, c.city
from cust as c
where c.rating >= any (select c2.rating from cust as c2 where c2.city = 'Москва');

-- task 6
select s.snum, s.name, s.comm, s.city
from sal as s
where s.snum not in (
    select o.snum
    from ord as o
    where o.cnum in (
        select c.cnum
        from cust as c
        where c.city = s.city
    )
);

-- task 7
select s.snum,
       s.name,
       s.comm,
       s.city,
       case
           when s.comm < 0.12 then 'низкая'
           when s.comm <= 0.13 then 'средняя'
           else 'высокая'
       end as comm_type
from sal as s;

-- task 8
select o.snum,
       case
           when count(*) >= 4 then 'активный'
           when count(*) >= 2 then 'умеренный'
           else 'неактивный'
       end as activity
from ord as o
group by o.snum;

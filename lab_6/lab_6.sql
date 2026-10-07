-- task 1
select *
from pg_indexes
where schemaname = 'my_schema';

-- task 2
create index if not exists cust_city_idx on cust (city);

explain select *
from cust
order by city;

-- task 3
insert into cust
values (generate_series(1, 1000), 'test_name', 100, 'test_city');

explain select *
from cust
order by city;

delete
from cust
where name = 'test_name';

-- task 4
create table if not exists full_order_info as
select o.*, p.name as prod_name, p.weight, p.city as prod_city,
       s.name as sal_name, s.comm, s.city as sal_city,
       c.name as cust_name, c.rating, c.city as cust_city
from ord as o
join prod as p using(pnum)
join sal as s using(snum)
join cust as c using(cnum)
where o.amt > (select avg(o2.amt) from ord as o2)
  and p.city != 'Saint Petersburg'
  and (select count(*) from ord as o2 where o2.snum = o.snum) <= 10
  and c.rating >= (select min(c2.rating) from cust as c2 where c2.city = 'Moscow');

select *
from full_order_info;

-- task 5
create view full_order_info_view as
select o.*, p.name as prod_name, p.weight, p.city as prod_city,
       s.name as sal_name, s.comm, s.city as sal_city,
       c.name as cust_name, c.rating, c.city as cust_city
from ord as o
join prod as p on o.pnum = p.pnum
join sal as s on o.snum = s.snum
join cust as c on o.cnum = c.cnum
where o.amt > (select avg(o2.amt) from ord as o2)
  and p.city != 'Saint Petersburg'
  and (select count(*) from ord as o2 where o2.snum = o.snum) <= 10
  and c.rating >= (select min(c2.rating) from cust as c2 where c2.city = 'Moscow');

select *
from full_order_info_view;

-- task 6
create materialized view full_order_info_matview as
select o.*, p.name as prod_name, p.weight, p.city as prod_city,
       s.name as sal_name, s.comm, s.city as sal_city,
       c.name as cust_name, c.rating, c.city as cust_city
from ord as o
join prod as p on o.pnum = p.pnum
join sal as s on o.snum = s.snum
join cust as c on o.cnum = c.cnum
where o.amt > (select avg(o2.amt) from ord as o2)
  and p.city != 'Saint Petersburg'
  and (select count(*) from ord as o2 where o2.snum = o.snum) <= 10
  and c.rating >= (select min(c2.rating) from cust as c2 where c2.city = 'Moscow');

select *
from full_order_info_matview;

-- task 7
with full_order_info as (
    select o.*, p.name as prod_name, p.weight, p.city as prod_city,
           s.name as sal_name, s.comm, s.city as sal_city,
           c.name as cust_name, c.rating, c.city as cust_city
    from ord as o
    join prod as p on o.pnum = p.pnum
    join sal as s on o.snum = s.snum
    join cust as c on o.cnum = c.cnum
    where o.amt > (select avg(o2.amt) from ord as o2)
      and p.city != 'Saint Petersburg'
      and (select count(*) from ord as o2 where o2.snum = o.snum) <= 10
      and c.rating >= (select min(c2.rating) from cust as c2 where c2.city = 'Moscow')
)
select *
from full_order_info;

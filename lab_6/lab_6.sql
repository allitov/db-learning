-- task 1
select *
from pg_indexes
where schemaname = 'my_schema';

-- task 2
create index if not exists cust_city_idx on cust (city);

explain
select *
from cust
order by city;

-- task 3
insert into cust
values (generate_series(1, 1000), 'test_name', 100, 'test_city');

explain
select *
from cust
order by city;

delete
from cust
where name = 'test_name';

-- task 4
create table if not exists full_order_info as
select o.*,
       p.name as prod_name,
       p.weight,
       p.city as prod_city,
       s.name as sal_name,
       s.comm,
       s.city as sal_city,
       c.name as cust_name,
       c.rating,
       c.city as cust_city
from ord as o
         join prod as p using (pnum)
         join sal as s using (snum)
         join cust as c using (cnum)
where o.amt > (select avg(o2.amt) from ord as o2)
  and p.city != 'Saint Petersburg'
  and (select count(*) from ord as o2 where o2.snum = o.snum) <= 10
  and c.rating >= (select min(c2.rating) from cust as c2 where c2.city = 'Moscow');

select *
from full_order_info;

-- task 5
create view full_order_info_view as
select o.*,
       p.name as prod_name,
       p.weight,
       p.city as prod_city,
       s.name as sal_name,
       s.comm,
       s.city as sal_city,
       c.name as cust_name,
       c.rating,
       c.city as cust_city
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
select o.*,
       p.name as prod_name,
       p.weight,
       p.city as prod_city,
       s.name as sal_name,
       s.comm,
       s.city as sal_city,
       c.name as cust_name,
       c.rating,
       c.city as cust_city
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
with full_order_info as (select o.*,
                                p.name as prod_name,
                                p.weight,
                                p.city as prod_city,
                                s.name as sal_name,
                                s.comm,
                                s.city as sal_city,
                                c.name as cust_name,
                                c.rating,
                                c.city as cust_city
                         from ord as o
                                  join prod as p on o.pnum = p.pnum
                                  join sal as s on o.snum = s.snum
                                  join cust as c on o.cnum = c.cnum
                         where o.amt > (select avg(o2.amt) from ord as o2)
                           and p.city != 'Saint Petersburg'
                           and (select count(*) from ord as o2 where o2.snum = o.snum) <= 10
                           and c.rating >= (select min(c2.rating) from cust as c2 where c2.city = 'Moscow'))
select *
from full_order_info;

create table if not exists files
(
    id     int primary key,
    object varchar(255) not null,
    parent varchar(255),
    size   int          not null
);

insert into files
values (1, 'Root', NULL, 0),
(2, 'Documents', 'Root', 0),
(3, 'Media', 'Root', 0),
(4, 'Reports', 'Documents', 0),
(5, 'Photos', 'Documents', 0),
(6, 'Video', 'Media', 0),
(7, 'file1.txt', 'Reports', 100),
(8, 'file2.txt', 'Reports', 100),
(9, 'img1.jpg', 'Photos', 100),
(10, 'movie.mp4', 'Video', 100);

select sum(size)
from files;

-- task 8
with recursive tree as (
    select object as folder,
           object,
           size
    from files
    where size = 0
    union all
    select tree.folder,
           files.object,
           files.size
    from files
    join tree on files.parent = tree.object
)
select folder, sum(size)
from tree
group by folder;

with recursive tree as (
    select object as folder,
           object,
           size
    from files
    where parent is null
    union all
    select tree.folder,
           files.object,
           files.size
    from files
    join tree on files.parent = tree.object
)
select sum(tree.size) as total_files_size
from tree
where tree.folder = 'Root';

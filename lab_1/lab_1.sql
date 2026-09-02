-- task 4
select *
from cust
limit 5;

select *
from ord
limit 5;

select *
from prod
limit 5;

select *
from sal
limit 5;

-- task 5
insert into sal (snum, name, comm, city)
values (3006, 'Astra', 0.16, 'Innopolis'),
       (3007, 'RedSoft', 0.13, 'Moscow')
on conflict do nothing;

-- task 6
delete
from sal
where snum = 3007;

-- task 7
alter table ord
    add column if not exists ord_date date;

comment on column ord.ord_date is 'Дата заказа';

-- task 8
update ord
set ord_date = '2026-09-01';

-- task 9
update ord
set ord_date = '2025-12-31'
where pnum = 1002;

-- task 10.1
select *
from ord
where cnum = 2002;

-- task 10.2
select cnum, city, name, rating
from cust
where rating >= 200;

-- task 10.3
select distinct pnum
from ord
where cnum <= 2005;

-- task 10.4
select *
from cust
where rating < 200
  and city in ('Novosibirsk', 'Saint Petersburg');

-- task 10.5
select *
from ord
where cnum in (2004, 2005, 2006);

select *
from ord
where cnum = 2004
   or cnum = 2005
   or cnum = 2006;

select *
from ord
where cnum between 2004 and 2006;
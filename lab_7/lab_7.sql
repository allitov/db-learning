-- task 1
select snum,
       amt,
       row_number() over sal_amt,
       rank() over sal_amt,
       dense_rank() over sal_amt
from ord
window sal_amt as (partition by snum order by amt desc);

-- task 2
select snum,
       cnum,
       amt,
       row_number() over sal_cust_amt,
       rank() over sal_cust_amt,
       dense_rank() over sal_cust_amt
from ord
window sal_cust_amt as (partition by snum, cnum order by amt desc);

-- task 3
insert into sal
values (3007, 'Eldorado', 0.13, 'Moscow'),
       (3008, 'Ozon', 0.2, 'Novosibirsk'),
       (3009, 'Wildberries', 0.19, 'Novosibirsk'),
       (3010, 'CityCenter', 0.10, 'Novosibirsk'),
       (3011, 'YandexMarket', 0.09, 'Moscow'),
       (3012, 'BiblioGlobus', 0.15, 'Saint Petersburg'),
       (3013, 'Enter', 0.17, 'Yekaterinburg'),
       (3014, 'Technopark', 0.16, 'Innopolis'),
       (3015, 'Regard', 0.14, 'Saint Petersburg'),
       (3016, 'Nix', 0.11, 'Innopolis')
on conflict do nothing;

select *,
       round(comm / avg(comm) over w, 1) as comm_ratio
from sal
window w as (partition by city)
order by city, comm_ratio;

select s.*,
       c.avg_comm,
       round(s.comm / c.avg_comm, 1) as comm_ratio
from sal as s
         join (select city, avg(comm) as avg_comm from sal group by city) as c
              using (city);

-- task 4
select *,
       max(amt) over w as current_max
from ord
window w as (order by ord_date, onum rows between unbounded preceding and current row);

-- task 5
select *,
       max(amt) over w as current_max
from ord
window w as (partition by snum order by snum, ord_date, onum rows between unbounded preceding and current row);

-- task 6
select snum,
       ord_date,
       onum,
       amt                                as curr_amt,
       coalesce(lag(amt) over w - amt, 0) as diff_prev,
       lead(amt) over w - amt             as diff_next
from ord
window w as (partition by snum order by snum, ord_date, onum);

-- task 7
select onum,
       amt,
       count(*) over (
           order by amt
           range between 1 preceding and 1 following
           ) - 1 as cnt_other_orders
from ord;

-- practice
create table if not exists ip (
    id int primary key,
    name varchar(30) not null,
    surname varchar(30) not null,
    mark smallint
);

insert into ip
values (1, 'Alice', 'I', 5),
       (2, 'Bob', 'P', NULL),
       (3, 'Alice', 'S', 3),
       (4, 'Bob', 'K', 4),
       (5, 'Clemens', 'L', 2),
       (6, 'Clemens', 'M', NULL),
       (7, 'Alice', 'N', 5),
       (8, 'Eva', 'O', 4),
       (9, 'Bob', 'T', 3),
       (10, 'Bob', 'U', 3) on conflict do nothing;

SELECT
    id, name, surname, mark,

    count(*) OVER (PARTITION BY mark)
        AS count_mark_all,

    count(*) OVER (PARTITION BY name, mark)
        AS count_mark_by_name,

    count(*) OVER (PARTITION BY mark
        ORDER BY id
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
        AS count_mark_frame_table,

    count(*) OVER (PARTITION BY name, mark
        ORDER BY id
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
        AS count_mark_frame_partition
FROM ip
ORDER BY id;
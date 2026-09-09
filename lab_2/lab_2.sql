-- task 1
select name
from prod
where name ilike 's%s';

-- task 2
select city
from cust
where city like '%r_'
order by city;

-- task 3
select lower(substring(name from 2 for length(name))) as name
from sal
where length(name) > 5
order by name;

-- task 4
select concat(lower(name), ': ', rating, ' scores') as rating
from cust
where position('ev' in name) > 0;

-- task 5
select date('2027-01-01') - current_date as days_until_new_year;

-- task 6
select distinct to_char(ord_date, 'dd') as day,
                to_char(ord_date, 'mm') as month,
                to_char(ord_date, 'yy') as year
from ord;

-- task 7
select name
from sal
where name ~* '^[bcdfghjklmnpqrstvwxyz]{2,}';

-- task 8
select name
from prod
where name ~* '^[^k]+k';
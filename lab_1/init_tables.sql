create table if not exists prod
(
    pnum   int primary key,
    name   varchar(20) not null,
    weight int         not null,
    city   varchar(20) not null
);

comment on table prod is 'Таблица продуктов';
comment on column prod.pnum is 'Номер продукта';
comment on column prod.name is 'Название продукта';
comment on column prod.weight is 'Вес продукта';
comment on column prod.city is 'Город производства';

insert into prod (pnum, name, weight, city)
values (1001, 'Monitor', 2000, 'Obninsk'),
       (1002, 'Keyboard', 500, 'Yekaterinburg'),
       (1003, 'Mouse', 100, 'Novosibirsk'),
       (1004, 'Printer', 1500, 'Saint Petersburg'),
       (1005, 'Hard drive', 300, 'Moscow'),
       (1006, 'Speakers', 700, 'Novosibirsk')
on conflict do nothing;
-----------------------------------------------------------------------------------

create table if not exists cust
(
    cnum   int primary key,
    name   varchar(20) not null,
    rating int         not null,
    city   varchar(20) not null
);

comment on table cust is 'Таблица покупателей';
comment on column cust.cnum is 'Номер покупателя';
comment on column cust.name is 'Имя покупателя';
comment on column cust.rating is 'Рейтинг покупателя';
comment on column cust.city is 'Город покупателя';

insert into cust (cnum, name, rating, city)
values (2001, 'Ivanov', 100, 'Perm'),
       (2002, 'Petrov', 100, 'Moscow'),
       (2003, 'Vasiliev', 200, 'Yekaterinburg'),
       (2004, 'Dmitriev', 200, 'Krasnoyarsk'),
       (2005, 'Skvortcov', 300, 'Moscow'),
       (2006, 'Avdeev', 400, 'Novosibirsk'),
       (2007, 'Smirnov', 100, 'Omsk')
on conflict do nothing;
-----------------------------------------------------------------------------------

create table if not exists sal
(
    snum int primary key,
    name varchar(20)   not null,
    comm numeric(7, 2) not null,
    city varchar(20)   not null
);

comment on table sal is 'Таблица продавцов';
comment on column sal.snum is 'Номер продавца';
comment on column sal.name is 'Название продавца';
comment on column sal.comm is 'Комиссионные продавца';
comment on column sal.city is 'Город продавца';

insert into sal (snum, name, comm, city)
values (3001, 'DNS', 0.11, 'Novosibirsk'),
       (3002, 'Citylink', 0.12, 'Saint Petersburg'),
       (3003, 'MVideo', 0.15, 'Yekaterinburg'),
       (3004, 'Inline', 0.13, 'Vladivostok'),
       (3005, 'Elbrus', 0.11, 'Moscow')
on conflict do nothing;
-----------------------------------------------------------------------------------

create table if not exists ord
(
    onum int primary key,
    pnum int not null,
    cnum int not null,
    snum int not null,
    amt  int not null,
    foreign key (pnum) references prod (pnum),
    foreign key (cnum) references cust (cnum),
    foreign key (snum) references sal (snum)
);

comment on table ord is 'Таблица заказов';
comment on column ord.onum is 'Номер заказа';
comment on column ord.pnum is 'Номер продукта';
comment on column ord.cnum is 'Номер покупателя';
comment on column ord.snum is 'Номер продавца';
comment on column ord.amt is 'Количество продукта';

insert into ord (onum, pnum, cnum, snum, amt)
values (4001, 1001, 2001, 3001, 2),
       (4002, 1001, 2002, 3001, 1),
       (4003, 1001, 2006, 3002, 10),
       (4004, 1001, 2003, 3003, 5),
       (4005, 1001, 2004, 3004, 5),
       (4006, 1002, 2001, 3005, 7),
       (4007, 1002, 2002, 3001, 8),
       (4008, 1003, 2001, 3002, 3),
       (4009, 1003, 2006, 3003, 1),
       (4010, 1003, 2007, 3004, 9),
       (4011, 1003, 2004, 3003, 6),
       (4012, 1004, 2002, 3001, 6),
       (4013, 1004, 2001, 3002, 4),
       (4014, 1004, 2001, 3004, 4),
       (4015, 1004, 2006, 3003, 3),
       (4016, 1004, 2004, 3005, 3),
       (4017, 1004, 2007, 3002, 2),
       (4018, 1005, 2001, 3005, 1),
       (4019, 1006, 2004, 3005, 2),
       (4020, 1006, 2003, 3002, 3)
on conflict do nothing;
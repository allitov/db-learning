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

create table if not exists ord
(
    onum     int primary key,
    pnum     int  not null,
    cnum     int  not null,
    snum     int  not null,
    amt      int  not null,
    ord_date date not null,
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
comment on column ord.ord_date is 'Дата заказа';

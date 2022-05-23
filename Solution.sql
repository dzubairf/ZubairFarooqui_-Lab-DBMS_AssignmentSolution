-- Creating Database
create database e_commerce;


-- Creating Table 
create table if not exists supplier( supp_id int primary key,
supp_name varchar(50) not null, supp_city varchar(50),
supp_phone varchar(10) not null);

create table if not exists customer( cus_id int not null,
cus_name varchar(20) not null, cus_phone varchar(10) not null, cus_city varchar(30) not null, cus_gender char,
primary key (cus_id));
create table if not exists category ( cat_id int not null,
cat_name varchar(20) not null, primary key (cat_id));

create table if not exists product (
pro_id int not null,
pro_name varchar(20) not null default "dummy", pro_desc varchar(60),
cat_id int not null,
primary key (pro_id),
foreign key (cat_id) references category (cat_id) );

create table if not exists supplier_pricing ( pricing_id int not null,
pro_id int not null,
supp_id int not null,
supp_price int default 0, primary key (pricing_id),
foreign key (pro_id) references product (pro_id), foreign key (supp_id) references supplier(supp_id) );

create table if not exists `order` ( ord_id int not null,
ord_amount int not null, ord_date date,
cus_id int not null,
pricing_id int not null,
primary key (ord_id),
foreign key (cus_id) references customer(cus_id),
foreign key (pricing_id) references supplier_pricing(pricing_id) );

create table if not exists rating ( rat_id int not null,
ord_id int not null, rat_ratstars int not null, primary key (rat_id),
foreign key (ord_id) references `order`(ord_id) );


-- Inserting Records
insert into supplier values(1,"rajesh retails","delhi",'1234567890'); 
insert into supplier values(2,"appario ltd.","mumbai",'2589631470'); 
insert into supplier values(3,"knome products","banglore",'9785462315'); 
insert into supplier values(4,"bansal retails","kochi",'8975463285');
insert into supplier values(5,"mittal ltd.","lucknow",'7898456532');

insert into customer values(1,"aakash",'9999999999',"delhi",'m'); 
insert into customer values(2,"aman",'9785463215',"noida",'m'); 
insert into customer values(3,"neha",'9999999999',"mumbai",'f'); 
insert into customer values(4,"megha",'9994562399',"kolkata",'f'); 
insert into customer values(5,"pulkit",'7895999999',"lucknow",'m');
insert into category values( 1,"books"); insert into category values(2,"games"); 
insert into category values(3,"groceries"); insert into category values (4,"electronics"); 
insert into category values(5,"clothes");

insert into product values(1,"gta v","windows 7 and above with i5 processor and 8gb ram",2);
insert into product values(2,"tshirt","size-l with black, blue and white variations",5);
insert into product values(3,"rog laptop","windows 10 with 15inch screen, i7 processor, 1tb ssd",4); 
insert into product values(4,"oats","highly nutritious from nestle",3);
insert into product values(5,"harry potter","best collection of all time by j.k rowling",1);
insert into product values(6,"milk","1l toned milk",3);
insert into product values(7,"boat earphones","1.5meter long dolby atmos",4);
insert into product values(8,"jeans","stretchable denim jeans with various sizes and color",5);
insert into product values(9,"project igi","compatible with windows 7 and above",2);
insert into product values(10,"hoodie","black gucci for 13 yrs and above",5);
insert into product values(11,"rich dad poor dad","written by robert kiyosaki",1);
insert into product values(12,"train your brain","by shireen stephen",1);

insert into supplier_pricing values(1,1,2,1500); 
insert into supplier_pricing values(2,3,5,30000); 
insert into supplier_pricing values(3,5,1,3000); 
insert into supplier_pricing values(4,2,3,2500);
insert into supplier_pricing values(5,4,1,1000); 
insert into supplier_pricing values(6,12,2,780); 
insert into supplier_pricing values(7,12,4,789); 
insert into supplier_pricing values(8,3,1,31000); 
insert into supplier_pricing values(9,1,5,1450); 
insert into supplier_pricing values(10,4,2,999); 
insert into supplier_pricing values(11,7,3,549); 
insert into supplier_pricing values(12,7,4,529); 
insert into supplier_pricing values(13,6,2,105); 
insert into supplier_pricing values(14,6,1,99); 
insert into supplier_pricing values(15,2,5,2999); 
insert into supplier_pricing values(16,5,2,2999);

insert into `order` values (101,1500,"2021-10-06",2,1); 
insert into `order` values(102,1000,"2021-10-12",3,5); 
insert into `order` values(103,30000,"2021-09-16",5,2); 
insert into `order` values(104,1500,"2021-10-05",1,1); 
insert into `order` values(105,3000,"2021-08-16",4,3); 
insert into `order` values(106,1450,"2021-08-18",1,9); 
insert into `order` values(107,789,"2021-09-01",3,7);
insert into `order` values(108,780,"2021-09-07",5,6); 
insert into `order` values(109,3000,"2021-09-10",5,3); 
insert into `order` values(110,2500,"2021-09-10",2,4); 
insert into `order` values(111,1000,"2021-09-15",4,5); 
insert into `order` values(112,789,"2021-09-16",4,7); 
insert into `order` values(113,31000,"2021-09-16",1,8); 
insert into `order` values(114,1000,"2021-09-16",3,5); 
insert into `order` values(115,3000,"2021-09-16",5,3); 
insert into `order` values(116,99,"2021-09-17",2,14);

insert into rating values(1,101,4);
insert into rating values(2,102,3); 
insert into rating values(3,103,1); 
insert into rating values(4,104,2); 
insert into rating values(5,105,4); 
insert into rating values(6,106,3); 
insert into rating values(7,107,4); 
insert into rating values(8,108,4); 
insert into rating values(9,109,3); 
insert into rating values(10,110,5); 
insert into rating values(11,111,3); 
insert into rating values(12,112,4); 
insert into rating values(13,113,2); 
insert into rating values(14,114,1); 
insert into rating values(15,115,1); 
insert into rating values(16,116,0); 


-- Question 3
select cus_gender,count(cus_gender) as no_of_customers from 
  (select c.cus_gender,s.supp_price 
   from `order` as o
   inner join customer as c 
   on o.cus_id = c.cus_id
   inner join supplier_pricing as s 
   on o.pricing_id = s.pricing_id
   where s.supp_price >= 3000) as t
group by cus_gender;

-- Question 4
select p.pro_name, o.* 
from `order` as o, supplier_pricing as s, product as p
where o.cus_id = 2 
and o.pricing_id = s.pricing_id 
and s.pro_id = p.pro_id;

-- Question 5
select * from supplier where supp_id in (select supp_id from supplier_pricing group by supp_id having count(supp_id) > 1) group by supp_id;

-- Question 6
select category.cat_id, category.cat_name, min(t2.min_price) as min_price 
from category inner join
(select product.cat_id, product.pro_name, t1.* from product inner join
(select pro_id, min(supp_price) as min_price from supplier_pricing group by pro_id) as t1 
where t1.pro_id = product.pro_id) as t2 
where t2.cat_id = category.cat_id group by category.cat_id;

-- Question 7
select p.pro_id,p.pro_name 
from `order` as o 
inner join supplier_pricing as s on o.pricing_id = s.pricing_id
inner join product as p on s.pro_id = p.pro_id
where o.ord_date > '2021-10-05'



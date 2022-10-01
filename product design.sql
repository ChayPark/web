-- < table design for shopping mall >
-- number of tables for designing web : 6 + 1
-- member, manager, product, cart, buy, bank, board
-- member table : information of members(users)
-- manager(admin) table : manager ID and Password (product registration, purchase management, membership management)
-- product table : information of product 
-- cart table : information of cart 
-- buy table : information of purchase product 
-- bank table : information of bank(card) 
-- board table : product review and QnA

-- ***************************************
-- 1. member table : information of members(users), consisted of 7 columns
-- ID, passwd(password), name, reg_date(registration day), address, tel(phone number), size(shoe size)
use db01;
show tables;

create table member(
id varchar(50) primary key, 
passwd varchar(16) not null,
name varchar(30) not null,
reg_date date not null,
address varchar(100) not null,
tel varchar(20) not null,
size int not null
);
show tables;
desc member;
select * from member;

insert into member values('aaaa1111', '1234', 'RM', now(), 'Sajik-ro-3-gil', '010-1111-1111', 9);
insert into member values('bbbb2222', '1234', 'Jimin', now(), '104 Dosan-daero', '010-2222-2222', 11);
insert into member values('cccc3333', '1234', 'V', now(), '38 Gadal 1-ro', '010-3333-3333', 7);

-- 2. admin table : 2 columns 
-- adminId(admin ID), adminPasswd(admin Password)

create table admin(
adminId varchar(50) primary key,
adminPasswd varchar(16) not null
);

show tables;
desc admin;
select * from admin;

-- id : admin, passwd : 1234;
insert into admin values('admin', '1234');
select * from admin;

-- 3. product table : information of product, most important table, consisted of 12 columns
-- product(shoes) information
-- product_id(product ID), product_brand(Brand of shoes), product_name(name of product), product_price(price of product, $), 
-- product_count(number of products), product_size(product size), product_date(release date of product),
-- product_image(product image), product_detail1(product detail image1), product_detail2(product detail image2), product_detail3(product detail image3), product_description(product description)

create table test (
product_id bigint primary key auto_increment,
product_brand varchar(50) not null,
product_name varchar(100) not null,
product_price int not null,
product_count int not null,
product_size int not null,
product_date varchar(15) not null,
product_image varchar(30) default 'nothing.jpg',
product_detail1 varchar(100) default 'nothing.jpg',
product_detail2 varchar(100) default 'nothing.jpg',
product_detail3 varchar(100) default 'nothing.jpg',
product_description text not null
);

drop table test;
show tables;
select * from test;

-- 4. bank table : information of bank(card) , consisted of 4 columns 
-- card_no(card number), card_com(card company), member_id(member ID), member_name(name of member)
create table bank (
card_no varchar(19) not null,
card_com varchar(20) not null,
member_id varchar(50) not null,
member_name varchar(30) not null
);

drop table bank;

show tables;
desc bank;
select * from bank;

insert into bank values('9876-4569-3652-4569', 'Industrial Bank of Korea', 'aaaa1111', 'RM');
select * from bank;

-- 5. cart table : information of cart, consisted of 7 columns 
-- cart_id(cart number), buyer(buyer, ID of member table), product_id(product number, product table's product_id),
-- product_name(product name, product table's product_name), product_size(product size, product table's product_size), buy_price(price of product), buy_count(count),
-- product_image(product table's product_image)

create table cart(
cart_id int primary key auto_increment,
buyer varchar(50) not null,
product_id int not null,
product_name varchar(100) not null,
product_size int not null,
buy_price int not null,
buy_count int not null,
product_image varchar(30) default 'nothing.jpg'
);

show tables;
desc cart;
select * from cart;

-- 6. buy table : information of purchase product, consisted of 13 columns  
-- buy_id(order number), buyer(buyer, member table's id), product_id(product number, product table's product_id),
-- product_name(product namee, product table's product_name), item_size(product size, product table's product_size), buy_price(product price), buy_count(count),
-- product_image(product image, product table's product_image), buy_date(date of purchase), account(information of purchase, bank, card),
-- delivery_name(name of package recipient), delivery_tel(recipient's number), delivery_address(recipient address), delivery_state(state of delivery)

create table buy(
buy_id bigint primary key auto_increment,
buyer varchar(50) not null,
product_id int not null,
product_name varchar(100) not null,
product_size int not null, 
buy_price int not null,
buy_count int not null,
product_image varchar(30) default 'nothing.jpg',
buy_date datetime not null,
account varchar(50) not null,
delivery_name varchar(30) not null,
delivery_tel varchar(20) not null,
delivery_address varchar(100) not null,
delivery_state varchar(20) default '상품 준비중'
);

show tables;
desc buy;
select * from buy;

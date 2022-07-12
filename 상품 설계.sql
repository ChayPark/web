-- < 쇼핑몰에 대한 전체 테이블 설계 >
-- 쇼핑몰 개발에 필요한 테이블 수 : 6 + 1개
-- member, manager, product, cart, buy, bank, board
-- member 테이블 : 회원(사용자) 정보에 대한 테이블 
-- manager 테이블 : 관리자 인증 테이블(상품 등록, 구매 관리, 회원 관리)
-- product 테이블 : 상품 정보에 관한 테이블  
-- cart 테이블 : 장바구니 정보에 관한 테이블 
-- buy 테이블 : 구매 상품 정보에 관한 테이블 
-- bank 테이블 : 은행(카드) 정보에 관한 테이블 
-- board 테이블 : 상품리뷰, QnA에 사용할 테이블 

-- ***************************************
-- 1. member 테이블 : 회원(사용자) 정보 테이블, 7개의 컬럼으로 구성
-- id(아이디), passwd(비밀번호), name(이름), reg_date(가입일자), address(주소), tel(전화번호), size(발사이즈)
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

insert into member values('aaaa1111', '1234', '이익준', now(), '서울시 마포구 양화로6길 6', '010-1111-1111', 9);
insert into member values('bbbb2222', '1234', '김준완', now(), '인천시 남동구 정각로 29', '010-2222-2222', 11);
insert into member values('cccc3333', '1234', '채송화', now(), '경기도 구리시 아차산로 439', '010-3333-3333', 7);

-- 2. admin 테이블 : 관리자 인증 테이블, 2개 컬럼 구성 
-- adminId(관리자 아이디), adminPasswd(관리자 비밀번호)

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

-- 3. product 테이블 : 상품 정보 테이블, 가장 중요한 테이블, 12개 컬럼으로 구성 
-- 상품(신발) 정보에 대한 테이블  
-- product_id(상품 아이디), product_brand(신발 브랜드), product_name(상품이름), product_price(상품 가격, $), 
-- product_count(상품 재고 수량), product_size(상품 사이즈), product_date(출시일),
-- product_image(상품 이미지), product_detail1(상품 디테일 이미지1), product_detail2(상품 디테일 이미지2), product_detail3(상품 디테일 이미지3), product_description(상품 설명)

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

-- 4. bank 테이블 : 은행(결제 카드) 정보 테이블, 4개 컬럼으로 구성 
-- card_no(카드번호), card_com(카드회사), member_id(사용자 아이디), member_name(사용자 이름)
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

insert into bank values('9876-4569-3652-4569', '기업은행', 'aaaa1111', '이익준');
select * from bank;

-- 5. cart 테이블 : 장바구니 테이블, 7개 컬럼으로 구성 
-- cart_id(장바구니 번호), buyer(구매자, member 테이블의 id), product_id(상품번호, product 테이블의 product_id),
-- product_name(상품 제목, product 테이블의 product_name), product_size(상품 사이즈, product 테이블의 product_size), buy_price(구매가격), buy_count(구매수량),
-- product_image(product 테이블의 product_image)

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

-- 6. buy 테이블 : 구매 정보 테이블, 13개 컬럼으로 구성 
-- buy_id(구매번호), buyer(구매자, member 테이블의 id), product_id(상품번호, product 테이블의 product_id),
-- product_name(상품이름, product 테이블의 product_name), item_size(상품 사이즈, product 테이블의 product_size), buy_price(구매 가격), buy_count(구매수량),
-- product_image(상품 이미지, product 테이블의 product_image), buy_date(구매일자), account(결제정보, 은행, 카드),
-- delivery_name(수령인 이름), delivery_tel(수령인 전화번호), delivery_address(수령인 주소), delivery_state(배송상태)

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

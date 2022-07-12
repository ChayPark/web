-- 2021/08/13(금)
use db02;
show tables;
select * from product;

create table product (
product_id bigint primary key auto_increment,
product_brand varchar(50) not null,
product_model varchar(50) not null,
product_title varchar(100) not null,
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
-- drop table product;
select * from product;
-- 1. JORDAN
insert into product(product_brand, product_model, product_title, product_price, product_count, product_size,
product_date, product_image, product_detail1, product_detail2, product_detail3, product_description) values(
'JORDAN',
'AIR JORDAN 1',
'FRAGMENT DESIGN X TRAVIS SCOTT X AIR JORDAN 1 RETRO HIGH',
200,
5,
6,
'2021-07-29',
'jordan001.jpg',
'jordan001a.jpg',
'jordan001b.jpg',
'jordan001c.jpg',
'A Jordan Brand collaboration with two major creative partners, the Fragment Design x Travis Scott x Air Jordan 1 Retro High released in July 2021. The shoes upper is built with a white tumbled leather base, contrasted by black on Travis Scotts signature backward Swoosh branding. The black nylon collar includes a hidden pouch, similar to a 2019 collaboration, while the toe box, collar and heel overlay all add Military Blue to the look. The heel also includes fragment designs lightning bolt logo on the right shoe, with Cactus Jack branding on the left, while underfoot, an off-white midsole houses Air in the heel to offer the usual cushioning. More Military Blue on the concentric rubber outsole completes the look.
'
);
select * from product;
insert into product(product_brand, product_model, product_title, product_price, product_count, product_size,
product_date, product_image, product_detail1, product_detail2, product_detail3, product_description) values(
'JORDAN',
'AIR JORDAN 1',
'AIR JORDAN 1 RETRO HIGH OG "DARK MOCHA"',
200,
5,
6,
'2020-10-31',
'jordan002.jpg',
'jordan002a.jpg',
'jordan002b.jpg',
'jordan002c.jpg',
'Featuring a look similar to Travis Scotts 2019 Air Jordan 1 collaboration, the Air Jordan 1 Retro High OG "Dark Mocha" released in October 2020. The shoes upper is built with leather, sporting a white base overlaid by black leather. The heel and collar incorporate Dark Mocha nubuck, while a nylon tongue and perforations on the toe box maintain the classic aesthetic. Air in the heel of the midsole provides cushioning.
'
);
insert into product(product_brand, product_model, product_title, product_price, product_count, product_size,
product_date, product_image, product_detail1, product_detail2, product_detail3, product_description) values(
'JORDAN',
'AIR JORDAN 1',
'FRAGMENT DESIGN X TRAVIS SCOTT X AIR JORDAN 1 RETRO LOW',
150,
2,
12,
'2021-08-13',
'jordan003.jpg',
'default.jpg',
'default.jpg',
'default.jpg',
'The Fragment Design x Travis Scott x Air Jordan 1 Retro Low released as part of a collaboration with the Houston rapper and Japanese imprint. Featuring a colorway that recalls previous fragment design collaborations, the shoes upper is built with a white leather base, overlaid by black and royal blue and complemented by inverted Swoosh branding on the lateral side. The heel patch of the left shoe includes Cactus Jack branding and a smiley face logo, while fragments lightning bolt marks the right shoe. Underfoot, a two-tone rubber cupsole anchors the design.
'
);

insert into product(product_brand, product_model, product_title, product_price, product_count, product_size,
product_date, product_image, product_detail1, product_detail2, product_detail3, product_description) values(
'JORDAN',
'AIR JORDAN 1',
'WMNS AIR JORDAN 1 RETRO HIGH OG "SEAFOAM"',
170,
10,
12,
'2021-08-12',
'jordan004.jpg',
'jordan004a.jpg',
'jordan004b.jpg',
'jordan004c.jpg',
'The sneaker that started it all emerges with a subdued palette on the Wmns Air Jordan 1 Retro High OG "Seafoam." Released in August 2021, the shoes upper is built entirely with leather, with the white base overlaid by Seafoam and complemented by Healing Orange on the laces. Perforations on the toe box are included for breathability, while underfoot, Air in the heel of the rubber cupsole provides cushioning. A concentric pattern on the rubber outsole offers traction.
'
);
-- 2. YEEZY
/* 700 넣을 때 넣기 
insert into product(product_brand, product_model, product_title, product_price, product_count, product_size,
product_date, product_image, product_detail1, product_detail2, product_detail3, product_description) values(
'YEEZY',
'YEEZY BOOST 700',
'YEEZY BOOST 700 "WAVE RUNNER"',
300,
10,
6,
'2017-08-12',
'yeezy001.jpg',
'yeezy001a.jpg',
'yeezy001b.jpg',
'yeezy001c.jpg',
'This first colorway of Yeezy Wave Runner 700 from Kanye West was introduced in November 2017, following an initial public opening in the Yeezy Season 5 fashion show previously that year. The retro-inspired lines of the sneaker worked together with a chunky silhouette reminiscent of a previous age. A mesh base on the quarter panel is completed in gray and a yellow with a teal forefoot.;
'
);

insert into product(product_brand, product_model, product_title, product_price, product_count, product_size,
product_date, product_image, product_detail1, product_detail2, product_detail3, product_description) values(
'YEEZY',
'YEEZY BOOST 700',
'YEEZY BOOST 700 "INERTIA"',
300,
30,
7,
'2019-03-09',
'yeezy002.jpg',
'yeezy002a.jpg',
'yeezy002b.jpg',
'yeezy002c.jpg',
'Featuring a black upper with a white band, SPLY 350 branding, and a translucent black midsole; the Yeezy Boost 350 V2 ‘Oreo’ released on December 17, 2016.
'
);
*/
select * from product;


drop table product;











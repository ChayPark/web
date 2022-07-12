<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.text.*, java.util.*, manager.product.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쇼핑몰 메인 페이지</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.css">
<%-- bxSlider --%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>
<%-- slick carousel --%>
<link rel="stylesheet" type="text/css" href="slick/slick.css"/>
<link rel="stylesheet" type="text/css" href="slick/slick-theme.css"/>
<script type="text/javascript" src="slick/slick.min.js"></script>

<style>
#container { width: 1100px; margin: 0 auto;}
ul { width: 100%; list-style: none;}

/* 분류별 신상품 3건씩 보기(bxSlider) css*/
#new_gallery { margin-left: 0px;}
#new_gallery li { display: inline-block; margin: 15px;}

/* 추천상품(slick carousel)css */
#good_gallery { box-sizing: border-box; height: 200px;}
#good_gallery h3 { margin-left: 10px;}
.slider { width: 95%; height: 300px; margin: 50px auto;}
.slick-slide { margin: 0px 20px;}
.slick-slide img { width: 100%; height: 100%;}
.slick-prev:before, .slick-next:before { color: black;}
.slick-prev, .slick-next { top: 30px;}
.slick-dots { top: 100px;}
.slick-slide { transition: all ease-in-out .3s; opacity: 0.2;}
.slick-active { opacity: 0.3;}
.slick-current { opacity: 1;}
</style>
</head>
<body>
<%-- 쇼핑몰의 메인 페이지 - 3개의 페이지를 include하여 구성하는 페이지 --%>
<%-- 상단 : shopTop.jsp, 하단 : shopBottom.jsp, 중단 : shopAll.jsp --%>
<script>
// bxSlider
$(document).ready(function() {
	$('.bx-slider').bxSlider({
		auto: true,	 	     // 자동 슬라이드 여부
		autoHover: true,     // 이미지에 마우스를 올렸을 때 멈춤 여부
		autoControls: true,  // 재생, 멈춤 버튼 
		speed: 2000, 	     // 전환 속도(시간, 2초)
		pause: 5000, 	     // 전환 대기 시간(이미지 노출 시간, 3초)
		slideWidth: 300,     // 슬라이드 너비
		slideHeight: 300,    // 슬라이드 높이
		slideMargin: 0,      // 슬라이드 사이드 여백(간격)
		maxSlides: 6,        // 최대 슬라이드 노출 개수
		minSlides: 1,        // 최소 슬라이드 노출 개수
		moveSlides: 3, 	     // 슬라이드 이동 개수 
		touchEnabled: false, // 웹화면의 touch 이벤트 제거 -> 클릭 했을 때 해당 페이지로 이동하기 위하여
	});
	
	// slick carousel
	$('.center').slick({
	  dots: true,
	  infinite: true,
	  centerMode: true,
	  centerPadding: '60px',
	  slidesToShow: 5,
	  slidesToScroll: 1,
	  autoplay: true,
	  autoplaySpeed: 2000,
	});
})

</script>

<%
// 신상품 각 분류별로 3개씩 가지고 옴
// jQuery의 플러그인 bxSlider를 사용하여 노출시킴 
ProductDBBean productPro = ProductDBBean.getInstance();
List<ProductDataBean> newProductList = productPro.getProducts();
newProductList.addAll(productPro.getProducts(("NIKE"), 3));
newProductList.addAll(productPro.getProducts(("ADIDAS"), 3));
newProductList.addAll(productPro.getProducts(("JORDAN"), 3));
newProductList.addAll(productPro.getProducts(("YEEZY"), 3));
newProductList.addAll(productPro.getProducts(("COLLAB"), 3));

// 추천상품 - 각 분류별로 최신상품 2건씩 가지고 옴.
List<ProductDataBean> goodProductList = productPro.getProducts();
goodProductList.addAll(productPro.getProducts(("NIKE"), 2));
goodProductList.addAll(productPro.getProducts(("ADIDAS"), 2));
goodProductList.addAll(productPro.getProducts(("JORDAN"), 2));
goodProductList.addAll(productPro.getProducts(("YEEZY"), 2));
goodProductList.addAll(productPro.getProducts(("COLLAB"), 2));

%>
<div id="container">
	<ul>
		<li>
			<header> <!-- 상단 -->
				<jsp:include page="../common/shopTop.jsp"/>
			</header>
		</li>
		<li>
			<main> <!-- 본문 -->
			<%-- 2. 신상품 각 분류별 3건 : jQuery plug-in : bxSlider 사용 --%>
			<article id="new_gallery"> <!-- 본문 내용1 -->
				<h3>최신 상품</h3>
				<div class="bx-slider">
				<%
				for(ProductDataBean product : newProductList) {
					out.print("<li>");
					out.print("<a href='shopContent.jsp?product_id=" + product.getProduct_id() + "'>");
					out.print("<img src=" + "/images_shoes21/" + product.getProduct_image() +  " width=250 height=200></a>");
					out.print("</li>");
				}
				%>
				</div>
			</article>
			<hr>
			<%-- 3. 베스트 셀러 10건 : jQuery plug-in slider 사용 : 보류(나중에 생각)--%>
			<%-- 판매를 기준으로 product_count가 많이 팔린 상품 --%>
			<%-- 4. 각 분류별 추천상품 1건 : jQuery plug-in slick carousel 사용 --%>
			<%-- 각 분류별로 1건씩 가져와서 노출하기 -> group by --%>
			<article id="good_gallery"> <!-- 본문 내용2 -->
				<h3>추천 상품</h3>
				<div class="center slider">
				<%
				for(ProductDataBean product : goodProductList) {
					out.print("<li>");
					out.print("<a href='shopContent.jsp?product_id=" + product.getProduct_id() + "'>");
					out.print("<img src=" + "/images_shoes21/" + product.getProduct_image() +  " width=350 height=200></a>");
					out.print("</li>");
				}
				%>
				</div>
			</article>
			<hr>
			<%-- 5. 할인상품 10건 : jQuery plug-in slider 사용 --%>
			<%-- select * from product order by discount_rate desc --%>
			<article> <!-- 본문 내용3 -->
			<jsp:include page="shopAll.jsp"/>
			</article>
			</main>
		</li>
		<li>
			<footer> <!-- 하단 -->
			<jsp:include page="../common/shopBottom.jsp"/>
			</footer>
		</li>
	</ul>

</div>
</body>
</html>
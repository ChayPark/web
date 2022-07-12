<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="manager.product.*, mall.member.*, java.text.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 상세보기 페이지</title>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
<style>
#container { width: 1100px; margin: 0 auto;}
ul { width: 100%; list-style: none;}
#m1 { width: 60%; float: left; display: inline-block; margin-top: -20px;}
#m2 { width: 39%; float: right; display: inline-block; margin-left: 1%;}
#m3 { width: 100%; clear: both;}

#m1 .s_image { text-align: center;}
#m1 .big { width: 95%;}
#m1 .small { width: 20%; margin: 10px 15px 15px 0;}

#m2 #c1 { width: 100%; float: left;}

#m2 .btns { text-align: center; margin-left: 5px;}
#m2 #btn_cart, #m2 #btn_buy { width: 180px; height: 45px; margin: 10px; color: white; border: none; 
cursor: pointer; }
#m2 #btn_cart { background: #196ab2;}
#m2 #btn_cart:hover { background: white; color: #196ab2; border: 1px solid #196ab2; font-weight: bold;}
#m2 #btn_buy { background: #199cb2;}
#m2 #btn_buy:hover { background: white; color: #199cb2; border: 1px solid #199cb2; font-weight: bold;}
#m2 .acc li { margin: 5px 0 5px 15px; font-size: 0.9em;}

#m3 { width: 98%; padding: 10px; text-align: justify; line-height: 30px; padding: 50px 0;}

#c1 .s20 { font-size: 1.5em; font-weight: bold; margin-bottom: 20px;}
#c1 .s21 { font-size: 1.2em; font-weight: bold; display: inline-block; margin-bottom: 10px;}
#c1 .s22, #c1 .s23 { font-size: 0.9em; margin-bottom: 10px;}
#c1 div a { text-decoration: none; color: black;}
#c1 div { margin: 20px 0;}
#c1 .s1 { margin-right: 50px; display: inline-block; width: 80px;}
#c1 .s3 { font-size: 1.5em; font-weight: bold; color: red;}
#c1 .s4 { color: red;}
#c1 .s5 { color: #1e9faa; margin-left: 20px; font-size: 0.9em; font-weight: bold;}

#c2 div { margin: 20px 0;}
#c2 ul { list-style: none; margin: 0; padding: 0;}
#c2 ul li { font-size: 0.9em; margin: 5px 0;}
#c2 .p_number { width: 50px; height: 25px; margin: -6px 15px 0 10px; text-align: center;}
#c2 .p_plus, #c2 .p_minus { cursor: pointer;}
#c2 .p_plus:hover, #c2 .p_minus:hover { color: red;}
#c2 .p_count1 { color: red; font-weight: bold;}
#c2 .p_count2 { color: blue; font-weight: bold;}
#c2 .p_check { font-size: 0.9em; font-weight: bold;}

/* number 속성에서 화살표 버튼 없애는 방법 */
input[type="number"]::-webkit-outer-spin-button, input[type="number"]::-webkit-inner-spin-button { -webkit-appearance: none; margin: 0;}
</style>

<script>
window.onload = function() {
	var big = document.querySelector(".big");
	var smallPics = document.querySelectorAll(".small");
		
	for(var i=0; i<smallPics.length; i++) {
		smallPics[i].onclick = function(event) {
			big.src = this.src;
		}
	}
	// 구매 수량 더하기, 빼기, 확인
	var p_plus = document.querySelector(".p_plus");    // 플러스 버튼 
	var p_minus = document.querySelector(".p_minus");  // 마이너스 버튼
	var p_number = document.querySelector(".p_number");// 구매수량
	var p_check = document.querySelector(".p_check");  // 구매확인
	var p_count = document.querySelector(".p_count");  // 상품재고수량
	// 플러스 버튼 - 상품 재고 수량 파악 -> 재고 수량까지만 주문 가능
	p_plus.addEventListener("click", function(){
		p_check.innerText = "구매확인";
		p_check.style.color = "black";
		p_number.value = parseInt(p_number.value) + 1;
		if(parseInt(p_number.value) > parseInt(p_count.value)) {
			p_number.value = p_count.value;
			p_check.innerText = "재고부족(주문가능 수량: " + p_count.value + ")"
			p_check.style.color = "red";
		}
	})
	// 마이너스 버튼 - 1권 이상만 주문 가능
	p_minus.addEventListener("click", function() {
		p_check.innerText = "구매확인";
		p_check.style.color = "black";
		p_number.value = parseInt(p_number.value) - 1;
		if(parseInt(p_number.value) < 1) {
			p_number.value = 1;
			p_check.innerText = "1개 이상만 주문 가능";
			p_check.style.color = "red";
		}
	})
	
	var form = document.productContentForm;
	// 카트에 넣기 처리 -> insertCart.jsp로 이동
	var btn_cart = document.querySelector("#btn_cart");
	btn_cart.addEventListener("click", function() {
		// 품절일 때 체크
		if(parseInt(p_count.value) == 0) {
			alert('선택한 상품은 품절입니다.');
			return;
		}
		form.submit();
	})
	
	// 바로 구매 처리 -> buyForm.jsp로 이동 
	var btn_buy = document.querySelector("#btn_buy");
	btn_buy.addEventListener("click", function() {
		// 품절일 때 체크
		if(parseInt(p_count.value) == 0) {
			alert('선택한 상품은 품절입니다.');
			return;
		}
		form.action = "../buy/buyForm.jsp";
		form.submit();
	})
	
}
</script>
</head>
<body>
<%-- 상품의 상세보기 페이지 --%>
<%
//회원 세션 확인 - 로그인 했을 때 -> 회원 DB 연동하여 주소 획득
String memberId = (String)session.getAttribute("memberId");
String address = "";
MemberDataBean member = null;
if(memberId != null) {
	MemberDBBean memberPro = MemberDBBean.getInstance();
	member = memberPro.getMember(memberId);
	address = member.getAddress();
}
//상품 아이디 받음
int product_id = Integer.parseInt(request.getParameter("product_id"));

// DB 연동, 쿼리 실행
ProductDBBean productPro = ProductDBBean.getInstance();
ProductDataBean product = productPro.getProduct(product_id);

// 판매가 계산
DecimalFormat df = new DecimalFormat("#,###,###,###");
int price = product.getProduct_price();     

//상품 재고 수량 받음 -> 판매중, 품절 여부 결정
int product_count = product.getProduct_count();

String product_image = product.getProduct_image();
String product_detail1 = product.getProduct_detail1();
String product_detail2 = product.getProduct_detail2();
String product_detail3 = product.getProduct_detail3();
String product_title = product.getProduct_title();
String product_brand = product.getProduct_brand();
String product_model = product.getProduct_model();
int product_size = product.getProduct_size();
%>

<div id="container">
   <ul>
      <li><header><jsp:include page="../common/shopTop.jsp"></jsp:include></header></li>
      <li>
         <div id="m1"> <!-- 구역1(위, 왼쪽) : 상품 이미지, 썸네일 이미지 -->
            <img src="/images_shoes21/<%=product_image%>" class="big">
            <div class="s_images">
               <img src="/images_shoes21/<%=product_image%>" class="small">
               <img src="/images_shoes21/<%=product_detail1%>" class="small">
               <img src="/images_shoes21/<%=product_detail2%>" class="small">
               <img src="/images_shoes21/<%=product_detail3%>" class="small">
            </div>
         </div>
         
         <div id="m2"> <!-- 구역2(위, 오른쪽) : 상품 기본정보, 버튼 -->
            <div id="c1">
               <div class="s20"><a href="#"><%=product_title %></a></div><hr>
               <div class="s21"><a href="#"><%=product_brand %></a> | <a href="#"><%=product_model%></a></div>
               <div class="s22">사이즈 :
	               <select name="product_size">
	               		<option selected>선택하시오.</option>
	               		<option value="6" <%if(product_size == 6) {%> selected <%} %>>6</option>
	               		<option value="7" <%if(product_size == 7) {%> selected <%} %>>7</option>
	               		<option value="8" <%if(product_size == 8) {%> selected <%} %>>8</option>
	               		<option value="9" <%if(product_size == 9) {%> selected <%} %>>9</option>
	               		<option value="10"<%if(product_size == 10) {%> selected <%} %>>10</option>
	               		<option value="11"<%if(product_size == 11) {%> selected <%} %>>11</option>
	               		<option value="12"<%if(product_size == 12) {%> selected <%} %>>12</option>
	               </select>
               </div>
               <div class="s23"><a href="#">상품리뷰 (10건)</a></div>
               <div><span class="s1">판매가 </span><%=df.format(price) %>$</div>
               <div>배송안내 
               		<%if(member != null) { %>
               			<span><%=address %></span>
               		<%} %>
               </div>
            </div>
            </div>
            <div id="c2">
				<!-- 상품 상세보기 폼 : product_id, price, buy_count(p_number,구매수량), product_size(사이즈) -->
				<!-- 3가지 정보를 가지고, cartInsert.jsp 또는 buyForm.jsp페이지로 이동 -->
				<form method="post" action="../cart/cartInsert.jsp" name="productContentForm">
					<input type="hidden" name="product_id" value="<%=product_id %>">
					<input type="hidden" name="product_title" value="<%=product_title %>">
					<input type="hidden" name="product_image" value="<%=product_image %>">
					<input type="hidden" name="price" value="<%=price %>">
					<input type="hidden" name="product_size" value="<%=product_size %>">
					<input type="hidden" value="<%=product_count %>" class="p_count"><hr>
					<%if(product_count == 0) {%>
						<div class="p_count1">품절</div>
					<%} else {%>
						<div class="p_count2">판매중</div>
					<%} %>
					<div>구매수량&ensp;
					<i class="fas fa-minus-circle p_minus"></i>
					<i class="fas fa-plus-circle p_plus">
					<input type="number" name="p_number" class="p_number" value="1" min="1" max="100" maxlength="2"></i>
					</div>
					<div class="p_check">구매확인</div>
					<div class="btns">
						<input type="button" value="카트에 넣기" id="btn_cart">
						<input type="button" value="바로 구매" id="btn_buy">
					</div>
				</form>
			</div>			
			<div id="m3"> <!-- 구역3(아래쪽, 전체) : 상품 상세내용 -->
				<hr><br>
				<div><%=product.getProduct_description() %></div>
			</div>
		</li>
		<!-- 각 상품에 대한 리뷰 -->
		<li></li>
		<li><footer><jsp:include page="../common/shopBottom.jsp"></jsp:include></footer></li>
	</ul>
</div>

</body>
</html>
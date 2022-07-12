<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="//netdna.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css">

<style>
@import url('https://fonts.googleapis.com/css2?family=Luckiest+Guy&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Dancing+Script:wght@600&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Bebas+Neue&display=swap');
#top { width: 100%; margin: 30px auto;}
#top, .t_box { margin: 1%;}
#top #t1 { width: 68%; display: inline-block; float: left; text-align: center;}
#top #t2 { width: 28%; display: inline-block; float: right; text-align: right; margin-top: 35px;}
#top #t3 { width: 68%; display: inline-block; float: left;}
#top #t4 { width: 28%; display: inline-block; float: right; text-align: right; font-size: 0.9em; margin-top: 20px;}
#top #t5 { clear: both;}
#t1 a, #t2 a, #t3 a, #t4 a { text-decoration: none; color: black;}
#t1 #m_title { font-size: 4em; font-family: 'Luckiest Guy', cursive;}
#t1 #s_title { font-size: 2em; font-family: 'Dancing Script', cursive; margin-right: 30px;}
#t2 img { margin-left: 35px; margin-top: -10px;}
#t4 b { color: #495057;}
#log { margin-top: -10%;}
/* 상단 아이콘 툴팁 */
[data-tooltip-text]:hover { position: relative;}
[data-tooltip-text]:hover:after {
	content: attr(data-tooltip-text); width: 70px; height:22px; text-align: center; line-height: 22px;
	border-radius: 11%;
	position: absolute; top: 25px; left: 20px;
	background-color: rgba(0,0,0,0.5); color: #ffffff; font-size: 12px;
	z-index: 100;
}
/* 구역3 : 상단 메뉴 구성 */
nav ul { padding: 5px; text-align: center; margin-top: -60px; margin-left: -40px;}
nav ul li { display: inline-block; width: 60px; padding: 5px 10px; margin: 0 10px; 
border-top: 1px solid #868e96; border-bottom: 5px solid white;}
nav ul li:hover { border-bottom: 5px solid red;}
.m_menu > a { font-family: 'Bebas Neue', cursive;}
.s_menu > a { font-family: 'Bebas Neue', cursive; font-size: 1.5em;}
.m1 { color: purple;}
.m7 { color: brown;}
/* .s_menu a { display: block;} 서브메뉴를 밑으로 내리는 방법, 사용하지 않으면 옆으로 나열되는 방법 */
.s_menu { display: none; position: absolute; padding: 10px 0; margin-top: 10px; z-index: 100; }
.s_menu a { diplay: inline-block; padding: 10px 0; margin: 10px 10px 5px 0;}
.s_menu a:hover { color: red; text-shadow: 2px 2px rgba(255,255,0,0.7);}
.m_menu:hover .s_menu { display: block;}


</style>

<script>
// 마우스를 올렸을 때 컬러 이미지로 변환
function changeIconOn(obj, i) {
	if(i == 1) obj.src = "../../icons/users_on.png";
	else if(i == 2) obj.src = "../../icons/buy_on.png";
	else if(i == 3) obj.src = "../../icons/cart_on.png";
	else if(i == 4) obj.src = "../../icons/show_on.png";
}

function changeIconOff(obj, i) {
	if(i == 1) obj.src = "../../icons/users_off.png";
	else if(i == 2) obj.src = "../../icons/buy_off.png";
	else if(i == 3) obj.src = "../../icons/cart_off.png";
	else if(i == 4) obj.src = "../../icons/show_off.png";
}

/*중분류*/
function categoryChange(e) {
	var NIKE=["DUNK", "AIR MAX", "AIR FORCE", "VAPOR MAX"];
	var ADIDAS=["ULTRA BOOST", "NMD", "PHARRELL"];
	var JORDAN=["AIR JORDAN 1", "AIR JORDAN 2", "AIR JORDAN 3", "AIR JORDAN 4", "AIR JORDAN 5", "AIR JORDAN 6", "AIR JORDAN 7", "AIR JORDAN 8", "AIR JORDAN 9", "AIR JORDAN 10", "AIR JORDAN 11", "AIR JORDAN 12", "AIR JORDAN 13", "AIR JORDAN 14"];
	var YEEZY=["YEEZY BOOST 350", "YEEZY BOOST 380", "YEEZY BOOST 500", "YEEZY BOOST 700", "YEEZY BOOST 750"];
	var COLLAB=["CANVAS", "OFF-WHITE", "VANS"];
	var target = document.getElementById("model");
		
	if(e.value == "NIKE") var d = NIKE;
	else if(e.value == "ADIDAS") var d = ADIDAS;
	else if(e.value == "JORDAN") var d = JORDAN;
	else if(e.value == "YEEZY") var d = YEEZY;
	else if(e.value == "COLLAB") var d = COLLAB;
		
	target.options.length = 0;
		
	for (x in d) {
		var opt = document.createElement("option");
		opt.value = d[x];
		opt.innerHTML = d[x];
		target.appendChild(opt);
	}	

}
</script>
<%-- 모든 쇼핑몰 페이지의 상단에 include 되어 사용하는 페이지 --%>
<%-- 타이틀, 메뉴구성, 로그인, 로그아웃, 회원가입 , 구매확인, 회원정보 확인 등의 내용으로 구성되는 페이지--%>
<%-- 쇼핑몰의 모든 페이지에서 사용하게 되는 아주 중요한 페이지 --%>
<%
//로그인이 되었을 때(memberId 이름으로 세션이 등록 되었을 때)
String memberId = (String)session.getAttribute("memberId");
%>
<div id="top">
	<div id="t1" class="t_box"> <!-- 구역1 : 타이틀, 검색창(보류) -->
		<div id="m_title"><a href="../shop/shopMain.jsp">CHAYISH</a><img src="../../icons/cherry.png" width="45" height="45" class="cherry_icon"></div>
		<div id="s_title">Bring power to your steps.</div>
	</div>
	<div id="t2" class="t_box"> <!-- 구역2 : 회원정보, 구매목록, 장바구니, 최근 본 상품(보류) - 아이콘 표시 -->
		<div id="t_images">
			<a href="../member/memberInfoForm.jsp" data-tooltip-text="회원정보"><img src="../../icons/users_off.png" width="35" height="35" class="user_icon"  
			onmouseover="changeIconOn(this, 1)" onmouseout="changeIconOff(this, 1)"></a>
			<a href="" data-tooltip-text="구매정보"><img src="../../icons/buy_off.png" width="35" height="35" class="buy_icon"    
			onmouseover="changeIconOn(this, 2)" onmouseout="changeIconOff(this, 2)"></a>
			<a href="../cart/cartList.jsp" data-tooltip-text="장바구니"><img src="../../icons/cart_off.png" width="35" height="35" class="cart_icon"   
			onmouseover="changeIconOn(this, 3)" onmouseout="changeIconOff(this, 3)"></a>
			<a href="" data-tooltip-text="최근 본 상품"><img src="../../icons/show_off.png" width="35" height="35" class="show_icon"   
			onmouseover="changeIconOn(this, 4)" onmouseout="changeIconOff(this, 4)"></a>
		</div>
	</div>
	<!-- 전체상품 | 베스트 | 신상품 | 추천상품 | 사이즈 | 매장 | 브랜드 소개 -->
	<!-- NIKE : 나이키, ADIDAS : 아디다스, JORDAN : 조던, YEEZY : 이지, COLLAB : 콜라보, all : 전체 
	-->
	<div id="t3" class="t_box"> <!-- 구역3 : 메뉴 구성 -->
		<nav>
			<ul>
				<li class="m_menu">
					<a href="../shop/shopMain.jsp?product_brand=all" class="m1">ALL</a>
				</li>
				<li class="m_menu">
					<a href="../shop/shopMain.jsp?product_brand=NIKE" class="m2">NIKE</a>
				</li>
				<li class="m_menu" >
					<a href="../shop/shopMain.jsp?product_brand=ADIDAS" class="m3">ADIDAS</a>
				</li>
				<li class="m_menu">
					<a href="../shop/shopMain.jsp?product_brand=JORDAN" class="m4">JORDAN</a>
				</li>
				<li class="m_menu">
					<a href="../shop/shopMain.jsp?product_brand=YEEZY" class="m5">YEEZY</a>
				</li>
				<li class="m_menu">
					<a href="../shop/shopMain.jsp?product_brand=COLLAB" class="m6">COLLAB</a>
				</li>
				<li class="m_menu">
					<a href="#" class="m7">SIZE</a>
				</li>
			</ul>
		</nav>
	</div>
	<div id="t4" class="t_box"> <!-- 구역4 : 로그인, 회원가입, 고객센터(QnA로 연결) -->
		<div id="log">
			<%if(memberId == null) {%> <%-- 로그인하지 않았을 때(memberId 세션이 없을 때) --%>
			<a href="../member/memberLoginForm.jsp">로그인</a>
			<%} else {%>                <%-- 로그인하였을 때(memberId 세션이 있을 때) --%>
			<a href=""><b><%=memberId %></b>님</a> | 
			<a href="../member/memberLogout.jsp">로그아웃</a>
			<%} %>
			 | <a href="../member/memberJoinForm.jsp">회원가입</a>
			 | <a href="">고객센터</a>
		</div>
	</div>
	<div id="t5"></div>
</div>
<hr>

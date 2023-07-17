<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="//netdna.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css">
<style>
@import url('https://fonts.googleapis.com/css2?family=Monoton&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Nanum+Pen+Script&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Nanum+Pen+Script&display=swap');
#top { width: 1100px; margin: 30px auto;}
#top .t_box { margin: 1%;}
#top #t1 { width: 68%; display: inline-block; float: left; text-align: center;}
#top #t2 { width: 28%; display: inline-block; float: right; text-align: right; margin-top: 35px;}
#top #t3 { width: 68%; display: inline-block; float: left;}
#top #t4 { width: 28%; display: inline-block; float: right; text-align: right; font-size: 0.9em; margin-top: 20px;}
#top #t5 { clear: both;}
#t1 a, #t2 a, #t3 a, #t4 a { text-decoration: none; color: black;}
#t1 #m_title { font-size: 3em; font-family: 'Monoton', cursive;}
#t1 #s_title { font-size: 1.5em; font-family: 'Nanum Pen Script', cursive;}
#t1 #s_search { margin: 10px 0;}
#t2 img { margin-left: 35px;}
#t4 b { color: #495057;}
/* 상단 아이콘 툴팁 */
[data-tooltip-text]:hover { position: relative;}
[data-tooltip-text]:hover:after {
	content: attr(data-tooltip-text); width: 65px; height: 22px; text-align: center; line-height: 22px;
	border-radius: 5px;
	position: absolute; top: 25px; left: 23px;
	background-color: rgba(0,0,0,0.7); color: #ffffff; font-size: 12px;
	z-index: 100; 
}
/* 구역3 : 상단 메뉴 구성 */
nav ul { padding: 5px; text-align: center; }
nav ul li { display: inline-block; width: 60px; padding: 5px 10px; margin: 0 10px; 
border-top: 1px solid #868e96; border-bottom: 5px solid white;}
nav ul li:hover { border-bottom: 5px solid red;}
.m_menu > a { font-family: 'Noto Sans KR', sans-serif;}
.s_menu > a { font-family: 'Nanum Pen Script', cursive; font-size: 1.5em;}
.m1 { color: purple;}
.m6, .m7 { color: brown;}
/* .s_menu a { display: block;} 서브메뉴를 밑으로 내리는 방법, 사용하지 않으면 옆으로 나열되는 방법 */
.s_menu { display: none; position: absolute; padding: 10px 0; margin-top: 10px;}
.s_menu a { diplay: inline-block; padding: 10px 0; margin: 10px 10px 5px 0;}
.s_menu a:hover { color: red; text-shadow: 2px 2px rgba(255,255,0,0.7);}
.m_menu:hover .s_menu { display: block;}
/* 구역1 : 검색창 CSS */
fieldset { position: relative; display: inline-block; padding: 0 0 0 40px; background: #fff;
  border: none; border-radius: 5px; }
input, button { position: relative; width: 200px; height: 30px; padding: 0; display: inline-block; float: left;}
input { color: #666; z-index: 2; border: 1px solid #868e96; padding-left: 5px;}
input:focus { outline: 0 none;}
input:focus + button {
  -webkit-transform: translate(0, 0);
      -ms-transform: translate(0, 0);
          transform: translate(0, 0);
  -webkit-transition-duration: 0.3s;
          transition-duration: 0.3s;
}
input:focus + button .fa {
  -webkit-transform: translate(0px, 0);
      -ms-transform: translate(0px, 0);
          transform: translate(0px, 0);
  -webkit-transition-duration: 0.3s;
          transition-duration: 0.3s;
  color: #fff;
}
button { z-index: 1; width: 50px; border: 1px solid #868e96; background: #868e96;
  cursor: pointer; border-radius: 0 5px 5px 0;  
  -webkit-transform: translate(-50px, 0);
      -ms-transform: translate(-50px, 0);
          transform: translate(-50px, 0);
  -webkit-transition-duration: 0.3s;
          transition-duration: 0.3s;
}
.fa-search { font-size: 1.4rem;color: #868e96; z-index: 3; top: 25%;
  -webkit-transform: translate(-190px, 0);
      -ms-transform: translate(-190px, 0);
          transform: translate(-190px, 0);
  -webkit-transition-duration: 0.3s;
          transition-duration: 0.3s;
  -webkit-transition: all 0.1s ease-in-out;
          transition: all 0.1s ease-in-out;
}
</style>

<script>
// 마우스를 올렸을때 컬러 이미지로 변환
function changeIconOn(obj, i) {
	if(i == 1) obj.src = "../../icons/user_on.png";
	else if(i == 2) obj.src = "../../icons/buy_on.png";
	else if(i == 3) obj.src = "../../icons/cart_on.png";
	else if(i == 4) obj.src = "../../icons/show_on.png";
}
function changeIconOff(obj, i) {
	if(i == 1) obj.src = "../../icons/user_off.png";
	else if(i == 2) obj.src = "../../icons/buy_off.png";
	else if(i == 3) obj.src = "../../icons/cart_off.png";
	else if(i == 4) obj.src = "../../icons/show_off.png";
}
</script>

<%-- 모든 쇼핑몰 페이지의 상단에 include 되어 사용하는 페이지 --%>
<%-- 타이틀, 메뉴, 로그인, 회원가입, 검색, 장바구니 확인, 구매 확인, 회원 정보 확인 등의 내용으로 구성되는 페이지 --%>
<%-- 쇼핑몰의 모든 페이지에서 사용하게 되는 아주 중요한 페이지 --%>
<%
//로그인이 되었을 때(memberId 이름으로 세션이 등록되었을 때)
String memberId = (String)session.getAttribute("memberId");
%>

<div id="top">
	<div id="t1" class="t_box"> <!-- 구역1 : 타이틀, 검색창(보류) -->
		<div id="m_title"><a href="../shop/shopMain.jsp">BOOKMALL21</a></div>
		<div id="s_title">세상의 모든 지식이 여기에</div>
		<div id="s_search">
			<form method="post" action="">
			<fieldset>
				<input type="search"><button type="submit"><i class="fa fa-search"></i></button>
			</fieldset>
			</form>
		</div>
	</div>
	<div id="t2" class="t_box"> <!-- 구역2 : 회원정보, 구매목록, 장바구니, 최근본상품(보류) - 아이콘으로 표시 -->
		<div id="t_images">
			<a href="../member/memberInfoForm.jsp" data-tooltip-text="회원정보"><img src="../../icons/user_off.png" width="35" height="35" class="user_icon"  
			onmouseover="changeIconOn(this, 1)" onmouseout="changeIconOff(this, 1)"></a>
			<a href="../buy/buyForm.jsp" data-tooltip-text="구매정보"><img src="../../icons/buy_off.png" width="35" height="35" class="buy_icon" 
			onmouseover="changeIconOn(this, 2)" onmouseout="changeIconOff(this, 2)"></a>
			<a href="../cart/cartList.jsp" data-tooltip-text="장바구니"><img src="../../icons/cart_off.png" width="35" height="35" class="cart_icon"
			onmouseover="changeIconOn(this, 3)" onmouseout="changeIconOff(this, 3)"></a>
			<a href="" data-tooltip-text="최근본상품"><img src="../../icons/show_off.png" width="35" height="35" class="show_icon"
			onmouseover="changeIconOn(this, 4)" onmouseout="changeIconOff(this, 4)"></a>
		</div>
	</div>
	<!-- 전체상품 | 베스트 | 신상품 | 추천상품 | 이벤트 | 중고상품 | 북클럽 -->
	<!-- 000 : 건강/취미, 100 : 경제/경영,  200 : 소설/시, 300 : 에세이,  400 : 여행,  500 : 역사, 600 : 예술,
		 700 : 인문, 800 : 자기계발, 900 : 자연과학, 910 : 유아, 920 : 인물, 930 : IT, all : 전체 
	-->
	<div id="t3" class="t_box"> <!-- 구역3 : 메뉴 구성 -->
		<nav>
			<ul>
				<li class="m_menu">
					<a href="../shop/shopMain.jsp?product_kind=all" class="m1">전체상품</a>
 					<div class="s_menu">
						<a href="../shop/shopMain.jsp?product_kind=000#p_kind">건강/취미</a>
						<a href="../shop/shopMain.jsp?product_kind=100#p_kind">경제/경영</a>
						<a href="../shop/shopMain.jsp?product_kind=200#p_kind">소설/시</a>
						<a href="../shop/shopMain.jsp?product_kind=300#p_kind">에세이</a>
						<a href="../shop/shopMain.jsp?product_kind=400#p_kind">여행</a>
						<a href="../shop/shopMain.jsp?product_kind=500#p_kind">역사</a>
						<a href="../shop/shopMain.jsp?product_kind=600#p_kind">예술</a>
						<a href="../shop/shopMain.jsp?product_kind=700#p_kind">인문</a>
						<a href="../shop/shopMain.jsp?product_kind=800#p_kind">자기계발</a>
						<a href="../shop/shopMain.jsp?product_kind=900#p_kind">자연과학</a>
						<a href="../shop/shopMain.jsp?product_kind=910#p_kind">유아</a>
						<a href="../shop/shopMain.jsp?product_kind=920#p_kind">인물</a>
						<a href="../shop/shopMain.jsp?product_kind=930#p_kind">IT</a>
					</div>
				</li>
				<li class="m_menu">
					<a href="#" class="m2">베스트</a>
				</li>
				<li class="m_menu" >
					<a href="#" class="m3">신상품</a>
				</li>
				<li class="m_menu">
					<a href="#" class="m4">추천상품</a>
				</li>
				<li class="m_menu">
					<a href="#" class="m5">이벤트</a>
				</li>
				<li class="m_menu">
					<a href="#" class="m6">중고상품</a>
				</li>
				<li class="m_menu">
					<a href="#" class="m7">북클럽</a>
				</li>
			</ul>
		</nav>
	</div>
	<div id="t4" class="t_box"> <!-- 구역4 : 로그인, 회원가입, 고객센터(QnA로 연결) -->
		<div>
			<%if(memberId == null) {%> <%-- 로그인하지 않았을 때(memberId 세션이 없을 때) --%>
			<a href="../member/memberLoginForm.jsp">로그인</a>
			| <a href="../member/memberJoinForm.jsp">회원가입</a>
			<%} else {%>                <%-- 로그인하였을 때(memberId 세션이 있을 때) --%>
			<a href="../member/memberInfoForm.jsp"><b><%=memberId %></b>님</a>
			| <a href="../member/memberLogout.jsp">로그아웃</a>
			<%} %>
			 | <a href="">고객센터</a>
		</div>
	</div>
	<div id="t5"></div>
</div>
<hr>

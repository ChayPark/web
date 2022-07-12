<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
a { color: black; text-decoration: none;}
#bottom { width: 1100px;}
#t1 { margin-left: 45px;}
#t11 { margin-left: 35px;}
#t2 { margin-left: 90px;}
#t3 { margin-left: 70px;}
#t4 { margin-left: 10px;}
.s_box { width: 100%; margin: 10px auto;}
.d_box { display: inline-block; width: 31%; margin: 20px 10px;}
.d_box #d1 { padding-top: -50px;}
.s_box > .d_box:nth-child(2) { width: 300px; margin-left: 100px;}
.s_box > .d_box:nth-child(3) { margin-top: 0px; margin-left: 160px; width: 130px;}
.d_box > div { font-size: 0.8em; margin: 5px 0;}
.d_box strong { color: blue;}
.d_box b { font-size: 1.1em;}
.d_box button { padding: 0;}
.dd_box { display: inline-block; width: 48%;}
.dd_box > div { margin: 5px 0;}

#s2 div { font-size: 0.8em; margin: 5px 0;}
#s2 a { text-decoration: underline;}
#s2 #d3 { display: inline-block; float: left;}
#s2 #d4 { display: inline-block; float: right;}

#d3 { display: right;}

/* 구역 1 : 검색 CSS */

fieldset { position: relative; display: inline-block; padding: 0 0 0 40px; background: #fff; border: none; border-radius: 5px; margin-right: 20px;}

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

button {
  z-index: 1; width: 50px; border: 1px solid #868e96; background: #868e96;
  cursor: pointer;
  border-radius: 0 5px 5px 0;  
  -webkit-transform: translate(-50px, 0);
      -ms-transform: translate(-50px, 0);
          transform: translate(-50px, 0);
  -webkit-transition-duration: 0.3s;
          transition-duration: 0.3s;
}

.fa-search {
  font-size: 1.4rem; color: #868e96; z-index: 3; top: 25%;
  -webkit-transform: translate(-190px, 0);
      -ms-transform: translate(-190px, 0);
          transform: translate(-190px, 0);
  -webkit-transition-duration: 0.3s;
          transition-duration: 0.3s;
  -webkit-transition: all 0.1s ease-in-out;
          transition: all 0.1s ease-in-out;
}
</style>

<%-- 모든 쇼핑몰 페이지의 하단에 include 되어 사용하는 페이지 --%>
<%-- 회사 이력, 정보, 위치 등의 다양한 정보가 나타나는 페이지 : 자세한 내용은 생략하고, 형태만 갖추어 놓을 예정 --%>
<hr>
<section id="s1" class="s_box"> <!-- 구역1 -->
	<div id="d1" class="d_box">
		<div id="t1"><b>SIGN UP FOR PROMOTION</b></div>
		<div id="t11"><input type="text" placeholder="write your email"></div><br><br>
		<div id="t2"><b>SEARCH HERE</b></div>
		<div>
			<form method="post" action="">
			<fieldset>
				<input type="search"><button type="submit"><i class="fa fa-search"></i></button>
			</fieldset>
		</form>
		</div>
		
	</div>
	<div id="d2" class="d_box">
		<div id="t3"><b>NEW RELEASE</b></div>
		<div><a href="../shop/shopContent.jsp?product_id=2">FRAGMENT DESIGN X TRAVIS SCOTT X AIR JORDAN 1 RETRO LOW</div>
		<div><a href="../shop/shopContent.jsp?product_id=23">WMNS AIR JORDAN 1 RETRO HIGH OG 'SEAFOAM'</a></div>
		<div><a href="../shop/shopContent.jsp?product_id=296">DUNK LOW SE 'SAIL MULTI-CAMO'</a></div>
		<div><a href="../shop/shopContent.jsp?product_id=128">YEEZY BOOST 350 V2 'BRED'</a></div>
	</div>
	<div id="d3" class="d_box">		
		<div id="t4"><b>ACCOUNT</b></div>
		<div><a href="../member/memberInfoForm.jsp">MY ACCOUNT</a></div>
		<div><a href="#">TRACK MY ORDER</a></div>
		<div><a href="#">SELL SNEAKERS</a></div>
		<div><a href="#">COOKIE SETTINGS</a></div>
	</div>
</section>
<hr>

<section id="s2" class="s_box"> <!-- 구역3 -->
	<div id="d1">휴먼 코리아 유한 책임회사 사이트의 상품/판매자/쇼핑 정보, 콘텐츠, UI 등에 대한 무단 복제, 전송, 배포, 스크래핑 등의 행위는 저작권법, 콘텐츠 산업 진흥법 등에 의하여 엄격히 금지됩니다.</div>
	<div id="d2"><a href="#">콘텐츠산업 진흥법에 따른 표시</a></div>
	<div id="d3">Copyright <b>CHAYISH</b> Korea All rights reserved.</div>
	<div id="d4"><img src="../../icons/cherry.png" width="45" height="45"></div>
</section> <!-- 아이콘 찾을 때는 shopMain에서  icons 폴더 찾기 : include 되었기 때문에-->
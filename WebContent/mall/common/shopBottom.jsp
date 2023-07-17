<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
#bottom { width: 1100px;}
#s1, #s2 { background: #e9ecef;}
.s_box { width: 100%; margin: 10px auto;}
.d_box { display: inline-block; width: 31%; margin: 20px 10px;}
.d_box > div { font-size: 0.8em; margin: 5px 0;}
.d_box strong { color: blue;}
.d_box b { font-size: 1.1em;}
.d_box button { padding: 0;}
.dd_box { display: inline-block; width: 48%;}
.dd_box > div { margin: 5px 0;}
#s2 #d3 div { display: inline-block; width: 48%; font-size: 0.7em;}
#s2 #d3 img { float: left; padding-right: 10px;}
#s3 div { font-size: 0.8em; margin: 5px 0;}
#s3 a { text-decoration: underline;}
#s3 #d3 { display: inline-block; float: left;}
#s3 #d4 { display: inline-block; float: right;}
</style>

<%-- 모든 쇼핑몰 페이지의 하단에 include 되어 사용하는 페이지 --%>
<%-- 회사 이력, 정보, 위치 등의 다양한 정보가 나타나는 페이지: 자세한 기능은 생략하고, 형태만 갖추어 놓을 예정 --%>
<hr>
<div id="bottom">
<section id="s1" class="s_box"> <!-- 구역1 -->
	<div id="d1" class="d_box">
		<div><b>고객센터</b></div>
		<div>Tel: <strong>1588-1004</strong> (평일 09:00 ~ 18:00)</div>
		<div>해피클럽 & VVIP : <strong>1522-9000</strong> (365일 09:00 ~ 18:00)</div>
		<div>경기도 부천시 원미구 부일로 330 (중동) 휴먼빌딩 6층</div>
		<div>Fax : 02-577-7789 | Mail : info@corp.mall21.co.kr</div>
	</div>
	<div id="d2" class="d_box">
		<div><b>휴먼코리아 유한책임회사</b></div>
		<div>서울시 강남구 테헤란로 170 (역상동 휴먼파이낸스센터)</div>
		<div>업무책임자 : 육치성</div>
		<div>사업자등록번호 : 200-88-98765</div>
		<div>통신판매업신고 : 강남 20686호 <b>사업자정보 확인&gt;</b></div>
	</div>
	<div id="d3" class="d_box">
		<div><b>전자금융 분쟁처리 &gt;</b></div>
		<div>Tel : 1588-1004 Fax : 02-577-7789</div>
		<div>Mail : mediation@mail21.co.kr</div>
		<div><b>분쟁처리절차&gt;</b></div>
		<div><b>안전거래센터&gt;</b></div>
	</div>
</section>
<hr>
	
<section id="s2" class="s_box"> <!--  구역2 -->
	<div id="d1" class="d_box">
		<div class="dd_box">
			<div>채용정보</div>
			<div>이용약관</div>
			<div>전자금융거래약관</div>
			<div><b>개인정보 처리방침</b></div>
			<div>보안센터</div>
		</div>
		<div class="dd_box">
			<div>브랜드 광고센터</div>
			<div>판매자 광고센터</div>
			<div>판매자 교육센터</div>
			<div>스토어관리 / Open API</div>
			<div>VeRO Program</div>
		</div>
	</div>
	<div id="d2" class="d_box">
		<div>저작권침해신고</div>
		<div>윤리경영</div>
		<div>소비자보호를 위한 오픈마켓 자율준수규약</div>
		<div>제춤안전정보센터</div>
		<div>사이버범죄 신고시스템</div>
	</div>
	<div id="d3" class="d_box">
		<div><img src="../../icons/f-icon1.png" width="25" height="25">ISMS-P<br>인증 사업자</div>
		<div><img src="../../icons/f-icon2.png" width="25" height="25">개인정보보호<br>우수 웹사이트</div>
		<div><img src="../../icons/f-icon3.png" width="25" height="25">한국온라인쇼핑<br>협회회원</div>
		<div><img src="../../icons/f-icon4.png" width="25" height="25">제품안전<br>협력매장</div>
		<div><img src="../../icons/f-icon5.png" width="25" height="25">위해상품차단시스템<br>운영매장</div>
	</div>
</section>
<hr>

<section id="s3"> <!-- 구역3 -->
	<div id="d1">휴먼코리아 유한책임회사 사이트의 상품/판매자/쇼핑 정보, 콘텐츠, UI 등에 대한 무단 복제, 전송, 배포, 스크래핑  등의 행위는 저작권법, 콘텐츠산업 진흥법 등에 의하여 엄격히 금지됩니다.</div>
	<div id="d2"><a href="#">콘텐츠산업 진흥법에 따른 표시</a></div>
	<div id="d3">Copyright mall21 Korea All rights reserved.</div>
	<div id="d4"><img src="../../icons/mall21.png" height="30"></div>
</section>
</div>
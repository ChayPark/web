<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="mall.cart.*, java.util.*, java.text.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구매확인 폼</title>
<style>
#container { width: 1100px; margin: 0 auto;}
ul { list-style: none;}
.title { text-align: center; font-size: 1.5em; margin: 30px 0;}
table { width: 100%; border: 1px solid #868e96; border-collapse: collapse;}
th, td { border: 1px solid #868e96;}
tr { height: 50px;}
.buy_table th { text-align: center;}


</style>
</head>
<body>
<%
// buyForm.jsp - 구매 정보 확인 폼 (구매 여부 결정), buyList.jsp - 구매 목록 폼 (최종 결제)

// 로그인 확인
String memberId = (String)session.getAttribute("memberId");
if(memberId == null) {
	out.print("<script>alert('로그인을 해주세요.');");
	out.print("location='../member/memberLoginForm.jsp';</script>");
}

//가격 포맷
DecimalFormat df = new DecimalFormat("#,###,###");

//배송일자 구하기
//일월화 = 현재날짜 + 3일, 수목금 = 현재날짜 + 3일 + 2일(토일), 토 = 현재날짜 + 3일 + 1일(일)
Calendar c = Calendar.getInstance();
int diff_day = 3;
//요일 - 1~7, 일~토
switch(c.get(Calendar.DAY_OF_WEEK)) {
case 1: case 2: case 3: c.add(Calendar.DATE, diff_day); break;
case 4: case 5: case 6: c.add(Calendar.DATE, diff_day+=2); break;
case 7: c.add(Calendar.DATE, diff_day+=1); break;
}
//배송 월, 일, 요일
int m = c.get(Calendar.MONTH) + 1;   // 배송 월
int d = c.get(Calendar.DATE);        // 배송 일
int w = c.get(Calendar.DAY_OF_WEEK); // 배송 요일
String[] weekday = {"", "일", "월", "화", "수", "목", "금", "토"};
String week = weekday[w];
//System.out.println("배송일자 : " + m + "월 " + d + "일 " + weekday[w] + "요일");

// request 요청값 확인
int cart_id = Integer.parseInt(request.getParameter("cart_id"));

// cart DB 연동, 쿼리 실행
CartDBBean cartPro = CartDBBean.getIntance();
CartDataBean cart = cartPro.getCart(cart_id);
%>

<div id="container">
<ul>
	<li><header><jsp:include page="../common/shopTop.jsp"/></header></li>
	<li>
		<div class="title">구매 정보 확인</div>
		<table class="buy_table">
			<tr>
				<th>상품명</th>
				<th>정가</th>
				<th>판매가</th>
				<th>수량</th>
				<th>합계</th>
				<th>배송일</th>
			</tr>
			<tr>
				<td>
					<img src="/images_mall21/<%=cart.getProduct_image()%>" width="50" height="75">
					<%=cart.getProduct_title() %>
				</td>
				<td></td>
				<td></td>
				<td><%=cart.getBuy_count() %></td>
				<td><%=cart.getBuy_price() %></td>
				<td>
					<span class="s_day1"><%=diff_day %>일 이내</span><br>
					<span class="s_day2">(<%=m %>/<%=d %>, <%=week %>)</span><br>
					<span class="s_day3">출고예정</span>
				</td>
			</tr>
		</table>
	
	</li>
	<li><footer><jsp:include page="../common/shopBottom.jsp"/></footer></li>
</ul>
</div>

</body>
</html>
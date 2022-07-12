<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="mall.cart.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카트 구매수량 변경 처리</title>
</head>
<body>

<%
String memberId = (String)session.getAttribute("memberId");

//로그인이 되지 않았을 때 - 로그인 폼으로 이동
if(memberId == null) {
	out.print("<script>alert('로그인을 해주세요.');");
	out.print("location='../member/memberLoginForm.jsp';</script>");
}

// 카트번호, 변경수량 변수값 획득
int cart_id = Integer.parseInt(request.getParameter("cart_id"));
int buy_count = Integer.parseInt(request.getParameter("buy_count"));

// cart DB연동, 쿼리 실행, 이동제어
CartDBBean cartPro = CartDBBean.getIntance();
cartPro.updateCart(cart_id, buy_count);
response.sendRedirect("cartList.jsp");
%>
</body>
</html>
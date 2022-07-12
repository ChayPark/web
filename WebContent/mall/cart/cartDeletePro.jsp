<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="mall.cart.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카트 상품 1개 삭제 처리</title>
</head>
<body>

<%
int cart_id = Integer.parseInt(request.getParameter("cart_id"));

// DB 연동, 쿼리 실행, 이동 제어
CartDBBean cartPro = CartDBBean.getIntance();
cartPro.deleteCart(cart_id);
response.sendRedirect("cartList.jsp");
%>
</body>
</html>
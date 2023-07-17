<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="mall.cart.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니 추가 처리</title>
</head>
<body>

<%
request.setCharacterEncoding("utf-8");

String memberId = (String)session.getAttribute("memberId");

// 로그인이 되지 않았을 때 - 로그인 폼으로 이동
if(memberId == null) {
	out.print("<script>alert('로그인을 해주세요.');");
	out.print("location='../member/memberLoginForm.jsp';</script>");
}

// 로그인이 되었을 때 - 요청 정보 획득, 카트빈 생성, DB 처리
int product_id = Integer.parseInt(request.getParameter("product_id"));
int buy_price = Integer.parseInt(request.getParameter("sale_price"));
int buy_count = Integer.parseInt(request.getParameter("p_number"));
String product_title = request.getParameter("product_title");
String product_image = request.getParameter("product_image");

CartDataBean cart = new CartDataBean();
cart.setBuyer(memberId);
cart.setProduct_id(product_id);
cart.setProduct_title(product_title);
cart.setBuy_price(buy_price);
cart.setBuy_count(buy_count);
cart.setProduct_image(product_image);

// 장바구니 DB 연동, 쿼리 실행
// 장바구니 - cart_id, buyer(memberID), product_id, product_title, buy_price, buy_count, product_image
CartDBBean cartPro = CartDBBean.getIntance();
int check = cartPro.insertCart(cart);

// 카트 추가 성공 여부에 따른 화면 이동
if(check == 0) { // 카트 추가 실패
	out.print("<script>alert('카트 추가 실패하였습니다.');history.back();</script>");
} else {         // 카트 추가 성공
	out.print("<script>location='cartList.jsp';</script>");
}
%>

</body>
</html>
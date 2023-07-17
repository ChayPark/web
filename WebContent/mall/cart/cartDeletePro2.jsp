<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="mall.cart.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>선택한 카트 상품 삭제(전체 또는 여러개)</title>
</head>
<body>

<%
// 자바스크립트의 선택 카트 배열을 문자열로 획득
String choice_cart = request.getParameter("choice_cart");
System.out.println("choice_cart : " + choice_cart);

// 문자열을 ,로 구분하여 문자열 배열로 저장
String[] carts = choice_cart.split(",");
System.out.println("carts : " + Arrays.toString(carts));

// 문자열 배열을 int형으로 변화하여 ArrayList로 저장
List<Integer> cartList = new ArrayList<Integer>();
for(int i=0; i<carts.length; i++) {
	cartList.add(Integer.parseInt(carts[i]));
}
System.out.println("cartList : " + cartList.toString());

// 카트 DB 연동, 쿼리 실행, 이동 제어
CartDBBean cartPro = CartDBBean.getIntance();
cartPro.deleteCart(cartList);
response.sendRedirect("cartList.jsp");
%>

</body>
</html>
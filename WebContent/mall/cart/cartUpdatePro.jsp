<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="mall.cart.*, manager.product.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카트 구매수량 변경 처리</title>
</head>
<body>

<%
String memberId = (String)session.getAttribute("memberId");
// 로그인이 되지 않았을 때 -> 로그폼으로 이동
if(memberId == null) {
	out.print("<script>alert('로그인을 해주세요.');");
	out.print("location='../member/memberLoginForm.jsp';</script>");
}

// 카트번호, 변경수량 변수값 획득
int cart_id = Integer.parseInt(request.getParameter("cart_id"));
int buy_count = Integer.parseInt(request.getParameter("buy_count"));
int p_one_price = Integer.parseInt(request.getParameter("p_one_price"));
int product_id = Integer.parseInt(request.getParameter("product_id"));

// 구매수량이 상품재고 수량을 초과할 때는 변경 불가, 0이하는 변경 불가
ProductDBBean productPro = ProductDBBean.getInstance();
ProductDataBean product = productPro.getProduct(product_id);
int product_count = product.getProduct_count();
out.print("<script>");
if(buy_count > product_count) { // 구매수량 > 상품재고 수량 -> 변경 불가
	out.print("alert('상품재고수량을 초과하였습니다.(현재 재고수량: "+ product_count +"개)\\n구매수량을 다시 입력해 주세요.');");
	out.print("location='cartList.jsp';");
} else if(buy_count <= 0) {     // 구매수량 <= 0 -> 변경 불가
	out.print("alert('구매수량은 1개이상이어야 합니다.\\n구매수량을 다시 입력해 주세요.');");
	out.print("location='cartList.jsp';");
} else { // 구매수량 < 상품재고 수량 -> 변경 가능                 
	// 카트 DB 연동, 쿼리 실행, 이동 제어
	CartDBBean cartPro = CartDBBean.getIntance();
	cartPro.updateCart(cart_id, buy_count, p_one_price);
	out.print("location='cartList.jsp';");
}
out.print("</script>");
%>

</body>
</html>
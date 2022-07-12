<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="manager.product.*, java.text.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 상세 보기</title>
<style>
#container { width: 600px; margin: 20px auto;}
h2 { text-align: center; background: #F9F7F6; border-left: 0.5em solid #9db5e8;; padding: 0.5em;} 
button { width: 80px; height: 30px; background: #9db5e8; color: white; border: 0;}
button:hover { background: white; color: black; border: 1px solid black;}
p { padding-top: 10px; overflow: auto;}
table { width: 100%; border: 1px solid #9db5e8; border-collapse: collapse; background: #9db5e8;}
th, td { border: 1px solid #277abe; padding: 5px; text-align: center;}
td { padding-left: 10px;}
tr { height: 50px;}
#images, #detail { background: white;}
.content_row { height: 300px; margin-top: 0;}
.btns { text-align: right; margin-bottom: 10px;}
.title { font-size: 1.3em; font-weight: 700;}
.price { font-weight: 700;}
</style>

</head>
<body>

<%
String managerId = (String)session.getAttribute("managerId");
//로그인하지 않았을 때
if(managerId == null) {
	response.sendRedirect("../logon/managerLoginForm.jsp");	
}
//로그인하였을 때

int product_id = Integer.parseInt(request.getParameter("product_id"));
String product_brand = request.getParameter("product_brand");
String pageNum = request.getParameter("pageNum");
DecimalFormat df = new DecimalFormat("#,###,###.##");
ProductDataBean product = new ProductDataBean();

// 상품 분류 
String product_brandName = "";
switch(product_brand) {
case "NIKE": product_brandName = "나이키"; break;
case "ADIDAS": product_brandName = "아디다스"; break;
case "JORDAN": product_brandName = "조던"; break;
case "YEEZY": product_brandName = "이지"; break;
case "COLLAB": product_brandName = "콜라보"; break;
case "all": product_brandName = "전체"; break;
}

// DB 연동, 쿼리 실행 
ProductDBBean dbPro = ProductDBBean.getInstance();
product = dbPro.getProduct(product_id);

%>
<div id="container">
	<h2>상품 내용 (<%=product_brandName %>)</h2>
	<div class="btns"><button onclick="location='productList.jsp?product_brand=<%=product_brand%>&pageNum=<%=pageNum%>'">상품 목록</button></div>
	<table>
		<tr>
			<th id="images" width="45%" rowspan="6"><img src="/images_shoes21/<%=product.getProduct_image() %>" width="250">
			<td width="55%" colspan="2"><span class="title"><%=product.getProduct_title() %></span></td>
		</tr>
		<tr><td colspan="2">사이즈: <%=product.getProduct_size() %></td></tr>
		<tr><td colspan="2">출시일: <%=product.getProduct_date() %></td></tr>
		<tr><td colspan="2">가격: <span class="price"><%=df.format(product.getProduct_price()) %>$</span></td></tr>
		<tr><td colspan="2">재고수량: <%=product.getProduct_count() %>개</td></tr>
		<tr>
			<td colspan="2"><p class="content_row"><%=product.getProduct_description() %></p></td>
		</tr>
		<tr>
			<td id="detail" ><img src="/images_shoes21/<%=product.getProduct_detail1() %>" width="250"></td>
			<td id="detail"><img src="/images_shoes21/<%=product.getProduct_detail2() %>" width="250"></td>
			<td id="detail"><img src="/images_shoes21/<%=product.getProduct_detail3() %>" width="250"></td>
		</tr>
		
	</table>
</div>
</body>
</html>
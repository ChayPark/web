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
h2 { text-align: center;}
button { width: 80px; height: 30px; background: black; color: white; border: 0;}
button:hover { background: white; color: black; border: 1px solid black;}
p { padding-top: 10px; overflow: auto;}
table { width: 100%; border: 1px solid lightgray; border-collapse: collapse; background: ivory;}
th, td { border: 1px solid lightgray; padding: 5px;}
td { padding-left: 10px;}
tr { height: 30px;}
.content_row { height: 200px; margin-top: 0;}
.btns { text-align: right; margin-bottom: 10px;}
.title { font-size: 1.3em; font-weight: 700;}
.price { text-decoration: line-through;}
.salePrice { font-size: 1.3em; font-weight: 700; color: red;}
.discount { color: red;}
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
String product_kind = request.getParameter("product_kind");
String pageNum = request.getParameter("pageNum");
DecimalFormat df = new DecimalFormat("#,###,###");
ProductDataBean product = new ProductDataBean();

//상품 분류
String product_kindName = "";
switch(product_kind) {
case "000": product_kindName = "건강/취미"; break;
case "100": product_kindName = "경제/경영"; break;
case "200": product_kindName = "소설/시"; break;
case "300": product_kindName = "에세이"; break;
case "400": product_kindName = "여행"; break;
case "500": product_kindName = "역사"; break;
case "600": product_kindName = "예술"; break;
case "700": product_kindName = "인문"; break;
case "800": product_kindName = "자기계발"; break;
case "900": product_kindName = "자연과학"; break;
case "910": product_kindName = "유아"; break;
case "920": product_kindName = "인물"; break;
case "930": product_kindName = "IT"; break;
case "all": product_kindName = "전체"; break;
}

// DB연동, 쿼리문 실행
ProductDBBean dbPro = ProductDBBean.getInstance();
product = dbPro.getProduct(product_id);

// 판매가 계산
int price = product.getProduct_price();
int dc = product.getDiscount_rate();
int salePrice = price - price*dc/100;
%>
<div id="container">
	<h2>상품 내용 (<%=product_kindName %>)</h2>
	<div class="btns"><button onclick="location='productList.jsp?product_kind=<%=product_kind%>&pageNum=<%=pageNum%>'">상품 목록</button></div>
	<table>
		<tr>
			<th width="45%" rowspan="6"><img src="/images_mall21/<%=product.getProduct_image() %>" width="250px"></th>
			<td width="55%"><span class="title"><%=product.getProduct_title() %></span></td>
		</tr>
		<tr><td><%=product.getAuthor() %> 저 | <%=product.getPublishing_com() %></td></tr>
		<tr><td>출판일: <%=product.getPublishing_date() %></td></tr>
		<tr><td>정가: <span class="price"><%=df.format(price) %> 원</span></td></tr>
		<tr><td>판매가: <span class="salePrice"><%=df.format(salePrice) %> 원</span> <span class="discount">(<%=dc %>%)</span></td></tr>
		<tr><td>재고 수량: <%=product.getProduct_count() %> 권</td></tr>
		<tr><td colspan="2"><p class="content_row"><%=product.getProduct_content() %></p></td></tr>
	</table>
</div>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="manager.product.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 삭제 처리 페이지</title>
</head>
<body>

<%
int product_id = Integer.parseInt(request.getParameter("product_id"));
String product_brand = request.getParameter("product_brand");
String pageNum = request.getParameter("pageNum");

// DB 연동, 삭제 쿼리 메소드 실행
ProductDBBean dbPro = ProductDBBean.getInstance();
dbPro.deleteProduct(product_id);
response.sendRedirect("productList.jsp?product_brand="+product_brand+"&pageNum="+pageNum);
%>
</body>
</html>
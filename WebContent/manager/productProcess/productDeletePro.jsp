<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="manager.product.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Product Deletion Page</title>
</head>
<body>

<%
int product_id = Integer.parseInt(request.getParameter("product_id"));
String product_brand = request.getParameter("product_brand");
String pageNum = request.getParameter("pageNum");

// DB link, executes deletion query method
ProductDBBean dbPro = ProductDBBean.getInstance();
dbPro.deleteProduct(product_id);
response.sendRedirect("productList.jsp?product_brand="+product_brand+"&pageNum="+pageNum);
%>
</body>
</html>

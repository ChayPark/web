<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Product Deleation Form Page</title>
</head>
<body>

<%
String managerId = (String)session.getAttribute("managerId");
//When there is no session value for managerId (when not login)
if(managerId == null) {
	response.sendRedirect("../logon/managerLoginForm.jsp");
}
//When there is session value for managerId (when login)


int product_id = Integer.parseInt(request.getParameter("product_id"));
String product_brand = request.getParameter("product_brand");
String pageNum = request.getParameter("pageNum");
%>
<script>
var choice = confirm("Would you like to delete this product?");

if(choice) location="productDeletePro.jsp?product_id=<%=product_id%>&product_brand=<%=product_brand%>&pageNum=<%=pageNum%>";
else history.back(); 
</script>

</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Page</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Gaegu&display=swap" rel="stylesheet">

<style>
#container { width: 300px; margin: auto;}
h3 { text-align: center; border-radius: 5em; padding: 0.6em 1em; background: #9db5e8; 
box-shadow: 1px 2px 10px rgba(0,0,0,0.2);  margin-left: 5px; font-size: 1.5em; font-family: 'Gaegu', cursive;}
a { text-decoration: none; color: #4b6375;}
table { width: 100%; border: 1px solid #9db5e8; border-collapse: collapse;}
th, td { border: 1px solid #9db5e8; color: black;}
tr { height: 40px; font-size: 1.3em;}
.title_row { background: #9db5e8; font-weight: bold;}
</style>
</head>
<body>
<%
String managerId = (String)session.getAttribute("managerId");
// When it was not logged in
if(managerId == null) {
	response.sendRedirect("logon/managerLoginForm.jsp");
}
// When the managerId is not null(When it was logged in)
%>
<div id="container">
	<h3>Admin main page</h3>
	<table>
		<tr><th><a href="logon/managerLogout.jsp">Admin logout</a></th></tr>
		<tr></tr>
		<tr class="title_row"><th>Product Management</th></tr>
		<tr><th><a href="productProcess/productRegisterForm.jsp">Product Registration</a></th></tr>
		<tr><th><a href="productProcess/productList.jsp">Product lists(Modifications/Deletions)</a></th></tr>
		<tr class="title_row"><th>Order Management</th></tr>
		<tr><th><a href="">Check the order list(Modifications/Deletions)</a></th></tr>
		<tr class="title_row"><th>Member Management</th></tr>
		<tr><th><a href="">Check the membership List(Modifications/Deletions)</a></th></tr>
	</table>
</div>

</body>
</html>

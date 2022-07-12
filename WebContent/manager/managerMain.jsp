<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지</title>

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
// 로그인이 되지 않았을 때
if(managerId == null) {
	response.sendRedirect("logon/managerLoginForm.jsp");
}
// 아래는 managerId가 null이 아닐 때(로그인이 되었을 때) 처리
%>
<div id="container">
	<h3>쇼핑몰 관리자 메인 페이지</h3>
	<table>
		<tr><th><a href="logon/managerLogout.jsp">관리자 로그아웃</a></th></tr>
		<tr></tr>
		<tr class="title_row"><th>상품 관리</th></tr>
		<tr><th><a href="productProcess/productRegisterForm.jsp">상품 등록</a></th></tr>
		<tr><th><a href="productProcess/productList.jsp">상품 목록(수정/삭제)</a></th></tr>
		<tr class="title_row"><th>주문 관리</th></tr>
		<tr><th><a href="">주문 목록 확인(수정/삭제)</a></th></tr>
		<tr class="title_row"><th>회원 관리</th></tr>
		<tr><th><a href="">회원 목록 확인(수정/삭제)</a></th></tr>
	</table>
</div>

</body>
</html>
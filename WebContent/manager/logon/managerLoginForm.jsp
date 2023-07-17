<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 로그인 폼 페이지</title>
<style>
#container { width: 300px; margin: 20px auto;}
h2, .btns_row { text-align: center;}
table { width: 100%; border: 1px solid black; border-collapse: collapse;}
th, td { border: 1px solid black;}
th { background: rgba(255, 187, 0, 0.7);}
td { padding-left: 10px;}
tr { height: 37px;}
input[type="button"] { width: 80px; height: 30px; background: black; color: white; border: 0; cursor: pointer; font-weight: 700;} 
input[type="button"]:hover { background: white; color: black; border: 1px solid black;}
</style>
<script>
window.onload = function() {
	var loginBtn = document.getElementById("loginBtn");
	loginBtn.addEventListener("click", function() {
		var form = document.loginForm;
		
		if(!form.managerId.value) {
			alert("관리자 아이디를 입력하시오.");
			form.managerId.focus();
			return;
		}
		if(!form.managerPasswd.value) {
			alert("관리자 비밀번호를 입력하시오.");
			form.managerPasswd.focus();
			return;
		}
		form.submit();
	})
}
</script>
</head>
<body>

<div id="container">
	<h2>관리자 로그인</h2>
	<form method="post" action="managerLoginPro.jsp" name="loginForm">
		<table>
			<tr>
				<th width="30%">아이디</th>
				<td width="70%"><input type="text" name="managerId" size="24"></td>			
			</tr>
			<tr>
				<th>비밀번호</th>
				<td><input type="password" name="managerPasswd" size="24" maxlength="16"></td>			
			</tr>
			<tr class="btns_row">
				<td colspan="2"><input type="button" value="로그인" id="loginBtn"></td>
			</tr>
		</table>
	</form>
</div>

</body>
</html>
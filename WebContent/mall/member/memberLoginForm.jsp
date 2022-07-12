<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 폼 페이지</title>
<style>
@import url('https://fonts.googleapis.com/css2?family=Luckiest+Guy&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Yanone+Kaffeesatz:wght@600&display=swap');
#container { width: 450px; margin: 100px auto;}
#m_title { font-size: 4.5em; font-family: 'Luckiest Guy', cursive; text-align: center; margin-left: 30px;}
#m_title a { text-decoration: none; color: black; }
#s_title { text-align: center; color: black; font-size: 2.5em; font-family: 'Yanone Kaffeesatz', sans-serif;}
table { width: 100%;}
td { padding: 5px 0;}
tr { height: 50px;}
input { height: 42px; padding-left: 10px;}
input[type="button"] { width: 99%; height: 55px; background: #343a40; color: white; border: none;}
input[type="button"]:hover { background: #ced4da; color: black; font-weight: bold; border: 1px solid black;}
a { text-decoration: none; color: gray; font-size: 0.8em;}
</style>
<script>
window.onload = function() {
	var form = document.loginForm;
	var btn_login = document.getElementById("btn_login");
	btn_login.addEventListener("click", function() {
		if(!form.id.value) {
			alert('아이디를 입력해주세요.');
			form.id.focus();
			return;
		}
		if(!form.passwd.value) {
			alert('비밀번호를 입력해주세요.');
			form.passwd.focus();
			return;
		}
		form.submit();
	})
	
	// 쿠키 확인 - 쿠키가 존재한다면
	if(document.cookie.length > 0) {
		// name이 'cookieId'인 쿠키의 값을 추출
		var search = "cookieId=";
		var idx = document.cookie.indexOf(search);
		if(idx != -1){ // cookieId가 존재한다면
			idx += search.length;
			var end = document.cookie.indexOf(";", idx);
			if(end == -1) {
				end = document.cookie.length;
			}
			form.id.value = document.cookie.substring(idx, end);
			form.save_id.checked = true;
		}
		
	}
	// 쿠키 저장하는 함수 - 체크박스를 클릭했을 때
	// document.cookie -> 쿠키 생성 
	// 쿠키를 만들 때 설정해야되는 값 -> 이름, 값, 유지시간
	// escape() 함수 : *, -, _, +, ., /를 제외한 모든 문자를 16진수로 변환하는 함수 
	// - 변환하는 이유 : 쉼표, 세미콜론등과 같은 문자가 쿠키에서 사용되는 문자열과의 충돌을 방지하기 위해서 
	var save_id = document.getElementById("save_id");
	save_id.addEventListener("click", function() {
		var now = new Date();			// 오늘 날짜
		var name = "cookieId"; 			// 쿠키 이름
		var value = form.id.value; 		// 쿠키 값 설정 
		if(form.save_id.checked == true) {			
			// 쿠키 생성 
			now.setDate(now.getDate() + 7); // 쿠키 유지 시간 설정, 7일 유지
			document.cookie = name + "=" + escape(value) + ";path=/;expires=" + now.toGMTString() + ";"
			console.log(document.cookie);
		} else { 
			// 쿠키 삭제
			now.setDate(now.getDate() + 0); // 쿠키 삭제, 유지시간을 0으로 설정 
			document.cookie = name + "=" + escape(value) + ";path=/;expires=" + now.toGMTString() + ";"
		}		
	})
	
	
}
</script>
</head>
<body>

<div id="container">
	<div id="m_title"><a href="../shop/shopMain.jsp">CHAYISH</a><img src="../../icons/cherry.png" width="45" height="45" class="cherry_icon"></div>
	<div id="s_title">LOGIN</div>
	<form method="post" action="memberLoginPro.jsp" name="loginForm">
		<table>
			<tr><td colspan="5"><input type="text" name="id" size="62" placeholder="아이디"></td></tr>
			<tr><td colspan="5"><input type="password" name="passwd" size="62" placeholder="비밀번호"></td></tr>
			<tr><td colspan="5"><input type="button" value="로그인" id="btn_login"></td></tr>
			<tr>
				<td width="8%"><input type="checkbox" name="save_id" id="save_id"></td>
				<td width="40%"><label for="save_id">아이디 저장</label></td>
				<td width="14%"><a href="memberJoinForm.jsp">회원가입 |</a></td>
				<td width="18%"><a href="">아이디 찾기 |</a></td>
				<td width="20%"><a href="">비밀번호 찾기</a></td>
			</tr>
		</table>
	</form>
</div>
</body>
</html>
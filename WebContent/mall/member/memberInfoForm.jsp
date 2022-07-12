<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="mall.member.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입정보 확인/수정/삭제(탈퇴)</title>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script> 
<style>
@import url('https://fonts.googleapis.com/css2?family=Luckiest+Guy&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Jua&display=swap');
#container { width: 500px; margin: 0 auto;}
#m_title { font-size: 3.5em; font-family: 'Luckiest Guy', cursive; text-align: center; margin-top: 30px;}
#m_title a { text-decoration: none; color: #495057;}
#s_title { font-size: 2em; font-family: 'Jua', sans-serif; text-align: center; color: #495057;}
table { width: 100%; border: 1px solid black; border-collapse: collapse;}
th, td { border: 1px solid black;}
th { background: #ced4da;}
td { padding-left: 10px;}
tr { height: 60px;}
span { font-size: 0.8em;}
#id { background: #dee2e6;}
#chk_id { color: red;}
.address_row { height: 100px;}
#btns { text-align: center; margin-top: 20px;}
#btns input[type="button"] { width: 130px; height: 40px; background: #495057; color: white; border: 0; corsor: pointer;}
#btns input[type="button"]:hover { background: #e9ecef; color: #495057; font-weight: bold; border: 1px solid black;}
.btn_chk { width: 100px; height: 30px; background: #868e96; color: white; border: 0; corsor: pointer; border-radius: 5px;}
.btn_chk:hover { background: #e9ecef; color: #868e96; border: 1px solid #79766d; font-weight: bold;}
</style>
<script>
window.onload = function() {
	var form = document.updateForm;
	var btn_update = document.getElementById("btn_update");
	btn_update.addEventListener("click", function() {
		if(!form.passwd.value) {
			alert('비밀번호를 입력해주세요.');
			form.passwd.focus();
			return;
		}
		if(!form.passwd2.value) {
			alert('비밀번호 확인을 입력해주세요.');
			form.passwd2.focus();
			return;
		}
		if(!form.name.value) {
			alert('이름을 입력해주세요.');
			form.name.focus();
			return;
		}
		if(!form.email.value) {
			alert('이메일을 입력해주세요.');
			form.email.focus();
			return;
		}
		if(!form.address.value) {
			alert('주소를 입력해주세요.');
			form.address.focus();
			return;
		}
		if(!form.address2.value) {
			alert('상세 주소를 입력해주세요.');
			form.address2.focus();
			return;
		}
		if(!form.tel.value) {
			alert('전화번호를 입력해주세요.');
			form.tel.focus();
			return;
		}
		form.submit();
	})
	
	var chk_pass = document.getElementById("chk_pass");
	var chk_pass2 = document.getElementById("chk_pass2");
	var chk_email = document.getElementById("chk_email");
	var passwd = form.passwd;
	var passwd2 = form.passwd2;
	var name = form.name;
	var email = form.email;
	// 포커스를 잃게 되었을 때 발생하는 이벤트
	// 비밀번호 - 4글자 미만에 대한 유효성 검사
	passwd.addEventListener("blur", function() {
		if(passwd.value.length < 4) {
			chk_pass.innerHTML = "비밀번호는 4자리 이상이어야 합니다.";
			chk_pass.style.color = "red";
			passwd.value = "";
			passwd.focus();
		} else {
			chk_pass.innerHTML = "사용가능한 비밀번호입니다.";
			chk_pass.style.color = "blue";
			passwd2.focus();
		}
	})
	
	// 비밀번호확인 - 비밀번호 불일치에 대한 유효성 검사
	passwd2.addEventListener("blur", function() {
		if(passwd.value != passwd2.value) {
			chk_pass2.innerHTML = "비밀번호가 일치하지 않습니다.";
			chk_pass2.style.color = "red";
			passwd2.value = "";
			passwd2.focus();
		} else {
			chk_pass2.innerHTML = "비밀번호가 일치합니다.";
			chk_pass2.style.color = "blue";
			name.focus();
		}
	})
	
	// 이메일 - '@' 문자 미포함에 대한 유효성 검사
	email.addEventListener("blur", function() {
		var x = email.value.indexOf("@");
		if(x == -1) {
			chk_email.innerHTML = "사용가능한 이메일을 입력해 주세요.";
			chk_email.style.color = "red";
			email.value = "";
			email.focus();
		} else { 
			chk_email.innerHTML = "사용가능한 이메일입니다.";
			chk_email.style.color = "blue";
		}
	})
	
	// 주소 찾기 버튼 - 다음 라이브러리 활용
	var btn_address = document.getElementById("btn_address");
	btn_address.addEventListener("click", function() {
		new daum.Postcode({
			oncomplete:function(data) {
				form.address.value = data.address;
			}
		}).open();
	})
	
	// 회원 탈퇴(회원삭제) 버튼을 클릭할 때
	var btn_delete = document.getElementById("btn_delete");
	btn_delete.addEventListener("click", function() {
		if(!form.passwd.value) {
			alert('비밀번호를 입력해주세요.');
			form.passwd.focus();
			return;
		}
		if(!form.passwd2.value) {
			alert('비밀번호 확인을 입력해주세요.');
			form.passwd2.focus();
			return;
		}
		form.action = 'memberDeletePro.jsp'; // action 변경 
		form.submit();
	})
}
</script>
</head>
<body>
<%
String memberId = (String)session.getAttribute("memberId");
if(memberId == null) { // 로그인을 하지 않았을 때
	out.print("<script>alert('로그인을 해주세요.');location='memberLoginForm.jsp';</script>");
} 
// 로그인을 하였을 때
// DB 연동, 회원 정보를 가지고 옴.
MemberDBBean memberPro = MemberDBBean.getInstance();
MemberDataBean member = memberPro.getMember(memberId);

%>

<div id="container">
	<div id="m_title"><a href="../shop/shopMain.jsp">CHAYISH</a></div>
	<div id="s_title">회원 정보 확인</div>
	<form method="post" action="memberUpdatePro.jsp" name="updateForm">
		<table>
			<tr>
				<th width="25%">아이디</th>
				<td width="75%">
					<input type="text" name="id" size="15" value="<%=member.getId() %>" readonly><br>
					<span id="chk_id">아이디는 수정이 불가합니다.</span>
				</td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td>
					<input type="password" name="passwd" size="15" value="<%=member.getPasswd() %>"><br>
					<span id="chk_pass"></span>
				</td>
			</tr>
			<tr>
				<th>비밀번호 확인</th>
				<td>
					<input type="password" name="passwd2" size="15" value=""><br>
					<span id="chk_pass2"></span>
				</td>
			</tr>
			<tr>
				<th>이름</th>
				<td>
					<input type="text" name="name" size="15" value="<%=member.getName() %>">
				</td>
			</tr>
			<tr>
				<th>사이즈</th>
				<td>
					<select name="size">
					  <option value="" selected>선택하세요</option>
	                  <option value="6" >6</option>
	                  <option value="7">7</option>
	                  <option value="8">8</option>
	                  <option value="9">9</option>
	                  <option value="10">10</option>
	                  <option value="11">11</option>
	                  <option value="12">12</option>
	               </select>
				</td>
			</tr>
			<tr>
				<th>이메일</th>
				<td>
					<input type="text" name="email" size="30" value="<%=member.getEmail() %>"><br>
					<span id="chk_email"></span>
				</td>
			</tr>
			<tr class="address_row">
				<th>주소</th>
				<td>
					<input type="button" value="주소 찾기" id="btn_address" class="btn_chk"><br>
					<input type="text" name="address" size="45" value=""><br>
					<input type="text" name="address2" size="45" value="">
				</td>
			</tr>
			<tr>
				<th>전화번호</th>
				<td>
					<input type="text" name="tel" value="<%=member.getTel() %>"><br>
				</td>
			</tr>
		</table>
		<div id="btns">
			<input type="button" value="회원정보수정" id="btn_update">&ensp; <!-- nbsp: 1칸, ensp: 2칸, emsp: 3칸 -->
			<input type="button" value="회원탈퇴" id="btn_delete">
		</div>
	</form>
</div>

</body>
</html>
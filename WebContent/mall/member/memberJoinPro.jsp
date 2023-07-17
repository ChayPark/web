<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="mall.member.*, java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 처리 페이지</title>
</head>
<body>

<%
request.setCharacterEncoding("utf-8");

// 폼에서 오는 변수 획득
String id = request.getParameter("id");
String passwd = request.getParameter("passwd");
String name = request.getParameter("name");
String email = request.getParameter("email");
String address = request.getParameter("address");
String address2 = request.getParameter("address2");
String addr = address + " " + address2; // 완전한 주소 = 지역주소 + 상세주소
String tel = request.getParameter("tel");
Timestamp reg_date = new Timestamp(System.currentTimeMillis());

// 회원 데이터 생성
MemberDataBean member = new MemberDataBean();
member.setId(id);
member.setPasswd(passwd);
member.setName(name);
member.setEmail(email);
member.setAddress(addr);
member.setTel(tel);
member.setReg_date(reg_date);

// DB 연동, 회원추가 쿼리 실행
MemberDBBean memberPro = MemberDBBean.getInstance();
int check = memberPro.insertMember(member);
out.print("<script>");
if(check == 0) { // 회원가입 실패
	out.print("alert('회원가입에 실패하였습니다.다시 입력해 주세요.');");
	out.print("location='memberJoinForm.jsp'");
} else if(check == 1) { // 회원가입 성공
	out.print("alert('회원가입에 성공하였습니다.즐거운 쇼핑하세요.');");
	out.print("location='memberLoginForm.jsp'");
}
out.print("</script>");
%>

</body>
</html>
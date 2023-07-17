<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="mall.member.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 수정 처리</title>
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

// 회원 데이터 생성
MemberDataBean member = new MemberDataBean();
member.setId(id);
member.setPasswd(passwd);
member.setName(name);
member.setEmail(email);
member.setAddress(addr);
member.setTel(tel);

// DB 연동, 회원수정 쿼리 실행
MemberDBBean memberPro = MemberDBBean.getInstance();
int check = memberPro.updateMember(member);
out.print("<script>");
if(check == 0) { // 회원수정 실패
	out.print("alert('회원정보 수정에 실패하였습니다.다시 입력해 주세요.');");
	out.print("location='memberInfoForm.jsp'");
} else if(check == 1) { // 회원수정 성공
	out.print("alert('회원정보 수정에 성공하였습니다.즐거운 쇼핑하세요.');");
	out.print("location='memberInfoForm.jsp'");
}
out.print("</script>");
%>

</body>
</html>
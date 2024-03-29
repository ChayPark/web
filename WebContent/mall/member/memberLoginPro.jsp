<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="mall.member.*" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 처리 페이지</title>
</head>
<body>

<%
String id = request.getParameter("id");
String passwd = request.getParameter("passwd");

// DB 연동, 쿼리문 실행
// 회원인증
// x가 1일때 - 아이디가 존재, 비밀번호도 일치
// x가 0일때 - 아이디는 존재, 비밀번호가 불일치
// x가 -1일때 - 아이디가 불일치
MemberDBBean memberPro = MemberDBBean.getInstance();
int x = memberPro.userCheck(id, passwd);

if(x == 1) {
	// 세션 생성 - 회원 아이디
	session.setAttribute("memberId", id);
	session.setMaxInactiveInterval(7200); // 세션 유지시간을 2시간으로 설정, 기본값: 1800(초), 30분
	// 추가해야함 - 쇼핑몰 메인페이지로 이동
	out.print("<script>alert('" + id + "님 로그인되었습니다.');location='../shop/shopMain.jsp';</script>");
} else if(x == 0) {
	out.print("<script>alert('비밀번호가 일치하지 않습니다.');history.back();</script>");
} else if(x == -1) {
	out.print("<script>alert('아이디가 존재하지 않습니다.');history.back();</script>");
}
%>

</body>
</html>
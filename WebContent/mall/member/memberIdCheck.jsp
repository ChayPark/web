<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="mall.member.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>중복 아이디 검사 페이지</title>
</head>
<body>
<%
String id = request.getParameter("id");

//중복 아이디 체크
// x=1 : 이미 아이디 존재 			 -> 경고창 
// x=0 : 해당 아이디가 존재하지 않을 때  -> 회원가입 진행
MemberDBBean memberPro = MemberDBBean.getInstance();
int x = memberPro.confirmId(id);

out.print("<script>");
if(x == 1) {
	out.print("alert('이미 사용중인 아이디가 있습니다.다른 아이디를 입력해주세요.');");
	
} else if(x == 0) {
	out.print("alert('사용 가능한 아이디 입니다.');");
}
out.print("history.back();");
out.print("</script>");

%>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그아웃 페이지</title>
</head>
<body>

<%
//session.invalidate(); // 모든 세션 무효화
session.removeAttribute("memberId"); // memberId 세션 삭제
out.print("<script>alert('로그아웃 하였습니다.');location='../shop/shopMain.jsp';</script>");
%>
</body>
</html>
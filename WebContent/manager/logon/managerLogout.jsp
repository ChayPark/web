<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 로그아웃 처리 페이지</title>
</head>
<body>

<%
// 세션을 삭제(무효화), 둘 중 하나 사용
//session.removeAttribute("managerId");
session.invalidate();
out.print("<script>alert('로그아웃되었습니다.');location='../managerMain.jsp';</script>");
%>

</body>
</html>
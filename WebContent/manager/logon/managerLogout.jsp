<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin logout page</title>
</head>
<body>

<%
// Delete Session
//session.removeAttribute("managerId");
session.invalidate();
out.print("<script>alert('Logout successfully.');location='../managerMain.jsp';</script>");
%>

</body>
</html>

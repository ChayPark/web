<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="manager.product.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin login page</title>
</head>
<body>
<% 
request.setCharacterEncoding("utf-8");

// Checking parameter values that are coming from the login form
String managerId = request.getParameter("managerId");
String managerPasswd = request.getParameter("managerPasswd");

// DB link, query execution
// check: 1 - ID exists, correct password
// check: 0 - ID exists, incorrect password
// check: -1 - ID does not exist
ProductDBBean dbPro = ProductDBBean.getInstance();
int check = dbPro.managerCheck(managerId, managerPasswd);

if(check == 1) { 		 // Save the administrator ID to a session, and move to the administrator main page
	session.setAttribute("managerId", managerId);
	session.setMaxInactiveInterval(7200); // The duration of the session: 7200 seconds = Set to 2 hours, default time 1800 seconds = 30 minutes
	response.sendRedirect("../managerMain.jsp");
} else if(check == 0) {  // Show the notification window, and move to the previous page (login form page)
	out.print("<script>alert('Admin password is not correct.');history.back();</script>");
} else if(check == -1) { // Show the notification window, and move to the previous page (login form page)
	out.print("<script>alert('Admin ID does not exist.');history.back();</script>");
}
%>
</body>
</html>

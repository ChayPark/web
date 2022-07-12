<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="manager.product.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 로그인 처리 페이지</title>
</head>
<body>
<% 
request.setCharacterEncoding("utf-8");

// 로그인 폼에서 넘어오는 파라미터 값 확인
String managerId = request.getParameter("managerId");
String managerPasswd = request.getParameter("managerPasswd");

// DB 연동, 쿼리 실행
// check: 1 - 아이디가 존재하고 비밀번호가 일치
// check: 0 - 아이디가 존재하지만 비밀번호가 불일치
// check: -1 - 아이디가 존재하지 않을 때
ProductDBBean dbPro = ProductDBBean.getInstance();
int check = dbPro.managerCheck(managerId, managerPasswd);

if(check == 1) { 		 // 관리자 아이디를 세션으로 저장하고, 관리자 메인 페이지로 이동
	session.setAttribute("managerId", managerId);
	session.setMaxInactiveInterval(7200); // 세션의 유지시간 : 7200초 = 2시간으로 설정, 기본 시간은 1800초 = 30분 
	response.sendRedirect("../managerMain.jsp");
} else if(check == 0) {  // 알림창 띄우고, 이전 페이지(로그인 폼 페이지) 돌아감
	out.print("<script>alert('관리자 비밀번호가 일치하지 않습니다.');history.back();</script>");
} else if(check == -1) { // 알림창 띄우고, 이전 페이지(로그인 폼 페이지) 돌아감
	out.print("<script>alert('관리자 아이디가 존재하지 않습니다.');history.back();</script>");
}
%>
</body>
</html>
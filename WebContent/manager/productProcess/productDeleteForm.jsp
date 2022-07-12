<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 삭제 폼 페이지</title>
</head>
<body>

<%
String managerId = (String)session.getAttribute("managerId");
//managerId에 대한 세션값이 없을 때(로그인하지 않았을 때)
if(managerId == null) {
	response.sendRedirect("../logon/managerLoginForm.jsp");
}
//managerId에 대한 세션값이 있을 때(로그인하였을 때)


int product_id = Integer.parseInt(request.getParameter("product_id"));
String product_brand = request.getParameter("product_brand");
String pageNum = request.getParameter("pageNum");
%>
<script>
var choice = confirm("선택한 상품을 삭제하시겠습니까?");

if(choice) location="productDeletePro.jsp?product_id=<%=product_id%>&product_brand=<%=product_brand%>&pageNum=<%=pageNum%>";
else history.back(); 
</script>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="mall.member.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보 삭제</title>
</head>
<body>

<%
// 폼에서 오는 변수 획득 - id, passwd만
String id = request.getParameter("id");
String passwd = request.getParameter("passwd");


// DB 연동, 회원정보 삭제 쿼리 실행 
MemberDBBean memberPro = MemberDBBean.getInstance();
int check = memberPro.deleteMember(id, passwd);

// check : 1(아이디, 비밀번호 모두 일치), 0(아이디만 일치, 비밀번호 불일치), -1(아이디 불일치)
out.print("<script>");
if(check == 1) {
	session.removeAttribute("memberId"); // 세션 삭제 -> 회원 탈퇴를 하였으므로 세션도 삭제함 
	out.print("alert('회원탈퇴에 성공하였습니다. 다시 만나게 될 날을 기대합니다.');");
	out.print("location='../shop/shopMain.jsp';");
} else {
	out.print("alert('회원탈퇴에 실패하였습니다. 아이디와 비밀번호를 확인해주세요.');");
	out.print("location='memberInfoForm.jsp';");
}
out.print("</script>");
%>
</body>
</html>
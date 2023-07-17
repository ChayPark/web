<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="manager.product.*, java.text.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 수정 폼 페이지</title>
<style>
#container { width: 500px; margin: 20px auto;}
h3 { text-align: center;}
table { width: 100%; border: 1px solid black; border-collapse: collapse;}
th, td { border: 1px solid black;}
tr { height: 30px;}
th { background: orange; font-size: 0.8em;}
td { padding-left: 5px;}
a { text-decoration: none; color: blue; font-weight: 700;}
small { color: red; font-size: 0.7em;}
.first_row td { text-align: right; padding-right: 10px;}
.btns_row { text-align: center; height: 50px;}
.btns_row input { width: 80px; height: 30px; border: 0; background: black; color: white; 
cursor: pointer; font-weight: 700; margin: 0 5px;}
.btns_row input:hover { background: white; color: black; border: 1px solid black;}
/* number 속성에서 화살표 버튼 없애는 방법 */
input[type="number"]::-webkit-outer-spin-button, input[type="number"]::-webkit-inner-spin-button { -webkit-appearance: none; margin: 0;}
</style>
<script>
window.onload = function() {
	var updateBtn = document.getElementById("updateBtn");
	updateBtn.addEventListener("click", function() {
		var form = document.updateForm;
		
		// product_kind(select로 기본값이 선택), product_image(default 값이 설정) 
		// 2개를 제외한 8개 항목에 대한 유효성 검사
		if(!form.product_title.value) {
			alert('상품 제목을 입력하시오.');
			form.product_title.focus();
			return;
		}
		if(!form.product_price.value) {
			alert('상품 가격을 입력하시오.');
			form.product_price.focus();
			return;
		}
		if(!form.product_count.value) {
			alert('상품 수량을 입력하시오.');
			form.product_count.focus();
			return;
		}
		if(!form.author.value) {
			alert('저자를 입력하시오.');
			form.author.focus();
			return;
		}
		if(!form.publishing_com.value) {
			alert('출판사를 입력하시오.');
			form.publishing_com.focus();
			return;
		}
		if(!form.publishing_date.value) {
			alert('출판일을 입력하시오.');
			form.publishing_date.focus();
			return;
		}
		if(!form.product_image.value) {
			alert('상품 이미지를 선택하시오.');
			return;
		}
		if(!form.product_content.value) {
			alert('상품 내용을 입력하시오.');
			form.product_content.focus();
			return;
		}
		if(!form.discount_rate.value) {
			alert('할인율을 입력하시오.');
			form.discount_rate.focus();
			return;
		}
		form.submit();
	})	
}
</script>
</head>
<body>
<%
String managerId = (String)session.getAttribute("managerId");
// managerId에 대한 세션값이 없을 때(로그인하지 않았을 때)
if(managerId == null) {
	response.sendRedirect("../logon/managerLoginForm.jsp");
}
// managerId에 대한 세션값이 있을 때(로그인하였을 때)

int product_id = Integer.parseInt(request.getParameter("product_id"));
String product_kind = request.getParameter("product_kind");
String pageNum = request.getParameter("pageNum");
ProductDataBean product = new ProductDataBean();

// DB 연동, 쿼리문 실행
ProductDBBean dbPro = ProductDBBean.getInstance();
product = dbPro.getProduct(product_id);
%>
<div id="container">
	<h3>상품 수정</h3>
	<form method="post" action="productUpdatePro.jsp" name="updateForm" enctype="multipart/form-data">
	<input type="hidden" name="product_id" value="<%=product_id%>">
	<input type="hidden" name="pageNum" value="<%=pageNum%>">
	<table>
		<tr class="first_row">
			<td colspan="2"><a href="../managerMain.jsp">관리자 메인</a></td>
		</tr>
		<tr>
			<th width="25%">분류 선택</th>
			<td width="75%">
			<select name="product_kind">
				<option value="000" <%if(product_kind.equals("000")) {%>selected<%}%>>건강/취미</option>
				<option value="100" <%if(product_kind.equals("100")) {%>selected<%}%>>경제/경영</option>
				<option value="200" <%if(product_kind.equals("200")) {%>selected<%}%>>소설/시</option>
				<option value="300" <%if(product_kind.equals("300")) {%>selected<%}%>>에세이</option>
				<option value="400" <%if(product_kind.equals("400")) {%>selected<%}%>>여행</option>
				<option value="500" <%if(product_kind.equals("500")) {%>selected<%}%>>역사</option>
				<option value="600" <%if(product_kind.equals("600")) {%>selected<%}%>>예술</option>
				<option value="700" <%if(product_kind.equals("700")) {%>selected<%}%>>인문</option>
				<option value="800" <%if(product_kind.equals("800")) {%>selected<%}%>>자기계발</option>
				<option value="900" <%if(product_kind.equals("900")) {%>selected<%}%>>자연과학</option>
				<option value="910" <%if(product_kind.equals("910")) {%>selected<%}%>>유아</option>
				<option value="920" <%if(product_kind.equals("920")) {%>selected<%}%>>인물</option>
				<option value="930" <%if(product_kind.equals("930")) {%>selected<%}%>>IT</option>
			</select>
			</td>
		</tr>
		<tr>
			<th>상품 제목</th>
			<td><input type="text" name="product_title" size="40" value="<%=product.getProduct_title()%>"></td>
		</tr>
		<tr>
			<th>상품 가격</th>
			<td><input type="number" name="product_price" size="10" min="0" max="1000000" value="<%=product.getProduct_price()%>">원</td>
		</tr>
		<tr>
			<th>상품 수량</th>
			<td><input type="number" name="product_count" size="10" min="0" max="1000000" value="<%=product.getProduct_count() %>">권</td>
		</tr>
		<tr>
			<th>저자</th>
			<td><input type="text" name="author" size="40" value="<%=product.getAuthor()%>"></td>
		</tr>	
		<tr>
			<th>출판사</th>
			<td><input type="text" name="publishing_com" size="40" value="<%=product.getPublishing_com()%>"></td>
		</tr>	
		<tr>
			<th>출판일</th>
			<td><input type="date" name="publishing_date" value="<%=product.getPublishing_date()%>"></td>
		</tr>
		<tr>
			<th>상품 이미지</th>
			<td><input type="file" name="product_image"><br><small>상품 이미지 파일을 다시 선택해 주세요.</small></td>
		</tr>
		<tr>
			<th>상품 내용</th>
			<td><textarea name="product_content" rows="13" cols="48"><%=product.getProduct_content() %></textarea></td>
		</tr>	
		<tr>
			<th>할인율</th>
			<td><input type="number" name="discount_rate" size="5" min="0" max="99" value="<%=product.getDiscount_rate()%>">%</td>
		</tr>
		<tr class="btns_row">
			<td colspan="2">
				<input type="button" value="상품 수정" id="updateBtn">
				<input type="reset" value="다시 입력">
				<input type="button" value="상품 목록" onclick="location='productList.jsp?product_kind=<%=product_kind%>&pageNum=<%=pageNum%>'">
			</td>
		</tr>
	</table>
	</form>
</div>

</body>
</html>
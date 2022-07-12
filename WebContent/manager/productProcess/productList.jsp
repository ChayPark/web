<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.text.*, java.util.*, manager.product.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 목록 전체 보기</title>
<style>
#container { width: 1200px; margin: 20px auto; font-size: 0.8em;}
h2 { text-align: center; border-radius: 5em; padding: 0.5em; background: #9db5e8; color: white; font-size: 2em;}
p { text-align: right; }
table { width: 100%; border: 1px solid #1e6793; border-collapse: collapse;}
th, td { border: 1px solid #1e6793;}
th { background: #9db5e8; opacity: 0.8;}
tr { height: 30px;}
a { text-decoration: none; color: black;}
input[type="button"] { width: 90px; height: 25px; background: #b8d6f0; color: white; border: 0; cursor: pointer;} 
input[type="button"]:hover { background: #cdc8da; color: black; border: 1px solid black;}
.center { text-align: center; font-weight: 700;}
.left { text-align: left; padding-left: 10px;}
.right { text-align: right; padding-right: 10px;}
/* paging 처리 css */
#paging { text-align: center; margin-top: 10px;}
#pbox { width: 25px; height: 25px; border: 1px solid #cdc8da; display: inline-block; 
margin: 2px; font-size: 0.7em; line-height: 25px; border-radius: 50%;}
#pbox:hover { background: #9db5e8; color: white; opacity: 0.5;}
.pbox_current { background: #9db5e8; color: white; border: none;}

</style>
<script>
window.onload = function() {
	var p_brand = document.getElementById("product_brand");
	p_brand.addEventListener("change", function() {
		location = 'productList.jsp?product_brand=' + p_brand.value + '&pageNum=1';
		
		// 반복문 동작 여부 확인(작동 안됨)
		/*
		for(var i=0; i<p_kind.options.length; i++) {
			if(p_kind.options[i].value == p_value) {
				p_kind.options[i].selected = true;
			}
		}
		*/
	})
	
}

function changeUpdateIconOn(obj) {
	obj.src = "../../icons/update_on.png";
}
function changeUpdateIconOff(obj) {
	obj.src = "../../icons/update_off.png";
}
function changeDeleteIconOn(obj) {
	obj.src = "../../icons/delete_on.png";
}
function changeDeleteIconOff(obj) {
	obj.src = "../../icons/delete_off.png";
}
</script>

</head>
<body>
<%
String managerId = (String)session.getAttribute("managerId");
// 로그인하지 않았을 때
if(managerId == null) {
	response.sendRedirect("../logon/managerLoginForm.jsp");	
}
// 로그인하였을 때
String product_brand = request.getParameter("product_brand");
String product_model = request.getParameter("product_model");
if(product_brand == null) product_brand = "all";
DecimalFormat df = new DecimalFormat("#,###,###");
List<ProductDataBean> productList = null;
int number = 0; // 상번 번호(1씩 증가하는)

// 상품 분류별 구분
// product_brand : nike(나이키), adidas(아디다스), jordan(조던), yeezy(이지부스트), Collaboration(콜라보), all(전체 상품) 문자열
String product_brandName = "";
switch(product_brand) {
case "NIKE": product_brandName = "나이키"; break;
case "ADIDAS": product_brandName = "아디다스"; break;
case "JORDAN": product_brandName = "에어 조던"; break;
case "YEEZY": product_brandName = "이지부스트"; break;
case "COLLAB": product_brandName = "콜라보"; break;
case "all": product_brandName = "전체"; break;
}

///////////////////////////////////////////////////////////////////////
// paging 처리를 위한 변수 
int pageSize = 10; // 1page에 10개의 상품을 보여줌 
String pageNum = request.getParameter("pageNum");
if(pageNum == null) pageNum = "1";

int currentPage = Integer.parseInt(pageNum);	 // 현재 페이지
int startRow = (currentPage - 1) * pageSize + 1; // 현재 페이지에서 보여줄 첫번째 행 
int endRow = currentPage * pageSize; 			 // 현재 페이지에서 마지막 행 

// 등록된 상품이 있을 때, 등록된 상품 10개를 ArrayList에 받아둔다.
//limit startRow, pageSize(10건으로 설정)
//DB 연동, 전체 상품수 조회
ProductDBBean dbPro = ProductDBBean.getInstance();
int count = dbPro.getProductCount(product_brand); // 전체 상품 수 또는 분류별 전체 상품수 

if(count > 0) productList = dbPro.getProducts(product_brand, startRow, pageSize); 

number = count - (currentPage-1)*pageSize;// 전체 글 수의 역순 번호 

%>
<%-- 상품 분류
product_brand : nike(나이키), adidas(아디다스), jordan(조던), yeezy(이지부스트), Collaboration(콜라보), all(전체 상품) 문자열

--%>
<div id="container">
	<h2><%=product_brandName %> 상품 목록 (<span><%=count %>개</span>)</h2>
	<p>	
		상품 분류 선택 : 
		<select name="product_brand" id="product_brand">
			<option value="all" <%if(product_brand.equals("all")) {%> selected <%} %>>전체</option>
			<option value="NIKE" <%if(product_brand.equals("NIKE")) {%> selected <%} %>>나이키</option>
			<option value="ADIDAS" <%if(product_brand.equals("ADIDAS")) {%> selected <%} %>>아디다스</option>
			<option value="JORDAN" <%if(product_brand.equals("JORDAN")) {%> selected <%} %>>조던</option>
			<option value="YEEZY" <%if(product_brand.equals("YEEZY")) {%> selected <%} %>>이지</option>
			<option value="COLLAB" <%if(product_brand.equals("COLLAB")) {%> selected <%} %>>콜라보</option>
		</select>&nbsp;&nbsp;&nbsp;
		<input type="button" value="상품 등록" onclick="location='productRegisterForm.jsp'">
	</p>
	<table>
		<tr>
			<th width="7%">번호</th>
			<th width="5%">브랜드</th>
			<th width="12%">컬렉션</th>
			<th width="21%">상품 이름</th>
			<th width="12%">상품 이미지</th>
			<th width="8%">가격</th>
			<th width="7%">수량</th>
			<th width="7%">사이즈</th>
			<th width="13%">출시일</th>
			<th width="17%"><small>수정/삭제</small></th>
		</tr>
		<%
		if(count == 0) { 
			out.print("<tr><td colspan='12' class='center'>등록된 상품이 없습니다.</td></tr>");
		} else {
			for(ProductDataBean product : productList) {
				int p_id = product.getProduct_id();
				String p_brand = product.getProduct_brand();
				switch(p_brand) {
				case "NIKE": product_brandName = "나이키"; break;
				case "ADIDAS": product_brandName = "아디다스"; break;
				case "JORDAN": product_brandName = "조던"; break;
				case "YEEZY": product_brandName = "이지"; break;
				case "COLLAB": product_brandName = "콜라보"; break;
				case "all": product_brandName = "전체"; break;
				}
				
		%>
		<tr>
			<td class="center"><%=number-- %></td>
			<td class="center"><%=product_brandName %></td>
			<td class="center"><%=product.getProduct_model() %></td>
			<td class="left">
				<a href="productContent.jsp?product_id=<%=p_id%>&product_brand=<%=p_brand%>&pageNum=<%=pageNum%>"><%=product.getProduct_title() %></a></td>
			<td class="center">
				<a href="productContent.jsp?product_id=<%=p_id%>&product_brand=<%=p_brand%>&pageNum=<%=pageNum%>"><img src=<%="/images_shoes21/" + product.getProduct_image() %> width="40"></a></td>
			<td class="right"><%=df.format(product.getProduct_price()) %>$</td>
			<td class="right"><%=df.format(product.getProduct_count()) %>개</td>
			<td class="center"><%=product.getProduct_size() %></td>
			<td class="center"><%=product.getProduct_date() %></td>
			<td class="center">
				<a href="productUpdateForm.jsp?product_id=<%=p_id%>&product_brand=<%=p_brand%>&pageNum=<%=pageNum%>"><img src="../../icons/update_off.png" width="25" 
				id="update_icon" onmouseover="changeUpdateIconOn(this);" onmouseout="changeUpdateIconOff(this);"></a>&nbsp;
				<a href="productDeleteForm.jsp?product_id=<%=p_id%>&product_brand=<%=p_brand%>&pageNum=<%=pageNum%>"><img src="../../icons/delete_off.png" width="25" 
				id="delete_icon" onmouseover="changeDeleteIconOn(this);" onmouseout="changeDeleteIconOff(this);"></a>
			</td>
		</tr>
		<%
			}
		}
		%>
	</table>
	
<div id="paging">
	
<%
// 페이징 처리 
// count : 전체 상품 수, kind_count : 전체 상품수 또는 분류별 상품 수
if(count > 0) {
	int pageCount = count / pageSize + (count%pageSize == 0 ? 0 : 1); // 전체 페이지 수 
	int startPage = 1;  // 시작 페이지 번호 
	int pageBlock = 10; // 페이징의 개수 
	
	// 시작페이지 설정
	if(currentPage % 10 != 0) startPage = (int)(currentPage/10)*10 + 1;
	else startPage = (int)(currentPage/10-1)*10 + 1;
	
	// 끝페이지 설정 
	int endPage = startPage + pageBlock - 1;
	if(endPage > pageCount) endPage = pageCount;
	
	// 이전 페이지 처리 
	if(startPage > 10) {
		out.print("<a href='productList.jsp?product_brand="+product_brand+"&pageNum="+(startPage-10)+"'><div id='pbox'>◀</div></a>");
	}
	
	// 페이징 블록 처리 -> 현재 페이지 하이퍼링크 없애기 
	for(int i=startPage; i<=endPage; i++) {
		if(i == currentPage) { // i가 현재 페이지 일 때(이동이 되지 않음) 
			out.print("<div id='pbox' class='pbox_current'>"+i +"</div>");
		} else { // i가 현재 페이지가 아닐 때(이동함)
			out.print("<a href='productList.jsp?product_brand="+product_brand+"&pageNum="+i+"'><div id='pbox'>" + i + "</div></a>");
		}
		
		
	}
	// 다음 페이지에 관한 처리 
	if(endPage < pageCount) {
		out.print("<a href='productList.jsp?product_brand="+product_brand+"&pageNum="+(startPage+10) + "'><div id='pbox'>▶</div></a>");
	}
}
%>
	</div> <%-- paging --%>

</div> <%--container --%>


</body>
</html>
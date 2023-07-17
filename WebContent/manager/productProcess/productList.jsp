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
h2 { text-align: center;}
p { text-align: right;}
table { width: 100%; border: 1px solid black; border-collapse: collapse;}
th, td { border: 1px solid black;}
th { background: orange; opacity: 0.8;}
tr { height: 30px;}
a { text-decoration: none; color: blue;}
input[type="button"] { width: 90px; height: 25px; background: black; color: white; border: 0; cursor: pointer;} 
input[type="button"]:hover { background: white; color: black; border: 1px solid black;}
.center { text-align: center; font-weight: 700;}
.left { text-align: left; padding-left: 10px;}
.right { text-align: right; padding-right: 10px;}
/* paging 처리 css */
#paging { text-align: center; margin-top: 10px;}
#pbox { width: 25px; height: 25px; border: 1px solid gray; display:inline-block;
margin: 2px; font-size: 0.7em; line-height: 25px; border-radius: 50%;}
#pbox:hover { background: orange; color:white; opacity: 0.5;}
.pbox_current { background: orange; color: white; border: none;}
</style>
<script>
window.onload = function() {
	var p_kind = document.getElementById("product_kind");
	p_kind.addEventListener("change", function() {
		location = 'productList.jsp?product_kind=' + p_kind.value + '&pageNum=1';	
		/* 반복문 동작 여부 확인(작동 안됨)
		for(var i=0; i<p_kind.options.length; i++) {
			if(p_kind.options[i].value == p_value) {
				p_kind.options[i].selected = true;
			}
		}
		*/
	})
}

function changeIconOn(obj, i) {
	if(i == 1) obj.src = "../../icons/update_on.png";
	else if(i == 2) obj.src = "../../icons/delete_on.png";
}

function changeIconOff(obj, i) {
	if(i == 1) obj.src = "../../icons/update_off.png";
	else if(i == 2) obj.src = "../../icons/delete_off.png";
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
String product_kind = request.getParameter("product_kind");
if(product_kind == null) product_kind = "all";
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
DecimalFormat df = new DecimalFormat("#,###,###");
List<ProductDataBean> productList = null;
int number = 0; // 상품 번호(1씩 증가하는)

// 상품 분류별 구분
// product_kind : 000, 100, 200 ... 900, 910, 920, 930 문자열
String product_kindName = "";
switch(product_kind) {
case "000": product_kindName = "건강/취미"; break;
case "100": product_kindName = "경제/경영"; break;
case "200": product_kindName = "소설/시"; break;
case "300": product_kindName = "에세이"; break;
case "400": product_kindName = "여행"; break;
case "500": product_kindName = "역사"; break;
case "600": product_kindName = "예술"; break;
case "700": product_kindName = "인문"; break;
case "800": product_kindName = "자기계발"; break;
case "900": product_kindName = "자연과학"; break;
case "910": product_kindName = "유아"; break;
case "920": product_kindName = "인물"; break;
case "930": product_kindName = "IT"; break;
case "all": product_kindName = "전체"; break;
}

//////////////////////////////

// 페이징(paging) 처리를 위한 변수
int pageSize = 10; // 1page에 10개의 상품을 보여줌
String pageNum = request.getParameter("pageNum");
if(pageNum == null) pageNum = "1";

int currentPage = Integer.parseInt(pageNum);     // 현재 페이지
int startRow = (currentPage - 1) * pageSize + 1; // 현재 페이지에서 보여줄 첫번째 행
int endRow = currentPage * pageSize;             // 현재 페이지에서 마지막 행

// 등록된 상품이 있을 때, 등록된 상품 10개를 ArrayList에 받아둠.
// limit startRow, pageSize(10건으로 설정)
// DB 연동, 전체 상품수 조회
ProductDBBean dbPro = ProductDBBean.getInstance();
int count = dbPro.getProductCount(product_kind); // 전체 상품수 또는 분류별 전체 상품수

if(count > 0) productList = dbPro.getProducts(product_kind, startRow, pageSize); 

number = count - (currentPage-1) * pageSize; // 전체 글수 역순 번호
%>
<%-- 상품 분류
000 건강/취미, 100 경제/경영, 200 소설/시, 300 에세이, 400 여행
500 역사, 600 예술, 700 인문, 800 자기계발, 900 자연과학, 910 유아, 920 인물, 930 IT
--%>
<div id="container">
	<h2><%=product_kindName %> 상품 목록 (<span><%=count %>개</span>)</h2>
	<p>	
		상품 분류 선택 : 
		<select id="product_kind">
			<option value="all" <%if(product_kind.equals("all")) {%> selected <%} %>>전체</option>
			<option value="000" <%if(product_kind.equals("000")) {%> selected <%} %>>건강/취미</option>
			<option value="100" <%if(product_kind.equals("100")) {%> selected <%} %>>경제/경영</option>
			<option value="200" <%if(product_kind.equals("200")) {%> selected <%} %>>소설/시</option>
			<option value="300" <%if(product_kind.equals("300")) {%> selected <%} %>>에세이</option>
			<option value="400" <%if(product_kind.equals("400")) {%> selected <%} %>>여행</option>
			<option value="500" <%if(product_kind.equals("500")) {%> selected <%} %>>역사</option>
			<option value="600" <%if(product_kind.equals("600")) {%> selected <%} %>>예술</option>
			<option value="700" <%if(product_kind.equals("700")) {%> selected <%} %>>인문</option>
			<option value="800" <%if(product_kind.equals("800")) {%> selected <%} %>>자기계발</option>
			<option value="900" <%if(product_kind.equals("900")) {%> selected <%} %>>자연과학</option>	
			<option value="910" <%if(product_kind.equals("910")) {%> selected <%} %>>유아</option>	
			<option value="920" <%if(product_kind.equals("920")) {%> selected <%} %>>인물</option>	
			<option value="930" <%if(product_kind.equals("930")) {%> selected <%} %>>IT</option>	
		</select>&nbsp;&nbsp;&nbsp;
		<input type="button" value="관리자 메인" onclick="location='../managerMain.jsp'">&nbsp;&nbsp;&nbsp;
		<input type="button" value="상품 등록" onclick="location='productRegisterForm.jsp'">
	</p>
	<table>
		<tr>
			<th width="5%">번호</th>
			<th width="6%">분류</th>
			<th width="19%">상품 제목</th>
			<th width="8%">상품 이미지</th>
			<th width="6%">가격</th>
			<th width="5%">수량</th>
			<th width="12%">저자</th>
			<th width="12%">출판사</th>
			<th width="8%">출판일</th>
			<th width="5%">할인율</th>
			<th width="8%">등록일</th>
			<th width="6%"><small>수정/삭제</small></th>
		</tr>
		<%
		if(count == 0) { 
			out.print("<tr><td colspan='12' class='center'>등록된 상품이 없습니다.</td></tr>");
		} else {
			for(ProductDataBean product : productList) {
				int p_id = product.getProduct_id();
				String p_kind = product.getProduct_kind();
				switch(p_kind) {
				case "000": product_kindName = "건강/취미"; break;
				case "100": product_kindName = "경제/경영"; break;
				case "200": product_kindName = "소설/시"; break;
				case "300": product_kindName = "에세이"; break;
				case "400": product_kindName = "여행"; break;
				case "500": product_kindName = "역사"; break;
				case "600": product_kindName = "예술"; break;
				case "700": product_kindName = "인문"; break;
				case "800": product_kindName = "자기계발"; break;
				case "900": product_kindName = "자연과학"; break;
				case "910": product_kindName = "유아"; break;
				case "920": product_kindName = "인물"; break;
				case "930": product_kindName = "IT"; break;
				case "all": product_kindName = "전체"; break;
				}
		%>
		<tr>
			<td class="center"><%=number-- %></td>
			<td class="center"><%=product_kindName %></td>
			<td class="left">
				<a href="productContent.jsp?product_id=<%=p_id%>&product_kind=<%=p_kind%>&pageNum=<%=pageNum%>"><%=product.getProduct_title() %></a></td>
			<td class="center">
				<a href="productContent.jsp?product_id=<%=p_id%>&product_kind=<%=p_kind%>&pageNum=<%=pageNum%>"><img src=<%="/images_mall21/" + product.getProduct_image() %> width="40"></a></td>
			<td class="right"><%=df.format(product.getProduct_price()) %></td>
			<td class="right"><%=df.format(product.getProduct_count()) %></td>
			<td class="left"><%=product.getAuthor() %></td>
			<td class="left"><%=product.getPublishing_com() %></td>
			<td class="center"><%=product.getPublishing_date() %></td>
			<td class="right"><%=product.getDiscount_rate() %>%</td>
			<td class="center"><%=product.getReg_date() %></td>
			<td class="center">
				<a href="productUpdateForm.jsp?product_id=<%=p_id%>&product_kind=<%=p_kind%>&pageNum=<%=pageNum%>"><img src="../../icons/update_off.png" width="25" 
				onmouseover="changeIconOn(this, 1);" onmouseout="changeIconOff(this, 1);"></a>&nbsp;
				<a href="productDeleteForm.jsp?product_id=<%=p_id%>&product_kind=<%=p_kind%>&pageNum=<%=pageNum%>"><img src="../../icons/delete_off.png" width="25" 
				onmouseover="changeIconOn(this, 2);" onmouseout="changeIconOff(this, 2);"></a>
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
// count: 전체 상품수, kind_count: 전체 상품수 또는 분류별 전체 상품수
if(count > 0) {
	int pageCount = count / pageSize + (count%pageSize==0 ? 0 : 1); // 전체 페이지수
	int startPage = 1;  // 시작 페이지 번호
	int pageBlock = 10; // 페이징의 개수
	
	// 시작 페이지 설정
	if(currentPage % 10 != 0) startPage = (currentPage/10)*10 + 1;
	else startPage = (currentPage/10-1)*10 + 1;
	
	// 끝 페이지 설정
	int endPage = startPage + pageBlock -1;
	if(endPage > pageCount) endPage = pageCount;
	
	// 이전 페이지 처리
	if(startPage > 10) {
		out.print("<a href='productList.jsp?product_kind="+product_kind+"&pageNum="+(startPage-10)+"'><div id='pbox'>◀</div></a>");
	}
	
	// 페이징 블록 처리
	for(int i=startPage; i<=endPage; i++) {
		if(i == currentPage) { // i가 현재 페이지 일때 (이동이 되지 않음)
			out.print("<div id='pbox' class='pbox_current'>"+i+"</div>");
		} else { // i가 현재 페이지가 아닐때 (이동함) 
			out.print("<a href='productList.jsp?product_kind="+product_kind+"&pageNum="+i+"'><div id='pbox'>" + i + "</div></a>");
		}
	}
	
	// 다음 페이지 처리
	if(endPage < pageCount) {
		out.print("<a href='productList.jsp?product_kind="+product_kind+"&pageNum="+(startPage+10)+"'><div id='pbox'>▶</div></a>");
	}
}
%>
	</div> <%-- paging --%>	
</div> <%-- container --%>

</body>
</html>
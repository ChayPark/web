<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.text.*, java.util.*, manager.product.*" %>

<style>
/* 전체보기 또는 분류별 전체 보기 css */
.p_kind1 { float: left; color: purple; margin-left: 30px; font-size: 1.2em; font-weight: bold; width: 300px;}
.p_kind2 { float: right; margin-right: 30px; font-size: 1.1em; width: 230px;}
.d_clear { clear: both; width: 100px; height: 10px; padding: 10px; margin-left: 1010px;}
.box { display: inline-block; float: left; border: 1px solid lightgray; height: 350px;
padding: 10px; margin: 10px 25px;}
.box:hover { background: rgba(0,0,0,0.3);}
span { display: inline-block; width: 200px; font-size: 0.8em;}
a { text-decoration: none; color: black;}
.p_image { transition: all 1s ease;}
.p_image:hover { transform: scale(1.1, 1.1);}
.p_title { color: navy;}
.p_title, .p_price { font-weight: bold;}

/* paging 처리 css */
#paging { text-align: center; margin-top: 10px; clear: both;}
#pbox { width: 25px; height: 25px; border: 1px solid gray; display:inline-block;
margin: 2px; font-size: 0.7em; line-height: 25px; border-radius: 50%;}
#pbox:hover { background: orange; color:white; opacity: 0.5;}
.pbox_current { background: orange; color: white; border: none;}
</style>

<script>
window.onload = function() {
	var p_kind = document.getElementById("product_kind");
	p_kind.addEventListener("change", function() {
		location = 'shopMain.jsp?product_kind=' + p_kind.value + '&pageNum=1#p_kind';	
	})
}
</script>

<%-- shopMain.jsp에 include 되는 페이지 --%>
<%-- 전체 상품 또는 분류별 상품 보기 페이지, 신상품, 베스트셀러, 추천상품 : jQuery plug-in을 사용 (slider, carousel) --%>
<%
String product_kind = request.getParameter("product_kind");
if(product_kind == null) product_kind = "all";
//SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
DecimalFormat df = new DecimalFormat("#,###,###");
List<ProductDataBean> productList = null;

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

// 페이징(paging) 처리를 위한 변수
int pageSize = 12; // 1page에 12개의 상품을 보여줌
String pageNum = request.getParameter("pageNum");
if(pageNum == null) pageNum = "1";

int currentPage = Integer.parseInt(pageNum);     // 현재 페이지
int startRow = (currentPage - 1) * pageSize + 1; // 현재 페이지에서 보여줄 첫번째 행
int endRow = currentPage * pageSize;             // 현재 페이지에서 마지막 행

// DB 연동, 전체 상품수 조회
// 전체 상품 또는 분류별 전체 상품
// 등록된 상품이 있을 때, 등록된 상품 10개를 ArrayList에 받아둠.
// limit startRow, pageSize(10건으로 설정)
ProductDBBean productPro = ProductDBBean.getInstance();
int count = productPro.getProductCount(product_kind); // 전체 상품수 또는 분류별 전체 상품수
if(count > 0) productList = productPro.getProducts(product_kind, startRow, pageSize); 
int pageCount = count / pageSize + (count%pageSize==0 ? 0 : 1); // 전체 페이지수
%>

<%-- 1. 상품 전체 또는 분류별 보기 (4개씩 3단으로 구성), 페이징 처리 --%>
<div class="p_kind" id="p_kind">
	<span class="p_kind1"><%=product_kindName %> 분야 상품 목록</span>
	<span class="p_kind2">	
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
		</select>
	</span>
</div>
<div class="d_clear"><%=pageNum %> / <%=pageCount %></div>
<div>
<%for(ProductDataBean product : productList) {
	int price = product.getProduct_price();
	int discount = product.getDiscount_rate();
	int salePrice = price - (price*discount/100);%>
	<a href="shopContent.jsp?product_id=<%=product.getProduct_id()%>">
	<div class="box">
		<img src=<%="/images_mall21/"+product.getProduct_image()%> width="200" height="280" class="p_image"><br>
		<span class="p_title"><%=product.getProduct_title() %></span><br>
		<span class="p_author"><%=product.getAuthor() %></span><br>
		<span class="p_price"><%=df.format(salePrice) %>원 (<%=discount%>%할인)</span>
	</div>
	</a>
<%} %>
</div>

<div id="paging">
<%
// 페이징 처리
// count: 전체 상품수, kind_count: 전체 상품수 또는 분류별 전체 상품수
if(count > 0) {
	//int pageCount = count / pageSize + (count%pageSize==0 ? 0 : 1); // 전체 페이지수
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
		out.print("<a href='shopMain.jsp?product_kind="+product_kind+"&pageNum="+(startPage-10)+"'><div id='pbox'>◀</div></a>");
	}
	
	// 페이징 블록 처리
	for(int i=startPage; i<=endPage; i++) {
		if(i == currentPage) { // i가 현재 페이지 일때 (이동이 되지 않음)
			out.print("<div id='pbox' class='pbox_current'>"+i+"</div>");
		} else { // i가 현재 페이지가 아닐때 (이동함) 
			out.print("<a href='shopMain.jsp?product_kind="+product_kind+"&pageNum="+i+"'><div id='pbox'>" + i + "</div></a>");
		}
	}
	
	// 다음 페이지 처리
	if(endPage < pageCount) {
		out.print("<a href='shopMain.jsp?product_kind="+product_kind+"&pageNum="+(startPage+10)+"'><div id='pbox'>▶</div></a>");
	}
}
%>
</div> <%-- paging --%>	
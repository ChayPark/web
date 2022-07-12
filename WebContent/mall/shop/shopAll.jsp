<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.text.*, java.util.*, manager.product.*" %>
<style>
/* 전체보기 또는 분류별 전체 보기 css */
.p_brand1 { float: left; color: purple; margin-left: 30px; font-size: 1.2em; font-weight: bold; width: 500px;}
.p_brand2 { float: right; margin-right: -60px; font-size: 1.1em; width: 500px;}
.d_clear { clear: both; width: 100px; height: 10px; padding: 10px; margin-left: 1010px;}
.box { display: inline-block; float: left; border: 1px solid lightgray; height: 280px;
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
#pbox { width: 25px; height: 25px; border: 1px solid #adb5bd; display:inline-block;
margin: 2px; font-size: 0.7em; line-height: 25px; border-radius: 50%;}
#pbox:hover { background: #adb5bd; color:white; opacity: 0.5;}
.pbox_current { background: #adb5bd; color: black; border: none;}
</style>

<script>
window.onload = function() {
	var p_brand = document.getElementById("product_brand");
	p_brand.addEventListener("change", function() {
		location = 'shopMain.jsp?product_brand=' + p_brand.value + '&pageNum=1#p_brand';	
	})
}

/*중분류*/
function categoryChange(e) {
	var all=["all"];
	var NIKE=["DUNK", "AIR MAX", "AIR FORCE", "VAPOR MAX"];
	var ADIDAS=["ULTRA BOOST", "NMD", "PHARRELL"];
	var JORDAN=["AIR JORDAN 1", "AIR JORDAN 2", "AIR JORDAN 3", "AIR JORDAN 4", "AIR JORDAN 5", "AIR JORDAN 6", "AIR JORDAN 7", "AIR JORDAN 8", "AIR JORDAN 9", "AIR JORDAN 10", "AIR JORDAN 11", "AIR JORDAN 12", "AIR JORDAN 13", "AIR JORDAN 14"];
	var YEEZY=["YEEZY BOOST 350", "YEEZY BOOST 380", "YEEZY BOOST 500", "YEEZY BOOST 700", "YEEZY BOOST 750"];
	var COLLAB=["CANVAS", "OFF-WHITE", "VANS"];
	var target = document.getElementById("model");
	
	if(e.value == "all") var d = all;
	else if(e.value == "NIKE") var d = NIKE;
	else if(e.value == "ADIDAS") var d = ADIDAS;
	else if(e.value == "JORDAN") var d = JORDAN;
	else if(e.value == "YEEZY") var d = YEEZY;
	else if(e.value == "COLLAB") var d = COLLAB;
		
	target.options.length = 0;
		
	for (x in d) {
		var opt = document.createElement("option");
		opt.value = d[x];
		opt.innerHTML = d[x];
		target.appendChild(opt);
	}	

} 
</script>

<%-- shopMain.jsp에 include 되는 페이지 --%>
<%-- 전체 상품 또는 분류별 상품 보기 페이지, 신상품, 베스트셀러, 추천상품 : jQuery plug-in을 사용 (slider, carousel) --%>
<%
String product_brand = request.getParameter("product_brand");
if(product_brand == null) product_brand = "all";
DecimalFormat df = new DecimalFormat("#,###,###");
List<ProductDataBean> productList = null;

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
int count = productPro.getProductCount1(product_brand); // 전체 상품수 또는 분류별 전체 상품수
if(count > 0) productList = productPro.getProducts1(product_brand, startRow, pageSize); 
int pageCount = count / pageSize + (count%pageSize==0 ? 0 : 1); // 전체 페이지수
%>

<%-- 1. 상품 전체 또는 분류별 보기 (4개씩 3단으로 구성), 페이징 처리 --%>
<div class="p_brand" id="p_brand">
	<span class="p_brand1"><%=product_brandName %> 상품 목록</span>
	<span class="p_brand2">	
		상품 분류 선택 : 
		<!-- onchange="categoryChange(this)" -->
		<select name="product_brand" onchange="categoryChange(this)">
			<option value="all" <%if(product_brand.equals("all")) {%> selected <%} %>>전체</option>
			<option value="NIKE" <%if(product_brand.equals("NIKE")) {%> selected <%} %>>나이키</option>
			<option value="ADIDAS" <%if(product_brand.equals("ADIDAS")) {%> selected <%} %>>아디다스</option>
			<option value="JORDAN" <%if(product_brand.equals("JORDAN")) {%> selected <%} %>>조던</option>
			<option value="YEEZY" <%if(product_brand.equals("YEEZY")) {%> selected <%} %>>이지</option>
			<option value="COLLAB" <%if(product_brand.equals("COLLAB")) {%> selected <%} %>>콜라보</option>	
		</select>
		세부 분류 선택 :
		<select name="product_model" id="model">
				<option>전체</option>
				<option></option>
				
		</select>
	</span>
</div>
<div class="d_clear"><%=pageNum %> / <%=pageCount %></div>
<div>
<%for(ProductDataBean product : productList) {
	int price = product.getProduct_price(); %>
	<a href="shopContent.jsp?product_id=<%=product.getProduct_id()%>">
	<div class="box">
		<img src=<%="/images_shoes21/"+product.getProduct_image()%> width="200" height="180" class="p_image"><br>
		<span class="p_title"><%=product.getProduct_title() %></span><br>
		<span class="p_brand"><%=product.getProduct_brand() %></span><br>
		<span class="p_price"><%=df.format(price) %>$ </span>
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
		out.print("<a href='shopMain.jsp?product_brand="+product_brand+"&pageNum="+(startPage-10)+"'><div id='pbox'>◀</div></a>");
	}
	
	// 페이징 블록 처리
	for(int i=startPage; i<=endPage; i++) {
		if(i == currentPage) { // i가 현재 페이지 일때 (이동이 되지 않음)
			out.print("<div id='pbox' class='pbox_current'>"+i+"</div>");
		} else { // i가 현재 페이지가 아닐때 (이동함) 
			out.print("<a href='shopMain.jsp?product_brand="+product_brand+"&pageNum="+i+"'><div id='pbox'>" + i + "</div></a>");
		}
	}
	
	// 다음 페이지 처리
	if(endPage < pageCount) {
		out.print("<a href='shopMain.jsp?product_brand="+product_brand+"&pageNum="+(startPage+10)+"'><div id='pbox'>▶</div></a>");
	}
}
%>
</div> <%-- paging --%>	
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.text.*, java.util.*, manager.product.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>View the entire list of products</title>
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
// Not log-in
if(managerId == null) {
	response.sendRedirect("../logon/managerLoginForm.jsp");	
}
// log-in
String product_brand = request.getParameter("product_brand");
String product_model = request.getParameter("product_model");
if(product_brand == null) product_brand = "all";
DecimalFormat df = new DecimalFormat("#,###,###");
List<ProductDataBean> productList = null;
int number = 0; // Product number(increased by 1)

// classification by product classification
// product_brand : nike, adidas, jordan, yeezy, Collaboration, all(entire products)
String product_brandName = "";
switch(product_brand) {
case "NIKE": product_brandName = "Nike"; break;
case "ADIDAS": product_brandName = "Adidas"; break;
case "JORDAN": product_brandName = "Air Jordan"; break;
case "YEEZY": product_brandName = "Yeezy Boost"; break;
case "COLLAB": product_brandName = "Collaboration"; break;
case "all": product_brandName = "Entire products"; break;
}

///////////////////////////////////////////////////////////////////////
// variable for paging
int pageSize = 10; // showing the 10 products for each page
String pageNum = request.getParameter("pageNum");
if(pageNum == null) pageNum = "1";

int currentPage = Integer.parseInt(pageNum);	 // current page
int startRow = (currentPage - 1) * pageSize + 1; // first row for current page 
int endRow = currentPage * pageSize; 			 // last row for current page 

// When there are registered products, 10 registered products are received in ArrayList.
//limit startRow, pageSize(10)
//DB link, total product number inquiry
ProductDBBean dbPro = ProductDBBean.getInstance();
int count = dbPro.getProductCount(product_brand); // Total number of goods or total number of goods by classification

if(count > 0) productList = dbPro.getProducts(product_brand, startRow, pageSize); 

number = count - (currentPage-1)*pageSize;// reverse number of total number of texts

%>
<%-- product classification
product_brand : nike, adidas, jordan, yeezy, Collaboration, all(entire products)

--%>
<div id="container">
	<h2><%=product_brandName %> Product List (<span><%=count %>qty</span>)</h2>
	<p>	
		product classification selection : 
		<select name="product_brand" id="product_brand">
			<option value="all" <%if(product_brand.equals("all")) {%> selected <%} %>>ALL</option>
			<option value="NIKE" <%if(product_brand.equals("NIKE")) {%> selected <%} %>>NIKE</option>
			<option value="ADIDAS" <%if(product_brand.equals("ADIDAS")) {%> selected <%} %>>ADIDAS</option>
			<option value="JORDAN" <%if(product_brand.equals("JORDAN")) {%> selected <%} %>>JORDAN</option>
			<option value="YEEZY" <%if(product_brand.equals("YEEZY")) {%> selected <%} %>>YEEZY</option>
			<option value="COLLAB" <%if(product_brand.equals("COLLAB")) {%> selected <%} %>>COLLAB</option>
		</select>&nbsp;&nbsp;&nbsp;
		<input type="button" value="Product Registeration" onclick="location='productRegisterForm.jsp'">
	</p>
	<table>
		<tr>
			<th width="7%">NO</th>
			<th width="5%">BRAND</th>
			<th width="12%">COLLECTION</th>
			<th width="21%">PRODUCT NAME</th>
			<th width="12%">PRODUCT IMAGE</th>
			<th width="8%">PRICE</th>
			<th width="7%">QTY</th>
			<th width="7%">SIZE</th>
			<th width="13%">REALEASE DATE</th>
			<th width="17%"><small>MODIFICATION/DELETION</small></th>
		</tr>
		<%
		if(count == 0) { 
			out.print("<tr><td colspan='12' class='center'>No registered product exists.</td></tr>");
		} else {
			for(ProductDataBean product : productList) {
				int p_id = product.getProduct_id();
				String p_brand = product.getProduct_brand();
				switch(p_brand) {
				case "NIKE": product_brandName = "NIKE"; break;
				case "ADIDAS": product_brandName = "ADIDAS"; break;
				case "JORDAN": product_brandName = "JORDAN"; break;
				case "YEEZY": product_brandName = "YEEZY"; break;
				case "COLLAB": product_brandName = "COLLAB"; break;
				case "all": product_brandName = "ALL"; break;
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
			<td class="right"><%=df.format(product.getProduct_count()) %>qty</td>
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
// Paging
// count : total number of products, kind_count : Total number of products or number of products by classification
if(count > 0) {
	int pageCount = count / pageSize + (count%pageSize == 0 ? 0 : 1); // Total page number
	int startPage = 1;  // start page number
	int pageBlock = 10; // number of paging
	
	// start page setting
	if(currentPage % 10 != 0) startPage = (int)(currentPage/10)*10 + 1;
	else startPage = (int)(currentPage/10-1)*10 + 1;
	
	// end page setting
	int endPage = startPage + pageBlock - 1;
	if(endPage > pageCount) endPage = pageCount;
	
	// previous page 
	if(startPage > 10) {
		out.print("<a href='productList.jsp?product_brand="+product_brand+"&pageNum="+(startPage-10)+"'><div id='pbox'>◀</div></a>");
	}
	
	// Paging block processing -> Get rid of the current page hyperlink
	for(int i=startPage; i<=endPage; i++) {
		if(i == currentPage) { // When i is the current page (not moved) 
			out.print("<div id='pbox' class='pbox_current'>"+i +"</div>");
		} else { // When i is not the current page (move)
			out.print("<a href='productList.jsp?product_brand="+product_brand+"&pageNum="+i+"'><div id='pbox'>" + i + "</div></a>");
		}
		
		
	}
	// Processing for the next page
	if(endPage < pageCount) {
		out.print("<a href='productList.jsp?product_brand="+product_brand+"&pageNum="+(startPage+10) + "'><div id='pbox'>▶</div></a>");
	}
}
%>
	</div> <%-- paging --%>

</div> <%--container --%>


</body>
</html>

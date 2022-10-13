<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="manager.product.*, java.text.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>product modification form page</title>
<style>
#container { width: 500px; margin: 20px auto;}
h3 { text-align: center; border-radius: 15px 15px 0 0; border-bottom: 2px solid #cdc8da; padding: 0.5em; background: #b8d6f0;}
table { width: 100%; border: 1px solid #1e6793; border-collapse: collapse;}
th, td { border: 1px solid #1e6793;}
tr { height: 30px;}
th { background: #b8d6f0; font-size: 0.8em;}
td { padding-left: 5px;}
a { text-decoration: none; color: #409caf; font-weight: 700;}
.first_row td { text-align: right; padding-right: 10px;}
.btns_row { text-align: center; height: 50px;}
.btns_row input { width: 80px; height: 30px; border: 0; background: #b8d6f0; color: black; 
cursor: pointer; font-weight: 700; margin: 0 5px;}
.btns_row input:hover { background: white; color: #b8d6f0; border: 1px solid black;}
/* The way to remove arrow buttons from the number attribute */
input[type="number"]::-webkit-outer-spin-button, input[type="number"]::-webkit-inner-spin-button { -webkit-appearance: none; margin: 0;}
</style>
<script>
window.onload = function() {
	var updateBtn = document.getElementById("updateBtn");
	updateBtn.addEventListener("click", function() {
		var form = document.updateForm;
		
		// product_brand(select is default), product_model(select), id 
		// Validation of 10 items except 3
		if(!form.product_title.value) {
			alert('Enter the product title.');
			form.product_title.focus();
			return;
		}
		if(!form.product_price.value) {
			alert('Enter the price of the item.');
			form.product_price.focus();
			return;
		}
		if(!form.product_count.value) {
			alert('Please enter the quantity of goods.');
			form.product_count.focus();
			return;
		}
		if(!form.product_size.value) {
			alert('Please enter a size.');
			form.product_size.focus();
			return;
		}
		if(!form.product_date.value) {
			alert('Please enter the release date.');
			form.product_date.focus();
			return;
		}
		if(!form.product_image.value) {
			alert('Please select a product representative image.');
			form.product_image.focus();
			return;
		}
		if(!form.product_detail1.value) {
			alert('Select Product Detail Image 1.');
			form.product_detail1.focus();
			return;
		}
		if(!form.product_detail2.value) {
			alert('Please select the product detailed image 2.');
			form.product_detail2.focus();
			return;
		}
		if(!form.product_detail3.value) {
			alert('Select Product Detail Image 3.');
			form.product_detail3.focus();
			return;
		}
		if(!form.product_description.value) {
			alert('Enter the product description.');
			form.product_description.focus();
			return;
		}
		form.submit();
	})	
}
/*second classification*/
function categoryChange(e) {
	var NIKE=["DUNK", "AIR MAX", "AIR FORCE", "VAPOR MAX"];
	var ADIDAS=["ULTRA BOOST", "NMD", "PHARRELL"];
	var JORDAN=["AIR JORDAN 1", "AIR JORDAN 2", "AIR JORDAN 3", "AIR JORDAN 4", "AIR JORDAN 5", "AIR JORDAN 6", "AIR JORDAN 7", "AIR JORDAN 8", "AIR JORDAN 9", "AIR JORDAN 10", "AIR JORDAN 11", "AIR JORDAN 12", "AIR JORDAN 13", "AIR JORDAN 14"];
	var YEEZY=["YEEZY BOOST 350", "YEEZY BOOST 380", "YEEZY BOOST 500", "YEEZY BOOST 700", "YEEZY BOOST 750"];
	var COLLAB=["CANVAS", "OFF-WHITE", "VANS"];
	var target = document.getElementById("model");
		
	if(e.value == "NIKE") var d = NIKE;
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
</head>
<body>
<%
String managerId = (String)session.getAttribute("managerId");
// When there is no session value for managerId (not logged in)
if(managerId == null) {
	response.sendRedirect("../logon/managerLoginForm.jsp");
}
// When you have a session value for ManagerId (Log in)

int product_id = Integer.parseInt(request.getParameter("product_id"));
String product_brand = request.getParameter("product_brand");
String pageNum = request.getParameter("pageNum");
ProductDataBean product = new ProductDataBean();

// DB link, excutes the query
ProductDBBean dbPro = ProductDBBean.getInstance();
product = dbPro.getProduct(product_id);
%>
<div id="container">
	<h3>Product Modification</h3>
	<form method="post" action="productUpdatePro.jsp" name="updateForm" enctype="multipart/form-data">
	<input type="hidden" name="product_id" value="<%=product_id %>">
	<input type="hidden" name="pageNum" value="<%=pageNum %>"> 
	<table>
		<tr class="first_row">
			<td colspan="2"><a href="../managerMain.jsp">Admin Main</a></td>
		</tr>
		<tr>
			<th width="25%">Select the Brand</th>
			<td width="75%">
			<select name="product_brand" onchange="categoryChange(this)">
				<option>Select the Brand</option>
				<option value="NIKE" <%if(product_brand.equals("NIKE")) {%>selected<%}%>>NIKE</option>
				<option value="ADIDAS" <%if(product_brand.equals("ADIDAS")) {%>selected<%}%>>ADIDAS</option>
				<option value="JORDAN" <%if(product_brand.equals("JORDAN")) {%>selected<%}%>>JORDAN</option>
				<option value="YEEZY" <%if(product_brand.equals("YEEZY")) {%>selected<%}%>>YEEZY</option>
				<option value="COLLAB" <%if(product_brand.equals("COLLAB")) {%>selected<%}%>>COLLAB</option>
			</select>
			</td>
		</tr>
		<tr>
			<th width="25%">Select the Collection</th>
			<td width="75%">
			<select name="product_model" id="model">
				<option>Select the product</option>
				<option value="DUNK" <%if(product_brand.equals("DUNK")) {%>selected<%}%>>DUNK</option>
				<option value="AIR MAX" <%if(product_brand.equals("AIR MAX")) {%>selected<%}%>>AIR MAX</option>
				<option value="AIR FORCE" <%if(product_brand.equals("AIR FORCE")) {%>selected<%}%>>AIR FORCE</option>
				<option value="VAPOR MAX" <%if(product_brand.equals("VAPOR MAX")) {%>selected<%}%>>VAPOR MAX</option>
				
				<option value="AIR JORDAN 1" <%if(product_brand.equals("AIR JORDAN 1")) {%>selected<%}%>>AIR JORDAN 1</option>
				<option value="AIR JORDAN 2" <%if(product_brand.equals("AIR JORDAN 2")) {%>selected<%}%>>AIR JORDAN 2</option>
				<option value="AIR JORDAN 3" <%if(product_brand.equals("AIR JORDAN 3")) {%>selected<%}%>>AIR JORDAN 3</option>
				<option value="AIR JORDAN 4" <%if(product_brand.equals("AIR JORDAN 4")) {%>selected<%}%>>AIR JORDAN 4</option>
				<option value="AIR JORDAN 5" <%if(product_brand.equals("AIR JORDAN 5")) {%>selected<%}%>>AIR JORDAN 5</option>
				<option value="AIR JORDAN 6" <%if(product_brand.equals("AIR JORDAN 6")) {%>selected<%}%>>AIR JORDAN 6</option>
				<option value="AIR JORDAN 7" <%if(product_brand.equals("AIR JORDAN 7")) {%>selected<%}%>>AIR JORDAN 7</option>
				<option value="AIR JORDAN 8" <%if(product_brand.equals("AIR JORDAN 8")) {%>selected<%}%>>AIR JORDAN 8</option>
				<option value="AIR JORDAN 9" <%if(product_brand.equals("AIR JORDAN 9")) {%>selected<%}%>>AIR JORDAN 9</option>
				<option value="AIR JORDAN 10" <%if(product_brand.equals("AIR JORDAN 10")) {%>selected<%}%>>AIR JORDAN 10</option>
				<option value="AIR JORDAN 11" <%if(product_brand.equals("AIR JORDAN 11")) {%>selected<%}%>>AIR JORDAN 11</option>
				<option value="AIR JORDAN 12" <%if(product_brand.equals("AIR JORDAN 12")) {%>selected<%}%>>AIR JORDAN 12</option>
				<option value="AIR JORDAN 13" <%if(product_brand.equals("AIR JORDAN 13")) {%>selected<%}%>>AIR JORDAN 13</option>
				<option value="AIR JORDAN 14" <%if(product_brand.equals("AIR JORDAN 14")) {%>selected<%}%>>AIR JORDAN 14</option>
				
				<option value="YEEZY BOOST 350" <%if(product_brand.equals("YEEZY BOOST 350")) {%>selected<%}%>>YEEZY BOOST 350</option>
				<option value="YEEZY BOOST 350" <%if(product_brand.equals("YEEZY BOOST 380")) {%>selected<%}%>>YEEZY BOOST 380</option>
				<option value="YEEZY BOOST 350" <%if(product_brand.equals("YEEZY BOOST 500")) {%>selected<%}%>>YEEZY BOOST 500</option>
				<option value="YEEZY BOOST 350" <%if(product_brand.equals("YEEZY BOOST 700")) {%>selected<%}%>>YEEZY BOOST 700</option>
				<option value="YEEZY BOOST 350" <%if(product_brand.equals("YEEZY BOOST 750")) {%>selected<%}%>>YEEZY BOOST 750</option>
				
				<option value="CANVAS" <%if(product_brand.equals("CANVAS")) {%>selected<%}%>>CANVAS</option>
				<option value="OFF-WHITE" <%if(product_brand.equals("OFF-WHITE")) {%>selected<%}%>>OFF-WHITE</option>
				<option value="VANS" <%if(product_brand.equals("VANS")) {%>selected<%}%>>VANS</option>
			</select>
			</td>
		</tr>
		
		<tr>
			<th>Product Name</th>
			<td><input type="text" name="product_title" size="40" value="<%=product.getProduct_title()%>"></td>
		</tr>
		<tr>
			<th>Product Price</th>
			<td><input type="number" name="product_price" size="10" min="0" max="1000000" value="<%=product.getProduct_price()%>">$</td>
		</tr>
		<tr>
			<th>Product Quantity</th>
			<td><input type="number" name="product_count" size="10" min="0" max="1000000" value="<%=product.getProduct_count()%>">개</td>
		</tr>
		<tr>
			<th>Product Size</th>
			<%-- <td>
				<select name="product_size">
					<option>Select your size</option>
					<option value="6" <%if(product_size == 6) {%>selected<%}%>>6</option>
					<option value="7" <%if(product_size == 7) {%>selected<%}%>>7</option>
					<option value="8" <%if(product_size == 8) {%>selected<%}%>>8</option>
					<option value="9" <%if(product_size == 9) {%>selected<%}%>>9</option>
					<option value="10" <%if(product_size == 10) {%>selected<%}%>>10</option>
					<option value="11" <%if(product_size == 11) {%>selected<%}%>>11</option>
					<option value="12" <%if(product_size == 12) {%>selected<%}%>>12</option>
				</select>
			</td> --%>
			<td><input type="number" name="product_size" size="40" value="<%=product.getProduct_size()%>"></td>
		</tr>	
		<tr>
			<th>Release Date</th>
			<td><input type="text" name="product_date" size="40" value="<%=product.getProduct_date()%>"></td>
		</tr>	
		<tr>
			<th>Product Image</th>
			<td><input type="file" name="product_image"></td>
		</tr>
		<tr>
			<th>Product detail image1</th>
			<td><input type="file" name="product_detail1"></td>
		</tr>
		<tr>
			<th>Product detail image2</th>
			<td><input type="file" name="product_detail2"></td>
		</tr>
		<tr>
			<th>Product detail image3</th>
			<td><input type="file" name="product_detail3"></td>
		</tr>
		<tr>
			<th>Product Description</th>
			<td><textarea name="product_description" rows="13" cols="48"><%=product.getProduct_description()%></textarea></td>
		</tr>	
		<tr class="btns_row">
			<td colspan="2">
				<input type="button" value="Product Modification" id="updateBtn">
				<input type="reset" value="Clear">
				<input type="button" value="Product List" onclick="location='productList.jsp?product_brand=<%=product_brand%>&pageNum=<%=pageNum%>'">
			</td>
		</tr>
	</table>
	</form>
</div>

</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Product Registration Form Page</title>
<style>
#container { width: 500px; margin: 20px auto;}
h3 { text-align: center; border-radius: 15px 15px 0 0; border-bottom: 2px solid #cdc8da; padding: 0.5em; background: #b8d6f0;}
table { width: 100%; border: 1px solid #1e6793; border-collapse: collapse;}
th, td { border: 1px solid #ced4da;}
tr { height: 30px;}
th { background: #b8d6f0; font-size: 0.8em;}
td { padding-left: 5px;}
a { text-decoration: none; color: #409caf; font-weight: 700;}
.first_row td { text-align: right; padding-right: 10px;}
.btns_row { text-align: center; height: 50px;}
.btns_row input { width: 80px; height: 30px; border: 0; background: #b8d6f0; color: black; 
cursor: pointer; font-weight: 700; margin: 0 5px;}
.btns_row input:hover { background: white; color: #b8d6f0; border: 1px solid black;}
/* How to remove arrow buttons from number attributes */
input[type="number"]::-webkit-outer-spin-button, input[type="number"]::-webkit-inner-spin-button { -webkit-appearance: none; margin: 0;}
</style>
<script>
window.onload = function() {
	var registerBtn = document.getElementById("registerBtn");
	registerBtn.addEventListener("click", function() {
		var form = document.registerForm;
		
		// product_brand(select is default), product_model(select), id 
		// Validity check for 10 items except 3 items
		if(!form.product_title.value) {
			alert('Enter the title of the product.');
			form.product_title.focus();
			return;
		}
		if(!form.product_price.value) {
			alert('Please enter the price of the product.');
			form.product_price.focus();
			return;
		}
		if(!form.product_count.value) {
			alert('Please enter the quantity of the product.');
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
			alert('Select the product representative image.');
			form.product_image.focus();
			return;
		}
		if(!form.product_detail1.value) {
			alert('Select Product Detail Image 1.');
			form.product_detail1.focus();
			return;
		}
		if(!form.product_detail2.value) {
			alert('Select Product Detail Image 2.');
			form.product_detail2.focus();
			return;
		}
		if(!form.product_detail3.value) {
			alert('Select Product Detail Image 3.');
			form.product_detail3.focus();
			return;
		}
		if(!form.product_description.value) {
			alert('Please enter a product description.');
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
// When there is no session value for managerId (when not login)
if(managerId == null) {
	response.sendRedirect("../logon/managerLoginForm.jsp");
}
// When there is a session value for managerId (when logined)
%>
<%-- product classification
Nike, Adidas, Jordan, Yeezy, Luxury, all
--%>
<div id="container">
	<h3>Product Registration</h3>
	<form method="post" action="productRegisterPro.jsp" name="registerForm" enctype="multipart/form-data">
	<table>
		<tr class="first_row">
			<td colspan="2"><a href="../managerMain.jsp">Admin main</a></td>
		</tr>
		<tr>
			<th width="25%">Select the Brand</th>
			<td width="75%">
			<select name="product_brand" onchange="categoryChange(this)">
				<option selected>Select the brand</option>
				<option value="NIKE">NIKE</option>
				<option value="ADIDAS">ADIDAS</option>
				<option value="JORDAN">JORDAN</option>
				<option value="YEEZY">YEEZY</option>
				<option value="COLLAB">COLLAB</option>
			</select>
			</td>
		</tr>
		<tr>
			<th width="25%">Select the Collection</th>
			<td width="75%">
			<select name="product_model" id="model">
				<option>Please select.</option>
			</select>
			</td>
		</tr>
		
		<tr>
			<th>Product Name</th>
			<td><input type="text" name="product_title" size="40"></td>
		</tr>
		<tr>
			<th>Product Price</th>
			<td><input type="number" name="product_price" size="10" min="0" max="1000000">$</td>
		</tr>
		<tr>
			<th>Product Quantity</th>
			<td><input type="number" name="product_count" size="10" min="0" max="1000000">Qty</td>
		</tr>
		<tr>
			<th>Product Size</th>
			<td><input type="number" name="product_size" size="40"></td>
		</tr>	
		<tr>
			<th>Release Date</th>
			<td><input type="text" name="product_date" size="40"></td>
		</tr>	
		<tr>
			<th>Product Representative Image</th>
			<td><input type="file" name="product_image"></td>
		</tr>
		<tr>
			<th>Product Detail Image 1</th>
			<td><input type="file" name="product_detail1"></td>
		</tr>
		<tr>
			<th>Product Detail Image 2</th>
			<td><input type="file" name="product_detail2"></td>
		</tr>
		<tr>
			<th>Product Detail Image 3</th>
			<td><input type="file" name="product_detail3"></td>
		</tr>
		<tr>
			<th>Product Content</th>
			<td><textarea name="product_description" rows="13" cols="48"></textarea></td>
		</tr>	
		<tr class="btns_row">
			<td colspan="2">
				<input type="button" value="Product Registration" id="registerBtn">
				<input type="reset" value="Clear">
				<input type="button" value="Product List" onclick="location='productList.jsp'">
			</td>
		</tr>
	</table>
	</form>
</div>

</body>
</html>

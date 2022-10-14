<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.util.*, java.sql.*, manager.product.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Product Modification Processing Page</title>
</head>
<body>
<%
request.setCharacterEncoding("utf-8");

// File upload processing object and variable declaration
MultipartRequest imageUp = null;
//String saveFolder = "/imageFile";
String encType = "utf-8";
int maxSize = 1024 * 1024 * 5;

//Stack Creation - imageUp saves image file names to the stack -> Save them back to the stack for import in order
//Create list - Save the image file name stored in the stack to the list
Stack<String> st = new Stack<String>();
List<String> fileNames = new ArrayList<String>();

// The address where the file is uploaded
String realFolder = "c:/images_shoes21";
String fileName = "";

// upload file processing
try {
	imageUp = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());
	
	Enumeration<?> files = imageUp.getFileNames();
	// Store unknown filenames in a stack
	while(files.hasMoreElements()) {
		String name = (String)files.nextElement();
		st.push(imageUp.getFilesystemName(name));
	}
	// Save the image file name stored in the stack back to the list
	while(!st.isEmpty()) {
		fileNames.add(st.pop());
	}
} catch(Exception e) {
	e.printStackTrace();
}

//product_id, pageNum data
int product_id = Integer.parseInt(imageUp.getParameter("product_id"));
String pageNum = imageUp.getParameter("pageNum");

// Receive 9 values from the form and process them as imageUp, a MultipartRequest object (because file upload is included)
// - File uploads are handled separately
// MultipartRequest 객체는 useBean에서 setProperty 액션태그가 동작하지 않음
// - Therefore, it is necessary to receive one value from the form and process it.
String product_brand = imageUp.getParameter("product_brand");
String product_model = imageUp.getParameter("product_model");
String product_title = imageUp.getParameter("product_title");
int product_price = Integer.parseInt(imageUp.getParameter("product_price")); // int
int product_count = Integer.parseInt(imageUp.getParameter("product_count")); // int
int product_size = Integer.parseInt(imageUp.getParameter("product_size")); // int
String product_date = imageUp.getParameter("product_date");
String product_description = imageUp.getParameter("product_description");

// Product object creation, set value on product object
ProductDataBean product = new ProductDataBean();
product.setProduct_id(product_id); // product_id 추가 
product.setProduct_brand(product_brand);
product.setProduct_model(product_model);
product.setProduct_title(product_title);
product.setProduct_price(product_price);
product.setProduct_count(product_count);
product.setProduct_size(product_size);
product.setProduct_date(product_date);
product.setProduct_description(product_description);
//fileName
product.setProduct_image(fileNames.get(0));
product.setProduct_detail1(fileNames.get(1));
product.setProduct_detail2(fileNames.get(2));
product.setProduct_detail3(fileNames.get(3));

// DB link, excutes query, move to product list
ProductDBBean dbPro = ProductDBBean.getInstance();
dbPro.updateProduct(product);
response.sendRedirect("productList.jsp?product_brand=" + product_brand + "&pageNum=" + pageNum);
%>
</body>
</html>

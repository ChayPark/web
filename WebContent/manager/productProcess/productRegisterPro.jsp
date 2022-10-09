<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.util.*, java.sql.*, manager.product.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>product registration processing page</title>
</head>
<body>
<%
request.setCharacterEncoding("utf-8");

// Declare File Upload Handling Objects and Variables
MultipartRequest imageUp = null;
String saveFolder = "/imageFile";
String encType = "utf-8";
int maxSize = 1024 * 1024 * 5;

// The absolute location of the web server in which the upload file is to be stored is obtained (it is the management area of the Tomcat server and it is not accessible)
//ServletContext context = getServletContext();
//String realFolder = context.getRealPath(saveFolder);
//String fileName = ""; // 웹서버에 저장된 파일 이름

// the location where the file is uploaded
String realFolder = "c:/images_shoes21";
String fileName = "";
String fileName1 = "";
String fileName2 = "";
String fileName3 = "";

// Stack generation - imageUp stores image file names in stacks - Storage them back in stacks to import them in order
// Create List - Save the image file name stored in the stack to the list
Stack<String> st = new Stack<String>();
List<String> fileNames = new ArrayList<String>();
// upload file processing
try {
	imageUp = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());
	
	Enumeration<?> files = imageUp.getFileNames();

	// Save the image file name to the stack
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

// It receives 9 values that come from the form and processes it as an imageUp, a MultipartRequest object (because it contains file uploads).
// - File uploads are processed separately
// MultipartRequest object does not operate setProperty action tag in useBean
// - Therefore, we have to take one value from the form and process it.
String product_brand = imageUp.getParameter("product_brand");
String product_model = imageUp.getParameter("product_model");
String product_title = imageUp.getParameter("product_title");
int product_price = Integer.parseInt(imageUp.getParameter("product_price")); // int
int product_count = Integer.parseInt(imageUp.getParameter("product_count")); // int
int product_size = Integer.parseInt(imageUp.getParameter("product_size")); // int
String product_date = imageUp.getParameter("product_date");
String product_description = imageUp.getParameter("product_description");

// Generate Product Object, set values for Product Object
ProductDataBean product = new ProductDataBean();
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

// DB link, query execution, and moving to the Product List
ProductDBBean dbPro = ProductDBBean.getInstance();
dbPro.insertProduct(product);
response.sendRedirect("productList.jsp?product_brand=" + product_brand);
%>

</body>
</html>

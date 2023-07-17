<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.util.*, java.sql.*, manager.product.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 등록 처리 페이지</title>
</head>
<body>
<%
request.setCharacterEncoding("utf-8");

// 파일 업로드 처리 객체와 변수 선언
MultipartRequest imageUp = null;
//String saveFolder = "/imageFile";
String encType = "utf-8";
int maxSize = 1024 * 1024 * 5;

// 업로드 파일이 저장될 웹서버의 절대 위치를 구함(Tomcat 서버의 관리 영역이어서 접근 불가, 사용하지 않음)
//ServletContext context = getServletContext();
//String realFolder = context.getRealPath(saveFolder);
//String fileName = ""; // 웹서버에 저장된 파일 이름

// 파일이 업로드되는 위치
String realFolder = "c:/images_mall21";
String fileName = "";

// 업로드 파일 처리
try {
	imageUp = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());
	
	Enumeration<?> files = imageUp.getFileNames();
	while(files.hasMoreElements()) {
		String name = (String)files.nextElement();
		fileName = imageUp.getFilesystemName(name);
	}
} catch(Exception e) {
	e.printStackTrace();
}

// 폼에서 넘어오는 9개의 값을 받아서 MultipartRequest 객체인 imageUp으로 처리(파일 업로드가 포함되어 있으므로)
// - 파일 업로드는 따로 처리
// MultipartRequest 객체는 useBean에서 setProperty 액션태그가 동작하지 않음
// - 따라서, 폼에서 넘어오는 값을 하나씩 받아서 처리해야함.
String product_kind = imageUp.getParameter("product_kind");
String product_title = imageUp.getParameter("product_title");
int product_price = Integer.parseInt(imageUp.getParameter("product_price")); // int
int product_count = Integer.parseInt(imageUp.getParameter("product_count")); // int
String author = imageUp.getParameter("author");
String publishing_com = imageUp.getParameter("publishing_com");
String publishing_date = imageUp.getParameter("publishing_date");
String product_content = imageUp.getParameter("product_content");
int discount_rate = Integer.parseInt(imageUp.getParameter("discount_rate")); // int

// Product 객체 생성, product 객체에 값을 설정
ProductDataBean product = new ProductDataBean();
product.setProduct_kind(product_kind);
product.setProduct_title(product_title);
product.setProduct_price(product_price);
product.setProduct_count(product_count);
product.setAuthor(author);
product.setPublishing_com(publishing_com);
product.setPublishing_date(publishing_date);
product.setProduct_content(product_content);
product.setDiscount_rate(discount_rate);
// fileName
product.setProduct_image(fileName); 
// reg_date는 따로 추가(폼에서 넘어오는 값이  아니므로)
product.setReg_date(new Timestamp(System.currentTimeMillis()));

// DB 연동, 쿼리문 실행, 상품목록으로 이동
ProductDBBean dbPro = ProductDBBean.getInstance();
dbPro.insertProduct(product);
response.sendRedirect("productList.jsp?product_kind=" + product_kind);
%>

</body>
</html>
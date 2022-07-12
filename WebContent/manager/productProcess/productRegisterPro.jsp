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
String saveFolder = "/imageFile";
String encType = "utf-8";
int maxSize = 1024 * 1024 * 5;

// 업로드 파일이 저장될 웹서버의 절대 위치를 구함(Tomcat 서버의 관리 영역이어서 접근 불가, 사용하지 않음)
//ServletContext context = getServletContext();
//String realFolder = context.getRealPath(saveFolder);
//String fileName = ""; // 웹서버에 저장된 파일 이름

// 파일이 업로드되는 위치
String realFolder = "c:/images_shoes21";
String fileName = "";
String fileName1 = "";
String fileName2 = "";
String fileName3 = "";

// 스택 생성 - imageUp이 이미지 파일명을 스택에 저장 -> 순서대로 가져오기 위해서 다시 스택에 저장
// 리스트 생성 - 스택에 저장된 이미지 파일명을 리스트에 저장
Stack<String> st = new Stack<String>();
List<String> fileNames = new ArrayList<String>();
// 업로드 파일 처리
try {
	imageUp = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());
	
	Enumeration<?> files = imageUp.getFileNames();

	// 이미지 파일명을 스택에 저장
	while(files.hasMoreElements()) {
		String name = (String)files.nextElement();
		st.push(imageUp.getFilesystemName(name));
	}
	// 스택에 저장된 이미지 파일명을 다시 리스트에 저장
	while(!st.isEmpty()) {
		fileNames.add(st.pop());
	}
} catch(Exception e) {
	e.printStackTrace();
}

// 폼에서 넘어오는 9개의 값을 받아서 MultipartRequest 객체인 imageUp으로 처리(파일 업로드가 포함되어 있으므로)
// - 파일 업로드는 따로 처리
// MultipartRequest 객체는 useBean에서 setProperty 액션태그가 동작하지 않음
// - 따라서, 폼에서 넘어오는 값을 하나씩 받아서 처리해야함.
String product_brand = imageUp.getParameter("product_brand");
String product_model = imageUp.getParameter("product_model");
String product_title = imageUp.getParameter("product_title");
int product_price = Integer.parseInt(imageUp.getParameter("product_price")); // int
int product_count = Integer.parseInt(imageUp.getParameter("product_count")); // int
int product_size = Integer.parseInt(imageUp.getParameter("product_size")); // int
String product_date = imageUp.getParameter("product_date");
String product_description = imageUp.getParameter("product_description");

// Product 객체 생성, product 객체에 값을 설정
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

// DB 연동, 쿼리문 실행, 상품목록으로 이동
ProductDBBean dbPro = ProductDBBean.getInstance();
dbPro.insertProduct(product);
response.sendRedirect("productList.jsp?product_brand=" + product_brand);
%>

</body>
</html>
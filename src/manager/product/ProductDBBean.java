package manager.product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class ProductDBBean {
	// JDBC에서 사용할 객체 변수 선언
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	private String sql = "";
	
	// singleton pattern 적용
	private ProductDBBean() {}
	
	private static ProductDBBean instance = new ProductDBBean();
	
	public static ProductDBBean getInstance() {
		return instance;
	}
	
	// connection pool 사용
	private Connection getConnection() throws Exception {
		Context initCtx = new InitialContext();
		Context envCtx = (Context)initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource)envCtx.lookup("jdbc/db02");
		return ds.getConnection();
	}
	
	// JDBC에서 사용할 객체 닫기
	private void close() {
		if(rs != null) try {rs.close();} catch(Exception e) {e.printStackTrace();}
		if(pstmt != null) try {pstmt.close();} catch(Exception e) {e.printStackTrace();}
		if(conn != null) try {conn.close();} catch(Exception e) {e.printStackTrace();}
	}
	
	// 관리자 인증 메소드
	// x: 1 - 아이디가 존재하고 비밀번호가 일치
	// x: 0 - 아이디가 존재하지만 비밀번호가 불일치
	// x: -1 - 아이디가 존재하지 않을 때
	public int managerCheck(String managerId, String managerPasswd) { 
		String dbPasswd = "";
		int x = -1;
		try {
			conn = getConnection();
			sql = "select managerPasswd from manager where managerId = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, managerId);
			rs = pstmt.executeQuery();
			
			if(rs.next()) { // 아이디가 존재할 때 
				dbPasswd = rs.getString("managerPasswd");
				if(dbPasswd.equals(managerPasswd)) x = 1; // 비밀번호 일치
				else x = 0;                               // 비밀번호 불일치
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return x;
	}
	
	// 상품 등록 메소드
	public void insertProduct(ProductDataBean product) { 
		try {
			conn = getConnection();
			sql = "insert into product values(?,?,?,?,?,?,?,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, product.getProduct_id());
			pstmt.setString(2, product.getProduct_brand());
			pstmt.setString(3, product.getProduct_model());
			pstmt.setString(4, product.getProduct_title());
			pstmt.setInt(5, product.getProduct_price());
			pstmt.setInt(6, product.getProduct_count());
			pstmt.setInt(7, product.getProduct_size());
			pstmt.setString(8, product.getProduct_date());
			pstmt.setString(9, product.getProduct_image());
			pstmt.setString(10, product.getProduct_detail1());
			pstmt.setString(11, product.getProduct_detail2());
			pstmt.setString(12, product.getProduct_detail3());
			pstmt.setString(13, product.getProduct_description());
			pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
	}
	
	// 전체 상품수 또는 분류별 전체 상품 수를 얻는 메소드
	public int getProductCount(String product_brand) { 
		int count = 0;
		try {
			conn = getConnection();
			if(product_brand.equals("all")) { // 전체 상품 수
				sql = "select count(*) from product";
				pstmt = conn.prepareStatement(sql);
			} else { 						 // 분류별 상품 수 
				sql = "select count(*) from product where product_brand = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, product_brand);
			}
			rs = pstmt.executeQuery();
			
			if(rs.next()) count = rs.getInt(1);
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return count;
	}
	
	// 전체 상품수 또는 분류별 전체 상품 수를 얻는 메소드 (shopAll용)
		public int getProductCount1(String product_brand) { 
			int count = 0;
			try {
				conn = getConnection();
				if(product_brand.equals("all")) { // 전체 상품 수
					sql = "select count(*) from product where product_size = 7";
					pstmt = conn.prepareStatement(sql);
				} else { 						 // 분류별 상품 수 
					sql = "select count(*) from product where product_brand = ?, product_size = 7";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, product_brand);
				}
				rs = pstmt.executeQuery();
				
				if(rs.next()) count = rs.getInt(1);
			} catch(Exception e) {
				e.printStackTrace();
			} finally {
				close();
			}
			return count;
		}
	
	//  전체 상품 또는 상품 분류별 상품의 정보를 얻는 메소드(productList 용)
	// product_brand: Nike, Adidas, Air Jordan, Yeezy, Collaboration, all(전체 상품)
	public List<ProductDataBean> getProducts(String product_brand, int start, int end) { 
		List<ProductDataBean> productList = new ArrayList<ProductDataBean>();
		ProductDataBean product = null;
		try {
			conn = getConnection();
			// limit ?, ? - 몇번부터 몇개, 0번부터 시작 
			if(product_brand.equals("all")) { // 전체 상품
				sql = "select * from product order by product_date desc limit ?, ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, start-1);
				pstmt.setInt(2, end);
			} else {    // 분류별 상품 (Nike, Adidas, Air Jordan, Yeezy, Collaboration, all(전체 상품))  
				sql = "select * from product where product_brand = ? order by product_date desc limit ?, ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, product_brand);
				pstmt.setInt(2, start-1);
				pstmt.setInt(3, end);
			
			}
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				// product_description를 제외한 12개 필드
				product = new ProductDataBean();
				product.setProduct_id(rs.getInt("product_id"));
				product.setProduct_brand(rs.getString("product_brand"));
				product.setProduct_model(rs.getString("product_model"));
				product.setProduct_title(rs.getString("product_title"));
				product.setProduct_price(rs.getInt("product_price"));
				product.setProduct_count(rs.getInt("product_count"));
				product.setProduct_size(rs.getInt("product_size"));
				product.setProduct_date(rs.getString("product_date"));
				product.setProduct_image(rs.getString("product_image"));
				product.setProduct_detail1(rs.getString("product_detail1"));
				product.setProduct_detail2(rs.getString("product_detail2"));
				product.setProduct_detail3(rs.getString("product_detail3"));
				productList.add(product);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return productList;
	}
	//  전체 상품 또는 상품 분류별 상품의 정보를 얻는 메소드(shopAll용)
	// product_brand: Nike, Adidas, Air Jordan, Yeezy, Collaboration, all(전체 상품)
	public List<ProductDataBean> getProducts1(String product_brand, int start, int end) { 
		List<ProductDataBean> productList = new ArrayList<ProductDataBean>();
		ProductDataBean product = null;
		try {
			conn = getConnection();
			// limit ?, ? - 몇번부터 몇개, 0번부터 시작 
			if(product_brand.equals("all")) { // 전체 상품
				sql = "select * from product where product_size=7 order by product_date desc limit ?, ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, start-1);
				pstmt.setInt(2, end);
			} else {    // 분류별 상품 (Nike, Adidas, Air Jordan, Yeezy, Collaboration, all(전체 상품))  
				sql = "select * from product where product_brand = ? and product_size=7 order by publishing_date desc, product_model limit ?, ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, product_brand);
				pstmt.setInt(2, start-1);
				pstmt.setInt(3, end);
			
			}
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				// product_description를 제외한 12개 필드
				product = new ProductDataBean();
				product.setProduct_id(rs.getInt("product_id"));
				product.setProduct_brand(rs.getString("product_brand"));
				product.setProduct_model(rs.getString("product_model"));
				product.setProduct_title(rs.getString("product_title"));
				product.setProduct_price(rs.getInt("product_price"));
				product.setProduct_count(rs.getInt("product_count"));
				product.setProduct_size(rs.getInt("product_size"));
				product.setProduct_date(rs.getString("product_date"));
				product.setProduct_image(rs.getString("product_image"));
				product.setProduct_detail1(rs.getString("product_detail1"));
				product.setProduct_detail2(rs.getString("product_detail2"));
				product.setProduct_detail3(rs.getString("product_detail3"));
				productList.add(product);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return productList;
	}
	
	// 메인 페이지에 나타낼  분류별 신상품 목록을 몇개(3개, 5개...)를 얻는 메소드
	public List<ProductDataBean> getProducts(String product_brand, int count) { 
		List<ProductDataBean> productList = new ArrayList<ProductDataBean>();
		ProductDataBean product = null;
		try {
			conn = getConnection();
			// 분류별로 product_date(출시일)를 기준으로 내림차순하여 1개를 조회하여 얻음.
			sql = "select * from product where product_brand = ? and product_size = 7 order by product_date desc limit ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, product_brand);
			pstmt.setInt(2, count);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				// product_description을 제외한 12개 필드
				product = new ProductDataBean();
				product.setProduct_id(rs.getInt("product_id"));
				product.setProduct_brand(rs.getString("product_brand"));
				product.setProduct_model(rs.getString("product_model"));
				product.setProduct_title(rs.getString("product_title"));
				product.setProduct_price(rs.getInt("product_price"));
				product.setProduct_count(rs.getInt("product_count"));
				product.setProduct_size(rs.getInt("product_size"));
				product.setProduct_date(rs.getString("product_date"));
				product.setProduct_image(rs.getString("product_image"));
				product.setProduct_detail1(rs.getString("product_detail1"));
				product.setProduct_detail2(rs.getString("product_detail2"));
				product.setProduct_detail3(rs.getString("product_detail3"));
				productList.add(product);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return productList;
	}
	
	// 메인 페이지에 나타낼  분류별 추천상품을 1건 얻는 메소드 -> 분류별 인기상품 1건 
	public List<ProductDataBean> getProducts() { 
		List<ProductDataBean> productList = new ArrayList<ProductDataBean>();
		ProductDataBean product = null;
		try {
			conn = getConnection();
			// 분류별로 그룹하여  product_count(수량)를 기준으로 오름차순하여 각 분류별로 1개를 조회하여 얻음.
			sql = "select * from product group by product_brand order by product_count desc";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
				
			while(rs.next()) {
				// product_content를 제외한 11개 필드
				product = new ProductDataBean();
				product.setProduct_id(rs.getInt("product_id"));
				product.setProduct_brand(rs.getString("product_brand"));
				product.setProduct_model(rs.getString("product_model"));
				product.setProduct_title(rs.getString("product_title"));
				product.setProduct_price(rs.getInt("product_price"));
				product.setProduct_count(rs.getInt("product_count"));
				product.setProduct_size(rs.getInt("product_size"));
				product.setProduct_date(rs.getString("product_date"));
				product.setProduct_image(rs.getString("product_image"));
				product.setProduct_detail1(rs.getString("product_detail1"));
				product.setProduct_detail2(rs.getString("product_detail2"));
				product.setProduct_detail3(rs.getString("product_detail3"));
				productList.add(product);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return productList;
	}
	
	// 상품 1개 정보를 얻는 메소드(상세 보기)
	// product_content를 포함한 12개 필드 정보
	public ProductDataBean getProduct(int product_id) { 
		ProductDataBean product = new ProductDataBean();
		try {
			conn = getConnection();
			sql = "select * from product where product_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, product_id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				product = new ProductDataBean();
				product.setProduct_id(rs.getInt("product_id"));
				product.setProduct_brand(rs.getString("product_brand"));
				product.setProduct_model(rs.getString("product_model"));
				product.setProduct_title(rs.getString("product_title"));
				product.setProduct_price(rs.getInt("product_price"));
				product.setProduct_count(rs.getInt("product_count"));
				product.setProduct_size(rs.getInt("product_size"));
				product.setProduct_date(rs.getString("product_date"));
				product.setProduct_image(rs.getString("product_image"));
				product.setProduct_detail1(rs.getString("product_detail1"));
				product.setProduct_detail2(rs.getString("product_detail2"));
				product.setProduct_detail3(rs.getString("product_detail3"));
				product.setProduct_description(rs.getString("product_description")); // 상품 설명
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return product;
	}
	
	// 상품 정보 수정 메소드
	public void updateProduct(ProductDataBean product) { 
		try {
			conn = getConnection();
			sql = "update product set product_brand=?, product_model=?, product_title=?, product_price=?, product_count=?, product_size=?, "
						+ "product_date=?, product_image=?, product_detail1=?, product_detail2=?, product_detail3=?, product_description=? "
						+ "where product_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, product.getProduct_brand());
			pstmt.setString(2, product.getProduct_model());
			pstmt.setString(3, product.getProduct_title());
			pstmt.setInt(4, product.getProduct_price());
			pstmt.setInt(5, product.getProduct_count());
			pstmt.setInt(6, product.getProduct_size());
			pstmt.setString(7, product.getProduct_date());
			pstmt.setString(8, product.getProduct_image());
			pstmt.setString(9, product.getProduct_detail1());
			pstmt.setString(10, product.getProduct_detail2());
			pstmt.setString(11, product.getProduct_detail3());
			pstmt.setString(12, product.getProduct_description());
			pstmt.setInt(13, product.getProduct_id());
			pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
	}
	
	// 상품 삭제 메소드
	public void deleteProduct(int product_id) { 
		try {
			conn = getConnection();
			sql = "delete from product where product_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, product_id);
			pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
	}
	
}

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
	// declare the objects for JDBC(Java Database Connectivity)
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	private String sql = "";
	
	// singleton pattern
	// why I used singleton pattern ?: Use one instance externally using static to prevent an instance from being created each time it is used.
	private ProductDBBean() {}
	
	private static ProductDBBean instance = new ProductDBBean();
	
	public static ProductDBBean getInstance() {
		return instance;
	}
	
	// connection pool
	// DBCP(DataBase Connection Pool) method
	private Connection getConnection() throws Exception {
		Context initCtx = new InitialContext();
		Context envCtx = (Context)initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource)envCtx.lookup("jdbc/db02");
		return ds.getConnection();
	}
	
	// Object for JDBC(Connection, PreparedStatement, ResultSet) 
	private void close() {
		if(rs != null) try {rs.close();} catch(Exception e) {e.printStackTrace();}
		if(pstmt != null) try {pstmt.close();} catch(Exception e) {e.printStackTrace();}
		if(conn != null) try {conn.close();} catch(Exception e) {e.printStackTrace();}
	}
	
	// Method of admin(manager) 
	// x: 1 - ID exists, and correct password
	// x: 0 - ID exists, but incorrect password
	// x: -1 - ID does not exist 
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
				if(dbPasswd.equals(managerPasswd)) x = 1; // correct password 
				else x = 0;                               // incorrect password 
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return x;
	}
	
	// Method of product registration
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
	
	// Method of total number of products or obtaining the total number of products by classification 
	public int getProductCount(String product_brand) { 
		int count = 0;
		try {
			conn = getConnection();
			if(product_brand.equals("all")) { 			 // total number of products 
				sql = "select count(*) from product";
				pstmt = conn.prepareStatement(sql);
			} else { 						 // total number of products by classification
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
	
	// Method of total number of products or obtaining the total number of products by classification (For shopAll)
		public int getProductCount1(String product_brand) { 
			int count = 0;
			try {
				conn = getConnection();
				if(product_brand.equals("all")) { // total number of products
					sql = "select count(*) from product where product_size = 7";
					pstmt = conn.prepareStatement(sql);
				} else { 						 // total number of products by classification  
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
	
	// Method of obtaining information about the entire product or product by classification(For productList)
	// product_brand: Nike, Adidas, Air Jordan, Yeezy, Collaboration, all
	public List<ProductDataBean> getProducts(String product_brand, int start, int end) { 
		List<ProductDataBean> productList = new ArrayList<ProductDataBean>();
		ProductDataBean product = null;
		try {
			conn = getConnection();
			// limit ?, ? - From what number to what number, start from zero
			if(product_brand.equals("all")) { // entire product
				sql = "select * from product order by product_date desc limit ?, ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, start-1);
				pstmt.setInt(2, end);
			} else {    // product by classification (Nike, Adidas, Air Jordan, Yeezy, Collaboration, all(entire product))  
				sql = "select * from product where product_brand = ? order by product_date desc limit ?, ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, product_brand);
				pstmt.setInt(2, start-1);
				pstmt.setInt(3, end);
			
			}
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				// 12 fields except product_description
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
	//  Method of obtaining information about the entire product or product by classification(for shopAll)
	// product_brand: Nike, Adidas, Air Jordan, Yeezy, Collaboration, all(entire product)
	public List<ProductDataBean> getProducts1(String product_brand, int start, int end) { 
		List<ProductDataBean> productList = new ArrayList<ProductDataBean>();
		ProductDataBean product = null;
		try {
			conn = getConnection();
			// limit ?, ? - From what number to what number, start from zero
			if(product_brand.equals("all")) { // entire product
				sql = "select * from product where product_size=7 order by product_date desc limit ?, ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, start-1);
				pstmt.setInt(2, end);
			} else {    // product by classification(Nike, Adidas, Air Jordan, Yeezy, Collaboration, all(entire product))  
				sql = "select * from product where product_brand = ? and product_size=7 order by publishing_date desc, product_model limit ?, ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, product_brand);
				pstmt.setInt(2, start-1);
				pstmt.setInt(3, end);
			
			}
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				// 12 fields except product_description
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
	
	// Method for obtaining several new product lists by classification to appear on the main page
	public List<ProductDataBean> getProducts(String product_brand, int count) { 
		List<ProductDataBean> productList = new ArrayList<ProductDataBean>();
		ProductDataBean product = null;
		try {
			conn = getConnection();
			// It is obtained by inquiring one by descending based on product_date (release date) for each classification
			sql = "select * from product where product_brand = ? and product_size = 7 order by product_date desc limit ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, product_brand);
			pstmt.setInt(2, count);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				// 12 fields except product_description
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
	
	// Method of obtaining 1 recommended product by classification to be displayed on the main page -> 1 popular product by classification
	public List<ProductDataBean> getProducts() { 
		List<ProductDataBean> productList = new ArrayList<ProductDataBean>();
		ProductDataBean product = null;
		try {
			conn = getConnection();
			// Grouped by classification, in ascending order based on product_count(quantity), and obtained by inquiring one for each classification.
			sql = "select * from product group by product_brand order by product_count desc";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
				
			while(rs.next()) {
				// 11 fields except product_content
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
	
	// Method of obtaining 1 product information (see details)
	// 12 fields include product_content
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
				product.setProduct_description(rs.getString("product_description")); // product description
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return product;
	}
	
	// Method of product information modification 
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
	
	// Method of delete product
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

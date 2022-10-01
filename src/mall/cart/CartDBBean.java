package mall.cart;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class CartDBBean {
	// JDBC object variables - DB conncection
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	private String sql = "";
	
	// Singleton Pattern 
	private CartDBBean() {}
	
	private static CartDBBean instance = new CartDBBean();
	
	public static CartDBBean getIntance() {
		return instance;
	}

	// Connection Pool 
	private Connection getConnection() throws Exception {
		Context initCtx = new InitialContext();
		Context envCtx = (Context)initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource)envCtx.lookup("jdbc/db02");
		return ds.getConnection();
	}
	
	// JDBC object variable close
	private void close() {
		try {if(rs != null) rs.close();} catch(Exception e) { e.printStackTrace();} 
		try {if(pstmt != null) pstmt.close();} catch(Exception e) { e.printStackTrace();} 
		try {if(conn != null) conn.close();} catch(Exception e) { e.printStackTrace();} 
	}
	
	// Add carts - Increase purchase count for the same product
	public int insertCart(CartDataBean cart) {
		System.out.println("===> insertCart() method");
		int x = 0; // check query success or not
		boolean check = false; // Check for the same productt
		int b_count = 0;       // additional purchase count of the same product
		
		try {
			conn = getConnection();
			
			// Check for the same product
			sql = "select * from cart where buyer = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, cart.getBuyer());
			rs = pstmt.executeQuery();
			
			// Check when the same product exists
			while(rs.next()) {
				if(rs.getInt("product_id") == cart.getProduct_id()) {
					check = true;
					b_count = rs.getInt("buy_count"); // Add the number of cart table purchases for the same product
				}
			}
			
			// Cart Processing according to the Same Products
			if(check == true) { // If the same goods has in cart - update
				sql = "update cart set buy_count=?, product_size=? where product_id=? and buyer=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, b_count+cart.getBuy_count());
				pstmt.setInt(2, cart.getProduct_id());
				pstmt.setString(3, cart.getBuyer());
				pstmt.setInt(4, cart.getProduct_size());
				x = pstmt.executeUpdate();
			} else {            // If the same goods has not in cart - insert
				sql = "insert into cart(buyer, product_id, product_title, product_size, buy_price, buy_count, product_image) "
						+ "values(?, ?, ?, ?, ?, ?, ?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, cart.getBuyer());
				pstmt.setInt(2, cart.getProduct_id());
				pstmt.setString(3, cart.getProduct_title());
				pstmt.setInt(4, cart.getProduct_size());
				pstmt.setInt(5, cart.getBuy_price());
				pstmt.setInt(6, cart.getBuy_count());
				pstmt.setString(7, cart.getProduct_image());
				x = pstmt.executeUpdate();
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally { 
			close();
		}
		return x;
	}
	
	// Checking the number of cart products - about the buyer
	public int getCartCount(String buyer) {
		System.out.println("===> getCartCount() method");
		int count = 0;
		try {
			conn = getConnection();
			
			sql = "select count(*) from cart where buyer=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, buyer);
			rs = pstmt.executeQuery();
			
			if(rs.next()) count = rs.getInt(1);
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return count;
	}
	// Check Cart List (entire list) - for buyers
	public List<CartDataBean> getCartList(String buyer) {
		System.out.println("===> getCartList() method");
		List<CartDataBean> cartList = new ArrayList<CartDataBean>();
		CartDataBean cart = null;
		try {
			conn = getConnection();
			sql = "select * from cart where buyer=? order by cart_id desc";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, buyer);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				cart = new CartDataBean();
				cart.setCart_id(rs.getInt("cart_id"));
				cart.setBuyer(rs.getString("buyer"));
				cart.setProduct_id(rs.getInt("product_id"));
				cart.setProduct_title(rs.getString("product_title"));
				cart.setProduct_size(rs.getInt("product_size"));
				cart.setBuy_price(rs.getInt("buy_price"));
				cart.setBuy_count(rs.getInt("buy_count"));
				cart.setProduct_image(rs.getString("product_image"));
				cartList.add(cart);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return cartList;
	}
	// Cart information modification (just modified purchase count) - increases the count when the product counts in the cart is the same or less than inventory count
	public void updateCart(int cart_id, int buy_count, int product_size, int p_one_price) {
		try {
			conn = getConnection();
			sql = "update cart set buy_count=?, product_size=? where cart_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, buy_count);
			pstmt.setInt(3, cart_id);
			pstmt.setInt(2, p_one_price*buy_count);
			pstmt.setInt(4, product_size);
			pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
	}
	// Cart Deletion - 3 ways(one, selected product, entire)
	// Delete one product in cart
	public void deleteCart(int cart_id) {
		try {
			conn = getConnection();
			sql = "delete from cart where cart_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, cart_id);
			pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
	}	
	
}

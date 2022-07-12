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
	// JDBC 객체 변수 - DB 연동
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	private String sql = "";
	
	// Singleton Pattern 설정
	private CartDBBean() {}
	
	private static CartDBBean instance = new CartDBBean();
	
	public static CartDBBean getIntance() {
		return instance;
	}

	// Connection Pool 설정
	private Connection getConnection() throws Exception {
		Context initCtx = new InitialContext();
		Context envCtx = (Context)initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource)envCtx.lookup("jdbc/db02");
		return ds.getConnection();
	}
	
	// JDBC 객체 변수 해제
	private void close() {
		try {if(rs != null) rs.close();} catch(Exception e) { e.printStackTrace();} 
		try {if(pstmt != null) pstmt.close();} catch(Exception e) { e.printStackTrace();} 
		try {if(conn != null) conn.close();} catch(Exception e) { e.printStackTrace();} 
	}
	
	// 카트 추가 - 동일한 상품에 대해서는 구매수량 증가
	public int insertCart(CartDataBean cart) {
		System.out.println("===> insertCart() 메소드");
		int x = 0; // 쿼리 성공 여부
		boolean check = false; // 동일 상품 체크 변수
		int b_count = 0;       // 동일 상품 추가 구매 수량
		
		try {
			conn = getConnection();
			
			// 동일한 상품에 대한 체크
			sql = "select * from cart where buyer = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, cart.getBuyer());
			rs = pstmt.executeQuery();
			
			// 동일한 상품이 존재할 때의 체크
			while(rs.next()) {
				if(rs.getInt("product_id") == cart.getProduct_id()) {
					check = true;
					b_count = rs.getInt("buy_count"); // 동일 상품에 대한 카트 테이블 구매 수량을 획득
				}
			}
			
			// 동일한 상품 유무에 따른 카트 처리
			if(check == true) { // 카트에 동일한 상품이 있을 때 - update
				sql = "update cart set buy_count=?, product_size=? where product_id=? and buyer=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, b_count+cart.getBuy_count());
				pstmt.setInt(2, cart.getProduct_id());
				pstmt.setString(3, cart.getBuyer());
				pstmt.setInt(4, cart.getProduct_size());
				x = pstmt.executeUpdate();
			} else {            // 카트에 동일한 상품이 없을 때 - insert
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
	
	// 카트 상품 수 확인 - 구매자에 대한 
	public int getCartCount(String buyer) {
		System.out.println("===> getCartCount() 메소드");
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
	// 카트 목록 확인 (전체 목록) - 구매자에 대한 
	public List<CartDataBean> getCartList(String buyer) {
		System.out.println("===> getCartList() 메소드");
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
	// 카트 정보 수정 (구매 수량만 수정) - 재고 수량과 비교하여 동일하거나 작을 때만 증가
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
	// 카트 삭제 - 3가지 방법(1개, 선택한 상품, 전체)
	// 카트 1개 상품 삭제 
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

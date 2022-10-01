package mall.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MemberDBBean {
	// DB link, Variable Declaration for Query Execution
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	private String sql = "";
	
	// Singleton Pattern
	private MemberDBBean() {}
	
	private static MemberDBBean instance = new MemberDBBean();
	
	public static MemberDBBean getInstance() {
		return instance;
	}
	
	// Connection Pool 
	private Connection getConnection() throws Exception {
		Context initCtx = new InitialContext();
		Context envCtx = (Context)initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource)envCtx.lookup("jdbc/db02");
		return ds.getConnection();
	}
	
	// DB link, set the release method for query executable variables
	private void close() {
		try { if(rs != null) rs.close(); } catch(Exception e) { e.printStackTrace();} 
		try { if(pstmt != null) pstmt.close(); } catch(Exception e) { e.printStackTrace();} 
		try { if(conn != null) conn.close(); } catch(Exception e) { e.printStackTrace();} 
	}
	
	// Method of member registration - check : 1(registration), 0(error)
	public int insertMember(MemberDataBean member) {
		int check = 0;
		try {
			conn = getConnection();
			sql = "insert into member values(?, ?, ?, ?, ?, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getId());
			pstmt.setString(2, member.getPasswd());
			pstmt.setString(3, member.getName());
			pstmt.setInt(4, member.getSize());
			pstmt.setString(5, member.getEmail());
			pstmt.setString(6, member.getAddress());
			pstmt.setString(7, member.getTel());
			pstmt.setTimestamp(8, member.getReg_date());
			check = pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return check;
	}
	// 회원 인증 메소드
	// x= 1 : ID exists, correct password
	// x= 0 : ID exists, incorrect password
	// x=-1 : Incorrect ID, password 
	public int userCheck(String id, String passwd) {
		int x = -1;
		try {
			conn = getConnection();
			sql = "select passwd from member where id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) { // ID exists
				String dbPasswd = rs.getString("passwd");
				if(dbPasswd.equals(passwd)) x = 1; // correct password	
				else x = 0; 					   // incorrect password
			} else { // ID does not exist
				x = -1;
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return x;
	}
	// Duplicate ID check
	// x=1 : ID exists			 -> warning 
	// x=0 : ID does not exist  -> sign up process
	
	public int confirmId(String id) {
		int x = 0;
		try {
			conn = getConnection();
			sql = "select id from member where id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) x = 1; // ID exist
			else x = 0;
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return x;
	}
	
	// Member Inquiry(check 1 person) Method - when member individual inquires
	public MemberDataBean getMember(String id) {
		MemberDataBean member = new MemberDataBean();
		try {
			conn = getConnection();
			sql = "select * from member where id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				member.setId(rs.getString("id"));
				member.setPasswd(rs.getString("passwd"));
				member.setName(rs.getString("name"));
				member.setSize(rs.getInt("size"));
				member.setEmail(rs.getString("email"));
				member.setAddress(rs.getString("address"));
				member.setTel(rs.getString("tel"));
				member.setReg_date(rs.getTimestamp("reg_date"));
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return member;
	}
	
	// Entire member lookup - Used by admin
	public List<MemberDataBean> getMembers(int start, int end) {
		List<MemberDataBean> members = new ArrayList<MemberDataBean>();
		MemberDataBean member = null;
		try {
			conn = getConnection();
			sql = "select * from member order by reg_date desc limit ?, ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start-1);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				member = new MemberDataBean();
				member.setId(rs.getString("id"));
				member.setPasswd(rs.getString("passwd"));
				member.setName(rs.getString("name"));
				member.setSize(rs.getInt("size"));
				member.setEmail(rs.getString("email"));
				member.setAddress(rs.getString("address"));
				member.setTel(rs.getString("tel"));
				member.setReg_date(rs.getTimestamp("reg_date"));
				members.add(member);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return members;
	}
		
	
	
	// Member Modification Method - check: 1 (Member Information Modification), 0(Error)
	public int updateMember(MemberDataBean member) {
		int check = 0;
		try {
			conn = getConnection();
			sql = "update member set passwd=?, name=?, size=?, email=?, address=?, tel=? where id=?"; // Change the password, name, size, email, address, number, depending on ID
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getPasswd());
			pstmt.setString(2, member.getName());
			pstmt.setInt(3, member.getSize());
			pstmt.setString(4, member.getEmail());
			pstmt.setString(5, member.getAddress());
			pstmt.setString(6, member.getTel());
			pstmt.setString(7, member.getId());
			check = pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return check;
	}
	// Member Deletion Method
	// Deletion Success : check = 1(ID exists, correct password)
	// Deletion Error : check = 0(ID exists, incorrect password), x = -1(ID does not exist)
	public int deleteMember(String id, String passwd) {
		int check = -1;
		try {
			conn = getConnection();
			// Verify password for ID
			sql = "select passwd from member where id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				String dbPasswd = rs.getString("passwd");
				if(dbPasswd.equals(passwd)) {
					sql = "delete from member where id = ?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, id);
					pstmt.executeUpdate();
					check = 1;
				} else check = 0;
			}
				
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return check;
	}
}

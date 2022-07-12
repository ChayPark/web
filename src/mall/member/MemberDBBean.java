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
	// DB 연동, 쿼리 실행에 대한 변수선언
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
	
	// Connection Pool 설정 
	private Connection getConnection() throws Exception {
		Context initCtx = new InitialContext();
		Context envCtx = (Context)initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource)envCtx.lookup("jdbc/db02");
		return ds.getConnection();
	}
	
	// DB 연동, 쿼리 실행 변수를 해제 메소드 설정 
	private void close() {
		try { if(rs != null) rs.close(); } catch(Exception e) { e.printStackTrace();} 
		try { if(pstmt != null) pstmt.close(); } catch(Exception e) { e.printStackTrace();} 
		try { if(conn != null) conn.close(); } catch(Exception e) { e.printStackTrace();} 
	}
	
	// 회원 가입 메소드 - check : 1(가입), 0(가입에러)
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
	// x= 1 : 아이디 존재, 비밀번호 일치
	// x= 0 : 아이디는 존재, 비밀번호는 불일치
	// x=-1 : 아이디, 비밀번호 불일치 
	public int userCheck(String id, String passwd) {
		int x = -1;
		try {
			conn = getConnection();
			sql = "select passwd from member where id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) { // 아이디 존재 
				String dbPasswd = rs.getString("passwd");
				if(dbPasswd.equals(passwd)) x = 1; // 비밀번호 일치 	
				else x = 0; 					   // 비밀번호 불일치 
			} else { // 아이디가 존재하지 않을 때 
				x = -1;
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return x;
	}
	// 중복 아이디 체크
	// x=1 : 이미 아이디 존재 			 -> 경고창 
	// x=0 : 해당 아이디가 존재하지 않을 때  -> 회원가입 진행
	
	public int confirmId(String id) {
		int x = 0;
		try {
			conn = getConnection();
			sql = "select id from member where id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) x = 1; // 이미 해당 아이디 존재 
			else x = 0;
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return x;
	}
	
	// 회원 조회(1명) 메소드 - 회원 개인이 조회할 때 
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
	
	// 회원 전체 조회 - 관리자가 사용 
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
		
	
	
	// 회원 수정 메소드 - check : 1(회원 정보 수정), 0(수정 에러)
	public int updateMember(MemberDataBean member) {
		int check = 0;
		try {
			conn = getConnection();
			sql = "update member set passwd=?, name=?, size=?, email=?, address=?, tel=? where id=?"; // 아이디에 따라 비번, 이름, 사이즈, 이메일, 주소, 번호 변경 
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
	// 회원 삭제(탈퇴) 메소드
	// 회원 탈퇴 성공 : check = 1(아이디 존재, 비밀번호 일치)
	// 회원 탈퇴 실패 : check = 0(아이디가 존재, 비밀번호 불일치), x = -1(아이디가 존재하지 않을 때)
	public int deleteMember(String id, String passwd) {
		int check = -1;
		try {
			conn = getConnection();
			// 아이디에 해당하는 비밀번호 확인 
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

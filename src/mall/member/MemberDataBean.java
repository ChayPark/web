package mall.member;

import java.sql.Timestamp;

public class MemberDataBean {
	private String id;
	private String passwd;
	private String name;
	private int size;
	private String email;
	private String address;
	private String tel;
	private Timestamp reg_date;
	
	public String getId() {
		return id;
	}
	
	public String getPasswd() {
		return passwd;
	}
	
	public String getName() {
		return name;
	}
	
	public int getSize() {
		return size;
	}
	
	public String getEmail() {
		return email;
	}
	
	public String getAddress() {
		return address;
	}
	
	public String getTel() {
		return tel;
	}
	
	public Timestamp getReg_date() {
		return reg_date;
	}
	
	public void setId(String id) {
		this.id = id;
	}
	
	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public void setSize(int size) {
		this.size = size;
	}
	
	public void setEmail(String email) {
		this.email = email;
	}
	
	public void setAddress(String address) {
		this.address = address;
	}
	
	public void setTel(String tel) {
		this.tel = tel;
	}
	
	public void setReg_date(Timestamp reg_date) {
		this.reg_date = reg_date;
	}
	
	
	
}

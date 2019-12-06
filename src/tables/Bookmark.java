package tables;

public class Bookmark {
	private String email;
	private int expenseNum;
	private String ninkname;
	private String profile;
	
	public String getNinkname() {
		return ninkname;
	}
	public void setNinkname(String ninkname) {
		this.ninkname = ninkname;
	}
	public String getProfile() {
		return profile;
	}
	public void setProfile(String profile) {
		this.profile = profile;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public int getExpenseNum() {
		return expenseNum;
	}
	public void setExpenseNum(int expenseNum) {
		this.expenseNum = expenseNum;
	}
	
	@Override
	public String toString() {
		return "Bookmark [email=" + email + ", expenseNum=" + expenseNum + "]";
	}
}

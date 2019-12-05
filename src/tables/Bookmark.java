package tables;

public class Bookmark {
	private String email;
	private int expenseNum;
	
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

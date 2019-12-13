package tables;

import java.util.Date;

public class Expense {
	private int expenseNum;
	private String email;
	private int travelNum;
	private int type1;
	private float price;
	private int type2;
	private int peocnt;
	private int seldate;
	private int selhour;
	private int selminute;
	private Date realtime;
	private String title;
	private String content;
	// 추가 조인 연결 후 작성
	private String nickname;
	private String profile;
	private String country;
	
	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}
	public int getExpenseNum() {
		return expenseNum;
	}
	public void setExpenseNum(int expenseNum) {
		this.expenseNum = expenseNum;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public int getTravelNum() {
		return travelNum;
	}
	public void setTravelNum(int travelNum) {
		this.travelNum = travelNum;
	}
	public int getType1() {
		return type1;
	}
	public void setType1(int type1) {
		this.type1 = type1;
	}
	public float getPrice() {
		return price;
	}
	public void setPrice(float price) {
		this.price = price;
	}
	public int getType2() {
		return type2;
	}
	public void setType2(int type2) {
		this.type2 = type2;
	}
	public int getPeocnt() {
		return peocnt;
	}
	public void setPeocnt(int peocnt) {
		this.peocnt = peocnt;
	}
	public int getSeldate() {
		return seldate;
	}
	public void setSeldate(int seldate) {
		this.seldate = seldate;
	}
	public int getSelhour() {
		return selhour;
	}
	public void setSelhour(int selhour) {
		this.selhour = selhour;
	}
	public int getSelminute() {
		return selminute;
	}
	public void setSelminute(int selminute) {
		this.selminute = selminute;
	}
	public Date getRealtime() {
		return realtime;
	}
	public void setRealtime(Date realtime) {
		this.realtime = realtime;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getProfile() {
		return profile;
	}
	public void setProfile(String profile) {
		this.profile = profile;
	}
	
	@Override
	public String toString() {
		return "Expense [expenseNum=" + expenseNum + ", email=" + email + ", travelNum=" + travelNum + ", type1="
				+ type1 + ", price=" + price + ", type2=" + type2 + ", peocnt=" + peocnt + ", seldate=" + seldate
				+ ", selhour=" + selhour + ", selminute=" + selminute + ", realtime=" + realtime + ", title=" + title
				+ ", content=" + content + "]";
	}
}

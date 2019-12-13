package tables;

public class Travel {
	private int travelNum;
	private String email;
	private String traveltitle;
	private String start;
	private String end;
	private String country;
	private String background;
	private float currency;
	private float budget;
	
	public int getTravelNum() {
		return travelNum;
	}
	public void setTravelNum(int travelNum) {
		this.travelNum = travelNum;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getTraveltitle() {
		return traveltitle;
	}
	public void setTraveltitle(String traveltitle) {
		this.traveltitle = traveltitle;
	}
	public String getStart() {
		return start;
	}
	public void setStart(String start) {
		this.start = start;
	}
	public String getEnd() {
		return end;
	}
	public void setEnd(String end) {
		this.end = end;
	}
	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}
	public String getBackground() {
		return background;
	}
	public void setBackground(String background) {
		this.background = background;
	}
	public float getCurrency() {
		return currency;
	}
	public void setCurrency(float currency) {
		this.currency = currency;
	}
	public float getBudget() {
		return budget;
	}
	public void setBudget(float budget) {
		this.budget = budget;
	}
	
	@Override
	public String toString() {
		return "Travel [travelNum=" + travelNum + ", email=" + email + ", traveltitle=" + traveltitle + ", start="
				+ start + ", end=" + end + ", country=" + country + ", background=" + background + ", currency="
				+ currency + ", budget=" + budget + "]";
	}
	
}

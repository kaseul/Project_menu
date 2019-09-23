package mirim.hs.kr;

import java.util.Date;

public class MenuBean {
	
	private int no;
	private Date days;
	private String part;
	private String menu;
	private int likes;
	
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public Date getDays() {
		return days;
	}
	public void setDays(Date days) {
		this.days = days;
	}
	public String getPart() {
		return part;
	}
	public void setPart(String part) {
		this.part = part;
	}
	public String getMenu() {
		return menu;
	}
	public void setMenu(String menu) {
		this.menu = menu;
	}
	public int getLikes() {
		return likes;
	}
	public void setLikes(int likes) {
		this.likes = likes;
	}
	
	@Override
	public String toString() {
		return "MenuBean [no=" + no + ", days=" + days + ", part=" + part + ", menu=" + menu + ", likes=" + likes + "]";
	}
	
}

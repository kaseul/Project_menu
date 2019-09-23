package mirim.hs.kr;

public class BoardBean {
	private String id;
	private int no;
	private String content;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	
	@Override
	public String toString() {
		return "BoardBean [id=" + id + ", no=" + no + ", content=" + content + "]";
	}
}

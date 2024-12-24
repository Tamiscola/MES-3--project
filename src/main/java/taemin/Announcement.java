package taemin;

public class Announcement {
	private int no;
	private String writer;
	private String content;
	private int reg_date;
	
	
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}

	public int getReg_date() {
		return reg_date;
	}
	public void setReg_date(int reg_date) {
		this.reg_date = reg_date;
	}
	@Override
	public String toString() {
		return "Announcement [no=" + no + ", writer=" + writer + ", content=" + content + ", reg_date=" + reg_date
				+ "]";
	}
	
	
}

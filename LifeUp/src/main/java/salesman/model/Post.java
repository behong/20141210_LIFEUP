package salesman.model;

public class Post implements Comparable<Post> {

    int id =0;
	String title;
    String content;
	String reg_id;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getReg_id() {
		return reg_id;
	}

	public void setReg_id(String reg_id) {
		this.reg_id = reg_id;
	}

    public Post() { }
    
    public Post(String title, String content, String writer) {
        this.title = title;
        this.content = content;
    }
    public String getTitle() { return title; }
    public Post setTitle(String title) { this.title = title; return this; };
    
    public String getContent() { return content; }
    public Post setContent(String content) { this.content = content; return this; }

	@Override
	public int compareTo(Post o) {
		// TODO Auto-generated method stub
		return 0;
	};


}

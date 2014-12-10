package salesman.vo.estimate;

public class ContractReplyVO {
	
	private String request_id;
	private String salesman_id;
	private String message;
	private String use_yn;
	private String create_user_id;
	private String create_user_nm;
	private String create_date;
	
	public String getRequest_id() {
		return request_id;
	}
	public void setRequest_id(String request_id) {
		this.request_id = request_id;
	}
	public String getSalesman_id() {
		return salesman_id;
	}
	public void setSalesman_id(String salesman_id) {
		this.salesman_id = salesman_id;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public String getUse_yn() {
		return use_yn;
	}
	public void setUse_yn(String use_yn) {
		this.use_yn = use_yn;
	}
	public String getCreate_user_id() {
		return create_user_id;
	}
	public void setCreate_user_id(String create_user_id) {
		this.create_user_id = create_user_id;
	}
	public String getCreate_user_nm() {
		return create_user_nm;
	}
	public void setCreate_user_nm(String create_user_nm) {
		this.create_user_nm = create_user_nm;
	}	
	public String getCreate_date() {
		return create_date;
	}
	public void setCreate_date(String create_date) {
		this.create_date = create_date;
	}
}	

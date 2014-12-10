package salesman.vo.estimate;

public class ContractVO {
	
	private String request_id;
	private String salesman_id;
	private String salesman_benefit;
	private String star_point;
	private String status;
	private String create_date;
	private String update_date;
	
	private String mail_flag;
	private String push_flag;
	
	public String getMail_flag() {
		return mail_flag;
	}
	public void setMail_flag(String mail_flag) {
		this.mail_flag = mail_flag;
	}
	public String getPush_flag() {
		return push_flag;
	}
	public void setPush_flag(String push_flag) {
		this.push_flag = push_flag;
	}
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
	public String getSalesman_benefit() {
		return salesman_benefit;
	}
	public void setSalesman_benefit(String salesman_benefit) {
		this.salesman_benefit = salesman_benefit;
	}
	public String getStar_point() {
		return star_point;
	}
	public void setStar_point(String star_point) {
		this.star_point = star_point;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getCreate_date() {
		return create_date;
	}
	public void setCreate_date(String create_date) {
		this.create_date = create_date;
	}
	public String getUpdate_date() {
		return update_date;
	}
	public void setUpdate_date(String update_date) {
		this.update_date = update_date;
	}	
}	

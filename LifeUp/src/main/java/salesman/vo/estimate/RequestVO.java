package salesman.vo.estimate;

public class RequestVO {
	
	private String request_id;
	private String customer_id;
	private String region_cd;
	private String vendor_id;
	private String car_id;
	private String car_trim;
	private String car_option;
	private String purchase_period_cd;
	private String customer_req;	
	private String status;
	
	private String salesman_id;
	
	public String getRequest_id() {
		return request_id;
	}
	public void setRequest_id(String request_id) {
		this.request_id = request_id;
	}
	public String getCustomer_id() {
		return customer_id;
	}
	public void setCustomer_id(String customer_id) {
		this.customer_id = customer_id;
	}
	public String getRegion_cd() {
		return region_cd;
	}
	public void setRegion_cd(String region_cd) {
		this.region_cd = region_cd;
	}
	public String getVendor_id() {
		return vendor_id;
	}
	public void setVendor_id(String vendor_id) {
		this.vendor_id = vendor_id;
	}	
	public String getCar_id() {
		return car_id;
	}
	public void setCar_id(String car_id) {
		this.car_id = car_id;
	}
	public String getCar_model() {
		return car_trim;
	}
	public void setCar_trim(String car_trim) {
		this.car_trim = car_trim;
	}
	public String getCar_option() {
		return car_option;
	}
	public void setCar_option(String car_option) {
		this.car_option = car_option;
	}	
	public String getPurchase_period_cd() {
		return purchase_period_cd;
	}
	public void setPurchase_period_cd(String purchase_period_cd) {
		this.purchase_period_cd = purchase_period_cd;
	}	
	public String getCustomer_req() {
		return customer_req;
	}
	public void setCustomer_req(String customer_req) {
		this.customer_req = customer_req;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}

	
	public String getSalesman_id() {
		return salesman_id;
	}
	public void setSalesman_id(String salesman_id) {
		this.salesman_id = salesman_id;
	}	
}

package salesman.vo.mypage;

import java.io.Serializable;
import java.util.Date;

public class MypageVO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	// content no
	private int req_id; 			
	private String customer_req; 
	private String status;
	//private String create_date;
	private Date create_date;
    private String salesman_benefit;
    // 포인트 내역 추가
    private String Point;
	
	
	@Override
	public String toString() {
		return "MypageVO [req_id=" + req_id + ", customer_req=" + customer_req
				+ ", status=" + status + ", create_date=" + create_date
				+ ", salesman_benefit=" + salesman_benefit + "]";
	}
	public int getReq_id() {
		return req_id;
	}
	public void setReq_id(int req_id) {
		this.req_id = req_id;
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
	public Date getCreate_date() {
		return create_date;
	}

	public void setCreate_date(Date create_date) {
		this.create_date = create_date;
	}
	public String getSalesman_benefit() {
		return salesman_benefit;
	}

	public void setSalesman_benefit(String salesman_benefit) {
		this.salesman_benefit = salesman_benefit;
	}
	/**
	 * @return the point
	 */
	public String getPoint() {
		return Point;
	}
	/**
	 * @param point the point to set
	 */
	public void setPoint(String point) {
		Point = point;
	}




}

package salesman.vo.mypage;

import java.io.Serializable;
import java.util.Date;

public class ReceiptVO implements Serializable {

	private static final long serialVersionUID = 1L;

	private Date requestDate;
	private String amount;
	private String point;
	private String totalPoint;
	private String status;
	private String status_nm;
	private Date confirmDate;
	
	private String salesman_id; // 결제 신청자 아이디
	private int id; // cash Pk
	
		
	/**
	 * @return the id
	 */
	public int getId() {
		return id;
	}
	/**
	 * @param id the id to set
	 */
	public void setId(int id) {
		this.id = id;
	}
	/**
	 * @return the salesman_id
	 */
	public String getSalesman_id() {
		return salesman_id;
	}
	/**
	 * @param salesman_id the salesman_id to set
	 */
	public void setSalesman_id(String salesman_id) {
		this.salesman_id = salesman_id;
	}
	public Date getRequestDate() {
		return requestDate;
	}
	public void setRequestDate(Date requestDate) {
		this.requestDate = requestDate;
	}
	public String getAmount() {
		return amount;
	}
	public void setAmount(String amount) {
		this.amount = amount;
	}
	public String getPoint() {
		return point;
	}
	public void setPoint(String point) {
		this.point = point;
	}
	public String getTotalPoint() {
		return totalPoint;
	}
	public void setTotalPoint(String totalPoint) {
		this.totalPoint = totalPoint;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getStatus_nm() {
		return status_nm;
	}
	public void setStatus_nm(String status_nm) {
		this.status_nm = status_nm;
	}
	public Date getConfirmDate() {
		return confirmDate;
	}
	public void setConfirmDate(Date confirmDate) {
		this.confirmDate = confirmDate;
	}	
}

package salesman.vo.mypage;

public class PaymentVO {
	
	private String userId;
	private String amount;
	private String receipter_nm;
	private String point;
	private String status;
	private String payment_day;
	
	
	
	public String getPayment_day() {
		return payment_day;
	}
	public void setPayment_day(String payment_day) {
		this.payment_day = payment_day;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getAmount() {
		return amount;
	}
	public void setAmount(String amount) {
		this.amount = amount;
	}
	public String getReceipter_nm() {
		return receipter_nm;
	}
	public void setReceipter_nm(String receipter_nm) {
		this.receipter_nm = receipter_nm;
	}
	
	
	public String getPoint() {
		return point;
	}
	public void setPoint(String point) {
		this.point = point;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
	@Override
	public String toString() {
		return "PaymentVO [userId=" + userId + ", amount=" + amount
				+ ", receipter_nm=" + receipter_nm + ", point=" + point
				+ ", status=" + status + "]";
	}

	

}

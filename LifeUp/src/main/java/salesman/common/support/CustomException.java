package salesman.common.support;

public class CustomException extends RuntimeException{	

	private static final long serialVersionUID = 1L;
	
	public String customMsg;

	public String getCustomMsg() {
		return customMsg;
	}

	public void setCustomMsg(String customMsg) {
		this.customMsg = customMsg;
	}

	public CustomException(String customMsg) {
		this.customMsg = customMsg;
	}
}
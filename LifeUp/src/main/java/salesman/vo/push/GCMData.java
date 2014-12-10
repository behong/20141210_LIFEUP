package salesman.vo.push;

public class GCMData {

	private String message;
	private String params;
	
	public GCMData() {}

	public GCMData(String message) {
		this.message = message;
	}
	
	public GCMData(String message, String params) {
		this.message = message;
		this.params = params;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getParams() {
		return params;
	}

	public void setParams(String params) {
		this.params = params;
	}

	@Override
	public String toString() {
		return "GCMData [message=" + message + ", params=" + params + "]";
	}


	
	
}

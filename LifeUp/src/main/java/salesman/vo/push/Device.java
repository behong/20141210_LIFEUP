package salesman.vo.push;

import java.io.Serializable;

public class Device implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private int id;
	private String uuid;
	private String phone;
	private String reg_Id;
	private String user_id;
	


	public Device() {}

	public Device(int id, String uuid, String phone, String regId, String user_id) {
		super();
		this.id = id;
		this.uuid = uuid;
		this.phone = phone;
		this.reg_Id = regId;
		this.user_id = user_id;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getUuid() {
		return uuid;
	}

	public void setUuid(String uuid) {
		this.uuid = uuid;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getReg_Id() {
		return reg_Id;
	}

	public void setReg_Id(String reg_Id) {
		this.reg_Id = reg_Id;
	}
	
	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

}

package salesman.vo.account;

import java.io.Serializable;

public class LoginVO implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	/** 사용자 타입 (일본사용자/영업사원) */
	private int userType;
	/** 사용자 ID */
	private String userId;	
	/** 비밀번호 */
	private String password;
	/** 비밀번호 초기화 유무*/
	private String initPwd;	
	/** 사용자명 */
	private String userNm;
	/** 전화번호 */
	private String mobile;
	/** 거주지역 */
	private String region;	
	/** 사무실전화번호 */
	private String officeNo;
	/** 제조업체 */
	private String vendorId;
	/** 제조업체 지점 */
	private String location;	
	/** 소개메시지 */
	private String introMsg;	
	/** 사진 */
	private String photo;
	
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
	public int getUserType() {
		return userType;
	}
	public void setUserType(int userType) {
		this.userType = userType;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}	
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getInitPwd() {
		return initPwd;
	}
	public void setInitPwd(String initPwd) {
		this.initPwd = initPwd;
	}
	public String getUserNm() {
		return userNm;
	}
	public void setUserNm(String userNm) {
		this.userNm = userNm;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getRegion() {
		return region;
	}
	public void setRegion(String region) {
		this.region = region;
	}
	public String getOfficeNo() {
		return officeNo;
	}
	public void setOfficeNo(String officeNo) {
		this.officeNo = officeNo;
	}
	public String getVendorId() {
		return vendorId;
	}
	public void setVendorId(String vendorId) {
		this.vendorId = vendorId;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public String getIntroMsg() {
		return introMsg;
	}
	public void setIntroMsg(String introMsg) {
		this.introMsg = introMsg;
	}
	public String getPhoto() {
		return photo;
	}
	public void setPhoto(String photo) {
		this.photo = photo;
	}
	
	@Override
	public String toString() {
		return "LoginVO [userType=" + userType + ", userId=" + userId
				+ ", password=" + password + ", initPwd=" + initPwd
				+ ", userNm=" + userNm + ", mobile=" + mobile + ", region="
				+ region + ", officeNo=" + officeNo + ", vendorId=" + vendorId
				+ ", location=" + location + ", introMsg=" + introMsg
				+ ", photo=" + photo + "]";
	}	
	
	
}
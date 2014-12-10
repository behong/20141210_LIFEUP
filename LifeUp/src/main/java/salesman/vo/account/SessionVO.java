package salesman.vo.account;

import java.io.Serializable;

public class SessionVO implements Serializable{
		
	private static final long serialVersionUID = 1L;
	
	/** 사용자 타입 (일본사용자/영업사원) */
	private int userType;
	/** 사용자 ID */
	private String userId;
	/** 이름 */
	private String userNm;
	/** 업체 */
	private String vendorId;
	/** 소속 지점 */
	private String vendorLoc;
	/** 핸드폰번호 */
	private String mobile;
	/** 사무실 번호 */
	private String office_no;
	/** 거주지역 **/
	private String sido_cd; //시도
	private String region;  //구군
	/** 비밀번호  */
	private String password;
	/** 이전 등록 비번 (수정시 사용 ) **/
	private String prevPassword;	
	/** 비밀번호 (수정시 사용 ) */
	private String passwordConfirm;	
	/** 영업사원 인기포인트  */
	private int star_point;
	/** 영업사원 잔여 결제포인트  */
	private int cash_point;		
	/** 영업사원 자기소개 */
	private String intro_msg;
	/** 메일수신여부 */
	private String mail_flag;
	/** 푸쉬메시지 수신여부 */
	private String push_flag;	
	private String create_date;
	private String update_date;
	
	public String getPasswordConfirm() {
		return passwordConfirm;
	}
	public void setPasswordConfirm(String passwordConfirm) {
		this.passwordConfirm = passwordConfirm;
	}
	public String getIntro_msg() {
		return intro_msg;
	}
	public void setIntro_msg(String intro_msg) {
		this.intro_msg = intro_msg;
	}
	public String getOffice_no() {
		return office_no;
	}
	public void setOffice_no(String office_no) {
		this.office_no = office_no;
	}
	public int getStar_point() {
		return star_point;
	}
	public void setStar_point(int star_point) {
		this.star_point = star_point;
	}
	public int getCash_point() {
		return cash_point;
	}
	public void setCash_point(int cash_point) {
		this.cash_point = cash_point;
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
	public String getUserNm() {
		return userNm;
	}
	public void setUserNm(String name) {
		this.userNm = name;
	}
	public String getVendorId() {
		return vendorId;
	}
	public void setVendorId(String vendorId) {
		this.vendorId = vendorId;
	}
	public String getVendorLoc() {
		return vendorLoc;
	}
	public void setVendorLoc(String vendorLoc) {
		this.vendorLoc = vendorLoc;
	}
	public String getSido_cd() {
		return sido_cd;
	}
	public void setSido_cd(String sido_cd) {
		this.sido_cd = sido_cd;
	}	
	public String getRegion() {
		return region;
	}
	public void setRegion(String region) {
		this.region = region;
	}	
	public String getPrevPassword() {
		return prevPassword;
	}
	public void setPrevPassword(String prevPassword) {
		this.prevPassword = prevPassword;
	}	
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	@Override
	public String toString() {
		return "SessionVO [userType=" + userType + ", userId=" + userId
				+ ", userNm=" + userNm + ", vendorId=" + vendorId
				+ ", vendorLoc=" + vendorLoc + ", mobile=" + mobile
				+ ", region=" + region + ", prevPassword=" + prevPassword
				+ ", password=" + password + ", create_date=" + create_date
				+ ", update_date=" + update_date + ", mail_flag=" + mail_flag
				+ ", push_flag=" + push_flag + "]";
	}
}
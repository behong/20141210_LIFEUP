package salesman.mypage.service;

import java.util.List;

import salesman.vo.mypage.MypageVO;
import salesman.vo.mypage.ReceiptVO;

public interface MypageService {

	public List<MypageVO> getMypagelist(String user_id,int user_type);
	
	public List<ReceiptVO> getReceiptList(String user_id);
	
	public List<MypageVO> getCashLogList(String user_id);
	
//	public Map<String, String> getOneDevice(String user_id);
//	
//	public int getTotalCount(Map<String, String> params);
//	
//	public int insertPushInfo(Map<String,String> params);
//	
//	public int updatePushInfo(Map<String,String> params);
//	
//	public int getPasschk(Map<String, Object> passMap, int userType);
}

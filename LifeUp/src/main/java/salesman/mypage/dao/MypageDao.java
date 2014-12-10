package salesman.mypage.dao;

import java.util.List;

import salesman.vo.mypage.MypageVO;
import salesman.vo.mypage.ReceiptVO;

public interface MypageDao {

	public List<MypageVO> getMypagelist(String user_id);
	
	public List<MypageVO> getMypageSellerList(String user_id);
	
	public List<ReceiptVO> getReceiptList(String user_id);
	
	public List<MypageVO> getCashLogList(String user_id);

//	public Map<String, String> getOneDevice(String user_id);
//	
//	public int getTotalCount(Map<String, String> params);
//	
//	public int updatePushInfo(Map<String, String> params);
//	
//	public int insertPushInfo(Map<String, String> params);
//	
//	public int passchk_customer(Map<String, Object> passMap);
//
//	public int passchk(Map<String, Object> passMap);
}

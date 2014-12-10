package salesman.mypage.service;

import java.util.List;

import salesman.mypage.dao.MypageDao;
import salesman.vo.mypage.MypageVO;
import salesman.vo.mypage.ReceiptVO;

public class MypageServiceImpl implements MypageService {
	
	private MypageDao mypageDao;
 
	public void setMypageDao(MypageDao mypageDao) {
		this.mypageDao = mypageDao;
	}

	@Override
	public List<MypageVO> getMypagelist(String user_id,int user_type) {
		List<MypageVO> Mypages = null;
		
		if(user_type == 1) {
			 Mypages = mypageDao.getMypagelist(user_id);
		}
		
		if(user_type == 2){
			 Mypages = mypageDao.getMypageSellerList(user_id);	
		}

		return Mypages;			
	}
	
	@Override
	public List<ReceiptVO> getReceiptList(String user_id) {
		return mypageDao.getReceiptList(user_id);
	}

	@Override
	public List<MypageVO> getCashLogList(String user_id) {
		return mypageDao.getCashLogList(user_id);
	}



//	@Override
//	public int getTotalCount(Map<String, String> params) {		
//		return mypageDao.getTotalCount(params);
//	}
//
//	@Override
//	public int insertPushInfo(Map<String, String> params) {
//		return mypageDao.insertPushInfo(params);
//	}
//
//	@Override
//	public int updatePushInfo(Map<String, String> params) {
//		return mypageDao.updatePushInfo(params);
//	}
//
//	@Override
//	public Map<String, String> getOneDevice(String user_id) {	
//		return mypageDao.getOneDevice(user_id);
//	}
//
//	@Override
//	public int getPasschk(Map<String, Object> passMap, int userType) {
//		
//		int chkNo = 0;
//		if(userType == 1){
//			chkNo = mypageDao.passchk_customer(passMap);
//		}
//		
//		if(userType == 2){
//			chkNo = mypageDao.passchk(passMap);	
//		}		
//		
//		return chkNo;
//	}
}

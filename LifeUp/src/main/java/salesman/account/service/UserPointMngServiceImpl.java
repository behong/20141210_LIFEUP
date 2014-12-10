package salesman.account.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import salesman.account.dao.UserPointMngDao;

public class UserPointMngServiceImpl implements UserPointMngService {
		
	private UserPointMngDao userPointMngDao;	    
    
	public void setUserPointMngDao(UserPointMngDao userPointMngDao){
		this.userPointMngDao = userPointMngDao;
	}

	@Override
	public List<HashMap<String, Object>> getSalesRankingList(Map<String, Object> param) {
		return userPointMngDao.getSalesRankingList(param);
	}
	
	@Override
	public List<HashMap<String, Object>> getSalesRankingListforWeekly() {
		return userPointMngDao.getSalesRankingListforWeekly();
	}
	
	@Override
	public List<HashMap<String, Object>> getSalesRankingListforMonthly() {
		return userPointMngDao.getSalesRankingListforMonthly();
	}		
}
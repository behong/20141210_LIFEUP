package salesman.account.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.support.SqlSessionDaoSupport;

public class UserPointMngDaoImpl extends SqlSessionDaoSupport implements UserPointMngDao {

	@Override
	public List<HashMap<String, Object>> getSalesRankingList(Map<String, Object> param) {		
		return getSqlSession().selectList("account.getSalesRankingList", param);
	}	
	
	@Override
	public List<HashMap<String, Object>> getSalesRankingListforWeekly() {		
		return getSqlSession().selectList("account.getSalesRankingListforWeekly");
	}
	
	@Override
	public List<HashMap<String, Object>> getSalesRankingListforMonthly() {		
		return getSqlSession().selectList("account.getSalesRankingListforMonthly");
	}
}

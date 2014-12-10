package salesman.account.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface UserPointMngDao {
	public List<HashMap<String,Object>> getSalesRankingList(Map<String, Object> param);
	public List<HashMap<String,Object>> getSalesRankingListforWeekly();
	public List<HashMap<String,Object>> getSalesRankingListforMonthly();
}

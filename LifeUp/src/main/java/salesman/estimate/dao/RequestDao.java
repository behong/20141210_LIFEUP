package salesman.estimate.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import salesman.vo.estimate.RequestVO;

public interface RequestDao {
	public int registerRequest(RequestVO estimateReqVO);
	
	public HashMap<String, Object> getRequestDetail(int ReqId);
	public int updateRequestHitCnt(int ReqId);
	
	public List<HashMap<String,Object>> getRequestList(Map<String, Object> param);
	public List<HashMap<String,Object>> getHotRequestList(Map<String, Object> param);	
	
	public int updateRequestStatus(RequestVO estimateReqVO);
	
	public int statePoint(String UserID);
}

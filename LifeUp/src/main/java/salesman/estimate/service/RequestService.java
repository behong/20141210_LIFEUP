package salesman.estimate.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import salesman.vo.estimate.RequestVO;

public interface RequestService {
	public int registerRequest(RequestVO estimateReqVO);
	
	public HashMap<String,Object> getRequestDetail(int reqID);
	public int updateRequestHitCnt(int ReqId);
	
	public List<HashMap<String, Object>> getRequestList(Map<String, Object> param);
	public List<HashMap<String, Object>> getHotRequestList(Map<String, Object> param);
	
	public int updateRequestStatus(RequestVO estimateReqVO);
	
	//현재 포인트 조회
	public int statePoint(String UserId);
}

package salesman.estimate.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import salesman.estimate.dao.RequestDao;
import salesman.vo.estimate.RequestVO;

public class RequestServiceImpl implements RequestService {

	private RequestDao requestDao;	    
    
	public void setRequestDao(RequestDao requestDao){
		this.requestDao = requestDao;
	}	
	
	@Override
	public int registerRequest(RequestVO estimateReqVO) {
		return requestDao.registerRequest(estimateReqVO);
	}

	@Override
	public HashMap<String, Object> getRequestDetail(int ReqId) {
		return  requestDao.getRequestDetail(ReqId);
	}
	
	@Override
	public int updateRequestHitCnt(int ReqId) {
		return requestDao.updateRequestHitCnt(ReqId);
	}
	
	@Override
	public List<HashMap<String, Object>> getRequestList(Map<String, Object> param) {
		return requestDao.getRequestList(param);
	}		
	
	@Override
	public List<HashMap<String, Object>> getHotRequestList(Map<String, Object> param) {
		return requestDao.getHotRequestList(param);
	}	
	
	@Override
	public int updateRequestStatus(RequestVO estimateReqVO) {
		return requestDao.updateRequestStatus(estimateReqVO);
	}

	@Override
	public int statePoint(String UserId) {
		return requestDao.statePoint(UserId);
	}
	
	
}

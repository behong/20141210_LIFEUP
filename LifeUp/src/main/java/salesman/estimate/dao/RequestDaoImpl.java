package salesman.estimate.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import salesman.vo.estimate.RequestVO;

public class RequestDaoImpl extends SqlSessionDaoSupport implements RequestDao{
	
	@Override
	public int registerRequest(RequestVO estimateReqVO) {
		return getSqlSession().insert("request.registerRequest",estimateReqVO);
	}

	@Override
	public HashMap<String, Object> getRequestDetail(int ReqId) {
		return getSqlSession().selectOne("request.getRequestDetail",ReqId);
	}
	
	@Override
	public int updateRequestHitCnt(int ReqId) {
		return getSqlSession().update("request.updateRequestHitCnt",ReqId);
	}	
	
	@Override
	public List<HashMap<String, Object>> getRequestList(Map<String, Object> param) {
		List<HashMap<String, Object>> estimateReglist = new ArrayList<HashMap<String,Object>>();
		//estimateReglist = getSqlSession().selectList("request.getRequestList", param);
		estimateReglist = getSqlSession().selectList("request.getRequestList20140828", param);
		
		return estimateReglist;
	}	
	
	@Override
	public List<HashMap<String, Object>> getHotRequestList(Map<String, Object> param) {
		List<HashMap<String, Object>> estimateReglist = new ArrayList<HashMap<String,Object>>();
		estimateReglist = getSqlSession().selectList("request.getHotRequestList", param);
		return estimateReglist;
	}	
	
	@Override
	public int updateRequestStatus(RequestVO estimateReqVO) {
		return getSqlSession().update("request.updateRequestStatus", estimateReqVO);
	}

	@Override
	public int statePoint(String UserID) {
		return getSqlSession().selectOne("request.getStatePoint",UserID);
	}
}

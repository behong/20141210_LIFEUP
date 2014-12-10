package salesman.admin.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import salesman.vo.mypage.ReceiptVO;
import salesman.vo.push.Device;

public class AdminDaoImpl extends SqlSessionDaoSupport implements AdminDao{

	@Override
	public List<Device> getAllDevices() {
		return getSqlSession().selectList("push.getPushList");
	}
	
	@Override
	public Map<String, String> getOneDevice(String user_id) {
		return getSqlSession().selectOne("push.getOneDevice",user_id);
	}

	@Override
	public int getTotalCount(Map<String, String> params) {
		return getSqlSession().selectOne("push.getTotalCount" , params);
	}

	@Override
	public int updatePushInfo(Map<String, String> params) {
		return getSqlSession().insert("push.updatePushInfo", params);
	}

	@Override
	public int insertPushInfo(Map<String, String> params) {
		return getSqlSession().insert("push.insertPushInfo", params);
	}

	@Override
	public List<ReceiptVO> getAllCash(int page) {
		return getSqlSession().selectList("admin.getCashList" ,page);
	}

	@Override
	public Integer getTotalCash() {
		return getSqlSession().selectOne("admin.getCashCount");
	}

	@Override
	public int updateCash(Map<String, String> params) {
		return getSqlSession().update("admin.modifyCashPoint", params);
	}

	@Override
	public int updateSalesCash(Map<String, String> params) {
		return getSqlSession().update("admin.modifySales_Cash", params);
	}
}

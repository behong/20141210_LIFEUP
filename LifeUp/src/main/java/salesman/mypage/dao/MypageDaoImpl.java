package salesman.mypage.dao;

import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import salesman.vo.mypage.MypageVO;
import salesman.vo.mypage.ReceiptVO;

public class MypageDaoImpl extends SqlSessionDaoSupport implements MypageDao{

	@Override
	public List<MypageVO> getMypagelist(String user_id) {
		return getSqlSession().selectList("mypage.getMyList", user_id);
	}

	@Override
	public List<MypageVO> getMypageSellerList(String user_id) {
		return getSqlSession().selectList("mypage.getMySellerList", user_id);
	}
	
	@Override
	public List<ReceiptVO> getReceiptList(String user_id) {
		return getSqlSession().selectList("mypage.getReceiptList", user_id);
	}

	@Override
	public List<MypageVO> getCashLogList(String user_id) {
		return getSqlSession().selectList("mypage.getCashLogList", user_id);
	}
	
//	@Override
//	public Map<String, String> getOneDevice(String user_id) {
//		return getSqlSession().selectOne("push.getOneDevice",user_id);
//	}
//
//	@Override
//	public int getTotalCount(Map<String, String> params) {
//		return getSqlSession().selectOne("push.getTotalCount" , params);
//	}
//
//	@Override
//	public int updatePushInfo(Map<String, String> params) {
//		return getSqlSession().insert("push.updatePushInfo", params);
//	}
//
//	@Override
//	public int insertPushInfo(Map<String, String> params) {
//		return getSqlSession().insert("push.insertPushInfo", params);
//	}
//	
//	@Override
//	public int passchk(Map<String, Object> params) {
//		return getSqlSession().selectOne("mypage.chkPass",params);
//	}
//
//	@Override
//	public int passchk_customer(Map<String, Object> passMap) {
//		return getSqlSession().selectOne("mypage.chkPass_customer",passMap);
//	}
}

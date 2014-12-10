package salesman.common.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import salesman.common.define.RegionVo;

public class CodesDaoImpl extends SqlSessionDaoSupport implements CodesDao{

	@Override
	public List<HashMap<String, Object>> getVendorCodes() {
		List<HashMap<String, Object>> codes = new ArrayList<HashMap<String, Object>>();
		codes = getSqlSession().selectList("common.getVendorCodes");
		return codes;		
	}
	
	@Override
	public List<HashMap<String, Object>> getCarCodes(String carId) {
		List<HashMap<String ,Object>> carCodeList = new ArrayList<HashMap<String,Object>>();
		carCodeList = getSqlSession().selectList("common.getCarCode",carId);
		return carCodeList;
	}

	@Override
	public List<RegionVo> selectSidoTable() {
		List<RegionVo> sidoTableList = new ArrayList<RegionVo>();
		sidoTableList = getSqlSession().selectList("common.getSido");
		return sidoTableList;
	}

	@Override
	public List<RegionVo> selectGuTable(String sido) {
		List<RegionVo> guTableList = new ArrayList<RegionVo>();
		guTableList = getSqlSession().selectList("common.getGu",sido);
		return guTableList;
	}


}

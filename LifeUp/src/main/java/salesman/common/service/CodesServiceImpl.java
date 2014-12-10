package salesman.common.service;

import java.util.HashMap;
import java.util.List;

import salesman.common.dao.CodesDao;
import salesman.common.define.RegionVo;

public class CodesServiceImpl implements CodesService  {

	private CodesDao codesDao;

	public void setCodesDao (CodesDao codesDao){
		this.codesDao = codesDao;
	}

	@Override
	public List<HashMap<String, Object>> getVendorCodes() {
		return codesDao.getVendorCodes();
	}
	
	@Override
	public List<HashMap<String, Object>> getCarCodeList(String carId) {
		return codesDao.getCarCodes(carId);
	}

	@Override
	public List<RegionVo> selectRegionSidoTable() {
		return codesDao.selectSidoTable();
	}

	@Override
	public List<RegionVo> selectRegionGuTable(String sido) {
		return codesDao.selectGuTable(sido);
	}

}

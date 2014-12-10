package salesman.common.dao;

import java.util.HashMap;
import java.util.List;

import salesman.common.define.RegionVo;

public interface CodesDao {	
	public List<HashMap<String, Object>> getVendorCodes();
	public List<HashMap<String, Object>> getCarCodes(String carId);
	
	public List<RegionVo> selectSidoTable();
	public List<RegionVo> selectGuTable(String sido);
	
	//
}

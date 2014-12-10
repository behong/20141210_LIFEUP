package salesman.push.dao;

import java.util.List;
import java.util.Map;

import salesman.vo.push.Device;

public interface PushDao {
	

	public List<Device> getAllDevices();	
	
	public Map<String, String> getOneDevice(String user_id);
	
	public int getTotalCount(Map<String, String> params);
	
	public int updatePushInfo(Map<String, String> params);
	
	public int insertPushInfo(Map<String, String> params);

}

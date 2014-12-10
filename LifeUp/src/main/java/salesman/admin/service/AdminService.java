package salesman.admin.service;

import java.util.List;
import java.util.Map;

import salesman.vo.mypage.ReceiptVO;
import salesman.vo.push.Device;

public interface AdminService {

	public int getTotalCash(); // 캐쉬 카운트
	
	public int updateCash(Map<String, String> params); // 결제테이블 처리
	
	public int updateSalesCash(Map<String, String> params); // 영업사원 테이블 처리
	
	public List<Device> getAllDevices();
	
	public List<ReceiptVO> getAllCash(int page);	
	
	public Map<String, String> getOneDevice(String user_id);
	
	public int getTotalCount(Map<String, String> params);
	
	public int insertPushInfo(Map<String,String> params);
	
	public int updatePushInfo(Map<String,String> params);

}

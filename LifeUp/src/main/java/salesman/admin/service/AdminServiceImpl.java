package salesman.admin.service;

import java.util.List;
import java.util.Map;

import salesman.admin.dao.AdminDao;
import salesman.vo.mypage.ReceiptVO;
import salesman.vo.push.Device;

public class AdminServiceImpl implements AdminService {
	
	private AdminDao AdminDaoPro; 

	public void setAdminDaoPro(AdminDao adminDaoPro) {
		AdminDaoPro = adminDaoPro;
	}

	@Override
	public List<Device> getAllDevices() {		
		List<Device> devices = AdminDaoPro.getAllDevices();
/*		for(Device device :devices){
			//String phone = device.getPhone();
			//device.setPhone(phone.substring(0,phone.length()-2)+"**");
			//String regid = device.getReg_Id();
			//device.setReg_Id(regid.substring(0,Math.min(regid.length(), 10)));
		}*/
		return devices;
	}

	@Override
	public int getTotalCount(Map<String, String> params) {		
		return AdminDaoPro.getTotalCount(params);
	}

	@Override
	public int insertPushInfo(Map<String, String> params) {
		return AdminDaoPro.insertPushInfo(params);
	}

	@Override
	public int updatePushInfo(Map<String, String> params) {
		return AdminDaoPro.updatePushInfo(params);
	}

	@Override
	public Map<String, String> getOneDevice(String user_id) {
		return AdminDaoPro.getOneDevice(user_id);
	}

	@Override
	public List<ReceiptVO> getAllCash(int page){
		int changePage = (page-1) * 20;  //20건씩
		List<ReceiptVO> cashList = AdminDaoPro.getAllCash(changePage);
		return cashList;
	}

	@Override
	public int getTotalCash() {
		return AdminDaoPro.getTotalCash();
	}

	@Override
	public int updateCash(Map<String, String> params) {
		return AdminDaoPro.updateCash(params);
	}

	@Override
	public int updateSalesCash(Map<String, String> params) {
		 return AdminDaoPro.updateSalesCash(params);
	}

	
}

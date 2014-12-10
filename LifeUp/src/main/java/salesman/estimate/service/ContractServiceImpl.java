package salesman.estimate.service;

import java.util.HashMap;
import java.util.List;

import salesman.estimate.dao.ContractDao;
import salesman.vo.estimate.ContractReplyVO;
import salesman.vo.estimate.ContractVO;

public class ContractServiceImpl implements ContractService {

	private ContractDao contractDao;
	
	private int _DEFAULT_CASH_POINT;
	
	public void set_DEFAULT_CASH_POINT(int cashPoint) {
		this._DEFAULT_CASH_POINT = cashPoint;
	}
	
	public int getDefaultCashPoint() {
		return this._DEFAULT_CASH_POINT;
	}
	
	public void setContractDao(ContractDao contractDao){
		this.contractDao = contractDao;
	}		
	
	@Override
	public List<HashMap<String, Object>> getContractList(int reqId, String userId) {
		return contractDao.getContractList(reqId, userId);
	}
	
	@Override
	public int registerContract(ContractVO contractVO) {
		return contractDao.registerContract(contractVO);
	}
	
	@Override
	public int modifyContract(ContractVO contractVO) {
		return contractDao.modifyContract(contractVO);
	}	
	
	@Override
	public int registerContractReply(ContractReplyVO contractReplyVO) {
		return contractDao.registerContractReply(contractReplyVO);
	}
	
	@Override
	public List<HashMap<String, Object>> getContractReplyList(int request_id, String salesman_id) {
		return contractDao.getContractReplyList(request_id, salesman_id);
	}
	
	@Override
	public int updateContractStatus(ContractVO contractVO) {
		return contractDao.updateContractStatus(contractVO);
	}
	
	@Override
	public boolean useCashPoint(int request_id, String salesman_id) {
		return contractDao.useCashPoint(request_id, salesman_id, this.getDefaultCashPoint());
	}
}

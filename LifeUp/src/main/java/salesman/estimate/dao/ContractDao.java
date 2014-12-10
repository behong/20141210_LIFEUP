package salesman.estimate.dao;

import java.util.HashMap;
import java.util.List;

import salesman.vo.estimate.ContractReplyVO;
import salesman.vo.estimate.ContractVO;

public interface ContractDao {
	public int registerContract(ContractVO contractVO);
	public int modifyContract(ContractVO contractVO);	
	public List<HashMap<String, Object>> getContractList(int reqId, String userId);
		
	public int registerContractReply(ContractReplyVO contractReplyVO);
	public List<HashMap<String, Object>> getContractReplyList(int request_id, String salesman_id);
	
	public int updateContractStatus(ContractVO contractVO);
	
	public boolean useCashPoint(int request_id, String salesman_id, int useCashPoint);
}

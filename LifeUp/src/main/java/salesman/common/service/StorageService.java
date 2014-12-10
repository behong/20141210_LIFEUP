package salesman.common.service;

import salesman.vo.account.SessionVO;

public interface StorageService {
	void SessionOut();
	
	SessionVO getAuthenticatedUser();
	Object getSessionAttribute(String attribute);
	boolean setSessionAttribute(String attribute, Object value);
	
	boolean removeSessionAttribute(String attribute);	
}

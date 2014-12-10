package salesman.common.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;

import salesman.common.define.Values;
import salesman.vo.account.SessionVO;

public class StorageServiceImpl implements StorageService {
	
	@Autowired(required=true)
	private HttpServletRequest request;
	
	@Override
	public void SessionOut() {
		request.getSession().invalidate();
	}		

	@Override
	public SessionVO getAuthenticatedUser() {
		return (SessionVO) getSessionAttribute(Values._SESSION_USER_);
	}
		
	@Override
	public Object getSessionAttribute(String attribute) {
		try {			
			return request.getSession().getAttribute(attribute); 
		} catch (Exception e) {
			return null;
		}		
	}
	
	@Override
	public boolean setSessionAttribute(String attribute, Object value) {
		try {		
			request.getSession().setAttribute(attribute, value);
			return true; 
		} catch (Exception e) {
			return false;
		}		
	}
	
	@Override
	public boolean removeSessionAttribute(String attribute) {
		try {		
			request.getSession().removeAttribute(attribute);
			return true; 
		} catch (Exception e) {
			return false;
		}
	}	
}

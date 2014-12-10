package salesman.account.service;

import salesman.account.dao.AccountDao;
import salesman.common.define.Values;
import salesman.common.service.StorageService;
import salesman.common.util.FileScrty;
import salesman.vo.account.LoginVO;
import salesman.vo.account.SessionVO;
import salesman.vo.mypage.PaymentVO;

public class AccountServiceImpl implements AccountService {
	
	private StorageService storageService;
	private AccountDao accountDao;	    
    
	public void setStorageService(StorageService storageService){
		this.storageService = storageService;
	}
	
	public void setAccountDao(AccountDao accountDao){
		this.accountDao = accountDao;		
	}		
	
	@Override
	public SessionVO getUserInfo(LoginVO login) {		
		SessionVO loginInfo = this.accountDao.getUserInfo(login);
		return loginInfo;
	}
	
	@Override
	public SessionVO tryLogin(LoginVO login) {
		
		String password = "";
		SessionVO loginInfo = null;
		
		try {			
			password = FileScrty.encryptPassword(login.getPassword());
			login.setPassword(password);
			
			loginInfo = this.accountDao.tryLogin(login);
			
			if(loginInfo != null)
				storageService.setSessionAttribute(Values._SESSION_USER_, loginInfo);
			
		} catch (Exception e) {
			return null;
		}		
		
		return loginInfo;
	}

	@Override
	public boolean modifyUserInfo(SessionVO userInfo) {
		
		String prevPassword = "";
		String password = "";
		try {			
			if(userInfo.getPassword() != null) {
				password = FileScrty.encryptPassword(userInfo.getPassword());
				prevPassword = FileScrty.encryptPassword(userInfo.getPrevPassword());
				
				userInfo.setPassword(password);
				userInfo.setPrevPassword(prevPassword);
			}	
		
			return this.accountDao.modifyUserInfo(userInfo);
			
		} catch (Exception e) {			
			return false;
		}		
	}	
	
	@Override
	public boolean modifyUserPasswd(SessionVO userInfo) {
		
		String prevPassword = "";
		String password = "";
		
		try {			
			if(userInfo.getPassword() != null) {
				password = FileScrty.encryptPassword(userInfo.getPassword());				
				userInfo.setPassword(password);
			}
			
			return this.accountDao.modifyUserPasswd(userInfo);
		} catch (Exception e) {
			return false;
		}
	}
	
	@Override
	public SessionVO getUserById(LoginVO login) {
		return this.accountDao.getUserById(login);
	}
	
	@Override
	public boolean registerAccount(LoginVO userInfo) {
		String password = "";
		boolean rtnValue = false;
		
		try {
			password = FileScrty.encryptPassword(userInfo.getPassword());
			userInfo.setPassword(password);
			
			rtnValue = this.accountDao.registerAccount(userInfo);
		} catch (Exception e) {
			return false;
		}				
				
		return rtnValue;
	}

	@Override
	public boolean addPoint(PaymentVO user) {
		
		try {
			//신청 성공 리터~~언
			return this.accountDao.addPoint(user);
		}catch  (Exception e){
			return false;
		}
		
	}
}

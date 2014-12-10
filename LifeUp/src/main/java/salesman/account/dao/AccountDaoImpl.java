package salesman.account.dao;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import salesman.vo.account.LoginVO;
import salesman.vo.account.SessionVO;
import salesman.vo.mypage.PaymentVO;

public class AccountDaoImpl extends SqlSessionDaoSupport implements AccountDao {
	
	@Override
	public SessionVO getUserInfo(LoginVO login) {
		SessionVO userInfo = (SessionVO) getSqlSession().selectOne("account.getUserInfo", login);		
		return userInfo;
	}
	
	@Override
	public SessionVO tryLogin(LoginVO login) {
		SessionVO user = null;
		
		String userType = (String) getSqlSession().selectOne("account.getUserType", login);		
		login.setUserType(Integer.parseInt(userType));
		
		if(login.getUserType() == 1)
			user = (SessionVO) getSqlSession().selectOne("account.getUser", login);		
		else
			user = (SessionVO) getSqlSession().selectOne("account.getSalesman", login);
		
		if(user != null)
			user.setUserType(login.getUserType());
		
		return user;
	}

	@Override
	public boolean modifyUserInfo(SessionVO user) {
		int rtnValue = 0;
		
		String userType = (String) getSqlSession().selectOne("account.getUserType", user);		
		user.setUserType(Integer.parseInt(userType));
		
		if(user.getUserType() == 1){
			if(user.getPrevPassword() != null ){
				rtnValue = getSqlSession().update("account.modifyCustomerInfo", user);	
			}else{
				rtnValue = getSqlSession().update("account.modifyCustomerInfo_agree", user);	
			}
		}else{
			if(user.getPrevPassword() != null ){
				rtnValue = getSqlSession().update("account.modifySalesmanInfo", user);
			}else{	
				rtnValue = getSqlSession().update("account.modifySalesmanInfo_agree", user);	
			}
		}
			
		return rtnValue > 0 ? true : false;
	}
	
	@Override
	public boolean modifyUserPasswd(SessionVO user) {
		int rtnValue = 0;
		
		String userType = (String) getSqlSession().selectOne("account.getUserType", user);		
		user.setUserType(Integer.parseInt(userType));
		
		if(user.getUserType() == 1)
			rtnValue = getSqlSession().update("account.modifyCustomerPasswd", user);		
		else
			rtnValue = getSqlSession().update("account.modifySalesmanPasswd", user);
			
		return rtnValue > 0 ? true : false;
	}	
	
	@Override
	public SessionVO getUserById(LoginVO login) {
		SessionVO user = null;		
		
		String userType = (String) getSqlSession().selectOne("account.getUserType", login);		
		login.setUserType(Integer.parseInt(userType));
		
		if(login.getUserType() == 1)
			user = (SessionVO) getSqlSession().selectOne("account.getUserById", login);		
		else
			user = (SessionVO) getSqlSession().selectOne("account.getSalesmanById", login);
		
		return user;
	}
	
	@Override
	public boolean registerAccount(LoginVO userInfo) {
		int rtnValue = 0;
		
		if(userInfo.getUserType() == 1)
			rtnValue = getSqlSession().update("account.registerCustomer", userInfo);		
		else if(userInfo.getUserType() == 2)
			rtnValue = getSqlSession().update("account.registerSalesman", userInfo);
			
		return rtnValue > 0 ? true : false;
	}

	@Override
	public boolean addPoint(PaymentVO user) {
		int rtnValue = 0;
		rtnValue = getSqlSession().insert("account.registerPoint", user);
		return rtnValue > 0 ? true : false;
	}
}

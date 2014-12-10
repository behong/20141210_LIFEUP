package salesman.account.service;

import salesman.vo.account.LoginVO;
import salesman.vo.account.SessionVO;
import salesman.vo.mypage.PaymentVO;

public interface AccountService {
	SessionVO getUserInfo(LoginVO login);
	SessionVO tryLogin(LoginVO login);
	
	boolean modifyUserInfo(SessionVO user);
	boolean modifyUserPasswd(SessionVO user);
	
	SessionVO getUserById(LoginVO login);
	
	boolean registerAccount(LoginVO userInfo);
	
	boolean addPoint(PaymentVO user);
	
}

package salesman.account.dao;

import salesman.vo.account.LoginVO;
import salesman.vo.account.SessionVO;
import salesman.vo.mypage.PaymentVO;

public interface AccountDao {
	SessionVO getUserInfo(LoginVO login);
	SessionVO tryLogin(LoginVO login);
	
	boolean modifyUserInfo(SessionVO user);
	boolean modifyUserPasswd(SessionVO user);
	
	SessionVO getUserById(LoginVO login);
	
	boolean registerAccount(LoginVO user);
	
	boolean addPoint(PaymentVO user);
}

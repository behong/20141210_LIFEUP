package salesman.common.service;

import org.springframework.beans.factory.annotation.Autowired;

import salesman.account.service.AccountService;
import salesman.common.util.NumberUtil;
import salesman.common.util.StringUtil;
import salesman.vo.account.LoginVO;
import salesman.vo.account.SessionVO;

public class MailingMessageImpl implements MailingMessage {
	
	@Autowired
	public AccountService accountService;
	
    public void setAccountService(AccountService accountService) {  
        this.accountService = accountService;  
    }
	
	private boolean useHtml = false;
	private String content = "";
	
	@Override
	public boolean useHtml() {
		return this.useHtml;
	}
	
	@Override
	public String getTextContent() {
		return content;
	}
	
	@Override
	public void setTextContent(String message) {			
		this.content = message;
		this.useHtml = false;
	}

	@Override
	public String getHtmlContent() {
		return content;
	}
	
	@Override
	public void setHtmlContent(String type, LoginVO user) {
		this.useHtml = true;	
		
		SessionVO userInfo = null;
		StringBuilder message = new StringBuilder();
		String newPasswd = "";
		
		try {
			userInfo = accountService.getUserById(user);
			
			if(userInfo == null) {
				this.content = "";
				return;
			}
			
			if(type.equals("ID")) {
				message.append("<span>");
				message.append(userInfo.getUserNm()).append("님의 ID는 ");
				message.append("<b>").append(userInfo.getUserId()).append("</b>");
				message.append(" 입니다");
				message.append("</span>");
			} else {			
		    	for (int i = 1; i <= 6; i++) {
		    		// 영자
		    		if (i % 3 != 0) {
		    			newPasswd += StringUtil.getRandomStr('a', 'z');
		    		// 숫자
		    		} else {
		    			newPasswd += NumberUtil.getRandomNum(0, 9);
		    		}
		    	}
		    	
				userInfo.setPassword(newPasswd);	
				accountService.modifyUserPasswd(userInfo);
				
				message.append("<span>");
				message.append(userInfo.getUserNm()).append("님의 새로 발급된 비밀번호는 ");
				message.append("<b>").append(newPasswd).append("</b>");
				message.append(" 입니다");
				message.append("</span>");
			}				
			
			this.content = message.toString();
		} catch (Exception e) {
			this.content = "";
		}
	}
}
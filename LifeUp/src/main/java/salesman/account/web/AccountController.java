package salesman.account.web;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import salesman.account.service.AccountService;
import salesman.common.define.RegionVo;
import salesman.common.service.CodesService;
import salesman.common.service.MailingMessage;
import salesman.common.service.MailingService;
import salesman.common.service.StorageService;
import salesman.common.support.CustomException;
import salesman.push.service.PushService;
import salesman.vo.account.LoginVO;
import salesman.vo.account.SessionVO;

@Controller
public class AccountController {
    @Autowired
    private StorageService storageService;
	
	@Autowired
	private AccountService accountService;
	
	@Autowired
	private MailingService mailingService;
	
	@Autowired
	private MailingMessage mailingMessage;
	
	@Autowired
	private CodesService codesService;	
	
	@Autowired
	private PushService pushService;
	   	       
    @RequestMapping(value="/account/logout")
    public String logout() 
    {
    	storageService.SessionOut();
    	return "redirect:/main";
    }

    @RequestMapping(value="/account/login")
    public String login() 
    {
    	return "/account/login";
    }

    
    @RequestMapping(value="/account/autoLogin" , method=RequestMethod.POST)
    public String autoLogin(@RequestParam Map<String, String> params) {
     	System.out.println("POST TEST : " + params.size()); 	
     	System.out.println("POST TEST toString: " + params.toString());
     	
    	LoginVO loginVO = new LoginVO();    	
    	loginVO.setUserId(params.get("webId").toString());
    	loginVO.setPassword(params.get("webP").toString());
    	loginVO.setUserType(Integer.parseInt(params.get("webType").toString()));
    	
    	accountService.tryLogin(loginVO);    	
     	return "redirect:/main";
    }
    
    /*
     * 로그인처리
     */
    @RequestMapping(value="/account/actionLogin", produces={"application/xml", "application/json"} )
    public @ResponseBody Map<String, Object> actionLogin(@RequestBody LoginVO loginVO) {     
    	
    	String message = "success";    	
    	SessionVO userInfo = null;    	  	
    	
    	Map<String, Object> result = new HashMap<String, Object>();    	
    	
    	try {    		
        	if(loginVO == null || loginVO.getUserId() == null || loginVO.getPassword() == null) {
        		message = "아이디와 비밀번호를 입력하세요";
        	} else {  
        		if(storageService.getAuthenticatedUser() != null) {
        			message = "duplicated";
        		} else if(accountService.getUserInfo(loginVO) != null) {	    	
        			userInfo = accountService.tryLogin(loginVO);	    	
			    	if (userInfo == null) {
			    		message = "로그인에 실패했습니다. 입력정보를 확인하세요";
		    		} else {
		    			message = "success";		    			
			    	}
		    	} else {
		    		message = "회원가입 후 로그인 해주세요";
		    	}	    			    		    
        	}	    		        	    		        
        	
    		result.put("message", message);    		
    		
    	} catch (Exception ex) {
    		result.put("message", "서버오류가 발생했습니다");
    	}
    	
    	return result;
    }   
    
    /*
     * 스마트폰 ID UPDATE
     */
    @RequestMapping(value="/account/app" ,method=RequestMethod.POST)
    public void appPost(@RequestParam String userId, @RequestParam String appId, @RequestParam String uuId, 
    		@RequestParam String phone, ModelMap model) {
    	
    	try {
	    	SessionVO userInfo = storageService.getAuthenticatedUser();
	    	
	    	if(userInfo != null) {    
	    		if(!appId.equals("") && userInfo.getUserId().equals(userId)) {    			
	    			Map<String, String> params = new HashMap<String, String>();    			
	    			params.put("webId", userId);
	    			params.put("reg_id", appId);
	    			params.put("uuid", uuId);
	    			params.put("phone", phone);
	    			
	    			if(pushService.updatePushInfo(params) == 0) {
	    				pushService.insertPushInfo(params);
	    			}
	    		}
			}
    	} catch (Exception ex) {}
    }              
          
    @RequestMapping("/account/membership")
	public void membership(ModelMap model) {
    	List<HashMap<String, Object>> vendors = codesService.getVendorCodes();
    	List<RegionVo> regions = codesService.selectRegionSidoTable();
    	
    	model.put("vendorCodes", vendors);
    	model.put("regions", regions);
    }
    
    /*
     * 회원가입시 ID 중복검색
     */
    @RequestMapping(value="/account/chkExistUserId" )
    public void chkExistUserId(@RequestParam int userType, @RequestParam String userId, HttpServletResponse response) throws IOException {
    	
    	LoginVO loginVO = new LoginVO();
    	loginVO.setUserType(userType);
    	loginVO.setUserId(userId);
    	
    	try {    		    		     		        	
        	SessionVO userInfo = accountService.getUserInfo(loginVO);
        	
        	if(userInfo != null)
        		response.getWriter().print("false");        	
        	else
        		response.getWriter().print("true");
    	} catch(Exception ex) {
    		response.getWriter().print("false");
    	}    	
    } 
    
    /*
     * 회원가입 등록
     */
    @RequestMapping("/account/register")
    public String register(@ModelAttribute LoginVO userInfo){
    	if(accountService.registerAccount(userInfo))    	
    		return "redirect:/main.do";
    	else
    		throw new CustomException("회원가입 중 오류가 발생했습니다");    	
    }
    
    /*
     * 사용자 찾기
     */
    @RequestMapping(value="/account/findUser", produces={"application/xml", "application/json"} )
    public @ResponseBody Map<String, Object> findUser(@RequestBody LoginVO loginVO, HttpServletRequest request) {
    	
    	Map<String, Object> result = new HashMap<String, Object>();
    	
    	try {    		    		     		
    		mailingMessage.setHtmlContent("ID", loginVO);
    		
    		if(mailingMessage.getHtmlContent().equals("")) {
    			result.put("message", "등록되지 않은 사용자입니다. 입력정보를 확인하세요");
    		} else {
    			mailingService.sendMail("hk@retailtech.co.kr", loginVO.getUserId(), "[HK] 계정정보 안내메일", mailingMessage);    		
    			result.put("message", "success");
    		}
    	} catch(Exception ex) {
    		result.put("message", "서버오류가 발생했습니다");
    	}
    	
    	return result;
    }
    
    /*
     * 사용자비밀번호 찾기
     */
    @RequestMapping(value="/account/findPwd", produces={"application/xml", "application/json"} )
    public @ResponseBody Map<String, Object> findPwd(@RequestBody LoginVO loginVO, HttpServletRequest request) {

    	Map<String, Object> result = new HashMap<String, Object>();    	
    	
    	try {    		    		    		
    		loginVO.setInitPwd("Y");    		
    		mailingMessage.setHtmlContent("PWD", loginVO);
    		
    		if(mailingMessage.getHtmlContent().equals("")) {
    			result.put("message", "등록되지 않은 사용자입니다. 입력정보를 확인하세요");
    		} else {
    			mailingService.sendMail("hk@retailtech.co.kr", loginVO.getUserId(), "[HK] 계정정보 안내메일", mailingMessage);
    			result.put("message", "success");
    		}    		    		
    	} catch(Exception ex) {
    		result.put("message", "서버오류가 발생했습니다");
    	}
    	
    	return result;
    }
    
//    @RequestMapping(value="/account/myInfoUpdate", produces={"application/xml", "application/json"} )
//    public @ResponseBody Map<String, Object> myInfoUpdate(@RequestBody SessionVO param, HttpServletRequest request) {
//
//    	Map<String, Object> result = new HashMap<String, Object>();
//    	SessionVO userInfo = null;
//    	
//    	try {    		
//    		userInfo = storageService.getAuthenticatedUser();
//    		
//    		if(userInfo == null) {
//	    		result.put("message", "로그인한 사용자가 아닙니다");    			
//    		} else {
//	    		param.setUserId(userInfo.getUserId());
//	    		param.setUserType(userInfo.getUserType());    		
//	
//	        	if(accountService.modifyUserInfo(param))
//	    			result.put("message", "success");
//	    		else
//	    			result.put("message", "정보수정에 실패했습니다. 입력정보를 확인하세요");
//    		}
//    	} catch(Exception ex) {
//    		result.put("message", "서버오류가 발생했습니다");
//    	} 
//    	
//    	return result;
//    }  
    
//    @RequestMapping(value="/account/myInfo", produces={"application/xml", "application/json"} )
//    public @ResponseBody Map<String, Object> myInfo(HttpServletRequest request) {
//    	
//    	SessionVO userInfo = null;
//    	LoginVO user = new LoginVO();
//    	Map<String, Object> result = new HashMap<String, Object>();
//    	
//    	try {
//    		userInfo = storageService.getAuthenticatedUser();
//    		
//    		if(userInfo == null) {
//	    		result.put("message", "로그인한 사용자가 아닙니다");    			
//    		} else {
//	        	user.setUserType(userInfo.getUserType());
//	        	user.setUserId(userInfo.getUserId());
//	        	
//	    		userInfo = accountService.getUserInfo(user);
//	    		
//	    		result.put("message", "success");
//	    		result.put("userInfo", userInfo);
//    		}
//    	} catch(Exception ex) {
//    		result.put("message", "서버오류가 발생했습니다");
//    	} 
//    	
//    	return result;
//    }  
}
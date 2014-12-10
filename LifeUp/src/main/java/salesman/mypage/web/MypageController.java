package salesman.mypage.web;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import salesman.account.service.AccountService;
import salesman.common.service.CodesService;
import salesman.common.service.StorageService;
import salesman.estimate.service.RequestService;
import salesman.mypage.service.MypageService;
import salesman.vo.account.LoginVO;
import salesman.vo.account.SessionVO;
import salesman.vo.mypage.MypageVO;
import salesman.vo.mypage.ReceiptVO;

@Controller
@RequestMapping("/mypage/*")
public class MypageController {
	
	@Autowired
	private MypageService mypageService;
	
    @Autowired
    private StorageService storageService;	
    
	@Autowired
	private RequestService requestService;

	@Autowired
	private AccountService accountService;
	
	@Autowired
    private CodesService codeService;
   
    @RequestMapping("/list")
    public String list(ModelMap model)
    {
    	LoginVO loginVO = new LoginVO();
		List<MypageVO> contractList = new ArrayList<MypageVO>();
		List<ReceiptVO> receiptList = new ArrayList<ReceiptVO>();
		List<MypageVO>cashLogList = new ArrayList<MypageVO>();
		
		SessionVO userInfo = storageService.getAuthenticatedUser();
		
		if(userInfo == null) {
			return "redirect:/account/login";
		} 
		
		loginVO.setUserId(userInfo.getUserId());
		loginVO.setUserType(userInfo.getUserType());
			   	
    	contractList = mypageService.getMypagelist(userInfo.getUserId(), userInfo.getUserType());
    	receiptList  = mypageService.getReceiptList(userInfo.getUserId());
    	//cash 사용 내역 
    	cashLogList = mypageService.getCashLogList(userInfo.getUserId());
    	userInfo     = accountService.getUserInfo(loginVO);
    	
    	model.put("cashLogList", cashLogList);
    	model.put("contractList", contractList);
    	model.put("receiptList", receiptList);    	
		model.put("userInfo", userInfo);		
		
    	model.put("regions", codeService.selectRegionSidoTable());
    	model.put("venders", codeService.getVendorCodes());
		
    	return "mypage/myList";
    }
    
    /*내정보 수정*/
    @RequestMapping(value="/update", produces={"application/xml", "application/json"} )
    public @ResponseBody Map<String, Object> update(@RequestBody SessionVO sessionVO, ModelMap model) {
    	   	
		if(sessionVO.getUserId().length() < 1) {		
			model.put("message","로그인한 사용자가 아닙니다");			
		} else {
			if(!accountService.modifyUserInfo(sessionVO)) {				
				model.put("message","이전 비밀번호를 확인하세요");
	    	} else {
	    		model.put("message","저장 되었습니다");
	    	}
		}	
		
		return model;
    }
    
    /*내정보 다시 읽기*/
    @RequestMapping(value="/reading", produces={"application/xml", "application/json"} )
    public @ResponseBody Map<String, Object> reading(@RequestBody SessionVO sessionVO, ModelMap model) {
    	   	
		if(sessionVO.getUserId().length() < 1) {		
			model.put("message","로그인한 사용자가 아닙니다");			
		} else {
			LoginVO loginVO = new LoginVO();
			
			loginVO.setUserId(sessionVO.getUserId());
			loginVO.setUserType(sessionVO.getUserType());
			
			model.put("userInfo", accountService.getUserInfo(loginVO));		
			model.put("message","디비 리딩 완료");
			
			System.out.println("model==============    " + model.toString());
		}	
		
		return model;
    }
    
    
    /* push, 메일링 설정 */
    @RequestMapping(value="/configUpdate", produces={"application/xml", "application/json"} )
    public @ResponseBody Map<String, Object> configUpdate(@RequestBody SessionVO sessionVO, ModelMap model) {    	
		if(sessionVO.getUserId().length() < 1) {
			model.put("message","로그인한 사용자가 아닙니다");    			
		} else {			
	    	if(accountService.modifyUserInfo(sessionVO))
	    		model.put("message","적용 되었습니다");
	    	else
	    		model.put("message","오류가 발생했습니다");
		}	
		
		return model;
    }
    
   
}

package salesman.admin.web;

import java.util.Map;

import org.omg.CORBA.PRIVATE_MEMBER;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import salesman.admin.service.AdminService;
import salesman.common.service.StorageService;
import salesman.vo.account.LoginVO;
import salesman.vo.account.SessionVO;

/**
 * Handles requests for the application home page.
	각 메서드에는 @RequestMapping 애노테이션에 사용자가 요청하는 url과 요청 형식에 따라 실행해야 할 메서드를 선언했습니다. 
	@RequestParam은 요청 방식에 상관 없이 해당 url 요청과 함께 전달 된 파라미터 값이 메서드의 각 인자로 전달되도록 설정했습니다. 
	여기서, Model은 Map 형식의 객체로서 뷰 단에 값을 전달하기 위한 클래스입니다. 
	Authentication은 스프링 시큐리티로 로그인에 성공 했을 때, 전달되는 객체입니다. 
	만약, 해당 url이 로그인을 수행하지 않은 사용자에 의해 요청 된다면 Authentication 객체는 전달되지 않으므로 해당 인자는 null이 됩니다. 
	반대로 로그인이 성공하였다면 Authentication 객체를 이용하여 사용자의 계정 등을 알아 낼 수 있습니다
 */

@Controller
@RequestMapping("/admin/*")
public class AdminController {
	
	private static final int TOTAL_PAGE_LINK = 10;
	
	@Autowired
	private AdminService adminService;
	
	 @Autowired
	    private StorageService storageService;
	
	@RequestMapping(value = {"/", "/index"}, method = RequestMethod.GET)
	public String index(Model model,Authentication authentication) {
		
		LoginVO user = new LoginVO();
		SessionVO userInfo = storageService.getAuthenticatedUser();		
		if(userInfo == null)
			return "/account/login";		
		
		return "admin/index";		
	}
	@RequestMapping(value = {"/billing_management"}, method = RequestMethod.GET)
	public String billing_management(@RequestParam(value = "page" ,required = false, defaultValue = "1" ) Integer page
			,ModelMap model,Authentication authentication) {

		
		
		int currPage = 1 ; // page가 없으면 첫 번째 페이지
		if(page != null){	//page 파라미터 있으면 해당 페이지를 현재 페이지로.
			currPage = page.intValue();
		}
		
		// 전체 페이지 개수
		int totalPage = adminService.getTotalCash();
		
		int lastLink =  (int)Math.ceil((double)currPage / TOTAL_PAGE_LINK)  * TOTAL_PAGE_LINK;
		int firstPage = lastLink -  (TOTAL_PAGE_LINK -1);
		
		//현재 페이지가 5 이면  5/10  = 0.5 올림 1이고 1*10 =10
		// 단 마지막 페이지가 전체 페이지를 초과하면 , 마지막 페이지가 전체 페이지가 된다.
		int lastPage = Math.min(lastLink, totalPage);
		
		model.put("currPage", currPage);
		model.put("totalPage", totalPage);
		model.put("firstPage", firstPage);
		model.put("lastPage", lastPage);		
		
		model.put("cashList", adminService.getAllCash(currPage) );
		
		return "admin/billing_management";		
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login(@RequestParam(value = "login_error", required = false) String login_error,
			Model model) {
		if(login_error != null) {
			model.addAttribute("error", "인증 실패");
		}
		return "admin/login";
	}
		
    
    @RequestMapping("/push/list")
    public String list(ModelMap model)
    {
        model.put("devices",adminService.getAllDevices());
    	return "push/pushList";
    } 
    
 
    /* 관리자 포인트 결제*/
    @RequestMapping(value="/register", produces={"application/xml", "application/json"} )
    public @ResponseBody Map<String, Object> Register(@RequestBody Map<String, String> params, ModelMap model) {  
    	
    	//System.out.println("POST: " + params.size()); // prints POST: 0
    	//System.out.println("params: " + params.toString()); // prints POST: 0
    	
    	if(params.size() > 0){
    		try{
    			int chkCount =0;
    			chkCount = adminService.updateCash(params);
    			System.out.println("======================" + chkCount);
    			if(chkCount > 0){
    				adminService.updateSalesCash(params);
    		    	model.put("message", "모두성공");
    			}else{
    				model.put("message", "결제테이블 업데이트 오류");
    			}
    		}catch (Exception ex) {
    			model.put("message", "서버오류가 발생했습니다");
        	}
    	}

/*		if(sessionVO.getUserId().length() < 1) {
			model.put("message","로그인한 사용자가 아닙니다");    			
		} else {			
	    	if(accountService.modifyUserInfo(sessionVO))
	    		model.put("message","적용 되었습니다");
	    	else
	    		model.put("message","오류가 발생했습니다");
		}	
		*/
		return model;
    }
    
}

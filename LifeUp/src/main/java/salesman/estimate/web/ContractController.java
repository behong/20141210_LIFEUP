package salesman.estimate.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import salesman.account.service.AccountService;
import salesman.common.service.StorageService;
import salesman.common.support.CustomException;
import salesman.estimate.service.ContractService;
import salesman.estimate.service.RequestService;
import salesman.push.service.PushService;
import salesman.vo.account.LoginVO;
import salesman.vo.account.SessionVO;
import salesman.vo.estimate.ContractReplyVO;
import salesman.vo.estimate.ContractVO;

@Controller
@RequestMapping("/contract/*")
public class ContractController {

	@Autowired
	private AccountService accountService;
	 
	@Autowired
	private RequestService requestService;
	
	@Autowired
	private ContractService contractService;
	
    @Autowired
    private StorageService storageService;
    
	@Autowired
	private PushService pushService;    
	
	@RequestMapping("/writeform")
    public String writeform(@RequestParam(value="request_id", required=false) String request_id, ModelMap model) {
		int id = 0;
		
		LoginVO user = new LoginVO();
		Map<String, Object> request = new HashMap<String, Object>();
		List<HashMap<String, Object>> contract = new ArrayList<HashMap<String, Object>>();	
				
		if(request_id == null || request_id == "")
			throw new CustomException("유효하지 않은 정보로 인해 페이지를 열 수 없습니다");
			
		SessionVO userInfo = storageService.getAuthenticatedUser();		
		if(userInfo == null)
			return "/account/login";
		
		user.setUserType(userInfo.getUserType());
    	user.setUserId(userInfo.getUserId());
    	
		try {
			userInfo = accountService.getUserInfo(user);
			
			if(userInfo.getCash_point() < contractService.getDefaultCashPoint()) // 기본 Cash 소진포인트 300
				return "redirect:/cash/Payment";
				
			id = Integer.parseInt(request_id);  
			request = requestService.getRequestDetail(id);
			contract = contractService.getContractList(id, userInfo.getUserId());			
		} catch (Exception ex) {}
		
		model.put("requestDetail", request);
		model.put("contractDetail", contract);
		
    	return "estimate/contract/contractForm";
    }  
	
	@RequestMapping(value="/registContract", produces={"application/xml", "application/json"} )
	public @ResponseBody Map<String, Object> registContract(@RequestBody ContractVO contractVO) {
		
		String message = "success";
		Map<String, Object> result = new HashMap<String, Object>();
		String pushParam = "";
		
		SessionVO userInfo = storageService.getAuthenticatedUser();		
		
		try {
			if(userInfo == null) {
				message = "failed";
				result.put("detail", "로그인 후 견적등록을 할 수 있습니다");			
			} else {
				contractVO.setSalesman_id(userInfo.getUserId());
				if(contractService.modifyContract(contractVO) == 0) { // 수정					
					if(contractService.registerContract(contractVO) <= 0) {	// 등록						
						message = "failed";
						result.put("detail", "견적등록 중 오류가 발생했습니다");
					} else {
						// Push 메시지 발송
						int requestId = Integer.parseInt(contractVO.getRequest_id());
						
						// Cash 포인트 소진
						contractService.useCashPoint(requestId, userInfo.getUserId());
	
						List<String> arrUserId = new ArrayList<String>();
						HashMap<String,Object> requestInfo = requestService.getRequestDetail(requestId);			
						arrUserId.add(requestInfo.get("CUSTOMER_ID").toString());
						
						pushParam = "/contract/detail?request_id=" + requestId + "&salesman_id=" + userInfo.getUserId();					
						pushService.sendMessage(arrUserId, "최신 견적 제안건이 등록되었습니다", pushParam);										
					}
				}
			}
		} catch (Exception ex) {
			message = "failed";
			result.put("detail", "견적등록 중 오류가 발생했습니다");
		}
		
		result.put("message", message);	
		
		return result;
	}
	
	@RequestMapping("/detail")
    public String detail(@ModelAttribute ContractVO contractVO, ModelMap model) {
		int id = 0;
		Map<String, Object> request = new HashMap<String, Object>();
		List<HashMap<String, Object>> contract = new ArrayList<HashMap<String, Object>>();	
		List<HashMap<String, Object>> reply = new ArrayList<HashMap<String, Object>>();
				
		if(contractVO.getRequest_id() == null || contractVO.getRequest_id() == "")
			throw new CustomException("유효하지 않은 정보로 인해 페이지를 열 수 없습니다");			
			
		SessionVO userInfo = storageService.getAuthenticatedUser();	
		
		try {
			if(userInfo != null && userInfo.getUserType() == 2) {
				contractVO.setSalesman_id(userInfo.getUserId());
			}
			
			id = Integer.parseInt(contractVO.getRequest_id());  
			request = requestService.getRequestDetail(id);							
			contract = contractService.getContractList(id, contractVO.getSalesman_id());
			reply = contractService.getContractReplyList(id, contractVO.getSalesman_id());
		} catch (Exception ex) { }
		
		model.put("requestDetail", request);
		model.put("contractDetail", contract);
		model.put("contractReply", reply);
		
    	return "estimate/contract/contractDetail";
    }  
	
	@RequestMapping(value="/registReply", produces={"application/xml", "application/json"} )
	public @ResponseBody Map<String, Object> registReply(@RequestBody ContractReplyVO contractReplyVO) {
		
		String message = "success";
		String pushParam = "";
		List<String> arrUserId = new ArrayList<String>();
		Map<String, Object> result = new HashMap<String, Object>();
		
		try {
			SessionVO userInfo = storageService.getAuthenticatedUser();		
			if(userInfo == null) {
				message = "failed";
				result.put("detail", "로그인 후 등록 할 수 있습니다");			
			} else {
				contractReplyVO.setCreate_user_id(userInfo.getUserId());
				contractReplyVO.setCreate_user_nm(userInfo.getUserNm());
				
				if(contractService.registerContractReply(contractReplyVO) <= 0) {							
					message = "failed";
					result.put("detail", "댓글 등록 중 오류가 발생했습니다");
				} else {			
					if(userInfo.getUserType() == 1) { // 일반인이 댓글 작성시 영맨에게 알림
						arrUserId.add(contractReplyVO.getSalesman_id());				
						pushParam = "/contract/detail?request_id=" + contractReplyVO.getRequest_id() + "&salesman_id=" + contractReplyVO.getSalesman_id();					
						pushService.sendMessage(arrUserId, "견적요청 댓글이 등록되었습니다", pushParam);
					}
				}
			}
		} catch (Exception ex) {
			message = "failed";
			result.put("detail", "댓글 등록 중 오류가 발생했습니다");
		}
		
		result.put("message", message);	
		return result;
	}
	
    @RequestMapping(value="/contractCancel", produces={"application/xml", "application/json"} )
    public @ResponseBody Map<String, Object> contractCancel(@RequestBody ContractVO contractVO)
    {    	
    	String message = "success";
    	Map<String, Object> result = new HashMap<String, Object>();
    	
		SessionVO userInfo = storageService.getAuthenticatedUser();
		
		try {
			if(userInfo == null) {
				message = "로그인 후 등록할 수 있습니다";
			} else {			
				contractVO.setSalesman_id(userInfo.getUserId());
		    	if(contractService.updateContractStatus(contractVO) <= 0) {
		    		message = "상태 업데이트 중 오류가 발생했습니다";
		    	} 
			}
		} catch (Exception ex) {
			message = "상태 업데이트 중 오류가 발생했습니다";
		}
		
    	result.put("message", message);
    	return result;
    }
}
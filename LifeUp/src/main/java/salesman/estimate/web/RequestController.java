package salesman.estimate.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import salesman.common.define.RegionVo;
import salesman.common.service.CodesService;
import salesman.common.service.StorageService;
import salesman.estimate.service.ContractService;
import salesman.estimate.service.RequestService;
import salesman.push.service.PushService;
import salesman.vo.account.SessionVO;
import salesman.vo.estimate.ContractVO;
import salesman.vo.estimate.RequestVO;


@Controller
@RequestMapping("/request/*")
public class RequestController {
	
	@Autowired
	private RequestService requestService;
	
	@Autowired
	private ContractService contractService;
	
    @Autowired
    private CodesService codeService;	
	    
    @Autowired
    private StorageService storageService;	

	@Autowired
	private PushService pushService;    

    private int pageRecordCnt = 30; // 리스트 기본 view 갯수
    private int rowCntByScroll = 10; // 스크롤시 rowCntByScroll 수 만틈 추가로 보여준다
	
    @RequestMapping("/list")
    public String list(@RequestParam (value="currentSeq", required=false) String currentSeq, 
    		@RequestParam (value="sidoCd", required=false) String sidoCd, 
    		@RequestParam (value="gugunCd", required=false) String gugunCd, 
    		@RequestParam (value="vendorCd", required=false) String vendorCd, 
    		@RequestParam (value="statusCd", required=false) String statusCd, ModelMap model) {
    	
    	List<RegionVo> regionList = new ArrayList<RegionVo>();
    	Map<String, Object> args = new HashMap<String, Object>();
    	List<HashMap<String, Object>> vendorList = new ArrayList<HashMap<String, Object>>();
    	
    	List<HashMap<String, Object>> requestList = new ArrayList<HashMap<String, Object>>();     	
    	
    	if(currentSeq == null || currentSeq == "")
    		currentSeq = String.valueOf(this.pageRecordCnt);    	
    	    	
    	args.put("startIdx", 0);
    	args.put("endIdx", Integer.parseInt(currentSeq));
    	args.put("sido_cd", sidoCd != null ? (sidoCd.equals("") ? null : sidoCd) : null);
    	args.put("region_cd", gugunCd != null ? (gugunCd.equals("") ? null : gugunCd) : null);
    	args.put("vendor_id", vendorCd != null ? (vendorCd.equals("") ? null : vendorCd) : null);
    	args.put("status_cd", statusCd != null ? (statusCd.equals("") ? null : statusCd) : null);    	    
    	    	
    	try {
	    	requestList = requestService.getRequestList(args);
	    	regionList = codeService.selectRegionSidoTable();
	    	vendorList = codeService.getVendorCodes();
    	} catch (Exception ex) {}
    	
        model.put("estimateRegList", requestList);
        model.put("sidos", regionList);
        model.put("venders", vendorList);       
        model.put("listCnt", requestList.size());
    	
        return "estimate/request/requestList";    	
    } 
    
    @RequestMapping(value="/listJson", produces={"application/xml", "application/json"} )
    public @ResponseBody Map<String, Object> listJson(@RequestBody Map<String, Object> param)
    {
    	int viewMaxSeq = 0;    	

    	List<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();     			
    	
    	String currentSeq = param.get("currentSeq") == null ? "0" : param.get("currentSeq").toString();
    	String showMaxSeq = param.get("showMaxSeq") == null ? null : param.get("showMaxSeq").toString();
    	
    	if(showMaxSeq != null) {
    		viewMaxSeq = Integer.parseInt(showMaxSeq);			
    		param.put("startIdx" , 0);
			param.put("endIdx"   , viewMaxSeq);
    	} else {
    		viewMaxSeq = Integer.parseInt(currentSeq);    	
	    	if(Integer.parseInt(currentSeq) >= this.pageRecordCnt) {	
	    		viewMaxSeq += rowCntByScroll ;
			    	   	     	   
				param.put("startIdx" , Integer.parseInt(currentSeq));
				param.put("endIdx"   , rowCntByScroll);
	    	}
    	}

		param.put("sido_cd"  , param.get("sido_cd") != null ? (param.get("sido_cd").toString().equals("") ? null : param.get("sido_cd").toString()) : null);
    	param.put("region_cd", param.get("region_cd") != null ? (param.get("region_cd").toString().equals("") ? null : param.get("region_cd").toString()) : null);
    	param.put("vendor_id", param.get("vendor_id") != null ? (param.get("vendor_id").toString().equals("") ? null : param.get("vendor_id").toString()) : null);    		
    	param.put("status_cd", param.get("status_cd") != null ? (param.get("status_cd").toString().equals("") ? null : param.get("status_cd").toString()) : null);		    		    	

    	try {
    		list = requestService.getRequestList(param);
    		//System.out.println("사이즈 "+ list.size());
    	} catch (Exception ex) { 
    		System.out.println("리스트 데이타 캣취");
    	}
    	
    	param.clear();	    	
    	param.put("list", list);    	
    	param.put("currentSeq", viewMaxSeq);
    	    	
    	return param;
    }     
    
    @RequestMapping("/writeform")
    public String addForm(ModelMap model) {
    	SessionVO userInfo = storageService.getAuthenticatedUser();
    	
    	if(userInfo == null) {
            return "account/login";
		}
    	
    	model.put("sidos", codeService.selectRegionSidoTable());
    	model.put("venders", codeService.getVendorCodes());
        return "estimate/request/writeform";
    }   
    
    @RequestMapping(value="/writing", produces={"application/xml", "application/json"} )
    public @ResponseBody Map<String, Object> writing(@RequestBody RequestVO requestVO)
    {    	
    	String message = "success";
    	Map<String, Object> result = new HashMap<String, Object>();
    	
    	try {
			SessionVO userInfo = storageService.getAuthenticatedUser();
			if(userInfo == null) {
				message = "로그인 후 등록할 수 있습니다";
			} else {			    	
		    	requestVO.setStatus("0001");
		    	requestVO.setCustomer_id(userInfo.getUserId());	    
		    	
		    	if(requestService.registerRequest(requestVO) <= 0) {
		    		message = "등록 중 오류가 발생했습니다";
		    	}
			}
    	} catch (Exception ex) {
    		message = "등록 중 오류가 발생했습니다";
    	}
    	
    	result.put("message", message);
    	return result;
    } 
    
    @RequestMapping("/detail")
    public String detail(@RequestParam (value="request_id", required=false) String request_id
    		,@RequestParam (value="point_id", required=false) String point_id
    		,@RequestParam (value="user_type_chk", required=false) Integer user_type_chk    		
    		, ModelMap model) {
    	
    	int iRequestId = 0;
    	Map<String, Object> request = new HashMap<String, Object>();
    	List<HashMap<String, Object>> contract = new ArrayList<HashMap<String, Object>>();
    	
    	if(request_id == null || request_id.equals(""))
    		return "redirect:/request/list";
    	
    	// 현재 포인트 조회 
    	//requestService.statePoint(point_id);

    	try {
    		iRequestId = Integer.parseInt(request_id); 
	    	// 요구사항 상세
	    	request = requestService.getRequestDetail(iRequestId);
	    	// 견적서 등록리스트
	    	contract = contractService.getContractList(iRequestId, null);
	    	
	    	// 영업사원 자신이 등록한 견적이 있는 경우, 거래완료 되지 않은 건에 한해서 상세화면으로 이동
	    	SessionVO userInfo = storageService.getAuthenticatedUser();
			if(userInfo != null) {			
		    	for(HashMap<String, Object> row : contract) {
		    		if(row.get("SALESMAN_ID").toString().equals(userInfo.getUserId()) && 
		    				row.get("STATUS").toString().equals("0001")) {
		    			return "redirect:/contract/detail?request_id=" + iRequestId;
		    		}
		    	}
			}
	    	
	    	// 조회수 업데이트
	    	requestService.updateRequestHitCnt(iRequestId);	    	
    	} catch (Exception ex) {}
    	
    	// 현재 포인트 조회 
    	//requestService.statePoint(point_id);
    	if(user_type_chk != null && user_type_chk == 2){
    		model.put("cash_point", requestService.statePoint(point_id));
    	}
    	model.put("request", request);   	    	    	
    	model.put("contract", contract);
    	
        return "estimate/request/detail";
    }
    
    @RequestMapping(value="/updateContractStatus", produces={"application/xml", "application/json"} )
    public @ResponseBody Map<String, Object> updateContractStatus(@RequestBody RequestVO requestVO)
    {    	
    	String message = "success";
    	String pushParam = "";
    	String requestId = "";
    	Map<String, Object> result = new HashMap<String, Object>();
    	
		SessionVO userInfo = storageService.getAuthenticatedUser();
		
		try {
			if(userInfo == null) {
				message = "로그인 후 등록할 수 있습니다";
			} else {			
		    	if(requestService.updateRequestStatus(requestVO) <= 0) {
		    		message = "상태 업데이트 중 오류가 발생했습니다";
		    	} else {
		    		if(requestVO.getStatus().equals("0002")) { // 확정
		    			ContractVO contractVO = new ContractVO();
		    			contractVO.setRequest_id(requestVO.getRequest_id());
		    			contractVO.setSalesman_id(requestVO.getSalesman_id());
		    			contractVO.setStatus(requestVO.getStatus());
		    			int rtnValue = contractService.updateContractStatus(contractVO);
		    			
		    			if(rtnValue > 0) {	    			
		    				List<String> arrUserId = new ArrayList<String>();	    			
			    			arrUserId.add(requestVO.getSalesman_id());
			    			
			    			pushParam = "/contract/detail?request_id=" + requestId + "?salesman_id=" + requestVO.getSalesman_id();
			    			pushService.sendMessage(arrUserId, "제안하신 건이 고객님으로부터 거래확정 되었습니다", pushParam);
		    			}
		    		}
		    	}
			}
		} catch (Exception ex) {
			message = "상태 업데이트 중 오류가 발생했습니다";
		}
		
    	result.put("message", message);
    	return result;
    }   
}
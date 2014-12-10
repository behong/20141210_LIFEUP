package salesman.cash.web;

import java.text.DecimalFormat;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import salesman.account.service.AccountService;
import salesman.common.service.StorageService;
import salesman.common.util.CommonDate;
import salesman.vo.account.LoginVO;
import salesman.vo.account.SessionVO;
import salesman.vo.mypage.PaymentVO;



@Controller
@RequestMapping("/cash/*")
public class CashController {
	 /**
	  * 숫자에 천단위마다 콤마 넣기
	  * @param int
	  * @return String
	  * */
	 public static String toNumFormat(int num) {
	  DecimalFormat df = new DecimalFormat("#,###");
	  return df.format(num);
	 }	
	
	@Autowired
	private AccountService accountService;
	
    @Autowired
    private StorageService storageService;	
	
    @RequestMapping("Payment")
    public String Pay(ModelMap model){
    	LoginVO loginVO = new LoginVO();
    	
    	SessionVO userInfo = storageService.getAuthenticatedUser();
    	
		loginVO.setUserId(userInfo.getUserId());
		loginVO.setUserType(userInfo.getUserType());
		
		userInfo     = accountService.getUserInfo(loginVO);
		
		model.put("userInfo", userInfo);	
    	return "cash/payment";
    }
    

    
    /* 결제 신청 */
    @RequestMapping(value="/Pending_Payment", produces={"application/xml", "application/json"} )
    public @ResponseBody Map<String, Object> payment(@RequestBody PaymentVO paymentVO, ModelMap model) {
    	
    	
    	if( Integer.parseInt(paymentVO.getAmount()) == 1000){ // 
    		paymentVO.setPoint("1000");
    		
    	}else if(Integer.parseInt(paymentVO.getAmount()) > 1000 && Integer.parseInt(paymentVO.getAmount()) < 10000){
    		// 1000원 이상이고 만원이하일때
    		paymentVO.setPoint("10000");
    	}else{
    		double resultPoint = 0;
    		resultPoint = Integer.parseInt(paymentVO.getAmount()) + ( Integer.parseInt(paymentVO.getAmount())* 0.1);
    		String str = Double.toString(resultPoint);
    		paymentVO.setPoint(str);
    	}
    	
    	//상태값 (결제 대기)
    	paymentVO.setStatus("0001");
    	
		if(paymentVO.getUserId().length() < 1) {
			model.put("message","로그인한 사용자가 아닙니다");    			
		} else {		
			
			if(accountService.addPoint(paymentVO)){
    			model.put("flag","Y");
	    		model.put("message","결제 신청 되었습니다");
			}else{
				model.put("flag","N");
	    		model.put("message","오류가 발생했습니다");
			}
		}	

		return model;
    }        

    /* 결제 신청 완료*/
    
    @RequestMapping("Payment_Complete")
    public String PaymentComplete(
    		@RequestParam(value="amount", required=false) String amount,
    		@RequestParam(value="receipter_nm", required=false) String receipter_nm,
    		ModelMap model){
        	
    	LoginVO 	loginVO = new LoginVO();
    	SessionVO userInfo = storageService.getAuthenticatedUser();
    	
		loginVO.setUserId(userInfo.getUserId());
		loginVO.setUserType(userInfo.getUserType());
		
		userInfo     = accountService.getUserInfo(loginVO);
		PaymentVO paymentVO = new PaymentVO();

		
		paymentVO.setAmount(toNumFormat(Integer.parseInt(amount)));
		paymentVO.setReceipter_nm(receipter_nm);
		paymentVO.setPayment_day( CommonDate.setOperationDate("plus", 7));
		model.put("userInfo", userInfo);	
		model.put("request", paymentVO);
    	return "cash/payment_result";
    }
}

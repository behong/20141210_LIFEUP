package salesman.push.web;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import salesman.push.service.PushService;

@Controller
@RequestMapping("/push/*")
public class PushController {
	
	@Autowired
	private PushService pushService;
    
    @RequestMapping("/list")
    public String list(ModelMap model)
    {
        model.put("devices",pushService.getAllDevices());
    	return "push/pushList";
    } 

    @RequestMapping(value="/register" , method=RequestMethod.POST)
    public String Register(@RequestParam Map<String, String> params){
   		String message = "OK";
    	System.out.println("POST: " + params.size()); // prints POST: 0

          int totalCount = 0;
          totalCount = pushService.getTotalCount(params);
          if(totalCount <= 0){
  	    	if(pushService.insertPushInfo(params) <= 0)
	    		message = "등록 중 오류가 발생했습니다";
          }else{
   	    	if(pushService.updatePushInfo(params) <= 0)
 	    		message = "수정 중 오류가 발생했습니다";
          }
    	
    	//return message;
        //  return "forward:/main";
          return "redirect:/main";
    }
    
    @RequestMapping("/send")
    public String Send(@RequestParam String AllMessage, @RequestParam String user_id, 
    		@RequestParam String message,@RequestParam(required=false,defaultValue = "0")String params, ModelMap model){

    	List<String> arrUserId = new ArrayList<String>();    	
    	if(AllMessage.equals("No") )
    		arrUserId.add(user_id);    	
    	
    	boolean rtnValue = pushService.sendMessage(arrUserId, message, params);
    	
    	if(rtnValue)
    		model.put("result", "문자 메시지가 전송 되었습니다");
    	else
    		model.put("result", "문자 메시지 전송을 실패했습니다");
    	
    	return "push/result";    	
    }
}

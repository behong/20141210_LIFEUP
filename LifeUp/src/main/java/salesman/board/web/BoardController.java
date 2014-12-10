package salesman.board.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import salesman.account.service.AccountService;
import salesman.board.service.NoticeService;
import salesman.common.service.StorageService;
import salesman.vo.account.LoginVO;
import salesman.vo.account.SessionVO;
import salesman.vo.mypage.PaymentVO;

@Controller
@RequestMapping("/board/*")
public class BoardController {
	
	@Autowired
	private NoticeService noticeService;
	
	@Autowired
	private AccountService accountService;
	
    @Autowired
    private StorageService storageService;	
	
    @RequestMapping("/Notice")
    public String Notice(ModelMap model) 
    {    	    
    	List<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
    	try {
    		list = noticeService.getNoticeList();
    	} catch (Exception ex) {}
    	
    	model.put("noticeList", list);
    	return "board/noticeList";
    }
    
    @RequestMapping("/FAQ")
    public String FAQ() 
    {    	    
    	return "board/faqList";
    }  
   
}

package salesman.account.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import salesman.account.service.UserPointMngService;

@Controller
public class UserPointMngController {
    @Autowired
    private UserPointMngService userPointMngService;	

    @RequestMapping(value="/salesRanking")
    public String salesRanking(ModelMap model) 
    {
    	List<HashMap<String, Object>> rankList = new ArrayList<HashMap<String, Object>>(); 
    	Map<String, Object> param = new HashMap<String, Object>();
    	// 검색 조건에 따라 param을 추가하도록 한다    	
    	try {
	    	rankList = userPointMngService.getSalesRankingList(param);    	
    	} catch (Exception ex) {}
    	
    	model.put("salesRankingList", rankList);    	
    	return "/account/salesRanking";
    }
}
package salesman.board.web;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import salesman.board.service.BoardService;
import salesman.model.Board;
import salesman.model.Post;

@Controller
@RequestMapping("/{board}/post")
public class PostController {
	
	@Autowired
	private BoardService boardService;
    
    @RequestMapping(method=RequestMethod.GET)
    public String list(@PathVariable Board board, ModelMap model) {
        model.put("posts", boardService.selectTestTable());
        return "post/list";
    }
    
    @RequestMapping(value="{postNo}", method=RequestMethod.GET)
    public String view(@PathVariable Board board, @PathVariable Integer postNo, ModelMap model) {
    	 model.put("post", boardService.getView(postNo));
    	 System.out.println("-----  "+ boardService.getView(postNo));
        return "post/view";
    }
    
    @RequestMapping(value="new", method=RequestMethod.GET)
    public String addForm(@ModelAttribute Post post) {
        return "post/form";
    }
    
    @RequestMapping(method=RequestMethod.POST)
    public String writing(@PathVariable Board board, Post post) {
    	int wireResult = boardService.writeProc(post);
        return "redirect:/{board}/post";
    }
    
    @RequestMapping(value="edit/{postNo}", method=RequestMethod.GET)
    public String editForm(@PathVariable Integer postNo, ModelMap model) {
    	model.put("post", boardService.getView(postNo));
        return "post/form";
    }
    
    @RequestMapping(method=RequestMethod.PUT)
    public String editing(@PathVariable Board board, Post post, HttpServletRequest request, RedirectAttributes redirectAttributes) {
    	boardService.editing(post);
    	redirectAttributes.addAttribute("postNo",post.getId());
        return "redirect:/{board}/post/{postNo}";
    	
    }
    
    @RequestMapping(method=RequestMethod.DELETE)
    public String erase(@PathVariable Board board, @RequestParam Integer postNo) {
    	boardService.erase(postNo);
        return "redirect:/{board}/post";
    }
}

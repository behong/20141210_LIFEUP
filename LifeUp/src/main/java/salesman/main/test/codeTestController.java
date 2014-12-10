package salesman.main.test;

import java.io.IOException;
import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class codeTestController {
	

	@RequestMapping("/htmlArrayToVo")
	public String main(HttpServletRequest request,
			HttpServletResponse response, ModelMap model)
			throws UnsupportedEncodingException {

		return "redirect:/test_code/htmlArrayToVo";
	}

	@RequestMapping(value = "/htmlParseTest", method = RequestMethod.GET)
	public void htmlParseTest(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		// 클리앙
		String pageUrl = "http://clien.career.co.kr/";

		Document doc = Jsoup.connect(pageUrl).get();
		String title = doc.title();
		System.out.println("제목=" + title);
		// 새로운 소식 최신 목록추출
		// class=RecentWrap 인 div를 추출
		String selector = " div.RecentWrap:eq(0)";
		selector += " .RecentLeft  ";// class=RecentLeft인 요소
		selector += " h2 ";// h2 태그

		Elements rcw = doc.select(selector);
		// 갯수추출
		System.out.println("RecentWrap갯수=" + rcw.size());
		// 문자값 추출
		Element el = rcw.get(0);
		System.out.println("H2의 문자값=" + el.text());
		// ////////// 새로운 소식 목록 추출
		String selector2 = " div.RecentWrap:eq(0)";
		selector2 += " .RecentLeft  ";// class=RecentLeft인 요소
		selector2 += " ul  li .title  a ";// 새로운 소식 목록
		Elements rcwList = doc.select(selector2);
		System.out.println("새로운소식목록갯수=" + rcwList.size());
		// 목록 내용 추출
		for (int i = 0; i < rcwList.size(); i++) {
			Element li = rcwList.get(i);
			System.out.println(li.text());
			System.out.println("링크=" + li.attr("href"));
		}// end for
	}// end main
}

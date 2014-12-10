package salesman.main.web;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.httpclient.DefaultHttpMethodRetryHandler;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpException;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.methods.GetMethod;
import org.apache.commons.httpclient.params.HttpMethodParams;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import salesman.account.service.UserPointMngService;
import salesman.common.service.CodesService;
import salesman.common.service.StorageService;
import salesman.estimate.service.RequestService;

@Controller
public class mainController {
	@Autowired
	private StorageService storageService;

	@Autowired
	private RequestService requestService;

	@Autowired
	private UserPointMngService userPointMngService;

	@Autowired
	private CodesService codeService;

	@Autowired
	private JavaMailSender mailSender;

	@RequestMapping("/main")
	public String main(HttpServletRequest request,
			HttpServletResponse response, ModelMap model)
			throws UnsupportedEncodingException {

		return "redirect:/request/list";

		// List<HashMap<String, Object>> requestList;
		// List<HashMap<String, Object>> weeklyRankList;
		// List<HashMap<String, Object>> monthlyRankList;
		//
		// Map<String, Object> args;
		// args = new HashMap<String, Object>();
		// args.put("startIdx", 0);
		// args.put("endIdx", 5);
		//
		// try {
		// requestList = requestService.getHotRequestList(args);
		// model.put("requestList", requestList);
		//
		// weeklyRankList = userPointMngService.getSalesRankingListforWeekly();
		// model.put("weeklyRankList", weeklyRankList);
		//
		// monthlyRankList =
		// userPointMngService.getSalesRankingListforMonthly();
		// model.put("monthlyRankList", monthlyRankList);
		// } catch (Exception ex) {
		// throw new CustomException("웹사이트에서 일시적인 오류가 발생하였습니다");
		// }
		//
		// return "main";
	}

	@RequestMapping("/selectRegionJson")
	public @ResponseBody Map<String, Object> listJson(@RequestBody String sido_cd, HttpServletRequest request) {
		Map<String, Object> result = new HashMap<String, Object>();

		if (sido_cd == null || sido_cd.equals("")) {
			result.put("Sido", codeService.selectRegionSidoTable());
		} else {
			result.put("Sido2", codeService.selectRegionGuTable(sido_cd));
		}

		return result;
	}

	@RequestMapping("/selectCarJson") 
	public @ResponseBody Map<String, Object> carlistJson(@RequestBody String venderId) {
		Map<String, Object> result = new HashMap<String, Object>();
		//result.put("carCodeList", codeService.getCarCodeList(venderId));
		
		System.out.println("============ " + codeService.getCarCodeList("100001"));
		return result;
	}

	@RequestMapping("/youtube")
	public String youtube(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("=================");
		return "youtube";
	}

	@RequestMapping("/sitescrap")
	public String sitescrap(HttpServletRequest request, HttpServletResponse response) {
		HttpClient client = new HttpClient();

		// Create a method instance.
		GetMethod method = new GetMethod(
				"http://ossue.com/bbs/board.php?bo_table=issue");

		// Provide custom retry handler is necessary
		method.getParams().setParameter(HttpMethodParams.RETRY_HANDLER,
				new DefaultHttpMethodRetryHandler(3, false));

		try {
			// Execute the method.
			int statusCode = client.executeMethod(method);

			if (statusCode != HttpStatus.SC_OK) {
				System.err.println("Method failed: " + method.getStatusLine());
			}

			// Read the response body.
			byte[] responseBody = method.getResponseBody();

			// Deal with the response.
			// Use caution: ensure correct character encoding and is not binary
			// data
			System.out.println(new String(responseBody));

		} catch (HttpException e) {
			System.err.println("Fatal protocol violation: " + e.getMessage());
			e.printStackTrace();
		} catch (IOException e) {
			System.err.println("Fatal transport error: " + e.getMessage());
			e.printStackTrace();
		} finally {
			// Release the connection.
			method.releaseConnection();
		}
		return "youtube";
	}

	@RequestMapping("/webMail")
	public String mail(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("=================");
		return "webmail/Mail";
	}

	@RequestMapping(value = "/sendEmail", method = RequestMethod.POST)
	public String doSendEmail(HttpServletRequest request,
			HttpServletResponse response) {
		// takes input from e-mail form
		// String recipientAddress = request.getParameter("recipient");
		String recipientAddress = "sijm@naver.com";
		String subject = request.getParameter("subject");
		String message = request.getParameter("message");

		// prints debug info
		System.out.println("To: " + recipientAddress);
		System.out.println("Subject: " + subject);
		System.out.println("Message: " + message);

		// creates a simple e-mail object
		SimpleMailMessage email = new SimpleMailMessage();
		email.setTo(recipientAddress);
		email.setSubject(subject);
		email.setText(message);

		// sends the e-mail
		mailSender.send(email);

		// forwards to the view named "Result"
		return "webmail/sendEmail";
	}

	@RequestMapping(value = "/favicon.ico", method = RequestMethod.GET)
	public void favicon(HttpServletRequest request, HttpServletResponse reponse) {
		try {
			reponse.sendRedirect("/resources/favicon.ico");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@RequestMapping(value = "/main_htmlParseTest", method = RequestMethod.GET)
	public void htmlParseTest(HttpServletRequest request,HttpServletResponse response) throws IOException {
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

package salesman.push.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.apache.http.HttpEntity;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;

import com.google.gson.Gson;

import salesman.push.service.PushService;
import salesman.vo.push.Device;
import salesman.vo.push.GCMData;
import salesman.vo.push.GCMMessage;

@Component
public class GCMUtil {
		
	private static PushService pushService;	
	
	@Autowired(required=true)
	public static void setPushService(PushService pushService) {
		GCMUtil.pushService = pushService;
	}
	
 
	public static String sendMessageToGCM(String message) {
		//final String API_KEY = "구글 GCM 서비스에 설정한 API KEY를 입력합니다.";
		final String API_KEY = "AIzaSyBdrOLfBi04LKBEjjroVWZga4Ip0G4_JqI";
		
		// JSON 포맷으로 메시지 변환 준비
		GCMMessage gcmMessage = new GCMMessage();
		gcmMessage.setData(new GCMData(message));
		
		// 데이터베이스에서 registration_id를 전부 읽어 온다.
		System.out.println("pushService.getAllDevices() ===  "+ GCMUtil.pushService.getAllDevices());	
		
		List<Device> devices = GCMUtil.pushService.getAllDevices();

		System.out.println("ddd ===  "+devices.toString());
		
		for(Device device : devices) {
			System.out.println("ddd ===  "+device);
			gcmMessage.addRegistrationId(device.getReg_Id());
		}
		
		// JSON으로 변환
		Gson gson = new Gson();
		String json = gson.toJson(gcmMessage);

		// 디버그 용
		System.out.println(json);
		
		// 메시지 전송 
		StringBuilder builder = new StringBuilder();
		try {
			CloseableHttpClient httpClient = HttpClients.createDefault();
			HttpPost httpPost = new HttpPost("https://android.googleapis.com/gcm/send");
			httpPost.addHeader("Content-Type", "application/json");
			httpPost.addHeader("Authorization", "key=" + API_KEY);
			StringEntity stringEntity = new StringEntity(json, "utf-8");
			httpPost.setEntity(stringEntity);
			
			CloseableHttpResponse response = httpClient.execute(httpPost);
			
			HttpEntity entity = response.getEntity();
			InputStream is = entity.getContent();
			BufferedReader br = new BufferedReader(new InputStreamReader(is));
			String line = null;
			while((line = br.readLine()) != null) {
				builder.append(line);
			}
			EntityUtils.consume(entity);
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClientProtocolException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return builder.toString();
	}

}

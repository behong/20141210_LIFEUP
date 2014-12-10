package salesman.push.service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.http.HttpEntity;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;

import salesman.push.dao.PushDao;
import salesman.vo.push.Device;
import salesman.vo.push.GCMData;
import salesman.vo.push.GCMMessage;

import com.google.gson.Gson;

public class PushServiceImpl implements PushService {
	
	private String API_KEY;
	private PushDao pushDao1;	

	public void setPushDao1(PushDao pushDao) {
		this.pushDao1 = pushDao;
	}
	
	public void setAPI_KEY(String api_key) {
		this.API_KEY = api_key;
	}

	@Override
	public List<Device> getAllDevices() {		
		List<Device> devices = pushDao1.getAllDevices();
/*		for(Device device :devices){
			//String phone = device.getPhone();
			//device.setPhone(phone.substring(0,phone.length()-2)+"**");
			//String regid = device.getReg_Id();
			//device.setReg_Id(regid.substring(0,Math.min(regid.length(), 10)));
		}*/
		return devices;
	}

	@Override
	public int getTotalCount(Map<String, String> params) {		
		return pushDao1.getTotalCount(params);
	}

	@Override
	public int insertPushInfo(Map<String, String> params) {
		return pushDao1.insertPushInfo(params);
	}

	@Override
	public int updatePushInfo(Map<String, String> params) {
		return pushDao1.updatePushInfo(params);
	}

	@Override
	public Map<String, String> getOneDevice(String user_id) {
		return pushDao1.getOneDevice(user_id);
	}

	@Override
	public boolean sendMessage(List<String> arrUserId, String message, String params) {				
		GCMMessage gcmMessage;
		List<String> arrMobileRegId = new ArrayList<String>();
			    	
    	if(arrUserId == null || arrUserId.size() == 0) { // 전체푸시
    		List<Device> devices = getAllDevices();
    		if(devices == null || devices.size() <= 0)
    			return false;
    		
        	for(Device device : devices) {        		
        		arrMobileRegId.add(device.getReg_Id());
        	}    		
    	} else if(arrUserId.size() == 1) { //단독 푸쉬
    		Map<String, String> device = getOneDevice(arrUserId.get(0));
    		if(device == null || device.size() <= 0)
    			return false;
    		arrMobileRegId.add(device.get("reg_id"));    		
    	} else {
    		return false;
    	}
    	
    	if(arrMobileRegId.size() <= 0)
    		return false;
    	
      	if(params == null || params.equals("")) 
    		return false;
      	
    	gcmMessage = new GCMMessage(arrMobileRegId, new GCMData(message, params));
    	    	
		// JSON으로 변환
		Gson gson = new Gson();
		String json = gson.toJson(gcmMessage);	
		
		// 메시지 전송 
		StringBuilder builder = new StringBuilder();
		try {
			CloseableHttpClient httpClient = HttpClients.createDefault();
			HttpPost httpPost = new HttpPost("https://android.googleapis.com/gcm/send");
			httpPost.addHeader("Content-Type", "application/json");
			httpPost.addHeader("Authorization", "key=" + this.API_KEY);
					
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
			return false;
		} catch (ClientProtocolException e) {
			return false;
		} catch (IOException e) {
			return false;
		}    	
		
		return true;
	}	
}

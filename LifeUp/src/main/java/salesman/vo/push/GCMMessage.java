package salesman.vo.push;

import java.util.ArrayList;
import java.util.List;

public class GCMMessage {

	private List<String> registration_ids = new ArrayList<String>();
	private GCMData data;
	
	public GCMMessage() {}

	public GCMMessage(List<String> registration_ids, GCMData data) {
		this.registration_ids = registration_ids;
		this.data = data;
	}

	public List<String> getRegistration_ids() {
		return registration_ids;
	}

	public void setRegistration_ids(List<String> registration_ids) {
		this.registration_ids = registration_ids;
	}

	public GCMData getData() {
		return data;
	}

	public void setData(GCMData data) {
		this.data = data;
	}
	
	public void addRegistrationId(String id) {
		registration_ids.add(id);
	}
}

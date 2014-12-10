package salesman.board.service;

import java.util.HashMap;
import java.util.List;

import salesman.board.dao.NoticeDao;

public class NoticeServiceImpl implements NoticeService {

	private NoticeDao noticeDao;
	
	public void setNoticeDao(NoticeDao noticeDao){
		this.noticeDao = noticeDao;
	}
	
	@Override
	public List<HashMap<String, Object>> getNoticeList() {		
		return noticeDao.getNoticeList();
	}
}

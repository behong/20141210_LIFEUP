package salesman.board.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;

public class NoticeDaoImpl extends SqlSessionDaoSupport implements NoticeDao {

	@Override
	public List<HashMap<String, Object>> getNoticeList() {		
		return getSqlSession().selectList("main.getNoticeList");
	}
}

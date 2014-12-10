package salesman.board.service;

import java.util.HashMap;
import java.util.List;

import salesman.model.Post;

public interface BoardService {
	
	public List<HashMap<String, Object>> selectTestTable();
	public int writeProc(Post post);
	public Post getView(int num);
	public Post editing(Post post);
	public int erase(Integer postNo);
}

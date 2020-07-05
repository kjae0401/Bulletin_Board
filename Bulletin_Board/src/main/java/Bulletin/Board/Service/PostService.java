package Bulletin.Board.Service;

import java.util.HashMap;
import java.util.List;

public interface PostService {
	public int post_count() throws Exception;
	public int post_count(String post_keyword) throws Exception;
	public List<HashMap<String, String>> post_list(HashMap<String, Object> post_list_range) throws Exception;
}
package Bulletin.Board.Service;

import java.util.HashMap;
import java.util.List;

public interface PostService {
	public int post_count() throws Exception;
	public int post_count(String post_keyword) throws Exception;
	public List<HashMap<String, String>> post_list(HashMap<String, Object> post_list_range) throws Exception;
	public HashMap<String, String> post_detail(int post_index) throws Exception;
	public void post_detail_view_update(int post_index) throws Exception;
	public boolean post_write(HashMap<String, String> post_write_data) throws Exception;
}
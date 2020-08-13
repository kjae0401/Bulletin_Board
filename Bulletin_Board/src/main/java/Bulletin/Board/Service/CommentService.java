package Bulletin.Board.Service;

import java.util.HashMap;
import java.util.List;

public interface CommentService {
	public boolean comment_write(HashMap<String, String> comment_write_data) throws Exception;
	public List<HashMap<String, String>> post_detail_comment(int post_index) throws Exception;
	public boolean comment_delete(String comment_index) throws Exception;
}
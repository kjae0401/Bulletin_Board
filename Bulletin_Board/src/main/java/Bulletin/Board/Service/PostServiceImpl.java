package Bulletin.Board.Service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import Bulletin.Board.DAO.PostDAO;

@Service("PostService")
public class PostServiceImpl implements PostService {
	@Autowired
	private PostDAO postDAO;

	public int post_count() {
		// TODO Auto-generated method stub
		return postDAO.post_count();
	}
	
	public int post_count(String post_keyword) {
		return postDAO.post_count(post_keyword);
	}

	public List<HashMap<String, String>> post_list(HashMap<String, Object> post_list_range) {
		// TODO Auto-generated method stub
		return postDAO.post_list_contents(post_list_range);
	}
}
package Bulletin.Board.DAO;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

@Repository("PostDAO")
public class PostDAO extends AbstractDAO {

	public int post_count() {
		// TODO Auto-generated method stub
		return (Integer) selectOne("Post.post_count");
	}

	public int post_count(String post_keyword) {
		// TODO Auto-generated method stub
		return (Integer) selectOne("Post.post_count_keyword", post_keyword);
	}
	
	@SuppressWarnings("unchecked")
	public List<HashMap<String, String>> post_list_contents(HashMap<String, Object> post_list_contents) {
		// TODO Auto-generated method stub
		if (post_list_contents.get("post_keyword") == null)
			return selectList("Post.post_list_contents", post_list_contents);
		else
			return selectList("Post.post_list_contents_keyword", post_list_contents);
	}

	@SuppressWarnings("unchecked")
	public HashMap<String, String> post_detail(int post_index) {
		// TODO Auto-generated method stub
		return (HashMap<String, String>) selectOne("Post.post_detail", post_index);
	}
}
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

	@SuppressWarnings("unchecked")
	public List<HashMap<String, String>> post_list_contents(HashMap<String, Integer> post_list_count) {
		// TODO Auto-generated method stub
		return selectList("Post.post_list_contents", post_list_count);
	}
}
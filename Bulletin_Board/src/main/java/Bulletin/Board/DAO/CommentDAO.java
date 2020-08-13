package Bulletin.Board.DAO;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

@Repository("CommentDAO")
public class CommentDAO extends AbstractDAO {
	public boolean comment_write(HashMap<String, String> comment_write_data) {
		// TODO Auto-generated method stub
		try {
			insert("Comment.comment_write", comment_write_data);
			
			return true;
		} catch(Exception e) {
			return false;
		}
	}

	@SuppressWarnings("unchecked")
	public List<HashMap<String, String>> post_detail_comment(int post_index) {
		// TODO Auto-generated method stub
		return selectList("Comment.post_detail_comment", post_index);
	}

	public boolean comment_delete(String comment_index) {
		// TODO Auto-generated method stub
		try {
			update("Comment.comment_delete", comment_index);
			
			return true;
		} catch(Exception e) {
			return false;
		}
	}
}
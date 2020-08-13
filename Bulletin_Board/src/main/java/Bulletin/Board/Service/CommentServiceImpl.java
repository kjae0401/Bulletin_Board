package Bulletin.Board.Service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import Bulletin.Board.DAO.CommentDAO;

@Service("CommentService")
public class CommentServiceImpl implements CommentService {
	@Autowired
	private CommentDAO commentDAO;
	
	public boolean comment_write(HashMap<String, String> comment_write_data) {
		// TODO Auto-generated method stub
		return commentDAO.comment_write(comment_write_data);
	}

	public List<HashMap<String, String>> post_detail_comment(int post_index) {
		// TODO Auto-generated method stub
		return commentDAO.post_detail_comment(post_index);
	}

	public boolean comment_delete(String comment_index) {
		// TODO Auto-generated method stub
		return commentDAO.comment_delete(comment_index);
	}
}
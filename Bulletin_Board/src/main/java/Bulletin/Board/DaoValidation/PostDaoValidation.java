package Bulletin.Board.DaoValidation;

public class PostDaoValidation {
	public static boolean post_write_validation(String writter_id, String post_title, String post_contents) {
		boolean result = false;
		
		if ((writter_id == "" || writter_id == null) || (writter_id == "" || writter_id == null) ||
				(writter_id == "" || writter_id == null)) {
			result = false;
		} else {
			result = true;
		}
		
		return result;
	}
	
	public static boolean post_update_validation(String post_index, String post_contents) {
		boolean result = false;
		
		if ((post_index == "" || post_index == null) || (post_contents == "" || post_contents == null)) {
			result = false;
		} else {
			result = true;
		}
		
		return result;
	}
}
package Bulletin.Board.DAO;

import java.util.HashMap;

import org.springframework.stereotype.Repository;

@Repository("UserDAO")
public class UserDAO extends AbstractDAO {

	public boolean login(HashMap<String, String> input_data) {
		// TODO Auto-generated method stub
		boolean result = (selectOne("User.login_query", input_data).toString().equals("1")) ? true : false;
		return result;
	}

	public int signup_page_idcheck(String query_data) {
		// TODO Auto-generated method stub
		return (Integer) selectOne("User.signup_page_idcheck_query", query_data);
	}

	public boolean signup(HashMap<String, String> input_data) {
		// TODO Auto-generated method stub
		boolean result = false;
		try {
			selectOne("User.signup", input_data);
			result = true;
		} catch (Exception e) {
			// TODO: handle exception
			result = false;
		}
		
		return result;
	}
}
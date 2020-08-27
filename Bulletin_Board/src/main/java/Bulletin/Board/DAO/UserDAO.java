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

	public String find_id_page_action(String query_data) {
		// TODO Auto-generated method stub
		String result = "";
		
		result = (String) selectOne("User.find_id_page_action", query_data);
		return result;
	}

	public boolean find_pwd_page_action(HashMap<String, String> query_data) {
		// TODO Auto-generated method stub
		boolean result = (selectOne("User.find_pwd_page_action", query_data).toString().equals("1")) ? true : false;
		
		return result;
	}

	public boolean find_pwd_page_last_action(HashMap<String, String> query_data) {
		// TODO Auto-generated method stub
		boolean result;
		
		try {
			update("User.find_pwd_page_last_action", query_data);
			result = true;
		} catch (Exception e) {
			result = false;
		}
		
		return result;
	}
}
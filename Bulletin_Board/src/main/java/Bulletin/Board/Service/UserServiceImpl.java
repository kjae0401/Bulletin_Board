package Bulletin.Board.Service;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import Bulletin.Board.DAO.UserDAO;

@Service("UserService")
public class UserServiceImpl implements UserService {
	@Autowired
	private UserDAO userDAO;

	public boolean login(HashMap<String, String> input_data) {
		// TODO Auto-generated method stub
		return userDAO.login(input_data);
	}

	public int signup_page_idcheck(String query_data) {
		// TODO Auto-generated method stub
		return userDAO.signup_page_idcheck(query_data);
	}

	public boolean signup(HashMap<String, String> input_data) {
		// TODO Auto-generated method stub
		return userDAO.signup(input_data);
	}

	public String find_id_page_action(String query_data) {
		// TODO Auto-generated method stub
		return userDAO.find_id_page_action(query_data);
	}

	public boolean find_pwd_page_action(HashMap<String, String> query_data) {
		// TODO Auto-generated method stub
		return userDAO.find_pwd_page_action(query_data);
	}

	public boolean find_pwd_page_last_action(HashMap<String, String> query_data) {
		// TODO Auto-generated method stub
		return userDAO.find_pwd_page_last_action(query_data);
	}

	public boolean change_email_page_action(HashMap<String, String> email_change_query_data) {
		// TODO Auto-generated method stub
		return userDAO.change_email_page_action(email_change_query_data);
	}
}
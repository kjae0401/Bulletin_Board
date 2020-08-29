package Bulletin.Board.Service;

import java.util.HashMap;

public interface UserService {
	public boolean login(HashMap<String, String> input_data) throws Exception;
	public int signup_page_idcheck(String input_data) throws Exception;
	public boolean signup(HashMap<String, String> input_data) throws Exception;
	public String find_id_page_action(String query_data) throws Exception;
	public boolean find_pwd_page_action(HashMap<String, String> query_data) throws Exception;
	public boolean find_pwd_page_last_action(HashMap<String, String> query_data) throws Exception;
	public boolean change_email_page_action(HashMap<String, String> email_change_query_data) throws Exception;
}
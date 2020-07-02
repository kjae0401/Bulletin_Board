package Bulletin.Board.Service;

import java.util.HashMap;

public interface UserService {
	public boolean login(HashMap<String, String> input_data) throws Exception;
	public int signup_page_idcheck(String input_data) throws Exception;
	public boolean signup(HashMap<String, String> input_data) throws Exception;
}
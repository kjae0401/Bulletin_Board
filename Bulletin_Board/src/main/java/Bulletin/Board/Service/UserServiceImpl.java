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
}
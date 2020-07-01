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

}

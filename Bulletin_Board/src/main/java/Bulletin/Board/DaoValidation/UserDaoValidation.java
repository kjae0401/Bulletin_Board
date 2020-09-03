package Bulletin.Board.DaoValidation;

public class UserDaoValidation {
	public static String change_pwd_validation(String change_current_pwd, String change_input_pwd, String change_input_pwd_check) {
		String result = "";

		if (change_current_pwd == "" || change_current_pwd == null) { result = "change_current_pwd empty"; }
		else if (change_input_pwd == ""  || change_input_pwd == null) { result = "change_input_pwd emtpy"; }
		else if (change_input_pwd_check == ""  || change_input_pwd_check == null) { result = "change_input_pwd_check empty"; }
		if (result != "") { return result; }
		
		if (change_input_pwd.length() < 8 || change_input_pwd.length() > 16 ) { 
			result = "change_input_pwd pattern error";
		} else {
			for (int i=0; i<change_input_pwd.length(); i++) {
				int asc_code = change_input_pwd.charAt(i);
				
				if (!((asc_code >= 97 && asc_code <= 122) || (asc_code >= 65 && asc_code <= 90) ||
						(asc_code >= 48 && asc_code <= 57))) {
					result = "change_input_pwd pattern error";
					return result;
				}
			}
		}
		if (result != "") { return result; }
		
		if (!change_input_pwd.equals(change_input_pwd_check)) {
			result = "change_input_pwd not equals";
			return result;
		}
		
		result = "validation success";
		return result;
	}
	
	public static String signup_validation(String signup_id, String signup_password, String signup_password_check, String signup_email) {
		String result = "";
		
		if ((signup_id == "" || signup_id == null) || (signup_password == "" || signup_password == null) || (signup_password_check == "" || signup_password == null) ||
				(signup_email == "" || signup_email == null) || !(signup_password.equals(signup_password_check)) || (signup_id.length() < 5 || signup_id.length() > 20) ||
				(signup_password.length() < 8 || signup_password.length() > 16)) {
			result = "fail";
			return result;
		}
		
		for (int i=0; i<signup_id.length(); i++) {
			int asc_code = signup_id.charAt(i);
			
			if (!((asc_code >= 97 && asc_code <= 122) || (asc_code >= 65 && asc_code <= 90) ||
					(asc_code >= 48 && asc_code <= 57))) {
				result = "fail";
				return result;
			}
		}
		
		for (int i=0; i<signup_password.length(); i++) {
			int asc_code = signup_password.charAt(i);
			
			if (!((asc_code >= 97 && asc_code <= 122) || (asc_code >= 65 && asc_code <= 90) ||
					(asc_code >= 48 && asc_code <= 57))) {
				result = "fail";
				return result;
			}
		}
		
		return result;
	}
}
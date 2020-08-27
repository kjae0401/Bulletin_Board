<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="ko">
	<head>
		<meta charset="utf-8">
	    <meta http-equiv="X-UA-Compatible" content="IE=edge">
	    <meta name="viewport" content="width=device-width, initial-scale=1">
		<!-- jQuery, bootstarp CSS, JS -->
	    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css"/>
		<!-- custom css -->
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/login_page.css">
		
		<script>
			var signup_result_message = "${signup_result_message}"
			
			if (signup_result_message == 'signup_success')
				alert('회원 가입에 성공하였습니다. 입력한 이메일로 인증 메일이 발송됩니다.')
			else if (signup_result_message == 'signup_fail')
				alert('회원 가입에 실패하였습니다. 다시 시도해주세요.')
		</script>
		
		<title>Log-In</title>
	</head>
	
	<body>
		<div class="login-page">
		  <div class="form">
		    <form class="login-form" method="post" action="login_page_action.do" onsubmit="return login_input_value_check()">
		      <input type="text" name="user_id" placeholder="ID"/>
		      <input type="password" name="user_password" placeholder="Password"/>
		      <input class="submit_button" type="submit" value="LOGIN"/>
		      <p class="login_fail_message">
		      <p class="message">Forgot your ID? <a href="javascript:void(0);" onclick="find_id_page();">CLICK HERE</a></p>
		      <p class="message">Forgot your PASSWORD? <a href="javascript:void(0);" onclick="find_pwd_page();">CLICK HERE</a></p>
		      <p class="message">Not registered? <a href="signup_page.do">Create an account</a></p>
		    </form>
		  </div>
		</div>
	    
	    <script>
	    	var login_fail_message = "${login_fail_message}"
	    	
	    	if (login_fail_message == 'login_fail')
	    		$('.login_fail_message').text('가입하지 않은 아이디이거나, 잘못된 비밀번호입니다.')

	    	function login_input_value_check() {
	    		if ($('input[name=user_id]').val() == "") {
	    			$('.login_fail_message').text('아이디를 입력해주세요.')
	    			$('input[name=user_id]').focus()
	    			return false
	    		}
	    		if ($('input[name=user_password]').val() == "") {
	    			$('.login_fail_message').text('비밀번호를 입력해주세요.')
	    			$('input[name=user_password]').focus()
	    			return false
	    		}
	    		
	    		return true
	    	}
	    	
	    	var find_id_page_history = null
	    	
	    	function find_id_page() {
	    		var url = '/Bulletin_Board/find_id_page.do'
	    		var name = '_blank'
	    		var specs = "'resizable=no', 'width=160', 'height=90'"
	    		
	    		if (find_id_page_history == null) {
	    			find_id_page_history = window.open(url, name, specs)
	    		} else {
	    			if (find_id_page_history.closed) {
	    				find_id_page_history = window.open(url, name, specs)
	    			}
	    		}
	    		
	    		find_id_page_history.focus()
	    	}
	    	
	    	var find_pwd_page_history = null
	    	
	    	function find_pwd_page() {
	    		var url = '/Bulletin_Board/find_pwd_page.do'
	    		var name = '_blank'
	    		var specs = "'resizable=no', 'width=160', 'height=90'"
	    		
	    		if (find_pwd_page_history == null) {
	    			find_pwd_page_history = window.open(url, name, specs)
	    		} else {
	    			if (find_pwd_page_history.closed) {
	    				find_pwd_page_history = window.open(url, name, specs)
	    			}
	    		}
	    		
	    		find_pwd_page_history.focus()
	    	}
	    </script>
	</body>
</html>
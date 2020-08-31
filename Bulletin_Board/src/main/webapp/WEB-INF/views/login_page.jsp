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
				
		<title>Log-In</title>
	</head>
	
	<body>
		<div class="login-page">
		  <div class="form">
		    <form class="login-form" method="post" onsubmit="return login_input_value_check()">
		      <input type="text" name="user_id" placeholder="ID"/>
		      <input type="password" name="user_password" placeholder="Password"/>
		      <input class="submit_button" type="submit" value="LOGIN"/>
		      <p class="login_fail_message">
		      <p class="message">Forgot your ID? <a href="javascript:void(0);" onclick="find_id_page();">CLICK HERE</a></p>
		      <p class="message">Forgot your PASSWORD? <a href="javascript:void(0);" onclick="find_pwd_page();">CLICK HERE</a></p>
		      <p class="message">Not registered? <a href="javascript:void(0)" onclick="signup_page()">Create an account</a></p>
		    </form>
		  </div>
		</div>

	    <script>
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
	    		
	    		$.ajax({
					url : "/Bulletin_Board/login_page_action.do",
					type : "post",
					data : {"user_id" : $('input[name=user_id]').val(), "user_password" : $('input[name=user_password]').val()},
					dataType : "html",
					success : function(result) {
						if (result == '') {
							$('.login_fail_message').text('가입하지 않은 아이디이거나, 잘못된 비밀번호입니다.')
						} else {
							location.href = result
						}
					}
				})
	    		
	    		return false
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
	    	
	    	var signup_page_history = null
	    	
	    	function signup_page() {
	    		var url = '/Bulletin_Board/signup_page.do'
	    		var name = '_blank'
	    		var specs = "'resizable=no', 'width=160', 'height=90'"
	    		
	    		if (signup_page_history == null) {
	    			signup_page_history = window.open(url, name, specs)
	    		} else {
	    			if (signup_page_history.closed) {
	    				signup_page_history = window.open(url, name, specs)
	    			}
	    		}
	    		
	    		signup_page_history.focus()
	    	}
	    </script>
	</body>
</html>
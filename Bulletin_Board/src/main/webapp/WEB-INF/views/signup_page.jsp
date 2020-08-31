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
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/signup_page.css">
		<!-- custom js -->
		<script src="${pageContext.request.contextPath}/js/page_close_function.js"></script>
		
		<title>Sign-Up</title>
	</head>
	
	<body>
		<div class="signup-page">
		  <div class="form">
		    <form class="signup-form" method="post" action="signup_page_action.do" onsubmit="return signup_input_value_check()">
				<input type="text" name="signup_id" placeholder="ID"/>
				<p class="signup_id_fail_message"></p>
				
				<input type="password" name="signup_password" placeholder="Password" autocomplete="new-password"/>
				<p class="signup_password_fail_message"></p>
				
				<input type="password" name="signup_password_check" placeholder="Password 재확인"/>
				<p class="signup_password_check_fail_message"></p>
				
				<input type="email" name="signup_email" placeholder="Email"/>
				<p class="signup_email_fail_message"></p>
						      
				<input class="submit_button" type="submit" value="가입하기"/>
		    </form>
		  </div>
		</div>

	    <script>
		    $(window).load(function () {
	    		window.resizeTo(560, 720)
	    	})
	    
		    var input_class_name = new Array("input[name=signup_id]", "input[name=signup_password]", "input[name=signup_password_check]", "input[name=signup_email]")
			var p_class_name = new Array(".signup_id_fail_message", ".signup_password_fail_message", ".signup_password_check_fail_message", ".signup_email_fail_message")
		    var flag
		    
	    	function signup_input_value_check() {
		    	flag = -1
		    	
	    		for (var i=0; i<input_class_name.length; i++) {
	    			$(input_class_name[i]).focus()
	    			$(input_class_name[i]).blur()	    			
	    		}
		    	
	    		if (flag != -1) {
			    	$(input_class_name[flag]).focus()
			    	return false
	    		} else {
	    			$.ajax({
						url : "/Bulletin_Board/signup_page_action.do",
						type : "post",
						data : {"signup_id" : $(input_class_name[0]).val(), "signup_password" : $(input_class_name[1]).val(), "signup_email" : $(input_class_name[3]).val()},
						dataType : "html",
						success : function(result) {
							if (result == 'success') {
								alert('회원가입에 성공하였습니다.')
								page_close()
							} else {
								alert('회원가입에 실패하였습니다. 다시 시도해주세요.')
								location.reload()
							}
						}
					})
	    			
	    			return false
	    		}
	    	}
		    
		    $(input_class_name[0]).focusout(function() {
		    	var id = $(this).val()
		    	var regex = /^[A-Za-z0-9+]{5,20}$/
		    	flag = (flag == -1) ? 0 : flag
		    	
		    	if (id == "") {
		    		$(p_class_name[0]).text('필수 정보입니다.')
		    		$(p_class_name[0]).attr("style", "color:red")
		    	} else if (!regex.test(id)) {
		    		$(p_class_name[0]).text('5~20자의 영문 대 소문자, 숫자만 사용 가능합니다.')
		    		$(p_class_name[0]).attr("style", "color:red")
		    	} else {
		    		$.ajax({
						url : "/Bulletin_Board/signup_page_idcheck.do",
						type : "post",
						data : {"signup_input_id" : id},
						async: false,
						success : function(data) {
							if (data == 1) {
								$(p_class_name[0]).text('이미 사용중인 아이디입니다.')
								$(p_class_name[0]).attr("style", "color:red")
							} else {
								$(p_class_name[0]).text('사용 가능한 아이디입니다.')
								$(p_class_name[0]).attr("style", "color:green")
								flag = -1
							}
						}
					})
		    	}
		    });
		    
		    $(input_class_name[1]).focusout(function() {
		    	var password = $(this).val()
		    	var regex = /^[A-Za-z0-9+]{8,16}$/
	    		flag = (flag == -1) ? 1 : flag

		    	if (password == "") {
		    		$(p_class_name[1]).text('필수 정보입니다.')
		    	} else if (!regex.test(password)) {
		    		$(p_class_name[1]).text('8~16자의 영문 대 소문자, 숫자만 사용 가능합니다.')
		    	} else {
		    		$(p_class_name[1]).text('')
		    		flag = -1
		    	}
		    });
		    
		    $(input_class_name[2]).focusout(function() {
		    	var password_check = $(this).val()
		    	flag = (flag == -1) ? 2 : flag
		    	
		    	if (password_check == "") {
		    		$(p_class_name[2]).text('필수 정보입니다.')
		    	} else if (password_check != $(input_class_name[1]).val()) {
		    		$(p_class_name[2]).text('비밀번호가 일치하지 않습니다.')
		    	} else {
		    		$(p_class_name[2]).text('')
		    		flag = -1
		    	}
		    });
		    
		    $(input_class_name[3]).focusout(function() {
		    	var email = $(this).val()
		    	var regex = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i
		    	flag = (flag == -1) ? 3 : flag
		    	
		    	if (email == "") {
		    		$(p_class_name[3]).text('필수 정보입니다.')
		    	} else if (!regex.test(email)){
		    		$(p_class_name[3]).text('이메일 형식이 올바르지 않습니다.')
		    	} else {
		    		$(p_class_name[3]).text('')
		    		flag = -1
		    	}
		    });
	    </script>
	</body>
</html>
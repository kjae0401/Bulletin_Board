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
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/find_pwd_page.css">
				
		<title>Forgot yout ID?</title>
	</head>
	
	<body>
	    <div class="find_pwd_form">
		  <div class="form">
		    <form method="post" onsubmit="return find_pwd()" autocomplete="off">
			  <input type="text" name="find_id" placeholder="가입 시 등록한 ID를 입력하세요."/>
		      <input type="text" name="find_email" placeholder="가입 시 등록한 Email을 입력하세요."/>
		      <input class="button" type="submit" value="찾기"/>
		      <p class="find_pwd_message">
		    </form>
		  </div>
		</div>
		
	    <script>
	    	$(window).load(function () {
	    		window.resizeTo(560, 640)
	    	})
	    	
	    	function find_pwd() {
	    		var id = $('input[name=find_id]').val()
	    		var email = $('input[name=find_email]').val()
	    		
	    		if (id == "") {
	    			$('.find_pwd_message').text('ID를 입력해주세요.')
	    			$('input[name=find_id]').focus()
	    		} else {
	    			if (email == "") {
		    			$('.find_pwd_message').text('이메일을 입력해주세요.')
		    			$('input[name=find_email]').focus()
		    		} else {
		    			$.ajax({
							url : "/Bulletin_Board/find_pwd_page_action.do",
							type : "post",
							data : {"input_id" : id, "input_email" : email},
							dataType : "json",
							success : function(data) {
								if (data == "") {
									$('form').remove()
									$('.form').append("<h3>일치하는 정보가 없습니다.</h3>")
									$('.form').append("<input type='button' class='button' onclick='page_close();' value='닫기'/>")
								} else {
									$('form').remove()
									var user_id = "<input type='hidden' name='user_id' value='" + id + "'/>"
									var input_pwd = "<input type='password' name='input_pwd' placeholder='변경할 비밀번호를 입력하세요' />"
									var input_pwd_check = "<input type='password' name='input_pwd_check' placeholder='변경할 비밀번호를 다시 입력하세요.' />"
									var find_pwd_last_action_button = "<input type='submit' class='button' value='완료' />"
									var input_pwd_message = "<p class='find_pwd_message'>"
									$('.form').append("<form method='post' onsubmit='return find_pwd_page_last_action();' autocomplete='off'>" + user_id + input_pwd + input_pwd_check + find_pwd_last_action_button + input_pwd_message + " </form>")
								}
							}
						})
		    		}
	    		}
	    		return false
	    	}
	    	
	    	function find_pwd_page_last_action() {
	    		var id = $('input[name=user_id]').val()
	    		var pwd = $('input[name=input_pwd]').val()
	    		var pwd_check = $('input[name=input_pwd_check]').val()
	    		var regex = /^[A-Za-z0-9+]{8,16}$/
	    		
	    		if (pwd == "") {
	    			$('.find_pwd_message').text('변경할 비밀번호를 입력해주세요.')
	    			$('input[name=input_pwd]').focus()
	    		} else if (!regex.test(pwd)) {
		    		$('.find_pwd_message').text('8~16자의 영문 대 소문자, 숫자만 사용 가능합니다.')
		    		$('input[name=input_pwd]').focus()
		    	} else {
		    		$('.find_pwd_message').text('')
		    		
		    		if (pwd_check == "") {
		    			$('.find_pwd_message').text('변경할 비밀번호를 다시 입력해주세요.')
		    			$('input[name=input_pwd_check]').focus()
		    		} else if (pwd_check != pwd) {
		    			$('.find_pwd_message').text('비밀번호가 일치하지 않습니다.')
		    			$('input[name=input_pwd_check]').focus()
		    		} else {		    			
		    			$('.find_pwd_message').text('')
		    			
		    			$.ajax({
							url : "/Bulletin_Board/find_pwd_page_last_action.do",
							type : "post",
							data : {"user_id" : id, "input_pwd" : pwd},
							dataType : "json",
							success : function(data) {
								$('form').remove()
								
								if (data) {
									$('.form').append("<h3>비밀번호를 변경하였습니다.</h3>")
								} else {
									$('.form').append("<h3>비밀번호 변경에 실패하였습니다.</h3>")
								}
								
								$('.form').append("<input type='button' class='button' onclick='page_close();' value='닫기'/>")
							}
						})
		    		}
		    	}
	    		return false
	    	}
	    	
	    	function page_close() {
	    		window.open('about:blank', '_self').self.close()
	    	}
	    </script>
	</body>
</html>
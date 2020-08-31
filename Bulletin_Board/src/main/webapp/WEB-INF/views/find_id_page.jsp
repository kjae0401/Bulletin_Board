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
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/find_id_page.css">
		<!-- custom js -->
		<script src="${pageContext.request.contextPath}/js/page_close_function.js"></script>
		
		<title>Forgot yout ID?</title>
	</head>
	
	<body>
	    <div class="find_id_form">
		  <div class="form">
		    <form method="post" onsubmit="return find_id()" autocomplete="off">
		      <input type="text" name="find_email" placeholder="가입 시 등록한 Email을 입력하세요."/>
		      <input class="button" type="submit" value="찾기"/>
		      <p class="find_id_message">
		    </form>
		  </div>
		</div>
		
	    <script>
	    	$(window).load(function () {
	    		window.resizeTo(560, 640)
	    	})
	    	
	    	function find_id() {
	    		var email = $('input[name=find_email]').val()
	    		
	    		if (email == "") {
	    			$('.find_id_message').text('이메일을 입력해주세요.')
	    			$('input[name=find_email]').focus()
	    		} else {
	    			$.ajax({
						url : "/Bulletin_Board/find_id_page_action.do",
						type : "post",
						data : {"input_email" : email},
						success : function(data) {
							$('form').remove()
							
							if (data == "") {
								$('.form').append("<h3>존재하는 ID가 없습니다.</h3>")
							} else {
								$('.form').append("<h3>ID : " + data + " 입니다.</h3>")
							}
							$('.form').append("<input type='button' class='button' onclick='page_close();' value='닫기'/>")
						}
					})
	    		}
	    		
	    		return false
	    	}
	    </script>
	</body>
</html>
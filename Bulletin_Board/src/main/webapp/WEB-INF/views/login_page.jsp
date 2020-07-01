<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="ko">
	<head>
		<meta charset="utf-8">
	    <meta http-equiv="X-UA-Compatible" content="IE=edge">
	    <meta name="viewport" content="width=device-width, initial-scale=1">
		
		<!-- custom css -->
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/login_page.css">
		<!-- 합쳐지고 최소화된 최신 CSS -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
		<title>Log-In</title>
	</head>
	
	<body>
		<div class="login-page">
		  <div class="form">
		    <form class="login-form" method="post" action="login_page_action.do">
		      <input type="text" name="user_id" placeholder="ID"/>
		      <input type="password" name="user_password" placeholder="Password"/>
		      <input class="submit_button" type="submit" value="LOGIN"/>
		      <p class="login_fail_message">
		      <p class="message">Not registered? <a href="#">Create an account</a></p>
		    </form>
		  </div>
		</div>
	
		<!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요합니다) -->
	    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	    <!-- 모든 컴파일된 플러그인을 포함합니다 (아래), 원하지 않는다면 필요한 각각의 파일을 포함하세요 -->
	    <script src="js/bootstrap.min.js"></script>
	</body>
</html>
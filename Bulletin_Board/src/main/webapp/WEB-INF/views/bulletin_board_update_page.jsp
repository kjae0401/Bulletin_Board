<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
	Object obj = request.getSession().getAttribute("user_id");
	String user_id;
	
	if (obj == null)
		user_id = "로그인";
	else
		user_id = (String) obj;
%>

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
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bulletin_board_update_page.css">
		
		<title>Bulletin Board</title>
	</head>
	
	<body>
		<nav class="navbar navbar-default">
			<div class="container-fluid">
		    	<!-- Brand and toggle get grouped for better mobile display -->
		    	<div class="navbar-header">
		      		<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
		        		<span class="sr-only">Toggle navigation</span>
		        		<span class="icon-bar"></span>
		        		<span class="icon-bar"></span>
		       			<span class="icon-bar"></span>
		      		</button>
		      		<a class="navbar-brand" href="/Bulletin_Board/bulletin_board_main_page.do">Spring 게시판</a>
		    	</div>
		    	
				<!-- Collect the nav links, forms, and other content for toggling -->
			    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			    	<ul class="nav navbar-nav">
			        	<li><a href="#">게시판</a></li>
			        	<li class="active"><a href="#">글쓰기<span class="sr-only">(current)</span></a></li>
			      	</ul>
	
					<ul class="nav navbar-nav navbar-right">
				        <% if (!user_id.equals("로그인")) { %>
					        <li class="dropdown">
					        	<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><%= user_id %> <span class="caret"></span></a>
					        	<ul class="dropdown-menu" role="menu">
					            	<li><a href="logout_action.do">로그아웃</a></li>
					          	</ul>
							</li>
						<% } else { %>
							<li><a href="login_page.do">로그인</a></li>
						<% } %>
					</ul>
		    	</div><!-- /.navbar-collapse -->
			</div><!-- /.container-fluid -->
		</nav>
		
		<table class="table">
			<caption><a href="/Bulletin_Board/bulletin_board_main_page.do">게시판</a></caption>
			<colgroup>
				<col width=20%>
				<col width=80%>
			</colgroup>
			
			<form action="bulletin_board_update_page_action.do" method="post">
				<input type="hidden" name="post_index" value="${post_index}"/>
				
				<thead>
					<tr>
						<td>제목</td>
						<td><label>${post_title}</label></td>
					</tr>
				</thead>
				
				<tbody>
					<tr>
						<td>내용</td>
						<td><textarea name="post_contents">${post_contents}</textarea></td>
					</tr>
					
					<tr>
						<td class="go_list_button">
							<button type="button" class="btn btn-primary" onclick="location.href='/Bulletin_Board/bulletin_board_main_page.do'">취소</button>
						</td>
						<td class="update_action_button">
							<button type="submit" class="btn btn-primary">수정</button>
						</td>
					</tr>
				</tbody>
			</form>
		</table>
		
		<script>
			
		</script>
	</body>
</html>
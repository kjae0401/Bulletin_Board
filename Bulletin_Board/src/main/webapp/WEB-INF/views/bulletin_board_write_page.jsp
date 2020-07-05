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
		<!--<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bulletin_board_main_page.css">-->
		
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
			        	<li class="active"><a href="#">게시판 <span class="sr-only">(current)</span></a></li>
			        	<li><a href="#">Link</a></li>
			      	</ul>
	
					<ul class="nav navbar-nav navbar-right">
				        <li class="dropdown">
				        	<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Dropdown <span class="caret"></span></a>
				        	<ul class="dropdown-menu" role="menu">
				            	<li><a href="#">Action</a></li>
				            	<li><a href="#">Another action</a></li>
				            	<li><a href="#">Something else here</a></li>
				            
				            	<li class="divider"></li>
				            	<li><a href="#">로그아웃</a></li>
				          	</ul>
						</li>
					</ul>
		    	</div><!-- /.navbar-collapse -->
			</div><!-- /.container-fluid -->
		</nav>
		
		<table>
			<caption><a href="/Bulletin_Board/bulletin_board_main_page.do">게시판</a></caption>
			
			<tbody>
				<tr>
					<td>제목</td>
					<td><input type="text"/></td>
				</tr>
				
				<tr>
					<td>내용</td>
					<td><textarea ></textarea></td>
				</tr>
			</tbody>
		</table>
		
		<button type="button" class="btn btn-primary" href="#">글쓰기</button>
	</body>
</html>
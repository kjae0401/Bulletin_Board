<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!-- JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bulletin_board_detail_page.css">
		
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
				<col style="width:20%">
				<col style="width:80%">
			</colgroup>
				
			<thead>
				<tr>
					<th colspan="5"><div class="text-ellipsis"><p class="post_title"><c:out value="${post_detail.post_title }"/></p></div></th>
				</tr>
			</thead>
			
			<tbody>
				<tr>
					<td colspan="1">작성자</td>
					<td colspan="4"><c:out value="${post_detail.post_writter_id }"/></td>
				</tr>
	
				<tr>
					<td colspan="1">작성 시간</td>
					<td colspan="4"><fmt:formatDate value="${post_detail.post_time}" pattern="yyyy.MM.dd kk:mm:ss" /></td>
				</tr>
	
				<tr>
					<td colspan="1">조회수</td>
					<td colspan="4"><c:out value="${post_detail.post_view }"/></td>
				</tr>
				
				<tr>
					<td colspan="1">내용</td>
					<td colspan="4"><label class="post_contents"><c:out value="${post_detail.post_contents }"/></label></td>
				</tr>

				<c:if test="${Writer}">
					<tr>
						<td colspan="5" class="editable_button">
							<input type="hidden" class="post_index" value=<c:out value="${post_detail.post_index }"/> />
							<button type="button" class="btn btn-primary" onclick="post_update()">수정</button>
							<button type="button" class="btn btn-primary" onclick="post_delete()">삭제</button>
						</td>
					</tr>
				</c:if>
			</tbody>
		</table>
		
		<div class="comment_wrtie_container">
			<form action="bulletin_board_detail_page_comment_action.do" method="post">
				<input type="text" name="post_comment" placeholder="댓글">
				<input type="submit" value="작성">
			</form>
						
			<ul>
				<li class="comment_user_id">작성자</li>
				<li class="commnet_contents">내용</li>
				<li class="comment_write_time">시간</li>
				<button class="comment_delete_button" value="삭제"/>
			</ul>
			
			<ul>
				<li class="comment_user_id">작성자</li>
				<li class="commnet_contents">내용</li>
				<li class="comment_write_time">시간</li>
				<button class="comment_delete_button" value="삭제"/>
			</ul>
			
			<ul>
				<li class="comment_user_id">작성자</li>
				<li class="commnet_contents">내용</li>
				<li class="comment_write_time">시간</li>
				<button class="comment_delete_button" value="삭제"/>
			</ul>
		</div>
		
		<script>
			function post_delete() {
				if (confirm("글을 삭제하시겠습니까?") == true) {
					location.href = "/Bulletin_Board/bulletin_board_delete_action.do?post_index=" + $('.post_index').val()
				} else {
					return false
				}
			}
			
			function post_update() {
				var form = document.createElement('form')
				var key = new Array('post_index', 'post_title', 'post_contents')
				var value = new Array($('.post_index').val(), $('.post_title').text(), $('.post_contents').text())
				
				form.setAttribute('method', 'post')
				form.setAttribute('action', 'bulletin_board_update_page.do')
				document.charset = "utf-8"
				
				for (var i=0; i<key.length; i++) {
					var hiddenfield = document.createElement("input")
					hiddenfield.setAttribute('type', 'hidden')
					hiddenfield.setAttribute('name', key[i])
					hiddenfield.setAttribute('value', value[i])
					form.appendChild(hiddenfield)
				}
				
				document.body.append(form)
				form.submit()
			}
		</script>
	</body>
</html>
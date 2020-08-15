<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!-- JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bulletin_board_main_page.css">
		
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
			        	<li class="active"><a href="/Bulletin_Board/bulletin_board_main_page.do">게시판 <span class="sr-only">(current)</span></a></li>
			        	<li><a href="/Bulletin_Board/bulletin_board_write_page.do">글쓰기</a></li>
			      	</ul>
	
					<ul class="nav navbar-nav navbar-right">
				        <% if (!user_id.equals("로그인")) { %>
					        <li class="dropdown">
					        	<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><%= user_id %> <span class="caret"></span></a>
					        	<ul class="dropdown-menu" role="menu">
					        		<li><a href="">정보 수정</a></li>
					        		<li class="divider"></li>
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
		
		<div class="main_contents_container">
			<table class="table table-striped">
				<caption><a href="/Bulletin_Board/bulletin_board_main_page.do">게시판</a></caption>
				
				<colgroup>
					<col width="10%">
					<col width="40%">
					<col width="15%">
					<col width="15%">
					<col width="10%">
				</colgroup>
				
				<thead>
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>작성일</th>
						<th>조회수</th>
					</tr>
				</thead>
				
				<tbody>
					<c:if test="${empty post_list_contents}">
						<tr><td colspan="5">글이 존재하지 않습니다.</td></tr>
					</c:if>
						
					<c:forEach items="${post_list_contents }" var="post_list_contents">
						<tr>
							<td>${post_list_contents.post_index }</td>
							<td><div class="text-cllipsis"><a href="" onclick="select_post(this)">${post_list_contents.post_title }</a></div></td>
							<td>${post_list_contents.post_writter_id }</td>
							<td><fmt:formatDate value="${post_list_contents.post_time}" pattern="yyyy.MM.dd" /></td>
							<td>${post_list_contents.post_view }</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			
			<button type="button" class="btn btn-primary" onclick="location.href='/Bulletin_Board/bulletin_board_write_page.do'">글쓰기</button>
		</div>
		<br>
		
		<ul class="pagination">
			<c:if test="${pagination.startPage != 1}">
				<li><a id="prevUrl" href="">&laquo</a></li>
			</c:if>
			
			<c:forEach begin="${pagination.startPage}" end="${pagination.endPage}" var="idx">
				<c:choose>
					<c:when test="${idx == pagination.nowPage }"><li class="active"><a><b href="#">${idx }</b></a></li></c:when>
					<c:when test="${idx != pagination.nowPage }"><li><a class="indexUrl" href="" value=${idx}>${idx }</a></li></c:when>
				</c:choose>
			</c:forEach>	
			
			<c:if test="${pagination.endPage != pagination.lastPage }">
				<li><a id="nextUrl" href="">&raquo</a></li>
			</c:if>
		</ul>
		
		<form method="get" class="post_keyword_form" action="bulletin_board_main_page.do" onsubmit="return fn_keyword_search()">
			<input type="text" class="post_keyword" name="post_keyword" placeholder="Search..."/>
			<input type="submit" class="btn btn-primary" value="검색"/>
		</form>
		
		<script>
			var post_keyword = "${post_keyword}"

			if (post_keyword != "")
				$(".post_keyword").val(post_keyword)
			
			function fn_keyword_search() {
				var post_keyword = $('.post_keyword').val()

				if (post_keyword == "") {
					return false
				}
				
				return true
			}
			
			$('#prevUrl').click(function() {
				if (post_keyword == null)
					$("a#prevUrl").attr("href", "/Bulletin_Board/bulletin_board_main_page.do?nowPage=${pagination.startPage - 1}&countPerPage=${pagination.countPerPage}")
				else
					$("a#prevUrl").attr("href", "/Bulletin_Board/bulletin_board_main_page.do?nowPage=${pagination.startPage - 1}&countPerPage=${pagination.countPerPage}&post_keyword=" + post_keyword)
			});
			
			$(".indexUrl").on("click", function() {
				var click_index = $(this).attr('value')

				if (post_keyword == null)
					$(this).attr("href", "/Bulletin_Board/bulletin_board_main_page.do?nowPage=" + click_index + "&countPerPage=${pagination.countPerPage}")
				else
					$(this).attr("href", "/Bulletin_Board/bulletin_board_main_page.do?nowPage=" + click_index + "&countPerPage=${pagination.countPerPage}&post_keyword=" + post_keyword)
			});
			
			$('#nextUrl').click(function() {
				if (post_keyword == null)
					$("a#nextUrl").attr("href", "/Bulletin_Board/bulletin_board_main_page.do?nowPage=${pagination.endPage + 1}&countPerPage=${pagination.countPerPage}")
				else
					$("a#nextUrl").attr("href", "/Bulletin_Board/bulletin_board_main_page.do?nowPage=${pagination.endPage + 1}&countPerPage=${pagination.countPerPage}&post_keyword=" + post_keyword)
			});
			
			function select_post(index) {
				var select_table = index.closest("tr").getElementsByTagName("td")
				var select_element_index = select_table[0].innerText
				var select_element_writter_id = select_table[2].innerText
				
				index.href = "/Bulletin_Board/bulletin_board_detail_page.do?post_index=" + select_element_index + "&post_writter_id=" + select_element_writter_id
			}
			
			// 글 쓰기 관련 메세지
			var post_write_message = "${post_write_message}"
			
			if (post_write_message == 'post_write_success')
				alert('글이 작성되었습니다.')
			else if (post_write_message == 'post_write_fail')
				alert('글 작성에 실패했습니다.')
			
			// 글 보기 실패
			var post_detail_fail_message = "${post_detail_fail_message}"
			
			if (post_detail_fail_message == 'post_detail_fail')
				alert('존재하지 않거나 이미 삭제된 글입니다.')
				
			// 글 삭제 메시지
			var post_delete_message = "${post_delete_message}"
			
			if (post_delete_message == 'post_delete_success')
				alert('글이 삭제되었습니다.')
			else if (post_delete_message == 'post_delete_fail')
				alert('글 삭제에 실패했습니다.')
				
			// 글 수정 실패
			var post_update_message = "${post_update_message}"
			
			if (post_update_message == 'post_update_fail')
				alert('글 수정에 실패했습니다.')
		</script>
	</body>
</html>
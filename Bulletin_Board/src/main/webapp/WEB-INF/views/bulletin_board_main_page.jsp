<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!-- JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
		<table class="table table-striped">
			<caption>게시판</caption>
			
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
				<c:forEach items="${post_list_contents }" var="post_list_contents">	
					<c:if test="${fn:length(post_list_contents) == 0 }">
						<tr><td colspan="5">글이 존재하지 않습니다.</td></tr>
					</c:if>
					
					<c:if test="${fn:length(post_list_contents) != 0 }">
						<tr>
							<td>${post_list_contents.post_index }</td>
							<td><div class="text-cllipsis"><a href="#">${post_list_contents.post_title }</a></div></td>
							<td>${post_list_contents.post_writter_id }</td>
							<td><fmt:formatDate value="${post_list_contents.post_time}" pattern="yyyy.mm.dd" /></td>
							<td>${post_list_contents.post_view }</td>
						</tr>
					</c:if>
				</c:forEach>
			</tbody>
		</table>

		<ul class="pagination">
			<c:if test="${pagination.startPage != 1}">
				<li><a href="/Bulletin_Board/bulletin_board_main_page.do?nowPage=${pagination.startPage - 1}&countPerPage=${pagination.countPerPage}">&laquo</a></li>
			</c:if>
			
			<c:forEach begin="${pagination.startPage}" end="${pagination.endPage}" var="idx">
				<c:choose>
					<c:when test="${idx == pagination.nowPage }"><li class="active"><a><b href="#">${idx }</b></a></li></c:when>
					<c:when test="${idx != pagination.nowPage }"><li><a href="/Bulletin_Board/bulletin_board_main_page.do?nowPage=${idx}&countPerPage=${pagination.countPerPage}">${idx }</a></li></c:when>
				</c:choose>
			</c:forEach>	
			
			<c:if test="${pagination.endPage != pagination.lastPage }">
				<li><a href="/Bulletin_Board/bulletin_board_main_page.do?nowPage=${pagination.endPage + 1}&countPerPage=${pagination.countPerPage}">&raquo</a></li>
			</c:if>
		</ul>
	</body>
</html>
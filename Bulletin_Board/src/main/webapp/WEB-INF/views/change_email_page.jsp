<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<head>
	<!-- custom css -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/change_email_page.css">
</head>

<body>
	<div class="modal" id="change_email_modal">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">Change your email</h4>
				</div>
	
				<form method="post" onsubmit="return change_email_page_action()" autocomplete="off">
					<div class="modal-body">
						<input name="user_id" type="hidden" value="<%=request.getSession().getAttribute("user_id")%>" />
		      			<input name="change_input_email" type="email" placeholder="변경할 email을 입력해주세요." /> <br>
					</div>
		
					<div class="modal-footer">
		      			<input type="submit" class="btn btn-primary" value="변경" />
		      			<input type="button" class="btn btn-danger" data-dismiss="modal" value="취소" />
					</div>
				</form>
	    	</div>
		</div>
	</div>
	
	<script>
		function change_email_page_action() {
			var user_id = $('input[name=user_id]')
			var change_input_email = $('input[name=change_input_email]')
			
			if (change_input_email.val() == "") {
				alert('필수 입력 정보를 입력해주세요.')
				change_input_email.focus()
			} else {
				$.ajax({
					url : "/Bulletin_Board/change_email_page_action.do",
					type : "post",
					data : {"user_id" : user_id.val(), "change_input_email" : change_input_email.val()},
					dataType : "html",
					async:false,
					success : function(result) {
						if (result == 'success') {
							alert('이메일을 변경하였습니다.')
							location.reload()
						} else {
							alert('이메일 변경에 실패하였습니다. 다시 시도해주세요.')
						}
					}
				})
			}			
			return false
		}
		
		$('.modal').on('hidden.bs.modal', function(e) {
			$(this).find('form')[0].reset()
		})
	</script>
</body>
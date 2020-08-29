<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<head>
	<!-- custom css -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/change_pwd_page.css">
</head>

<body>
	<div class="modal" id="change_pwd_modal">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">Change your Password</h4>
				</div>
	
				<form method="post" onsubmit="return change_pwd_page_action()" autocomplete="off">
					<div class="modal-body">
						<input name="user_id" type="hidden" value="<%=request.getSession().getAttribute("user_id")%>" />
		      			<input name="change_current_pwd" type="password" placeholder="현재 Password를 입력해주세요." /> <br>
		      			<input name="change_input_pwd" type="password" placeholder="변경하실 Password를 입력해주세요." /> <br>
		      			<input name="change_input_pwd_check" type="password" placeholder="변경하실 Password를 다시 입력해주세요." /> <br>
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
		function change_pwd_page_action() {
			var change_current_pwd = $('input[name=change_current_pwd]')
			var change_input_pwd = $('input[name=change_input_pwd]')
			var change_input_pwd_check = $('input[name=change_input_pwd_check]')
			var user_id = $('input[name=user_id]')
			var regex = /^[A-Za-z0-9+]{8,16}$/
			
			if (change_current_pwd.val() == "") {
				alert('필수 입력 정보를 입력해주세요.')
				change_current_pwd.focus()
			} else {
				if (change_input_pwd.val() == "") {
					alert('필수 입력 정보를 입력해주세요.')
					change_input_pwd.focus()
				} else {
					if (change_input_pwd_check.val() == "") {
						alert('필수 입력 정보를 입력해주세요.')
						change_input_pwd_check.focus()
					} else {
						if (!regex.test(change_input_pwd.val())) {
							alert('8~16자의 영문 대 소문자, 숫자만 사용 가능합니다.')
							change_input_pwd.focus()
						} else {
							if (change_input_pwd.val() != change_input_pwd_check.val()) {
								alert('비밀번호가 일치하지 않습니다.')
								change_input_pwd_check.focus()
							} else {
								$.ajax({
									url : "/Bulletin_Board/change_pwd_page_action.do",
									type : "post",
									data : {"change_current_pwd" : change_current_pwd.val(), "change_input_pwd" : change_input_pwd.val(), "user_id" : user_id.val()},
									dataType : "html",
									async:false,
									success : function(data) {
										if (data == 'success') {
											alert('비밀번호를 변경하였습니다.')
											location.reload()
										} else if (data == 'pwd_fail') {
											alert('비밀번호를 다시 확인하여주세요.')
										} else {
											alert('비밀번호 변경에 실패하였습니다. 다시 시도해주세요.')
										}
									}
								})
							}
						}
					}
				}
			}
			
			return false
		}
		
		$('.modal').on('hidden.bs.modal', function(e) {
			$(this).find('form')[0].reset()
		})
	</script>
</body>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>user-my-page</title>
<%@ include file= "/resources/common/header.jsp" %>
</head>
<body>
<section class="section bg-tertiary">
	<div class="container" style="width:470px">
		<div class="justify-content-center align-items-center">
			<div class="section-title text-center">
				<p class="text-primary text-uppercase fw-bold">Delete account</p>
				<h1> 주의 </h1>
			</div>
		</div>
			<div class="shadow p-5 bg-white" style="border-radius:20px;">
				<div class="contact-form">
					<p style="font-size:1.37rem;">회원계정 탈퇴를 하실 경우 회원님께서 생성한 소소모임은 사라지게 되고 참여한 모든 소소모임에서 자동으로 탈퇴하게 됩니다.</p>
					<div class="row loginBtn" style="margin-bottom:15px;">
						<button class="btn btn-outline-primary" style="width:46%; margin:0 13px 0 10px;" onclick="delete()">회원 탈퇴</button>
						<button class="btn btn-outline-primary" style="width:46%;" onclick="location.href='/views/user/mypage'">돌아가기</button>
					</div>
				</div>
			</div>
		</div>
</section>

<script>
	function delete() {
		fetch('/user-delete/${userInfo.uiNum}', )
	}
</script>


</body>
</html>
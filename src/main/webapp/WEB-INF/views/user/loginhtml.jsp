<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file= "/resources/common/header.jsp" %>
</head>
<body>
<section class="section bg-tertiary">
	<div class="container" style="width:470px">
		<div class="justify-content-center align-items-center">
			<div class="section-title text-center">
				<p class="text-primary text-uppercase fw-bold">log in</p>
				<h1>로그인</h1>
			</div>
		</div>
			<div class="shadow p-5 bg-white" style="border-radius:20px;">
				<div class="contact-form">
					<div class="form-group mb-4 pb-2">
						<label type="text" class="form-label" >ID</label>
						<input type="text" class="form-control shadow-none" id="uiId">
					</div>
					<div class="form-group mb-4 pb-2">
						<label class="form-label">PASSWORD</label>
						<input type="password" class="form-control shadow-none" id="uiPwd">
					</div>
					<div class="row loginBtn" style="margin-bottom:15px;">
						<button class="btn btn-outline-primary" style="width:46%; margin:0 13px 0 10px;" onclick="login()">로그인</button>
						<button class="btn btn-outline-primary" style="width:46%;" onclick="location.href='/views/user/signup'">회원가입</button>
					</div>
					<a onclick="location.href='/views/user/find-user'">비밀번호를 잊으셨나요?</a>
				</div>
			</div>
		</div>
</section>
	<script>
	function login() {
				
	let param = {
			uiId : document.querySelector('#uiId').value,
			uiPwd : document.querySelector('#uiPwd').value
	};
	console.log(param);
	
	fetch('/login',{
		method:'POST',
		headers:{'Content-Type':'application/json'			
		},
		body:JSON.stringify(param)
	})
	.then(function(res){
		return res.text();
	})
	.then(function(data){
		if(data){
			data = JSON.parse(data)
			if(data.uiName != null && data.uiActive == 1){
				alert(data.uiName + '님 환영합니다!');
				/* history.go(-1); */
				 location.href='/'; 
				return;
			}
			
		}
		alert('아이디와 비밀번호를 확인해주세요.');
		uiId.focus();
	})
}
</script>
</body>
</html>
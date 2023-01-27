<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>user-login</title>
<%@ include file= "/resources/common/header.jsp" %>
</head>
<body>
	<h1>로그인</h1>
	<br>
	<input type="text" id="uiId">아이디
	<br>
	<input type="password" id="uiPwd">비밀번호
	<br>
	<br>
	<button onclick="login()">로그인</button>
	<button onclick="location.href='/views/user/signup'">회원가입</button>


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
			if(data.uiName){
				alert(data.uiName + '님 환영합니다!');
				location.href='/';
				return;
			}
		}
		
		alert('아이디와 비밀번호를 확인해주세요.');

	})
}
	</script>


</body>
</html>
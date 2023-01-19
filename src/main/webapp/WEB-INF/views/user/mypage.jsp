<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>user-my-page</title>
</head>
<body>
	<h1>마이페이지</h1>
	<br> 이름: ${userInfo.uiName}
	<br> 나이 : ${userInfo.uiAge}
	<br> 닉네임 : ${userInfo.uiNickname}
	<br> 주소 : ${userInfo.uiAddr}
	<br>
	<c:if test="${userInfo.uiImgPath ne null}">
사진 : <img src="${userInfo.uiImgPath}">
		<br>
	</c:if>
	<div id="confirm" style="display: none">
		<input type="password" id="uiPwd" placeholder="비밀번호">
		<button onclick="passwordConfirm()">비밀번호 확인</button>
	</div>
	<button onclick="showConfirm('update')">수정</button>
	<button onclick="showConfirm('delete')">탈퇴</button>

	<script>
	let _type;
	function showConfirm(type){
		_type = type;
		document.querySelector('#confirm').style.display = '';
		console.log(_type);
	}
	
	
	
	function passwordConfirm(){
		let method = 'POST'
		if(_type==='delete'){
			method = 'DELETE';	
		}
		const param = {
				uiPwd : document.querySelector('#uiPwd').value
		}
		console.log(param);
		
		
		fetch('/user-infos/${userInfo.uiNum}',{
			method : method,
			headers : {
				'Content-Type':'application/json'
			},
			body:JSON.stringify(param)
		})
		.then(function(res){
			return res.json();
		})
		.then(function(data){
			if(data===true){
				if(_type==='update'){
					location.href='/views/user/update';
				}else if(_type==='delete'){
					alert('삭제완료!');
					location.href='/';
				}
			}else{
				alert('비밀번호를 확인해주세요');
			}
		})
	}
</script>
</body>
</html>
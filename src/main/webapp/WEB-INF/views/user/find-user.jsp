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

	<h2>회원 계정찾기</h2>
	<button onclick="openIdDiv()">아이디 찾기</button>
	<button onclick="openPwdDiv()">비밀번호 찾기</button>
		<div id="idDiv" style="display: none;">
		<br>
			<input type="text" id="uiName"> 이름 <br>
			<select name="question" class="uiQuestion">
				<option value='' selected="selected">질문을 선택해 주세요.</option>
				<option value='fruit'>당신이 제일 좋아하는 과일은?</option>
				<option value='school'>당신이 나온 초등학교 이름은?</option>
				<option value='game'>당신이 즐겨하는 게임은?</option>
				<option value='city'>당신의 출신 동네는?</option>
				<option value='mountain'>당신이 제일 좋아하는 산은?</option>
				<option value='choice'>엄마와 아빠중 더 좋은사람은?</option>
			</select>질문 <br>
			<input type="text" class="uiAnswer">답변 
			<br>
			<br>
			<button onclick="findId()">아이디 찾기</button> <button onclick="location.href='/views/user/login'">돌아가기</button>
		</div>
		
		
		<div id="pwdDiv"style="display: none;">
		<br>
			<input type="text" id="uiId"> 아이디 <br>
			<select name="question" class="uiQuestion">
				<option value='' selected="selected">질문을 선택해 주세요.</option>
				<option value='fruit'>당신이 제일 좋아하는 과일은?</option>
				<option value='school'>당신이 나온 초등학교 이름은?</option>
				<option value='game'>당신이 즐겨하는 게임은?</option>
				<option value='city'>당신의 출신 동네는?</option>
				<option value='mountain'>당신이 제일 좋아하는 산은?</option>
				<option value='choice'>엄마와 아빠중 더 좋은사람은?</option>
			</select>질문 <br>
			<input type="text" class="uiAnswer">답변 
			<br>
			<br>
			<button onclick="findPwd()">비밀번호 재설정</button><button onclick="location.href='/views/user/login'">돌아가기</button>
		</div>
	
	<script>
	function openIdDiv() {
		document.querySelector('#idDiv').style.display = "";
		document.querySelector('#pwdDiv').style.display = "none";
	}
	
	function openPwdDiv() {
		document.querySelector('#pwdDiv').style.display = "";
		document.querySelector('#idDiv').style.display = "none";
	}
	
 	function findId() {
		
		const param = {
			uiName : document.querySelector('#uiName').value,
			uiQuestion : document.querySelector('.uiQuestion').value,
			uiAnswer : document.querySelector('.uiAnswer').value
		}
		
		
		fetch('/find-id',{
			method : 'POST',
			headers : {
				'Content-Type' : 'application/json'
			},
			body : JSON.stringify(param)
		})
		.then(function(res){
			return res.json()
		}).then(function(data){
			if(data){
				alert('회원님의 Id는' + data.uiId + '입니다.')
				location.href = '/views/user/find-user'
			}
		})
	} 
 	
 	
 	function findPwd(){
 		
 		
 		const param = {
 				uiId : document.querySelector('#uiId').value,
 				uiQuestion : document.querySelector('.uiQuestion').value,
 				uiAnswer : document.querySelector('.uiAnswer').value
 			}
 		
 		fetch('/find-pwd',{
			method : 'PATCH',
			headers : {
				'Content-Type' : 'application/json'
			},
			body : JSON.stringify(param)
		})
		.then(function(res){
			return res.json()
		}).then(function(data){
			if(data){
				console.log(data);
				alert('임시 비밀번호 123456789a 입니다.')
				location.href = '/views/user/find-user'
			}	alert('입력을 확인해주세요.');
		}
		
		)
 		
 	}
	
	
	
	
	</script>

</body>
</html>
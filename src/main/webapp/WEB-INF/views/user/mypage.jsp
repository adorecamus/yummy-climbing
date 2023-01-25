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
	<button onclick="showConfirm('update')">회원정보 수정</button>
	<br>
	<button onclick="showConfirm('delete')">회원 탈퇴</button>
	<br>
	


	<!--챌린지 리스트 칸 -->
	<div id="rDiv">
		<h2>${userInfo.uiNickname}의 목표!</h2>
		<table border="1">
			<tr>
				<th>번호</th>
				<th>도전 과제</th>
				<th>작성일</th>
			</tr>
			<tbody id="tBody">
			</tbody>
		</table>
	</div>



	<script>
	
	/*개인정보 함수 칸 */
	
		/* 수정or삭제 버튼 클릭시 비밀번호 확인칸이 생기는 함수 */
	let _type;
	function showConfirm(type){
		_type = type;
		document.querySelector('#confirm').style.display = '';
		console.log(_type);
	}
	
		/*각 요청에 맞게 수정이동 또는 삭제실행 함수  */
	
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
			if(data===true || data===1){
				if(_type==='update'){
					location.href='/views/user/update';
				}else if(_type==='delete'){
					alert('삭제완료!');
					location.href='/';
				}
			}else{
				alert('비밀번호를 확인해주세요');
			}
		});
	}
	
	/* 개인정보 칸 함수 끝 */
	
	
	/*리스트 함수 칸*/
	
	function getChallengeList(){
		fetch("/challenge-list/${userInfo.uiNum}")
		.then(function(res){
			return res.json();
		})
		.then(function(userChallenge){
			let html = '';
			for(let i=0;i<userChallenge.length;i++){
			html += '<tr>'
			html += '<td>' + userChallenge.ucNum + '</td>';
			html += '<td><a href="/views/challengeList/view?ucNum=' + userChallenge.ucNum + '">' + userChallenge.ucChallenge + '</td>';
			html += '<td>' + userChallenge.ucCredat + '</td>';
			html +=  '</tr>'
			}
			document.querySelector('#tBody').innerHTML = html;	
		});
	}
	window.onload = function(){
		getChallengeList();
	}
	
	/*리스트 함수 칸 끝*/
	
</script>
</body>
</html>
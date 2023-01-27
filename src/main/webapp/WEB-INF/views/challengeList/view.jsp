<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="/resources/common/header.jsp"%>
<link href="/resources/css/style1.css" rel="stylesheet" type="text/css">
<link href="/resources/css/style.css" rel="stylesheet" type="text/css">
</head>
<body>
	<h2>챌린지 정보</h2>
	<table border="1">
		<tr>
			<th>도전 목표</th>
			<th>생성일</th>
		</tr>
	</table>
	<br>
	
	<textarea rows="3" cols="40" id="ucChallenge" style="resize: none;"
		placeholder="${userChallenge.cuChallenge}"></textarea>
	<br>

	<button onclick="updateUserChallenge()">수정</button>
	<button onclick="deleteUserChallenge()">도전 성공!</button>
	<button onclick="location.href='/views/user/mypage'">돌아가기</button>

	<script>
		function getChallenge() {
			
			fetch('/get-challenge')
		}
	
		
	
	
	
		/*챌린지 리스트 수정 함수 */
				
		function updateUserChallenge() {

			const param = {
				ucChallenge : document.querySelector('#ucNum').value
			}

			fetch('/user-challenge/${cuNum}', {
				method : 'PATCH',
				headers : {
					'Content-Type' : 'application/json'
				},
				body : JSON.stringify(param)
			}).then(function(res) {
				return res.json();
			}).then(function(data) {
				if (date === 1) {
					alert('수정 완료');
					location.href = '/views/user/mypage';
				}
			});
		}

		/*챌린지 리스트 삭제 함수 */
		function deleteUserChallenge() {
			fetch('/user-challenge/${userChallenge.cuNum}', {
				method : 'DELETE'
			}).then(function(res) {
				return res.json();
			}).then(function(data) {
				if (data === 1) {
					alert('앞으로도 화이팅!');
					location.href = '/views/user/mypage';
				}
			});
		}
	</script>

</body>
</html>
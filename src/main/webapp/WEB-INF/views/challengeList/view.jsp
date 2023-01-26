<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>챌린지 정보</h2>
	<input type="text" id="ucNum" value="${userChallenge.cuNum}" disabled>번호
	<br>
	<input type="text" id="ucChallenge" value="${userChallenge.cuChallenge}" >나의 도전!
	<br>
	<input type="text" id="ucCredat" value="${userChallenge.cuCredat}" disabled>생성일
	<br>


<button onclick="updateUserChallenge()">수정</button>
<button onclick="deleteUserChallenge()">도전 성공!</button>
<button onclick="location.href='/views/user/mypage'">돌아가기</button>

<script>

/*챌린지 리스트 수정 함수 */
function updateUserChallenge(){
	
	const param = {
			ucChallenge : document.querySelector('#ucNum').value
	}
	
	fetch('/user-challenge/${userChallenge.cuNum}',{
		method : 'PATCH',
		headers : {
			'Content-Type' : 'application/json'
		},
		body : JSON.stringify(param)
	})
	.then(function(res){
		return res.json();
	}).then(function(data){
		if(date === 1){
			alert('수정 완료');
			location.href='/views/user/mypage';
		}
	});
}


/*챌린지 리스트 삭제 함수 */
function deleteUserChallenge(){
	fetch('/user-challenge/${userChallenge.cuNum}',{
		method:'DELETE'
	})
	.then(function(res){
		return res.json();
	})
	.then(function(data){
		if(data===1){
			alert('앞으로도 화이팅!');
			location.href='/views/user/mypage';
		}
	});
}

</script>

</body>
</html>
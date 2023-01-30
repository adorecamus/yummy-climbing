<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>소모임 가입</title>
</head>
<body>
<h2>소모임 가입</h2>
<div id="alertJoin">${msg}</div>
<br>
<button onclick="joinParty()">가입하기</button>

<script>
function joinParty(){
	const info = {
			piNum : ${param.piNum}
	}
	fetch('/party-member', {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json'
		},
		body: JSON.stringify(info)
	})
	.then(response => response.json())
	.then(result => {
		if(result === true ){
			alert('소모임에 가입되었습니다!');
			location.href='/views/party/view?piNum=' + ${param.piNum};
			return;
		}
		alert('다시 시도해주세요');
	})
}


</script>
</body>
</html>
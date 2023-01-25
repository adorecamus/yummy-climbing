<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시물등록</title>
</head>
<body>
<label>내용</label><br>
<textarea rows="10" cols="25" id="pbContent"></textarea><br>
<label>작성자</label><br>
<input type="text" value="${param.uiNickName}">
<br><br>
<button onclick="insertBoard()">등록</button>

<script>
function insertBoard(){
	const partyBoard = {
			pbContent : document.querySelector('#pbContent').value
	};
	
	fetch('/party-boards', {
		method: 'POST',
		headers: {
			'Content-Type' : 'application/json'
		},
		body: JSON.stringify(partyBoard)
	})
	.then(response => response.json())
	.then(function(data){
		if(data==1){
			alert('게시물이 정상적으로 등록되었습니다.');
			location.href="/views/party/main";
		}
	})
	window.onload = function(){
		insertBoard();
	}
}
</script>
</body>
</html>
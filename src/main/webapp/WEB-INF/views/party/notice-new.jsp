<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 등록</title>
</head>
<body>
공지 내용<br>
<textarea rows="10" cols="50" id="pbnContent"></textarea>
<button onclick="insertNotice()">등록</button>

<script>
function insertNotice(){
	const notice = {
			pbnContent : document.querySelector('#pbnContent').value
	};
	console.log(notice);
	fetch('/party-infos/boards/notice', {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json'
		},
		body: JSON.stringify(notice)
	})
	.then(response => response.json())
	.then(result => {
		if(result === 1) {
			alert('공지가 등록되었습니다.');
			location.href='/views/party/view';
			return;
		}
		alert('다시 시도해주세요!');
	})
	.catch(error => {
		alert('다시 시도해주세요!!');
		location.replace();
	})
}

//왜 등록이 안되냐고~~~~~~

</script>
</body>
</html>
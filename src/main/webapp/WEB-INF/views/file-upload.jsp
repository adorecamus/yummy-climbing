<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<input type="file" id="file1">
<button id="uploadBtn">파일 전송</button>
<div id="proDiv" style="display:none;">
	<progress id="pg" value="0" max="100"></progress>
	<div id="per"></div>
</div>
<script>
window.onload = function() {
	document.querySelector("#uploadBtn").onclick = function() {
		const file1 = document.querySelector('#file1');
		console.log(file1.files.length);
		if(file1.files.length === 0) {
			alert('파일을 선택해주세요.');
			return;
		}
		const uploadFile = file1.files[0];
		console.log(uploadFile);
		
		const formData = new FormData();
		formData.append('file1', uploadFile);
		const xhr = new XMLHttpRequest();
		xhr.open('POST', '/file-upload');
		xhr.onreadystatechange = function() {
			if(xhr.readyState === xhr.DONE) {
				if(xhr.status === 200) {
					alert('전송 완료');
					location.href = '/files/' + xhr.responseText;
				} else {
					alert('전송 실패');
				}
			}
		}
		const proDiv = document.querySelector('#proDiv');
		xhr.upload.addEventListener('progress', function(e){
			console.log(e.loaded);
			if (proDiv.style.display === 'none'){
				proDiv.style.display = '';
			}
			const per = e.loaded / e.total * 100;
			document.querySelector('#pg').value = per;
			document.querySelector('#per').innerHTML = Math.floor(per) + '%';
		});
		xhr.send(formData);
	}
}
</script>
</body>
</html>
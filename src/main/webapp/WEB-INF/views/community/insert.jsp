<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 등록</title>
<%@ include file= "/resources/common/header.jsp" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
<table>
	<select id="cbCategory">
		<option value="freeBoard">자유게시판</option>
		<option value="questionBoard">질문게시판</option>
		<option value="infoBoard">정보게시판</option>
	</select>
	<tr>
		<th>제목</th>
		<td><input type="text" id="cbTitle"></td>
	</tr>
	<tr>
		<th>작성자</th>
		<td><input type="text" id="uiId" value="${userInfo.uiId}" readonly></td>
	</tr>
	<tr>
		<th>내용</th>
		<td><textarea rows="20" cols="30" id="cbContent"></textarea></td>
	</tr>
	<tr>
		<th>file1</th>
		<td><input type="file" id="file1"></td>
	</tr>
	<tr>
		<th>file2</th>
		<td><input type="file" id="file2"></td>
	</tr>
	<tr>
		<th>file3</th>
		<td><input type="file" id="file3"></td>
	</tr>
		<button id="uploadFile">파일업로드</button>
		<div id="proDiv" style="display:none;">
			<progress id="pg" value="0" max="100"></progress>
			<div id="per"></div>
		</div>
	<tr>
	<th colspan="2">
		<button onclick="insertBoard()">등록</button>
		<button onclick="location.href='/views/community/list'">목록</button>
	</th>
	</tr>
</table>
<script>

function insertBoard() {
/* 	const param = {};
	param.cbTitle = document.querySelector('#cbTitle').value;
	param.cbContent = document.querySelector('#cbContent').value; */
		
	const cbTitle = document.querySelector('#cbTitle').value;
	if (!cbTitle) {
		alert('제목을 입력해주세요.');
		cbTitle.focus();
		return;
	}
		
	const cbContent = document.querySelector('#cbContent').value;
	if (!cbTitle) {
		alert('내용을 입력해주세요.');
		cbContent.focus();
		return;
	}
	const param = {
			uiId: document.querySelector('#uiId').value,
			cbCategory: document.querySelector('#cbCategory').value,
			cbTitle: document.querySelector('#cbTitle').value,
			cbContent: document.querySelector('#cbContent').value
		}
		fetch('/community-board',{
			method:'POST',
			headers : {
				'Content-Type' : 'application/json'
			},
			body : JSON.stringify(param)
		})
		.then(function(res){
				return res.json();
		})
		.then(function(result){
			if(result===1){
				alert('게시글이 등록되었습니다.');
				location.href='/views/community/list';
			}
			
		});
	}
	
window.onload = function() {
	document.querySelector("#uploadFile").onclick = function() {
		const formData = new FormData();
		for(let i=1; i<3; i++) {
			if(document.querySelector('#file'+i).files.length==1) {
				formData.append('file'+i, document.querySelector('#file'+i).files[0]);
			}
		} 
		const xhr = new XMLHttpRequest();
		xhr.open('POST', '/community-board-file/{cbNum}');
		xhr.onreadystatechange = function() {
			if(xhr.readyState === xhr.DONE) {
				if(xhr.status === 200) {
					alert('파일 업로드를 성공하였습니다.');
					location.href = '/files/' + xhr.responseText;
				} else {
					alert('파일 업로드를 실패하였습니다.');
				}
			}
		}
		xhr.send(formData);
	}
}
	
/* 	const formData = new FormData();
	formData.append('uiId', document.querySelector('#uiId').value);
	formData.append('cbCategory', document.querySelector('#cbCategory').value);
	formData.append('cbTitle', document.querySelector('#cbTitle').value);
	formData.append('cbContent', document.querySelector('#cbContent').value);
	for(let i=1; i<=3; i++){
		if(document.querySelector('#file'+i).files.length==1) {
			formData.append('file'+i, document.querySelector('#file'+i).files[0]);
		}
	} 

	const xhr = new XMLHttpRequest();
	xhr.open('POST','/community-board-file');
	xhr.onreadystatechange= function(){
		if(xhr.readyState === xhr.DONE){
			if(xhr.status === 200){
				if(xhr.responseText=='1'){
					alert('게시글이 등록되었습니다.');
					location.href='/views/community/list';
				}
			}else{
				alert('전송 실패');
			}
		}
	}
	xhr.send(formData); */

</script>
</body>
</html>
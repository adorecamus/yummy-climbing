<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 등록</title>
<%@ include file= "/resources/common/header.jsp" %>
<link href="/resources/css/style1.css" rel="stylesheet" type="text/css">
<link href="/resources/css/style.css" rel="stylesheet" type="text/css">
<!-- CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<!-- js -->
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
	<th colspan="2">
		<button onclick="insertBoard()">등록</button>
		<button onclick="location.href='/views/community/list'">목록</button>
	</th>
	</tr>
</table>
<script>
	function insertBoard() {
/* 		const param = {};
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
			
		})

	}
</script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 수정</title>
<%@ include file= "/resources/common/header.jsp" %>
</head>
<body>
<table border="1">
	<tr>
		<th>제목</th>
		<td><input type="text" id="cbTitle"></td>
	</tr>
	<tr>
		<th>내용</th>
		<td><textarea rows="10" cols="40" id="cbContent"></textarea></td>
	</tr>
	<tr>
		<th colspan="1">
			<button onclick="updateBoard()">수정</button>
			<button>리스트</button>
		</th>
	</tr>
</table>
<script>
function getBoard(){
	fetch('/community-board/${param.cbNum}')
	.then(function(res){
		return res.json();
	})
	.then(function(communityBoard){
		document.querySelector('#cbTitle').value = communityBoard.cbTitle;
		document.querySelector('#cbContent').value = communityBoard.cbContent;
	});
}
window.onload = function(){
	getBoard();
}
function updateBoard(){
	var check = confirm('게시글을 수정하시겠습니까?');
	if(check) {
		const param = {};
		param.cbTitle = document.querySelector('#cbTitle').value;
		param.cbContent = document.querySelector('#cbContent').value;
		
		fetch('/community-board/${param.cbNum}',{
			method:'PATCH',
			headers : {
				'Content-Type' : 'application/json'
			},
			body : JSON.stringify(param)
		})
		.then(async function(res){
			if(res.ok){
				return res.json();
			}else{
				const err = await res.text();
				throw new Error(err);
			}
		})
		.then(function(data){
			if(data===1){
				alert('게시물이 수정되었습니다.');
				location.href='/views/community/list';
			}
			
		})
		.catch(function(err){
			alert(err);
		});
	}
}
</script>
</body>
</html>
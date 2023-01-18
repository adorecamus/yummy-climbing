<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="commentBox">
	<div class="commentCnt">댓글<span id="cnt">0</span></div><br>
	<div class="commentName">
		<span class="writer" value="${uiId}" readonly></span><br>
	</div>
	<div class="commentContentBox">
		<textarea class="InputComment" id="commentCotent" cols="80" rows="2"></textarea>
		<div class="insertBtn"><button id="insertComment">댓글등록</button></div>
	</div>
</div>
<script>
function getCommentList() {
	fetch('/comments')
	.then(function(res){
		return res.json();
	})
	.then(function(list){
		let html = '';
		for(let i=0; i<list.length; i++){
			const commentList = list[i];
			html += '<tr>';
			html += '<td>' + commentList.uiId + '</td>';
			html += '<td>' + commentList.bcContent + '</td>';
			html += '<td>' + commentList.bcCredat + '</td>';
			html += '</tr>;	
		}
		document.querySelector('#tBody').innerHTML = html;
	})
};
window.onload = functionj(){
	getCommentList()
}

function insertComment() {
	
}
</script>
</body>
</html>
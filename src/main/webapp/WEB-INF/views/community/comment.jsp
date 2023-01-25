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
		<span id="uiNickname" value="${uiNickname}" readonly></span><br>
	</div>
	<div class="commentContentBox">
		<textarea class="InputComment" id="cbcContent" cols="80" rows="2" placeholder="댓글을 입력하세요..."></textarea>
		<div class="insertBtn"><button onclick="insertComment()" >등록</button></div>
	</div>
	<div id="comment"></div>
</div>
<script>
function insertComment() {
	const cbcContent = document.querySelector('#cbcContent').value;
	if(!cbcContent) {
		alert('댓글을 입력해주세요.');
		cbcContent.focus();
		return;
	}
	
	const param = {
			uiNickname : document.querySelector('#uiNickname').value,
			cbcContent : document.querySelector('#cbcContent').value
	}
	
	fetch('/community-comments', {
		method: 'POST',
		headers : {
			'Content-Type' : 'application/json'
		},
		body : JSON.stringify(param)
	})
	.then(function(res){
		return res.json();
	})
	.then(function(result){
		if(result==1){
			alert('댓글이 등록되었습니다.');
			location.href='/views/community/view';
		}
		
	});
	
}
</script>
</body>
</html>
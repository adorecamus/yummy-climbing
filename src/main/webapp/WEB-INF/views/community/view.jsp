<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 상세화면</title>
<script type="text/ecmascript" src="/resources/js/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
<script	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
</head>
<body>
<div id="detail"></div>
<div id="btnDiv" style="display:none">
	<button onclick="location.href='/views/community/update?cbNum=${param.cbNum}'">수정</button>
	<button onclick="deleteBoard()">삭제</button>
</div>
<script>
function deleteBoard(){
	fetch('/community-board/${param.cbNum}',{
		method:'DELETE'
	})
	.then(function(res){
		return res.json();
	})
	.then(function(data){
		if(data===1){
			alert('게시글이 삭제되었습니다.');
			location.href='/views/community/list';
		}
	});
}
function getBoard(){
	fetch('/community-board/${param.cbNum}')
	.then(function(res){
		return res.json();
	})
	.then(function(communityBoard){
		let html = '';
		html += '번호 : ' + communityBoard.cbNum + '<br>';
		html += '제목 : ' + communityBoard.cbTitle + '<br>';
		html += '본문 : ' + communityBoard.cbContent + '<br>';
		html += '작성자 : ' + communityBoard.uiId + '<br>';
		html += '작성일 : ' + communityBoard.cbCredat + '<br>';
		html += '조회수 : ' + communityBoard.cbCnt + '<br>';
		document.querySelector('#detail').innerHTML = html;
		if(communityBoard.uiNum == '${userInfo.uiNum}'){
			document.querySelector('#btnDiv').style.display = '';
		}
	});
}
window.onload = function(){
	getBoard();
}
</script>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시물 상세페이지</title>
</head>
<body>
<table border=1>
	<tr>
		<th>내용</th>
		<th>작성자</th>
		<th>등록일</th>
		<th>수정일</th>
		<th>등록시간</th>
		<th>수정시간</th>
	</tr>
	<tbody id="partyBoards"></tbody>
</table>
<script>
window.onload = function(){
	getPartyBoard();
}
function getPartyBoard(){
	fetch('/party-infos/${param.piNum}')
	.then(response => response.json())
	.then(list => {
		let html = '';
		for(partyBoard of list){
			html += '<tr>';
			html += '<td>' + partyBoard.pbContent + '</td>';
			html += '<td>' + partyBoard.uiNickname + '</td>';
			html += '<td>' + partyBoard.pbCredat + '</td>';
			html += '<td>' + partyBoard.pbLmodat + '</td>';
			html += '<td>' + partyBoard.pbCretim + '</td>';
			html += '<td>' + partyBoard.pbLmotim + '</td>';
			html += '</tr>';
			document.querySelector('#partyBoards').innerHTML = html;
		}
	});
}
</script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>소모임 상세페이지</title>
</head>
<body>
<h2>소모임 상세페이지</h2>
<h3>소모임 정보</h3>
<div id="partyInfos">
</div>
<h3>소모임 공지사항</h3>
<div id="notice" style="border:1px solid; width:400px;">
<table border=1>
	<tr>
		<th>내용</th>
		<th>등록일</th>
		<th>수정일</th>
	</tr>
	<tbody id="partyNotices"></tbody>	
</table>
<button onclick="location.href='/views/party/notice-new'">공지사항 등록</button>
</div>
<h3>소모임 게시판</h3>
<div id="board">
<table border=1>
	<tr>
		<th>번호</th>
		<th>내용</th>
		<th>작성자</th>
		<th>등록일</th>
		<th>수정일</th>
		<th>등록시간</th>
		<th>수정시간</th>
	</tr>
	<tbody id="partyBoards"></tbody>
</table>
<button onclick="location.href='/views/party/board-new'">게시물등록</button>
</div>

<script>
window.onload = function(){
	getPartyInfos();
	getPartyNotices();
	getPartyBoards();
}
//소모임 정보
function getPartyInfos(){
	let html = '';
	fetch('/party-infos/${param.piNum}')
	.then(response => response.json())
	.then(function(partyInfo){
		console.log(partyInfo);
		html += '<div style="border:1px solid; width:400px;">';
		html += '<p>산 : ' + partyInfo.mntnm + '</p>';
		html += '<p>모임 이름 : ' + partyInfo.piName + '</p>';
		html += '<p>날짜 : ' + partyInfo.piExpdat + '</p>';
		html += '<p>시간 : ' + partyInfo.piMeetingTime + '</p>';
		html += '<p>멤버 : ' + partyInfo.memNum + " / " + partyInfo.piMemberCnt + '</p>';
		html += '<p>좋아요 : ' + partyInfo.likeNum + '</p>';
		html += '<p>소개 : ' + partyInfo.piProfile + '</p>';
		html += '</div>';
		document.querySelector('#partyInfos').innerHTML = html;
	});
}

//공지사항
function getPartyNotices(){
	fetch('/party-infos/${param.piNum}/notice')
	.then(response => response.json())
	.then(list => {
		let html = '';
		for(notice of list){
			html += '<tr>';
			html += '<td>' + notice.pbnContent +'</td>';
			html += '<td>' + notice.pbnCredat +'</td>';
			html += '<td>' + notice.pbnLmodat +'</td>';
			html += '</tr>';
			document.querySelector('#partyNotices').innerHTML = html;
		}
	});
}

//소모임 일반게시판	
function getPartyBoards(){
	fetch('/party-infos/${param.piNum}/boards')
	.then(response => response.json())
	.then(list => {
		let html = '';
		for(partyBoard of list){
			html += '<tr >';
			html += '<td>' + partyBoard.pbNum + '</td>'
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
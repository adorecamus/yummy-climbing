<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>소모임 게시판</title>
</head>
<body>

<h3>공지사항</h3>
	<div id="notice">
	<table border=1>
		<tr>
			<th>내용</th>
			<th>등록일</th>
			<th>수정일</th>
		</tr>
		<tbody id="partyNotices"></tbody>	
	</table>
	<div id="detailNotice" style="display:none">
		<h4>공지 상세내용</h4>
		<table border = 1>
			<tr>
				<th>내용</th>
				<th>등록일</th>
				<th>수정일</th>
		</tr>
		<tbody id="partyDetailNotice"></tbody>
		</table>
		댓글
		<input type="text" id="noticeComment" onclick="noticeComment()"><button>등록</button>
	</div>
	<button onclick="openInsertNotice()">공지등록</button>
	<div id="insertNotice" style="display:none">
		<h4>공지 입력</h4>
		<textarea rows="10" cols="50" id="pbnContent"></textarea>
		<button onclick="insertNotice()">등록</button>
	</div>
</div>

<h3>일반게시판</h3>
	<div id="board">
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
	<div id="detailBoard" style="display:none">
		<h4>게시물 상세내용</h4>
		<table border=1>
			<tr>
				<th>내용</th>
				<th>작성자</th>
				<th>등록일</th>
				<th>수정일</th>
				<th>등록시간</th>
				<th>수정시간</th>
			</tr>
			<tbody id="partyDetailBoard"></tbody>
		</table>
		댓글
		<input type="text" id="boardComment" onclick="boardComment()"><button>등록</button>
	</div>
	<button onclick="openInsertBoard()">게시물등록</button>
	<div id="insertBoard" style="display:none">
		<h4>게시물 입력</h4>
		<textarea rows="10" cols="50" id="pbContent"></textarea>
		<button onclick="insertBoard()">등록</button>
	</div>
</div>


<script>
window.onload = function(){
	getPartyNotices();
	getPartyBoards();
}

let noticeList = [];
//공지사항
function getPartyNotices(){
	
	fetch('/party-notice/${param.piNum}')
	.then(response => response.json())
	.then(list => {
		let html = '';
		for(let i = 0; i < list.length; i++){
			noticeList[i] = list[i];
			console.log(noticeList[i]);
			html += '<tr style="cursor:pointer;" onclick="openDetailNotice(noticeList[' + i + '])">';
			html += '<td>' + list[i].pbnContent +'</td>';
			html += '<td>' + list[i].pbnCredat +'</td>';
			html += '<td>' + list[i].pbnLmodat +'</td>';
			html += '</tr>';
			document.querySelector('#partyNotices').innerHTML = html;
		}
	});
}

//공지 클릭=> 공지 상세페이지
function openDetailNotice(notice){
	document.querySelector('#detailNotice').style.display = '';
	let html = '';
	html += '<td>' + notice.pbnContent +'</td>';
	html += '<td>' + notice.pbnCredat +'</td>';
	html += '<td>' + notice.pbnLmodat +'</td>';
	html += '</tr>';
	document.querySelector('#partyDetailNotice').innerHTML = html;
}

//공지등록창 나오게
function openInsertNotice(){
	document.querySelector('#insertNotice').style.display = '';
}

//공지 등록
function insertNotice(){
	const notice = {
			pbnContent : document.querySelector('#pbnContent').value
	};
	fetch('/party-notice/${param.piNum}', {
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

//공지 댓글등록
/*
function noticeComment(){
	const nComment = {document.querySelector('#boardComment').value};
	fetch('/party-boards/${param.pbnNum}/comments',{
		method: 'POST',
		headers: {
			'Content-Type' : 'application/json'
		},
		body: JSON.stringify(nComment)
	})
	.then(response => response.json())
	.then(result=> {
		if(result === 1) {
			alert('댓글이 등록되었습니다.');
			location.href='/views/party/boards?piNum='+${param.piNum};
			return;
		}
		alert('다시 시도해주세요');
	})	
}*/


//소모임 일반게시판
let boardList = [];
function getPartyBoards(){
	fetch('/party-boards/${param.piNum}')
	.then(response => response.json())
	.then(list => {
		let html = '';
		for(let i=0; i<list.length; i++){
			boardList[i] = list[i];
			html += '<tr style="cursor:pointer;" onclick="openDetailBoard(boardList[' + i + '])">';
			html += '<td>' + list[i].pbContent + '</td>';
			html += '<td>' + list[i].uiNickname + '</td>';
			html += '<td>' + list[i].pbCredat + '</td>';
			html += '<td>' + list[i].pbLmodat + '</td>';
			html += '<td>' + list[i].pbCretim + '</td>';
			html += '<td>' + list[i].pbLmotim + '</td>';
			html += '</tr>';
			document.querySelector('#partyBoards').innerHTML = html;
		}
	});
}

//일반게시물 클릭=> 상세페이지
function openDetailBoard(partyBoard){
	document.querySelector('#detailBoard').style.display = '';
	console.log(partyBoard);
	let html = '';
	html += '<td>' + partyBoard.pbContent + '</td>';
	html += '<td>' + partyBoard.uiNickname + '</td>';
	html += '<td>' + partyBoard.pbCredat + '</td>';
	html += '<td>' + partyBoard.pbLmodat + '</td>';
	html += '<td>' + partyBoard.pbCretim + '</td>';
	html += '<td>' + partyBoard.pbLmotim + '</td>';
	html += '</tr>';
	document.querySelector('#partyDetailBoard').innerHTML = html;
}

//일반게시물 등록 클릭=> 등록창 나오게
function openInsertBoard(){
	document.querySelector('#insertBoard').style.display = '';
}
//일반게시물 등록
function insertBoard(){
	const board = {
			pbContent : document.querySelector('#pbContent').value
	};
	fetch('/party-boards/${param.piNum}', {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json'
		},
		body: JSON.stringify(board)
	})
	.then(response => response.json())
	.then(result => {
		if(result === 1) {
			alert('게시물이 등록되었습니다.');
			location.href='/views/party/boards?piNum='+${param.piNum};
			console.log(pbNum);
			return;
		}
		alert('다시 시도해주세요!');
	})
	.catch(error => {
		alert('다시 시도해주세요!!');
		location.replace();
	})
}

//일반게시물 댓글등록
//대체 왜 pbNum은 db에 저장된거랑 세션에 나오는거랑 값이 다른가!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
function boardComment(){
	const bComment = {
			pbcComment : document.querySelector('#boardComment').value
	};
	fetch('/party-boards/comments/${param.piNum}',{
		method: 'POST',
		headers: {
			'Content-Type' : 'application/json'
		},
		body: JSON.stringify(bComment)
	})
	.then(response => response.json())
	.then(result=> {
		if(result === 1) {
			alert('댓글이 등록되었습니다.');
			location.href='/views/party/boards?piNum='+${param.piNum};
			return;
		}
		alert('다시 시도해주세요');
	})	

}

</script>
</body>
</html>
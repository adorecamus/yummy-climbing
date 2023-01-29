<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>소소모임 게시판</title>
</head>
<body>
<c:if test="${captain ne null}">
<h3>방장만 보이는 영역(여기부터)</h3>
	<table border=1>
		<tr>
			<th><input type="checkbox" name="allCheck" onclick="toggleCheck(this)"></th>
			<th>내용</th>
			<th>등록일</th>
			<th>수정일</th>
			<th>수정시간</th>
		</tr>
		<tbody id="captinNotices"></tbody>	
	</table>
	<button onclick="openInsertNotice()">등록</button>
	<button onclick="openUpdateNotice()">수정</button>
	<button onclick="deleteNotices(this)">삭제</button>
		<div id="updateNotice" style="display:none">
			<h4>공지 수정</h4>
			<textarea rows="10" cols="50" id="pnNewContent" ></textarea>
		<button onclick="updateNotices()">등록</button>
	</div>
	<div id="insertNotice" style="display:none">
		<h4>공지 입력</h4>
		<textarea rows="10" cols="50" id="pnContent"></textarea>
		<button onclick="insertNotice()">등록</button>
	</div>
<h3>방장만 보이는 영역(여기까지)</h3>
</c:if>
<h3>공지사항</h3>
	<div id="notice">
	<table border=1>
		<tr>
			<th>내용</th>
			<th>등록일</th>
			<th>수정일</th>
			<th>수정시간</th>
		</tr>
		<tbody id="partyNotices"></tbody>	
	</table>
	<br><br>
	<div id="detailNotice" style="display:none; border: 1px solid">
		<h4>공지 상세내용</h4>
		<table border = 1>
			<tr>
				<th>내용</th>
				<th>등록일</th>
				<th>수정일</th>
				<th>수정시간</th>
		</tr>
		<tbody id="partyDetailNotice"></tbody>
		</table>	
	</div>
	
</div>


<script>
window.onload = function(){
	getPartyNotices();
	getCaptinNotices();
}

function toggleCheck(obj){
	const pnNums = document.querySelectorAll('input[name="pnNums"]');
	for(const pnNum of pnNums){
		pnNum.checked = obj.checked;
	}
}

//방장만 보이는 공지영역(수정,삭제를 위한)
//공지 목록 보기
let noticeList = [];
function getCaptinNotices(){
	fetch('/party-notice/${param.piNum}')
	.then(response => response.json())
	.then(list => {
		let html = '';
		for(let i = 0; i < list.length; i++){
			noticeList[i] = list[i];
			html += '<tr>';
			html += '<td><input type="checkbox" name="pnNums" value="' + list[i].pnNum + '"></td>';
			html += '<td>' + list[i].pnContent +'</td>';
			html += '<td>' + list[i].pnCredat +'</td>';
			html += '<td>' + list[i].pnLmodat +'</td>';
			html += '<td>' + list[i].pnLmotim +'</td>';
			html += '</tr>';
			document.querySelector('#captinNotices').innerHTML = html;
		}
	});
}


//공지 수정
function openUpdateNotice(){
	document.querySelector('#updateNotice').style.display = '';
}

//공지 삭제
function deleteNotices(pnNum){	
	const pnNumObjs = document.querySelectorAll('input[name="pnNums"]:checked');
	const pnNums = [];
	for(const pnNumObj of pnNumObjs){
		pnNums.push(pnNumObj.value);
	}
	if(pnNums.length===0){
		alert('공지를 선택하세요');
		return;
	}	
	fetch('/party-notice/' + pnNums[0],{
		method: 'DELETE',
		headers: {
			'Content-Type': 'application/json'
		}
	})
	.then(response => response.json())
	.then(result => {
		if(result>= 1){
			alert('공지가 삭제되었습니다.');
			location.href='/views/party/notice?piNum=' + ${param.piNum};
			return;
		}
		alert('다시 시도해주세요.');
	})
}


//전체 공지사항 리스트
function getPartyNotices(){
	fetch('/party-notice/${param.piNum}')
	.then(response => response.json())
	.then(list => {
		let html = '';
		for(let i = 0; i < list.length; i++){
			noticeList[i] = list[i];
			//console.log(noticeList[i]);
			html += '<tr style="cursor:pointer;" onclick="openDetailNotice(noticeList[' + i + '])">';
			html += '<td>' + list[i].pnContent +'</td>';
			html += '<td>' + list[i].pnCredat +'</td>';
			html += '<td>' + list[i].pnLmodat +'</td>';
			html += '<td>' + list[i].pnLmotim +'</td>';
			html += '</tr>';
			document.querySelector('#partyNotices').innerHTML = html;
		}
	});
}

//공지 클릭=> 공지 상세페이지
function openDetailNotice(notice){
	document.querySelector('#detailNotice').style.display = '';
	let html = '';
	html += '<td>' + notice.pnContent +'</td>';
	html += '<td>' + notice.pnCredat +'</td>';
	html += '<td>' + notice.pnLmodat +'</td>';
	html += '<td>' + notice.pnLmotim +'</td>';
	html += '</tr>';
	html += getPnNum(notice.pnNum);
	document.querySelector('#partyDetailNotice').innerHTML = html;
}

function getPnNum(pnNum){
	let html = '';
	html += '<h4>Comment</h4>';
	html += '<table border=1><tr><th>내용</th><th>작성자</th><th>등록일</th><th>수정일</th></tr><tbody id="commentList"></tbody></table>';
	html += '<textarea id="pncComment" cols="60" rows="2" placeholder="댓글을 입력하세요"></textarea>';
	html += '<button onclick="insertComment(' + pnNum + ')" >등록</button>';
	html += getNoticeComment(pnNum);
	return html;
}

//공지등록창 나오게
function openInsertNotice(){
	document.querySelector('#insertNotice').style.display = '';
}
//공지 등록
function insertNotice(){
	const notice = {
			pnContent : document.querySelector('#pnContent').value
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
			location.href='/views/party/notice?piNum=' + ${param.piNum};
			return;
		}
		alert('다시 시도해주세요!');
	})
	.catch(error => {
		alert('다시 시도해주세요!!');
		location.replace();
	})
}
//공지 삭제
function deleteNotice(pnNum){
	fetch('/party-notice/' + pnNum,{
		method: 'DELETE',
		headers: {
			'Content-Type': 'application/json'
		}
	})
	.then(response => response.json())
	.then(result => {
		if(result === 1){
			alert('공지가 삭제되었습니다.');
			location.href='/views/party/notice?piNum=' + ${param.piNum};
			return;
		}
		alert('다시 시도해주세요.');
	})
}

//공지에 댓글 달기
function insertComment(pnNum){
	const comment = {
			pncComment : document.querySelector('#pncComment').value
	};
	fetch('/party-notice/comments' + pnNum, {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json'
		},
		body: JSON.stringify(comment)
	})
	.then(response => response.json())
	.then(result => {
		if(result===1){
			alert('댓글이 등록되었습니다.');
			location.href='/views/party/notice?piNum=' + ${param.piNum};
			return;
		}
		alert('다시 시도해주세요.');
	})
}

let commentList = [];
//공지 댓글 리스트
function getNoticeComment(pnNum){
	console.log(pnNum);
	fetch('/party-notice/comments/'+pnNum)
	.then(response => response.json())
	.then(list => {
		console.log(list);
		let html = '';
		for(let i = 0; i < list.length; i++){
			commentList[i] = list[i];
			console.log(list);
			html += '<tr>';
			html += '<td>' + list[i].pncComment + '</td>';
			html += '<td>' + list[i].uiNickname + '</td>';
			html += '<td>' + list[i].pncCredat + '</td>';
			html += '<td>' + list[i].pncLmodat + '</td>';
			html += '</tr>';
			document.querySelector('#commentList').innerHTML = html;
		}
	})
}
</script>
</body>
</html>

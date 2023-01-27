<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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

	</div>
	<button onclick="openInsertNotice()">공지등록</button>
	<div id="insertNotice" style="display:none">
		<h4>공지 입력</h4>
		<textarea rows="10" cols="50" id="pnContent"></textarea>
		<button onclick="insertNotice()">등록</button>
	</div>
</div>


<script>
window.onload = function(){
	getPartyNotices();
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
			html += '<td>' + list[i].pnContent +'</td>';
			html += '<td>' + list[i].pnCredat +'</td>';
			html += '<td>' + list[i].pnLmodat +'</td>';
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
			pbnContent : document.querySelector('#pnContent').value
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

</script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>소모임 생성</title>
<body>

<input type="text" id="piName" placeholder="모임 이름"><br>
<input type="text" id="mntnm" value="${param.mntnm}" placeholder="산 이름"><button onclick="changeSearchDisplay()">검색</button>
<div id="searchMountain" style="display:none">
<input type="text" id="searchMntnm" onkeyup="searchMountain()">
<div id="searchResult"></div>
</div>
<br>
<input type="date" id="piExpdat" placeholder="모임 날짜"><br>
<input type="time" id="piMeetingTime" step="900" placeholder="모임 시간"><br>
<input type="number" max=50 min=2 id="piMemberCnt" placeholder="정원"><br>
<textarea id="piProfile" placeholder="모임 설명"></textarea><br>

<button onclick="createParty()">만들기</button>
<button onclick="location.href='/views/party/main'">소모임 메인</button>

<script>
let today = new Date();
let dateString = today.getFullYear() + '-' + today.getMonth()+1 + '-' + today.getDate();
document.querySelector('#piExpdat').min = dateString;

function select(id) {
	return document.querySelector('#' + id).value;
}

function changeSearchDisplay() {
	document.querySelector('#searchMountain').style.display = '';
}

function searchMountain() {
	fetch('/mountain?mntnm=' + select('searchMntnm'))
	.then(response => response.json())
	.then(list => {
		let html = '';
		for (mountainInfo of list) {
			html += '<p style="cursor:pointer;" onclick="selectMountain(\'' + mountainInfo.mntnm + '\')"><b>' + mountainInfo.mntnm + '</b> ' + mountainInfo.areanm + '</p>';
		}
		document.querySelector('#searchResult').innerHTML = html;
	})
}

function selectMountain(mntnm) {
	document.querySelector('#mntnm').value = mntnm;
	document.querySelector('#searchMntnm').value = '';
	document.querySelector('#searchResult').innerHTML = '';
	document.querySelector('#searchMountain').style.display = 'none';
}

function createParty() {
	let partyInfoParameter = {
			piName : document.querySelector('#piName').value,
			mntnm : document.querySelector('#mntnm').value,
			piExpdat : document.querySelector('#piExpdat').value.replace(/-/g, ''),
			piMeetingTime : document.querySelector('#piMeetingTime').value.replace(':',''),
			piMemberCnt : document.querySelector('#piMemberCnt').value,
			piProfile : document.querySelector('#piProfile').value
	};
	console.log(partyInfoParameter);
	
	/*
	fetch('/party-infos', {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json'
		},
		body: JSON.stringify(partyInfoParameter)
	})
	.then(response => response.json())
	.then(result => {
		if(result === true) {
			alert('등록되었습니다.');
			location.href='/views/party/main';
			return;
		}
		alert('다시 시도해주세요.');
	})
	.catch(error => {
		alert('다시 시도해주세요.');
		location.replace();
	})
	*/
}
</script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>소모임 생성</title>
<body>

<input type="text" id="piName" name="piName" placeholder="모임 이름"><br>
<input type="text" id="mntnm" name="mntnm" value="${param.mntnm}" placeholder="산 이름" readonly><button onclick="changeSearchDisplay()">검색</button>

<div id="searchMountain" style="display:none; border:1px solid; height:200px; overflow:scroll;">
<input type="text" id="searchText" onkeyup="checkReg(this)">
<div id="searchResult"></div>
</div>

<br>
<input type="date" id="piExpdat" name="piExpdat" placeholder="모임 날짜"><br>
<input type="time" id="piMeetingTime" name="piMeetingTime" step="900" placeholder="모임 시간"><br>
<input type="number" id="piMemberCnt" name="piMemberCnt" max=50 min=2 placeholder="정원"><br>
<textarea id="piProfile" placeholder="모임 설명"></textarea><br>

<button onclick="createParty()">만들기</button>
<button onclick="location.href='/views/party/main'">소모임 메인</button>

<script>
let today = new Date();
let dateString = today.getFullYear() + '-' + today.getMonth()+1 + '-' + today.getDate();
document.querySelector('#piExpdat').min = dateString;

function changeSearchDisplay() {
	document.querySelector('#searchMountain').style.display = '';
	searchMountain();
}

function searchMountain() {
	fetch('/mountain/search?searchText=' + document.querySelector('#searchText').value)
	.then(response => response.json())
	.then(list => {
		let html = '';
		for (mountainInfo of list) {
			html += '<p style="cursor:pointer;" onclick="selectMountain(\'' + mountainInfo.mntnm + '\')"><b>' + mountainInfo.mntnm + '</b> ' + mountainInfo.areanm + '</p>';
		}
		document.querySelector('#searchResult').innerHTML = html;
	})
}

function checkReg(obj) {
	const regExp = /[a-z0-9]|[\[\]{}()<>?|`~!@#$%^&*-_+=,.;:\"'\\]/g;
	if (regExp.test(obj.value)) {
		obj.value = obj.value.replace(regExp, '');
	}
	searchMountain();
}

function selectMountain(mntnm) {
	document.querySelector('#mntnm').value = mntnm;
	document.querySelector('#searchText').value = '';
	document.querySelector('#searchResult').innerHTML = '';
	document.querySelector('#searchMountain').style.display = 'none';
}

function createParty() {
	if (checkInput() === false) {
		return;
	}
	
	let partyInfoParameter = {
			piName : document.querySelector('#piName').value,
			mntnm : document.querySelector('#mntnm').value,
			piExpdat : document.querySelector('#piExpdat').value.replace(/-/g, ''),
			piMeetingTime : document.querySelector('#piMeetingTime').value.replace(':',''),
			piMemberCnt : document.querySelector('#piMemberCnt').value,
			piProfile : document.querySelector('#piProfile').value
	};
	console.log(partyInfoParameter);
	
	fetch('/party-infos', {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json'
		},
		body: JSON.stringify(partyInfoParameter)
	})
	.then(async response => {
			if(response.ok) {
				return response.json();
			} else {
				const err = await response.text();
				throw new Error(err);
			}
		})
	.then(result => {
		console.log(result);
		/*
		if(result === true) {
			alert('등록되었습니다.');
			location.href='/views/party/main';
			return;
		}
		*/
		alert('다시 시도해주세요.');
	})
	.catch(error => {
		alert('다시 시도해주세요.');
		console.log('에러!');
	})
}

function checkInput() {
	let msg = ['모임 이름을', '산을', '모임 날짜를', '모임 시간을', '정원을'];
	let inputs = document.querySelectorAll('[name]');
	for(var i=0; i<inputs.length; i++){
		if (inputs[i].value.trim() === ''){
			alert(msg[i] + ' 입력해주세요.');
			inputs[i].focus();
			return false;
		}
	}
	return true;
}
</script>
</body>
</html>
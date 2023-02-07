<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>소소모임 만들기</title>
<%@ include file="/resources/common/header.jsp"%>
<body>
<div class="container">
<div style="width:60%; margin:5% 0 5% 20%;">

<div class="row mb-3">
	<label for="piName" class="col-sm-3 col-form-label">모임 이름</label>
	<div class="col-sm-8">
		<input type="text" class="form-control" id="piName">
	</div>
</div>

<div class="row mb-3">
	<label for="mntnm" class="col-sm-3 col-form-label">산 이름</label>
	<div class="col-sm-8">
		<input type="text" class="form-control" id="mntnm" value="${param.mntnm}" readonly><button onclick="displaySearchDiv()" class="btn btn-primary">검색</button>
	</div>
</div>
<div id="searchMountain" style="display:none; border:1px solid; width:600px; height:200px; overflow:scroll;">
	<button onclick="closeSearchDiv()" style="float:right;">닫기</button>
	<input type="text" id="searchText" onkeyup="checkReg(this)" placeholder="산 또는 지역으로 검색">
	<div id="searchResult"></div>
</div>

<div class="row mb-3">
	<label for="piExpdat" class="col-sm-3 col-form-label">모임 날짜</label>
	<div class="col-sm-8">
		<input type="date" class="form-control" id="piExpdat">
	</div>
</div>

<div class="row mb-3">
	<label for="piMeetingTime" class="col-sm-3 col-form-label">모임 시간</label>
	<div class="col-sm-8">
		<input type="time" class="form-control" step="900" id="piMeetingTime">
	</div>
</div>

<div class="row mb-3">
	<label for="piMemberCnt" class="col-sm-3 col-form-label">정원</label>
	<div class="col-sm-8">
		<input type="number" class="form-control" max=50 min=2 id="piMemberCnt">
	</div>
</div>

<div class="mb-3">
	<label for="piProfile" class="form-label">모임 설명</label>
	<textarea class="form-control" id="piProfile" rows="4"></textarea>
</div>
	
<!-- 
<input type="text" id="piName" name="piName" placeholder="모임 이름"><br>
<input type="text" id="mntnm" name="mntnm" value="${param.mntnm}" placeholder="산 이름" readonly><button onclick="displaySearchDiv()">검색</button>

<div id="searchMountain" style="display:none; border:1px solid; width:600px; height:200px; overflow:scroll;">
	<button onclick="closeSearchDiv()" style="float:right;">닫기</button>
	<input type="text" id="searchText" onkeyup="checkReg(this)" placeholder="산 또는 지역으로 검색">
	<div id="searchResult"></div>
</div>

<br>
<input type="date" id="piExpdat" name="piExpdat" placeholder="모임 날짜"><br>
<input type="time" id="piMeetingTime" name="piMeetingTime" step="900" placeholder="모임 시간"><br>
<input type="number" id="piMemberCnt" name="piMemberCnt" max=50 min=2 placeholder="정원"><br>
<textarea id="piProfile" placeholder="모임 설명"></textarea><br>
-->

<button onclick="createParty()" class="btn btn-primary">만들기</button>
<button onclick="location.href='/views/party/main'" class="btn btn-secondary" style="float:right;">소모임 메인</button>

</div>
</div>

<script>
let today = new Date();
let dateString = today.getFullYear() + '-' + today.getMonth()+1 + '-' + today.getDate();
document.querySelector('#piExpdat').min = dateString;

function displaySearchDiv() {
	document.querySelector('#searchMountain').style.display = '';
	searchMountain();
}

function searchMountain() {
	fetch('/mountain/search?searchText=' + document.querySelector('#searchText').value)
	.then(async response => {
			if(response.ok) {
				return response.json();
			} else {
				const err = await response.json();
				throw new Error(err);
			}
		})
	.then(list => {
		let html = '';
		for (mountainInfo of list) {
			html += '<p style="cursor:pointer;" onclick="selectMountain(\'' + mountainInfo.mntnm + '\')"><b>' + mountainInfo.mntnm + '</b> ' + mountainInfo.areanm + '</p>';
		}
		document.querySelector('#searchResult').innerHTML = html;
	})
	.catch(error => {
		console.log('에러!!!!!');
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
	closeSearchDiv();
}

function closeSearchDiv() {
	document.querySelector('#searchText').value = '';
	document.querySelector('#searchResult').innerHTML = '';
	document.querySelector('#searchMountain').style.display = 'none';
}

async function createParty() {
	if (checkInput() === false) {
		return;
	}
	
	let partyInfoParameter = {
			piName : document.querySelector('#piName').value,
			mntnm : document.querySelector('#mntnm').value,
			piExpdat : document.querySelector('#piExpdat').value,
			piMeetingTime : document.querySelector('#piMeetingTime').value,
			piMemberCnt : document.querySelector('#piMemberCnt').value,
			piProfile : document.querySelector('#piProfile').value
	};
	console.log(partyInfoParameter);
	
	const createResponse = await fetch('/party-info', {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json'
		},
		body: JSON.stringify(partyInfoParameter)
	});
	if (!createResponse.ok) {
		const errorResult = await createResponse.json();
		alert(errorResult.message);
		location.href = '/views/user/login';
		return;
	}
	const piNum = await createResponse.json();
	if (piNum !== 0) {
		alert('소소모임이 등록되었습니다.');
		location.href = '/views/party/view?piNum=' + piNum;
	}
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
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>소소모임 방장 관리 페이지</title>
<%@ include file="/resources/common/header.jsp"%>
</head>
<body>
<div class="container"">

<div id="partyDiv" style="width:80%; height:350px; margin:5% 0 5% 10%">
<h2>소소모임 정보</h2>
<div id="partyInfoDiv" style="border:1px solid; height:330px;">
<input type="text" id="mntnm" name="mntnm" readonly><br>
<input type="text" id="piName" name="piName" placeholder="모임 이름" readonly><br>
<input type="date" id="piExpdat" name="piExpdat" placeholder="모임 날짜" readonly><br>
<input type="time" id="piMeetingTime" name="piMeetingTime" step="900" placeholder="모임 시간" readonly><br>
<input type="number" id="piMemberCnt" name="piMemberCnt" max=50 min=2 placeholder="정원" readonly><br>
<textarea id="piProfile" placeholder="모임 설명" readonly></textarea><br>
<button onclick="updateParty()" class="btn btn-primary">정보 수정</button>
<button onclick="changePartyStatus('complete')" class="btn btn-outline-primary">모집완료</button>
<button onclick="changePartyStatus('delete')" class="btn btn-secondary">소소모임 삭제</button>
<p>삭제 후에는 복구할 수 없습니다.</p>
</div>
</div>

<div id="membersDiv" style="width:80%; height:300px; margin:5% 0 5% 10%">
<h2>부원 관리</h2>
<div class="btn-group col-12">
  <button type="button" class="btn btn-outline-primary col-6" onclick="getMemberInfos()">부원 목록</button>
  <button type="button" class="btn btn-outline-primary col-6" onclick="getBlockedMembers()">차단 목록</button>
</div>

<div id="memberInfosDiv" style="text-align:center;">
	<table class="table table-borderless">
		<tbody id="memberTbody">
		</tbody>
	</table>
	<button onclick="changeMemberStatus()" class="btn btn-primary">탈퇴</button>
	<button onclick="changeMemberStatus('block')" class="btn btn-secondary">차단</button>
	<br>
	차단한 회원은 재가입할 수 없습니다.
</div>

<div id="blockedMembersDiv" style="display:none; text-align:center;">
	<table class="table table-borderless">
		<tbody id="blockedMemberTbody">
		</tbody>
	</table>
	<button onclick="changeMemberStatus('unblock')" class="btn btn-primary">차단 해제</button>
</div>
	
</div>

</div>

<script>
window.addEventListener('load', async function() {
	await getPartyInfos();
	await getMemberInfos();
});

async function getPartyInfos(){
	const partyInfoResponse = await fetch('/party-info/${param.piNum}');
	if (!partyInfoResponse.ok) {
		const errorResult = await partyInfoResponse.json();
		alert(errorResult.message);
		return;
	}
	const partyInfo = await partyInfoResponse.json();
	const infoObjs = document.querySelectorAll('input[id],textarea[id]');
	for (const infoObj of infoObjs) {
		infoObj.value = partyInfo[infoObj.getAttribute('id')];
		if (infoObj.getAttribute('id') !== 'mntnm') {
			infoObj.readOnly = false;
		}
	}
}

async function updateParty() {
	if (checkInput() === false) {
		return;
	}
	
	const partyInfoParameter = {
			piName : document.querySelector('#piName').value,
			mntnm : document.querySelector('#mntnm').value,
			piExpdat : document.querySelector('#piExpdat').value,
			piMeetingTime : document.querySelector('#piMeetingTime').value,
			piMemberCnt : document.querySelector('#piMemberCnt').value,
			piProfile : document.querySelector('#piProfile').value
	};
	console.log(partyInfoParameter);
	
	const updateResponse = await fetch('/captain/party-info?piNum=${param.piNum}', {
		method: 'PATCH',
		headers: {
			'Content-Type': 'application/json'
		},
		body: JSON.stringify(partyInfoParameter)
	});
	if (!updateResponse.ok) {
		const errorResult = await updateResponse.json();
		alert(errorResult.message);
		return;
	}
	const updateResult = await updateResponse.json();
	if (updateResult === true) {
		alert('수정되었습니다.');
		location.href = '/views/party/edit?piNum=${param.piNum}';
	}
}

function checkInput() {
	let msg = ['모임 이름을', '산을', '모임 날짜를', '모임 시간을', '정원을'];
	let inputs = document.querySelectorAll('[name]');
	for(var i=0; i<inputs.length; i++){
		if (inputs[i].value === ''){
			alert(msg[i] + ' 입력해주세요.');
			inputs[i].focus();
			return false;
		}
	}
	return true;
}

async function getMemberInfos() {
	document.querySelector('#blockedMembersDiv').style.display = 'none';
	document.querySelector('#memberInfosDiv').style.display = '';
	
	let html = '';
	const membersResponse = await fetch('/party-info/members/${param.piNum}');
	if (!membersResponse.ok) {
		const errorResult = await membersResponse.json();
		console.log(errorResult);
		html += '<p>' + errorResult.message + '</p>';
		document.querySelector('#memberInfosDiv').innerHTML = html;
		return;
	}
	const members = await membersResponse.json();
	if (members.length !== 1) {
		html += '<tr><td><input type="checkbox" name="allCheck" onclick="toggleCheck(this)"></td></tr>';
	}
	for (const member of members) {
		if (member.pmGrade === 1) {
			continue;
		}
		html += '<tr>';
		html += '<td><input type="checkbox" name="pmNum" value="' + member.pmNum + '"></td>';
		html += '<td>  ' + member.uiImgPath + '  </td>';
		html += '<td>  ' + member.uiNickname + '  </td>';
		html += '<td>  ' + member.uiAge + '  </td>';
		html += '<td>  ' + member.uiGender + '  </td>';
		html += '</tr>';
	}
	document.querySelector('#memberTbody').innerHTML = html;
}

async function getBlockedMembers() {
	document.querySelector('#memberInfosDiv').style.display = 'none';
	document.querySelector('#blockedMembersDiv').style.display = '';
	
	let html = '';
	const blockedMembersResponse = await fetch('/captain/party-info/members/blocked?piNum=${param.piNum}');
	if (!blockedMembersResponse.ok) {
		const errorResult = await blockedMembersResponse.json();
		console.log(errorResult);
		html += '<p>' + errorResult.message + '</p>';
		document.querySelector('#blockedMembersDiv').innerHTML = html;
		return;
	}
	const blockedMembers = await blockedMembersResponse.json();
	if (members.length !== 0) {
		html += '<tr><td><input type="checkbox" name="allCheck" onclick="toggleCheck(this)"></td></tr>';
	}
	for (const blockedMember of blockedMembers) {
		html += '<tr>';
		html += '<td><input type="checkbox" name="pmNum" value="' + blockedMember.pmNum + '"></td>';
		html += '<td>  ' + blockedMember.uiImgPath + '  </td>';
		html += '<td>  ' + blockedMember.uiNickname + '  </td>';
		html += '</tr>';
	}
	document.querySelector('#blockedMemberTbody').innerHTML = html;
}

function toggleCheck(obj) {
	const checkObjs = document.querySelectorAll('input[name="pmNum"]');
	for (const checkObj of checkObjs) {
		checkObj.checked = obj.checked;
	}
}

async function changeMemberStatus(type) {
	let msg = '탈퇴';
	if (type === 'block') {
		msg = '차단';
	} else if (type === 'unblock') {
		msg = '차단 해제';
	}
	if(confirm('선택한 부원을 ' + msg + '하시겠습니까?')) {
		const pmNumObjs = document.querySelectorAll('input[name="pmNum"]:checked');
		let pmNums = [];
		for (const pmNumObj of pmNumObjs) {
			pmNums.push(pmNumObj.value);
		}
		console.log(pmNums);
		if(pmNums.length===0) {
			alert('선택된 부원이 없습니다.');
			return;
		}
		
		let memberParameter = {
				pmNums : pmNums,
				pmActive : 0
		};
		if (type === 'block') {
			memberParameter.pmActive = -1;	
		} else if (type === 'unblock') {
			memberParameter.pmActive = 0;
		}
		console.log(memberParameter);
		
		const changeResponse = await fetch('/captain/party-info/members?piNum=${param.piNum}', {
			method:'PATCH',
			headers: {
				'Content-Type' : 'application/json'
			},
			body: JSON.stringify(memberParameter)
		});
		if (!changeResponse.ok) {
			const errorResult = await changeResponse.json();
			alert(errorResult.message);
			return;
		}
		const changeResult = await changeResponse.json();
		if (changeResult === pmNums.length) {
			alert('선택된 부원을 모두 ' + msg + '했습니다.');
			location.href='/views/party/edit?piNum=${param.piNum}';
		}
	}
}

async function changePartyStatus(type) {
	let url = '/captain/party-info';
	let method = 'DELETE';
	let msg = '삭제';
	let rediretUrl = '/views/party/main';
	if (type === 'complete') {
		url += '/complete';
		method = 'PATCH';
		msg = '모집완료';
		rediretUrl = '/views/party/view?piNum=${param.piNum}';
	}
	if (confirm('정말 ' + msg +'하시겠습니까?')) {
		const changeResponse = await fetch(url + '?piNum=${param.piNum}', {
			method: method
		});
		if (!changeResponse.ok) {
			const errorResult = await changeResponse.json();
			alert(errorResult.message);
			return;
		}
		const changeResult = await changeResponse.json();
		if (changeResult === true) {
			alert('소소모임이 ' + msg + '되었습니다.');
			location.href = rediretUrl;
		}
	}
}

</script>
</body>
</html>
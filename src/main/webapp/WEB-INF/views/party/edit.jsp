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

<div id="partyDiv" style="width:80%; height:300px; margin:5% 0 5% 10%">
<h2>소소모임 정보</h2>
<div id="partyInfoDiv" style="border:1px solid; height:250px;">
<input type="text" id="piName" name="piName" placeholder="모임 이름"><br>
<input type="text" id="mntnm" name="mntnm" readonly><br>
<input type="date" id="piExpdat" name="piExpdat" placeholder="모임 날짜"><br>
<input type="time" id="piMeetingTime" name="piMeetingTime" step="900" placeholder="모임 시간"><br>
<input type="number" id="piMemberCnt" name="piMemberCnt" max=50 min=2 placeholder="정원"><br>
<textarea id="piProfile" placeholder="모임 설명"></textarea><br>
<button onclick="updateParty()">수정</button>
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
	
	<button onclick="sendMembersOut()" class="btn btn-primary">탈퇴</button>
	<button onclick="sendMembersOut('block')" class="btn btn-secondary">차단</button>
	<br>
	차단한 회원은 재가입할 수 없습니다.
</div>

<div id="blockedMembersDiv" style="display:none;">
	<table class="table table-borderless">
		<thead>
			<tr>
				<th><input type="checkbox" name="allCheck" onclick="toggleCheck(this)"></th>
			</tr>
		</thead>
		<tbody id="blockedMemberTbody">
		</tbody>
	</table>
	
	<button onclick="unblockMembers()">차단 해제</button>
</div>
	
</div>


</div>
<script>
window.addEventListener('load', function() {
	getPartyInfos();
	getMemberInfos();
});

function getPartyInfos(){
	fetch('/party-infos/${param.piNum}')
	.then(async response => {
			if(response.ok) {
				return response.json();
			} else {
				const err = await response.json();
				throw new Error(err);
			}
		}) 
	.then(partyInfo => {
		console.log(partyInfo);
		document.querySelector('#piName').value = partyInfo.piName;
		document.querySelector('#mntnm').value = partyInfo.mntnm;
		document.querySelector('#piExpdat').value = partyInfo.piExpdat;
		document.querySelector('#piMeetingTime').value = partyInfo.piMeetingTime;
		document.querySelector('#piMemberCnt').value = partyInfo.piMemberCnt;
		document.querySelector('#piProfile').value = partyInfo.piProfile;
	})
	.catch(error => {
		console.log('에러!!!!!');
	});
}

function updateParty() {
	if (checkInput() === false) {
		return;
	}
	
	let partyInfoParameter = {
			piName : document.querySelector('#piName').value,
			mntnm : document.querySelector('#mntnm').value,
			piExpdat : document.querySelector('#piExpdat').value,
			piMeetingTime : document.querySelector('#piMeetingTime').value.replace(':',''),
			piMemberCnt : document.querySelector('#piMemberCnt').value,
			piProfile : document.querySelector('#piProfile').value
	};
	console.log(partyInfoParameter);
	
	fetch('/party-info/${param.piNum}', {
		method: 'PATCH',
		headers: {
			'Content-Type': 'application/json'
		},
		body: JSON.stringify(partyInfoParameter)
	})
	.then(async response => {
			if(response.ok) {
				return response.json();
			} else {
				const err = await response.json();
				throw new Error(err);
			}
		})
	.then(data => {
		if (data.result === true) {
			alert(data.msg);
		} else {
			if (confirm(data.msg)) {
				location.href = data.url;
			}
		}
		location.href = data.url;
	})
	.catch(error => {
		console.log('에러!!!!!');
		alert(error.msg);
		location.href = error.url;
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

async function getMemberInfos() {
	document.querySelector('#blockedMembersDiv').style.display = 'none';
	document.querySelector('#memberInfosDiv').style.display = '';
	
	let html = '';
	const membersResponse = await fetch('/party-infos/members/${param.piNum}');
	if (!membersResponse.ok) {
		const errorResult = await membersResponse.json();
		console.log(errorResult);
		html += '<p>' + errorResult.message + '</p>';
		document.querySelector('#memberInfosDiv').innerHTML = html;
		return;
	}
	const members = await membersResponse.json();
	if (members.length !== 1) {
		html += '<tr><td><input type="checkbox" name="allCheck" onclick="toggleCheck(this)"></td><td>전체 선택</td></tr>';
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
	const blockedMembersResponse = await fetch('/party-info/members/blocked?piNum=${param.piNum}');
	if (!blockedMembersResponse.ok) {
		const errorResult = await blockedMembersResponse.json();
		console.log(errorResult);
		html += '<p>' + errorResult.message + '</p>';
		document.querySelector('#blockedMembersDiv').innerHTML = html;
		return;
	}
	const blockedMembers = await blockedMembersResponse.json();
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

function sendMembersOut(type) {
	const msg = '탈퇴';
	if (type === 'block') {
		msg = '차단';
	}
	if(confirm('선택한 부원을 ' + msg + '하시겠습니까?')) {
		const pmNumObjs = document.querySelectorAll('input[name="pmNum"]:checked');
		const pmNums = [];
		for (const pmNumObj of pmNumObjs) {
			pmNums.push(pmNumObj.value);
		}
		console.log(pmNums);
		if(pmNums.length===0) {
			alert('선택된 부원이 없습니다.');
			return;
		}
		
		const memberParameter = {
				pmNums : pmNums,
				pmActive : 0
		};
		if(type === 'block') {
			memberParameter.pmActive = -1;	
		}
		console.log(memberParameter);
		
		fetch('/party-info/members/${param.piNum}', {
			method:'PATCH',
			headers: {
				'Content-Type' : 'application/json'
			},
			body: JSON.stringify(memberParameter)
		})
		.then(response => response.json())
		.then(result => {
			if(result === pmNums.length) {
				alert('선택된 부원을 모두 내보냈습니다.');
				location.href='/views/party/edit?piNum=${param.piNum}';
			}
		})
	}
}

</script>
</body>
</html>
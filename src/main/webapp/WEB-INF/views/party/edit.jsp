<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>소소모임 관리 페이지</title>
</head>
<body>
<h2>소소모임 방장 관리 페이지</h2>

<h4>소소모임 정보 수정</h4>
<div id="partyDiv" style="border:1px solid; width:300px; height:200px; overflow:scroll-y;">
<input type="text" id="piName" name="piName" placeholder="모임 이름"><br>
<input type="text" id="mntnm" name="mntnm" readonly><br>
<input type="date" id="piExpdat" name="piExpdat" placeholder="모임 날짜"><br>
<input type="time" id="piMeetingTime" name="piMeetingTime" step="900" placeholder="모임 시간"><br>
<input type="number" id="piMemberCnt" name="piMemberCnt" max=50 min=2 placeholder="정원"><br>
<textarea id="piProfile" placeholder="모임 설명"></textarea><br>

<button onclick="updateParty()">수정</button>
</div>

<h4>부원 관리</h4>
<div id="membersDiv" style="border:1px solid; width:300px; height:200px; overflow:scroll-y;">
	<table>
		<thead>
			<tr>
				<th>  방장  </th>
				<th>  이미지  </th>
				<th>  닉네임  </th>
				<th>  나이  </th>
				<th>  성별  </th>
			</tr>
		</thead>
		<tbody id="memberInfos">
		</tbody>
	</table>
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
		//document.querySelector('#piMeetingTime').value = (partyInfo.piName).replace(':',''),
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
	
	fetch('/party-infos', {
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

function getMemberInfos() {	
	fetch('/party-infos/members/${param.piNum}')
	.then(async response => {
			if(response.ok) {
				return response.json();
			} else {
				const err = await response.text();
				throw new Error(err);
			}
		})
	.then(memberList => {
		console.log(memberList);
		let html = '';
		for (memberInfo of memberList) {
			html += '<tr>';
			if (memberInfo.pmGrade === 1) {
				html += '<td>  ★  </td>'
			} else {
				html += '<td>    </td>'
			}
			html += '<td>  ' + memberInfo.uiImgPath + '  </td>';
			html += '<td>  ' + memberInfo.uiNickname + '  </td>';
			html += '<td>  ' + memberInfo.uiAge + '  </td>';
			html += '<td>  ' + memberInfo.uiGender + '  </td>';
			html += '</tr>';
		}
		document.querySelector('#memberInfos').innerHTML = html;
	})
	.catch(error => {
		console.log('에러!!!!!');
		console.log(error);
	});
}
</script>
</body>
</html>
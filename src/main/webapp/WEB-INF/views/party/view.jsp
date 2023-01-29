<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>소소모임 상세페이지</title>
<style>
#member:hover {
    color: red;
  }
</style>
</head>
<body>
<h2>소소모임 상세페이지</h2>
<h3>소소모임 정보</h3>
<div id="partyInfos">
</div>

<div id="memberInfos" style="display:none; border:1px solid; width:300px; height:200px; overflow:scroll;">
	<button onclick="closeSearchDiv()" style="float:right;">닫기</button>
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
		<tbody id="memberTbody">
		</tbody>
	</table>
</div>

<button onclick="location.href='/views/party/notice?piNum=${param.piNum}'">제대로 모시겠습니다</button>

<script>
window.onload = function(){
	getPartyInfos();
}
//소모임 정보
function getPartyInfos(){
	let html = '';
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
		html += '<div style="border:1px solid; width:400px;">';
		html += '<p>산 : ' + partyInfo.mntnm + '</p>';
		html += '<p>모임 이름 : ' + partyInfo.piName + '</p>';
		html += '<p>날짜 : ' + partyInfo.piExpdat + '</p>';
		html += '<p>시간 : ' + partyInfo.piMeetingTime + '</p>';
		html += '<p><u id="member" style="cursor:pointer;" onclick="getMemberInfos()">멤버 : ' + partyInfo.memNum + "</u> / " + partyInfo.piMemberCnt + '</p>';
		html += '<p>좋아요 : ' + partyInfo.likeNum + '</p>';
		html += '<p>소개 : ' + partyInfo.piProfile + '</p>';
		html += '<p>방장 : ' + partyInfo.uiNickname + '</p>';
		html += '</div>';
		document.querySelector('#partyInfos').innerHTML = html;
	})
	.catch(error => {
		console.log('에러!!!!!');
	});
}

function getMemberInfos() {
	document.querySelector('#memberInfos').style.display = '';
	
	fetch('/party-infos/members/${param.piNum}')
	.then(async response => {
			if(response.ok) {
				return response.json();
			} else {
				const err = await response.json();
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
		document.querySelector('#memberTbody').innerHTML = html;
	})
	.catch(error => {
		console.log('에러!!!!!');
	});
}

function closeSearchDiv() {
	document.querySelector('#memberInfos').style.display = 'none';
}

if('${msg}' != ''){
	alert('${msg}');
}
</script>
</body>
</html>
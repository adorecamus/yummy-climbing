<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>소모임 메인</title>
</head>
<body>
<h2>소모임 메인페이지</h2>

<button onclick="location.href='/views/party/create'">모임 만들기</button>

<h4>이 주의 추천 소모임</h4>
<div id="recommendedParty" style="border:2px solid; width:800px; height:250px;">

</div>
<br>

<select id="searchType">
	<option value="MNTNM">산 이름</option>
	<option value="PI_NAME">모임 이름</option>
	<option value="PI_EXPDAT">날짜</option>
</select>
<input type="text" id="searchText"><button onclick="getPartyList()">검색</button>
<br><br>

<select id="sortType" onchange="getPartyList()">
	<option value="LIKE_NUM">좋아요</option>
	<option value="PI_CREDAT">생성일</option>
	<option value="PI_EXPDAT">마감일</option>
</select>
<select id="sortOrder" onchange="getPartyList()">
	<option value="DESC">내림차순</option>
	<option value="ASC">오름차순</option>
</select>
<input type="checkbox" onclick="changeCompleteStatus(this)">완료된 모임 포함
<div id="partyList">
</div>

<script>
let includeCompletedParty = false;

window.onload = function() {
	getPartyList();
	getRecommendedPartyList();
}

function changeCompleteStatus(obj) {
	includeCompletedParty = obj.checked;
	getPartyList();
}

function getPartyList() {
	let parameter = "?searchType=" + document.querySelector('#searchType').value
	+ "&searchText=" + document.querySelector('#searchText').value
	+ "&sortType=" + document.querySelector('#sortType').value
	+ "&sortOrder=" + document.querySelector('#sortOrder').value
	+ "&includeComplete=" + includeCompletedParty;
	
	fetch('/party-infos' + parameter)
	.then(response => response.json()) 
	.then(list => {
		let html = '';
		for(partyInfo of list) {
			if (partyInfo.piComplete === 1) {
				html += '<div style="background-color:lightgrey; float:left; border:1px solid; width:200px; cursor:pointer;" onclick="location.href=\'/views/party/view?piNum=' + partyInfo.piNum + '\'">';
			} else {
				html += '<div style="float:left; border:1px solid; width:200px; cursor:pointer;" onclick="location.href=\'/views/party/view?piNum=' + partyInfo.piNum + '\'">';
			}
			html += '<p>산 : ' + partyInfo.mntnm + '<br>';
			html += '모임 이름 : ' + partyInfo.piName + '<br>';
			html += '날짜 : ' + partyInfo.piExpdat + '<br>';
			html += '시간 : ' + partyInfo.piMeetingTime + '<br>';
			html += '멤버 : ' + partyInfo.memNum + " / " + partyInfo.piMemberCnt + '<br>';
			html += '좋아요 : ' + partyInfo.likeNum + '<br>';
			html += '소개 : ' + partyInfo.piProfile + '<br>';
			html += '생성일 : ' + partyInfo.piCredat + '</p>';
			html += '</div>';
		}
		document.querySelector('#partyList').innerHTML = html;
	})
}

function getRecommendedPartyList() {
	fetch('/party-infos/recommended')
	.then(response => response.json()) 
	.then(list => {
		let html = '';
		for(partyInfo of list) {
			if (partyInfo.piComplete === 1) {
				html += '<div style="background-color:lightgrey; float:left; border:1px solid; width:200px; cursor:pointer;" onclick="location.href=\'/views/party/view?piNum=' + partyInfo.piNum + '\'">';
			} else {
				html += '<div style="float:left; border:1px solid; width:200px; cursor:pointer;" onclick="location.href=\'/views/party/view?piNum=' + partyInfo.piNum + '\'">';
			}
			html += '<p>산 : ' + partyInfo.mntnm + '<br>';
			html += '모임 이름 : ' + partyInfo.piName + '<br>';
			html += '날짜 : ' + partyInfo.piExpdat + '<br>';
			html += '시간 : ' + partyInfo.piMeetingTime + '<br>';
			html += '멤버 : ' + partyInfo.memNum + " / " + partyInfo.piMemberCnt + '<br>';
			html += '좋아요 : ' + partyInfo.likeNum + '<br>';
			html += '소개 : ' + partyInfo.piProfile + '<br>';
			html += '생성일 : ' + partyInfo.piCredat + '</p>';
			html += '</div>';
		}
		document.querySelector('#recommendedParty').innerHTML = html;
	})
}
</script>

</body>
</html>
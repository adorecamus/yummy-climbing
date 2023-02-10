<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>소모임 메인</title>
<%@ include file= "/resources/common/header.jsp" %>
<link href="/resources/css/style2.css" rel="stylesheet" type="text/css">
<link href="/resources/css/style.css" rel="stylesheet" type="text/css">
<meta name=”viewport” content=”width=device-width, initial-scale=1”>
</head>
<body>
	<div class="col-8 mx-auto text-center" style="margin-top: 50px;">
		<div class="section-title pt-4">
			<p class="text-primary text-uppercase fw-bold">SOSOMOIM</p>
			<h2 class="mb-3 text-capitalize">소소모임</h2>
		</div>

	</div>

	<div class="recommendationWrap">
		<h4>★이 주의 추천 소소모임★</h4>
		<div id="recommendedParty" class="recommendations"></div>
	</div>
	<div class="searchBox">
		<div class="input-group shadow-none bg-white search">
			<select id="searchType" class="searchBoxOption">
				<option value="MNTNM">산 이름</option>
				<option value="PI_NAME">모임 이름</option>
				<option value="PI_EXPDAT">날짜</option>
			</select> 
			<input type="text" id="searchText" class="form-control shadow-none bg-white" style="width: 350px;" placeholder="검색어를 입력하세요..">
			<button class="btn btn-primary search"  style="margin: 0 3px;" onclick="getPartyList()">검색</button>
		</div>
		<div class="detail">
			<select id="sortType" class="searchBoxOption" onchange="getPartyList()">
				<option value="LIKE_NUM">좋아요</option>
				<option value="PI_CREDAT">생성일</option>
				<option value="PI_EXPDAT">마감일</option>
			</select>
			<select id="sortOrder" class="searchBoxOption"  onchange="getPartyList()">
				<option value="DESC">내림차순</option>
				<option value="ASC">오름차순</option>
			</select>
			<input type="checkbox" onclick="changeCompleteStatus(this)">완료된 모임 포함
		</div>	
	</div>

	<div class="flex_container" id="partyList">
		<div class="makeParty"></div>
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
		html += '<div class="flex_item"><img class="plusBtn" onclick="location.href=\'/views/party/create\'" src="/resources/images/banner/plus2.png"><p><b>소모임 만들기</b></p></div>';
		for(partyInfo of list) {
			if (partyInfo.piComplete === 1) {
				html += '<div class="flex_item" style="background-color:lightgrey;"';
			} else {
				html += '<div class="flex_item" '; 
			}
			html += 'onclick="location.href=\'/views/party/view?piNum=' + partyInfo.piNum + '\'">';
			html += '<p><b><' + partyInfo.piName + '></b><br>';
			html += '<img class="partyIcon_main" src="/resources/images/party/' + partyInfo.piIcon + '.png">';
			html += '산 : ' + partyInfo.mntnm + '<br>';
			html += '날짜 : ' + partyInfo.piExpdat + '<br>';
			html += '시간 : ' + partyInfo.piMeetingTime + '<br>';
			html += '멤버 : ' + partyInfo.memNum + " / " + partyInfo.piMemberCnt + '<br>';
			html += '좋아요 : ' + partyInfo.likeNum + '<br>';
			html += '[소개]<br>' + partyInfo.piProfile + '<br>';
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
				html += '<div style="background-color:lightgrey;';
			} else {
				html += '<div class="recommendedParty" '; 
			}
			html += 'onclick="location.href=\'/views/party/view?piNum=' + partyInfo.piNum + '\'">';
			html += '<p><b><' + partyInfo.piName + '></b><br>';
			html += '<img class="partyIcon_main" src="/resources/images/party/' + partyInfo.piIcon + '.png">';
			html += '산 : ' + partyInfo.mntnm + '<br>';
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
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
	<div class="col-8 mx-auto text-center mt-5" >
		<div class="section-title">
			<p class="text-primary text-uppercase fw-bold">SOSOMOIM</p>
			<h2 class="mb-3 text-capitalize" onclick="location.href='/views/party/main'"style="cursor: pointer">소소모임</h2>
		</div>
	</div>
<section>
	<div class="container mb-3">
		<div class="col-8 mx-auto text-center">
			<hr><h4>★&nbsp;&nbsp;금주의 추천 소소모임&nbsp;&nbsp;★</h4><hr>
		</div>
		<div id="recommendedParty" class="row cur-po" style="max-width: 1182px; margin: 0 auto;"></div>
	</div>
</section>
<div class="container">
	<div class="mt-3">
		<div class="input-group shadow-none bg-white search">
			<select id="searchType" class="searchBoxOption" style="border-color: lightgrey; width: 100px; text-align: center;">
				<option value="MNTNM">산 이름</option>
				<option value="PI_NAME">모임 이름</option>
				<option value="PI_EXPDAT">날짜</option>
			</select> 
			<input type="text" id="searchText" class="form-control shadow-none bg-white" style="width: 245px;" placeholder="검색어를 입력하세요.."
			value="" onkeypress="getBoardInfos()">
		<div class="searchBtn" style="width: 77px;">
			<button class="btn btn-primary w-100 " onclick="getPartyList()" style="padding: 14px; margin-inline:8px;">검색</button>
		</div>
	</div>
	<div class="mb-2" style="margin-top:3px;">
		<select id="sortType" class="searchBoxOption" style="border-color: lightgrey; width: 100px; text-align: center;"onchange="getPartyList()">
			<option value="LIKE_NUM">좋아요</option>
			<option value="PI_CREDAT">생성일</option>
			<option value="PI_EXPDAT">마감일</option>
		</select>
		<select id="sortOrder" class="searchBoxOption" style="border-color: lightgrey; width: 100px; text-align: center;" onchange="getPartyList()">
			<option value="DESC">내림차순</option>
			<option value="ASC">오름차순</option>
		</select>
		<input type="checkbox" onclick="changeCompleteStatus(this)">완료된 모임 포함
		</div>	
	</div>
</div>	

<section >
	<div class="row cur-po mb-3" id="partyList" style="max-width: 1182px; margin: 0 auto;">
		<div class="makeParty"></div>
	</div>
</section>


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
		html += '<div class="col-lg-4" style="margin:13px 1px 13px 2px;"><div class="card"><div class="card-header" style="text-align:center; padding-top:91px;"><img class="card-img-top" style="width:86px; margin:0 auto;"onclick="location.href=\'/views/party/create\'" src="/resources/images/banner/plus2.png"><br><b class="border-sm-tit mt-3">소모임 만들기</b></div><div class="card-body"></div></div></div>';
		for(partyInfo of list) {
			if (partyInfo.piComplete === 1) {
				html += '<div class="col-lg-4 recommendedParty" style="background-color:lightgrey;"';
			} else {
				html += '<div class="col-lg-4 "style="margin:13px 1px 13px 2px;"'; 
			}
		  
			html += 'onclick="location.href=\'/views/party/view?piNum=' + partyInfo.piNum + '\'"><div class="card">';
			html += '<div class="p-3 card-header" style="text-align:center; over-flow:hidden; height:198px;"><div class="border-box-tit mb-4">' + partyInfo.mntnm +'</div>';
			html += '<img class="partyIcon_main mb-4" style="width:88px; height:65px" src="/resources/images/party/' + partyInfo.piIcon + '.png">';
			html += '<div style="margin:0 auto;"><b class="border-sm-tit mt-3">' + partyInfo.piName + '</b></div></div>';
			html += '<ul class="list-group list-group-flush party-list-f" style="	list-style-type: none;">';
			html += '<div class="p-3"><li class="list-group-item">날짜 :&nbsp;&nbsp;&nbsp;&nbsp;' + partyInfo.piExpdat + '</li>';
			html += '<li class="list-group-item">시간 :&nbsp;&nbsp;&nbsp;&nbsp;' + partyInfo.piMeetingTime + '</li>';
			html += '<li class="list-group-item">멤버 :&nbsp;&nbsp;&nbsp;&nbsp;' + partyInfo.memNum + " / " + partyInfo.piMemberCnt + '</li>';
			html += '<li class="list-group-item">좋아요 :&nbsp;' + partyInfo.likeNum + '</li>';
			html += '생성일 :&nbsp;' + partyInfo.piCredat + '</ul>';
			html += '<div class="fs-6" style="over-flow:hidden; height:38px;">&nbsp;&nbsp;[소개]&nbsp;&nbsp;' + partyInfo.piProfile + '</div></p>';
			html += '</div></div></div>';
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
				html += '<div class="col-xl-4 p-4"'; 
			}
			html += 'onclick="location.href=\'/views/party/view?piNum=' + partyInfo.piNum + '\'">';
			html += '<div class="recommendedParty" >';
			html += '<div class="border-box-tit mb-4">' + partyInfo.mntnm + '</div>';
			html += '<img class="partyIcon_main mt-2 mb-4" style="width:88px; height:65px" src="/resources/images/party/' + partyInfo.piIcon + '.png">';
			html += '<b class="border-sm-tit mt-3">' + partyInfo.piName + '</b>';
			html += '<div class="row mt-2" style="text-align: left; padding-inline: 15px; color:#2f2f2f; font-size:0.99rem;"><div class="w-50">날짜 : ' + partyInfo.piExpdat + '<br>';
			html += '시간 : ' + partyInfo.piMeetingTime + '<br>';
			html += '멤버 : ' + partyInfo.memNum + " / " + partyInfo.piMemberCnt + '</div>';
			html += '<div class="w-50"> 좋아요 : ' + partyInfo.likeNum + '<br>';
//			html += '소개 : ' + partyInfo.piProfile + '<br>';
			html += '생성일 : ' + partyInfo.piCredat;
			html += '</div</div></div></div></div></div>';
		}
		document.querySelector('#recommendedParty').innerHTML = html;
	})
}
</script>

</body>
</html>
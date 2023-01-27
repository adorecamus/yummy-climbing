<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>소모임 상세페이지</title>
<%@ include file= "/resources/common/header.jsp" %>
<link href="/resources/css/style1.css" rel="stylesheet" type="text/css">
<link href="/resources/css/style.css" rel="stylesheet" type="text/css">
</head>
<body>
<h2>소모임 상세페이지</h2>
<h3>소모임 정보</h3>
<div id="partyInfos">
</div>
<br>
<button onclick="location.href='/views/party/notice?piNum=${param.piNum}'">제대로 모시겠습니다</button>

<script>
window.onload = function(){
	getPartyInfos();
}
//소모임 정보
function getPartyInfos(){
	let html = '';
	fetch('/party-infos/${param.piNum}')
	.then(response => response.json())
	.then(function(partyInfo){
		console.log(partyInfo);
		html += '<div style="border:1px solid; width:400px;">';
		html += '<p>산 : ' + partyInfo.mntnm + '</p>';
		html += '<p>모임 이름 : ' + partyInfo.piName + '</p>';
		html += '<p>날짜 : ' + partyInfo.piExpdat + '</p>';
		html += '<p>시간 : ' + partyInfo.piMeetingTime + '</p>';
		html += '<p>멤버 : ' + partyInfo.memNum + " / " + partyInfo.piMemberCnt + '</p>';
		html += '<p>좋아요 : ' + partyInfo.likeNum + '</p>';
		html += '<p>소개 : ' + partyInfo.piProfile + '</p>';
		html += '</div>';
		document.querySelector('#partyInfos').innerHTML = html;
	});
}

</script>
</body>
</html>
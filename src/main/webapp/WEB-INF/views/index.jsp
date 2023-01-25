<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>맛등산</title>
</head>
<body>
맛등산 대박~~~~~~~~~~~~~~~~~!!!!!!!!!!!!!!!!!!!!!!
<br>
<c:if test="${userInfo ne null}">
	<h1>${userInfo.uiNickname}님 어서오세요</h1>
</c:if>
<br>
<c:if test="${userInfo eq null}">
<button onclick="location.href='/views/user/login'">로그인</button>
<button onclick="location.href='/views/user/signup'">회원가입</button> 
</c:if>
<button onclick="location.href='/views/community/list'">목록</button>
<button onclick="location.href='/views/mountain/list'">메인</button>
<button onclick="location.href='/views/party/main'">소모임</button>
<br>
<br>
<c:if test="${userInfo ne null}">
<button onclick="location.href='/views/user/mypage'">마이 페이지</button> 
<button onclick="location.href='/views/user/logout">로그아웃</button>
</c:if>

<h4>이 주의 추천 산</h4>
<div id="recommendedMountainDiv" style="width:500px; height:200px; align:center;">
	<div id="mountainInfoDiv" class=".paging-div" style="border:solid;">
		<p>추천 산리스트</p>
	</div>
</div>

<h4>이 주의 추천 모임</h4>
<div id="recommendedParty" style="border:2px solid; width:500px; height:200px;"></div>

<script>
 	window.onload = function(){
 		getRecommendedMountainList();
 		getRecommendedPartyList();
	}
	
	function getRecommendedMountainList(){ //산 정보
		const mountainURI = '/mountain/recommended';
	
		fetch(mountainURI,{
			method:'GET',
			headers : {
				'Content-Type' : 'application/json'
			}			
		})
		.then(async function(res){
			if(res.ok){
				return res.json();
			}else{
				const err = await res.text();
				throw new Error(err);
			}
		})
		.then(function(mountainList){
			if(mountainList!==null){
				let html= '';
				for(const mountainInfo of mountainList){
					html += '<div style="border:1px solid; width: 150px; height: 150px; display:inline-block; cursor:pointer;" onclick="location.href=\'/views/mountain/view?mntnm='
						 + mountainInfo.mntnm + '\'">'
						 + '<h5>' + mountainInfo.mntnm + '</h5>' + '</div>';
				}
				document.querySelector('#mountainInfoDiv').innerHTML = html;
			}
		});
	}
	
	function getRecommendedPartyList() {
		fetch('/party-infos/recommended')
		.then(response => response.json()) 
		.then(list => {
			let html = '';
			for(partyInfo of list) {
				if (partyInfo.piComplete === 1) {
					html += '<div style="background-color:lightgrey; float:left; border:1px solid; width:150px; height:150px; cursor:pointer;" onclick="location.href=\'/views/party/view?piNum=' + partyInfo.piNum + '\'">';
				} else {
					html += '<div style="float:left; border:1px solid; width:150px; height:150px; cursor:pointer;" onclick="location.href=\'/views/party/view?piNum=' + partyInfo.piNum + '\'">';
				}
				html += '<p>' + partyInfo.mntnm + '<br><b>' + partyInfo.piName + '</b></p>';
				/*
				html += '<p>산 : ' + partyInfo.mntnm + '</p>';
				html += '<p>모임 이름 : ' + partyInfo.piName + '</p>';
				html += '<p>날짜 : ' + partyInfo.piExpdat + '</p>';
				html += '<p>시간 : ' + partyInfo.piMeetingTime + '</p>';
				html += '<p>멤버 : ' + partyInfo.memNum + " / " + partyInfo.piMemberCnt + '</p>';
				html += '<p>좋아요 : ' + partyInfo.likeNum + '</p>';
				html += '<p>소개 : ' + partyInfo.piProfile + '</p>';
				html += '<p>생성일 : ' + partyInfo.piCredat + '</p>';
				*/
				html += '</div>';
			}
			document.querySelector('#recommendedParty').innerHTML = html;
		})
	}
</script>
</body>
</html>
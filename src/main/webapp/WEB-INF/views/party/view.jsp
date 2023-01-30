<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="page" style="overflow: auto; border: 1px solid;">
	<header>
		<h2>header 영역</h2>
	</header>
	<nav style="width: 150px;height:1500px; float:left; border: 1px solid;">
	<div id="partyInfos1">
		<p id="mntnm">산: </p>
		<p id="piName" style="color: orange;"></p>
	</div>		
	<div id="partyIcon" style="width:100px; height:100px; background-color:gray;"> </div>	
	<div id="partyInfos2">
		<p id="uiNickname">대장: </p>
		<p id="piMember">부원: </p>
		<input type="button" id="likeBtn" value="♡ 좋아요" onclick="updateLike()"/>
		<div id="likeBox"></div>
	</div>	
	</nav>
	
	<section style="height:1500px; margin-left: 156px; border: 1px solid;">
		<h2>소소모임 소개</h2>	
		<div id="partyInfos" style="border: 1px solid;" >
		</div>
		<h2>알림장</h2>
		<div id="partyNotices" style="border: 1px solid;">
			<div id="noticeInfo">
			<p id="uiNickname"></p>
			<p id="pnCredat">등록일</p>
			</div>
			<p>내용</p>
			<textarea rows="10" cols="50"></textarea>
			<br>			
		</div>
		
		<h2>소근소근</h2>
			<div id="commentList" style="border: 1px solid;">
			<br>
				<textarea rows="2" cols="50" id="outputComment"></textarea>
				<button onclick="insertComment()" id="insertCommentBtn">등록</button>

			</div>
	</section>
</div>

<script>
window.onload = function(){
	getPartyInfos();
}
//소모임 정보
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
		//console.log(partyInfo);
		document.querySelector('#mntnm').innerHTML += partyInfo.mntnm;
		document.querySelector('#piName').innerHTML += partyInfo.piName;
		document.querySelector('#uiNickname').innerHTML += partyInfo.uiNickname;
		document.querySelector('#piMember').innerHTML +=  partyInfo.memNum + " / " + partyInfo.piMemberCnt;
	})
	.catch(error => {
		console.log('에러!!!!!');
	});
}

//댓글 클릭-> 해당 공지의 댓글 전체를 볼 수 있음
function openComments(){
	document.querySelector('#comment').style.display = '';
}



</script>
</body>
</html>
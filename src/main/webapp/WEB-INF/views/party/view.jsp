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
	<br>
	<button onclick="joinParty()">가입하기</button>
	<button onclick="quitParty()">탈퇴하기</button>
	</nav>
	
	<section style="height:1500px; margin-left: 156px; border: 1px solid;">
		<h2>소소모임 소개</h2>	
		<div id="partyInfos" style="border: 1px solid;" >
			<p id="piExpdat">- 모임날짜: </p>
			<p id="piMeetingTime">- 모임시간: </p>
			<p id="piProfile">" </p>
		</div>
		<h2>알림장</h2>
		<div id="partyNotices" style="border: 1px solid;">
				<div id="noticeList">
				</div>
		</div>
		<h2>소근소근</h2>
			<div id="commentList" style="border: 1px solid;">
			</div>
			<br>
			<div id="commentBox">
			<div id="writerId"></div>
			<textarea id="inputComment" rows="5" cols="60"></textarea><button onclick="insertPartyComment()">등록</button>
			</div>
	</section>
</div>

<script>
window.onload = function(){
	getPartyInfos1();
	getPartyInfos2();
	getPartyNotice();
	getPartyComment();
}
//소모임 정보
function getPartyInfos1(){
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
function getPartyInfos2(){
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
		document.querySelector('#piExpdat').innerHTML += partyInfo.piExpdat;
		document.querySelector('#piMeetingTime').innerHTML += partyInfo.piMeetingTime;
		document.querySelector('#piProfile').innerHTML += partyInfo.piProfile + " \"";
	})
	.catch(error => {
		console.log('에러!!!!!');
	});
}

//소모임 가입
function joinParty(){
	const info = {
			piNum : ${param.piNum}
	}
	fetch('/party-member', {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json'
		},
		body: JSON.stringify(info)
	})
	.then(response => response.json())
	.then(result => {
		if(result === true ){
			alert('소모임에 가입되었습니다!');
			location.href='/views/party/view?piNum=' + ${param.piNum};
			return;
		}
		alert('이미 가입한 소모임입니다');
	})
}
 console.log(${param.pmNum});
//소모임 탈퇴
function quitParty(){
	const check = confirm('소모임을 탈퇴하시겠습니까?');
	if(check){
		fetch('/party-member',{
			method: 'DELETE'
		})
		.then(response => response.json())
		.then(result => {
			if(result === 1){
				alert('소모임을 탈퇴하였습니다.');
				location.href='/views/party/main'
				return;
			}
			alert('다시 시도해주세요.');
		})
	}
}

//알림장 내용 가져오기
function getPartyNotice(){
	fetch('/party-notice/${param.piNum}')
	.then(response => response.json())
	.then(list => {
		let html = '';
		console.log(list);
		for(let i = 0; i < list.length; i++){
		noticeList[i] = list[i];
		html += '<p> ★ [' + noticeList[i].pnCredat + '] ' + noticeList[i].pnContent +'</p>';
		document.querySelector('#noticeList').innerHTML = html;
		}
	})
}

//소근소근 내용 가져오기
function getPartyComment(){
	fetch('/party-comments/${param.piNum}')
	.then(response => response.json())
	.then(list => {
		let html = '';
		console.log(list);
		for(let i=0; i<list.length; i++){
			commentList[i] = list[i];
			html += '<p>' + commentList[i].uiNickname + ' - ' + commentList[i].pcComment + '</p>';
			document.querySelector('#commentList').innerHTML = html;
		}
	})
	
}

//소근소근 글쓰기
function insertPartyComment(){
	const comment = {
			pcComment : document.querySelector('#inputComment').value,
	}
	fetch('/party-comments/${param.piNum}',{
		method: 'POST',
		headers: {
			'Content-Type': 'application/json'
		},
		body: JSON.stringify(comment)
	})
	.then(response => response.json())
	.then(result => {
		if(result === 1){
			alert('글이 등록되었습니다.');
			location.href='/views/party/view?piNum=' + ${param.piNum};
			return;
		}
		alert('다시 시도해주세요!');
	})
}

</script>
</body>
</html>
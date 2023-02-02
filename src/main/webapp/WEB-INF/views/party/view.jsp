<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>소소모임 상세페이지</title>
<%@ include file="/resources/common/header.jsp"%>
<link href="/resources/css/style1.css" rel="stylesheet" type="text/css">
<link href="/resources/css/style.css" rel="stylesheet" type="text/css">
</head>
<body>
<nav style="width: 150px; height:100%; float:left; position: fixed; left:0; right:0; padding-top: 10px;">
	<div style="width:100%; text-align: center;">
	<div id="partyInfos1" style="display: inline-block;">
		<p id="mntnm">산: </p>
		<p id="piName" style="color: orange;"></p>
	</div>		
	<div id="partyIcon" style="width:100px; height:100px; background-color:gray; display: inline-block;"> </div>	
	<div id="partyInfos2">
		<p id="uiNickname">대장: </p>
		<p id="piMember">부원: </p>
		<div id="likeBox" style="display: inline-block;">
			<div id="likeBtn" style="width: 50px; height: 50px; position: relative; float: left; cursor: pointer;" onclick="updateLike()">
				<img src="/resources/images/user/empty-heart.png">
			</div>
			<br>
			<div id="likeCnt"></div>
		</div>
	</div>	
	<br>
	<button onclick="joinParty()">가입하기</button>
	<button onclick="quitParty()">탈퇴하기</button>
	</div>
	</nav>

	<section style="height:100%; margin-left: 156px;">
		${userInfo}
		${memberAuth}
		
		<h2> "소소모임 소개"</h2>
		<br>
			<div id="partyInfos" style="border: 1px solid;" >
				<p id="piExpdat">- 모임날짜: </p>
				<p id="piMeetingTime">- 모임시간: </p>
				<p id="piProfile">" </p>
			</div>
		<br>
		<h2>"알림장"</h2>
			<div id="noticeBox">
				<div id="noticeList">
				</div>
				<div id="inputNotice" style="display:none;">
					<textarea rows="3" cols="70" id="pnContent"></textarea>
					<button onclick="insertNotice()">등록</button>
				</div>
			</div>
		<br>
		<h2>"소근소근"</h2>
			<div id="commentBox"></div>
			<textarea id="inputComment" rows="5" cols="60"></textarea><button onclick="insertPartyComment()">등록</button>
	</section>


<script>
window.onload = function(){
	getPartyInfos1();
	getPartyInfos2();
	getPartyNotice();
	getPartyComment();
	getPartyLikeCnt();
	checkPartyLikeInfo();
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
	.then(response => response.text())
	.then(result => {
		alert(result);
		location.href='/views/party/view?piNum=' + ${param.piNum};
	})
}

//소모임 탈퇴
function quitParty(){
	const check = confirm('소모임을 탈퇴하시겠습니까?');
	if(check){
		const info = {
				piNum : ${param.piNum}
		}
		fetch('/party-member',{
			method: 'DELETE',
			headers: {
				'Content-Type': 'application/json'
			},
			body: JSON.stringify(info)
		})
		.then(response => response.json())
		.then(result => {
			if(result === true){
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
		//console.log(list);
		for(let i = 0; i < list.length; i++){
			html += '<textarea style="resize:none;border:none;" cols="80" rows="1" id="notice'+ list[i].pnNum +'" readonly>' + '[' + list[i].pnCredat + '] ' + list[i].pnContent + '</textarea>';
			if('${memberAuth.pmGrade}' == 1){
				document.querySelector('#inputNotice').style.display='';
				html += '<button onclick="updateNotice('+list[i].pnNum+', this)">수정</button><button onclick="deleteNotice('+list[i].pnNum+')">삭제</button>'; 
			}
		}
		document.querySelector('#noticeList').innerHTML = html;
	})
}

//알림장에 공지 등록
function insertNotice(){
	const notice = {
			pnContent : document.querySelector('#pnContent').value.subString(0,10)
	};
	fetch('/party-notice/${param.piNum}', {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json'
		},
		body: JSON.stringify(notice)
	})
	.then(response => response.json())
	.then(result => {
		if(result === 1) {
			alert('공지가 등록되었습니다.');
			location.href='/views/party/view?piNum=' + ${param.piNum};
			return;
		}
		alert('다시 시도해주세요!');
	})
	.catch(error => {
		alert('다시 시도해주세요!!');
		location.replace();
	})
}

//알림장 공지 수정
function updateNotice(pnNum, obj){
	document.querySelector('#notice'+pnNum).style.border = '1px solid';
	document.querySelector('#notice'+pnNum).readOnly = false;
	obj.innerText = "확인";
	obj.addEventListener('click', function(){
		fetch('/party-notice/' + pnNum,{
			method : 'PATCH',
			headers : {
				'Content-Type' : 'application/json'
			},
			body : JSON.stringify({
				pnNum : pnNum,
				pnContent : document.querySelector('#notice'+pnNum).value
			})
		})
		.then(response => response.json())
		.then(result => {
			if(result === 1){
				alert('공지가 수정되었습니다.');
				location.href = '/views/party/view?piNum=' + ${param.piNum};
				return;
			}
			alert('다시 시도해주세요');
		})
	})
}

//알림장 공지 삭제
function deleteNotice(pnNum){
	const check = confirm('공지를 삭제하시겠습니까?');	
	if(check){
		fetch('/party-notice/' + pnNum, {
			method : 'DELETE'
		})
		.then(response => response.json())
		.then(result => {
			console.log(result);
			if(result === 1){
				alert('공지가 삭제되었습니다.');
				location.href='/views/party/view?piNum=' + ${param.piNum};
				return;
			}
			alert('다시 시도해주세요');
		})
	}
}

//소근소근 내용 가져오기
function getPartyComment(){
	fetch('/party-comments/${param.piNum}')
	.then(response => response.json())
	.then(list => {
		let html = '';
		//console.log(list);
		for(let i=0; i<list.length; i++){
			console.log(list[i]);
			html += '<p>' + list[i].uiNickname +' : ';	
			html += '<textarea style="resize:none; border:none;" cols="50" rows="1" id="comment'+ list[i].pcNum +'" readonly>' + list[i].pcComment + '</textarea>';
			if('${userInfo.uiNum}' == list[i].uiNum){
				html += '<button onclick="updatePartyComment('+list[i].pcNum+', this)">수정</button><button onclick="deletePartyComment('+list[i].pcNum+')">삭제</button>' + '</p>';
			}
		}
		document.querySelector('#commentBox').innerHTML = html;
	})
}


//소근소근 글쓰기
function insertPartyComment(){
	const comment = {
			pcComment : document.querySelector('#inputComment').value
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

//소근소근 글 수정
function updatePartyComment(pcNum, obj){
	document.querySelector('#comment'+pcNum).style.border = '1px solid';
	document.querySelector('#comment'+pcNum).readOnly = false;
	
	obj.innerText = '확인';
	obj.addEventListener('click', function(){
		fetch('/party-comment/'+ pcNum,{
			method: 'PATCH',
			headers: {
				'Content-Type': 'application/json'
			},
			body: JSON.stringify({
				piNum : ${param.piNum},
				pcComment : document.querySelector('#comment'+pcNum).value
			})
		})
		.then(response => response.json())
		.then(result => {
			if(result === 1){
				alert('글이 수정되었습니다.');
				location.href='/views/party/view?piNum=' + ${param.piNum};
				return;
			}
			alert('다시 시도해주세요!');
		})
	})
}

//소근소근 글 삭제
function deletePartyComment(pcNum){
	const check = confirm('글을 삭제하시겠습니까?');	
	if(check){
		fetch('/party-comment/' + pcNum, {
			method : 'DELETE'
		})
		.then(response => response.json())
		.then(result => {
			console.log(result);
			if(result === 1 ){
				alert('글이 삭제되었습니다.');
				location.href='/views/party/view?piNum=' + ${param.piNum};
				return;
			}
			alert('다시 시도해주세요');
		})
	}
}


//좋아요 개수 
function getPartyLikeCnt(){
	fetch('/party-like-cnt/${param.piNum}')
	.then(response => response.json())
	.then(data=> {
		if(data != null){
			let html = '';
			html += data;
			document.querySelector('#likeCnt').innerHTML = html;
		}
	});
}

//좋아요 되어있는지 체크
function checkPartyLikeInfo(){
	const info = {
			piNum : ${param.piNum}
	}
	fetch('/party-like/check',{
		method: 'POST',
		headers: {
			'Content-Type': 'application/json'
		},
		body: JSON.stringify(info)
	})
	.then(response => response.json())
	.then(result => {
		console.log(result);
		if(result === 1){
			//console.log(result);
			document.querySelector("#likeBtn img").src = '/resources/images/user/red-heart.png';
			return;
		}
		document.querySelector("#likeBtn img").src = '/resources/images/user/empty-heart.png';
		return;
	})
}

//좋아요 등록
function updateLike(){
	const info = {
			piNum : ${param.piNum}
	}
	fetch('/party-like',{
		method: 'POST',
		headers: {
			'Content-Type' : 'application/json'
		},
		body: JSON.stringify(info)
	})
	.then(response => response.json())
	.then(result => {
		if(result === 1){
			getPartyLikeCnt();
			checkPartyLikeInfo();
		}
	})
	
}


</script>
</body>
</html>
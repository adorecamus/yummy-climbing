<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>소소모임 상세페이지</title>
<%@ include file="/resources/common/header.jsp"%>
<link href="/resources/css/style2.css" rel="stylesheet" type="text/css">
<link href="/resources/css/style1.css" rel="stylesheet" type="text/css">
<link href="/resources/css/style.css" rel="stylesheet" type="text/css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>        <!-- 이 제이쿼리 꼭 넣어줘야함!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!-->
</head>
<body>
<section style="background-color: #ddebd7a8;">
<div class="container">
<div class="row">
	<div class="leftWrap col-lg-3">
		<div class="partyWidget">
			<div class="partyNameBox">
				<div id="mntnm"></div>
				<div id="piName" class="partyName"></div>
			</div>
			<div class="partyIcon_view"><img id="piIcon"></div>
			<div id="leftPartyInfoDiv" class="partyMemberBox">
				<div id="uiNickname">대장 </div>
				<div id="piMember" onclick="getMemberInfos()">부원 </div>
				<div id="likeBox" class="likeBox">
					<div id="likeBtn" onclick="updateLike()">
						<img src="/resources/images/banner/seed.png">
						<div class="row justify-content-center">
							<div id="likeInfo" style="color:red;" class="col-2">♡</div><div id="likeCnt" class="col-5"></div>
						</div>
					</div>
					<br>	
				</div>
			<br>
			<button id="partyBtn"></button>
			</div>
		</div>
	</div>
	<div class="col-lg-2 space"></div>
	<div class="rightWrap col-lg-7" style="margin:0;">
		<div class="partyBox mb-3" style="width:100%;">
			<div class="title">
				<h3>자기소개</h3>
			</div>
			<div id="partyInfoDiv" class="partyInfos">
				<p id="piExpdat">모임날짜 </p>
				<p id="piMeetingTime">모임시간 </p>
				<p id="piProfile"> "  </p>
			</div>
		</div>
		<div class="noticeWrap" style="width:100%;">
			<div class="title">
				<h3>알림장</h3>
			</div>
			<div class="noticeBox">
				<div id="noticeList" class="noticeList"></div>
				<div class="inputNoticeBox" id="inputNoticeBox" style="display:none;" >
					<div class="inputNotice" id="pnContent" contenteditable="true" ></div>
					<button class="btn btn-outline-primary btn-pd " onclick="insertNotice()">등록</button>
				</div>
			</div>
		</div>
		<div class="commentWrap" style="width:100%;">
			<div class="title">
				<h3> 소근소근</h3>
			</div>
			<div class="commentBox">
				<div id="commentList" class="commentList"></div>
				<div class="inputCommentBox" id="inputCommentBox" style="display:none;">
					<div id="inputComment" class="inputComment form-control" contenteditable="true"></div><br>
				</div>
				<div class="row">
					<div class="w-50">
						<button class="btn btn-outline-primary btn-pd" onclick="insertPartyComment()" style="display:flex; justify-content:flex-start;">등록</button>
					</div>
					<div class="w-50">
						<div class="paging" ><ul class="pagination" style="list-style:none; display:flex; justify-content:flex-end;"></ul></div>
					</div>
				</div>
			</div>
		</div>
		<div id="membersDiv" style="display:none; border:1px solid; width:300px; height:200px; overflow-x:hidden;">
			<button onclick="closeMembersDiv()" style="float:right;">닫기</button>
			<div id="memberInfosDiv">
				<table>
					<tbody id="memberTbody" style="display:none">
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>
</div>
</section>
<script>
const partyBtn = document.getElementById('partyBtn');

window.addEventListener('load', async function() {
	await getPartyInfos();
	await checkPartyLikeInfo();
	await getPartyLikeCnt();
	if ('${memberAuth.pmActive}' == 1) {
		await getPartyNotice();
		await getPartyComment();
		document.getElementById('inputCommentBox').style.display='';
	}
});

function changePartyBtn(text, btnClass, clickEvent) {
	partyBtn.innerText = text;
	partyBtn.setAttribute('class', 'btn btn-' + btnClass);
	partyBtn.addEventListener('click', clickEvent);
}

const party = {};

// 소소모임 정보 받아오기
async function getPartyInfos(){
	const partyInfoResponse = await fetch('/party-info/${param.piNum}');
	if (!partyInfoResponse.ok) {
		const errorResult = await partyInfoResponse.json();
		alert(errorResult.message);
		return;
	}
	const partyInfo = await partyInfoResponse.json();
	for (const key of Object.keys(partyInfo)) {
		const value = partyInfo[key];
		if (value != null) {
			party[key] = partyInfo[key];
		}
	}
	fillPartyInfos();
}

// 소소모임 정보 채우기
async function fillPartyInfos() {
	document.getElementById('mntnm').innerText = party.mntnm;
	document.getElementById('piName').innerText = '"' + party.piName + '"';
	document.getElementById('uiNickname').insertAdjacentHTML('beforeend', '<b>' + party.uiNickname + '</b>');
	document.getElementById('piMember').insertAdjacentHTML('beforeend', '<b>' + party.memNum + " </b>/ " + party.piMemberCnt);
	document.getElementById('piExpdat').insertAdjacentHTML('beforeend', '&nbsp<b>' + party.piExpdat + '</b>');
	document.getElementById('piMeetingTime').insertAdjacentHTML('beforeend', '&nbsp<b>' + party.piMeetingTime + '</b>');
	document.getElementById('piProfile').innerText += party.piProfile + " \"";
	document.getElementById('piIcon').src = '/resources/images/party/' + party.piIcon + '.png';
	if(party.piComplete === 1) {
		if ('${memberAuth.pmActive}' != 1) {
			changePartyBtn('완료', 'secondary', function() {
				alert('모집완료된 소소모임입니다 T_T');
			});
			return;
		}
	}
	if ('${memberAuth.pmActive}' == 1) {
		if ('${memberAuth.pmGrade}' == 1) {
			changePartyBtn('관리', 'primary', function() {
				location.href = '/views/party/edit?piNum=${param.piNum}';
			});
			document.getElementById('inputNoticeBox').style.display='';
			return;
		}
		changePartyBtn('탈퇴', 'secondary', quitParty);
		return;
	}
	changePartyBtn('가입', 'primary', joinParty);
}

const membersDiv = document.getElementById('membersDiv');
const memberTbody = document.getElementById('memberTbody');

// 부원 정보 불러오기
async function getMemberInfos() {
	membersDiv.style.display = '';
	if (memberTbody.style.display != 'none') {
		console.log('이미 정보 가져왔다!');
		return;
	}
	
	let html = '';
	const membersResponse = await fetch('/party-info/members/${param.piNum}');
	memberTbody.style.display = '';
	if (!membersResponse.ok) {
		const errorResult = await membersResponse.json();
		console.log(errorResult);
		html += '<p>' + errorResult.message + '</p>';
		document.getElementById('memberInfosDiv').insertAdjacentHTML('beforeend', html);
		return;
	}
	const members = await membersResponse.json();
	console.log(members);
	for (const member of members) {
		html += '<tr>';
		if (member.pmGrade === 1) {
			html += '<td>  ★  </td>'
		} else {
			html += '<td>    </td>'
		}
		html += '<td>  ' + member.uiImgPath + '  </td>';
		html += '<td>  ' + member.uiNickname + '  </td>';
		html += '<td>  ' + member.uiAge + '  </td>';
		html += '<td>  ' + member.uiGender + '  </td>';
		html += '</tr>';
	}
	memberTbody.insertAdjacentHTML('beforeend', html);
}

function closeMembersDiv() {
	membersDiv.style.display = 'none';
	memberTbody.style.display = 'none';
}

const likeBtnImg = document.querySelector("#likeBtn img");
const likeInfoDiv = document.getElementById('likeInfo');
let likeInfo = 0;
const likeCntDiv = document.getElementById('likeCnt');

// 좋아요 되어 있는지 체크
async function checkPartyLikeInfo() {
	const likeInfoResponse = await fetch('/party-like/check/${param.piNum}');
	if (!likeInfoResponse.ok) {
		const errorResult = await likeInfoResponse.json();
		alert(errorResult.message);
		return;
	}
	const likeInfoResult = await likeInfoResponse.json();
	if (likeInfoResult === 1) {
		changeLikeBtn(1);
		return;
	}
	changeLikeBtn(0);
	return;
}

function changeLikeBtn(likeStatus) {
	if (likeStatus === 1) {
		likeInfo = 1;
		likeInfoDiv.innerText = '♥';
		likeBtnImg.src = '/resources/images/banner/tree.png';
		return;
	}
	likeInfo = 0;
	likeBtnImg.src = '/resources/images/banner/seed.png';
	likeInfoDiv.innerText = '♡';
}

// 좋아요 개수 불러오기
async function getPartyLikeCnt() {
	const likeCntResponse = await fetch('/party-like/${param.piNum}');
	if (!likeCntResponse.ok) {
		const errorResult = await likeCntResponse.json();
		alert(errorResult.message);
		return;
	}
	const likeCntResult = await likeCntResponse.json();
	likeCntDiv.innerText = likeCntResult;
}

// 좋아요 & 좋아요 취소
async function updateLike(){
	const info = {
			piNum : ${param.piNum}
	}
	const updateResponse = await fetch('/party-like',{
		method: 'POST',
		headers: {
			'Content-Type' : 'application/json'
		},
		body: JSON.stringify(info)
	});
	if (!updateResponse.ok) {
		const errorResult = await updateResponse.json();
		alert(errorResult.message);
		return;
	}
	const updateResult = await updateResponse.json();
	if (updateResult === 1) {
		const likeStatus = (likeInfo === 1)? 0 : 1;
		changeLikeBtn(likeStatus);
		await getPartyLikeCnt();
		return;
	}
	alert('다시 시도해주세요.');
}



// 소소모임 가입
async function joinParty(){
	const joinResponse = await fetch('/party-info/members', {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json'
		},
		body: JSON.stringify({
			piNum: ${param.piNum}
		})
	});
	if (!joinResponse.ok) {
		const errorResult = await joinResponse.json();
		alert(errorResult.message);
		return;
	}
	const joinResult = await joinResponse.text();
	alert(party.piName + ' ' + joinResult);
	location.reload();
}

// 소소모임 탈퇴
async function quitParty(){
	const check = confirm(party.piName + ' ' + '소소모임을 탈퇴하시겠습니까?');
	if (check) {
		const quitResponse = await fetch('/party-member?piNum=${param.piNum}',{
			method: 'DELETE',
			headers: {
				'Content-Type': 'application/json'
			}
		});
		if (!quitResponse.ok) {
			const errorResult = await quitResponse.json();
			alert(errorResult.message);
			return;
		}
		const quitResult = await quitResponse.json();
		if(quitResult === true){
			alert(party.piName + ' ' + '소소모임을 탈퇴하였습니다.');
			location.href='/views/party/main';
			return;
		}
		alert('다시 시도해주세요.');
	}
}

// 알림장 내용 가져오기
async function getPartyNotice(){
	const noticeResponse = await fetch('/party-member/notice?piNum=${param.piNum}');
	if (!noticeResponse.ok) {
		const errorResult = await noticeResponse.json();
		alert(errorResult.message);
		return;
	}
	const noticeList = await noticeResponse.json();
	fillPartyNotices(noticeList);
}

// 알림장 내용 채우기
function fillPartyNotices(noticeList) {
	let html = '';
	for(const notice of noticeList){
		html += '<div class="fixed">[' + notice.pnCredat +'] </div>';	
		html += '<div disabled class="mt-3" style="overflow:hidden; word-break:break-all;" id="notice'+ notice.pnNum +'" >' + notice.pnContent
		if('${memberAuth.pmGrade}' == 1){
			html += '&nbsp&nbsp&nbsp<button class="btn btn-outline-primary btn-pd" onclick="updateNotice('+notice.pnNum+', this)">수정</button>&nbsp<button class="btn btn-outline-primary btn-pd" onclick="deleteNotice('+notice.pnNum+')">삭제</button>'; 
		}
		html += '</div><hr><br>';
	}
	document.getElementById('noticeList').insertAdjacentHTML('beforeend', html);
}

// 알림장에 공지 등록(최대10개)
async function insertNotice() {
	const notice = {
			pnContent : document.getElementById('pnContent').innerText
	};
	const insertResponse = await fetch('/captain/party-notice?piNum=${param.piNum}', {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json'
		},
		body: JSON.stringify(notice)
	});
	if (!insertResponse.ok) {
		const errorResult = await insertResponse.json();
		alert(errorResult.message);
		return;
	}
	const insertResult = await insertResponse.text();
	alert(insertResult);
	location.reload();
}

// 알림장 공지 수정
async function updateNotice(pnNum, obj) {
	const notice = document.getElementById('notice'+pnNum);
	notice.style.border = '1px solid';
	notice.readOnly = false;
	obj.innerText = "확인";
	obj.addEventListener('click', async function(){
		const updateResponse = await fetch('/captain/party-notice/'+pnNum + '?piNum=${param.piNum}', {
			method: 'PATCH',
			headers: {
				'Content-Type': 'application/json'
			},
			body: JSON.stringify({
				pnNum : pnNum,
				pnContent : notice.value
			})
		});
		if (!updateResponse.ok) {
			const errorResult = await updateResponse.json();
			alert(errorResult.message);
			return;
		}
		const updateResult = await updateResponse.json();
		if(updateResult === 1){
			alert('공지가 수정되었습니다.');
			location.reload();
			return;
		}
		alert('다시 시도해주세요');
	})
}

// 알림장 공지 삭제
async function deleteNotice(pnNum) {
	const check = confirm('공지를 삭제하시겠습니까?');
	if(check){
		const deleteResponse = await fetch('/captain/party-notice/'+pnNum + '?piNum=${param.piNum}', {
			method : 'DELETE'
		});
		if (!deleteResponse.ok) {
			const errorResult = await deleteResponse.json();
			alert(errorResult.message);
			return;
		}
		const deleteResult = await deleteResponse.json();
		if(deleteResult === 1){
			alert('공지가 삭제되었습니다.');
			location.reload();
			return;
		}
		alert('다시 시도해주세요');
	}
}

// 소근소근 내용 가져오기
let totalData; //총 데이터 수
const dataPerPage = 5; //한 페이지에 나타낼 글 수 ex)난 한 페이지에 5개만 나타내고 싶다! 그러면 5
let pageCount = 5; //페이징에 나타낼 페이지 수  ex)난 밑에 페이지 번호를 5개까지만 나타내고 6부터는 '>' 눌러서 나오게 할거다! 그럼 5
const globalCurrentPage = 1; //현재 페이지
const commentsList = []; //표시하려하는 데이터 리스트

async function getPartyComment() { //페이지가 로드가 되면서 실행이 되는 함수 24~47
	const commentsResponse = await fetch('/party-member/comments?piNum=${param.piNum}');
	if (!commentsResponse.ok) {
		const errorResult = await commentsResponse.json();
		alert(errorResult.message);
		return;
	}
	const commentsResult = await commentsResponse.json();
	for (const comments of commentsResult) {
		commentsList.push(comments);
	}
	totalData = commentsList.length;
	let html = '';
	for (const comments of commentsList) {
		html += '<div class="fixed"><b>' + commentsList[i].uiNickname + '</b></div>';	
		html += '<div disabled class="mt-3" id="comment'+ commentsList[i].pcNum +'">'+ commentsList[i].pcComment + '</div>';
		if('${userInfo.uiNum}' == comments.uiNum){
			html += '&nbsp&nbsp<button class="btn btn-outline-primary btn-pd" onclick="updatePartyComment('+commentsList[i].pcNum+', this)">수정</button>&nbsp';
			html += '<button class="btn btn-outline-primary btn-pd" onclick="deletePartyComment('+commentsList[i].pcNum+')">삭제</button>';
		}
		html += '</p><hr><br>'; 
	}
	document.getElementById("commentList").insertAdjacentHTML('beforeend', html);
}

// 소근소근 글쓰기
async function insertPartyComment(){
	const comment = {
			pcComment : document.getElementById('inputComment').innerText
	}
	const insertResponse = await fetch('/party-member/comments?piNum=${param.piNum}',{
		method: 'POST',
		headers: {
			'Content-Type': 'application/json'
		},
		body: JSON.stringify(comment)
	});
	if (!insertResponse.ok) {
		const errorResult = await insertResponse.json();
		alert(errorResult.message);
		return;
	}
	const insertResult = await insertResponse.json();
	if(insertResult === 1){
		alert('글이 등록되었습니다.');
		location.reload();
		return;
	}
	alert('다시 시도해주세요!');
}

//소근소근 글 수정
async function updatePartyComment(pcNum, obj){
	const commentObj = document.getElementById('comment'+pcNum);
	commentObj.style.border = '1px solid';
	commentObj.readOnly = false;
	obj.innerText = '확인';
	obj.addEventListener('click', async function(){
		const updateResponse = await fetch('/party-member/comments/' + pcNum + '?piNum=${param.piNum}',{
			method: 'PATCH',
			headers: {
				'Content-Type': 'application/json'
			},
			body: JSON.stringify({
				pcComment : commentObj.value
			})
		});
		if (!updateResponse.ok) {
			const errorResult = await updateResponse.json();
			alert(errorResult.message);
			return;
		}
		const updateResult = await updateResponse.json();
		if(updateResult === 1){
			alert('글이 수정되었습니다.');
			location.reload();
			return;
		}
		alert('다시 시도해주세요!');
	});
}

// 소근소근 글 삭제
async function deletePartyComment(pcNum){
	const check = confirm('글을 삭제하시겠습니까?');	
	if (check) {
		const deleteResponse = await fetch('/party-member/comments/' + pcNum + '?piNum=${param.piNum}',{
			method: 'DELETE',
		});
		if (!deleteResponse.ok) {
			const errorResult = await deleteResponse.json();
			alert(errorResult.message);
			return;
		}
		const deleteResult = await deleteResponse.json();
		if (deleteResult === 1) {
			alert('글이 삭제되었습니다.');
			location.reload();
			return;
		}
		alert('다시 시도해주세요');
	}
}

</script>
</body>
</html>
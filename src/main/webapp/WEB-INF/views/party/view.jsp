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
<div class="totalWrap">
	<div class="leftWrap">
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
					<div id="likeCnt"></div>
				</div>
				<br>	
			</div>
		</div>
		<br>
		<button id="partyBtn"></button>
	</div>
	
	<div class="rightWrap">
		<div class="partyBox">
			<div class="title">
				<h3>우리는</h3>
			</div>
			<div id="partyInfoDiv" class="partyInfos">
				<p id="piExpdat">모임날짜 </p>
				<p id="piMeetingTime">모임시간 </p>
				<p id="piProfile"> "  </p>
			</div>
		</div>
		<div class="noticeWrap">
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
		<br>
		<div class="commentWrap">
			<div class="title">
				<h3> 소근소근</h3>
			</div>
			<div class="commentBox">
				<div id="commentList" class="commentList"></div>
				<div class="inputCommentBox" id="inputCommentBox" style="display:none;">
					<div id="inputComment" class="inputComment" contenteditable="true"></div><br>
					<button class="btn btn-outline-primary btn-pd" onclick="insertPartyComment()">등록</button>
				</div>
				<div class="paging" ><ul class="pagination" style="list-style:none;"></ul></div>
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
<script>
const partyBtn = document.querySelector('#partyBtn');

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
	document.getElementById('piExpdat').insertAdjacentHTML('beforeend', '<b>' + party.piExpdat + '</b>');
	document.getElementById('piMeetingTime').insertAdjacentHTML('beforeend', '<b>' + party.piMeetingTime + '</b>');
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
		html += '<textarea class="textareaNotice" cols="40" rows="1" id="notice'+ notice.pnNum +'" readonly>' + notice.pnContent + '</textarea>';
		if('${memberAuth.pmGrade}' == 1){
			html += '<button class="btn btn-outline-primary btn-pd" onclick="updateNotice('+notice.pnNum+', this)">수정</button><button class="btn btn-outline-primary btn-pd" onclick="deleteNotice('+notice.pnNum+')">삭제</button>'; 
		}
		html += '<hr><br>';
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
		alert('댓글이 등록되었습니다.');
		location.reload();
		return;
	}
	alert('다시 시도해주세요!');
}

//소근소근 글 수정
async function updatePartyComment(pcNum, obj){
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
async function deletePartyComment(pcNum){
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
async function getPartyLikeCnt(){
	fetch('/party-like-cnt/${param.piNum}')
	.then(response => response.json())
	.then(data=> {
		if(data != null){
			let html = '';
			html += '♥ : '+data;
			document.querySelector('#likeCnt').innerHTML = html;
		}
	});
}

//좋아요 되어있는지 체크
async function checkPartyLikeInfo(){
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
			document.querySelector("#likeBtn img").src = '/resources/images/banner/tree.png';
			return;
		}
		document.querySelector("#likeBtn img").src = '/resources/images/banner/seed.png';
		return;
	})
}

//좋아요 등록
async function updateLike(){
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

// 부원 정보
async function getMemberInfos() {
	document.querySelector('#membersDiv').style.display = '';
	
	if (document.querySelector('#memberTbody').style.display != 'none') {
		console.log('이미 정보 가져왔다!');
		return;
	}
	
	let html = '';
	const membersResponse = await fetch('/party-info/members/${param.piNum}');
	document.querySelector('#memberTbody').style.display = '';
	if (!membersResponse.ok) {
		const errorResult = await membersResponse.json();
		console.log(errorResult);
		html += '<p>' + errorResult.message + '</p>';
		document.querySelector('#memberInfosDiv').innerHTML = html;
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
	document.querySelector('#memberTbody').innerHTML = html;
}

function closeMembersDiv() {
	document.querySelector('#membersDiv').style.display = 'none';
	document.querySelector('#memberTbody').style.display = 'none';
}

// 소근소근 페이징
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
	displayData(1);
	paging(totalData, 1);
}

//현재 페이지(currentPage)와 페이지당 글 개수(dataPerPage) 반영
function displayData(currentPage) {
	let html = "";
	currentPage = Number(currentPage);
	//dataPerPage = Number(dataPerPage);
	let maxpnum = (currentPage - 1) * dataPerPage + dataPerPage;
	if (maxpnum > totalData) { maxpnum = totalData; } 
	for (let i = (currentPage - 1) * dataPerPage; i < maxpnum; i++) {
		html += '<div class="fixed">' + commentsList[i].uiNickname + '</div>';	
		html += '<textarea class="textareaComment" rows="1" id="comment'+ commentsList[i].pcNum +'" readonly>'
					+ commentsList[i].pcComment + '</textarea>';
		if('${userInfo.uiNum}' == commentsList[i].uiNum){
			html += '<button class="btn btn-outline-primary btn-pd" onclick="updatePartyComment('+commentsList[i].pcNum+', this)">수정</button>';
			html += '<button class="btn btn-outline-primary btn-pd" onclick="deletePartyComment('+commentsList[i].pcNum+')">삭제</button>';
		}
		html += '</p><hr><br>';
	} 
	document.getElementById("commentList").insertAdjacentHTML('beforeend', html);
}

function paging(totalData, currentPage) {
	totalPage = Math.ceil(totalData / dataPerPage); //총 페이지 수
	if (totalPage < pageCount) { pageCount = totalPage; } //이 if함수가 무슨 소리냐면 내가 가진 데이터로 나올 총 페이지수는 예를 들어 7개인데
     //나는 밑에 페이지번호가 최대 8개까지 뜨고 9부터는 '>'누르면 나오게 해놨다면
     //7 < 8 로 내가 설정한 페이지번호가 더 크기 때문에 페이지번호를 데이터로 나올 총 페이지수로 바꿔주는것
	let pageGroup = Math.ceil(currentPage / pageCount); // 페이지 그룹
	let last = pageGroup * pageCount; //화면에 보여질 마지막 페이지 번호
	if (last > totalPage) { last = totalPage; }
     //화면에 보여질 마지막 페이지 번호가 총 페이지보다 많다면
     //보여질 마지막 페이지 번호를 총 페이지로 바꾼다는 것
	let first = last - (pageCount - 1); //화면에 보여질 첫번째 페이지 번호
	let next = last + 1;
	let prev = first - 1;
	let pageHtml = "";
     //여기 pageHtml은 prev 넣을 태그를 넣으면 된다.
    pageHtml += "<li class='page-item'>";
    pageHtml += "<a class='page-link' href='#' id='prev' aria-label='Previous'>";
    pageHtml += "<span aria-hidden='true'>&laquo;</span>";
    pageHtml += "</a></li>";
	//페이징 번호 표시 
	for (let i = first; i <= last; i++) {
		if (currentPage == i) {
			pageHtml += "<li class='page-item'><a class='page-link' href='#'>" + i + "</a></li>";
    	} else {
			pageHtml += "<li class='page-item'><a class='page-link' href='#'>" + i + "</a></li>";
    	}
	}

	//여기 pageHtml에는 next 넣을 태그를 넣으면 된다.
    pageHtml += "<li class='page-item'>";
    pageHtml += "<a class='page-link' href='#' id='next' aria-label='Next'>";
	pageHtml += "<span aria-hidden='true'>&raquo;</span>";
	pageHtml += "</a></li>";
  
       //위에 pageHtml을 어디다가 삽입할건지!
	$(".pagination").html(pageHtml);

	//페이징 번호 클릭 이벤트 
	$(".pagination li a").click(function() {
    	let $id = $(this).attr("id");
    	selectedPage = $(this).text();
       
       //마지막 페이지에서 next를 또 누를 경우 빈페이지만 나오게 되는 현상이 있었음
       //next는 totalPage보다 항상 1 많게 찍혔었음
       //그래서 next - 1이 totalPage랑 같다면 selectedPage를 totalPage랑 같게 한 것
       //selectedPage는 현재 페이지라고 생각하면 된다.
    if ($id == "next") {
    	if ((next - 1) === totalPage) {
    		selectedPage = totalPage;
    	} else {
    		selectedPage = next;
    	}
    }
    if ($id == "prev") {
    	if (prev > 0) {
    		selectedPage = prev;	
    	} else if (prev == 0) {
    		selectedPage = 1;
    	}
    }
       //이게 원래 prev랑 next가 페이지 그룹이 바뀌었을 때만 생성이 되게 코드가 짜여있었음.
       //난 prev를 누르면 전 페이지, next를 누르면 다음 페이지로 가고 싶게했음
       //그래서 prev 또한 바꿔줌
       //prev는 원래 현재 페이지에서 -1이 된 값을 가지고 있음
       //그게 0이라면 selectedPage는 1이 되게
       //0보다 크다면 selectedPage가 prev값이 되게함
    
    //전역변수에 선택한 페이지 번호를 담는다...
    globalCurrentPage = selectedPage;
    //페이징 표시 재호출
    paging(totalData, selectedPage);
    //글 목록 표시 재호출
    displayData(selectedPage);
  });
}
</script>
</body>
</html>
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
<div class="leftWrap">
		<div class="partyNameBox">
			<p id="mntnm">산 : </p>
			<p id="piName" class="partyName"></p>
		</div>		
		<div class="partyIcon"></div>	
		<div id="partyInfos2" class="partyMemberBox">
			<p id="uiNickname">대장 : </p>
			<p id="piMember" onclick="getMemberInfos()">부원 : </p>
			<div id="likeBox" class="likeBox">
				<div id="likeBtn" onclick="updateLike()">
					<img src="/resources/images/banner/seed.png">
					<div id="likeCnt"></div>
				</div>
				<br>	
			</div>
		</div>	
	<br>
	<button id="partyBtn" class="btn btn-primary">가입</button>
</div>

<div class="rightWrap">
	<div class="partyBox">
		<div class="title">
			<h3>우리는</h3>
		</div>
		<div id="partyInfos" class="partyInfos">
			<p id="piExpdat">- 모임날짜 : </p>
			<p id="piMeetingTime">- 모임시간 : </p>
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
	<div id="membersDiv" style="display:none; border:1px solid; width:300px; height:200px; overflow:scroll-y;">
		<button onclick="closeSearchDiv()" style="float:right;">닫기</button>
		<div id="memberInfosDiv">
			<table>
				<tbody id="memberTbody" style="display:none">
				</tbody>
			</table>
		</div>
	</div>
</div>

<script>
const partyBtn = document.querySelector('#partyBtn');

window.onload = async function(){
	await getPartyInfos();
	getPartyLikeCnt();
	checkPartyLikeInfo();
	//getPartyMemberCount();
}

function changePartyBtn(text, clickEvent) {
	partyBtn.innerText = text;
	partyBtn.addEventListener('click', clickEvent);
}

//소모임 정보
async function getPartyInfos(){
	const partyInfoResponse = await fetch('/party-info/${param.piNum}');
	if (!partyInfoResponse.ok) {
		const errorResult = await partyInfoResponse.json();
		alert(errorResult.message);
		return;
	}
	const partyInfo = await partyInfoResponse.json();
	document.querySelector('#mntnm').innerText +=  ' ' + partyInfo.mntnm;
	document.querySelector('#piName').innerText += '"' + partyInfo.piName + '"';
	document.querySelector('#uiNickname').innerText += ' ' + partyInfo.uiNickname;
	document.querySelector('#piMember').innerText += ' ' + partyInfo.memNum + " / " + partyInfo.piMemberCnt;
	document.querySelector('#piExpdat').innerText += ' ' + partyInfo.piExpdat;
	document.querySelector('#piMeetingTime').innerText += ' ' + partyInfo.piMeetingTime;
	document.querySelector('#piProfile').innerText += partyInfo.piProfile + " \"";

	if(partyInfo.piComplete === 1) {
		partyBtn.setAttribute('class', 'btn btn-secondary');
		if ('${memberAuth.pmActive}' != 1) {
			changePartyBtn('완료', function() {
				alert('모집완료된 소소모임입니다 T_T');
			});
			return;
		}
	}
	if ('${memberAuth.pmActive}' == 1) {
		getPartyNotice();
		getPartyComment();
		document.querySelector('#inputCommentBox').style.display='';
		if ('${memberAuth.pmGrade}' == 1) {
			changePartyBtn('관리', function() {
				location.href = '/views/party/edit?piNum=${param.piNum}';
			});
			document.querySelector('#inputNoticeBox').style.display='';
			return;
		}
		changePartyBtn('탈퇴', quitParty);
		return;
	}
	changePartyBtn('가입', joinParty);
}

//소모임 가입
function joinParty(){
	/*
	const info = {
			piNum : ${param.piNum}
			uiNum : ${userInfo.uiNum}
	}
	*/
	
	fetch('/party-member?piNum=${param.piNum}', {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json'
		}
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
		fetch('/party-member/${param.piNum}',{
			method: 'DELETE',
			headers: {
				'Content-Type': 'application/json'
			}
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
			html += '<div class="fixed">[' + list[i].pnCredat +'] </div>';	
			html += '<textarea class="textareaNotice" cols="40" rows="1" id="notice'+ list[i].pnNum +'" readonly>' + list[i].pnContent + '</textarea>';
			if('${memberAuth.pmGrade}' == 1){
				html += '<button class="btn btn-outline-primary btn-pd" onclick="updateNotice('+list[i].pnNum+', this)">수정</button><button class="btn btn-outline-primary btn-pd" onclick="deleteNotice('+list[i].pnNum+')">삭제</button>'; 
			}
			html += '<hr><br>';
		}
		document.querySelector('#noticeList').innerHTML = html;
	})
}

//알림장에 공지 등록(최대10개)
function insertNotice(){
	const notice = {
			pnContent : document.querySelector('#pnContent').value
	};
	fetch('/party-notice/${param.piNum}', {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json'
		},
		body: JSON.stringify(notice)
	})
	.then(response => response.text())
	.then(result => {
			alert(result);
			location.href='/views/party/view?piNum=' + ${param.piNum};
			return;
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

//소근소근 글쓰기
function insertPartyComment(){
	const comment = {
			pcComment : document.querySelector('#inputComment').innerHTML
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
			html += '♥ : '+data;
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
			document.querySelector("#likeBtn img").src = '/resources/images/banner/tree.png';
			return;
		}
		document.querySelector("#likeBtn img").src = '/resources/images/banner/seed.png';
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

function closeSearchDiv() {
	document.querySelector('#membersDiv').style.display = 'none';
	document.querySelector('#memberTbody').style.display = 'none';
}

//소근소근 글 페이징
let totalData; //총 데이터 수
let dataPerPage; //한 페이지에 나타낼 글 수 ex)난 한 페이지에 5개만 나타내고 싶다! 그러면 5
let pageCount = 5; //페이징에 나타낼 페이지 수  ex)난 밑에 페이지 번호를 5개까지만 나타내고 6부터는 '>' 눌러서 나오게 할거다! 그럼 5
let globalCurrentPage = 1; //현재 페이지
let dataList; //표시하려하는 데이터 리스트

//현재 페이지(currentPage)와 페이지당 글 개수(dataPerPage) 반영
function displayData(currentPage, dataPerPage) {

	let html = "";

	//Number로 변환하지 않으면 아래에서 +를 할 경우 스트링 결합이 되어버림..
	currentPage = Number(currentPage);
	dataPerPage = Number(dataPerPage);

	let maxpnum=(currentPage - 1) * dataPerPage + dataPerPage; 
	if(maxpnum>totalData){maxpnum=totalData;} 

	for (
	var i = (currentPage - 1) * dataPerPage;
	i < maxpnum; 
	i++
	) { //여기에 원래 리스트에 넣어주는 값들으 넣어주면 된다. 불러오는 형식은 dataList[i].컬럼명
		
		html += '<div class="fixed">' + dataList[i].uiNickname + '</div>';	
		html += '<textarea class="textareaComment" rows="1" id="comment'+ dataList[i].pcNum +'" readonly>' + dataList[i].pcComment + '</textarea>';
		if('${userInfo.uiNum}' == dataList[i].uiNum){
			html += '<button class="btn btn-outline-primary btn-pd" onclick="updatePartyComment('+ dataList[i].pcNum+', this)">수정</button><button class="btn btn-outline-primary btn-pd" onclick="deletePartyComment('+dataList[i].pcNum+')">삭제</button>';
		}
		html += '</p><hr><br>';
		/*
		html += '<tr>'
			if(dataList[i].piComplete === 1) {
				html += '<td>' + '모집완료' + '</td></tr>'
			}
			html += '<tr><td style="color:gray;">' + dataList[i].mntnm + '</td></tr>'
			html += '<tr><td style="color:gray;">' + dataList[i].piName + '</td></tr>'
			html += '<tr><td>' + dataList[i].piExpdat + '</td></tr>'
			html += '<tr><td>' + dataList[i].piMeetingTime + '</td></tr>'
			html += '<tr><td>' + dataList[i].memNum + " / " + dataList[i].piMemberCnt + '</td></tr>'
			html+= '<hr>'
			html += '<tr></tr>'
			*/
	} 
	$("#commentList").html(html);  //여기서 저 위에있는 값들을 html에 넣어줌
}

function paging(totalData, dataPerPage, pageCount, currentPage) {
	  console.log("currentPage : " + currentPage);

	  totalPage = Math.ceil(totalData / dataPerPage); //총 페이지 수
	  
	  if(totalPage<pageCount){
	    pageCount=totalPage; 
	  } //이 if함수가 무슨 소리냐면 내가 가진 데이터로 나올 총 페이지수는 예를 들어 7개인데
      //나는 밑에 페이지번호가 최대 8개까지 뜨고 9부터는 '>'누르면 나오게 해놨다면
      //7 < 8 로 내가 설정한 페이지번호가 더 크기 때문에 페이지번호를 데이터로 나올 총 페이지수로 바꿔주는것
	  
	  let pageGroup = Math.ceil(currentPage / pageCount); // 페이지 그룹
	  let last = pageGroup * pageCount; //화면에 보여질 마지막 페이지 번호
	  
	  console.log("pagGroup=" + pageGroup);
	  console.log("totalPage=" + totalPage);
	  
	  if (last > totalPage) {
	    last = totalPage;
	  }
      //화면에 보여질 마지막 페이지 번호가 총 페이지보다 많다면
      //보여질 마지막 페이지 번호를 총 페이지로 바꾼다는 것

	  let first = last - (pageCount - 1); //화면에 보여질 첫번째 페이지 번호
	  let next = last + 1;
	  let prev = first - 1;
	  console.log("pageCount=" + pageCount);
	  console.log("first=" + first);
	  console.log("last=" + last);
	  
	  let pageHtml = "";
	  console.log("prev=" + prev);
	  console.log("next=" + next);
	  
      //여기 pageHtml은 prev 넣을 태그를 넣으면 된다.
	    pageHtml += "<li class='page-item'>";
	    pageHtml += "<a class='page-link' href='#' id='prev' aria-label='Previous'>";
        pageHtml += "<span aria-hidden='true'>&laquo;</span>";
      	pageHtml += "</a></li>";
	  

	 //페이징 번호 표시 
	  for (var i = first; i <= last; i++) {
	    if (currentPage == i) {
	      pageHtml +=
	        "<li class='page-item'><a class='page-link' href='#'>" + i + "</a></li>";
	    } else {
	      pageHtml += "<li class='page-item'><a class='page-link' href='#'>" + i + "</a></li>";
	    }
	  }

	  //여기 pageHtml에는 next 넣을 태그를 넣으면 된다.
	    pageHtml += "<li class='page-item'>"
	    pageHtml += "<a class='page-link' href='#' id='next' aria-label='Next'>"
        pageHtml += "<span aria-hidden='true'>&raquo;</span>"
        pageHtml += "</a></li>"
	  
        //위에 pageHtml을 어디다가 삽입할건지!
	  $(".pagination").html(pageHtml);

	  //페이징 번호 클릭 이벤트 
	  $(".pagination li a").click(function () {
	    let $id = $(this).attr("id");
	    selectedPage = $(this).text();
	    console.log("selectedPage=" + selectedPage);
        
        //마지막 페이지에서 next를 또 누를 경우 빈페이지만 나오게 되는 현상이 있었음
        //next는 totalPage보다 항상 1 많게 찍혔었음
        //그래서 next - 1이 totalPage랑 같다면 selectedPage를 totalPage랑 같게 한 것
        //selectedPage는 현재 페이지라고 생각하면 된다.
	    if ($id == "next") {
	    	 console.log("selectedPage2=" + selectedPage);
	    	 console.log("totalPage2=" + totalPage);
	    	if((next - 1) === totalPage) {
	    		selectedPage = totalPage;
	    	}else {
	    		selectedPage = next;
	    	}
	    }
	    if ($id == "prev") {
	    	if(prev > 0) {
	    		selectedPage = prev;	
	    	}else if(prev == 0) {
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
	    paging(totalData, dataPerPage, pageCount, selectedPage);
	    //글 목록 표시 재호출
	    displayData(selectedPage, dataPerPage);
	  });
	}

function getPartyComment() { //페이지가 로드가 되면서 실행이 되는 함수 24~47
	//dataPerPage 선택값 가져오기
		dataPerPage = 5;    //위에서 선언한 한 페이지에 나타낼 글 수를 여기서 값 설정해줌! 글 수 바꾸고 싶다면 여기서 설정하면 된다.
		
		$.ajax({ // ajax로 데이터 가져오기(기존에 쓰던 fetch처럼 쓰면 된다. 여기선 데이터 불러오는 코드 작성하면 된다.)
		method: "GET",  //메소드명
		url: "/party-comments/${param.piNum}?includeComplete=true",    //데이터 불러오는 코드 컨트롤러 주소
		dataType: "json",   //데이터타입은 json으로 나와야해서 이건 변경할 필요 없음
		success: function (d) { //값을 성공적으로 불러온다면 저 d라는 곳에 값이 담길 예정임
		console.log(d);
	        //여기서 console.log(d)를 찍어보면 값이 나오는게 확인이 되어야함!!
	        //성공적으로 값을 불러왔다면 d에 리스트가 찍혀야 함.
	        //console.log(d) 찍을 때 45라인과 48라인은 꼭 주석처리해줘야함
	        //저 함수는 밑에서 추가로 선언을 해야하는 함수들이라 오류남.
	    
		dataList=d; //dataList에 결과 담음
		
		//totalData(총 데이터 수) 구하기
		totalData = d.length;
		
		//글 목록 표시 호출 (테이블 생성)
		displayData(1, dataPerPage);    //밑에서 추가로 선언할 함수

		//페이징 표시 호출
		paging(totalData, dataPerPage, pageCount, 1);   //밑에서 추가로 선언할 함수
		}
	})

}
</script>
</body>
</html>
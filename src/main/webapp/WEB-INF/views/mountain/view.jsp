<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>산</title>
<%@ include file="/resources/common/header.jsp"%>
<link href="/resources/css/style1.css" rel="stylesheet" type="text/css">
<link href="/resources/css/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${kakaoMapKey}&libraries=services,clusterer,drawing"></script>
</head>
<body>
<div id="mountainPageWrap"
	style="width: 80%; margin: 5rem 0 3rem 0; padding: 2rem 2rem 2rem 2rem; position: absolute; text-align: center; border: solid; left: 10%; min-width: 34.5rem">
	<!-- header -->
	<div id="mountainHeaderWrap">
		<div id="mountainInfoWrap" style="width: 30rem; padding: 1rem 1rem 1rem 1rem; float: left; display: inline-block;">
			<div id="likeWrap"
				style="width: 50px; position: absolute; height: 30px; cursor: pointer; z-index: 99;">
				<div id="mountainLike"
					style="width: 50px; height: 50px; position: relative; float: left"
					onclick="setMountainLike()">
					<img src="/resources/images/user/empty-heart.png">
				</div>
				<div id="likeCount"
					style="width: 50px; height: 30px; position: relative; float: left"></div>
			</div>
			<div id="mountainName" style="width: 100%;"></div>
			<div id="mountainSubTitle" style="width: 100%;"></div>
			<div id="mountainImg"
				style="width: 100%; height: 400px; overflow: hidden; margin-bottom: 0.25rem">
			</div>
			<div id="heightWrap"
				style="width: 100%; display: inline-block; float: left;">
				<div style="width: 20%; float: left;">높이</div>
				<div id="mountainHeight"
					style="width: 80%; float: left; text-align: left;"></div>
			</div>
			<div id="areaWrap"
				style="width: 100%; display: inline-block; float: left; margin: 0.25rem auto">
				<div style="width: 20%; float: left;">지역</div>
				<div id="mountainArea"
					style="width: 80%; float: left; text-align: left;"></div>
			</div>
		</div>

		<div id="envirmentWrap" style="float: right">
			<div id="map" style="width: 30rem; height: 30rem;"></div>
			<div id="weatherWrap"
				style="width: 100%; display: flex;  align-items: center; justify-content: center;">
				<img id="weatherIcon" style="width: 15%; height: 15%; object-fit: fill;">
				<div id="weatherDiv"
					style="width: 60%; margin-left: 0.25rem; text-align: left; vertical-align: middle;"></div>
			</div>
		</div>
	</div>

	<!-- article -->
	<div id="mountainInfoArticleWrap" style="position: relative; clear: both; margin: 0 auto;  margin-top:20px;">
		<div id="mountainInfoListWrap">
			<div id="mountainInfoList">
				<div id="mountainReason" class="service-item">
					<div onclick="toggleContent(this)" style="width:100%;border:solid; border-width:1px; cursor: pointer;"><h4>100대 명산 선정이유</h4></div>
					<div class="contents" style="display:none; padding: 50px 50px 50px 50px"></div>
				</div>
				<div id="mountainDetails" class="service-item">
					<div onclick="toggleContent(this)" style="width:100%;border:solid; border-width:1px;cursor: pointer;"><h4>세부정보</h4></div>
					<div class="contents" style="display:none;  padding: 50px 50px 50px 50px"></div>
				</div>
				<div id="mountainOverview" class="service-item">
					<div onclick="toggleContent(this)" style="width:100%;border:solid; border-width:1px;cursor: pointer;"><h4>산 요약</h4></div>
					<div class="contents" style="display:none; padding: 50px 50px 50px 50px"></div>
				</div>
				<div id="mountainEtcCourse" class="service-item">
					<div onclick="toggleContent(this)" style="width:100%;border:solid; border-width:1px;cursor: pointer;"><h4>등산코스</h4></div>
					<div class="contents" style="display:none; padding: 50px 50px 50px 50px"></div>
				</div>
				<div id="mountainTourism" class="service-item">
					<div onclick="toggleContent(this)" style="width:100%;border:solid; border-width:1px;cursor: pointer;"><h4>숙식 및 기타정보 / 이용문의</h4></div>
					<div class="contents" style="display:none; padding: 50px 50px 50px 50px"></div>
				</div>
				<div id="mountainTransport" class="service-item">
					<div onclick="toggleContent(this)" style="width:100%;border:solid; border-width:1px;cursor: pointer;"><h4>대중교통정보</h4></div>
					<div class="contents" style="display:none; padding: 50px 50px 50px 50px"></div>
				</div>
			</div>
		</div>
		<div id="partyOfMountainWrap">
			<div id="partyTitleWrap" class="service-item" style="width:100%; border:solid; border-width:1px;  cursor:pointer; margin-top:20px;" onclick="toggleContent(this)"><h4>소소모임</h4></div>
			<div id="partyDivBody" class="contents" style="display:none; padding:50px 50px 50px 50px"></div>
		</div>
		<div id="mountainCommentWrap" style="display: block; clear:both; margin-top:20px;" >
			<div id="mountainComment">
				<div id="commentDivBody" style="diplay:block; align:center;"></div>
				<c:if test="${userInfo ne null}">
					<div id="mountainCommentInsertWrap" style="clear:both; display: flex; align-items: center; justify-content: center;">
						<textarea id="montainCommentory" rows="5" cols="50"
							style="resize: none;"></textarea>
						<button onclick="insertMountainComment()" style="margin-left:10px">등록</button>
					</div>
				</c:if>
			</div>
		</div>
	</div>
</div>
	
<script>
window.addEventListener('load', async function(){
	await getSelectedMountainInfo();
});

//sibling div class(.contents) display toggle
function toggleContent(obj){
	const divObj = obj;
	const divParent = divObj.parentNode;
	const divContent = divParent.getElementsByClassName("contents")[0];
	
	if(divContent.style.display==='none'){
		divObj.style.backgroundColor = '#EAEAEA';
		divContent.style.display='block';
	} else {
		divObj.style.backgroundColor = '';
		divContent.style.display='none';
	}
	return;
}

//선택한 산의 정보를 불러오기
function getSelectedMountainInfo(){	
	const mountainURL = '/mountain/' + '${param.miNum}';
	
	fetch(mountainURL)
	.then(function(res){
		return res.json();
	})
	.then(async function(mountainInfo){
		if(mountainInfo!==null){
			/* header part*/
			document.querySelector("title").innerText = mountainInfo.mntnm;
			document.querySelector("#mountainName").innerHTML = '<h1>' + mountainInfo.mntnm + '</h1>'; // 산이름
			document.querySelector("#mountainArea").innerHTML = '<p>' + mountainInfo.areanm + '</p>'// 산지역명
			document.querySelector("#mountainHeight").innerText =  mountainInfo.mntheight + 'm'; // 산높이
			document.querySelector("#mountainSubTitle").innerHTML = '<p>' + mountainInfo.subnm + '</p>'; // 산 부제
			document.querySelector("#mountainImg").innerHTML = '<img style="width:100%; height:100%; object-fit:fill;" src="'
															 + mountainInfo.mntnattchimageseq + '"'
															 + ' onerror="this.src=\'/resources/images/mountain/mountain-no-img.png\'">'; // 산이미지 url
 
			/* article part*/
 			document.querySelector("#mountainReason .contents").innerHTML = '<div class="aeatreason" align="left">' + mountainInfo.aeatreason + '</div>'; // 100대산 선정 이유
			document.querySelector("#mountainDetails .contents").innerHTML = '<div class="details" align="left">' + mountainInfo.details + '</div>'; // 세부설명
			document.querySelector("#mountainEtcCourse .contents").innerHTML =  '<div class="etccourse" align="left">' + mountainInfo.etccourse + '</div>'; // 기타코스
			document.querySelector("#mountainOverview .contents").innerHTML = '<div class="overview" align="left">' + mountainInfo.overview + '</div>'; // 요약
			document.querySelector("#mountainTourism .contents").innerHTML =  '<div class="tourisminf" align="left">' + mountainInfo.tourisminf + '</div>'; // 주변관광정보
			document.querySelector("#mountainTransport .contents").innerHTML =  '<div class="transport" align="left">' + mountainInfo.transport + '</div>'; // 교통정보
			
			let mountainPlace = {
					x : mountainInfo.lot, // 산 데이터 경도
					y : mountainInfo.lat, // 산 데이터 위도
					place_name : mountainInfo.mntnm // 산 이름
			} // 산 위치 관련 정보를 저장한 구조체

			await getLikesMountain(mountainInfo.miNum);
			await getMountainComments(mountainInfo.miNum);
			await getPartyOfMountain(mountainPlace.place_name);
			
			if('${userInfo}'!==''){ // 로그인 안되있으면 실행x
				checkMountainLike('${userInfo.uiNum}', mountainInfo.miNum);
			}
			
			const keyword = '100대명산 ' + mountainPlace.place_name; // '100대명산'을 명시해줘야 다른 키워드가 붙지 않음(xx산 음식점 등)
			
			if(mountainPlace.x===0 || mountainPlace.y==0){ // 둘중 하나라도 0이면 좌표값을 불러오지 못했거나 없는것. 좌표값이 없을 경우 키워드 검색으로 이동
	//			alert('아이고 좌표가 없네');
				ps.keywordSearch(keyword, placesSearchCB); // 카카오맵 키워드 검색
			} else{
				setCenter(mountainPlace.y, mountainPlace.x); // 좌표 기준 중앙정렬
				displayMarker(mountainPlace); // 마커생성
			}
			await getWeather(mountainPlace.y, mountainPlace.x, '${openWeatherMapAPI}');
		}
	});
}

//산의 소소모임 불러오기
function getPartyOfMountain(mountainName){
	const PartyOfMountainURL = '/party-infos/mountain/';
	
	fetch(PartyOfMountainURL + mountainName)
	.then(function(res){
		return res.json();
	})
	.then(function(parties){
		if(parties!==null){
//			console.log(parties);
			let html='';
			if(parties.length===0){
				html += '<p>' + '해당 산의 소소모임이 없습니다.' + '</p>'
			} else {
				for(const party of parties){
						html += '<div class="partyDiv service-item" style="width:200px; height:200px; border:solid; cursor:pointer; margin:5px 5px 5px 5px auto; display:inline-block;" onclick="location.href=\'/views/party/view?piNum=' + party.piNum + '\'">'
 						html += '<p class="piName">' + party.piName + '<p>';
						html += '<p class="memberCount"> 인원' + '<br>' + party.memNum + '/' + party.piMemberCnt + '<p>';
						//html += '<p class="piCredat"> 모임생성일자: ' + party.piCredat + '</p>';
						html += '<p class="piMeetingDate"> 모임일자' + '<br>' + party.piExpdat + '/' + party.piMeetingTime + '</p>';
						html += '<p class="piProfile"> 소개' + '<br>' + party.piProfile + '</p>';
						html += '</div>'
				}
			}
			document.querySelector("#partyDivBody").insertAdjacentHTML('afterbegin',html);
		}
	});
}

//산 좋아요 수 체크
function getLikesMountain(mountainNum){
	const mountainLikeURL = '/mountain-like/';
	
	fetch(mountainLikeURL + mountainNum)
	.then(function(res){
		return res.json();
	})
	.then(function(cnt){
		if(cnt!==null){
			let html='';
//			console.log(cnt);
			html += '<h5>' + cnt + '</h5>'
			document.querySelector('#likeCount').innerHTML = html;
		}
	});
}

//산코멘트 불러오기
function getMountainComments(mountainNum){
	const mountainCommentURI = '/mountain-comment/';
	
	fetch(mountainCommentURI + mountainNum)
	.then(function(res){
		return res.json();
	})
	.then(async function(comments){
		if(comments!==null){
			let html='';
			
			if(comments.length===0){
				html += '<p> ' + '댓글이 없습니다.' + '<br>' + '처음으로 글을 남겨보세요!' + '</p>';
			} else {
				for(const comment of comments){
					html += '<div class="commentDiv" style="width:550px; height:200px; margin:0 auto; padding-top: 10px;">'
//						html += '<p class="mcNum" style="display:none"> 글번호: ' + comment.mcNum + '<p>';
//						html += '<p class="uiNum" style="display:none"> 회원번호: ' + comment.uiNum + '<p>';
					html += '<div class="profileWrap" style="width:100px; height:120px; display:inline-block;">'
					html += '<div class="imgDiv" style="width:40px; height:40px; overflow:hidden; margin:0 auto;">';
					html += '<img class="uiImgPath" style="width:100%; height:100%; object-fit:fill; margin:0 auto;" src="'
					     + comment.uiImgPath + '" onerror="this.src=\'/resources/images/user/user-base-img.png\'">';
					html += '</div>'
					html += '<div class="nickNameDiv" style="width:99%; margin:0 auto;">';
					html += '<p class="niNickname" style="width:99%; margin-bottom:5px;">' + comment.uiNickname + '</p>';
					html += '</div>'
					html += '<div class="dateDiv" style="width:99%; margin:0 auto; margin-bottom:5px;">';
					html += '<p class="commentDate" style="margin-bottom:5px;">' + comment.mcLmodat + '</p>';
					html += '</div>'
					html += '<div class="commentButtonWrap" sytle="display:none;" data-uiNum="' + comment.uiNum + '" >'
					html += '<button type="button" class="commentChange" data-uiNum="' + comment.uiNum + '" data-mcNum="' + comment.mcNum +'">수정' + '</button>';
					html += '<button type="button" class="commentDelete" data-uiNum="' + comment.uiNum + '" data-mcNum="' + comment.mcNum +'">삭제' + '</button>';
					html += '</div>'
					html += '</div>'
					html += '<textarea class="mcComment' + comment.uiNum + '" name="comment" rows="5" cols="45" style="resize:none; border:none; padding:5px 0 0 5px; margin-top:40px;" disabled>' + comment.mcComment + '</textarea>';
					html += '</div>'
				}
			}
				document.querySelector("#commentDivBody").innerHTML = html;
				
				await setCommentButtonEvent();
				await setButtonVisiable();
		}
	});
}

//버튼이벤트 등록
function setCommentButtonEvent(){
	const changeButtons = document.querySelectorAll(".commentChange");
//	console.log(changeButtons);
	
	for(const changeButton of changeButtons){
		changeButton.addEventListener('click', updateMountainComment);
	}
	const deleteButtons = document.querySelectorAll(".commentDelete");
	for(const deleteButton of deleteButtons){
		deleteButton.addEventListener('click', deleteMountainComment);
	}
}

//버튼 표시
function setButtonVisiable(){
	const buttonWraps = document.querySelectorAll(".commentButtonWrap");
	
	for(const buttonWrap of buttonWraps){
//		console.log(buttonWrap.getAttribute("data-uiNum"));
		if(buttonWrap.getAttribute("data-uiNum")=='${userInfo.uiNum}'){
			buttonWrap.style.display="";
		} else {
			buttonWrap.style.display="none";
		}
	}
}

//좋아요 수 체크
function checkMountainLike(uiNum, miNum){
	checkMountainLikeURL = '/mountain-like/check';
	
	const checkLikeParam = {
		uiNum: uiNum,
		miNum: miNum
	};
	
	fetch(checkMountainLikeURL,{
		method: 'POST',
		headers: {
			'Content-Type': 'application/json'
		},
		body: JSON.stringify(checkLikeParam)
	})
	.then(function(response){
			return response.json();
	})
	.then(result => {
		if(result===1){
//			console.log(result);
			document.querySelector("#mountainLike img").src = '/resources/images/user/red-heart.png';
			return;
		} 
		document.querySelector("#mountainLike img").src = '/resources/images/user/empty-heart.png';
		return;
	})
}

//좋아요 설정(클릭)
function setMountainLike(){
	const setMountainLikeURL = '/mountain-like/set'
	uiNum = '${userInfo.uiNum}';
	miNum = '${param.miNum}';
	
	const checkLikeParam = {
		uiNum: uiNum,
		miNum: miNum
	};
	
	fetch(setMountainLikeURL,{
		method: 'POST',
		headers: {
			'Content-Type': 'application/json'
		},
		body: JSON.stringify(checkLikeParam)
	})
	.then(function(response){
		return response.json();
	})
	.then(result => {
		if(result===1){
			checkMountainLike(uiNum, miNum);
			getLikesMountain(miNum);
		}
	});
}

//산 코멘트 입력
function insertMountainComment(){
	const insertMountainCommentURI = '/mountain-comment';
	const insertParam = {
		miNum : '${param.miNum}',
		uiNum : '${userInfo.uiNum}',
		mcComment : document.querySelector("#montainCommentory").value
	};
	
	//--validation--//
	if(insertParam.mcComment.trim().length>300){
		alert('코멘트는 300자 이하');
		document.querySelector("#montainCommentory").focus();
		return;
	}
	
	if(insertParam.mcComment.trim().length===0){
		alert('내용을 입력하세요');
		document.querySelector("#montainCommentory").focus();
		return;
	}	
	//--validation end--//
	
	fetch(insertMountainCommentURI,{
		method: 'PUT',
		headers: {
			'Content-Type': 'application/json'
		},
		body: JSON.stringify(insertParam)
	})
	.then(function(response){
			return response.json();
	})
	.then(result => {
		if(result === 1){
			alert('댓글 등록완료');
			document.querySelector("#montainCommentory").value = '';
			getMountainComments(insertParam.miNum);
			return;
		}
		alert('댓글 등록실패');
	});
}

// 코멘트 수정
function updateMountainComment(){
	const updateMountainCommentURI = '/mountain-comment/update';
	const uiNum = this.getAttribute("data-uiNum");
	const mcNum = this.getAttribute("data-mcNum");
	
//	console.log(document.querySelector(".mcComment"+uiNum));
	document.querySelector('.mcComment'+uiNum).style.border = '1px solid';
	document.querySelector('.mcComment'+uiNum).disabled = false;
	
	this.innerText = "확인"
	
	this.addEventListener('click', function(){
		const updateParam = {
				miNum : '${param.miNum}',
				uiNum : uiNum,
				mcNum : mcNum,
				mcComment : document.querySelector('.mcComment'+uiNum).value
		};
		
		//--validation--//
		if(updateParam.mcComment.trim().length>300){
			alert('코멘트는 300자 이하');
			document.querySelector("#montainCommentory").focus();
			return;
		}
		
		if(updateParam.mcComment.trim().length===0){
			alert('내용을 입력하세요');
			document.querySelector("#montainCommentory").focus();
			return;
		}	
		//--validation end--//
		
		fetch(updateMountainCommentURI,{
			method: 'PATCH',
			headers: {
				'Content-Type': 'application/json'
			},
			body: JSON.stringify(updateParam)
		})
		.then(function(response){
				return response.json();
		})
		.then(result => {
			if(result === 1){
				alert('댓글 수정완료');
				getMountainComments(updateParam.miNum);
				return;
			}
			alert('댓글 수정실패');
		});
	});
}

// 산 코멘트 삭제(비활성화)
function deleteMountainComment(){
	const deleteMountainCommentURI = '/mountain-comment/delete';
	const uiNum = this.getAttribute("data-uiNum");
	const mcNum = this.getAttribute("data-mcNum");
	
/* 	console.log(uiNum);
	console.log(mcNum); */
	
	const deleteParam = {
		miNum : '${param.miNum}',
		uiNum : uiNum,
		mcNum : mcNum
	};
	
	fetch(deleteMountainCommentURI,{
		method: 'PATCH',
		headers: {
			'Content-Type': 'application/json'
		},
		body: JSON.stringify(deleteParam)
	})
	.then(function(response){
			return response.json();
	})
	.then(result => {
		if(result===1){
			alert('댓글 삭제완료');
			getMountainComments(deleteParam.miNum);
			return;
		}
		alert('댓글 삭제실패');
	});
}

/* //-----pagination-----//
let totalData; //총 데이터 수
let dataPerPage; //한 페이지에 나타낼 글 수 ex)난 한 페이지에 5개만 나타내고 싶다! 그러면 5
let pageCount = 3; //페이징에 나타낼 페이지 수  ex)난 밑에 페이지 번호를 5개까지만 나타내고 6부터는 '>' 눌러서 나오게 할거다! 그럼 5
let globalCurrentPage = 1; //현재 페이지
let dataList; //표시하려하는 데이터 리스트

//현재 페이지(currentPage)와 페이지당 글 개수(dataPerPage) 반영
function displayData(currentPage, dataPerPage) {

	let html = "";

	//Number로 변환하지 않으면 아래에서 +를 할 경우 스트링 결합이 되어버림..
	currentPage = Number(currentPage);
	dataPerPage = Number(dataPerPage);

	let maxpnum=(currentPage - 1) * dataPerPage + dataPerPage; 
	
	if(maxpnum>totalData){
		maxpnum=totalData;
	}

	for(let i=(currentPage-1)*dataPerPage;i<maxpnum;i++) { //여기에 원래 리스트에 넣어주는 값들으 넣어주면 된다. 불러오는 형식은 dataList[i].컬럼명	
			html += '<div class="col-lg-4 col-md-6 service-item single-item" style="cursor:pointer;" onclick="location.href=\'/views/mountain/view?miNum=' + dataList[i].miNum + '\'">'
			 + '<a class="text-black">'
		 	 + '<div style="position: relative; width:100%; height:200px; overflow:hidden;">'
		 	 + '<img class="mountainImgDivWrap" style="width:100%; height:200px; object-fit:fill"' + 'src="' + dataList[i].mntnattchimageseq + '"' + 'onerror="this.src=\'/resources/images/mountain/mountain-no-img.png\'">'
			 + '</div>'
			 + '<h5 class="mb-4 service-title">' + dataList[i].mntnm + '</h5>'
			 + '</a></div>'
			//등산 아이콘 제작자 : Freepik
	}
	$("#mountainInfoDiv").html(html);  //여기서 저 위에있는 값들을 html에 넣어줌
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

      //이건 전체 건수 나타낼려고 적은 것
      //전체 건수 표기 안할거면 밑에 세 줄은 지워도 무관.
	  let displayCount = "";
	  displayCount = "전체 " + totalData + "건";
	  $(".allPartys").html(displayCount);
	  
      //이것도 전체 건수를 이모티콘과 같이 넣으려고 한거라
      //얘도 안쓴다면 지워도 무관(3줄)
	  let reviewCount = "";
	  reviewCount = "🗨" + totalData
	  $(".reviewCount").html(reviewCount);


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

function getMountainCommandAndPaging(){
	//dataPerPage 선택값 가져오기
	dataPerPage = 10;    //위에서 선언한 한 페이지에 나타낼 글 수를 여기서 값 설정해줌! 글 수 바꾸고 싶다면 여기서 설정하면 된다.
	
	$.ajax({ // ajax로 데이터 가져오기(기존에 쓰던 fetch처럼 쓰면 된다. 여기선 데이터 불러오는 코드 작성하면 된다.)
	method: "GET",  //메소드명
	url: mountainURI,    //데이터 불러오는 코드 컨트롤러 주소
	dataType: "json",   //데이터타입은 json으로 나와야해서 이건 변경할 필요 없음
	success: function(d) { //값을 성공적으로 불러온다면 저 d라는 곳에 값이 담길 예정임
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
  });
} */
//-----pagination end--//

//-----카카오맵-----//
var mapContainer = document.getElementById('map'), // 지도를 표시할 div
mapOption = { 
	center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표(기본값)
	level: 7 // 지도의 확대 레벨
};

var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
var infowindow = new kakao.maps.InfoWindow({zIndex:1}); // infowindow
var mapTypeControl = new kakao.maps.MapTypeControl(); //일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
var zoomControl = new kakao.maps.ZoomControl(); //지도 확대 축소를 제어할 수 있는 줌 컨트롤을 생성합니다
var ps = new kakao.maps.services.Places(); // 장소 검색 객체를 생성합니다

map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT); //kakao.maps.ControlPosition은 컨트롤이 표시될 위치를 정의하는데 TOPRIGHT는 오른쪽 위를 의미합니다
map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT); // 줌컨트롤

function setCenter(lat, lot) {            
    var moveLatLon = new kakao.maps.LatLng(lat, lot); // 이동할 위도 경도 위치를 생성합니다
    map.setCenter(moveLatLon); // 지도 중심을 이동 시킵니다
}

//키워드 검색 완료 시 호출되는 콜백함수 입니다
function placesSearchCB (data, status, pagination) {
    if (status === kakao.maps.services.Status.OK) {
        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
        var bounds = new kakao.maps.LatLngBounds(); // LatLngBounds 객체에 좌표를 추가합니다
        
        for (var i=0; i<data.length; i++) {
            displayMarker(data[i]);    
            bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
        }       
        map.setBounds(bounds);  // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
        map.setLevel(7);
    } 
}

//지도에 마커를 표시하는 함수입니다
function displayMarker(place) {
    // 마커를 생성하고 지도에 표시합니다
    var marker = new kakao.maps.Marker({
        map: map,
        position: new kakao.maps.LatLng(place.y, place.x) 
    });

    kakao.maps.event.addListener(marker, 'mouseover', function() {    // 마커에 이벤트를 등록합니다
        infowindow.setContent('<div style="padding:5px;font-size:12px;text-align:center;">' + place.place_name + '</div>'); // 장소명이 인포윈도우에 표출됩니다
        infowindow.open(map, marker);
    });
    
    kakao.maps.event.addListener(marker, 'mouseout', function() {    // 마커에 이벤트를 등록합니다
        infowindow.close();
    });
}
//-----카카오맵 end-----//

//---openweather api--//
const weatherDiv = document.querySelector("#weatherDiv");
const weatherIcon = document.querySelector("#weatherIcon");

function getWeather(lat, lon, apiKey){
	const weatherAPIURL='https://api.openweathermap.org/data/2.5/weather';
	const weatherURI = '?lat=' + lat + '&lon=' + lon + '&appid=' + apiKey + '&units=metric';	// units=metric : 섭씨로 설정
	const weatherIconURL = 'https://openweathermap.org/img/wn/';
	const weatherIconSurfix = '@2x.png';
	const celsius = '℃';

	fetch(weatherAPIURL + weatherURI)
	.then(response => response.json())
	.then(data => {
//		console.log(data); 
	    const place = data.name;
	    const temp = data.main.temp.toFixed(1) + celsius; // 온도
	    const weathers = data.weather[data.weather.length -1]; // 날씨
	    const sunset = new Date(data.sys.sunset*1000); // 일몰 unix timestamp * millisec
	    const sunrise = new Date(data.sys.sunrise*1000); // 일출 unix timestamp * millisec
	    
	    let dailySunsetDate = (sunset.getMonth()+1) + '월 ' + sunset.getDate() + '일';
	    let dailySunriseDate = (sunrise.getMonth()+1) + '월 ' + sunrise.getDate() + '일';
	    let dailySunsetTime = sunset.getHours() + '시 ' + sunset.getMinutes() + '분';
	    let dailySunriseTime = sunrise.getHours() + '시 ' + sunrise.getMinutes() + '분';
	    
	    weatherIcon.src = weatherIconURL + weathers.icon + weatherIconSurfix;
	    weatherDiv.innerHTML = '산 현재기온: ' + temp + '<br>' + dailySunsetDate + ' 일출: ' + dailySunriseTime + '<br>' + dailySunriseDate + ' 일몰: '+ dailySunsetTime;
	});
}
//---openweather api end--//
</script>
</body>
</html>
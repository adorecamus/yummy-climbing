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
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
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
<div id="mountainPageWrap" style="width:80%; margin: 5rem 0 3rem 0; padding: 2rem 2rem 2rem 2rem; position: absolute; text-align: center; border: solid; left: 10%; min-width: 34.5rem">
	<!-- header -->
	<div id="mountainHeaderWrap">
		<div id="mountainInfoWrap" style="width:30rem; border:solid; padding: 1rem 1rem 1rem 1rem; float:left; display: inline-block;">
			<div id="likeWrap" style="width: 50px; position:absolute; height: 30px; cursor: pointer; z-index: 99;">
				<div id="mountainLike"style="width: 50px; height: 50px; position: relative; float: left"
					onclick="setMountainLike()">
					<img src="/resources/images/user/empty-heart.png">
				</div>
				<div id="likeCount"	style="width: 50px; height: 30px; position: relative; float: left"></div>
			</div>
			<div id="mountainName" style="width:100%;"></div>
			<div id="mountainSubTitle" style="width:100%;"></div>
			<div id="mountainImg" style="width:100%; height:100%; overflow: hidden; margin-bottom: 0.25rem">
			</div>
			<div id="heightWrap" style=" width:100%; display:inline-block; float:left;">
				<div style=" width:20%; float:left;">높이</div>
				<div id="mountainHeight" style=" width:80%; float:left; text-align:left;"></div>
			</div>
			<div id="areaWrap" style=" width:100%; display:inline-block; float:left; margin:0.25rem auto">
				<div style=" width:20%; float:left;">지역</div>
				<div id="mountainArea" style="width:80%; float:left; text-align:left;"></div>
			</div>
		</div>
		
		<div id="envirmentWrap" style="float:right">
			<div id="map" style="width: 30rem; height: 30rem;"></div>
			<div id="weatherWrap" style=" width:100%; display:inline-block;float:left;">
				<img id="weatherIcon" style=" width:15%; height:15%; float:left; object-fit:cover;">
				<div id="weatherDiv" style=" width:60%; margin-left:0.25rem; float:left; text-align: left; vertical-align: middle;"></div>
			</div>
		</div>
	</div>
	
	<!-- article -->
	<div id="mountainInfoArticleWrap" style="position: relative; clear:both; margin: 0 auto;">
		<div id="mountainInfoListWrap">
			<div id="mountainInfoList">
				<ul id="mountainReason" style="list-style: none;">
					<li></li>
				</ul>
				<ul id="mountainDetails">
					<li></li>
				</ul>
				<ul id="mountainEtcCourse">
					<li></li>
				</ul>
				<ul id="mountainOverview">
					<li></li>
				</ul>
				<ul id="mountainTourism">
					<li></li>
				</ul>
				<ul id="mountainTransport">
					<li></li>
				</ul>
			</div>
		</div>
		<div id="mountainCommentWrap" style="display: block;">
			<div id="mountainComment">
				<div id="divBody"></div>
			</div>
			<div id="mountainCommentInsertWrap">
				<textarea id="montainCommentory" style="width: 10erm; height: 6.25em; resize: none;"></textarea>
				<button onclick="insertMountainComment()">등록</button>
			</div>
		</div>
	</div>
</div>

<script>
window.addEventListener('load',getSelectedMountainInfo());

function getSelectedMountainInfo(){	
	const mountainURL = '/mountain/' + '${param.miNum}';
	
	fetch(mountainURL)
	.then(function(res){
		return res.json();
	})
	.then(function(mountainInfo){
		if(mountainInfo!==null){
			/* header */
			document.querySelector("title").innerText = mountainInfo.mntnm;
			document.querySelector("#mountainName").innerHTML = '<h1>' + mountainInfo.mntnm + '</h1>'; // 산이름
			document.querySelector("#mountainArea").innerHTML = '<p>' + mountainInfo.areanm + '</p>'// 산지역명
			document.querySelector("#mountainHeight").innerText =  mountainInfo.mntheight + 'm'; // 산높이
			document.querySelector("#mountainSubTitle").innerHTML = '<p>' + mountainInfo.subnm + '</p>'; // 산 부제
			document.querySelector("#mountainImg").innerHTML = '<img style="width:100%; height:100%; object-fit:cover;" src="'
															 + mountainInfo.mntnattchimageseq + '"'
															 + ' onerror="this.src=\'/resources/images/mountain/mountain-no-img.png\'">'; // 산이미지 url

			/* article */
 			document.querySelector("#mountainReason li").innerText = mountainInfo.aeatreason; // 100대산 선정 이유
			document.querySelector("#mountainDetails li").innerText = mountainInfo.details;
			document.querySelector("#mountainEtcCourse li").innerText =  mountainInfo.etccourse;
			document.querySelector("#mountainOverview li").innerText = mountainInfo.overview;
			document.querySelector("#mountainTourism li").innerText =  mountainInfo.tourisminf;
			document.querySelector("#mountainTransport li").innerText =  mountainInfo.transport;
			
			let mountainPlace = {
					x : mountainInfo.lot, // 산 데이터 경도
					y : mountainInfo.lat, // 산 데이터 위도
					place_name : mountainInfo.mntnm // 산 이름
			} // 산 정보를 저장한 구조체

			getLikesMountain(mountainInfo.miNum);
			getMountainComments(mountainInfo.miNum);
			checkMountainLike('${userInfo.uiNum}', mountainInfo.miNum);
			
			const keyword = '100대명산 ' + mountainPlace.place_name; // '100대명산'을 명시해줘야 다른 키워드가 붙지 않음(xx산 음식점 등)
			
			if(mountainPlace.x===0 || mountainPlace.y==0){ // 둘중 하나라도 0이면 좌표값을 불러오지 못했거나 없는것. 좌표값이 없을 경우 키워드 검색으로 이동
	//			alert('아이고 좌표가 없네');
				ps.keywordSearch(keyword, placesSearchCB); // 카카오맵 키워드 검색
			} else{
				setCenter(mountainPlace.y, mountainPlace.x); // 좌표 기준 중앙정렬
				displayMarker(mountainPlace); // 마커생성
			}
			
			getWeather(mountainPlace.y, mountainPlace.x, '${openWeatherMapAPI}');
		}
	});
}

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

function getMountainComments(mountainNum){
	const mountainCommentURI = '/mountain-comment/';
	
	fetch(mountainCommentURI + mountainNum)
	.then(function(res){
		return res.json();
	})
	.then(function(comments){
		if(comments!==null){
			let html='';
			
			if(comments.length===0){
				html += '<p> ' + '댓글이 없습니다.' + '<br>' + '처음으로 글을 남겨보세요!' + '</p>';
			} else {
				for(const comment of comments){
					html += '<p class="mcNum"> 글번호: ' + comment.mcNum + '<p>';
					html += '<p class="uiNum"> 회원번호: ' + comment.uiNum + '<p>';
					html += '<p class="niNickname"> 닉: ' + comment.uiNickname + '</p>';
					html += '<p class="uiImgPath"> img: ' + comment.uiImgPath + '</p>';
					html += '<p class="mcComment"> 댓글: ' + comment.mcComment + '</p>';
					html += '<p class="commentModDate"> 작성일자: ' + comment.mcLmodat + '/' + comment.mcLmotim + '</p>';
					html += '<button class="commentChange">수정' + '</button>';
					html += '<button class="commentDelete">삭제' + '</button>';	
				}
			}
				document.querySelector("#divBody").innerHTML = html;
				document.querySelector(".commentChange").addEventListener('click', deleteMountainComment());
		}
	});	
}

function checkMountainLike(uiNum, miNum){
	checkMountainLikeURL = '/mountain-like/check';
	
	checkLikeParam = {
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
			console.log(result);
			document.querySelector("#mountainLike img").src = '/resources/images/user/red-heart.png';
			return;
		} 
		document.querySelector("#mountainLike img").src = '/resources/images/user/empty-heart.png';
		return;
	})	
}

function setMountainLike(){
	setMountainLikeURL = '/mountain-like/set'
	uiNum = '${userInfo.uiNum}';
	miNum = '${param.miNum}';
	
	checkLikeParam = {
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
	})
}

function insertMountainComment(){
	const insertMountainCommentURI = '/mountain-comment';
	const insertParam = {
		miNum : '${param.miNum}',
		uiNum : '${userInfo.uiNum}',
		mcComment : document.querySelector("#montainCommentory").value
	};
	
	fetch(insertMountainCommentURI,{
		method: 'POST',
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
			getMountainComments(insertParam.miNum);
			return;
		}
		alert('댓글 등록실패');
	});
}

function deleteMountainComment(){
	const deleteMountainCommentURI = '/mountain-comment/delete';
	const deleteParam = {
		miNum : '${param.miNum}',
		uiNum : '${userInfo.uiNum}',
		mcNum : ''
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
		if(result === 1){
			alert('댓글 삭제완료');
			getMountainComments(deleteParam.miNum);
			return;
		}
		alert('댓글 삭제실패');
	});
}

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

const weatherDiv = document.querySelector("#weatherDiv");
const weatherIcon = document.querySelector("#weatherIcon");

//날씨 api
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
</script>
</body>
</html>
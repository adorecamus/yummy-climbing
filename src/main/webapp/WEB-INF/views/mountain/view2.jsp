<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${param.mntnm}</title>
<%@ include file= "/resources/common/header.jsp" %>
<link href="/resources/css/style1.css" rel="stylesheet" type="text/css">
<link href="/resources/css/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${kakaoMapKey}&libraries=services,clusterer,drawing"></script>
</head>
<body>
<div id="mountainInfoWrap" style="width: 70%; margin: 20px 0 20px 0; padding:5px 5px 5px 5px; position:absolute; text-align:center; border:solid; left:15%;">
	<div id="mountainInfoHeaderWrap" style=" width: 70%; border:solid; position:relative;  margin: auto;">
		<div id="mountainHeader" style="border:solid; width:50%; display: inline-block; position:absolute; align:center; margin: auto;">
			<div id="mountainName" style="border:solid; width:50%; position:relative; margin: auto;"></div>
			<div id="mountainHeight" style="border:solid; width:50px; position:relative; margin: auto;"></div>
			<div id="mountainLike" style="border:solid; width:50px; height:50px; cursor:pointer; position:relative;" onclick="alert('좋아요 이벤트 넣을곳')"><img src="/resources/images/user/red-heart.png"></div>
			<div id="LikeCount" style="border:solid; width:50px; height:30px; position:relative;"></div>
		</div>
		<div id="mountainSubTitle" style="border:solid; width:50%; position:relative; margin: auto;"></div>
		<div id="mountainArea" style="border:solid; width:50%; position:relative; margin: auto;"></div>
		<div id="weatherWarp" style="border:solid; position:relative;">
			<div id="weatherDiv" style="border:solid; position:absolute;"></div>
			<div id="weatherIconWarp" style="border:solid; position:absolute;">
				<img id="weatherIcon">
			</div>
		</div>	
	</div>

	<div id="mountainInfoArticleWrap">
		<div id="mountainView" style="width: 100%; height: 500px; display: inline-block ; position: relative;">
			<div id="mountainImg" style="position: relative; width:300px; height:300px; overflow:hidden;">				
			</div>
			<div id="map" style="width: 500px; height: 500px;">
			</div>
		</div>
		<div id="mountainInfoListWrap">
			<div id="mountainInfoList">
				<ul id="mountainReason" style="list-style:none;">
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
		<div id="mountainCommentWrap">
			
		</div>
	</div>
</div>
		

<script>
window.onload = function(){
	getSelectedMountainInfo();
}

function getSelectedMountainInfo(){	
	fetch('/mountain/${param.mntnm}')
	.then(function(res){
		return res.json();
	})
	.then(function(mountainInfo){
		if(mountainInfo!==null){
			/* header */
			document.querySelector("#mountainName").innerText = mountainInfo.mntnm; // 산이름
			document.querySelector("#mountainArea").innerText = mountainInfo.areanm; // 산지역명
			document.querySelector("#mountainHeight").innerText =  mountainInfo.mntheight + 'm'; // 산높이
			document.querySelector("#mountainSubTitle").innerText = mountainInfo.subnm; // 산 부제
			document.querySelector("#mountainImg").innerHTML = '<img style="position:absolute; width:100%; height:100%; top:50%; left:50%; transform:translate(-50%, -50%);" src="' + mountainInfo.mntnattchimageseq + '" >'; // 산이미지 url

			/* article */
			document.querySelector("#mountainReason li").innerText = mountainInfo.aeatreason; // 100대산 선정 이유
			document.querySelector("#mountainDetails li").innerText = mountainInfo.details;
			document.querySelector("#mountainEtcCourse li").innerText =  mountainInfo.etccourse;
			document.querySelector("#mountainOverview li").innerText = mountainInfo.overview;
			document.querySelector("#mountainTourism li").innerText =  mountainInfo.tourisminf;
			document.querySelector("#mountainTransport li").innerText =  mountainInfo.transport;
			
			getLikeMountain(mountainInfo.miNum);
			getMountainComments(mountainInfo.miNum);
			
			let mountainPlace = {
					x : mountainInfo.lot, // 산 데이터 경도
					y : mountainInfo.lat, // 산 데이터 위도
					place_name : mountainInfo.mntnm // 산 이름
			} // 산 정보를 저장한 구조체
			
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

function getLikeMountain(mountainNum){
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
			document.querySelector('#LikeCount').innerHTML = html;
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
			console.log(comments);
		}
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
		console.log(data); 
	    const place = data.name;
	    const temp = data.main.temp.toFixed(1) + celsius; // 온도
	    const weathers = data.weather[data.weather.length -1]; // 날씨
	    const sunset = new Date(data.sys.sunset*1000); // 일몰 unix timestamp * millisec
	    const sunrise = new Date(data.sys.sunrise*1000); // 일출 unix timestamp * millisec
	    
	    let dailySunset = sunset.getHours() + '시 ' + sunset.getMinutes() + '분';
	    let dailySunrise = sunrise.getHours() + '시 ' + sunrise.getMinutes() + '분';
	    
	    weatherIcon.src = weatherIconURL + weathers.icon + weatherIconSurfix;
	    weatherDiv.innerHTML = '현재기온: ' + temp + '<br>' + '금일 일출: ' + dailySunrise + '<br>' + '금일 일몰: '+ dailySunset;
	});
}
</script>
</body>
</html>
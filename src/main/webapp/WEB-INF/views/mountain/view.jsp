<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
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
<div id="mountainInfoWrap"  style="width: 70%; position:absolute; text-align:center; border:solid; left:15%;">
	<div id="mountainInfoHeaderWrap" style="border:solid; width=80%;">
		<div id="mountainHeader" style="border:solid; width=50%; display: inline-block;">
			<div id="mountainName" style="border:solid; width=50%;"></div>
			<div id="mountainLike" style="border:solid; width:50px; height:50px; cursor:pointer" onclick="alert('좋아요 이벤트 넣을곳')">좋아요</div>
			<div id="LikeCountWrap" style="border:solid; width:50px; height:100px;">
				<div id="LikeCount">
				</div>
				<div id="LikeText">
					<h5>좋아요 갯수</h5>
				</div>
			</div>
		</div>
	</div>
	<div id="mountainInfoArticleWrap">
		<div id="mountainView" style="width: 100%; height: 500px; display: inline-block;">
			<div id="mountainImg" style="border:solid; width: 50%; height: 100%;">				
			</div>
			<div id="map" style="width: 50%; height: 50%;">
			</div>
		</div>
	</div>
		<table border=1>
			<tr>
				<th>1</th>
				<th>2</th>
				<th>3</th>
				<th>4</th>
				<th>5</th>
				<th>6</th>
				<th>7</th>
				<th>8</th>
				<th>9</th>
			</tr>
			<tbody id="tBody">
			</tbody>
		</table>
		<div id="weatherDiv"></div>
		<img id="weatherIcon">
		
		<div id="mountainCommentWrap">
			
		</div>
</div>
<script>
window.onload = function(){
	getSelectedMountainInfo();
}

function getSelectedMountainInfo(){
	let html = '';
//	console.log('${param.mntnm}');
	
	fetch('/mountain/${param.mntnm}')
	.then(function(res){
		return res.json();
	})
	.then(function(mountainInfo){
		if(mountainInfo!==null){
	//		console.log(mountainInfo);
			html += '<tr>';
			document.querySelector("#mountainName").innerText = mountainInfo.mntnm;
			document.querySelector("#mountainImg").innerHTML = '<img src="' + mountainInfo.mntnattchimageseq + '">';
			html += '<td id="aeatreason">' + mountainInfo.aeatreason + '</td>';
			html += '<td id="areanm">' + mountainInfo.areanm + '</td>';
			html += '<td id="details">' + mountainInfo.details + '</td>';
			html += '<td id="etccourse">' + mountainInfo.etccourse + '</td>';
			html += '<td id="mntheight">' + mountainInfo.mntheight + '</td>';
			html += '<td id="overview">' + mountainInfo.overview + '</td>';
			html += '<td id="subnm">' + mountainInfo.subnm + '</td>';
			html += '<td id="tourisminf">' + mountainInfo.tourisminf + '</td>';
			html += '<td id="transport">' + mountainInfo.transport + '</td>';
			html += '</tr>';
			document.querySelector('#tBody').innerHTML = html;
			
			getLikeMountain(mountainInfo.miNum);
			getMountainComments(mountainInfo.miNum);
			
			let mountainPlace = {
					x : mountainInfo.lot, // 산 데이터 경도
					y : mountainInfo.lat, // 산 데이터 위도
					place_name : mountainInfo.mntnm // 산 이름
			} // 산 정보를 저장한 구조체
			
			let keywords = '100대명산 ' + mountainPlace.place_name; // '100대명산'을 명시해줘야 다른 키워드가 붙지 않음(xx산 음식점 등)
	//		console.log(keywords);
			
			if(mountainPlace.x===0 || mountainPlace.y==0){ // 둘중 하나라도 0이면 좌표값을 불러오지 못했거나 없는것. 좌표값이 없을 경우 키워드 검색으로 이동
	//			alert('아이고 좌표가 없네');
				ps.keywordSearch(keywords, placesSearchCB); // 카카오맵 키워드 검색
			} else{
				setCenter(mountainPlace.y, mountainPlace.x); // 좌표 기준 중앙정렬
				displayMarker(mountainPlace); // 마커생성
			}
			
			getWeather(mountainPlace.y, mountainPlace.x);
		}
	});
}

function getLikeMountain(mountainNum){
	fetch('/mountain-like/' + mountainNum)
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
	fetch('/mountain-comment/' + mountainNum)
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
        infowindow.setContent('<div style="padding:5px;font-size:12px;">' + place.place_name + '</div>'); // 장소명이 인포윈도우에 표출됩니다
        infowindow.open(map, marker);
    });
    
    kakao.maps.event.addListener(marker, 'mouseout', function() {    // 마커에 이벤트를 등록합니다
        infowindow.close();
    });   
}
const weatherDiv = document.querySelector("#weatherDiv");
const weatherIcon = document.querySelector("#weatherIcon");

//날씨 api
function getWeather(lat, lon){
	const weatherURI = '?lat=' + lat + '&lon=' + lon + '&appid=${openWeatherMapAPI}&units=metric';	// units=metric : 섭씨로 설정
	const celsius = '℃';

	fetch('https://api.openweathermap.org/data/2.5/weather' + weatherURI)
	.then(response => response.json())
	.then(data => {
		console.log(data); 
//	    const place = data.name;
	    const temp = data.main.temp.toFixed(1) + celsius;
	    const weathers = data.weather[data.weather.length -1];
	    weatherIcon.src = 'https://openweathermap.org/img/wn/' + weathers.icon + '@2x.png';
	    weatherDiv.innerHTML = temp + '<br>' + weathers.main + '<br>';
		});
}
</script>
</body>
</html>
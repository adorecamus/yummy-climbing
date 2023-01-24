<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:eval var="openWeatherMapAPI"
	expression="@envProperties['openweathermap.key']" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<spring:eval var="kakaoMapKey"
	expression="@envProperties['kakao.map.js.key']" />
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${kakaoMapKey}&libraries=services,clusterer,drawing"></script>
<title>mountain</title>
</head>
<body>
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

	<div id="map" style="width: 700px; height: 700px;"></div>

	<script>
function getSelectedMountainInfo(){
	let html = '';
	console.log('${param.mntnm}');
	
	fetch('/mountain/${param.mntnm}')
	.then(function(res){
		return res.json();
	})
	.then(function(mountainInfo){
		console.log(mountainInfo);
		html += '<tr>';
		html += '<td id="mntnm">' + mountainInfo.mntnm + '</td>';
		html += '<td id="aeatreason">' + mountainInfo.aeatreason + '</td>';
		html += '<td id="areanm">' + mountainInfo.areanm + '</td>';
		html += '<td id="details">' + mountainInfo.details + '</td>';
		html += '<td id="etccourse">' + mountainInfo.etccourse + '</td>';
		html += '<td id="mntheight">' + mountainInfo.mntheight + '</td>';
		html += '<td id="overview">' + mountainInfo.overview + '</td>';
		html += '<td id="subnm">' + mountainInfo.subnm + '</td>';
		html += '<td id="tourisminf">' + mountainInfo.tourisminf + '</td>';
		html += '</tr>';
		document.querySelector('#tBody').innerHTML = html;
		
	});
}

const COORDS = 'coords';
window.onload = function(){
	loadCoords();
	getSelectedMountainInfo();
}
	function loadCoords() {
	  const loadedCoords = localStorage.getItem(COORDS); // localStorage에서 위치정보 가져옴
//	  console.log(loadedCoords);
	  if (loadedCoords === null) { // 위치 정보가 없으면
	  	askForCoords(); // 위치 정보 요청 함수
	  } else {
		  const parseCoords = JSON.parse(loadedCoords); // json형식을 객체 타입으로 바꿔서 저장
		  mapOption.center = new kakao.maps.LatLng(parseCoords.latitude, parseCoords.longitude);
	  }
	}
	
	function askForCoords() { // 사용자 위치 요청 (요청 수락, 요청 거절)
		navigator.geolocation.getCurrentPosition(handleGeoSucces, handleGeoError);
	}
	
	function handleGeoSucces(position) { // 요청 수락
		const latitude = position.coords.latitude; 
		const longitude = position.coords.longitude;
		const coordsObj = {
			latitude,
		    longitude,
		};
		saveCoords(coordsObj); // localStorage에 저장 함수
	}
	
	function saveCoords(coordsObj) { // localStorage에 저장
		localStorage.setItem(COORDS, JSON.stringify(coordsObj));
	}
	 
	function handleGeoError() { // 요청 거절
		console.log('위치 정보 거절');
	}

var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
mapOption = { 
    center: new kakao.maps.LatLng(37.66645197990472, 127.01282925848525), // 지도의 중심좌표
    level: 7 // 지도의 확대 레벨
};
var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

//일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
var mapTypeControl = new kakao.maps.MapTypeControl();

//kakao.maps.ControlPosition은 컨트롤이 표시될 위치를 정의하는데 TOPRIGHT는 오른쪽 위를 의미합니다
map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);

//지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
var zoomControl = new kakao.maps.ZoomControl();

map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
map.addOverlayMapTypeId(kakao.maps.MapTypeId.TERRAIN);

</script>
</body>
</html>
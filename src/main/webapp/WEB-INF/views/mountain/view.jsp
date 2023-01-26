<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:eval var="openWeatherMapAPI"
	expression="@envProperties['openweathermap.key']" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<spring:eval var="kakaoMapKey" expression="@envProperties['kakao.map.js.key']" />
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${kakaoMapKey}&libraries=services,clusterer,drawing"></script>
<title>${param.mntnm}</title>
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
			<th>10</th>
			<th>11</th>
		</tr>
		<tbody id="tBody">
		</tbody>
	</table>
	
	<div id="map" style="width: 700px; height: 700px;"></div>

<script>
window.onload = function(){
	getSelectedMountainInfo();
}
let mountainLatitude = 0;
let mountainLongitude = 0;

function getSelectedMountainInfo(){
	let html = '';
//	console.log('${param.mntnm}');
	
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
		html += '<td id="transport">' + mountainInfo.transport + '</td>';
		html += '<td id="mntnattchimageseq">' + '<img src="' + mountainInfo.mntnattchimageseq + '" onerror="this.src=''">';
		html += '</tr>';
		document.querySelector('#tBody').innerHTML = html;
		
		mountainLatitude = mountainInfo.lat;
		mountainLongitude = mountainInfo.lot;
		console.log(mountainLatitude, mountainLongitude);
	});
}

var mapContainer = document.getElementById('map'), // 지도를 표시할 div
mapOption = { 
	center: new kakao.maps.LatLng(mountainLatitude,mountainLongitude), // 지도의 중심좌표
	level: 8 // 지도의 확대 레벨
};

var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

var infowindow = new kakao.maps.InfoWindow({zIndex:1});
var mapTypeControl = new kakao.maps.MapTypeControl(); //일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
var zoomControl = new kakao.maps.ZoomControl(); //지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다

map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT); //kakao.maps.ControlPosition은 컨트롤이 표시될 위치를 정의하는데 TOPRIGHT는 오른쪽 위를 의미합니다
map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT); // 줌컨트롤
map.addOverlayMapTypeId(kakao.maps.MapTypeId.TERRAIN); // 지형도

</script>
</body>
</html>
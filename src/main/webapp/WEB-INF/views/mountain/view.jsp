<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
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

function getSelectedMountainInfo(){
	let html = '';
//	console.log('${param.mntnm}');
	
	fetch('/mountain/${param.mntnm}')
	.then(function(res){
		return res.json();
	})
	.then(function(mountainInfo){
//		console.log(mountainInfo);
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
		html += '<td id="mntnattchimageseq">' + '<img src="' + mountainInfo.mntnattchimageseq + '">';
		html += '</tr>';
		document.querySelector('#tBody').innerHTML = html;
		
		let mountainLatitude = mountainInfo.lat;
		let mountainLongitude = mountainInfo.lot;	
		let keywords = '100대명산 ' + mountainInfo.mntnm; // '100대명산'을 명시해줘야 다른 키워드가 붙지 않음(ex:음식점)
//		console.log(keywords);
		
		if(mountainLatitude===0 || mountainLongitude==0){ // 둘중 하나라도 0이면 좌표값을 불러오지 못했거나 없는것. 좌표값이 없을 경우 키워드 검색으로 이동
//			alert('아이고 좌표가 없네');
			ps.keywordSearch(keywords, placesSearchCB);
		} else{
			setCenter(mountainLatitude, mountainLongitude);
			var markerPosition  = new kakao.maps.LatLng(mountainLatitude, mountainLongitude); // 마커가 표시될 위치입니다 
			var marker = new kakao.maps.Marker({ // 마커를 생성합니다
			    position: markerPosition
			});
			marker.setMap(map);	// 마커가 지도 위에 표시되도록 설정합니다
		}
		
	});
}

var mapContainer = document.getElementById('map'), // 지도를 표시할 div
mapOption = { 
	center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
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
    } 
}

//지도에 마커를 표시하는 함수입니다
function displayMarker(place) {
    // 마커를 생성하고 지도에 표시합니다
    var marker = new kakao.maps.Marker({
        map: map,
        position: new kakao.maps.LatLng(place.y, place.x) 
    });

    kakao.maps.event.addListener(marker, 'click', function() {    // 마커에 클릭이벤트를 등록합니다
        infowindow.setContent('<div style="padding:5px;font-size:12px;">' + place.place_name + '</div>'); // 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다
        infowindow.open(map, marker);
    });
}
</script>
</body>
</html>
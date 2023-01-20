<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<spring:eval var="kakaoMapKey" expression="@envProperties['kakao.map.js.key']" />
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${kakaoMapKey}&libraries=services,clusterer,drawing"></script>
<title>mountain</title>
</head>
<body>
<div id="map" style="width:700px;height:700px;">
</div>
<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
mapOption = { 
    center: new kakao.maps.LatLng(37.66645197990472, 127.01282925848525), // 지도의 중심좌표
    level: 5 // 지도의 확대 레벨
};
var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
//일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
var mapTypeControl = new kakao.maps.MapTypeControl();
//지도에 컨트롤을 추가해야 지도위에 표시됩니다
//kakao.maps.ControlPosition은 컨트롤이 표시될 위치를 정의하는데 TOPRIGHT는 오른쪽 위를 의미합니다
map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);
//지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
var zoomControl = new kakao.maps.ZoomControl();
map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
map.addOverlayMapTypeId(kakao.maps.MapTypeId.TERRAIN);

</script>
</body>
</html>
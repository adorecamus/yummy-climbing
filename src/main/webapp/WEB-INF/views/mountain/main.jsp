<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>main</title>
</head>
<body>
<spring:eval var="openWeatherMapAPI" expression="@envProperties['openweathermap.key']" />
<div id="mountainDiv" style="border:solid; width: 300px; height: 300px">
<p>산리스트</p>
</div>
<div id="weatherDiv" style="border:solid; width: 500px; height: 200px">
<p>날씨</p>
</div>
<script>	
 	window.onload = function(){
 		init();
/* 		getMountainInfo(); */
	}
	
	function getMountainInfo(){ //산 정보
		fetch('/mountain')
		.then(function(response){
			console.log(response);
			return response.json();
		})
		.then(function(mountainList){
			console.log(mountainList);
			if(mountainList!==null){
				for(mountainInfo of mountainList){
					const html= '';
					html += '<div>' + ${mountainInfo.mntnm} + '</div>';					
				}
				document.querySelector('#mountainDiv').innerHTML = html;
			}
		});
	}
	
	const weather = document.querySelector("#weatherDiv");
	const COORDS = "coords";
	 
	function getWeather(lat, lng) {
	  fetch('https://api.openweathermap.org/data/2.5/weather?lat='+ lat + '&lon=' + lng + '&appid=' + ${openWeatherMapAPI})
	    .then(function(response){
	      return response.json();
	    })
	    .then(function(json){ 
	      console.log(json);
	      const temperature = json.main.temp; 
	      const place = json.name;
	      weather.innerText = '${temperature} @ ${place}';
	    });
	}
	 
	function saveCoords(coordsObj) { // localStorage에 저장
	  localStorage.setItem(COORDS, JSON.stringify(coordsObj));
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
	 
	function handleGeoError() { // 요청 거절
	  console.log("위치 정보 거절");
	}
	 
	function askForCoords() { // 사용자 위치 요청 (요청 수락, 요청 거절)
	  navigator.geolocation.getCurrentPosition(handleGeoSucces, handleGeoError);
	}
	 
	function loadCoords() {
	  const loadedCoords = localStorage.getItem(COORDS); // localStorage에서 위치정보 가져옴
	  if (loadedCoords === null) { // 위치 정보가 없으면
	    askForCoords(); // 위치 정보 요청 함수
	  } else {
	    const parseCoords = JSON.parse(loadedCoords); // json형식을 객체 타입으로 바꿔서 저장
	    getWeather(parseCoords.latitude, parseCoords.longitude); // 날씨 요청 함수
	  }
	}
	
	function init() {
	  loadCoords();
	}

</script>
</body>
</html>
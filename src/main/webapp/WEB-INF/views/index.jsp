<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>맛등산</title>
<%@ include file="/resources/common/header.jsp"%>
</head>
<body>
	맛등산 대박~~~~~~~~~~~~~~~~~!!!!!!!!!!!!!!!!!!!!!!
	<br>
	<c:if test="${userInfo ne null}">
		<h1>${userInfo.uiNickname}님어서오세요</h1>
	</c:if>
	<br>
	<c:if test="${userInfo eq null}">
		<button onclick="location.href='/views/user/login'">로그인</button>
		<button onclick="location.href='/views/user/signup'">회원가입</button>
	</c:if>
	<button onclick="location.href='/views/community/list'">목록</button>
	<button onclick="location.href='/views/mountain/list'">산리스트</button>
	<button onclick="location.href='/views/party/main'">소모임</button>
	<br>
	<br>
	<c:if test="${userInfo ne null}">
		<button onclick="location.href='/views/user/mypage'">마이 페이지</button>
		<button onclick="location.href='/views/user/logout'">로그아웃</button>
	</c:if>
	<h4>오늘날씨</h4>
	<div id="weatherDiv"></div>
	<div id="weatherimgWrap">
		<img id="weatherIcon">
	</div>

	<h4>이 주의 추천 산</h4>
	<div id="recommendedMountainDiv"
		style="width: 500px; height: 200px; text-align: center;">
		<div id="mountainInfoDiv" class=".paging-div" style="border: solid;">
			<p>추천 산리스트</p>
		</div>
	</div>

	<h4>이 주의 추천 모임</h4>
	<div id="recommendedParty"
		style="border: 2px solid; width: 500px; height: 200px;"></div>

	<script>
 	window.onload = function(){
 		getRecommendedMountainList();
 		getRecommendedPartyList();
	 	loadCoords();
	}
	
	function getRecommendedMountainList(){ //산 정보
		const mountainURI = '/mountain/recommended';
	
		fetch(mountainURI,{
			method:'GET',
			headers : {
				'Content-Type' : 'application/json'
			}			
		})
		.then(async function(res){
			if(res.ok){
				return res.json();
			}else{
				const err = await res.text();
				throw new Error(err);
			}
		})
		.then(function(mountainList){
			if(mountainList!==null){
				let html= '';
				for(const mountainInfo of mountainList){
/* 					html += '<div style="border:1px solid; width: 150px; height: 150px; display:inline-block; cursor:pointer;" onclick="location.href=\'/views/mountain/view?mntnm='
						 + mountainInfo.mntnm + '\'">'
						 + '<h5>' + mountainInfo.mntnm + '</h5>' + '</div>'; */
					html += '<div style="margin:5px 0px 0px 5px; width:150px; height:125px; display:inline-block; cursor:pointer;" onclick="location.href=\'/views/mountain/view?mntnm=' + mountainInfo.mntnm + '\'">';
						html += '<div style="position: relative; width:150px; height:100px; overflow:hidden;">'
							 + '<img style="position:absolute; width:100%; height:100%; top:50%; left:50%; transform:translate(-50%, -50%);"'
							 +  'src="' + mountainInfo.mntnattchimageseq + '"' + ' onerror="this.src=\'/resources/images/mountain-no-img.png\'">'
							 + '</div>';
						html += '<div style="border:solid; width:150px; height:25px;">' + '<h6 align="center">' + mountainInfo.mntnm + '</h6>' + '</div>';
					html += '</div>';
					//등산 아이콘 제작자 : Freepik
				}
				document.querySelector('#mountainInfoDiv').innerHTML = html;
			}
		});
	}
	
	function getRecommendedPartyList() {
		fetch('/party-infos/recommended')
		.then(response => response.json()) 
		.then(list => {
			let html = '';
			for(partyInfo of list) {
				if (partyInfo.piComplete === 1) {
					html += '<div style="background-color:lightgrey; float:left; border:1px solid; width:150px; height:150px; cursor:pointer;" onclick="location.href=\'/views/party/view?piNum=' + partyInfo.piNum + '\'">';
				} else {
					html += '<div style="float:left; border:1px solid; width:150px; height:150px; cursor:pointer;" onclick="location.href=\'/views/party/view?piNum=' + partyInfo.piNum + '\'">';
				}
				html += '<p>' + partyInfo.mntnm + '<br><b>' + partyInfo.piName + '</b></p>';
				/*
				html += '<p>산 : ' + partyInfo.mntnm + '</p>';
				html += '<p>모임 이름 : ' + partyInfo.piName + '</p>';
				html += '<p>날짜 : ' + partyInfo.piExpdat + '</p>';
				html += '<p>시간 : ' + partyInfo.piMeetingTime + '</p>';
				html += '<p>멤버 : ' + partyInfo.memNum + " / " + partyInfo.piMemberCnt + '</p>';
				html += '<p>좋아요 : ' + partyInfo.likeNum + '</p>';
				html += '<p>소개 : ' + partyInfo.piProfile + '</p>';
				html += '<p>생성일 : ' + partyInfo.piCredat + '</p>';
				*/
				html += '</div>';
			}
			document.querySelector('#recommendedParty').innerHTML = html;
		})
	}

	const weatherDiv = document.querySelector("#weatherDiv");
	const weatherIcon = document.querySelector("#weatherIcon");
	const COORDS = 'coords';


		function loadCoords() {
		  const loadedCoords = localStorage.getItem(COORDS); // localStorage에서 위치정보 가져옴
//		  console.log(loadedCoords);
		  if (loadedCoords === null) { // 위치 정보가 없으면
		  	askForCoords(); // 위치 정보 요청 함수
		  } else {
			  const parseCoords = JSON.parse(loadedCoords); // json형식을 객체 타입으로 바꿔서 저장
			  getWeather(parseCoords.latitude, parseCoords.longitude); // 날씨 요청 함수
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
		
		function getWeather(lat, lon){
			const weatherURI = '?lat=' + lat + '&lon=' + lon + '&appid=${openWeatherMapAPI}&units=metric';	// units=metric : 섭씨로 설정
			const celsius = '℃';

			fetch('https://api.openweathermap.org/data/2.5/weather' + weatherURI)
			.then(response => response.json())
			.then(data => {
				console.log(data); 
			    const place = data.name;
			    const temp = data.main.temp.toFixed(1) + celsius;
			    const weathers = data.weather[data.weather.length -1];
			    weatherIcon.src = 'https://openweathermap.org/img/wn/' + weathers.icon + '@2x.png';
			    weatherDiv.innerHTML = place + '<br>' + temp + '<br>' + weathers.main + '<br>';
			});
		}

</script>
</body>
</html>
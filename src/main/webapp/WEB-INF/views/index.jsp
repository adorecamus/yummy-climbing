<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>맛등산</title>
<%@ include file= "/resources/common/header.jsp" %>
<%@ include file= "/resources/common/banner.jsp" %>
</head>
<body>
<section class="page-header1">
	<div class="container">
		<div class="row position-relative">
			<div class="col-8 mx-auto text-center">
				<p class="text-primary text-uppercase fw-bold">List of recommended mountains</p>
				<h2 class="mb-4">금주의 추천 산</h2>
			</div>
		</div>
	</div>
</section>
<section class="section-sm bg-primary-light">
	<div class="container recommendMountaingab">
			<div id="recommendedMountainDiv" style= "text-align:center; margin:0 auto; width:70%;">
				<div id="mountainInfoDiv" class="row">
					<p>추천 산리스트</p>
				</div>
			</div>
		</div>
</section>
<section class="section testimonials overflow-hidden bg-tertiary">
	<div class="container">
	    <div class="row justify-content-center">
	      <div class="col-lg-6">
	        <div class="section-title text-center">
	          <p class="text-primary text-uppercase fw-bold">Our Service Holders</p>
	          <h2 class="mb-4">금주의 추천 모임</h2>
	        </div>
	      </div>
	    </div>
	    <div class="row position-relative">
	    	<div id="recommendedParty" style="display:flex; align-content: 3px;"></div>
	   	</div>
	</div>
	<div class="has-shapes">
    <svg class="shape shape-left text-light" width="290" height="709" viewBox="0 0 290 709" fill="none"
      xmlns="http://www.w3.org/2000/svg">
      <path
        d="M-119.511 58.4275C-120.188 96.3185 -92.0001 129.539 -59.0325 148.232C-26.0649 166.926 11.7821 174.604 47.8274 186.346C83.8726 198.088 120.364 215.601 141.281 247.209C178.484 303.449 153.165 377.627 149.657 444.969C144.34 546.859 197.336 649.801 283.36 704.673"
        stroke="currentColor" stroke-miterlimit="10" />
      <path
        d="M-141.434 72.0899C-142.111 109.981 -113.923 143.201 -80.9554 161.895C-47.9878 180.588 -10.1407 188.267 25.9045 200.009C61.9497 211.751 98.4408 229.263 119.358 260.872C156.561 317.111 131.242 391.29 127.734 458.631C122.417 560.522 175.414 663.463 261.437 718.335"
        stroke="currentColor" stroke-miterlimit="10" />
      <path
        d="M-163.379 85.7578C-164.056 123.649 -135.868 156.869 -102.901 175.563C-69.9331 194.256 -32.086 201.934 3.9592 213.677C40.0044 225.419 76.4955 242.931 97.4127 274.54C134.616 330.779 109.296 404.957 105.789 472.299C100.472 574.19 153.468 677.131 239.492 732.003"
        stroke="currentColor" stroke-miterlimit="10" />
      <path
        d="M-185.305 99.4208C-185.982 137.312 -157.794 170.532 -124.826 189.226C-91.8589 207.919 -54.0118 215.597 -17.9666 227.34C18.0787 239.082 54.5697 256.594 75.4869 288.203C112.69 344.442 87.3706 418.62 83.8633 485.962C78.5463 587.852 131.542 690.794 217.566 745.666"
        stroke="currentColor" stroke-miterlimit="10" />
    </svg>
    <svg class="shape shape-right text-light" width="731" height="429" viewBox="0 0 731 429" fill="none"
      xmlns="http://www.w3.org/2000/svg">
      <path
        d="M12.1794 428.14C1.80036 390.275 -5.75764 349.015 8.73984 312.537C27.748 264.745 80.4729 237.968 131.538 231.843C182.604 225.703 234.032 235.841 285.323 239.748C336.615 243.64 391.543 240.276 433.828 210.964C492.452 170.323 511.701 91.1227 564.607 43.2553C608.718 3.35334 675.307 -9.81661 731.29 10.323"
        stroke="currentColor" stroke-miterlimit="10" />
      <path
        d="M51.0253 428.14C41.2045 392.326 34.0538 353.284 47.7668 318.783C65.7491 273.571 115.623 248.242 163.928 242.449C212.248 236.641 260.884 246.235 309.4 249.931C357.916 253.627 409.887 250.429 449.879 222.701C505.35 184.248 523.543 109.331 573.598 64.0588C615.326 26.3141 678.324 13.8532 731.275 32.9066"
        stroke="currentColor" stroke-miterlimit="10" />
      <path
        d="M89.8715 428.14C80.6239 394.363 73.8654 357.568 86.8091 325.028C103.766 282.396 150.788 258.515 196.347 253.054C241.906 247.578 287.767 256.629 333.523 260.099C379.278 263.584 428.277 260.567 465.976 234.423C518.279 198.172 535.431 127.525 582.62 84.8317C621.964 49.2292 681.356 37.4924 731.291 55.4596"
        stroke="currentColor" stroke-miterlimit="10" />
      <path
        d="M128.718 428.14C120.029 396.414 113.678 361.838 125.837 331.274C141.768 291.221 185.939 268.788 228.737 263.659C271.536 258.515 314.621 267.008 357.6 270.282C400.58 273.556 446.607 270.719 482.028 246.16C531.163 212.111 547.275 145.733 591.612 105.635C628.572 72.19 684.375 61.1622 731.276 78.0432"
        stroke="currentColor" stroke-miterlimit="10" />
      <path
        d="M167.564 428.14C159.432 398.451 153.504 366.107 164.863 337.519C179.753 300.046 221.088 279.062 261.126 274.265C301.164 269.452 341.473 277.402 381.677 280.465C421.88 283.527 464.95 280.872 498.094 257.896C544.061 226.035 559.146 163.942 600.617 126.423C635.194 95.1355 687.406 84.8167 731.276 100.612"
        stroke="currentColor" stroke-miterlimit="10" />
    </svg>
  </div>
</section>
<%-- 	<c:if test="${userInfo eq null}">
		<button onclick="location.href='/views/user/login'">로그인</button>
		<button onclick="location.href='/views/user/signup'">회원가입</button>
	</c:if>
	<br>
	<br>
	<c:if test="${userInfo ne null}">
		<button onclick="location.href='/views/user/mypage'">마이 페이지</button>
		<button onclick="location.href='/views/user/logout'">로그아웃</button>
	</c:if> --%>
<!-- 	<h4>오늘날씨</h4>
	<div id="weatherDiv"></div>
	<div id="weatherimgWrap">
		<img id="weatherIcon">
	</div> -->

<!-- 	<h4>이 주의 추천 산</h4>
	<div id="recommendedMountainDiv"
		style="width: 500px; height: 200px; text-align: center;">
		<div id="mountainInfoDiv" class=".paging-div" style="border: solid;">
			<p>추천 산리스트</p>
		</div>
	</div>

	<h4>이 주의 추천 모임</h4>
	<div id="recommendedParty"
		style="border: 2px solid; width: 500px; height: 200px;"></div>
 -->
<script>
	
window.addEventListener('load', async function(){
	await getRecommendedMountainList();
	await getRecommendedPartyList();
 	await loadCoords();
});

 	
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
					html += '<div style="display:flex; flex-direction: column; cursor:pointer; width:33.1%;" onclick="location.href=\'/views/mountain/view?miNum=' + mountainInfo.miNum + '\'">';
					html += '<div style="position: relative; width:100%; height:200px; overflow:hidden;">'
					 	 + '<img class="mountainImgDivWrap" style="width:100%; height:200px; object-fit:fill"' + 'src="' + mountainInfo.mntnattchimageseq + '"' + 'onerror="this.src=\'/resources/images/mountain/mountain-no-img.png\'">'
						 + '</div>'
					html += '<div style="padding-top:10px;">' + '<h5 align="center">' + mountainInfo.mntnm + '</h5>' + '</div>';
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
					html += '<div class="col-lg-4 col-md-6 pt-1" style="background-color:lightgrey; border-radius: 12px; cursor:pointer;" onclick="location.href=\'/views/party/view?piNum=' + partyInfo.piNum + '\'">';
				} else {
					html += '<div class="m-2" style="cursor:pointer;" onclick="location.href=\'/views/party/view?piNum=' + partyInfo.piNum + '\'">';
				}
				html += '<div class="shadow rounded bg-white p-4 mt-4">'
		          	 + '<div class="d-block d-sm-flex align-items-center">'
		             + '<span class="colored-box text-center h3 mb-4">'+"23"
		             + '<p class="month">'+ "Mar" +'</p>'
		           	 + '</span>'
		             + '<div class="mt-3 mt-sm-0 ms-0 ms-sm-3">'
		             + '<p class="text-primary mb-1 fw-bold">' + partyInfo.mntnm + '</p>'
		             + '<h5 class="h5 mb-1">' + partyInfo.piName + '</h5>'
		             + '<p class="mb-0">'+"08:00 AM ~"+'</p>'
		             + '</div>'
		          	 + '</div>'
		          	 + '<div class="content">'+"Lorem ipsum dolor demina egestas sit puru felis arcu. Vitae, turpisds tortr etiam faucibus ac suspendisse."+'</div>'
		        	 + '<a type="button" class="btn btn-primary mt-3" href="#" data-bs-toggle="modal" data-bs-target="#applyLoan" style="font-size:15px; border-radius: 35px;" >'
		        	 + "Join Now"
		        	 + '<span style="font-size: 14px;" class="ms-2 fas fa-arrow-right"></span></a>'
		        	 + '</div>'
//					 + '<p>' + partyInfo.mntnm + '<br><b>' + partyInfo.piName + '</b></p>';
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
			  return;
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
			saveCoords(coordsObj); // localStorage에 저장하는 함수
			getWeather(latitude, longitude);
		}
		
		function saveCoords(coordsObj) { // localStorage에 저장
			localStorage.setItem(COORDS, JSON.stringify(coordsObj));
		}
		 
		function handleGeoError() { // 요청 거절
			console.log('위치 정보 요청 거절');
		}
		
		function getWeather(lat, lon){
			const weatherURI = '?lat=' + lat + '&lon=' + lon + '&appid=${openWeatherMapAPI}&units=metric';	// units=metric : 섭씨로 설정
			const celsius = '℃';

			fetch('https://api.openweathermap.org/data/2.5/weather' + weatherURI)
			.then(response => response.json())
			.then(async function(data){
//				console.log(data); 
			    const place = data.name;
			    const temp = data.main.temp.toFixed(1) + celsius;
			    const weathers = data.weather[data.weather.length -1];
			    weatherIcon.src = 'https://openweathermap.org/img/wn/' + weathers.icon + '@2x.png';
			    weatherDiv.innerHTML = place + '&nbsp&nbsp&nbsp&nbsp' + temp;
			});
		}

</script>
</body>
</html>
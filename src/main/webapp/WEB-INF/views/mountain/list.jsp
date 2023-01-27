<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>main</title>
<%@ include file="/resources/common/header.jsp"%>
<link href="/resources/css/style1.css" rel="stylesheet" type="text/css">
<link href="/resources/css/style.css" rel="stylesheet" type="text/css">
<spring:eval var="openWeatherMapAPI" expression="@envProperties['openweathermap.key']" />
<script
	src="https://code.jquery.com/jquery-3.6.3.min.js"
	integrity="sha256-pvPw+upLPUjgMXY0G+8O0xUf+/Im1MZjXxxgOcBQBXU="
	crossorigin="anonymous">
</script>
</head>
<body>
	<div id="mountainDivWrap" style="width: 70%; align: center; border:solid;">
		<div id="mountainSearchWrap">
			<select id="conditionSelect">
				<option value="mntnm">산이름</option>
				<option value="areanm">지역</option>
			</select> <input type="text" id="condition" placeholder="검색조건" value="" onkeypress="getMountainInfo()">
			<button onclick="getMountainInfo()">검색</button>
			<button onclick="location.reload()">초기화</button>
		</div>
		<div id="mountainInfoDiv" class=".paging-div" style="border: solid;">
		</div>
		
		<div id="mountainPagenationWrap">
			<nav aria-label="mountainPagination">
				<ul class="pagination">
					<li class="page-item"><a class="page-link" href="#"
						aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
					</a></li>
					<li class="page-item"><a class="page-link" href="#">1</a></li>
					<li class="page-item"><a class="page-link" href="#">2</a></li>
					<li class="page-item"><a class="page-link" href="#">3</a></li>
					<li class="page-item"><a class="page-link" href="#"
						aria-label="Next"> <span aria-hidden="true">&raquo;</span>
					</a></li>
				</ul>
			</nav>
		</div>
	</div>

<script>
 	window.onload = function(){
 		getMountainInfo();
	}
	
	function getMountainInfo(){ //산 정보
		const conditionSelect = document.querySelector('#conditionSelect').value;
		const condition = document.querySelector('#condition').value;
		const mountainURI = '/mountain' + '?' + conditionSelect + "=" + condition;
	
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
//			console.log(mountainList);
			if(mountainList!==null){
				let html= '';
				for(const mountainInfo of mountainList){
					html += '<div style="border:solid; width:150px; height:180px; display:inline-block; cursor:pointer;" onclick="location.href=\'/views/mountain/view?mntnm=' + mountainInfo.mntnm + '\'">';
					html += '<div style="border:solid; width:150px; height:130px;>' + '<img src=\"' + mountainInfo.mntnattchimageseq + '\">' + '</div>';
					html += '<div style="border:solid; width:150px; height:50px;">' + '<h6>' + mountainInfo.mntnm + '</h6>' + '</div>';
					html += '</div>';
				}
				document.querySelector('#mountainInfoDiv').innerHTML = html;
			}
		});
	}
</script>
</body>
</html>
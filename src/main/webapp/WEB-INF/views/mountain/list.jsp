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
		
	<select id="conditionSelect">
        <option value="mntnm">산이름</option>
        <option value="areanm">지역</option>
    </select>  
	<input type="text" id="condition" placeholder="검색조건" value="">	
	<button onclick="getMountainInfo()">검색</button>
	
	<div id="mountainDiv" style="border:solid; width: 300px; height: 300px">
		<p>산리스트</p>
	</div>

<script>
 	window.onload = function(){
 		getMountainInfo();
	}
	
	function getMountainInfo(){ //산 정보
		const conditionSelect = document.querySelector('#conditionSelect').value;
		const condition = document.querySelector('#condition').value;
		const mountainURI = '/mountain' + '?' + conditionSelect + "=" + condition;
		console.log(mountainURI);
		
		const html= '';
	
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
			console.log(mountainList);
			if(mountainList!==null){
				for(const mountainInfo of mountainList){
					html += '<div>' + '<p>' + ${mountainInfo.mntnm} + '</p>' + '</div>';					
				}
				document.querySelector('#mountainDiv').innerHTML = html;
			}
		});
	}
</script>
</body>
</html>
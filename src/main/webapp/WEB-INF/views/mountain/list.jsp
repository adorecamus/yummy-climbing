<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>main</title>
<%@ include file="/resources/common/header.jsp"%>
<link href="/resources/css/style1.css" rel="stylesheet" type="text/css">
<link href="/resources/css/style.css" rel="stylesheet" type="text/css">
<script
	src="https://code.jquery.com/jquery-3.6.3.min.js"
	integrity="sha256-pvPw+upLPUjgMXY0G+8O0xUf+/Im1MZjXxxgOcBQBXU="
	crossorigin="anonymous">
</script>
</head>
<body>
	<div id="mountainDivWrap" style="width:70%; position:relative ; text-align:center; left:15%; margin:20px 0 20px 0;">
		<div id="mountainSearchWrap" style="width:100%; margin:10px auto; vertical-align: middle;">
			<div id="searchBoxWrap" style="width:90%; display:inline-block;">
				<div id="selectWrap" style="width:40%; display:inline;">
					<select id="conditionSelect">
						<option value="mntnm">산이름</option>
						<option value="areanm">지역</option>
					</select> <input type="text" id="condition" placeholder="" value="" onkeypress="getMountainInfo()">
				</div>
				<div id="searchButtonWrap" style="display:inline-block;">
					<button onclick="getMountainInfo()">검색</button>
					<button onclick="location.reload()">초기화</button>
				</div>
			</div>
		</div>
		<div id="mountainInfoDiv" class=".paging-div" style="border-width:5px 0 0 0;">
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
					html += '<div class=".paging-div" style=" border:solid; overflow:hidden; margin:5px 5px 0 5px; width:150px; height:125px; display:inline-block; cursor:pointer;" onclick="location.href=\'/views/mountain/view?mntnm=' + mountainInfo.mntnm + '\'">';
						html += '<div style="position: relative; width:150px; height:100px; overflow:hidden;">'
							 + '<img class="mountainImgDivWrap" style="position:absolute; width:100%; height:100%; top:50%; left:50%; transform:translate(-50%, -50%);"'
							 +  'src="' + mountainInfo.mntnattchimageseq + '"' + ' onerror="this.src=\'/resources/images/mountain/mountain-no-img.png\'">'
							 + '</div>';
						html += '<div style="width:150px; height:25px;">' + '<h6 align="center">' + mountainInfo.mntnm + '</h6>' + '</div>';
					html += '</div>';
					//등산 아이콘 제작자 : Freepik
				}
				document.querySelector('#mountainInfoDiv').innerHTML = html;
			}
		});
	}
</script>
</body>
</html>
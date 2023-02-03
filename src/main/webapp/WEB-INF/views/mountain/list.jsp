<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>main</title>
<%@ include file="/resources/common/header.jsp"%>
<script
	src="https://code.jquery.com/jquery-3.6.3.min.js"
	integrity="sha256-pvPw+upLPUjgMXY0G+8O0xUf+/Im1MZjXxxgOcBQBXU="
	crossorigin="anonymous">
</script>
</head>
<body>
<div class="col-8 mx-auto text-center" style="margin-top:50px;">
	<div class="section-title pt-4">
		<p class="text-primary text-uppercase fw-bold">mountain information</p>
        <h2 class="mb-3 text-capitalize">산리스트</h2>
	</div>
	<div class="searchBox" style="width:70%; margin:0 auto; display:flex;">
		<div class="input-group shadow-none bg-white search" >
			<select id="conditionSelect" class="searchBoxoption" style="border-color:lightgrey; width: 100px; text-align:center;">
				<option value="mntnm">산이름</option>
				<option value="areanm">지역</option>
			</select> 
			<input type="text" id="condition" class="form-control shadow-none bg-white" style="width:220px;" placeholder="검색어를 입력하세요.." value="" onkeypress="getMountainInfo()">
		</div>
		<div class="searchBtn" style="display:flex; width:350px;">
			<button class="btn btn-primary search" onclick="getMountainInfo()" style="margin:0 5px;">검색</button>
			<button class="btn btn-primary reset" onclick="location.reload()">초기화</button>
			</div>
		</div>
	</div>
	<section class="section">
		<div class="container">
			<div id="mountainInfoDiv" class=".paging-div row" style="padding-bottom: 10px; text-align:center;">
			</div>
		</div>
	</section>
	<div style="position: absolute; left: -5000px;" aria-hidden="true">
		<input type="text" name="b_463ee871f45d2d93748e77cad_a0a2c6d074" tabindex="-1">
	</div>	
<div id="mountainPagenationWrap">
	<nav aria-label="mountainPagination">
		<div id="Pagination">
			<div id="div-body">
			</div>
		</div>
	</nav>
</div>


<script>
window.addEventListener('load', async function(){
	await getMountainInfo();
});

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
					html += '<div class="col-lg-4 col-md-6 service-item" style="cursor:pointer;" onclick="location.href=\'/views/mountain/view?miNum=' + mountainInfo.miNum + '\'">'
						 + '<a class="text-black">'
					 	 + '<div style="position: relative; width:100%; height:130px; overflow:hidden;">'
					 	 + '<img class="mountainImgDivWrap"'+  'src="' + mountainInfo.mntnattchimageseq + '"' + 'onerror="this.src=\'/resources/images/mountain/mountain-no-img.png\'">'
						 + '</div>'
						 + '<h5 class="mb-4 service-title">' + mountainInfo.mntnm + '</h5>'
						 + '</a></div>'
						//등산 아이콘 제작자 : Freepik
//						html += '<div class=".paging-div" style=" border:solid; overflow:hidden; margin:5px 5px 0 5px; width:150px; height:125px; display:inline-block; cursor:pointer;" onclick="location.href=\'/views/mountain/view?mntnm=' + mountainInfo.mntnm + '\'">';
//						html += '<div style="position: relative; width:150px; height:100px; overflow:hidden;">'
//							 + '<img class="mountainImgDivWrap" style="position:absolute; width:100%; height:100%; top:50%; left:50%; transform:translate(-50%, -50%);"'
//							 +  'src="' + mountainInfo.mntnattchimageseq + '"' + ' onerror="this.src=\'/resources/images/mountain/mountain-no-img.png\'">'
//							 + '</div>';
//						html += '<div style="width:150px; height:25px;">' + '<h6 align="center">' + mountainInfo.mntnm + '</h6>' + '</div>';
//						html += '</div>';
					
				}
				document.querySelector('#mountainInfoDiv').innerHTML = html;
			}
		});
	}
</script>
</body>
</html>
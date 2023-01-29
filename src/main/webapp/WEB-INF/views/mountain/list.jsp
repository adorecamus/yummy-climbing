<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
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
	<div id="mountainDivWrap" style="width: 70%; position:absolute; text-align:center; border:solid; left:15%;">
		<div id="mountainSearchWrap" style="height:50px; display:inline-block; vertical-align: middle;">
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
				<div id="Pagination">
					<div id="div-body">
					</div>
				</div>
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
/* 				$('#pagination').twbsPagination({
					  totalPages: mountainList.length,
					  visiblePages: 20,
					  onPageClick: function (event, page) {
					    $('#page-content').text('Page ' + page);
					  }
					}); */
				
				let html= '';
				for(const mountainInfo of mountainList){
					html += '<div class=".paging-div" style="margin:5px 5px 0 5px; width:150px; height:125px; display:inline-block; cursor:pointer;" onclick="location.href=\'/views/mountain/view?mntnm=' + mountainInfo.mntnm + '\'">';
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
	
/* 	function paging(page) {
		$('#div-body').empty();
		var startRow = (page - 1) * pageSize; // + 1 list는 0부터 시작하니깐;
		var endRow = page * pageSize;
		if (endRow > totalCount) 
		{
			endRow = totalCount;
		}  
		var startPage = ((page - 1)/visibleBlock) * visibleBlock + 1;
		var endPage = startPage + visibleBlock - 1;
		if(endPage > totalPages) {    //
		  endPage = totalPages;
		}
		for (var j = startRow; j < endRow; j++) 
		{	
			$('#div-body').append(''+ chatLogList[j].fileNo +''
					+ textLengthOverCut(chatLogList[j].fileName, '25', '...') +''+ chatLogList[j].fileDate +'');
		}
	}	 */

</script>
</body>
</html>
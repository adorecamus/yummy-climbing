<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 목록</title>
</head>
<body>
<h2>커뮤니티</h2>
<input type="text" id="cbTitle"><button onclick="getBoardInfos()">검색</button>
<div>
	<table id="table" class="table">
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>조회수</th>
		</tr>
		<tbody id="tBody"></tbody>
	</table>
</div>
<div>
	<button onclick="getBoardInfoList()"></button>
</div>
<script>
function getBoardInfos() {
	fetch('/community-board?cbTitle='+document.querySelector('#cbTitle').value)
	.then(function(res){
		return res.json();
	})
	.then(function(list){
		let html = '';
		for(let i=0; i<list.length; i++) {
			const communityboard = list[i];
			html += '<tr>';
			html += '<td>' + communityboard.cbNum + '</td>';
			html += '<td><a hrefs="/views/community-board/view?cbNum='+ communityboard.cbNum +'">' + communityboard.cbTitle + '</a></td>';
			html += '<td>' + communityboard.uiId + '</td>';
			html += '<td>' + communityboard.cbCredat + '</td>';
			html += '<td>' + communityboard.cbCnt + '</td>';
			html += '</tr>';
		}
		document.querySelector('#tBody').innerHTML = html;
	})
};
window.onload = function(){
	getBoardInfoList()
}

</script>
</body>
</html>
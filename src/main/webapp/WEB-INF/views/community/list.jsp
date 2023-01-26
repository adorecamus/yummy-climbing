<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 목록</title>
<!-- CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<!-- js -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

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
	<button onclick="location.href='/views/community/insert'">글쓰기</button>
</div>
<div class="pageInfo_wrap">
	<div class="pageInfo_area">
		<ul id="pageInfo">
			<c:if test="${pageMaker.prev}">
				<li class="pageBtn previous"><a href="#">Pre</a></li>
			</c:if>
			<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
				<li class="pageInfo_btn"><a href="${num}" onclick="pageBtn()">${num}</a></li>
			</c:forEach>
			<c:if test="${pageMaker.next}">
				<li class="pageBtn next"><a href="#">Next</a></li>
			</c:if>
		</ul>
	</div>
</div>
<form id="moveForm" method="get">
	<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
	<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
</form>

<script>
function pageBtn(e) {
	let moveForm = document.querySelector('#moveForm');
	e.preventDefault();
	moveForm.find("input[name='pageNum']").val($(this).attr("href"));
	moveForm.attr("action", "/views/community/list");
	moveForm.submit();	
}

function getBoardInfos() {
	fetch('/community-board?cbTitle='+document.querySelector('#cbTitle').value)
	.then(function(res){
		return res.json();
	})
	.then(function(list){
		let html = '';
		for(let i=0; i<list.length; i++) {
			const communityboard = list[i];
			html += '<tr style= "cursor:pointer" onclick="location.href=\'/views/community/view?cbNum='+communityboard.cbNum + '\'">';
			html += '<td>' + communityboard.cbNum + '</td>';
			html += '<td>' + communityboard.cbTitle + '<span> [' + communityboard.cbCommentCnt + ']</span></td>';
			html += '<td>' + communityboard.uiId + '</td>';
			html += '<td>' + communityboard.cbCredat + '</td>';
			html += '<td>' + communityboard.cbViewCnt + '</td>';
			html += '</tr>';
		}
		document.querySelector('#tBody').innerHTML = html;
	})
};

window.onload = function(){
	getBoardInfos()
}

</script>
</body>
</html>
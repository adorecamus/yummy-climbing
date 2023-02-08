<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 목록</title>
<!-- CSS -->
<%@ include file= "/resources/common/header.jsp" %>
</head>
<body>
<div class="row col-8 mx-auto text-center mt-10">
	<h2 class="text-capitalize"><span onclick="location.href='/views/community/list'" style="cursor:pointer">커뮤니티</span></h2>
	<ul style="list-style-type: none">
		<li style="background-color: #baebc9a8;border: solid 2px black;">
       		<a class="text-primary fw-bold" style="width:24.8%; margin-left:30px; font-size:20px; margin-right:30px; cursor:pointer;" onclick="getBoardInfosByCategory('infoboard')">정보게시판</a>
       		<a class="text-primary fw-bold" style="width:24.8%; margin-left:30px; font-size:20px; margin-right:30px; cursor:pointer;" onclick="getBoardInfosByCategory('freeboard')">자유게시판</a>
       		<a class="text-primary fw-bold" style="width:24.8%; margin-left:30px; font-size:20px; margin-right:30px; cursor:pointer;" onclick="getBoardInfosByCategory('questionboard')">질문게시판</a>
       		<a class="text-primary fw-bold" style="width:24.8%; margin-left:30px; font-size:20px; margin-right:30px; cursor:pointer;" onclick="getBoardInfosByCategory('reviewboard')">후기게시판</a>
       	</li>
	</ul>
</div>

<c:if test="${userInfo ne null}">
<div class="writeBtnSection">
	<div class="writeBtn ">
		<div class="btn btn-outline-primary btn-pd">
			<span onclick="location.href='/views/community/insert'">글쓰기</span>
		</div>
	</div>
</div>
</c:if>   

<div class="tableWrap mb-5">
	<table id="table" class="table">
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>조회수</th>
		</tr>
		<tbody id="tBody" class="tBodyArea"></tbody>
	</table>
</div>
        <div class="searchBox" style="width:70%; margin:0 auto; display:flex;">
			<div class="input-group shadow-none bg-white search" >
				<select id="conditionSelect" class="searchBoxoption" style="border-color:lightgrey; width: 100px; text-align:center;">
					<option value="mntnm">제목</option>
					<option value="mntnm">작성자</option>
					<option value="areanm">내용</option>
				</select> 
				<input type="text" id="cbTitle" class="form-control shadow-none bg-white" style="width:220px;" placeholder="검색어를 입력하세요.." value="" onkeypress="getBoardInfos()">
			</div>
			<div class="searchBtn" style="width:127px;">
				<button class="btn btn-primary search" onclick="getBoardInfos()" style="margin:0 5px;">검색</button>
			</div>
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
	fetch('/community-board?cbTitle='+ document.querySelector('#cbTitle').value)
	.then(function(res){
		return res.json();
	})
	.then(function(list){
		console.log(list);
		let html = '';
		for(let i=0; i<list.length; i++) {
			const communityboard = list[i];
			html += '<tr style= "cursor:pointer" onclick="location.href=\'/views/community/view?cbNum='+communityboard.cbNum + '\'">';
			html += '<td>' + communityboard.cbNum + '</td>';
			html += '<td>' + communityboard.cbTitle + '<span> [' + communityboard.cbCommentCnt + ']</span></td>';
			html += '<td>' + communityboard.uiNickname + '</td>';
			html += '<td>' + communityboard.cbCredat + '</td>';
			html += '<td>' + communityboard.cbViewCnt + '</td>';
			html += '</tr>';
		}
		document.querySelector('#tBody').innerHTML = html;
	})
};

window.onload = function(){
	getBoardInfos();
}

function getBoardInfosByCategory(category) {
	console.log(category)
	fetch('/community-board/category?cbCategory='+ category)
	.then(function(res) {
		return res.json();
	})
	.then(function(list){
		let html = '';
		for(let i=0; i<list.length; i++) {
			const communityboard = list[i];
			html += '<tr style= "cursor:pointer" onclick="location.href=\'/views/community/view?cbNum='+communityboard.cbNum + '\'">';
			html += '<td>' + communityboard.cbNum + '</td>';
			html += '<td>' + communityboard.cbTitle + '<span> [' + communityboard.cbCommentCnt + ']</span></td>';
			html += '<td>' + communityboard.uiNickname + '</td>';
			html += '<td>' + communityboard.cbCredat + '</td>';
			html += '<td>' + communityboard.cbViewCnt + '</td>';
			html += '</tr>';
		}
		document.querySelector('#tBody').innerHTML = html;
	})
};

/* function getBoardInfosByCategory(cbCategory) {
	fetch('/community-board/category?category=' + document.getElementById('#cbCategory'))
	.then(function(res) {
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
}; */

</script>
</body>
</html>
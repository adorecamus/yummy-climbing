<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 목록</title>
<!-- CSS -->
<%@ include file="/resources/common/header.jsp"%>
</head>
<body>
	<div class="row col-8 mx-auto text-center mt-10">
		<p class="text-primary text-uppercase fw-bold">community</p>
		<h2 class="text-capitalize"
			onclick="location.href='/views/community/list'"
			style="cursor: pointer">커뮤니티
		</h2>
	</div>
	<section class="section">
		<div class="container">
			<div class="row">
				<div class="col-lg-3">
					<!-- categories -->
					<div class="widget widget-categories">
						<h5 class="widget-title">
							<span>Category</span>
						</h5>
						<ul class="list-unstyled widget-list">
							<li><a onclick="getBoardInfosByCategory('infoboard')">정보게시판
							</a></li>
							<li><a onclick="getBoardInfosByCategory('freeboard')">자유게시판</a>
							</li>
							<li><a onclick="getBoardInfosByCategory('questionboard')">질문게시판</a>
							</li>
							<li><a onclick="getBoardInfosByCategory('reviewboard')">후기게시판</a>
							</li>
							<li>
								<c:if test="${userInfo ne null}">
									<hr style="max-width:163px;">
									<a onclick="location.href='/views/community/insert'">글쓰기 ···</a>
								</c:if>
							</li>
						</ul>
					</div>
				</div>
				<div class="col-lg-9">
					<div class="tableWrap mb-5">
						<table id="table" class="table table-hover" style="width:100%; text-align:center;">
							<tr>
								<th>번호</th>
								<th>제목</th>
								<th>작성자</th>
								<th>작성일</th>
								<th>조회수</th>
							</tr>
							<tbody id="tBody" class="tBodyArea"></tbody>
						</table>
						<div class="searchBox float-end mt-3">
							<div class="input-group shadow-none bg-white search">
								<select id="conditionSelect" class="searchBoxoption"
									style="border-color: lightgrey; width: 100px; text-align: center;">
									<option value="mntnm">제목</option>
									<option value="mntnm">작성자</option>
									<option value="areanm">내용</option>
								</select> <input type="text" id="cbTitle" class="form-control shadow-none bg-white"
									placeholder="검색어를 입력하세요.." value="" onkeypress="getBoardInfos()">
							<div class="searchBtn" style="width: 77px;">
								<button class="btn btn-primary w-100 " onclick="getBoardInfos()" style="padding: 14px; margin-inline:8px;">검색</button>
							</div>
						</div>
					</div>
					</div>
				</div>
				
			</div>
		</div>
	</section>

<script>
function getBoardInfos() {
	fetch(
			'/community-board?cbTitle='
					+ document.querySelector('#cbTitle').value)
			.then(function(res) {
				return res.json();
			})
			.then(
					function(list) {
						console.log(list);
						let html = '';
						for (let i = 0; i < list.length; i++) {
							const communityboard = list[i];
							html += '<tr style= "cursor:pointer" onclick="location.href=\'/views/community/view?cbNum='
									+ communityboard.cbNum + '\'">';
							html += '<td>' + communityboard.cbNum + '</td>';
							html += '<td  style="text-align:left; padding-inline: 2.5%;	">' + communityboard.cbTitle + '<span> ['
									+ communityboard.commentCnt+ ']</span></td>';
							html += '<td>' + communityboard.uiNickname + '</td>';
							html += '<td>' + communityboard.cbCredat + '</td>';
							html += '<td>' + communityboard.cbViewCnt + '</td>';
							html += '</tr>';
						}
						document.querySelector('#tBody').innerHTML = html;
					})
};

window.onload = function() {
	getBoardInfos();
}

function getBoardInfosByCategory(category) {
	console.log(category)
	fetch('/community-board/category?cbCategory=' + category)
			.then(function(res) {
				return res.json();
			})
			.then(
				function(list) {
					let html = '';
					for (let i = 0; i < list.length; i++) {
						const communityboard = list[i];
						html += '<tr style= "cursor:pointer" onclick="location.href=\'/views/community/view?cbNum='
								+ communityboard.cbNum + '\'">';
						html += '<td>' + communityboard.cbNum + '</td>';
						html += '<td>' + communityboard.cbTitle + '<span> ['
								+ communityboard.commentCnt + ']</span></td>';
						html += '<td>' + communityboard.uiNickname + '</td>';
						html += '<td>' + communityboard.cbCredat + '</td>';
						html += '<td>' + communityboard.cbViewCnt + '</td>';
						html += '</tr>';
					}
					document.querySelector('#tBody').innerHTML = html;
				})
};
	</script>
</body>
</html>
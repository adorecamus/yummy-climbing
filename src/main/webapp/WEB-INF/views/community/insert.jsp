<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 등록</title>
<%@ include file= "/resources/common/header.jsp" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
<table>
	<select id="cbCategory">
		<option value="freeBoard">자유게시판</option>
		<option value="questionBoard">질문게시판</option>
		<option value="infoBoard">정보게시판</option>
	</select>
	<tr>
		<th>제목</th>
		<td><input type="text" id="cbTitle"></td>
	</tr>
	<tr>
		<th>작성자</th>
		<td><input type="text" id="uiId" value="${userInfo.uiId}" readonly></td>
	</tr>
	<tr>
		<th>내용</th>
		<td><textarea rows="20" cols="30" id="cbContent"></textarea></td>
	</tr>
	<tr>
	<th colspan="2">
		<button onclick="insertBoard()">등록</button>
		<button onclick="location.href='/views/community/list'">목록</button>
		<div data-name="fileDiv" class="form-group filebox bs3-primary">
			<label for="file_0" class="col-sm-2 control-label">파일1</label>
			<div class="col-sm-10">
				<input type="text" class="upload-name" value="파일 찾기" readonly />
				<label for="file_0" class="control-label">찾아보기</label>
				<input type="file" name="files" id="file_0" class="upload-hidden" onchange="changeFilename(this)"/>
				<button type="button" onclick="addFile()" class="btn btn-bordered btn-xs visible-xs-inline visible-sm-inline visible-md-inline visible-lg-inline">
					<i class="fa fa-plus" aria-hidden="true"></i>
				</button>
				<button type="button" onclick="removeFile(this)" class="btn btn-bordered btn-xs visible-xs-inline visible-sm-inline visible-md-inline visible-lg-inline">
					<i class="fa fa-minus" aria-hidden="true"></i>
				</button>
			</div>
		</div>
	</th>
	</tr>
</table>
	<form class="form-horizontal" th:action="@{/board/register.do}" th:object="${board}" method="post" enctype="multipart/form-data" onsubmit="return registerBoard(this)">
	</form>
<script>
let fileIdx = 0; /*[- 파일 인덱스 처리용 전역 변수 -]*/

function addFile() {
	const fileDivs = $('div[data-name="fileDiv"]');
	if (fileDivs.length > 2) {
		alert('파일은 최대 세 개까지 업로드 할 수 있습니다.');
		return false;
	}
	fileIdx++;

	const fileHtml = `
		<div data-name="fileDiv" class="form-group filebox bs3-primary">
			<label for="file_${fileIdx}" class="col-sm-2 control-label"></label>
			<div class="col-sm-10">
				<input type="text" class="upload-name" value="파일 찾기" readonly />
				<label for="file_${fileIdx}" class="control-label">찾아보기</label>
				<input type="file" name="files" id="file_${fileIdx}" class="upload-hidden" onchange="changeFilename(this)" />

				<button type="button" onclick="removeFile(this)" class="btn btn-bordered btn-xs visible-xs-inline visible-sm-inline visible-md-inline visible-lg-inline">
					<i class="fa fa-minus" aria-hidden="true"></i>
				</button>
			</div>
		</div>
	`;

	$('#btnDiv').before(fileHtml);
}

function removeFile(elem) {
	const prevTag = $(elem).prev().prop('tagName');
	if (prevTag === 'BUTTON') {
		const file = $(elem).prevAll('input[type="file"]');
		const filename = $(elem).prevAll('input[type="text"]');
		file.val('');
		filename.val('파일 찾기');
		return false;
	}

	const target = $(elem).parents('div[data-name="fileDiv"]');
	target.remove();
}

/* function changeFilename(file) {
	file = $(file);
	const filename = file[0].files[0].name;
	const target = file.prevAll('input');
	target.val(filename);
} */

function insertBoard() {
/* 	const param = {};
	param.cbTitle = document.querySelector('#cbTitle').value;
	param.cbContent = document.querySelector('#cbContent').value; */
		
	const cbTitle = document.querySelector('#cbTitle').value;
	if (!cbTitle) {
		alert('제목을 입력해주세요.');
		cbTitle.focus();
		return;
	}
		
	const cbContent = document.querySelector('#cbContent').value;
	if (!cbTitle) {
		alert('내용을 입력해주세요.');
		cbContent.focus();
		return;
	}
		
	const param = {
		uiId: document.querySelector('#uiId').value,
		cbCategory: document.querySelector('#cbCategory').value,
		cbTitle: document.querySelector('#cbTitle').value,
		cbContent: document.querySelector('#cbContent').value
	}
	fetch('/community-board',{
		method:'POST',
		headers : {
			'Content-Type' : 'application/json'
		},
		body : JSON.stringify(param)
	})
	.then(function(res){
			return res.json();
	})
	.then(function(result){
		if(result===1){
			alert('게시글이 등록되었습니다.');
			location.href='/views/community/list';
		}
		
	})

}
</script>
</body>
</html>
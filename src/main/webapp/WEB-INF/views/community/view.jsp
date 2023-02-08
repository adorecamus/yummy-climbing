<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 상세화면</title>
<%@ include file= "/resources/common/header.jsp" %>
<script src="https://code.jquery.com/jquery-3.6.3.min.js" integrity="sha256-pvPw+upLPUjgMXY0G+8O0xUf+/Im1MZjXxxgOcBQBXU=" crossorigin="anonymous">
</script>
</head>
<body>
<div class="form-group mb-4 pb-2">
	<div class="container mt-10" style="max-width:920px;">
		<div id="detail" class="mb-4">
		<!--
			<p id="cbNum"></p>
			<h2 id="cbTitle"></h2>
			<div>
				<div class="row" style="width:387px;">
					<div class="board-text" id="uiNickname"></div>
					<div class="board-text" id="cbCredat"></div>
					<div class="board-text" id="cbCretim"></div>
					<div class="board-text" id="cbViewCnt"></div>
				</div>
				<div id="cbContent" style="margin:20px 20px 20px 20px"></div>
			</div>
		-->
		</div>
		<div id="btnDiv" style="display:none">
			<button onclick="location.href='/views/community/update?cbNum=${param.cbNum}'">수정</button>
			<button onclick="deleteBoard()">삭제</button>
		</div> 
		<div>
			<input type="button" id="likeBtn" value="♡ 좋아요" onclick="updateLike()">
			<div id="likeBox"></div>
		</div>
	</div>
</div>
<hr>
<div class="container commentBox">
	<div class="commentCnt">
		<span>댓글</span>
		<span id="commentCnt"></span>
	</div>
	<div class="commentContentBox">
		<div id="comment"></div>
		<textarea class="InputComment" id="cbcContent" cols="80" rows="2" placeholder="댓글을 입력하세요..."></textarea>
		<div class="insertBtn">
			<button onclick="insertComment()">등록</button>
		</div>
	</div>
</div>

<script>
const uiNum = '${userInfo.uiNum}';
const likeBtn = document.getElementById('likeBtn');

window.addEventListener('load', async function() {
	await getBoard();
	await getFiles();
	if (uiNum !== '') {
		await getLikeInfo();
	}
	await getlikeCnt();
	await getCommentList();
});

// 게시글 보기
async function getBoard() {
	const boardResponse = await fetch('/community-board/${param.cbNum}');
	if (!boardResponse.ok) {
		const errorResult = await boardResponse.json();
		alert('게시글을 불러올 수 없습니다.');
		location.href = '/views/community/list';
		return;
	}
	const communityBoard = await boardResponse.json();
	let html = '';
	html += 'No. ' + communityBoard.cbNum + '<br>';
	html += '<h2>' + communityBoard.cbTitle + '</h2>';
	html += '<div>';
	html += '<div class="row" style="width:369px;">';
	html += '<div class="board-text">' + communityBoard.uiNickname + '</div>';
	html += '<div class="board-text">' + communityBoard.cbCredat+ '</div>';
	html += '<div class="board-text">' + communityBoard.cbCreTim+ '</div>';
	html += '<div class="board-text">조회&nbsp;&nbsp;' + communityBoard.cbViewCnt + '<br></div></div>';	
	html += '</div>';
	html += '<div id="cbContent" style="margin:20px 20px 20px 20px">' + communityBoard.cbContent + '</div>';
	if('${userInfo.uiNum}' == communityBoard.uiNum){
		document.getElementById('btnDiv').style.display='';
	};
	document.getElementById('detail').insertAdjacentHTML('afterbegin', html);
	document.getElementById('commentCnt').insertAdjacentHTML('beforeend', '<span>['+communityBoard.cbCommentCnt +']</span>');
}

// 게시글에 등록한 파일 불러오기
async function getFiles() {
	const filesResponse = await fetch('/community-board-file/${param.cbNum}');
	if (!filesResponse.ok) {
	 	alert('등록된 파일을 불러올 수 없습니다.');
	 	return;
	}
	const filesResult = await filesResponse.json();
	if (filesResult.length > 0) {
		let html = '';
		html += '<div class="board-text">첨부 이미지</div>';
		for (const file of filesResult) {
			html += '<img src="/files/' + file.cbfUuid + '" alt="1.jpg">';
		}
		document.getElementById('detail').insertAdjacentHTML('beforeend', html);
	}
}

//좋아요 여부 불러오기
async function getLikeInfo() {
	const likeInfoResponse = await fetch('/board-like/${param.cbNum}');
	if (!likeInfoResponse.ok) {
	 	alert('좋아요 여부를 불러올 수 없습니다.');
	 	return;
	}
	const likeInfoResult = await likeInfoResponse.json();
	if (likeInfoResult === true) {
		likeBtn.value = '♥ 좋아요 취소';
	}
}

// 좋아요 수 불러오기
async function getlikeCnt() {
	const likeCntResponse = await fetch('/board-like-cnt/${param.cbNum}');
	if (!likeCntResponse.ok) {
	 	alert('좋아요 수를 불러올 수 없습니다.');
	 	return;
	}
	const likeCntResult = await likeCntResponse.json();
	if (likeCntResult != null) {
		likeBtn.value += '\u00A0\u00A0'+likeCntResult;
	}
}

// 좋아요&좋아요 취소
async function updateLike(){
	if (uiNum === ''){
		alert('로그인이 필요한 서비스입니다.');
		location.href="/views/user/login";
		return;
	}
	const param = {
		cbNum : '${param.cbNum}',
		uiNum : uiNum
	}
	const likeResponse = await fetch('/board-like', {
		method:'POST',
		headers : {
			'Content-Type' : 'application/json'
		},
		body : JSON.stringify(param)
	});
	if (!likeResponse.ok) {
	 	alert('좋아요 여부를 불러올 수 없습니다.');
	 	return;
	}
	const likeResult = await likeResponse.json();
	if(likeResult == 0){
		likeBtn.value = '♥ 좋아요 취소';
	} else {
		likeBtn.value = '♡ 좋아요';
	}
	await getlikeCnt();
}
		
// 댓글 목록 불러오기
async function getCommentList() {
	const commentsResponse = await fetch('/community-comments/${param.cbNum}');
	if (!commentsResponse.ok) {
	 	alert('댓글을 불러올 수 없습니다.');
	 	return;
	}
	const commentsResult = await commentsResponse.json();
	let html = '';
	for (let i = 0; i<commentsResult.length; i++) {
		const comment = commentsResult[i];
		html += '<hr>';
		html += '<tr>';
 		html += '<input type="hidden" id="commentUiNum" value='+ comment.uiNum +'>';
		html += '<span>' + comment.uiNickname + '</span>';
		html += '<span> &nbsp;' + comment.cbcCredat + '</span>';
		html += '<span> &nbsp;' + comment.cbcCretim + '</span><br>';
		html += '<textarea id="textcomment'+ comment.cbcNum+'" cols="80" rows="2" disabled="">' + comment.cbcContent + '</textarea>';
		if(uiNum == comment.uiNum){
			html += '<button id="updateCommentBtn" onclick="updateComment('+comment.cbcNum+', this)">수정</button><button id="deleteCommentBtn" onclick="deleteComment('+comment.cbcNum+')">삭제</button>'
		} 
		html += '</tr><br>';
		html += '</hr>';
	}
	document.getElementById('comment').insertAdjacentHTML('beforeend', html);
}

// 댓글 등록 
async function insertComment() {
	if(uiNum === ''){
		alert('로그인이 필요한 서비스입니다.');
		location.href = "/views/user/login";
		return;
	}
	const cbcContent = document.getElementById('cbcContent');
	if (!cbcContent.value) {
		alert('댓글을 입력해주세요.');
		cbcContent.focus();
		return;
	}
	const param = {
		cbNum : '${param.cbNum}',
		uiNum : uiNum,
		uiNickname : '${userInfo.uiNickname}',
		cbcContent : cbcContent.value
	}
	const insertResponse = await fetch('/community-comments', {
		method : 'POST',
		headers : {
			'Content-Type' : 'application/json'
		},
		body : JSON.stringify(param)
	});
	if (!insertResponse.ok) {
	 	alert('댓글을 불러올 수 없습니다.');
	 	return;
	}
	const insertResult = await insertResponse.json();
	if (insertResult == 1) {
		alert('댓글이 등록되었습니다.');
		window.location.reload();
		return;
	}
	alert('다시 시도해주세요.');
}

// 댓글 수정
async function updateComment(cbcNum, obj) {
	document.getElementById('textcomment'+cbcNum).disabled = false;
	obj.innerText = '확인';
	obj.addEventListener('click', async function(){
		const check = confirm('댓글 수정하시겠습니까?');	
		if (check) {
			const updateResponse = await fetch('/community-comments/'+ cbcNum, {
				method: 'PATCH',
				headers: {
					'Content-Type' : 'application/json'
				},
				body: JSON.stringify({
					cbNum : ${param.cbNum},
					cbcContent: document.querySelector('#textcomment'+ cbcNum).value
				})
			});
			if (!updateResponse.ok) {
			 	alert('댓글 수정에 실패했습니다.');
			 	return;
			}
			const updateResult = await updateResponse.json();
			if (updateResult === 1) {
				alert('댓글 수정이 완료되었습니다.');
				window.location.reload();
				return;
			}
			alert('다시 시도해주세요.');
		}
	})
}
						
// 댓글 삭제 (오류..)
async function deleteComment(cbcNum) {
	var check = confirm('댓글을 삭제하시겠습니까?');
	if (check) {
		const deleteResponse = await fetch('/community-comments/' + cbcNum, {
			method : 'DELETE'
		});
		if (!deleteResponse.ok) {
		 	alert('댓글 삭제에 실패했습니다.');
		 	return;
		}
		const deleteResult = await deleteResponse.json();
		if (deleteResult === 1) {
			alert('댓글이 삭제되었습니다.');
			window.location.reload();
		}
		alert('다시 시도해주세요.');
	}
}

// 게시글 삭제
async function deleteBoard() {
	var check = confirm('게시물을 삭제하시겠습니까?');
	if (check) {
		const deleteResponse = await fetch('/community-board/${param.cbNum}', {
			method : 'DELETE'
		});
		if (!deleteResponse.ok) {
		 	alert('게시물 삭제에 실패했습니다.');
		 	return;
		}
		const deleteResult = await deleteResponse.json();
		if (deleteResult === 1) {
			alert('게시물이 삭제되었습니다.');
			location.href = '/views/community/list';
			return;
		}
		alert('다시 시도해주세요.');
	}
}
</script>

</body>
</html>
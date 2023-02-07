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
		<div id="detail" class="mb-4"></div>
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
// 댓글 수정 
function updateComment(cbcNum, obj) {
	document.querySelector('#textcomment'+cbcNum).disabled = false;
	obj.innerText = '확인'
	obj.addEventListener('click', function(){
		const check = confirm('댓글 수정하시겠습니까?');	
		if(check){
			fetch('/community-comments/'+ cbcNum, {
				method: 'PATCH',
				headers: {
					'Content-Type' : 'application/json'
				},
				body: JSON.stringify({
					cbNum : ${param.cbNum},
					cbcContent: document.querySelector('#textcomment'+ cbcNum).value
				})
			})
			.then(function(res){
				return res.json();
			})
			.then(function(result){
				if(result===1){
					alert('댓글 수정이 완료되었습니다.');
					window.location.reload();
					return;
				}
				alert('다시 시도해주세요.');
			})
		}
	})
}
		
// 좋아요 수
function likeCnt() {
	fetch('/board-like-cnt/${param.cbNum}')
	.then(function(res){
		return res.json();
		console.log(res);
	})
	.then(function(data){
		if (data != null) {
			document.querySelector('#likeBtn').value += '\u00A0\u00A0'+data ;
		}
	});
}
		
// 좋아요 불러오기
function getLikeInfo() {
	fetch('/board-like/${param.cbNum}')
	.then(function(res){
		return res.text();
	})
	.then(function(data){
		if (data != null) {
			document.querySelector('#likeBtn').value = '♥ 좋아요 취소';
		} else if (data ===  null) {
			document.querySelector('#likeBtn').value = '♡ 좋아요';
		}
	});
}
	
function updateLike(){
	const uiId = '${userInfo.uiId}';
	if(uiId===''){
		alert('로그인이 필요한 서비스입니다.');
		location.href="/views/user/login";
		return;
	}
	const param = {
		cbNum : '${param.cbNum}',
		uiNum : '${userInfo.uiNum}'
	}
	fetch('/board-like', {
		method:'POST',
		headers : {
			'Content-Type' : 'application/json'
		},
		body : JSON.stringify(param)
	})
	.then(function(res) {
		return res.json();
	})
	.then(function(likeChk) {
		if(likeChk == 0){
			document.querySelector('#likeBtn').value = '♥ 좋아요 취소';
		} else if (likeChk == 1) {
			document.querySelector('#likeBtn').value = '♡ 좋아요';
		}
		likeCnt();
	})
}
		
// 좋아요 취소 
function deleteBoard() {
	var check = confirm('게시물을 삭제하시겠습니까?');
	if(check) {
		fetch('/community-board/${param.cbNum}', {
		method : 'DELETE'
		})
		.then(function(res) {
			return res.json();
		})
		.then(function(data) {
			if (data === 1) {
				lert('게시글이 삭제되었습니다.');
				location.href = '/views/community/list';
			}
		});
	}
}
		
// 게시글 보기
function getBoard() {
	fetch('/community-board/${param.cbNum}')
	.then(function(res) {
		return res.json();
	})
	.then(function(communityBoard) {
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
		html += '<textarea class="form-control shadow-none" id="exampleFormControlTextarea1" rows="3" readonly style="height:323px"> ' + communityBoard.cbContent + '</textarea>';
 		if('${userInfo.uiNum}' == communityBoard.uiNum){
 			document.querySelector('#btnDiv').style.display='';
		};
		document.querySelector('#detail').innerHTML = html;
		document.querySelector('#commentCnt').innerHTML = '<span>['+communityBoard.cbCommentCnt +']</span>';
	});
}

window.onload = async function(){
	getBoard();
	getCommentList();
	getLikeInfo();
	likeCnt();
	await getFiles();
}

// 게시글에 등록한 파일 불러오기
async function getFiles() {
	const filesResponse = await fetch('/community-board-file/${param.cbNum}');
	if (!filesResponse.ok) {
	 	alert('등록된 파일을 불러올 수 없습니다.');
	 	return;
	}
	const filesResult = await filesResponse.json();
	console.log(filesResult);
	if (filesResult.length > 0) {
		let html = '';
		for (const file of filesResult) {
			html += '<img src="/files/' + file.cbfUuid + '">';
		}
		document.querySelector('#detail').insertAdjacentHTML('beforeend', html);
	}
}
		
// 댓글 목록 불러오기
function getCommentList() {
	fetch('/community-comments/${param.cbNum}')
	.then(function(res) {
		return res.json();
	})
	.then(function(list) {
		console.log(list);
		let html = '';
		for (let i = 0; i<list.length; i++) {
			const comment = list[i];
			html += '<hr>';
			html += '<tr>';
 			html += '<input type="hidden" id="commentUiNum" value='+ comment.uiNum +'>';
			html += '<span>' + comment.uiNickname + '</span>';
			html += '<span> &nbsp;' + comment.cbcCredat + '</span>';
			html += '<span> &nbsp;' + comment.cbcCretim + '</span><br>';
			html += '<textarea id="textcomment'+ comment.cbcNum+'" cols="80" rows="2" disabled="">' + comment.cbcContent + '</textarea>';
			if('${userInfo.uiNum}' == comment.uiNum){
				html += '<button id="updateCommentBtn" onclick="updateComment('+comment.cbcNum+', this)">수정</button><button id="deleteCommentBtn" onclick="deleteComment('+comment.cbcNum+')">삭제</button>'
			} 
			html += '</tr><br>';
			html += '</hr>';
		}
		document.querySelector('#comment').innerHTML = html;
	});
}

// 댓글 등록 
function insertComment() {
	const uiId = '${userInfo.uiId}';
	if(uiId===''){
		alert('로그인이 필요한 서비스입니다.');
		location.href="/";
		return;
	}
	const cbcContent = document.querySelector('#cbcContent').value;
	if (!cbcContent) {
		alert('댓글을 입력해주세요.');
		document.getElementById("cbcContent").focus();
		return;
	}
	const param = {
		cbNum : '${param.cbNum}',
		uiNum : '${userInfo.uiNum}',
		uiNickname : '${userInfo.uiNickname}',
		cbcContent : document.querySelector('#cbcContent').value
	}

	fetch('/community-comments', {
		method : 'POST',
		headers : {
			'Content-Type' : 'application/json'
		},
		body : JSON.stringify(param)
	})
	.then(function(res) {
		return res.json();
	})
	.then(function(result) {
		if (result == 1) {
			alert('댓글이 등록되었습니다.');
			window.location.reload();
		}
	});
}
						
// 댓글 삭제 (오류..)
function deleteComment(cbcNum) {
	var check = confirm('댓글을 삭제하시겠습니까?');
	if(check) {
		fetch('/community-comments/' + cbcNum, {
			method : 'DELETE'
		})
		.then(function(res) {
			return res.json();
		})
		.then(function(result) {
			if (result === 1) {
				alert('댓글이 삭제되었습니다.');
				window.location.reload();
			}
		});
	}
}
</script>

</body>
</html>
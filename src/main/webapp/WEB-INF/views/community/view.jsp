<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 상세화면</title>
<script
  src="https://code.jquery.com/jquery-3.6.3.min.js"
  integrity="sha256-pvPw+upLPUjgMXY0G+8O0xUf+/Im1MZjXxxgOcBQBXU="
  crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
<script	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
</head>
<body>
	<div id="detail"></div>
	<div id="btnDiv">
		<button
			onclick="location.href='/views/community/update?cbNum=${param.cbNum}'">수정</button>
		<button onclick="deleteBoard()">삭제</button>
	</div>
	<div>
		<input type="button" id="likeBtn" value="♡ 좋아요" onclick="updateLike()"/>
		<div id="likeBox"></div>
	</div>
	<div class="commentBox">
		<div class="commentCnt">
			댓글<span id="commentCnt"></span>
		</div>
		<div class="commentContentBox">
			<div id="comment"></div>
			<div id="confirm" style="display: none">
				<button onclick="updateConfirm()">수정</button>
				<button onclick="deleteConfirm()">삭제</button>
			</div>
			<div id="okBtn" style="display: none">
				<button onclick="updateComment()">수정</button>
				<button onclick="deleteComment()">삭제</button>
			</div>
			<textarea class="InputComment" id="cbcContent" cols="80" rows="2"
				placeholder="댓글을 입력하세요..."></textarea>
			<div class="insertBtn">
				<button onclick="insertComment()">등록</button>
			</div>
		</div>

	</div>
	<script>
		function likeCnt() {
			fetch('/board-like-cnt/${param.cbNum}')
			.then(function(res){
				return res.json();
//				console.log(res);
			})
			.then(function(data){
				if (data != null) {
					document.querySelector('#likeBtn').value += '\u00A0\u00A0'+data ;
				}
			});
		}
	
		function getLikeInfo() {
			fetch('/board-like/${param.cbNum}')
			.then(function(res){
				return res.json();
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
			}).then(function(res) {
				return res.json();
			}).then(function(likeChk) {
				if(likeChk == 0){
					document.querySelector('#likeBtn').value = '♥ 좋아요 취소';
				} else if (likeChk == 1) {
					document.querySelector('#likeBtn').value = '♡ 좋아요';
				}
				
			});
		}
		
		function deleteBoard() {
			fetch('/community-board/${param.cbNum}', {
				method : 'DELETE'
			}).then(function(res) {
				return res.json();
			}).then(function(data) {
				if (data === 1) {
					alert('게시글이 삭제되었습니다.');
					location.href = '/views/community/list';
				}
			});
		}

		function getBoard() {
			fetch('/community-board/${param.cbNum}').then(function(res) {
				return res.json();
			}).then(function(communityBoard) {
				let html = '';
				html += '번호 : ' + communityBoard.cbNum + '<br>';
				html += '제목 : ' + communityBoard.cbTitle + '<br>';
				html += '본문 : ' + communityBoard.cbContent + '<br>';
				html += '작성자 : ' + communityBoard.uiId + '<br>';
				html += '작성일 : ' + communityBoard.cbCredat + '<br>';
				html += '조회수 : ' + communityBoard.cbViewCnt + '<br>';
				document.querySelector('#detail').innerHTML = html;
				document.querySelector('#commentCnt').innerHTML = '<span>['+communityBoard.cbCommentCnt +']</span>';
			});
		}
		window.addEventListener('DOMContentLoaded', function(){
			getBoard();
			getCommentList();
			getLikeInfo();
			likeCnt();
		});

		// 댓글 목록 
		function getCommentList() {
			fetch('/community-comments/${param.cbNum}')
			.then(function(res) {
				return res.json();
			})
			.then(function(list) {
						let html = '';
						for (let i = 0; i < list.length; i++) {
							const commentList = list[i];
							if (commentList.uiNum == '${userInfo.uiNum}') {
							document.querySelector('#confirm').style.display = '';
							}
							html += '<tr>';
							html += '<input type="hidden" id='+ commentList.uiNum +'>';
							html += '<span>' + commentList.uiNickname + '</span>';
							html += '<span> &nbsp;' + commentList.cbcCredat + '</span>';
							html += '<span> &nbsp;' + commentList.cbcCretim + '</span><br>';
							html += '<textarea id="textcomment" cols="80" rows="2" disabled="">' + commentList.cbcContent + '</textarea>';
							html += '</tr><br>';
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
			}).then(function(res) {
				return res.json();
			}).then(function(result) {
				if (result == 1) {
					alert('댓글이 등록되었습니다.');
					window.location.reload();
				}

			});

		}
		
		// 댓글 수정 (오류..)
/*		function updateComment() {
 				if (confirm('댓글을 수정하시겠습니까?')==true) {
					document.getElementById('textcomment').disabled=false;
					document.getElementById('textcomment').focus();
					html += document.querySelector('#updateComment').
				} */
				
				
			function updateConfirm() {
				var check = confirm('댓글을 수정하시겠습니까?');
				if(check) {
					document.querySelector('#confirm').style.display = 'none';
					document.querySelector('#okBtn').style.display = '';
					document.getElementById('textcomment').disabled=false;
					document.getElementById('textcomment').focus();
					}
				}
				
			function updateComment() {
				const param = {
					cbcContent : document.querySelector('#cbcContent').value
				}
			
				fetch('/community-comments/${param.cbcNum}', {
				method:'PATCH',
				headers : {
					'Content-Type' : 'application/json'
				},
				body : JSON.stringify(param)
			})
			.then(async function(res){
				if(res.ok){
					return res.json();
				}else{
					const err = await res.text();
					throw new Error(err);
				}
			})
			.then(function(data){
				if(data===1){
					alert('댓글이 수정되었습니다.');
					window.location.reload();
				}
				
			})
			.catch(function(err){
				alert(err);
			}); 
		}	
	

		// 댓글 삭제 (오류..)
		function deleteComment() {
			fetch('/community-comments/${param.cbcNum}', {
				method : 'DELETE'
			}).then(function(res) {
				return res.json();
			}).then(function(result) {
				if (result === 1) {
					alert('댓글이 삭제되었습니다.');
					window.location.reload();
				}
			});
		}
		
	</script>

</body>
</html>
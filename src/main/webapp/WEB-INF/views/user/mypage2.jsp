<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>user-my-page</title>
<%@ include file="/resources/common/header.jsp"%>
</head>
<body>
	<section class="page-header bg-tertiary">
		<div class="container">
			<div class="row">
				<div class="col-8 mx-auto text-center">
					<p class="text-primary text-uppercase fw-bold">mypage</p>
					<h2 class="mb-3 text-capitalize">계정 관리</h2>
				</div>
				<div class="container">
					<div class="row">
						<div class="col-lg-9">
							<div class="align-items-center mb-5">
								<div class="row position-relative gy-4">
									<div class="icon-box-item">
										<div class="block bg-white">
											<div class="difference-of-us-item icon me-4 mb-4 mb-sm-0"> <i class="fas fa-shield-alt mt-4" style="font-size:36px"></i>
			            					</div>
											<!-- 프로필 칸 -->
											<h3 class="mb-3">개인정보 수정</h3>
											이름: ${userInfo.uiName}
											나이 : ${userInfo.uiAge}
											닉네임 : ${userInfo.uiNickname}
										</div>
									</div>
								</div>
							</div>
						<div class="row justify-content-between">
			      			<div class="col-lg-6">
			      			
			      				<!-- 좋아요 커뮤니티 게시물 -->
			        			<div class="difference-of-us-item p-3 rounded mr-0">
			          				<div class="d-block align-items-center m-2">
			            				<div class="block">
				              				<h4 class="mb-4" style="text-align:center;">♥한 게시글</h4>
				              				<table class="table">
												<tr>
													<th>카테고리</th>
													<th>제목</th>
												</tr>
												<tbody id="myLikeBoard"></tbody>
											</table>
			           					</div>
			          				</div>
			        			</div>
			        			

			        		</div>
			        			<!-- 내가 작성한 커뮤니티 게시물 -->
								<div class="col-lg-6">		        			
			        			<div class="difference-of-us-item p-3 rounded mr-0">
			          				<div class="d-block align-items-center m-2">
			            				<div class="block">
				              				<h4 class="mb-4" style="text-align:center;">작성 게시글</h4>
				              				<table class="table">
												<tr>
													<th>카테고리</th>
													<th>제목</th>
												</tr>
												<tbody id="myBoard"></tbody>
											</table>
			           					</div>
			          				</div>
			        			</div>
			        			</div>
			    </div>
			    
			    <div class="container">
						<div class="row justify-content-between">
					        <div class="difference-of-us-item p-3 rounded mr-0">
					          	<div class="d-block align-items-center m-2">
							        <h3 style="display:inline-block">${userInfo.uiNickname}&nbsp;님의&nbsp;&nbsp;<b style="color:#fbd971;">Challenge !</b></h3>	
							        <button class="btn btn-primary mb-1" onclick="addChallenge()" style="float:right;">추가하기!</button>
							        <textarea class="form-control mb-3" id="ucChallenge" style="resize: none;" placeholder="New Challenge"></textarea>
									<table class="table" style="text-align:center;">
										<tr>
											<th>번호</th>
											<th>도전 과제</th>
											<th>작성일</th>
											<th>수정일</th>
										</tr>
										<tbody id="tBody" class="tbodyArea"></tbody>
									</table>	
						       </div>
						    </div>
		    			</div>
			</div>
			    
			    
				</div>
				<div class="col-lg-3">
					<div class="widget widget-categories">	
						<ul class="list-unstyled widget-list">
							<li><a onclick="showConfirm('update')">회원정보 수정</a></li>
							<li><a onclick="showConfirm('delete')">회원 탈퇴</a>
							</li>
							<li><a onclick="location.href='/'">홈으로</a>
							</li>
						</ul>
					</div>
					<!-- latest post -->
					<div class="widget">
						<!-- 가입한 소모임  -->
						<h5 class="widget-title">
							<span>${userInfo.uiNickname}님이&nbsp;&nbsp;가입한&nbsp;&nbsp;소모임</span>
						</h5>
						<ul class="list-unstyled widget-list">
							<div id="myParty"></div>
						</ul>
		
						<!-- 좋아요 소모임  -->
						<h5 class="widget-title">
							<span>${userInfo.uiNickname}님이&nbsp;&nbsp;♥한&nbsp;&nbsp;소모임</span>
						</h5>
						<ul class="list-unstyled widget-list">
							<div id="likeParty"></div>
						</ul>
		
						<!-- 좋아요 산 -->
						<h5 class="widget-title">
							<span>${userInfo.uiNickname}님이&nbsp;&nbsp;♥한&nbsp;&nbsp;산</span>
						</h5>
						<ul class="list-unstyled widget-list">
							<div id="likeMountain"></div>
						</ul>
					</div>
				</div>
			</div>
				</div>
				

				
				
			</div>
		</div>
		<div class="container">

	  </div>
	</section>
	<section class="section">
		<div class="container">

</div>
</section>
	
	<!-- 프로필 사진 등록 칸-->
	<c:if test="${userInfo.uiImgPath eq null}">
		<br>
		<h3>프로필 사진</h3>
		사진을 추가해 주세요.
		<div
			style="width: 150px; height: 200px; background-color: grey; margin-top: 10px; margin-bottom: 10px"></div>
		<input type="file" id="image" accept="image/png, image/jpeg">
		<br>
		<button onclick="profileUpload()">프로필 사진 설정</button>
		<br>
	</c:if>

	<c:if test="${userInfo.uiImgPath ne null}">
		<img src="${userInfo.uiImgPath}">
		<h3>프로필 사진</h3>
		<form action="/updatImg" method="post" enctype="multipart/form-data">
			<input type="hidden" name="userNum" value="${userInfo.uiNum}">
			<input type="file" id="image" accept="image/png, image/jpeg">
			<button onclick="changeImg()">사진변경</button>
		</form>
		<br>
	</c:if>

	<script>
		/*개인정보 함수 칸 */

		/* 수정or삭제 버튼 클릭시 비밀번호 확인칸이 생기는 함수 */
		let _type;
		function showConfirm(type) {
			_type = type;
			document.querySelector('#confirm').style.display = '';
			console.log(_type);
			uiPwd.focus();
		}

		/*각 요청에 맞게 수정이동 또는 삭제실행 함수 */

		function passwordConfirm() {
			let method = 'POST';
			if (_type === 'delete') {
				method = 'DELETE';
			}
			
			console.log(method);
			const param = {
				uiPwd : document.querySelector('#uiPwd').value
			}
			console.log(param);

		/* 	const formData = new FormData();
			const inputImg = document.querySelector('#image');
			if(inputImg.getAttribute('type') === 'file'){
				if(inputImg.files.length==1){
					formData.append('multipartFiles',)
				}
			}
			 */
			 
			fetch('/user-infos/${userInfo.uiNum}', {
				method : method,
				headers : {
					'Content-Type' : 'application/json'
				},
				body : JSON.stringify(param)
			}).then(function(res) {
				return res.json();
				console.log(res);
			}).then(function(data) {
				
				if (data === true) {
					if (_type === 'update') {
						location.href = '/views/user/update';
					} else if (_type === 'delete') {
						/* alert('삭제완료!'); */
						location.href = '/views/user/delete';
					}
				} else {
					alert('비밀번호를 확인해주세요');
				}
			});
		}
		


		/* 개인정보 칸 함수 끝 */

		/*리스트 함수 칸*/

		/* 챌린지 불러오기 */
		function getChallengeList() {
			fetch("/challenge-list/${userInfo.uiNum}")
					.then(function(res) {
						return res.json();
					})
					.then(
							function(userChallenge) {
								let html = '';
								for (let i = 0; i < userChallenge.length; i++) {
									html += '<tr>'
									html += '<td>' + (i+1) 
											+ '</td>';
									html += '<td><a href="/views/challengeList/view?ucNum='
											+ userChallenge[i].ucNum
											+ '">'
											+ userChallenge[i].ucChallenge
											+ '</td>';
									html += '<td>' + userChallenge[i].ucCredat
											+ '</td>';
									html += '<td>' + userChallenge[i].ucLmodat
											+ '</td>';
									html += '</tr>'
								}
								document.querySelector('#tBody').innerHTML = html;
							});
		}
		window.onload = function() {
			getChallengeList();
			getMyPartyList();
			getLikePartyList();
			getLikeMountainList();
			getMyBoardList();
			getLikeBoardList();
		}

		
		/* 새로운 챌린지 추가하기 */
		function addChallenge() {

			const param = {
				ucChallenge : document.querySelector('#ucChallenge').value
			}
			console.log(param);
			
			fetch('/challenge-add', {
				method : 'POST',
				headers : {
					'Content-Type' : 'application/json'
				},
				body : JSON.stringify(param)
			}).then(function(res) {
				return res.json()
			}).then(function(data) {
				if(data===1) {
					alert('추가 완료!');
					location.reload();
				}
			});
		}

		/*리스트 함수 칸 끝*/
		
		//가입한 소모임
		function getMyPartyList(){
			fetch('/user-party/${userInfo.uiNum}')
			.then(response => response.json())
			.then(list=> {
				console.log(list);
				let html= '';
				for(let i=0; i<list.length; i++){
					html += '<li class="d-flex widget-post align-items-center" style="cursor:pointer;" onclick="location.href=\'/views/party/view?piNum=' + list[i].piNum + '\'">' + list[i].piName;
					if(list[i].pmGrade==1){
						html += ' (★)' 
					}
					html += '</li>';
					document.querySelector('#myParty').innerHTML = html;
				}
			})
		}
		
		//좋아요(♥한) 소모임
		function getLikePartyList(){
			fetch('/user-party-like/${userInfo.uiNum}')
			.then(response => response.json())
			.then(list=> {
				console.log(list);
				let html= '';
				for(let i=0; i<list.length; i++){
					html += '<li style="cursor:pointer;" onclick="location.href=\'/views/party/view?piNum=' + list[i].piNum + '\'">' + list[i].piName + '</li>';
					document.querySelector('#likeParty').innerHTML = html;
				}
			})
		}
		
		//좋아요(♥한) 산
		function getLikeMountainList(){
			fetch('/user-mountain-like/${userInfo.uiNum}')
			.then(response => response.json())
			.then(list=> {
				console.log(list);
				let html= '';
				for(let i=0; i<list.length; i++){
					html += '<li style="cursor:pointer;" onclick="location.href=\'/views/mountain/view?miNum=' + list[i].miNum + '\'">' + list[i].mntnm + '</li>';
					document.querySelector('#likeMountain').innerHTML = html;
				}
			})
		}
		
		//좋아요(♥한) 커뮤니티게시글
		function getLikeBoardList(){
			fetch('/user-board-like/${userInfo.uiNum}')
			.then(response => response.json())
			.then(list => {
				console.log(list);
				let html = '';
				for(let i=0; i<list.length; i++){
					html += '<tr>';
					html += '<td>' + list[i].cbCategory + '</td>';
					html += '<td style="cursor:pointer;" onclick="location.href=\'/views/community/view?cbNum=' + list[i].cbNum + '\'">' + list[i].cbTitle + '</td>';
					html += '</tr>';
				}
				document.querySelector('#myLikeBoard').innerHTML = html;
			})
		}
		
		//내가 작성한 커뮤니티 게시글
		function getMyBoardList(){
			fetch('/user-board/${userInfo.uiNum}')
			.then(response => response.json())
			.then(list => {
				console.log(list);
				let html = '';
				for(let i=0; i<list.length; i++){
					html += '<tr>';
					html += '<td>' + list[i].cbCategory + '</td>';
					html += '<td style="cursor:pointer;" onclick="location.href=\'/views/community/view?cbNum=' + list[i].cbNum + '\'">' + list[i].cbTitle + '</td>';
					html += '</tr>';
				}
				document.querySelector('#myBoard').innerHTML = html;
			})
		}
		

	</script>
</body>
</html>
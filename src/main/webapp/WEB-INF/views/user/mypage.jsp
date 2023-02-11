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
					<h2 class="mb-3 text-capitalize">마이페이지</h2>
				</div>
				<div class="container">
					<div class="row">
						<div class="col-lg-9">
							<div class="align-items-center mb-5">
								<div class="icon-box-item">
									<div class="block bg-white">
										<div class="row justify-content-between">
											<div class="col-lg-6">
												<div>
													<!-- 프로필 사진 등록 칸-->
													<c:if test="${userInfo.uiImgPath eq null}">
														<h3>프로필 사진</h3>
														<p>사진을 추가해 주세요.</p>
														<div class="row">
															<div style="width: 150px; height: 200px; background-color: grey;"></div>
															<div class="w-50" style="padding-top: 78px;">
																<input type="file" id="image" accept="image/png, image/jpeg" class="w-100">
																<button class="btn btn-light p-3" onclick="profileUpload()">프로필 사진 설정</button>
															</div>
														</div>
													</c:if>
		
													<c:if test="${userInfo.uiImgPath ne null}">
														<img src="${userInfo.uiImgPath}">
														<h3>프로필 사진</h3>
														<form action="/updatImg" method="post"
															enctype="multipart/form-data">
															<input type="hidden" name="userNum"
																value="${userInfo.uiNum}"> <input type="file"
																id="image" accept="image/png, image/jpeg">
															<button onclick="changeImg()">사진변경</button>
														</form>
													</c:if>
												</div>
												<!-- 프로필 칸 -->
												<h3 class="mb-3"><span class= "border-sm-tit">개인정보 수정</span></h3>
												이름: ${userInfo.uiName} 나이 : ${userInfo.uiAge} 닉네임 :
												${userInfo.uiNickname}
											</div>
											<div class="col-lg-6">
												<!-- 프로필 칸 -->
												<h3 class="mb-3"><span class= "border-sm-tit">개인정보 수정</span></h3>
												이름: ${userInfo.uiName} 나이 : ${userInfo.uiAge} 닉네임 :
												${userInfo.uiNickname}
											</div>
										</div>
									</div>
								</div>
							</div>	
					<div class="row justify-content-between">
						<div class="col-lg-6">
							<!-- 좋아요 커뮤니티 게시물 -->
							<div class="accordion" id="accordionPanelsStayOpenExample">
							  <div class="accordion-item">
							    <h2 class="accordion-header" id="panelsStayOpen-headingfive">
							      <button class="accordion-button collapsed acc-tit" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapsefive" aria-expanded="false" aria-controls="panelsStayOpen-collapsefive">
							        ♥한&nbsp;&nbsp;게시글
							      </button>
							    </h2>
							    <div id="panelsStayOpen-collapsefive" class="accordion-collapse collapse" aria-labelledby="panelsStayOpen-headingfive">
							      <div class="accordion-body">
							        <table class="table" style="text-align: center;">
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
						</div>
						<!-- 내가 작성한 커뮤니티 게시물 -->
						<div class="col-lg-6">
							<div class="accordion" id="accordionPanelsStayOpenExample">
								<div class="accordion-item">
							    	<h2 class="accordion-header" id="panelsStayOpen-headingsix">
							      		<button class="accordion-button collapsed acc-tit" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapsesix" aria-expanded="false" aria-controls="panelsStayOpen-collapsesix">작성 게시글</button>
							    	</h2>
								    <div id="panelsStayOpen-collapsesix" class="accordion-collapse collapse" aria-labelledby="panelsStayOpen-headingsixs">
								      <div class="accordion-body">
										<table class="table" style="text-align: center;">
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
					</div>
					<div class="container mt-5">
						<div class="row justify-content-between">
							<div class="difference-of-us-item p-3 rounded mr-0 bg-white">
								<div class="d-block align-items-center m-2">
									<h3 style="display: inline-block">${userInfo.uiNickname}&nbsp;님의&nbsp;&nbsp;<b
											style="color: #558f65;">Challenge !</b>
									</h3>
									<button class="btn btn-primary mb-1" onclick="addChallenge()"
										style="float: right;">추가하기</button>
									<textarea class="form-control mb-3" id="ucChallenge"
										style="resize: none;" placeholder="New Challenge"></textarea>
									<table class="table" style="text-align: center;">
										<tr>
											<th>번호</th>
											<th>도전 과제</th>
											<th>작성일</th>
											<th>수정일</th>
											<th>삭제</th>
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
								<div id="confirm" style="display: none">
									<input type="password" class="form-control mb-2" id="uiPwd"
										placeholder="비밀번호">
									<button class="btn btn-dark mb-2" onclick="passwordConfirm()">비밀번호 확인</button>
								</div>
								<ul class="list-unstyled widget-list">
									<li class="mb-2"><a onclick="showConfirm('update')">회원정보 수정</a></li>
									<li class="mb-2"><a onclick="showConfirm('delete')">회원 탈퇴</a></li>
									<li class="mb-2"><a onclick="location.href='/'">홈으로</a></li>
								</ul>
							</div>						
							<div class="accordion" id="accordionPanelsStayOpenExample">
							  <div class="accordion-item">
							    <h2 class="accordion-header" >
							      <button class="accordion-button-update collapsed acc-tit" type="button">
							        ${userInfo.uiNickname}님의&nbsp;&nbsp;활동
							      </button>
							    </h2>
							  </div>
							  <div class="accordion-item">
							    <h2 class="accordion-header" id="panelsStayOpen-headingTwo">
							      <button class="accordion-button collapsed acc-tit" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseTwo" aria-expanded="false" aria-controls="panelsStayOpen-collapseTwo">
							        가입한&nbsp;&nbsp;소모임
							      </button>
							    </h2>
							    <div id="panelsStayOpen-collapseTwo" class="accordion-collapse collapse" aria-labelledby="panelsStayOpen-headingTwo">
							      <div class="accordion-body">
										<span id="myParty" class="sp-color-b"></span>
							      </div>
							    </div>
							  </div>
							  <div class="accordion-item">
							    <h2 class="accordion-header" id="panelsStayOpen-headingThree">
							      <button class="accordion-button collapsed acc-tit" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseThree" aria-expanded="false" aria-controls="panelsStayOpen-collapseThree">
							        ♥한&nbsp;&nbsp;소모임
							      </button>
							    </h2>
							    <div id="panelsStayOpen-collapseThree" class="accordion-collapse collapse" aria-labelledby="panelsStayOpen-headingThree">
							      <div class="accordion-body">
										<span id="likeParty" class="sp-color-b"></span>
							      </div>
							    </div>
							  </div>							  
							  <div class="accordion-item">
							    <h2 class="accordion-header" id="panelsStayOpen-headingfour">
							      <button class="accordion-button collapsed acc-tit" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapsefour" aria-expanded="false" aria-controls="panelsStayOpen-collapsefour">
							        ♥한&nbsp;&nbsp;산
							      </button>
							    </h2>
							    <div id="panelsStayOpen-collapsefour" class="accordion-collapse collapse" aria-labelledby="panelsStayOpen-headingfour">
							      <div class="accordion-body">
										<span id="likeMountain" class="sp-color-b"></span>
							      </div>
							    </div>
							  </div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="container"></div>
	</section>
	
	<script>
	
	//윈도우 시작시 자동시작함수
	window.onload = function() {
		getChallengeList();
		getMyPartyList();
		getLikePartyList();
		getLikeMountainList();
		getMyBoardList();
		getLikeBoardList();
	}
	
		
	
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
									html += '<td><button class="xbox" value=' + userChallenge[i].ucNum + '>x</button></td>';
									html += '</tr>'
								}
								document.querySelector('#tBody').innerHTML = html;
							});
		}	

		
		/* 새로운 챌린지 추가하기 */
		function addChallenge() {

			const ucChallenge = document.querySelector('#ucChallenge').value;
			
			if(ucChallenge == ''){
				alert('챌린지를 추가해보세요!');
				return;
			}

			if(ucChallenge.trim().length > 20){
				alert('챌린지의 길이는 20자를 초과할 수 없습니다!');
				return;
			}
			
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

		
		
		//챌린지 삭제
		$(".xbox").click(function(){
			alert($(this).val);
		});
		
		
		
		
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
					html += '<hr>'
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
					html += '<hr>'
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
					html += '<hr>'
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
					html += '<td style="cursor:pointer; text-align: left;" onclick="location.href=\'/views/community/view?cbNum=' + list[i].cbNum + '\'">' + list[i].cbTitle + '</td>';
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
					html += '<td style="cursor:pointer; text-align: left;" onclick="location.href=\'/views/community/view?cbNum=' + list[i].cbNum + '\'">' + list[i].cbTitle + '</td>';
					html += '</tr>';
				}
				document.querySelector('#myBoard').innerHTML = html;
			})
		}
		

	</script>
</body>
</html>
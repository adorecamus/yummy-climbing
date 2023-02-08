<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>user-update-page</title>
<%@ include file="/resources/common/header.jsp"%>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</head>
<body>

	<input type="text" id="uiId" value="${userInfo.uiId}" disabled>아이디
	<br>
	<input type="text" id="uiName" value="${userInfo.uiName}" disabled>이름
	<br>
	<input type="text" id="uiAge" value="${userInfo.uiAge}" disabled>나이
	<br>
	<input type="text" id="uiNickname" placeholder="닉네임을 입력하세요">닉네임
	<button onclick="checkNickname()">중복 확인</button>
	<br>
	<input type="text" id="uiAddr" value="${userInfo.uiAddr}" disabled>주소
	<br>
	<input type="text" id="uiZonecode" value="${userInfo.uiZonecode}" disabled>우편번호
	<br>
	<button onclick="searchAddr()">주소검색</button>
	<br>
	
	<br>
	<button onclick="join()">정보수정</button>
	<button onclick="location.href='/'">홈으로</button>

<section class="section bg-tertiary">
	<div class="container" style="width:600px">
		<div class="justify-content-center align-items-center">
			<div class="section-title text-center">
				<p class="text-primary text-uppercase fw-bold">Edit your information</p>
				<img loading="prelaod" decoding="async" class="img-fluid" width="67px" src="/resources/images/banner/swan.png" alt="맛등산" style="cursor:pointer;" onclick="location.href='/'">
				<h2 style="color:#6db596">회원정보 수정</h2>
			</div>
		</div>
			<div class="shadow p-5 bg-white">
				<div class="contact-form">
					<div class="row form-group mb-4 pb-2">
						<div>
						<label type="text" class="form-label" style="left:23px;">ID</label>
						<input type="text" class="form-control shadow-none" id="uiId" value="${userInfo.uiId}" disabled>
						</div>
					</div>
					<div class="form-group mb-4 pb-2">
						<label class="form-label">PASSWORD</label>
						<input type="password" class="form-control shadow-none" id="uiPwd" placeholder="비밀번호">
					</div>
					<div class="form-group mb-4 pb-2">
						<label class="form-label">PASSWORD CHECK</label>
						<input type="password" class="form-control shadow-none" id="uiPwdCheck" placeholder="비밀번호 확인">
					</div>
					<div class="row form-group mb-4 pb-2">
						<div style="width:74%">
						<label class="form-label">NICKNAME</label>
						<input type="text" class="form-control shadow-none"id="uiNickname" placeholder="닉네임을 입력하세요">닉네임
						</div>
						<div class="searchBtn" style="width:26%">
							<button class="btn btn-primary search" onclick="checkNickname()" style="margin:0 5px; padding:13px 11px;">중복 확인</button>
						</div>
					</div>
					<div class="form-group mb-4 pb-2">
						<label class="form-label">NAME</label>
						<input type="text" class="form-control shadow-none" id="uiName" value="${userInfo.uiName}" disabled>이름
					</div>
					<div class="form-group mb-4 pb-2">
						<label class="row form-label">AGE</label>
						<input type="text" class="form-control shadow-none" id="uiAge" value="${userInfo.uiAge}" disabled>
					</div>
					<div class="form-group mb-4 pb-2">
						<label class="form-label">ADDRESS</label>
						<input type="text" class="form-control shadow-none" id="uiAddr" placeholder="주소" onclick="searchAddr()">
					</div>
					<div class="row form-group pb-2">
						<div style="width:74%">
						<label class="form-label">ZONE CODE</label>
						<input type="text" class="form-control shadow-none" id="uiZonecode" placeholder="우편번호" disabled>
						</div>
						<div class="addrBtn" style="width:26%; margin:0 auto;">
							<button class="btn btn-outline-primary" style="margin:0 5px; padding:13px 11px;" onclick="searchAddr()">주소검색</button>
						</div>
					</div>
					<div class="row loginBtn mt-3">
						<button class="btn btn-outline-primary" style="width:46%; margin:0 13px 0 10px;" onclick="join()">정보수정</button>
						<button class="btn btn-outline-primary" style="width:46%;" onclick="location.href='/'">홈으로</button>
					</div>
				</div>
			</div>
		</div>
</section>

	<script>
		function searchAddr() {
			const daumWin = new daum.Postcode({
				oncomplete : function(data) {
					document.querySelector('#uiZonecode').value = data.zonecode;
					//주소의 우편번호
					document.querySelector('#uiAddr').value = data.address;
					//일반 주소
				}
			});
			daumWin.open();

		}

		/*동일한 닉네임이 있는지 확인하는 함수 */
		let isExistName = false;

		function checkNickname() {
			const uiNickname = document.querySelector('#uiNickname').value;
			fetch('/sign-up/checkNickname/' + uiNickname)
			.then(function(data) {
				return data.json();
			}).then(function(res) {
				if (res===false) {
					alert('사용 가능한 닉네임 입니다.');
					isExistName = true;
				} else {
					alert('이미 사용중인 닉네임 입니다.');
					isExistName = false;
				}
			});

		}

		//수정 회원정보
		function join() {
			
			if(!isExistName){
				alert('닉네임을 확인해주세요.');
				return;
			}
			const param = {
				uiNickname : document.querySelector('#uiNickname').value,
				uiAddr : document.querySelector('#uiAddr').value,
				uiZonecode : document.querySelector('#uiZonecode').value
			}
			console.log(param);

			fetch('/user-infos/${userInfo.uiNum}', {
				method : 'PATCH',
				headers : {
					'Content-Type' : 'application/json'
				},
				body : JSON.stringify(param)
			})
			.then(function(res){
					return res.json()
				})
				.then(function(data){
					if(data===true){
						alert('수정이 성공하였습니다.')
						location.href='/views/user/mypage';
					}
				})
				.catch(function(err){
					alert('오류가 발생하였습니다.')
					location.replace();
	})
		}
	</script>

</body>
</html>
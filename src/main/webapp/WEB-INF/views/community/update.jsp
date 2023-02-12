<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 수정</title>
<%@ include file= "/resources/common/header.jsp" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
<section class="homepage_tab position-relative" style="margin: 0 auto;">
	<div class="container mt-5">
		<div class="row justify-content-center">
			<div class="col-lg-8 mt-5 mb-3">
				<div class="text-center">
					<p class="text-primary text-uppercase fw-bold ">community</p>
					<h2>커뮤니티</h2>
				</div>
			</div>
		<div class="col-lg-10">
		<div class="rounded shadow bg-white p-5 tab-content mb-3"
			id="pills-tabContent">
			<div class="tab-pane fade show active"
				id="pills-how-much-can-i-recive" role="tabpanel"
				aria-labelledby="pills-how-much-can-i-recive-tab">
				<div class="content-block" style="width: 87%; margin: 0 auto">

					</div>
					<div class="row mb-2 pb-2">
						<label class="col-sm-3 col-form-label">카테고리</label>
						<div class="col-sm-4">
							<select type="text" id="cbCategory" class="form-select gender" >
								<option value="infoBoard">정보게시판</option>
								<option value="freeBoard">자유게시판</option>
								<option value="questionBoard">질문게시판</option>
								<option value="reviewBoard">후기게시판</option>
							</select>
						</div>
					</div>
					<div class="row mb-2 pb-2">
						<label class="col-sm-3 col-form-label">작성자</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" id="uiId" value="${userInfo.uiId}" readonly>
						</div>
					</div>
					<div class="row mb-2 pb-2">
						<label class="col-sm-3 col-form-label">제목</label>
						<div class="col-sm-9">
							<input type="text" class="form-control" id="cbTitle">
						</div>
					</div>
					<div class="mb-3">
						<textarea class="form-control" id="cbContent" placeholder="내용을 입력해주세요."></textarea>
					</div>
						<div class="row mb-3 align-items-center justify-content-between">
						<!-- 파일을 불러와서 있으면 여기에 이미지+이름을 보여주고 아니면 input을 보여주자 -->
							<div class="col-4 ">file1
								<td><input type="file" id="file1"></td>
							</div>
							<div class="col-4 " >file2
								<td><input type="file" id="file2"></td>
							</div>
							<div class="col-4 " >file3
								<td><input type="file" id="file3"></td>
							</div>
							
							<div class="img_wrap row mb-3 align-items-center justify-content-start">
								<div class="file1 col-4"></div>
								<div class="file2 col-4"></div>
								<div class="file3 col-4"></div>
							</div>
						</div>
					<div>
						<button onclick="updateBoard()" class="btn btn-primary" style="float: right;">수정</button>
						<button onclick="location.href='/views/community/list'" class="btn btn-secondary">목록</button>
					</div>
				</div>
			</div>
		</div>
		<div class="has-shapes">	
	      <svg class="shape shape-left text-light" width="290" height="709" viewBox="0 0 290 709" fill="none"
	        xmlns="http://www.w3.org/2000/svg">
	        <path
	          d="M-119.511 58.4275C-120.188 96.3185 -92.0001 129.539 -59.0325 148.232C-26.0649 166.926 11.7821 174.604 47.8274 186.346C83.8726 198.088 120.364 215.601 141.281 247.209C178.484 303.449 153.165 377.627 149.657 444.969C144.34 546.859 197.336 649.801 283.36 704.673"
	          stroke="currentColor" stroke-miterlimit="10" />
	        <path
	          d="M-141.434 72.0899C-142.111 109.981 -113.923 143.201 -80.9554 161.895C-47.9878 180.588 -10.1407 188.267 25.9045 200.009C61.9497 211.751 98.4408 229.263 119.358 260.872C156.561 317.111 131.242 391.29 127.734 458.631C122.417 560.522 175.414 663.463 261.437 718.335"
	          stroke="currentColor" stroke-miterlimit="10" />
	        <path
	          d="M-163.379 85.7578C-164.056 123.649 -135.868 156.869 -102.901 175.563C-69.9331 194.256 -32.086 201.934 3.9592 213.677C40.0044 225.419 76.4955 242.931 97.4127 274.54C134.616 330.779 109.296 404.957 105.789 472.299C100.472 574.19 153.468 677.131 239.492 732.003"
	          stroke="currentColor" stroke-miterlimit="10" />
	        <path
	          d="M-185.305 99.4208C-185.982 137.312 -157.794 170.532 -124.826 189.226C-91.8589 207.919 -54.0118 215.597 -17.9666 227.34C18.0787 239.082 54.5697 256.594 75.4869 288.203C112.69 344.442 87.3706 418.62 83.8633 485.962C78.5463 587.852 131.542 690.794 217.566 745.666"
	          stroke="currentColor" stroke-miterlimit="10" />
	      </svg>
	      <svg class="shape shape-right text-light" width="474" height="511" viewBox="0 0 474 511" fill="none"
	        xmlns="http://www.w3.org/2000/svg">
	        <path
	          d="M601.776 325.899C579.043 348.894 552.727 371.275 520.74 375.956C478.826 382.079 438.015 355.5 412.619 321.6C387.211 287.707 373.264 246.852 354.93 208.66C336.584 170.473 311.566 132.682 273.247 114.593C220.12 89.5159 155.704 108.4 99.7772 90.3769C53.1531 75.3464 16.3392 33.2759 7.65012 -14.947"
	          stroke="currentColor" stroke-miterlimit="10" />
	        <path
	          d="M585.78 298.192C564.28 319.945 539.378 341.122 509.124 345.548C469.472 351.341 430.868 326.199 406.845 294.131C382.805 262.059 369.62 223.419 352.278 187.293C334.936 151.168 311.254 115.417 275.009 98.311C224.74 74.582 163.815 92.4554 110.913 75.3971C66.8087 61.1784 31.979 21.3767 23.7639 -24.2362"
	          stroke="currentColor" stroke-miterlimit="10" />
	        <path
	          d="M569.783 270.486C549.5 290.99 526.04 310.962 497.501 315.13C460.111 320.592 423.715 296.887 401.059 266.641C378.392 236.402 365.963 199.965 349.596 165.901C333.24 131.832 310.911 98.1265 276.74 82.0034C229.347 59.6271 171.895 76.4848 122.013 60.4086C80.419 47.0077 47.5905 9.47947 39.8431 -33.5342"
	          stroke="currentColor" stroke-miterlimit="10" />
	        <path
	          d="M553.787 242.779C534.737 262.041 512.691 280.809 485.884 284.722C450.757 289.853 416.568 267.586 395.286 239.173C373.993 210.766 362.308 176.538 346.945 144.535C331.581 112.533 310.605 80.8723 278.502 65.7217C233.984 44.6979 180.006 60.54 133.149 45.4289C94.0746 32.8398 63.2303 -2.41965 55.9568 -42.8233"
	          stroke="currentColor" stroke-miterlimit="10" />
	        <path
	          d="M537.791 215.073C519.964 233.098 499.336 250.645 474.269 254.315C441.41 259.126 409.422 238.286 389.513 211.704C369.594 185.13 358.665 153.106 344.294 123.17C329.923 93.2337 310.293 63.6078 280.258 49.4296C238.605 29.7646 188.105 44.5741 144.268 30.4451C107.714 18.6677 78.8538 -14.3229 72.0543 -52.1165"
	          stroke="currentColor" stroke-miterlimit="10" />
	      </svg>
	    </div>
	</div>
</section>

<script>
async function getBoard(){
	const boardResponse = await fetch('/community-boards/${param.cbNum}?update=yes');
	if (!boardResponse.ok) {
		const errorResult = await boardResponse.json();
		alert('게시글을 불러올 수 없습니다.');
		location.href = '/views/community/list';
		return;
	}
	const communityBoard = await boardResponse.json();
	console.log(communityBoard);
	document.getElementById('cbTitle').value = communityBoard.cbTitle;
	document.getElementById('cbContent').value = communityBoard.cbContent;
}

window.onload = async function(){
	await getBoard();
	await getFiles();
}

//게시글에 등록한 파일 불러오기
async function getFiles() {
	const filesResponse = await fetch('/community-board-file/${param.cbNum}');
	if (!filesResponse.ok) {
	 	alert('등록된 파일을 불러올 수 없습니다.');
	 	return;
	}
	const filesResult = await filesResponse.json();
	console.log(filesResult);
	if (filesResult.length > 0) {
		for (let i = 0; i<filesResult.length; i++) {
			let html = '';
			html += '<img src="/files/' + filesResult[i].cbfUuid + '"><br>';
			html += filesResult[i].cbfName;
			html += '<button class="btn btn-light" onclick="deleteFile(\'' + filesResult[i].cbfNum + '\')" style="float:right;">삭제</button>';
			$(".file" + (i+1)).html(html);
		}
	}
	
}

function deleteFile(id) {
	document.getElementById(id).value = "";
	$("." + id).html("");
}

async function updateBoard(){
	var check = confirm('게시글을 수정하시겠습니까?');
	if(check) {
		const param = {
			cbTitle: document.getElementById('cbTitle').value,
			cbContent: document.getElementById('cbContent').value
		};
		
		const updateResponse = await fetch('/community-board/${param.cbNum}',{
			method:'PATCH',
			headers : {
				'Content-Type' : 'application/json'
			},
			body : JSON.stringify(param)
		});
		if (!updateResponse.ok) {
			const errorResult = await updateResponse.json();
			alert(errorResult.msg);
			location.href = '/views/community/list';
			return;
		}
		const updateResult = await updateResponse.json();
		if(updateResult===1){
			alert('게시물이 수정되었습니다.');
			location.href='/views/community/view?cbNum=${param.cbNum}';
			return;
		}
		alert('다시 시도해주세요.');
	}
}

</script>
</body>
</html>
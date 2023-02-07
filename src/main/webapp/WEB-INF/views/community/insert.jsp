<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 등록</title>
<%@ include file= "/resources/common/header.jsp" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript" src="/resources/js/jquery-3.6.3.js"></script>
</head>
<body>
<table>
	<select id="cbCategory">
		<option value="infoBoard">정보게시판</option>
		<option value="freeBoard">자유게시판</option>
		<option value="questionBoard">질문게시판</option>
		<option value="reviewBoard">후기게시판</option>
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
		<th>file1</th>
		<td><input type="file" id="file1"></td>
	</tr>
	<tr>
		<th>file2</th>
		<td><input type="file" id="file2"></td>
	</tr>
	<tr>
		<th>file3</th>
		<td><input type="file" id="file3"></td>
	</tr>
	<tr>
		<th colspan="2">
			<button id="uploadBtn">등록</button>
			<button onclick="location.href='/views/community/list'">목록</button>
		</th>
	</tr>
</table>

<!-- 이미지 미리보기 div -->
<div class="img_wrap"></div>

<script>
var sel_file = [];

$(function(){
	//------------- 이미지 미리보기 시작 ------------------
	$("input[type='file']").on("change", handleImgFileSelect);
	
	//e : change 이벤트 객체
	// change 이벤트 설정하면  e는 이벤트가 된다. handleImgFileSelect에 파라미터 주면 e가 이벤트가 아니라 그냥 파라미터가 됨.
	function handleImgFileSelect(e){
		
		console.log("여길봐라: "+ JSON.stringify(e));
		//e.target : 파일객체
		//e.target.files : 파일객체 안의 파일들
		var files = e.target.files;
		var filesArr = Array.prototype.slice.call(files);
		
		//f : 파일 객체
		filesArr.forEach(function(f){
			//미리보기는 이미지만 가능함
			if(!f.type.match("image.*")){
				alert("이미지 파일이 아닙니다.");
				return;
			}
			
			// 파일객체 복사
			 sel_file.push(f);
			
			//파일을 읽어주는 객체 생성
			var reader = new FileReader();
			reader.onload = function(e){
				//forEach 반복 하면서 img 객체 생성
				var img_html = "<img src=\"" + e.target.result + "\" />";
				$(".img_wrap").append(img_html);
				console.log(e.target.result);
			}
			
			reader.readAsDataURL(f);
		});
	}
	
	//------------- 이미지 미리보기 끝 ------------------
	
	//첨부파일의 확장자가 exe, sh, zip, alz 경우 업로드를 제한
	var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");	// !!!!!!이미지 파일만 가능하게 정규식 바꿔야 함!!!!!!
	//최대 5MB까지만 업로드 가능
	var maxSize = 5242880; //5MB
	//확장자, 크기 체크
	function checkExtension(fileName, fileSize){
		if(fileSize >= maxSize){
			alert("파일 사이즈 초과");
			return false;
		}
		
		if(regex.test(fileName)){
			alert("해당 종류의 파일은 업로드할 수 없습니다.");
			return false;
		}
		//체크 통과
		return true;
	}

	$("#uploadBtn").on("click",function(e){
		const cbTitle = document.querySelector('#cbTitle').value;
		if (!cbTitle) {
			alert('제목을 입력해주세요.');
			cbTitle.focus();
			return;
		}
			
		const cbContent = document.querySelector('#cbContent').value;
		if (!cbContent) {
			alert('내용을 입력해주세요.');
			cbContent.focus();
			return;
		}
		
		const formData = new FormData();
		const inputObjs = document.querySelectorAll('input[id],textarea[id],select[id]');
		for(const inputObj of inputObjs){
			if(inputObj.getAttribute('type') === 'file'){
				if(inputObj.files.length==1){
					const file = inputObj.files[0];
					if(!checkExtension(file.name, file.size)){//!true라면 실패
						return;
					}
					if(!file.type.match("image.*")){
						alert("이미지 파일만 업로드 가능합니다");
						return;
					}
					formData.append('multipartFiles',inputObj.files[0]);
					//formData.append(inputObj.getAttribute('id'), inputObj.files[0]);
				}
				continue;
			}
			formData.append(inputObj.getAttribute('id'),inputObj.value);
		}
		
		formData.enctype='multipart/form-data'; 
		const xhr = new XMLHttpRequest();
		xhr.open('POST', '/community-board');
		xhr.onreadystatechange = function() {
			if(xhr.readyState === xhr.DONE) {
				if(xhr.status === 200) {
					alert('글이 등록되었습니다');
					location.href = '/views/community/view?cbNum=' + xhr.responseText;
				} else {
					alert('등록에 실패했습니다.');
				}
			}
		}
		xhr.send(formData);
	});

});

</script>
</body>
</html>
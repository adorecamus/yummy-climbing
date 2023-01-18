<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 등록</title>
</head>
<body>
<table border="1">
	<tr>
		<th>제목</th>
		<td><input type="text" id="cbTitle"></td>
	</tr>
	<tr>
		<th>내용</th>
		<td><textarea rows="20" cols="30" id="cbContent"></textarea></td>
	</tr>
	<tr>
	<th colspan="2">
		<button onclick="insertBoard()">등록</button>
		<button onclick="location.href='/views/community/list'">리스트</button>
	</th>
	</tr>
</table>
<script>
	function insertBoard() {
		const param = {};
		param.cbTitle = document.querySelector('#cbTitle').value;
		param['cbContent'] = document.querySelector('#cbContent').value;
		
		fetch('/community-board',{
			method:'POST',
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
				alert('정상등록 되었습니다.');
				location.href='/views/community/list';
			}
			
		})
		.catch(function(err){
			alert(err);
		});

	}
</script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="/resources/common/header.jsp"%>
<style>
.page-item {
	float:left;
	margin-left:10px;
}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>        <!-- 이 제이쿼리 꼭 넣어줘야함!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!-->
</head>
<body>

<div id="partyList"></div>
<div style="clear:both;"><ul class="pagination" style="list-style:none;"></ul></div>
<p class="allPartys" style="margin-left:20px;"></p>
<p class="reviewCount"></p>

<script>
let totalData; //총 데이터 수
let dataPerPage; //한 페이지에 나타낼 글 수 ex)난 한 페이지에 5개만 나타내고 싶다! 그러면 5
let pageCount = 5; //페이징에 나타낼 페이지 수  ex)난 밑에 페이지 번호를 5개까지만 나타내고 6부터는 '>' 눌러서 나오게 할거다! 그럼 5
let globalCurrentPage = 1; //현재 페이지
let dataList; //표시하려하는 데이터 리스트

//현재 페이지(currentPage)와 페이지당 글 개수(dataPerPage) 반영
function displayData(currentPage, dataPerPage) {

	let html = "";

	//Number로 변환하지 않으면 아래에서 +를 할 경우 스트링 결합이 되어버림..
	currentPage = Number(currentPage);
	dataPerPage = Number(dataPerPage);

	let maxpnum=(currentPage - 1) * dataPerPage + dataPerPage; 
	if(maxpnum>totalData){maxpnum=totalData;} 

	for (
	var i = (currentPage - 1) * dataPerPage;
	i < maxpnum; 
	i++
	) { //여기에 원래 리스트에 넣어주는 값들으 넣어주면 된다. 불러오는 형식은 dataList[i].컬럼명

		if (dataList[i].piComplete === 1) {
			html += '<div style="background-color:lightgrey;';
		} else {
			html += '<div style="'; 
		}
		html += 'float:left; border:1px solid; width:200px; height:220px; cursor:pointer;" onclick="location.href=\'/views/party/view?piNum=' + dataList[i].piNum + '\'">';
		html += '<p>산 : ' + dataList[i].mntnm + '<br>';
		html += '모임 이름 : ' + dataList[i].piName + '<br>';
		html += '날짜 : ' + dataList[i].piExpdat + '<br>';
		html += '시간 : ' + dataList[i].piMeetingTime + '<br>';
		html += '멤버 : ' + dataList[i].memNum + " / " + dataList[i].piMemberCnt + '<br>';
		html += '좋아요 : ' + dataList[i].likeNum + '<br>';
		html += '소개 : ' + dataList[i].piProfile + '<br>';
		html += '생성일 : ' + dataList[i].piCredat + '</p>';
		html += '</div>';
		
		/*
		html += '<tr>'
			if(dataList[i].piComplete === 1) {
				html += '<td>' + '모집완료' + '</td></tr>'
			}
			html += '<tr><td style="color:gray;">' + dataList[i].mntnm + '</td></tr>'
			html += '<tr><td style="color:gray;">' + dataList[i].piName + '</td></tr>'
			html += '<tr><td>' + dataList[i].piExpdat + '</td></tr>'
			html += '<tr><td>' + dataList[i].piMeetingTime + '</td></tr>'
			html += '<tr><td>' + dataList[i].memNum + " / " + dataList[i].piMemberCnt + '</td></tr>'
			html+= '<hr>'
			html += '<tr></tr>'
			*/
	} 
	$("#partyList").html(html);  //여기서 저 위에있는 값들을 html에 넣어줌
}

function paging(totalData, dataPerPage, pageCount, currentPage) {
	  console.log("currentPage : " + currentPage);

	  totalPage = Math.ceil(totalData / dataPerPage); //총 페이지 수
	  
	  if(totalPage<pageCount){
	    pageCount=totalPage; 
	  } //이 if함수가 무슨 소리냐면 내가 가진 데이터로 나올 총 페이지수는 예를 들어 7개인데
      //나는 밑에 페이지번호가 최대 8개까지 뜨고 9부터는 '>'누르면 나오게 해놨다면
      //7 < 8 로 내가 설정한 페이지번호가 더 크기 때문에 페이지번호를 데이터로 나올 총 페이지수로 바꿔주는것
	  
	  let pageGroup = Math.ceil(currentPage / pageCount); // 페이지 그룹
	  let last = pageGroup * pageCount; //화면에 보여질 마지막 페이지 번호
	  
	  console.log("pagGroup=" + pageGroup);
	  console.log("totalPage=" + totalPage);
	  
	  if (last > totalPage) {
	    last = totalPage;
	  }
      //화면에 보여질 마지막 페이지 번호가 총 페이지보다 많다면
      //보여질 마지막 페이지 번호를 총 페이지로 바꾼다는 것

	  let first = last - (pageCount - 1); //화면에 보여질 첫번째 페이지 번호
	  let next = last + 1;
	  let prev = first - 1;
	  console.log("pageCount=" + pageCount);
	  console.log("first=" + first);
	  console.log("last=" + last);
	  
	  let pageHtml = "";
	  console.log("prev=" + prev);
	  console.log("next=" + next);
	  
      //여기 pageHtml은 prev 넣을 태그를 넣으면 된다.
	    pageHtml += "<li class='page-item'>";
	    pageHtml += "<a class='page-link' href='#' id='prev' aria-label='Previous'>";
        pageHtml += "<span aria-hidden='true'>&laquo;</span>";
      	pageHtml += "</a></li>";
	  

	 //페이징 번호 표시 
	  for (var i = first; i <= last; i++) {
	    if (currentPage == i) {
	      pageHtml +=
	        "<li class='page-item'><a class='page-link' href='#'>" + i + "</a></li>";
	    } else {
	      pageHtml += "<li class='page-item'><a class='page-link' href='#'>" + i + "</a></li>";
	    }
	  }

	  //여기 pageHtml에는 next 넣을 태그를 넣으면 된다.
	    pageHtml += "<li class='page-item'>"
	    pageHtml += "<a class='page-link' href='#' id='next' aria-label='Next'>"
        pageHtml += "<span aria-hidden='true'>&raquo;</span>"
        pageHtml += "</a></li>"
	  
        //위에 pageHtml을 어디다가 삽입할건지!
	  $(".pagination").html(pageHtml);

      //이건 전체 건수 나타낼려고 적은 것
      //전체 건수 표기 안할거면 밑에 세 줄은 지워도 무관.
	  let displayCount = "";
	  displayCount = "전체 " + totalData + "건";
	  $(".allPartys").html(displayCount);
	  
      //이것도 전체 건수를 이모티콘과 같이 넣으려고 한거라
      //얘도 안쓴다면 지워도 무관(3줄)
	  let reviewCount = "";
	  reviewCount = "🗨" + totalData
	  $(".reviewCount").html(reviewCount);


	  //페이징 번호 클릭 이벤트 
	  $(".pagination li a").click(function () {
	    let $id = $(this).attr("id");
	    selectedPage = $(this).text();
	    console.log("selectedPage=" + selectedPage);
        
        //마지막 페이지에서 next를 또 누를 경우 빈페이지만 나오게 되는 현상이 있었음
        //next는 totalPage보다 항상 1 많게 찍혔었음
        //그래서 next - 1이 totalPage랑 같다면 selectedPage를 totalPage랑 같게 한 것
        //selectedPage는 현재 페이지라고 생각하면 된다.
	    if ($id == "next") {
	    	 console.log("selectedPage2=" + selectedPage);
	    	 console.log("totalPage2=" + totalPage);
	    	if((next - 1) === totalPage) {
	    		selectedPage = totalPage;
	    	}else {
	    		selectedPage = next;
	    	}
	    }
	    if ($id == "prev") {
	    	if(prev > 0) {
	    		selectedPage = prev;	
	    	}else if(prev == 0) {
	    		selectedPage = 1;
	    	}
	    	
	    }
        //이게 원래 prev랑 next가 페이지 그룹이 바뀌었을 때만 생성이 되게 코드가 짜여있었음.
        //난 prev를 누르면 전 페이지, next를 누르면 다음 페이지로 가고 싶게했음
        //그래서 prev 또한 바꿔줌
        //prev는 원래 현재 페이지에서 -1이 된 값을 가지고 있음
        //그게 0이라면 selectedPage는 1이 되게
        //0보다 크다면 selectedPage가 prev값이 되게함
	    
	    //전역변수에 선택한 페이지 번호를 담는다...
	    globalCurrentPage = selectedPage;
	    //페이징 표시 재호출
	    paging(totalData, dataPerPage, pageCount, selectedPage);
	    //글 목록 표시 재호출
	    displayData(selectedPage, dataPerPage);
	  });
	}

$(document).ready(function () { //페이지가 로드가 되면서 실행이 되는 함수 24~47
	//dataPerPage 선택값 가져오기
	dataPerPage = 3;    //위에서 선언한 한 페이지에 나타낼 글 수를 여기서 값 설정해줌! 글 수 바꾸고 싶다면 여기서 설정하면 된다.

	$.ajax({ // ajax로 데이터 가져오기(기존에 쓰던 fetch처럼 쓰면 된다. 여기선 데이터 불러오는 코드 작성하면 된다.)
	method: "GET",  //메소드명
	url: "/party-infos?includeComplete=true",    //데이터 불러오는 코드 컨트롤러 주소
	dataType: "json",   //데이터타입은 json으로 나와야해서 이건 변경할 필요 없음
	success: function (d) { //값을 성공적으로 불러온다면 저 d라는 곳에 값이 담길 예정임
	console.log(d);
        //여기서 console.log(d)를 찍어보면 값이 나오는게 확인이 되어야함!!
        //성공적으로 값을 불러왔다면 d에 리스트가 찍혀야 함.
        //console.log(d) 찍을 때 45라인과 48라인은 꼭 주석처리해줘야함
        //저 함수는 밑에서 추가로 선언을 해야하는 함수들이라 오류남.
    
	dataList=d; //dataList에 결과 담음
	
	//totalData(총 데이터 수) 구하기
	totalData = d.length;
	
	//글 목록 표시 호출 (테이블 생성)
	displayData(1, dataPerPage);    //밑에서 추가로 선언할 함수

	//페이징 표시 호출
	paging(totalData, dataPerPage, pageCount, 1);   //밑에서 추가로 선언할 함수

	}
  });
});



</script>
</body>
</html>
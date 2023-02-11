/**
 * 
 */

function paging(totalData, dataPerPage, pageCount, currentPage) {
	console.log("currentPage : " + currentPage);
	totalPage = Math.ceil(totalData / dataPerPage); //총 페이지 수

	if (totalPage < pageCount) {
		pageCount = totalPage;
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
	pageHtml += "<div class='page-link' id='prev' name='Previous'>";
	pageHtml += "<span aria-hidden='true'>&laquo;</span>";
	pageHtml += "</div></li>";
	//페이징 번호 표시 
	for (var i = first; i <= last; i++) {
		if (currentPage == i) {
			pageHtml +=
				"<li class='page-item'><div class='page-link'>" + i + "</div></li>";
		} else {
			pageHtml += "<li class='page-item'><div class='page-link'>" + i + "</div></li>";
		}
	}
	//여기 pageHtml에는 next 넣을 태그를 넣으면 된다.
	pageHtml += "<li class='page-item'>"
	pageHtml += "<div class='page-link' id='next' name='Next'>"
	pageHtml += "<span aria-hidden='true'>&raquo;</span>"
	pageHtml += "</div></li>"

	//위에 pageHtml을 어디다가 삽입할건지!
	$(".pagination").html(pageHtml);
	//페이징 번호 클릭 이벤트 
	$(".pagination li div").click(function() {
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
			if ((next - 1) === totalPage) {
				selectedPage = totalPage;
			} else {
				selectedPage = next;
			}
		}
		if ($id == "prev") {
			if (prev > 0) {
				selectedPage = prev;
			} else if (prev == 0) {
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

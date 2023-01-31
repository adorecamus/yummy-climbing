<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>소소모임 관리 페이지</title>
</head>
<body>
<h2>소소모임 방장 관리 페이지</h2>

<div id="editDiv">

<input type="text" id="piName" name="piName" placeholder="모임 이름"><br>
<input type="text" id="mntnm" name="mntnm" readonly><br>
<input type="date" id="piExpdat" name="piExpdat" placeholder="모임 날짜"><br>
<input type="time" id="piMeetingTime" name="piMeetingTime" step="900" placeholder="모임 시간"><br>
<input type="number" id="piMemberCnt" name="piMemberCnt" max=50 min=2 placeholder="정원"><br>
<textarea id="piProfile" placeholder="모임 설명"></textarea><br>

</div>

<script>

</script>
</body>
</html>
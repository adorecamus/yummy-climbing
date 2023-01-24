<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>맛등산</title>
</head>
<body>
맛등산 대박~~~~~~~~~~~~~~~~~!!!!!!!!!!!!!!!!!!!!!!
<br>
<c:if test="${userInfo ne null}">
	<h1>${userInfo.uiNickname}님 어서오세요</h1>
</c:if>
<br>
<c:if test="${userInfo eq null}">
<button onclick="location.href='/views/user/login'">로그인</button>
<button onclick="location.href='/views/user/signup'">회원가입</button> 
</c:if>
<button onclick="location.href='/views/community/list'">목록</button>
<button onclick="location.href='/views/mountain/list'">메인</button>
<button onclick="location.href='/views/party/main'">소모임</button>
<br>
<br>
<c:if test="${userInfo ne null}">
<button onclick="location.href='/views/user/mypage'">마이 페이지</button> 
<button onclick="location.href='/views/user/logout">로그아웃</button>
</c:if>
</body>
</html>
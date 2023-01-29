<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<!--
 // WEBSITE: https://themefisher.com
 // TWITTER: https://twitter.com/themefisher
 // FACEBOOK: https://www.facebook.com/themefisher
 // GITHUB: https://github.com/themefisher/
-->
<html>
<head>
<meta charset="UTF-8">
<title>Header</title>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=5">
<meta name="description" content="This is meta description">
<meta name="author" content="Themefisher">
<link rel="shortcut icon" href="images/favicon.png" type="image/x-icon">
<link rel="icon" href="images/favicon.png" type="image/x-icon">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
<script src="/resources/js/script.js"></script>
<script src="/resources/plugins/scrollmenu/scrollmenu.min.js"></script>
<link href="/resources/css/style1.css" rel="stylesheet" type="text/css">
<link href="/resources/css/style.css" rel="stylesheet" type="text/css">
<link href="/resources/css/style.css.map" rel="stylesheet" type="text/css">
<spring:eval var="openWeatherMapAPI" expression="@envProperties['openweathermap.key']" />
<spring:eval var="kakaoMapKey" expression="@envProperties['kakao.map.js.key']" />

<!-- theme meta -->
  <meta name="theme-name" content="wallet" />

</head>
<body>
<!-- navigation -->
<header class="navigation bg-tertiary">
  <nav class="navbar navbar-expand-xl navbar-light text-center py-3">
    <div class="container">
      <a class="navbar-brand" href="/">
        <img loading="prelaod" decoding="async" class="img-fluid" width="160" src="images/logo.png" alt="Wallet">
      </a>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"> <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mx-auto mb-2 mb-lg-0">
          <li class="nav-item "> <span class="nav-link" onclick="location.href='/views/mountain/list'">산리스트</span>
          </li>
          <li class="nav-item"> <span class="nav-link" onclick="location.href='/views/party/main'">소소모임</span>
          </li>
          <li class="nav-item "> <span class="nav-link" onclick="location.href='/views/community/list'">커뮤니티</span>
          </li>
          <li class="nav-item "> <span class="nav-link" >null</span>
          </li>
        </ul>
        <!-- account btn --> <a href="#!" class="btn btn-outline-primary" onclick="location.href='/views/user/login'">로그인</a>
        <!-- account btn --> <a href="#!" class="btn btn-primary ms-2 ms-lg-3" onclick="location.href='/views/user/signup'">회원가입</a>
      </div>
    </div>
  </nav>
</header>
<!-- /navigation -->

<!-- # JS Plugins -->
<!-- <script src="plugins/jquery/jquery.min.js"></script>
<script src="plugins/bootstrap/bootstrap.min.js"></script>
<script src="plugins/slick/slick.min.js"></script>
<script src="plugins/scrollmenu/scrollmenu.min.js"></script> -->

<!-- Main Script -->
<script src="js/script.js"></script>
</body>
</html>
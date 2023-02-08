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
					<p class="text-primary text-uppercase fw-bold"></p>
					<h2 class="mb-3 text-capitalize">MyPage</h2>
				</div>
			</div>
		</div>
		<div class="has-shapes">
			<svg class="shape shape-left text-light" viewBox="0 0 192 752"
				fill="none" xmlns="http://www.w3.org/2000/svg">
      <path d="M-30.883 0C-41.3436 36.4248 -22.7145 75.8085 4.29154 102.398C31.2976 128.987 65.8677 146.199 97.6457 166.87C129.424 187.542 160.139 213.902 172.162 249.847C193.542 313.799 149.886 378.897 129.069 443.036C97.5623 540.079 122.109 653.229 191 728.495" stroke="currentColor" stroke-miterlimit="10" />
      <path d="M-55.5959 7.52271C-66.0565 43.9475 -47.4274 83.3312 -20.4214 109.92C6.58466 136.51 41.1549 153.722 72.9328 174.393C104.711 195.064 135.426 221.425 147.449 257.37C168.829 321.322 125.174 386.42 104.356 450.559C72.8494 547.601 97.3965 660.752 166.287 736.018" stroke="currentColor" stroke-miterlimit="10" />
      <path d="M-80.3302 15.0449C-90.7909 51.4697 -72.1617 90.8535 -45.1557 117.443C-18.1497 144.032 16.4205 161.244 48.1984 181.915C79.9763 202.587 110.691 228.947 122.715 264.892C144.095 328.844 100.439 393.942 79.622 458.081C48.115 555.123 72.6622 668.274 141.552 743.54" stroke="currentColor" stroke-miterlimit="10" />
      <path d="M-105.045 22.5676C-115.506 58.9924 -96.8766 98.3762 -69.8706 124.965C-42.8646 151.555 -8.29436 168.767 23.4835 189.438C55.2615 210.109 85.9766 236.469 98.0001 272.415C119.38 336.367 75.7243 401.464 54.9072 465.604C23.4002 562.646 47.9473 675.796 116.838 751.063" stroke="currentColor" stroke-miterlimit="10" />
    </svg>
			<svg class="shape shape-right text-light" viewBox="0 0 731 746"
				fill="none" xmlns="http://www.w3.org/2000/svg">
      <path
					d="M12.1794 745.14C1.80036 707.275 -5.75764 666.015 8.73984 629.537C27.748 581.745 80.4729 554.968 131.538 548.843C182.604 542.703 234.032 552.841 285.323 556.748C336.615 560.64 391.543 557.276 433.828 527.964C492.452 487.323 511.701 408.123 564.607 360.255C608.718 320.353 675.307 307.183 731.29 327.323"
					stroke="currentColor" stroke-miterlimit="10" />
      <path
					d="M51.0253 745.14C41.2045 709.326 34.0538 670.284 47.7668 635.783C65.7491 590.571 115.623 565.242 163.928 559.449C212.248 553.641 260.884 563.235 309.4 566.931C357.916 570.627 409.887 567.429 449.879 539.701C505.35 501.247 523.543 426.331 573.598 381.059C615.326 343.314 678.324 330.853 731.275 349.906"
					stroke="currentColor" stroke-miterlimit="10" />
      <path
					d="M89.8715 745.14C80.6239 711.363 73.8654 674.568 86.8091 642.028C103.766 599.396 150.788 575.515 196.347 570.054C241.906 564.578 287.767 573.629 333.523 577.099C379.278 580.584 428.277 577.567 465.976 551.423C518.279 515.172 535.431 444.525 582.62 401.832C621.964 366.229 681.356 354.493 731.291 372.46"
					stroke="currentColor" stroke-miterlimit="10" />
      <path
					d="M128.718 745.14C120.029 713.414 113.678 678.838 125.837 648.274C141.768 608.221 185.939 585.788 228.737 580.659C271.536 575.515 314.621 584.008 357.6 587.282C400.58 590.556 446.607 587.719 482.028 563.16C531.163 529.111 547.275 462.733 591.612 422.635C628.572 389.19 684.375 378.162 731.276 395.043"
					stroke="currentColor" stroke-miterlimit="10" />
      <path
					d="M167.564 745.14C159.432 715.451 153.504 683.107 164.863 654.519C179.753 617.046 221.088 596.062 261.126 591.265C301.164 586.452 341.473 594.402 381.677 597.465C421.88 600.527 464.95 597.872 498.094 574.896C544.061 543.035 559.146 480.942 600.617 443.423C635.194 412.135 687.406 401.817 731.276 417.612"
					stroke="currentColor" stroke-miterlimit="10" />
      <path
					d="M817.266 289.466C813.108 259.989 787.151 237.697 759.261 227.271C731.372 216.846 701.077 215.553 671.666 210.904C642.254 206.24 611.795 197.156 591.664 175.224C555.853 136.189 566.345 75.5336 560.763 22.8649C552.302 -56.8256 498.487 -130.133 425 -162.081"
					stroke="currentColor" stroke-miterlimit="10" />
      <path
					d="M832.584 276.159C828.427 246.683 802.469 224.391 774.58 213.965C746.69 203.539 716.395 202.246 686.984 197.598C657.573 192.934 627.114 183.85 606.982 161.918C571.172 122.883 581.663 62.2275 576.082 9.55873C567.62 -70.1318 513.806 -143.439 440.318 -175.387"
					stroke="currentColor" stroke-miterlimit="10" />
      <path
					d="M847.904 262.853C843.747 233.376 817.789 211.084 789.9 200.659C762.011 190.233 731.716 188.94 702.304 184.292C672.893 179.627 642.434 170.544 622.303 148.612C586.492 109.577 596.983 48.9211 591.402 -3.74766C582.94 -83.4382 529.126 -156.746 455.638 -188.694"
					stroke="currentColor" stroke-miterlimit="10" />
      <path
					d="M863.24 249.547C859.083 220.07 833.125 197.778 805.236 187.353C777.347 176.927 747.051 175.634 717.64 170.986C688.229 166.321 657.77 157.237 637.639 135.306C601.828 96.2707 612.319 35.6149 606.738 -17.0538C598.276 -96.7443 544.462 -170.052 470.974 -202"
					stroke="currentColor" stroke-miterlimit="10" />
    </svg>
		</div>
	</section>

	<section class="section">
		<div class="container">
			<div class="row">
				<div class="col-lg-9">
						<div class="align-items-center">
				<div class="row position-relative gy-4">
					<div class="icon-box-item col-md-6">
						<div class="block bg-white">
							<div class="icon rounded-number">01</div>
							<!-- 프로필 칸 -->
							<h3 class="mb-3">개인정보 수정</h3>
							이름: ${userInfo.uiName}
							나이 : ${userInfo.uiAge}
							닉네임 : ${userInfo.uiNickname}
							주소 : ${userInfo.uiAddr}
						</div>
					</div>
					<div class="icon-box-item col-md-6">
						<div class="block bg-white">
							<div class="icon rounded-number">02</div>
							<h3 class="mb-3">Empathetic</h3>
							<p class="mb-0">Lorem ipsum dolor sit aamet, ctetur adsipis cing elit. Lacaus</p>
						</div>
					</div>
					<div class="icon-box-item col-md-6">
						<div class="block bg-white">
							<div class="icon rounded-number">03</div>
							<h3 class="mb-3">All Improving</h3>
							<p class="mb-0">Lorem ipsum dolor sit aamet, ctetur adsipis cing elit. Lacaus</p>
						</div>
					</div>
					<div class="icon-box-item col-md-6">
						<div class="block bg-white">
							<div class="icon rounded-number">04</div>
							<h3 class="mb-3">User-Focused</h3>
							<p class="mb-0">Lorem ipsum dolor sit aamet, ctetur adsipis cing elit. Lacaus</p>
						</div>
					</div>
					<div class="has-shapes">
						<svg class="shape shape-1 text-primary" width="71" height="71" viewBox="0 0 119 119" fill="none" xmlns="http://www.w3.org/2000/svg">
							<path d="M8.50598 89.8686C8.17023 89.3091 7.83449 88.6376 7.49875 88.078L66.0305 0.336418C66.7019 0.448334 67.3734 0.560249 68.0449 0.560249L8.50598 89.8686Z" fill="currentColor" />
							<path d="M5.03787 83.2646C4.70213 82.5932 4.47829 81.9217 4.14255 81.2502L58.3096 -0.00032826C59.093 -0.000328191 59.7645 -0.000328132 60.5479 -0.000328064L5.03787 83.2646Z" fill="currentColor" />
							<path d="M16.9007 100.613C16.453 100.165 16.0053 99.7175 15.5577 99.2698L79.4613 3.47031C80.0209 3.69414 80.6924 3.91795 81.252 4.14178L16.9007 100.613Z" fill="currentColor" />
							<path d="M12.5352 95.5762C12.0876 95.0166 11.7518 94.5689 11.3042 94.0094L72.9695 1.45541C73.641 1.56732 74.2006 1.79115 74.8721 1.90306L12.5352 95.5762Z" fill="currentColor" />
							<path d="M0.00101471 55.5103C0.11293 54.1673 0.224831 52.9362 0.336747 51.5932L29.6586 7.72242C30.7777 7.05093 31.8969 6.49136 33.1279 5.93178L0.00101471 55.5103Z" fill="currentColor" />
							<path d="M26.1887 108.334C25.9649 108.223 25.7411 107.999 25.5172 107.887L91.2115 9.40136C91.4353 9.51328 91.6592 9.7371 91.883 9.84901C92.2188 10.0728 92.4426 10.2967 92.7783 10.4086L27.084 108.894C26.8602 108.67 26.5245 108.558 26.1887 108.334Z" fill="currentColor" />
							<path d="M114.042 81.0269C112.587 84.7201 110.685 88.4133 108.334 91.8827C105.984 95.3521 103.41 98.4857 100.5 101.396L114.042 81.0269Z" fill="currentColor" />
							<path d="M0.335842 66.7012C0.223927 65.6939 0.112026 64.7986 0.000110881 63.7914L40.7373 2.79753C41.6326 2.46179 42.6398 2.23796 43.5352 2.01413L0.335842 66.7012Z" fill="currentColor" />
							<path d="M2.23929 75.6538C2.01546 74.8704 1.79162 74.087 1.56779 73.3036L50.0271 0.558655C50.8105 0.446747 51.7059 0.334824 52.4893 0.222908L2.23929 75.6538Z" fill="currentColor" />
							<path d="M32.793 112.139C32.2335 111.915 31.6739 111.58 31.1143 111.244L96.4728 13.206C96.9205 13.6537 97.4801 13.9894 97.9277 14.4371L32.793 112.139Z" fill="currentColor" />
							<path d="M77.7822 115.161C76.8868 115.497 75.8796 115.72 74.9843 116.056L117.848 51.8168C117.96 52.824 118.072 53.7193 118.184 54.7266L77.7822 115.161Z" fill="currentColor" />
							<path d="M68.493 117.512C67.7096 117.624 66.8143 117.736 66.0309 117.848L116.057 42.8644C116.281 43.6478 116.505 44.4312 116.729 45.3265L68.493 117.512Z" fill="currentColor" />
							<path d="M60.0992 118.294C59.3158 118.294 58.6443 118.294 57.8609 118.294L113.259 35.2533C113.595 35.9248 113.819 36.5963 114.154 37.2678L60.0992 118.294Z" fill="currentColor" />
							<path d="M21.8245 105.087C21.3768 104.64 20.8172 104.304 20.3696 103.856L85.6162 6.15427C86.1758 6.37809 86.7354 6.71384 87.2949 7.04959L21.8245 105.087Z" fill="currentColor" />
							<path d="M89.0856 110.124C87.9665 110.795 86.7354 111.467 85.6162 112.026L118.184 63.1194C118.072 64.4624 117.96 65.8054 117.736 67.0364L89.0856 110.124Z" fill="currentColor" />
							<path d="M3.69339 38.2759C5.2602 34.135 7.27468 30.1061 9.84873 26.189C12.4228 22.3839 15.3326 18.9145 18.5781 15.8928L3.69339 38.2759Z" fill="currentColor" />
							<path d="M52.49 117.848C51.8185 117.736 51.147 117.736 50.4755 117.624L109.791 28.5392C110.126 29.0988 110.462 29.7703 110.798 30.3299L52.49 117.848Z" fill="currentColor" />
							<path d="M38.9475 114.712C38.388 114.489 37.7165 114.265 37.1569 114.041L101.396 17.6818C101.844 18.1295 102.292 18.5771 102.739 19.0248L38.9475 114.712Z" fill="currentColor" />
							<path d="M45.4392 116.728C44.7677 116.616 44.2081 116.392 43.5366 116.28L105.873 22.8306C106.321 23.3902 106.657 23.8378 107.105 24.3974L45.4392 116.728Z" fill="currentColor" />
						</svg>
						<svg class="shape shape-2 text-primary" width="100" height="100" viewBox="0 0 119 119" fill="none" xmlns="http://www.w3.org/2000/svg">
							<path d="M8.50598 89.8686C8.17023 89.3091 7.83449 88.6376 7.49875 88.078L66.0305 0.336418C66.7019 0.448334 67.3734 0.560249 68.0449 0.560249L8.50598 89.8686Z" fill="currentColor" />
							<path d="M5.03787 83.2646C4.70213 82.5932 4.47829 81.9217 4.14255 81.2502L58.3096 -0.00032826C59.093 -0.000328191 59.7645 -0.000328132 60.5479 -0.000328064L5.03787 83.2646Z" fill="currentColor" />
							<path d="M16.9007 100.613C16.453 100.165 16.0053 99.7175 15.5577 99.2698L79.4613 3.47031C80.0209 3.69414 80.6924 3.91795 81.252 4.14178L16.9007 100.613Z" fill="currentColor" />
							<path d="M12.5352 95.5762C12.0876 95.0166 11.7518 94.5689 11.3042 94.0094L72.9695 1.45541C73.641 1.56732 74.2006 1.79115 74.8721 1.90306L12.5352 95.5762Z" fill="currentColor" />
							<path d="M0.00101471 55.5103C0.11293 54.1673 0.224831 52.9362 0.336747 51.5932L29.6586 7.72242C30.7777 7.05093 31.8969 6.49136 33.1279 5.93178L0.00101471 55.5103Z" fill="currentColor" />
							<path d="M26.1887 108.334C25.9649 108.223 25.7411 107.999 25.5172 107.887L91.2115 9.40136C91.4353 9.51328 91.6592 9.7371 91.883 9.84901C92.2188 10.0728 92.4426 10.2967 92.7783 10.4086L27.084 108.894C26.8602 108.67 26.5245 108.558 26.1887 108.334Z" fill="currentColor" />
							<path d="M114.042 81.0269C112.587 84.7201 110.685 88.4133 108.334 91.8827C105.984 95.3521 103.41 98.4857 100.5 101.396L114.042 81.0269Z" fill="currentColor" />
							<path d="M0.335842 66.7012C0.223927 65.6939 0.112026 64.7986 0.000110881 63.7914L40.7373 2.79753C41.6326 2.46179 42.6398 2.23796 43.5352 2.01413L0.335842 66.7012Z" fill="currentColor" />
							<path d="M2.23929 75.6538C2.01546 74.8704 1.79162 74.087 1.56779 73.3036L50.0271 0.558655C50.8105 0.446747 51.7059 0.334824 52.4893 0.222908L2.23929 75.6538Z" fill="currentColor" />
							<path d="M32.793 112.139C32.2335 111.915 31.6739 111.58 31.1143 111.244L96.4728 13.206C96.9205 13.6537 97.4801 13.9894 97.9277 14.4371L32.793 112.139Z" fill="currentColor" />
							<path d="M77.7822 115.161C76.8868 115.497 75.8796 115.72 74.9843 116.056L117.848 51.8168C117.96 52.824 118.072 53.7193 118.184 54.7266L77.7822 115.161Z" fill="currentColor" />
							<path d="M68.493 117.512C67.7096 117.624 66.8143 117.736 66.0309 117.848L116.057 42.8644C116.281 43.6478 116.505 44.4312 116.729 45.3265L68.493 117.512Z" fill="currentColor" />
							<path d="M60.0992 118.294C59.3158 118.294 58.6443 118.294 57.8609 118.294L113.259 35.2533C113.595 35.9248 113.819 36.5963 114.154 37.2678L60.0992 118.294Z" fill="currentColor" />
							<path d="M21.8245 105.087C21.3768 104.64 20.8172 104.304 20.3696 103.856L85.6162 6.15427C86.1758 6.37809 86.7354 6.71384 87.2949 7.04959L21.8245 105.087Z" fill="currentColor" />
							<path d="M89.0856 110.124C87.9665 110.795 86.7354 111.467 85.6162 112.026L118.184 63.1194C118.072 64.4624 117.96 65.8054 117.736 67.0364L89.0856 110.124Z" fill="currentColor" />
							<path d="M3.69339 38.2759C5.2602 34.135 7.27468 30.1061 9.84873 26.189C12.4228 22.3839 15.3326 18.9145 18.5781 15.8928L3.69339 38.2759Z" fill="currentColor" />
							<path d="M52.49 117.848C51.8185 117.736 51.147 117.736 50.4755 117.624L109.791 28.5392C110.126 29.0988 110.462 29.7703 110.798 30.3299L52.49 117.848Z" fill="currentColor" />
							<path d="M38.9475 114.712C38.388 114.489 37.7165 114.265 37.1569 114.041L101.396 17.6818C101.844 18.1295 102.292 18.5771 102.739 19.0248L38.9475 114.712Z" fill="currentColor" />
							<path d="M45.4392 116.728C44.7677 116.616 44.2081 116.392 43.5366 116.28L105.873 22.8306C106.321 23.3902 106.657 23.8378 107.105 24.3974L45.4392 116.728Z" fill="currentColor" />
						</svg>
					</div>
				</div>
			<div class="mt-5 mt-lg-0">
				<div class="section-title ps-0 ps-lg-5">
					<p class="text-primary text-uppercase fw-bold mb-3">Values Wr Provide</p>
					<h2 class="h1">Our Core Values</h2>
					<div class="content">
						<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Consv allis quam aliquet integer eget magna ullam corper intesager peent esque urna. Sed vulutate aenean nunc quis a urna morbi id vitae. Vulpuate nisl</p>
						<p>sed morbi sit ut placerat eges aeftas et. Pellen tesque tristisque magnis augue gravida pulvinar placerat. Tellus massa pretra scelerisque leo. In volutpat arcu nunc nisl et, viverra faucisfbus egestas. In habitasse sagittis, convallis ut commodo amet.</p>
					</div>
				</div>
			</div>
		</div>
		</div>
		<div class="col-lg-3">
			<div class="widget widget-categories">
				<h5 class="widget-title">
					<span>여기에 적을 말 추천 받습니다.</span>
				</h5>
				<ul class="list-unstyled widget-list">
					<li><a onclick="showConfirm('update')">회원정보 수정</a></li>
					<li><a onclick="showConfirm('delete')">회원 탈퇴</a>
					</li>
					<li><a onclick="location.href='/'">홈으로</a>
					</li>
				</ul>
			</div>
			<!-- latest post -->
			<div class="widget">
				<!-- 가입한 소모임  -->
				<h5 class="widget-title">
					<span>${userInfo.uiNickname}님이&nbsp;&nbsp;가입한&nbsp;&nbsp;소모임</span>
				</h5>
				<ul class="list-unstyled widget-list">
					<div id="myParty"></div>
				</ul>

				<!-- 좋아요 소모임  -->
				<h5 class="widget-title">
					<span>${userInfo.uiNickname}님이&nbsp;&nbsp;♥한&nbsp;&nbsp;소모임</span>
				</h5>
				<ul class="list-unstyled widget-list">
					<div id="likeParty"></div>
				</ul>

				<!-- 좋아요 산 -->
				<h5 class="widget-title">
					<span>${userInfo.uiNickname}님이&nbsp;&nbsp;♥한&nbsp;&nbsp;산</span>
				</h5>
				<ul class="list-unstyled widget-list">
					<div id="likeMountain"></div>
				</ul>

				<!-- 좋아요 커뮤니티 게시물 -->
				<h5 class="widget-title">
					<span>${userInfo.uiNickname}님이&nbsp;&nbsp;♥한&nbsp;&nbsp;게시글</span>
				</h5>
				<table>
					<tr>
						<th>카테고리</th>
						<th>제목</th>
					</tr>
					<tbody id="myLikeBoard"></tbody>
				</table>
				
				<!-- 내가 작성한 커뮤니티 게시물 -->
				<h5 class="widget-title">
					<span>${userInfo.uiNickname}님이&nbsp;&nbsp;작성한&nbsp;&nbsp;커뮤니티&nbsp;&nbsp;게시글</span>
				</h5>
				<table>
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
</section>


	<!-- 프로필 칸 -->
	<h1>마이페이지</h1>
	<br> 이름: ${userInfo.uiName}
	<br> 나이 : ${userInfo.uiAge}
	<br> 닉네임 : ${userInfo.uiNickname}
	<br> 주소 : ${userInfo.uiAddr}
	<br>

	<!-- 프로필 사진 등록 칸-->
	<c:if test="${userInfo.uiImgPath eq null}">
		<br>
		<h3>프로필 사진</h3>
		사진을 추가해 주세요.
		<div
			style="width: 150px; height: 200px; background-color: grey; margin-top: 10px; margin-bottom: 10px"></div>
		<input type="file" id="image" accept="image/png, image/jpeg">
		<br>
		<button onclick="profileUpload()">프로필 사진 설정</button>
		<br>
	</c:if>

	<c:if test="${userInfo.uiImgPath ne null}">
		<img src="${userInfo.uiImgPath}">
		<h3>프로필 사진</h3>
		<form action="/updatImg" method="post" enctype="multipart/form-data">
			<input type="hidden" name="userNum" value="${userInfo.uiNum}">
			<input type="file" id="image" accept="image/png, image/jpeg">
			<button onclick="changeImg()">사진변경</button>
		</form>
		<br>
	</c:if>
	<br>

	<!--챌린지 리스트 칸 -->
	<div id="rDiv">
		<h2 style="color: red">${userInfo.uiNickname}의Challenge!</h2>
		<h4>New Challenge</h4>
		<textarea rows="3" cols="40" id="ucChallenge" style="resize: none;"></textarea>
		<button onclick="addChallenge()">추가하기!</button>
		<br> <br>
		<table border="1">
			<tr>
				<th>번호</th>
				<th>도전 과제</th>
				<th>작성일</th>
				<th>수정일</th>
			</tr>
			<tbody id="tBody">
			</tbody>
		</table>
	</div>


	<script>
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
									html += '</tr>'
								}
								document.querySelector('#tBody').innerHTML = html;
							});
		}
		window.onload = function() {
			getChallengeList();
			getMyPartyList();
			getLikePartyList();
			getLikeMountainList();
			getMyBoardList();
			getLikeBoardList();
		}

		
		/* 새로운 챌린지 추가하기 */
		function addChallenge() {

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
					html += '<td style="cursor:pointer;" onclick="location.href=\'/views/community/view?cbNum=' + list[i].cbNum + '\'">' + list[i].cbTitle + '</td>';
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
					html += '<td style="cursor:pointer;" onclick="location.href=\'/views/community/view?cbNum=' + list[i].cbNum + '\'">' + list[i].cbTitle + '</td>';
					html += '</tr>';
				}
				document.querySelector('#myBoard').innerHTML = html;
			})
		}
		

	</script>
</body>
</html>
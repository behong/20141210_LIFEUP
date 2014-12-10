<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<script type="text/javascript">
	function fnReqWrite(userCheck) {
		/*
		로그인 안되어 있으면 로그인 페이지 이동
		일반 회원이면 글쓰기 페이지
		영업사원이면 검색페이지 
		*/
		if(userCheck == '2') {
			alert('영업사원은 등록할 수 없습니다');
		} else if(typeof(userCheck) == "undefined" || userCheck == "") {
			//alert('로그인 후 등록할 수 있습니다');
			location.href = "/account/login";			
		} else {	
			location.href = "/request/writeform";
		}			
	}
	
	$(function() {
		$('nav#menu-left').mmenu();
	});	
</script>	
<div id="page">
	<div id="header">
		<a class="navicon" href="#menu-left"></a>
		<div class="logo">
			<img class="logoImage"><a href="/"  style="text-decoration:none;">
				<span style="height: 52px;font-size:40px;font-family: fantasy;">vava</span>
				<span  style="height: 52px;font-size:20px;">car</span></a>
		</div>
		<div class="search-bar">
			<a href="#" id="write" onClick="fnReqWrite('${sessionScope._USER_INFO_.userType}');"><span class="write-icon"></span></a>
		</div>
		<div class="clear"></div>
	</div>
	<nav id="menu-left">
		<ul>
			<li style="height:24px;">&nbsp;</li>
			<li style="border-top-width: 0px;"><a href="#" onclick="location.href='<spring:url value='/' />'" id="menuMenu">HOME</a></li>
			<li>
				<c:if test="${empty sessionScope._USER_INFO_}">
					<a href="#" onclick="location.href='<spring:url value='/account/login'/>'" id="menuLogin">로그인</a>								
				</c:if>
				<c:if test="${not empty sessionScope._USER_INFO_}">
					<a href="#" onclick="location.href='<spring:url value='/account/logout'/>'" id="menuLogin">로그아웃</a>
				</c:if>
			</li>
			<c:if test="${empty sessionScope._USER_INFO_}">
				<li><a href="#" onclick="location.href='<spring:url value='/account/membership'/>'" id="menuMembership">회원가입</a></li>
			</c:if>
			<c:if test="${not empty sessionScope._USER_INFO_}">			
				<li><a href="#" onclick="location.href='<spring:url value='/mypage/list' />'" id="menuMyPage">내정보</a></li>							
			</c:if>	
			<li><a href="#" onclick="location.href='<spring:url value='/request/list' />'" id="menuRequest">의뢰목록</a></li>
			<li><a href="#" onclick="location.href='<spring:url value='/board/Notice' />'" id="menuNotice">공지사항</a></li>
			<li><a href="#" onclick="location.href='<spring:url value='/board/FAQ' />'" id="menuFAQ">FAQ</a></li>
			<c:if test="${sessionScope._USER_INFO_.userType != 2}">
				<li><a href="#" onclick="fnReqWrite('${sessionScope._USER_INFO_.userType}');">견적의뢰</a></li>
			</c:if>
			<li><a href="#" onclick="location.href='<spring:url value='/salesRanking' />'" id="menuRanking">영업랭킹</a></li>
		</ul>
	</nav>
</div>
<%@ tag language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang='ko'>
<head>
<meta charset='utf-8'>
	<title>Mypage</title>
	<meta name="viewport" content="user-scalable=no,   width=device-width,  target-densitydpi=device-mdpi">
	<meta name='description' content=''>
	<meta name='author' content=''>
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=IE8" />
	
	<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.2/jquery.mobile-1.4.2.min.css">
	<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css">
	<link href='<spring:url value="/resources/css/loginPanel.css"/>' rel='stylesheet'>	
    	
	<script src="http://code.jquery.com/jquery-1.10.2.min.js"></script>
	<script src="http://code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
  	<script src="http://code.jquery.com/mobile/1.4.2/jquery.mobile-1.4.2.min.js"></script>
  	<script src='<spring:url value="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.11.1/jquery.validate.js"/>'></script>			
	<script src='<spring:url value="/resources/js/webService.js"/>'></script>

    <script type="text/javascript">
		var _Commn = new webService.Web.ComnService();
		var _Async = new webService.Web.AsyncService(_Commn.fnBeforRun, _Commn.fnAfterRun);
        
		// 로그인/찾기 패널 토글  및 쿠키정보값 설정
		$(function(){
 		    $('a[href=#frmUserLogin]').click(function(){
		        var panel = $(this).attr('href');
		        $(panel).toggle();
		        
	        	$('#frmUserLogin').show();
	        	$('#frmFindUserInfo').hide();
	        	
		        return false;
		    });
 			
		    $('a[href=#right-panel]').click(function(){
				var userId = '${cookie.userId.value}';
	        	var userType = '${cookie.userType.value}';	   	        	        	
        		
	         	if(userId != "" && userType != "") {
	        		$('#txtUser').val(userId); 
	        		$('input:radio[name=userType]:input[value='+userType+']').attr("checked", true).checkboxradio("refresh");        
	        		$('#txtUserPwd').focus();
	        	} else {        	
	        		$('input:radio[name=userType]:input[value="1"]').attr("checked", true).checkboxradio("refresh");
	        		$('#txtUserID').focus();
	        	}
		    });		    
		});		
		
        // 사용자/비밀번호 찾기 Div Open
        function fnOpenFindUser(title) {
			if(title == 'U') {
        		title = '사용자찾기';
        	} else {
        		title = '비밀번호찾기';
        	}
        	
         	$('#spTitle').html(title); 
        	$('#txtFUserId').focus();
        	        	
        	$('#frmUserLogin').hide();
        	$('#frmFindUserInfo').show();        	
 		}
        
		// 로그인 엔터입력
        function fnEnterKey(type) {
        	if(event.keyCode == 13) {
	        	if(type == "I") 
	        		$('#txtUserPwd').focus();
	        	else if(type == "P") 
	        		fnLogin();
        	}
        }
        
        // 로그인
    	function fnLogin() {    		    	
        	var autoLogin = 'N';
        	
        	if($('#chkAutoLogin').is(":checked"))
        		autoLogin = "Y";        	        
        	
      	    _Async.post (
    			"/account/actionLogin.do",
    			JSON.stringify({ userId: $('#txtUser').val(), password: $('#txtUserPwd').val(), userType: $('input[name=userType]:checked').val() }),
    			function (data) {    
    				if(data.message == 'success' || data.message == 'duplicated') {
    					document.location.href='/main?saveYn=' + autoLogin;
    					sendUserInfoToApp($('#txtUser').val(), $('#txtUserPwd').val(), $('input[name=userType]:checked').val());
    				} else {
    					alert(data.message);    					
    				}
    			}
    		);
    	}
        
    	function sendUserInfoToApp(id, pwd, userType){
    		window.HybridApp.setMessage(id, pwd, userType);
    	}    	    
        
        // 사용자찾기
    	function fnFindUser() {
    		var url = "/account/findUser.do";
    		
    		if($("#spTitle").html() == "비밀번호찾기")
    			url = "/account/findPwd.do";
    			
    		_Async.post (
    			url,
    			JSON.stringify({ userId: $('#txtFUserId').val(), userType: $('input[name=fUserType]:checked').val() }),
    			function (data) {                
    				if(data.message =='success') {
    					$('#txtFUserId').val("");
    					$('input:radio[name=fUserType]:input[value="1"]').attr("checked", true).checkboxradio("refresh");
    				} else {
    					alert(data.message);
    				}    					    				    		
    			} 
    		);	    				    
    	}  
        
/*
        // 내정보 
    	function fnMyInfo() {			
      	    _Async.post (
    			"/account/myInfo.do",
    			'',
    			function (data) {                
    				if(data.message == 'success') {
    					$('#myInfoModal').modal('show'); 
    					$("#txtIUserId").val(data.userInfo.userId);
    					$("#txtIUserNm").val(data.userInfo.userNm);    					
    					$("#txtIMobile").val(data.userInfo.mobile);
    					$('#txtIPrevPasswd').focus();
    				}
    			} 
    		);				
    	}  
        
        // 내정보 수정
    	function fnMyInfoUpdate() {

        	if( $('#txtIPasswd').val() == $('#txtIPrevPasswd').val() ) {
        		alert('신규 비밀번호와 이전 비밀번호가 일치합니다');
        		return;
        	} else if( $('#txtIPasswdConfirm').val() != $('#txtIPasswd').val() ) {
        		alert('신규 비밀번호를 확인하세요');
        		return;
        	}
        	
      	    _Async.post (
    			"/account/myInfoUpdate.do",
    			JSON.stringify({ userId: $('#txtIUserId').val(), mobile: $('#txtIMobile').val(), password: $('#txtIPasswd').val(), prevPassword: $('#txtIPrevPasswd').val() }),
    			function (data) {                
    				if(data.message == 'success') {
    					$('#myInfoModal').hide();
    					
    					$('#txtIPasswd').val("");
    					$('#txtIPrevPasswd').val("");
    					$('#txtIPasswdConfirm').val("");
    				} else {
    					alert(data.message);
    				}
    			} 
    		);		
    	}    
*/        		
    </script>    
</head>
<body>
	<div data-role="page" class="jqm-demos ui-responsive-panel" id="mainPage">
		<div data-role="header">
			<h1>견적의신</h1>			
			<a href="#nav-panel" data-icon="bars" data-iconpos="notext">Menu</a>
			
			<c:if test="${empty sessionScope._USER_INFO_}">
				<a href="#right-panel" id="menuLogin" data-icon="user" data-iconpos="notext">로그인</a>				
			</c:if>
			<c:if test="${not empty sessionScope._USER_INFO_}">
				<a href="javascript:_Commn.fnPageMove('/account/logout');" data-icon="forward" data-iconpos="notext">로그아웃</a>
			</c:if>
		</div>	
		<div data-role="panel" data-display="push" data-theme="b" id="nav-panel">	
			<ul data-role="listview">
				<li data-icon="delete"><a href="#" data-rel="close" style="height:30px; padding-top: 18px;">닫기</a></li>
				<li><a href="javascript:_Commn.fnPageMove('<spring:url value="/main"/>');" style="height:30px; padding-top: 18px;">HOME</a></li>
				<c:if test="${not empty sessionScope._USER_INFO_}">
					<li><a href='#' onclick="fnMyInfo();" style="height:30px; padding-top: 18px;">내정보</a></li>							
				</c:if>	 				
				<li><a href="javascript:_Commn.fnPageMove('<spring:url value="/board/Notice"/>');" style="height:30px; padding-top: 18px;">공지사항</a></li>
				<li><a href="javascript:_Commn.fnPageMove('<spring:url value="/board/FAQ"/>');" style="height:30px; padding-top: 18px;">FAQ</a></li>
				<li><a href="javascript:_Commn.fnPageMove('<spring:url value="/request/list"/>');" style="height:30px; padding-top: 18px;">의뢰목록</a></li>
				<li><a href="javascript:_Commn.fnPageMove('<spring:url value="/request/list"/>');" style="height:30px; padding-top: 18px;">영업랭킹</a></li>																					
			</ul>	    
		</div>	
		<div data-role="panel" data-position="right" data-position-fixed="false" data-display="overlay" id="right-panel" data-theme="b">
			<form id="frmUserLogin" class="userform">
				<h2>로그인</h2>
				<div class="switch">
				    <fieldset data-role="controlgroup" data-theme="b" data-type="horizontal">
				        <input type="radio" name="userType" id="radio-choice-t-4a" value="1" >
				        <label for="radio-choice-t-4a">일반</label>
				        <input type="radio" name="userType" id="radio-choice-t-4c" value="2">
				        <label for="radio-choice-t-4c">영업사원</label>
				    </fieldset>					
				</div>
				<label for="name">ID (Email)</label>
				<input type="text" name="userId" id="txtUser" data-mini="true" onKeypress="fnEnterKey('I');">						
				<label for="password">Password</label>
				<input type="password" name="password" id="txtUserPwd" data-clear-btn="true" autocomplete="off" data-mini="true" onKeypress="fnEnterKey('P');">				
				<label for="name" style="width:45px;">ID저장
					<input type="checkbox" name="autoLogin" id="chkAutoLogin" data-mini="true" checked="checked">
				</label>
				<div class="ui-grid-a">
					<div class="ui-block-a"><a href="#" data-rel="close" data-role="button" data-theme="c" data-mini="true" onClick="fnLogin();">로그인</a></div>
				    <div class="ui-block-b"><a href="#" data-rel="close" data-role="button" data-theme="b" data-mini="true">취소</a></div>				    
				</div>							
				<div class="ui-grid-a">
					<label for="text"><a href="#" data-icon="plus" data-iconpos="notext" onclick="fnOpenFindUser('U');" style="text-decoration: none;">ID를 분실했나요?</a></label>
					<label for="text"><a href="#" data-icon="plus" data-iconpos="notext" onclick="fnOpenFindUser('P');" style="text-decoration: none;">비빌번호를 분실했나요?</a></label>
					<label for="name">						
						<a href="#" data-icon="plus" data-iconpos="notext" onclick="document.location.href='<spring:url value="/account/membership"/>';" style="text-decoration: none;">계정이 없으신가요?</a>				
					</label>
				</div>	
			</form>	
			<form id="frmFindUserInfo" class="userform" style="display: none;">
				<h2 id="spTitle">사용자찾기</h2>			
			    <fieldset data-role="controlgroup" data-theme="b" data-type="horizontal">
			        <input type="radio" name="fUserType" id="radio-choice-t-4a" value="1" checked="checked">
			        <label for="radio-choice-t-4a">일반</label>
			        <input type="radio" name="fUserType" id="radio-choice-t-4c" value="2">
			        <label for="radio-choice-t-4c">영업사원</label>
			    </fieldset>										
				<label for="name">ID (Email)</label>
				<input type="text" name="txtFUserId" id="txtFUserId" data-mini="true">
				<div class="ui-grid-a">
					<div class="ui-block-a"><a href="#" data-rel="close" data-role="button" data-theme="c" data-mini="true" onClick="fnFindUser();">찾기</a></div>
				    <div class="ui-block-b"><a href="#frmUserLogin" data-rel="close" data-role="button" data-theme="b" data-mini="true">취소</a></div>				    
				</div>								    			
			</form>				
		</div><!-- /panel -->			
		<jsp:doBody /><!-- Contents by pages -->	
	</div><!-- /page -->
</html>
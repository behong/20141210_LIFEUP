<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang='ko'>
<head>
<%@ include file="../include/library.jsp" %>
<script type="text/javascript">
	$(document).ready(function() {		   			
		// 로그인/사용자찾기 패널 취소
		$('a[href=#frmUserLogin]').click(function() {
	    	$('#frmUserLogin').show();
	    	$('#frmFindUserInfo').hide();
	    	
	    	$("#frmUserLogin").find("input[name='password']").focus();
	    }); 	
		
		var userId = $.cookie("userId");
//		var userType = $.cookie("userType");	   		
	
		//if(typeof userId != 'undefined' && typeof userType != 'undefined') {
		if(typeof userId != 'undefined') {
			userId = decodeURI(userId);
//			userType = decodeURI(userType);
				
			$("#frmUserLogin").find("input[name='userId']").val(userId); 
//			$("#frmUserLogin").find("input[name=userType]").filter("[value=\"" + userType + "\"]").attr("checked", true);
			$("#frmUserLogin").find("input[name='password']").focus();
		} else {        			
//			$("#frmUserLogin").find("input[name=userType]").filter('[value="1"]').attr("checked", true);
			$("#frmUserLogin").find("input[name='userId']").focus();
		}			
	});	
	
	// 사용자/비밀번호 찾기 Div Open
	function fnActiveFormOpen(flag) {
		var title = "로그인";
		
		if(flag == 'U') {
			title = '사용자찾기';
		} else if(flag == 'P') {
			title = '비밀번호찾기';
		} 
		
		$('#frmUserLogin').hide();		
		$('#frmFindUserInfo').hide();		
	
		if(flag == "L") {
			$('#frmUserLogin').show();				
			$("#frmUserLogin").find("input[name='userId']").focus();
		} else {		
			$('#frmFindUserInfo').show();		
			$("#frmFindUserInfo").find("input[name='txtFUserId']").focus();				
		}
		
		$("#buttonText").text(title);
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
			JSON.stringify({ userId: $('#txtUser').val(), password: $('#txtUserPwd').val() }),
			//JSON.stringify({ userId: $('#txtUser').val(), password: $('#txtUserPwd').val(), userType: $('input[name=userType]:checked').val() }),
			function (data) {    
				if(data.message == 'success' || data.message == 'duplicated') {
					// AutoCheck 값 설정 후 main으로 이동
					$("#frmUserLogin").find("input[name='saveYn']").val(autoLogin);
									
					if(autoLogin == "Y") {
						$.cookie("userId", encodeURI($('#txtUser').val()), { path: '/', expires: 365 });
//						$.cookie("userType", encodeURI($('input[name=userType]:checked').val()), { path: '/', expires: 365 });
					} else {
						$.removeCookie("userId");
//						$.removeCookie("userType");
					}					
					
					frmUserLogin.method="post";
					frmUserLogin.action = "/main";
					frmUserLogin.submit();	
					
					sendUserInfoToApp($('#txtUser').val(), $('#txtUserPwd').val());
					//sendUserInfoToApp($('#txtUser').val(), $('#txtUserPwd').val(), $('input[name=userType]:checked').val());
				} else {
					alert(data.message);    					
				}
			}
		);
	}
	
	//function sendUserInfoToApp(id, pwd, userType){
	function sendUserInfoToApp(id, pwd) {
		if(typeof window.HybridApp != 'undefined')
			window.HybridApp.setMessage(id, pwd);
			//window.HybridApp.setMessage(id, pwd, userType);			
	}  
		
	// 사용자찾기
	function fnFindUser() {
		var url = "/account/findUser.do";
		if($("#buttonText").text() == "비밀번호찾기")
			url = "/account/findPwd.do";
			
		_Async.post (
			url,
			JSON.stringify({ userId: $('#txtFUserId').val() }),
			function (data) {                
				if(data.message =='success') {
					$('#txtFUserId').val("");
				} else {
					alert(data.message);
				}    					    				    		
			} 
		);	    				    
	}
</script>	
<link rel="stylesheet" href="/resources/css/login.css">
<link rel="stylesheet" href="/resources/css/button.css">

</head>
<body>
	<%@ include file="../include/header.jsp" %>
	<div class="content">
		<div class="wrap">
			<div id="main" >							
				<form id="frmUserLogin" class="form" style="padding-left: 5px; padding-right: 5px;">
					<input type="hidden" id="saveYn" name="saveYn" />				
					
					<label for="name">아이디
						<input type="text" class="input-text" name="userId" id="txtUser"  onKeypress="fnEnterKey('I');">
					</label>
						
					<label for="password">비밀번호
						<input type="password"  class="input-text" name="password" id="txtUserPwd" onKeypress="fnEnterKey('P');">
					</label>
									
			
					<div >
						<label for="name" style="width:75px; padding-top: 10px;">아이디 저장
							<input type="checkbox" name="autoLogin" id="chkAutoLogin" checked="checked">
						</label>																 
					</div>

					<div >
						<span class="loginbutton red" onClick="fnLogin();">로그인</span>
					</div>				    
										
					<div >
						<span class="loginbutton black" onclick="fnActiveFormOpen('P');" class="loginbox_text" style="text-decoration:none;">비밀번호 찾기</span>
					</div>
					<div >
						<span class="loginbutton black" onclick="fnActiveFormOpen('U');" class="loginbox_text" style="text-decoration:none;">사용자 찾기</span>
					</div>
					<div >
						<span class="loginbutton red" onclick='_Commn.fnPageMove("/account/membership")' class="loginbox_text" style="text-decoration:none;">회원가입</span>
					</div>										

				</form>	
				
				<form id="frmFindUserInfo"  class="form"  style="display: none;">
						<div>
						<label for="name">아이디 (이메일)
						<input type="text" class="input-text"  name="txtFUserId" id="txtFUserId" >						
							<a href="#"  onClick="fnFindUser();" class="loginbox_text"  style="text-decoration:none;"><span id="buttonText"></span></a>
							<a href="#"  onclick="fnActiveFormOpen('L');" class="loginbox_text"  style="text-decoration:none;">취소</a>
						</label>						
						</div>
				</form>			
			</div>	
		</div>	
	</div><!-- /page -->

</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="java.util.*" %>

<!DOCTYPE html>
<html lang='ko'>
<head>		
<%@ include file="../include/library.jsp" %>
<link rel="stylesheet" href="/resources/css/mylist.css">
<link rel="stylesheet" href="/resources/css/request_write.css">
<link rel="stylesheet" href="/resources/css/liquid-slider.css">
<link rel="stylesheet" href="/resources/css/mylist/animate.min.css">
<style>
	 .done{ color:red; }
	 label { font-size: 12pt; }
	 .push_checkbox { color:red; }
</style>
	
<script type="text/javascript">
	/*ready 는 로딩 할때 한번만 로딩 AJAX 호출과 무관하다*/
	$(document).ready(function() {
		fnMyPageSidoChange('${userInfo.userType}');
		fnValidator();			
		fnInitialize('${userInfo.userType}');
	});
	
	function fnInitialize(userType) {
		var userType = $.trim($("#userType").val()); 
		var initPushYn = $.trim("${userInfo.push_flag}");
		var initEmailYn = $.trim("${userInfo.mail_flag}");

		if(initPushYn == "Y" && userType == "1") { 
			$('input:checkbox[id="push_checkbox_n"]').attr("checked","checked");
		}
		if(initPushYn == "Y" && userType == "2") { 
			$('input:checkbox[id="push_checkbox_s"]').attr("checked","checked");
		}
		
		if(initEmailYn == "Y") {
			if(userType == '1')
				$('input[id="mail_checkbox_n"]').prop("checked", true);
			else
				$('input[id="mail_checkbox_s"]').prop("checked", true);
		}
		return;
	}
	
	function fnMyPageSidoChange(userType) {				
		if(userType == 2)
			return;
		
		var sidoCd = $('#ddlNSido').val();		
		if(sidoCd == '0'  || sidoCd =='' )
			return;
		$("#ddlNGugun").find("option").remove().end().append("<option value=\"\">선택</option>");
		
		_Async.post (
			"/selectRegionJson",
			sido_cd = sidoCd,
			function (data) {
				var resultData = data.Sido2; 
				
				$.each(resultData, function(index, row) {
					if(row.gugun_cd == $('#hdnRegion').val())
						$("#ddlNGugun").append("<option value='"+ row.gugun_cd +"' selected>" + row.gugun_nm  + "</option>");
					else
						$("#ddlNGugun").append("<option value='"+ row.gugun_cd +"'>" + row.gugun_nm  + "</option>");
				});
			}    			
		);   			
	}
	
	function fnSetUserConfig(type) {
		var userId, userType, data, flagYn;
		
		userId   = $('#userId').val();
		userType = $('#userType').val();					

		if(type == "mail") {
			if(userType == '1')
				if(	$("input[id='mail_checkbox_n']").val() =="Y"){
					$("input[id='mail_checkbox_n']").removeAttr("checked");
					$("input[id='mail_checkbox_n']").val("N");
					flagYn = "N";
				}else{
					$("input[id='mail_checkbox_n']").attr("checked","checked");
					$("input[id='mail_checkbox_n']").val("Y");
					flagYn = "Y";
				}					
				//flagYn = $("#mail_checkbox_n").prop("checked") == true ? "Y" : "N";
			else
				if(	$("input[id='mail_checkbox_s']").val() =="Y"){
					$("input[id='mail_checkbox_s']").removeAttr("checked");
					$("input[id='mail_checkbox_s']").val("N");
					flagYn = "N";
				}else{
					$("input[id='mail_checkbox_s']").attr("checked","checked");
					$("input[id='mail_checkbox_s']").val("Y");
					flagYn = "Y";
				}					
				//flagYn = $("#mail_checkbox_s").prop("checked") == true ? "Y" : "N";			
				data = {"userId": userId, "userType": userType, "mail_flag" : flagYn};
		}else if(type == "push") {
			if(userType == '1'){
				if(	$("input[id='push_checkbox_n']").val() =="Y"){
					$("input[id='push_checkbox_n']").removeAttr("checked");
					$("input[id='push_checkbox_n']").val("N");
					flagYn = "N";
				}else{
					$("input[id='push_checkbox_n']").attr("checked","checked");
					$("input[id='push_checkbox_n']").val("Y");
					flagYn = "Y";
				}			
				//console.log("flaaaag=== " + flagYn);
				//flagYn =$("input:checkbox[id='push_checkbox_n']").is(":checked") == true ? "Y" : "N";
			}else{
				if(	$("input[id='push_checkbox_s']").val() =="Y"){
					$("input[id='push_checkbox_s']").removeAttr("checked");
					$("input[id='push_checkbox_s']").val("N");
					flagYn = "N";
				}else{
					$("input[id='push_checkbox_s']").attr("checked","checked");
					$("input[id='push_checkbox_s']").val("Y");
					flagYn = "Y";
				}				
				//flagYn = $("#push_checkbox_s").prop("checked") == true ? "Y" : "N";
			}
			data = {"userId": userId, "userType": userType, "push_flag" : flagYn};
		}

		_Async.post (
			"/mypage/configUpdate",
			JSON.stringify(data),
			function (data) {    
				alert(data.message);
			}    			
		); 
	}
	
	function fnValidator() {		
		$("#frmNormal").validate({
	        rules: {
	        	prevPassword: { required: true },
	        	password: { required: true },
	        	passwordConfirm: { equalTo: "#tbxNPwd" },
	            mobile: { required: true },
	            region: { required: true }
	        },
	        messages: { 
	        	prevPasswd: { required: "이전 비밀번호를 입력하세요" },
				password: { required: "비밀번호를 입력하세요." },
				passwordConfirm: { equalTo: "비밀번호를 다시 확인하세요." },                       
	            mobile: { required: "전화번호를 입력해주세요" },
	            region: { required: "거주지역을 선택해주세요" }
	        }
	    });
		
		$("#frmSales").validate({	  
	        rules: {
	        	prevPassword: { required: true },
	        	password: { required: true },
	        	passwordConfirm: { equalTo: "#tbxSPwd" },
	        	mobile: { required: true },
	        	office_no: { required: false },
	        	vendorId: { required: true },
	        	vendorLoc: { required: false },
	        	intro_msg: { required: true }                                
	        },
	        messages: {
	        	prevPasswd: { required: "이전 비밀번호를 입력하세요" },
				password: { required: "비밀번호를 입력하세요." },
				passwordConfirm: { equalTo: "비밀번호를 다시 확인하세요." },
				mobile: { required: "전화번호를 입력해주세요" },
	//			office_no: { numeric: "숫자만 입력하세요." },                
	          	vendorId: { required: "소속회사를 선택하세요." },
	//          vendorLoc: { required: "근무지점을 입력하세요." },
	          	intro_msg: { required: "인사말을 입력하세요." }             
	        }
	    });		
	}	
	
	function fnMyInfoUpdate(type) {	
		var data;
			
		if(type == 'N') {
			if($('#tbxNPrevPasswd').val() == "" || $('#tbxNPwdConfirm').val() == "") {
				alert('비밀번호를 확인하세요');
				return;
			} 
			
			if($('#tbxNPrevPasswd').val() == $('#tbxNPwdConfirm').val()) { 
				alert('이전 비밀번호와 동일합니다. 새로운 비밀번호를 입력하세요');
				return;
			}
			
			data = _Commn.getFormData($('#frmNormal'));
		} else {
			if($('#tbxSPrevPasswd').val() == "" || $('#tbxSPwdConfirm').val() == "") {
				alert('비밀번호를 확인하세요');
				return;
			}
			
			if($('#tbxSPrevPasswd').val() == $('#tbxSPwdConfirm').val()) { 
				alert('이전 비밀번호와 동일합니다. 새로운 비밀번호를 입력하세요');
				return;
			}
			
			if(!_Commn.fnCheckSpecialChar($('#tbxSLocation', "#mypage").val())) {
				$('#tbxSLocation', "#mypage").focus();
				alert('특수문자는 사용할 수 없습니다');
				return;
			}					
	
			if(!_Commn.fnCheckSpecialChar($('#tbxSIntro', "#mypage").val())) {
				$('#tbxSIntro', "#mypage").focus();
				alert('특수문자는 사용할 수 없습니다');
				return;
			}
						
			data = _Commn.getFormData($('#frmSales'));			
		}						
		
		_Async.post (
			"/mypage/update",
			JSON.stringify(data),
			function (data) {    
				alert(data.message);
			}
		); 		
	}

	function fnMyPageReqDetail(requestId) {
		$('#hdnRequestId', '#frmMyList').val(requestId);
		
		frmMyList.method = "post";
		frmMyList.action = "/request/detail";
		frmMyList.submit();
	}
</script>
</head>
<body class="no-js">
	<%@ include file="../include/header.jsp" %>	
	<div class="content">
		<div class="wrap">
			<div class="single-page">						
				<div class="single-page-artical">
					<div class="artical-content">
						<form id='frmMyList' name='frmMyList' method='post'>
							<input type='hidden' id='hdnRequestId' name='request_id'/>
						</form>							
						<form id='frmPush' name='frmPush' method='post'>
							<input type='hidden' id='userId' name='userId' value="${userInfo.userId}"/>
							<input type='hidden' id='userType' name='userType' value="${userInfo.userType}"/>
							<input type='hidden' id='initEmailYn_id' name='initEmailYn' value="${userInfo.mail_flag}"/>
						</form>		
					
						<div id="main-slider" class="liquid-slider">						
							<c:choose>
								<c:when test="${userInfo.userType == '1'}">
									<div>
										<h2 class="title">내견적</h2>
										<div id="tabs-1"><br/>											
											<input type='hidden' id='hdnRequestId' name='request_id'/>	
											<div class="tbl_1">						
											<table>
												<colgroup>
													<col width="5%">
													<col width="*">
													<col width="20%">
												</colgroup>
												<tr>
													<th>번호</th>
													<th>제목</th>
													<th>날짜</th>
												</tr>					
												<c:forEach items="${contractList}" var="list" varStatus="status">			     
													<tr>
														<td>${status.count}</td>
														<td><a href="#" onclick="fnMyPageReqDetail('${list.req_id}');">${list.customer_req}</a></td>
														<td><fmt:formatDate value="${list.create_date}" pattern="yyyy-MM-dd HH:mm"/></td>
													</tr>		
												<c:if test="${empty contractList}">  
													<tr><td>등록된 견적의뢰 내용이 없습니다</td></tr>								
												</c:if>																			
										    	</c:forEach>
											</table>
				 		    			  </div>														
										</div>
									</div>
									<div>
										<h2 class="title">내정보</h2>
										<div id="tabs-2"><br/>
											<form id='frmNormal' name='frmNormal' method='post'>
												<input type="hidden" id='hdnRegion' name='initRegion' value='${userInfo.region}' />
												<input type='hidden' id='hdnUserType' name='userType' value='1' />
												<input type="hidden" id='tbxNUserId' name='userId' value='${userInfo.userId}' />					
											    <div >    	 
											         <label for="userId">아이디(이메일)</label>			
											         <label>${userInfo.userId}</label>	       			         
											    </div>				    
											    <div>    	 
											         <label for="password">이전 비밀번호
											         <input type="password" class="input-text" id='tbxNPrevPasswd' name='prevPassword' />
											         </label>
											    </div>				    
											    <div>    	 
											         <label for="password">비밀번호</label>
											         <input type="password"  id='tbxNPwd' name='password' />
											    </div>
											    <div>    	 
											         <label for="passwordConfirm">비밀번호 확인</label>
											         <input type="password"  id='tbxNPwdConfirm' name='passwordConfirm' />
											    </div>    
											    <div>    	 
											         <label for="userNm">성명</label>
											         <label>${userInfo.userNm}</label>
											    </div>     
												<div>							
													<label for="ddlSido">지역</label>
												    <select id="ddlNSido" onchange="fnMyPageSidoChange();">
														<option value=''>선택</option>
														<c:forEach items="${regions}" var="sido">
															<option value="${sido.sido_cd}" ${ sido.sido_cd == userInfo.sido_cd ? 'selected' : ''}>${sido.sido_nm}</option>
														</c:forEach>
												    </select>		    
												    <select name="region" id="ddlNGugun">
												    	<option value=''>선택</option>
												    </select>		    							
											    </div>	            
											    <div>    	 
											         <label for="mobile">전화번호</label>
											         <input type="text" maxlength="11" id='tbxNMobile' name='mobile' value='${userInfo.mobile}' onkeydown='return _Commn.fnNumberChkInputBox(event);' />
											    </div>  
												<div style="margin-top: 7px; margin-right: -10px; text-align: right;">
													<a href="#" onclick="fnMyInfoUpdate('N')">정보수정</a>
												</div>				                   
										    </form>
										</div>
									</div>          
									<div>
										<h2 class="title">푸쉬메시지</h2>
										<div id="tabs-3"><br/>											
											<label>
							        			<input type="checkbox" id="mail_checkbox_n" onClick="fnSetUserConfig('mail');" value="${userInfo.mail_flag}">메일 수신 동의
							        		</label>		 
							    			<label>
							        			<input type="checkbox"  id="push_checkbox_n"  onClick="fnSetUserConfig('push');" value="${userInfo.push_flag}" >푸쉬 수신 동의
							    			</label>										    		
										</div>
									</div>
								</c:when>
								<c:when test="${userInfo.userType == '2'}">									
									<div>
										<h2 class="title">내견적</h2>
										<div id="tabs-4"><br/>											
											<input type='hidden' id='hdnRequestId' name='request_id'/>	
											<div class="tbl_1">						
												<table>
													<colgroup>
														<col width="5%">
														<col width="*">
														<col width="20%">
													</colgroup>
													<tr>
														<th>번호</th>
														<th>제목</th>
														<th>날짜</th>
													</tr>					
													<c:forEach items="${contractList}" var="list" varStatus="status">			     
														<tr>
															<td>${status.count}</td>
															<td><a href="#" onclick="fnMyPageReqDetail('${list.req_id}');">${list.salesman_benefit}</a></td>
															<td><fmt:formatDate value="${list.create_date}" pattern="yyyy-MM-dd HH:mm"/></td>
														</tr>									
														<c:if test="${empty contractList}">  
															<tr><td>등록된 견적내역이 없습니다</td></tr>								
														</c:if>
											    	</c:forEach>
												</table>
						    			  	</div>														
										</div>
									</div>
									<div>
										<h2 class="title">내정보</h2>
										<div id="tabs-5"><br/>
											<!--  영업사원 정보 수정 -->					    
										    <form id='frmSales' name='frmSales' method='post'>
										    	<input type='hidden' id='hdnUserType' name='userType' value='2' />
										    	<input type="hidden" id='tbxSalesmanId' name='userId' value='${userInfo.userId}' />
											    <div>    	 
											         <label>아이디(이메일)</label>
											         <label>${userInfo.userId}</label>				         
											    </div>
											    <div>    	 
											         <label>이전 비밀번호</label>
											         <input type="password" id='tbxSPrevPasswd' name='prevPassword' />
											    </div>				    
											    <div>    	 
											         <label>비밀번호</label>
											         <input type="password" id='tbxSPwd' name='password' />
											    </div>
											    <div>    	 
											         <label>비밀번호 확인</label>
											         <input type="password" id='tbxSPwdConfirm' name='passwordConfirm' />
											    </div>    
											    <div>    	 
											         <label>성명</label>
											         <label>${userInfo.userNm}</label>				         
											    </div>     
											    <div>    	 
											         <label>핸드폰 번호</label>
											         <input type="text" maxlength="11" id='tbxSMobile' name='mobile' value='${userInfo.mobile}' onkeydown='return _Commn.fnNumberChkInputBox(event);' />
											    </div>  
											    <div>    	 
											         <label>사무실 전화번호</label>
											         <input type="text" maxlength="11" id='tbxOffice' name='office_no' value='${userInfo.office_no}' onkeydown='return _Commn.fnNumberChkInputBox(event);' />
											    </div> 
												<div>
													<label>소속회사</label>
												    <select name="vendorId" id="ddlSVendor">
														<option value=''>선택</option>
														<c:forEach items="${venders}" var="vendor">
															<option value="${vendor.code}" ${ vendor.code == userInfo.vendorId ? 'selected' : ''}>${vendor.value}</option>
														</c:forEach>
												    </select>				    		   					
											    </div>	
											    <div>    	 
											         <label>근무지점</label>
											         <input type="text" id='tbxSLocation' name='vendorLoc' value='${userInfo.vendorLoc}' />
											    </div>
											    <div>    	 
											         <label>간략소개</label>
											         <input type="text" id='tbxSIntro' name='intro_msg' value='${userInfo.intro_msg}' />
											    </div>
												<div style="margin-top: 7px; margin-right: -10px; text-align: right;">
													<a href="#" onclick="fnMyInfoUpdate('S')">정보수정</a>
												</div>				                   				    
										    </form>    
										</div>
									</div>					
									<div>
										<h2 class="title">결제내역</h2>
										<div id="tabs-6"><br/>
											<!--결제내역 -->
											<form id='frmChargeList' name='frmChargeList' method='post'>
											<div class="tbl_1">	
												<table>
													<colgroup>
														<col width="7%">
														<col width="10%">
														<col width="20%">
														<col width="20%">
														<col width="10%">
														<col width="20%">
													</colgroup>
													<tr>
														<th>요청일</th>
														<th>입금액</th>
														<th>포인트</th>
														<th>잔여포인트</th>
														<th>상태</th>
														<th>처리완료일</th>
													</tr>										
													<tbody>
														<c:forEach items="${receiptList}" var="list">
														<tr>
															<td><fmt:formatDate value="${list.requestDate}" pattern="yyyy-MM-dd"/></td>
															<td><fmt:formatNumber value="${list.amount}" groupingUsed="true" /></td>
															<td><fmt:formatNumber value="${list.point}" groupingUsed="true" /></td>
															<td><fmt:formatNumber value="${list.totalPoint}" groupingUsed="true" /></td>
															<td>${list.status_nm}</td>
															<td><fmt:formatDate value="${list.confirmDate}" pattern="yyyy-MM-dd HH:mm"/></td>
														</tr> 
														<c:if test="${empty receiptList}">  
															<li>등록된 결제내역이 없습니다</li>								
														</c:if>							
														</c:forEach>          
													</tbody>
												</table>			
												</div>						
											</form>			
										</div>
									</div>									
									<div>
										<h2 class="title">포인트사용내역</h2>
										<div id="tabs-7"><br/>
										<!-- 포인트 사용 내역 리스트 -->							
											<div class="tbl_1">	
												<table>
													<colgroup>
														<col width="10%">
														<col width="20%">
														<col width="*">
														<col width="10%">
													</colgroup>
													<tr>
														<th>요청일</th>
														<th>사용포인트</th>
														<th>견적글 요약</th>
														<th>견적상태</th>
													</tr>										
													<tbody>
														<c:forEach items="${cashLogList}" var="list">
														<tr>
															<td><fmt:formatDate value="${list.create_date}" pattern="yyyy-MM-dd"/></td>
															<td><fmt:formatNumber value="${list.point}" groupingUsed="true" /></td>
															<td>${list.customer_req}</td>
															<td>${list.status}</td>
														</tr> 
														<c:if test="${empty cashLogList}">  
															<li>등록된 결제내역이 없습니다</li>								
														</c:if>							
														</c:forEach>          
													</tbody>
												</table>			
											</div>						
										</div>
									</div>							
									<div>
										<h2 class="title">푸쉬메시지</h2>
										<div id="tabs-8"><br/>
											<div class="tbl_1">
												<!-- 수신설정 -->
												<label>
								        			<input type="checkbox" id="mail_checkbox_s" onClick="fnSetUserConfig('mail');" value="${userInfo.mail_flag}">메일 수신 동의
								        		</label>		 
								    			<label>
								        			<input type="checkbox" id="push_checkbox_s" onClick="fnSetUserConfig('push');" value="${userInfo.push_flag}">푸쉬 수신 동의
								    			</label>		
											</div>
										</div>																    
									</div>
								</c:when>
								<c:otherwise>
									<div>사용할 메뉴가 없습니다(비로그인))</div>
								</c:otherwise>
							</c:choose>																
						</div>
						<footer>
							<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.3/jquery.easing.min.js"></script>
							<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.touchswipe/1.6.4/jquery.touchSwipe.min.js"></script>
							<script type="text/javascript" src="/resources/js/jquery.liquid-slider.min.js"/></script>  
							<script>
								$('#main-slider').liquidSlider();
							</script>
						</footer>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>

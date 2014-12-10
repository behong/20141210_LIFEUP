<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang='ko'>
<head>		
<%@ include file="../include/library.jsp" %>	
<script type="text/javascript">
	$(document).ready(function() {
		$('#ddlNGugun').removeAttr('style');
		
		//라디오 버튼 영역 제이쿼리 css 적용
		$( "#button" ).button();
		$( "#radioset" ).buttonset();
		
		fnValidator();
	});	
	
	// 약관 선택시 DIV 제어
	function fnShowDoc(docType) {
		if(docType == 1) {
			$("#divDocOne").toggle();
			$('html, body').animate({ scrollTop: $(document).height()},800);
		} else {
			$("#divDocTwo").toggle();
			$('html, body').animate({ scrollTop: $(document).height()},800);			
		}			
	}
	// 회원가입 선택시 나타나는 폼 제어
	function fnChoiceUser(userType) {
		if(userType == 1) {
			$("#divSalesForm").hide();
			$("#divNormalForm").show();
		} else {
			$("#divNormalForm").hide();
			$("#divSalesForm").show();
		}	
	}
	
	function fnAccountValidation() {		
		
		if( !$('#chkAgreeOne').is(":checked") || !$('#chkAgreeTwo').is(":checked")) {
			alert('이용약관과 개인정보 수집 및 이용에 대한 안내를 모두 동의해주세요');
			return false;
		} 		
		
		if($("#membershipFrm").find('input[name=userType]:radio:checked').val() == 1) {
			if($("#frmNormal").valid())	
				frmNormal.submit();	
		} else {
			if($("#frmSales").valid())
				frmSales.submit();
		}	
	}
	
	function fnValidator() {
		$("#frmNormal").validate({
	        rules: {
	        	userId: { required: true, email: true, "remote": {
		            		url: '/account/chkExistUserId.do?userType=1',
		            		type: "post",
		                    data: {
		                    	tbxUserId: function() {
		                            return $('#tbxUserId').val();
		                        }
		                    }
		          		} },   
	      		userNm : { required: true }, 
	        	password: { required: true },
	        	passwordConfirm: { equalTo: "#tbxNPwd" },
	            mobile: { required: true },
	            region: { required: true }
	        },
	        messages: {
	            userId: {
	            			required: "아이디(이메일주소)를 입력하세요.",
	                        email: "올바른 이메일주소를 입력하세요.",
	                        remote : jQuery.format("중복 아이디 입니다")
	                    },
				userNm: { required: "성명을 입력하세요." },  
				password: { required: "비밀번호를 입력하세요." },
				passwordConfirm: { equalTo: "비밀번호를 다시 확인하세요." },                       
	            mobile: { required: "전화번호를 입력해주세요" },
	            region: { required: "거주지역을 선택해주세요" }
	        }
	    });
		
		$('#frmSales').validate({
	        rules: {
	        	userId: { required: true, email: true, "remote": {
		            		url: '/account/chkExistUserId.do?userType=2',
		            		type: "post",
		                    data: {
		                    	tbxSalesmanId: function() {
		                            return $('#tbxSalesmanId').val();
		                        }
		                    }
		          		} },   
	      		userNm : { required: true }, 
	        	password: { required: true },
	        	passwordConfirm: { equalTo: "#tbxSPwd" },
	        	mobile: { required: true },
	        	officeNo: { required: false },
	        	vendorId: { required: true },
	        	location: { required: false },
	            introMsg: { required: true }                                
	        },
	        messages: {
	            userId: {
	            			required: "아이디(이메일주소)를 입력하세요.",
	                        email: "올바른 이메일주소를 입력하세요.",
	                        remote : jQuery.format("중복 아이디 입니다")
	                    },
				userNm: { required: "성명을 입력하세요." },  
				password: { required: "비밀번호를 입력하세요." },
				passwordConfirm: { equalTo: "비밀번호를 다시 확인하세요." },
				mobile: { required: "전화번호를 입력해주세요" },
				//officeNo: { numeric: "숫자만 입력하세요." },                
	          	vendorId: { required: "소속회사를 선택하세요." },
				//location: { required: "근무지점을 입력하세요." },
	          	introMsg: { required: "인사말을 입력하세요." }             
	        }
	    });		
	}
	
	function fnAccountSidoChange(obj) {
		if(obj.value == '0')			
			return;
			
		$("#ddlNGugun").find("option").remove().end().append("<option value=\"\">선택</option>");
		
		_Async.post (
			"/selectRegionJson",
			sido_cd = obj.value,
			function (data) {    
				var resultData = data.Sido2; 
				
				$.each(resultData, function(index, row){	    		      		
					$("#ddlNGugun").append("<option value='"+ row.gugun_cd +"'>" + row.gugun_nm  + "</option>");
				});			
			}    			
		);   	         
	}	
</script>
<style type="text/css">
    div.scroll_box{
        height: expression( this.scrollHeight > 49 ? "50px" : "auto" );
        max-height: 50px;
        border: 1px solid #666;
        overflow-y: auto;
    }
</style>
<link rel="stylesheet" href="/resources/css/button.css">
<link rel="stylesheet" href="/resources/css/login.css">

</head>
<body>
	<%@ include file="../include/header.jsp" %>	
	<div class="content">
		<div class="wrap">
			<div id="main" >
		
				<div style="padding-top: 0px;">				
					<form id="membershipFrm" name="membershipFrm">
						<div id="radioset">
							<input type="radio" id="radio1" name="userType" value="1" onclick="fnChoiceUser(1);" checked="checked"><label for="radio1">일반</label>
							<input type="radio" id="radio2" name="userType" value="2" onclick="fnChoiceUser(2);"><label for="radio2">영업사원</label>
						</div>
				    </form>				    
				    <div id="divNormalForm">
						<form id="frmNormal" class="form" name='frmNormal' method='post' action="/account/register"> 
							<input type='hidden' id='hdnUserType' name='userType' value='1' />		
					        <label>아이디(이메일)
					        <input type="text" class="input-text" id='tbxUserId' name='userId' />
					        </label>
					        <label>비밀번호
					        <input type="password"  class="input-text" id='tbxNPwd' name='password' />
					        </label>
					        <label>비밀번호 확인
					        <input type="password"  class="input-text" id='tbxNPwdConfirm' name='passwordConfirm' />
					        </label>
					        <label>성명
					        <input type="text"  class="input-text"  id='tbxNUserNm' name='userNm' value='' />
					        </label>
							<label>지역
							<select name="ddlSido"  class="input-selectbox"  id="ddlNSido" onchange="fnAccountSidoChange(this);">
								<option value=''>선택</option>
								<c:forEach items="${regions}" var="sido">
									<option value="${sido.sido_cd}">${sido.sido_nm}</option>
								</c:forEach>
							</select>
							<select name="region" class="input-selectbox" id="ddlNGugun">
								<option value=''>선택</option>
							</select>	
							</label>
					        <label>전화번호
					        <input type="text" class="input-text" maxlength="11" id='tbxNMobile' name='mobile' onkeydown='return _Commn.fnNumberChkInputBox(event);' />
					        </label>
					    </form>
				    </div>
				    
				    <!--  영업사원 회원가입 폼 Start-->
				    <div id="divSalesForm" style="display:none;">
					    <form id="frmSales" class="form" name='frmSales' method='post' action="/account/register">
					    	<input type='hidden' id='hdnUserType' name='userType' value='2' />						        	 
					         <label>아이디(이메일)
					         <input type="text" class="input-text"  id='tbxSalesmanId' name='userId' />
					         </label>	 
					         <label>비밀번호
					         <input type="password" class="input-text"  id='tbxSPwd' name='password' />
					         </label>	 
					         <label>비밀번호 확인
					         <input type="password" class="input-text"  id='tbxSPwdConfirm' name='passwordConfirm' />
					         </label>						        	 
					         <label>성명
					         <input type="text" class="input-text"  id='tbxSUserNm' name='userNm' value='' />
					         </label>						        	 
					         <label>핸드폰 번호
					         <input type="text" class="input-text" maxlength="11"  id='tbxSMobile' name='mobile' onkeydown='return _Commn.fnNumberChkInputBox(event);' />
					         </label>						        	
					         <label>사무실 전화번호
					         <input type="text" class="input-text" maxlength="11"  id='tbxOffice' name='officeNo' onkeydown='return _Commn.fnNumberChkInputBox(event);' />
					    	 </label>
							 <label>소속회사								
							    <select name="vendorId" class="input-selectbox" id="ddlSVendor" >
									<option value=''>선택</option>
									<c:forEach items="${vendorCodes}" var="vendor">
										<option value="${vendor.code}">${vendor.value}</option>
									</c:forEach>
							    </select>				    		   												
					         </label>						         	 
					         <label>근무지점
					         <input type="text" class="input-text"  id='tbxSLocation' name='location' />
					         </label>	 
					         <label>간략소개
					         <input type="text" class="input-text"  id='tbxSIntro' name='introMsg' />
					         </label>
					    </form>    
				    </div>
				    <!--  영업사원 회원가입 폼 End-->
				    				    
					<div >
						<span class="loginbutton red" onClick="fnAccountValidation();">회원가입</span>
					</div>
						 
					<input type="checkbox" name="chkAgreeOne" id="chkAgreeOne"  onClick="fnShowDoc(1);">
				    <label for="chkAgreeOne">이용약관 동의
					<div id="divDocOne"  class="scroll_box" style="display:none;" >
							<h3>제 1 조 (목적)</h3>
							<p>이 약관은 본 사이트 서비스의 이용과 관련하여 회사와 회원과의 권리, 의무 및 책임사항, 기타 필요한 사항을 규정함을 목적으로 합니다.</p>
							<h3>제 2 조 (정의)</h3>
							<p>이 약관에서 사용하는 용어의 정의는 다음과 같습니다.</p>
							<ul>
							<li>①&quot;서비스&quot;라 함은 본 사이트에 제공하는 정보와 관련 제반 서비스를 의미합니다.</li>
							<li>②&quot;회원&quot;이라 함은 회사의 &quot;서비스&quot;에 접속하여 이 약관에 따라 &quot;회사&quot;와 이용계약을 체결하고 &quot;회사&quot;가 제공하는 &quot;서비스&quot;를 이용하는 고객을 말합니다.</li>
							<li>③&quot;아이디&quot;라 함은 &quot;회원&quot;의 식별과 &quot;서비스&quot; 이용을 위하여 &quot;회원&quot;이 정하고 &quot;회사&quot;가 승인하는 정보를 의미합니다</li>
							<li>④&quot;비밀번호&quot;라 함은 &quot;회원&quot;에게 허가된 아이디과 일치되는 &quot;회원&quot;임을 확인하고 비밀보호를 위해 &quot;회원&quot; 자신이 정한 문자 또는 숫자의 조합을 의미합니다.</li>
							<li>⑤&quot;유료서비스&quot;라 함은 &quot;회사&quot;가 유료로 제공하는 각종 온라인디지털콘텐츠 및 제반 서비스를 의미합니다.</li>
							<li>⑥&quot;포인트&quot;라 함은 서비스의 효율적 이용을 위해 회사가 임의로 책정 또는 지급, 조정할 수 있는 재산적 가치가 없는 &quot;서비스&quot; 상의 가상 데이터를 의미합니다.</li>
							<li>⑦&quot;게시물&quot;이라 함은 &quot;회원&quot;이 &quot;서비스&quot;를 이용함에 있어 &quot;서비스상&quot;에 게시한 부호ㆍ문자 등의 정보 형태의 글, 사진과 링크 등을 의미합니다.</li>
							</ul>
						
							<h3>제 3 조 (약관의 게시와 개정)</h3>
						
							<ul>
							<li>①&quot;회사&quot;는 이 약관의 내용을 &quot;회원&quot;이 쉽게 알 수 있도록 서비스 초기 화면에 게시합니다.</li>
							<li>②&quot;회사&quot;는 &quot;약관의규제에관한법률&quot;, &quot;정보통신망이용촉진및정보보호등에관한법률(이하 &quot;정보통신망법&quot;)&quot; 등 관련법을 위배하지 않는 범위에서 이 약관을 개정할 수 있습니다.</li>
							<li>③&quot;회사&quot;가 약관을 개정할 경우에는 적용일자 및 개정사유를 명시하여 현행약관과 함께 제1항의 방식에 따라 그 개정약관의 적용일자 30일 전부터 적용일자 전일까지 공지합니다. </li>
							<li>④회사가 전항에 따라 개정약관을 공지 또는 통지하면서 회원에게 30일 기간 내에 의사표시를 하지 않으면 의사표시가 표명된 것으로 본다는 뜻을 명확하게 공지 또는 통지하였음에도 회원이 명시적으로 거부의 의사표시를 하지 아니한 경우 회원이 개정약관에 동의한 것으로 봅니다.</li>
							<li>⑤회원이 개정약관의 적용에 동의하지 않는 경우 회사는 개정 약관의 내용을 적용할 수 없으며, 이 경우 회원은 이용계약을 해지할 수 있습니다. 다만, 기존 약관을 적용할 수 없는 특별한 사정이 있는 경우에는 회사는 이용계약을 해지할 수 있습니다.</li>
							</ul>
						
							<h3>제 4 조 (약관의 해석)</h3>
						
							<ul>
							<li>①&quot;회사&quot;는 &quot;유료서비스&quot; 및 개별 서비스에 대해서는 별도의 이용약관 및 정책(이하 &quot;유료서비스약관 등&quot;)을 둘 수 있으며, 해당 내용이 이 약관과 상충할 경우에는 &quot;유료서비스약관 등&quot;이 우선하여 적용됩니다.</li>
							<li>②이 약관에서 정하지 아니한 사항이나 해석에 대해서는 &quot;유료서비스약관 등&quot; 및 관계법령 또는 상관례에 따릅니다.</li>
							</ul>
						
							<h3>제 5 조 (이용계약 체결)</h3>
							
							<ul>
							<li>①이용계약은 &quot;회원&quot;이 되고자 하는 자(이하 &quot;가입신청자&quot;)가 약관의 내용에 대하여 동의를 한 다음 회원가입신청을 하고 &quot;회사&quot;가 이러한 신청에 대하여 승낙함으로써 체결됩니다.</li>
							<li>②&quot;회사&quot;는 &quot;가입신청자&quot;의 신청에 대하여 &quot;서비스&quot; 이용을 승낙함을 원칙으로 합니다. 다만, &quot;회사&quot;는 다음 각 호에 해당하는 신청에 대하여는 승낙을 하지 않거나 사후에 이용계약을 해지할 수 있습니다.</li>
							<li>③제1항에 따른 신청에 있어 &quot;회사&quot;는 &quot;회원&quot;의 종류에 따라 전문기관을 통한 실명확인 및 본인인증을 요청할 수 있습니다.</li>
							<li>④&quot;회사&quot;는 서비스관련설비의 여유가 없거나, 기술상 또는 업무상 문제가 있는 경우에는 승낙을 유보할 수 있습니다.</li>
							<li>⑤제2항과 제4항에 따라 회원가입신청의 승낙을 하지 아니하거나 유보한 경우, &quot;회사&quot;는 원칙적으로 이를 가입신청자에게 알리도록 합니다.</li>
							<li>⑥이용계약의 성립 시기는 &quot;회사&quot;가 가입완료를 신청절차 상에서 표시한 시점으로 합니다.</li>
							</ul>
						
							<h3>제 6 조 (회원정보의 변경)</h3>
							<ul>
							<li>①&quot;회원&quot;은 개인정보관리화면을 통하여 언제든지 본인의 개인정보를 열람하고 수정할 수 있습니다. 다만, 서비스 관리를 위해 필요한 실명, 아이디 등은 수정이 불가능합니다.</li>
							<li>②&quot;회원&quot;은 회원가입신청 시 기재한 사항이 변경되었을 경우 온라인으로 수정을 하거나 전자우편 기타 방법으로 &quot;회사&quot;에 대하여 그 변경사항을 알려야 합니다.</li>
							<li>③제2항의 변경사항을 &quot;회사&quot;에 알리지 않아 발생한 불이익에 대하여 &quot;회사&quot;는 책임지지 않습니다.</li>
							</ul>
							
							<h3>제 7 조 (개인정보보호 의무)</h3>
							<p>&quot;회사&quot;는 &quot;정보통신망법&quot; 등 관계 법령이 정하는 바에 따라 &quot;회원&quot;의 개인정보를 보호하기 위해 노력합니다. 개인정보의 보호 및 사용에 대해서는 관련법 및 &quot;회사&quot;의 개인정보취급방침이 적용됩니다. 다만, &quot;회사&quot;의 공식 사이트 이외의 링크된 사이트에서는 &quot;회사&quot;의 개인정보취급방침이 적용되지 않습니다.</p>
							<h3>제 8 조 (&quot;회원&quot;의 &quot;아이디&quot; 및 &quot;비밀번호&quot;의 관리에 대한 의무)</h3>
							<ul>
							<li>①&quot;회원&quot;의 &quot;아이디&quot;와 &quot;비밀번호&quot;에 관한 관리책임은 &quot;회원&quot;에게 있으며, 이를 제3자가 이용하도록 하여서는 안 됩니다.</li>
							<li>②&quot;회사&quot;는 &quot;회원&quot;의 &quot;아이디&quot;가 개인정보 유출 우려가 있거나, 반사회적 또는 미풍양속에 어긋나거나 &quot;회사&quot; 및 &quot;회사&quot;의 운영자로 오인한 우려가 있는 경우, 해당 &quot;아이디&quot;의 이용을 제한할 수 있습니다.</li>
							<li>③&quot;회원&quot;은 &quot;아이디&quot; 및 &quot;비밀번호&quot;가 도용되거나 제3자가 사용하고 있음을 인지한 경우에는 이를 즉시 &quot;회사&quot;에 통지하고 &quot;회사&quot;의 안내에 따라야 합니다.</li>
							<li>④제3항의 경우에 해당 &quot;회원&quot;이 &quot;회사&quot;에 그 사실을 통지하지 않거나, 통지한 경우에도 &quot;회사&quot;의 안내에 따르지 않아 발생한 불이익에 대하여 &quot;회사&quot;는 책임지지 않습니다.</li>
							</ul>
							<h3>제 9 조 (&quot;회원&quot;에 대한 통지)</h3>
							<ul>
							<li>①&quot;회사&quot;가 &quot;회원&quot;에 대한 통지를 하는 경우 이 약관에 별도 규정이 없는 한 서비스 내 전자우편주소, 전자쪽지 등으로 할 수 있습니다.</li>
							<li>②&quot;회사&quot;는 &quot;회원&quot; 전체에 대한 통지의 경우 7일 이상 &quot;회사&quot;의 게시판에 게시함으로써 제1항의 통지에 갈음할 수 있습니다.</li>
							</ul>
						
							<h3>제 10 조 (&quot;회사&quot;의 의무)</h3>
							<ul>
							<li>①&quot;회사&quot;는 관련법과 이 약관이 금지하거나 미풍양속에 반하는 행위를 하지 않으며, 계속적이고 안정적으로 &quot;서비스&quot;를 제공하기 위하여 최선을 다하여 노력합니다.</li>
							<li>②&quot;회사&quot;는 &quot;회원&quot;이 안전하게 &quot;서비스&quot;를 이용할 수 있도록 개인정보(신용정보 포함)보호를 위해 보안시스템을 갖추어야 하며 개인정보취급방침을 공시하고 준수합니다.</li>
							<li>③&quot;회사&quot;는 서비스이용과 관련하여 &quot;회원&quot;으로부터 제기된 의견이나 불만이 정당하다고 인정할 경우에는 이를 처리하여야 합니다. &quot;회원&quot;이 제기한 의견이나 불만사항에 대해서는 게시판을 활용하거나 전자우편 등을 통하여 &quot;회원&quot;에게 처리과정 및 결과를 전달합니다.</li>
							</ul>
							<h3>부칙</h3>
							<ul>
							<li>①이 약관은 2014년 01월 01일부터 적용됩니다.</li>
							<li>②2014년 01월 01일부터 시행되던 종전의 약관은 본 약관으로 대체합니다.</li>
							</ul>
															
					</div>
				  </label>  
				  
					<input type="checkbox" name="chkAgreeTwo" id="chkAgreeTwo"  onClick="fnShowDoc(2);">
				    <label for="chkAgreeTwo">개인정보수집 동의
						<div id='divDocTwo' class="scroll_box"  style="display:none;">
							
								<h3>가. 수집하는 개인정보의 항목</h3>
								<ul>
									<li>첫째, 회사는 회원가입, 각종 서비스의 제공을 위해 최초 회원가입 당시 아래와 같은 최소한의 개인정보를 필수항목으로 수집하고 있습니다.
										<ul>
										<li>&lt;회원가입&gt;
											<ul>
											<li>- 이름, 비밀번호, 연락처(메일주소 또는 휴대폰 번호)</li>
											</ul>
										</li>
										<li>&lt;영업사원 회원가입&gt;
											<ul>
											<li>- 이름, 비밀번호, 연락처(메일주소 또는 휴대폰 번호), 근무회사, 근무지점</li>
											</ul>
										</li>						
										</ul>
									</li>
									<li>둘째, 서비스 이용과정이나 사업처리 과정에서 아래와 같은 정보들이 자동으로 생성되어 수집될 수 있습니다.
										<ul>
										<li>- IP Address, 쿠키, 방문 일시, 서비스 이용 기록, 불량 이용 기록</li>
										</ul>
									</li>
								</ul>
								
								<h3>나. 개인정보 수집방법</h3>
								<ul>
									<li>회사는 다음과 같은 방법으로 개인정보를 수집합니다.
										<ul>
											<li>- 홈페이지, 아이디, 이벤트 응모</li>
										</ul>
									</li>
									</ul>
									<h1 style='font-size: 13px'>개인정보의 수집 및 이용 목적</h1>
									<ul>
									<li>가. 회원관리
									<p>회원제 서비스 제공, 개인식별, 이용약관 위반 회원에 대한 이용제한 조치, 불만처리 등 민원처리, 고지사항 전달, 회원탈퇴의사의 확인</p></li>
									<li>나. 신규 서비스 개발 및 마케팅&middot;광고에의 활용
								</ul>			
								<h3>개인정보의 보유 및 이용기간</h3>
								<p>이용자의 개인정보는 원칙적으로 개인정보의 수집 및 이용목적이 달성되면 지체 없이 파기합니다. 단, 다음의 정보에 대해서는 아래의 이유로 명시한 기간 동안 보존합니다.</p>
						</div>
					</label>
				</div>
				
			</div>
		</div>	
	</div><!-- /page -->
</html>
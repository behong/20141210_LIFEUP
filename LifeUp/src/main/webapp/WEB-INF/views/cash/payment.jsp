<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang='ko'>
<head>
<meta charset='utf-8'>

<%@ include file="../include/library.jsp" %>
<script type="text/javascript">

 function post_to_url(path, params, method) {
	    method = method || "post"; // Set method to post by default, if not specified.
	 
	    // The rest of this code assumes you are not using a library.
	    // It can be made less wordy if you use one.
	    var form = document.createElement("form");
	    form.setAttribute("method", method);
	    form.setAttribute("action", path);
	 
	    for(var key in params) {
	        var hiddenField = document.createElement("input");
	        hiddenField.setAttribute("type", "hidden");
	        hiddenField.setAttribute("name", key);
	        hiddenField.setAttribute("value", params[key]);
	 
	        form.appendChild(hiddenField);
	    }
	 
	    document.body.appendChild(form);
	    form.submit();
	}
	function fnPaymentGo() {
		var userId, amount, receipter_nm, data;
		
		userId   = $('#userId', '#frmPayment').val();
		//$(#DynamicValueAssignedHere).children(".formdiv").findnext('input[name="amount"]').val();
		amount	 = $('input:radio[name="amount"]:checked', '#frmPayment').val();
		receipter_nm = $('#receipter_nm', '#frmPayment').val();
		data = {"userId": userId, "amount": amount, "receipter_nm" : receipter_nm};
		
		_Async.post (
			"/cash/Pending_Payment",
			JSON.stringify(data),
			function (data) {    
				if(data.flag == "Y"){
					alert(data.message);
					//_Commn.fnPageMove("/cash/Payment_Complete",$('#frmPayment'));
					post_to_url("/cash/Payment_Complete",{"userId": userId, "amount": amount, "receipter_nm" : receipter_nm});
						
				}
			}    			
		); 
		
	}
 </script>
<link type="text/css" rel="stylesheet" href="/resources/css/cash.css" />

</head>

<body>
	<%@ include file="../include/header.jsp" %>
	<div class="content">
		<div class="wrap">
			<div id="main" >	
				<form id='frmPayment' name='frmPayment' method='post'>
				<input type='hidden' id='userId' name='userId' value="${userInfo.userId}"/>
				
					<fieldset>
					    <h1>결제금액 선택하여 주세요</h1>
					        <input type="radio" name="amount" id="amount1" value="1000">
					        <label for="amount1">1,000 원</label>
					        <input type="radio" name="amount" id="amount2" value="9900" checked="checked">
					        <label for="amount2">9,900 원</label>
					        <input type="radio" name="amount" id="amount3" value="19000">
					        <label for="amount3">19,000 원</label>
					        <input type="radio" name="amount" id="amount4" value="29000">
					        <label for="amount4">29,000 원</label>
					</fieldset>	
					
					<p/>		
					
					<h1>입금자명</h1>
					<div class="mtuPwrOpt">
						<input type="text"  class="input-text"  name="receipter_nm" id="receipter_nm" value="${userInfo.userNm}">
					</div>
					
					<p/>
					
					<!-- 
					<div class="third">
						<h3>추가 혜택</h3>
						<p>차량 구매회원에게 견적을 남기면~ 실시간 푸시 메세지 전송</p>
						<p>차량 구매회원에게 견적을 남기면~ 실시간 푸시 메세지 전송</p>
					</div>					
					 -->		
					 
					<h1>추가 혜택</h1>
					<div class="mtuPwrOpt">
							<ul class="feeAdd">
								<li><span class="num1"></span>차량 구매회원에게 견적을 남기면~ 실시간 푸시 메세지 전송</li>
								<li><span class="num2"></span>결제금액이 1만원 이상일 경우 해당 금액의 10%가 플러스로 적립됩니다.</li>
								<!-- <li><span class="num3"></span>신청하신 당일 하루는 포인트 삭감없이 이용하실 수 있습니다.</li> -->
							</ul>
					</div>
					
					<p/>
					<div class="Cash_box_btn">   
						<a href="#" class="cashCancelButton" onclick="history.back(); return false;">취소하기</a>
						<a href="#" class="cashDaum_Style"   onclick="fnPaymentGo();">결제 신청</a>
					</div>	
									
					</form>
		</div>
	</div>
</div>	
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang='ko'>
<head>
<%@ include file="../../include/library.jsp" %>
<script type="text/javascript">
	$(document).ready(function() {
		$('#tbxSalesBenefit').focus();
	});	

	function fnContractSave() {		
		$('.error').hide();
		
		if($.trim($('#tbxSalesBenefit').val()) == "") {
			$('#tbxSalesBenefit').after('<div class="error" style="padding-top: 13px;">견적을 입력하세요</div>');					
			return;
		} else {
			if(!_Commn.fnCheckSpecialChar($('#tbxSalesBenefit', "#frmContractForm").val())) {
				$('#tbxSalesBenefit').after('<div class="error" style="padding-top: 13px;">특수문자는 사용할 수 없습니다</div>');
				return;
			}
		}
		
		_Async.post (
			"/contract/registContract.do",
			JSON.stringify( { request_id: $('#hdnRequestId').val(), salesman_benefit: $('#tbxSalesBenefit').val() } ),
			function (data) {    
				if(data.message == 'success') {				
					frmContractForm.action = "/request/detail";
					frmContractForm.submit();
				} else {
					alert(data.detail);
				}
			} 
		);
	}
</script>
</head>
<body>
	<%@ include file="../../include/header.jsp" %>
	<div class="content">
		<div class="wrap">
			<div class="single-page">
				<article>
					<form id='frmContractForm' name='frmContractForm' method="post">
						<input type='hidden' id='hdnRequestId' name='request_id' value='${requestDetail.REQUEST_ID}' />
						<h2 class="underline">의뢰상태</h2>
			        	<p style="padding-bottom: 30px; margin-top : -5px;">${requestDetail.STATUS_NM}</p>					
						<h2 class="underline">지역/차종</h2>
			        	<p style="padding-bottom: 30px; margin-top : -5px;">${requestDetail.SIDO_NM} ${requestDetail.GUGUN_NM} > ${requestDetail.VENDOR_NM} > ${requestDetail.CAR_NM}</p>
						<h2 class="underline">차량옵션</h2>
			        	<p style="padding-bottom: 30px; margin-top : -5px;">${requestDetail.CAR_OPTION}</p>		
						<h2 class="underline">${requestDetail.CUSTOMER_NM}님 요구사항</h2>
			        	<p style="padding-bottom: 30px; margin-top : -5px;">${requestDetail.CUSTOMER_REQ}</p>	
						<h2 class="underline">구매예정일</h2>
			        	<p style="padding-bottom: 30px; margin-top : -5px;">${requestDetail.PURCHASE_PERIOD_CD}</p>
			        					
						<c:if test="${requestDetail.STATUS != '0003'}">		
							<div style="padding-top : 0px; padding-bottom: 7px;">
								<h2 class="underline">견적제안</h2>
								<p style="padding-bottom: 30px; margin-top : -5px;">
									<textarea data-mini="false" cols="40" rows="8" id='tbxSalesBenefit' name='salesman_benefit'><c:forEach items="${contractDetail}" var="detail" varStatus="status">${detail.SALESMAN_BENEFIT}</c:forEach></textarea>
								</p>
								<div style="height:5px;"></div>				
							</div>																	
							<div style="margin-right: -10px; margin-top: 5px; text-align: right;">
								<a href="#" data-role="button" data-inline="true"  id="btnReply" onclick="fnContractSave();">등록</a>
							</div>		
						</c:if>	
					</form>
				</div>
			</div>
		</div>	
	</div><!-- /page -->
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang='ko'>
<head>
<%@ include file="../../include/library.jsp" %>
<script type="text/javascript">

	function fnContractUpdate() {
		if($.trim($('#tbxSalesBenefit').val()) == "") {
			alert('견적을 입력하세요');
			return;
		}
		
		_Async.post (
			"/contract/registContract",
			JSON.stringify( { request_id: $('#hdnRequestId').val(), salesman_benefit: $('#tbxSalesBenefit').val() } ),
			function (data) {    
				if(data.message == 'success') {
					frmContractDetail.action = "/contract/detail";
					frmContractDetail.submit();
				} else {
					alert(data.detail);
				}
			} 
		);
	}

	function fnContractConfirm() {
		_Async.post (
			"/request/updateContractStatus",
			JSON.stringify( { request_id: $('#hdnRequestId').val(), salesman_id : $('#hdnSalesman_id').val(), status : '0002' } ),
			function (data) {    
				if(data.message == 'success') {
					$('#btnConfirm').hide();
				} else {
					alert(data.message);
				}
			} 
		);	
	}

	function fnContractCancel() {
		_Async.post (
			"/contract/contractCancel",
			JSON.stringify( { request_id: $('#hdnRequestId').val(), status : '0003' } ),
			function (data) {    
				if(data.message == 'success') {
					frmContractDetail.action = "/request/detail";
					frmContractDetail.submit();
				} else {
					alert(data.message);
				}
			} 
		);	
	}

	function fnContractReply() {
		
		if($.trim($('#tbxShortMsg').val()) == "") {
			alert('댓글 메세지를 입력하세요');
			$('#tbxShortMsg').focus();
			return;
		}		
		
		_Async.post (
			"/contract/registReply",
			JSON.stringify( { request_id: $('#hdnRequestId').val(), salesman_id: $('#hdnSalesman_id').val(), message: $('#tbxShortMsg').val() } ),
			function (data) {    
				if(data.message == 'success') {
					$('#replyContainer').show();					
					$('#replyContainer').append("<h2 class=\"underline\">오늘</h2><p style=\"padding-bottom: 30px; margin-top : -5px;\">" + $.trim($('#tbxShortMsg').val()) + "</p>" );					
					$('#tbxShortMsg').val("");
				} else {
					alert(data.detail);
				}
			} 
		);		
		
	}
	
	function fnEnterKey(type) {		
		
		if(event.keyCode == 13) {			
	    	if(type == "R") { 
	    		fnContractReply();	    		
	    	} else if(type == "C") { 
	    		fnContractUpdate();
	    	}
		}
		
	}
</script>
<link rel="stylesheet" href="/resources/css/contract_detail.css">
</head>
<body>
	<%@ include file="../../include/header.jsp" %>
	<div class="content">
		<div class="wrap">
			<div class="single-page">
				<article>
				
					<form id='frmContractDetail' name='frmContractDetail' method="post">
					
					<div class=".result_cnt1">
						<div class="tbl_1">
							<table>
								<caption>견적 요청 내역</caption>
								<colgroup>
									<col width="20%" />
									<col />
								</colgroup>
				                <tr>
									<th scope="col">의뢰상태</th>
									<td>${requestDetail.STATUS_NM} </td>
								</tr>								
				                <tr>
									<th scope="col">지역/차종</th>
									<td>${requestDetail.SIDO_NM} ${requestDetail.GUGUN_NM} > ${requestDetail.VENDOR_NM} > ${requestDetail.CAR_NM} </td>
								</tr>
								<tr>
									<th scope="col">차량옵션</th>
									<td>${requestDetail.CAR_OPTION}</td>
								</tr>
							
								<tr>
									<th scope="col" colspan="2" align="center">${requestDetail.CUSTOMER_NM}님 요구사항</th>
								</tr>
								<tr>
									<td colspan="2">${requestDetail.CUSTOMER_REQ}</td>
								</tr>
								<tr>
									<th scope="col">구매예정일</th>
									<td>${requestDetail.PURCHASE_PERIOD_CD}</td>
								</tr>
							</table>	
						</div>
						<br />					
					</div>
			        	
						<c:forEach items="${contractDetail}" var="detail" varStatus="loop">
						   	<input type='hidden' id='hdnRequestId' name='request_id' value='${requestDetail.REQUEST_ID}' />    	   		   						   		   			
							<input type='hidden' id='hdnSalesman_id' name='salesman_id' value='${detail.SALESMAN_ID}' />
	
							<div class=".result_cnt1">
								<div class="tbl_1">
									<table>
										<caption>견적내용</caption>
										<colgroup>
											<col width="20%" />
											<col />
										</colgroup>
										
										<c:choose>
											<c:when test="${detail.SALESMAN_ID == sessionScope._USER_INFO_.userId}">										
												<tr>
													<th scope="col" colspan="2" align="center">
													<textarea data-mini="true" cols="40" rows="8" id='tbxSalesBenefit' name='salesman_benefit' onKeypress="fnEnterKey('C');">${detail.SALESMAN_BENEFIT}</textarea>
													</th>
												</tr>
											</c:when>		
											<c:when test="${requestDetail.CUSTOMER_ID == sessionScope._USER_INFO_.userId}">
								                <tr>
													<th scope="col">영업사원</th>
													<td>${detail.VENDOR_NM} > ${detail.LOCATION} > ${detail.SALESMAN_NM} - ${detail.MOBILE} </td>
												</tr>								
								                <tr>
													<th scope="col">견적 작성일</th>
													<td>${detail.CREATE_DATE} </td>
												</tr>
												<tr>
													<th scope="col" colspan="2" align="center">
													${detail.SALESMAN_BENEFIT}
													</th>
												</tr>																			
											</c:when>
										</c:choose>	
						              
									</table>	
								</div>
								<br />					
							</div>
						
							<div class="box_btn">
								<c:choose>
									<c:when test="${requestDetail.CUSTOMER_ID == sessionScope._USER_INFO_.userId}">
											<c:if test="${requestDetail.STATUS == '0001' && detail.STATUS != '0003'}">
												<a href="#" class="btn_Style"  id="btnConfirm" onclick="fnContractConfirm();">거래확정</a>	
											</c:if>
									</c:when>	
									<c:otherwise>
											<c:if test="${detail.STATUS == '0001'}">
												<a href="#" class="btn_Style"  onclick="fnContractUpdate();">수정</a>
												<a href="#" class="btn_Style"  id="btnCancel" onclick="fnContractCancel();">등록취소</a>
											</c:if>
									</c:otherwise>
								</c:choose>	    	       
							</div>
							
							<!--  댓글 영역  -->
							<div id="replyContainer">
								<c:forEach items="${contractReply}" var="reply" varStatus="loop">
									<h2 class="underline">${reply.CREATE_USER_NM}</h2>
									<p style="padding-bottom: 30px; margin-top : -5px;">${reply.CREATE_DATE} ${reply.MESSAGE}</p>	
							    </c:forEach>			
							</div>
							
							<c:if test="${requestDetail.STATUS != '0003'}">
								<p style="padding-bottom: 30px; margin-top : -5px;">
								    <input type="text" id='tbxShortMsg' name='message' onKeypress="fnEnterKey('R');">
								</p>
								<div class="box_btn">								
								<a href="#" class="btn_Style"   id="btnReply" onclick="fnContractReply();">댓글 등록</a>
								</div>
							</c:if>	
						</c:forEach>	
		        	</form>
		        </article>
			</div>
		</div>	
	</div><!-- /page -->
</html>
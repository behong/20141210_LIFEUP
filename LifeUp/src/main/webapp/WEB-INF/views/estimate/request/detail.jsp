<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang='ko'>
<head>
<%@ include file="../../include/library.jsp" %>
<script type="text/javascript">
	
	function fnContractWrite(userType,point) {	
		if(userType != 2) {
			alert('일반 사용자는 사용할 수 없습니다');
			return;
		}
		
		if(point <= 300 ){
			if (confirm("포인트가 부족 합니다.\n 충전 페이지로 이동 합니다.") == true){    //확인
			frmReqDetail.action = "/cash/Payment";
			}else{//취소
				return;
			}
		} else {		
			frmReqDetail.action = "/contract/writeform";
		}
		
		frmReqDetail.submit();	
	}
	
	function fnContractDetail(salesman_id) {
		$('#hdnSalesmanId').val(salesman_id);

		frmReqDetail.action = "/contract/detail";		
		frmReqDetail.submit();
	}
</script>
<link rel="stylesheet" href="/resources/css/request_detail.css">
</head>
<body>
	<%@ include file="../../include/header.jsp" %>
	<div class="content">
		<div class="wrap">
			<div class="single-page">
				<form id='frmReqDetail' name="frmReqDetail" method="post">
					<input type='hidden' id='hdnSalesmanId' name='salesman_id' />
					<input type='hidden' id='hdnRequestId' name='request_id' value='${request.REQUEST_ID}' />				
					<input type='hidden' id='hdnCurrentSeq' name='currentSeq' value='${param.currentSeq}' />
					<input type='hidden' id='hdnSidoCd' name='sidoCd' value='${param.sidoCd}' />
					<input type='hidden' id='hdnGugunCd' name='gugunCd' value='${param.gugunCd}' />
					<input type='hidden' id='hdnVendorCd' name='vendorCd' value='${param.vendorCd}' />
					<input type="hidden" id="hdnStatusCd" name="statusCd" value="${param.statusCd}" />
					<input type='hidden' id='hdnPageMove' name='pageMove' value='Y' /><!-- List로 이동시 더보기 실행방지 -->
					<!--  point check -->
					<input type='hidden' id='hdnPoint_Id' name='point_id'  value='${sessionScope._USER_INFO_.userId}'/>					
				</form>		
						
				<article>

					
					<div class=".result_cnt1">
						<div class="tbl_1">
							<table>
								<caption>견적 요청 내역</caption>
								<colgroup>
									<col width="20%" />
									<col />
								</colgroup>
				                <tr>
									<th scope="col">지역/차종</th>
									<td>${request.SIDO_NM} ${request.GUGUN_NM} > ${request.VENDOR_NM} > ${request.CAR_NM} </td>
								</tr>
								<tr>
									<th scope="col">차량옵션</th>
									<td>${request.CAR_OPTION}</td>
								</tr>
							
								<tr>
									<th scope="col" colspan="2" align="center">${request.CUSTOMER_NM}님 요구사항</th>
								</tr>
								<tr>
									<td colspan="2">${request.CUSTOMER_REQ}</td>
								</tr>
								<tr>
									<th scope="col">구매예정일</th>
									<td>${request.PURCHASE_PERIOD_CD}</td>
								</tr>
							</table>	
						</div>
						<br />					
					</div>

					<div class=".result_cnt1">
						<div class="tbl_1">
							<table>
								<caption>견적제안</caption>
								<colgroup>
									<col width="20%" />
									<col />
								</colgroup>
					        	<c:if test="${empty contract}">
					        		<tr>
										<th scope="col" colspan="2" align="center">등록된 견적 제안이 없습니다</th>
									</tr>								
								</c:if>									
				                

									
									<c:forEach items="${contract}" var="salesDoc" varStatus="loop">	
										<c:choose>
											<c:when test="${salesDoc.SALESMAN_ID == sessionScope._USER_INFO_.userId || request.CUSTOMER_ID == sessionScope._USER_INFO_.userId}">
												<tr>											
													<th scope="col">견적내용</th>															
											    	<td>
											    		<a href="#" onclick="fnContractDetail('${salesDoc.SALESMAN_ID}');">			    			
															<c:if test="${salesDoc.STATUS == '0003'}"><s></c:if>
																[${salesDoc.CREATE_DATE}] ${salesDoc.SALESMAN_NM}님 견적 ${salesDoc.STATUS_NM}
															<c:if test="${salesDoc.STATUS == '0003'}"></s></c:if> 								    			
											    		</a>
											    	</td>
											    	</tr>
									    	</c:when>
									    	<c:otherwise>
												<tr>											
													<th scope="col">견적내용</th>															
											    	<td>	    			
													<c:if test="${salesDoc.STATUS == '0003'}"><s></c:if>
														[${salesDoc.CREATE_DATE}] ${salesDoc.SALESMAN_NM}님 견적 ${salesDoc.STATUS_NM}
													<c:if test="${salesDoc.STATUS == '0003'}"></s></c:if>
											    	</td>
										    	</tr>	
									    	</c:otherwise>
								    	</c:choose>
								    </c:forEach>		       									
							</table>	
						</div>
						<br />					
					</div>					
		        	
					<div class="box_btn">
						<c:if test="${sessionScope._USER_INFO_.userType == '2' && request.STATUS == '0001'}">
							<a href="#" class="btn_Style" onclick="fnContractWrite('${sessionScope._USER_INFO_.userType}','${cash_point}');">견적남기기</a>											
						</c:if>
					</div>		
						        	
				</article>
			</div>
		</div>	
	</div><!-- /page -->
</html>
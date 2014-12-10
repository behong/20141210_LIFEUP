<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang='ko'>
<head>
<meta charset='utf-8'>

<%@ include file="../include/library.jsp" %>
<link type="text/css" rel="stylesheet" href="/resources/css/cash.css" />
</head>
<body>
<%@ include file="../include/header.jsp" %>
	<div class="content">
		<div class="wrap">
			<div id="main" >		
				<!-- ************ 컨텐츠영역 ********************** -->
					<div class=".result_cnt1">
						<div class="tbl_1">
							<!-- start: 결제정보 시작 -->
							<table>
								<caption>결제 신청 내역</caption>
								<colgroup>
									<col width="33%" />
									<col />
								</colgroup>
				                <tr>
									<th scope="col">상품명</th>
									<td>바바카 승리의 영업사원 </td>
								</tr>
								<tr>
									<th scope="col">구매금액</th>
									<td><strong class="price">${request.amount}원</strong></td>
								</tr>
							
								<tr>
									<th scope="col">입금은행</th>
									<td>
										<strong class="font_red">국민은행 <br />(012502-04-097513)	</strong>						
									</td>
								</tr>
								<tr>
									<th scope="col">입금자명</th>
									<td>${request.receipter_nm}</td>
								</tr>
								<tr>
									<th scope="col">예금주명</th>
									<td>홍성인</td>
								</tr>
								<tr>
									<th scope="col">입금기한</th>
									
									<td><strong>${request.payment_day}</strong>까지 입금요망</td>
									
								</tr>
							 
							</table>	
						</div>
						<br />

						<div class="Cash_box_btn">   
							<a href="/" class="cashCancelButton" >홈으로</a>
							<a href="mypage/list/?tabMenu=2" class="cashDaum_Style">결제내역</a>
						</div>							
						
						<p>입금할 금액을 확인 후, 은행에 입금하여 주세요.</p>
						<p>입금확인 완료 후 포인트가 지급됩니다. 이용해주셔서 감사합니다.</p>	
						
					</div>
		</div>
	</div>
</div>	
</html>
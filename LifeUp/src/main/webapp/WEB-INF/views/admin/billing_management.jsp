<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>로그인</title>

		<meta http-equiv="Content-type" content="text/html; charset=utf-8" />
		<title>Steal My Admin</title>
		<link rel="stylesheet" href="/resources/admin/css/board.css" type="text/css"  />		
		<link rel="stylesheet" href="/resources/admin/css/960.css" type="text/css" media="screen" charset="utf-8" />
		<link rel="stylesheet" href="/resources/admin/css/template.css" type="text/css" media="screen" charset="utf-8" />
		<link rel="stylesheet" href="/resources/admin/css/colour.css" type="text/css" media="screen" charset="utf-8" />
		

		<script type="text/javascript">
		$(function(){
		    $("#check_all").click(function(){
		        var chk = $(this).is(":checked");	//.attr('checked');
		        
		        if(chk){ 
		        	alert(chk);
		        	alert($("input:checkbox").attr("checked") );
		        	$("input:checkbox").attr("checked", true); 
		        	//$(".select_subject input").attr('checked', true);
		        }else{
		        	alert($("input:checkbox").attr("checked") );
		        	//$(".select_subject input").attr('checked', false);
		        	$("input:checkbox").attr("checked", false);
		        }
		    });
		    
		    //한개씩 처리..
/* 		    $("#chk_one").click(function(){
		    	alert($(this).val());
		    }); */
		});		
		   function coupon_reg(cash_id,point,loginId) {
 	       	   	$.ajax({
     				type : 'POST'
     				,url : '/admin/register'
                  ,contentType: "application/json; charset=utf-8"				
     				,dataType: 'json'
     				,data : JSON.stringify
					({
					cashId:cash_id
					,receiptCashPoint:point
					,userId:loginId
					})
     				,success : function(result) {
	       			console.log(result);	       				
	       		 	location.reload();
     				//$('#txtmobile').val(result.mypageList2.mobile);
     				//$('#create_date').html(parseDate(result.mypageList2.create_date));
     				 console.log("내정보 AJAX통신 성공");
     				}
  					,error : function(error){consle.log("error" + error);}
  					                       
     			});	       
	        }		
		</script>
</head>

	<body>
		<!-- head -->
		<%@ include file="head.jsp" %>
		
		<div id="content" class="container_16 clearfix">
		
				<h3>결제관리 > <b>신청자 목록</b></h3>
				<table>
					<tr>
						<th width="150"><!-- <label><input type='checkbox' id='check_all' class='input_check' /><!-- <b>전체</b></label> -->선택</th>
						<th width="200">신청ID</th>					
						<th width="100">결제금액</th>
						<th width="100">포인트</th>
						<th width="200">전체포인트</th>
						<!-- <th width="200">상태코드</th> -->
						<th width="200">신청일</th>
						<th width="200">결제처리일</th>												
					</tr>
					<c:forEach items="${cashList}" var="cash" varStatus="status">
						<tr class="select_subject">
							<!-- <td ><label><input type='checkbox'  class='input_check'  name='class[${status.count}]'  value=''${cash.id}' /></label></td>  -->
							<td>
								<c:choose>
							       <c:when test="${cash.status == '0001'}">
							       <input type="button" value="구매처리요청"  onclick="coupon_reg( '${cash.id}' , '${cash.point}' , '${cash.salesman_id}'  )" />
							       </c:when>
							       <c:when test="${cash.status == '0002'}">구매완료</c:when>
							       <c:when test="${cash.status == '0003'}"> 구매취소</c:when>
							       <c:otherwise>미승인코드</c:otherwise>
						       </c:choose>							
							</td>
							<td id="user_id" >${cash.salesman_id}</td>
							<td><fmt:formatNumber value="${cash.amount}" groupingUsed="true" /></td>
							<td id="point"><fmt:formatNumber value="${cash.point}" groupingUsed="true" /></td>
							<td><fmt:formatNumber value="${cash.totalPoint}" groupingUsed="true" /></td>
							<td><fmt:formatDate value="${cash.requestDate}"  pattern="yyyy-MM-dd HH:mm" /></td>
							<!-- <td>
							   <c:choose>
							       <c:when test="${cash.status == '0001'}">신규</c:when>
  							       <c:when test="${cash.status == '0002'}"> 구매완료</c:when>
							       <c:when test="${cash.status == '0003'}"> 구매취소</c:when>  							       
							       <c:otherwise>미승인코드</c:otherwise>
							   </c:choose>							
							</td>
							 -->
							<td><fmt:formatDate value="${cash.confirmDate}" pattern="yyyy-MM-dd HH:mm"/></td>
						</tr>
					</c:forEach>
						<tr>
							<td colspan="7" align="center">
								<c:if test="${firstPage > 1 }"><a href="billing_management?page=${firstPage-1 }">[&lt;]</a></c:if>
								<c:forEach var="page" begin="${firstPage }" end="${lastPage }">
									<c:if test="${page == currPage }"><b>[${page }]</b></c:if>
									<c:if test="${page != currPage }"><a href="billing_management?page=${page }">[${page }]</a></c:if>
								</c:forEach>
								<c:if test="${lastPage < totalPage }"><a href="billing_management?page=${lastPage+1 }">[&gt;]</a></c:if>
							</td>
						</tr>					
				</table>
		</div>
		
		
		<div id="foot">
			<div class="container_16 clearfix">
				<div class="grid_16">
					<a href="#">푸웃</a>
				</div>
			</div>
		</div>
		
		
	</body>
</html>
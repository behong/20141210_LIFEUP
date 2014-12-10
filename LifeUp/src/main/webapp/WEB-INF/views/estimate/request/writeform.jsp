<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang='ko'>
<head>
<%@ include file="../../include/library.jsp" %>
<script type="text/javascript">
	$(document).ready(function() {
		//$("#accordion").accordion();
		
		_Commn.SetDatePickter();					
	});

	function fnFrmSidoChange(obj){
		if(obj.value == '0')			
			return;
			
			$("#ddlGugun").find("option").remove().end().append("<option value=\"\">선택</option>");

			_Async.post (
				"/selectRegionJson",
				sido_cd = obj.value,
				function (data) {    
					var resultData = data.Sido2; 			
					$.each(resultData, function(index, row){	    		      		
						$("#ddlGugun").append("<option value='"+ row.gugun_cd +"'>" + row.gugun_nm  + "</option>");	
					});
					
					$("#ddlGugun").show();
				}    			
			);   	         
	}	

	// 차량 종류 셀렉박스
	function fnVenderChange(obj){
		if(obj.value == '')
			return;
		
			$("#ddlCar").find("option").remove().end().append("<option value=\"\">선택</option>");
			
		    _Async.post (
				"/selectCarJson",
				venderId = obj.value,
				function (data) {    
					var resultData = data.carCodeList;  
					$.each(resultData, function(index, row){
						$("#ddlCar").append("<option value='"+ row.car_id +"'>" + row.car_nm  + "</option>");    		        	  
					});
					
					$("#ddlCar").show();							
				} 
			);   	       
	}	

	function fnChangeDDL(obj) {
		$(obj).parent().parent().find(".error").hide();
	}

	function fnChangeTextValue(obj) {
		if(obj != "")
			$(obj).parent().parent().find(".error").hide();
	}

	function fnWriteFrmSave() {		
		var check = true;
		
		$('.error').hide();
		
		if($('#ddlSido').val() == "" || $('#ddlGugun').val() == "") {
			check = false;
			$('#ddlGugun').parent().after('<div class="error" style="padding-top: 13px;">거주지역을 선택하세요</div>');
		} else if($('#ddlVendor').val() == "" || $('#ddlCar').val() == "") {
			check = false;
			$('#ddlCar').parent().after('<div class="error" style="padding-top: 13px;">차량을 선택하세요</div>');
		} else if($('#carOption').val() == "") {
			check = false;
			$('#carOption').focus();
			$('#carOption').parent().after('<div class="error" style="padding-top: 13px;">옵션을 입력하세요</div>');			
		} else if($('#purchase_period_cd').val() == "") {
			check = false;
			$('#purchase_period_cd').parent().after('<div class="error" style="padding-top: 13px;">구매예정일을 입력하세요</div>');
		} else if($('#customer_req').val() == "") {
			check = false;
			$('#customer_req').focus();
			$('#customer_req').parent().after('<div class="error" style="padding-top: 13px;">요구사항을 입력하세요</div>');
		}
		
	    if(!_Commn.fnCheckSpecialChar($('#carOption').val())) {
			check = false;
			$('#carOption').parent().after('<div class="error" style="padding-top: 13px;">특수문자는 사용할 수 없습니다</div>');
		} else if(!_Commn.fnCheckSpecialChar($('#customer_req').val())) {
			check = false;
			$('#customer_req').parent().after('<div class="error" style="padding-top: 13px;">특수문자는 사용할 수 없습니다</div>');
		} 
		
		if(check == false)
			return;
		
	    _Async.post (
			"/request/writing",
			JSON.stringify({ region_cd: $('#ddlGugun').val(), 
							 car_id: $('#ddlCar').val(), 
							 car_trim: $('#carTrim').val(), 
							 car_option: $('#carOption').val(),
							 purchase_period_cd: $('#purchase_period_cd').val(),
							 customer_req: $('#customer_req').val()}),
			function (data) {    
				if(data.message == "success") {
					var frm = document.frmReqWriteForm;
					frm.action = "/request/list";
					frm.submit();
				} else {
					alert(data.message);
				}			
			} 
		);   
	}	
</script>
<link rel="stylesheet" href="/resources/css/request_write.css">

</head>
<body>
	<%@ include file="../../include/header.jsp" %>
	
	<div class="content">
		<div class="wrap">
			<div id="main" >	
			
			 <div class="container">
						<form id="frmReqWriteForm"  class="form"  name="frmReqWriteForm" method="post">
											
						<div class="area">지역</div>
								<div class="area1">
								    <select name="ddlSido" id="ddlSido" class="input-selectbox" onchange="fnFrmSidoChange(this);">
										<option value=''>선택</option>
										<c:forEach items="${sidos}" var="sido">
											<option value="${sido.sido_cd}">${sido.sido_nm}</option>
										</c:forEach>
								    </select>
								</div>
								<div class="area2">							    
								    <select name="region_cd" id="ddlGugun" class="input-selectbox"  onchange="fnChangeDDL(this);">
								    	<option value=''>선택</option>
								    </select>		
								</div>
						
						
							
							<div class="cars">차량</div>
								<div class="car_vender1">
							    <select name="ddlVendor" id="ddlVendor" class="input-selectbox" onchange="fnVenderChange(this);">
									<option value=''>선택</option>
							   		<c:forEach items="${venders}" var="vender">
							   			<option value="${vender.code}">${vender.value}</option>
							   		</c:forEach>
							    </select>
							    </div>
							    <div class="car_vender2">
							    <select name="car_id" id="ddlCar" class="input-selectbox"  onchange="fnChangeDDL(this);">
									<option value=''>선택</option>
							    </select>
							    </div>
						
							<!-- 
						    <div>    	 
						         <label>트림</label>
						         <input type="text" id="carTrim" name="car_trim" onchange="fnChangeTextValue(this);">
						    </div>
						     -->
						    <div class="option">
						         <label>옵션
						         <input type="text"  class="input-text"  id="carOption" name="car_option" onchange="fnChangeTextValue(this);">
						         </label>
						    </div>
						    <div class="buyDate">신차 구매예정일</div>
						    <div class="purchase_period">
						         <input type="text" id="purchase_period_cd" name="purchase_period_cd" class="datePicker" readonly="readonly" onchange="fnChangeTextValue(this);">
						    </div>    
						    <div class="customer_desc">요구사항</div>
						    <div class="customer_req">
						        <textarea cols="40" rows="8"  class="customer_input-text"   id="customer_req" name="customer_req"  onchange="fnChangeTextValue(this);">
						        </textarea>
						    </div>																
						</form>
						<p/>
						<div class="box_btn">   
							<a href="#" class="btn_Style"   onclick="fnWriteFrmSave();">의뢰 신청</a>
						</div>
												
			 </div>
			 			  	
			</div>
		</div>	
	</div>
</html>

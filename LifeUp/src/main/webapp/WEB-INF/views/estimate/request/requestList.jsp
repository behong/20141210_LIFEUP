<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang='ko'>
<head>		
<%@ include file="../../include/library.jsp" %>	

<script src="/resources/js/jquery.imagesloaded.js"></script>
<script src="/resources/js/jquery.wookmark.js"></script>
<script type="text/javascript">	

	$(document).ready(function() {
/* 	    //get
	    if($.cookie('scroll_loc')){
	    	console.log("쿠키 좌표값"+$.cookie('scroll_loc'));
	        $(window).scrollTop($.cookie('scroll_loc'));
	    }
	    //set
	    $(window).scroll(function(){
	        $.cookie('scroll_loc',$(this).scrollTop());
	    });     */	    
	});

	function fnReqDetail(requestId) {			
		$('#hdnRequestId').val(requestId);
/* 		var  currentSeq 	  = requestId;
		var  currentscroll  = $(this).scrollTop();
		//두개의 데이타 ^를 구분자로 두개의 현재페이지 정보를 마킹해놓았습니다.
		str_hash=currentSeq+"^"+currentscroll;		
		document.location.hash = "#" + str_hash;
		console.log("디테일 이동하는 hash ==" + document.location.hash);
 */		
 		var frm = document.frmReqList;
		frm.action = "/request/detail";
		frm.submit();	
	}	

/* 	$(function(){
		var target_id='#scroll_foot';
		//$('body, html').css('scrollTop', $(target_id).offset().top);
		//$('body, html').animate({ scrollTop: $(target_id).offset().top }, 1000); 
		// window.scrollTo(0, $(target_id).offset().top);
		});	 */
</script>
</head>

<body>
	<%@ include file="../../include/header.jsp" %>	
	<div class="content">
		<div class="wrap">
			<div id="main" >
				<form id='frmReqList' name='frmReqList' method='post'>
					<input type='hidden' id='hdnScrollWorkingYn' name='hdnScrollWorkingYn' value="N" />
					<input type="hidden" id="hdnCurrentSeq" name='currentSeq' value='${param.currentSeq == null || param.currentSeq == "" ? 30 : param.currentSeq}'>
					<input type='hidden' id='hdnRequestId' name='request_id' />					
					<input type="hidden" id="hdnReqVendor" name="vendorCd" value='${param.vendorCd}' />
					<input type="hidden" id="hdnReqSido" name="sidoCd" value='${param.sidoCd}' />
					<input type="hidden" id="hdnReqGugun" name="gugunCd" value='${param.gugunCd}' />
					<input type="hidden" id="hdnReqStatus" name="statusCd" value='${param.statusCd}' />		
					<!--  point check -->
					<input type='hidden' id='hdnPoint_Id' name='point_id'  value='${sessionScope._USER_INFO_.userId}'/>
					<input type='hidden' id='hdnUserType_chk' name='user_type_chk'  value='${sessionScope._USER_INFO_.userType}'/>
				</form>
						
				<ul id="tiles">		
					<c:forEach items="${estimateRegList}" var="estimateReg" varStatus="status">	      
				        <li onclick="fnReqDetail('${estimateReg.REQUEST_ID}');" >			        	
				        	<!-- <img src="/resources/images/img1.jpg" width="200" height="200"> -->
				        	<div class="post-info">
				        		<div class="post-basic-info">
					        		<h3><a href="#">${estimateReg.CAR_NM}</a></h3>
					        		<span><a href="#"><label></label>${estimateReg.REGION_NM}</a></span>
					        		<p>${estimateReg.CUSTOMER_REQ}</p>
				        		</div>
				        		<div class="post-info-rate-share">
				        			<div class="rateit">
				        				${estimateReg.HIT_CNT} Hit
				        			</div>
				        			<div class="post-share">
				        				${estimateReg.STATUS_NM}
				        			</div>
				        			<div class="clear"> </div>
				        		</div>
				        	</div>
				        </li>
					</c:forEach>
		      	</ul>
		    </div>
		</div>
	</div>
	
	<script type="text/javascript">	
		(function ($){
			
			$tiles = $('#tiles'), $handler = $('li', $tiles), $main = $('#main'), $window = $(window), $document = $(document), options = {
				autoResize : true, // This will auto-update the layout when the browser window is resized.
				container : $main, // Optional, used for some extra CSS styling
				offset : 20, // Optional, the distance between grid items
				itemWidth : 260
			};
			/* checkForHash(); */
			/*
			상세페이지 이동하면 현 상태 스크롤 좌표값 데이타를 가지고 간다
			*/
			/* function checkForHash() {
			    if(document.location.hash){
			    	//hash 가 있다면 ^ 를 구분자로 하나씩 string을 추출하여 각각 페이지정보를 가져옵니다.
			    	var str_hash = document.location.hash;
			    	str_hash = str_hash.replace("#","");
			    	arr_curpage=str_hash.split("^");
			    	localpageSeq=arr_curpage[0];
			    	localScroll=arr_curpage[1];
		   	        console.log("보여줘야할 localpageSeq = " + localpageSeq);
			        console.log("보여줘야할 localScroll = " + localScroll);
			        $("#hdnCurrentSeq").val(localpageSeq);
			        $window.bind('scroll.wookmark', onScroll);
			    }else 
				{
					//nothing..
				}
			} */			
			
			function applyLayout() {
				//$tiles.imagesLoaded(function() {
					if ($handler.wookmarkInstance) {
						$handler.wookmarkInstance.clear();
					}
		
					$handler = $('li', $tiles);
					$handler.wookmark(options);
				//});
			}

			function onScroll() {
				// Check if we're within 100 pixels of the bottom edge of the broser window.
				var winHeight = window.innerHeight ? window.innerHeight : // iphone fix
				$window.height();
				var closeToBottom = ($window.scrollTop() + winHeight > $document.height() - 100);							
				
				//스크롤이 하단 부근에 왔을때		
				if (closeToBottom) {								

					if($("#hdnScrollWorkingYn").val() == "N") {
						
						$("#hdnScrollWorkingYn").val("Y");
						
						_Async.post (
							"/request/listJson",
							JSON.stringify(
											{
											 currentSeq: $("#hdnCurrentSeq").val(),
											 sido_cd: $('#ddlSido').val(), 
											 region_cd: $('#ddlGugun').val(), 
											 vendor_id: $('#ddlVendor').val(), 
											 status_cd: $('#ddlStatus').val() }
											),
							function (data) {	

 								if (data.list.length <= 0){
									alert('마지막 페이지 입니다.');
									return;
								}			
								if (data.list != null && data.list != "") {
									
									$.each(data.list, function( idx,row) {			
	
										var object = "<li onclick=\"fnReqDetail('" + row.REQUEST_ID + "');\">";			        	
										object += "<div class='post-info'>";
										object += "<div class=\"post-basic-info\">";
										object += "<h3><a href='#''>" + row.CAR_NM + "</a></h3>";
										object += "<span><a href='#'><label></label>" + row.REGION_NM + "</a></span>";
										object += "<p>" + row.CUSTOMER_REQ + "</p>";
										object += "</div>";
										object += "<div class='post-info-rate-share'>";
										object += "<div class='rateit'>";
										object += row.HIT_CNT + " Hit";
										object += "</div>";
										object += "<div class='post-share'>";
										object += row.STATUS_NM;
										object += "</div>";										
										object += "<div class='clear'></div>";
										object += "</div>";
										object += "</div>";
										object += "</li>";
										
										$tiles.append(object);		
									});		
									
									$("#hdnCurrentSeq").val(data.currentSeq);									
									$.cookie('currentSeq', data.currentSeq);									
								}
								$("#hdnScrollWorkingYn").val("N");
								applyLayout();
							}
						);
					}					
				}
			};
					
			// Call the layout function for the first time
			applyLayout();
			
			// Capture scroll event.
			$window.bind('scroll.wookmark', onScroll);
			
		    if($.cookie('currentSeq') > 0) {
		    	var currentSeq = $.cookie('currentSeq');
		    	
		    	_Async.post (
					"/request/listJson",
					JSON.stringify({
						 currentSeq: 0,
						 showMaxSeq: currentSeq,
						 sido_cd: $('#ddlSido').val(), 
						 region_cd: $('#ddlGugun').val(), 
						 vendor_id: $('#ddlVendor').val(), 
						 status_cd: $('#ddlStatus').val() 
					}),
					function (data) {							
						if (data.list != null && data.list != "") {							
							$.each(data.list, function( idx,row) {
								var object = "<li onclick=\"fnReqDetail('" + row.REQUEST_ID + "');\">";			        	
									object += "<div class='post-info'>";
									object += "<div class=\"post-basic-info\">";
									object += "<h3><a href='#''>" + row.CAR_NM + "</a></h3>";
									object += "<span><a href='#'><label></label>" + row.REGION_NM + "</a></span>";
									object += "<p>" + row.CUSTOMER_REQ + "</p>";
									object += "</div>";
									object += "<div class='post-info-rate-share'>";
									object += "<div class='rateit'>";
									object += row.HIT_CNT + " Hit";
									object += "</div>";
									object += "<div class='post-share'>";
									object += row.STATUS_NM;
									object += "</div>";										
									object += "<div class='clear'></div>";
									object += "</div>";
									object += "</div>";
									object += "</li>";
								
								$tiles.append(object);		
							});		
							
							$("#hdnCurrentSeq").val(data.currentSeq);
							$.cookie('currentSeq', data.currentSeq);
						}
						
						$('html, body').animate({scrollTop : $document.height()}, 1000);						
						$("#hdnScrollWorkingYn").val("N");											
						applyLayout();
					}
				);
		    }
		})(jQuery);	
	</script>
	
	<div class="footer" id="scroll_foot">
		<p>Copyright vavacar.com. All right reserved.</p>
	</div>
	
</body>
</html>
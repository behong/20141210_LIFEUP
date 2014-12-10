<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang='ko'>
<head>
<meta charset='utf-8'>
<title></title>
<!--  layer pop -->
<style type="text/css">
	.layer {display:none; position:fixed; _position:absolute; top:0; left:0; width:100%; height:100%; z-index:100;}
	.layer .bg {position:absolute; top:0; left:0; width:100%; height:100%; background:#000; opacity:.5; filter:alpha(opacity=50);}
	.layer .pop-layer {display:block;}
	.pop-layer {display:none; position: absolute; top: 50%; left: 50%; width: auto; height:auto;  background-color:#fff; border: 5px solid #3571B5; z-index: 10;}	
	.pop-layer .pop-container {padding: 20px 25px;}
	.pop-layer p.ctxt {color: #666; line-height: 25px;}
	.pop-layer .btn-right {width: 100%; margin:10px 0 20px; padding-top: 10px; border-top: 1px solid #DDD; text-align:right;}
	.pop-layer .btn-left {width: 100%; margin:10px 0 20px; padding-top: 10px; border-top: 1px solid #DDD; text-align:left;}
	a.cbtn {display:inline-block; height:25px; padding:0 14px 0; border:1px solid #304a8a; background-color:#3f5a9d; font-size:13px; color:#fff; line-height:25px;}	
	a.cbtn:hover {border: 1px solid #091940; background-color:#1f326a; color:#fff;}
	ul#youtube{list-style-type:none;width:300px;text-overflow:ellipsis;white-space:nowrap; overflow:hidden;} /* li 스타일 정하기*/
	.youtube_txt{display:block;text-align:center;width:144px;height:23px;margin:0 auto}

</style>	

<%@ include file="include/library.jsp" %>

<script type="text/javascript">
/*
	var _Commn = new webService.Web.ComnService();
	var _Async = new webService.Web.AsyncService(_Commn.fnBeforRun, _Commn.fnAfterRun);
		 	
	$(document).bind("mobileinit", function() {
		$.mobile.loadingMessage(false);
		$.mobile.ajaxEanbled(false);
		$.mobile.defaultPageTransition('slide');
		$.mobile.pageLoadErrorMessage('Please reflesh this website');
	});  
*/
	
	$( document ).ready(function() {			
		$.ajax({
			url : 'http://gdata.youtube.com/feeds/api/users/nayha70/favorites?alt=json-in-script&callback=?&max-results=2',
			dataType : 'json',
			//async : false,
			//data : data,
			success : function(data) { 
				$.each(data.feed.entry, function(i, item) {
					var title = item['title']['$t'];
					var video = item['id']['$t']; 
					video = video.replace('http://gdata.youtube.com/feeds/api/videos/','http://www.youtube.com/watch?v=');
					$('#youtube').append('<li><a href="'+video+'" onclick="layer_open();return false;">'+title+'</span></a></li>');
				});
				
				$("#youtube").ytplaylist({addThumbs:true, autoPlay: true, holderId: 'ytvideo2'});
			}
		});
		
	});

	function layer_open(el){
		el="layer2"; //임의 추가 
		var temp = $('#' + el);
		var bg = temp.prev().hasClass('bg');	//dimmed 레이어를 감지하기 위한 boolean 변수
		
		if(bg){
			$('.layer').fadeIn();	//'bg' 클래스가 존재하면 레이어가 나타나고 배경은 dimmed 된다. 
		}else{
			temp.fadeIn();
		}
		
		// 화면의 중앙에 레이어를 띄운다.
		if (temp.outerHeight() < $(document).height() ) temp.css('margin-top', '-'+temp.outerHeight()/2+'px');
		else temp.css('top', '0px');
		if (temp.outerWidth() < $(document).width() ) temp.css('margin-left', '-'+temp.outerWidth()/2+'px');
		else temp.css('left', '0px');
		
		temp.find('a.cbtn').click(function(e){
			if(bg){
				$('.layer').fadeOut(); //'bg' 클래스가 존재하면 레이어를 사라지게 한다. 
			}else{
				temp.fadeOut();
			}
			e.preventDefault();
		});
		
		$('.layer .bg').click(function(e){	//배경을 클릭하면 레이어를 사라지게 하는 이벤트 핸들러
			$('.layer').fadeOut();
			e.preventDefault();
		});	
	}		

	function fnMainReqDetail(requestId) {
		$('#hdnRequestId').val(requestId);
		_Commn.fnPageMove("/request/detail", $('#frmMain'));
		//frm.action = "/request/detail";
		//frm.submit();
	}	 

 	$(document).on('pagebeforeshow', '#mainPage' ,function(){
		_Commn.fnMarkingLeftMenu($("#mainPage").find("a[id='menuMain']"));	
	});	
</script>   

<script src='<spring:url value="/resources/js/login.js"/>'></script>
<script src='<spring:url value="/resources/js/contractDetail.js"/>'></script>
<script src='<spring:url value="/resources/js/contractFrm.js"/>'></script>
<script src='<spring:url value="/resources/js/faqList.js"/>'></script>	
<script src='<spring:url value="/resources/js/membership.js"/>'></script>
<script src='<spring:url value="/resources/js/myPageList.js"/>'></script>
<script src='<spring:url value="/resources/js/noticeList.js"/>'></script>
<script src='<spring:url value="/resources/js/requestDetail.js"/>'></script>	
<script src='<spring:url value="/resources/js/requestList.js"/>'></script>	
<script src='<spring:url value="/resources/js/requestWriteFrm.js"/>'></script>	
<script src='<spring:url value="/resources/js/salesRanking.js"/>'></script>
<script src='<spring:url value="/resources/js/payment.js"/>'></script>
<script type="text/javascript" src="http://geckohub.com/jquery/youtubeplaylist/jquery.youtubeplaylist.js"></script>
    
</head>
<body>
	<div data-role="page" class="jqm-demos ui-responsive-panel" id="mainPage">

		<%@ include file="include/header.jsp" %>
		
		<div data-role="content" class="ui-content jqm-content jqm-fullwidth" style="padding-top: 0px;">	
		<form name="frmMain" id="frmMain" method="post">
			<input type="hidden" id="hdnRequestId" name="request_id" />
		</form>			
					
		<div class="ui-grid-a ui-responsive">
        	<div class="ui-block-a">
        		<div class="jqm-block-content">
        			<h3>많이 본 의뢰글</h3><!-- 비싼 차종? -->
					<c:forEach items="${requestList}" var="request" varStatus="status">
						<p style="text-overflow:ellipsis; overflow:hidden; white-space:nowrap"><a href="#" onclick="fnMainReqDetail('${request.REQUEST_ID}');" class="ui-link">${request.CUSTOMER_REQ}</a></p>
					</c:forEach>       			
        		</div>
        	</div>
        	<div class="ui-block-b">
        		<div class="jqm-block-content">
        			<h3>주간 베스트 영맨</h3>
					<c:forEach items="${weeklyRankList}" var="weekklyRank" varStatus="status">
						<p style="text-overflow:ellipsis; overflow:hidden; white-space:nowrap"><a href="#" onclick="_Commn.fnPageMove('<spring:url value="/salesRanking" />')" data-transition="slide" class="ui-link">[${weekklyRank.VENDOR_NM}-${weekklyRank.SALESMAN_NM}] ${weekklyRank.INTRO_MSG}</a></p>
					</c:forEach> 
        		</div>
        	</div>        	
        	<div class="ui-block-a">
        		<div class="jqm-block-content">
        			<h3>월간 베스트 영맨</h3>
					<c:forEach items="${monthlyRankList}" var="monthlyRank" varStatus="status">
						<p style="text-overflow:ellipsis; overflow:hidden; white-space:nowrap"><a href="#" onclick="_Commn.fnPageMove('<spring:url value="/salesRanking" />')" data-transition="slide" class="ui-link">[${monthlyRank.VENDOR_NM}-${monthlyRank.SALESMAN_NM}] ${monthlyRank.INTRO_MSG}</a></p>
					</c:forEach>  
        		</div>
        	</div>     	
        	<div class="ui-block-b">
        		<div class="jqm-block-content">
        			<h3>자동차 갤러리</h3><!-- 이미지 누르면 겔러리 상세  -->
					<ul id="youtube"></ul>
        		</div>
        	</div>
        </div>
        
		</div>		
	</div><!-- /page -->
	
	<!--  pop layer -->
	<div class="layer">
		<div class="bg"></div>
		<div id="layer2" class="pop-layer">
			<div class="pop-container">
				<div class="pop-conts">
					<!--content //-->
					<p class="ctxt mb20"><div id="ytvideo2"></div></p>
					<div class="btn-left">
						<a href="#" class="cbtn">Close</a>
					</div>
					<!--// content-->
				</div>
			</div>
		</div>
	</div>
	<!--  pop layer End -->	
</html>

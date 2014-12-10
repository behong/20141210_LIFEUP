<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang='ko'>
<head>
<%@ include file="../include/library.jsp" %>
<script type="text/javascript">
</script>
</head>
<body>
	<%@ include file="../include/header.jsp" %>
	<div class="content">
		<div class="wrap">
			<div class="single-page">
				<div class="single-page-artical">
					<div class="artical-content">
						<c:forEach items="${salesRankingList}" var="rows" varStatus="status">
							<div class="grid1_of_2">
								<div class="grid_img">
									<a href=""><img src="/resources/images/pic10.jpg" alt=""></a>
								</div>
								<div class="grid_text">																	
									<h4 class="style1 list">${rows.VENDOR_NM} > ${rows.LOCATION} > ${rows.SALESMAN_NM}</h4>
									<h3 class="style"><a href="mailto:${rows.SALESMAN_ID}" class="ui-btn">${rows.SALESMAN_ID}</a></h3>
									<h3 class="style"><a href="tel:${rows.MOBILE}" class="ui-btn">${rows.MOBILE}</a></h3>
									<p class="para top">${rows.INTRO_MSG}</p>	
								</div>
								<div class="clear"></div>
							</div>
						</c:forEach>					
					</div>					
				</div>
			</div>
		</div>	
	</div><!-- /page -->
</html>

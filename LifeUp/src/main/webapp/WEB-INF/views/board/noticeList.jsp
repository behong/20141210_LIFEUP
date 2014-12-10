<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang='ko'>
<head>
<%@ include file="../include/library.jsp" %>
<script type="text/javascript">
	$(document).ready(function() {
		$("#accordion").accordion();
	});		 
</script>
</head>
<body>
	<%@ include file="../include/header.jsp" %>
	<div class="content">
		<div class="wrap">
			<div id="main" role="main">
				<div id="accordion">
					<c:forEach items="${noticeList}" var="notice" varStatus="status">
					<h3>${notice.TITLE}</h3>
					<div>${notice.CONTENT}</div>
					</c:forEach>																
				</div>
			</div>
		</div>	
	</div><!-- /page -->
</html>

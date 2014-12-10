<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang='ko'>
<head>
<meta charset='UTF-8'>
<%@ include file="../include/library.jsp" %>
</head>
<body>

		<div >
			<ul>
			    <li>			    	
			    	<h1><a href="#" onclick="_Commn.fnPageMove('<spring:url value="/main" />')" >홈</a></h1>
			    </li>
			    <li><h1>데이터 처리 중 오류가 발생했습니다. ${exception.customMsg}</h1></li>
    		</ul>    		    			
		</div>
	
</html>
<body>
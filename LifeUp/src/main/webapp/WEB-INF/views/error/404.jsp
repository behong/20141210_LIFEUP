<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang='ko'>
<head>
<meta charset='utf-8'>
<%@ include file="../include/library.jsp" %>
</head>
<body>
	<div data-role="page" class="jqm-demos ui-responsive-panel" id="notFoundPage">
		<div data-role="content" class="ui-content jqm-content jqm-fullwidth" style="padding-top: 0px;">
			<ul data-role="listview" data-inset="true">
			    <li data-role="list-divider" data-theme="b">			    	
			    	<h1><a href="#" onclick="_Commn.fnPageMove('<spring:url value="/main" />')" data-icon="home" data-iconpos="notext" style="height:30px; padding-top: 18px; border-right-width: 0px;">홈</a></h1>
			    </li>
			    <li data-role="list-divider"><h1>페이지를 찾을 수 없습니다</h1></li>
    		</ul>    		    			
		</div>
	</div>
</html>
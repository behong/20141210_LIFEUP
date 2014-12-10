<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html> 
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>MAIN </title>
  <link rel="stylesheet" href="//code.jquery.com/mobile/1.4.2/jquery.mobile-1.4.2.min.css">
  <script src="//code.jquery.com/jquery-1.10.2.min.js"></script>
  <script src="//code.jquery.com/mobile/1.4.2/jquery.mobile-1.4.2.min.js"></script>
</head>
<body>   

<div data-role="page" class="jqm-demos ui-responsive-panel" id="panel-responsive-page1"  >

	<div class="ui-content jqm-content jqm-fullwidth">

		<table data-role="table" id="table-custom-2" data-mode="columntoggle" class="ui-body-d ui-shadow table-stripe ui-responsive" data-column-btn-theme="b" data-column-btn-text="필요한것만.." data-column-popup-theme="a">
	         <thead>
	           <tr class="ui-bar-d">
	             <th data-priority="1">글번호</th>
	             <th>제 목</th>
	             <th data-priority="2">작성자</th>
	           </tr>
	         </thead>
	         
			  <tbody>
			   <c:forEach items="${posts}" var="post">    
	       		<tr>
	             <th>${post.id}</th>
	             <td class="title"><a href="<spring:url value="/${board.name}/post/${post.id}"/>" data-rel="external">${post.title}</a></td>
	             <td>${post.reg_id}</td>
	           </tr>
			  </c:forEach>           
	         </tbody>
       </table>
       
		<a href="<spring:url value="/${board.name}/post/new"/>" class="ui-shadow ui-btn ui-corner-all ui-btn-icon-left ui-icon-plus ui-btn-b">글쓰기</a>          		     
	        
	</div><!-- /content -->
		    


</div>

</body>

</html>
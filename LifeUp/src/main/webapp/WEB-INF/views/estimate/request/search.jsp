<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang='ko'>
<head>		
</head>
<body>
				<div style='max-width:400px; display:none;'>
		            <div>
		                <h1>조건 검색</h1>
		            </div>
		            <div>
						<fieldset>
						    <label for="ddlSido">시(도)</label>
						    <select name="ddlSido" id="ddlSido" onchange="fnReqSidoChange('', 'N');">
						    	<option value="">시(도)</option>
								<c:forEach items="${sidos}" var="sido">
									<option value="${sido.sido_cd}">${sido.sido_nm}</option>
								</c:forEach>
						    </select>	
						    <label for="region_cd">구(군)</label>
						    <select name="region_cd" id="ddlGugun" onchange="fnReqDDLChange();">
						    	<option value="">구(군)</option>				   		
						    </select>				    		       
						</fieldset>
						<fieldset >
						    <label for="ddlVendor">제조업체</label>
						    <select name="ddlVendor" id="ddlVendor" onchange="fnReqDDLChange();">
						    	<option value="">제조업체</option>
						   		<c:forEach items="${venders}" var="vender">
						   			<option value="${vender.code}">${vender.value}</option>
						   		</c:forEach>
						    </select>			       
						</fieldset>	
						<fieldset >
						    <label for="ddlStatus">거래상태</label>
						    <select name="status_cd" id="ddlStatus" onchange="fnReqDDLChange();">
						    	<option value="">거래상태</option>
						    	<option value="0001">진행중</option>
						    	<option value="0002">종료</option>
						    </select>			       
						</fieldset>																		
		                <a href='#' onclick="fnGetCtrlVal();">닫기</a>
		            </div>
		        </div>	
		        
</body>
</html>		        
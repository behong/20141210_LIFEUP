<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>로그인</title>
<link rel="stylesheet" type="text/css" href="/resources/admin/css/board.css" />
<script type="text/javascript" src="/resources/admin/js/util.js"></script>
<script type="text/javascript">
function checkForm(f) {
	var result = true;
	if(isNull(f.j_username, document.getElementById("error_username"), "계정을 입력하세요!!")) result = false;
	if(isNull(f.j_password, document.getElementById("error_password"), "암호를 입력하세요!!")) result = false;
	return result;
}
</script>
</head>
<body>
<div id="dialog">
	<h3 align="center">로그인</h3>
	<form action="/static/j_spring_security_check" method="post" onsubmit="return checkForm(this)">
		<table width="300" align="center">
			<tr>
				<th width="100">계정</th>
				<td>
					<input type="text" name="j_username" size="20" /><br />
					<span class="error-text" id="error_username"></span>
				</td>
			</tr>
			<tr>
				<th>암호</th>
				<td>
					<input type="password" name="j_password" size="20" /><br />
					<span class="error-text" id="error_password"></span>
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					암호 기억하기&nbsp;&nbsp;<input type="checkbox" name="_spring_security_remember_me" />&nbsp;&nbsp;
				</td>
			</tr>
			<!-- 
			<tr>
				<td colspan="2" align="center">
					<a href="join">[회원 가입]</a>
				</td>
			</tr>
			 -->
			<tr>
				<td colspan="2" align="center">
					<input type="submit" value="확인" />&nbsp;
					<input type="button" value="취소" onclick="history.back();" />
				</td>
			</tr>
		</table><br />
		<c:if test="${not empty error }">
			<div align="center" class="error-text">${error }</div>
		</c:if>
	</form>
</div>
</body>
</html>
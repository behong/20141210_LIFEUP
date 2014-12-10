<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>예제</title>
<style type="text/css">
body { font-size: 12px; }
td { text-align: center; }
.warning { font-weight: bold; color: red; }
.regId_list{width:150px; vertical-align:middle; overflow:hidden; text-overflow:ellipsis; white-space:nowrap;}
</style>
		<link rel="stylesheet" href="/resources/admin/css/board.css" type="text/css"  />		
		<link rel="stylesheet" href="/resources/admin/css/960.css" type="text/css" media="screen" charset="utf-8" />
		<link rel="stylesheet" href="/resources/admin/css/template.css" type="text/css" media="screen" charset="utf-8" />
		<link rel="stylesheet" href="/resources/admin/css/colour.css" type="text/css" media="screen" charset="utf-8" />
<script type="text/javascript">
function check(fm) {
	if(fm.message.value.length == 0) {
		alert("메시지를 입력하세요.");
		fm.message.focus();
		return false;
	} else {
		return true;
	}
}
</script>
</head>
<body>
<!-- head -->
		<%@ include file="../admin/head.jsp" %>

		<div id="content" class="container_16 clearfix">
				<h3>메시지 수신이 가능한 디바이스 목록</h3>
				<hr />
				<table border="1">
					<tr>
						<th width="200">회원 ID</th>
						<th width="200">디바이스 ID</th>
						<th width="200">전화번호</th>
						<th width="200">Registration ID(앞자리 10글자)</th>
						<th width="40"></th>
					</tr>
					<c:forEach items="${devices}" var="device">
					<tr>
						<td>${device.user_id}</td>
						<td>${device.uuid}</td>
						<td>${device.phone}</td>
						<td><div id="test" class="regId_list">${device.reg_Id}</div></td>
						<td><a href="removeDevice.do?id=${device.user_id}">삭제</a>
					</tr>
					</c:forEach>
				</table>
				<hr />
				<h3>메시지 전송</h3>
				<p class="warning">주의 : 메시지는 위에 등록된 모든 디바이스에 전송됩니다.</p>
				<hr />
				<form action="/push/send" method="post" onsubmit="return check(this)">
					<input type="radio" name="AllMessage" value="ALL" />전체
					<input type="radio" name="AllMessage" value="No" checked="checked" />지정
					<br />
					<label for="message">전송 할 아이디 : </label><input type="text" id="user_id" name="user_id" size="30" /><br />
					<label for="message">전송 할 메시지 : </label><input type="text" id="message" name="message" size="100" />
					<input type="submit" value="전송" /> 
				</form>
				<hr />
		</div>
		
		
		<div id="foot">
			<div class="container_16 clearfix">
				<div class="grid_16">
					<a href="#">푸웃</a>
				</div>
			</div>
		</div>

</body>
</html>
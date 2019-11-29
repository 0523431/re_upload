<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="co" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>A new journey</title>
</head>
<body>
<div class="temp">
	<button class="save" onclick="location.href='mainWrite.jsp'">
		여행지 등록하기
	</button>
</div>

<hr>

<div>
	<co:forEach var="list" items="${list}">
	<div>
	</div>
	</co:forEach>
</div>
</body>
</html>
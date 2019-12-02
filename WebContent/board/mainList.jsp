<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="co" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>A new journey</title>
<style type="text/css">
	div {
		border-bottom: 5px solid #f7f7f7;
		margin: 10px;
		padding-bottom: 10px;
		width: 70%;
	}
	.test {
		border: 5px solid #f7f7f7;
		padding: 20px;
		width : 275px;
		border-radius: 10px;
		-moz-border-radius: 10px;
		-webkit-border-radius: 10px;
	}
</style>
</head>
<body>
<div class="temp">
	<button class="save" onclick="location.href='mainWrite.jsp'">
		여행지 등록하기
	</button>
</div>

<hr>
<div>
	<co:forEach var="list" items="${info}">
	<div class="test">
		<p><a href="subList.pro?num=${info.travelnum}">${info.traveltitle}</a></p>
		<p>${info.start}&nbsp;&nbsp;${info.end}</p>
		<p>${info.budget}</p>
	</div>
	</co:forEach>	
</div>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="co" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>A new journey</title>
<script>
	// 검색 후, 그 결과를 페이지에 유지시켜주는 메서드함수
	function listdo(page) { // listdo 메서드에 page값을 넣고
		document.f.pageNum.value = page; // pageNum의 value값을 바꿔주는 거야
		document.f.submit(); // form을 submit해주는 거야
	}
</script>
<style type="text/css">
	div {
		border-bottom: 5px solid #f7f7f7;
		margin: 10px;
		padding-bottom: 10px;
		width: 70%;
	}
	.test {
		margin : auto;
		border: 2px solid #E0E3DA;
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

<form action="mainInfo.pro" method="post" name="f">
<co:set var="today" value="<%=new java.util.Date() %>" />
<input type="hidden" name="today" value="${today}">

<input type="hidden" name="pageNum" value="1">
	<div>
		<co:forEach var="list" items="${list}">
		<div class="test" style="background-image:url(${list.background})">
			<p><a href="subList.pro?travelNum=${list.travelNum}">${list.traveltitle}</a></p>
			<p>${list.start}&nbsp;-&nbsp;${list.end}</p>
			<p>${list.budget}</p>
		</div>
		<br>
		</co:forEach>	
	</div>
	
	<%-- 어려운 부분 --%>
	<div>
		<co:if test="${pageNum <=1}">
			[이전]
		</co:if>
		<co:if test="${pageNum >1}">
				<%-- <a href="list.do?pageNum=${pageNum -1}">[이전]</a> --%>
				<a href="javascript:listdo(${pageNum -1})">[이전]</a>
		</co:if>
		
		<co:forEach var="a" begin="${startpage}" end="${endpage}">
			<co:if test="${a ==pageNum}">
				[${a}]
			</co:if>
			<co:if test="${a !=pageNum}">
				<%-- <a href="list.do?pageNum=${a}">[${a}]</a> --%>
				<a href="javascript:listdo(${a})">[${a}]</a>
			</co:if>
		</co:forEach>

		<co:if test="${pageNum >= maxpage}">
			[다음]
		</co:if>
		<co:if test="${pageNum < maxpage}">
			<%-- <a href="list.do?pageNum=${pageNum +1}">[다음]</a> --%>
			<a href="javascript:listdo(${pageNum +1})">[다음]</a>
		</co:if>
	</div>
</form>
</body>
</html>
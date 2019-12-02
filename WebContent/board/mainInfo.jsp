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
	// �˻� ��, �� ����� �������� ���������ִ� �޼����Լ�
	function listdo(page) { // listdo �޼��忡 page���� �ְ�
		document.f.pageNum.value = page; // pageNum�� value���� �ٲ��ִ� �ž�
		document.f.submit(); // form�� submit���ִ� �ž�
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
		������ ����ϱ�
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
	
	<%-- ����� �κ� --%>
	<div>
		<co:if test="${pageNum <=1}">
			[����]
		</co:if>
		<co:if test="${pageNum >1}">
				<%-- <a href="list.do?pageNum=${pageNum -1}">[����]</a> --%>
				<a href="javascript:listdo(${pageNum -1})">[����]</a>
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
			[����]
		</co:if>
		<co:if test="${pageNum < maxpage}">
			<%-- <a href="list.do?pageNum=${pageNum +1}">[����]</a> --%>
			<a href="javascript:listdo(${pageNum +1})">[����]</a>
		</co:if>
	</div>
</form>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="co" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<co:set var="path" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>A new journey</title>
<%-- ajax�� �̿��ؼ� ����� �����̶� jquery�� ���� --%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script>
	// �˻� ��, �� ����� �������� ���������ִ� �޼����Լ�
	function listdo(page) { // listdo �޼��忡 page���� �ְ�
		document.f.pageNum.value = page; // pageNum�� value���� �ٲ��ִ� �ž�
		document.f.submit(); // form�� submit���ִ� �ž�
	}
</script>
<style type="text/css">
	.test {
		margin : auto;
		border: 2px solid #E0E3DA;
		padding: 20px;
		width : 275px;
		border-radius: 10px;
		-moz-border-radius: 10px;
		-webkit-border-radius: 10px;
	}
	.uploadbtn {
	margin : auto;
	text-align : center;
	background-color:#E0E3DA;
	border-radius:20px;
	border:2px solid #E0E3DA;
	display:inline-block;
	cursor:pointer;
	color:#566270;
	font-family:Arial;
	font-size:20px;
	padding:20px 40px;
	text-decoration:none;
	}
	.uploadbtn:hover {
	background-color: #566270;
	color:#E0E3DA;
	}
	.infodiv {
	width:350px; height:300px;
	border:1px solid red;
	float:left;
	margin-right:10px;
	}
	.graphdiv {
	width:350px; height:300px;
	border:1px solid red;
	float:left;
	}
</style>
</head>
<body>
<div class="divcenter">
	<button class="uploadbtn" onclick="location.href='mainWriteForm.pro?email=${sessionScope.email}'">
		������ ����ϱ�
	</button>
</div>
<hr>
<form action="mainInfo.pro" method="post" name="f">
	<co:set var="today" value="<%=new java.util.Date() %>" />
	
	<input type="hidden" name="today" value="new Date()">
	<input type="hidden" name="pageNum" value="1">
	
	<div>
		<co:forEach var="list" items="${list}">
		<div class="test">
			<p><a href="subList.pro?travelNum=${list.travelNum}">${list.traveltitle}</a></p>
			<p>${list.start}&nbsp;-&nbsp;${list.end}</p>
			<p>���� : ${list.budget}&nbsp;&nbsp;&nbsp; <p>������ : ${list.country}</p>
		</div>
		<!-- <div class="test">
			<canvas id="canvas">
			</canvas>
		</div> -->
		</co:forEach>
	</div>
	
	
	<%-- ����� �κ� --%>
	<hr>
	<div class="divcenter">
		<co:if test="${pageNum <=1}">
			[����]
		</co:if>
		<co:if test="${pageNum >1}">
				<a href="javascript:listdo(${pageNum -1})">[����]</a>
		</co:if>
		
		<co:forEach var="a" begin="${startpage}" end="${endpage}">
			<co:if test="${a ==pageNum}">
				[${a}]
			</co:if>
			<co:if test="${a !=pageNum}">
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
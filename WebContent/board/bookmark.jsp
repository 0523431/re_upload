<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>���ε���</title>
<style>
td {
	background-color: #E0E3DA;
	border: 5px solid #f7f7f7;
	text-align: center;
	padding: 10px;
}
</style>
<script>
function listdo(page) { // listdo �޼��忡 page���� �ְ�
	document.f.pageNum.value = page; // pageNum�� value���� �ٲ��ִ� �ž�
	document.f.submit(); // form�� submit���ִ� �ž�
}
</script>
</head>
<body>
<form name="f" action="bookmark.pro" method="post">
<input type="hidden" name="pageNum" value="1">

<c:forEach var="b" items="${list}">
<table>
	<tr><td rowspan="2"><img class="circle-img" src="${path}/member/profile/${b.profile}" /></td>
		<td>${b.nickname}&nbsp;&nbsp;&nbsp;(${b.email})</td>
	<tr>
		<td>${b.seldate}�� ${b.selhour} �� ${b.selminute} ��</td>
	</tr>
</table>
<table>
	<tr><td>${b.type2==1? "�ĺ�":b.type2==2? "����":b.type2==3? "����":b.type2==4? "����":b.type2==5? "����":b.type2==6? "���ǰ":"��Ÿ"}</td>
		<td>${b.type1==1? "����":b.type1==2? "ī��":"����"}</td>
		<td>${b.price}</td>
		<td>${b.peocnt} ��</td>
	</tr>
	<tr><td colspan="4">${b.title}</td></tr>
	<tr><td colspan="4">${b.content}</td></tr>
</table>
<br>
</c:forEach>
<!-- ������ �ѱ�� -->
<hr>
	<div class="divcenter">
		<c:if test="${pageNum <=1}">
			[����]
		</c:if>
		<c:if test="${pageNum >1}">
				<a href="javascript:listdo(${pageNum -1})">[����]</a>
		</c:if>
		
		<c:forEach var="a" begin="${startpage}" end="${endpage}">
			<c:if test="${a ==pageNum}">
				[${a}]
			</c:if>
			<c:if test="${a !=pageNum}">
				<a href="javascript:listdo(${a})">[${a}]</a>
			</c:if>
		</c:forEach>

		<c:if test="${pageNum >= maxpage}">
			[����]
		</c:if>
		<c:if test="${pageNum < maxpage}">
			<a href="javascript:listdo(${pageNum +1})">[����]</a>
		</c:if>
	</div>
</form>
</body>
</html>
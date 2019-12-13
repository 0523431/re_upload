<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>���ε���</title>
</head>
<body>
<c:forEach var="b" items="${list}">
<table>
	<tr><td rowspan="2"><img class="circle-img" src="${path}/member/profile/${b.profile}" /></td>
		<td>${b.nickname}&nbsp;&nbsp;&nbsp;(${b.email})</td>
	<tr>
		<td>${b.seldate}�� ${b.selhour} �� ${b.selminute} ��</td>
	</tr>
</table>
<br>
<table>
	<tr><td>${b.type2==1? "�ĺ�":b.type2==2? "����":b.type2==3? "����":b.type2==4? "����":b.type2==5? "����":b.type2==6? "���ǰ":"��Ÿ"}</td>
		<td>${b.type1==1? "����":b.type1==2? "ī��":"����"}</td>
		<td>${b.price}</td>
		<td>${b.peocnt} ��</td>
	</tr>
	<tr><td colspan="4">${b.title}</td></tr>
	<tr><td colspan="4">${b.content}</td></tr>
</table>
</c:forEach>
</body>
</html>
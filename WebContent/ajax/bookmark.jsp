<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>따로따로</title>
</head>
<body>
<c:forEach var="b" items="${list}">
<table>
	<tr><td rowspan="2"><img class="circle-img" src="${path}/member/profile/${b.profile}" /></td>
		<td>${b.nickname}&nbsp;&nbsp;&nbsp;(${b.email})</td>
	<tr>
		<td>${b.seldate}일 ${b.selhour} 시 ${b.selminute} 분</td>
	</tr>
</table>
<br>
<table>
	<tr><td>${b.type2==1? "식비":b.type2==2? "쇼핑":b.type2==3? "관광":b.type2==4? "교통":b.type2==5? "숙박":b.type2==6? "기념품":"기타"}</td>
		<td>${b.type1==1? "현금":b.type1==2? "카드":"무료"}</td>
		<td>${b.price}</td>
		<td>${b.peocnt} 명</td>
	</tr>
	<tr><td colspan="4">${b.title}</td></tr>
	<tr><td colspan="4">${b.content}</td></tr>
</table>
</c:forEach>
</body>
</html>
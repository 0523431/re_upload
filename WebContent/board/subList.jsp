<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Expense list</title>
<style>
td {
	color : #566270;
	border: 3px solid #E0E3DA;
	padding : 10px;
}
</style>
</head>
<body>

<div class="mainTitle">
	${list.traveltitle}
</div>

<table>
	<tr>
		<td>ALL</td>
 		<c:forEach var="date" begin="${fn:substring(list.start,3,4)}" end="${fn:substring(list.end,3,4)}" ><td>${date}</td>
		</c:forEach>
	</tr>
</table>
<br>
<table>
	<tr>
		<td onclick="">ALL</td>
		<td onclick="">CASH</td>
		<td onclick="">CARD</td>
		<td onclick="location.href='subWrite.pro'">새 지출</td>
	</tr>
</table>
<br>
<table>
	<tr>
		<td>쓴돈</td>
		<td>남은돈 ${list.budget}</td>
	</tr>
</table>
<br>
<co:if test=${!emtpy }>
<table>
	<tr>
		<td rowspan="2"></td>
		<td></td>
		<td></td>
		<td></td>
	</tr>
	<tr>
		<td colspan="2"></td>
		<td></td>
	</tr>
</table>
</co:if>

</body>
</html>
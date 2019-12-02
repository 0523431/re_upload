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
	${info.traveltitle}
</div>

<table>
	<tr>
		<td>ALL</td>
 		<c:forEach var="date" begin="${fn:substring(info.start,4,6)}" end="${fn:substring(info.end,4,6)}" >
 		<td>${date}</td>
		</c:forEach>
	</tr>
</table>
<br>
<table>
	<tr>
		<td onclick="">ALL</td>
		<td onclick="">CASH</td>
		<td onclick="">CARD</td>
		<td onclick="location.href='subWrite.pro?date='+">�� ����</td>
	</tr>
</table>
<br>
<table>
	<tr>
		<td>����</td>
		<td>������ ${info.budget}</td>
	</tr>
</table>
<br>
<%-- <co:if test=${!emtpy info.}> --%>
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
<%-- </co:if> --%>

</body>
</html>
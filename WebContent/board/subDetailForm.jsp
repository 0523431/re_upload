<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>���⳻�� �ڼ��� �����?</title>
<style>
td {
	color: #566270;
	border: 3px solid #E0E3DA;
	padding: 10px;
	text-align: center;
}
</style>
<script>
function goback() {
	 history.back();  
	 return false;
}	
</script>
</head>
<body>

<input type="hidden" value="${param.expenseNum}" name="expenseNum">
<div class="divcenter">
	<a href="javascript:goback()">${tinfo.traveltitle}</a>
</div>
<table>
	<tr><td rowspan="2"><img class="circle-img" src="${path}/member/profile/${info.profile}" /></td>
		<td>${info.nickname}&nbsp;&nbsp;&nbsp;(${info.email})</td>
	<tr>
		<td>${info.seldate}�� ${info.selhour} �� ${info.selminute} ��</td>
	</tr>
</table>
<br>
<table>
	<tr><td>${info.type2==1? "�ĺ�":info.type2==2? "����":info.type2==3? "����":info.type2==4? "����":info.type2==5? "����":info.type2==6? "���ǰ":"��Ÿ"}</td>
		<td>${info.type1==1? "����":info.type1==2? "ī��":"����"}</td>
		<td>${info.price}</td>
		<td>${info.peocnt} ��</td>
	</tr>
	<tr><td colspan="4">${info.title}</td></tr>
	<tr><td colspan="4">${info.content}</td></tr>
</table>

<!-- ���� ���� -->
<c:if test="${info.email != sessionScope.email}">
<div class="divcenter">
	<button onclick="return goback()">���ư���</button>
</div>
</c:if>
<c:if test="${info.email == sessionScope.email}">
<div class="divcenter">
	<button onclick="location.href='subDeleteForm.pro?expenseNum=${param.expenseNum}'">����</button>
	<button onclick="location.href='subUpdateForm.pro?expenseNum=${param.expenseNum}'">����</button>
</div>
</c:if>
</body>
</html>
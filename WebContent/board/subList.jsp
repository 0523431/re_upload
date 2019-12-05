<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="co" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>�󸶽質 �����?</title>
<style>
td {
	color: #566270;
	border: 3px solid #E0E3DA;
	padding: 10px;
	text-align: center;
}
.type1 {
	text-align : center;
	background-color:transparent;
	border-radius:0px;
	border:3px solid #E0E3DA;
	display:inline-block;
	cursor:pointer;
	color:#566270;
	font-family:Arial;
	font-size:16px;
	padding:13px 35px;
	text-decoration:none;
}
</style>
<script>

</script>
</head>
<body>
<input type="hidden" value="${sessionScope.email}" name="email">
<input type="hidden" value="${param.travelNum}" name="travelNum">

<div class="mainTitle">
	<a href="mainInfo.pro?email=${sessionScope.email}">${info.traveltitle}</a>
</div>
<button onclick="location.href='mainUpdateForm.pro?travelNum=${param.travelNum}'">
����
</button>

<table>
	<tr>
		<td><a href="subList.pro?travelNum=${param.travelNum}">ALL</a></td>
 		<co:forEach var="date" begin="${fn:substring(info.start,3,5)}" end="${fn:substring(info.end,3,5)}" >
 		<td><a href="javascript:">${date}</a></td>
		</co:forEach>
	</tr>
</table>
<br>
<!--
	���� form�±� �ȿ��� input�� name�� value�� ���� url�� �����µ�,
	�ؿ��� �� ����� input���� ���� �ٷ� parameter�� 
	mode : parameter
	all, 1, 2 : value ��
-->
<div class="divcenter">
	<button class="type1" onclick="location.href='subList.pro?travelNum=${param.travelNum}&mode=all'">��ƺ���</button>
	<button class="type1" onclick="location.href='subList.pro?travelNum=${param.travelNum}&mode=1'">����</button>
	<button class="type1" onclick="location.href='subList.pro?travelNum=${param.travelNum}&mode=2'">ī��</button>
	<button class="type1" onclick="location.href='subWriteForm.pro?travelNum=${param.travelNum}'">������</button>
</div>
<br>
<table>
	<tr>
		<td>����&nbsp;&nbsp;&nbsp;
			<co:forEach var="m" items="${exlist}">
				<co:set var="sum" value="${sum+ m.price}" />
			</co:forEach>
			${sum}
			<co:forEach var="m" items="${exlist}">
				<co:if test="${m.type1==1}">
					<co:set var="sumcash" value="${sumcash+ m.price}" />
				</co:if>
			</co:forEach>
		</td>
		<td>������&nbsp;&nbsp;&nbsp;
			<co:if test="${expcnt ==0}">
			${info.budget}
			</co:if>
			<co:if test="${expcnt >0}">
				<co:forEach var="m" items="${exlist}">
					<co:if test="${m.type1 ==1}">
						<co:set var="budget" value="${info.budget-sumcash}" />
					</co:if>
				</co:forEach>
			</co:if>
			${budget}</td>
	</tr>
</table>
<br>
<co:if test="${expcnt ==0}">
	<div class="divcenter">
		���⳻���� �����ϴ�
	</div>
</co:if>

<co:if test="${expcnt >0}">
<table>
	<co:forEach var="ex" items="${exlist}">
	<tr>
		<td rowspan="2" width="10%">${ex.type2==1? "�ĺ�":ex.type2==2? "����":ex.type2==3? "����":ex.type2==4? "����":ex.type2==5? "����":ex.type2==6? "���ǰ":"��Ÿ"}</td>
		<td>�Һ����� : ${ex.type1==1? "����":ex.type1==2? "ī��":"����"}</td>
		<td>${ex.price}</td>
		<td>${ex.seldate}��   ${ex.selhour} ��  ${ex.selminute} ��</td>
	</tr>
	<tr>
		<td colspan="2"><a href="subDetailForm.pro?expenseNum=${ex.expenseNum}">${ex.title}</a></td>
		<td>�ο� : ${ex.peocnt}</td>
	</tr>
	</co:forEach>
</table>
</co:if>
</body>
</html>
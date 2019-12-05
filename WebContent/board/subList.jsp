<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="co" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>얼마썼나 볼까요?</title>
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
수정
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
	보통 form태그 안에서 input의 name과 value를 통해 url로 보내는데,
	밑에서 쓴 방법은 input과정 없이 바로 parameter에 
	mode : parameter
	all, 1, 2 : value 값
-->
<div class="divcenter">
	<button class="type1" onclick="location.href='subList.pro?travelNum=${param.travelNum}&mode=all'">모아보기</button>
	<button class="type1" onclick="location.href='subList.pro?travelNum=${param.travelNum}&mode=1'">현금</button>
	<button class="type1" onclick="location.href='subList.pro?travelNum=${param.travelNum}&mode=2'">카드</button>
	<button class="type1" onclick="location.href='subWriteForm.pro?travelNum=${param.travelNum}'">새지출</button>
</div>
<br>
<table>
	<tr>
		<td>쓴돈&nbsp;&nbsp;&nbsp;
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
		<td>남은돈&nbsp;&nbsp;&nbsp;
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
		지출내역이 없습니다
	</div>
</co:if>

<co:if test="${expcnt >0}">
<table>
	<co:forEach var="ex" items="${exlist}">
	<tr>
		<td rowspan="2" width="10%">${ex.type2==1? "식비":ex.type2==2? "쇼핑":ex.type2==3? "관광":ex.type2==4? "교통":ex.type2==5? "숙박":ex.type2==6? "기념품":"기타"}</td>
		<td>소비유형 : ${ex.type1==1? "현금":ex.type1==2? "카드":"무료"}</td>
		<td>${ex.price}</td>
		<td>${ex.seldate}일   ${ex.selhour} 시  ${ex.selminute} 분</td>
	</tr>
	<tr>
		<td colspan="2"><a href="subDetailForm.pro?expenseNum=${ex.expenseNum}">${ex.title}</a></td>
		<td>인원 : ${ex.peocnt}</td>
	</tr>
	</co:forEach>
</table>
</co:if>
</body>
</html>
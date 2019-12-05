<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>지출내역 자세히 볼까요?</title>
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
		<td>${info.seldate}일 ${info.selhour} 시 ${info.selminute} 분</td>
	</tr>
</table>
<br>
<table>
	<tr><td>${info.type2==1? "식비":info.type2==2? "쇼핑":info.type2==3? "관광":info.type2==4? "교통":info.type2==5? "숙박":info.type2==6? "기념품":"기타"}</td>
		<td>${info.type1==1? "현금":info.type1==2? "카드":"무료"}</td>
		<td>${info.price}</td>
		<td>${info.peocnt} 명</td>
	</tr>
	<tr><td colspan="4">${info.title}</td></tr>
	<tr><td colspan="4">${info.content}</td></tr>
</table>

<!-- 수정 삭제 -->
<c:if test="${info.email != sessionScope.email}">
<div class="divcenter">
	<button onclick="return goback()">돌아가기</button>
</div>
</c:if>
<c:if test="${info.email == sessionScope.email}">
<div class="divcenter">
	<button onclick="location.href='subDeleteForm.pro?expenseNum=${param.expenseNum}'">삭제</button>
	<button onclick="location.href='subUpdateForm.pro?expenseNum=${param.expenseNum}'">수정</button>
</div>
</c:if>
</body>
</html>
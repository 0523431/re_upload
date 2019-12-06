<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>따로따로</title>
<style>
td {
	background-color: #E0E3DA;
	border: 5px solid #f7f7f7;
	text-align: center;
	padding: 10px;
}
</style>
<script>
function listdo(page) { // listdo 메서드에 page값을 넣고
	document.f.pageNum.value = page; // pageNum의 value값을 바꿔주는 거야
	document.f.submit(); // form을 submit해주는 거야
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
		<td>${b.seldate}일 ${b.selhour} 시 ${b.selminute} 분</td>
	</tr>
</table>
<table>
	<tr><td>${b.type2==1? "식비":b.type2==2? "쇼핑":b.type2==3? "관광":b.type2==4? "교통":b.type2==5? "숙박":b.type2==6? "기념품":"기타"}</td>
		<td>${b.type1==1? "현금":b.type1==2? "카드":"무료"}</td>
		<td>${b.price}</td>
		<td>${b.peocnt} 명</td>
	</tr>
	<tr><td colspan="4">${b.title}</td></tr>
	<tr><td colspan="4">${b.content}</td></tr>
</table>
<br>
</c:forEach>
<!-- 페이지 넘기기 -->
<hr>
	<div class="divcenter">
		<c:if test="${pageNum <=1}">
			[이전]
		</c:if>
		<c:if test="${pageNum >1}">
				<a href="javascript:listdo(${pageNum -1})">[이전]</a>
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
			[다음]
		</c:if>
		<c:if test="${pageNum < maxpage}">
			<a href="javascript:listdo(${pageNum +1})">[다음]</a>
		</c:if>
	</div>
</form>
</body>
</html>
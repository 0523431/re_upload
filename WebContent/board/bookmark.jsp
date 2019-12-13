<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>따로따로</title>
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
		<div class="col-md-12" style="height: 100px;">
			<div class="blog-entry ftco-animate d-md-flex">
				<img class="circle-other"
					 style="margin-top:10px;margin-left: 0px;margin-right: 0px;"
					 src="${path}/member/profile/${b.profile}">
				<div class="text text-2 pl-md-4" style="margin-top:10px;padding-top: 10px;">
					<div class="meta-wrap">
					<p class="mb-4" style="margin-bottom: 0px;">
						${b.nickname}&nbsp;&nbsp;&nbsp;(${b.email})
					</p>
						<p class="meta" style="margin-bottom: 0px;">
							<i class="icon-calendar mr-2"></i>${b.seldate}일&nbsp;&nbsp;${b.selhour}시&nbsp;&nbsp;${b.selminute}분
						</p>
					</div>
				</div>
			</div>
		</div>
<table class="table-sub">
	<tr>
		<th>소비유형</th>
		<th>소비수단</th>
		<th>금액</th>
		<th>동행자</th>
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
	<%-- 페이지 --%>
	<hr>
	<div class="divcenter">
		<c:if test="${pageNum <=1}">
			◀&nbsp;&nbsp;
		</c:if>
		<c:if test="${pageNum >1}">
				<a href="javascript:listdo(${pageNum -1})">◀&nbsp;&nbsp;</a>
		</c:if>
		
		<c:forEach var="a" begin="${startpage}" end="${endpage}">
			<c:if test="${a ==pageNum}">
				${a}&nbsp;&nbsp;
			</c:if>
			<c:if test="${a !=pageNum}">
				<a href="javascript:listdo(${a})">${a}&nbsp;&nbsp;</a>
			</c:if>
		</c:forEach>

		<c:if test="${pageNum >= maxpage}">
			▶
		</c:if>
		<c:if test="${pageNum < maxpage}">
			<a href="javascript:listdo(${pageNum +1})">▶</a>
		</c:if>
	</div>
</form>
</body>
</html>
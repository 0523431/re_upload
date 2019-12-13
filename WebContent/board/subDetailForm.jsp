<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>지출내역 자세히 볼까요?</title>
<script>
function goback() {
	 history.back();  
	 return false;
}	
</script>
</head>
<body>
<input type="hidden" value="${param.expenseNum}" name="expenseNum">

<div class="title-main">
	<a href="subList.pro?travelNum=${tinfo.travelNum}">${tinfo.traveltitle}</a>
</div>
<%-- <c:if test="${info.email != sessionScope.email}"> --%>
		<div class="col-md-12" style="height: 100px;">
			<div class="blog-entry ftco-animate d-md-flex">
				<img class="circle-other"
					 style="margin-top:10px;margin-left: 0px;margin-right: 0px;"
					 src="${path}/member/profile/${info.profile}">
				<div class="text text-2 pl-md-4" style="margin-top:10px;padding-top: 10px;">
					<div class="meta-wrap">
					<p class="mb-4" style="margin-bottom: 0px;">
						${info.nickname}&nbsp;&nbsp;&nbsp;(${info.email})
					</p>
						<p class="meta" style="margin-bottom: 0px;">
							<i class="icon-calendar mr-2"></i>${info.seldate}일&nbsp;&nbsp;${info.selhour}시&nbsp;&nbsp;${info.selminute}분
						</p>
					</div>
				</div>
			</div>
		</div>
<%-- </c:if> --%>
<table class="table-sub">
	<tr>
		<th>소비유형</th>
		<th>소비수단</th>
		<th>금액</th>
		<th>동행자</th>
	<tr><td>${info.type2==1? "식비":info.type2==2? "쇼핑":info.type2==3? "관광":info.type2==4? "교통":info.type2==5? "숙박":info.type2==6? "기념품":"기타"}</td>
		<td>${info.type1==1? "현금":info.type1==2? "카드":"무료"}</td>
		<td>${info.price}</td>
		<td>${info.peocnt} 명</td>
	</tr>
	<tr><td colspan="4">${info.title}</td></tr>
	<tr><td colspan="4">${info.content}</td></tr>
</table>

<!-- 수정 삭제 -->
<br>
<div class="divcenter">
	<button class="btn-main" onclick="return goback()">Back</button>
	<button class="btn-main" onclick="location.href='subDeleteForm.pro?expenseNum=${param.expenseNum}'">Delete</button>
	<button class="btn-main" onclick="location.href='subUpdateForm.pro?expenseNum=${param.expenseNum}'">Edit</button>
</div>
</body>
</html>
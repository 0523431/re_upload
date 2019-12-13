<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="co" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<co:set var="path" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>A new journey</title>
<%-- ajax을 이용해서 사용할 예정이라서 jquery를 연결 --%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script>
	// 검색 후, 그 결과를 페이지에 유지시켜주는 메서드함수
	function listdo(page) { // listdo 메서드에 page값을 넣고
		document.f.pageNum.value = page; // pageNum의 value값을 바꿔주는 거야
		document.f.submit(); // form을 submit해주는 거야
	}
</script>
</head>
<body>
<form action="mainInfo.pro" method="post" name="f">
<input type="hidden" name="pageNum" value="1">

			<!-- 여행지 등록하기 -->
			<div class="half">
			<p style="text-align: center;">
				<a href="mainWriteForm.pro?email=${sessionScope.email}" class="btn btn-primary p-3 px-xl-4 py-xl-3">여행지 등록하기</a>
			</p>
			</div>
	    	<hr>
	    	<div class="row pt-md-4">
				<!-- 여행지 리스트 -->
				<co:forEach var="list" items="${list}">				
				<div class="col-md-12">
					<div class="blog-entry ftco-animate d-md-flex">
					<a href="subList.pro?travelNum=${list.travelNum}" class="img img-2"
					   style="background-image: url(${path}/board/background/${list.background});"></a>
					<div class="text text-2 pl-md-4">
						<h4 class="mb-4" style="margin-bottom:0px;"><a href="subList.pro?travelNum=${list.travelNum}">${list.traveltitle}</a></h4>
						<div class="meta-wrap">
							<p class="meta" style="margin-bottom:0px;"><i class="icon-calendar mr-2"></i>${list.start}&nbsp;-&nbsp;${list.end}</p>
							<p class="meta" style="margin-bottom:0px;">여행지 : ${list.country}</p>
							<p class="meta" style="margin-bottom:0px;">예산 : ${list.budget}</p>
						</div>
						<p><a href="subList.pro?travelNum=${list.travelNum}" class="btn-custom">Write more <span class="ion-ios-arrow-forward"></span></a></p>
					</div>
					</div>
				</div>
				</co:forEach>
			</div>
				<!-- END-->
	<%-- 페이지 --%>
	<hr>
	<div class="divcenter">
		<co:if test="${pageNum <=1}">
			◀&nbsp;&nbsp;
		</co:if>
		<co:if test="${pageNum >1}">
				<a href="javascript:listdo(${pageNum -1})">◀&nbsp;&nbsp;</a>
		</co:if>
		
		<co:forEach var="a" begin="${startpage}" end="${endpage}">
			<co:if test="${a ==pageNum}">
				${a}&nbsp;&nbsp;
			</co:if>
			<co:if test="${a !=pageNum}">
				<a href="javascript:listdo(${a})">${a}&nbsp;&nbsp;</a>
			</co:if>
		</co:forEach>

		<co:if test="${pageNum >= maxpage}">
			▶
		</co:if>
		<co:if test="${pageNum < maxpage}">
			<a href="javascript:listdo(${pageNum +1})">▶</a>
		</co:if>
	</div>

</form>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="co" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<co:set var="path" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>같이보자</title>
<script>
	// 검색 후, 그 결과를 페이지에 유지시켜주는 메서드함수
	function listdo(page) { // listdo 메서드에 page값을 넣고
		document.search.pageNum.value = page; // pageNum의 value값을 바꿔주는 거야
		document.search.submit(); // form을 submit해주는 거야
	}
	
	function open_book(num) {
		$.ajax("${path}/ajax/bookmarkform.pro?email=${sessionScope.email}&expenseNum="+num, {
			success : function(msg1) {
				alert(msg1);
				// 유지보수 완료 (bookmsg.jsp에서 msg1 전달받음)
			},
			error : function(e) {
				alert("서버오류 :" + e.status);
			}
		})
	}
	
	function open_comment() {
		var op = "width=400, height=150, munubar=no, top=200, left=500";
		open("bookmarkForm.pro?email=${sessionScope.email}", "window`s name",
				op);
	}
</script>
</head>
<body>
<!-- 검색 -->
<form action="otherList.pro" method="post" name="search">
	<input type="hidden" name="pageNum" value="1">
	<div class="divcenter">
		<select name="column">
			<option value="">선택하세요</option>
			<option value="country">국가</option>
			<option value="nickname">작성자</option>
			<option value="peocnt">동행인원</option>
		</select>
			<script type="text/javascript">
				document.search.column.value = "${param.column}";
			</script>
		<input type="search" name="find" value="${param.find}" style="width: 50%">
		<input type="submit" value="검색">
	</div>
</form>
	<!-- 리스트 -->
	<div class="row pt-md-4">
	<co:forEach var="list" items="${list}">
		<div class="col-md-12" style="height: 150px;">
			<div class="blog-entry ftco-animate d-md-flex">
				<img class="circle-other" style="margin-top: 20px;" src="${path}/member/profile/${list.profile}">
				<div class="text text-2 pl-md-4">
					<div class="meta-wrap">
					<p class="mb-4" style="margin-bottom: 0px;">
						${list.nickname}(${list.email})
					</p>
						<p class="meta" style="margin-bottom: 0px;">
							<i class="icon-calendar mr-2"></i>${list.seldate}일&nbsp;&nbsp;${list.selhour}시&nbsp;&nbsp;${list.selminute}분
						</p>
						<p class="meta" style="margin-bottom: 0px;">
							${list.title}
						</p>
						<input type="hidden" value="${list.expenseNum}" name="expensNum">
					</div>
					<p>
					<a href="subDetailForm.pro?expenseNum=${list.expenseNum}"
						class="btn-custom">Write more <span
						class="ion-ios-arrow-forward"></span></a>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<button class="btn-main" style="text-align:right;" onclick="javascript:open_book('${list.expenseNum}')" id="bookmark">bookmark me!</button>
					</p>
				</div>
			</div>
		</div>
	</co:forEach>
	</div>

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
</body>
</html>
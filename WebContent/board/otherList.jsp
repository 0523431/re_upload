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
<style>
td {
	background-color: #E0E3DA;
	border: 5px solid #f7f7f7;
	text-align: center;
	padding: 10px;
}
</style>
<script>
	// 검색 후, 그 결과를 페이지에 유지시켜주는 메서드함수
	function listdo(page) { // listdo 메서드에 page값을 넣고
		document.sf.pageNum.value = page; // pageNum의 value값을 바꿔주는 거야
		document.sf.submit(); // form을 submit해주는 거야
	}
	function open_book(num) {
		$.ajax("${path}/ajax/bookmarkform.pro?email=${sessionScope.email}&expenseNum="+num, {
			success : function(data) {
				alert("따로따로에 추가되었습니다");
			},
			error : function(e) {
				alert("서버오류 :" + e.status);
			}
		})
	}
	
	$("#bookmark").click(function() {
		$.ajax("${path}/ajax/bookmark.pro?email=${sessionScope.email}", {
			success : function(data) {
				alert("따로따로에 추가되었습니다");
			},
			error : function(e) {
				alert("서버오류 :" + e.status);
			}
		})
	})

	function open_comment() {
		var op = "width=400, height=150, munubar=no, top=200, left=500";
		open("bookmarkForm.pro?email=${sessionScope.email}", "window`s name",
				op);
	}
</script>
</head>
<body>

	<input type="hidden" name="pageNum" value="1">
	<!-- 검색 -->
	<form action="otherList.pro" method="post" name="search">
		<table>
			<tr>
				<td style="border-width: 0px; border-radius: 10px 10px;"><select
					name="column">
						<option value="">선택하세요</option>
						<option value="country">국가</option>
						<option value="nickname">작성자</option>
						<option value="peocnt">동행인원</option>
				</select> <script type="text/javascript">
					document.search.column.value = "${param.column}";
				</script> <input type="text" name="find" value="${param.find}"
					style="width: 50%"> <input type="submit" value="검색">
				</td>
			</tr>
		</table>
	</form>
	<!-- 리스트 -->
	<co:forEach var="list" items="${list}">
		<table>
			<tr>
				<td rowspan="2"><img class="circle-other"
					src="${path}/member/profile/${list.profile}" /></td>
				<td>${list.nickname}(${list.email})</td>
			</tr>
			<tr>
				<td>${list.seldate}일 ${list.selhour} 시 ${list.selminute}</td>
			</tr>
			<tr>
				<td colspan="2"><a
					href="subDetailForm.pro?expenseNum=${list.expenseNum}">${list.title}</a>
					<input type="hidden" value="${list.expenseNum}" name="expensNum">
				</td>
			</tr>
		</table>
		<button onclick="javascript:open_book('${list.expenseNum}')" id="bookmark">bookmark me!</button>
		<button onclick="open_comment()">comment</button>
	</co:forEach>

	<%-- 페이지 넘버 --%>
	<table>
		<tr>
			<td colspan="5"><co:if test="${pageNum <=1}">
			[이전]
		</co:if> <co:if test="${pageNum >1}">
					<%-- <a href="list.do?pageNum=${pageNum -1}">[이전]</a> --%>
					<a href="javascript:listdo(${pageNum -1})">[이전]</a>
				</co:if> <co:forEach var="a" begin="${startpage}" end="${endpage}">
					<co:if test="${a ==pageNum}">
				[${a}]
			</co:if>
					<co:if test="${a !=pageNum}">
						<%-- <a href="list.do?pageNum=${a}">[${a}]</a> --%>
						<a href="javascript:listdo(${a})">[${a}]</a>
					</co:if>
				</co:forEach> <co:if test="${pageNum >= maxpage}">
			[다음]
		</co:if> <co:if test="${pageNum < maxpage}">
					<%-- <a href="list.do?pageNum=${pageNum +1}">[다음]</a> --%>
					<a href="javascript:listdo(${pageNum +1})">[다음]</a>
				</co:if></td>
		</tr>
	</table>
</body>
</html>
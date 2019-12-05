<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="co" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<co:set var="path" value="${pageContext.request.contextPath}" />


<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>���̺���</title>
<style>
td {
	background-color: #E0E3DA;
	border: 5px solid #f7f7f7;
	text-align: center;
	padding: 10px;
}
</style>
<script>
	// �˻� ��, �� ����� �������� ���������ִ� �޼����Լ�
	function listdo(page) { // listdo �޼��忡 page���� �ְ�
		document.sf.pageNum.value = page; // pageNum�� value���� �ٲ��ִ� �ž�
		document.sf.submit(); // form�� submit���ִ� �ž�
	}
	function open_book(num) {
		$.ajax("${path}/ajax/bookmarkform.pro?email=${sessionScope.email}&expenseNum="+num, {
			success : function(data) {
				alert("���ε��ο� �߰��Ǿ����ϴ�");
			},
			error : function(e) {
				alert("�������� :" + e.status);
			}
		})
	}
	
	$("#bookmark").click(function() {
		$.ajax("${path}/ajax/bookmark.pro?email=${sessionScope.email}", {
			success : function(data) {
				alert("���ε��ο� �߰��Ǿ����ϴ�");
			},
			error : function(e) {
				alert("�������� :" + e.status);
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
	<!-- �˻� -->
	<form action="otherList.pro" method="post" name="search">
		<table>
			<tr>
				<td style="border-width: 0px; border-radius: 10px 10px;"><select
					name="column">
						<option value="">�����ϼ���</option>
						<option value="country">����</option>
						<option value="nickname">�ۼ���</option>
						<option value="peocnt">�����ο�</option>
				</select> <script type="text/javascript">
					document.search.column.value = "${param.column}";
				</script> <input type="text" name="find" value="${param.find}"
					style="width: 50%"> <input type="submit" value="�˻�">
				</td>
			</tr>
		</table>
	</form>
	<!-- ����Ʈ -->
	<co:forEach var="list" items="${list}">
		<table>
			<tr>
				<td rowspan="2"><img class="circle-other"
					src="${path}/member/profile/${list.profile}" /></td>
				<td>${list.nickname}(${list.email})</td>
			</tr>
			<tr>
				<td>${list.seldate}�� ${list.selhour} �� ${list.selminute}</td>
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

	<%-- ������ �ѹ� --%>
	<table>
		<tr>
			<td colspan="5"><co:if test="${pageNum <=1}">
			[����]
		</co:if> <co:if test="${pageNum >1}">
					<%-- <a href="list.do?pageNum=${pageNum -1}">[����]</a> --%>
					<a href="javascript:listdo(${pageNum -1})">[����]</a>
				</co:if> <co:forEach var="a" begin="${startpage}" end="${endpage}">
					<co:if test="${a ==pageNum}">
				[${a}]
			</co:if>
					<co:if test="${a !=pageNum}">
						<%-- <a href="list.do?pageNum=${a}">[${a}]</a> --%>
						<a href="javascript:listdo(${a})">[${a}]</a>
					</co:if>
				</co:forEach> <co:if test="${pageNum >= maxpage}">
			[����]
		</co:if> <co:if test="${pageNum < maxpage}">
					<%-- <a href="list.do?pageNum=${pageNum +1}">[����]</a> --%>
					<a href="javascript:listdo(${pageNum +1})">[����]</a>
				</co:if></td>
		</tr>
	</table>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>���ε���</title>
<script>
function listdo(page) { // listdo �޼��忡 page���� �ְ�
	document.f.pageNum.value = page; // pageNum�� value���� �ٲ��ִ� �ž�
	document.f.submit(); // form�� submit���ִ� �ž�
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
							<i class="icon-calendar mr-2"></i>${b.seldate}��&nbsp;&nbsp;${b.selhour}��&nbsp;&nbsp;${b.selminute}��
						</p>
					</div>
				</div>
			</div>
		</div>
<table class="table-sub">
	<tr>
		<th>�Һ�����</th>
		<th>�Һ����</th>
		<th>�ݾ�</th>
		<th>������</th>
	<tr><td>${b.type2==1? "�ĺ�":b.type2==2? "����":b.type2==3? "����":b.type2==4? "����":b.type2==5? "����":b.type2==6? "���ǰ":"��Ÿ"}</td>
		<td>${b.type1==1? "����":b.type1==2? "ī��":"����"}</td>
		<td>${b.price}</td>
		<td>${b.peocnt} ��</td>
	</tr>
	<tr><td colspan="4">${b.title}</td></tr>
	<tr><td colspan="4">${b.content}</td></tr>
</table>
<br>
</c:forEach>
	<%-- ������ --%>
	<hr>
	<div class="divcenter">
		<c:if test="${pageNum <=1}">
			��&nbsp;&nbsp;
		</c:if>
		<c:if test="${pageNum >1}">
				<a href="javascript:listdo(${pageNum -1})">��&nbsp;&nbsp;</a>
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
			��
		</c:if>
		<c:if test="${pageNum < maxpage}">
			<a href="javascript:listdo(${pageNum +1})">��</a>
		</c:if>
	</div>
</form>
</body>
</html>
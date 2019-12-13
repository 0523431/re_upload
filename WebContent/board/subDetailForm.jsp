<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>���⳻�� �ڼ��� �����?</title>
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
							<i class="icon-calendar mr-2"></i>${info.seldate}��&nbsp;&nbsp;${info.selhour}��&nbsp;&nbsp;${info.selminute}��
						</p>
					</div>
				</div>
			</div>
		</div>
<%-- </c:if> --%>
<table class="table-sub">
	<tr>
		<th>�Һ�����</th>
		<th>�Һ����</th>
		<th>�ݾ�</th>
		<th>������</th>
	<tr><td>${info.type2==1? "�ĺ�":info.type2==2? "����":info.type2==3? "����":info.type2==4? "����":info.type2==5? "����":info.type2==6? "���ǰ":"��Ÿ"}</td>
		<td>${info.type1==1? "����":info.type1==2? "ī��":"����"}</td>
		<td>${info.price}</td>
		<td>${info.peocnt} ��</td>
	</tr>
	<tr><td colspan="4">${info.title}</td></tr>
	<tr><td colspan="4">${info.content}</td></tr>
</table>

<!-- ���� ���� -->
<br>
<div class="divcenter">
	<button class="btn-main" onclick="return goback()">Back</button>
	<button class="btn-main" onclick="location.href='subDeleteForm.pro?expenseNum=${param.expenseNum}'">Delete</button>
	<button class="btn-main" onclick="location.href='subUpdateForm.pro?expenseNum=${param.expenseNum}'">Edit</button>
</div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>나를보자</title>
<script>
function goback() {
	 history.back();  
	 return false;
}
</script>
</head>
<body>
<input type="hidden" value="${param.email}" name="email">
<table>
	<tr>
		<th class="th-main">닉네임</th>
		<td class="sub">${info.nickname}</td>
	</tr>
	<tr>
		<th class="th-main">이메일</th>
		<td class="sub">${info.email}</td>
	</tr>
	<tr>
		<th class="th-main">사진</th>
		<td class="sub">
		<p style="text-align: center;">
			<img src="${path}/member/profile/${info.profile}" height="150" width="150" id="profile" style="margin:center">
			
		</p>
		</td>
	</tr>
</table>
<!-- 수정 삭제 -->
<br>
<div class="divcenter">
<!-- 	<button class="btn-main" onclick="return goback()">Back</button> -->
	<button class="btn-main" onclick="location.href='myListDeleteForm.pro?email=${param.email}'">Delete</button>
	<button class="btn-main" onclick="location.href='myListUpdateForm.pro?email=${param.email}'">Edit</button>
</div>

</body>
</html>
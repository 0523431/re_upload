<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>지출 삭제할까요?</title>
<style>
	.check {
		width:50%; height:10%;
		margin : auto;
		border: 2px solid #E0E3DA;
		padding: 20px;
		width : 275px;
		border-radius: 10px;
		-moz-border-radius: 10px;
		-webkit-border-radius: 10px;
	}
</style>
</head>
<body>
<form action="subDelete.pro" name="f" method="post">
	<input type="hidden" value="${param.expenseNum}" name="expenseNum">
	<div class="check">
	<div class="divcenter">
		비밀번호를 입력해주세요
		<hr>
		<input type="password" name="password">
		<br><br>
		<button onclick="submit()">확인</button>
	</div>
	</div>
</form>
</body>
</html>
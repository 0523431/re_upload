<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>�������� �����ұ��?</title>
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
<form action="mainDelete.pro" name="f" method="post">
	<input type="hidden" value="${param.travelNum}" name="travelNum">
	<div class="check">
	<div class="divcenter">
		��й�ȣ�� �Է����ּ���
		<hr>
		<input type="password" name="password">
		<br><br>
		<button onclick="submit()">Ȯ��</button>
	</div>
	</div>
</form>
</body>
</html>
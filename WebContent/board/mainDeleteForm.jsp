<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>�������� �����ұ��?</title>
<script>
function goback() {
	history.back();  
	return false;
}
</script>
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
		<button onclick="return goback()" class="btn-main">CANCLE</button>
		&nbsp;&nbsp;
		<button class="btn-main" onclick="submit()">OK</button>
	</div>
	</div>
</form>
</body>
</html>
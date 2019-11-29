<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>비밀번호 찾기</title>

<script type="text/javascript">
	function closePass() {
		opener.document.f.password.value = ""; // 전달안함
		opener.document.f.password.focus();
		self.close();
	}
</script>

</head>

<body>
<form name="f">
	<h3 id="password">비밀번호 **${password}</h3>
	<input type="button" value="닫기" onclick="closePass()">
</form>

</body>
</html>

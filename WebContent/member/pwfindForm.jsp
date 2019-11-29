<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>비밀번호 찾기</title>
</head>
<body style="background-color: #f7f7f7;">

<form action="pwfind.pro" name="f" method="post">
	<table>
		<caption>비밀번호 찾기</caption>
		<tr>
			<th>이메일</th>
			<td><input type="text" name="email"></td>
		</tr>
		<tr>
			<th>닉네임</th>
			<td><input type="text" name="nickname"></td>
		</tr>
		<tr>
			<td colspan="2">
				<br>
				<input type="submit" value="비밀번호찾기">
			</td>
		</tr>
	</table>
</form>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="co" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>��� ��ȣ ����</title>
<link rel="stylesheet" href="/jsp_study2/css/main.css">

<script>
	function checkinput(form) {
		if(form.new_pass.value != form.conf_pass.value) {
			alert("���� ��й�ȣ�� ���Է��� ��й�ȣ�� �ٸ��ϴ�");
			form.conf_pass.value =""; // ���� ������
			form.conf_pass.focus(); // Ŀ�� ��ġ ����
			return false;
		}
		return true;
	}
</script>

</head>
<body>

<form action="changePass.pro?email=${param.email}" name="f" method="post"
	  onsubmit="return checkinput(this)"> <%--this==form --%>
<input type="hidden" name="id" value='${login}'>
	  
<table>
	<caption>��й�ȣ ����</caption>
	<tr><th class="th-main">���� ��й�ȣ</th>
		<td class="sub"><input type="text" name="old_pass"></td></tr> <%-- db�� ���� --%>
	<tr><th class="th-main">���� ��й�ȣ</th>
		<td class="sub"><input type="text" name="new_pass"></td></tr>
	<tr><th class="th-main">���� ��й�ȣ ���Է�</th>
		<td class="sub"><input type="text" name="conf_pass"></td></tr>
	<tr><td colspan="2" class="sub"><input class="btn-main" type="submit" value="��й�ȣ ����"></td></tr>
</table>
</form>

</body>
</html>
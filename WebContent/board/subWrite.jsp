<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>���ھ���</title>
<style>
.sub {
	color : #566270;
	border: 3px solid #E0E3DA;
	padding : 10px;
}
</style>
</head>
<body>

<table>
	<tr>
		<td class="sub">
			<input type="radio" name="type1" value="1">����
			<input type="radio" name="type1" value="1">ī��
			<input type="radio" name="type1" value="1">����
		</td>
		<td class="sub">
			ȯ���ڵ�
		</td>
		<td class="sub" width="70%">
			<input type="text" name="expense">
		</td>
	</tr>
	<tr>
		<td colspan="2" class="sub" width="80%">
			<input type="radio" name="type2" value="1">�ĺ�
			<input type="radio" name="type2" value="2">����
			<input type="radio" name="type2" value="3">����
			<input type="radio" name="type2" value="4">����
			<input type="radio" name="type2" value="5">����
			<input type="radio" name="type2" value="6">���ǰ
			<input type="radio" name="type2" value="7">��Ÿ
		</td>
		<td class="sub">
			<select>
				<option value="1">1</option>
				<option value="2">2</option>
				<option value="3">3</option>
				<option value="4">4</option>
				<option value="5">��ü</option>
			</select>
		</td>
	</tr>
	<tr>
		<td class="sub">�տ��� ������ ��¥....</td>
		<td rowspan="2" colspan="2" class="sub">
			<input type="text" name="title">
		</td>
	</tr>
	<tr>
		<td class="sub">
			<select>
			<c:forEach var="i" begin="0" end="23">
				<option value="${i}">&nbsp;${i}&nbsp;</option>
			</c:forEach>
			</select>
			&nbsp;:&nbsp;
			<select>
			<c:forEach var="i" begin="0" end="59">
				<option value="${i}">&nbsp;&nbsp;${i}&nbsp;&nbsp;</option>
			</c:forEach>
			</select>
		</td>
	</tr>
	<tr><td colspan="3" class="sub">
			<textarea rows="15" name="content"></textarea>
		</td>
	</tr>
	<tr><td colspan="3" class="sub">
			<input type="text" name="map">
		</td>
	</tr>	
</table>
</body>
</html>
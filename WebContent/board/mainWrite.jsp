<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>�������� ����غ����</title>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<!-- datepicker source -->
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<script>
	$(function() {
		$("#datepicker_start").datepicker();
	});
	$(function() {
		$("#datepicker_end").datepicker();
	});
	
	var conti = {}
	var europe = []
	$(document).ready(function() {
		var euhtml ="";
		$.ajax({
			url : "${path}/ajax/code.jsp",
			success : function(data) {
				conti = JSON.parse(data);
				europe = conti.����;
				$.each(europe, function(index, item) {
					var country = item.country;
					euhtml += "<option>"+country+"</option>";
				})
				console.log(euhtml)
				$("#country").html(euhtml);
			},
			eooro : function(e) {
				alert("�������� : " + e.satus);
			}
		})
	})
	
	function selectcon(op) { // op:������ ���
		console.log(op.value);
		html ="";
		var contis = conti[op.value];
		$.each(contis, function(index, item) {
			var country = item.country;
			html += "<option>"+country+"</option>";
		})
		console.log(html)
		$("#country").html(html);
	}
	
	function win_upload() {
		var op = "width=400, height=150, munubar=no, top=200, left=500";
		open("pictureForm.pro","window`s name",op);
		return false;
	}
	
	function checkToSave() {
		f = document.f;
		f.submit();
	}
</script>
<style>

</style>
</head>
<body>
<form name="f" action="mainWrite.pro" method="post">
<div class="mainTitle">
	A new journey
</div>
<div class="divcenter">
	<img src="" height="150" width="200" id="picture">
	<br><br>
	<button onclick="return win_upload()" class="save">
		Ŀ���������
	</button>
</div>
<hr>
<table>
	<tr>
		<th colspan="2">����</th>
		<td><input type="text" name="traveltitle"></td>
	</tr>
	<tr>
		<th colspan="2">������</th>
		<td>
			<select name="conti" id="con" onchange="selectcon(this)">
				<option>����</option>
				<option>�ƽþ�</option>
				<option>�ϾƸ޸�ī</option>
				<option>���Ƹ޸�ī</option>
				<option>�����ƴϾ�</option>
				<option>������ī</option>
			</select>
			<select name="country" id="country">
			</select>
		</td>
	</tr>
	<tr><th rowspan="2">�Ⱓ</th>
		<td>Start</td>
		<td class="datepicker">
			<input type="text" id="datepicker_start" name="start">
		</td>
	</tr>
	<tr>
		<td>End</td>
		<td class="datepicker">
			<input type="text" id="datepicker_end" name="end">
		</td>
	</tr>
	<tr>
		<th colspan="2">ȯ��</th>
		<td><input type="text" name="currency"></td>
	</tr>
	<tr>
		<th colspan="2">����</th>
		<td><input type="text" name="budget"></td>
	</tr>
	<tr>
		<td colspan="2" class=""></td>
		<td>
			<button onclick="mainList.jsp" class="cancle">CANCLE</button>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<button onclick="checkToSave()" class="save">SAVE</button>
		</td>
</table>
</form>

<div id="confirm">
</div>
</body>
</html>
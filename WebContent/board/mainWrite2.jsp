<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>�������� ����غ����</title>
<link rel="stylesheet" href="/resources/demos/style.css">
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
		$.ajax({
			url : "code.jsp",
			success : function(data) {
				conti = JSON.parse(data);
				europe = conti.����;
				$.each(europe, function(index, item) {
					var country = item.country;
					euhtml += "<option>"+country+"</option>";
				})
				console.log(euhtml)
				$("#country").html(euhtml);
			}
		})
	})
	function selectcon(op) {
		console.log(op.value);
		
//		if(op.value=='�ƽþ�') {
	       ashtml ="";
		   var asia = conti[op.value];
		   $.each(asia, function(index, item) {
			  var country = item.country;
			   ashtml += "<option>"+country+"</option>";
		   })
		  console.log(ashtml)
 		  $("#country").html(ashtml);
//		}
		/* 		var north = conti.�ϾƸ޸�ī;
		$.each(north, function(index, item) {
			var country = item.country;
			nahtml += "<option>"+country+"</option>";
		})
		$("#country").append(nahtml);
		
		var south = conti.���Ƹ޸�ī;
		$.each(south, function(index, item) {
			var country = item.country;
			sahtml += "<option>"+country+"</option>";
		})
		console.log(sahtml)
		$("#country").append(sahtml);
		
		var africa = conti.������ī;
		$.each(africa, function(index, item) {
			var country = item.country;
			afhtml += "<option>"+country+"</option>";
		})
		console.log(afhtml)
		$("#country").append(afhtml);
		
		var oceania = conti.�����ƴϾ�;
		$.each(oceania, function(index, item) {
			var country = item.country;
			ochtml += "<option>"+country+"</option>";
		})
		console.log(ochtml)
		$("#country").append(ochtml);
 */		

	}
	
</script>
<style>
	.save .cancle {
		align: left;
		background-color:transparent;
		border-radius:10px;
		border:1px solid #566270;
		display:inline-block;
		cursor:pointer;
		color:#566270;
		font-family:Arial;
		font-size:16px;
		padding:15px 15px;
		text-decoration:none;
	}
	.save:hover{
		background-color: #566270;
		color:#FFFFF3
	}
	.cancle:hover {
		background-color: #566270;
		color:#FFFFF3
	}
</style>
</head>
<body>
<form name="mainF" action="writeMain.pro">
<div class="mainTitle">
	A new journey
</div>
<table>
	<tr>
		<th colspan="2">����</th>
		<td><input type="text" name="traveltitle"></td>
	</tr>
	<tr>
		<th colspan="2">������</th>
		<td>
			<select name="" id="con" onchange="selectcon(this)">
				<option>����</option>
				<option>�ƽþ�</option>
				<option>�ϾƸ޸�ī</option>
				<option>���Ƹ޸�ī</option>
				<option>�����ƴϾ�</option>
				<option>������ī</option>
			</select>
			<select name="" id="country">

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
		<th colspan="2"><label for="budget">����</label></th>
		<td><input type="text" name="budget"></td>
	</tr>
	<tr>
		<td colspan="2" class=""></td>
		<td>
			<button onclick="check()" class="cancle">CANCLE</button>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<button onclick="check()" class="save">SAVE</button>
		</td>
</table>
</form>

<div id="confirm">
</div>
</body>
</html>
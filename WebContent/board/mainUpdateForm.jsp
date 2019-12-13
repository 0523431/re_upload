<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>�������� �����غ����?</title>
<!-- datepicker source -->
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<script>
$(document).ready(function () {
	$("#startDate").datepicker({
		dateFormat: "yy-mm-dd", // ��¥�� ����
		minDate: -365, // 0 : ������=����
		nextText: ">",
		prevText: "<",
		onSelect: function (date) {
			var endDate = $('#endDate');
			var startDate = $(this).datepicker('getDate');
			var minDate = $(this).datepicker('getDate');
			endDate.datepicker('setDate', minDate);
			startDate.setDate(startDate.getDate() + 100);
			endDate.datepicker('option', 'maxDate', startDate);
			endDate.datepicker('option', 'minDate', minDate);
		}
	});
	$('#endDate').datepicker({
		dateFormat: "yy-mm-dd", // ��¥�� ����
		nextText: ">",
		prevText: "<"
	});
});
	
	var conti = {}
	var europe = []
	$(document).ready(function() {
		var euhtml ="";
		$.ajax({
			url : "${path}/ajax/code.jsp",
			success : function(data) {
				conti = JSON.parse(data); // ��ü
				europe = conti.����; // �迭
				$.each(europe, function(index, item) {
					var country = item.country;
					euhtml += "<option>"+country+"</option>";
				})
				console.log(euhtml)
				$("#country").html(euhtml);
			},
			error : function(e) {
				alert("�������� : " + e.satus);
			}
		})
	})
	
	function selectcon(op) { // op:������ ���
		console.log(op.value);
		html ="";
		var contis = conti[op.value]; // �迭
		$.each(contis, function(index, item) {
			var country = item.country;
			html += "<option>"+country+"</option>";
		})
		console.log(html)
		$("#country").html(html);
	}
	
	function checkToSave() {
		f = document.f;
		var checkcurrency = $('#currency').val();
		if (isNaN(checkcurrency)) { // ����:false
			alert("ȯ���� ���ڸ� �Է����ּ���");
			f.currency.focus();
			return false;
		}
		var checkbudget = $('#budget').val();
		if (isNaN(checkbudget)) { // ����:false
			alert("���� ���ڸ� �Է����ּ���");
			f.budget.focus();
			return false;
		}
		f.submit();
	}
	function goback() {
		history.back();  
		return false;
	}
	function gotodelete() {
		location.href="mainDeleteForm.pro?travelNum=${param.travelNum}";
		return false;
	}
	function file_delete() { // ÷�������� ������, �����ϴ� �޼���
		document.f.background_up.value =""; // hidden���� ���ؼ� db�� ������ ���� (file�� db���踦 ����)
		file_desc.style.display ="none"; // display="none" ===> �������ʰ� ����
	}
</script>
</head>
<body>

<form name="f" action="mainUpdate.pro" method="post" enctype="multipart/form-data">
<input type="hidden" value="${param.travelNum}" name="travelNum">
<input type="hidden" value="${sessionScope.email}" name="email">
<input type="hidden" name="background_up" value="${info.background}">
<div class="title-main">
	A new journey
</div>
<hr>
<table>
	<tr>
		<th class="th-main" colspan="2">����</th>
		<td class="td-main"><input type="text" name="traveltitle" value="${info.traveltitle}" autocomplete="off"></td>
	</tr>
	<tr>
		<th class="th-main" colspan="2">������</th>
		<td class="td-main">
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
	<tr><th class="th-main" rowspan="2">�Ⱓ</th>
		<td class="td-main">Start</td>
		<td class="td-main" class="datepicker">
			<input type="text" id="startDate" name="start" autocomplete="off"
					onfocus="if(this.value =='${info.start}') this.value='';"
					onblur="if(this.value =='') this.value='${info.start}';"
					value="${info.start}">
		</td>
	</tr>
	<tr>
		<td class="td-main">End</td>
		<td class="td-main" class="datepicker">
			<input type="text" id="endDate" name="end" autocomplete="off"
					onfocus="if(this.value =='${info.end}') this.value='';"
					onblur="if(this.value =='') this.value='${info.end}';"
					value="${info.end}">
		</td>
	</tr>
	<tr>
		<th class="th-main" colspan="2">ȯ��</th>
		<td class="td-main"><input type="text" id="currency" name="currency" autocomplete="off"
			 onfocus="if(this.value =='${info.currency}') this.value='';"
			 onblur="if(this.value =='') this.value='${info.currency}';"
			 value="${info.currency}"></td>
	</tr>
	<tr>
		<th class="th-main" colspan="2">����</th>
		<td class="td-main"><input type="text" id="budget" name="budget" autocomplete="off"
			 onfocus="if(this.value =='${info.budget}') this.value='';"
			 onblur="if(this.value =='') this.value='${info.budget}';"
			 value="${info.budget}"></td>
	</tr>
	<tr>
		<th class="th-main" colspan="2">Ŀ������</th>
		<td class="td-main">
			<c:if test="${!empty info.background}">
				<div id="file_desc">
					${info.background}
					<a href="javascript:file_delete()">[Ŀ������ ����]</a>
				</div>
			</c:if>
			<input type="file" name="background"></td>
	</tr>
</table>
<!-- update submit -->
<br><br>
<div style="text-align:right">
	<button onclick="return goback()" class="btn-main">CANCLE</button>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<button onclick="return checkToSave()" class="btn-main">SAVE</button>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<button onclick="return gotodelete()" class="btn-main">Delete</button>
</div>
</form>

</body>
</html>
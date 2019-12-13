<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>�������� ����غ����?</title>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<!-- datepicker source -->
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<script type="text/javascript">
$(document).ready(function () {
	$("#startDate").datepicker({
		dateFormat: "yy-mm-dd", // ��¥�� ����
		minDate: -365,
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
		html = "";
		html2 = "";
		var contis = conti[op.value];
		$.each(contis, function(index, item) {
			var country = item.country;
			html += "<option>"+country+"</option>";
			html2 += code;
		})
		console.log(html)
		$("#country").html(html);
		//$("#code").html(html2);
	}

	function checkToSave() {
		f = document.f;
		if(f.traveltitle.value =="") {
			alert("���� ������ �Է��ϼ���");
			f.traveltitle.focus();
			return false;
		}
		if(f.start.value =="") {
			alert("���������� �����ϼ���");
			f.traveltitle.focus();
			return false;
		}
		if(f.end.value =="") {
			alert("���������� �����ϼ���");
			f.traveltitle.focus();
			return false;
		}
		if(f.currency.value =="") {
			alert("ȯ���� �Է��ϼ���");
			f.currency.focus();
			return false;
		}
		if(f.budget.value =="") {
			alert("������ �Է��ϼ���");
			f.budget.focus();
			return false;
		}
		f.submit();
	}
	function goback() {
		history.back();  
		return false;
	}	
</script>
</head>

<body>
<form name="f" action="mainWrite.pro" method="post" enctype="multipart/form-data">
<input type="hidden" value="${sessionScope.email}" name="email">
<div class="title-main">
	A new journey
</div>
<hr>
<table>
	<tr>
		<th class="th-main" colspan="2">����</th>
		<td class="sub"><input type="text" name="traveltitle" autocomplete="off"></td>
	</tr>
	<tr>
		<th class="th-main" colspan="2">������</th>
		<td class="sub">
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
			<div id="code"></div>
		</td>
	</tr>
	<tr><th class="th-main" rowspan="2" nowrap>�Ⱓ</th>
		<td class="sub" style="text-align:right;">Start</td>
		<td class="sub">
			<input type="text" id="startDate" name="start" autocomplete="off"
					onfocus="if(this.value =='�������� �������ּ���') this.value='';"
					onblur="if(this.value =='') this.value='�������� �������ּ���';"
					value="�������� �������ּ���">
		</td>
	</tr>
	<tr>
		<td class="sub" style="text-align:right;">End</td>
		<td class="sub">
			<input type="text" id="endDate" name="end" autocomplete="off"
					onfocus="if(this.value =='���������� �������ּ���') this.value='';"
					onblur="if(this.value =='') this.value='���������� �������ּ���';"
					value="���������� �������ּ���">
		</td>
	</tr>
	<tr>
		<th class="th-main" colspan="2">ȯ��</th>
		<td class="sub"><input type="text" name="currency" autocomplete="off"
			 onfocus="if(this.value =='ȯ�� ���� ȯ�� (���ڸ��Է��ϼ���)') this.value='';"
			 onblur="if(this.value =='') this.value='ȯ�� ���� ȯ�� (���ڸ��Է��ϼ���)';"
			 value="ȯ�� ���� ȯ�� (���ڸ��Է��ϼ���)"
			 ></td>
	</tr>
	<tr>
		<th class="th-main" colspan="2">����</th>
		<td class="sub"><input type="text" name="budget" autocomplete="off"
			 onfocus="if(this.value =='���� ������ ���Դϱ�? (���ڸ��Է��ϼ���)') this.value='';"
			 onblur="if(this.value =='') this.value='���� ������ ���Դϱ�? (���ڸ��Է��ϼ���)';"
			 value="���� ������ ���Դϱ�? (���ڸ��Է��ϼ���)"></td>
	</tr>
	<tr>
		<th class="th-main" colspan="2">Ŀ������</th>
		<td class="sub"><input type="file" name="background"></td>
	</tr>
</table>
<br><br>
<div style="text-align:right">
	<button onclick="return goback()" class="btn-main">CANCLE</button>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<button onclick="return checkToSave()" class="btn-main">SAVE</button>
</div>
</form>

</body>
</html>
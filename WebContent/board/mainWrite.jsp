<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>여행지를 등록해볼까요?</title>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<!-- datepicker source -->
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<script type="text/javascript">
$(document).ready(function () {
	$("#startDate").datepicker({
		dateFormat: "yy-mm-dd", // 날짜의 형식
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
		dateFormat: "yy-mm-dd", // 날짜의 형식
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
				europe = conti.유럽;
				$.each(europe, function(index, item) {
					var country = item.country;
					euhtml += "<option>"+country+"</option>";
				})
				console.log(euhtml)
				$("#country").html(euhtml);
			},
			eooro : function(e) {
				alert("서버오류 : " + e.satus);
			}
		})
	})
	
	function selectcon(op) { // op:선택한 대륙
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
			alert("여행 제목을 입력하세요");
			f.traveltitle.focus();
			return false;
		}
		if(f.start.value =="") {
			alert("여행일정을 선택하세요");
			f.traveltitle.focus();
			return false;
		}
		if(f.end.value =="") {
			alert("여행일정을 선택하세요");
			f.traveltitle.focus();
			return false;
		}
		if(f.currency.value =="") {
			alert("환율을 입력하세요");
			f.currency.focus();
			return false;
		}
		if(f.budget.value =="") {
			alert("예산을 입력하세요");
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
		<th class="th-main" colspan="2">제목</th>
		<td class="sub"><input type="text" name="traveltitle" autocomplete="off"></td>
	</tr>
	<tr>
		<th class="th-main" colspan="2">여행지</th>
		<td class="sub">
			<select name="conti" id="con" onchange="selectcon(this)">
				<option>유럽</option>
				<option>아시아</option>
				<option>북아메리카</option>
				<option>남아메리카</option>
				<option>오세아니아</option>
				<option>아프리카</option>
			</select>
			<select name="country" id="country">
			</select>
			<div id="code"></div>
		</td>
	</tr>
	<tr><th class="th-main" rowspan="2" nowrap>기간</th>
		<td class="sub" style="text-align:right;">Start</td>
		<td class="sub">
			<input type="text" id="startDate" name="start" autocomplete="off"
					onfocus="if(this.value =='시작일을 선택해주세요') this.value='';"
					onblur="if(this.value =='') this.value='시작일을 선택해주세요';"
					value="시작일을 선택해주세요">
		</td>
	</tr>
	<tr>
		<td class="sub" style="text-align:right;">End</td>
		<td class="sub">
			<input type="text" id="endDate" name="end" autocomplete="off"
					onfocus="if(this.value =='마지막날을 선택해주세요') this.value='';"
					onblur="if(this.value =='') this.value='마지막날을 선택해주세요';"
					value="마지막날을 선택해주세요">
		</td>
	</tr>
	<tr>
		<th class="th-main" colspan="2">환율</th>
		<td class="sub"><input type="text" name="currency" autocomplete="off"
			 onfocus="if(this.value =='환전 당일 환율 (숫자만입력하세요)') this.value='';"
			 onblur="if(this.value =='') this.value='환전 당일 환율 (숫자만입력하세요)';"
			 value="환전 당일 환율 (숫자만입력하세요)"
			 ></td>
	</tr>
	<tr>
		<th class="th-main" colspan="2">예산</th>
		<td class="sub"><input type="text" name="budget" autocomplete="off"
			 onfocus="if(this.value =='여행 예산은 얼마입니까? (숫자만입력하세요)') this.value='';"
			 onblur="if(this.value =='') this.value='여행 예산은 얼마입니까? (숫자만입력하세요)';"
			 value="여행 예산은 얼마입니까? (숫자만입력하세요)"></td>
	</tr>
	<tr>
		<th class="th-main" colspan="2">커버사진</th>
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
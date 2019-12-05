<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>여행지를 수정해볼까요?</title>
<!-- datepicker source -->
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<script>
$(document).ready(function () {
	$("#startDate").datepicker({
		dateFormat: "yy-mm-dd", // 날짜의 형식
		minDate: 0,
		nextText: ">",
		prevText: "<",
		onSelect: function (date) {
			var endDate = $('#endDate');
			var startDate = $(this).datepicker('getDate');
			var minDate = $(this).datepicker('getDate');
			endDate.datepicker('setDate', minDate);
			startDate.setDate(startDate.getDate() + 30);
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
				conti = JSON.parse(data); // 객체
				europe = conti.유럽; // 배열
				$.each(europe, function(index, item) {
					var country = item.country;
					euhtml += "<option>"+country+"</option>";
				})
				console.log(euhtml)
				$("#country").html(euhtml);
			},
			error : function(e) {
				alert("서버오류 : " + e.satus);
			}
		})
	})
	
	function selectcon(op) { // op:선택한 대륙
		console.log(op.value);
		html ="";
		var contis = conti[op.value]; // 배열
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
		if (isNaN(checkcurrency)) { // 숫자:false
			alert("환율은 숫자만 입력해주세요");
			f.currency.focus();
			return false;
		}
		var checkbudget = $('#budget').val();
		if (isNaN(checkbudget)) { // 숫자:false
			alert("예산 숫자만 입력해주세요");
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
</script>
</head>
<body>

<form name="f" action="mainUpdate.pro" method="post">
	<input type="hidden" value="${param.travelNum}" name="travelNum">
	<input type="hidden" value="${sessionScope.email}" name="email">

	<div class="mainTitle">
		등록한 여행지 수정
	</div>
<hr>
<table>
	<tr>
		<th colspan="2">제목</th>
		<td><input type="text" name="traveltitle" value="${info.traveltitle}" autocomplete="off"></td>
	</tr>
	<tr>
		<th colspan="2">여행지</th>
		<td>
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
		</td>
	</tr>
	<tr><th rowspan="2">기간</th>
		<td>Start</td>
		<td class="datepicker">
			<input type="text" id="startDate" name="start" autocomplete="off"
					onfocus="if(this.value =='${info.start}') this.value='';"
					onblur="if(this.value =='') this.value='${info.start}';"
					value="${info.start}">
		</td>
	</tr>
	<tr>
		<td>End</td>
		<td class="datepicker">
			<input type="text" id="endDate" name="end" autocomplete="off"
					onfocus="if(this.value =='${info.end}') this.value='';"
					onblur="if(this.value =='') this.value='${info.end}';"
					value="${info.end}">
		</td>
	</tr>
	<tr>
		<th colspan="2">환율</th>
		<td><input type="text" id="currency" name="currency" autocomplete="off"
			 onfocus="if(this.value =='${info.currency}') this.value='';"
			 onblur="if(this.value =='') this.value='${info.currency}';"
			 value="${info.currency}"></td>
	</tr>
	<tr>
		<th colspan="2">예산</th>
		<td><input type="text" id="budget" name="budget" autocomplete="off"
			 onfocus="if(this.value =='${info.budget}') this.value='';"
			 onblur="if(this.value =='') this.value='${info.budget}';"
			 value="${info.budget}"></td>
	</tr>
	<tr>
		<td colspan="2" class="sub"></td>
		<td>
			<button onclick="return goback()" class="cancle">취소</button>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<button onclick="return checkToSave()" class="save">저장</button>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<button onclick="return gotodelete()" class="save">삭제</button>
			
		</td>
</table>
</form>

<div id="confirm">
</div>
</body>
</html>
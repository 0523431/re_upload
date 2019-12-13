<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>지출 수정하기</title>
<script>
	function checkToSave() {
		var checkprice = $('#price').val();
		if (isNaN(checkprice) || checkprice =='') { // 숫자:false
			alert("지출 금액은 숫자만 입력해주세요");
			f.price.focus();
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
<form action="subUpdate.pro" name="f" method="post">
<input type="hidden" value="${param.expenseNum}" name="expenseNum">
<input type="hidden" value="${info.travelNum}" name="travelNum">
<input type="hidden" value="${info.email}" name="email">

<table>
	<tr>
		<td class="th-sub" width="20%">소비수단</td>
		<td class="sub" width="30%">
			<input type="radio" name="type1" value="1" ${info.type1==1? "checked":"" }>현금&nbsp;&nbsp;
			<input type="radio" name="type1" value="2" ${info.type1==2? "checked":"" }>카드&nbsp;&nbsp;
			<br><input type="radio" name="type1" value="3" ${info.type1==3? "checked":"" }>무료&nbsp;&nbsp;
		</td>
		<td class="th-sub" width="20%">
			사용금액
		</td>
		<td class="sub" width="30%">
			<input type="text" name="price" id="price" autocomplete="off"
					placeholder="숫자만 입력하세요" value="${info.price}">
		</td>
	</tr>
</table>
<br>
<table>
	<tr>
		<td class="th-sub" width="15%">소비유형</td>
		<td colspan="2" class="sub" width="60%">
			<input type="radio" name="type2" value="1" ${info.type2==1? "checked":"" }>식비&nbsp;&nbsp;
			<input type="radio" name="type2" value="2" ${info.type2==2? "checked":"" }>쇼핑&nbsp;&nbsp;
			<input type="radio" name="type2" value="3" ${info.type2==3? "checked":"" }>관광&nbsp;&nbsp;
			<br>
			<input type="radio" name="type2" value="4" ${info.type2==4? "checked":"" }>교통&nbsp;&nbsp;
			<input type="radio" name="type2" value="5" ${info.type2==5? "checked":"" }>숙박&nbsp;&nbsp;
			<input type="radio" name="type2" value="6" ${info.type2==6? "checked":"" }>선물&nbsp;&nbsp;
			<input type="radio" name="type2" value="7" ${info.type2==7? "checked":"" }>기타
		</td>
		<td class="th-sub" width="15%">동행자 수</td>
		<td class="sub">
			<select name="peocnt" onchange="selectpeo(this)">
				<option value="1" ${info.peocnt==1? "selected":""}>1</option>
				<option value="2" ${info.peocnt==2? "selected":""}>2</option>
				<option value="3" ${info.peocnt==3? "selected":""}>3</option>
				<option value="4" ${info.peocnt==4? "selected":""}>4</option>
				<option value="5" ${info.peocnt==5? "selected":""}>단체</option>
			</select>
		</td>
	</tr>
</table>
<br>
<table>
	<tr>
		<td class="th-sub">&nbsp;&nbsp;날짜&nbsp;&nbsp;</td>
		<td class="sub">
			<select name="seldate" id="seldate" onchange="selectdate(this)">
				<c:forEach var="date" begin="${fn:substring(info_period.start,8,10)}" end="${fn:substring(info_period.end,8,10)}" >
 					<option value="${date}" ${(info.seldate==date)? "selected":""}>&nbsp;&nbsp;&nbsp;&nbsp;${date}&nbsp;&nbsp;&nbsp;&nbsp;</option>
				</c:forEach>
			</select>
		</td>
		<td rowspan="2" colspan="2" class="sub">
			<input type="text" name="title" autocomplete="off" value="${info.title}">
		</td>
	</tr>
	<tr>
		<td class="th-sub">시간</td>
		<td class="sub">
			<select name="selhour" id="selhour">
			<c:forEach var="i" begin="0" end="23">
				<option value="${i}" ${(info.selhour==i)? "selected":""}>&nbsp;${i}&nbsp;</option>
			</c:forEach>
			</select>
			&nbsp;:&nbsp;
			<select name="selminute" id="selminute">
			<c:forEach var="i" begin="0" end="59">
				<option value="${i}" ${(info.selminute==i)? "selected":""}>&nbsp;&nbsp;${i}&nbsp;&nbsp;</option>
			</c:forEach>
			</select>
		</td>
	</tr>
	<tr><td colspan="3" class="sub">
			<textarea rows="8" name="content" id="content1" autocomplete="off">${info.content}</textarea>
			<script>
				CKEDITOR.replace("content1", {filebrowserImageUploadUrl : "imgupload.pro"});
			</script>
		</td>
	</tr>
</table>

<!-- 수정 완료 / 취소 -->
<div class="divcenter">
	<button class="btn-main" onclick="return goback()">cancle</button>&nbsp;&nbsp;&nbsp;
	<button class="btn-main" onclick="return checkToSave()">save</button>
</div>

</form>
</body>

</html>
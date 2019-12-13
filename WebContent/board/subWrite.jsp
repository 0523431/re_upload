<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>쓰자쓰자</title>
<script>
	function checkToSave() {
	 	if(f.type1.value =="") {
			alert("현금? 카드? 무료? 선택해주세요");
			//f.type1.focus();
			return false;
		}
	 	var checkprice = $('#price').val();
	 	if(isNaN(checkprice)) { // 숫자:false
			alert("지출 금액은 숫자만 입력해주세요");
			f.price.focus();
			return false;
		}
	 	if(f.type2.value =="") {
			alert("어떤 유형에 지출했는지 선택해주세요");
			f.type1.focus();
			return false;
		}
	 	if(f.type1.value =="") {
			alert("현금? 카드? 무료? 선택해주세요");
			f.type2.focus();
			return false;
		}
	 	if(f.peocnt.value =="") {
			alert("함께 동행한 인원을 선택해주세요");
			f.peocnt.focus();
			return false;
		}
	 	if(f.type1.value =="") {
			alert("현금? 카드? 무료? 선택해주세요");
			f.type1.focus();
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

<form name="f" method="post" action="subWrite.pro">
<input type="hidden" value="${sessionScope.email}" name="email">
<input type="hidden" value="${param.travelNum}" name="travelNum">

<table>
	<tr>
		<td class="th-sub" width="20%">소비수단</td>
		<td class="sub" width="30%">
			<input type="radio" name="type1" value="1">현금&nbsp;&nbsp;
			<input type="radio" name="type1" value="2">카드&nbsp;&nbsp;
			<br><input type="radio" name="type1" value="3">무료&nbsp;&nbsp;
		</td>
		<td class="th-sub" width="20%">
			사용금액
		</td>
		<td class="sub" width="30%">
			<input type="text" name="price" id="price" autocomplete="off"
					onfocus="if(this.value =='숫자만 입력하세요') this.value='';"
					onblur="if(this.value =='') this.value='숫자만 입력하세요';"
					value="숫자만 입력하세요">
		</td>
	</tr>
</table>
<br>
<table>
	<tr>
		<td class="th-sub" width="15%">소비유형</td>
		<td colspan="2" class="sub" width="60%">
			<input type="radio" name="type2" value="1">식비&nbsp;&nbsp;
			<input type="radio" name="type2" value="2">쇼핑&nbsp;&nbsp;
			<input type="radio" name="type2" value="3">관광&nbsp;&nbsp;
			<br>
			<input type="radio" name="type2" value="4">교통&nbsp;&nbsp;
			<input type="radio" name="type2" value="5">숙박&nbsp;&nbsp;
			<input type="radio" name="type2" value="6">선물&nbsp;&nbsp;
			<input type="radio" name="type2" value="7">기타
		</td>
		<td class="th-sub" width="15%">동행자 수</td>
		<td class="sub">
			<select name="peocnt" onchange="selectpeo(this)">
				<option value="1">1</option>
				<option value="2">2</option>
				<option value="3">3</option>
				<option value="4">4</option>
				<option value="5">단체</option>
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
				<c:forEach var="date" begin="${fn:substring(info.start,8,10)}" end="${fn:substring(info.end,8,10)}" >
 					<option value="${date}" id="seldate">&nbsp;&nbsp;&nbsp;&nbsp;${date}&nbsp;&nbsp;&nbsp;&nbsp;</option>
				</c:forEach>
			</select>
			<input type="hidden" id="seldate3" value="">
		</td>
		<td rowspan="2" colspan="2" class="sub">
			<input type="text" name="title" autocomplete="off"
					onfocus="if(this.value =='제목을 입력해주세요') this.value='';"
					onblur="if(this.value =='') this.value='제목을 입력해주세요';"
					value="제목을 입력해주세요">
		</td>
	</tr>
	<tr>
		<td class="th-sub">시간</td>
		<td class="sub">
			<select name="selhour" id="selhour" onchange="selecthour(this)">
			<c:forEach var="i" begin="0" end="23">
				<option value="${i}">&nbsp;${i}&nbsp;</option>
			</c:forEach>
			</select>
			&nbsp;시&nbsp;
			<select name="selminute" id="selminute" onchange="selectminute(this)">
			<c:forEach var="i" begin="0" end="59">
				<option value="${i}">&nbsp;&nbsp;${i}&nbsp;&nbsp;</option>
			</c:forEach>
			</select>&nbsp;분
			<input type="hidden" name="realtime" value="new Date()">
		</td>
	</tr>
	<tr><td colspan="3" class="sub">
			<textarea class="sub" rows="8" name="content" id="content1" autocomplete="off"></textarea>
			<script>
				<%-- 이 기능을 쓰면 내용에 이미지를 올릴 수 있음
					  이미지 업로드용 url : filebrowserImageUploadUrl => 업로드 탭이 만들어짐
					  
					 imgupload.do : 업로드를 위한 url을 지정해줌
					 
					 -------------------------------------
					 업로드 탭에서 이미지 선택하고 업로드 버튼을 누르면 CKEDITOR가 imgupload.do를 실행시킴
					 그러면 method.properties에서 imgupload 메서드로 연결 시키고
				--%>
				CKEDITOR.replace("content1", {filebrowserImageUploadUrl : "imgupload.pro"});
			</script>
		</td>
	</tr>
	<!-- <tr><td colspan="3" class="sub">
			<input type="text" name="map">
		</td>
	</tr> -->
</table>
<br>
<div class="divcenter">
	<button onclick="return goback()" class="btn-main">CANCLE</button>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<button onclick="return checkToSave()" class="btn-main">SAVE</button>

</div>
</form>

</body>
</html>
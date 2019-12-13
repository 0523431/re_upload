<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>���ھ���</title>
<script>
	function checkToSave() {
	 	if(f.type1.value =="") {
			alert("����? ī��? ����? �������ּ���");
			//f.type1.focus();
			return false;
		}
	 	var checkprice = $('#price').val();
	 	if(isNaN(checkprice)) { // ����:false
			alert("���� �ݾ��� ���ڸ� �Է����ּ���");
			f.price.focus();
			return false;
		}
	 	if(f.type2.value =="") {
			alert("� ������ �����ߴ��� �������ּ���");
			f.type1.focus();
			return false;
		}
	 	if(f.type1.value =="") {
			alert("����? ī��? ����? �������ּ���");
			f.type2.focus();
			return false;
		}
	 	if(f.peocnt.value =="") {
			alert("�Բ� ������ �ο��� �������ּ���");
			f.peocnt.focus();
			return false;
		}
	 	if(f.type1.value =="") {
			alert("����? ī��? ����? �������ּ���");
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
		<td class="th-sub" width="20%">�Һ����</td>
		<td class="sub" width="30%">
			<input type="radio" name="type1" value="1">����&nbsp;&nbsp;
			<input type="radio" name="type1" value="2">ī��&nbsp;&nbsp;
			<br><input type="radio" name="type1" value="3">����&nbsp;&nbsp;
		</td>
		<td class="th-sub" width="20%">
			���ݾ�
		</td>
		<td class="sub" width="30%">
			<input type="text" name="price" id="price" autocomplete="off"
					onfocus="if(this.value =='���ڸ� �Է��ϼ���') this.value='';"
					onblur="if(this.value =='') this.value='���ڸ� �Է��ϼ���';"
					value="���ڸ� �Է��ϼ���">
		</td>
	</tr>
</table>
<br>
<table>
	<tr>
		<td class="th-sub" width="15%">�Һ�����</td>
		<td colspan="2" class="sub" width="60%">
			<input type="radio" name="type2" value="1">�ĺ�&nbsp;&nbsp;
			<input type="radio" name="type2" value="2">����&nbsp;&nbsp;
			<input type="radio" name="type2" value="3">����&nbsp;&nbsp;
			<br>
			<input type="radio" name="type2" value="4">����&nbsp;&nbsp;
			<input type="radio" name="type2" value="5">����&nbsp;&nbsp;
			<input type="radio" name="type2" value="6">����&nbsp;&nbsp;
			<input type="radio" name="type2" value="7">��Ÿ
		</td>
		<td class="th-sub" width="15%">������ ��</td>
		<td class="sub">
			<select name="peocnt" onchange="selectpeo(this)">
				<option value="1">1</option>
				<option value="2">2</option>
				<option value="3">3</option>
				<option value="4">4</option>
				<option value="5">��ü</option>
			</select>
		</td>
	</tr>
</table>
<br>
<table>
	<tr>
		<td class="th-sub">&nbsp;&nbsp;��¥&nbsp;&nbsp;</td>
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
					onfocus="if(this.value =='������ �Է����ּ���') this.value='';"
					onblur="if(this.value =='') this.value='������ �Է����ּ���';"
					value="������ �Է����ּ���">
		</td>
	</tr>
	<tr>
		<td class="th-sub">�ð�</td>
		<td class="sub">
			<select name="selhour" id="selhour" onchange="selecthour(this)">
			<c:forEach var="i" begin="0" end="23">
				<option value="${i}">&nbsp;${i}&nbsp;</option>
			</c:forEach>
			</select>
			&nbsp;��&nbsp;
			<select name="selminute" id="selminute" onchange="selectminute(this)">
			<c:forEach var="i" begin="0" end="59">
				<option value="${i}">&nbsp;&nbsp;${i}&nbsp;&nbsp;</option>
			</c:forEach>
			</select>&nbsp;��
			<input type="hidden" name="realtime" value="new Date()">
		</td>
	</tr>
	<tr><td colspan="3" class="sub">
			<textarea class="sub" rows="8" name="content" id="content1" autocomplete="off"></textarea>
			<script>
				<%-- �� ����� ���� ���뿡 �̹����� �ø� �� ����
					  �̹��� ���ε�� url : filebrowserImageUploadUrl => ���ε� ���� �������
					  
					 imgupload.do : ���ε带 ���� url�� ��������
					 
					 -------------------------------------
					 ���ε� �ǿ��� �̹��� �����ϰ� ���ε� ��ư�� ������ CKEDITOR�� imgupload.do�� �����Ŵ
					 �׷��� method.properties���� imgupload �޼���� ���� ��Ű��
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
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>나를보자</title>
<script>
function win_upload() {
	var op = "width=400, height=150, munubar=no, top=200, left=500";
	open("${path}/member/profileForm.pro","window`s name",op);
}
function goback() {
	 history.back();  
	 return false;
}
function checkToSave() {
	if(f.password.value == "") {
		alert("비밀번호를 입력하세요");
		check.password.focus();
		return false;
	}
	f.submit();
}
// 닉네임 중복 체크
function checkname() {
	nickname = $('#nickname').val();
	$.ajax("${path}/ajax/nickname_check.pro?nickname="+nickname, {
		success : function(msg2) {
			console.log("true / false : "+ msg2);							
			alert(msg2);
		},
		error : function(e) {
			alert("nickname="+nickname + e.status);
			console.log("실패");
		}
	})
	return false;
}

function changepass() {
	var op = "width=500, height=350, munubar=no, top=300, left=400";
	open("changePassForm.pro","",op);
	return false;
}
</script>
</head>
<body>
<form name="f" action="myListUpdate.pro" method="post">
<input type="hidden" value="${param.email}" name="email">
<table>
	<tr>
		<th class="th-main">닉네임</th>
		<td class="sub">
			<input type="text" id="nickname" name="nickname" autocomplete="off"
			 onfocus="if(this.value =='${info.nickname}') this.value='';"
			 onblur="if(this.value =='') this.value='${info.nickname}';"
			 value="${info.nickname}">
		</td>
		<td class="sub" style="text-align:left; padding-left: 0px;">
			<button class="btn-main-re" style="margin-bottom: 0px;" onclick="return checkname()">중복확인</button>
			<!-- 중복체크 판단을 위한 히든 -->
			<input type="hidden" name="duplication" value="ducheck">
		</td>
	</tr>
	<tr>
		<th class="th-main">이메일</th>
		<td class="sub">
			<input type="text" readonly value="${info.email} (변경불가)">
		</td>
	</tr>
	<tr>
		<th class="th-main">비밀번호</th>
		<td class="sub">
			<input type="password" name="password">
		</td>
		<td class="sub" style="text-align:left; padding-left: 0px;">
			<button class="btn-main-re" style="margin-bottom: 0px;" onclick="return changepass()">비밀번호변경</button>
		</td>
	</tr>
	<tr>
		<th class="th-main">사진</th>
		<td class="sub">
		<!-- 프로필사진 등록-->
		<div>
			<p style="text-align: center;">
				<!-- hidden value ==실제 사진에 대한 값 -->
				<input type="hidden" name="profile" value="${info.profile}">
				<img src="${path}/member/profile/${info.profile}" height="150" width="150"
					id="profile" style="margin:center"><br><br>
				<a href="javascript:win_upload()">사진등록</a>
			</p>
		</div>
		</td>
	</tr>
</table>
</form>
<!-- 수정 삭제 -->
<br>
<div class="divcenter">
	<button class="btn-main" onclick="return goback()">cancle</button>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<button class="btn-main" onclick="checkToSave()">save</button>
</div>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<%-- 실제 실행중인 프로젝트의 이름을 간단하게 가져온 것
	 ${pageContext.request.contextPath} : /jsp_study2 --%>

<!DOCTYPE html>
<html lang="utf-8">
<head>
	<title>Sign up</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<!--===============================================================================================-->	
	<link rel="icon" type="image/png" href="${path}/log_join_css/images/icons/favicon.ico"/>
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="${path}/log_join_css/vendor/bootstrap/css/bootstrap.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="${path}/log_join_css/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="${path}/log_join_css/fonts/Linearicons-Free-v1.0.0/icon-font.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="${path}/log_join_css/vendor/animate/animate.css">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="${path}/log_join_css/vendor/css-hamburgers/hamburgers.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="${path}/log_join_css/vendor/animsition/css/animsition.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="${path}/log_join_css/vendor/select2/select2.min.css">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="${path}/log_join_css/vendor/daterangepicker/daterangepicker.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="${path}/log_join_css/css/util.css">
	<link rel="stylesheet" type="text/css" href="${path}/log_join_css/css/main.css">
<!--===============================================================================================-->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
</head>
<script type="text/javascript">
	function goback() {
		history.back();  
		return false;
	}
	
	function win_upload() {
		var op = "width=400, height=150, munubar=no, top=200, left=500";
		open("profileForm.pro","window`s name",op);
	}
	
	function isSame() {
		f = document.f;
		if(f.password.value == f.passconfirm.value) {
			document.getElementById("passcheck2").innerHTML = "비밀번호가 일치합니다";
			document.getElementById("passcheck2").style.color = "grey";
		} else {
			document.getElementById("passcheck2").innerHTML = "비밀번호가 일치하지않습니다";
			document.getElementById("passcheck2").style.color = "red";
			f.passconfirm.focus();
			return false;
		}
	}
	
	function inputcheck() {
		f = document.f;
		if(f.nickname.value =="") {
			alert("닉네임을 입력하세요");
			f.nickname.focus();
			return;
		}
		if(f.email.value =="") {
			alert("이메일을 입력하세요");
			f.email.focus();
			return;
		}
		if(f.password.value =="") {
			alert("비밀번호를 입력하세요");
			f.password.focus();
			return;
		}
		if(f.passconfirm.value =="") {
			alert("비밀번호 재입력 후 확인이 필요합니다");
			f.password.focus();
			return;
		}
		if(f.profile.value =="") {
			alert("사진을 등록하세요");
			return false;
		}
		if(f.passconfirm.value != f.password.value) {
			alert("재입력한 비밀번호가 일치하지않습니다");
			f.passconfirm.focus();
			return false;
		}
		f.submit();
		
		function checkemail() {
			var op = "width=400, height=150, munubar=no, top=200, left=500";
			open("check.pro","window`s name",op);
		}
		
		$("#confirm_name").click(function() {
			var data = {nickname:$("#name").val()};
			console.log(data)
			$.ajax({
					url : "ajax_name.jsp", // 요청페이지 설정
					type : "POST", // method 방식 설정
					data : data,
					success : function(data) { // 콜백함수
						console.log(data)
						$("#message").html(data);
						if($("h1").is(".find")) { // class값이 find이 h1태그가 존재해?
							$("#nickname").val("");
						}
					},
					error : function(e) {
						// 시스템적인 오류 (500 : 쿼리문을 잘못 작성)
						alert("서버오류 : " + e.status);
					}
			})
			return false; //없어도 됨 의미 없음
		})
	}
</script>

<body style="background-color: #666666;">
	<div class="limiter">
		<div class="container-login100">
			<div class="wrap-login100">
				<form class="login100-form validate-form" action="join.pro" name="f" method="post">
					<span class="login100-form-title p-b-43">
						Sign up
					</span>
					<!-- 회원정보 입력시작 -->
					<input type="hidden" name="profile" value="">
					<div class="wrap-input100 validate-input" data-validate="닉네임을 입력하세요">
						<input class="input100" type="text" name="nickname" id="name" required>
						<span class="focus-input100"></span>
						<span class="label-input100">닉네임을 입력하세요</span>
					</div>
					<div style="float : right;">
						<button class="w3-button w3-border w3-border-gray w3-round-large"
								id="confirm_name">중복확인</button>
					</div>
					<div id="message"><!-- 내용출력 위치 --></div>
					<br><br>
					<div class="wrap-input100 validate-input" data-validate="이메일을 입력하세요">
						<input class="input100" type="text" name="email">
						<span class="focus-input100"></span>
						<span class="label-input100">이메일을 입력하세요 : abcd@efg.com</span>
					</div>
					<div style="float : right;">
						<button class="w3-button w3-border w3-border-gray w3-round-large" onclick="return checkemail()">중복확인</button>
					</div>
					<br><br>
					<div class="wrap-input100 validate-input" data-validate="비밀번호를 입력하세요">
						<input class="input100" type="password" name="password" onchange="pwCheck()">
						<span class="focus-input100"></span>
						<span class="label-input100">비밀번호를 입력하세요</span>
					</div>
					<div id="passcheck"></div>
					<div class="wrap-input100 validate-input" data-validate="비밀번호를 입력하세요">
						<input class="input100" type="password" name="passconfirm" onchange="isSame()">
						<span class="focus-input100"></span>
						<span class="label-input100">비밀번호를 재확인합니다</span>
					</div>
					<div id="passcheck2"></div>
					<!-- 프로필사진 등록-->
					<div>
						<img src="" height="150" width="150" id="profile">
						<font size="2">
							<a href="javascript:win_upload()">사진등록</a>
						</font>
					</div>
					<br>
					<div class="container-login100-form-btn">
						<button class="login100-form-btn"  onclick="return inputcheck()">
							Sign up
						</button>
					</div>
					<br>
					<div class="container-login100-form-btn">
						<button class="login100-form-btn"  onclick="return goback()">
							Cancle
						</button>
					</div>
				</form>
				
				<!-- left side -->
				<div class="login100-more" style="background-image: url('${path}/log_join_css/images/bg-01.jpg');">
				</div>
			</div>
		</div>
	</div>

<!--===============================================================================================-->
	<script src="${path}/log_join_css/vendor/jquery/jquery-3.2.1.min.js"></script>
<!--===============================================================================================-->
	<script src="${path}/log_join_css/vendor/animsition/js/animsition.min.js"></script>
<!--===============================================================================================-->
	<script src="${path}/log_join_css/vendor/bootstrap/js/popper.js"></script>
	<script src="${path}/log_join_css/vendor/bootstrap/js/bootstrap.min.js"></script>
<!--===============================================================================================-->
	<script src="${path}/log_join_css/vendor/select2/select2.min.js"></script>
<!--===============================================================================================-->
	<script src="${path}/log_join_css/vendor/daterangepicker/moment.min.js"></script>
	<script src="${path}/log_join_css/vendor/daterangepicker/daterangepicker.js"></script>
<!--===============================================================================================-->
	<script src="${path}/log_join_css/vendor/countdowntime/countdowntime.js"></script>
<!--===============================================================================================-->
	<script src="${path}/log_join_css/js/main.js"></script>
</body>
</html>
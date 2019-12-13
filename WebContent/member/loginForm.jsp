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
	<title>Login</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
<!--===============================================================================================-->	
	<link rel="icon" type="${path}/log_join_css/image/png" href="${path}/log_join_css/images/icons/favicon.ico"/>
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="${path}/log_join_css/vendor/bootstrap/css/bootstrap.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" >
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" >
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
</head>
<script>
	function win_findpass() {
		var op = "width=300, height=150, munubar=no top=300, left=600";
		open("pwfindForm.pro","",op);
	}
	
	function check() {
		f = document.f;
		if(f.email.value =="") {
			alert("이메일을 입력하세요");
			f.email.focus();
			return false;
		}
		if(f.password.value =="") {
			alert("비밀번호를 입력하세요");
			f.password.focus();
			return false;
		}
		f.submit();
	}
</script>

<body style="background-color: #666666;">
	<div class="limiter">
		<div class="container-login100">
			<div class="wrap-login100">
				<form name="f" action="login.pro" method="post" class="login100-form validate-form">
				
					<span class="login100-form-title p-b-43">
						Login to continue
					</span>
					
					<div class="wrap-input100 validate-input" data-validate = "이메일을 입력하세요 : abcd@efg.com">
						<input class="input100" type="text" name="email">
						<span class="focus-input100"></span>
						<span class="label-input100">Email</span>
					</div>
					
					<div class="wrap-input100 validate-input" data-validate="비밀번호를 입력하세요">
						<input class="input100" type="password" name="password">
						<span class="focus-input100"></span>
						<span class="label-input100">Password</span>
					</div>

					<div class="flex-sb-m w-full p-t-3 p-b-32">
						<div>
							<a href="javascript:win_findpass()" class="txt1">
								비밀번호를 잊으셨나요?
							</a>
						</div>
					</div>
			
					<div class="container-login100-form-btn">
						<button class="login100-form-btn" onclick="check()">
							Login
						</button>
					</div>
					<br>
					<div class="container-login100-form-btn">
						<button class="login100-form-btn" onclick="location.href='joinForm.pro'">
							Sign up
						</button>
					</div>
				</form>

				<div class="login100-more" style="background-image: url('${path}/log_join_css/images/dublin01.jpg');">
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
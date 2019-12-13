<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<%-- ���� �������� ������Ʈ�� �̸��� �����ϰ� ������ ��
	 ${pageContext.request.contextPath} : /jsp_study2 --%>

<!DOCTYPE html>
<html lang="utf-8">
<head>
	<title>Sign up</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<!--===============================================================================================-->	
	<link rel="icon" type="${path}/log_join_css/image/png" href="${path}/log_join_css/images/icons/favicon.ico"/>
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
			document.getElementById("passcheck2").innerHTML = "��й�ȣ�� ��ġ�մϴ�";
			document.getElementById("passcheck2").style.color = "grey";
		} else {
			document.getElementById("passcheck2").innerHTML = "��й�ȣ�� ��ġ�����ʽ��ϴ�";
			document.getElementById("passcheck2").style.color = "red";
			f.passconfirm.focus();
			return false;
		}
	}
	
	function inputcheck() {
		f = document.f;
		if(f.nickname.value =="") {
			alert("�г����� �Է��ϼ���");
			f.nickname.focus();
			return;
		}
		if(f.email.value =="") {
			alert("�̸����� �Է��ϼ���");
			f.email.focus();
			return;
		}
		if(f.password.value =="") {
			alert("��й�ȣ�� �Է��ϼ���");
			f.password.focus();
			return;
		}
		if(f.passconfirm.value =="") {
			alert("��й�ȣ ���Է� �� Ȯ���� �ʿ��մϴ�");
			f.password.focus();
			return;
		}
		if(f.profile.value =="") {
			alert("������ ����ϼ���");
			return false;
		}
		if(f.passconfirm.value != f.password.value) {
			alert("���Է��� ��й�ȣ�� ��ġ�����ʽ��ϴ�");
			f.passconfirm.focus();
			return false;
		}
	}
	
	/* function confirm_name() {
		var nickname = $('#nickname').val();
		$.ajax("${page}/ajax/nickname_check.pro?nickname="+ nickname, {
			success : function(msg2) {
				console.log("true / false : "+ msg2);							
				$("#check_message").text(msg2);
				//$("#check_message").css("color", "red");
			},
			error : function(e) {
					alert(e.status);
					console.log("����");
			}
		})
	} */
	
	/* $("#nickname").blur(function() {
		var nickname = $('#nickname').val();
		$.ajax('${page}/ajax/nickname_check.pro?nickname='+ nickname, {
			success : function(msg2) {
				console.log("true / false : "+ msg2);							
				$("#check_message").text(msg2);
				//$("#check_message").css("color", "red");
			},
			error : function(e) {
					alert(e.status);
					console.log("����");
			}
			});
		});	 */
</script>

<body style="background-color: #666666;">
	<div class="limiter">
		<div class="container-login100">
			<div class="wrap-login100">
				<form class="login100-form validate-form" action="join.pro" name="f" method="post">
					<span class="login100-form-title p-b-43">
						Sign up
					</span>
					<!-- ȸ������ �Է� -->
					<input type="hidden" name="profile" value="">
					<div class="wrap-input100 validate-input" data-validate="�г����� �Է��ϼ���">
						<input class="input100" type="text" name="nickname" id="#nickname">
						<span class="focus-input100"></span>
						<span class="label-input100">�г����� �Է��ϼ���</span>
					</div>
					<div style="float : right;">
						<button class="w3-button w3-padding-small w3-border w3-border-gray w3-round-large"
								onclick="javascript:return confirm_name()"
								id="confirm_name">�ߺ�Ȯ��</button>
					</div>
					<div id="check_message">
						<!-- �ߺ�Ȯ�� ������� ��ġ -->
					</div>
					<br><br>
					<div class="wrap-input100 validate-input" data-validate="�̸����� �Է��ϼ���">
						<input class="input100" type="text" name="email">
						<span class="focus-input100"></span>
						<span class="label-input100">�̸����� �Է��ϼ��� : abcd@efg.com</span>
					</div>
					<div style="float : right;">
						<button class="w3-button w3-padding-small w3-border w3-border-gray w3-round-large" onclick="return checkemail()">�ߺ�Ȯ��</button>
					</div>
					<br><br>
					<div class="wrap-input100 validate-input" data-validate="��й�ȣ�� �Է��ϼ���">
						<input class="input100" type="password" name="password" onchange="pwCheck()">
						<span class="focus-input100"></span>
						<span class="label-input100">��й�ȣ�� �Է��ϼ���</span>
					</div>
					<div id="passcheck"></div>
					<div class="wrap-input100 validate-input" data-validate="��й�ȣ�� �Է��ϼ���">
						<input class="input100" type="password" name="passconfirm" onchange="isSame()">
						<span class="focus-input100"></span>
						<span class="label-input100">��й�ȣ�� ��Ȯ���մϴ�</span>
					</div>
					<div id="passcheck2"></div>
					<!-- �����ʻ��� ���-->
					<div>
						<p style="text-align: center;">
							<img src="" height="150" width="150" id="profile" style="margin:center"><br><br>
							<!-- <button class="w3-button w3-padding-small w3-border w3-border-gray w3-round-large"
							onclick="return win_upload()">�������</button> -->
							<a href="javascript:win_upload()">�������</a>
						</p>
					</div>
					<!-- ���Թ�ư -->
					<hr>
					<div class="container-login100-form-btn">
						<button class="login100-form-btn"  onclick="inputcheck()">
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
				<div class="login100-more" style="background-image: url('${path}/log_join_css/images/13.jpg');">
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
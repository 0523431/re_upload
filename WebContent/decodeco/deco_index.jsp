<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />


<!DOCTYPE html>
<html lang="en">
  <head>
    <title><decorator:title /></title>
    <!-- css -->
	<link rel="stylesheet" href="${path}/decodeco/main.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    
    <link href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,600,700" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Lora:400,400i,700,700i&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Abril+Fatface&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="${path}/main_css/css/open-iconic-bootstrap.min.css">
    <link rel="stylesheet" href="${path}/main_css/css/animate.css">
    
    <link rel="stylesheet" href="${path}/main_css/css/owl.carousel.min.css">
    <link rel="stylesheet" href="${path}/main_css/css/owl.theme.default.min.css">
    <link rel="stylesheet" href="${path}/main_css/css/magnific-popup.css">

    <link rel="stylesheet" href="${path}/main_css/css/aos.css">

    <link rel="stylesheet" href="${path}/main_css/css/ionicons.min.css">

    <link rel="stylesheet" href="${path}/main_css/css/bootstrap-datepicker.css">
    <link rel="stylesheet" href="${path}/main_css/css/jquery.timepicker.css">

    
    <link rel="stylesheet" href="${path}/main_css/css/flaticon.css">
    <link rel="stylesheet" href="${path}/main_css/css/icomoon.css">
    <link rel="stylesheet" href="${path}/main_css/css/style.css">
  <decorator:head />
  </head>
  <!-- 스마트에디터 사용 -->
  <script type="text/javascript" src="http://cdn.ckeditor.com/4.5.7/full/ckeditor.js"></script>
  <body>
  <hr>
	<div id="colorlib-page">
		<a href="#" class="js-colorlib-nav-toggle colorlib-nav-toggle"><i></i></a>
		<aside id="colorlib-aside" role="complementary" class="js-fullheight">
			<nav id="colorlib-main-menu" role="navigation">
				<%--
				<div id="colorlib-logo" class="mb-4" style="width: 50%;">
					<a href="index.html" style="background-image: url(${path}/main_css/images/bg_1.jpg);">
						Spend<span>the money</span>
					</a>
				</div>
				--%>
				<div>
					<p style="text-align: center; bottom: 0px; margin-bottom: 0px;">
					<c:if test="${!empty sessionScope.email}">
					<img class="circle-img" src="${path}/member/profile/${sessionScope.profile}" />
	    			<br>
	    			<font size="3">${sessionScope.nickname}</font>
					<font size="2">${sessionScope.email}</font>
					<ul class="tagcloud" style="text-align: right;">
						<a href="${path}/member/logout.pro" class="tag-cloud-link">logout</a>
					</ul>
					<%-- <button class="tag-cloud-link" onclick="location.href='${path}/member/logout.pro'">logout</button> --%>
					</c:if>
					</p>
				</div>
				<ul class="colorlib-active">
					<li><span class="icon-calendar"></span>&nbsp;&nbsp;<a href="${path}/board/mainInfo.pro?email=${sessionScope.email}">쓰자쓰자</a></li>
					<li><span class="icon icon-search"></span>&nbsp;&nbsp;<a href="${path}/board/otherList.pro">같이보자</a></li>
					<li><span class="icon-paper-plane"></span>&nbsp;&nbsp;<a href="${path}/board/currencyList.pro">환율보자</a></li>
					<li><span class="icon-folder-o"></span>&nbsp;&nbsp;<a href="${path}/board/bookmark.pro?email=${sessionScope.email}">따로보자</a></li>
					<li><span class="icon-person"></span>&nbsp;&nbsp;<a href="${path}/member/myList.pro?email=${sessionScope.email}">관리하자</a></li>
				</ul>
			</nav>

			<!-- 라이센스 지우지말것 -->
			<div class="colorlib-footer">
				<p class="pfooter">
	  			Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with <i class="icon-heart" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a>
	  		</div>
		</aside>
	
		<!-- END COLORLIB-ASIDE -->	
		<div id="colorlib-main">
			<section class="ftco-section ftco-no-pt ftco-no-pb">
				<div class="container">
					<div class="row d-flex">
						<div class="col-xl-8 py-5 px-md-5">
							<decorator:body />
						</div>
					</div>
				</div>
			</section>
	    	<!-- <div class="col-xl-4 sidebar ftco-animate bg-light pt-5 fadeInUp ftco-animated">
				<div class="sidebar-box ftco-animate">
					<h3 class="sidebar-heading"></h3>
					<p style="text-align: -webkit-right; font-size: small; color: darkgray;">Pooreum made it so hard</p>
				</div>
	    	</div> -->
		</div><!-- END COLORLIB-MAIN -->
	</div><!-- END COLORLIB-PAGE -->
<hr>
  <!-- loader -->
  <div id="ftco-loader" class="show fullscreen">
  	<svg class="circular" width="48px" height="48px">
  		<circle class="path-bg" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke="#eeeeee"/>
  		<circle class="path" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke-miterlimit="10" stroke="#F96D00"/>
  	</svg>
  </div>


  <%-- <script src="${path}/main_css/js/jquery.min.js"></script> --%>
  <script src="${path}/main_css/js/jquery-migrate-3.0.1.min.js"></script>
  <script src="${path}/main_css/js/popper.min.js"></script>
  <script src="${path}/main_css/js/bootstrap.min.js"></script>
  <script src="${path}/main_css/js/jquery.easing.1.3.js"></script>
  <script src="${path}/main_css/js/jquery.waypoints.min.js"></script>
  <script src="${path}/main_css/js/jquery.stellar.min.js"></script>
  <script src="${path}/main_css/js/owl.carousel.min.js"></script>
  <script src="${path}/main_css/js/jquery.magnific-popup.min.js"></script>
  <script src="${path}/main_css/js/aos.js"></script>
  <script src="${path}/main_css/js/jquery.animateNumber.min.js"></script>
  <script src="${path}/main_css/js/scrollax.min.js"></script>
  <script src="${path}/main_css/js/main.js"></script>
    
  </body>
</html>
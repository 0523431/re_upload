<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
    
<!DOCTYPE html>
<html lang="en">
<title><decorator:title /></title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Poppins">
<link rel="stylesheet" href="https://www.w3schools.com/lib/w3-theme-light-green.css">
<link rel="stylesheet" href="https://www.w3schools.com/lib/w3-colors-highway.css">

<!-- css -->
<link rel="stylesheet" href="${path}/decodeco/main.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<script type="text/javascript">
	
</script>
<style type="text/css">
	body,h1,h2,h3,h4,h5 {
		font-family: "Poppins", sans-serif
	}
	body {
		font-size:16px;
	}
	.w3-half img {
		margin-bottom:-6px;
		margin-top:16px;
		opacity:0.8;
		cursor:pointer
	}
	.w3-half img:hover {
		opacity:1
	}
	
</style>
<decorator:head />
<script type="text/javascript" src="http://cdn.ckeditor.com/4.5.7/full/ckeditor.js">
<%--
	모든 게시판에 스마트 에디터를 쓰겠다 !
	version => full / smart / ...
--%>
</script>
<body>

<!-- Sidebar/menu -->
<nav class="w3-sidebar w3-collapse w3-top w3-large w3-padding" style="z-index:3;width:300px;font-weight:bold;" id="mySidebar"><br>
  <a href="javascript:void(0)" onclick="w3_close()" class="w3-button w3-hide-large w3-display-topleft" style="width:100%;font-size:22px">Close Menu</a>
  <div class="w3-container">
    <c:if test="${!empty sessionScope.email}">
		<img class="circle-img" src="${path}/member/profile/${sessionScope.profile}" />
	    <br>
	    <font size="3">${sessionScope.nickname}</font>
		<font size="2">${sessionScope.email}</font>
		<br>
		<button class="button"
				onclick="location.href='${path}/member/logout.pro'">로그아웃
		</button>
		<%-- <button class="w3-button w3-small w3-border w3-border-gray w3-round-large"
				onclick="location.href='${path}/member/logout.pro'">로그아웃
		</button> --%>
	</c:if>
	
  </div>
  <div class="w3-bar-block">
    <a href="${path}/board/mainInfo.pro?email=${sessionScope.email}" class="w3-bar-item w3-button w3-hover-theme-d5">쓰자쓰자</a> 
    <a href="${path}/board/otherList.pro" class="w3-bar-item w3-button w3-hover-theme-d5">같이보자</a> 
    <a href="${path}/board/currencyList.pro" class="w3-bar-item w3-button w3-hover-w3-theme-d5">환율</a> 
    <a href="${path}/board/bookmark.pro?email=${sessionScope.email}" class="w3-bar-item w3-button w3-hover-w3-theme-d5">따로보자</a> 
    <a href="${path}/board/myList.pro?email=${sessionScope.email}" class="w3-bar-item w3-button w3-hover-w3-theme-d5">나를보자</a> 
    <a href="#" onclick="w3_close()" class="w3-bar-item w3-button w3-hover-w3-theme-d5">임보임보</a>
  </div>
</nav>

<!-- Top menu on small screens -->
<header class="w3-container w3-top w3-hide-large w3-2018-crocus-petal w3-xlarge w3-padding">
  <a href="javascript:void(0)" class="w3-button w3-margin-right" onclick="w3_open()">▽</a>
  <span>Company Name</span>
</header>

<!-- Overlay effect when opening sidebar on small screens -->
<div class="w3-overlay w3-hide-large" onclick="w3_close()" style="cursor:pointer" title="close side menu" id="myOverlay"></div>

<!-- !PAGE CONTENT! -->
<div class="w3-main" style="margin-left:340px;margin-right:40px">

  <!-- Header -->
  <div class="w3-container" style="margin-top:10px">
    <!--
    <h1 class="w3-jumbo"><b>Interior Design</b></h1>
    <h1 class="w3-xxxlarge w3-text-red"><b>Showcase.</b></h1>
    -->
    <hr style="width:100%; border:3px solid #E0E3DA" class="w3-round">
  </div>
  
  <!-- Services -->
  <div class="w3-container" id="services" style="margin-top:50px">
    <decorator:body />
  </div>
  
    
  </div>

<!-- End page content -->
</div>

<!-- Footer : W3.CSS Container -->
<div class="w3-light-grey w3-container w3-padding-32" style="margin-top:75px;padding-right:58px">
	<p class="w3-right">Powered by <a href="https://www.w3schools.com/w3css/default.asp" title="W3.CSS" target="_blank" class="w3-hover-opacity">w3.css</a>
	</p>
</div>

<script>
// Script to open and close sidebar
function w3_open() {
  document.getElementById("mySidebar").style.display = "block";
  document.getElementById("myOverlay").style.display = "block";
}
 
function w3_close() {
  document.getElementById("mySidebar").style.display = "none";
  document.getElementById("myOverlay").style.display = "none";
}

// Modal Image Gallery
function onClick(element) {
  document.getElementById("img01").src = element.src;
  document.getElementById("modal01").style.display = "block";
  var captionText = document.getElementById("caption");
  captionText.innerHTML = element.alt;
}
</script>

</body>
</html>

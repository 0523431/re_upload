<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="co" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<co:set var="path" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>A new journey</title>
<%-- charjs를 쓰기 위해서 --%>
<script type="text/javascript" src="http://www.chartjs.org/dist/2.9.3/Chart.min.js">
</script>
<%-- ajax을 이용해서 사용할 예정이라서 jquery를 연결 --%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script>
	// 검색 후, 그 결과를 페이지에 유지시켜주는 메서드함수
	function listdo(page) { // listdo 메서드에 page값을 넣고
		document.f.pageNum.value = page; // pageNum의 value값을 바꿔주는 거야
		document.f.submit(); // form을 submit해주는 거야
	}
	
	// graph > json형태를 view단에서 만들어줌
	function graphs() {
		$.ajax("${path}/ajax/graph.pro", {
			success : function(data) {
				console.log(data);
				barGraphprint(data);
			},
			error : function(e) {
				alert("서버오류" + e.satus);
			}
		})
	}

	function barGraphprint(data) {
		// data : 서버에서 전달한 JSON형태의 데이터
		var rows = JSON.parse(data);
		
		// 배열 데이터로 만들어줌
		var type2s = []; // 라벨 데이터
		var datas = []; // 건수 데이터
		var colors = []; // 색상
		
		// json파일을 분석하여 필요한 데이터로 저장해주는 과정
		$.each(rows, function(index, item) {
			type2s[index] = item.type2; // 소비유형 | type2 : boardAllAction에서 정한 변수명
			datas[index] = item.cnt; // 글의 개수 저장 | cnt : boardAllAction에서 정한 변수명
			colors[index] = [red, green, blue, purple, gray, yellow, orange];
		})
		
		var config = {
			type : "pie",
			data : {
				datasets :[{
					data : datas,
					backgroundColor : colors,
				}],
				labels : names
			},
			options : {
				responsive : true,
				legend : {
					position : "top"
				},
				title : {
					display : true,
					text : "글쓴이 별 게시판 등록 건수"
				}
			}
		};
		var ctx = document.getElementById("canvas").getContext("2d");
		new Chart(ctx, config);
	}
</script>
<style type="text/css">
	.test {
		margin : auto;
		border: 2px solid #E0E3DA;
		padding: 20px;
		width : 275px;
		border-radius: 10px;
		-moz-border-radius: 10px;
		-webkit-border-radius: 10px;
	}
	.uploadbtn {
	margin : auto;
	text-align : center;
	background-color:#E0E3DA;
	border-radius:20px;
	border:2px solid #E0E3DA;
	display:inline-block;
	cursor:pointer;
	color:#566270;
	font-family:Arial;
	font-size:20px;
	padding:20px 40px;
	text-decoration:none;
	}
	.uploadbtn:hover {
	background-color: #566270;
	color:#E0E3DA;
	}
	.infodiv {
	width:350px; height:300px;
	border:1px solid red;
	float:left;
	margin-right:10px;
	}
	.graphdiv {
	width:350px; height:300px;
	border:1px solid red;
	float:left;
	}
</style>
</head>
<body>
<div class="divcenter">
	<button class="uploadbtn" onclick="location.href='mainWriteForm.pro?email=${sessionScope.email}'">
		여행지 등록하기
	</button>
</div>
<hr>
<form action="mainInfo.pro" method="post" name="f">
	<co:set var="today" value="<%=new java.util.Date() %>" />
	
	<input type="hidden" name="today" value="new Date()">
	<input type="hidden" name="pageNum" value="1">
	
	<div>
		<co:forEach var="list" items="${list}">
		<div class="test">
			<p><a href="subList.pro?travelNum=${list.travelNum}">${list.traveltitle}</a></p>
			<p>${list.start}&nbsp;-&nbsp;${list.end}</p>
			<p>예산 : ${list.budget}&nbsp;&nbsp;&nbsp; <p>여행지 : ${list.country}</p>
		</div>
		<div>
			<canvas id="canvas">
			</canvas>
		</div>
		</co:forEach>
	</div>
	
	
	<%-- 어려운 부분 --%>
	<hr>
	<div class="divcenter">
		<co:if test="${pageNum <=1}">
			[이전]
		</co:if>
		<co:if test="${pageNum >1}">
				<a href="javascript:listdo(${pageNum -1})">[이전]</a>
		</co:if>
		
		<co:forEach var="a" begin="${startpage}" end="${endpage}">
			<co:if test="${a ==pageNum}">
				[${a}]
			</co:if>
			<co:if test="${a !=pageNum}">
				<a href="javascript:listdo(${a})">[${a}]</a>
			</co:if>
		</co:forEach>

		<co:if test="${pageNum >= maxpage}">
			[다음]
		</co:if>
		<co:if test="${pageNum < maxpage}">
			<%-- <a href="list.do?pageNum=${pageNum +1}">[다음]</a> --%>
			<a href="javascript:listdo(${pageNum +1})">[다음]</a>
		</co:if>
	</div>
</form>
</body>
</html>
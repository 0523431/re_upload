<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="co" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<co:set var="path" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>�󸶽質 �����?</title>
<%-- charjs�� ���� ���ؼ� --%>
<script type="text/javascript" src="http://www.chartjs.org/dist/2.9.3/Chart.min.js">
</script>
<%-- ajax�� �̿��ؼ� ����� �����̶� jquery�� ���� --%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<style>
td {
	color: #566270;
	border: 3px solid #E0E3DA;
	padding: 10px;
	text-align: center;
}
.type1 {
	text-align : center;
	background-color:transparent;
	border-radius:0px;
	border:3px solid #E0E3DA;
	display:inline-block;
	cursor:pointer;
	color:#566270;
	font-family:Arial;
	font-size:16px;
	padding:13px 35px;
	text-decoration:none;
}
.date {
	white-space:nowrap;
	overflow-x: auto;
    white-space: nowrap;
    width:70%; height:80px;
	margin : auto;
	border: 2px solid #E0E3DA;
	padding: 20px;
	border-radius: 10px;
}
.indate {
	float:left;
	margin-right:20px;
	font-size: 20px;
	font-weight: bold;
	
}
</style>
<script>
var randomColorFactor = function() {
	return Math.round(Math.random() *255);
};
var randomColor = function(opacity) {
	return "rgba("+randomColorFactor() + ","
		+ randomColorFactor() + ","
		+ randomColorFactor() + ","
		+ (opacity || '.3') +")";
};

$(document).ready(function() {
	graphs();
})

//json���¸� view�ܿ��� �������
function graphs() {
	$.ajax("${path}/ajax/graph.pro?travelNum=${param.travelNum}&email=${sessionScope.email}", {
		success : function(data) {
			console.log(data);
			barGraphprint(data);
		},
		error : function(e) {
			alert("��������" + e.satus);
		}
	})
}

function barGraphprint(data) {
	// data : �������� ������ JSON������ ������
	var rows = JSON.parse(data);
	
	// �迭 �����ͷ� �������
	var type2s = [];
	var datas = [];
	var colors = [];
	
	$.each(rows, function(index, item) {
		type2s[index] = item.type2; // type2s
		datas[index] = item.cnt; // ���� ���� ����
		colors[index] = randomColor();
			//["red", "yellow", "orange", "green", "blue", "navy", "purple"];
	})
	
	var chartData = {
		labels: type2s,
		datasets: [
			{
				type:"bar",
				label:"�Ǽ�",
				data: datas,
				backgroundColor: colors
			},
			{
				type:"line",
				label:"�Ǽ�",
				data: datas,
				backgroundColor: colors,
				borderWidth: 2,
				fill: false
			}
		]
	};
	var ctx = document.getElementById("canvas").getContext("2d");
	new Chart(ctx, {
			type: "bar",
			data: chartData,
			options: {
				responsive: true,
				legend: {
					display: false,
					position : "top"
				},
				title : {
					display : true,
					text : "�̹� ���࿡�� �Һ� ������ �˾ƺ���"
				},
				scales: {
					xAxes: [{
						display: true,
						scaleLabel: {
							display: true,
							labelString: '�Һ�����'
						},
						stacked : true // 0���� �����ϰ� ����
					}],
					yAxes: [{
						display: true,
						scaleLabel: {
							display: true,
							labelString: '�󵵼�'
						},
						stacked : true
					}]
				}
			}
	});
};
</script>
</head>
<body>
<input type="hidden" value="${param.travelNum}" name="travelNum">
<input type="hidden" value="all" name="type1">
<input type="hidden" value="alldate" name="seldate">

<div class="mainTitle">
	<a href="mainInfo.pro?email=${sessionScope.email}">${info.traveltitle}</a>
</div>
<button onclick="location.href='mainUpdateForm.pro?travelNum=${param.travelNum}'">
����
</button>

<table>
	<tr>
		<td><a href="subList.pro?travelNum=${param.travelNum}">ALL</a></td>	
 		<co:forEach var="date" begin="${fn:substring(info.start,8,10)}" end="${fn:substring(info.end,8,10)}" >
 		<td><a href="javascript:">${date}</a></td>
		</co:forEach>
	</tr>
</table>

<div class="test" style="width: 75%;">
	<canvas id="canvas">
	</canvas>
</div>

<div class="date">
	<div class="indate" onclick="location.href='subList.pro?travelNum=${param.travelNum}&type1=all&seldate=all'">ALL</div>
	<co:forEach var="date" begin="${fn:substring(info.start,8,10)}" end="${fn:substring(info.end,8,10)}" >
	<div class="indate" onclick="location.href='subList.pro?travelNum=${param.travelNum}&type1=${type1}&seldate=${date}'">${date}</div>
	</co:forEach>
</div>
<br>
<!--
	���� form�±� �ȿ��� input�� name�� value�� ���� url�� �����µ�,
	�ؿ��� �� ����� input���� ���� �ٷ� parameter�� 
	type1(mode) : parameter
	all, 1, 2 : value ��
-->
<div class="divcenter">
	<button class="type1" onclick="location.href='subList.pro?travelNum=${param.travelNum}&type1=all'">��ƺ���</button>
	<button class="type1" onclick="location.href='subList.pro?travelNum=${param.travelNum}&type1=1'">����</button>
	<button class="type1" onclick="location.href='subList.pro?travelNum=${param.travelNum}&type1=2'">ī��</button>
	<button class="type1" onclick="location.href='subWriteForm.pro?travelNum=${param.travelNum}'">������</button>
</div>
<br>
<table>
	<tr>
		<td>����&nbsp;&nbsp;&nbsp;
			<co:forEach var="m" items="${exlist}">
				<co:set var="sum" value="${sum+ m.price}" />
			</co:forEach>
			${sum}
			<co:forEach var="m" items="${exlist}">
				<co:if test="${m.type1==1}">
					<co:set var="sumcash" value="${sumcash+ m.price}" />
				</co:if>
			</co:forEach>
		</td>
		<td>������&nbsp;&nbsp;&nbsp;
			<co:if test="${expcnt ==0}">
			${info.budget}
			</co:if>
			<co:if test="${expcnt >0}">
				<co:forEach var="m" items="${exlist}">
					<co:if test="${m.type1 ==1}">
						<co:set var="budget" value="${info.budget-sumcash}" />
					</co:if>
				</co:forEach>
			</co:if>
			${budget}</td>
	</tr>
</table>
<br>
<co:if test="${expcnt ==0}">
	<div class="divcenter">
		���⳻���� �����ϴ�
	</div>
</co:if>

<co:if test="${expcnt >0}">
<table>
	<co:forEach var="ex" items="${exlist}">
	<tr>
		<td rowspan="2" width="10%">${ex.type2==1? "�ĺ�":ex.type2==2? "����":ex.type2==3? "����":ex.type2==4? "����":ex.type2==5? "����":ex.type2==6? "���ǰ":"��Ÿ"}</td>
		<td>�Һ����� : ${ex.type1==1? "����":ex.type1==2? "ī��":"����"}</td>
		<td>${ex.price}</td>
		<td>${ex.seldate}��   ${ex.selhour} ��  ${ex.selminute} ��</td>
	</tr>
	<tr>
		<td colspan="2"><a href="subDetailForm.pro?expenseNum=${ex.expenseNum}">${ex.title}</a></td>
		<td>�ο� : ${ex.peocnt}</td>
	</tr>
	</co:forEach>
</table>
</co:if>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="co" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
	var type2s = ["�ĺ�","����","����","����","����","����","��Ÿ"];
	var datas = [];
	var colors = [];
	
	$.each(rows, function(index, item) {
		type2s[index] = item.type2; // type2s
		datas[index] = item.cnt; // ���� ���� ����
		colors[index] = randomColor();
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
			beginAtZero: true,
			options: {
				responsive: true,
				legend: {
					display: false,
					position : "top"
				},
				title : {
					display : true,
					text : "���� �Һ� ����"
				},
				scales: {
					xAxes: [{
						display: true,
						scaleLabel: {
							display: true,
							// labelString: '�Һ�����'
						}
					}],
					yAxes: [{
						display: true,
						scaleLabel: {
							display: true,
							// labelString: '�󵵼�'
						},
						stacked : true,
						ticks: {
	                        beginAtZero: true,
	                        callback: function (value) { if (Number.isInteger(value)) { return value; } },
	                        stepSize: 1
	                    }
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

<div class="title-main">
	<a href="mainInfo.pro?email=${sessionScope.email}">${info.traveltitle}</a>
	<button class="btn-sub" onclick="location.href='mainUpdateForm.pro?travelNum=${param.travelNum}'">
		edit&nbsp;&nbsp;<i class="icon-comment2"></i>
	</button>
</div>
<br>
<div class="test" style="width: 85%; margin:auto;">
	<canvas id="canvas">
	</canvas>
</div>
<table class="table-sub">
	<tr>
		<th class="th-sub"><%-- <a href="subList.pro?travelNum=${param.travelNum}&type1=all&seldate=all"> --%>Dates<!-- </a> --></th>	
 		<co:forEach var="date" begin="${fn:substring(info.start,8,10)}" end="${fn:substring(info.end,8,10)}" >
 		<td class="td-sub"><%-- <a href="subList.pro?travelNum=${param.travelNum}&type1=${type1}&seldate=${date}"> --%>${date}<!-- </a> --></td>
		</co:forEach>
	</tr>
</table>
<br>
<!--
	���� form�±� �ȿ��� input�� name�� value�� ���� url�� �����µ�,
	�ؿ��� �� ����� input���� ���� �ٷ� parameter�� 
	type1(mode) : parameter
	all, 1, 2 : value ��
-->
<div style="text-align: right">
	<button class="btn-type1" onclick="location.href='subList.pro?travelNum=${param.travelNum}&type1=all'">&nbsp;&nbsp;ALL&nbsp;&nbsp;</button>
	<button class="btn-type1" onclick="location.href='subList.pro?travelNum=${param.travelNum}&type1=1'">CASH</button>
	<button class="btn-type1" onclick="location.href='subList.pro?travelNum=${param.travelNum}&type1=2'">CARD</button>
	<button class="btn-new" onclick="location.href='subWriteForm.pro?travelNum=${param.travelNum}'">NEW</button>
</div>
<table class="table-sub">
	<tr>
		<th class="th-sub">����</th>
		<td class="td-sub">
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
		<th class="th-sub">������</th>
		<td class="td-sub">
			<co:if test="${expcnt ==0}">
			${info.budget}
			</co:if>
			<co:if test="${expcnt >0}">
				<co:forEach var="m" items="${exlist}">
					<co:if test="${m.type1 ==1}">
						<co:set var="budget" value="${info.budget - sumcash}" />
					</co:if>
				</co:forEach>
			</co:if>
			<fmt:formatNumber value="${budget}" pattern="###,###.00" />
		</td>
	</tr>
</table>
<br>
<co:if test="${expcnt ==0}">
	<div class="divcenter">
		���⳻���� �����ϴ�
	</div>
</co:if>

<co:if test="${expcnt >0}">
	<co:forEach var="ex" items="${exlist}">
	<table class="table-sub">
	<tr>
		<td rowspan="2" width="10%">
			${ex.type2==1? "�ĺ�":ex.type2==2? "����":ex.type2==3? "����":ex.type2==4? "����":ex.type2==5? "����":ex.type2==6? "����":"��Ÿ"}
		</td>
		<td style="width: 100px;">�Һ�����</td><td style="width: 180px; text-align:left;">${ex.type1==1? "����":ex.type1==2? "ī��":"����"}</td>
		<th rowspan="2" class="th-sub">${ex.price}</th>
		<td style="width: 150px;">${ex.seldate}��&nbsp;&nbsp;&nbsp;${ex.selhour}��&nbsp;${ex.selminute}��</td>
	</tr>
	<tr>
		<td colspan="2"><a href="subDetailForm.pro?expenseNum=${ex.expenseNum}">${ex.title}</a></td>
		<td>�ο� : ${ex.peocnt}</td>
	</tr>
	</table>
	</co:forEach>
</co:if>
</body>
</html>
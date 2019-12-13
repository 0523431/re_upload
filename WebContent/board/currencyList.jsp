<%@page import="org.jsoup.nodes.Element"%>
<%@page import="org.jsoup.select.Elements"%>
<%@page import="org.jsoup.Jsoup"%>
<%@page import="org.jsoup.nodes.Document"%>
<%@page import="java.io.IOException"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>환율정보</title>
<style type="text/css">
	table, td, th {
		border : 1px solid grey; border-collapse:collapse;
	}
</style>

</head>
<body>

<%
	String url = "https://okbfex.kbstar.com/quics?page=C015690#loading";
	String line = "";
	Document doc = null;
	try {
		// doc : 홈페이지의 소스가 저장되어 있음
		doc = Jsoup.connect(url).get();
		// Elements : 배열이거나 list이거나 => collection
		// e1 : url이 제공하는 html 문서 중 태그가 table인 태그들만 저장
		Elements e1 = doc.select(".tType01");
		for(Element ele : e1) { // 여기서 ele는 table태그 한개를 뜻함 => table태그를 제외한 그 안의 내용들
			String temp = ele.html();
			System.out.println("========================");
			System.out.println(temp);
			line +=temp;
		}
	} catch(IOException e) {
		e.printStackTrace();
	}
%>
<table>
	<%=line %>
</table>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<% request.setCharacterEncoding("UTF-8");%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<fmt:requestEncoding value="UTF-8" /> <%-- 파라미터 값을 인코딩 --%>
<%-- 데이터베이스의 Connection 객체 생성 --%>
<sql:setDataSource var="conn" driver="org.mariadb.jdbc.Driver"
				   url="jdbc:mariadb://localhost:3306/projectdb"
				   user="scott"
				   password="1234" />

<%--
	executeQuery(sql)의 결과를 rs가 받게 됨
	resultSet의 기능을 가진 객체가 되는 거
--%>
<sql:query var="rs" dataSource="${conn}">
	select * from member where nickname=?
	<sql:param>
		${param.nickname}
	</sql:param>
</sql:query>

<c:if test="${empty rs.rows}">
	<h1 class="unfind"> 사용하실 수 있습니다</h1>
</c:if>

<c:if test="${!empty rs.rows}">
	<h1 class="find">${rs.rows[0].nickname}는 존재하는 닉네임입니다</h1>	
</c:if>
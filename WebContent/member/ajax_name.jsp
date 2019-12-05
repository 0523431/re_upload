<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<% request.setCharacterEncoding("UTF-8");%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<fmt:requestEncoding value="UTF-8" /> <%-- �Ķ���� ���� ���ڵ� --%>
<%-- �����ͺ��̽��� Connection ��ü ���� --%>
<sql:setDataSource var="conn" driver="org.mariadb.jdbc.Driver"
				   url="jdbc:mariadb://localhost:3306/projectdb"
				   user="scott"
				   password="1234" />

<%--
	executeQuery(sql)�� ����� rs�� �ް� ��
	resultSet�� ����� ���� ��ü�� �Ǵ� ��
--%>
<sql:query var="rs" dataSource="${conn}">
	select * from member where nickname=?
	<sql:param>
		${param.nickname}
	</sql:param>
</sql:query>

<c:if test="${empty rs.rows}">
	<h1 class="unfind"> ����Ͻ� �� �ֽ��ϴ�</h1>
</c:if>

<c:if test="${!empty rs.rows}">
	<h1 class="find">${rs.rows[0].nickname}�� �����ϴ� �г����Դϴ�</h1>	
</c:if>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="co" uri="http://java.sun.com/jsp/jstl/core" %>

<script>
	<co:choose>
		<co:when test="${opener}">
			alert("${msg}")
			opener.location.href="${url}"
		</co:when>
		<co:otherwise>
			alert("${msg}")
			location.href="${url}"
		</co:otherwise>
	</co:choose>
	
	<co:if test="${closer}">
		self.close();
	</co:if>
</script>
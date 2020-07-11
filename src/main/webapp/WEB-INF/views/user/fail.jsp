<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../includes/tempnav.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>환영합니다.</title>
</head>
<body>
<h1>이멜 인증 실패</h1>
<div>
<label>result : </label><c:out value="${result}" />
</div>
<div>
<h3>이멜 인증 실패</h3>
</div>

<%@ include file="../includes/footer.jsp"%>
</body>
</html>
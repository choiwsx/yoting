<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ERROR</title>
</head>
<body>
<h1>에러 페이지</h1>
<h3>에러:<c:out value="${result }" />

</h3>
<c:if test ="${empty userNo}">
<input type="button" value="로그인" onclick="location.href='/'">
</c:if>
<input type="button" value="홈으로" onclick="location.href='/'">
<input type="button" value="뒤로가기" onclick="history.back(-1);">
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ㅇㅋ</title>
</head>
<body>
<h1>결과</h1>
<h3>실행되었습니다.</h3>
<c:out value="${result }" />
<a href="/">홈으로</a>
<input type="button" value="뒤로가기" onclick="history.back(-1);">
</body>
</html>
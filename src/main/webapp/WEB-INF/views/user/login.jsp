<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../includes/tempnav.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
</head>
<body>
<h1>로그인 화면.</h1>
<div>
<label>result : </label><c:out value="${result}" />
</div>
<div>
<form action="/user/login" method="POST" enctype="utf8">
    <label>아이디</label><input name="userId" type="text">
    <label>비번</label><input name="userPwd" type="password">
    <button type="submit">로그인</button>
</form>
</div>
<div>
   <a href="/user/registration">회원가입</a>
   <a>아이디/비번 찾기</a>
</div>


</body>
</html>
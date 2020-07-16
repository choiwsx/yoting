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
<h1>로그인</h1>

<c:if test="${result ne null }">
</c:if>
<div>
<form action="/user/login" method="POST" enctype="utf8">
    <label>아이디</label><input name="userId" type="text" maxlength="30">
    <label>비번</label><input name="userPwd" type="password" maxlength="30">
    <button type="submit">로그인</button>
</form>
</div>
<div>
   <a href="/user/registration">회원 가입</a>
</div>
<br>
<div> 
회원 가입을 했는데 인증 이메일이 안왔나요? 

<a href="/user/resendEmail">인증 이메일 다시 보내기</a>
</div>
</body>
</html>
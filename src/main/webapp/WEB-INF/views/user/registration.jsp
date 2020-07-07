<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../includes/tempnav.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 가입</title>
</head>
<body>



<h1>회원 가입 폼</h1>
<form action="/user/registration" method="POST" enctype="utf8">
    <div>
        <label>아이디</label>
        <input type="text" name="userId" />
    </div>
    <div>
        <label>비번1</label>
        <input type="password" name="userPwd" />
    </div>
    <div>
        <label>비번2</label>
        <input type="password" name="pwd2" />
    </div>
    <div>
        <label>이메일</label>
        <input type="text" name="email" />
    </div>
    <div>
        <label>이멜소식</label>
        <input type="checkbox" name="emailSub" />
    </div>
    <button type="submit">submit</button>
</form>
<div> 
회원 가입을 했는데 이메일이 안왔나요? 

<a href="/user/resendEmail">인증 이메일 다시 보내기</a>
</div>
</body>
</html>
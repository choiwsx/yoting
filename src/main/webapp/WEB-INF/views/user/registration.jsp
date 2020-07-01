<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>유저 등록</title>
</head>
<body>
<div>
<label>result : </label><c:out value="${result}" />
</div>
<div>
<label>userNo</label><c:out value="${user.userNo}" /><br>
<label>userId</label><c:out value="${user.userId}" /><br>
<label>userPwd</label><c:out value="${user.userPwd}" /><br>
<label>userEmail</label><c:out value="${user.email}" /><br>
<label>userEmailAuth</label><c:out value="${user.emailAuth}" /><br>
<label>userProfilePhoto</label><c:out value="${user.profilePhoto}" /><br>
<label>userWeb</label><c:out value="${user.webUrl}" /><br>
<label>userBio</label><c:out value="${user.bio}" /><br>
<label>userEmailSub</label><c:out value="${user.emailSub}" /><br>
<label>userPrivacy</label><c:out value="${user.privacy}" /><br>
<label>userStatus</label><c:out value="${user.status}" /><br>
</div>

<h1>회원 가입 폼</h1>
<form action="/user-h/registration" method="POST" enctype="utf8">
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
    <div>
        <label>약관동의</label>
        <input type="checkbox" name="tmp" />
    </div>
    <button type="submit">submit</button>
</form>
 
 <div>
<a href="/user-h/list">리스트로</a>
</div>
<div>
<a href="/user-h/registration">가입하기</a>
</div>


</body>
</html>
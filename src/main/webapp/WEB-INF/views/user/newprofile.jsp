<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>새 프로필</title>
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

<h1>프로필 정보 입력</h1>
<form action="/user-h/newprofile" method="POST" enctype="utf8">
    <div>
        <label>닉네임</label>
        <input type="text" name="nickName" />
    </div>
    <div>
        <label>프사</label>
        <input type="text" name="profilePhoto" />
    </div>
    <div>
        <label>개인홈피주소</label>
        <input type="text" name="webUrl" />
    </div>
    <div>
        <label>소개글</label>
        <input type="text" name="bio" />
    </div>
    <div>
        <label>프로필공개여부</label>
        <input type="checkbox" name="privacy" />
        <input type="hidden" value="off" name="privacy"/>
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
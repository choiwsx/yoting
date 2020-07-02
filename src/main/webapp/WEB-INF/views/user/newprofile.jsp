<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../includes/tempnav.jsp" %>
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


<h1>프로필 정보 입력</h1>
<form action="/user/newprofile" method="POST" enctype="utf8">
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
 

</body>
</html>
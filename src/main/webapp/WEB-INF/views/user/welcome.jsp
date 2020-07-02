<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../includes/tempnav.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 가입 완료</title>
</head>
<body>
<h1>회원 가입을 축하합니다.</h1>
<div>
<label>result : </label><c:out value="${result}" />
</div>
<div>
<h1>새회원 정보</h1>
<label>userNo</label> <c:out value="${user.userNo}" /><br>
<label>userId</label> <c:out value="${user.userId}" /><br>
<label>userPwd</label> <c:out value="${user.userPwd}" /><br>
<label>userEmail</label> <c:out value="${user.email}" /><br>
<label>userEmailAuth</label> <c:out value="${user.emailAuth}" /><br>
<label>userProfilePhoto</label> <c:out value="${user.profilePhoto}" /><br>
<label>userWeb</label> <c:out value="${user.webUrl}" /><br>
<label>userBio</label> <c:out value="${user.bio}" /><br>
<label>userEmailSub</label> <c:out value="${user.emailSub}" /><br>
<label>userPrivacy</label> <c:out value="${user.privacy}" /><br>
<label>userStatus</label> <c:out value="${user.status}" /><br>
</div>

<div>
이메일 인증만 하면 회원가입이 최종 완료됩니다. 이메일을 확인해주세요.


                        
이메일이 안왔나요? 

<a>이메일 다시 보내기</a>
</div>



</body>
</html>
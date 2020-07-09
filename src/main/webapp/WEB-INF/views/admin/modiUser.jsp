<%@page import="org.kitchen.domain.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../includes/tempnav.jsp" %>
<%UserVO user =  (UserVO)request.getAttribute("user");%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보 수정</title>
</head>
<body>
<div>

<h1>관리자 모드:<c:out value="${user.userId }" />님의 정보 수정</h1>

<form action="/admin/modiUser" method="post">
<div>
 <input type="hidden" name="userNo" value="<c:out value="${user.userNo }"/>" />
        <label>아이디</label>
        <input type="text" name="userId" value="<c:out value="${user.userId }"/>" />
    </div>
    <div>
        <label>비번1</label>
        <input type="password" name="userPwd" value="<c:out value="${user.userPwd }"/>" />
    </div>
    <div>
    	<label>이메일</label>
        <input type="text" name="email" value="<c:out value="${user.email }"/>" />
    </div>
    <div>
    	<label>이메일 인증여부</label>
        <input type="checkbox" name="emailAuth" <c:if test="${user.emailAuth==true }"> checked </c:if> />
        <input type="hidden" value="off" name="emailAuth"/>
    </div>
    <div>
    	<label>닉네임</label>
        <input type="text" name="nickName" value="<c:out value="${user.nickName }"/>" />
    </div>
        <div>
    	<label>프사</label>
    	<img src="<%=user.getProfilePhoto().equals("")? "/img/default.jpg":user.getProfilePhoto() %>" >
        <input type="text" name="profilePhoto" value="<c:out value="${user.profilePhoto }"/>" />
    </div>
    <div>
        <label>닉네임</label>
        <input type="text" name="webUrl" value="<c:out value="${user.webUrl }"/>" />
    </div>
    <div>
        <label>자기소개</label>
        <input type="text" name="bio" value="<c:out value="${user.bio }"/>" />
    </div>
    <div>
    	<label>이메일 소식 받음 여부</label>
        <input type="checkbox" name="emailSub" <c:if test="${user.emailSub==true }"> checked </c:if> />
        <input type="hidden" value="off" name="emailSub"/>
    </div>
    <div>
    	<label>프로필 비공개?</label>
        <input type="checkbox" name="privacy" <c:if test="${user.privacy==true }"> checked </c:if> />
        <input type="hidden" value="off" name="privacy"/>
    </div>
    <button type="submit">submit</button>

</form>
	

</div>
</body>
</html>
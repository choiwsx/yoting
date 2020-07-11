<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ include file="../includes/tempnav.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>인증 이메일  다시보내기</title>
</head>
<body>
인증 이메일이 안왔나요?


<form action="/user/resendEmail" method="post">
<input type="text" name="email" placeholder="가입 시 등록한 이메일을 입력해주세요.">
<button type="submit">인증 메일 다시 보내기</button>
</form>
</body>
</html>
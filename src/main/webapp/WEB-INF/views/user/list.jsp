<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../includes/tempnav.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 리스트</title>
</head>
<body>
<div>

<h1>가입된 유저 리스트</h1>
	<table border="1">
	<thead>
	<tr>
		<th>userNo</th>
		<th>userId</th>
		<th>userPwd</th>
		<th>email</th>
		<th>emailAuth</th>
		<th>nickName</th>
		<th>profilePhoto</th>
		<th>webUrl</th>
		<th>bio</th>
		<th>emailSub</th>
		<th>privacy</th>
		<th>status</th>
		<th>삭제</th>
	</tr>
	</thead>
	<tbody>
		<c:forEach var="user" items="${list}">
		<tr>
			<td><a href="<c:url value='/user/profile?userId=${user.userId}' />"><c:out value="${user.userNo}" /></a></td>
			<td><c:out value="${user.userId}" /></td>
			<td><c:out value="${user.userPwd}" /></td>
			<td><c:out value="${user.email}" /></td>
			<td><c:out value="${user.emailAuth}" /></td>
			<td><c:out value="${user.nickName}" /></td>
			<td><c:out value="${user.profilePhoto}" /></td>
			<td><c:out value="${user.webUrl}" /></td>
			<td><c:out value="${user.bio}" /></td>
			<td><c:out value="${user.emailSub}" /></td>
			<td><c:out value="${user.privacy}" /></td>
			<td><c:out value="${user.status}" /></td>
			<td><a href="<c:url value='/user/deluser?userno=${user.userNo}' />">삭제</a></td>
		</tr>
		</c:forEach>
	</tbody>
	</table>


</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<%@ include file="../includes/tempnav.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
<title>profile</title>
</head>
<body>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

	<div style="text-align: center;">
		<c:forEach items="${profile}" var="user">
			<div>
				<a href="1"><img src="<c:out value="${user.profilePhoto}"/>"
					width="300" height="300" /></a>
			</div>
			<div>
				<a href="1"><c:out value="${user.nickName}" /></a>
			</div>
			<div>
				<a href="1"><c:out value="${user.webUrl}" /></a>
			</div>
			<div>${user.email}</div>
			<div>
				<c:out value="${user.userId}" />
			</div>
		</c:forEach>
	</div>

</body>

<script type="text/javascript">

</script>

</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix='fn'%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<%@ include file="../includes/tempnav.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
<title>Category</title>
</head>
<body>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<a href='category'> <img
		src="https://i.postimg.cc/kgHGnJbq/ALL.png" /></a>
	<a href='category?categoryNo=44'> <img
		src="https://i.postimg.cc/26R5Z0Gt/BanChan.png" /></a>
	<a href='category?categoryNo=66'> <img
		src="https://i.postimg.cc/Gps2tWFY/Desert.png" /></a>
	<a href='category?categoryNo=88'> <img
		src="https://i.postimg.cc/C1GxHb6x/Jusik.png" /></a>
	<table>
		<tr>
			<th>rno</th>
			<th>제목</th>
			<th>유저넘버</th>
			<th>카테고리</th>
			<th>입력일</th>
		</tr>
		<div> 총 <c:out value="${fn:length(list)} " />개있습니다.</div>
		<c:forEach items="${list}" var="recipe" varStatus="status">
			<tr>
				<td><c:out value="${recipe.rno}" /></td>
				<td><c:out value="${recipe.title}" /></td>
				<td><c:out value="${recipe.userNo}" /></td>
				<td><c:out value="${recipe.categoryNo}" /></td>
				<td><c:out value="${recipe.regDate}" /></td>
			</tr>
		</c:forEach>
	
	</table>


</body>

<script type="text/javascript">
	
</script>
</html>
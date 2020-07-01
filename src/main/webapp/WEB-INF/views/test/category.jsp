<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix='fn'%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
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
			<th>번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>
		</tr>
		<div> 총 <c:out value="${fn:length(list)} " />개의 레시피가있어요</div>
		<c:forEach items="${list}" var="recipe" varStatus="status">
			<tr>
				<td><c:out value="${recipe.rno}" /></td>
				<td><c:out value="${recipe.title}" /></td>
				<td><c:out value="${recipe.userNo}" /></td>
				<td><c:out value="${recipe.regDate}" /></td>
			</tr>
		</c:forEach>
	
	</table>


</body>

<script type="text/javascript">
	
</script>
</html>
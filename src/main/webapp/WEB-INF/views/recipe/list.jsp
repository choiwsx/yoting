<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Recipe List</title>
</head>
<body>
${recipe.cookingTime} ${recipe.content} ${recipe.thumbnail }
	<table>
		<thead>
			<tr>
				<th>게시물 번호</th>
				<th>제목</th>
				<th>썸네일</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>수정일</th>
			</tr>
		</thead>
		<c:forEach items="${list}" var="recipe">
			<tr>
				<td><c:out value="${recipe.rno }" /></td>
				<td><a class='move' href='<c:out value="${recipe.rno }"/>'>
						<c:out value="${recipe.title }" />
				</a></td>
				<td><img src="<c:out value='${recipe.thumbnail }'/>" width=30px height=30px></td>
				<td><c:out value="${recipe.userNo }" /></td>
				<td><fmt:formatDate pattern="yyyy-MM-dd"
						value="${recipe.regdate }" /></td>
				<td><fmt:formatDate pattern="yyyy-MM-dd"
						value="${recipe.updateDate }" /></td>
			</tr>
		</c:forEach>
	</table>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<form id='searchForm' action="/recipeBoard/list_w" method='get'>
	<input type='text' name='keyword' id="keyword"/>
	<button class='btn btn-default'>Search</button>
</form>

<table>
	<tr>
		<th>#번호</th>
		<th>제목</th>
		<th>작성자</th>
		<th>작성일</th>
	</tr>
	<c:forEach items="${list_w}" var="recipe">
	<tr>
		<td><c:out value="${recipe.rno}"/></td>
		<td><c:out value="${recipe.title}"/></td>
		<td><c:out value="${recipe.userNo}"/></td>
		<td><c:out value="${recipe.regdate}"/></td>
	</tr>
	</c:forEach>
</table>
<form id='actionForm' action="/recipeBoard/list_w" method='get'>
	<input type='hidden' name='keyword' value=>
</form>
</body>

<script type="text/javascript">
$(document).ready(function(){
	var searchForm = $("#searchForm");
	$("#searchForm button").on("click", function(e){
		e.preventDefault();
		var key = document.getElementById("keyword").value;
		console.log(key);
		//searchForm.submit();
	});
});
</script>
</html>
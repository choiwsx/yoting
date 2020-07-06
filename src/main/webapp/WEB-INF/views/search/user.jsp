<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix='fn'%>
<%@ include file="../includes/tempnav.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
<title>검색:유저 리스트</title>
</head>
<body>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<form id='searchForm' action="/search/user" method='get'>
		<input type='text' name='keyword' id="keyword"
			value='<c:out value="${cri.keyword}"/>' placeholder="유저 id">
		<button class='btn btn-default'>Search</button>
	</form>
	<table>
	<div> 총<c:out value="${fn:length(userSearch)} " />명있습니다.</div>
		<c:forEach items="${userSearch}" var="user">
			<a href='/user/profile?userId=<c:out value="${user.userId }" />' class="profileUrl" >
				<img src="<c:out value="${user.profilePhoto}"/>" width="140" height="120" />
				id:<c:out value="${user.userId}" />
				닉넴:<c:out value="${user.nickName}" /> </a>
				<br>
		</c:forEach>
	</table>
</body>

<script type="text/javascript">
//$(document).ready(function(){
//	var searchForm = $("#searchForm");
//	$("#searchForm button").on("click", function(e){
//		e.preventDefault();
//		var key = document.getElementById("keyword").value;
//		searchForm.submit();
//	});
// });

</script>
</html>
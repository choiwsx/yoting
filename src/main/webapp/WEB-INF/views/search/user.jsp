<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix='fn'%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<form id='searchForm' action="/userBoard/userSearch" method='get'>
		<input type='text' name='keyword' id="keyword"
			value='<c:out value="${cri.keyword}"/>'>
		<button class='btn btn-default'>Search</button>
	</form>
	<table>
	<div> 총 <c:out value="${fn:length(userSearch)} " />명의 요리사가 있어요</div>
		<c:forEach items="${userSearch}" var="user">
			<a href='profile?userId=<c:out value="${user.userId }" />' class="profileUrl" >
				<img src="<c:out value="${user.profilePhoto}"/>" width="140" height="120" />
				<c:out value="${user.nickName}" /> </a>
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
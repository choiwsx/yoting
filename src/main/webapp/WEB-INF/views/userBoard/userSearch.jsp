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
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<form id='searchForm' action="/userBoard/userSearch" method='get'>
		<input type='text' name='keyword' id="keyword"
			value='<c:out value="${cri.keyword}"/>'>
		<button class='btn btn-default'>Search</button>
	</form>
	<table>
		<c:forEach items="${userSearch}" var="user">
		<div style="border=1px dashed #BDBDBD;z">
			<a href='profile?userId=<c:out value="${user.userId }" />' class="profileUrl" >
				<img src="<c:out value="${user.profilePhoto}"/>" width="140" height="120" />
				<c:out value="${user.nickName}" /> </a>
				</div>
		</c:forEach>
	</table>
</body>

<script type="text/javascript">
$(document).ready(function(){
	var searchForm = $("#searchForm");
	$("#searchForm button").on("click", function(e){
		e.preventDefault();
		var key = document.getElementById("keyword").value;
		console.log(key);
		searchForm.submit();
	});
});

</script>
</html>
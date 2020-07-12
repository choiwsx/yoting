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
<script src="http://code.jquery.com/jquery-1.7.js"	type="text/javascript"></script>
<script	src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js" type="text/javascript"></script>
<link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" rel="stylesheet" type="text/css" />
	<form id='searchForm' action="/search/user" method='get'>
		<input type='text' name='keyword' id="userKeyword"
			value='<c:out value="${cri.keyword}"/>' placeholder="유저 id">
		<button class='btn btn-default'>Search</button>
	</form>
	<table>
	<div> 총<c:out value="${fn:length(userSearch)} " />명있습니다.</div>
		<c:forEach items="${userSearch}" var="user">
			<a href='/user/profile?userId=<c:out value="${user.userId }" />' class="profileUrl" >
				<img src="<c:out value="${user.profilePhoto}"/>" width="140" height="120" onerror="imgError(this);"/>
				id:<c:out value="${user.userId}" />
				닉넴:<c:out value="${user.nickName}" /> </a>
				<br>
		</c:forEach>
	</table>
</body>

<script type="text/javascript">
$("#userKeyword").autocomplete({
	source : function(request, response) {
		$.ajax({
			url : "user/autocomplete",
			type : "post",
			dataType : "json",
			data : request,
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",				
			success : function(data) {
				var result = data;
				response(result);
			},
			error : function(data) {
				alert("에러가 발생하였습니다.")
			}
		});
	}
});

</script>
</html>
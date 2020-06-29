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
			<tr>
				<td><a href="#" class="profilePhoto"><img
						src="<c:out value="${user.profilePhoto}"/>" width="180"
						height="120" /></a></td>
				<td><a href="#" class="profileUrl"><c:out
							value="${user.nickName}" /></a></td>
				<td><span><c:out value="${user.userId}" /></span></td>
			</tr>
		</c:forEach>
	</table>
	<form id='profileUrlForm' action="/userBoard/profile?" method='get'>
		<input type='hidden' id='profile'>
	</form>
	<form id='actionForm' action="/userBoard/userSearch" method='get'>
		<input type='hidden' name='keyword'>
	</form>
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
	$(".profileUrl").on("click", function(e){
		e.preventDefault();
		var text = $(this).text();
		alert(text);
		$('#profile').val(text);
		profileUrlForm.submit();
		});

	$(".profilePhoto").on("click", function(e){
		e.preventDefault();
		var text = $(".profileUrl").text();
		alert(text);
		profileUrlForm.submit();
		});
});

</script>
</html>
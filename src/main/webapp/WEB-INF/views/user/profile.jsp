<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<%@ include file="../includes/tempnav.jsp" %>
<%
Long loggedInUserNo = (Long)session.getAttribute("loggedInUserNo");        
%>

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
		<div>
			result: <c:out value="${result}" />
		</div>
			<div>
				<a href="1"><img src="<c:out value="${user.profilePhoto}"/>"
					width="300" height="300" /></a>
			</div>
			<div>
				레시피:<c:out value="${recipeCount}" />
				구독자:<c:out value="${followerCount}" />
				구독중:<c:out value="${followingCount}" />
				<form action="/user/follow" method="post">
					<input type="hidden" name="followee" value='<c:out value="${user.userNo}" />'>
					<input type="hidden" name="follower" value='<c:out value="${loggedInUserNo}" />'>
				</form>
			</div>
			<div>
				<label>아이디:</label><c:out value="${user.userId}" />
			</div>
			<div>
				<label>닉네임:</label><c:out value="${user.nickName}" />
			</div>
			<div>
				<label>웹사이트:</label><a href="<c:out value="${user.webUrl}" />"><c:out value="${user.webUrl}" /></a>
			</div>
			<div>
				<label>이메일:</label>${user.email}
			</div>
			<div>
				<label>자기소개:</label>${user.bio}
			</div>
	</div>
	<form action="/search/detail" method="get">
		<input type="text" name="keyword">
		<input type="hidden" name="userNo" value='<c:out value="${user.userNo}" />'>
		<input type="hidden" name="where" value="profile">

		<button type="submit">검색</button>		
	</form>
	<c:forEach items="${recipeList}" var="recipe">
			<a href='/recipe/detail?rno=<c:out value="${recipe.rno} " />' class="rno" >
			<img src="<c:out value="${recipe.thumbnail}"/>" width="140" height="120" />
			<c:out value="${recipe.title}" /> </a>
			<a href='recipe/del?rno=<c:out value="${recipe.rno} " />'></a>
	</c:forEach>



</body>

<script type="text/javascript">

</script>

</html>
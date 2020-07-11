<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix='fn'%>
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
				<c:if test="${keyword == null && empty recipeList}">
				 	<b><c:out value="${user.nickName}" />님</b>은 아직 작성한 레시피가 없어요.
				</c:if>
				<c:if test="${keyword == null && !empty recipeList}">
					<b><c:out value="${user.nickName}" />님</b>은  <c:out value="${fn:length(recipeList)}" />개의 레시피가 있습니다.
				</c:if>
				<c:if test="${keyword != null && empty recipeList}">
					<b><c:out value="${user.nickName}" />님</b>의 레시피 중에서 <b><c:out value="${keyword}" /></b>로 검색한 결과는 없어요.
				</c:if>
				<c:if test="${keyword != null && !empty recipeList}">
					<b><c:out value="${user.nickName}" />님</b>의 레시피 중에서 <b><c:out value="${keyword}" /></b>로 검색한 결과, <c:out value="${fn:length(recipeList)}" />개의 레시피가 있습니다.
				</c:if>
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
	<form action="/user/search" method="get">
		<input type="text" name="keyword" placeholder='<c:out value="${user.nickName}" />님의 레시피 검색' value='<c:out value="${keyword}" />'>
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


<%@ include file="../includes/footer.jsp"%>
</body>

<script type="text/javascript">

</script>

</html>
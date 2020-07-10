<%@page import="org.kitchen.domain.ProfileDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix='fn'%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<%@ include file="../includes/tempnav.jsp" %>
<% ProfileDTO profile = (ProfileDTO)request.getAttribute("profile"); %>

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
				<a href="1"><img src="<c:out value="${profile.user.profilePhoto}"/>"
					width="300" height="300" onerror="imgError(this);" /></a>
			</div>
			<div>
				<c:if test="${empty profile.recipes}">
				 	<b><c:out value="${profile.user.nickName}" />님</b>은 아직 작성한 레시피가 없어요.
				</c:if>
				<c:if test="${not empty empty profile.recipes}">
					<b><c:out value="${profile.user.nickName}" />님</b>은  <c:out value="${fn:length(profile.recipes)}" />개의 레시피가 있습니다.
				</c:if>
				
				<form id="followForm" method="post">
					<input type="hidden" name="followeeNo" value='<c:out value="${profile.user.userNo}" />'>
					<input type="hidden" name="followerNo" value='<c:out value="${userNo}" />'>
					<c:if test="${profile.following eq true}"><c:out value="<div><button type='button' id='unfollow'>구독 취소하기</button></div>" escapeXml="false" /></c:if>
					<c:if test="${profile.following eq false}"><c:out value="<div><button type='button' id='follow'>구독하기</button></div>" escapeXml="false" /></c:if>
					
				</form>
			</div>
			<div>
				<label>구독자 수:</label><c:out value="${profile.followers}" />
			</div>
			<div>
				<label>아이디:</label><c:out value="${profile.user.userId}" />
			</div>
			<div>
				<label>닉네임:</label><c:out value="${profile.user.nickName}" />
			</div>
			<div>
				<label>웹사이트:</label><a href="<c:out value="${profile.user.webUrl}" />"><c:out value="${profile.user.webUrl}" /></a>
			</div>
			<div>
				<label>이메일:</label>${profile.user.email}
			</div>
			<div>
				<label>자기소개:</label>${profile.user.bio}
			</div>
	</div>
	<form id="searchForm" method="post">
		<input type="text" name="keyword" placeholder='<c:out value="${profile.user.nickName}" />님의 레시피 검색' value='<c:out value="${keyword}" />'>
		<input type="hidden" name="userNo" value='<c:out value="${profile.user.userNo}" />'>
		<input type="hidden" name="where" value="profile">
		<button type="submit">검색</button>		
	</form>
	<c:forEach items="${profile.recipes}" var="recipe">
			<a href='/recipe/detail?rno=<c:out value="${recipe.rno} " />' class="rno" >
			<img src="<c:out value="${recipe.thumbnail}"/>" width="140" height="120" />
			<c:out value="${recipe.title}" /> </a>
			<a href='recipe/del?rno=<c:out value="${recipe.rno} " />'></a>
	</c:forEach>



</body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
	$("#follow").on("click", function() {
		$("#followForm").attr("action", "/user/follow").submit();
	});
	
	$("#unfollow").on("click", function() {
		$("#followForm").attr("action", "/user/unfollow").submit();
	});
</script>

</html>
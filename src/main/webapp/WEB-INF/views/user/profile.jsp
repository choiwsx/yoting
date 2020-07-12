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
<title>프로필</title>
</head>
<body>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

	<div style="text-align: center;">
	<h1><c:out value="${profile.user.nickName}" />님의 주방</h1>
			<div>
				<img src="<c:out value="${profile.user.profilePhoto}"/>"
					width="300" height="300" onerror="imgError(this);" /></a>
			</div>
			<div>
				<c:if test="${empty profile.recipes}">
				 	<b><c:out value="${profile.user.nickName}" />님</b>은 아직 작성한 레시피가 없어요.
				</c:if>
				<c:if test="${not empty profile.recipes}">
					<b><c:out value="${profile.user.nickName}" />님</b>은  <c:out value="${fn:length(profile.recipes)}" />개의 레시피가 있습니다.
				</c:if>
				 <c:if test ="${not empty userNo}">
				<form id="followForm" method="post">
					<input type="hidden" name="followeeNo" value='<c:out value="${profile.user.userNo}" />'>
					<input type="hidden" name="followerNo" value='<c:out value="${userNo}" />'>
					<c:if test="${profile.following eq true}"><c:out value="<div><button type='button' id='unfollow'>구독 취소하기</button></div>" escapeXml="false" /></c:if>
					<c:if test="${profile.following eq false}"><c:out value="<div><button type='button' id='follow'>구독하기</button></div>" escapeXml="false" /></c:if>
				</form>
				</c:if>
			</div>
			<div>
				<c:out value="구독자 수:${profile.followers}" />
			</div>
			<div>
				<c:out value="아이디:${profile.user.userId}" />
			</div>
			<div>
				<c:out value="닉네임:${profile.user.nickName}" />
			</div>
			<div>
				<a href="<c:out value="홈페이지:${profile.user.webUrl}" />"><c:out value="${profile.user.webUrl}" /></a>
			</div>
			<div>
				<c:out value="이메일:${profile.user.email}"/>
			</div>
			<div>
				<c:out value="자기 소개:${profile.user.bio}"/>
			</div>
	</div>
	   <c:if test="${not empty profile.recipes }">
	
		<input type="text" name="recipeKeyword" placeholder='<c:out value="${profile.user.nickName}"/>님의 레시피 검색'  maxlength="300" style='width: 300px'>
		<input type="hidden" name="userNo" value='<c:out value="${profile.user.userNo}" />'>
		<input type="hidden" name="where" value="profile">
		<button id="searchBtn">검색</button>		
		<button id="initBtn">초기화</button>	<br>
	<c:forEach items="${profile.recipes}" var="recipe">
	<div data-title="<c:out value="${recipe.title}" />" style="border: 1px solid; width: 400px; height: 200px; padding: 15px; margin: 33px; float: left;">
	<div style="float:left;"><a href="/recipe/detail?rno=${recipe.rno}"><img src="<c:out value="${recipe.thumbnail }"/>" 
	 style='margin: 10px' width=100px; height=100px;  onerror="imgError(this);"  /></a></div>
						<div style="padding: 15px;">
						<c:choose>
						   <c:when test="${fn:length(recipe.title) > 15}">
						      ${fn:substring(recipe.title,0,14)}...
						   </c:when>
						  <c:otherwise>
						     ${recipe.title}
						  </c:otherwise>
						</c:choose>
</div>
						<div><c:choose>
						   <c:when test="${fn:length(recipe.reContent) > 15}">
						      ${fn:substring(recipe.reContent,0,14)}...
						   </c:when>
						  <c:otherwise>
						     ${recipe.reContent}
						  </c:otherwise>
						</c:choose></div>
						</div>
	</c:forEach>
</c:if>
</body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
$(document).ready(function(){
	let title = document.querySelectorAll("[data-title]");
$("#searchBtn").on("click", function(e){
	e.preventDefault();
	var keyword = $("input[name=recipeKeyword]").val();
    if(keyword==''){
       alert("키워드를 입력하세요.");
       return false;
    }
	for(i=0;i<title.length;i++){
		title[i].style.display='none';
	var titleVal = title[i].getAttribute("data-title");
	if(!(titleVal.search(keyword)==-1)){
		title[i].style.display='block';
		}
	}
    
});

$("#initBtn").on("click",function(e){
	e.preventDefault();
	 for(i=0;i<title.length;i++){
		 title[i].style.display='block';
	 }
});

	$("#follow").on("click", function() {
		$("#followForm").attr("action", "/user/follow").submit();
	});
	
	$("#unfollow").on("click", function() {
		$("#followForm").attr("action", "/user/unfollow").submit();
	});
});
</script>

</html>
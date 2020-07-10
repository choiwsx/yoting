<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@ include file="../includes/tempnav.jsp" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>


<fieldset><legend>College Information</legend>
레시피타이틀:<c:out value="${recipe.title }" />
레시피섬ㄴㅔ일:<c:out value="${recipe.thumbnail }" />
레시피유저넘버"<c:out value="${recipe.userNo }" />
레시피요리시간"<c:out value="${recipe.cookingTime }" />
레시피난이도:<c:out value="${recipe.difficulty }" />
레시피분량:<c:out value="${recipe.portion }" />
레시피카테고리번호:<c:out value="${recipe.categoryNo }" />


    <div class="help icon astrisk">콘텐트</div>
    <c:forEach items="${recipe.contentList}" var="content" varStatus="vs">
        <div class="field">
        <c:out value='${vs.count}' />번째 콘텐트
         <div class="label required">stepNo</div>
        <div class="output"><input type="text" value="<c:out value='${content.stepNo}' />" /></div>
        <div class="label required">사진</div>
        <div class="output"><input type="text" value="<c:out value='${content.photoUrl}' />" /></div>
        <div class="label required">내용</div>
        <div class="output"><input type="text" value="<c:out value='${content.content}' />" /></div>
        </div>
        <hr />
    </c:forEach>

</fieldset>

</body>
</html>
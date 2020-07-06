<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ include file="../includes/tempnav.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Recipe Register</title>
</head>
<body>
	<form:form modelAttribute="recipe" action="/recipe/registrationTest" method="post">
	   
	
	    <fieldset><legend>레시피 내용</legend>
	
	    
		<form:hidden path="userNo" value="1" />
	
        <form:label
            path="categoryNo" cssErrorClass="invalid">카테고리</form:label>
        
        <form:select
            path="categoryNo" cssErrorClass="invalid ">
            <form:option value="0">카테고리</form:option>
            <form:option value="11">주식</form:option>
            <form:option value="22">디저트</form:option>
            <form:option value="33">반찬</form:option>
        </form:select>
       
       	<form:input path="thumbnail" placeholder="섬네일"/>
		<form:input path="title" placeholder="제목"/>
		<form:input path="cookingTime" placeholder="소요시간"/>
		<form:input path="portion" placeholder="몇인분"/>
		<form:input path="difficulty" placeholder="난이도"/>
		

	    <div id="dl_list_0">
	    <c:forEach var="content" varStatus="vs" items="${recipe.contentList}">
	    <c:out value="${vs.count}" />번째 컨텐츠
	        <div class="content_<c:out value='${vs.index}' />">
	        <div class="field">
	        <div class="label required"><form:label
	            path="contentList[${vs.index}].photoUrl" cssErrorClass="invalid">사진</form:label></div>
	
	        <div class="input"><form:input
	            path="contentList[${vs.index}].photoUrl" cssErrorClass="invalid " />
	        </div>
			</div>
	        <div class="field">
	        <div class="label required"><form:label
	            path="contentList[${vs.index}].content" cssErrorClass="invalid">내용</form:label></div>
	        <div class="input"><form:textarea
	            path="contentList[${vs.index}].content" cssErrorClass="invalid " /><form:label
	            path="contentList[${vs.index}].content" cssErrorClass="icon invalid" />
	        <a href="#" class="remove_item icon minus">remove</a> <form:errors
	            path="contentList[${vs.index}].content" cssClass="invalid" /></div>
	        </div>
	
	        <hr />
	
	        </div>
	        <form:hidden path="contentList[${vs.index}].stepNo" cssErrorClass="invalid " value="${vs.index + 1 }"/>
	    </c:forEach>
	
	    <div class="field">
	    <div class="label"><a class="add_item icon plus" href="#">add</a></div>
	    </div>
	    </div>
	
	    <div class="field">
	    <div class="input"><input type="submit" class="button primary"
	        value="Save" /></div>
	    </div>
	
	    </fieldset>
	
	</form:form>

</body>
</html>
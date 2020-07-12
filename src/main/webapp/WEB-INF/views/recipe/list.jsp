<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix='fn'%>

<%@ include file="../includes/tempnav.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Recipe List</title>
<style>
a {
   text-decoration: none;
   color: #000000
}
</style>
</head>
<body>
<%@ include file="../includes/category.jsp"%>
<br><br>


   <div style="margin-left: 10%; margin-right: 10%;">
      <c:forEach items="${list}" var="recipe">
         <a class="content" href="/recipe/detail?rno=${recipe.rno}">
            <div style="text-align: center; border: 1px solid; width: 280px; height: 370px; margin: 33px; float: left;">
               <div>
                  <img src="<c:out value='${recipe.thumbnail }'/>" width=280px
                     height=280px onerror="imgError(this);" >
               </div>
               <div style="margin-top: 10px;">
                  <c:choose>
						   <c:when test="${fn:length(recipe.title) > 15}">
						      ${fn:substring(recipe.title,0,14)}...
						   </c:when>
						  <c:otherwise>
						     ${recipe.title}
						  </c:otherwise>
						</c:choose>
               </div>
               <div>
                  by
                  <c:out value="${recipe.userNo }" />
               </div>
               <div>
                  <fmt:formatDate pattern="yyyy-MM-dd" value="${recipe.regDate }" />
               </div>
            </div>
            </a>
      </c:forEach>      
   </div>
</body>
</html>
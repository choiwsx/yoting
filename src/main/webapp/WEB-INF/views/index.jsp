<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix='fn'%>
<%@page import="java.util.*"%>
<%
   request.setCharacterEncoding("UTF-8");
%>
<%@ include file="includes/tempnav.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Index</title>
<style>
a {
   text-decoration: none;
   color: #000000
}
</style>
</head>
<body>
   <h1>먹스타그램</h1>

   <div>
      총
      <c:out value="${fn:length(list)}  " />
      개의 레시피가 있습니다.
   </div>
   <div style="margin-left: 10%; margin-right: 10%;">
      <c:forEach items="${list}" var="recipe">
         <a class="content" href="/recipe/detail?rno=${recipe.rno}">
            <div
               style="text-align: center; border: 1px solid; width: 280px; height: 370px; margin: 33px; float: left;">
               <div>
                  <img src="<c:out value='${recipe.thumbnail }'/>" width=280px
                     height=280px onerror="imgError(this);" >
               </div>
               <div style="margin-top: 10px;">
                  <c:out value="${recipe.title }" />
               </div>
               <div>
                  by
                  <c:out value="${recipe.userNo }" />
               </div>
               <div>
                  <fmt:formatDate pattern="yyyy-MM-dd" value="${recipe.updateDate }" />
               </div>
            </div>
         </a>
      </c:forEach>
   </div>

</body>

</html>
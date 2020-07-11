<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix='fn'%>
<%
   request.setCharacterEncoding("UTF-8");

%>
<%@ include file="../includes/tempnav.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>인기 주방장 리스트</title>
<style>
a {
   text-decoration: none;
   color: #000000
}
</style>
</head>
<body>

   <div>
      총
      <c:out value="${fn:length(list)}  " />
      명의 인기 주방장 리스트
   </div>

   <div style="margin-left: 10%; margin-right: 10%;">
      <c:forEach items="${list}" var="simpleProfile">
         <a class="content" href="/user/profile?userId=${simpleProfile.userId}">
            <div style="text-align: center; border: 1px solid; width: 280px; height: 370px; margin: 33px; float: left;">
               <div>
                  <img src="<c:out value='${simpleProfile.photoPhoto }'/>" width=280px
                     height=280px>
               </div>
               <div>구독자:<c:out value="${simpleProfile.followers }" /> 구독중:<c:out value="${simpleProfile.followings }" />
               </div>
               <div style="margin-top: 10px;">
                  <c:out value="${simpleProfile.userId }" />
               </div>
               <div style="margin-top: 10px;">
                  <c:out value="${simpleProfile.nickName }" />
               </div>
               
            </div>
            </a>
      </c:forEach>      
   </div>
   <%@ include file="../includes/footer.jsp"%>
</body>
</html>
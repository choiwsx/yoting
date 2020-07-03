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
<title>레시피 상세</title>
</head>
<body>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

	<div style="text-align: center;">
		
			<div>
                <h1>레시피<c:out value="${recipe.title}" /></h1>
                <img src="<c:out value="${recipe.thumbnail}"/>" width="140" height="120" />
               
			</div>
			<div>
				난이도:<c:out value="${recipe.difficulty}" />
				양:<c:out value="${recipe.portion}" />
                
            </div>
            <div>
                <h3>요리 순서</h3>
            <c:forEach items="${contentList}" var="content">
                <div>
                    순서:<c:out value="${content.stepNo}" />         
                    <img src="<c:out value="${content.photoUrl}"/>" width="140" height="120" />
                    <c:out value="${content.content}" />
                </div>
            </c:forEach>
			</div>
            작성일:<c:out value="${recipe.regDate}" />
            수정일:<c:out value="${recipe.updateDate}" />
    </div>
    
<div>
    레시피 만든이
    <a href="/user/profile?userId=<c:out value="${author.userId}" />">
    <img src="<c:out value="${author.profilePhoto}" />" width="140" height="120" />
    <c:out value="${author.nickName}" />
    <c:out value="${author.bio}" />
    </a>
</div>

</body>

<script type="text/javascript">

</script>

</html>